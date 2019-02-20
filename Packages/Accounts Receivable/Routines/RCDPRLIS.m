RCDPRLIS ;WISC/RFJ - list of receipts report ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,304,321**;Mar 20, 1995;Build 48
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 N %ZIS,DATEEND,DATESTRT,POP,RCFILTF,RCFILTT,RCLSTMGR,RCSORT
 N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 W !
 D DATESEL^RCRJRTRA("RECEIPT Opened")
 I '$G(DATESTRT)!('$G(DATEEND)) Q
 ;
 ; Prompt for sort order PRCA*4.5*321
 S RCSORT=$$SORTSEL()
 I RCSORT=-1 Q
 ;
 ; Prompt for filter by FMS Status PRCA*4.5*321
 D SELFILTF(.RCFILTF)
 I RCFILTF=-1 Q
 ;
 ; Prompt for filter by Payment Type PRCA*4.5*321
 D SELFILTT(.RCFILTT)
 I RCFILTT=-1 Q
 ;
 ; Ask for ListMan display, exit if timeout or '^'
 W !
 S RCLSTMGR=$$ASKLM^RCDPEARL() I RCLSTMGR<0 Q
 ;
 ; Send report to Listman if requested
 I RCLSTMGR D  D CLEAN Q
 . D DQ
 . D EN^RCDPRL
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS I POP Q
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="List of Receipts",ZTRTN="DQ^RCDPRLIS"
 .   S ZTSAVE("DATE*")="",ZTSAVE("RC*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 D DQ
 Q
 ;
DQ ;  queued report starts here
 ; PRCA*4.5*321 Extensive changes to this subroutine for filter/sort/ListMan
 N %,%I,CNT,DATA,DATE,DATEDIS1,DATEDIS2,FMSDOCNO,FMSTATUS,NOW,PAGE,PTYPE,RCDK,RCDPDATA
 N RCDPFPRE,RCIX,RCRECTDA,RCRJFLAG,RCRJLINE,RCUSER,SCREEN,SPACE,TOTALS,TYPE,X,Y
 K ^TMP($J,"RCDPRLIS")
 S SPACE=$J("",80)
 S RCDK=$$FMADD^XLFDT(DATESTRT,-1)_".24" ; Initialize start date for first $ORDER
 S DATEEND=DATEEND_".24" ; Receipt date opened can include time, so compare with midnight on the end date.
 F  S RCDK=$O(^RCY(344,"AO",RCDK)) Q:(RCDK=""!(RCDK>DATEEND))  D  ;
 . S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,"AO",RCDK,RCRECTDA)) Q:'RCRECTDA  D
 . . K RCDPDATA
 . . D DIQ344^RCDPRPLM(RCRECTDA,".01:200")
 . . ;  get fms document ^ status ^ pre lockbox patch
 . . S FMSDOCNO=$$FMSSTAT^RCDPUREC(RCRECTDA)
 . . ; Apply filter by FMS Status
 . . S FMSTATUS=$P(FMSDOCNO,"^",2)
 . . I RCFILTF,FMSTATUS'="",'$D(RCFILTF(FMSTATUS)) Q  ; this status not included
 . . ; Apply filter by Payment Type
 . . S PTYPE=RCDPDATA(344,RCRECTDA,.04,"E")
 . . I RCFILTT,PTYPE'="",'$D(RCFILTT(PTYPE)) Q  ; this status not included
 . . ;
 . . ;  compute totals by type
 . . I RCDPDATA(344,RCRECTDA,.04,"E")="" S RCDPDATA(344,RCRECTDA,.04,"E")="UNKNOWN"
 . . S $P(TOTALS(PTYPE),"^",1)=$P($G(TOTALS(PTYPE)),"^",1)+RCDPDATA(344,RCRECTDA,101,"E")
 . . S $P(TOTALS(PTYPE),"^",2)=$P($G(TOTALS(PTYPE)),"^",2)+RCDPDATA(344,RCRECTDA,.15,"E")
 . . S $P(TOTALS,"^",1)=$P($G(TOTALS),"^",1)+RCDPDATA(344,RCRECTDA,101,"E")
 . . S $P(TOTALS,"^",2)=$P($G(TOTALS),"^",2)+RCDPDATA(344,RCRECTDA,.15,"E")
 . . ;
 . . ;  opened by
 . . I RCDPDATA(344,RCRECTDA,.02,"I")=.5 D  ;
 . . . S RCUSER="ar"
 . . E  D  ;
 . . . S RCUSER=RCDPDATA(344,RCRECTDA,.02,"E")
 . . . I RCUSER'="" D
 . . . . S RCUSER=$E($P(RCUSER,",",2))_$E(RCUSER)
 . . ;
 . . S DATA=RCDPDATA(344,RCRECTDA,.01,"E")            ;receipt number
 . . S DATA=DATA_"^"_RCDPDATA(344,RCRECTDA,.03,"I")   ;date opened
 . . S DATA=DATA_"^"_RCDPDATA(344,RCRECTDA,.04,"E")   ;payment type
 . . S DATA=DATA_"^"_RCUSER                           ;user initials
 . . S DATA=DATA_"^"_RCDPDATA(344,RCRECTDA,101,"E")   ;payment count
 . . S DATA=DATA_"^"_RCDPDATA(344,RCRECTDA,.15,"E")   ;payment amount
 . . S DATA=DATA_"^"_$S($P(FMSDOCNO,"^",3):"*",1:" ") ;pre lockbox
 . . S DATA=DATA_"^"_$P(FMSDOCNO,"^")                 ;fms cr document
 . . S DATA=DATA_"^"_$P(FMSDOCNO,"^",2)               ;fms cr doc status
 . . S DATA=DATA_"^"_RCRECTDA                         ;ien of file 344
 . . ;
 . . ; Index ^TMP global by user selected sort order
 . . I RCSORT="D" S RCIX=RCDPDATA(344,RCRECTDA,.03,"I")
 . . I RCSORT="F" S RCIX=FMSTATUS
 . . I RCSORT="T" S RCIX=PTYPE
 . . S ^TMP($J,"RCDPRLIS","SORT",RCIX,RCRECTDA)=DATA
 ;
 S Y=$P(DATESTRT,".") S DATEDIS1=$$FMTE^XLFDT(Y,"2DZ")
 S Y=$P(DATEEND,".") S DATEDIS2=$$FMTE^XLFDT(Y,"2DZ")
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=1,RCRJLINE="",$P(RCRJLINE,"-",81)=""
 S SCREEN=0 I '$D(ZTQUEUED),'$G(RCLSTMGR),IO=IO(0),$E(IOST)="C" S SCREEN=1
 D HDR ; Compile header in to ^TMP for use in report or ListMan
 U IO D:'$G(RCLSTMGR) H
 S CNT=0
 S RCIX=0 F  S RCIX=$O(^TMP($J,"RCDPRLIS","SORT",RCIX)) Q:RCIX=""!($G(RCRJFLAG))  D
 . S RCRECTDA=0 F  S RCRECTDA=$O(^TMP($J,"RCDPRLIS","SORT",RCIX,RCRECTDA)) Q:'RCRECTDA!($G(RCRJFLAG))  D
 . . S DATA=^TMP($J,"RCDPRLIS","SORT",RCIX,RCRECTDA)
 . . S DATE=$P(DATA,"^",2)
 . . S CNT=CNT+1
 . . S XX=""
 . . I RCLSTMGR S XX=" "_$E(CNT_SPACE,1,4)_" "                          ; line number (for listman)
 . . S XX=XX_$$FMTE^XLFDT(DATE,"2ZD")_" "                               ; date opened
 . . S XX=XX_$E($P(DATA,"^")_SPACE,1,12)_" "                            ; receipt number
 . . S XX=XX_$E($P($P(DATA,"^",3)," ")_SPACE,1,$S(RCLSTMGR:5,1:8))_" "  ; payment type 
 . . S XX=XX_$E($P(DATA,"^",4)_SPACE,1,2)                               ; user initials
 . . S XX=XX_$J($P(DATA,"^",5),6)                                       ; payment count
 . . S XX=XX_$J($P(DATA,"^",6),$S(RCLSTMGR:11,1:13),2)_" "              ; payment amount
 . . S XX=XX_$E($P(DATA,"^",7)_SPACE,1)                                 ; pre lockbox
 . . S XX=XX_$E($P(DATA,"^",8)_SPACE,1,16)_" "                          ; fms cr document
 . . S XX=XX_$E($P(DATA,"^",9),1,$S(RCLSTMGR:8,1:9))                    ; fms cr doc status
 . . ;
 . . ; Write line or put it to global
 . . I '$G(RCLSTMGR) D  ;
 . . . W !,XX
 . . E  D  ;
 . . . S ^TMP($J,"RCDPRLIS",CNT)=XX
 . . . S ^TMP($J,"RCDPRLIS","IDX",CNT)=$P(DATA,"^",10) ; Cross reference line# vs file 344 DA
 . . ;
 . . ;  set pre lockbox flag to 1 to show note at end of report
 . . I $P(DATA,"^",7)="*" S RCDPFPRE=1
 . . ;
 . . I '$G(RCLSTMGR),$Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 ;
 I $G(RCLSTMGR) Q  ; PRCA*4.5*321 - Totals don't have a place in a protocol list with actions
 ;
 I $G(RCRJFLAG) D CLEAN Q
 I $G(RCDPFPRE) W !?54,"*CR tied to deposit"
 W !?33,"------  -----------"
 W !?33,$J($P($G(TOTALS),"^"),6),$J($P($G(TOTALS),"^",2),13,2)
 ;
 ;  show totals by type of payment
 W !!,"TOTALS BY TYPE OF PAYMENT"
 W !,"-------------------------"
 S TYPE="" F  S TYPE=$O(TOTALS(TYPE)) Q:TYPE=""!($G(RCRJFLAG))  D
 .   W !,TYPE,?33,$J($P(TOTALS(TYPE),"^"),6),$J($P(TOTALS(TYPE),"^",2),13,2)
 .   I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 ;
 W !!,"*** END OF REPORT ***",!
 ;
 I $G(RCRJFLAG) D CLEAN Q
 I SCREEN U IO(0) R !,"Press RETURN to continue:",%:DTIME
 ;
 I '$G(RCLSTMGR) D CLEAN
 Q
