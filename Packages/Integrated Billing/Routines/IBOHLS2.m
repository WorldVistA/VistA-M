IBOHLS2 ;ALB/BAA - IB HELD CHARGES LIST MANAGER ;08-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
REL      ; release selected copay charges
 D FULL^VALM1
 N I,J,IBXX,VALMY,IBND,DATA,NAME,CNT,DFN,IBCHRGS,RELCPY
 S RELCPY=""
 ;
 ;
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . S DATA=$G(^TMP($J,"IBOHLSX",IBXX))
 . S DFN=$P(DATA,U,1)
 . S NAME=$P(DATA,U,2)
 . S CNT=$P(DATA,U,3)
 . S DATA=^TMP($J,"IBOHLS",NAME,CNT,"IBND")
 . S IBND=$P(DATA,U,3)
 . S IBCHRGS=^TMP($J,"IBOHLS",NAME,CNT)
 . Q:IBND=""  D RELHLD(DFN,IBND,IBCHRGS)
 . I RELCPY=1 K ^TMP($J,"IBOHLS",NAME,CNT)
 ;
 D BLD^IBOHLS
 S VALMBCK="R"
 Q
 ;
RELHLD(DFN,IBN,IB0) ; queue copay for release
 K IBR60
 K ^TMP($J,"IBHOLD")
 I '$$KCHK^XUSRB("IB AUTHORIZE") D  G RELHLDQ
 . W !?5,"The necessary key is IB AUTHORIZE.  Please see your manager." ;
 . D PAUSE^VALM1
 ;
 W !," Copay for "_$P(IB0,U,1)_" - "_$P(IB0,U,2)_" for the amount of $"_$P(IB0,U,7)_" will be released."
 ;
 S DIR(0)="Y",DIR("A")="Are you sure you want to Release this Copay",DIR("B")="NO"
 S DIR("?",1)="     Enter:  'Y'  -  to Release the Copay"
 S DIR("?",2)="             'N'  -  to NOT Release the Copay"
 S DIR("?",3)="             '^'  -  to exit this option"
 D ^DIR K DIR
 I Y'=1 D  Q
 . S RELCPY=0
 . W !," Release of Copay for "_$P(IB0,U,1)_" - "_$P(IB0,U,2)_" canceled."
 . D PAUSE^VALM1
 ;
 S ^TMP($J,"IBHOLD",DFN,IBN)=""
 ;
 D REL^IBOHRL ;                    Release charges
 ;
 W !," Copay for "_$P(IB0,U,1)_" - "_$P(IB0,U,2)_" for the amount of $"_$P(IB0,U,7)_" has been queued for released."
 S RELCPY=1
 D PAUSE^VALM1
 K ^TMP($J,"IBHOLD")
RELHLDQ  Q  ;
 ;
RPT(RTN,FILTERS) ; print the information
 N BDATE,EDATE
 S BDATE=$P(FILTERS(0),U,1),EDATE=$P(FILTERS(0),U,2)
 D DEVICE("PR")
 D PAUSE^VALM1
 D BLD^IBOHLS
 S VALMBCK="R" Q
 Q
 ;
DEVICE(TYPE) ; Ask user to select device
 ;
 D CLEAR^VALM1
 D FULL^VALM1
 N %ZIS,CRT,MAXCNT,POP
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 ; print report
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL,CRT=0
 I $D(IO("Q")) D  G ENQ
 .S ZTDESC="VistA Held Charges Report"
 .S ZTRTN="QUE^IBOHLS2",ZTDESC="IB - COPAYS ON HOLD"
 .S (IBDIVS,V)="" F  S V=$O(FILTERS(1,V)) Q:V=""  S IBDIVS=IBDIVS_$S(IBDIVS="":"",1:",")_V
 .S (WHO,V)="" F  S V=$O(FILTERS(1,V)) Q:V=""  S WHO=WHO_$S(WHO="":"",1:",")_V
 .S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL
 .F I="CRT","TYPE","MAXCNT","FILTERS(" S ZTSAVE(I)=""
 .D ^%ZTLOAD K IO("Q") D HOME^%ZIS
 .W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q")
 ;
 ;
 I TYPE="PR" U IO D PRINT("IBOHLS",BDATE,EDATE,MAXCNT)
 I TYPE="EF" U IO D EXCEL("IBOHLS",BDATE,EDATE,MAXCNT)
 ;
 D ^%ZISC
 ; 
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP("IBOUT",$J)
 ;
