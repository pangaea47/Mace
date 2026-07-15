local mod_prefix = "mace"
Mace = Mace or {
}
SMODS.Atlas {
	key = "macelc",
	px = 71,
	py = 95,
	path = "playingcardsmace.png",
}

SMODS.Atlas {
	key = "macehc",
	px = 71,
	py = 95,
	path = "playingcardsmacehc.png",
}

SMODS.Atlas {
	key = "enhancements",
	px = 71,
	py = 95,
	path = "enhancementssealsmace.png"
}
SMODS.Atlas {
	key = "image",
	px = 71,
	py = 95,
	path = "image.png"
}
local mace_macelc = SMODS.Atlases["mace_macelc"]
local lcatlas_table = {
	py = mace_macelc.py,
	px = mace_macelc.px,
	name = mace_macelc.name,
	image = mace_macelc.image,
}

local mace_macehc = SMODS.Atlases["mace_macehc"]
local hcatlas_table = {
	py = mace_macehc.py,
	px = mace_macehc.px,
	name = mace_macehc.name,
	image = mace_macehc.image,
}

local mace_test = SMODS.Atlases["mace_image"]
local testatlas_table = {
	py = mace_test.py,
	px = mace_test.px,
	name = mace_test.name,
	image = mace_test.image,
}

local function force_atlas_image()
	if not lcatlas_table.image then
		lcatlas_table.image = mace_macelc.image
	end
	if not hcatlas_table.image then
		hcatlas_table.image = mace_macehc.image
	end
	if not testatlas_table.image then
		testatlas_table.image = mace_test.image
	end
end
Mace.mace_atlases = {
	mace_macelc = lcatlas_table,
	mace_macehc = hcatlas_table,
	mace_test = testatlas_table,
}

for _, suit in ipairs({ "hearts", "clubs", "diamonds", "spades" }) do
	SMODS.DeckSkin {
		key = suit .. "_mace",
		suit = suit:gsub("^%l", string.upper),
		ranks = { '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace' },
		lc_atlas = 'mace_macelc',
		hc_atlas = 'mace_macehc',
		posStyle = 'deck',
		loc_txt = {
			['en-us'] = "Mace"
		},
	}
end


