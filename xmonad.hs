import XMonad hiding( (|||) )
import XMonad.Layout.LayoutCombinators
import XMonad.Config.Azerty
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Config.Desktop(desktopLayoutModifiers)
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Grid
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile

import XMonad.StackSet
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Spacing

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
  xmonad azertyConfig

myConfig = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/evenlis/.xmobarc.hs"
  return $ defaultConfig {

    startupHook = myStartupHook,
    modMask = mod4Mask,
    terminal = "rxvt-unicode",
    XMonad.workspaces = myWorkspaces,
    manageHook = manageSpawn <+> manageDocks <+> myManageHook <+> manageHook defaultConfig,
    --      startupHook = startup <+> startupHook defaultConfig,
    layoutHook = avoidStruts $ smartBorders $ desktopLayoutModifiers (tall ||| Full ||| Grid),
    logHook = dynamicLogWithPP xmobarPP
               { ppOutput = hPutStrLn xmproc,
                 ppTitle = xmobarColor "#6C8CD5" "" . shorten 50,
                 ppCurrent = xmobarColor "#6C8CD5" "" . wrap "(" ")"
                },
    borderWidth = 2,
    normalBorderColor = "#cccccc",
    focusedBorderColor = "#eb8f00",
    focusFollowsMouse = False
    } `additionalKeys`
    [ ((mod4Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command --lock"),
      ((mod4Mask .|. shiftMask, xK_s), spawn "sleep 0.1; gnome-screenshot -a"),
      ((mod4Mask, xK_Down), spawn "amixer -c 1 set Master 5%-"),
      ((mod4Mask, xK_Up), spawn "amixer -c 1 set Master 5%+"),
      ((mod4Mask, xK_Left), spawn "xbacklight -dec 15"),
      ((mod4Mask, xK_Right), spawn "xbacklight -inc 15"),
      ((mod4Mask, xK_b), sendMessage ToggleStruts),
      ((mod4Mask, xK_u), prevWS),
      ((mod4Mask, xK_i), nextWS),
      ((mod4Mask .|. shiftMask, xK_i), prevScreen),
      ((mod4Mask .|. shiftMask, xK_u), nextScreen),
      ((mod4Mask, xK_c), spawn "emacs"),
      ((mod4Mask, xK_z), spawn "zathura"),
      ((mod4Mask, xK_o), spawn "google-chrome"),
      ((mod4Mask, xK_w), kill),
      ((0, xK_Scroll_Lock), spawn "dmenu_run -b -i -l 10 -p \">\" -fn \"-*-helvetica-bold-r-normal-*-17-*-100-*-p-0-*-15\""),
      ((mod4Mask, xK_Scroll_Lock), spawn "~/.calc.sh"),
      -- task mgr
      ((mod1Mask .|. controlMask, xK_Delete), spawn "gnome-system-monitor"),
      ((mod4Mask .|. controlMask, xK_h), sendMessage Shrink),
      ((mod4Mask .|. controlMask, xK_l), sendMessage Expand),

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
  spawnOn "term" "rxvt-unicode"
  spawnOn "emacs" "emacs"
  spawnOn "web" "google-chrome"
  spawnOn "slack" "google-chrome --app=https://p15ntnu.slack.com"

myWorkspaces = ["term", "emacs", "web", "slack"] ++ map show ([5..9] :: [Int])

--startup = do
--  spawn "synaptikscfg load"
--  spawn "synaptikscfg init"
tall = Tall 1 (3/100) (1/2)
