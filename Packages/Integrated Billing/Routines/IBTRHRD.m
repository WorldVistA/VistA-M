IBTRHRD ;ALB/JWS - CLAIMS TRACKING 278 DISPOSITION REPORT ;21-SEP-2015
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
% ;
 ; FILTERS array is built
 ; FILTERS(0)[1] = 1 if report by Staff
 ;                 2 if report by Patient
 ;                 3 if report by Date
 ; FILTERS(0)[2] = 
 ; FILTERS(0)[3] = 0 (or null) if All staff, 1 if selected staff
 ; FILTERS(0)[4] = 0 (or null) if All Patients, 1 if selected patients
 ; FILTERS(0)[5] =
 ; FILTERS(0)[6] = sort, 1 = name, 2 = date
 ; FILTERS(2,staff name) = ien
 ; FILTERS(3,patient name) = ien
 ; FILTERS(4)[1] = from date
 ; FILTERS(4)[2] = through date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,RPTDATE,IBQUIT,FILTERS,OK
 I '$D(DT) D DT^DICRW
 W !!,"278 Deletion Disposition Report"
 ; selection filter
 S DIR(0)="S^1:Report by Staff;2:Report by Patient;3:Report by Date Range^I '$F("",1,2,3"","",""_X) K X"
 S DIR("A")="Select the type of report to generate"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="1    Report by Staff"
 S DIR("L",4)="2    Report by Patient"
 S DIR("L",5)="3    Report by Date Range"
 S DIR("?",1)="Select how you wish to select the entries to display on the report."
 S DIR("?",2)=""
 S DIR("?",3)="1 will allow you to select one or more Staff members to report on."
 S DIR("?",4)="2 will allow you to select one or more Patients to report on."
 S DIR("?")="3 will allow you to select a Date Range of 278 transactions to report on."
 W ! D ^DIR K DIR
 I $G(DIRUT) Q
 S FILTERS(0)=Y
 I Y=1 D STAFF G 1
 I Y=3 G 1
 I Y=2 D PAT
 ;
1 ;
 S RPTDATE=$$FMDATES("") I RPTDATE="" Q
 S FILTERS(4)=RPTDATE
 S DIR(0)="Y",DIR("A")="Include Delete Reason",DIR("B")="NO"
 S DIR("?",1)="     Enter:  'Y'  -  to include the Delete Reason Codes on report."
 S DIR("?",2)="             'N'  -  to exclude the Delete Reason Codes on report."
 S DIR("?")="             '^'  -  to exit this report."
 D ^DIR K DIR
 I $G(DIRUT) Q
 S $P(FILTERS(0),"^",8)=+Y
 I $P(FILTERS(0),"^")=3 S $P(FILTERS(0),"^",6)=2 G 4
 ;I $P(FILTERS(0),"^")=1 G 2
 I $P(FILTERS(0),"^")=2 G 3
 ;
2 ;
 S OK=1,X=$P(FILTERS(0),"^",3)
 I X S X=$O(FILTERS(2,"")) I X,$O(FILTERS(2,X))="" S OK=0,$P(FILTERS(0),"^",6)=1
 I OK D  I $G(DIRUT) Q
 . S DIR(0)="S^1:Staff Name;2:Date^I '$F("",1,2"",X) K X"
 . S DIR("A")="Select the Primary Sort"
 . S DIR("L",1)="Select one of the following:"
 . S DIR("L",2)=""
 . S DIR("L",3)="1    Staff Name"
 . S DIR("L",4)="2    Date"
 . S DIR("?",1)="Select how you wish to sort the entries on this report."
 . S DIR("?",2)=""
 . S DIR("?",3)="1 will sort the entries by Staff Name."
 . S DIR("?")="2 will sort the entries by 278 Transaction Date."
 . W ! D ^DIR K DIR
 . I $G(DIRUT) Q
 . S $P(FILTERS(0),"^",6)=Y
 . Q
 G 4
 ;
3 ;
 S OK=1,X=$P(FILTERS(0),"^",4)
 I X S X=$O(FILTERS(3,"")) I X,$O(FILTERS(3,X))="" S OK=0,$P(FILTERS(0),"^",6)=1
 I OK D  I $G(DIRUT) Q
 . S DIR(0)="S^1:Patient Name;2:Date^I '$F("",1,2"",X) K X"
 . S DIR("A")="Select the Primary Sort"
 . S DIR("L",1)="Select one of the following:"
 . S DIR("L",2)=""
 . S DIR("L",3)="1    Patient Name"
 . S DIR("L",4)="2    Date"
 . S DIR("?",1)="Select how you wish to sort the entries on this report."
 . S DIR("?",2)=""
 . S DIR("?",3)="1 will sort the entries by Patient Name."
 . S DIR("?")="2 will sort the entries by 278 Transaction Date."
 . W ! D ^DIR K DIR
 . I $G(DIRUT) Q
 . S $P(FILTERS(0),"^",6)=Y
 . Q
