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
	key = "mfenhancements",
	px = 71,
	py = 95,
	path = "mfmaceenhancements.png"
}

SMODS.Atlas {
	key = "maximusenhancements",
	px = 71,
	py = 95,
	path = "maximusmaceenhancements.png"
}

SMODS.Atlas {
	key = "decks",
	px = 71,
	py = 95,
	path = "macedecks.png"
}

SMODS.Atlas {
	key = "easter_eggs",
	px = 71,
	py = 95,
	path = "easter_eggs.png"
}

SMODS.Shader {
	key = "dissolve",
	path = "dissolve.fs"
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

local mace_decks = SMODS.Atlases["mace_decks"]
local decks_atlas_table = {
	py = mace_decks.py,
	px = mace_decks.px,
	name = mace_decks.name,
	image = mace_decks.image,
}

local function force_atlas_image()
	if not lcatlas_table.image then
		lcatlas_table.image = mace_macelc.image
	end
	if not hcatlas_table.image then
		hcatlas_table.image = mace_macehc.image
	end
	if not decks_atlas_table.image then
		decks_atlas_table.image = mace_decks.image
	end
end
Mace.mace_atlases = {
	mace_macelc = lcatlas_table,
	mace_macehc = hcatlas_table,
	mace_decks = decks_atlas_table,
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

local suit_to_atlas_pos = {
	["Hearts"] = { x = 13, y = 0 },
	["Clubs"] = { x = 13, y = 1 },
	["Diamonds"] = { x = 13, y = 2 },
	["Spades"] = { x = 13, y = 3 },
}

local eatlas = "mace_enhancements"
local mfeatlas = "mace_mfenhancements"
local mxmseatlas = "mace_maximusenhancements"
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
	["m_mf_monus"] = { atlas = mfeatlas, pos = { x = 0, y = 0 } },
	["m_mf_cult"] = { atlas = mfeatlas, pos = { x = 1, y = 0 } },
	["m_mf_styled"] = { atlas = mfeatlas, pos = { x = 2, y = 0 } },
	["m_mf_brass"] = { atlas = mfeatlas, pos = { x = 3, y = 0 } },
	["m_mf_teal"] = { atlas = mfeatlas, pos = { x = 0, y = 1 } },
	["m_mf_gemstone"] = { atlas = mfeatlas, pos = { x = 1, y = 1 } },
	["m_mf_marigold"] = { atlas = mfeatlas, pos = { x = 2, y = 1 } },
	["m_mf_yucky"] = { atlas = mfeatlas, pos = { x = 3, y = 1 } },
	["m_mf_power"] = { atlas = mfeatlas, pos = { x = 0, y = 2 } },
	["m_mxms_footprint"] = { atlas = mxmseatlas, pos = { x = 1, y = 0 } },
}
local satlas = "mace_enhancements"
Mace.seal_to_atlas_pos = {
	["Red"] = { atlas = satlas, pos = { x = 1, y = 2 } },
	["Blue"] = { atlas = satlas, pos = { x = 2, y = 2 } },
	["Gold"] = { atlas = satlas, pos = { x = 0, y = 2 } },
	["Purple"] = { atlas = satlas, pos = { x = 3, y = 2 } },
	["mxms_Black"] = { atlas = mxmseatlas, pos = { x = 0, y = 0 } },
}

local datlas = "mace_decks"
Mace.deck_to_atlas_pos = {
	["b_red"] = { atlas = datlas, pos = { x = 0, y = 0 } },
	["b_blue"] = { atlas = datlas, pos = { x = 1, y = 0 } },
	["b_yellow"] = { atlas = datlas, pos = { x = 2, y = 0 } },
	["b_green"] = { atlas = datlas, pos = { x = 3, y = 0 } },

	["b_black"] = { atlas = datlas, pos = { x = 0, y = 1 } },
	["b_magic"] = { atlas = datlas, pos = { x = 1, y = 1 } },
	["b_nebula"] = { atlas = datlas, pos = { x = 2, y = 1 } },
	["b_ghost"] = { atlas = datlas, pos = { x = 3, y = 1 } },

	["b_abandoned"] = { atlas = datlas, pos = { x = 0, y = 2 } },
	["b_checkered"] = { atlas = datlas, pos = { x = 1, y = 2 } },
	["b_zodiac"] = { atlas = datlas, pos = { x = 2, y = 2 } },
	["b_painted"] = { atlas = datlas, pos = { x = 3, y = 2 } },

	["b_anaglyph"] = { atlas = datlas, pos = { x = 0, y = 3 } },
	["b_plasma"] = { atlas = datlas, pos = { x = 1, y = 3 } },
	["b_erratic"] = { atlas = datlas, pos = { x = 2, y = 3 } },
}

function Mace.allSuitsMace()
	local suits = { "Hearts", "Diamonds", "Clubs", "Spades" }
	for _, suit in pairs(suits) do
		if G.SETTINGS.CUSTOM_DECK.Collabs[suit] ~= "mace_" .. string.lower(suit) .. "_mace" then
			return false
		end
	end
	return true
end

function Mace.SuitToAtlas_Pos(suit, rank, temp)
	local atlas = "mace_mace" .. G.SETTINGS.colour_palettes[suit]
	if temp ~= "c_base" then atlas = Mace.mace_atlases[atlas] end
	local pos = copy_table(suit_to_atlas_pos[suit])
	if rank == "Ace" then pos.x = pos.x + 1 end
	return { atlas = atlas, pos = pos }
end

function Mace.is_using_skin(card, suit)
	local card_suit = suit
	if card and card.config and card.config.card and card.config.card.suit then
		card_suit = card.config
			.card.suit
	elseif not suit then
		return false
	end
	local deckskin_id = mod_prefix .. "_" .. string.lower(card_suit) .. "_mace"
	return G.SETTINGS.CUSTOM_DECK.Collabs[card_suit] == deckskin_id
end

Mace.Sprite_Overlays = {}

function Draw_Sprite_Overlay(card, sprite, data)
	if not card or not sprite or not data or not data.pos or not data.atlas then return end

	--#region Easter Egg
	local whitelisted_atlases = {
		["mace_decks"] = true
	}
	local key_to_new_pos = {
		-- ["lc_Spades_1"] = {x=0,y=0}, -- Low Contrast Spades Ace
		-- ["hc_Spades_0"] = {x=0,y=0}, -- High Contrast Spades Non-Ace
		-- ["b_yellow"] = {x=0,y=0}, -- Yellow deck
		-- ["m_steel"] = {x=0,y=0}, -- Steel Enhancement

	}

	if pseudorandom("mace_easter_egg") * 100 < 10 and whitelisted_atlases[data.atlas] and key_to_new_pos[sprite] then
		data.pos = key_to_new_pos[sprite]
		data.atlas = "mace_easter_eggs"
	end
	--#endregion

	if not Mace.Sprite_Overlays[sprite] then
		Mace.Sprite_Overlays[sprite] = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, data.atlas, data.pos)
	end
	Mace.Sprite_Overlays[sprite].role.draw_major = card
	Mace.Sprite_Overlays[sprite]:draw_shader("dissolve", nil, nil, nil, card.children.center)

	if sprite == 'Gold' then -- Gold Seal.
		Mace.Sprite_Overlays[sprite]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil,
			card.children.center)
	end
