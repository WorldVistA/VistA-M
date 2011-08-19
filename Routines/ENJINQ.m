ENJINQ ;(WASH ISC)/JA/TJK-Help Processor (Screens) ;3-6-92
 ;;7.0;ENGINEERING;;Aug 17, 1993
 S D=""
A S DJX="" X:$Y<16 DJCP
 I DJ4["R" W "**REQUIRED**",*7
 ;ADDITIONAL HELP
 S:'$D(X) X=DJXX G:X'="??" F G:'$D(^DD(DJDD,DJAT,21,0)) F G:'$P(^(0),U,4) F
 S DJZ1=0,DIWL=0,DIWR=79,DIWF="" K ^UTILITY($J,"W")
 S DJXX=X F DJK=1:1 S DJZ1=$O(^DD(DJDD,DJAT,21,DJZ1)) Q:DJZ1=""  S X=^(DJZ1,0) D ^DIWP
 S DJZ1=0 F DJK=1:1 S DJZ1=$O(^UTILITY($J,"W",DIWL,DJZ1)) Q:DJZ1=""  D:$Y>21 HLD Q:DJX[U  W !,^(DJZ1,0)
 D HLD K DJZ1,DJK,^UTILITY($J,"W",DIWL),DIWL,DIWR,DIWF S X=DJXX G:DJX'[U F Q
HLD W !,"Type <CR> to continue, uparrow to exit: " R DJX:DTIME X DJCP W ! Q
CONT R !,"Repaint screen (Y/N): N//",DJX:DTIME I DJX["?" W !,*7,"Please enter 'Y'es or 'N'o." G CONT
 X DJCP Q:DJX=""!("Yy"'[$E(DJX))  S DJSV=V N DJ0 D N^ENJDPL S V=DJSV Q
F D:$Y>19 HLD Q:DJX[U  I $D(^DD(DJDD,DJAT,3)),^(3)]"" W !,^(3) D HLD Q:DJX[U
 I $D(^DD(DJDD,DJAT,4)) W ! X ^(4)
 I DJ4["S",DJ4'["M" D:$Y>21 CONT Q:DJX[U  W !,"CHOOSE FROM:" S DJS=$P(^DD(DJDD,DJAT,0),U,3) F DJK=1:1 S Y=$P(DJS,";",DJK) Q:Y=""  S Y="'"_$P(Y,":",1)_"'  FOR "_$P(Y,":",2) W !,Y
 ; D DCS^ENJ
 I DJ4["P" K DIC("S") S DJDIC=DIC,DJD0=D0,DIC(0)=$S(DJ4["'":"MEQZ",1:"MEQZL"),DIC=+$P(DJ4,"P",2) X DJCP X:$P(^DD(DJDD,DJAT,0),U,2)["*" ^(12.1) D ^DIC K DIC D CONT S DIC=DJDIC,D0=DJD0 G:Y<0 R1 S V(V)=$E(Y(0,0),1,+DJJ(V)) G P1
 I DJ4["D" S:'$D(%DT) %DT="E" D HELP
 K DJS,DJZ1 I $Y>23 D CONT Q
 D CONT S @$P(DJJ(V),U,2) X XY W V(V) Q
P ; D DCS^ENJ
 K DIC("S") S DJDIC=DIC,DJD0=D0,DIC(0)=$S(DJ4["'":"MEQZ",1:"MEQZL"),DIC=+$P(DJ4,"P",2) X DJCP W X X:$P(^DD(DJDD,DJAT,0),U,2)["*" ^(12.1) D ^DIC K DIC S:+Y>0 V(V)=$E(Y(0,0),1,+DJJ(V)),DIC=DJDIC,D0=DJD0 D CONT G:Y<0 R1
P1 ;
 S X=+Y,(DIE,DIC)=DJDIC,DA=DJDN,DR=DJ3_"////"_X X DJCP W ! D ^DIE S D0=DJD0 D PP S V(V)=$E(V(V),1,+DJJ(V)) X:$D(^ENG(6910.9,DJN,1,$O(^ENG(6910.9,DJN,1,"A",V,0)),1)) ^(1)
 I $Y>23 S DJZ=V D N^ENJDPL S V=DJZ Q
 S DY=17,DX=0 X XY W @DJEOP S @$P(DJJ(V),U,2) X XY W @DJHIN X XY W V(V),@DJLIN Q
R1 S DIC=DJDIC
 S @$P(DJJ(V),U,2) X XY W:$D(V(V)) @DJHIN W:$D(V(V)) V(V) X XY Q
FUNC ;COMMAND DISPLAY FOR PROGRAM DJINJ
 X DJCP
 W @DJHIN X XY W "COMMANDS",@DJLIN,!
 W "^   -- Quit",?41,"@  -- Delete data"
 W !,"^nn -- Go to the 'nn' statement",?41,"CR -- Go to the next statement"
 W !,"^C  -- Command menu display",?41,"<  -- Go to previous statement"
 W !,"^N  -- New Record",?41,"?? -- For more information about field"
 W !,"    -- Space bar, recall previous answer",?41," ? -- Information about field"
 W !,"^D  -- Down page",?41,"^U  -- Up page"
 W !,"Note: (C)omputed, (M)ultiple, (W)ord processing, (R)ead only"
 H 5 ;Prevent premature erasure
 Q
FUNC2 ;COMMAND DISPLAY
 X DJCP
 W @DJHIN X XY W "COMMANDS",@DJLIN,!
 W "^ -- Quit",?41,"^nn -- Go to the 'nn' statement"
 W !,"@ -- delete data",?41,"CR  -- Go to the next statement"
 W !,"  -- Space bar, recall previous record",?41,"<   -- Go to previous statement"
 W !,"? -- Help prompt",?41,"?? -- For more information about field"
 W !,"^C -- Command menu display",?41,"^N -- Next record"
 W !,"^L -- List current elements"
 W !,"Note: (C)omputed, (M)ultiple, (W)ord processing, (R)ead only"
 Q
HELP ;
 D:$Y>21 R W !,"EXAMPLES OF VALID DATES:"
 D:$Y>21 R W !,"  JAN 22 1957 or 22 JAN 57 or 1/22/57 or 012257"
 D:$Y>21 R W !,"  T (FOR TODAY), T+1 (FOR TOMORROW), T+2, T+7, etc."," T-1 (FOR YESTERDAY)"
 D:$Y>21 R W !,"  T-3W (3 WEEKS AGO), etc."
 D:$Y>21 R W !,"IF THE YEAR IS OMITTED, THE COMPUTER USES THE CURRENT YEAR",!
 D:$Y>21 R I %DT'["X" W "YOU MAY OMIT THE PRECISE DAY, AS:  JAN, 1957",!
 D:$Y>21 R I %DT["T" W "FOLLOW DATE WITH TIME, AS:  JAN 22@10,    T@10PM,   ETC."
 Q
R X DJCL W "Type <CR> to continue" R DJX:10 X DJCP
PP ;
 S DJZ=+$P($P(^DD(DJDD,DJAT,0),"^",2),"P",2) Q:$P(^DD(DJZ,.01,0),"^",2)'["P"
P11 I $D(@("^"_$P(^DD(DJZ,.01,0),U,3)_"V(V),0)")) S V(V)=$P(^(0),U,1)
 S DJZ=+$P($P(^DD(DJZ,.01,0),"^",2),"P",2) Q:$P(^DD(DJZ,.01,0),"^",2)'["P"  G P11
