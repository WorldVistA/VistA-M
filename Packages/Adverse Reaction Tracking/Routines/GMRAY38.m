GMRAY38 ;SLC/DAN Post-install for patch 38 ;5/3/07  14:53
 ;;4.0;Adverse Reaction Tracking;**38**;Mar 29, 1996;Build 2
 ;
POST ;Find varible pointers associated with IEN zero
 N TMP,IEN,FREE,REACTANT,FDA,COM
 S FREE=$O(^GMRD(120.82,"B","OTHER ALLERGY/ADVERSE REACTION",0)) Q:'FREE  S:FREE FREE=FREE_";GMRD(120.82,"
 S IEN=0 F  S IEN=$O(^GMR(120.8,IEN)) Q:'+IEN  D
 .I $E($P($G(^GMR(120.8,IEN,0)),U,3),1,2)="0;" D
 ..S $P(^GMR(120.8,IEN,0),U,3)=FREE ;Update pointer to free text entry
 ..S REACTANT=$P(^GMR(120.8,IEN,0),U,2)_" ( FREE TEXT )"
 ..S FDA(120.8,(IEN_","),.02)=REACTANT
 ..D FILE^DIE(,"FDA")
 ..S COM="Updated by patch GMRA*4*38 to free text due to bad pointer value." D ADCOM^GMRAFX(IEN,"O",COM) ;Add comment to record
 ..S TMP($P(^GMR(120.8,IEN,0),U),$P(^GMR(120.8,IEN,0),U,2))=""
 ;
MAIL ;Send message indicating post install is finished
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,GMRATXT,CNT,VADM,DFN,REACTANT,LOOP,DIFROM,NAME,REACT
 S XMDUZ="PATCH GMRA*4*38 POST-INSTALL",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S GMRATXT(1)="The post-install routine for patch GMRA*4*38"
 S GMRATXT(2)="finished on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S GMRATXT(3)=""
 S CNT=4
 I $D(TMP) D
 .S GMRATXT(CNT)="The following patients had reactants updated to free text entries",CNT=CNT+1,GMRATXT(CNT)="because of a problem with the pointer data.",CNT=CNT+1
 .S GMRATXT(CNT)="",CNT=CNT+1,GMRATXT(CNT)="Please use the Allergy Update Utility to fix these entries.",CNT=CNT+1,GMRATXT(CNT)="",CNT=CNT+1
 .S IEN=0 F  S IEN=$O(TMP(IEN)) Q:'+IEN  S NAME=$$GET1^DIQ(2,IEN,.01)_" ("_$E($$GET1^DIQ(2,IEN,.09),6,9)_")" S REACT="" F  S REACT=$O(TMP(IEN,REACT)) Q:REACT=""  D
 ..S GMRATXT(CNT)=NAME_$$REPEAT^XLFSTR(" ",(38-$L(NAME)))_REACT,CNT=CNT+1
 S XMTEXT="GMRATXT(",XMSUB="PATCH GMRA*4*38 Post Install COMPLETED"
 D ^XMD
 Q
