local function config()
    vim.g.sexp_mappings = {
        -- stolen from tpope/sexp_mappings_for_regular_people.vim
        -- except I want to disable existing maps
        sexp_splice_list = "dsf",
        sexp_move_to_prev_element_head = "B",
        sexp_move_to_next_element_head = "W",
        sexp_move_to_prev_element_tail = "gE",
        sexp_move_to_next_element_tail = "E",
        sexp_swap_list_backward = "<f",
        sexp_swap_list_forward = ">f",
        sexp_swap_element_backward = "<e",
        sexp_swap_element_forward = ">e",
        sexp_emit_head_element = ">(",
        sexp_emit_tail_element = "<)",
        sexp_capture_prev_element = "<(",
        sexp_capture_next_element = ">)",
        -- TODO
        sexp_convolute = "<Leader>?",
        sexp_raise_list = "<Leader>o",
        sexp_raise_element = "<Leader>O",
        -- disable
        sexp_flow_to_prev_close = "",
        sexp_flow_to_prev_open = "",
        sexp_flow_to_next_close = "",
        sexp_flow_to_next_open = "",
        sexp_flow_to_prev_leaf_head = "",
        sexp_flow_to_next_leaf_head = "",
        sexp_flow_to_prev_leaf_tail = "",
        sexp_flow_to_next_leaf_tail = "",
        sexp_round_head_wrap_list = "",
        sexp_round_tail_wrap_list = "",
        sexp_square_head_wrap_list = "",
        sexp_square_tail_wrap_list = "",
        sexp_curly_head_wrap_list = "",
        sexp_curly_tail_wrap_list = "",
        sexp_round_head_wrap_element = "",
        sexp_round_tail_wrap_element = "",
        sexp_square_head_wrap_element = "",
        sexp_square_tail_wrap_element = "",
        sexp_curly_head_wrap_element = "",
        sexp_curly_tail_wrap_element = "",
        sexp_insert_at_list_head = "",
        sexp_insert_at_list_tail = "",
    }
end

return {
    { 'guns/vim-sexp', config = config },
}
