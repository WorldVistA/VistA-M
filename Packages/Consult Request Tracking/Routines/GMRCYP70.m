GMRCYP70 ;BP/SBR - CONSULT NOTE STORED ON WRONG PATIENT ; 11/07/2008
 ;;3.0;CONSULT/REQUEST TRACKING;**70**;;Build 17
 ;
ENV ;
 S XPDNOQUE=1  ;don't allow install to be queued
 Q
 ;
EN1 ;
 I $G(DUZ)="" D BMES^XPDUTL("Your DUZ is not defined.")
 N GMRCRECP,ZTDESC,ZTIO,ZTRTN,ZTSK,ZTSAVE,ZTQUEUED,ZTREQ,ZTDTH
 S GMRCRECP($S(+DUZ:DUZ,1:.5))=""
 D NAMELIST("Choose message recipients: ",.GMRCRECP,"")
TASK S ZTRTN="START^GMRCYP70",ZTIO=""
 S ZTSAVE("GMRCRECP(")=""
 S ZTDESC="Search for Results on Wrong Consult Patient",ZTDTH=$H
 D ^%ZTLOAD
 D BMES^XPDUTL("The search for results on wrong consult patient is"_$S($D(ZTSK):"",1:" NOT")_" queued")
 I $D(ZTSK) D MES^XPDUTL(" (to start NOW)."),BMES^XPDUTL("YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED.")
 Q
 ;
START ;
 S:$D(ZTQUEUED) ZTREQ="@"
 N GMRCTTL,XCNT
 K ^TMP("GMRCYP70",$J)
 D SEARCH
 I GMRCTTL D MSG
 I GMRCTTL=0 D NOMSG
 Q