4 ;
 D DEV
 Q
 ;
STAFF ; Staff ( New Person file) filter
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S",DIR("A")="Select(A)ll or (S)elected Staff",DIR("B")="All"
 S DIR("?",1)="Enter 'A' to select all Staff Members."
 S DIR("?")="Enter 'S' to select specific Staff Members."
 S $P(DIR(0),"^",2)="A:All Staff Members;S:Selected Staff Members"
 W ! D ^DIR K DIR
 I $G(DIRUT) Q 0
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),"^",3)=$S(Y="A":0,1:1)
 ; Set staff
 I $P(FILTERS(0),"^",3)=1 D ASKSTAFF(.FILTERS)
 Q
 ;
PAT ; Patient filter
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S",DIR("A")="Select(A)ll or (S)elected Patient(s)",DIR("B")="All"
 S DIR("?",1)="Enter 'A' to select all Patients."
 S DIR("?")="Enter 'S' to select specific Patients."
 S $P(DIR(0),"^",2)="A:All Patients;S:Selected Patients"
 W ! D ^DIR K DIR
 I $G(DIRUT) Q 0
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),"^",4)=$S(Y="A":0,1:1)
 ; Set Patient
 I $P(FILTERS(0),"^",4)=1 D ASKPAT(.FILTERS)
 Q
 ;
DEV ; -- select device, run option
 ;W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBTRHRD",ZTSAVE("IB*")="",ZTDESC="IB - 278 Statistical Volume Report" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
 ;
 U IO
 S X=80 X ^%ZOSF("RM")
DQ D PRINT G END
 Q
 ;
END ; -- Clean up
 ;;K ^TMP($J) W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K I,J,X,Y,DFN,%ZIS,VA,IBTRN,IBTRND,IBPAG,IBHDT,IBDT,IBBDT,IBEDT,IBQUIT
 Q
 ;
PRINT ; -- print one billing report from ct
 W !,"Compiling report data..."
 N SDT,EDT,IEN,NODE0,PATIEN,INSIEN,IBQUIT,IBPAG,CERT,PATINS,STAFF
 S IBHDT=$$HTE^XLFDT($H,1),IBQUIT=0,IBPAG=0
 K ^TMP($J)
 S SDT=$P(FILTERS(4),"^"),EDT=$P(FILTERS(4),"^",2)
 F  S SDT=$O(^IBT(356.22,"F",SDT)) Q:SDT=""  Q:$P(SDT,".")>EDT  D
 . S IEN=0 F  S IEN=$O(^IBT(356.22,"F",SDT,IEN)) Q:IEN=""  Q:$G(IBQUIT)  D
 .. S NODE0=$G(^IBT(356.22,IEN,0)) I NODE0'="" D
 ... I $P(NODE0,"^",20)=2 Q  ;skip response entries 1/19/16
 ... ;;I $P(NODE0,"^",15)="" Q  ;must have been submitted
 ... ;I $P(NODE0,"^",11)="" Q  ;278 has not been 'worked' for submission
 ... S PATIEN=$P(NODE0,"^",2),INSIEN=$P(NODE0,"^",3)
 ... I PATIEN="" Q
 ... I INSIEN="" Q
 ... S PATINS=$P($G(^DPT(PATIEN,.312,INSIEN,0)),"^") I PATINS="" Q
 ... S OK=1
 ... I $P(FILTERS(0),"^")=1 D  I 'OK Q
 .... S STAFF=$P(NODE0,"^",24) I STAFF="" S OK=0 Q
 .... I $P(FILTERS(0),"^",3) D  I 'OK Q
 ..... I '$D(FILTERS(2,STAFF)) S OK=0 Q
 ..... Q
 .... Q
 ... I $P(FILTERS(0),"^")=2 D  I 'OK Q
 .... I $P(FILTERS(0),"^",4) D  I 'OK Q
 ..... I '$D(FILTERS(3,PATIEN)) S OK=0 Q
 ..... Q
 .... Q
 ... D SET
 .. Q
 . Q
 ;
