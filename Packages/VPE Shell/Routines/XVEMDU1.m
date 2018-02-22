XVEMDU1 ;DJB/VEDD**Templates,Description [7/19/95 9:08pm];2017-08-15  12:22 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
EN ;Templates
 I '$D(^DIBT("F"_ZNUM)),'$D(^DIPT("F"_ZNUM)),'$D(^DIE("F"_ZNUM)) D  G EX
 . W ?30,"No Templates" S FLAGG=1
 NEW A,B,DISYS,DIW,DIWI,DIWTC,DIWX,DIWT,DIWL,DIWF,DIWR,DN,HEAD,I,II,R,VAR,ZX
 S Z1="" D INIT^XVEMDPR,HD
 D DIPT G:FLAGQ EX D DIBT G:FLAGQ EX D DIE
EX ;
 Q
DIPT ;Print Templates
 S HEAD="A.)  PRINT TEMPLATES:" W !?2,HEAD,?45,"^DIPT("
 S A="",VAR="^DIPT"
 F II=1:1 S A=$O(^DIPT("F"_ZNUM,A)) Q:A=""  W !?12,$J(II,4),".  ",A S B=$O(^DIPT("F"_ZNUM,A,"")) W ?51,B W:$D(^DIPT(B,"ROU")) ?60,"Compiled: ",^DIPT(B,"ROU") I $Y>XVVSIZE D PAGE Q:FLAGQ!(Z1="S")
 I II=1 W ?55,"No print templates..."
 Q
DIBT ;Sort Templates
 S HEAD="B.)  SORT TEMPLATES:" W !!?2,HEAD,?45,"^DIBT("
 S A="",VAR="^DIBT"
 F II=1:1 S A=$O(^DIBT("F"_ZNUM,A)) Q:A=""  W !?12,$J(II,4),".  ",A W ?51,$O(^DIBT("F"_ZNUM,A,"")) I $Y>XVVSIZE D PAGE Q:FLAGQ!(Z1="S")
 I II=1 W ?55,"No sort templates..."
 Q
DIE ;Edit Templates
 S HEAD="C.)  INPUT TEMPLATES:" W !!?2,HEAD,?46,"^DIE("
 S A="",VAR="^DIE"
 F II=1:1 S A=$O(^DIE("F"_ZNUM,A)) Q:A=""  W !?12,$J(II,4),".  ",A S B=$O(^DIE("F"_ZNUM,A,"")) W ?51,B W:$D(^DIE(B,"ROU")) ?60,"Compiled: ",^DIE(B,"ROU") I $Y>XVVSIZE D PAGE Q:FLAGQ!(VAR="")
 I II=1 W ?55,"No input templates..."
 Q
PAGE ;Templates
 I VAR="^DIE" S ZX=VAR_"(""F"_ZNUM_""","""_A_""")" I $O(@ZX)="" S VAR="" Q
 I FLAGP,$E(XVVIOST,1,2)="P-" W @XVV("IOF"),!!! D HD Q
 W !! S Z1=$$CHOICE^XVEMKC("CONTINUE^SKIP^QUIT^EXIT",1)
 I "0,3,4"[Z1 S FLAGQ=1 S:Z1=4 FLAGE=1 Q
 S Z1=$S(Z1=2:"S",1:"")
 I Z1="S",VAR="^DIE" S FLAGQ=1 Q
 S ZX=VAR_"(""F"_ZNUM_""","""_A_""")"
 W @XVV("IOF") D HD I Z1="S"!($O(@ZX)="") Q
 W !?2,HEAD," continued..." Q
PAGE1 ;File Description
 I FLAGP,$E(XVVIOST,1,2)="P-" W @XVV("IOF"),!!! D HD1 Q
 D PAUSEQE^XVEMKC(2) Q:FLAGQ  W @XVV("IOF") D HD1
 Q
DES ;File Description
 I FLAGP D PRINT^XVEMDPR ;Shut off printing
 I '$D(^DIC(ZNUM,"%D")) W ?30,"No description available." S FLAGG=1 Q
 NEW A,DIW,DIWF,DIWL,DIWR,DIWT,DN,Z
 W @XVV("IOF") D HD1
 KILL ^UTILITY($J,"W")
 S A=0 F  S A=$O(^DIC(ZNUM,"%D",A)) Q:A=""  S X=^DIC(ZNUM,"%D",A,0),DIWL=5,DIWR=75,DIWF="W" D ^DIWP I $Y>XVVSIZE D PAGE1 Q:FLAGQ
 D:'FLAGQ ^DIWW
 G EX
HD ;Templates
 W !?2,"T E M P L A T E S        PRINT  *  SORT  *  INPUT",!,$E(XVVLINE,1,XVV("IOM"))
 Q
HD1 ;File description
 W !?2,"File description for ",ZNAM," file.",!,$E(XVVLINE1,1,XVV("IOM"))
 Q
