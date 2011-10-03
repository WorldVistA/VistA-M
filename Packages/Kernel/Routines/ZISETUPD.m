ZISETUPD ;SF/GFT,AC - INITIALIZE DEVICE FILE FOR DSM;4/20/88  8:26 PM ;4/9/92  14:19
 ;;7.1;KERNEL;;Jun 08, 1993
 W !,"THIS ROUTINE INITIALIZES THE DEVICE FILE WITH CURRENT PORT NUMBERS",!
 R "OK? ",X:9999,!! G EXIT:X'?1"Y".E
 L +^%ZIS:2 W:'$T !,"FILE IS IN USE.  TRY AGAIN LATER!!!",*7 Q:'$T
 I '$D(^%ZIS(1,0)) S ^%ZIS(1,0)="DEVICE^3.5"
 S T=$P(^(0),"^",4),M=^%ZOSF("MGR"),%ZISV=$S($D(^%ZOSF("VOL")):^("VOL"),1:"") D FLST
QUES I %ZISV]"" W !,"Please Enter a Prefix for New Devices: "_%ZISV_"//" R %ZISV1:$S($D(DTIME):DTIME,1:300) G EXIT:%ZISV1="^"!'$T S:%ZISV1="" %ZISV1=%ZISV I %ZISV1?1"?"."?" D HLP G QUES
 F I=1,3:1:7,64:1:127 I $D(^[M]SYS(^[M]SYS(0,"RUNNING"),"TTY",I)) D CHK
 F I=47,60 D CHK
C K ^%ZIS("C") S ^%ZIS("C")="G ^%ZISC"
 W !!,"ALL SETUP" L -^%ZIS
EXIT K %ZISV,%ZISV1,A,I,LST,M,NM,T,X,Z Q
 ;
CHK Q:$S(%ZISV]"":$S($O(^%ZIS(1,"G","SYS."_%ZISV_"."_I,0))>0:1,$O(^%ZIS(1,"CPU",%ZISV_"."_I,0))>0:1,1:0),$O(^%ZIS(1,"C",I,0))>0:1,1:0)  S NM=$S(I=47:"MT",I=60:"SDP",1:I)
ADD I %ZISV]"" S LST=LST+1 G:$D(^%ZIS(1,+LST,0))#2 ADD S T=T+1,^%ZIS(1,"C",I,+LST)="",^%ZIS(1,+LST,0)=%ZISV1_NM_"^"_I_"^1^1^^^^^"_%ZISV_"^^1",^("TYPE")=$S(I=47:"MT",I=60:"SDP",1:"TRM"),^%ZIS(1,"B",%ZISV1_NM,+LST)="" D SETCNTR Q
ADD1 S LST=LST+1 G:$D(^%ZIS(1,+LST,0))#2 ADD1 S T=T+1,^%ZIS(1,"C",I,+LST)="",^%ZIS(1,+LST,0)=NM_"^"_I_"^1^1",^("TYPE")=$S(I=47:"MT",I=60:"SDP",1:"TRM"),^%ZIS(1,"B",NM,+LST)="",$P(^%ZIS(1,0),"^",3)=+LST,$P(^(0),"^",4)=T Q
 Q
SETCNTR S ^%ZIS(1,"CPU",%ZISV_"."_I,+LST)="",^%ZIS(1,"G","SYS."_%ZISV_"."_I,+LST)="",$P(^%ZIS(1,0),"^",3)=+LST,$P(^(0),"^",4)=T Q
FLST S X=$S($D(^%ZIS(1,0)):$P(^(0),"^",3),1:0),A=+X
 F I=+X:0 S I=+$O(^%ZIS(1,I)) Q:I'>0  S A=I
 S LST=A Q
HLP ;HELP FOR PREFIX QUESTION
 W !,"There must be a prefix for a new device"
 W !,"becuase the Device Name and the $I cannot"
 W !,"be the same." Q
