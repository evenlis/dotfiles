Config { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
       , bgColor = "#131517"
       , fgColor = "#88C965"
       , position = Top
       , lowerOnStart = True

       ,commands = [ Run MultiCpu [] 10
                     --, Run CoreTemp ["-t", "C C", "-L", "40", "-H", "60", "-l", "lightblue", "-n", "white", "-h", "red"] 50

                   , Run Memory [] 10

                   , Run Swap [] 100

                   , Run Network "eth1" [] 10

--                   , Run Battery ["-t","Battery: %","-L","25","-H","75","--low","#FF0000","--normal","#F9FF00","--high","#00FF00"] 10
                   ,Run BatteryP ["BAT0"]
                    ["-t", "<acstatus> (<left>%)",
                     "-L", "10", "-H", "80", "-p", "3",
                     "--", "-O", "<fc=green>On</fc> - ",
                     "-L", "-15", "-H", "-5",
                     "-l", "red", "-m", "blue", "-h", "green"] 600

                   , Run Com "/home/even/.xmobar/getvolume.sh" [] "myVolume" 3
                   , Run Com "/home/even/.xmobar/getcoretemp.sh" [] "coreTemp" 100
                   , Run Date "%a %_d. %b %H:%M" "date" 10

                   , Run StdinReader

                   ]

       , sepChar = "%"

       , alignSep = "}{"

       , template = "%StdinReader% }{  %multicpu% | Temp: %coreTemp% | %memory% %swap% | %eth1% | <fc=#A7779E>%battery%</fc> | <fc=#FFC300>Vol: %myVolume%</fc> | <fc=#0099FF>%date%</fc>   "

       }
