BPSVRX3 ;AITC/PD - Print Report from VER;5/2/2017
 ;;1.0;E CLAIMS MGMT ENGINE;**22**;JUN 2004;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
REPORT ; Select and print sections of the list.
 ;
 ; Allow the user to select one or more sections of the VER list to
 ; print to the specified device.
 ;
 N BPSAR,BPSLIST
 D FULL^VALM1
 ;
LIST I '$$SELECT(.BPSLIST) G REXIT
 ;
 D BUILD
 ;
 I '$$DEVICE() G REXIT:$$STOP,LIST
 ;
REXIT ; Exit point.
 ;
 Q
 ;
SELECT(BPSLIST) ; Allow user to select sections of the list to be printed.
 ;
 ; This function returns a 1 if the user entered one or more sections
 ; to be printed, 0 if no selection was made.
 ; This function expects the following variables to exist:
 ; - BPSVRX("LISTNAV",Section#) = Beginning Line#
 ;   where Section# is a number, 1-14, corresponding to a section of the
 ; ListMan list, and Beginning Line# is the first line of that section.
 ;
 ; Returns the BPSLIST array with a list of one or more sections:
 ;     BPSLIST(Section#) = First Line ^ Last Line
 ; Where First Line and Last Line are the first and last lines of
 ; that section in the list and Section# can be one or more numbers
 ; from 1 to 14, each corresponding to a section:
 ;      8 - AP, TPJI Account Profile
 ;      3 - BE, Billing Events
 ;      7 - CI, TPJI Claim Info
 ;      2 - CL, Claim Log
 ;      9 - CM, TPJI AR Comment History
 ;      4 - CR, Claims Response Inquiry Report
 ;     10 - ER, TPJI ECME Rx Information
 ;     11 - ES, Eligibility Status
 ;     12 - EV, Eligibility Verification
 ;      5 - IN, Insurance
 ;      6 - LB, List of Bills
 ;     14 - MP, Medication Profile
 ;     13 - SD, Sensitive Drug
 ;      1 - VW, View Rx
 ;
 N BPSLC,BPSLISTNAV,BPSSECBEGIN,BPSSECEND,BPSSECNUM,BPSSECLIST,BPSSEL
 N BPSUC,BPSX,BPSY,DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S BPSSECLIST=",AP,BE,CI,CL,CM,CR,ER,ES,EV,IN,LB,MP,SD,VW,"
 S BPSLISTNAV("AP")=8
 S BPSLISTNAV("BE")=3
 S BPSLISTNAV("CI")=7
 S BPSLISTNAV("CL")=2
 S BPSLISTNAV("CM")=9
 S BPSLISTNAV("CR")=4
 S BPSLISTNAV("ER")=10
 S BPSLISTNAV("ES")=11
 S BPSLISTNAV("EV")=12
 S BPSLISTNAV("IN")=5
 S BPSLISTNAV("LB")=6
 S BPSLISTNAV("MP")=14
 S BPSLISTNAV("SD")=13
 S BPSLISTNAV("VW")=1
 ;
 S BPSUC="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S BPSLC="abcdefghijklmnopqrstuvwxyz"
 ;
 ; Display the list of actions to the user once, upon executing the PR option.
 ; List can be re-displayed to the user by entering ??.
 W !
 W !,"VW View Rx          CR CRI Report       CI TPJI Claim Info  ER TPJI ECME Rx"
 W !,"CL Claim Log        IN Insurance        AP TPJI Acct Pro    ES Elig Status"
 W !,"BE Billing Events   LB List of Bills    CM TPJI AR Comm     EV Elig Verif"
 W !
 ;
SELECT1 ; Prompt user for section(s) to print.
 ;
 S DIR(0)="FOU^0:40"
 S DIR("A")="Select Report to Print"
 S DIR("?",1)=" Select one or many report(s) to print, separated by commas. When all"
 S DIR("?",2)=" reports have been selected, hit enter without making another selection."
 S DIR("?",3)=" Example: "
 S DIR("?",4)="  Select Report to Print: VW,IN,CM"
 S DIR("?")="  Select Report to Print: ES"
 S DIR("??")="^D HELP^BPSVRX3"
 ;
 D ^DIR
 ;
 ; If user enters "^" or "^^", or it times out, clear out the
 ; list and skip to end.
 ;
 I $D(DTOUT)!$D(DUOUT) K BPSLIST G SELECTQ
 ;
 ; If user entered nothing, skip to end.
 ;
 I X="" G SELECTQ
 ;
 ; Convert any lower case to upper case
 S X=$TR(X,BPSLC,BPSUC)
 ;
 F BPSX=1:1:$L(X,",") D
 . S BPSSEL=$P(X,",",BPSX)
 . I BPSSECLIST'[(","_BPSSEL_",") W !,*7," ",BPSSEL," is not a valid entry." Q
 . S BPSSECNUM=BPSLISTNAV(BPSSEL)
 . I $D(BPSLIST(BPSSECNUM)) W !,*7," ",BPSSEL," already selected." Q
 . S BPSSECBEGIN=$G(BPSVRX("LISTNAV",BPSSECNUM))
 . S BPSY=$O(BPSVRX("LISTNAV",BPSSECNUM))
 . I BPSY'="" S BPSSECEND=$G(BPSVRX("LISTNAV",BPSY))-1
 . E  S BPSSECEND=$O(^TMP("BPSVRX",$J,""),-1)
 . S BPSLIST(BPSSECNUM)=BPSSECBEGIN_"^"_BPSSECEND
 . Q
 ;
 G SELECT1
 ;
SELECTQ ;
 I '$D(BPSLIST) Q 0
 Q 1
 ;
BUILD ; Move selected compiled data into BPSAR array
 ;
 N BPSBEGIN,BPSEND,BPSLINE,BPSSECTION
 ;
 K BPSAR
 S BPSSECTION=""
 F  S BPSSECTION=$O(BPSLIST(BPSSECTION)) Q:BPSSECTION=""  D
 . S BPSBEGIN=$P(BPSLIST(BPSSECTION),U,1)
 . S BPSEND=$P(BPSLIST(BPSSECTION),U,2)
 . ;
 . S BPSLINE=BPSBEGIN-1
 . F  S BPSLINE=$O(^TMP("BPSVRX",$J,BPSLINE)) Q:'BPSLINE  Q:BPSLINE>BPSEND  D
 . . ;
 . . S BPSAR(BPSLINE)=^TMP("BPSVRX",$J,BPSLINE,0)
 Q
 ; 
DEVICE() ; Prompt user for output device.
 ; Function return values:
 ;   1 - User selected a device.
 ;   0 - User exited out.
 ;
 N BPSRETURN,DIR,POP,X,Y,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 S BPSRETURN=1
 ;
 S ZTRTN="PRINT^BPSVRX3"
 S ZTDESC="VER View Prescription Report"
 S ZTSAVE("BPS*")=""
 S ZTSAVE("VALMHDR(")=""
 ;
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S BPSRETURN=0
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR
 ;
 Q BPSRETURN
 ;
STOP()   ; Determine if user wishes to exit out of the option entirely.
 ; Function return values:
 ;   1 - Yes, exit entirely.
 ;   0 - No, do not exit but return to the previous question.
 ;
 N DIR,DIRUT,Y
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 W !
 D ^DIR
 I $D(DIRUT) S Y=1
 Q Y
 ;
PRINT ; Print sections of the list.
 ;
 ; BPSLIST will be an array of one or more sections from the existing
 ; ListMan list stored in ^TMP("BPSVRX",$J).  Format of BPSLIST:
 ;     BPSLIST(Section#) = First Line ^ Last Line
 ; Where First Line and Last Line are the first and last lines of
 ; that section in the list and Section# can be one or more numbers
 ; from 1 to 14, each corresponding to a section:
 ;      8 - AP, TPJI Account Profile
 ;      3 - BE, Billing Events
 ;      7 - CI, TPJI Claim Info
 ;      2 - CL, Claim Log
 ;      9 - CM, TPJI AR Comment History
 ;      4 - CR, Claims Response Inquiry Report
 ;     10 - ER, TPJI ECME Rx Information
 ;     11 - ES, Eligibility Status
 ;     12 - EV, Eligibility Verification
 ;      5 - IN, Insurance
 ;      6 - LB, List of Bills
 ;     14 - MP, Medication Profile
 ;     13 - SD, Sensitive Drug
 ;      1 - VW, View Rx
 ;
 N BPSCRT,BPSBEGIN,BPSDASHES,BPSEND,BPSLINE,BPSPAGE,BPSSECTION,BPSSTOP
 ;
 S BPSCRT=$S($E(IOST,1,2)="C-":1,1:0)
 S BPSPAGE=0,BPSSTOP=0,$P(BPSDASHES,"=",79)=""
 ;
 S BPSSECTION=""
 F  S BPSSECTION=$O(BPSLIST(BPSSECTION)) Q:BPSSECTION=""  D  Q:BPSSTOP
 . S BPSBEGIN=$P(BPSLIST(BPSSECTION),U,1)
 . S BPSEND=$P(BPSLIST(BPSSECTION),U,2)
 . ;
 . ; Display the header at the top of each section.
 . ;
 . D HEADER
 . ;
 . S BPSLINE=BPSBEGIN-1
 . F  S BPSLINE=$O(BPSAR(BPSLINE)) Q:'BPSLINE  Q:BPSLINE>BPSEND  D  Q:BPSSTOP
 . . ;
 . . I $Y+3>IOSL D HEADER I BPSSTOP Q
 . . ;
 . . W !,BPSAR(BPSLINE)
 . . ;
 . . Q
 . Q
 ;
 I BPSSTOP G PRINTQ
 I $Y+4>IOSL D HEADER I BPSSTOP G PRINTQ
 W !!?5,"*** End of Report ***"
 I BPSCRT S DIR(0)="E" W ! D ^DIR K DIR
 ;
PRINTQ ;
 ;
 I $D(ZTQUEUED) S ZTREQ="@"  ; If queued, purge the task after exiting.
 ;
 Q
 ;
HEADER ; Print the header.
 ;
 N BPSX
 ;
 ; If PAGE (i.e. not the first page) and device is the screen, do an
 ; end-of-page reader call.  If PAGE or screen output, do a form feed.
 ; If this is the first page ('BPSPAGE), and device is file or printer
 ; ('BPSCRT), reset the left margin ($C(13)).
 ;
 I BPSPAGE,BPSCRT S DIR(0)="E" D ^DIR K DIR I 'Y S BPSSTOP=1 G HEADERQ
 I BPSPAGE!BPSCRT W @IOF
 I 'BPSPAGE,'BPSCRT W $C(13)
 S BPSPAGE=BPSPAGE+1
 ;
 ; Write the report header.
 ;
 W "View Pharmacy Rx Report",?70,"Page: ",BPSPAGE,!
 ;
 S BPSX=0
 F  S BPSX=$O(VALMHDR(BPSX)) Q:'BPSX  W VALMHDR(BPSX),!
 W BPSDASHES
 ;
HEADERQ ;
 Q
 ;
HELP ; ?? Help - Display Options
 W !,"VW View Rx          CR CRI Report       CI TPJI Claim Info  ER TPJI ECME Rx"
 W !,"CL Claim Log        IN Insurance        AP TPJI Acct Pro    ES Elig Status"
 W !,"BE Billing Events   LB List of Bills    CM TPJI AR Comm     EV Elig Verif"
 W !
 W !," Select one or many report(s) to print, separated by commas. When all"
 W !," reports have been selected, hit enter without making another selection."
 W !," Example: "
 W !,"  Select Report to Print: VW,IN,CM"
 W !,"  Select Report to Print: ES"
 Q
