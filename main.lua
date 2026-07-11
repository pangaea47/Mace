local mod_prefix = "mace"

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

Mace = Mace or {}
function Mace.is_using_skin(card, suit)
    if not card or not card.config or not card.config.card or not card.config.card.suit then return false end
    local deckskin_id = mod_prefix
    if suit then deckskin_id = deckskin_id .. "_" .. suit .. "_mace" end -- Not sure if this will be useful, but i thought it might
    return G.SETTINGS.CUSTOM_DECK.Collabs[card.config.card.suit]:sub(1, #(deckskin_id)) == deckskin_id
end

local eatlas = "mace_enhancements"
local enhancement_to_atlas_pos = {
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
G.cl_enhancements = {}

SMODS.DrawStep({
    key = 'enhancement_sprite',
    order = 21,
    func = function(card, layer)
        if not Mace.is_using_skin(card) then
            card.children.center.states.visible = true
            return
        end
        card.children.center.states.visible = false

        local key = card.config.center.key
        if key == 'c_base' or card.config.center.set ~= "Enhanced" then return end
        if not G.cl_enhancements[key] then
            local data = enhancement_to_atlas_pos[key]
            if not data then return print("Mace: No pos provided for enhancement: " .. key) end
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
    end,
    conditions = { vortex = false, facing = 'front' },
})

local satlas = "mace_enhancements"
local seal_to_atlas_pos = {
    ["Red"] = { atlas = satlas, pos = { x = 1, y = 2 } },
    ["Blue"] = { atlas = satlas, pos = { x = 2, y = 2 } },
    ["Gold"] = { atlas = satlas, pos = { x = 0, y = 2 } },
    ["Purple"] = { atlas = satlas, pos = { x = 3, y = 2 } },
}
G.cl_seals = {}

SMODS.DrawStep({
    key = 'seal_sprite',
    order = 21,
    func = function(card, layer)
        if not Mace.is_using_skin(card) then return end

        local seal = card.seal
        if not seal then return end
        if not G.cl_seals[seal] then
            local data = seal_to_atlas_pos[seal]
            if not data then return print("Mace: No pos provided for seal: " .. seal) end
            G.cl_seals[seal] = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, data.atlas, data.pos)
        end
        G.cl_seals[seal].role.draw_major = card
        G.cl_seals[seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        if seal == 'Gold' then
            G.cl_seals[seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil,
                card.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
})


-- previous attempt at enhancements made by someone else

--SMODS.DrawStep {
--    key = 'mace_render',
--    order = 2,
--    func = function(self, layer)
--        --Draw the main part of the card
--        if (self.edition and self.edition.negative and (not self.delay_edition or self.delay_edition.negative)) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
--            if self.children.front and (self.ability.delayed or not self:should_hide_front()) then
--                self.children.front:draw_shader('negative', nil, self.ARGS.send_to_shader)
--            end
--        elseif not self:should_draw_base_shader() then
--            -- Don't render base dissolve shader.
--        elseif not self.greyed then
--            if self.children.front and (self.ability.delayed or not self:should_hide_front()) then
--                self.children.front:draw_shader('dissolve')
--            end
--        end
--    end,
--    conditions = { vortex = false, facing = 'front', front_hidden = false },
--}