ENQ Q 
 ;
PRINT(RTN,BDATE,EDATE,MAX) ; -- print the current data
 N REC,CNT,LCNT,RX,IBQUIT,FIRST,XX,NAME,LINE,ZZ,ZZ1,ZZ2,PGC,RNB
 S LCNT=0,PGC=0,IBQUIT=0
 D CLEAR^VALM1
 U IO
 D HEADER
 S NAME="" F  S NAME=$O(^TMP($J,"IBOHLS",NAME)) Q:NAME=""  D
 . S FIRST=1
 . S CNT=0 F  S CNT=$O(^TMP($J,"IBOHLS",NAME,CNT)) Q:CNT=""  D
 .. D:$Y>MAX HEADER Q:IBQUIT
 .. S LINE=$$SETL("","","",1,2) ;line#
 .. ;PATNAME^PATID^TYPE^FROM/FILL DATE^TO/RLS DATE^#DAYS ON HOLD^CHARGE
 .. S REC=^TMP($J,"IBOHLS",NAME,CNT)
 .. S LINE=$$SETL(LINE,$P(REC,U),"",4,22)
 .. S LINE=$$SETL(LINE,$P(REC,U,2),"",26,6)
 .. S LINE=$$SETL(LINE,$P(REC,U,3),"",35,6)
 .. S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(REC,U,4),"2DZ"),"",44,8)
 .. S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(REC,U,5),"2DZ"),"",54,8)
 .. S LINE=$$SETL(LINE,$P(REC,U,6),"",63,5)
 .. S LINE=$$SETL(LINE,$J($P(REC,U,7),8,2),"",71,8)
 .. S LCNT=LCNT+1
 .. S ^TMP("IBOUT",$J,LCNT)=LINE
 .. I $D(^TMP($J,"IBOHLS",NAME,CNT,1)) S RX=^(1),RX="Rx#:"_RX D
 ... ;RX VALUE
 ... S LINE=$$SETL("",RX,"",37,20)
 ... S LCNT=LCNT+1
 ... S ^TMP("IBOUT",$J,LCNT)=LINE
 .. I $D(^TMP($J,"IBOHLS",NAME,CNT,2)) D
 ... ;BILL#AR STATUS^DATE BILLED^CHARGE
 ... S BCNT=0 F  S BCNT=$O(^TMP($J,"IBOHLS",NAME,CNT,2,BCNT)) Q:BCNT=""  D
 .... S REC=^TMP($J,"IBOHLS",NAME,CNT,2,BCNT)
 .... S LINE=$$SETL("","Bill: ","",6,18)
 .... S LINE=$$SETL(LINE,$P(REC,U),"",15,10)
 .... S LINE=$$SETL(LINE,$P(REC,U,2),"",26,10)
 .... S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(REC,U,3),"2DZ"),"",39,8)
 .... S LINE=$$SETL(LINE,$J($P(REC,U,4),8,2),"",48,11)
 .... S LCNT=LCNT+1
 .... S ^TMP("IBOUT",$J,LCNT)=LINE
 .... S RNB=$P(REC,U,7)
 .... I RNB'="" D
 ..... S LINE=$$SETL("","RNB: ","",6,6)
 ..... S LINE=$$SETL(LINE,RNB,"",14,60)
 .. I $D(^TMP($J,"IBOHLS",NAME,CNT,3)),FIRST D  ; IF DISPLAYING INSURANCE INFORMATION
 ... N ZZ,ZZ1,ZZ2
 ... ;ins co^sub id^plan id^effective dt^expiration 
 ... S FIRST=0
 ... S LINE=$$SETL("","Insurance","",8,9)
 ... S LINE=$$SETL(LINE,"Subscriber","",28,10)
 ... S LINE=$$SETL(LINE,"Group","",44,5)
 ... S LINE=$$SETL(LINE,"Eff Dt","",54,6)
 ... S LINE=$$SETL(LINE,"Exp Dt","",66,6)
 ... S LCNT=LCNT+1
 ... S ^TMP("IBOUT",$J,LCNT)=LINE
 ... S LCNT=LCNT+1
 ... S $P(ZZ2,"-",68)=""
 ... S LINE=$$SETL("",ZZ2,"",8,68)
 ... S ^TMP("IBOUT",$J,LCNT)=LINE
 ... S ZZ=0 F  S ZZ=$O(^TMP($J,"IBOHLS INS",NAME,ZZ)) Q:ZZ=""   D
 .... ;plan coverage^effective date^covered?^limit
 .... S ZZ1=^TMP($J,"IBOHLS INS",NAME,ZZ)
 .... S LINE=$$SETL("",$P(ZZ1,U),"",8,15)
 .... S LINE=$$SETL(LINE,$P(ZZ1,U,2),"",28,10)
 .... S LINE=$$SETL(LINE,$P(ZZ1,U,3),"",44,6)
 .... S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(ZZ1,U,4),"2DZ"),"",54,8)
 .... S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(ZZ1,U,5),"2DZ"),"",66,8)
 .... S LCNT=LCNT+1
 .... S ^TMP("IBOUT",$J,LCNT)=LINE
 .... S LINE=$$SETL("","Plan Coverage   Effective Date   Covered?    Limit Comments","",10,60)
 .... S LCNT=LCNT+1
 .... S ^TMP("IBOUT",$J,LCNT)=LINE
 .... S ZZ2=0 F  S ZZ2=$O(^TMP($J,"IBOHLS INS",NAME,ZZ,ZZ2)) Q:ZZ2=""  D
 ..... S ZZ1=^TMP($J,"IBOHLS INS",NAME,ZZ,ZZ2)
 ..... S LINE=$$SETL("",$P(ZZ1,U),"",10,15)
 ..... S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(ZZ2,U,2),"2DZ"),"",28,8)
 ..... S LINE=$$SETL(LINE,$P(ZZ1,U,3),"",46,10)
 ..... S LINE=$$SETL(LINE,$P(ZZ1,U,4),"",59,20)
 ..... S LCNT=LCNT+1
 ..... S ^TMP("IBOUT",$J,LCNT)=LINE
 ;
 S XX=0
 F  S XX=$O(^TMP("IBOUT",$J,XX)) Q:XX=""  D:$Y>MAX HEADER Q:IBQUIT  W !,^TMP("IBOUT",$J,XX)
 W !!,?5,"END OF REPORT"
 Q
 ;
