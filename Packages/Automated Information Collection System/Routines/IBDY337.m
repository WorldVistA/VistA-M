IBDY337 ;ALB/DHH - PRE AND POST INSTALL FOR PATCH IBD*3*37 ; JUL 18, 2001
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**37**;APR 24, 1997
 ;
PRE ;- Create EF block list report and clear workspace before install
 D CLWKSP
 Q
 ;
 ;
POST ;- Add toolkit blocks
 D TKBLKS
 D MISC
 Q
 ;
 ;
CLWKSP ;- Clear the AICS Import/Export Workspace (files in #358) before
 ;- loading new toolkit blocks
 ;
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Clearing AICS Import/Export workspace...")
 D DLTALL^IBDE2
 D MES^XPDUTL(">>> ...completed.")
 Q
 ;
 ;
TKBLKS ;- Add GAF tool kit blocks to AICS Tool Kit
 ;
 N A,ARY,BLK,CNT,CNT1,CNTB,CNTF,EXCLUDE,FORM,FORMNM,NAME,IBDNM,IBDBLK,IBDX,IBTKBLK,NEWBLOCK,NEWFORM,NODE,NUM,ORD,SUMMARY,X,Y
 ;
 ;- Add all tool kit blocks
 S FORMNM="TOOL KIT"
 S (CNTB,CNTF)=0,NUM=1
 D BMES^XPDUTL(">>> Adding GAF Tool Kit blocks to the AICS Tool Kit...")
 ;
 ;- Display error msg and exit if Tool Kit not found
 I '$O(^IBE(357,"B",FORMNM,0)) D TKERR Q
 ;
 ;- Get blocks from Imp/Exp EF Block file
 S ORD="" F  S ORD=$O(^IBE(358.1,"D",ORD)) Q:ORD=""  S BLK=0 F  S BLK=$O(^IBE(358.1,"D",ORD,BLK)) Q:'BLK  D
 . S NAME=$P($G(^IBE(358.1,+BLK,0)),"^")
 . ;
 . ;- Not a tool kit block
 . Q:$P($G(^IBE(358.1,BLK,0)),"^",14)'=1
 . ;
 . ;- Delete block if it already exists and is a toolkit block
 . S IBTKBLK=1
 . S IBDNM="" F  S IBDNM=$O(^IBE(357.1,"B",IBDNM)) Q:IBDNM=""  S IBDBLK=0 F  S IBDBLK=+$O(^IBE(357.1,"B",IBDNM,IBDBLK)) Q:'IBDBLK  D
 .. S NODE=$G(^IBE(357.1,IBDBLK,0))
 .. I $P((NODE),"^")=NAME,$P(NODE,"^",14) D 
 ... D DLTBLK^IBDFU3(IBDBLK,"",357.1)
 . S NEWBLOCK=$$COPYBLK^IBDFU2(BLK,$$TKFORM^IBDFU2C,358.1,357.1,"","",$$TKORDER^IBDF13)
 . S CNTB=CNTB+1
 . D:$G(NEWBLOCK) DLTBLK^IBDFU3(BLK,"",358.1)
 . ;
 . ;- Add block name to array (used in summary at end)
 . S SUMMARY(NUM)=NAME
 . S NUM=NUM+1
 . ;
 . ;- Display msg to user
 . D BMES^XPDUTL(">>> Moving encounter form block "_$G(NAME)_" from")
 . D MES^XPDUTL("    AICS Import/Export files to AICS Tool Kit.")
 ;
 ;- Clear workspace
 D DLTALL^IBDE2
 D BMES^XPDUTL("... completed.")
 ;
SUMM ;- EF block summary displayed to user
 D BMES^XPDUTL("Summary of Encounter Form Blocks Added to Tool Kit:")
 D MES^XPDUTL("===================================================")
 D MES^XPDUTL("")
 F IBDX=0:0 S IBDX=$O(SUMMARY(IBDX)) Q:'IBDX  D
 . D MES^XPDUTL($G(SUMMARY(IBDX)))
 I '$D(SUMMARY) D
 . D MES^XPDUTL(">>> ERROR: Missing data in IMP/EXP ENCOUNTER FORM BLOCK file (#358.1).")
 . D MES^XPDUTL(">>> No Encounter Form Blocks were installed. Please contact National")
 . D MES^XPDUTL(">>> Vista Support for assistance.")
 Q
 ;
 ;
TKERR ;- Display error msg if Tool Kit not found
 D BMES^XPDUTL(">>> ERROR: No AICS Tool Kit found.  New encounter form blocks can not be")
 D MES^XPDUTL(">>> installed.  Please contact National Vista Support for assistance.")
 Q
 ;
 ;
MISC ;- Misc. manual sets that will not transport via kid
 ;
 ;-- add GAF SCORE HANDPRINT to HAND PRINT FIELD (359.94)
 ;
 K DO
 N DIC,X
 S DIC="^IBE(359.94,",DIC(0)="Z"
 S X="GAF SCORE HANDPRINT"
 S DIC("DR")=".02///GAF Score:;.03///5;.04///10;.06///GAF SCORE HANDPRINT;.08///GAF HAND PRINT V3.0;.1///GAF SCORE"
 D FILE^DICN
 Q
