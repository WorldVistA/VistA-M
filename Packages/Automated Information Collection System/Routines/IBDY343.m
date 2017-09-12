IBDY343 ;ALB/ESD - PRE AND POST INSTALL FOR PATCH IBD*3*43 ; AUG 1, 2000
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**43**;APR 24, 1997
 ;
PRE ;- Create EF block list report and clear workspace before install
 D BLKLIST
 D CLWKSP
 Q
 ;
 ;
POST ;- Add toolkit blocks
 D TKBLKS
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
BLKLIST ;- List tool kit blocks, forms, div(s), and clinic(s) so that users can
 ;- find and change them to the new EF blocks containing Enrollment 
 ;- Priority
 ;
 N ARRYVAL,BLKIEN,BLKNAM,BLOCK,CLINIC,CNT,DIV,DIVNAM,FORMIEN,FORM,LINE,LINECNT,MULTI
 K ^TMP("DILIST",$J),^TMP($J,"IBDCS"),^TMP($J,"IBDCN"),^TMP("IBD43",$J)
 ;
 ;- Display info msg to patch installer
 D USERMSG
 ;
 ;- Var used in CLINIC^IBDF15A call for multiple divs; must be defined
 S MULTI=0
 S LINECNT=19
 F LINE=1:1 S BLKNAM=$P($T(LIST+LINE),";;",2) Q:(BLKNAM="QUIT")  D
 . D FIND^DIC(357.1,"",".01;.02","",BLKNAM)
 . F CNT=0:0 S CNT=$O(^TMP("DILIST",$J,2,CNT)) Q:'CNT  D
 .. S BLKIEN=+$G(^TMP("DILIST",$J,2,CNT))
 .. ;
 .. ;- Get block and what form it's on
 .. S BLOCK=$P($G(^IBE(357.1,BLKIEN,0)),"^")
 .. S FORMIEN=+$P($G(^IBE(357.1,BLKIEN,0)),"^",2)
 .. S FORM=$P($G(^IBE(357,FORMIEN,0)),"^")
 .. ;
 .. ;- Don't list blocks on the Form tool kit
 .. Q:FORMIEN<1!(FORM="")!(FORM="TOOL KIT")!(FORM="TOOLKIT BLOCKS")
 .. ;
 .. ;- Get list of clinics and division(s) using form
 .. D CLINIC^IBDF15A(FORMIEN,FORM)
 .. S (CLINIC,DIVNAM)="",DIV=0
 .. F  S DIVNAM=$O(^TMP($J,"IBDCS",DIVNAM)) Q:DIVNAM=""  F  S DIV=$O(^TMP($J,"IBDCS",DIVNAM,DIV)) Q:'DIV  D
 ... F  S CLINIC=$O(^TMP($J,"IBDCS",DIVNAM,DIV,FORM,FORMIEN,CLINIC)) Q:CLINIC=""  D WRITELST(.LINECNT)
 ;
 ;- Briefly explain rpt and list old and new EF blocks
 D XMHDR
 I '$D(^TMP("IBD43",$J,19)) S ^TMP("IBD43",$J,19)="          No AICS encounter form information found"
 D XM
 D MES^XPDUTL(">>> ...completed.")
 K ^TMP("DILIST",$J),^TMP($J,"IBDCS"),^TMP($J,"IBDCN"),^TMP("IBD43",$J)
 Q
 ;
 ;
WRITELST(CNT) ;- Print block & form on 1st line, clinic & division on 2nd line
 N LINE
 S LINE=$$SETSTR^VALM1(" Block:  "_BLOCK,"",1,40),LINE=$$SETSTR^VALM1("      Form:  "_FORM,LINE,43,36)
 D INCR(.CNT)
 S LINE=$$SETSTR^VALM1("Clinic:  "_CLINIC,"",1,40),LINE=$$SETSTR^VALM1("  Division:  "_$E(DIVNAM,1,25),LINE,43,36)
 D INCR(.CNT)
 S LINE=$$SETSTR^VALM1(" ","",1,80)
 D INCR(.CNT)
 Q
 ;
 ;
