local old_footprint_func = SMODS.DrawStep.obj_table["mxms_footprint"].func
SMODS.DrawStep:take_ownership("mxms_footprint", {
    func = function(card, context)
        if Mace.is_using_skin(card) then
        else
            old_footprint_func(card, context)
        end
    end,
}, true)
