vim.cmd([[
"
if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    let g:neovide_refresh_rate = 60 
    let g:neovide_cursor_animation_length=0.03
    let g:neovide_cursor_vfx_mode = "pixiedust"
    let g:neovide_transparency = 0.95
    set guifont=JetBrains\ Mono:h10
endif
"]])