SEARCH ;Search for results attached to the wrong patient.
 ;DBIA #5350 Clinical Procedures to get the Medical Patient IEN.
 ;DBIA #2693 TIU to get the Patient IEN.
 ;DBIA #2467 Consults to get the ORDERABLE ITEM from the ORDER file.
 ;
 N GMRCLOC,GMRCDIV,GMRC0,GMRCCNST,GMRCSEQ,GMRCRSLT,GMRCPAT,GMRCRSPT
 N GMRCDT,GMRCRSDT,GMRCDTX,GMRCCPT,GMRCNAME,GMRCERR,GMRCOERR,GMRCTYP,X
 S (GMRC0,GMRCCNST,GMRCRSLT,GMRCDT,GMRCRSDT,GMRCDTX,GMRCCPT,GMRCNAME,GMRCOERR,GMRCTYPE,X)=""
 S (XCNT,GMRCRSPT,GMRCTTL)=0
 S GMRCCNST=0 F  S GMRCCNST=$O(^GMR(123,GMRCCNST)) Q:GMRCCNST=""  Q:GMRCCNST'>0  D
 . S GMRC0=$G(^GMR(123,GMRCCNST,0)),XCNT=XCNT+1,(GMRCLOC,GMRCDIV)=""
 . F  S GMRCRSLT=$O(^GMR(123,GMRCCNST,50,"B",GMRCRSLT)) Q:GMRCRSLT=""  D
 .. S GMRCNAME="",GMRCERR=""
 .. S GMRCCPT=$P(GMRC0,U,2),(GMRCDT,GMRCDTX)=$P(GMRC0,U,1)
 .. S GMRCTYPE=$P($P(GMRCRSLT,"(",2),",",1)
 .. I $P(GMRCRSLT,";",2)="TIU(8925," D  I +GMRCERR Q
 ... N GMRCTIU
 ... D EXTRACT^TIULQ(+GMRCRSLT,"GMRCTIU",.GMRCERR,".02;1201",,,"IE")
 ... I +GMRCERR Q
 ... S GMRCRSPT=$G(GMRCTIU(+GMRCRSLT,.02,"I"))
 ... S GMRCRSDT=$G(GMRCTIU(+GMRCRSLT,1201,"E"))
 ... ;I GMRCCPT=GMRCRSPT K GMRCTIU(+GMRCRSLT)
 .. I $P(GMRCRSLT,";",2)'="TIU(8925," D
 ... S X=$P($P($P(GMRCRSLT,";",2),",",1),"(",2)
 ... I X'=699,X'=699.5 S GMRCRSPT=$$GET1^DIQ(X,+GMRCRSLT,1,"I")
 ... I X=699!(X=699.5) S GMRCRSPT=$$GET1^DIQ(X,+GMRCRSLT,.02,"I")
 ... I $G(GMRCRSPT)'="" S GMRCRSPT=$$GET1^DIQ(690,GMRCRSPT,.01,"I")
 ... I X=698!(X=698.1)!(X=698.2)!(X=698.3)!(X=701) S GMRCRSDT=$$GET1^DIQ(X,+GMRCRSLT,.01,"E")
 ... I X'=698,X'=698.1,X'=698.2,X'=698.3,X'=701 D
 .... S GMRCRSDT=$$GET1^DIQ(X,+GMRCRSLT,1502,"E")
 .... I GMRCRSDT="" S GMRCRSDT=$$GET1^DIQ(X,+GMRCRSLT,.01,"E")
 .. I GMRCCPT=GMRCRSPT Q  ;stored correctly
 .. ;For this report, we will quit if any patient iens are not found
 .. I GMRCRSPT="" Q  ;S GMRCRSPT="<NO IEN FOUND>"
 .. I GMRCCPT="" Q  ;S GMRCCPT="<NO IEN FOUND>"
 .. ;
 .. S GMRCOERR=$P(GMRC0,U,3)
 .. I GMRCOERR'="" S GMRCNAME=$P($$OI^ORX8(GMRCOERR),U,2)
 .. I GMRCNAME="",+$P(GMRC0,U,8) D
 ... N GMRCPTR,GMRCFL,GMRCPRC
 ... S GMRCPRC=$P(GMRC0,U,8),GMRCPTR=+GMRCPRC,GMRCFL=$P(GMRCPRC,";",2)
 ... I +GMRCPTR,GMRCFL'="" S GMRCPRC="^"_GMRCFL_GMRCPTR_",0)" D
 .... S GMRCNAME=$P($G(@GMRCPRC),U,1)
 .. I GMRCNAME="" S GMRCNAME=$P($G(^GMR(123.5,$P(GMRC0,U,5),0)),U,1)
 .. S GMRCLOC=+$P(GMRC0,U,4)
 .. S GMRCDIV=+$P($G(^SC(GMRCLOC,0)),U,4)
 .. S GMRCTTL=GMRCTTL+1
 .. I GMRCDT="" S GMRCDTX="NO DATE "_GMRCTTL
 .. S ^TMP("GMRCYP70",$J,GMRCDIV,GMRCCNST,GMRCDTX,GMRCTTL)=GMRCCNST_U_GMRCNAME_U_GMRCDT_U_GMRCCPT_U_GMRCRSPT_U_GMRCTYPE_U_+GMRCRSLT_U_GMRCRSDT_U_XCNT
 Q
 ;
