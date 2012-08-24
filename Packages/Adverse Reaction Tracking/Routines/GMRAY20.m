GMRAY20 ;SLC/DAN Post-install for patch 20 ;6/22/06  10:09
 ;;4.0;Adverse Reaction Tracking;**20**;Mar 29, 1996;Build 1
 ;
POST ;Executed following installation of patch 20
 N SUB,TOP,DIK,DA
 K ^XTMP("GMRAFX") ;Remove existing free text allergy list - switching location and don't need old list
 S SUB=0 F  S SUB=$O(^GMRD(120.84,SUB)) Q:'+SUB  D
 .Q:'$D(^GMRD(120.84,SUB,1))  ;Stop if no top 10 list associated with this entry
 .S TOP=10 F  S TOP=$O(^GMRD(120.84,SUB,1,TOP)) Q:'+TOP  D
 ..S DA(1)=SUB,DA=TOP,DIK="^GMRD(120.84,"_DA(1)_",1," D ^DIK ;Delete any entries in multiple numbered above 10
 ;
FIXZERO ;Find varible pointers associated with IEN zero
 N TMP,IEN,FREE
 S FREE=$O(^GMRD(120.82,"B","OTHER ALLERGY/ADVERSE REACTION",0)) Q:'FREE  S:FREE FREE=FREE_";GMRD(120.82,"
 S IEN=0 F  S IEN=$O(^GMR(120.8,IEN)) Q:'+IEN  D
 .I $E($P($G(^GMR(120.8,IEN,0)),U,3),1,2)="0;" D
 ..S $P(^GMR(120.8,IEN,0),U,3)=FREE ;Update pointer to free text entry
 ..S TMP($P(^GMR(120.8,IEN,0),U),$P(^GMR(120.8,IEN,0),U,2))=""
 ;
MAIL ;Send message indicating post install is finished
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,GMRATXT,CNT,VADM,DFN,REACTANT,LOOP,DIFROM
 S XMDUZ="PATCH GMRA*4*20 POST-INSTALL",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S GMRATXT(1)="The post-install routine for patch GMRA*4*20"
 S GMRATXT(2)="finished on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S GMRATXT(3)=""
 S CNT=4
 I $D(TMP) D
 .S GMRATXT(CNT)="The following patients had reactants updated to free text entries",CNT=CNT+1,GMRATXT(CNT)="because of a problem with the pointer data.",CNT=CNT+1
 .S GMRATXT(CNT)="",CNT=CNT+1,GMRATXT(CNT)="Please use the Allergy Update Utility to fix these entries.",CNT=CNT+1,GMRATXT(CNT)="",CNT=CNT+1
 .S IEN=0 F  S IEN=$O(TMP(IEN)) Q:'+IEN  S NAME=$$GET1^DIQ(2,IEN,.01)_" ("_$E($$GET1^DIQ(2,IEN,.09),6,9)_")" S REACT="" F  S REACT=$O(TMP(IEN,REACT)) Q:REACT=""  D
 ..S GMRATXT(CNT)=NAME_$$REPEAT^XLFSTR(" ",(38-$L(NAME)))_REACT,CNT=CNT+1
 S XMTEXT="GMRATXT(",XMSUB="PATCH GMRA*4*20 Post Install COMPLETED"
 D ^XMD
 Q
