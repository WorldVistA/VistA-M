GMRAY21 ;SLC/DAN Post-init for patch 21 ;12/23/04  12:17
 ;;4.0;Adverse Reaction Tracking;**21**;Mar 29, 1996
 ;
 ;DBIA SECTION
 ;10063 - %ZTLOAD
 ;3744  - $$TESTPAT^VADPT
 ;10013 - DIK
 ;10103 - XLFDT
 ;10070 - XMD
 ;10141 - XPDUTL
 ;
PRE ;Pre-install converts IODINE to allergy type of drug
 N DIE,DA,DR
 S DIE="^GMRD(120.82,",DA=$O(^GMRD(120.82,"B","IODINE",0)),DR="1////D"
 I DA D ^DIE
 Q
 ;
Q ;Entry point to queue process during install
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 S ZTRTN="DQ^GMRAY21",ZTDESC="GMRA*4*21 POST INSTALL ROUTINE",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("POST INSTALL NOT QUEUED - RUN DQ^GMRA21 AFTER INSTALL FINISHES") Q
 D BMES^XPDUTL("Post-install queued as task # "_$G(ZTSK))
 Q
 ;
DQ ;Dequeue
 N PROB,GMRAIOD
 D POST,IODINE,ADDB,MAIL
 Q
 ;
POST ;Post-init entry point
 N DA,GMRAI,GMRA0,LCV,DIK
 ;Check assessment level in 120.86 and make sure it makes the patient's actual assessment level
 S GMRAI=0 F  S GMRAI=$O(^GMR(120.86,GMRAI)) Q:'+GMRAI  I $P(^(GMRAI,0),U,2),$$NKASCR^GMRANKA(GMRAI) S DIK="^GMR(120.86,",DA=GMRAI D ^DIK ;Delete assessment if patient doesn't have allergies and assessment is set to "has allergies"
 ;Find entries in 120.8 that are missing the reactant or are missing additional required data and take appropriate action.
 S GMRAI=0 F  S GMRAI=$O(^GMR(120.8,GMRAI)) Q:'+GMRAI  D
 .S GMRA0=$G(^GMR(120.8,GMRAI,0))
 .I GMRA0=""!($L(GMRA0,"^")=1)!($P(GMRA0,"^",2,3)="^") S DIK="^GMR(120.8,",DA=GMRAI D ^DIK Q  ;Delete entry if no zero node or only 1 piece on zero node or missing reactant data
 .I $P(GMRA0,U,6)="o" D CHECKOBS
 ;Check observed data to make sure it's matched to the right patient
 S LCV=0 F  S LCV=$O(^GMR(120.85,LCV)) Q:'+LCV  D
 .S GMRA0=$G(^GMR(120.85,LCV,0)) Q:GMRA0=""
 .I $P(GMRA0,U,2)'=$P($G(^GMR(120.8,$P(GMRA0,U,15),0)),U) S DIK="^GMR(120.85,",DA=LCV D ^DIK
 Q
 ;
 ;
CHECKOBS ;Check observation data to make sure it's present and accurate
 N J
 Q:$D(^GMR(120.8,GMRAI,"ER"))!($$TESTPAT^VADPT($P(GMRA0,U)))!($$DECEASED^GMRAFX($P(GMRA0,U)))  ;Stop if allergy entered in error, test patient or deceased patient
 I $P(GMRA0,U,12)=1 D
 .I '$D(^GMR(120.85,"C",GMRAI)) S PROB($P(GMRA0,U),GMRAI)="OBS" Q  ;Marked as observed but no data
 .S J=0 F  S J=$O(^GMR(120.85,"C",GMRAI,J)) Q:'+J  I '$O(^GMR(120.85,J,2,0)) S PROB($P(GMRA0,U),GMRAI)="SS" ;Has observed data but no sign/symptoms
 Q
 ;
