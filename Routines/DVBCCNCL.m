DVBCCNCL ;ALB/GTS-557/THM-2507 CANCEL REQUESTS ,EXAMS ; 9/23/91  9:25 AM
 ;;2.7;AMIE;**102**;Apr 10, 1995
 ;
 G EN
LOOK1 S EXAM=$S($D(^DVB(396.6,$P(^DVB(396.4,JZ,0),U,3),0)):$P(^(0),U,1),1:"Unknown")
 S STAT=$P(^DVB(396.4,JZ,0),U,4)
 S $P(^TMP($J,EXAM),U,1)=STAT_U_JZ S:STAT="C" TCNCL=1 S:STAT="T" TCNCL=2
 Q
 ;
EN ;
 D HOME^%ZIS S FF=IOF,HD="2507 Exam Veteran Selection",HD2="2507 Test Cancellation"
 ;
LOOK D KILL W @FF,!?(IOM-$L(HD)\2),HD,!?(IOM-$L(HD2)\2),HD2,!! S DIC("W")="D DICW^DVBCUTIL" S DIC="^DVB(396.3,",DIC(0)="AEQM",DIC("A")="Select VETERAN: " D ^DIC G:X=""!(X=U) EXIT I +Y<0 W *7,"  ???" G LOOK
 S DA(1)=+Y,DFN=$P(Y,U,2),STAT=$P(^DVB(396.3,DA(1),0),U,18) D STATCHK G:$D(NCN) LOOK S REQDT=$P(^DVB(396.3,DA(1),0),U,2)
 I '$D(^DPT(DFN,0)) W *7,!!,"Zeroth node for ^DPT record missing!",!! H 3 G LOOK
 S PNAM=$P(^DPT(DFN,0),U,1),SSN=$P(^(0),U,9),CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown") K DICW
 S REQRO=$P(^DVB(396.3,DA(1),0),U,3),REQSTR=$P(^(0),U,4) ;used to screen bulletins
 K TCNCL F JZ=0:0 S JZ=$O(^DVB(396.4,"C",DA(1),JZ)) Q:JZ=""  D LOOK1
 ;
