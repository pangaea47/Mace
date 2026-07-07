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

for _, suit in ipairs({ "hearts", "clubs", "diamonds", "spades" }) do
    SMODS.DeckSkin {
        key = suit.."_mace",
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