CLEAN ; Clean up ^TMP arrays
 D ^%ZISC
 K ^TMP($J,"RCDPRLIS")
 Q
 ;
SORTSEL() ; Select sort order for report, by Date Opened, FMS Status or Payment Type
 ; Input: None
 ; Return: Sort Type D - Date, F - FMS Status, T - Payment Type
 N DIR,X,Y,DUOUT,DTOUT,DIRUT,DIROUT,RCREP
 W !
 S DIR(0)="SOA^D:Date;F:FMS Status;T:Type of payment"
 S DIR("A")="Sort By (D)ATE OPENED, (F)MS STATUS OR (T)YPE OF PAYMENT: "
 S DIR("B")="D"
 S DIR("?",1)="Select the order you wish the receipts to appear in on the report."
 S DIR("?",2)=" "
 S DIR("?",3)="    D - Sort by the date the receipt was opened"
 S DIR("?",4)="    S - Sort by the FMS Status"
 S DIR("?")="    T - Sort by the Payment Type"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RETURN=-1
 E  S RETURN=Y
 Q RETURN
 ;
SELFILTF(RETURN) ; Ask if user want to filter by FMS status. If yes get list of status.
 ; Input: None
 ; Output: RETURN, passed by reference
 ;         RETURN - 1=Filter by FMS Status, 0=Don't
 ;         RETURN(STATUS) - array of FMS Status to include in the report
 ; 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,J,QUIT,RCODES,RCOUT,X,Y
 K RETURN
 S RETURN=0
 ;
 W !
 S DIR(0)="YA"
 S DIR("A")="Filter by FMS Status? (Y/N): "
 S DIR("B")="NO"
 S DIR("?",1)="Enter 'Y' or 'Yes' to only show receipts with selected FMS Status"
 S DIR("?",2)="Enter 'N' or 'No' if you wish to show receipts including all FMS Status"
 S DIR("?")="If you select yes, you will be prompted for the FMS Status' you wish to include"
 D ^DIR
 I $D(DIRUT) S RETURN=-1 Q
 I Y=0 Q
 S RETURN=1
 ;
 ; Prompt for status' to be included. Multi-select
 W !
 D FIELD^DID(2100.1,3,"","POINTER","RCOUT")
 S RCODES=RCOUT("POINTER")
 ; Add pseudo code to list for "NOT ENTERED", returned by FMSSTAT^RCDPUREC
 I $E(RCODES,$L(RCODES))'=";" S RCODES=RCODES_";"
 S RCODES=RCODES_"N:NOT ENTERED"
 K DIR
 S DIR(0)="SOA^"_RCODES
 S DIR("A")="Select an FMS Status to include in the report: "
 K DIR("?")
 S DIR("?",1)="Select an FMS Status to show in the report."
 S DIR("?",2)="You will be prompted multiple times, until you hit ENTER"
 S DIR("?")="without making a selection."
 S QUIT=0
 F  D  I QUIT Q
 . W !
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) K RETURN S RETURN=-1,QUIT=1 Q
 . I Y="" S QUIT=1 Q
 . S RETURN(Y(0))=""
 . ; Rebuid DIR(0) to only include codes not yet selected
 . S DIR(0)=$$BLDS(RCODES,.RETURN)
 . I $P(DIR(0),"^",2)="" S QUIT=1 ; All status selected so stop prompting.
 I RETURN=-1 Q
 ; If no FMS Status' were selected, don't filter by it.
 I $O(RETURN(""))="" D  ;
 . S RETURN=0
 . W !!,"No FMS Status' were selected. All FMS Status' will be shown",!
 Q
 ;
