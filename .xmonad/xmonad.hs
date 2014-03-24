import XMonad hiding( (|||) )
import XMonad.Layout.LayoutCombinators
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Config.Desktop(desktopLayoutModifiers)

import XMonad.StackSet
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

import XMonad.Actions.SpawnOn
import Data.Monoid
import qualified Data.Map as M
import Control.Monad

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO

myManageHook = composeAll
               [ isFullscreen --> doFloat ]


main = do
  customConfig <- myConfig
  spawn "~/.xmonad/startup-commands.sh">>xmonad customConfig

myConfig = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/even/.xmobarc.hs"
  return $ defaultConfig {

    startupHook = myStartupHook,
    modMask = mod4Mask,
    terminal = "gnome-terminal",
    XMonad.workspaces = myWorkspaces,
    manageHook = manageSpawn <+> manageDocks <+> myManageHook <+> manageHook defaultConfig,
    --      startupHook = startup <+> startupHook defaultConfig,
    layoutHook = avoidStruts $ smartBorders $ desktopLayoutModifiers (tall ||| Full),
    logHook = dynamicLogWithPP xmobarPP
               { ppOutput = hPutStrLn xmproc,
                 ppTitle = xmobarColor "#6C8CD5" "" . shorten 50,
                 ppCurrent = xmobarColor "#6C8CD5" "" . wrap "(" ")"
                },
    borderWidth = 3,
    normalBorderColor = "#cccccc",
    focusedBorderColor = "#eb8f00",
    focusFollowsMouse = False
    } `additionalKeys`
    [ ((mod4Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command --lock"),
      ((mod4Mask .|. shiftMask, xK_s), spawn "sleep 0.1; gnome-screenshot -a"),
      ((mod4Mask, xK_Down), spawn "amixer set Master 5%-"),
      ((mod4Mask, xK_Up), spawn "amixer set Master 5%+"),
      ((mod4Mask, xK_b), sendMessage ToggleStruts),
      ((mod4Mask, xK_z), spawn "zathura"),
      ((mod4Mask, xK_c), spawn "emacs"),
      ((mod4Mask, xK_o), spawn "google-chrome-stable"),
      ((mod4Mask, xK_w), kill),
      ((0, xK_Scroll_Lock), spawn "dmenu_run -b -p drad$ -nb '#000000' -nf '#00B74A' -sb '#8E8888' -sf '#A60032'"),
      ((mod4Mask, xK_Scroll_Lock), spawn "~/.calc.sh"),
      -- task mgr
      ((mod1Mask .|. controlMask, xK_Delete), spawn "gnome-system-monitor"),
      -- irssi
      ((mod4Mask, xK_i), spawn "gnome-terminal -e irssi"),

      -- Audio
      ((mod4Mask, xK_a), spawn "gnome-terminal -e alsamixer -c 1"),
      ((0, 0x1008ff13), spawn "gnome-terminal -e amixer -c 1 set Master 4+"),
      ((0, 0x1008ff11), spawn "gnome-terminal -e amixer -c 1 set Master 4-"),
      ((0, 0x1008ff12), spawn "gnome-terminal -e amixer -c 1 set Master 0db"),

      -- Brightness
      ((0, 0x1008ff02), spawn "xbacklight -inc 10"),
      ((0, 0x1008ff03), spawn "xbacklight -dec 10")


    ]

myStartupHook=do
  spawnOn "term" "gnome-terminal"
  spawnOn "emacs" "emacs"
  spawnOn "web" "google-chrome"
  spawnOn "adium" "gnome-terminal -e finch"

myWorkspaces = ["term", "emacs", "web", "adium"] ++ map show ([5..8] :: [Int]) ++ ["irssi"]

--startup = do
--  spawn "synaptikscfg load"
--  spawn "synaptikscfg init"
tall = Tall 1 (3/100) (1/2)
