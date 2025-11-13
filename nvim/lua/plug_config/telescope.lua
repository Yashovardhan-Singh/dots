return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local t = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", t.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", t.live_grep,  { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", t.buffers,    { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", t.help_tags,  { desc = "Help tags" })
    end,
  }
