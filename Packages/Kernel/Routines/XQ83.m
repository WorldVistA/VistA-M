XQ83 ;SF-ISC.SEA/JLI/LUKE - FIND ^XUTL NODES NEEDING SURGERY ;04/08/2003  11:46
 ;;8.0;KERNEL;**60,157,286**;Jul 10, 1995
 Q
DQ ;TaskMan entry fired by CHEK below
 ;
 Q:'$D(^DIC(19,"AT"))  ;Nothing to do
 ;
 I $D(^DIC(19,"AXQ","P0"))=1 D  ;Somebody is rebuilding menus
 .L +^DIC(19,"AXQ","P0"):0 ;If we can lock it the flag is bogus
 .I $T L -^DIC(19,"AXQ","P0") K ^DIC(19,"AXQ","P0")
 .Q
 Q:$D(^DIC(19,"AXQ","P0"))=1
 ;
 I $D(^DIC(19,"AXQ","P0","STOP")) D
 .N X,Y,Z
 .S X=$G(^DIC(19,"AXQ","P0","STOP")) Q:X=""
 .S Y=$H
 .S Z=$$HDIFF^XLFDT(Y,X,1)
 .I Z>0 K ^DIC(19,"AXQ","P0","STOP") Q  ;Flag left over from yesterday
 .S Z=$$HDIFF^XLFDT(Y,X,2)
 .I Z>11000 K ^DIC(19,"AXQ","P0","STOP") Q  ;Flag is over 2 hours old
 .Q
 Q:$D(^DIC(19,"AXQ","P0","STOP"))  ;Rebuilding - stop micro surgery
 ;
 S ^DIC(19,"AXQ","P0","MICRO")=$H ;Set the 'I am working' flag.
 ;
 D NOW^%DTC ;Returns: %=3010706.131332, %H=58626,47612, X=3010706
 S X=% S %XQT1=X H 2
 S XQSTART=$$HTE^XLFDT($H) ;Returns: Jul 06, 2001@13:19:20
 ;
 S X1=X,X2=-21 D C^%DTC F %K=0:0 S %K=$O(^DIC(19,"AT",%K)) Q:%K'>0!(%K'<X)  K ^(%K) ;Kill of those that are 21 says old
 S X=DT+2 F  S X=$O(^DIC(19,"AT",X)) Q:X'>0  S %K="" F  S %K=$O(^DIC(19,"AT",X,%K)) Q:%K=""  K ^(%K) S ^DIC(19,"AT",$$NOW^XLFDT(),%K)=""
 ;Kill off old "AT" nodes
 ;
