IBCNSGE ;ALB/ESG - Insurance Company EDI Parameter Report ;07-JAN-2005
 ;;2.0;INTEGRATED BILLING;**296,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eClaims Plus
 ; Identify insurance companies and display EDI parameter information.
 ;
 ;
EN ; Entry Point
 NEW IBRINS,IBRBID,IBRINS1,IBRINS2,IBRSORT,STOP
 D SELECT I STOP G EXIT
 D SORT I STOP G EXIT
 D DEVICE
EXIT ;
 Q
 ;
SELECT ; Select insurance companies to include on the report
 NEW DIR,DIC,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBQ
SEL1 ;
 S STOP=0,IBQ=0
 W @IOF
 W !!?21,"Insurance Company EDI Parameter Report"
 W !!?5,"This report will display the EDI parameter information for selected"
 W !?5,"insurance companies.  You can specify one company, multiple companies,"
 W !?5,"a range of company names, or all companies on file."
 ;
 S DIR(0)="SO^A:Include All Insurance Companies;S:Select Specific Insurance Companies;R:Specify a Range of Insurance Company Names"
 S DIR("A")="     Method for selecting insurance companies"
 S DIR("B")="A"
 S DIR("?",1)="Enter a code from the list.  This defines how you want to select insurance"
 S DIR("?",2)="companies for this report."
 S DIR("?",3)=""
 S DIR("?",4)="If you choose 'A', then all active companies will be included."
 S DIR("?",5)="If you choose 'S', then one or more specific companies can be selected."
 S DIR("?")="If you choose 'R', then you can enter a range of company names."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SELX
 S IBRINS=Y
 I '$F(".A.S.R.","."_IBRINS_".") S STOP=1 G SELX
 I IBRINS="S" D MULT I IBQ G SEL1      ; choose one or many
 I IBRINS="R" D RANGE I IBQ G SEL1     ; choose a range
 ;
 W !
 S DIR(0)="YO"
 S DIR("A",1)="Only include Insurance Companies with Electronic"
 S DIR("A")="             Bill ID's that are blank or contain ""PRNT"""
 S DIR("B")="NO"
 S DIR("?",1)="Enter either 'Y' or 'N'.  If you choose 'Y', then this will limit the selection"
 S DIR("?",2)="of insurance companies.  Only those companies in which the Inst ID or the Prof"
 S DIR("?",3)="ID is either blank or contains ""PRNT"" (uppercase or lowercase)"
 S DIR("?")="will be included."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SELX
 S IBRBID=Y
SELX ;
 Q
 ;
MULT ; select one or many insurance companies
 NEW DIC,X,Y
 K IBRINS S IBRINS="S"
 F  D  Q:Y'>0
 . W ! S DIC("A")="Insurance Company: "
 . S DIC("S")="I $$ACTIVE^IBCNEUT4(Y)"    ; screen out Inactives
 . S DIC=36,DIC(0)="AEQM" D ^DIC
 . Q:Y'>0
 . S IBRINS(+Y)=$P($G(^DIC(36,+Y,0)),U,1)
 . Q
 I $O(IBRINS(""))="" S IBQ=1 G MULTX   ; none selected
MULTX ;
 Q
 ;
RANGE ; select a range of insurance company names
 K IBRINS1,IBRINS2
 W !
 S DIR(0)="FO",DIR("A")="Start with Insurance Company"
 S DIR("?",1)="This response can be free text."
 S DIR("?",2)="Responses are case sensitive."
 S DIR("?")="Example: To find CIGNA, type CIGNA not cigna or Cigna."
 S DIR("B")="First" D ^DIR K DIR
 I $D(DIRUT) S IBQ=1 G RANGEX
 S IBRINS1=Y
 I IBRINS1="First" S IBRINS1=" "
 ;
 W !
 S DIR(0)="FO",DIR("A")="Go to Insurance Company"
 S DIR("?",1)="This response can be free text."
 S DIR("?",2)="Responses are case sensitive."
 S DIR("?")="Example: To find CIGNA, type CIGNA not cigna or Cigna."
 S DIR("B")="Last" D ^DIR K DIR
 I $D(DIRUT) S IBQ=1 G RANGEX
 S IBRINS2=Y
 I IBRINS2="Last" S IBRINS2="~~~~~"
 ;
 I IBRINS1=" ",IBRINS2="~~~~~" D  G RANGEX
 . K IBRINS,IBRINS1,IBRINS2
 . S IBRINS="A"
 . Q
 ;
 I IBRINS1]IBRINS2 D  G RANGE
 . W !!?5,"Sorry ..... Ending name must come after Starting name"
 . W !!?5,"Please try again",*7
 . Q
 ;
RANGEX ;
 Q
 ;
