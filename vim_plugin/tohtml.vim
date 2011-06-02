" Vim plugin for converting a syntax highlighted file to HTML.
" Maintainer: Bram Moolenaar <B...@vim.org>
" Last Change: 2003 Apr 06
" Don't do this when:
" - when 'compatible' is set
" - this plugin was already loaded
" - user commands are not available.
if !&cp && !exists(":TOhtml") && has("user_commands")
  command -range=% TOhtml :call Convert2HTML(<line1>, <line2>)
  func Convert2HTML(line1, line2)
    if a:line2 >= a:line1
      let g:html_start_line = a:line1
      let g:html_end_line = a:line2
    else
      let g:html_start_line = a:line2
      let g:html_end_line = a:line1
    endif
    if !&diff
        runtime syntax/2html.vim
    else
        let winnr = []
        windo | if (&diff) | call add(winnr, winbufnr(0)) | endif
        for window in winnr
            exe ":" . bufwinnr(window) . "wincmd w"
            let g:html_start_line = 1
            let g:html_end_line = line('$')
            runtime syntax/2html.vim
        endfor
        call Diff2HTML(winnr)
    endif
    unlet g:html_start_line
    unlet g:html_end_line
  endfunc
  func Diff2HTML(vars)
        let bufnr = []
        for wind in a:vars
            let name=bufname(wind)  . '.html'
            if name == '.html'
                let name='Untitled.html'
            endif
            call add(bufnr, bufnr(name))
        endfor
        let html = []
        call add(html, '<html>')
        call add(html, '<head>')
        call add(html, '<title>diff</title>')
        call add(html, '<meta name="Generator" content="Vim/7.2">')
        call add(html, '<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">')
        call add(html, '</head>')
        call add(html, '<body bgcolor="#333333" text="#ffffff"><font face="monospace">')
        call add(html, '<table border="1" width="100%">')
        call add(html, '<tr>')
        for buf in a:vars
            call add(html, '<th>'.bufname(buf).'</th>')
        endfor
        call add(html, '</tr><tr>')
        for buf in bufnr
            let temp=[]
            exe ":" . bufwinnr(buf) . 'wincmd w'
            1,/<body/d_
            $
            ?</body>?,$d_
            let temp=getline(1,'$')
            call add(html, '<td nowrap valign="top">')
            let html+=temp
            call add(html, '</td>')
        endfor
        call add(html, '</tr>')
        call add(html, '</table>')
        call add(html, '</font>')
        call add(html, '</body>')
        call add(html, '</html>')
        let i=1
        let name="Diff" . ".html"
        while filereadable(name)
            let name = substitute(name, '\d*\.html$', '', '') . i . ".html"
            let i+=1
        endw
        exe ":new " . name
        set modifiable
        call append(0,html)
  endfunc
endif