SELFILTT(RETURN) ; Ask if user want to filter by Payment Type. If yes get list of types.
 ; Input: None
 ; Output: RETURN, passed by reference
 ;         RETURN - 1=Filter by FMS Status, 0=Don't
 ;         RETURN(STATUS) - array of FMS Status to include in the report
 ; 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCODES,RCIEN,RCNAME,QUIT,X,Y
 K RETURN
 S RETURN=0
 ;
 W !
 S DIR(0)="YA"
 S DIR("A")="Filter by Payment Type? (Y/N): "
 S DIR("B")="NO"
 S DIR("?",1)="Enter 'Y' or 'Yes' to only show receipts with selected Payment Types"
 S DIR("?",2)="Enter 'N' or 'No' if you wish to show receipts including all Payment Types"
 S DIR("?")="If you select yes, you will be prompted for the Payment Types you wish to include"
 D ^DIR
 I $D(DIRUT) S RETURN=-1 Q
 I Y=0 Q
 S RETURN=1
 ;
 ; Prompt for types to be included. Multi-select
 W !
 K DIR
 ; Present payment types as a set of codes to streamline user interface/selection/help
 S (RCODES,RCNAME)=""
 F  S RCNAME=$O(^RC(341.1,"B",RCNAME)) Q:RCNAME=""  D  ;
 . S RCIEN=0 F  S RCIEN=$O(^RC(341.1,"B",RCNAME,RCIEN)) Q:'RCIEN  D  ;
 . . I $$GET1^DIQ(341.1,RCIEN_",",.06,"I")=1 D  ;
 . . . S RCODES=RCODES_RCIEN_":"_$$GET1^DIQ(341.1,RCIEN_",",.01,"E")_";"
 S DIR(0)="SOA^"_RCODES
 S DIR("A")="Select a Payment Type to include in the report: "
 K DIR("?")
 S DIR("?",1)="Select an Payment Type to include in the report."
 S DIR("?",2)="You will be prompted multiple times, until you hit ENTER"
 S DIR("?")="without making a selection."
 S QUIT=0
 F  D  I QUIT Q
 . W !
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) K RETURN S RETURN=-1,QUIT=1 Q
 . I Y="" S QUIT=1 Q
 . S RETURN(Y(0))=""
 . ; Rebuid DIR(0) to only include codes not yet selected
 . S DIR(0)=$$BLDS(RCODES,.RETURN)
 . I $P(DIR(0),"^",2)="" S QUIT=1 ; All status selected so stop prompting.
 ;
 I RETURN=-1 Q
 ; If no payment types were selected, don't filter by it.
 I $O(RETURN(""))="" D  ;
 . S RETURN=0
 . W !!,"No Payment Types were selected. Filter will not be used",!
 Q
 ;
