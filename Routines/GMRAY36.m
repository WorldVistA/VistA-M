GMRAY36 ;SLC/DAN Post-install for patch 36 ;2/1/07  13:46
 ;;4.0;Adverse Reaction Tracking;**36**;Mar 29, 1996;Build 9
 ;DBIA SECTION
 ;10063 - %ZTLOAD
 ; 3744 - $$TESTPAT^VADPT
 ;10018 - DIE
 ;10103 - XLFDT
 ;10070 - XMD
 ;10141 - XPDUTL
 ; 4631 - $$SCREEN^XTID
 ;
Q ;Entry point to queue process during install
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 S ZTRTN="DQ^GMRAY36",ZTDESC="GMRA*4*36 POST INSTALL ROUTINE",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("POST INSTALL NOT QUEUED - RUN DQ^GMRA36 AFTER INSTALL FINISHES") Q
 D BMES^XPDUTL("Post-install queued as task # "_$G(ZTSK))
 Q
 ;
DQ ;Dequeue
 N FIX,FTBP
 D ^GMRAY36A ;Set up new style xref in file 120.82
 D POST,MAIL
 Q
 ;
POST ;Post-install for patch 36
 N IEN,GMRA0,DIE,DA,DR,DFN,GMRAFT
 S GMRAFT=$O(^GMRD(120.82,"B","OTHER ALLERGY/ADVERSE REACTION",0))
 S IEN=0 F  S IEN=$O(^GMR(120.8,IEN)) Q:'+IEN  D
 .S GMRA0=$G(^GMR(120.8,IEN,0)) ;Set GMRA0 to zero node
 .Q:GMRA0=""  ;Quit if no zero node
 .Q:+$G(^GMR(120.8,IEN,"ER"))  ;Quit if entered in error
 .S DFN=$P(GMRA0,U) Q:'+DFN  ;Quit if no patient identifier
 .Q:$$TESTPAT^VADPT(DFN)  ;Quit if test patient
 .Q:$$DECEASED^GMRAFX(DFN)  ;Quit if patient is deceased
 .I $P(GMRA0,U,3)=(GMRAFT_";GMRD(120.82,") S FTBP=$G(FTBP)+1 ;Count existing free text entries
 .I '+$P(GMRA0,U,12),$P(GMRA0,U,16) S DIE=120.8,DA=IEN,DR="15///1" D ^DIE ;If not signed off and verified then mark signed off
 .I $P(GMRA0,U,3)["GMRD",+$P(GMRA0,U,3)'=GMRAFT D TYPENAME,INACT ;Check allergy type and reactant name of 120.82 entries and then check if inactive
 .I $P(GMRA0,U,3)["PSDRUG" D FILE50 ;If file 50 check for ing/drug class
 .I $D(^GMR(120.8,IEN,10)) D CHKSIGNS ;If reactions exist check for semi-colons in free text entries
 Q
 ;
MAIL ;Send message indicating post install is finished
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,GMRATXT
 S XMDUZ="PATCH GMRA*4*36 POST-INSTALL",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S XMY("DAVID.NABER@VA.GOV")="",XMY("CATHERINE.HOANG2@VA.GOV")="",XMY("THOMAS.CAMPBELL2@VA.GOV")="",XMY("HULET.LEE_ANN@FORUM.VA.GOV")=""
 S XMY("VHAOIHSITESHDRIM@MED.VA.GOV")=""
 S GMRATXT(1)="The post-install routine for patch GMRA*4*36"
 S GMRATXT(2)="finished on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S GMRATXT(3)=""
 S GMRATXT(4)="Number of free text entries before patch 36  : "_+$G(FTBP)
 S GMRATXT(5)="Allergies converted to free text by patch 36 : "_+$G(FIX)
 S GMRATXT(6)="Total number of free text allergies at site  : "_($G(FTBP)+$G(FIX))
 S GMRATXT(7)=""
 S GMRATXT(8)="Please note that patch GMRA*4*29, when installed, will automatically"
 S GMRATXT(9)="convert free text entries to a standardized entry.",GMRATXT(10)="As a result, you do not need to take any action at this point."
 S XMTEXT="GMRATXT(",XMSUB="PATCH GMRA*4*36 Post Install COMPLETED"
 D ^XMD
 Q
 ;
INACT ;If 120.82 is inactive then convert 120.8 entry to free text
 N DA,DIE,DR,GMRAAR,COM
 Q:'$$SCREEN^XTID(120.82,,(+$P(GMRA0,U,3)_","))  ;Stop if term is active
 S GMRAAR=GMRAFT_";GMRD(120.82,"
 S DA=IEN,DIE=120.8,DR="1////^S X=GMRAAR" D ^DIE
 S FIX=$G(FIX)+1 ;Increment counter
 S COM="Changed from "_$P($G(GMRA0),U,2)_" (File 120.82) to free text by patch GMRA*4*36" D ADCOM^GMRAFX(IEN,"O",COM)
 Q
 ;
TYPENAME ;Synch up allergy type
 N DA,DIE,DR
 Q:$$SCREEN^XTID(120.82,,(+$P(GMRA0,U,3)_","))  ;Stop if term is inactive
 I $P($G(^GMRD(120.82,+$P(GMRA0,U,3),0)),U,2)'=$P(GMRA0,U,20) S DR="3.1///"_$P($G(^GMRD(120.82,+$P(GMRA0,U,3),0)),U,2)
 I $P(GMRA0,U,2)'=$P($G(^GMRD(120.82,+$P(GMRA0,U,3),0)),U) S DR=$G(DR)_$S($G(DR)'="":";",1:"")_".02////"_$P($G(^GMRD(120.82,+$P(GMRA0,U,3),0)),U)
 I $D(DR) S DIE=120.8,DA=IEN D ^DIE
 Q
 ;
FILE50 ;Update to free text if no ing/drug class on file
 N DA,DIE,DR,GMRAAR,COM
 I '$O(^GMR(120.8,IEN,2,0))&('$O(^GMR(120.8,IEN,3,0))) D
 .S GMRAAR=GMRAFT_";GMRD(120.82,"
 .S DIE=120.8,DA=IEN,DR="1////^S X=GMRAAR" D ^DIE
 .S FIX=$G(FIX)+1
 .S COM="Changed from "_$P($G(GMRA0),U,2)_" (File 50) to free text by patch GMRA*4*36" D ADCOM^GMRAFX(IEN,"O",COM)
 Q
 ;
CHKSIGNS ;Check free text reactions for semicolons.  If present substitute a comma to avoid display problems
 N SUB,NAME,DR,DA,DIE
 S SUB=0 F  S SUB=$O(^GMR(120.8,IEN,10,SUB)) Q:'+SUB  D
 .I $P($G(^GMR(120.8,IEN,10,SUB,0)),U,2)[";" D
 ..S NAME=$TR($P(^(0),U,2),";",",") ;Replace ; with , naked reference to above line
 ..S DA(1)=IEN,DA=SUB,DIE="^GMR(120.8,DA(1),10,",DR="1////"_NAME D ^DIE
 Q
