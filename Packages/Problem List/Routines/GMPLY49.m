GMPLY49 ;ISP/TC - Pre/Post Install Routine for GMPL*2.0*49 ;08/23/17  08:15
 ;;2.0;Problem List;**49**;Aug 25, 1994;Build 43
 ;
 ; External References:
 ;   ICR  872    PROTOCOL FILE #101
 ;   ICR  1157   OUT^XPDMENU
 ;   ICR  2051   $$FIND1^DIC
 ;   ICR  2053   FILE^DIE
 ;   ICR  10014  EN^DIU2
 ;   ICR  10104  $$LJ/$$UP^XLFSTR
 ;   ICR  10141  BMES/MES/PATCH^XPDUTL
 ;   ICR  10156  OPTION FILE #19
 ;
ASGNRPT ; Retrieve pre-existing user/clinic selection list assignment report
 N GMPLULST,GMPLCLST,GMPLELST,GMPLTXT
 D GETUSRLT^GMPLSLRP(.GMPLULST,.GMPLELST)
 D GETCLNLT^GMPLSLRP(.GMPLCLST)
 I $D(GMPLULST)!($D(GMPLCLST))!($D(GMPLELST)) D
 . D SENDARPT(.GMPLULST,.GMPLCLST,.GMPLELST)
 . D MES^XPDUTL("  Report has been generated to the installer & OR CACS mailgroup via MailMan.")
 E  D MES^XPDUTL("  No pre-existing USER or CLINIC selection list assignments found.")
 I $D(GMPLELST) D
 . N GMPLUSR,GMPLLST,GMPLFDA,GMPLDUZ,GMPLMSG,GMPLSUC
 . S (GMPLUSR,GMPLLST)="",GMPLSUC=1
 . D BMES^XPDUTL("  Removing invalid USER selection list assignments for...")
 . F  S GMPLUSR=$O(GMPLELST(GMPLUSR)) Q:GMPLUSR=""  D
 . . F  S GMPLLST=$O(GMPLELST(GMPLUSR,GMPLLST)) Q:GMPLLST=""  D
 . . . D MES^XPDUTL("     "_GMPLUSR_": Invalid Selection List #"_GMPLLST_"")
 . . . S GMPLDUZ=$G(GMPLELST(GMPLUSR,GMPLLST))
 . . . S GMPLFDA(200,""_GMPLDUZ_",",125.1)="@"
 . . . D FILE^DIE("K","GMPLFDA","GMPLMSG")
 . . . I $D(GMPLMSG) S GMPLSUC=0 D MES^XPDUTL("     Error: "_GMPLMSG("DIERR",1,"TEXT",1))
 . I GMPLSUC D MES^XPDUTL("  Done.")
 K GMPLULST,GMPLCLST,GMPLELST
 Q
 ;
