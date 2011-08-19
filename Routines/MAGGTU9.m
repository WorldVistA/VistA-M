MAGGTU9 ;WOIFO/LB/GEK - Imaging utilities assign key
 ;;3.0;IMAGING;**8,59**;Nov 27, 2007;Build 20
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
CHKKEY ;
 N NOGIVE
 S NOGIVE=1
GIVEKEY ;Give MAGDISP CLIN key to all MAG WINDOWS option holders
 ; that have neither MAGDISP CLIN nor MAGDISP ADMIN
 ;   Find the menu option's IEN
 N MKEYC,MKEYA,ERR,OPT,MAGUSER,I,KEYCLIN,KEYADMIN,KEYCT,KEYECT,XCT
 N KEYHASC,KEYHASA,KEYHASB,KEYNONE,SP,LSP
 N UCT,UTOT,OPTACC,MDOT,UDISCT
 ; This could be made Generic if ever a need, to search for users 
 ; withour either key, and assigned those users the first (KEYCLIN)
 S KEYCLIN="MAGDISP CLIN"
 S KEYADMIN="MAGDISP ADMIN"
 S KEYCT=0 ; count of number of users that were assigned the key.
 S KEYECT=0 ; count of number of errors during the assignment.
 S KEYHASC=0 ; count of number of users that already have key Clin
 S KEYHASA=0 ; count of number of users that already have key Admin
 S KEYHASB=0 ; count of number of users that Have Both keys
 S KEYNONE=0 ; count of Users that have Neither Key.
 S OPTACC=0 ; count of users with access to MAG WINDOWS.
 S UDISCT=0 ; count of Disabled Users Skipped.
 S MDOT=10000 ; print '.' to screen to show progress.
 S UCT=0 ; user count. for progress
 S UTOT=$P(^VA(200,0),"^",4)
 ;
 I $G(NOGIVE) D 
 . D MES^XPDUTL("Checking for users that have access to Option : "_"MAG WINDOWS")
 . D MES^XPDUTL("  but do not have either '"_KEYCLIN_"' or '"_KEYADMIN_"' Keys")
 . D MES^XPDUTL("  Disabled users (DISUSER=1) are skipped, they are not checked.")
 . Q
 E  D MES^XPDUTL("Assigning "_KEYCLIN_" to all users with access to Option : "_"MAG WINDOWS")
 D MES^XPDUTL("  ")
 S OPT=$$FIND1^DIC(19,"","X","MAG WINDOWS","","","ERR")
 I OPT="" D MES^XPDUTL("ERROR ",$G(ERR("DIERR",1,"TEXT",1))) Q
 I OPT=0 D MES^XPDUTL("MAG WINDOWS wasn't found in Option File") Q
 ;   Lookup the security key
 S MKEYC=$$LKUP^XPDKEY(KEYCLIN)
 S MKEYA=$$LKUP^XPDKEY(KEYADMIN)
 I ('MKEYC)!('MKEYA) D MES^XPDUTL("ERROR: Imaging Display Keys are not defined at this site") Q
 ;   Check all Users at site to see if they don't have either Clin or Admin
 D MES^XPDUTL("Checking users...")
 D MES^XPDUTL(" ")
 S I=0 F  S I=$O(^VA(200,I)) Q:'I  D
 . I $$GET1^DIQ(200,I,7,"E")]"" S UDISCT=UDISCT+1 Q
 . S UCT=UCT+1 I UCT>MDOT S MDOT=MDOT+10000 D MES^XPDUTL(UCT_" of "_UTOT_" users checked...")
 . I (($$ACCESS^XQCHK(I,OPT))>0) S OPTACC=OPTACC+1 D C(I)
 . Q
 S SP="          "
 S LSP=$L(UTOT)+3
 D MES^XPDUTL("   ")
 I $G(NOGIVE) D
 . D MES^XPDUTL($E(SP,1,LSP-$L(OPTACC))_OPTACC_" of "_UTOT_" Users have access to option MAG WINDOWS.")
 . D MES^XPDUTL($E(SP,1,LSP-$L(KEYHASB))_KEYHASB_" Users have Both Keys ")
 . D MES^XPDUTL($E(SP,1,LSP-$L(KEYHASC))_KEYHASC_" Users only have "_KEYCLIN_" key")
 . D MES^XPDUTL($E(SP,1,LSP-$L(KEYHASA))_KEYHASA_" Users only have "_KEYADMIN_" key")
 . D MES^XPDUTL($E(SP,1,LSP-$L(KEYNONE))_KEYNONE_" Users have neither Key")
 . I KEYECT>0 D MES^XPDUTL(KEYECT_" Errors during Key Assignment. See install log for details")
 . Q
 I '$G(NOGIVE) D
 . D MES^XPDUTL($E(SP,1,LSP-$L(OPTACC))_OPTACC_" of "_UTOT_" Users have access to option MAG WINDOWS.")
 . D MES^XPDUTL($E(SP,1,LSP-$L(KEYHASB))_KEYHASB_" Users already have Both Keys ")
 . D MES^XPDUTL($E(SP,1,LSP-$L(KEYHASC))_KEYHASC_" Users have Only Key "_KEYCLIN)
 . D MES^XPDUTL($E(SP,1,LSP-$L(KEYHASA))_KEYHASA_" Users have Only Key "_KEYADMIN)
 . D MES^XPDUTL($E(SP,1,LSP-$L(KEYCT))_KEYCT_" Users were assigned key: "_KEYCLIN)
 . D MES^XPDUTL("Assignment Complete.")
 . I KEYECT>0 D MES^XPDUTL(KEYECT_" Errors during Key Assignment. See install log for details")
 . Q
 Q
