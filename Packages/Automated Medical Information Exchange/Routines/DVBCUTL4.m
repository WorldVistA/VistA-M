DVBCUTL4 ;ALB-ISC/JLU/GTS-A utility routine ;2/22/93
 ;;2.7;AMIE;**57**;Apr 10, 1995
 ;
SITE() ;returns the site's name from the amie parameter file (396.1)
 N DVBCX
 S DVBCX=$O(^DVB(396.1,0))
 I 'DVBCX Q "UNKNOWN"
 Q $P(^(DVBCX,0),U,1) ;nake on SITE+2
 ;
EXAM() ;returns the next exam .01 number in the 396.4 Exam file
 N DVBA,DVBA1
 L +^DVB(396.1,1,5):3
 I '$T Q 0 ;unable to lock parameter file node
 S DVBA=$P(^DVB(396.1,1,5),U,1)
 F DVBA1=0:0 S DVBA=DVBA+1 I '$D(^DVB(396.4,"B",DVBA)) Q
 S $P(^DVB(396.1,1,5),U,1)=DVBA
 L -^DVB(396.1,1,5)
 Q DVBA ;contains new .01 value
 ;
EXSRH(A,B,C) ;searches for the exam for a specific request.
 ;A ==> The DIC("A") prompt for 396.6
 ;B ==> An optional screen on 396.6
 ;C ==> An optional screen on 396.4
 ;
 N ERR
 DO
 .I $D(A),A]"" S DIC("A")=A
 .I $D(B),B]"" S DIC("S")=B
 .S DIC="^DVB(396.6,",DIC(0)="AEQM"
 .D ^DIC K DIC
 .I +Y<0!($D(DTOUT))!(X="")!(X=U) S ERR=-1 Q
 .I $D(C),C]"" S DIC("S")=C
 .S X=+Y,DIC="^DVB(396.4,",DIC(0)="EQ"
 .S D="ARQ"_REQDA
 .D IX^DIC K DIC,D
 I $D(ERR),ERR<0 S Y=-1
 Q Y
 ;
ROLLBCK ;  ** Sort the ^TMP global to find added exams **
 S DIK="^DVB(396.4,"
 N DVBADA,DVBAEXNM,DVBARQDT
 S (DVBADA,DVBAEXNM,DVBARQDT)=""
 S DVBARQDT=$P(^DVB(396.3,REQDA,0),U,2)
 F DVBACNT=0:0 S DVBAEXNM=$O(^TMP($J,"NEW",DVBAEXNM)) Q:DVBAEXNM=""  D LOOP2
 K DVBACNT,DVBADA,DVBAEXNM,DVBARQDT,DIK,DA
 Q
 ;
LOOP2 ;  ** Loop through 'PE' X-Ref:delete exams just added **
 F DVBADA=0:0 S DVBADA=$O(^DVB(396.4,"APE",DFN,DVBAEXNM,DVBARQDT,DVBADA)) Q:DVBADA=""  S DA=DVBADA D ^DIK
 Q
 ;
CONTMES ;  ** Continue Message to replace HANG statements **
 W !!,"   Press RETURN to continue..." R DVBCCONT:DTIME K DVBCCONT
 Q
 ;
EXMLOG1 ; ** Add exam (Called from DVBCADE2) **
 S (DIC,DIE)="^DVB(396.4,",DIC(0)=""
 K DD,DO
 S DIC("DR")=".02////^S X=REQDA;.03////^S X=$P(^TMP($J,""NEW"",EXMNM),U,1);.04////O"
 D FILE^DICN I $D(Y),(+Y>0) W:$X>40&($L(EXMNM)>30) !
 W EXMNM_" -added, " W:$X>50 !
 I $D(Y),+Y<0 W *7,"Exam addition error ! " S OUT=1 H 3 Q
 S $P(^TMP($J,"NEW",EXMNM),U,3)=+Y
 I $P(^DVB(396.3,REQDA,0),U,10)="E" DO
 .I $D(^DVB(396.3,REQDA,5)) DO  ;**Insuf 2507 entered after 2.7
 ..K DTOUT
 ..S DVBAINDA=+$P(^DVB(396.3,REQDA,5),U,1),DVBCADEX=""
 ..D INSXM^DVBCUTA1 K DVBCADEX
 .I '$D(^DVB(396.3,REQDA,5)) DO  ;**Insuf 2507 entered prior to 2.7
 ..N REASON
 ..S REASON=+$$INRSLK^DVBCUTA3
 ..I +REASON>0 DO
 ...K DIE,Y,DA,DR
 ...S DIE="^DVB(396.4,",DR=".11////^S X=REASON;80;.12"
 ...S DA=+$P(^TMP($J,"NEW",EXMNM),U,3)
 ...S DIE("NO^")="" D ^DIE K DIE,DA,DR,Y W !!
 Q  ;Quit to EXMLOG^DVBCADE2
 ;