LOOP ;Main loop
 ;
 ;I $D(^DIC(19,"AXQ","P0","STOP")) G KILL
 K ^TMP($J) S X=%XQT,%XQX="",N=0 F %K=X:0 S %K=$O(^DIC(19,"AT",%K)) Q:%K'>0!(%K>%XQT1)  S %XQT=%K,%Z="" F %J=0:0 S %Z=$O(^DIC(19,"AT",%K,%Z)) Q:%Z=""  S N=N+1,^TMP($J,N,%Z)="",^TMP($J,"A",%Z,N)=""
 ;$O through "AT" and set up lists in ^TMP, ^TMP($J,"A" is the XREF
 ;
 I '$D(^TMP($J)) S XQN="P0",X=%XQT D H^%DTC S %XQT=%H_","_%T F %K=0:0 S XQN=$O(^XUTL("XQO",XQN)) Q:$E(XQN)'="P"  S ^(XQN,0)=%XQT
 I '$D(^TMP($J)) G KILL
 ;If nothing appears in TMP quit
 ;
 S %Z="" F %K=0:0 S %Z=$O(^TMP($J,"A",%Z)) Q:%Z=""  F N=0:0 S N=$O(^TMP($J,"A",%Z,N)) Q:N'>0  I $O(^(N))>0 K ^TMP($J,N)
 ;F N=0:0 S N=$O(^TMP($J,N)) Q:N'>0  S %Z=$O(^(N,"")),%X1=+%Z,%XC=$E(%Z,$L(%X1)+1,99),%X2=$E(%XC,2,99),XJ=$S(%XC="DIFROM":"DNUL",%XC["I":"DINS",%XC["D":"DDEL",%Z=+%Z:"DREG",%XC["S":"DSYN",%XC["P":"DPRI",1:"DNUL") D @XJ
 F XQXM=0:0 S XQXM=$O(^TMP($J,XQXM)) Q:XQXM'>0  S XQOP=$O(^(XQXM,"")),XQENT=$S(XQOP["S":"SYN",XQOP["I":"INS",XQOP["D":"DEL",XQOP["P":"PRI",1:"REG") D @XQENT
 ;solve the entry for the type of operation needs to be performed and
 ; to that code below.
 ;Remove the "AT" nodes that we processed
 F XQI=0:0 S XQI=$O(^DIC(19,"AT",XQI)) Q:(XQI'<%XQT1)!(XQI<1)  K ^(XQI)
 D NOW^%DTC S %XQT=%XQT1 S:%=0 %="" S %XQT1=X H 2
 G LOOP
 ;
DINS F %M=N:0 S %M=$O(^TMP($J,%M)) Q:%M'>0  I $D(^(%M,(%X1_"D"_%X2)))!$D(^(%X1))!$D(^(%X2)) K ^TMP($J,N) Q
 I $D(^TMP($J,N)) F %M=N:0 S %M=$O(^TMP($J,%M)) Q:%M'>0  I $D(^(%M,(%X1_"S"_%X2))) K ^TMP($J,%M)
 Q
DDEL F %M=N:0 S %M=$O(^TMP($J,%M)) Q:%M'>0  I $D(^(%M,(%X1_"I"_%X2))) K ^TMP($J,N) Q
 I $D(^TMP($J,N)) F %M=N:0 S %M=$O(^TMP($J,%M)) Q:%M'>0  I $D(^(%M,(%X1_"S"_%X2))) K ^TMP($J,%M)
 Q
DREG F %M=N:0 S %M=$O(^TMP($J,%M)) Q:%M'>0  S X=$O(^(%M,"")) I X[("I"_%X2)!(X[("S"_%X2)) K ^TMP($J,%M)
 Q
DSYN F %M=N:0 S %M=$O(^TMP($J,%M)) Q:%M'>0  S X=$O(^(%M,"")) I X=%X2!(X=(%X1_"I"_%X2)) K ^TMP($J,N) Q
 Q
DNUL K ^TMP($J,N)
DPRI Q
 ;
DEL S XQC="D" D SPLIT D ^XQ83D Q
 ;
DIFROM S XQH=%XQT D QUE^XQ81
 G KILL
 ;
INS S XQC="I" D SPLIT D ^XQ83A Q
 ;
SYN S XQC="S" D SPLIT D SYN^XQ83R Q
 ;
REG S XQC="" D REG^XQ83R Q
 ;
PRI ; Enter a new Primary menu
 S XQC="P" D SPLIT S (A,XQDIC)="P"_XQOPM,XQVE=0,XQRB=0,XQFG1=1 K XQFG L +^XUTL("XQO",A):0 D PM1^XQ8 S ^XUTL("XQO",XQDIC,0)=%XQT1 L -^XUTL("XQO",XQDIC)
 Q
 ;
SPLIT S XQOPM=+XQOP,XQOPI=+$P(XQOP,XQC,2),XQC1=XQOPM_","_XQOPI_",",XQC2=","_XQC1,XQOPI1=XQOPI_",",XQOPI2=","_XQOPI1 Q
 ;
 ;
CHEKV ;First see if the compiled menus live on this system
 ;If so fall through to CHEK, else quit (called by XQOO*)
 Q:'$D(^XUTL("XQO"))
 ;
CHEK ;See if microsurgery needs to be run here
 ;Called by XUS+25 and XUSG+18
 ;Also kicked off by the option XQKICKMICRO
 ;
 Q:'$D(^DIC(19,"AT"))  ;Nothing to do
 ;
 I $D(^DIC(19,"AXQ","P0"))=1 D  ;Somebody is rebuilding menus
 .L +^DIC(19,"AXQ","P0"):0 ;If we can lock it the flag is bogus
 .I $T L -^DIC(19,"AXQ","P0") K ^DIC(19,"AXQ","P0")
 .Q
 Q:$D(^DIC(19,"AXQ","P0"))=1
 ;
 I $D(^DIC(19,"AXQ","P0","STOP")) D
 .N X,Y,Z
 .S X=$G(^DIC(19,"AXQ","P0","STOP")) Q:X=""
 .S Y=$H
 .S Z=$$HDIFF^XLFDT(Y,X,1)
 .I Z>0 K ^DIC(19,"AXQ","P0","STOP") Q  ;Flag left over from yesterday
 .S Z=$$HDIFF^XLFDT(Y,X,2)
 .I Z>11000 K ^DIC(19,"AXQ","P0","STOP") Q  ;Flag is over 2 hours old
 .Q
 Q:$D(^DIC(19,"AXQ","P0","STOP"))  ;Rebuilding - stop micro surgery
 ;
 ;If the compiled menus do not exist on "AXQ" rebuild all of them
 S %XQH=$O(^DIC(19,"AXQ","P")) I %XQH'["P" D  Q
 .;S ^DIC(19,"AXQ","P0")=$H
 .S ZTIO="",ZTDTH=$H,ZTRTN="QUE^XQ81",ZTSAVE("DUZ")=.5
 .D SETVOL
 .D ^%ZTLOAD
 .Q
 ;
 Q:'$D(^XUTL("XQO",%XQH,0))  L ^XUTL("XQO",%XQH,0):0 I '$T K %XQH Q
 ;If the first menu has a 0th node lock it, if it won't lock quit
 N X S %H=$P(^XUTL("XQO",%XQH,0),U,1) D YMD^%DTC S:%>.001 %=%-.001 S:%=0 %="" S %XQT=X_%
 ;Get date off first entry set %XQT (looks like: 3000414.081043)
 S %XQX="",%ZO="" S:'$D(XQM) XQM=+$G(^VA(200,DUZ,201)) I XQM>0,'$D(^XUTL("XQO","P"_XQM)) S %XQX=XQM_"P",^DIC(19,"AT",%XQT+.0001,%XQX)=""
 ;Set Primary menu of this user, if not there flag it in "AT" it looks
 ;  like this: ^DIC(19,"AT",3000414.081143,9P)
 ;I $O(^DIC(19,"AT",%XQT))>0
 ;
 S ^DIC(19,"AXQ","P0","MICRO")=$H,%XQX=1
 S %TIM=$P($H,",")-1_","_$P($H,",",2)
 L -^XUTL("XQO",%XQH,0)
 ;
 ;
 S ZTDESC="MICRO UPDATING XUTL",ZTRTN="DQ^XQ83",ZTSAVE("%XQT")="",ZTSAVE("DUZ")=.5,ZTDTH=%TIM,ZTIO="" D:'$D(ZTCPU) SETVOL D ^%ZTLOAD
 ;Unlock the node and task off DQ above and quit
 ;
 Q
SETVOL ;
 X ^%ZOSF("UCI") S ZTCPU=$P(Y,",",2),ZTUCI=$P(Y,",")
 Q
 ;
KILL D REPORT^XQ84("MICRO")
 K ^DIC(19,"AXQ","P0","MICRO")
 ;
 K %,%H,%J,%K,%M,%X1,%X2,%TIM,%XQT1,%XQH,%I,%T,%XQA,%XQX,%XQT,%XQX1,%XQX2,%XQY,A,B,I,I0,%Z,%ZO
 K J,K,M,N,P,X1,X2,XQA,XQC,XQC1,XQC2,XQE,XQENT,XQK,XQOP,XQOPI,XQOPI1,XQOPI2
 K XQI,XQH,XQFG1,XQM,XQN,XQOPM,XQOPS,XQP,XQRB,XQSTART,XQVE,XQXM,Y
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
