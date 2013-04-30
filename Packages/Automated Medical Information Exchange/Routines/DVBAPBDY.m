DVBAPBDY ;ALB/CMM BODY SYSTEM FILE UPDATE ;1/19/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EN ;
 N BDYCNT
 S BDYCNT=0
 D SET
 D LOOP
 D SG1
 D EXIT
 Q
SET N VAR
 S VAR=" - Adding to 2507 Body System File."
 D BUMPBLK^DVBAPOST
 D BUMPBLK^DVBAPOST
 D BUMPBLK^DVBAPOST
 W !!!,VAR
 D BUMP^DVBAPOST(VAR)
 D BUMPBLK^DVBAPOST
SET1 ;
 S DIF="^TMP($J,""DVBA"",",XCNP=0
 K ^TMP($J,"DVBA")
 F ROU="DVBAPB1" S X=ROU X ^%ZOSF("LOAD") W "."
 K DIF,XCNP,ROU
 Q
LOOP ;
 N LP,LP1
 S LP=0
 F  S LP=$O(^TMP($J,"DVBA",LP)) Q:(LP="")  D
 .K STOP
 .S LINE=^TMP($J,"DVBA",LP,0)
 .I (LINE'[";;")!(LINE[";AMIE;")!(LINE="") Q
 .S BODY=$P(LINE,";",3)
 .D GET
 .I $D(STOP) Q
 .I '$D(^DVB(396.7,BODY,1,0)) S ^DVB(396.7,BODY,1,0)="^396.701P^0^0"
 .F LP1=4:1:999 S X=$P(LINE,";",LP1) Q:X=""  D
 ..K STOP
 ..D CHK
 ..I $D(STOP) Q
 ..K DA
 ..D SETUP
 ..I $D(STOP) Q
 ..K DD,DO
 ..S DLAYGO=396,DIC="^DVB(396.7,"_BODY_",1,",DA(1)=BODY,DIC(0)="LMZ" D FILE^DICN
 ..K DIC,DA,DLAYGO,DD,DO
 ..I Y<0 D SE Q
 ..W:'(LP1#10) "."
 ..S BDYCNT=BDYCNT+1
 Q
GET ;
 K DIC
 S DIC="^DVB(396.7,",X=BODY,DIC(0)="MOZ"
 D ^DIC
 I Y<0 D SE1 S STOP=1 Q
 S BODY=+Y
 Q
SE ;
 N VAR
 S VAR="Could not add code "_X_" to body system "_BODY
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
 Q
SE1 ;
 N VAR
 S VAR="Could not find body system "_BODY
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
 Q
CHK ;
 N COD,COD1
 S COD=$O(^DIC(31,"C",X,""))
 I COD="" S STOP=1 W !,"Error adding exam "_X Q
 S COD1=$O(^DVB(396.7,BODY,1,"B",COD,""))
 I COD1'="" S STOP=1
 Q
SG1 ;writes and updates the tmp global with the finish
 N LP1,V1
 F LP1=1:1:2 D BUMPBLK^DVBAPOST
 S V1="I have updated "_BDYCNT_" exams to the 2507 Body System File!"
 W !!,V1
 D BUMP^DVBAPOST(V1)
 D BUMPBLK^DVBAPOST
 Q
EXIT ;
 K X,Y,BODY,STOP,LINE,^TMP($J,"DVBA")
 Q
SETUP ;
 S DVBAVAR=$O(^DIC(31,"C",X,""))
 I '$D(^DIC(31,DVBAVAR,0)) D SE2 S STOP=1 Q
 S X=DVBAVAR
 Q
SE2 ;
 N VAR
 S VAR="Zero node of the "_X_" code does not exist.  Please investigate!"
 W !!,VAR
 D BUMP^DVBAPOST(VAR)
 Q
