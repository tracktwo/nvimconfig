
-- Configure harpoon
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "[H]arpoon: M[a]rk file" } )
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, { desc = "[H]arpoon: Quick Menu" } )
vim.keymap.set("n", "<leader>ha", function() ui.nav_file(1) end, { desc = "[H]arpoon: Jump to buffer 1"} )
vim.keymap.set("n", "<leader>hs", function() ui.nav_file(2) end, { desc = "[H]arpoon: Jump to buffer 2"})
vim.keymap.set("n", "<leader>hd", function() ui.nav_file(3) end, { desc = "[H]arpoon: Jump to buffer 3"})
vim.keymap.set("n", "<leader>hf", function() ui.nav_file(4) end, { desc = "[H]arpoon: Jump to buffer 4"})

