GMRAY17 ;SLC/DAN Post-init for patch 17 ;10/20/03  14:24
 ;;4.0;Adverse Reaction Tracking;**17**;Mar 29, 1996
 ;
 ;DBIA SECTION
 ;10063 - %ZTLOAD
 ;3744  - $$TESTPAT^VADPT
 ;10018 - DIE
 ;10013 - DIK
 ;2056  - DIQ
 ;10103 - XLFDT
 ;10104 - XLFSTR
 ;10070 - XMD
 ;10141 - XPDUTL
 ;
Q ;Entry point to queue process during install
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 S ZTRTN="DQ^GMRAY17",ZTDESC="GMRA*4*17 POST INSTALL ROUTINE",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("POST INSTALL NOT QUEUED - RUN DQ^GMRA17 AFTER INSTALL FINISHES") Q
 D BMES^XPDUTL("Post-install queued as task # "_$G(ZTSK))
 Q
 ;
DQ ;Dequeue
 D POST,MAIL
 Q
 ;
POST ;Post-init entry point
 ;Update lower case entries
 N NAME,IEN,AIEN,DA,DIE,DR,RIEN,SIEN,ROOT,GMRAI,GMRA0,LCV,CNT,PCNT,PROB,DIK,FILE,FILEIEN
 ;Re-index 120.85 as previous bug may have left xrefs unset
 S DIK="^GMR(120.85," D IXALL^DIK
 F ROOT="^GMRD(120.82,""B"")","^GMRD(120.82,""D"")" D
 .S NAME=""
 .F  S NAME=$O(@ROOT@(NAME)) Q:NAME=""  I NAME?.E1L.E D
 ..S IEN=0 F  S IEN=$O(@ROOT@(NAME,IEN)) Q:'+IEN  I '$P(^GMRD(120.82,IEN,0),U,3) D
 ...S DIE="^GMRD(120.82,"_$S(ROOT["""D""":"DA(1),3,",1:""),DR=".01///"_$$UP^XLFSTR(NAME)
 ...I ROOT["""D""" S DA(1)=IEN,DA=$O(@ROOT@(NAME,IEN,0))
 ...I ROOT["""B""" S DA=IEN
 ...D ^DIE K DA
 ...S AIEN=0 F  S AIEN=$O(^GMR(120.8,"C",NAME,AIEN)) Q:'+AIEN  I $P(^GMR(120.8,AIEN,0),U,3)=(IEN_";GMRD(120.82,") S DIE="^GMR(120.8,",DA=AIEN,DR=".02////"_$$UP^XLFSTR(NAME) D ^DIE K DA D
 ....I $D(^GMR(120.85,"C",AIEN)) D  ;Observed reaction for this reactant
 .....S RIEN=0 F  S RIEN=$O(^GMR(120.85,"C",AIEN,RIEN)) Q:'+RIEN  D
 ......S SIEN=$O(^GMR(120.85,RIEN,3,"B",NAME,0)) Q:'+SIEN
 ......S DA(1)=RIEN,DA=SIEN,DIE="^GMR(120.85,DA(1),3,",DR=".01////^S X=$$UP^XLFSTR(NAME)" D ^DIE
 ;
 ;Find entries in 120.8 that are missing the reactant or are missing additional required data and take appropriate action.
 K DA
 S GMRAI=0 F  S GMRAI=$O(^GMR(120.8,GMRAI)) Q:'+GMRAI  D
 .I '$D(^GMR(120.8,GMRAI,0)) Q  ;Don't process if missing zero node
 .S GMRA0=$G(^GMR(120.8,GMRAI,0))
 .I $L(GMRA0,U)=1 S DIK="^GMR(120.8,",DA=GMRAI D ^DIK Q  ;Delete entry if only the 1st piece of the zero node is present
 .I $P(GMRA0,U,4)'=+$P(GMRA0,U,4) D FIXDATE
 .I $P(GMRA0,U,6)="o",$P(GMRA0,U,20)["D" D CHECKOBS
 .I $D(^GMR(120.8,GMRAI,10,"B",-1)) D FIXREACT ;If -1 is stored as reactant delete it
 .I $P(GMRA0,U,2)="",$P(GMRA0,U,3)'="" D  ;If no reactant but pointer is present then set reactant
 ..S ENTRY=$P(GMRA0,U,3)
 ..S FILE=+$P(@("^"_$P(ENTRY,";",2)_"0)"),U,2)
 ..S FILEIEN=$P(ENTRY,";")
 ..S NAME=$$GET1^DIQ(FILE,FILEIEN,$S(FILE'=50.67:.01,1:4))
 ..S DIE="^GMR(120.8,",DA=GMRAI,DR=".02////"_NAME D ^DIE
 ;Check observed data to make sure it's matched to the right patient
 S LCV=0 F  S LCV=$O(^GMR(120.85,LCV)) Q:'+LCV  D
 .S GMRA0=$G(^GMR(120.85,LCV,0)) Q:GMRA0=""
 .I $P(GMRA0,U,2)'=$P($G(^GMR(120.8,$P(GMRA0,U,15),0)),U) S DIK="^GMR(120.85,",DA=LCV D ^DIK
 Q
 ;
FIXDATE ;Update origination date to get rid of trailing zeros.  Problem was caused by a bug in XLFDT
 N DIE,DR,DA
 S DIE="^GMR(120.8,",DA=GMRAI,DR="4////"_+$P(GMRA0,U,4)
 D ^DIE
 Q
 ;
CHECKOBS ;Check observation data to make sure it's present and accurate
 Q:$D(^GMR(120.8,GMRAI,"ER"))!($$TESTPAT^VADPT($P(GMRA0,U)))!($$DECEASED^GMRAFX($P(GMRA0,U)))  ;Stop if allergy entered in error, test patient or deceased patient
 I $P(GMRA0,U,12)=1 D
 .I '$D(^GMR(120.85,"C",GMRAI)) S PROB($P(GMRA0,U),GMRAI)="OBS" Q  ;Marked as observed but no data
 .S J=0 F  S J=$O(^GMR(120.85,"C",GMRAI,J)) Q:'+J  I '$O(^GMR(120.85,J,2,0)) S PROB($P(GMRA0,U),GMRAI)="SS" ;Has observed data but no sign/symptoms
 Q
 ;
MAIL ;Send message indicating post install is finished
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,GMRATXT
 S XMDUZ="PATCH GMRA*4*17 POST-INSTALL",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S GMRATXT(1)="The post-install routine for patch GMRA*4*17"
 S GMRATXT(2)="finished on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S GMRATXT(3)=""
 S CNT=3 I $D(PROB) D
 .S CNT=CNT+1,GMRATXT(CNT)="The following patients have observed allergy entries that are"
 .S CNT=CNT+1,GMRATXT(CNT)="signed off (accepted) but are missing required data.  Please review each"
 .S CNT=CNT+1,GMRATXT(CNT)="entry and and update (if data is known), mark it as entered in error,"
 .S CNT=CNT+1,GMRATXT(CNT)="or leave it alone."
 .S CNT=CNT+1,GMRATXT(CNT)=""
 .S PCNT=0
 .F  S PCNT=$O(PROB(PCNT)) Q:'+PCNT  D
 ..S DFN=PCNT D DEM^VADPT
 ..S IEN=0 F  S IEN=$O(PROB(PCNT,IEN)) Q:'+IEN  D
 ...S CNT=CNT+1
 ...S GMRATXT(CNT)=VADM(1)_"  "_$P($P(VADM(2),U,2),"-",3)_"  "_$P(^GMR(120.8,IEN,0),U,2)_" missing "_$S(PROB(PCNT,IEN)="OBS":"observation date",1:"sign/symptoms")
 ..S CNT=CNT+1,GMRATXT(CNT)=""
 S CNT=CNT+1,GMRATXT(CNT)="You should"_$S($D(PROB):" also ",1:" ")_"run option GMRA PRINT-NOT SIGNED OFF to get a listing"
 S CNT=CNT+1,GMRATXT(CNT)="of all entries that have not yet been signed off.  These entries"
 S CNT=CNT+1,GMRATXT(CNT)="should be reviewed and updated if possible.  They can be left alone"
 S CNT=CNT+1,GMRATXT(CNT)="if additional data is unavailable."
 S XMTEXT="GMRATXT(",XMSUB="PATCH GMRA*4*17 Post Install COMPLETED"
 D ^XMD
 Q
 ;
FIXREACT ;delete any sign/symptoms erroneously stored as -1
 N DIK,DA,RIEN
 S DA(1)=GMRAI,DA=$O(^GMR(120.8,GMRAI,10,"B",-1,0)),DIK="^GMR(120.8,DA(1),10," D ^DIK
 ;Now check 120.85 for corresponding entries
 S RIEN=$O(^GMR(120.85,"C",GMRAI,0)) Q:'+RIEN
 S DA(1)=RIEN,DA=$O(^GMR(120.85,RIEN,2,"B",-1,0)),DIK="^GMR(120.85,DA(1),2," D ^DIK
 Q