MAIL ;Send message indicating post install is finished
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,GMRATXT,DFN,PCNT,VADM,CNT,IEN
 S XMDUZ="PATCH GMRA*4*21 POST-INSTALL",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S GMRATXT(1)="The post-install routine for patch GMRA*4*21"
 S GMRATXT(2)="finished on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S GMRATXT(3)=""
 S CNT=3 I $D(PROB) D
 .S CNT=CNT+1,GMRATXT(CNT)="The following patients have observed allergy entries that are"
 .S CNT=CNT+1,GMRATXT(CNT)="signed off (accepted) but are missing required data.  Please review each"
 .S CNT=CNT+1,GMRATXT(CNT)="entry and update (if data is known), mark it as entered in error,"
 .S CNT=CNT+1,GMRATXT(CNT)="or leave it alone."
 .S CNT=CNT+1,GMRATXT(CNT)=""
 .S PCNT=0
 .F  S PCNT=$O(PROB(PCNT)) Q:'+PCNT  D
 ..S DFN=PCNT D DEM^VADPT
 ..S IEN=0 F  S IEN=$O(PROB(PCNT,IEN)) Q:'+IEN  D
 ...S CNT=CNT+1
 ...S GMRATXT(CNT)=VADM(1)_"  "_VA("BID")_"  "_$P(^GMR(120.8,IEN,0),U,2)_" missing "_$S(PROB(PCNT,IEN)="OBS":"observation date",1:"sign/symptoms")
 ..S CNT=CNT+1,GMRATXT(CNT)=""
 I $D(GMRAIOD) D
 .S CNT=CNT+1,GMRATXT(CNT)=$$REPEAT^XLFSTR("*",75),CNT=CNT+1,GMRATXT(CNT)=""
 .S CNT=CNT+1,GMRATXT(CNT)="The following patients have had their IODINE allergies updated.",CNT=CNT+1,GMRATXT(CNT)="You should review them for accuracy.",CNT=CNT+1,GMRATXT(CNT)=""
 .S DFN=0 F  S DFN=$O(GMRAIOD(DFN)) Q:'+DFN  K VADM D DEM^VADPT S CNT=CNT+1,GMRATXT(CNT)=VADM(1)_"  "_VA("BID")
 S XMTEXT="GMRATXT(",XMSUB="PATCH GMRA*4*21 Post Install COMPLETED"
 D ^XMD
 Q
 ;
IODINE ;Find existing IODINE allergies and update them
 N GMRAIODN,GMRAI,PAT,GMRAPA,GMRAAR
 S GMRAIODN=$O(^GMRD(120.82,"B","IODINE",0)) Q:'+GMRAIODN  ;No IODINE entry
 S (GMRAAR,GMRAIODN)=GMRAIODN_";GMRD(120.82,"
 S GMRAI=0 F  S GMRAI=$O(^GMR(120.8,"C","IODINE",GMRAI)) Q:'+GMRAI  D
 .S PAT=$P($G(^GMR(120.8,GMRAI,0)),U) Q:'+PAT  ;No patient
 .Q:$P($G(^GMR(120.8,GMRAI,0)),U,3)'=GMRAIODN  ;Not the one we're looking for
 .Q:$D(^GMR(120.8,GMRAI,"ER"))!($$DECEASED^GMRAFX(PAT))  ;Stop if entered in error or patient has expired
 .S GMRAPA=GMRAI
 .S DIE="^GMR(120.8,",DA=GMRAPA,DR="3.1////D" D ^DIE ;Update allergy type to drug
 .D DELMUL^GMRAFX3(2),DELMUL^GMRAFX3(3) ;Delete any existing ingredients and drug classes for this allergy
 .D UPDATE^GMRAPES1 ;add ingredients and drug classes from IODINE entry
 .S GMRAIOD(PAT)=""
 .Q
 Q
 ;
ADDB ;Add B xref to reactions multiple in 120.85
 N IEN,DA,DIK
 S IEN=0 F  S IEN=$O(^GMR(120.85,IEN)) Q:'+IEN  I $D(^GMR(120.85,IEN,2)) D
 .S $P(^GMR(120.85,IEN,2,0),U,2)="120.8502P"
 .S DA(1)=IEN,DIK="^GMR(120.85,DA(1),2," D IXALL^DIK
 Q
