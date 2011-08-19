ZISETDTM ;HGL::B-FmSys.Rsave;10:46 AM  21 Mar 1990;INITIALIZE DEVICE FILE FOR DATATREE ;4/9/92  14:17
 ;;7.1;KERNEL;;Jun 08, 1993
 ; ** For DataTree **
 W !,"THIS ROUTINE INITIALIZES THE DEVICE FILE WITH CURRENT PORT NUMBERS"
 W !,"OR UPDATES THE DEVICE FILE IF NEW HARDWARE HAS BEEN ADDED TO THE SYSTEM",!
 R "OK? ",X:$S($D(DTIME):DTIME,1:9999),!! I X'?1"Y".E G EXIT
 L +^%ZIS:2 W:'$T !,"FILE IS IN USE.  TRY AGAIN LATER!!!",*7 Q:'$T
 I '$D(^%ZIS(1,0)) S ^%ZIS(1,0)="DEVICE^3.5"
 I $D(^%ZIS(2,0))[0 S ^%ZIS(2,0)="TERMINAL TYPE^3.2I^2^2" D TT
 S %ZISV=$S($D(^%ZOSF("VOL")):^("VOL"),1:"")
 D FLST
QUES W !,"Please Enter a Prefix for New Devices: " W:%ZISV]"" %ZISV_"// "
 R %ZISV1:300 Q:%ZISV1="^"!'$T  S:%ZISV1="" %ZISV1=%ZISV
 I %ZISV1?1"?"."?"!(%ZISV1="") D HLP G QUES
 ;
 S TYPE="TRM",DEV=1,ZISADD=0 D CHK,ADD:ZISADD
 S TYPE="HFS" F DEV=10:1:17 S ZISADD=0 D CHK,ADD:ZISADD
 S TYPE="SPL",DEV=18,ZISADD=0 D CHK,ADD:ZISADD
 S TYPE="SDP",DEV=19,ZISADD=0 D CHK,ADD:ZISADD
 S TYPE="TRM" F DEV=30:1:200 D CHKDEV I '$D(ERR) S ZISADD=0 D CHK,ADD:ZISADD
 D C,SETCNTR
 W !!,"Device File setup completed"
EXIT ;
 L -^%ZIS K %ZISV,%ZISV1,A,I,T,X,DEV,ERR,LST,NM,TYPE,ZISADD
 Q
 ;
CHKDEV K ERR ZETRAP NODEV O DEV::0 C DEV Q
NODEV S ERR="NO SUCH DEVICE" Q
 ;
C ; Close Logic
 K ^%ZIS("C") S ^%ZIS("C")="G ^%ZISC"
 Q
SETCNTR S $P(^%ZIS(1,0),"^",3)=+LST,$P(^(0),"^",4)=T
 Q
 ;
CHK I $O(^%ZIS(1,"G","SYS."_%ZISV_"."_DEV,0))>0 Q
 I $O(^%ZIS(1,"CPU",%ZISV_"."_DEV,0))>0 Q
 I $O(^%ZIS(1,"C",DEV,0))>0 Q
 S NM=%ZISV1_DEV,ZISADD=1
 Q
ADD S LST=LST+1 G:$D(^%ZIS(1,+LST,0))#2 ADD S T=T+1
 S ^%ZIS(1,+LST,0)=NM_"^"_DEV_"^^^^^^^"_%ZISV_"^^1"
 I TYPE="TRM" S ^%ZIS(1,+LST,0)=$P(^%ZIS(1,+LST,0),"^",1,2)_"^1^1^"_$P(^(0),"^",5,99)
 I TYPE="SDP" S $P(^%ZIS(1,+LST,0),"^",4)=1
 S ^%ZIS(1,+LST,"TYPE")=TYPE
 S ^%ZIS(1,"B",NM,+LST)="",^%ZIS(1,"C",DEV,+LST)=""
 S ^%ZIS(1,"CPU",%ZISV_"."_DEV,+LST)="",^%ZIS(1,"G","SYS."_%ZISV_"."_DEV,+LST)=""
 W !,"Device ",NM," added.  TYPE=",^%ZIS(1,+LST,"TYPE")
 Q
FLST S (A,T)=0
 F I=0:0 S I=+$O(^%ZIS(1,I)) Q:I'>0  S A=I,T=T+1
 S LST=A
 Q
TT ; Define general terminal types
 S ^%ZIS(2,1,0)="C-OTHER",^(1)="80^#^24^$C(8)",^(9)="general 'dumb' video terminal"
 S ^%ZIS(2,2,0)="P-OTHER",^(1)="132^#^64^$C(8)",^(9)="General printer (132)"
 S ^%ZIS(2,"B","C-OTHER",1)="",^%ZIS(2,"B","P-OTHER",2)=""
 Q
HLP ;HELP FOR PREFIX QUESTION
 W !,"There must be a prefix for a new devices"
 W !,"because the Device Name and the $I cannot"
 W !,"be the same."
 Q