CASECHK ; Check for mixed/lower case list/category name entries
 N GMPLLIST,GMPLCAT,GMPLLNM,GMPLCNM,GMPLLDA,GMPLCDA,GMPLMSG,GMPLFDA,GMPLERR,GMPLTXT
 S (GMPLLNM,GMPLCNM,GMPLLDA,GMPLCDA)=""
 F  S GMPLLNM=$O(^GMPL(125,"B",GMPLLNM)) Q:GMPLLNM=""  D
 . F  S GMPLLDA=$O(^GMPL(125,"B",GMPLLNM,GMPLLDA)) Q:GMPLLDA=""  D
 . . I $$MIXLOWCS^GMPLX(GMPLLNM) D
 . . . S GMPLFDA(125,""_GMPLLDA_",",.01)=$$UP^XLFSTR(GMPLLNM)
 . . . D FILE^DIE("EK","GMPLFDA","GMPLMSG")
 . . . I $D(GMPLMSG) D
 . . . . S GMPLLIST("FAIL",GMPLLNM)="Record #"_GMPLLDA_U_"Error: "_GMPLMSG("DIERR",1,"TEXT",1)
 . . . . K GMPLMSG
 . . . E  S GMPLLIST("PASS",GMPLLNM)=""
 F  S GMPLCNM=$O(^GMPL(125.11,"B",GMPLCNM)) Q:GMPLCNM=""  D
 . F  S GMPLCDA=$O(^GMPL(125.11,"B",GMPLCNM,GMPLCDA)) Q:GMPLCDA=""  D
 . . I $$MIXLOWCS^GMPLX(GMPLCNM) D
 . . . S GMPLFDA(125.11,""_GMPLCDA_",",.01)=$$UP^XLFSTR(GMPLCNM)
 . . . D FILE^DIE("EK","GMPLFDA","GMPLERR")
 . . . I $D(GMPLERR) D
 . . . . S GMPLCAT("FAIL",GMPLCNM)="Record #"_GMPLCDA_U_"Error: "_GMPLERR("DIERR",1,"TEXT",1)
 . . . . K GMPLERR
 . . . E  S GMPLCAT("PASS",GMPLCNM)=""
 I $D(GMPLLIST)!($D(GMPLCAT)) D
 . D SENDCRPT(.GMPLLIST,.GMPLCAT)
 . S GMPLTXT(1)="  A mixed & lower case list/category name report has been generated to the"
 . S GMPLTXT(2)="  installer and OR CACS mailgroup via MailMan."
 . D BMES^XPDUTL(.GMPLTXT)
 E  D MES^XPDUTL("  No mixed or lower case list/category names found.")
 K GMPLLIST,GMPLCAT,GMPLMSG
 Q
 ;
DUPCHK ; Check for duplicate selection list/category entry names
 N GMPLSLST,GMPLCLST,GMPLDUPL,GMPLDUPC,GMPLLNM,GMPLCNM,GMPLTXT,GMPLIEN,GMPLDA
 S (GMPLLNM,GMPLCNM)="",GMPLSLST("0")="",GMPLCLST("0")="",(GMPLIEN,GMPLDA)=0
 F  S GMPLLNM=$O(^GMPL(125,"B",GMPLLNM)) Q:GMPLLNM=""  D
 . F  S GMPLIEN=$O(^GMPL(125,"B",GMPLLNM,GMPLIEN)) Q:'GMPLIEN  D
 . . I $$DUPL(.GMPLSLST,GMPLLNM) S GMPLDUPL(GMPLLNM)=""
 . . S GMPLSLST(GMPLLNM)=""
 F  S GMPLCNM=$O(^GMPL(125.11,"B",GMPLCNM)) Q:GMPLCNM=""  D
 . F  S GMPLDA=$O(^GMPL(125.11,"B",GMPLCNM,GMPLDA)) Q:'GMPLDA  D
 . . I $$DUPL(.GMPLCLST,GMPLCNM) S GMPLDUPC(GMPLCNM)=""
 . . S GMPLCLST(GMPLCNM)=""
 I $D(GMPLDUPL)!($D(GMPLDUPC)) D
 . D SENDDRPT(.GMPLDUPL,.GMPLDUPC)
 . S GMPLTXT(1)="  A duplicate list/category name report has been generated to the installer"
 . S GMPLTXT(2)="  and OR CACS mailgroup via MailMan."
 . D BMES^XPDUTL(.GMPLTXT)
 E  D MES^XPDUTL("  No duplicate list/category names found.")
 K GMPLSLST,GMPLCLST,GMPLDUPL,GMPLDUPC
 Q
 ;
DUPL(GMPLARY,GMPLENT) ; Check if GMPLENT is a duplicate in GMPLARY
 N GMPLSUB,GMPLRSLT S GMPLSUB="",GMPLRSLT=0
 F  S GMPLSUB=$O(GMPLARY(GMPLSUB)) Q:GMPLSUB=""  D
 . I $$UP^XLFSTR(GMPLENT)=$$UP^XLFSTR(GMPLSUB) S GMPLRSLT=1 Q
 Q GMPLRSLT
 ;