BLDS(CODES,PICKED) ; Build DIR(0) string taking into account codes already picked.
 ; Input: CODES - Set of codes string in fileman format e.g. A:Apple;B:Ball;
 ;        PICKED - Array of values already picked, subscripted by external value e.g. PICKED("Apple")=""
 ; Return: RETURN in DIR(0) format. Set of codes that only includes ones not picked.
 ;         e.g "SAO^B:Ball"
 ; 
 N RETURN
 S RETURN="SOA^"
 F J=1:1:$L(CODES,";") D  ;
 . S X=$P($P(CODES,";",J),":",2)
 . I X'="",'$D(PICKED(X)) S RETURN=RETURN_$P(CODES,";",J)_";"
 Q RETURN
 ;
HDR ; Compile header into ^TMP for use in ListMan or report
 ; Input: None
 ; Output: Header information in ^TMP($J,"RCDPRLIS","HDR",n) for us in report or ListMan formats
 N K,XX
 S ^TMP($J,"RCDPRLIS","HDR",1)="LIST OF RECEIPTS REPORT"
 s XX="  DATE RANGE   : "_DATEDIS1_"  TO  "_DATEDIS2_"         "
 S XX=XX_"SORT ORDER: "_$S(RCSORT="D":"DATE OPENED",RCSORT="F":"FMS STATUS",1:"PAYMENT TYPE")
 S ^TMP($J,"RCDPRLIS","HDR",2)=XX
 ;
 I 'RCFILTF D  ;
 . S XX="ALL"
 E  D  ;
 . S XX=""
 . S K="" F  S K=$O(RCFILTF(K)) Q:K=""  S:XX'="" XX=XX_"; " S XX=XX_K
 S ^TMP($J,"RCDPRLIS","HDR",3)="  FMS STATUS   : "_$S($L(XX)>63:"SELECTED",1:XX)
 ;
  I 'RCFILTT D  ;
 . S XX="ALL"
 E  D  ;
 . S XX=""
 . S K="" F  S K=$O(RCFILTT(K)) Q:K=""  S:XX'="" XX=XX_"; " S XX=XX_K
 S ^TMP($J,"RCDPRLIS","HDR",4)="  PAYMENT TYPES: "_$S($L(XX)>63:"SELECTED",1:XX)
 S ^TMP($J,"RCDPRLIS","HDR",5)="DATE     RECEIPT      TYPE     US COUNT       AMOUNT  FMS CR DOC       STATUS"
 W !,RCRJLINE
 Q
 ;
H ;  header
 N %
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),^TMP($J,"RCDPRLIS","HDR",1),?(80-$L(%)),%
 W !,^TMP($J,"RCDPRLIS","HDR",2)
 W !,^TMP($J,"RCDPRLIS","HDR",3)
 W !,^TMP($J,"RCDPRLIS","HDR",4)
 W !,^TMP($J,"RCDPRLIS","HDR",5)
 W !,RCRJLINE
 Q
