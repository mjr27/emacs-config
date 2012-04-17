(set-variable 'default-background "#000D13")
(set-variable 'default-foreground "#ffffff")
(set-variable 'tabbar-background "grey50")
(set-variable 'region-background "#303000")

(set-variable 'default-font "-*-Liberation Mono-*-*-*-15-*-*-*-*-*-*")

(set-face-background 'default default-background)
(set-face-foreground 'default default-foreground)
(set-face-font 'default default-font)

(set-face-background 'region region-background)
(set-face-foreground 'region "white")

(set-face-font 'tabbar-default default-font)
(set-face-background 'tabbar-default tabbar-background)
(set-face-foreground 'tabbar-default default-foreground)
(set-face-attribute 'tabbar-default nil :box '(:line-width 7  :color "#000D13" ))

(set-face-background 'tabbar-selected default-background)
(set-face-foreground 'tabbar-selected default-foreground)
(set-face-attribute 'tabbar-selected nil :box '(:line-width 7 :color "#000D13" )  :weight 'bold )

(set-face-background 'tabbar-unselected tabbar-background)
(set-face-foreground 'tabbar-unselected default-background)
(set-face-attribute 'tabbar-unselected nil :box '(:line-width 7 :color "grey50" )  :weight 'bold )

(set-face-attribute 'tabbar-separator nil :box '(:line-width 1  :color "grey50" ))

(set-face-foreground 'cursor default-background)
(set-face-background 'cursor default-foreground)