STATCHK ; ** Check Statuses (Called from ^DVBCEDIT) **
 Q:STAT="O"  I STAT="RX" W *7,!!,"This exam has been cancelled by the RO.",!! H 2 S NCN=1 Q
 I STAT="CT" W *7,!!,"This request has been completed and transferred out.",!! H 2 S NCN=1 Q
 I STAT="C" W *7,!!,"This exam has been completed.",! S NCN=1 Q
 I STAT="X" W *7,!!,"This exam has been cancelled by MAS.",!! H 2 S NCN=1 Q
 I STAT="R" W *7,!!,"This exam has been released to the RO.",!! H 2 S NCN=1 Q
 Q
 ;
COMP ; ** Check to see if transcription completed (Called from ^DVBCEDIT) **
 K OUT Q:$P(^DVB(396.4,EXMDA,0),U,4)="C"  W !!,"Is transcription completed for this exam" S %=2 D YN^DICN I $D(DTOUT) S OUT=1 Q
 I $D(%Y),(%Y["?") W !!,"Enter Y if all information has been entered and transcription is finished",!,"or N if more information will be entered later",!! G COMP
 Q:%'=1
 K DIE,DA,DR
 S DIE="^DVB(396.4,",DA=EXMDA,DR=".04///C;90///NOW"
 D ^DIE
 Q
 ;
PAUSE ;this is a pause, only looking for a return or up arrow
 S DIR(0)="E"
 D ^DIR
 K DIR
 Q
 ;
STM ;start response clock
 I $D(XRTL) D T0^%ZOSV
 Q
 ;
SPM ;stop monitor clock
 I $D(XRT0) D T1^%ZOSV
 K XRTN
 Q
 ;
DELSER ;this subroutine will delete the server message
 S XMZ=XQMSG
 S XMSER="S."_XQSOP
 D REMSBMSG^XMA1C
 Q
 ;
PHYS(A) ; ** Question user for access to Physicians Guide **
 S DIC(0)="AEMQ^^"
 S DIC("A")="Select exam: "
 ;S DIR("?")="Enter Yes to access the Physician's Guide using Text Retreival."
 D ^DIC
 ;I +Y=1 D PHYS^A1BBTR ;Access Physician's Guide
 ;I +Y=1 D PHYS^DRSTR ;** Access Physician's Guide
 S:'$D(Y) Y=""
 K DIR,X,Y(0)
 Q Y
 ;
DATE(PAR1,PAR2) ;gets the beginning and ending dates from the users
 ;PAR1 is the beginning date
 ;PAR2 is the ending date
 ;
DATE1 S %DT("A")="Enter the beginning date: "
 S %DT="AET"
 D ^%DT
 I X="^"!($D(DTOUT)) S (PAR1,PAR2)=0 Q
 I X="" S (PAR1,PAR2)=-1 Q
 S PAR1=Y
 K %DT,Y,X,DTOUT
 S %DT("A")="Enter the ending date: "
 S %DT="AET"
 D ^%DT
 I X="^"!($D(DTOUT)) S (PAR1,PAR2)=0 Q
 I X="" S (PAR1,PAR2)=-1 Q
 S PAR2=Y
 K %DT,X,Y,DTOUT
 I PAR2<PAR1 DO  G DATE1
 .S VAR(1,0)="1,0,0,2:2,0^Beginning date must be before ending date!"
 .D WR^DVBAUTL4("VAR")
 .K VAR,PAR1,PAR2
 .Q
 Q
