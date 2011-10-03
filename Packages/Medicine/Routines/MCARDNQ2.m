MCARDNQ2 ;WISC/TJK,JA-SCREEN INPUT - QUESTIONMARKS (PART 2) ;7/9/96  12:09
 ;;2.3;Medicine;;09/13/1996
FUNC ;
 ;JAH don't display commands for option MCRHDELVISIT
 I $D(MCDSPTYP) Q
 I $D(MCDID) Q
 I ('$D(MCMASS)),('$D(MCHELPS2)) Q
 I '$D(DJTOGGLE) D FUNCC
 E  D FUNCK
 K MCMASS S MCDID=1
 Q
FUNCC ;Display help for Line Entry
 X DJCP
 S DJCHO="C" D DISPLAY("LINE") S MCDID=1
 S @$P(DJJ(V),U,2) X XY
 Q
FUNCK ;Display help for Keypad 
 X DJCP S DJCHO="K" D DISPLAY("KEYPAD") S MCDID=1
 S @$P(DJJ(V),U,2) X XY
 Q
DISPLAY(MODE) ;Display help 
 N LOOP,LINE,MODE2
 S X=0 X ^%ZOSF("RM") ;    turn off auto wrap   ;  REW added since MSM count escape sequences (some of the time!!!)
 S MODE2=$J(MODE,6)
 S MODE2=$S(MODE="LINE":"      ",1:MODE)
 X XY W IORVON,DJHIN,MODE2," COMMANDS:",DJLIN,IORVOFF,"  (C)omputed, (M)ultiple, (W)ord processing, (R)ead only"
 F LOOP=1:1:7 S LINE=$P($T(@MODE+LOOP),";;",2) D
 .W !,DJHIN,$P(LINE,";",1),DJLIN," -- ",$P(LINE,";",2)," "
 .W DJHIN,$P(LINE,";",3),DJLIN," -- ",$P(LINE,";",4)
 S X=+$G(IOM) X ^%ZOSF("RM") ;    reset margin/auto wrap   ;  REW added since MSM count escape sequences (some of the time!!!)
 Q
FUNC2 X DJCP
 W DJHIN X XY W "COMMANDS",DJLIN,!
 W "^ -- Quit",?41,"^nn -- Go to the 'nn' statement"
 W !,"@ -- delete data",?41,"CR  -- Go to the next statement"
 W !,"  -- Space bar, recall previous record",?41,"<   -- Go to previous statement"
 W !,"? -- Help prompt",?41,"?? -- For more information about field"
 W !,"^C -- Command menu display"
 W !,"^L -- List current elements"
 W !,"Note: (C)omputed, (M)ultiple, (W)ord processing, (R)ead only"
 Q
LINE ;
 ;; ^T or PF1;Toggle to Keypad mode     ;  ?//??;Field help
 ;; ^C       ;Display Commands (current mode)  ;<RET>;Next field
 ;; ^R       ;Repaint the screen        ;      <;Previous field
 ;; ^D       ;Next screen               ;    ^nn;Go to the 'nn' field
 ;; ^U       ;Previous screen           ;      @;Delete data
 ;; ^O       ;Turn on/off automatic help;      ^;Quit
 ;; ^H       ;Help           ;   Space bar <RTN>;Recall previous answer
KEYPAD ;
 ;;PF1 or ^T;Toggle to Numberpad mode;         PF2;Turn on/off auto help
 ;;KP1      ;Display Commands (current mode)  ;KP7;Help
 ;;KP3      ;Exit                    ;  PF3 or PF4;Field help
 ;;KP4      ;Go to the 'nn' field    ;    Up Arrow;Previous field
 ;;KP5      ;Repaint the screen      ;  Down Arrow;Next field
 ;;KP6      ;Recall previous answer  ; Right Arrow;Next Screen
 ;;KP9      ;Delete data             ;  Left Arrow;Previous Screen