POST ; Post-install subroutine
 N GMPLOPT,GMPLOTXT
 D BMES^XPDUTL("  Scanning for duplicate Problem Selection list/category names...")
 D DUPCHK
 D BMES^XPDUTL("  Marking GMPL CODE LIST menu option out of order...")
 S GMPLOPT="GMPL CODE LIST",GMPLOTXT="This option is obsolete and disabled."
 D OUT^XPDMENU(GMPLOPT,GMPLOTXT),MES^XPDUTL("  Done.")
 D UPCHKMNU
 D BMES^XPDUTL("  Updating display order of several items for GMPL BUILD LIST MENU option...")
 D UPDTDORD
 D BMES^XPDUTL("  Resequencing GMPL MENU BUILD GROUP protocol menu items...")
 D RSEQPROT
 Q:$$PATCH^XPDUTL("GMPL*2.0*49")
 D EN^GMPLY49A
 Q
 ;
PRE ; Pre-install subroutine
 ; Remove old data dictionary for the Problem Selection List Files
 N DIU
 D BMES^XPDUTL("  Retrieving pre-existing USER/CLINIC selection list assignment report...")
 D ASGNRPT
 D BMES^XPDUTL("  Scanning for mixed or lower case Problem Selection list/category names...")
 D CASECHK
 D BMES^XPDUTL("  Removing old PROBLEM SELECTION LIST file #125 data dictionary...")
 S DIU(0)=""
 S DIU=125
 D EN^DIU2 K DIU
 D MES^XPDUTL("  Data dictionary for file #125 removed.")
 N DIU
 D BMES^XPDUTL("  Removing old PROBLEM SELECTION CATEGORY file #125.11 data dictionary...")
 S DIU(0)=""
 S DIU=125.11
 D EN^DIU2 K DIU
 D MES^XPDUTL("  Data dictionary for file #125.11 removed.")
 I $D(^GMPL(125,0)) S $P(^GMPL(125,0),U,3)=0
 I $D(^GMPL(125.11,0)) S $P(^GMPL(125.11,0),U,3)=0
 Q
 ;
RSEQPROT ; Resequence GMPL MENU BUILD GROUP protocol menu items
 N GMPLPIEN,GMPLMSG,GMPLDA,GMPLITEM,GMPLIENS,GMPLFDA,GMPLTXT,GMPLERR
 S GMPLDA=0,GMPLERR=0
 S GMPLPIEN=$$FIND1^DIC(101,"","BX","GMPL MENU BUILD GROUP","","","GMPLMSG")
 I 'GMPLPIEN D BMES^XPDUTL("  Error: Cannot find GMPL MENU BUILD GROUP protocol.") Q
 F  S GMPLDA=$O(^ORD(101,GMPLPIEN,10,GMPLDA)) Q:GMPLDA=""  D
 . S GMPLITEM=$G(^ORD(101,GMPLPIEN,10,GMPLDA,0))
 . I $P(GMPLITEM,U,2)="ED" D  Q
 . . S GMPLIENS=""_GMPLDA_","_GMPLPIEN_","
 . . S GMPLFDA(101.01,GMPLIENS,.01)="GMPL MENU COPY GROUP"
 . . S GMPLFDA(101.01,GMPLIENS,2)="CN"
 . . S GMPLFDA(101.01,GMPLIENS,3)="5"
 . . D FILE^DIE("EK","GMPLFDA","GMPLMSG")
 . . I $D(GMPLMSG) D
 . . . S GMPLTXT(1)="  Unable to add GMPL MENU COPY GROUP as the 5th menu item. "
 . . . S GMPLTXT(2)="  Error: "_GMPLMSG("DIERR",1,"TEXT",1),GMPLERR=1
 . . . D BMES^XPDUTL(.GMPLTXT)
 I 'GMPLERR D MES^XPDUTL("  Done.")
 Q
 ;
