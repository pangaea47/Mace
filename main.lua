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
    path = "enhancements.png"
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


local atlas = "mace_enhancements"
local enhancement_to_atlas_pos = {
    ["c_base"] = { atlas = atlas, pos = { x = 0, y = 0 } },
    ["m_bonus"] = { atlas = atlas, pos = { x = 1, y = 0 } },
    ["m_mult"] = { atlas = atlas, pos = { x = 2, y = 0 } },
    ["m_wild"] = { atlas = atlas, pos = { x = 3, y = 0 } },
    ["m_lucky"] = { atlas = atlas, pos = { x = 4, y = 0 } },
    ["m_glass"] = { atlas = atlas, pos = { x = 5, y = 0 } },
    ["m_steel"] = { atlas = atlas, pos = { x = 6, y = 0 } },
    ["m_stone"] = { atlas = atlas, pos = { x = 0, y = 1 } },
    ["m_gold"] = { atlas = atlas, pos = { x = 1, y = 1 } },
}
G.cl_enhancements = {}

SMODS.DrawStep({
    key = 'enhancement_sprite',
    order = 1,
    func = function(card, layer)
        local key = card.config.center.key
        if key == 'c_base' or card.config.center.set ~= "Enhanced" then return end
        if not G.cl_enhancements[key] then
            local data = enhancement_to_atlas_pos[key]
            G.cl_enhancements[key] = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, data.atlas, data.pos)
        end
        if key ~= 'c_base' then
            G.cl_enhancements[key].role.draw_major = card
            G.cl_enhancements[key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            if card.edition then
                local edition = G.P_CENTERS[card.edition.key]
                G.cl_enhancements[key]:draw_shader(edition.shader, nil, nil, nil, card.children.center, scale_mod,
                    rotate_mod)
            end
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