HEADER ; -- print header
 N DIR,X,Y,DTOUT,DUOUT,OFFSET,HDR,DASHES,DASHES2,LIN,IBPXT
 S IBPXT=0
 ;
 I CRT,PGC>0,'$D(ZTQUEUED) D  I IBPXT G HEADERX
 . I MAX<51 F LIN=1:1:(MAX-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I X="^" S IBQUIT=1
 . I $D(DTOUT)!$D(DUOUT)!(IBQUIT) S IBPXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 G HEADERX
 S PGC=PGC+1
 W @IOF,!,?1,"VistA Held Charges Report"
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,1)_"  Page: "_PGC
 S OFFSET=78-$L(HDR)
 W ?OFFSET,HDR
 I BDATE=0 S BDATE="Beginning"
 I BDATE>0 S BDATE=$$FMTE^XLFDT(BDATE,"5Z")
 S HDR=BDATE_" - "_$$FMTE^XLFDT(EDATE,"5Z")
 S OFFSET=80-$L(HDR)\2
 W !,?OFFSET,HDR
 W !,?4,"Patient Name",?26,"ID",?35,"Type",?44,"Fr/Fl Dt",?54,"To/Rls Dt",?64,"Days",?73,"Amount"
 W !,?2,"-----------------------------------------------------------------------------"
HEADERX ; EXIT
 Q
 ;
EXPORT(RTN,FILTERS) ; -- print excel spreadsheet.
 N REC,CNT,RX,IBQUIT,BDATE,EDATE,NAME
 S LCNT=0,PGC=0,IBQUIT=0
 S BDATE=$P(FILTERS(0),U,1),EDATE=$P(FILTERS(0),U,2)
 D ^%ZISC
 D DEVICE("EF")
 ;
 D BLD^IBOHLS
 D PAUSE
 S VALMBCK="R"
 Q
 ;