SENDARPT(GMPLULST,GMPLCLST,GMPLELST) ; Build pre-existing user/clinic selection list assignment rpt and send via MailMan
 N GMPLTO,GMPLFROM,GMPXMSUB,SUB,GMPLCNT
 K ^TMP("GMPLASGN",$J)
 S SUB="GMPLASGN",GMPLCNT=9
 S GMPXMSUB="Pre-existing USER/CLINIC Selection List Assignment Report"
 S GMPLFROM="GMPL*2.0*49 INSTALL"
 S GMPLTO(DUZ)="",GMPLTO("G.OR CACS")=""
 S ^TMP(SUB,$J,1,0)=""
 S ^TMP(SUB,$J,2,0)="This report was auto generated during installation to identify Problem"
 S ^TMP(SUB,$J,3,0)="Selection Lists assigned to users and clinics prior to the installation of"
 S ^TMP(SUB,$J,4,0)="GMPL*2.0*49. After installation all users and clinic assignments will be"
 S ^TMP(SUB,$J,5,0)="migrated to the new Default Selection List Display parameter setting. If users"
 S ^TMP(SUB,$J,6,0)="and clinics desire to use the National Problem Selection List as their default"
 S ^TMP(SUB,$J,7,0)="setting then use the Assign/Remove menu option to reassign those users or"
 S ^TMP(SUB,$J,8,0)="clinics listed in the report."
 S ^TMP(SUB,$J,9,0)=""
 I $D(GMPLULST) D
 . N GMPLUSR,GMPLST S (GMPLUSR,GMPLST)=""
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="User Selection List Assignments: "
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 . F  S GMPLUSR=$O(GMPLULST(GMPLUSR)) Q:GMPLUSR=""  D
 . . F  S GMPLST=$O(GMPLULST(GMPLUSR,GMPLST)) Q:GMPLST=""  D
 . . . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="   "_$$LJ^XLFSTR(GMPLUSR,35)_$$LJ^XLFSTR(GMPLST,40)
 E  S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="There are no USER selection list assignments in the system currently."
 S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 I $D(GMPLCLST) D
 . N GMPLCLIN,GMPLLST S (GMPLCLIN,GMPLLST)=""
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="Clinic Selection List Assignments: "
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 . F  S GMPLCLIN=$O(GMPLCLST(GMPLCLIN)) Q:GMPLCLIN=""  D
 . . F  S GMPLLST=$O(GMPLCLST(GMPLCLIN,GMPLLST)) Q:GMPLLST=""  D
 . . . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="   "_$$LJ^XLFSTR(GMPLCLIN,35)_$$LJ^XLFSTR(GMPLLST,40)
 E  S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="There are no CLINIC selection list assignments in the system currently."
 I $D(GMPLELST) D
 . N GMPLUSNM,GMPLSLDA S (GMPLUSNM,GMPLSLDA)=""
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="User(s) assigned to a Selection List that no longer exists:"
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 . F  S GMPLUSNM=$O(GMPLELST(GMPLUSNM)) Q:GMPLUSNM=""  D
 . . F  S GMPLSLDA=$O(GMPLELST(GMPLUSNM,GMPLSLDA)) Q:GMPLSLDA=""  D
 . . . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="   "_$$LJ^XLFSTR(GMPLUSNM,35)_$$LJ^XLFSTR("Selection List #"_GMPLSLDA,40)
 D SEND^GMPLUTL4(SUB,GMPXMSUB,.GMPLTO,GMPLFROM)
 Q
 ;
