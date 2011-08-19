IBCICMEP ;DSI/JSR - ClaimsManager ERROR REPORT ;6-APR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; ** Program Description **
 ;     This routine has only 1 entry point EN.
 ;     This routine is invoked when ^IBCICME is run from the menu option.
 ;     ^IBCICME is and extraction routine which collects claims which
 ;     the user defined report extracted for reporting purposes.
 ;     This routine ^IBCICMEP is the print routine which permits the 
 ;     user to print the report to the screen or to queue as a background
 ;     job which can be stopped at any time using TaskManager.
 ;  Variables
 ;     IBCIPXT = (0 or 1) halts job if report is stopped.
 ;     SORT1  = will always be a 1 (reserved for future use)
 ;     SORT2  = space concatenated with the Error Code Mnemonic or a 1
 ;              this is a flag type indicator.  1 indicates that the
 ;              report will print all errors for a bill
 ;              Sort2'=1 indicates that the report will print all Bills
 ;              for a ClaimsManager Error Code (JSR 6/12/01)
 ;     SORT3  = "1" or the  Assigned to person name
 ;     SORT4  = a space concatenated with whatever data the user is
 ;              sorting by (terminal digit, Insurance company name,
 ;              patient last name, negative charge amount or bill #. 
 ;     SORT5  = Sort5 will always be a 1 (reserved for future use
 ;              possible insurance group ID). 
 ;     MAXCNT = Kernel determines the Max Lines per Page for each device
 ;     CRT    = Determines if output is sent to screen.
 ;     RPTTYP = Identifies type of report being compiled.
EN ; this is the only entry point
 N ASSIGN,AUDIT,COMMEN,CRT,DATE,EFLAG,ERRSEQ,GROUPBY,I,IBCI1,IBCI10
 N IBCI11,IBCI12,IBCI2,IBCI3,IBCI4,IBCI5,IBCI6,IBCI7,IBCI8,IBCI9,IBCIARR
 N IBCIBEG,IBCID2,IBCIDATA,IBCIDT,IBCIEND,IBCIPGCT,IBCIARR,IBCIEMN
 N IBCIQT,IBCIRUN,IBCISEQ,IBCITOT,IBCITXT,IBCIX,IBIFN,MAXCNT,PREV
 N IBCIPXT,RPTTYP,SORT1,SORT2,SORT3,SORT4,SORT5,IBCIX,Y,Z,X,STOP,NAME
 S ASSIGN=RPTSPECS("ASNSORT") ; PRIMARY SORT BY ASSIGN TO PERSON 1 YES 0 NO
 S COMMEN=RPTSPECS("IBCICOMM") ; FLAG PRINT COMMENT 1 YES 0 NO
 S GROUPBY=RPTSPECS("SORTBY")   ;TYPE 2=INS LOGIC DIFF SORT4
 S IBCIBEG=RPTSPECS("BEGDATE")
 S DATE=RPTSPECS("DATYP")
 S IBCIEND=RPTSPECS("ENDDATE")
 S EFLAG=RPTSPECS("DISPLAY ERROR TEXT")  ; 1 print error txt 0 don't
 S (IBCIPXT,IBCIPGCT)=0  ; flags quit and header
 S Z=($P($G(^IBA(351.91,0)),U,4))
 F I=1:1:Z S (IBCIARR(I))=$P($G(^IBA(351.91,I,0)),U,2)  ; CM status
 S RPTTYP(1)="Terminal Digit"
 S RPTTYP(2)="Insurance Company"
 S RPTTYP(3)="Patient Last Name"
 S RPTTYP(4)="Dollar Impact"
 S RPTTYP(5)="Bill Number"  ;JSR 6/12/2001
 ;
 I IOST["C" S MAXCNT=IOSL-4,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 I RPTSPECS("TYPE")="D" D PRINT  ; Detailed Report ;DSI/DJW 3/21/02
 I IBCIPXT=0 D PRINT2
 I CRT,IBCIPGCT>0,'$D(ZTQUEUED),IBCIPXT=0 S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S IBCIPXT=1 Q
 G XIT
 Q
PRINT ; prints data extracted
 I '$D(^TMP($J,IBCIRTN)) D HEADER W ?35,"N O   D A T A   F O U N D",!!
 S SORT1="" F  S SORT1=$O(^TMP($J,IBCIRTN,SORT1)) Q:SORT1=""!(IBCIPXT=1)!($G(ZTSTOP))   D
 . S SORT2="" F  S SORT2=$O(^TMP($J,IBCIRTN,SORT1,SORT2)) Q:SORT2=""!(IBCIPXT=1)!($G(ZTSTOP))   D
 . . S SORT3="" F  S SORT3=$O(^TMP($J,IBCIRTN,SORT1,SORT2,SORT3)) Q:SORT3=""!(IBCIPXT=1)!($G(ZTSTOP))   D
 . . . I ASSIGN D HEADER
 . . . S SORT4="" F  S SORT4=$O(^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4)) Q:SORT4=""!(IBCIPXT=1)!($G(ZTSTOP))   D
 . . . . S PREV=SORT4
 . . . . I GROUPBY=2,IBCIPXT=0,IBCIPGCT>0 D HEAD2
 . . . . S SORT5="" F  S SORT5=$O(^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4,SORT5)) Q:SORT5=""!(IBCIPXT=1)!($G(ZTSTOP))   D
 . . . . . S NAME="" F  S NAME=$O(^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4,SORT5,NAME)) Q:NAME=""!(IBCIPXT=1)!($G(ZTSTOP))   D
 . . . . . . S IBIFN="" F  S IBIFN=$O(^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4,SORT5,NAME,IBIFN)) Q:IBIFN=""!(IBCIPXT=1)!($G(ZTSTOP))   D
 . . . . . . . S IBCIEMN="" F  S IBCIEMN=$O(^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4,SORT5,NAME,IBIFN,IBCIEMN)) Q:IBCIEMN=""!(IBCIPXT=1)!($G(ZTSTOP))  D
 . . . . . . . . D DATA
 . . . . . . . . D LINE
 . . . . . . . . I EFLAG D ERROR
 . . . . . . . I COMMEN D COMM
 Q