EXCEL(RTN,BDATE,EDATE,MAX) ; print the data in excel format
 U IO
 N LINE,LCNT,PCE,REC,OUT,NAME,XX,BCNT,CNT,NXT,ZZ,ZZ1,ZZ2,OUT
 D EXHDR
 S LCNT=0
 S NAME="" F  S NAME=$O(^TMP($J,"IBOHLS",NAME)) Q:NAME=""  D COUNT
 ;
 S XX=0
 F  S XX=$O(^TMP("IBOUT",$J,XX)) Q:XX=""  W !,^TMP("IBOUT",$J,XX)
 ;
 W !,"END OF REPORT"
 D PAUSE
 Q
 ;
COUNT ; format output
 N LINE,REC,REC1
 S FIRST=1,CNT=0,LINE=""
 F  S CNT=$O(^TMP($J,"IBOHLS",NAME,CNT)) Q:CNT=""  D
 . S LCNT=LCNT+1
 . S REC=^TMP($J,"IBOHLS",NAME,CNT)
 . ;PATNAME^PATID^TYPE^Fr/Fl D^To/Rls^#Days On Hold^CHARGE $  Fr/Fl Dt and To/Rls 
 . S $P(REC,U,4)=$$FMTE^XLFDT($P(REC,U,4),"2DZ")
 . S $P(REC,U,5)=$$FMTE^XLFDT($P(REC,U,5),"2DZ")
 . S ^TMP("IBOUT",$J,LCNT)=REC
 . ;RX VALUE
 . I $D(^TMP($J,"IBOHLS",NAME,CNT,1)) S $P(^TMP("IBOUT",$J,LCNT),U,8)=^TMP($J,"IBOHLS",NAME,CNT,1)
 . I $D(^TMP($J,"IBOHLS",NAME,CNT,2)) D
 .. S SVRC=^TMP("IBOUT",$J,LCNT),REC="",XX=0
 .. S BCNT=0 F  S BCNT=$O(^TMP($J,"IBOHLS",NAME,CNT,2,BCNT)) Q:BCNT=""  D
 ... ;BILL#^AR STATUS^DATE BILLED^CHARGE
 ... S LINE=SVRC
 ... S REC=$P(^TMP($J,"IBOHLS",NAME,CNT,2,BCNT),U,1,6)
 ... S $P(REC,U,3)=$$FMTE^XLFDT($P(REC,U,3),"2DZ")
 ... S REC1=$P(REC,U,1,3)_U_$P(REC,U,6)
 ... S XX=XX+1
 ... I XX=1 S $P(^TMP("IBOUT",$J,LCNT),U,9)=REC1
 ... I XX>1 S LCNT=LCNT+1 S $P(LINE,U,9)=REC1,^TMP("IBOUT",$J,LCNT)=LINE,LINE=""
 Q  ;DON'T USE INSURANCE INFO. IT WILL BE TOO LONG.
 ;
EXHDR ; -- excel header
 S HDR="Patient Name"_U_"ID"_U_"Type"_U_"Fr/Fl Dt"_U_"To/Rls Dt"_U_"Days"_U_"Amount"_U_"RX"_U_"BILL"_U_"AR STATUS"_U_"DATE BILLED"_U_"CHARGE"
 W !,HDR
 Q
 ;
PAUSE ;pause at end of screen if being displayed on a terminal
 Q:$E(IOST,1,2)'["C-"  N DIR,DUOUT,DTOUT,DIRUT W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DUOUT)!($D(DIRUT)) S IBQUIT=1
 Q
 ;
PATINS ; view patient insurance
 D FULL^VALM1
 N I,J,IBXX,VALMY,ECNT,DFN,GOPAT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . S REC=$G(^TMP($J,"IBOHLSX",IBXX))
 . S DFN=$P(REC,U,1)
 . D EN^VALM("IBCNS VIEW PAT INS")
 D BLD^IBOHLS
 S VALMBCK="R"
 Q
 ;