SENDCRPT(GMPLLIST,GMPLCAT) ; Build mix/lower case name report and send to installer via MailMan
 N GMPLTO,GMPLFROM,GMPXMSUB,SUB,GMPLCNT,GMPLLNM,GMPLCNM
 K ^TMP("GMPLCASE",$J)
 S SUB="GMPLCASE",GMPLCNT=9,(GMPLLNM,GMPLCNM)=""
 S GMPXMSUB="Mixed & Lower Case List/Category Name Report"
 S GMPLFROM="GMPL*2.0*49 INSTALL"
 S GMPLTO(DUZ)="",GMPLTO("G.OR CACS")=""
 S ^TMP(SUB,$J,1,0)=""
 S ^TMP(SUB,$J,2,0)="Mixed/lower case problem selection list/category names are no longer allowed"
 S ^TMP(SUB,$J,3,0)="with patch GMPL*2.0*49. This patch scans the Problem Selection List and Problem"
 S ^TMP(SUB,$J,4,0)="Selection Category files for any names in mixed or lower case letters and"
 S ^TMP(SUB,$J,5,0)="converts them to upper case."
 S ^TMP(SUB,$J,6,0)=""
 S ^TMP(SUB,$J,7,0)="For those conversions that failed, please have a CAC or somebody with FileMan"
 S ^TMP(SUB,$J,8,0)="access manually modify the name to upper case."
 S ^TMP(SUB,$J,9,0)=""
 I $D(GMPLLIST("PASS")) D
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="The following list names converted successfully:"
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 . F  S GMPLLNM=$O(GMPLLIST("PASS",GMPLLNM)) Q:GMPLLNM=""  D
 . . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="     "_GMPLLNM
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 I $D(GMPLLIST("FAIL")) D
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="Failed list names:"
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="",GMPLLNM=""
 . F  S GMPLLNM=$O(GMPLLIST("FAIL",GMPLLNM)) Q:GMPLLNM=""  D
 . . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=$$LJ^XLFSTR("*"_GMPLLNM,34)_$$LJ^XLFSTR($P(GMPLLIST("FAIL",GMPLLNM),U),18)_$$LJ^XLFSTR($P(GMPLLIST("FAIL",GMPLLNM),U,2),80)
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 I $D(GMPLCAT("PASS")) D
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="The following category names converted successfully:"
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 . F  S GMPLCNM=$O(GMPLCAT("PASS",GMPLCNM)) Q:GMPLCNM=""  D
 . . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="     "_GMPLCNM
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 I $D(GMPLCAT("FAIL")) D
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="Failed category names:"
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="",GMPLCNM=""
 . F  S GMPLCNM=$O(GMPLCAT("FAIL",GMPLCNM)) Q:GMPLCNM=""  D
 . . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=$$LJ^XLFSTR("*"_GMPLCNM,34)_$$LJ^XLFSTR($P(GMPLCAT("FAIL",GMPLCNM),U),18)_$$LJ^XLFSTR($P(GMPLCAT("FAIL",GMPLCNM),U,2),80)
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 D SEND^GMPLUTL4(SUB,GMPXMSUB,.GMPLTO,GMPLFROM)
 Q
 ;
SENDDRPT(GMPLDUPL,GMPLDUPC) ; Build duplicate name report and send to installer via MailMan
 N GMPLTO,GMPLFROM,GMPXMSUB,SUB,GMPLCNT,GMPLLIST,GMPLCAT
 K ^TMP("GMPLDUP",$J)
 S SUB="GMPLDUP",GMPLCNT=6,(GMPLLIST,GMPLCAT)=""
 S GMPXMSUB="Duplicate Problem Selection List/Category Name Report"
 S GMPLFROM="GMPL*2.0*49 INSTALL"
 S GMPLTO(DUZ)="",GMPLTO("G.OR CACS")=""
 S ^TMP(SUB,$J,1,0)=""
 S ^TMP(SUB,$J,2,0)="Duplicate problem selection list/category names are no longer allowed with"
 S ^TMP(SUB,$J,3,0)="patch GMPL*2.0*49. The following list/category names are duplicates. Please"
 S ^TMP(SUB,$J,4,0)="have your CAC review these with the pre-existing file entries and rename,"
 S ^TMP(SUB,$J,5,0)="delete, or reconcile the duplicate entries as needed."
 S ^TMP(SUB,$J,6,0)=""
 I $D(GMPLDUPL) D
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="     Duplicate List Names:"
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 . F  S GMPLLIST=$O(GMPLDUPL(GMPLLIST)) Q:GMPLLIST=""  D
 . . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="     "_GMPLLIST
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 I $D(GMPLDUPC) D
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="     Duplicate Category Names:"
 . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)=""
 . F  S GMPLCAT=$O(GMPLDUPC(GMPLCAT)) Q:GMPLCAT=""  D
 . . S GMPLCNT=GMPLCNT+1,^TMP(SUB,$J,GMPLCNT,0)="     "_GMPLCAT
 D SEND^GMPLUTL4(SUB,GMPXMSUB,.GMPLTO,GMPLFROM)
 Q
 ;
