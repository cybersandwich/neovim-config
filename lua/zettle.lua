local M = {}
function M.test_grep_filename()
    local opts = {
        prompt_title = "~ Backlink ~",
        shorten_path = false,
        cwd = "/Users/wes/zn",
        attach_mappings = function(_, map)
            map(
                "i",
                "<CR>",
                function(prompt_bufnr)
                    -- filename is available at entry[1]
                    local entry = require("telescope.actions.state").get_selected_entry()
                    require("telescope.actions").close(prompt_bufnr)
                    local filename = entry[1]
                    -- Insert filename in current cursor position
                    vim.cmd("normal i" .."[[ " .. filename .. " ]]" )
                end
            )
            return true
        end
    }
    require("telescope.builtin").live_grep(opts)
end
return M