SORT ; Choose the sorting method
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !!?5,"*** Sort Criteria ***"
 S DIR(0)="SO^1:Insurance Company Name;2:Prof Electronic Bill ID;3:Inst Electronic Bill ID;4:Electronic Type;5:Type Of Coverage;6:Use VAMC as Billing Provider"
 S DIR("A")="Sort By",DIR("B")=1
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SORTX
 S IBRSORT=Y
SORTX ;
 Q
 ;
COMPILE ; Entry point for task; compile scratch global, print, clean-up
 ;
 NEW RTN,INSIEN,INSNM,DATA,ADDR,EDI,PROFID,INSTID,NAME,STREET,CITY
 NEW STATE,TYPCOV,TRANS,INSTYP,SORT,TMP,FLG,FLGP,FLGI,SWBCK
 ;
 S RTN="IBCNSGE"
 KILL ^TMP($J,RTN)   ; init
 ;
 ; all insurances
 I IBRINS="A" D
 . S INSIEN=0
 . F  S INSIEN=$O(^DIC(36,INSIEN)) Q:'INSIEN  D CALC(INSIEN)
 . Q
 ;
 ; specific insurances
 I IBRINS="S" D
 . S INSIEN=0
 . F  S INSIEN=$O(IBRINS(INSIEN)) Q:'INSIEN  D CALC(INSIEN)
 . Q
 ;
 ; a range of insurances
 I IBRINS="R" D
 . S INSNM=$O(^DIC(36,"B",IBRINS1),-1)
 . F  S INSNM=$O(^DIC(36,"B",INSNM)) Q:INSNM=""  Q:INSNM]IBRINS2  D
 .. S INSIEN=0
 .. F  S INSIEN=$O(^DIC(36,"B",INSNM,INSIEN)) Q:'INSIEN  D CALC(INSIEN)
 .. Q
 . Q
 ;
 D PRINT                           ; print the report
 D ^%ZISC                          ; close the device
 KILL ^TMP($J,RTN)                 ; kill scratch global
 I $D(ZTQUEUED) S ZTREQ="@"        ; purge the task record
COMPX ;
 Q
 ;
