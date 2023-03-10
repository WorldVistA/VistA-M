RCRPSTR ;EDE/YMG - REPAYMENT PLAN STATUS REPORT; 11/30/2020
 ;;4.5;Accounts Receivable;**381,390,396,378**;Mar 20, 1995;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 N EXCEL,FILTER,POP,SORT,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 K ^TMP("RCRPSTR",$J)
 W !!,"Repayment Plan Status Report",!
 ; sort by?
 S SORT=$$ASKSORT() I SORT=-1 Q
 ; filter by?
 S FILTER=$$ASKFLTR() I FILTER=-1 Q
 ; export to Excel?
 S EXCEL=$$ASKEXCEL^RCRPRPU() I EXCEL<0 Q
 ;Device settings printout
 I EXCEL D EXCMSG^RCTCSJR    ; Display Excel display message I EXCEL
 I 'EXCEL W !!,"This report requires 132 column display.",!
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report
 .S ZTDESC="Repayment Plan Status Report",ZTRTN="COMPILE^RCRPSTR"
 .S ZTSAVE("FILTER")="",ZTSAVE("SORT")="",ZTSAVE("EXCEL")="",ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! D PAUSE^RCRPRPU
 .Q
 D COMPILE
 ;
 Q
 ;
ASKSORT() ; display "sort by" prompt
 ;
 ; returns N for debtor name, S for status, A for account balance, -1 for user exit / timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SA^N:Name;S:Status;A:Account Balance",DIR("B")="N"
 S DIR("A")="Sort By Debtor (N)ame, (S)tatus or (A)ccount Balance: "
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q Y
 ;
ASKFLTR() ; display "filter by" prompt
 ;
 ; returns "N ^ start name ^ end name" for debtor name,
 ;         "S ^ selected statuses ^ days in status" for status,
 ;         "U" for no filter,
 ;         -1 for user exit / timeout
 ;
 N RES,STOP,Z,RCANS
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SA^N:Name;S:Status;U:Unfiltered",DIR("B")="S"
 S DIR("A")="Filter By Debtor (N)ame, (S)tatus or (U)nfiltered: "
 S STOP=0 F  D  Q:STOP
 .D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RES=-1,STOP=1 Q
 .S RES=Y
 .I RES="N" D  Q
 ..S Z=$$INTV   ; Ask for the First and last name
 ..I Z=-1 S RES=-1,STOP=1 Q
 ..S $P(RES,U,2)=$P(Z,U),$P(RES,U,3)=$P(Z,U,2),STOP=1
 ..Q
 .I RES="S" D
 ..S Z=$$ASKSTAT() I (Z=-1)!(Z="Q") S RES=-1,STOP=1 Q
 ..S $P(RES,U,2)=Z
 ..S Z=$$ASKDAYS() I Z=-1 S RES=-1,STOP=1 Q
 ..S $P(RES,U,3)=Z,STOP=1
 ..Q
 .S STOP=1
 .Q
 Q RES
 ;
ASKNM(SNAME) ; display "start with name" / "end with name" prompts
 ;
 ; SNAME - starting name (selected at "start with name" prompt), used in screen, optional
 ;
 ; returns selected debtor name or -1 for no selection / user exit / timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S SNAME=$G(SNAME,"")
 S DIR(0)="PAO^340:EBS"
 S DIR("A")=$S(SNAME="":"Start",1:"End")_" with name: "
 I SNAME'="" S DIR("S")="I $$NAM^RCFN01(Y)]"""_SNAME_""""
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $$NAM^RCFN01($P(Y,U))
 ;
