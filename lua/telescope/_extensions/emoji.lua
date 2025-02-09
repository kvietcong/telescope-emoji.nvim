local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local action_state = require("telescope.actions.state")

local config = require("telescope-emoji").config
local emojis = require("telescope-emoji").emojis

local custom_search = function(get_ordinal, opts)
    local displayer = entry_display.create({
        separator = " ",
        items = {
            { width = 40 },
            { width = 18 },
            { remaining = true },
        },
    })
    local make_display = function(entry)
        return displayer({
            entry.value .. " " .. entry.name,
            entry.category,
            entry.description,
        })
    end

    pickers.new(opts, {
        prompt_title = "Emojis",
        sorter = conf.generic_sorter(opts),
        finder = finders.new_table({
            results = emojis,
            entry_maker = function(emoji)
                return {
                    ordinal = get_ordinal(emoji),
                    display = make_display,

                    name = emoji.name,
                    value = emoji.value,
                    category = emoji.category,
                    description = emoji.description,
                }
            end,
        }),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local emoji = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                config().action(emoji)
            end)
            return true
        end,
    }):find()
end

local default_search = function(opts)
    custom_search(config().default_get_ordinal, opts)
end

local category_search = function(opts)
    custom_search(function(emoji) return emoji.category end, opts)
end

local exports = {
    emoji = default_search,
    search = default_search,
    ---
    category = category_search,
    custom = custom_search,
}

return require("telescope").register_extension({
    exports = exports,
})
