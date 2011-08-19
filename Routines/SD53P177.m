SD53P177 ;BP-CIOFO/KEITH - Patch SD*5.3*177 utility routine ; 8/27/99 3:28pm
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;
ENV ;environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 D DOMNCHK(.XPDABORT) ;checks Q domain for HL7
 I XPDABORT="" K XPDABORT
 Q
 ;
PRE ;Pre-init
 D DFILE ;Delete entries in file #409.92
 D OPT ;Change name of option SC PCMM GUI WORKSTATI0N
 Q
 ;
DFILE ;Delete file #409.92 entries prior to install
 Q:'$D(^SD(409.92))
 N DIK,DA S DIK="^SD(409.92,",DA=0
 D BMES^XPDUTL("Deleting file #409.92 entries...")
 F  S DA=$O(^SD(409.92,DA)) Q:'DA  D ^DIK
 Q
 ;
OPT ;Rename PCMM GUI option so pre-patch177 clients may not access
 ;post-patch177 server routines.
 ;    From: SC PCMM GUI WORKSTATION
 ;      To: SCMC PCMM GUI WORKSTATION
 ;
 NEW NEW,OLD
 S NEW="SCMC PCMM GUI WORKSTATION"
 S OLD="SC PCMM GUI WORKSTATION"
 ;
 ;Quit if NEW option already exists.
 Q:$$LKOPT^XPDMENU(NEW)
 ;
 ;Rename OLD option.
 D RENAME^XPDMENU(OLD,NEW)
 ;
 D BMES^XPDUTL("Option SC PCMM GUI WORKSTATION renamed to SCMC PCMM GUI WORKSTATION")
 Q
 ;
POST ;Post-init
 D ENMAIN^SCMCCV3(21)  ;Queue the Preceptor Conversion
 D ERMT                ;edit report menu text
 D XREF                ;Reindex 404.43, field .03
 ;                     ; . queue inconsistency report
 D SITE                ;Stuff site number into file 771, field 3
 Q
 ;
ERMT ;Edit report menu text values for GUI selection
 ;
 D BMES^XPDUTL("Editing menu text values for GUI report selection...")
 N SCX,DA,DR,DIE
 S SCX(1)="Pt. List for Team Assignments"
 S SCX(2)="Detailed Patient Assignments"
 S SCX(6)="Summary Listing of Teams"
 S SCX(7)="Team Patient Listing"
 S SCX(8)="Team Member Listing"
 S DIE="^SD(404.92,",DR=".01///^S X=SCX",DA=0
 F  S DA=$O(SCX(DA)) Q:'DA  S SCX=SCX(DA) D ^DIE
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 .Q
 Q
 ;
DOMNCHK(XPDABORT) ;checks for the new Austin q-domain
 ;
 I '$$FIND1^DIC(4.2,,"QX","Q-NPQ.MED.VA.GOV","B") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Installation of this patch requires that the domain")
 .D MES^XPDUTL("Q-NPQ.MED.VA.GOV be defined (XM*999*125).  Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 .K ^TMP("DIERR",$J)
 .Q
 Q
 ;
SITE ;Put local site number in HL7 APPLICATION PARAMETER file (#771).
 NEW FAC,SCERR,SCFDA,SCIENS
 S FAC=+$P($$SITE^VASITE(),"^",3) ;Get facility number
 Q:FAC=""
 S SCIENS=$O(^HL(771,"B","PCMM",""))
 Q:'SCIENS
 S SCIENS=SCIENS_","
 S SCFDA(771,SCIENS,3)=FAC
 D FILE^DIE(,"SCFDA","SCERR")
 Q
XREF ;Queue reindexing of 404.43, field .03.
 Q:$D(^SCPT(404.43,"ACTDFN"))  ;Don't run multiple times.
 ;
 NEW SCDUZ,ZTDESC,ZTDTH,ZTIO,ZTRTN
 S SCDUZ=DUZ
 S ZTDTH=$H
 S ZTIO=""
 S ZTRTN="XREF1^SD53P177"
 S ZTSAVE("SCDUZ")=""
 S ZTDESC="PCMM Patch 177 reindexing"
 D ^%ZTLOAD
 I $D(ZTSK)[0 D  ;
 . D MES^XPDUTL("Reindexing of file 404.43 cancelled!")
 E  D  ;
 . D MES^XPDUTL("Reindexing of file 404.43 queued.")
 . D MES^XPDUTL("Generating mail message with PCMM Inconsistency Report totals.")
 Q
XREF1 ;Reindex 404.43, field .03.
 NEW DIK
 S DIK="^SCPT(404.43,"
 S DIK(1)=".03^ACTDFN2^ACTPC2"
 D ENALL^DIK
 ;
 D MAIL^SCRPV1(SCDUZ) ;Send Brief type Inconsistency Report.
 Q
