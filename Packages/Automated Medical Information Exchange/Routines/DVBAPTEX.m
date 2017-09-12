DVBAPTEX ;ALB/CMM  EXAM FILE UPDATE - POST INT ; 12 MARCH 1997
 ;;2.7;AMIE;**12**;Apr 10, 1995
 ;
 ; This is the post-in for patch 12 to add a new body system to the
 ; 2507 Body System file (396.7) and to inactivate Exams and add the
 ; new Exams into the AMIE EXAM file (396.6).
 ;
DRIVE ;
 D MES^XPDUTL("Post Init Installation:")
 D MES^XPDUTL("Updating 2507 Body System file.")
 D ^DVBAPTBD
 ; ^ update 2507 Body System file (396.7)
 D MES^XPDUTL("Updating AMIE EXAM file.")
 I '$D(^DVB(396.6)) D MES^XPDUTL("Missing file 396.6, AMIE EXAM file")
 I $D(^DVB(396.6)) D
 .D INACT
 .D LOAD
 .D LOOP
 D MES^XPDUTL("Removing Files: ")
 D MES^XPDUTL("EXAM EXCEPTION (#396.93)")
 D MES^XPDUTL("AMIE DOCUMENT (#396.91)")
 D MES^XPDUTL("AMIE DOCUMENT TABLE OF CONTENTS (#396.92)")
 D REMOVE
 Q
 ;
REMOVE ;deletes files 396.93, 396.92 and 396.92 for Physician's Guide
 ;removes data and dd
 N NAME
 F NAME="^DVBP(396.91,","^DVBP(396.92,","^DVB(396.93," D
 .S DIU=NAME,DIU(0)="D"
 .D EN^DIU2
 K DIU
 Q
 ;
LOAD ;
 S DIF="^TMP($J,""DVBAPT"",",XCNP=0
 K ^TMP($J,"DVBAPT")
 F ROU="DVBAPT1" S X=ROU X ^%ZOSF("LOAD")
 ;DVBAPT1 contains all New exams to be active after this patch
 K DIF,XCNP,ROU
 Q
 ;
LOOP ;
 K LP,EXM,WKS,ROU,PNM,BDY,STAT,LINE,NAME
 S LP=0,NUM=99
 F  S LP=$O(^TMP($J,"DVBAPT",LP)) Q:LP=""  D
 .S LINE=^TMP($J,"DVBAPT",LP,0)
 .I (LINE'[";;")!(LINE[";AMIE;")!(LINE="") Q
 .S NUM=NUM+1
 .S EXM=$P(LINE,";",3) ;current exam name
 .S NAME=$P(LINE,";",4) ;new exam name
 .S WKS=$P(LINE,";",5) ;worksheet number
 .S PNM=$P(LINE,";",6) ;print name
 .S BDY=$P(LINE,";",7) ;body system
 .S STAT=$P(LINE,";",8) ;status
 .S ROU=$P(LINE,";",9) ;routine name
 .;
 .I NAME="" S NAME=EXM ;same name
 .;
 .I STAT="A" D NEW(NUM)
 K LP,EXM,WKS,ROU,PNM,BDY,STAT,LINE,NAME,NUM
 Q
 ;
INACT ; inactivate exam
 N LOOP
 S LOOP=0
 F  S LOOP=$O(^DVB(396.6,LOOP)) Q:'LOOP  D
 .S DIE="^DVB(396.6,",DA=+LOOP,DR=".5///I"
 .D ^DIE
 .K DIE,DA,DR
 Q
 ;
NEW(EN) ; add new exam
 K DD,DO,DIC,DA
 S DIC="^DVB(396.6,",DIC(0)="LZ",X=NAME,DINUM=EN
 S DIC("DR")=".07///"_WKS_";.5///"_STAT_";2///"_BDY_";6///"_PNM_";7///"_ROU
 D FILE^DICN
 I +Y=-1,$D(^DVB(396.6,EN)) D
 .;have entry already, make sure fields are all populated correctly
 .S DA=EN,DIE="^DVB(396.6,"
 .S DR=".07///"_WKS_";.5///"_STAT_";2///"_BDY_";6///"_PNM_";7///"_ROU_";.01///"_NAME
 .D ^DIE
 .K DIE,DA,DR
 I '$D(^DVB(396.6,EN)) D MES^XPDUTL("Unable to add exam, "_NAME_", IEN= ",EN)
 K DIC,X,Y,DINUM
 Q
