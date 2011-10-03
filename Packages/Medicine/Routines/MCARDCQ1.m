MCARDCQ1 ;WISC/TJK-HELP FROM DIC (MODIFIED FOR MEDICINE SCREENS) ;8/23/96  10:06
 ;;2.3;Medicine;;09/13/1996
 S Y=$S('$D(MCPCTY):0,MCPCTY:MCPCTY-.00000001,1:MCPCTY),DS=DS_X,X=-1 I DIZ S DIY=$L($P(DO,U,3))+DIY+5 S:Y="" Y=0
 E  S X=$S(Y=0:-1,1:Y),Y=0
 D Y I $D(DIC("W")),$D(MCBDIC),DIX[MCBDIC_MCDF S DIY=" I $D("_DIC_"Y,0)) X:$D(DIC(""W"")) DIC(""W"")" S:$L(DS)+$L(DIY)<254 DS=DS_DIY S DIY=99
 I $D(DIC("W")),'$D(MCBDIC) S DIY=" I $D("_DIC_"Y,0)) X:$D(DIC(""W"")) DIC(""W"")" S:$L(DS)+$L(DIY)<254 DS=DS_DIY S DIY=99
LST W !?3 S DD=DIY+3,MCMASS=1 I $Y>$S($G(DIC("W"))]"":18,1:21) R "Press <RETURN> to Continue, '^' to Quit: ",MCPCTY:DTIME X:MCPCTY'?1"^" DJCP Q:MCPCTY?1"^"  W $C(13),$J("",15),$C(13),?3 G 0:MCPCTY?1P D Y ; DAD 7-17-96
 ;; ***ORIGINAL*** ;; LST W !?3 S DD=DIY+3,MCMASS=1 I $Y>20 R "Press <RETURN> to Continue, '^' to Quit: ",MCPCTY:DTIME X:MCPCTY'?1"^" DJCP Q:MCPCTY?1"^"  W $C(13),$J("",15),$C(13),?3 G 0:MCPCTY?1P D Y
L X DIX I  G 0
 S DIW=$X X DS Q:$G(MCPCTY)=U  I DIW-$X G LST:DD+DIY>79,LST:$Y>21 W ?DD S DD=DD+DIY
 G L
 ;
WOV S MCPCTDIC=DIC,DIC=MCPCTZ,MCPCTWW=Y,Y=MCPCTY
W1 S MCPCTX=$O(^DD(MCPCTW,0,"ID",MCPCTX)) I MCPCTX]"" S MCPCT=^(MCPCTX) X "W ""  "",$E("_MCPCTZ_MCPCTY_",0),0)",MCPCT G W1
 S DIC=MCPCTDIC,Y=MCPCTWW K MCPCTDIC,MCPCTW,MCPCTX,MCPCTWW,MCPCTZ Q
 ;
Y ;I $D(^("OS",^DD("OS"),"XY")) S DIZ=^("XY") I DIZ?1U.E S (IOX,IOY)=0 X DIZ K IOX,IOY
 S DIZ=$Y+21
 Q
CONT S MCMASS=1
 I $G(MCPCTY)'=U R !," Press <RETURN> to Continue, '^' to Quit: ",MCPCTY:DTIME
 Q
 ;
S S DS(1)=X,DS(2)=Y I 1 X:$D(DIC("S")) DIC("S")
 I $T S Y=DS(2) D SCR:$D(DO("SCR"))
 S X=DS(1),Y=DS(2)
 IF  D  I 1 ;    clear bottom of screen if necessary
 .  IF $Y>21 D
 ..    D CONT
 ..    I MCPCTY'=U X DJCP
 ..    Q
 .  ;END IF
 .  ;
 .  Q
 ;END IF
 ;
 Q
 ;
SCR I @("$D("_DIC_"Y,0))") X DO("SCR")
 Q
 ;
