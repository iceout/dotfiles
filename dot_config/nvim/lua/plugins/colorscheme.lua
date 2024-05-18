return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local solarized = require("solarized")
      vim.o.background = "dark" -- or 'light'
      solarized.setup({
        transparent = true,
        palette = "selenized", -- or solarized
        --  colors = {
        --    base0 = "#b9b9b9",
        --    base02 = "#3b3b3b",
        --    base03 = "#181818",
        --    base04 = "#252525",
        --    magenta = "#eb6eb7",
        --    red = "#ed4a46",
        --    yellow = "#dbb32d",
        --    green = "#70b433",
        --    blue = "#368aeb",
        --    cyan = "#3fc5b7",
        --  },
      })

      vim.cmd.colorscheme("solarized")
    end,
  },
}