INCR(CNT) ;- Create output array
 S ^TMP("IBD43",$J,CNT)=LINE
 S CNT=CNT+1
 Q
 ;
 ;
XM ;- Send mail message to patch installer
 N DIFROM,XMSUB,XMDUZ,XMTEXT,XMY
 S XMSUB="Patch IBD*3*43 Encounter Form Block Report"
 S XMDUZ=.5
 S XMY(DUZ)=""
 S XMY(XMDUZ)=""
 S XMTEXT="^TMP(""IBD43"",$J,"
 D ^XMD
 Q
 ;
 ;
XMHDR ;- Report header
 ;
 S ^TMP("IBD43",$J,1)=" Patch IBD*3*43 contains a number of encounter form blocks which were"
 S ^TMP("IBD43",$J,2)=" modified to include the Enrollment Priority. These new"
 S ^TMP("IBD43",$J,3)=" encounter form blocks should replace the existing encounter form"
 S ^TMP("IBD43",$J,4)=" blocks on all applicable encounter forms."
 S ^TMP("IBD43",$J,5)=" "
 S ^TMP("IBD43",$J,6)=" This report will assist the user in replacing these blocks by listing the"
 S ^TMP("IBD43",$J,7)=" existing encounter form blocks, the encounter form(s) they are located on,"
 S ^TMP("IBD43",$J,8)=" and all clinic(s), and division(s) using the encounter form."
 S ^TMP("IBD43",$J,9)=" "
 S ^TMP("IBD43",$J,10)="    Old block                        New block"
 S ^TMP("IBD43",$J,11)="    =========                        ========="
 S ^TMP("IBD43",$J,12)=" "
 S ^TMP("IBD43",$J,13)="    PATIENT INFORMATION (V2.1)       PATIENT INFORMATION (V3.0)"
 S ^TMP("IBD43",$J,14)="    BASIC DEMOGRAPHICS               BASIC DEMOGRAPHICS (V3.0)"
 S ^TMP("IBD43",$J,15)="    BASIC DEMOGRAPHICS (MST)         BASIC DEMOGRAPHICS (V3.0)"
 S ^TMP("IBD43",$J,16)=" "
 Q
 ;
 ;
USERMSG ;- Info message displayed during patch install
 ;
 D BMES^XPDUTL(">>> Creating encounter form block report to aid user in finding existing")
 D MES^XPDUTL(">>> encounter form blocks and replacing them with blocks containing the")
 D MES^XPDUTL(">>> Enrollment Priority.")
 D BMES^XPDUTL(">>> This report will be sent as a mail message to the patch installer")
 D MES^XPDUTL(">>> with the subject ""Patch IBD*3*43 Encounter Form Block Report"".")
 Q
 ;
 ;
TKBLKS ;- Add Enrollment Priority tool kit blocks to AICS Tool Kit
 ;
 N A,ARY,BLK,CNT,CNT1,CNTB,CNTF,EXCLUDE,FORM,FORMNM,NAME,IBDNM,IBDBLK,IBDX,IBTKBLK,NEWBLOCK,NEWFORM,NUM,ORD,SUMMARY,X,Y
 ;
 ;- Add all tool kit blocks
 S FORMNM="TOOL KIT"
 S (CNTB,CNTF)=0,NUM=1
 D BMES^XPDUTL(">>> Adding Enrollment Priority Tool Kit blocks to the AICS Tool Kit...")
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
 . ;- Delete block if it already exists
 . S IBTKBLK=1
 . S IBDNM="" F  S IBDNM=$O(^IBE(357.1,"B",IBDNM)) Q:IBDNM=""  S IBDBLK=0 F  S IBDBLK=+$O(^IBE(357.1,"B",IBDNM,IBDBLK)) Q:'IBDBLK  D
 .. I $P($G(^IBE(357.1,IBDBLK,0)),"^")=NAME D DLTBLK^IBDFU3(IBDBLK,"",357.1)
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
LIST ;- List of encounter form blocks
 ;;BASIC DEMOGRAPHICS
 ;;BASIC DEMOGRAPHICS (MST)
 ;;PATIENT INFORMATION (V2.1)
 ;;QUIT
