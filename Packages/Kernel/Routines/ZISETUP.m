ZISETMSM ;IHS/MJ,ACC, SFISC/AC -- INITIALIZE DEVICE FILE FOR MSM-68 [ 05/02/89  4:42 PM ] ;4/9/92  14:17
 ;;8.0;KERNEL;;JUL 10, 1995
 S %PC=$ZV["MSM-PC"
 W !,"THIS ROUTINE TAKES INITIALIZES THE DEVICE FILE WITH CURRENT PORT NUMBERS",!
 R "OK? ",X,!! G:X'?1"Y".E EXIT
 L +^%ZIS:2 W:'$T !,"FILE IS IN USE.  TRY AGAIN LATER!!!",*7 Q:'$T
 I '$D(^%ZIS(1,0)) S ^%ZIS(1,0)="DEVICE^3.5"
 S T=$P(^(0),"^",4),M=^%ZOSF("MGR"),%ZISV=$S($D(^%ZOSF("VOL")):^("VOL"),1:"") D FLST
QUES I %ZISV]"" W !,"Please Enter a Prefix for New Devices: "_%ZISV_"//" R %ZISV1:$S($D(DTIME):DTIME,1:300) G EXIT:%ZISV1="^"!'$T S:%ZISV1="" %ZISV1=%ZISV I %ZISV1?1"?"."?" D HLP G QUES
SYS S TYPE="",CONFIG=$P(^SYS("CONFIG"),";",1),CONFIG=+^SYS("CONFIG",CONFIG) ;DEFAULT SUBSCRIPTS TTY=0
 S TTY=0
DDB S TTY=$O(^SYS(CONFIG,"DDB",TTY)) I TTY'="" S DEF=^(TTY),I=TTY D CHK G DDB
HFS ;INITIALIZE HOST FILE SERVER
 S TYPE="HFS" F I=51:1:$S(%PC:52,1:54) D CHK
 ;S ^(0)=$P(^%ZIS(1,0),"^",1,2)_"^^"_TL
C K ^%ZIS("C") S ^%ZIS("C")="G ^%ZISC"
 W !!,"ALL SETUP" G EXIT
CHK Q:$S(%ZISV]"":$S($O(^%ZIS(1,"G","SYS."_%ZISV_"."_I,0))>0:1,$O(^%ZIS(1,"CPU",%ZISV_"."_I,0))>0:1,1:0),$O(^%ZIS(1,"C",I,0))>0:1,1:0)  S NM=$S(I=47:"MT",I=60:"SDP",1:I)
ADD I %ZISV]"" S LST=LST+1 G:$D(^%ZIS(1,+LST,0))#2 ADD S T=T+1,^%ZIS(1,"C",I,+LST)="",^%ZIS(1,+LST,0)=%ZISV1_NM_"^"_I_"^1^1^^^^^"_%ZISV_"^^1",^("TYPE")=$S(I=47:"MT",I=60:"SDP",1:"TRM"),^%ZIS(1,"B",%ZISV1_NM,+LST)="" D SETCNTR Q
ADD1 S LST=LST+1 G:$D(^%ZIS(1,+LST,0))#2 ADD1 S T=T+1,^%ZIS(1,"C",I,+LST)="",^%ZIS(1,+LST,0)=NM_"^"_I_"^1^1"
 S ^("TYPE")=$S(I=47:"MT",I>58&(I<63):"SDP",TYPE="HFS":"HFS",1:"TRM"),^%ZIS(1,"B",NM,+LST)="",$P(^%ZIS(1,0),"^",3)=+LST,$P(^(0),"^",4)=T Q
 Q
SETCNTR S ^%ZIS(1,"CPU",%ZISV_"."_I,+LST)="",^%ZIS(1,"G","SYS."_%ZISV_"."_I,+LST)="",$P(^%ZIS(1,0),"^",3)=+LST,$P(^(0),"^",4)=T Q
EXIT ;
 L -^%ZIS K %PC,CONFIG,DEF,LST,M,NAME,NM,T,TTY,TYPE,X
 Q
PEND K %,%F,%GBN,%GLB,%MAX,%OF,%UI,%USZ,%UT,%X,CC,GN,I,K,KEY,OF,TFL,TYP,UC
 Q
FLST S X=$S($D(^%ZIS(1,0)):$P(^(0),"^",3),1:0),A=+X
 F I=+X:0 S I=+$O(^%ZIS(1,I)) Q:I'>0  S A=I
 S LST=A Q
HLP ;HELP FOR PREFIX QUESTION
 W !,"There must be a prefix for a new device"
 W !,"becuase the Device Name and the $I cannot"
 W !,"be the same." Q
