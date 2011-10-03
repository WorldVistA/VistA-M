ECRUTL ;ALB/ESD - Event Capture Report Utilities ;1 Aug 97
 ;;2.0; EVENT CAPTURE ;**5,100**;8 May 96;Build 21
 ;
ASKLOC() ; Ask report location(s) (institution)
 ;   Input:  None
 ;  Output:  1 if successful - location(s) will be in array ECLOC
 ;           0 if unsuccessful
 ;
 N DIRUT,DUOUT,ECN,ECNUM,ECX,Y
 D LOCARRY
 ;
 ;- Only one location exists
 I '$D(ECLOC(2)) G ASKLOCQ
 ;
 W !
 S DIR(0)="YA",DIR("A")="Do you want to print this report for all locations? ",DIR("B")="YES",DIR("?")="Enter YES to choose all Event Capture locations or NO to select a specific location."
 D ^DIR K DIR I $D(DIRUT) K ECLOC G ASKLOCQ
 I +Y G ASKLOCQ
 I 'Y D
 . W @IOF,!,"Event Capture Locations:",!
 . F ECX=0:0 S ECX=$O(ECLOC(ECX)) Q:'ECX  W ECX_".  ",$P(ECLOC(ECX),"^",2),!
 . S ECNUM=$$SEL
 . I ECNUM D
 .. S ECLOC(1)=+$P(ECLOC(ECNUM),"^")_"^"_$P(ECLOC(ECNUM),"^",2)
 .. F ECX=0:0 S ECX=$O(ECLOC(ECX)) Q:'ECX  K:(ECX>1) ECLOC(ECX)
 . I 'ECNUM K ECLOC