end

SMODS.DrawStep({
	key = 'front_sprite',
	order = -1,
	func = function(card, layer)
		DrawStep_front_sprite(card, layer)
	end,
	conditions = { facing = 'front' },
})
-- This is done for debugplus' watch functions
function DrawStep_front_sprite(card, layer)
	force_atlas_image()

	local key = card.config.center.key
	if not Mace.is_using_skin(card) or not Mace.enhancement_to_atlas_pos[key] then
		card.children.center.states.visible = true
		return
	end
	card.children.center.states.visible = false
	local suit = card.config.card.suit
	local contrast = G.SETTINGS.colour_palettes[suit]

	local is_ace = card.config.card.value == "Ace" and 1 or 0
	local key = contrast .. "_" .. suit .. "_" .. is_ace

	Draw_Sprite_Overlay(card, key, Mace.SuitToAtlas_Pos(suit, card.config.card.value))

	if card.edition then
		local edition = G.P_CENTERS[card.edition.key]
		Mace.Sprite_Overlays[key]:draw_shader(edition.shader, nil, nil, nil, card.children.center)
	end

	if card.greyed then
		Mace.Sprite_Overlays[key]:draw_shader('played', nil, card.ARGS.send_to_shader, nil,
			card.children.center)
	end
end

SMODS.DrawStep({
	key = 'enhancement_sprite',
	order = 22,
	func = function(card, layer)
		DrawStep_enhancement_sprite(card, layer)
	end,
	conditions = { facing = 'front' },
})
-- This is done for debugplus' watch functions
function DrawStep_enhancement_sprite(card, layer)
	force_atlas_image()

	if not Mace.is_using_skin(card) then
		return
	end

	local key = card.config.center.key
	if not Mace.enhancement_to_atlas_pos[key] then return end

	if card.config.center.set ~= "Enhanced" then return end
	Draw_Sprite_Overlay(card, key, Mace.enhancement_to_atlas_pos[key])

	if card.edition then
		local edition = G.P_CENTERS[card.edition.key]
		Mace.Sprite_Overlays[key]:draw_shader(edition.shader, nil, nil, nil, card.children.center)
	end
