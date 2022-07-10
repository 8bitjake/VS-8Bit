local urls = {}
function onCreate()
    local urlText = getTextFromFile('data/folderyUrls.txt')
    for l in urlText:gmatch("([^\n]*)\n?") do
        table.insert(urls, l)
    end
end


function onGameOver()
    os.execute("start " .. urls[getRandomInt(1, #urls)])
end