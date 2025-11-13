return {
    "goolord/alpha-nvim",
    config = function()
      local alpha, dashboard = require("alpha"), require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██║   ██║██║████╗ ████║",
        "██╔██╗ ██║██║   ██║██║██╔████╔██║",
        "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
      }
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  Find text", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      dashboard.section.footer.val =
        os.date("  %d-%m-%Y   %H:%M:%S") ..
        "  |    v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
      alpha.setup(dashboard.opts)
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function() if vim.fn.argc() == 0 then alpha.start(true) end end,
      })
    end,
  }
