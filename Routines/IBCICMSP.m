IBCICMSP ;DSI/JSR - ClaimsManager STATUS REPORT ;6-APR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; ** Program Description **
 ;     This routine has only 1 entry point EN.
 ;     This routine is invoked when ^IBCICMS is run from the menu option.
 ;     ^IBCICMS is and extraction routine which collects claims which
 ;     the user defined report extracted for reporting purposes.
 ;     This routine ^IBCICMSP is the print routine which permits the 
 ;     user to print the report to the screen or to queue as a background
 ;     job which can be stopped at any time using TaskManager.
 ;  Variables
 ;     IBCIPXT = (0 or 1) halts job if report is stopped.
 ;     SORT1  = will always be a 1
 ;     SORT2  = will always be a 1
 ;     SORT3  = "1" or the  Assigned to person name
 ;     SORT4  = a space concatenated with whatever data the user is
 ;              sorting by (terminal digit, Insurance company name,
 ;              patient last name, negative charge amount, or bill#. 
 ;     SORT5  = 1 will always be a 1
 ;     MAXCNT = Kernel determines the Max Lines per Page for each device
 ;     CRT    = Determines if output is sent to screen.
 ;     RPTTYP = Identifies type of report being compiled.
EN ; this is the only entry point
 N ASSIGN,AUDIT,COMMEN,CRT,DATE,EFLAG,ERRSEQ,GROUPBY,I,IBCI1,IBCI10
 N IBCI2,IBCI3,IBCI4,IBCI5,IBCI6,IBCI7,IBCI8,IBCI9,IBCIARR
 N IBCIBEG,IBCIDATA,IBCIDT,IBCIEND,IBCIPGCT,IBCIARR,IBCIEMN
 N IBCIRUN,IBCISEQ,IBCITXT,IBCIX,IBIFN,MAXCNT,PREV
 N IBCIPXT,RPTTYP,SORT1,SORT2,SORT3,SORT4,SORT5,Y,Z,X,STOP,NAME
 S ASSIGN=RPTSPECS("ASNSORT") ; PRIMARY SORT BY ASSIGN TO PERSON 1 YES 0 NO
 S COMMEN=RPTSPECS("IBCICOMM") ; FLAG PRINT COMMENT 1 YES 0 NO
 S GROUPBY=RPTSPECS("SORTBY")   ;TYPE 2=INS LOGIC DIFF SORT4
 S IBCIBEG=RPTSPECS("BEGDATE")
 S DATE=RPTSPECS("DATYP")
 S IBCIEND=RPTSPECS("ENDDATE")
 S (IBCIPXT,IBCIPGCT)=0  ; flags quit and header
 S Z=($P($G(^IBA(351.91,0)),U,4))
 F I=1:1:Z S (IBCIARR(I))=$P($G(^IBA(351.91,I,0)),U,2)  ; CM status
 S RPTTYP(1)="Terminal Digit"
 S RPTTYP(2)="Insurance Company"
 S RPTTYP(3)="Patient Last Name"
 S RPTTYP(4)="Dollar Impact"
 S RPTTYP(5)="Bill Number"  ; jsr 6/12/01
 ;
 I IOST["C" S MAXCNT=IOSL-4,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 I RPTSPECS("TYPE")="D" D PRINT  ;Detailed report ;DSI/DJW 3/21/02
 D PRINT2
 I CRT,IBCIPGCT>0,'$D(ZTQUEUED),IBCIPXT=0 S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S IBCIPXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q
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
 . . . . . . . D DATA
 . . . . . . . D LINE
 . . . . . . . I COMMEN D COMM
 ; Exit from the PRINT procedure
 Q
 ;
PRINT2 ; Print the totals by CM status at the end of the report
 ; esg - 5/22/01
 ;
 I RPTSPECS("TYPE")="D" G PR2    ; detailed report
 D HEADER
 I '$D(^TMP($J,IBCIRTN)) W ?35,"N O   D A T A   F O U N D",!! G PRX
PR2 ;
 I $D(IBCISCNT),'$G(IBCIPXT),'$G(ZTSTOP) D TOTALS
 ;
PRX ; Exit from the PRINT2 procedure
 Q
 ;
 ;
HEADER ; header for main report
 I CRT,IBCIPGCT>0,'$D(ZTQUEUED),IBCIPXT=0 S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S IBCIPXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q
 S IBCIPGCT=IBCIPGCT+1
 W @IOF,!,"ClaimsManager Status Report sort by "_RPTTYP(GROUPBY)_" for "
 W $E(IBCIBEG,4,5)_"/"_$E(IBCIBEG,6,7)_"/"_$E(IBCIBEG,2,3)_" thru "_$E(IBCIEND,4,5)_"/"_$E(IBCIEND,6,7)_"/"_$E(IBCIEND,2,3)
 W ?100,"Page :"_IBCIPGCT,!
 I RPTSPECS("TYPE")="S" W "Summary Report"
 E  W "Detailed Report"
 S Y=$$NOW^XLFDT X ^DD("DD") S IBCIRUN=Y
 W ?100,"Run Date: "_IBCIRUN,!!
 ;
 ; skip the column headings for the summary report
 I RPTSPECS("TYPE")="S" G HEADERX
 ;
 I DATE=1 W ?8,"BILL NO.",?18,"PATIENT NAME",?44,"PID",?50," EVENT",?60,"BILLER",?68,"CODER",?76,"ASSIGN",?84,"ERROR CODES",?102,"TYPE",?108,"CHARGES",?116,"CM STATUS"
 E  W ?8,"BILL NO.",?18,"PATIENT NAME",?44,"PID",?50," ENTER",?60,"BILLER",?68,"CODER",?76,"ASSIGN",?84,"ERROR CODES",?102,"TYPE",?108,"CHARGES",?116,"CM STATUS"
 N X S $P(X,"=",130)="" W !,X,!
HEADERX ;
 Q
 ; 
HEAD2 ; only printed when insurance is a selected sort
 Q:GROUPBY'=2
 Q:IBCIPXT=1
 I $Y+4>MAXCNT,IBCIPXT=0 D HEADER
 I $Y=6,IBCIPXT=0 W ?2,"INSURANCE: "_SORT4,!
 E  W:IBCIPXT=0 !,?2,"INSURANCE: "_SORT4,!
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
 S IBCIX=(IBCIARR(IBCI9))
 Q
COMM ; print CM user comments these comments are keyed by the user
 I '$D(^IBA(351.9,IBIFN,2,0)) W ! Q  ; JSR 6/13/01 line feed correction
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
 W ?8,IBCI1,?19,$E(NAME,1,23),?44,$E(IBCI2,6,9),?50,IBCIDT
 W ?60,$E(IBCI4,1,6),?68,$E(IBCI5,1,6),?76,$E(IBCI6,1,6),?84,IBCI10
 W ?102,IBCI7,?108,$J($FN(IBCI8,",",0),6),?116,IBCIX,!
 Q
XIT ; one exit point
 Q
 ;
 ;
TOTALS ; Print totals - esg - 5/22/01
 NEW CMDESC,CMSTS
 I $Y+5>MAXCNT D HEADER Q:IBCIPXT!$G(ZTSTOP)
 W !!?32,"ClaimsManager Bill Totals by ClaimsManager Status",!
 S CMDESC=""
 F  S CMDESC=$O(^IBA(351.91,"B",CMDESC)) Q:CMDESC=""  D  Q:IBCIPXT!$G(ZTSTOP)
 . S CMSTS=0
 . F  S CMSTS=$O(^IBA(351.91,"B",CMDESC,CMSTS)) Q:'CMSTS  D  Q:IBCIPXT!$G(ZTSTOP)
 .. I '$D(IBCISCNT(1,CMSTS)) Q    ; no bill with this status on report
 .. I $Y+3>MAXCNT D HEADER Q:IBCIPXT!$G(ZTSTOP)
 .. W !?22,$P(^IBA(351.91,CMSTS,0),U,1),?63,$J(IBCISCNT(1,CMSTS),6)
 .. W ?76,$J("$"_$FN(IBCISCNT(2,CMSTS),",",0),12)
 .. Q
 . Q
 Q:IBCIPXT!$G(ZTSTOP)
 I $Y+4>MAXCNT D HEADER Q:IBCIPXT!$G(ZTSTOP)
 W !?62,"-------",?75,"-------------"
 W !?22,"GRAND TOTAL",?63,$J(IBCISCNT(1),6)
 W ?76,$J("$"_$FN(IBCISCNT(2),",",0),12)
 Q
 ;