MSG ;Send Mailman message to installer
 N GMRC0,GMRCIEN,GMRCC,GMRCCNT,GMRCTPT,GMRCDT,GMRCFDT,GMRCRDT,GMRCNAME
 N GMRCPFLG,GMRCCPT,GMRCTYPE,GMRCDOC,GMRCCON,GMRCX,GMRCMSG,GMRCPARM
 N GMRCPG,GMRCSPC,GMRCTPG,GMRCTXT,GMRCDIV,GMRCEDIV,GMRCSIEN,GMRCRTTL
 N XMDUZ,XMERR,XMSUB,XMTEXT,XMY,Y
 S (GMRCCON,GMRCNAME,GMRCCPT,GMRCTPT,GMRCDOC,GMRCTYPE)=""
 I $D(GMRCRECP) M XMY=GMRCRECP
 I DUZ="" N DUZ S DUZ=.5
 S XMDUZ=DUZ,XMTEXT="GMRCTXT"
 S XMY(DUZ)=""
 D
 . S GMRCPG=0,GMRCDIV="",GMRCSIEN=""
 . D TOTAL
 . S GMRCTPG=GMRCRTTL/500 I GMRCTPG#1 S GMRCTPG=$P(GMRCTPG,".")+1
 . F GMRCPG=1:1:GMRCTPG D
 .. K GMRCTXT
 .. S GMRCC=0
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="This message ("_GMRCPG_" of "_GMRCTPG_") has been sent by routine GMRCYP70 at the completion"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="of the Consult Result evaluation."
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 .. S XMSUB="CONSULT NOTE ON WRONG PATIENT (MSG "_GMRCPG_" of "_GMRCTPG_")"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="In the report below, the patient IEN from the ASSOCIATED RESULTS file (8925,"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="691, 691.1, etc.) does not match the patient IEN stored on the consult"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="in the REQUEST/CONSULTATION file."
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="A team including a Clinical Application Coordinator, Chief, Health"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Information Management, and other pertinent facility staff should"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="review the results of the report generated by this patch. This step is"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="critical to ensuring the integrity and accuracy of the Consult data at"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="your facility."
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="See the description for patch GMRC*3.0*70 in the National Patch Module"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="for further explanation of this report and for instructions on how to"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="correct the listed entries."
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  CONSULT #      CONSULT NAME             CONSULT DATE/TIME   "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="   CONSULT PT IEN #     RESULT PT IEN #    RESULT TYPE     RESULT DOC #     "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="    RESULT DATE/TIME    "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="============================================================================="
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 .. S GMRCSPC="                                                            "
 .. S GMRCCNT=0,GMRCPFLG=0
 .. I +$G(GMRCSIEN) S GMRCDIV=GMRCDIV-1
 .. F  S GMRCDIV=$O(^TMP("GMRCYP70",$J,GMRCDIV)) Q:GMRCDIV=""  D  Q:GMRCCNT>497
 ... I GMRCCNT'=0 D
 .... N I
 .... F I=1:1:3 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 ... S GMRCEDIV=$$EXTERNAL^DILFD(44,3,"",GMRCDIV)
 ... I GMRCEDIV']"" S GMRCEDIV="UNKNOWN"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="-----------------------------------------------------------------------------"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Division: "_GMRCEDIV
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="-----------------------------------------------------------------------------"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 ... I '+$G(GMRCSIEN) S GMRCIEN=""
 ... I +$G(GMRCSIEN) S GMRCSIEN=""
 ... F  S GMRCIEN=$O(^TMP("GMRCYP70",$J,GMRCDIV,GMRCIEN)) Q:GMRCIEN=""  D  Q:+GMRCPFLG
 .... S GMRCDT=""
 .... F  S GMRCDT=$O(^TMP("GMRCYP70",$J,GMRCDIV,GMRCIEN,GMRCDT)) Q:GMRCDT=""  D
 ..... S GMRCX=""
 ..... F  S GMRCX=$O(^TMP("GMRCYP70",$J,GMRCDIV,GMRCIEN,GMRCDT,GMRCX)) Q:GMRCX=""  D
 ...... S GMRC0=$G(^TMP("GMRCYP70",$J,GMRCDIV,GMRCIEN,GMRCDT,GMRCX))
 ...... S Y=$P(GMRC0,"^",3)  ;SET DATE
 ...... D DD^%DT
 ...... I Y=-1 S Y="DATE ERROR"
 ...... S GMRCFDT=Y
 ...... S GMRCCON=$E(GMRCIEN_GMRCSPC,1,15)
 ...... S GMRCFDT=$E(GMRCFDT_GMRCSPC,1,18)
 ...... S GMRCNAME=$E($P(GMRC0,U,2)_GMRCSPC,1,23)_"  "
 ...... S GMRCCPT=$E($P(GMRC0,U,4)_GMRCSPC,1,21)
 ...... S GMRCTPT=$E($P(GMRC0,U,5)_GMRCSPC,1,19)
 ...... S GMRCTYPE=$E($P(GMRC0,U,6)_GMRCSPC,1,16)
 ...... S GMRCDOC=$E($P(GMRC0,U,7)_GMRCSPC,1,20)
 ...... S GMRCRDT=$E($P(GMRC0,U,8)_GMRCSPC,1,21)
 ...... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "_GMRCCON_GMRCNAME_GMRCFDT
 ...... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="   "_GMRCCPT_GMRCTPT_GMRCTYPE_GMRCDOC
 ...... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="    "_GMRCRDT
 ...... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 ...... S GMRCCNT=GMRCCNT+1
 .... I GMRCCNT>499 D
 ..... I +$O(^TMP("GMRCYP70",$J,GMRCDIV,GMRCIEN)) S GMRCSIEN=GMRCIEN
 ..... S GMRCPFLG=1
 .. I GMRCCNT=0 Q
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Total records searched: "_XCNT
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Total records in this message: "_GMRCCNT
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Total records attached to wrong patient: "_GMRCTTL
 .. D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.GMRCPARM,"","")
 .. S GMRCMSG(1)=" "
 .. S GMRCMSG(2)="******************************************************************************"
 .. D
 ... S GMRCMSG(3)="** Message ("_$S($L(GMRCPG)=1:$J("0"_GMRCPG,2),1:GMRCPG)_" of "_$S($L(GMRCTPG)=1:$J("0"_GMRCTPG,2),1:GMRCTPG)_") containing Consult records which have a consult result**"
 ... I '$D(XMERR) S GMRCMSG(4)="** attached to the wrong patient.                                           **"
 ... I $D(XMERR) D 
 .... S GMRCMSG(4)="** attached to the wrong patient was NOT sent.                              **"
 .... S GMRCMSG(5)="** The message was not sent due to an error in the message setup.           **"
 .... S GMRCMSG(6)="** Dumping message to screen.                                               **"
 .... S GMRCMSG(7)="******************************************************************************"
 .. I '$D(XMERR) S GMRCMSG(5)="******************************************************************************"
 . K ^TMP("GMRCYP70",$J)
 Q
 ;
