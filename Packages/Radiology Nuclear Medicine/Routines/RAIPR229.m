RAIPR229 ;HDSO/SCL - Pre-Install patch 229; Feb 27, 2026@14:27
 ;;5.0;Radiology/Nuclear Medicine;**229**;Mar 16, 1998;Build 4
 ;
 ; Reference to EN^DIU2 in ICR #10014
 ; Reference to MES^XPDUTL in ICR #10141
 ;
 ; code based on previous CPT patch routine ^RAIRP215 from 2024
 ;
PRE ;pre-install code to execute
 ;save pre-install version of file #73.2
 N XTMP,DIU,RATXT,RAX,XTMPDT
 S XTMP="RA229 PrePatch Save",XTMPDT=$$HTFM^XLFDT(+$H)
 I $D(^XTMP(XTMP,0,XTMPDT)) D  ;Already saved today do not resave
 . S RATXT(1)=" "
 . S RATXT(2)="Previous RADIOLOGY CPT BY PROCEDURE TYPE (file #73.2) backup is already on file."
 . S RATXT(3)="Additional backup not performed"
 . D MES^XPDUTL(.RATXT)
 E  D  ; save backup before patch changes
 . S ^XTMP(XTMP,0)=$$HTFM^XLFDT(+$H+184)_"^"_XTMPDT_"^RA(73.2) (File #73.2) backup prior to RA*5*229 patch update"
 . S ^XTMP(XTMP,0,XTMPDT)="" ;Date saved
 . M ^XTMP(XTMP,XTMPDT,"RA73.2")=^RA(73.2)
 . S RATXT(1)=" "
 . S RATXT(2)="A backup of RADIOLOGY CPT BY PROCEDURE TYPE (File #73.2)"
 . S RATXT(3)="has been saved to ^XTMP("_XTMP_")."
 . S RATXT(4)="The backup will be available for 6 months"
 . D MES^XPDUTL(.RATXT)
 K RATXT
 ; 
 ; delete previous data from file #73.2
 S DIU="^RA(73.2,",DIU(0)="DT" D EN^DIU2
 S RAX=$O(^RA(73.2,0))
 I $D(^RA(73.2,0))=0,(RAX="") D
 .S RATXT(1)=" "
 .S RATXT(2)="The RADIOLOGY CPT BY PROCEDURE TYPE (#73.2) has been deleted."
 .S RATXT(3)="An updated version of file #73.2 will be installed."
 .D MES^XPDUTL(.RATXT)
 .Q
 E  D
 .S RATXT(1)=" "
 .S RATXT(2)="The RADIOLOGY CPT BY PROCEDURE TYPE (#73.2) has not been deleted."
 .S RATXT(3)="An updated version of file #73.2 will not be installed."
 .S RATXT(4)=" ",RATXT(5)="This build will not continue. Contact the national radiology"
 .S RATXT(6)="development team."
 .D MES^XPDUTL(.RATXT)
 .;stop the build; keep the transport global
 .S XPDQUIT=2
 .Q
 K DIU,RATXT,RAX,XTMP,XTMPDT
 Q