DT W:$E(MCPCT,4,5) +$E(MCPCT,4,5)_"-" W:$E(MCPCT,6,7) +$E(MCPCT,6,7)_"-" W $E(MCPCT,1,3)+1700 W:MCPCT["." " ("_$E(MCPCT_0,9,10)_":"_$E(MCPCT_"000",11,12)_")" Q
 ;
0 ;
 K DIW,DIZ,DS Q:DIC(0)'["L"  S XQH=-1 I $D(MCPCTY) S:MCPCTY="??" DZ=MCPCTY S:MCPCTY?1P DZ="?"
 I $S($D(DLAYGO):DO(2)\1-DLAYGO,1:1),$D(^DIC(+DO(2),0,"LAYGO")),DUZ(0)'="@" F X=1:1 S Y=$E(^("LAYGO"),X) I DUZ(0)[Y G RCR:Y="" Q
 ;
 ;I $D(DZ)#2,DZ="?" W:$X>3 ! W ?3,"YOU MAY ENTER A NEW ",$P(DO,U,1),", IF YOU WISH" D CONT Q:MCPCTY=U
 ;I  X DJCP F DG=3,12 I $D(^DD(+DO(2),.01,DG)) S X=^(DG) F MCPCT=$L(X," "):-1:1 I $L($P(X," ",1,MCPCT))<70 W !?5,$P(X," ",1,MCPCT) W:MCPCT'=$L(X," ") !?5,$P(X," ",MCPCT+1,99) Q
 I $D(DZ)#2,DZ="?" D  Q:MCPCTY=U
 . W:$X>3 ! W ?3,"YOU MAY ENTER A NEW ",$P(DO,U,1),", IF YOU WISH"
 . D CONT Q:MCPCTY=U  X DJCP
 . F DG=3,12 I $D(^DD(+DO(2),.01,DG)) S X=^(DG) F MCPCT=$L(X," "):-1:1 I $L($P(X," ",1,MCPCT))<70 W !?5,$P(X," ",1,MCPCT) W:MCPCT'=$L(X," ") !?5,$P(X," ",MCPCT+1,99) Q
 . D CONT Q:MCPCTY=U  X DJCP
 . Q
 ;
 S DZ1=DO(2),DZ1(0)=DIC(0),DZ1(1)=DO
 I $D(^DD(+DO(2),.01,4)) X ^(4)
 IF $G(DZ)?1"??".E D
 .  IF $D(^DD(+DO(2),.01,22)) D
 ..    S XQH=^DD(+DO(2),.01,22)
 ..    D EN1^XQH
 ..    Q
 .  ;END IF
 .  ;
 .  IF XQH=-1,$D(^DD(+DZ1,.01,21)) D
 ..    ;IF $P(^DD(+DZ1,.01,21,0),"^",4)+$Y>21 D
 ..;.      D CONT
 ..;.      I MCPCTY'=U X DJCP
 ..;.      Q
 ..    ;END IF
 ..    ;
 ..    I $G(MCPCTY)'=U D  D CONT X DJCP
 ...      S X=0
 ...      F  S X=$O(^DD(+DZ1,.01,21,X)) Q:X'>0  W !,$G(^(X,0)) I $Y>21 D CONT Q:MCPCTY=U  X DJCP
 ...      Q
 ..    Q
 .  ;END IF
 .  ;
 .  Q
 ;END IF
 ;
 I $G(MCPCTY)=U Q
 S DO(2)=$S(DJ4["S":DJ4,1:DZ1),DIC(0)=DZ1(0),DO=DZ1(1) K DZ1
 I $Y>20 D CONT Q:MCPCTY=U  X DJCP
 I $D(DZ),DO(2)["S" W !,"CHOOSE FROM: " F X=1:1 S Y=$P($P(^DD(+DO(2),.01,0),U,3),";",X) D CONT:Y="" Q:Y=""  W !?7,$P(Y,":",1),?15," ",$P(Y,":",2) I $Y>21,$P($P(^(0),U,3),";",X+1)'="" D CONT Q:MCPCTY=U  X DJCP
 I DO(2)["V" S DU=+DO(2),D=.01 D V
RCR Q:DO(2)'["P"!$D(DZ(1))  S DZ(1)=DIC,DZ(0)=DIC(0),DS=^DD(+DO(2),.01,0),DIC=U_$P(DS,U,3),DIC(0)=$E("L",$P(DS,U,2)'["'")
 F Y=1:1:3 S X=$E("VWS",Y) S:$D(DIC(X)) DZ(X)=DIC(X) K DO K:Y<3!'DS DIC(X)
 K:DS DZ(3) D DQ^MCARDCQ K DICW,DICS S DIC=DZ(1),DIC(0)=DZ(0) F Y=1:1:3 S X=$E("VWS",Y) K DO,DIC(X) S:$D(DZ(Y)) DIC(X)=DZ(Y)
 D CONT
 Q
V W:$X ! W ?5,"Enter one of the following:",!?7
 F Y=0:0 S Y=$O(^DD(DU,D,"V",Y)) S:Y="" Y=-1 Q:Y'>0  I $D(^(Y,0)) S Y(0)=^(0) X:$D(DIC("V")) DIC("V") I  W:$D(^DIC(+Y(0),0)) $P(Y(0),U,4)_".EntryName to select a "_$P(Y(0),U,2),!?7
 W !?5,"To see the entries in any particular file, type <Prefix.?>",! S DU="" I DZ'?1"??".E K X,DZ Q
T F DG=2:1 S X=$T(T+DG) Q:X=""  W !?5,$E(X,4,99)
 K X,DZ Q
 ;;If you simply enter the name then the system will search each of
 ;;the above files for the name you have entered. If a match is
 ;;found the system will ask you if it is the entry that you desire.
 ;;
 ;;However, if you know the file name of the entry you want
 ;;then you can speed up processing by using the following
 ;;syntax to choose the entry:
 ;;      <Prefix>.<entry name>
 ;;                or
 ;;      <Message>.<entry name>
 ;;                or
 ;;      <File Name>.<entry name>
 ;;
 ;;Also, you do NOT need to enter the entire file name or message
 ;;to direct the look up. Using the first few characters will
 ;;be enough information.