PRINT2 ; print audit report
 I RPTSPECS("TYPE")="D",('$D(^TMP($J,IBCIRTN))) Q
 D HEADA
 I IBCIPXT=1 Q
 ; JSR 6/12/01 change to accommodate new request PRINT2+2 thru PRINT2+9
 I '$D(^TMP($J,IBCIRTN)) W ?35,"N O   D A T A   F O U N D",! Q
 S SORT1="" F  S SORT1=$O(^TMP($J,IBCIRTN_"-TOTALS",SORT1)) Q:SORT1=""!(IBCIPXT=1)!($G(ZTSTOP))   D
 . I $Y+1>MAXCNT D HEADER
 . S AUDIT=^TMP($J,IBCIRTN_"-TOTALS",SORT1)
 . W ?20,SORT1,?40,$J($FN(AUDIT,","),9),!
 W !
 S IBCITOT=$G(^TMP($J,IBCIRTN_"-TOTALS"))
 ; JSR ===
 W ?20,"Total # Claims",?40,$J($FN($P($G(IBCITOT),U,1),","),9),!
 W ?20,"Total # Errors",?40,$J($FN($P($G(IBCITOT),U,2),","),9),!
 Q
HEADER ; header for main report
 I CRT,IBCIPGCT>0,'$D(ZTQUEUED),IBCIPXT=0 S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S IBCIPXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q
 S IBCIPGCT=IBCIPGCT+1
 W @IOF,!,"ClaimsManager Detailed Error Report sort by "_RPTTYP(GROUPBY)_" for "
 W $E(IBCIBEG,4,5)_"/"_$E(IBCIBEG,6,7)_"/"_$E(IBCIBEG,2,3)_" thru "_$E(IBCIEND,4,5)_"/"_$E(IBCIEND,6,7)_"/"_$E(IBCIEND,2,3)
 W ?100,"Page :"_IBCIPGCT,!
 S Y=$$NOW^XLFDT X ^DD("DD") S IBCIRUN=Y
 W "Detailed Report",?100,"Run Date: "_IBCIRUN,!!
 I DATE=1 W ?1,"ERROR",?8,"BILL NO.",?18,"PATIENT NAME",?44,"PID",?50," EVENT",?60,"BILLER",?68,"CODER",?76,"ASSIGN",?84,"ERROR CODES",?102,"TYPE",?108,"CHARGES",?116,"CM STATUS"
 E  W ?1,"ERROR",?8,"BILL NO.",?18,"PATIENT NAME",?44,"PID",?50," ENTER",?60,"BILLER",?68,"CODER",?76,"ASSIGN",?84,"ERROR CODES",?102,"TYPE",?108,"CHARGES",?116,"CM STATUS"
 N X S $P(X,"=",130)="" W !,X,!
 Q 
HEAD2 ; only printed when insurance is a selected sort
 Q:GROUPBY'=2
 Q:IBCIPXT=1
 I $Y+4>MAXCNT,IBCIPXT=0 D HEADER
 I $Y=6,IBCIPXT=0 W ?2,"INSURANCE: "_SORT4,!
 E  W:IBCIPXT=0 !,?2,"INSURANCE: "_SORT4,!
 Q
HEADA ; only for audit header
 I CRT,IBCIPGCT>0,'$D(ZTQUEUED),IBCIPXT=0 S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S IBCIPXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q
 S IBCIPGCT=IBCIPGCT+1
 W @IOF,!,"ClaimsManager Audit Error Report for "
 W $E(IBCIBEG,4,5)_"/"_$E(IBCIBEG,6,7)_"/"_$E(IBCIBEG,2,3)_" thru "_$E(IBCIEND,4,5)_"/"_$E(IBCIEND,6,7)_"/"_$E(IBCIEND,2,3)
 W ?100,"Page :"_IBCIPGCT,!
 I RPTSPECS("TYPE")="S" W "Summary Report"
 E  W "Detailed Report"
 S Y=$$NOW^XLFDT X ^DD("DD") S IBCIRUN=Y
 W ?100,"Run Date: "_IBCIRUN,!!
 Q
DATA ; formats line item data - note claims with same edit error mnemonic
 ; may print mulitple times if the HFCA line item is an unique line
 ; with the same error type. The report prints the error mnemonic and
 ; the HCFA line # as it relates to IB.
 S IBCIDATA=^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4,SORT5,NAME,IBIFN)
 S IBCI1=$P(IBCIDATA,U,1)  ; [1] External Bill#
 S IBCI2=$P(IBCIDATA,U,2)  ; [2] Patient SSN
 S IBCI3=$P(IBCIDATA,U,3)  ; ck logic [3] EventDate or Bill
 S IBCIDT=$E(IBCI3,4,5)_"/"_$E(IBCI3,6,7)_"/"_$E(IBCI3,2,3)
 S IBCI4=$P(IBCIDATA,U,4)  ; [4] Biller name
 S IBCI5=$P(IBCIDATA,U,5)  ; [5] Coder name
 S IBCI6=$P(IBCIDATA,U,6)  ; [6] Assigned to person name
 S IBCI7=$P(IBCIDATA,U,7)  ;[7] inpatient/outpatient flag
 S IBCI8=$P(IBCIDATA,U,8)  ;[8] Charges
 S IBCI9=$P(IBCIDATA,U,9)  ;[9] ien of current ClaimsManager
 S IBCI10=$P(IBCIDATA,U,10)  ;[10] String of error code mne
 S IBCID2=^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4,SORT5,NAME,IBIFN,IBCIEMN)
 S IBCI11=$P(IBCID2,U,1)
 S IBCI12=$P(IBCID2,U,2)  ; jsr 6/12/01
 S IBCIX=(IBCIARR(IBCI9))
 Q