ASK I $D(TCNCL) W *7,!!,"This request cannot be cancelled entirely because",!," one or more exams have ",$S(TCNCL=2:"been transferred.",1:"been completed.")
 I  W !!,"However, you may cancel other individual exams.",!!,"Press RETURN " R ANS:60 G:'$T!(ANS="^") EXIT G DATA
 W !!,"Do you want to cancel the entire exam" S %=2 D YN^DICN G:$D(DTOUT)!(%<0) EXIT G:%=1 ^DVBCCNC1
 I $D(%Y),%Y["?" W !!,"Enter Y to cancel the ENTIRE exam or N to cancel ONLY selected exams",!! G ASK
 ;
DATA K EXMPTR,NCN
 D HDR^DVBCUTIL
EXMSEL S REQDA=DA(1),Y=$$EXSRH^DVBCUTL4("Select EXAM TO CANCEL: ","I $D(^DVB(396.4,""ARQ""_REQDA,+Y))") ;*Exam lookup function call
 K DIC("S"),REQDA
 G:$D(DTOUT) EXIT I X=""!(X=U)&($D(CANC)) D BULL^DVBCCNC1 G LOOK
 I $D(X),X=""!(X=U)&('$D(CANC)) G LOOK
 I Y=-1 W *7,"  ??" G EXMSEL  ;DVBA*2.7*102
 I ($P(^DVB(396.4,+Y,0),U,4)["X")!($P(^DVB(396.4,+Y,0),U,4)="T") W *7," ??" G EXMSEL
 S EXMPTR=+Y,EXMNM=$P(^DVB(396.4,+Y,0),U,3)
 S EXMNM=$S($D(^DVB(396.6,EXMNM,0)):$P(^(0),U,1),1:"Unknown exam")
 S STAT=$P(^TMP($J,EXMNM),U,1) D STATCHK G:$D(NCN) DATA
 D CNCLCHK G:NOFND=0 DATA G:$D(OUT) EXIT
 ;
 ;  ** If selected an exam, enter Cancellation Reason.
 S DVBCMSG=" for this "_EXMNM_" exam:",EXMCNC="" D CODE G:$D(OUT) EXIT
 S DR="52R;.04////"_CCODE_";51////^S X=DUZ;50///NOW",DIE="^DVB(396.4,"
 S DA=EXMPTR D ^DIE K DR,DIE G:($D(Y))!($D(DTOUT)) EXIT
 S STAT=$P(^DVB(396.4,DA,0),U,4),REASON=+$P(^DVB(396.4,DA,"CAN"),U,3)
 G:REASON=0 LOOK S $P(^TMP($J,EXMNM),U,1)=STAT
 S ^TMP("DVBA",$J,9999999-$P(^DVB(396.4,EXMPTR,"CAN"),U,1))=CCODE
 S CANC(EXMNM)=STAT_U_REASON D CNCLCHK I $D(OUT) G EXIT
 K %DT G DATA
 ;
EXIT D KILL K CCODE,DVBCMSG,TCNCL,^TMP($J),EXMPTR,J G KILL^DVBCUTIL
 ;
KILL K TCNCL,DIC,DA,D0,D1,DFN,X,Y,OLDEXAM,JDR,REQDT,DR,EXMNM,NCN,STAT,%,NOFND,CANC,^TMP($J),%Y,Z,JY,JZ,DA,DIC,DIE,ALLCANC
 Q
 ;
CNCLCHK S NOFND=0,Z=$P(^DVB(396.3,DA(1),0),U,18) Q:Z="X"!(Z="RX")  K Z S I="" F J=0:0 S I=$O(^TMP($J,I)) Q:I=""  I $P(^TMP($J,I),U,1)'="X"&($P(^(I),U,1)'="RX") S NOFND=1
 Q:NOFND=1  W *7,!!,"Since all exams have been cancelled",!,"the entire request will be CANCELLED.",!! H 3
 S DVBCMSG=" for this request:" D CODE
 S DR="17////"_CCODE_";19///NOW;20////^S X=DUZ"
 S DA=DA(1),DIE="^DVB(396.3," D ^DIE S DA=DA(1) D NOTIFY^DVBCCNC1
 Q
 ;
STATCHK Q:STAT="P"!(STAT="N")!(STAT="NT")!(STAT="S")!(STAT="O")
 W !!,*7,"This exam or request has been ",$S(STAT="RX":"cancelled by the RO",STAT="X":"cancelled by MAS",STAT="T":"transcribed",STAT="R":"released",STAT="C":"completed",STAT="CT":"completed, transferred out",1:"given an incorrect status"),".",!!
 S NCN=1 H 2 Q
 ;NCN=no can do
 Q
 ;
CODE S:'$D(DVBCMSG) DVBCMSG=":" W @IOF,!,"Please enter cancellation code"_DVBCMSG,! K OUT,%
 S DIR("A")="CANCELLED BY"
 S:'$D(EXMCNC) DIR(0)="SO^X:MAS CANCELLATION;RX:REGIONAL OFFICE CANCELLATION"
 S:$D(EXMCNC) DIR(0)="S^X:MAS CANCELLATION;RX:REGIONAL OFFICE CANCELLATION"
 D ^DIR S CCODE=Y
 I CCODE=U&('$D(EXMCNC)) W !!,*7,"NO '^' ALLOWED AT THIS PROMPT" D CONTMES^DVBCUTL4 G CODE
 I $D(DTOUT) D RQCODE^DVBCUTL2 S OUT=1 Q
 I (X=""&('$D(EXMCNC))) W !,*7,"This is a required response." D CONTMES^DVBCUTL4 G CODE
CNCBY W !!,*7,"CANCELLED BY ",$S(CCODE="X":"MAS",CCODE="RX":"RO",1:"???"),", OK" S %=2 D YN^DICN I %=2 G CODE
 I %=-1&('$D(EXMCNC)&('$D(DTOUT))) W !!,*7,"NO '^' ALLOWED AT THIS PROMPT" D CONTMES^DVBCUTL4 G CNCBY
 K EXMCNC
 I $D(DTOUT) D BULL^DVBCCNC1 S OUT=1 Q
 Q