function Mace.is_using_skin(card, suit)
	if not card or not card.config or not card.config.card or not card.config.card.suit then return false end
	local deckskin_id = mod_prefix
	if suit then deckskin_id = deckskin_id .. "_" .. suit .. "_mace" end -- Not sure if this will be useful, but i thought it might
	return G.SETTINGS.CUSTOM_DECK.Collabs[card.config.card.suit]:sub(1, #(deckskin_id)) == deckskin_id
end

local rank_to_atlas_pos = {
	["Hearts"] = { x = 13, y = 0 },
	["Clubs"] = { x = 13, y = 1 },
	["Diamonds"] = { x = 13, y = 2 },
	["Spades"] = { x = 13, y = 3 },
}

local eatlas = "mace_enhancements"
Mace.enhancement_to_atlas_pos = {
	["c_base"] = { atlas = eatlas, pos = { x = 0, y = 0 } },
	["m_bonus"] = { atlas = eatlas, pos = { x = 1, y = 0 } },
	["m_mult"] = { atlas = eatlas, pos = { x = 2, y = 0 } },
	["m_wild"] = { atlas = eatlas, pos = { x = 3, y = 0 } },
	["m_glass"] = { atlas = eatlas, pos = { x = 4, y = 0 } },
	["m_steel"] = { atlas = eatlas, pos = { x = 0, y = 1 } },
	["m_stone"] = { atlas = eatlas, pos = { x = 1, y = 1 } },
	["m_gold"] = { atlas = eatlas, pos = { x = 2, y = 1 } },
	["m_lucky"] = { atlas = eatlas, pos = { x = 3, y = 1 } },
}
local satlas = "mace_enhancements"
Mace.seal_to_atlas_pos = {
	["Red"] = { atlas = satlas, pos = { x = 1, y = 2 } },
	["Blue"] = { atlas = satlas, pos = { x = 2, y = 2 } },
	["Gold"] = { atlas = satlas, pos = { x = 0, y = 2 } },
	["Purple"] = { atlas = satlas, pos = { x = 3, y = 2 } },
}
G.cl_enhancements = {}

function allSuitsMace()
	local suits = { "Hearts", "Diamonds", "Clubs", "Spades" }
	for _, suit in pairs(suits) do
		if G.SETTINGS.CUSTOM_DECK.Collabs[suit] ~= "mace_" .. string.lower(suit) .. "_mace" then
			print(suit)
			print(G.SETTINGS.CUSTOM_DECK.Collabs[suit])
			print("mace_" .. string.lower(suit) .. "mace")
			return false
		end
	end
	return true
end

SMODS.DrawStep({
	key = 'enhancement_sprite',
	order = 21,
	func = function(card, layer)
		DrawStep_enhancement_sprite(card, layer)
	end,
	conditions = { vortex = false, facing = 'front' },
})
-- This is done for debugplus' watch functions
function DrawStep_enhancement_sprite(card, layer)
	force_atlas_image()
	local key = card.config.center.key
	if not Mace.enhancement_to_atlas_pos[key] then return end
	if not Mace.is_using_skin(card) then
		card.children.center.atlas = card.children.center.base_atlas or card.children.center.atlas
		card.children.center.Mid.sprite_pos = card.children.center.base_pos or card.children.center.Mid.sprite_pos
		return
	end



	card.children.center.base_atlas = card.children.center.base_atlas or card.children.center.atlas
	card.children.center.base_pos = card.children.center.base_pos or card.children.center.atlas
	card.children.center.atlas = Mace.mace_atlases[card.children.front.atlas.key]
	card.children.center.Mid.sprite_pos = copy_table(rank_to_atlas_pos[card.config.card.suit])
	if card.config.card.value == "Ace" then card.children.center.Mid.sprite_pos.x = 14 end

	if key == 'c_base' or card.config.center.set ~= "Enhanced" then return end
	if not G.cl_enhancements[key] then
		local data = Mace.enhancement_to_atlas_pos[key]
		G.cl_enhancements[key] = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, data.atlas, data.pos)
	end
	if key ~= 'c_base' then
		G.cl_enhancements[key].role.draw_major = card
		G.cl_enhancements[key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		if card.edition then
			local edition = G.P_CENTERS[card.edition.key]
			G.cl_enhancements[key]:draw_shader(edition.shader, nil, nil, nil, card.children.center)
		end
	end
end

SMODS.DrawStep({
	key = 'enhancement_sprite_back',
	order = 22,
	func = function(card, layer)
		if allSuitsMace() and G.GAME[card.back].effect.center.key == "b_red" then
			card.children.back.base_atlas = card.children.back.base_atlas or card.children.back.atlas
			card.children.back.base_pos = card.children.back.base_pos or card.children.back.atlas
			card.children.back.atlas = Mace.mace_atlases["mace_test"]
			card.children.back.Mid.sprite_pos = { x = 0, y = 0 }
		else
			card.children.back.atlas = card.children.back.base_atlas or card.children.back.atlas
			card.children.back.Mid.sprite_pos = card.children.back.base_pos or card.children.back.Mid.sprite_pos
		end
	end,
	conditions = { vortex = false, facing = 'back' },
})

G.cl_seals = {}

SMODS.DrawStep({
	key = 'seal_sprite',
	order = 22,
	func = function(card, layer)
		DrawStep_seal_sprite(card, layer)
	end,
	conditions = { vortex = false, facing = 'front' },
})

function DrawStep_seal_sprite(card, layer)
	if not Mace.is_using_skin(card) then return end

	local seal = card.seal
	if not seal or not Mace.seal_to_atlas_pos[seal] then return end
	if not G.cl_seals[seal] then
		local data = Mace.seal_to_atlas_pos[seal]
		G.cl_seals[seal] = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, data.atlas, data.pos)
	end
	G.cl_seals[seal].role.draw_major = card
	G.cl_seals[seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
	if seal == 'Gold' then
		G.cl_seals[seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil,
			card.children.center)
	end
end

-- debug for quick resets im lazy
function R() SMODS.restart_game() end