SENDLIST(GMPLSLST) ; Export national list/category data if prefixed with VA-
 I $E(GMPLSLST,1,3)="VA-" Q 1
 Q 0
 ;
UPCHKMNU ; Update GMPL SELECTION LIST CSV CHECK menu text
 N GMPLIEN,GMPLFDA,GMPLMSG,GMPLERR,GMPLTXT
 S GMPLIEN=+$$FIND1^DIC(19,"","KX","GMPL SELECTION LIST CSV CHECK","","","GMPLMSG")
 I GMPLIEN>0 D
 . D BMES^XPDUTL("  Updating GMPL SELECTION LIST CSV CHECK menu text...")
 . S GMPLFDA(19,""_GMPLIEN_",",1)="Check Problem Selection List Problem Codes"
 . D FILE^DIE("EK","GMPLFDA","GMPLERR")
 I $D(GMPLERR) D
 . S GMPLTXT(1)="  Error updating menu text."
 . S GMPLTXT(2)="  Error "_GMPLERR("DIERR",1)_": "_GMPLERR("DIERR",1,"TEXT",1)
 . D BMES^XPDUTL(.GMPLTXT)
 E  D MES^XPDUTL("  Done.")
 Q
 ;
UPDTDORD ; Update display order of several menu items for GMPL BUILD LIST MENU option
 N GMPLI,GMPLOIEN,GMPLMSG,GMPLTXT,GMPLERR S GMPLERR=0
 S GMPLOIEN=$$FIND1^DIC(19,"","BX","GMPL BUILD LIST MENU","","","GMPLMSG")
 I 'GMPLOIEN D BMES^XPDUTL("  Error: Cannot find GMPL BUILD LIST MENU option") Q
 F GMPLI=1:1:3 D
 . N GMPLOPT,GMPLMIEN,GMPLIENS,GMPLVAL,GMPLFDA
 . S GMPLOPT=$S(GMPLI=1:"GMPL DELETE LIST",GMPLI=2:"GMPL SELECTION LIST CSV CHECK",1:"GMPL SELECTION LIST IMPORT")
 . S GMPLVAL=$S(GMPLI=1:"4",GMPLI=2:"5",1:"6")
 . S GMPLMIEN=$$FIND1^DIC(19.01,","_GMPLOIEN_",","BX",GMPLOPT,"","","GMPLMSG")
 . S GMPLIENS=""_GMPLMIEN_","_GMPLOIEN_","
 . S GMPLFDA(19.01,GMPLIENS,2)=GMPLVAL
 . S GMPLFDA(19.01,GMPLIENS,3)=GMPLVAL
 . D FILE^DIE("EK","GMPLFDA","GMPLMSG")
 . I $D(GMPLMSG) D
 . . S GMPLTXT(1)="  Menu Item: "_GMPLOPT
 . . S GMPLTXT(2)="  Error: "_GMPLMSG("DIERR",1,"TEXT",1),GMPLERR=1
 . . D BMES^XPDUTL(.GMPLTXT)
 I 'GMPLERR D MES^XPDUTL("  Done.")
 Q
 ;