CLMTRK ; look at claims tracking
 D FULL^VALM1
 N I,J,IBXX,VALMY,ECNT,NAME,GOTPAT,RC,IBFR,IBTO
 D EN^VALM2($G(XQORNOD(0)))
 K ^TMP($J,"IBOHLS CLMTRK")
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . S RC=$G(^TMP($J,"IBOHLSX",IBXX))
 . S DFN=$P(RC,U,1),NAME=$P(RC,U,2),ECNT=$P(RC,U,3),GOTPAT=1
 . S RC=^TMP($J,"IBOHLSF")
 . S IBFR=$P(RC,U,1),IBTO=$P(RC,U,2)
 . S ^TMP($J,"IBCLMTRK")=DFN_U_IBFR_U_IBTO
 .D EN^VALM("IBT CLAIMS TRACKING EDITOR")
 K ^TMP($J,"IBOHLS CLMTRK")
 D BLD^IBOHLS
 S VALMBCK="R"
 Q
 ;
PATCLM ; look at claims INFO
 D FULL^VALM1
 N IBXX,VALMY,ECNT,PNAME,RC,XX,IBIFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . S RC=$G(^TMP($J,"IBOHLSX",IBXX))
 . S DFN=$P(RC,U,1),NAME=$P(RC,U,2),ECNT=$P(RC,U,3)
 . D EN^VALM("IBJT ACTIVE LIST")
 D BLD^IBOHLS
 S VALMBCK="R"
 Q
 ;
PATACP ; look at ACCOUNT PROFILE
 D FULL^VALM1
 N IBXX,VALMY,ECNT,NAME,RC,DFN,CPY,PRCATY
 D EN^VALM2($G(XQORNOD(0)))
 D CLEAR^VALM1
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . S RC=$G(^TMP($J,"IBOHLSX",IBXX))
 . S DFN=$P(RC,U,1),NAME=$P(RC,U,2),ECNT=$P(RC,U,3)
 . N DIC,X,Y,DEBT,PRCADB,DA,PRCA,COUNT,OUT,SEL,BILL,BAT,TRAN,DR,DXS,DTOUT,DIROUT,DIRUT,DUOUT
 . N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 . S COUNT=0,CPY=1
 . S PRCATY="ALL",X=NAME
 . S X=$$UPPER^VALM1(X)
 . S Y=$S($O(^PRCA(430,"B",X,0)):$O(^(0)),$O(^PRCA(430,"D",X,0)):$O(^(0)),1:-1)
 . I Y>0 S DEBT=$P($G(^PRCA(430,Y,0)),"^",9) I DEBT S PRCADB=$P($G(^RCD(340,DEBT,0)),"^"),^DISV(DUZ,"^PRCA(430,")=Y,$P(DEBT,"^",2)=$$NAM^RCFN01(DEBT) D COMP^PRCAAPR,EN1^PRCAATR(Y) Q
 . S DIC="^RCD(340,",DIC(0)="E" D ^DIC
 . I Y<0 W !,"No entries found for "_NAME Q
 . S ^DISV(DUZ,"^RCD(340,")=+Y
 . S PRCADB=$P(Y,"^",2),DEBT=+Y_"^"_$P(@("^"_$P(PRCADB,";",2)_+PRCADB_",0)"),"^")
 . D COMP^PRCAAPR,HDR^PRCAAPR1,HDR2^PRCAAPR1,DIS^PRCAAPR1
 . D PAUSE^VALM1
 K ^TMP("PRCAAPR",$J)
 D BLD^IBOHLS
 S VALMBCK="R"
 Q
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ; Creates a line of data to be set into the body
 ; of the worklist
 ; Input: LINE - Current line being created
 ; DATA - Information to be added to the end of the current line
 ; LABEL - Label to describe the information being added
 ; COL - Column position in line to add information add
 ; LNG - Maximum length of data information to include on the line
 ; Returns: Line updated with added information
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
QUE ; QUEUED REPORT ENTRY
 ;Required variable input: FILTERS(0),FILTERS(1),FILTERS(2),BDATE,EDATE,INSTS,PATS,IINS,CRT,TYPE
 ;
 D FULL^VALM1
 D CLEAR^VALM1
 S BDATE=$P(FILTERS(0),U,1),EDATE=$P(FILTERS(0),U,2)
 S INSTS=$P(FILTERS(0),U,3),PATS=$P(FILTERS(0),U,4)
 S IINS=FILTERS(3)
 D SORT^IBOHLS1
 ;
 I TYPE="PR" U IO D PRINT("IBOHLS",BDATE,EDATE,MAXCNT)
 I TYPE="EF" U IO D EXCEL("IBOHLS",BDATE,EDATE,MAXCNT)
 Q 
