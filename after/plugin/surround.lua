local S = require("nvim-surround")
local C = require("nvim-surround.config")

local define_rust_surround = function(name)
  return {
      add = function()
        return { { name .. "(" }, { ")" } }
      end,
      find = function()
        return C.get_selection({pattern = name .. "%b()"})
      end,
      delete = "^(" .. name .. "%()().-(%))()$",
      change = {
       target = "^(" .. name .. "%()().-(%))()$",
      }
  }
end
S.setup({
  surrounds = {
    ["O"] = define_rust_surround("Ok"),
    ["E"] = define_rust_surround("Err"),
    ["S"] = define_rust_surround("Some"),
  }
})