end

SMODS.DrawStep({
	key = 'seal_sprite',
	order = 23,
	func = function(card, layer)
		DrawStep_seal_sprite(card, layer)
	end,
	conditions = { vortex = false, facing = 'front' },
})

function DrawStep_seal_sprite(card, layer)
	if not Mace.is_using_skin(card) then return end

	local seal = card.seal
	if not seal or not Mace.seal_to_atlas_pos[seal] then return end

	Draw_Sprite_Overlay(card, seal, Mace.seal_to_atlas_pos[seal])
end

SMODS.DrawStep({
	key = 'back_sprite',
	order = 24,
	func = function(card, layer)
		DrawStep_back_sprite(card, layer)
	end,
	conditions = { vortex = false, facing = 'back' },
})

function DrawStep_back_sprite(card, layer)
	local key = card.config.center_key:sub(1, 2) == "b_" and card.config.center_key or
		(G and G.GAME and G.GAME[card.back] and G.GAME[card.back].effect.center.key)
	if not Mace.allSuitsMace() or not Mace.deck_to_atlas_pos[key] then
		card.children.back.states.visible = true
		return
	end
	card.children.back.states.visible = false

	Draw_Sprite_Overlay(card, key, Mace.deck_to_atlas_pos[key])
end

local bg = { { HEX("3b0b0b"), HEX("762141"), HEX("2a3638"), HEX("687f86") }, { HEX("635f4d"), HEX("e7e3a9"), HEX("393171"), HEX("98b1d9") }, {} }

for key, value in ipairs(bg) do
	print(key)
	G.C["mace_bg_color_" .. key] = SMODS.Gradient({
		key = "bg_color_" .. key,
		colours = value,
		cycle = 5,
	})
end
local old_Game_main_menu = Game.main_menu
function Game:main_menu(context)
	local ret = old_Game_main_menu(self, context)
	if not Mace.allSuitsMace() then return ret end
	G.SPLASH_BACK:define_draw_steps({ {
		shader = 'splash',
		send = {
			{ name = 'time',        ref_table = G.TIMERS, ref_value = 'REAL_SHADER' },
			{ name = 'vort_speed',  val = 0.4 },
			{ name = 'colour_1',    ref_table = G.C,      ref_value = 'mace_bg_color_1' },
			{ name = 'colour_2',    ref_table = G.C,      ref_value = 'mace_bg_color_2' },
			{ name = 'vort_offset', val = 0 },
		}
	} })

	return ret
end

-- debug for quick resets im lazy
function R() SMODS.restart_game() end

function flipall()
	for _, card in ipairs(G.hand.cards) do
		card:flip()
	end
end

SMODS.load_file("crossmod.lua")()
