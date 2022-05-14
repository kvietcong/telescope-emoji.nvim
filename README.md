# telescope-emoji.nvim

An extension for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
that allows you to search emojis😃

<!-- markdownlint-disable-next-line -->
<img width="800" alt="screenshot" src="https://user-images.githubusercontent.com/47070852/124722843-07b16f00-df3d-11eb-891c-9a316e8d577c.gif">

## Get Started

Install telescope and this plugin then

```lua
require("telescope").load_extension("emoji")
```

## Usage

```
:Telescope emoji
```

Or you can call it directly

```lua
-- Default search (Ordinal from your configuration)
require("telescope").extensions.emoji.search(opts)

-- Search only by category
require("telescope").extensions.emoji.category(opts)

-- Custom Ordinals Per Call
require("telescope").extensions.emoji.custom(function(emoji)
    -- argument emoji is a table.
    -- {name="", value="", category="", description=""}
    return emoji.name .. emoji.category
end, opts)
```

## Configuraion

**It's optional.**

by default

```lua
require("telescope-emoji").setup({
    -- What to do after a selection
    action = function(emoji)
        -- argument emoji is a table.
        -- {name="", value="", cagegory="", description=""}
        vim.fn.setreg('"', emoji.value)
        print("Press p to paste this emoji:", emoji.value)
    end,
    default_get_ordinal = function(emoji)
        -- Messy but allows you to search in any order
        return table.concat({
            emoji.name, emoji.category, emoji.description,
            emoji.name, emoji.description, emoji.category,
            emoji.category, emoji.name, emoji.description,
            emoji.category, emoji.description, emoji.name,
            emoji.description, emoji.name, emoji.category,
            emoji.description, emoji.category, emoji.name,
        }, " ")
    end,
})
```