ERROR ; this is a unique error which CM reports
 S ERRSEQ=0 F  S ERRSEQ=$O(^IBA(351.9,IBIFN,1,IBCIEMN,1,ERRSEQ)) Q:'ERRSEQ!(IBCIPXT=1)  D
 . I $Y+2>MAXCNT D HEADER
 . Q:IBCIPXT=1
 . S IBCITXT=$G(^IBA(351.9,IBIFN,1,IBCIEMN,1,ERRSEQ,0))
 . I ERRSEQ=1 W ?10,"CM Error Message: "
 . I $Y+1>MAXCNT,IBCIPXT=0 D HEADER
 . W ?28,IBCITXT,!
 W !
 Q
COMM ; print CM user comments these comments are keyed by the user
 Q:'$D(^IBA(351.9,IBIFN,2,0))
 I $Y+2>MAXCNT,IBCIPXT=0 D HEADER
 Q:IBCIPXT=1
 W ?10,$$CMTINFO^IBCIUT5(IBIFN),!
 S IBCISEQ=0 F  S IBCISEQ=$O(^IBA(351.9,IBIFN,2,IBCISEQ)) Q:'IBCISEQ!(IBCIPXT=1)  D
 . S IBCITXT=$G(^IBA(351.9,IBIFN,2,IBCISEQ,0))
 . I $Y+1>MAXCNT,IBCIPXT=0 D HEADER
 . Q:IBCIPXT=1
 . W ?28,IBCITXT,!
 W !
 Q
LINE ; print report detail line
 Q:IBCIPXT=1
 I $Y+1>MAXCNT,IBCIPXT=0 D HEADER
 I IBCIPGCT=0,IBCIPXT=0 D HEADER D HEAD2
 Q:IBCIPXT=1
 W ?1,IBCI12_"*"_IBCI11,?8,IBCI1,?19,$E(NAME,1,23),?44,$E(IBCI2,6,9)
 W ?50,IBCIDT,?60,$E(IBCI4,1,6),?68,$E(IBCI5,1,6),?76,$E(IBCI6,1,6)
 W ?84,IBCI10,?102,IBCI7,?108,$J($FN(IBCI8,",",0),6),?116,IBCIX,!
 Q
XIT ; one exit point
 Q
