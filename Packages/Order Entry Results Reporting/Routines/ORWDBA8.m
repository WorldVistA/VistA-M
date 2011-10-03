ORWDBA8 ; SLC/GDU - Billing Awareness - Phase I [11/16/04 15:39]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;Clinical Indicator Data Capture By Provider Parameter Management
 ;
 ;Varaibles
 ;  CIDC   Clinical Indicator Data Capture Parameter, current value
 ;  CNT    Counter, incremented counter variable
 ;  DIR    Input array variable for ^DIR
 ;  DT     Standard Fileman/Kernel variable for current date
 ;         DT is set, but not newed or killed
 ;  DTOUT  Timeout indicator, output variable of ^DIR
 ;  DUOUT  Up arrow indicator, output variable of ^DIR
 ;  OREM   Error Message, output variable of ^DIC, and ^XPAR
 ;  FST    First, display control varible
 ;  HC     Help Counter, help text line count
 ;  IEN    Internal Entry Number
 ;  IOF    Standard Kernel variable to clear screen
 ;  NAME   Provider Name, parsed from RF output array from FIND^DIC
 ;  NX0    Next group of providers prompt, used to help build DIR(0)
 ;  NXC    Next group of providers count, used to help build DIR(0)
 ;  NXH    Next group of providers help, used to help build DIR("?"
 ;  PTD    Provider Termination Date, internal value
 ;  RF     Records Found, initial user search results
 ;  ORSCR  Screen, input variable to filter search
 ;  SP     Selected Provider
 ;  SV     Search Value
 ;  U      Standard FileMan, Kernel field delimiter
 ;  US     User Selection
 ;  WA     Work Array, filtered array of providers for user selection
 ;  X      Standard FileMan work varaible
 ;  Y      Processed output of user selection, output variable of ^DIR
 ;
 ;External References
 ;  FIND^DIC    DBIA 2051, FileMan record(s) finder
 ;  ^DIR        DBIA 10026, FileMan input reader
 ;  $$GET^XPAR  DBIA 2263, Get current value of single parameter
 ;  ADD^XPAR    DBIA 2263, Add new parameter
 ;  CHG^XPAR    DBIA 2263, Change current value of parameter
 ;  $$DT^XLFDT  DBIA 10103, Gets today's date from the system
 ;
EN ;Starting point of this program
 ;Ask user for provider
 N APS,CIDC,CNT,DIR,DTOUT,DUOUT,OREM,FST,HC,IEN,NAME,NX0,NXC,NXH,RF
 N ORSCR,PTD,SP,SV,US,VAL,WA,X,Y
 S DT=$$DT^XLFDT
 S DIR(0)=$P($T(FT0),";",3)
 S DIR("A")=$P($T(FA),";",3)
 S DIR("?",1)=$P($T(FH1),";",3)
 S DIR("?",2)=$P($T(FH2),";",3)
 S DIR("?")=$P($T(FH3),";",3)
 D SCRHDR W ! D ^DIR S SV=Y K DIR
 I SV=""!($D(DTOUT))!($D(DUOUT)) G EXIT
 S ORSCR="I $D(^XUSEC(""PROVIDER"",Y))=1"
 D FIND^DIC(200,"","@;.01;7;9.2I;9.2","CP",SV,"*","",.ORSCR,"","RF","OREM")
 ;Test if no matching records found. If true alert user.
 I $P(RF("DILIST",0),U)=0 D  G:Y=1 EN G EXIT
 . S DIR(0)="E"
 . S DIR("A",1)=$P($T(UAA1),";",3)_" "_SV
 . S DIR("A")=$P($T(UAA5),";",3)
 . D SCRHDR W ! D ^DIR K DIR
 S (SP,PTD)=""
 ;If search returns only 1 match
 I $P(RF("DILIST",0),U)=1 D
 . S SP=1,PTD=$P(RF("DILIST",SP,0),U,4)
 .;Test if provider is DISUSERED. If true alert user and quit
 . I $P(RF("DILIST",SP,0),U,3)="YES" D  Q
 .. S DIR(0)="E"
 .. S DIR("A",1)=$P(RF("DILIST",SP,0),U,2)_" "_$P($T(UAA2),";",3)
 .. S DIR("A")=$P($T(UAA5),";",3)
 .. D SCRHDR W ! D ^DIR K DIR
 .. S SP=$S(Y=1:"",1:"Q")
 .;Test if provider is terminated. If true alert user and quit
 . I PTD'="",(PTD=DT)!(PTD<DT) D  Q
 .. S DIR(0)="E"
 .. S DIR("A",1)=$P(RF("DILIST",SP,0),U,2)_" "_$P($T(UAA3),";",3)
 .. S DIR("A",1)=DIR("A",1)_" "_$P(RF("DILIST",SP,0),U,5)
 .. S DIR("A")=$P($T(UAA5),";",3)
 .. D SCRHDR W ! D ^DIR K DIR
 .. S SP=$S(Y=1:"",1:"Q")
 . S IEN=$P(RF("DILIST",1,0),U)
 . S NAME=$P(RF("DILIST",1,0),U,2)
 I $P(RF("DILIST",0),U)>1 D
 . S WA(0)=0
 . F X=1:1:$P(RF("DILIST",0),U) D
 .. S PTD=$P(RF("DILIST",X,0),U,4)
 .. I $P(RF("DILIST",X,0),U,3)="",(PTD="")!(PTD>DT) D
 ... S WA(0)=WA(0)+1
 ... S WA(WA(0))=RF("DILIST",X,0)
 . I WA(0)=0 D
 .. ;Alerting the user that this search failed because all providers
 .. ;returned are inactive
 .. S DIR(0)="E"
 .. S DIR("A",1)=$P($T(UAA4),";",3)_" "_SV
 .. S DIR("A")=$P($T(UAA5),";",3)
 .. D SCRHDR W ! D ^DIR K DIR
 .. S SP=$S(Y=1:"",1:"Q")
 . I WA(0)=0 Q
 . I WA(0)=1 S SP=1  ;Default to the single active provider
 . I WA(0)>1 D SPFL  ;Additional selection if several active providers
 . I SP="Q"!(SP="") Q
 . S IEN=$P(WA(SP),U)
 . S NAME=$P(WA(SP),U,2)
 I SP="Q" G EXIT
 I SP="" G EN
 D PSP G EN
EXIT ;Exit point for this program
 Q
FT0 ;;FO^1:40
FA ;;Select the provider to manage the parameter
FH1 ;;Enter the name/partial name of the provider.
FH2 ;;This is free text, 1 to 40 characters in length.
FH3 ;;This search will only return those with the PROVIDER key.
UAA1 ;;Found no provider records matching the search criteria of
UAA2 ;;is a provider who has been DISUSERED.
UAA3 ;;is an inactive provider with a termination date of
UAA4 ;;Found no active provider records matching the search criteria of
UAA5 ;;Hit enter to continue or "^" to quit
SPFL ;Select Provider From List
 I $D(FST)=0 S FST=1
 S DIR(0)="SO^"
 S DIR("?",1)=$P($T(DH),";",3)
 S DIR("?")=$P($T(DHS),";",3)
 S DIR("A")=$P($T(DA),";",3)
 I WA(0)<10 D
 . F X=1:1:WA(0)  S DIR(0)=DIR(0)_X_":"_$P(WA(X),U,2)_";"
 I WA(0)=10 D
 . F X=1:1:10  S DIR(0)=DIR(0)_X_":"_$P(WA(X),U,2)_";"
 I WA(0)>10 D
 . S CNT=0,HC=1,(NXC,NX0,NXH,SP,X,Y)=""
 . F X=FST:1:10+(FST-1) Q:$D(WA(X))=0  D
 .. S CNT=CNT+1
 .. S DIR(0)=DIR(0)_X_":"_$P(WA(X),U,2)_";"
 . S NXC=WA(0)-X,NXC=$S(NXC>10:10,1:NXC)
 . S NX0=$P($P($T(D0N),";",3),"|")_NXC_$P($P($T(D0N),";",3),"|",2)
 . S NXH=$P($P($T(DHN),";",3),"|")_NXC_$P($P($T(DHN),";",3),"|",2)
 . I CNT=10 D
 .. S DIR(0)=DIR(0)_";"_NX0
 .. S HC=HC+1,DIR("?",HC)=NXH
 . I FST>10 D
 .. S DIR(0)=DIR(0)_";"_$P($T(D0P),";",3)
 .. S HC=HC+1,DIR("?",HC)=$P($T(DHP),";",3)
 D SCRHDR,^DIR K DIR
 S SP=Y
 I SP="" Q
 I $D(DTOUT)!($D(DUOUT)) S SP="Q" Q
 I SP="N"!(SP="P") S FST=$S(SP="N":FST+10,1:FST-10) G SPFL
 I SP=""!(SP="Q") Q
 Q
D0N ;;N:Next | provider(s)
D0P ;;P:Previous 10 providers
DH ;;Select the provider for parameter management.
DHN ;;Enter N to get the next | providers.
DHP ;;Enter P to get the previous 10 providers.
DHS ;;Enter "^" to exit or the Enter key to return to provider lookup.
DA ;;Select the provider to assign the parameter
PSP ;Process Selected Provider
 S CIDC=$$GET^XPAR(IEN_";VA(200,","OR BILLING AWARENESS BY USER",1,"Q")
 I CIDC="" D
 . ;Assign the CIDC parameter and enable/disable it
 . S DIR(0)="SO^"_$P($T(AE),";",3)_";"_$P($T(AD),";",3)
 . S DIR("A")=$P($T(AA),";",3)
 . S DIR("?",1)=$P($T(AHE),";",3),DIR("?")=$P($T(AHD),";",3)
 . D SCRHDR
 . W !,$P($T(ASH1),";",3)," ",NAME,!,$P($T(ASH2),";",3)
 . D ^DIR S US=Y K DIR
 . I US=""!($D(DTOUT))!($D(DUOUT)) Q
 . S VAL=$S(US="E":1,1:0),OREM=""
 . D ADD^XPAR(IEN_";VA(200,","OR BILLING AWARENESS BY USER",1,VAL,.OREM)
 E  D
 . ;Edit the CIDC parameter to enable or disable it
 . S DIR(0)="Y"
 . I CIDC=0 S DIR("A")=$P($T(EEA),";",3),DIR("?",1)=$P($T(EHEY),";",3)
 . E  S DIR("A")=$P($T(EDA),";",3),DIR("?",1)=$P($T(EHDY),";",3)
 . S DIR("B")="YES",DIR("?")=$P($T(EHN),";",3)
 . D SCRHDR
 . W !,$P($T(ESH),";",3)_" "_NAME
 . W:CIDC=0 !,$P($T(EESH),";",3)
 . W:CIDC=1 !,$P($T(EDSH),";",3)
 . W ! D ^DIR S US=Y K DIR
 . I US=""!(US=0)!($D(DTOUT))!($D(DUOUT)) Q
 . S OREM="",VAL=$S(CIDC=0:1,1:0)
 . D CHG^XPAR(IEN_";VA(200,","OR BILLING AWARENESS BY USER",1,VAL,.OREM)
 Q
ASH1 ;;Assign CIDC Functionality Parameter to
ASH2 ;;Enable / Disable CIDC Functionality
AE ;;E:Enable CIDC functionality
AD ;;D:Disable CIDC functionality
AA ;;Assign the parameter and enable / disable CIDC functionality
AHE ;;Enter E to assign the parameter and enable CIDC for this provider.
AHD ;;Enter D to assign the parameter and disable CIDC for this provider
ESH ;;Edit Assigned CIDC Functionality Parameter of
EESH ;;CIDC Functionality for this provider is currently DISABLED
EDSH ;;CIDC Functionality for this provider is currently ENABLED
EEA ;;Enable CIDC Functionality (YES/NO)
EDA ;;Disable CIDC Functionality (YES/NO)
EHEY ;;Enter YES to ENABLE CIDC Functionality
EHDY ;;Enter YES to DISABLE CIDC Functionality
EHN ;;Enter NO to leave CIDC Functionality unchanged
 ;
SCRHDR ;Screen Header
 W:$D(IOF) @IOF
 W !,$P($T(SH1),";",3)
 Q
SH1 ;;Clinical Indicator Data Capture By Provider Parameter Management
