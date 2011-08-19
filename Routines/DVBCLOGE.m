DVBCLOGE ;ALB/GTS-557/THM-SET UP C&P EXAM ; 5/10/91  8:55 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;if $D(OUT), request deleted - exams must be completed
 ;
EXMHD K OUT N DVBARQDT,DVBADT,DVBADA
 W @FF,?(IOM-$L(HD2)\2),HD2
 W !!,"Please select the exams for ",$P(PNAM,",",2,99)," ",$P(PNAM,",",1)
 W !,"Use ? to see a list of exams available for selection.",!!
 I $D(^DVB(396.3,REQDA,5)),($P(^DVB(396.3,REQDA,0),"^",10)="E"&(+$P(^DVB(396.3,REQDA,5),"^",1)'>0)) DO
 .S TVAR(1,0)="0,0,0,1,0^NOTE:  This request has a priority of Insufficient without a link"
 .S TVAR(2,0)="0,8,0,1:1,0^to a completed request."
 .S TVAR(3,0)="0,0,0,1:2,0^Use care to select the proper exam(s) to return as insufficient."
 .D WR^DVBAUTL4("TVAR")
 .K TVAR
 I '$D(^DVB(396.3,REQDA,5))&($P(^DVB(396.3,REQDA,0),"^",10)="E") DO
 .S TVAR(1,0)="0,0,0,1,0^NOTE:  This request has a priority of Insufficient without a link"
 .S TVAR(2,0)="0,8,0,1:1,0^to a completed request."
 .S TVAR(3,0)="0,0,0,1:2,0^Use care to select the proper exam(s) to return as insufficient."
 .D WR^DVBAUTL4("TVAR")
 .K TVAR
 ;
EXMSEL K DIC,OUT,DVBAQT I $D(DVBCLCKD) Q
 S DVBARQDT=$P(^DVB(396.3,REQDA,0),U,2)
 I $D(^DVB(396.3,REQDA,5)),(+$P(^DVB(396.3,REQDA,5),U,1)>0) DO
 .S DVBAINDA=+$P(^DVB(396.3,REQDA,5),U,1) ;**Exam Scr for Insuff 2507'S
 .S DIC("S")="I $D(^DVB(396.4,""ARQ"_DVBAINDA_""",Y))"
 S:'$D(DIC("S")) DIC("S")="I $P(^(0),U,5)'=""I"""
 S DIC="^DVB(396.6,"
 S DIC(0)="AEQM",DIC("A")="Select EXAM: " D ^DIC
 S:$D(DTOUT) OUT=1 D:$D(OUT) KVARS Q:$D(OUT)
 G:X=""!(X=U) EXMDIS ;Only out of EXMSEL
 I +Y>0 S EXMNM=$P(^DVB(396.6,+Y,0),U,1),EXMPTR=+Y
 I +Y<0 W "  ???" G EXMSEL
 I $D(^TMP($J,"NEW",EXMNM)) W "    Duplicate - ignored",!,*7 G EXMSEL
 I $D(^DVB(396.4,"APS",DFN,EXMPTR,"O"))>0 W *7,"  -- already ON FILE",!
 I $D(^DVB(396.4,"APS",DFN,EXMPTR,"O"))>0 S DVBAQT=1
 G:$D(DVBAQT) EXMSEL
 S ^TMP($J,"NEW",EXMNM)=+Y K Y G EXMSEL
 ;
EXMDIS W @FF,!! K %,%Y,DIE,DIC G:$D(DVBCLCKD) EXMSEL
 I '$D(^TMP($J,"NEW")) W !!,*7,"You have not selected any exams.",!,"Do you want to try again" S %=1 D YN^DICN D:%=1 KVARS G:%=1 EXMHD I $D(DTOUT) S OUT=1 D KVARS Q
 I $D(%Y) I %Y["?" W !!,"Enter Y to go back and select exams or N to DELETE the entire request",!,"as well as any exams selected." D CONTMES^DVBCUTL4 G EXMDIS
 I $D(%) I %'=1 S OUT=1 D KVARS Q
 W !!,"You have selected these exams:",!! S EXMNM="" F JY=0:1 S EXMNM=$O(^TMP($J,"NEW",EXMNM)) Q:EXMNM=""  W ?5,EXMNM,!
 W !,$S(JY'>1:"Is this exam",1:"Are these exams")," correct"
 S %=2 D YN^DICN G:%=1 EXMLOG ;Only out of EXMDIS
 I $D(DTOUT) S OUT=1 D KVARS Q
 I $D(%Y),%Y["?" W !,"Enter Y to go ahead and log the selected exams or N to modify the list." D CONTMES^DVBCUTL4 G EXMDIS
 ;
EXMOD ;drop into - correct exams
 I $D(%),%=2 W @FF,!!!
 S DIC(0)="AEQM",DIC("A")="Enter EXAM to delete: "
 S DIC="^DVB(396.6,",DIC("S")="I $D(^TMP($J,""NEW"",$P(^(0),U,1)))"
 ;
EXMOD1 K OUT D ^DIC
 S:$D(DTOUT) OUT=1 D:$D(OUT) KVARS Q:$D(OUT)
 G:X=""!(X=U) EXMASK ;Only out of EXMOD1
 S EXMNM=$P(^DVB(396.6,+Y,0),U,1)
 I +Y>0&($D(^TMP($J,"NEW",EXMNM))) K ^TMP($J,"NEW",EXMNM) W "  Ok ..." H 1 G EXMOD1
 G EXMOD1
 ;
EXMASK W @FF,!!,"Want to add more exams"
 S %=1 D YN^DICN G:%=1 EXMSEL ;select more exams
 I $D(DTOUT) S OUT=1 D KVARS Q
 I $D(%Y),%Y["?" W !!,"Enter Y to add more exams or N to go on and log existing selections." D CONTMES^DVBCUTL4 G EXMASK
 G EXMDIS ;display exams
 ;
EXMLOG W !! S EXMNM="" K DR
 D STM^DVBCUTL4
 F DVBCJ=0:0 S EXMNM=$O(^TMP($J,"NEW",EXMNM)) Q:EXMNM=""  S X=$$EXAM^DVBCUTL4 S:X=0 DVBCLCKD=1 Q:$D(DVBCLCKD)  D EXMLOG1 Q:$D(OUT)
 S XRTN=$T(+0)
 D SPM^DVBCUTL4
 W:$D(DVBCLCKD) !!,"   Another user adding exams now...try again later."
 R:$D(DVBCLCKD) !,"   PRESS [Return] TO CONTINUE...",DVBCCONT:DTIME
 I $D(DVBCLCKD) D ROLLBCK^DVBCUTL4 G EXMDIS
 I $D(OUT) D KVARS Q
 H 2 K DA S DA=REQDA
 W @IOF,!,"Please enter any remarks for this request:",!!!
 S DR="23",DIE="^DVB(396.3," D ^DIE H 1
 K DIC,DIE,DR,EXMNM,DVBCDEL,Y,X,EXMPTR D KVARS
 Q
 ;
EXMLOG1 ;called by EXMLOG
 K OUT,DD,DO S (DIC,DIE)="^DVB(396.4,",DIC(0)=""
 S DIC("DR")=".02////^S X=REQDA;.03////^S X=$P(^TMP($J,""NEW"",EXMNM),U,1);.04////O"
 D FILE^DICN
 I $D(Y),+Y>0 W:$X>50 ! W:$X>40&($L(EXMNM)>30) ! W EXMNM_" -added, "
 I $D(Y),+Y<0 W *7,"Exam addition error ! " S OUT=1
 D INSXM^DVBCUTA1
 I $D(DTOUT) W *7,"Exam addition error ! " S OUT=1 D ROLLBCK^DVBCUTL4
 Q
 ;
KVARS ;Kill this routines variables
 K DVBARQDT,DVBADT,DVBADA,DVBAQT,DVBAINDA
 Q
