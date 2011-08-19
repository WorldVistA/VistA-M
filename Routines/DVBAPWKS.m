DVBAPWKS ;ALB/CMM AMIE EXAM FILE UPDATE ;1/20/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EN ;
 N WKSCNT
 S WKSCNT=0
 D SET
 D LOOP
 D SG1
 D EXIT
 Q
SET N VAR
 S VAR=" - Adding to AMIE Exam File"
 W !!!,VAR
 D BUMPBLK^DVBAPOST
 D BUMPBLK^DVBAPOST
 D BUMPBLK^DVBAPOST
 D BUMP^DVBAPOST(VAR)
 D BUMPBLK^DVBAPOST
SET1 ;
 S DIF="^TMP($J,""DVBA"",",XCNP=0
 K ^TMP($J,"DVBA")
 F ROU="DVBAPW1","DVBAPW2" S X=ROU X ^%ZOSF("LOAD") W "."
 K DIF,XCNP,ROU
 Q
LOOP ;
 N LP,EXM,WKS
 S LP=0
 F  S LP=$O(^TMP($J,"DVBA",LP)) Q:(LP="")  D
 .K STOP
 .S LINE=^TMP($J,"DVBA",LP,0)
 .I (LINE'[";;")!(LINE[";AMIE;")!(LINE="") Q
 .S EXM=$P(LINE,";",3)
 .S WKS=$P(LINE,";",4)
 .D CHK
 .I $D(STOP) D SE Q
 .;;;D ADDW
 .D ADDE
 .W:(LP#10) "."
 Q
ADDW ;
 S DIE="^DVB(396.6,",DA=EXAM,DR=".07///"_WKS
 D ^DIE
 K DIW,DA,DR,DIE
 Q
ADDE ;
 I '$D(^DVB(396.6,EXAM,1,0)) S ^DVB(396.6,EXAM,1,0)="^396.61P^0^0"
 F LP1=5:1:999 S X=$P(LINE,";",LP1) Q:X=""  D
 .K STOP,DA
 .D SETUP
 .I $D(STOP) Q
 .S DLAYGO=396
 .K DD,DO
 .S DIC="^DVB(396.6,"_EXAM_",1,",DA(1)=EXAM,DIC(0)="LZM" D FILE^DICN
 .K DD,DO
 .I Y<0 D SE1
 .K DA,DIC,DLAYGO
 .I Y>0 S WKSCNT=WKSCNT+1
 Q
SE ;
 N VAR
 S VAR="Could not find AMIE Exam "_EXM
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
 Q
SE1 ;
 N VAR
 S VAR="Addition of exam "_X_" to "_EXM_" has failed."
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
 Q
CHK ;
 S DIC="^DVB(396.6,",DIC(0)="OZ",X=EXM,D="B"
 ;LOOKUP ONLY ON "B" CROSS REFERENCE
 D IX^DIC
 I Y<0 S STOP=1
 K DIC,X,D
 S EXAM=+Y
 Q
 ;
SG1 ;writes and updates the tmp global with the finish
 N LP1,V1
 F LP1=1:1:2 D BUMPBLK^DVBAPOST
 S V1="I have updated "_WKSCNT_" exams to the AMIE Exam file."
 W !!,V1
 D BUMP^DVBAPOST(V1)
 D BUMPBLK^DVBAPOST
 Q
EXIT ;
 K X,Y,STOP,EXAM,LINE,^TMP($J,"DVBA"),DVBAVAR
 Q
 ;
SETUP ;
 S DVBAVAR=$O(^DIC(31,"C",X,""))
 I DVBAVAR="" D SE3 S STOP=1 Q
 I '$D(^DIC(31,DVBAVAR,0)) D SE2 S STOP=1 Q
 I $O(^DVB(396.6,EXAM,1,"B",DVBAVAR,""))'="" S STOP=1 Q
 S X=DVBAVAR
 Q
 ;
SE2 ;
 N VAR
 S VAR="Zero node of the "_X_" code does not exist, AMIE Exam "_EXM_".  Please investigate!"
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
 Q
 ;
SE3 ;
 N VAR
 S VAR="'C' cross reference for code "_X_" does not exist, AMIE Exam "_EXM_".  Please investigate!"
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
 Q
