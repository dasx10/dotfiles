return {
  {
    'vim-airline/vim-airline',
    config = function()
      vim.g.airline_section_y = "%{getfsize(expand('%:p')) >= 0 ? getfsize(expand('%:p')) . 'B  ' : ''}%{&ff}  %{&fenc}"
    end,
  },
  {
    'vim-airline/vim-airline-themes',
  },
}
