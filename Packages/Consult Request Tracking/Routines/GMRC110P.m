GMRC110P ;ABV/PIJ - Consult STA3N fix. Patch GMRC*3.0*110 ;8/1/18 07:36
 ;;3.0;CONSULT/REQUEST TRACKING;**110**;DEC 27, 1997;Build 6
 ;
 ;This routine locates a site's STA3N ID and places it in a GMRC UNIQUE CONSULT ID parameter.
 ;It is used by Community Care.
 ;
 Q
 ;
POST ;updates GMRC UNIQUE CONSULT ID paramater file #8989.5
 N GMRCID
 ;
 S GMRCID=$E($P($$SITE^VASITE(),U,3),1,3)
 I GMRCID="" D  Q
 .D BMES^XPDUTL()
 .D MES^XPDUTL("*****************************************")
 .D MES^XPDUTL("Your SITE ID does not exist.")
 .D MES^XPDUTL("Please contact IRM for assistance.")
 .D MES^XPDUTL("*****************************************")
 ;
 D EN^XPAR("PKG.CONSULT/REQUEST TRACKING","GMRC UNIQUE CONSULT SITE ID",,GMRCID)
 ;
 D BMES^XPDUTL()
 D MES^XPDUTL("******************************************************")
 D MES^XPDUTL("Your STATION 3N (STA3N) is "_GMRCID_" and")
 D MES^XPDUTL("has been recorded in the Parameters file.")
 D MES^XPDUTL("******************************************************")
 D BMES^XPDUTL()
 ;
 D BMES^XPDUTL("******************************************************")
 D MES^XPDUTL("Commencing conversion of existing UCIDs to "_GMRCID)
 D FIXSTA3N
 D BMES^XPDUTL("******************************************************")
 D MES^XPDUTL("End of conversion.")
 Q
 ;
FIXSTA3N ; Scroll through #123 "B" index.  Look for any entries in #80 (UCID)
 ; and if the first "_" piece does not = GMRCID, then update field #80 with this
 ; new number.
 N FMDATE,GMRCID,GMRCIEN,GMRCOUT,NEWUCID,OLDUCID,X
 N DA,DIE,DR
 ;
 S (GMRCID,GMRCIEN)=""
 S (OLDUCID,NEWUCID,X)=0
 ;
 S FMDATE="3180101"
 ;GMRCID = Parameter Name
 S GMRCID=$$GET^XPAR("PKG.CONSULT/REQUEST TRACKING","GMRC UNIQUE CONSULT SITE ID")
 ;
 F  S FMDATE=$O(^GMR(123,"B",FMDATE)) Q:FMDATE=""  D
 .S GMRCIEN=""
 .F  S GMRCIEN=$O(^GMR(123,"B",FMDATE,GMRCIEN)) Q:GMRCIEN=""  D UPDATE
 ;
 Q
 ;
UPDATE ;
 S X=$$GET1^DIQ(123,GMRCIEN,80) ; 325_883826
 I X'="" S OLDUCID=$P(X,"_",1) D
 .I OLDUCID'=GMRCID D
 ..S NEWUCID=GMRCID_"_"_GMRCIEN
 ..S DR="80///"_NEWUCID
 ..S DIE=123
 ..S DA=GMRCIEN
 ..D ^DIE
 ..K GMRCOUT D GETS^DIQ(123,GMRCIEN_",",".01;.02","E","GMRCOUT")
 ..D MES^XPDUTL($G(GMRCOUT(123,GMRCIEN_",",.01,"E"))_"  "_$G(GMRCOUT(123,GMRCIEN_",",.02,"E"))_"  From: "_OLDUCID_"_"_GMRCIEN_"  To: "_NEWUCID)
 Q