ASKSTAT() ; display "which statuses" prompt
 ;
 ; returns selected statuses (comma separated list of internal codes from 340.5/.07) or -1 for no selection / user exit / timeout
 ;
 N RES,SEL,STOP,STSTR
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S STSTR="NCLDFTSP"
 S DIR(0)="SAO^A:All;N:New;C:Current;L:Late;D:Delinquent;P:Paid in Full;S:Closed;F:Defaulted;T:Terminated;U:Continue;Q:Quit"
 S DIR("A",1)=""
 S DIR("A",2)="Statuses available:"
 S DIR("A",3)="  (A)ll, (N)ew, (C)urrent, (L)ate, (D)elinquent, (P)aid in Full, Clo(S)ed,"
 S DIR("A",4)="         De(F)aulted, (T)erminated,"
 S DIR("A",5)=""
 S DIR("A",6)="Statuses currently selected: None"
 S DIR("A",7)=""
 S DIR("A")="Select Status to add, Enter to continue or (Q)uit? "
 S (RES,SEL)="",STOP=0 F  D  Q:STOP
 .I SEL'="" S DIR("A",6)="Statuses currently selected: "_SEL
 .D ^DIR
 .I Y="" S STOP=1 Q    ;User is ready to enter the days.
 .I $D(DUOUT)!$D(DIROUT) S RES=-1,STOP=1 Q   ;User issued exit command, leave utilitystandard time out or ^ escape
 .I $D(DIRUT)!$D(DTOUT) S STOP=1 Q   ;standard time out or ^ escape
 .I Y="A" D  Q     ;User selected all available statuses for report
 ..S RES="1,2,3,4,7,8,5,6"
 ..S SEL="New,Current,Late,Delinquent,Paid in Full,Closed,Defaulted,Terminated"
 ..S STOP=1
 .I Y="Q" S RES=-1,STOP=1 Q
 .I Y="U" S STOP=1 Q
 .I SEL'[Y(0) D
 ..S RES=RES_$S(RES'="":","_($F(STSTR,Y)-1),1:$F(STSTR,Y)-1)
 ..S SEL=SEL_$S(SEL'="":", "_Y(0),1:Y(0))
 ..Q
 .I $L(RES,",")=8 S STOP=1  ; all statuses selected - we're done
 .Q
 Q $S(RES="":-1,1:RES)
 ;
ASKDAYS() ; display "days in status" prompt
 ;
 ; returns # of days in status or -1 for no selection / user exit / timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="NA^0:999:0"
 S DIR("A")="Enter the Minimum # of Days in Status or ^ to quit: "
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q Y
 ;
COMPILE ; compile report
 N BEGDT,CNT,NAME,RPIEN,STATDT,STATUS,STLIST,Z
 ;
 S CNT=0
 I $P(FILTER,U)="S" D
 .; filtering by statuses
 .S BEGDT=$$FMADD^XLFDT(DT,-$P(FILTER,U,3),,1) ; date to begin the search with
 .S STLIST=$P(FILTER,U,2) F Z=1:1:$L(STLIST,",") S STATUS=$P(STLIST,",",Z) D
 ..S STATDT=BEGDT F  S STATDT=$O(^RCRP(340.5,"D",STATUS,STATDT),-1) Q:'STATDT  D
 ...S RPIEN="" F  S RPIEN=$O(^RCRP(340.5,"D",STATUS,STATDT,RPIEN)) Q:'RPIEN  S CNT=CNT+1 D GETDATA(RPIEN,CNT)
 ...Q
 ..Q
 .Q
 I $P(FILTER,U)="N"!($P(FILTER,U)="U") D
 .; filtering by name or no filter
 .S Z="" F  S Z=$O(^RCRP(340.5,"B",Z)) Q:'Z  D
 ..S RPIEN=$O(^RCRP(340.5,"B",Z,"")) Q:'RPIEN
 ..I $P(FILTER,U)="N" S NAME=$$NAM^RCFN01($P(^RCRP(340.5,RPIEN,0),U,2)) Q:$P(FILTER,U,2)]NAME  Q:NAME]$P(FILTER,U,3)
 ..S CNT=CNT+1 D GETDATA(RPIEN,CNT)
 ..Q
 .Q
 D PRINT
 K ^TMP("RCRPSTR",$J)
 Q
 ;