PR ;
 D HDR
 I '$D(^TMP($J,"IBTRHRD")) W !!,"No 278 Transactions found in date range.",! G PR1
 N Z1,Z2,Z3,TOT1,TOT2,TOT3,TOT4,TOT5,TOT6,TOT7,TOT8,TOT9,DATA,DDATA
 N GTOT1,GTOT2,GTOT3,GTOT4,GTOT5,GTOT6,GTOT7,GTOT8,GTOT9,D1,D2
 S (Z1,Z2)=""
 F  S Z1=$O(^TMP($J,"IBTRHRD",Z1)) Q:Z1=""!($G(IBQUIT))  D  Q:IBQUIT
 . S Z2=""  F  S Z2=$O(^TMP($J,"IBTRHRD",Z1,Z2)) Q:Z2=""!($G(IBQUIT))  S DATA=$G(^(Z2)) I DATA'="" D
 .. I ($Y+5)>IOSL D HDR Q:IBQUIT
 .. I $P(FILTERS(0),"^",6)=1 W !,$E(Z1,1,23) I $P(FILTERS(0),"^")'=3 W ?25,$E(Z2,4,5),"/",$E(Z2,6,7),"/",$E(Z2,2,3)
 .. I $P(FILTERS(0),"^",6)=2 D
 ... I $P(FILTERS(0),"^")=3 W !,$E(Z1,4,5),"/",$E(Z1,6,7),"/",$S($E(Z1)=3:20,1:19),$E(Z1,2,3) Q
 ... W !,$E(Z2,1,23),?25,$E(Z1,4,5),"/",$E(Z1,6,7),"/",$E(Z1,2,3)
 .. W ?47,$J(+$P(DATA,"^"),3),?69,$J(+$P(DATA,"^",2),3)
 .. I $P(FILTERS(0),"^",8),$O(^TMP($J,"IBTRHRD",Z1,Z2,"")) D
 ... W !?10,"Detail Delete Reason:",?40,"---"
 ... S Z3="" F  S Z3=$O(^TMP($J,"IBTRHRD",Z1,Z2,Z3)) Q:Z3=""  S DDATA=$G(^(Z3)) I DDATA D
 .... S D1=$$GET1^DIQ(356.023,Z3_",",.01)
 .... S D2=$$GET1^DIQ(356.023,Z3_",",.02)
 .... W !?10,D1,"-",$E(D2,1,25),?41,DDATA
 .... Q
 .. S TOT1=$G(TOT1)+$P(DATA,"^"),TOT2=$G(TOT2)+$P(DATA,"^",2)
 . I +$G(TOT1)=0,+$G(TOT2)=0 Q
 . I $P(FILTERS(0),"^")'=3 D  ;don't print subtotals when selecting by date
 .. N CHK S CHK=$O(FILTERS(2,"")) I CHK'="",$O(FILTERS(2,CHK))="" Q
 .. S CHK=$O(FILTERS(3,"")) I CHK'="",$O(FILTERS(2,CHK))="" Q
 .. W !?38,$TR($J(" ",42)," ","-")
 .. W !,"   Total"
 .. W ?46,$J(TOT1,4),?68,$J(TOT2,4)
 .. W !
 . S GTOT1=$G(GTOT1)+$G(TOT1),GTOT2=$G(GTOT2)+$G(TOT2)
 . S (TOT1,TOT2)=""
 . Q
 I +$G(GTOT1)=0,+$G(GTOT2)=0 G PR1
 W !,?25,$TR($J(" ",55)," ","=")
 W !,"Grand Total"
 W ?46,$J(GTOT1,4),?68,$J(GTOT2,4)
 W !
PR1 ;
 W !,?(80-$L("*** END OF REPORT ***")\2),"*** END OF REPORT ***"
 I $D(ZTQUEUED) G END
 Q
 ;
HDR ; -- Print header for billing report
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !," 278 Deletion Disposition Report",?40,IBHDT,?72,"Page: ",IBPAG
 W !," Sort by: ",$S($P(FILTERS(0),"^",6)=1:$S($P(FILTERS(0),"^")=1:"Staff",1:"Patient"),1:"Date")
 W !,?30,"Report Timeframe:"
 S SDT=$P(FILTERS(4),"^"),EDT=$P(FILTERS(4),"^",2)
 W !,?27,$E(SDT,4,5),"/",$E(SDT,6,7),"/",$S($E(SDT)=3:20,1:19),$E(SDT,2,3)
 W " - ",$E(EDT,4,5),"/",$E(EDT,6,7),"/",$S($E(EDT)=3:20,1:19),$E(EDT,2,3)
 I $P(FILTERS(0),"^")=1 W !?31,$S($P(FILTERS(0),"^",3)=1:"Selected",1:"All")," Staff"
 I $P(FILTERS(0),"^")=2 W !?31,$S($P(FILTERS(0),"^",4)=1:"Selected",1:"All")," Patient(s)"
 I $P(FILTERS(0),"^")=3 W !?31,"Selected Dates"
 W !!,$S($P(FILTERS(0),"^")=1:"Staff",$P(FILTERS(0),"^")=2:"Patient",1:"Date")
 I $P(FILTERS(0),"^")'=3 W ?27,"Date"
 W ?43,"#278s Submitted",?64,"#Delete Reasons"
 W !,$TR($J(" ",80)," ","=")
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 W !!,"....task stopped at user request"
 Q
 ;
