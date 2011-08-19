EASEZLM ;ALB/jap - 1010EZ List Manager Processing Screens ;10/12/00  13:07
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;;Mar 15, 2001
 ;
EN ;Main entry point for 1010EZ processing
 ;Ask user to select processing status
 W @IOF
 W !!,"10-10EZ Application Processing --",!
 K DIR,DTOUT,DUOUT,DIRUT,Y
 S DIR(0)="SMO^1:New;2:In Review;3:Printed, Pending Signature;4:Signed;5:Filed;6:Inactivated"
 S DIR("A")="Select Applications to View"
 D ^DIR K DIR
 I $D(DIRUT) K DIR,DTOUT,DUOUT,DIRUT,Y  Q
 ;
 S EASVIEW=0
 ;I Y,"^1^2^3^4^5^"[(U_Y_U) S EASVIEW=Y
 I Y,"^1^2^3^4^5^6^"[(U_Y_U) S EASVIEW=Y
 Q:'EASVIEW
 S EASPSTAT=""
 D EN^EASEZL1
 K EASVIEW G EN
 Q
 ;
HDR ;Header code
 N H
 S VALMHDR(1)=" "
 ;Processing - primary view
 N HDR
 S HDR=""
 S H=$S(EASVIEW=1:"NEW",EASVIEW=2:"IN REVIEW",EASVIEW=3:"PRINTED, PENDING SIG.",EASVIEW=4:"SIGNED",EASVIEW=5:"FILED",EASVIEW=6:"INACTIVATED",1:"")
 S HDR=HDR_H
 S VALMHDR(2)="Application Status: "_$S(HDR="":"Unknown",1:HDR)
 S VALMHDR(3)=" "
 Q
 ;
INIT ;Init variables and list array
 ;
 S VALMSG=$$MSG^EASEZLM
 S EASARY="EASEZ"
 K ^TMP("EASEZ",$J),^TMP($J,712),^TMP("EASEZIDX",$J)
 ;determine processing status
 ;I EASPSTAT="" S V=EASVIEW,EASPSTAT=$S(V=1:"NEW",V=2:"REV",V=3:"PRT",V=4:"SIG",V=5:"CLS",1:"") K V
 I EASPSTAT="" S V=EASVIEW,EASPSTAT=$S(V=1:"NEW",V=2:"REV",V=3:"PRT",V=4:"SIG",V=5:"FIL",V=6:"CLS",1:"") K V
 I EASPSTAT="" S VALMCNT=0 D NOLINES^EASEZLM
 I EASVIEW,EASPSTAT'="" D BLD
 ;Print message if no Applications meet selection criteria
 I 'VALMCNT D NOLINES^EASEZLM
 Q
 ;
BLD ;Build initial EZ selection screen
 N V,JDATE,JNAME,DAT,FILDATE,WEBID,WILLSEND,VETTYPE,FAC,APP,SSN,DOB,EDATE,IT,PRT,STATION
 K ^TMP("EASEZ",$J)
 S VALMBG=1,VALMCNT=0
 S IT="" F  S IT=$O(VALMDDF(IT)) Q:IT=""  S X=VALMDDF(IT),EASCOL(IT)=$P(X,U,2),EASWID(IT)=$P(X,U,3)
 S EASLN=0,EASNUM=0
 I 'EASVIEW S VALMCNT=0,$P(^TMP("EASEZ",$J,0),U,4)=VALMCNT Q
 W !!,"Please wait while processing...",!!
 ;call to find all Applications needed for main LM screen
 D PICKALL^EASEZU2(EASVIEW)
 ;
 S FAC="" F  S FAC=$O(^TMP($J,712,EASVIEW,FAC)) Q:FAC=""  S JNAME="" F  S JNAME=$O(^TMP($J,712,EASVIEW,FAC,JNAME)) Q:JNAME=""  D
 .S JDATE=0  F  S JDATE=$O(^TMP($J,712,EASVIEW,FAC,JNAME,JDATE)) Q:'JDATE  S APP=0 F  S APP=$O(^TMP($J,712,EASVIEW,FAC,JNAME,JDATE,APP)) Q:'APP  D
 ..S DAT=^TMP($J,712,EASVIEW,FAC,JNAME,JDATE,APP)
 ..;reset processing status if application has filing date
 ..;I EASVIEW=4 S FILDATE=$P(DAT,U,5)
 ..S SSN=$P(DAT,U,2),VETTYPE=$P(DAT,U,3),EDATE=$P(DAT,U,4),WEBID=$P(DAT,U,6),WILLSEND=$P(DAT,U,7),FAC=$P(DAT,U,8)
 ..S PRT=$S(WILLSEND:"Vet",1:"VA")
 ..S STATION=FAC S:STATION=1 STATION=""
 ..S EASLN=EASLN+1,EASNUM=EASNUM+1
 ..S X=$$SETSTR^VALM1(EASLN,"",EASCOL("NUMBER"),EASWID("NUMBER"))
 ..S X=$$SETSTR^VALM1(JNAME,X,EASCOL("APPLICANT"),EASWID("APPLICANT"))
 ..S X=$$SETSTR^VALM1(SSN,X,EASCOL("SSN"),EASWID("SSN"))
 ..S X=$$SETSTR^VALM1(VETTYPE,X,EASCOL("TYPE"),EASWID("TYPE"))
 ..S X=$$SETSTR^VALM1(EDATE,X,EASCOL("DATE"),EASWID("DATE"))
 ..S X=$$SETSTR^VALM1(" "_PRT,X,EASCOL("PRINTED"),EASWID("PRINTED"))
 ..S X=$$SETSTR^VALM1(STATION,X,EASCOL("STATION"),EASWID("STATION"))
 ..S X=$$SETSTR^VALM1(APP,X,EASCOL("APPNUM"),EASWID("APPNUM"))
 ..S ^TMP("EASEZ",$J,EASLN,0)=X
 ..S ^TMP("EASEZ",$J,"IDX",EASLN,APP)=JNAME_U_EDATE
 ..;I EASVIEW=4,'FILDATE D
 ..;.S $P(^TMP("EASEZ",$J,"IDX",EASLN,APP),U,3)=1
 ..;.D FLDCTRL^VALM10(EASLN,"APPLICANT",IOINHI,IOINORM)
 ..;.D FLDCTRL^VALM10(EASLN,"APPNUM",IOINHI,IOINORM)
 ..S ^TMP("EASEZIDX",$J,APP)=JNAME_U_EDATE_U_WEBID_U_WILLSEND_U_STATION
 S VALMCNT=EASNUM
 S $P(^TMP("EASEZ",$J,0),U,4)=VALMCNT
 Q
 ;
MSG() ;Custom message for list manager 'message window'
 ;
 I EASVIEW=4 Q "Applications not yet filed to the Patient database."
 Q "Select an Application to view."
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;protocol action Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP(EASARY_"SRT",$J),^TMP(EASARY_"IDX",$J)
 K EASBEG,EASEND,EASDFN,EASEZNEW,EASAPP,EASLOCK,EASLN
 Q
 ;
SEL ;Select item in inital view to expand
 N BG,LST,Y,DIR,DTOUT,DUOUT,DIRUT
 S BG=VALMBG
 S LST=VALMLST
 S EASSEL=0,EASERR=0
 I 'BG D  Q
 .W !!,*7,"There are no '",VALM("ENTITY"),"s' to select.",!
 .S EASERR=1
 .S DIR(0)="E" D ^DIR K DIR
 S Y=+$P($P(XQORNOD(0),U,4),"=",2)
 I 'Y D
 .S DIR(0)="N^"_BG_":"_LST,DIR("A")="Select "_VALM("ENTITY")_"(s)"
 .D ^DIR K DIR I $D(DIRUT) S EASERR=1,EASSEL=0
 Q:EASERR
 ;
 ;check for valid entries
 S EASSEL=Y
 I EASSEL<BG!(EASSEL>LST) D
 .W !,*7,"Selection '",EASSEL,"' is not a valid choice."
 .S EASERR=1,EASSEL=0 D PAUSE^VALM1
 ;
 Q
 ;
NOLINES ;if array empty, inform user
 I $G(EASLOCK)=1 D  Q
 .S ^TMP(EASARY,$J,1,0)=$$SETSTR^VALM1(" ","",1,60)
 .S ^TMP(EASARY,$J,"IDX",1,1)=""
 .S ^TMP(EASARY,$J,2,0)=$$SETSTR^VALM1("No Applications meet the selection criteria. ","",5,60)
 .S ^TMP(EASARY,$J,"IDX",2,2)=""
 I $G(EASLOCK)=0 D  Q
 .S ^TMP(EASARY,$J,1,0)=$$SETSTR^VALM1(" ","",1,60)
 .S ^TMP(EASARY,$J,"IDX",1,1)=""
 .S ^TMP(EASARY,$J,2,0)=$$SETSTR^VALM1("Application being processed by another user.","",5,60)
 .S ^TMP(EASARY,$J,"IDX",2,2)=""
 .S ^TMP(EASARY,$J,3,0)=$$SETSTR^VALM1("Try again late.....","",5,60)
 .S ^TMP(EASARY,$J,"IDX",3,3)=""
 S ^TMP(EASARY,$J,1,0)=$$SETSTR^VALM1(" ","",1,60)
 S ^TMP(EASARY,$J,"IDX",1,1)=""
 S ^TMP(EASARY,$J,2,0)=$$SETSTR^VALM1("No Applications meet the selection criteria. ","",5,60)
 S ^TMP(EASARY,$J,"IDX",2,2)=""
 Q
 ;
FNL ;option (list template) Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP($J,712)
 K ^TMP("EASEZ",$J),^TMP("EASEZSRT",$J),^TMP("EASEZIDX",$J)
 K ^TMP("VALM STACK",$J)
 K EASVIEW,EASSEL,EASLN,EASNUM,EASARY,EASCOL,EASWID,EASAPP,EASPSTAT,EASRTR,EASERR
 Q
 ;
NOACT(STAT,ACTION) ;action not allowed
 ;
 W !!,$C(7),ACTION_" not allowed for this "_STAT_" Application."
 S VALMBCK="R"
 D PAUSE^VALM1
 Q
