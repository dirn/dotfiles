function c -d 'Copy to the clipboard, trimming newlines'
    command tr -d '\n' | pbcopy
end