C(USER) ;
 ; check KEY for USER
 N DO,D1,MFDA,ZC,ZA,MIEN
 ; check to see if they have the Clin key
 S ZC=$$FIND1^DIC(200.051,","_USER_",","",KEYCLIN)
 I ZC="" D  Q
 . D MES^XPDUTL("ERROR Validating that user ("_USER_") has Key "_KEYCLIN)
 . S KEYECT=KEYECT+1
 . Q
 ; check to see if they have the Admin key
 S ZA=$$FIND1^DIC(200.051,","_USER_",","",KEYADMIN)
 I ZA="" D  Q
 . D MES^XPDUTL("ERROR Validating that user ("_USER_") has Key "_KEYADMIN)
 . S KEYECT=KEYECT+1
 . Q
 I ((+ZC)&(+ZA)) S KEYHASB=KEYHASB+1 Q
 I +ZC S KEYHASC=KEYHASC+1 Q
 I +ZA S KEYHASA=KEYHASA+1 Q
 S KEYNONE=KEYNONE+1
 I $G(NOGIVE) D  Q
 . D MES^XPDUTL("User: "_$P($G(^VA(200,USER,0)),"^")_" has neither Key")
 . Q
 S MFDA(200.051,"+1,"_USER_",",.01)=MKEYC
 S MFDA(200.051,"+1,"_USER_",",1)=DUZ
 S MFDA(200.051,"+1,"_USER_",",2)=DT
 S MIEN(1)=MKEYC_","
 D UPDATE^DIE("","MFDA","MIEN")
 I $D(DIERR) D  Q
 . D MES^XPDUTL("ERROR Assigning Key ("_KEYCLIN_") to user ("_USER_")")
 . S KEYECT=KEYECT+1
 . D CLEAN^DILF
 . Q
 S KEYCT=KEYCT+1
 D CLEAN^DILF
 Q
FLT ;  Create a Few Public Filters as a default for sites.
 ;  Only create new public filters if file is empty.
 N DIK
 I +$P(^MAG(2005.87,0),"^",3) D  Q
 . D MES^XPDUTL("The IMAGE LIST FILTERS File is not empty,")
 . D MES^XPDUTL("  Default Public Filters were not installed.")
 . Q
 S ^MAG(2005.87,1,0)="Rad All^RAD^CLIN^^^^^^0"
 S ^MAG(2005.87,1,1)="^1^.05"
 S ^MAG(2005.87,2,0)="Clin All^^CLIN^^^^^^0"
 S ^MAG(2005.87,2,1)="^1^.05"
 S ^MAG(2005.87,3,0)="Admin All^^ADMIN^^^^^^0"
 S ^MAG(2005.87,3,1)="^1^.05"
 S ^MAG(2005.87,4,0)="Clin 2 yr^^CLIN^^^^^^-24"
 S ^MAG(2005.87,4,1)="^1^.05"
 S ^MAG(2005.87,5,0)="Admin 10-10EZ All^^ADMIN^46,^^^^^0"
 S ^MAG(2005.87,5,1)="^1^.05"
 S ^MAG(2005.87,6,0)="Adv Directives^^CLIN^67^^^^^0"
 S ^MAG(2005.87,6,1)="^1^.05"
 S ^MAG(2005.87,7,0)="All^^^^^^^^0"
 S ^MAG(2005.87,7,1)="^1^.05"
 S ^MAG(2005.87,8,0)="All 2 yr^^^^^^^^-24"
 S ^MAG(2005.87,8,1)="^1^.05"
 S ^MAG(2005.87,9,0)="All 6 mth^^^^^^^^-6"
 S ^MAG(2005.87,9,1)="^1^.05"
 ;All Advance Directives^^CLIN^67^^^^^0
 S DIK="^MAG(2005.87," D IXALL^DIK
 D MES^XPDUTL("Default Public Filters added to IMAGE LIST FILTERS File.")
 Q