NOMSG ;Send Mailman message to installer - no records found
 N GMRCC,GMRCMSG,GMRCPARM,GMRCSPC,GMRCTXT
 N XMDUZ,XMERR,XMSUB,XMTEXT,XMY,Y
 I DUZ="" N DUZ S DUZ=.5
 S XMDUZ=DUZ,XMTEXT="GMRCTXT"
 S XMY(DUZ)=""
 K GMRCTXT
 S GMRCC=0
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="This message has been sent by routine GMRCYP70 at the completion"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="of the Consult Result evaluation."
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 S XMSUB="NO MATCHES FOUND - CONSULT RESULTS"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="All Consult Results are attached to the correct patient."
 S GMRCSPC="                                                            "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Total records attached to wrong patient: "_$G(GMRCTTL)
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.GMRCPARM,"","")
 S GMRCMSG(1)=" "
 S GMRCMSG(2)="******************************************************************************"
 S GMRCMSG(3)="** Message containing Consult records which have a Consult Result           **"
 I '$D(XMERR) S GMRCMSG(4)="** attached to the wrong Patient was sent.                                  **"
 I $D(XMERR) D 
 . S GMRCMSG(4)="** attached to the wrong patient was NOT sent.                              **"
 . S GMRCMSG(5)="** The message was not sent due to an error in the message setup.           **"
 . S GMRCMSG(6)="** Dumping message to screen.                                               **"
 . S GMRCMSG(7)="******************************************************************************"
 I '$D(XMERR) S GMRCMSG(5)="******************************************************************************"
 Q
 ;
TOTAL ;Calculate adjusted result totals to determine total messages needed
 N GMRCDIV,GMRCDT,GMRCIEN,GMRCTCNT,GMRCX
 S GMRCRTTL=0
 S GMRCDIV=""
TOTAL1 S (GMRCTCNT,GMRCPFLG)=0
 D
 . I +$G(GMRCSIEN) S GMRCDIV=GMRCDIV-1
 . F  S GMRCDIV=$O(^TMP("GMRCYP70",$J,GMRCDIV)) Q:GMRCDIV=""  D  Q:GMRCTCNT>497
 .. I '+$G(GMRCSIEN) S GMRCIEN=""
 .. I +$G(GMRCSIEN) S GMRCSIEN=""
 .. F  S GMRCIEN=$O(^TMP("GMRCYP70",$J,GMRCDIV,GMRCIEN)) Q:GMRCIEN=""  D  Q:+GMRCPFLG
 ... S GMRCDT=""
 ... F  S GMRCDT=$O(^TMP("GMRCYP70",$J,GMRCDIV,GMRCIEN,GMRCDT)) Q:GMRCDT=""  D
 .... S GMRCX=""
 .... F  S GMRCX=$O(^TMP("GMRCYP70",$J,GMRCDIV,GMRCIEN,GMRCDT,GMRCX)) Q:GMRCX=""  D
 ..... S GMRCTCNT=GMRCTCNT+1
 ... I GMRCTCNT>499 D
 .... I +$O(^TMP("GMRCYP70",$J,GMRCDIV,GMRCIEN)) S GMRCSIEN=GMRCIEN
 .... S GMRCPFLG=1
 .... S GMRCRTTL=GMRCRTTL+1
 . I GMRCTCNT<500 S GMRCRTTL=GMRCRTTL+GMRCTCNT
 G:GMRCDIV'="" TOTAL1
 Q
 ;