ASKLOCQ Q $S('$D(ECLOC):0,1:1)
 ;
 ;
LOCARRY ;-- Get location(s) from "LOC" xref of DMMS Units (#720) fld of 
 ;   INSTITUTION file and create ECLOC array
 ;
 N ECLNAM,ECLNUM,ECCNT
 S (ECCNT,ECLNUM)=0,ECLNAM=""
 F  S ECLNAM=$O(^DIC(4,"LOC",ECLNAM)) Q:ECLNAM=""  F  S ECLNUM=$O(^DIC(4,"LOC",ECLNAM,ECLNUM)) Q:'ECLNUM  S ECCNT=ECCNT+1,ECLOC(ECCNT)=ECLNUM_"^"_ECLNAM,ECLOC1(ECLNUM)=ECLNAM
 Q
 ;
 ;
SEL() ;-- Select one location from ECLOC array
 ;
GETNUM N DIRUT,DUOUT,Y
 S DIR(0)="NA",DIR("A")="Select Number: ",DIR("?")=$P($T(HLPTXT),";;",2)
 D ^DIR K DIR
 I $D(DIRUT) S ECN=0 G SELQ
 I '$D(ECLOC(+Y)) W !!,$P($T(HLPTXT),";;",2) G GETNUM
 S ECN=+Y
SELQ Q +$G(ECN)
 ;
 ;
 ;
ASKDSS() ; Ask DSS Unit(s)
 ;   Input:  None
 ;  Output:  1 if successful - DSS Units will be in array ECDSSU
 ;           0 if unsuccessful
 ;
 N DIRUT,DUOUT,ECKEY,ECNT,ECD,ECN,ECX,I,Y
 S ECKEY=$S($D(^XUSEC("ECALLU",DUZ)):1,1:0)
 W ! S DIR(0)="YA"
 S DIR("A")="Do you want to print this report for all "_$S('ECKEY:"accessible ",1:"")_"DSS Units? ",DIR("B")="YES"
 D ^DIR K DIR
 G:$D(DIRUT) ASKDSSQ
 D @($S(+Y:"ALLU",1:"SPECU"))
ASKDSSQ Q $S('$D(ECDSSU):0,1:1)
 ;
 ;
ALLU ;-- Get all DSS Units and create ECDSSU array
 N DIR,ECD,ECN,ECX,I,Y
 S ECD="",(ECN,ECX)=0
 F  S ECD=$O(^ECD("B",ECD)) Q:ECD=""  F  S ECN=$O(^ECD("B",ECD,ECN)) Q:'ECN  D
 . Q:'$$VALID(ECN)!('ECKEY&('$D(^VA(200,DUZ,"EC",+ECN))))
 . S ECX=ECX+1,ECDSSU(ECX)=ECN_"^"_ECD
 I '$D(ECDSSU) D
 . W !!,$P($T(NOUNITS),";;",2),!
 . F I=0:1:1 W !,$P($T(ERRMSG+I),";;",2)
 . W ! S DIR(0)="E" D ^DIR
ALLUQ Q
 ;
 ;
SPECU ;-- Get specific DSS Units
 N DIRUT,DUOUT,Y
 W !
 S DIR(0)="YA",DIR("A")="Do you want to print this report for specific DSS Unit(s)? ",DIR("B")="YES"
 S DIR("?")="Enter YES to select specific DSS Unit(s) or NO to quit."
 D ^DIR K DIR
 I 'Y!($D(DIRUT)) G SPECUQ
 D SELU
SPECUQ Q
 ;
 ;
SELU ;-- Create ECDSSU array containing DSS Units after checking for validity and access to Unit
 N ECX,I,Y,Z
 S (ECX,Z)=0
GETU W ! K DUOUT,DTOUT,DIRUT,Y
 S DIC=724,DIC("A")="Select DSS Unit: ",DIC(0)="QEAMZ"
 S DIC("S")="I ECKEY!($D(^VA(200,DUZ,""EC"",+Y)))"
 D ^DIC K DIC
 G SELUQ:$D(DTOUT)!($D(DUOUT))
 I +Y>0 D  G GETU
 . F I=1:1:ECX I +Y=+ECDSSU(I) D  Q
 .. W !,?10,"But you already selected that one... try again."
 .. S Y=-1
 . Q:Y=-1
 . I $$VALID(+Y) S ECX=ECX+1,ECDSSU(ECX)=Y
 . I '$$VALID(+Y) W ! F I=0:1:1 W !?5,$P($T(INVALID+I),";;",2)
 I +Y<0 S Z=$$DISPU() I 'Z W !!?10," *** NO DSS UNITS SELECTED ***" G SELUQ
 W ! S DIR(0)="YA",DIR("A")="Is this list correct? ",DIR("B")="YES",DIR("?")="Answer YES to accept the list, NO to start over."
 D ^DIR K DIR
 I $D(DIRUT) G SELUQ
 I '$G(Y) S ECX=0 K ECDSSU G GETU
SELUQ I $D(DIRUT)!($D(DTOUT))!($D(DUOUT)) D
 . I $D(ECDSSU) W !!,?10,"Deleting selection...",!
 . K ECDSSU
 Q
 ;
 ;
VALID(IEN) ;-- Check DSS Unit for use by Event Capture
 N NODE
 S NODE=$G(^ECD(IEN,0))
 Q $S($P(NODE,"^",8):1,1:0)
 ;
 ;
DISPU(TYP) ;-- Display DSS Units
 N X
 I '$D(ECDSSU) G DISPUQ
 W @IOF,!!,$S($G(TYP)="All":TYP,1:"Selected")_" DSS Units:",!
 F X=0:0 S X=$O(ECDSSU(X)) Q:'X  W !?5,X_". ",$P(ECDSSU(X),"^",2)
 W !
DISPUQ Q $S($D(ECDSSU):1,1:0)
 ;
 ;
HLPTXT ;;  Enter the number corresponding to the location you want to select.
NOUNITS ;;  You do not have access to any DSS Units.
ERRMSG ;;  If you are responsible for printing this report, contact your Event
 ;;  Capture ADPAC to allow access.
INVALID ;;  This DSS Unit is either inactive or cannot be used with the
 ;;  Event Capture software.  Please select another DSS Unit.
 ;
 ;
 ;
STDT() ; Get Start Date
 ;   Input:  None
 ;  Output:  1 if successful - start date in ECSTDT
 ;           0 if unsuccessful
 ;
EN N DIRUT,DUOUT,Y
 W ! S DIR(0)="DA^::EX",DIR("A")="Enter Start Date: ",DIR("?")="^D HELP^%DTC"
 D ^DIR K DIR G:$D(DIRUT) STDTQ
 I (+Y>DT) W !,"*** Future dates are not allowed ***" G EN
 S ECSTDT=+Y,ECSTDT=ECSTDT-.0001
STDTQ Q $S($G(ECSTDT):1,1:0)
 ;
 ;
 ;
ENDDT(STDT) ; Get End Date
 ;   Input:  STDT - Start Date
 ;  Output:  1 if successful - end date in ECENDDT
 ;           0 if unsuccessful
 ;
 N DIRUT,DUOUT,Y
 G:'$G(STDT) ENDDTQ
 W ! S DIR(0)="DA^"_STDT_":DT:EX",DIR("A")="Enter End Date: "
 S DIR("?")="^W ""*** Future dates are not allowed ***"",! D HELP^%DTC"
 D ^DIR K DIR G:$D(DIRUT) ENDDTQ
 S ECENDDT=+Y,ECENDDT=ECENDDT+.9999
ENDDTQ Q $S($G(ECENDDT):1,1:0)
 ;
REASON ;* Prompt to report Procedure Reasons
 ;
 ;* Variables returned
 ;   ECRY - Must be KILLed by calling routine
 ;
 S DIR(0)="Y^A"
 S DIR("A")="Do you want to include Procedure Reasons"
 S DIR("B")="NO"
 S DIR("?",1)="Enter Yes to include procedure reasons on the report."
 S DIR("?")="Enter No to report without procedure reasons."
 D ^DIR
 S:(+Y=1) ECRY=""
 K DIR,Y
 Q