GETDATA(RPIEN,CNT) ; fetch data and put it into ^TMP global
 ;
 ; RPIEN - file 340.5 ien
 ; CNT   - sequential # of ^TMP entry to create
 ;
 N AMNT,DAYS,DEBTOR,N0,SSN,TMPSTR,Z,ORPLNDT,AMTPM,RMNOPY
 I RPIEN'>0!(CNT'>0) Q
 S N0=^RCRP(340.5,RPIEN,0)                   ; 0-node in file 340.5
 S DEBTOR=$P(N0,U,2)                         ; pointer to file 340
 S ORPLNDT=$P(N0,U,3)                        ; Original Plan Date (Creation Date)
 S NAME=$$NAM^RCFN01(DEBTOR) Q:NAME=""       ; debtor name
 S SSN=$$SSN^RCFN01(DEBTOR)                  ; debtor SSN
 S AMNT=+$P(N0,U,11)-$$PMNTS^RCRPINQ(RPIEN)  ; amount owed
 S DAYS=$$FMDIFF^XLFDT(DT,$P(N0,U,8))        ; days in status
 S AMTPM=$P(N0,U,6)                          ; amount per month payment
 S RMNOPY=AMNT\AMTPM+$S(AMNT#AMTPM:1,1:0)    ; remaining # payments
 ; each entry is: debtor name ^ ssn ^ repayment plan ID ^ status (internal) ^ status date ^ days in status ^ last payment date ^ # of payments ^
 ;                remaining balance ^ at CS? ^ # of forbearances
 S TMPSTR=NAME_U_SSN_U_$P(N0,U)_U_ORPLNDT_U_$P(N0,U,7)_U_$P(N0,U,8)_U_DAYS
 S TMPSTR=TMPSTR_U_$O(^RCRP(340.5,RPIEN,3,"B",""),-1) ; last payment date
 S TMPSTR=TMPSTR_U_RMNOPY_U_AMNT_U_$P($G(^RCRP(340.5,RPIEN,1)),U,4)_U_$P(N0,U,9)
 ; add a new entry to ^TMP global
 S ^TMP("RCRPSTR",$J,CNT)=TMPSTR
 S Z=$S(SORT="N":NAME,SORT="S":$$EXTERNAL^DILFD(340.5,.07,,$P(N0,U,7)),1:AMNT) Q:Z=""
 S ^TMP("RCRPSTR",$J,"IDX",Z,DAYS,CNT)=""
 Q
 ;
PRINT ; print report
 N ATCS,BAL,CNT,DATA,DAYS,EXTDT,LN,PAGE,SSN,STATUS,Z,Z1,QUIT
 U IO
 S PAGE=0
 S EXTDT=$$FMTE^XLFDT(DT)
 S QUIT=0
 I EXCEL D
 .W !,"Repayment Plan Status Report;",EXTDT,";",$$FLTRSTR(),";",$$SORTSTR()
 .W !,"Name;SSN;RPP ID;Orig Plan date;Status;Status date;Days in status;Last payment;Current plan length;Remaining balance;CS;Forbearances"
 .Q
 I 'EXCEL D
 .I $E(IOST,1,2)["C-",'$D(ZTQUEUED) W @IOF
 .D HDR
 .Q
 I '$D(^TMP("RCRPSTR",$J)) D  Q
 .I EXCEL W !!,"No records found." Q
 .W !!,$$CJ^XLFSTR("No records found.",132)
 .Q
 S Z="" F  S Z=$O(^TMP("RCRPSTR",$J,"IDX",Z)) Q:Z=""  D  Q:$G(QUIT)
 .S DAYS="" F  S DAYS=$O(^TMP("RCRPSTR",$J,"IDX",Z,DAYS),-1) Q:DAYS=""  D  Q:$G(QUIT)
 ..S CNT=0 F  S CNT=$O(^TMP("RCRPSTR",$J,"IDX",Z,DAYS,CNT)) Q:'CNT  D  Q:$G(QUIT)
 ...S DATA=^TMP("RCRPSTR",$J,CNT)
 ...; convert status code
 ...S Z1=$P(DATA,U,5),STATUS=$S(Z1=1:"NEW",Z1=2:"CURR",Z1=3:"LATE",Z1=4:"DELQ",Z1=5:"DEF",Z1=6:"TERM",Z1=7:"CLOS",Z1=8:"PAID",1:"")
 ...; format remaining balance
 ...S BAL=$FN($P(DATA,U,10),"",2)
 ...; convert "at CS" value
 ...S ATCS=$S($P(DATA,U,11):"Y",1:"N")
 ...; format SSN to last 4 digits
 ...S Z1=$P(DATA,U,2),SSN=$E(Z1,$L(Z1)-3,$L(Z1)) I SSN'>0 S SSN="N/A"
 ...I EXCEL D  Q
 ....W !,$P(DATA,U),";",SSN,";",$P(DATA,U,3),";",$$FMTE^XLFDT($P(DATA,U,4),"2DZ"),";",STATUS,";",$$FMTE^XLFDT($P(DATA,U,6),"2DZ"),";",$P(DATA,U,7),";"
 ....W $$FMTE^XLFDT($P(DATA,U,8),"2DZ"),";",$P(DATA,U,9),";",BAL,";",ATCS,";",$P(DATA,U,12)
 ....Q
 ...S LN=LN+1
 ...W !,$E($P(DATA,U),1,30),?31,SSN,?37,$P(DATA,U,3),?57,$$FMTE^XLFDT($P(DATA,U,4),"2DZ"),?67,STATUS,?73,$$FMTE^XLFDT($P(DATA,U,6),"2DZ"),?83,$P(DATA,U,7),?92
 ...W $$FMTE^XLFDT($P(DATA,U,8),"2DZ"),?102,$P(DATA,U,9),?112,$$CJ^XLFSTR("$"_BAL,13),?123,ATCS,?127,$P(DATA,U,12)
 ...I LN>(IOSL-3) D HDR I $G(QUIT) Q
 ...Q
 ..Q
 .Q
 I PAGE>0,'$D(ZTQUEUED) D PAUSE^RCRPRPU W @IOF
 Q
 ;
HDR ; print header
 I PAGE>0,'$D(ZTQUEUED) D PAUSE^RCRPU W @IOF I $G(QUIT) Q
 S PAGE=PAGE+1,LN=7
 W !,"Repayment Plan Status Report",?66,EXTDT,?120,"Page: ",PAGE
 W !,$$FLTRSTR()
 W !,$$SORTSTR()
 W !!,"                                                                                                                               For-"
 W !,"                                                         Original        Status    Days in   Last     Cur plan  Remaining      bear-"
 W !,"Name                           SSN        RPP ID         Plan Dt   Stat   date     status   payment    length    balance   CS  ances"
 W ! D DASH^RCRPRPU(132)
 Q
 ;
FLTRSTR() ; returns "Filtered by" string to print
 N STR,Z
 S STR="Filtered by: "
 I $P(FILTER,U)="U" S STR=STR_"No filter"
 I $P(FILTER,U)="N" S STR=STR_"Debtor name (from "_$P(FILTER,U,2)_" to "_$P(FILTER,U,3)_")"
 I $P(FILTER,U)="S" D
 .S STR=STR_"Status ("
 .F Z=1:1:$L($P(FILTER,U,2),",") S STR=STR_$S(Z>1:", ",1:"")_$$EXTERNAL^DILFD(340.5,.07,,$P($P(FILTER,U,2),",",Z))  ; PRCA*4.5*378
 .S STR=STR_"), at least "_$P(FILTER,U,3)_" days in status"
 .Q 
 Q STR
 ;
SORTSTR() ; returns "Sorted by" string to print
 N STR
 S STR="Sorted by: "_$S(SORT="N":"Debtor name",SORT="S":"Status",1:"Account balance")
 Q STR
 ;
 ; Select name range
INTV() ; Selects the range of names
 ; Output: First value ^ Last Value OR -1 
 ;
 N RCFRST,RCLAST,X
 ;
 S (RCFRST,RCLAST)=""
FRST W !!?3,"START WITH NAME: FIRST// " R X:DTIME I '$T!(X["^") Q -1
 I $E(X)="?" D HFST(1) G FRST
 S RCFRST=X
LAST W !?8,"GO TO NAME: LAST// " R X:DTIME I '$T!(X["^") Q -1
 I $E(X)="?" D HFST(2) G LAST
 I X="" S RCLAST="zzzzz" G QINT
 I RCFRST]X D  G LAST
 .W *7,!!?7,"The LAST value must follow the FIRST.",!
 S RCLAST=X
 ;
QINT Q (RCFRST_"^"_RCLAST)
 ;
HFST(RCVAL) ; - 'START WITH PATIENT/DEBTOR...' prompt 
 N RCPRMPT
 S RCPRMPT="First" S:RCVAL=2 RCPRMPT="Last"
 ;
 W !!,"      Enter a valid field value, or"
 W !,"        '<CR>' -  To start from the '"_RCPRMPT_"' value for this field"
 W !,"        '^'    -  To quit this option"
 Q