SET ; -- set tmp array
 N PIECE,ST1,ST2,INS,DATE,TRANST,DELETE,COUNT
 S TRANST=+$P(NODE0,"^",20)
 I $P(FILTERS(0),"^")=1 D
 . I $D(FILTERS(2,STAFF)) S INS=FILTERS(2,STAFF)
 . E  S INS=$$GET1^DIQ(200,STAFF_",",.01)
 . I INS="" S INS="UNKNOWN" Q
 I $P(FILTERS(0),"^")=2 D
 . I $D(FILTERS(3,PATIEN)) S INS=FILTERS(3,PATIEN)
 . E  S INS=$$GET1^DIQ(2,PATIEN_",",.01)
 . I INS="" S INS="INKNOWN" Q
 I $P(FILTERS(0),"^")=3 S INS=$P(SDT,".")
 I $P(FILTERS(0),"^",6)=1 S ST1=INS,ST2=$P(SDT,".")
 I $P(FILTERS(0),"^",6)=2 S ST1=$P(SDT,"."),ST2=INS
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 D HDR W !!,"....task stopped at user request" Q
 S DELETE=$P(NODE0,"^",25)
 S COUNT=$G(^TMP($J,"IBTRHRD",ST1,ST2))
 ; count[1] = number of 278s submitted
 I +TRANST<2,$P(NODE0,"^",12)'="" S $P(COUNT,"^")=$P(COUNT,"^")+1
 ; count[2] = number of 278s deleted
 I DELETE D
 . S $P(COUNT,"^",2)=$P(COUNT,"^",2)+1
 . I +$P(FILTERS(0),"^",8) S ^(DELETE)=$G(^TMP($J,"IBTRHRD",ST1,ST2,DELETE))+1
 S ^TMP($J,"IBTRHRD",ST1,ST2)=COUNT
 Q
 ;
FMDATES(PROMPT) ; ask for date range
 N %DT,X,Y,DT1,DT2,IB1,IB2
 S DT1="",IB1="Start Date: ",IB2="End Date: "
 I $G(PROMPT)'="" S IB1="Start with "_PROMPT_": ",IB2="Go to "_PROMPT_": "
FM1 ;
 S %DT="AEX",%DT("A")=IB1 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FM1E:(Y<0&(X="")),FMDQ
 S (%DT(0),DT2)=$P(Y,".",1) I DT2'>DT S %DT("B")="Today"
FM2 ;
 S %DT="AEX",%DT("A")=IB2 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FM2E:(Y<0&(X="")),FMDQ
 S DT1=DT2_"^"_$P(Y,".",1)
FMDQ ;
 Q DT1
FM1E ;
 W !,"A date must be entered." G FM1
FM2E ;
 W !,"A date must be entered." G FM2
 Q
 ;
ASKSTAFF(FILTERS)   ; Sets a list of staff
 ; Input:   FILTERS - Current Array of filter settings
 ; Output:  FILTERS - Updated Array of filter settings
 N DIC,DIR,DIRUT,DIVS,DUOUT,IBIENS,IEN,N,NM,NODE,X,XX,Y
 S DIC=200,DIC(0)="AEM"
 F  D  Q:+IEN<1
 . D ONE(.DIC,.IEN)
 . Q:+IEN<1
 . S FILTERS(2,$P(IEN,"^"))=$P(IEN,"^",2)
 Q
 ;
ONE(DIC,IEN)  ; Prompts the user for Payer
 ; Input:   DIC     - Variable/Array of settings needed for ^DIC call
 ;          
 ; Output:  IEN     - IEN of the selected Payer Entry
 ;                    null if no selection was made
 S DIC("A")="Select "_$S(DIC=200:"Staff Member: ",DIC="^VA(200,":"Staff Member: ",DIC=2:"Patient: ",DIC="^DPT(":"Patient: ",1:"Payer: ")
 D ^DIC
 S IEN=Y
 Q
 ;
ASKPAT(FILTERS) ; Sets a list of Patients
 ; Input:   FILTERS - Current Array of filter settings
 ; Output:  FILTERS - Updated Array of filter settings
 N DIC,DIR,DIRUT,DIVS,DUOUT,IBIENS,IEN,N,NM,NODE,X,XX,Y
 S DIC=2,DIC(0)="AEM"
 F  D  Q:+IEN<1
 . D ONE(.DIC,.IEN)
 . Q:+IEN<1
 . S FILTERS(3,$P(IEN,"^"))=$P(IEN,"^",2)
 Q
