GMRAY19 ;SLC/DAN Post-install for patch 19 ;5/4/04  10:24
 ;;4.0;Adverse Reaction Tracking;**19**;Mar 29, 1996
 ;DBIA SECTION
 ;10063 - %ZTLOAD
 ; 3744 - $$TESTPAT^VADPT
 ;10018 - DIE
 ;10103 - XLFDT
 ;10070 - XMD
 ;10141 - XPDUTL
 ;
Q ;Entry point to queue process during install
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 S ZTRTN="DQ^GMRAY19",ZTDESC="GMRA*4*19 POST INSTALL ROUTINE",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("POST INSTALL NOT QUEUED - RUN DQ^GMRA19 AFTER INSTALL FINISHES") Q
 D BMES^XPDUTL("Post-install queued as task # "_$G(ZTSK))
 Q
 ;
DQ ;Dequeue
 N TCNT,VCNT
 D POST,MAIL
 Q
 ;
POST ;Post-install for patch 19
 N IEN,GMRA0,GMRAV,DIE,DA,DR,VER,DFN
 S (IEN,TCNT,VCNT)=0 F  S IEN=$O(^GMR(120.8,IEN)) Q:'+IEN  D
 .S GMRA0=$G(^GMR(120.8,IEN,0)) ;Set GMRA0 to zero node
 .Q:GMRA0=""  ;Quit if no zero node
 .Q:$P(GMRA0,U,16)'=""  ;Quit if verified field set
 .Q:+$G(^GMR(120.8,IEN,"ER"))  ;Quit if entered in error
 .S DFN=$P(GMRA0,U) Q:'+DFN  ;Quit if no patient identifier
 .Q:$$TESTPAT^VADPT(DFN)  ;Quit if test patient
 .Q:$$DECEASED^GMRAFX(DFN)  ;Quit if patient is deceased
 .S TCNT=TCNT+1
 .S GMRAV="",GMRAV(0)=GMRA0
 .S VER=$$VFY^GMRASIGN(.GMRAV)
 .S DIE=120.8,DA=IEN,DR="19///"_VER S:VER DR=DR_";20///"_$$NOW^XLFDT D ^DIE
 .I VER S VCNT=VCNT+1 D ADCOM^GMRAFX(IEN,"V","Auto-verified by patch 19 post-install")
 Q
 ;
MAIL ;Send message indicating post install is finished
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,GMRATXT
 S XMDUZ="PATCH GMRA*4*19 POST-INSTALL",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S GMRATXT(1)="The post-install routine for patch GMRA*4*19"
 S GMRATXT(2)="finished on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S GMRATXT(3)=""
 I TCNT=0 D
 .S GMRATXT(4)="The post-install did not find any entries that were missing the"
 .S GMRATXT(5)="verified field.  No further action is required."
 I TCNT>0 D
 .S GMRATXT(4)="The post-install found "_TCNT_$S(TCNT=1:" entry",1:" entries")_" that were missing"
 .S GMRATXT(5)="the verified field.  "_$S(TCNT=VCNT:"All",VCNT=0:"None",1:VCNT)_" of these were auto-verified."
 .S:TCNT'=VCNT GMRATXT(6)="The remaining reactants are now available for verification",GMRATXT(7)="using allergy package options."
 S XMTEXT="GMRATXT(",XMSUB="PATCH GMRA*4*19 Post Install COMPLETED"
 D ^XMD
 Q