CALC(INS) ; extract insurance data for company ien=INS
 ;
 I '$$ACTIVE^IBCNEUT4(INS) G CALCX      ; not active
 S DATA=$G(^DIC(36,INS,0))
 S ADDR=$G(^DIC(36,INS,.11))
 S EDI=$G(^DIC(36,INS,3))
 S FLG=$G(^DIC(36,INS,4))
 S FLGP=+$P(FLG,U,11)      ; prof switchback flag
 S FLGI=+$P(FLG,U,12)      ; inst switchback flag
 S PROFID=$P(EDI,U,2)
 S INSTID=$P(EDI,U,4)
 ;
 I IBRBID,PROFID'="",INSTID'="",$$UP^XLFSTR(PROFID)'["PRNT",$$UP^XLFSTR(INSTID)'["PRNT" G CALCX
 ;
 S NAME=$P(DATA,U,1) S:NAME="" NAME="~UNK"
 S STREET=$P(ADDR,U,1)
 S CITY=$P(ADDR,U,4)
 S STATE=+$P(ADDR,U,5)
 S STATE=$S(STATE:$P($G(^DIC(5,STATE,0)),U,2),1:"")
 S TYPCOV=$$EXTERNAL^DILFD(36,.13,,$P(DATA,U,13))
 S TRANS=$$EXTERNAL^DILFD(36,3.01,,$P(EDI,U,1))
 S INSTYP=$$EXTERNAL^DILFD(36,3.09,,$P(EDI,U,9))
 S SWBCK="~"     ; default no switchback flags set; sort these at the end
 I FLGP,FLGI S SWBCK="BOTH"
 I FLGP,'FLGI S SWBCK="PROF"
 I 'FLGP,FLGI S SWBCK="INST"
 ;
 S SORT=" "
 I IBRSORT=1,NAME'="" S SORT=" "_NAME
 I IBRSORT=2,PROFID'="" S SORT=" "_PROFID
 I IBRSORT=3,INSTID'="" S SORT=" "_INSTID
 I IBRSORT=4,INSTYP'="" S SORT=" "_INSTYP
 I IBRSORT=5,TYPCOV'="" S SORT=" "_TYPCOV
 I IBRSORT=6,SWBCK'="" S SORT=" "_SWBCK
 ;
 S TMP=NAME_U_STREET_U_CITY_U_STATE_U_INSTYP_U_TYPCOV_U_TRANS_U_INSTID_U_PROFID_U_SWBCK
 S ^TMP($J,RTN,SORT,NAME,INS)=TMP
CALCX ;
 Q
 ;
PRINT ; print the report to the specified device
 NEW MAXCNT,CRT,PAGECNT,STOP,SORT,NAME,INS,DATA,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 S PAGECNT=0,STOP=0
 ;
 I '$D(^TMP($J,RTN)) D HEADER W !!!?5,"No Data Found"
 ;
 S SORT=""
 F  S SORT=$O(^TMP($J,RTN,SORT)) Q:SORT=""  D  Q:STOP
 . S NAME=""
 . F  S NAME=$O(^TMP($J,RTN,SORT,NAME)) Q:NAME=""  D  Q:STOP
 .. S INS=0
 .. F  S INS=$O(^TMP($J,RTN,SORT,NAME,INS)) Q:'INS  D  Q:STOP
 ... S DATA=$G(^TMP($J,RTN,SORT,NAME,INS))
 ... I $P(DATA,U,10)["~" S $P(DATA,U,10)=""
 ... I $Y+1>MAXCNT!'PAGECNT D HEADER Q:STOP
 ... W !,$E($P(DATA,U,1),1,25)       ; name
 ... W ?27,$E($P(DATA,U,2),1,19)     ; address1
 ... W ?47,$E($P(DATA,U,3),1,13)     ; city, st
 ... I $P(DATA,U,3)'="",$P(DATA,U,4)'="" W ","
 ... W $E($P(DATA,U,4),1,2)
 ... W ?65,$E($P(DATA,U,7),1,8)      ; transmit elec
 ... W ?75,$E($P(DATA,U,8),1,8)      ; inst payer id
 ... W ?84,$E($P(DATA,U,9),1,8)      ; prof payer id
 ... W ?94,$E($P(DATA,U,5),1,12)     ; ins type
 ... W ?108,$E($P(DATA,U,6),1,18)    ; type of cov
 ... W ?128,$E($P(DATA,U,10),1,4)    ; switchback flag
 ... Q
 .. Q
 . Q
 ;
 I STOP G PRINTX
 W !!?5,"*** End of Report ***"
 I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
PRINTX ;
 Q
 ;
HEADER ; page break and report header information
 NEW LIN,HDR,TAB,C1,C2
 S STOP=0
 I CRT,PAGECNT>0,'$D(ZTQUEUED) D  I STOP G HEADX
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I 'Y S STOP=1 Q
 . Q
 ;
 S PAGECNT=PAGECNT+1
 W @IOF,!
 ;
 I IBRINS="A" W "All Companies"
 I IBRINS="S" W "Selected Companies"
 I IBRINS="R" D    ; range description
 . S C1=IBRINS1 I C1=" " S C1="First"
 . S C2=IBRINS2 I C2="~~~~~" S C2="Last"
 . W "Companies [",C1,"] through [",C2,"]"
 . Q
 ;
 W ?45,"  Insurance Company EDI Parameter Report"
 S HDR="Page: "_PAGECNT,TAB=132-$L(HDR)-1
 W ?TAB,HDR
 ;
 W !,"Sorted By "
 I IBRSORT=1 W "Ins Company Name"
 I IBRSORT=2 W "Prof ID"
 I IBRSORT=3 W "Inst ID"
 I IBRSORT=4 W "Electronic Type"
 I IBRSORT=5 W "Type of Coverage"
 I IBRSORT=6 W "Use VAMC as Billing Provider"
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,"1Z"),TAB=132-$L(HDR)-1
 W ?TAB,HDR
 ;
 W !,"Only Blank or 'PRNT' Bill ID's = ",$S(IBRBID:"YES",1:"NO"),?128,"VAMC"
 ;
 W !?65,"Electron",?75,"Inst",?84,"Prof",?94,"Electronic",?128,"Bill"
 W !,"Insurance Company Name",?27,"Street Address",?47,"City"
 W ?65,"Transmit",?76,"ID",?85,"ID",?97,"Type",?108,"Type of Coverage",?128,"Prov"
 W !,$$RJ^XLFSTR("",132,"=")
 ;
 ; check for a stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  G HEADX
 . S (ZTSTOP,STOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 . Q
HEADX ;
 Q
 ;
DEVICE ; Device selection before compile
 NEW ZTRTN,ZTDESC,ZTSAVE,POP
 W !!!,"This report is 132 columns wide.  Please choose an appropriate device.",!
 S ZTRTN="COMPILE^IBCNSGE"
 S ZTDESC="Insurance Company EDI Parameter Report"
 S ZTSAVE("IBRINS")=""
 S ZTSAVE("IBRBID")=""
 S ZTSAVE("IBRINS1")=""
 S ZTSAVE("IBRINS2")=""
 S ZTSAVE("IBRSORT")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM")
DEVX ;
 Q
 ;