NAMELIST(GMRCP,GMRCOLD,GMRCDELR) ;manage the list of recipients
 ;
 ; GMRCP - Prompt
 ; GMRCOLD - Original list with ordering provider.
 ; GMRCDELR - 1 means the original list may have names deleted
 ; Returns final list in GMRCOLD array
 ;
 N GMRCNEW,GMRCNT,GMRCDUZ,GMRCUSER,GMRCQ,GMRCADD,DIC,X,Y
 M GMRCNEW=GMRCOLD
 I GMRCDELR=1 K GMRCOLD S GMRCOLD="" ;Remove mandatory users from GMRCOLD
 S GMRCNT=0 F  D  Q:(GMRCUSER[U)
 . S GMRCUSER=$$READ("FAO;3;46",GMRCP,"","^D NAMEHELP^GMRCYP70")
 . S:'$L(GMRCUSER) GMRCUSER=U Q:(GMRCUSER[U)
 . I ($E(GMRCUSER,1)="-") S GMRCADD=0,GMRCUSER=$E(GMRCUSER,2,$L(GMRCUSER))
 . E  S GMRCADD=1
 . S X=GMRCUSER,DIC=200,DIC(0)="EMQ" D ^DIC
 . I (Y>0) D  I 1
 .. I GMRCADD D
 ... I $D(GMRCNEW(+Y)) D MES^XPDUTL(" already in the list.") Q
 ... S GMRCNEW(+Y)="" D MES^XPDUTL(" added to the list.") S GMRCNT=GMRCNT+1
 .. I 'GMRCADD D
 ... I $D(GMRCOLD(+Y)) D MES^XPDUTL(" can't delete this name from the list.") Q
 ... I '$D(GMRCNEW(+Y)) D MES^XPDUTL(" not currently in the list.") Q
 ... K GMRCNEW(+Y) S GMRCNT=GMRCNT-1 D MES^XPDUTL(" deleted from the list.")
 . E  I $L(GMRCUSER) D MES^XPDUTL("  Name not found.")
 . D MES^XPDUTL(" ")
 M GMRCOLD=GMRCNEW
 Q
 ;
READ(GMRC0,GMRCA,GMRCB,GMRCH,GMRCL) ;read logic
 ;
 ;  GMRC0 -> DIR(0) --- Type of read
 ;  GMRCA -> DIR("A") - Prompt
 ;  GMRCB -> DIR("B") - Default Answer
 ;  GMRCH -> DIR("?") - Help text or ^Execute code
 ;  GMRCL -> Number of blank lines to put before Prompt
 ;
 ;  Returns "^" or answer
 ;
 N GMRCLINE,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:'$L($G(GMRC0)) U
 S DIR(0)=GMRC0
 S:$L($G(GMRCA)) DIR("A")=GMRCA
 S:$L($G(GMRCB)) DIR("B")=GMRCB
 S:$L($G(GMRCH)) DIR("?")=GMRCH
 F GMRCLINE=1:1:($G(GMRCL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
 ;
NAMEHELP ;Help for the recipient list logic
 N GMRCDUZ
 D BMES^XPDUTL("Enter the name of the user to send the message to,")
 D MES^XPDUTL(" or put a '-' in front of a name to delete from the list.")
 D MES^XPDUTL(" ")
 D MES^XPDUTL("  Example:")
 D BMES^XPDUTL("     SMITH,FRED  ->  to add Fred to the list.")
 D MES^XPDUTL("     -SMITH,FRED ->  to delete Fred from the list.")
 D BMES^XPDUTL("Already selected: ")
 D MES^XPDUTL(" ")
 S GMRCDUZ=0 F  S GMRCDUZ=$O(GMRCNEW(GMRCDUZ)) Q:'GMRCDUZ  D
 . I '$D(GMRCOLD(GMRCDUZ)) D MES^XPDUTL("     "_$P(^VA(200,GMRCDUZ,0),U,1))
 . I $D(GMRCOLD(GMRCDUZ)) D MES^XPDUTL("     "_$P(^VA(200,GMRCDUZ,0),U,1)_"  <mandatory>")
 D MES^XPDUTL(" ")
 Q
