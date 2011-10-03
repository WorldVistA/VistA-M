ORWDBA83 ; SLC/GDU - Billing Awareness - Phase I [10/18/04 10:52]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
 ;Enable Clinical Indicator Data Capture By Provider Parameter Module
 ;ORWDBA83 - Assign the parameter to a selected provider and manually set
 ;           the CIDC by provider parameter to enable/disable the CIDC
 ;           functionality
 ;
 ;Local Variables
 ;CNT          Counter - Used to get count of providers who do not have 
 ;             the parameter assigned to them.
 ;DIR          Input array variable for ^DIR
 ;DTOUT        Timeout indicator, output variable of ^DIR
 ;DUOUT        Up arrow indicator, output variable of ^DIR
 ;OREM         Error Message, output from FIND^DIC
 ;ENT          Entity the parameter is assigned to, input variable for
 ;             ADD^XPAR
 ;FILE         File Number of file searched, input variable for FIND^DIC
 ;FLD          Field Number of fields to be returned in oputput, input
 ;             variable for FIND^DIC
 ;FLG          Flags for search method and output format, input variable
 ;             for FIND^DIC
 ;FST          First, a control variable to help build DIR(0) in MT10P
 ;HC           Help Count, a control variable to help build DIR("?"
 ;             in MT10P.
 ;ID           Indentifier, input variable for FIND^DIC
 ;IEN          Internal Entry Number, standard FileMan variable for a
 ;             record's internal id number. Input variable for
 ;             FIND^DIC. Used to build ENT.
 ;IND          Index, input variable for FIND^DIC
 ;INST         Instance indicator, input variable for ENVAL^XPAR
 ;IOF          Clear Screen and move cursor to top of screen, standard
 ;             Kernal IO variable
 ;NAME         Provider Name, parsed from RF output array from FIND^DIC
 ;NUM          Maximum number of records to return, input variable for
 ;             FIND^DIC
 ;NX0          Next group of providers prompt, used to help build DIR(0)
 ;NXC          Next group of providers count, used to help build DIR(0)
 ;NXH          Next group of providers help, used to help build DIR("?"
 ;PAR          The Name or IEN of a parameter in the PARAMETER DEFINITION
 ;             FILE, input variable for ADD^XPAR 
 ;RF           Records Found, the array variable with the results found
 ;             by FIND^DIC
 ;RFC          Records Found Count, The first piece of the zero node in
 ;             the output array from FIND^DIC with the total number
 ;             records returned
 ;ORSCR        Screen, an input variable for FIND^DIC to filter out
 ;             records from the search.
 ;SP           Selected Provider, set to the value of Y when the user
 ;             selects a provider from the list of providers returned
 ;             by FIND^DIC
 ;U            FileMan standard variable for data delimiter, equals "^"
 ;VAL          Value of the parameter being added, input variable for
 ;             ADD^XPAR
 ;X            Standard FileMan work varaible
 ;X1
 ;Y            Processed output of user selection, output variable for
 ;             ^DIR
 ;
 ;Global Variables
 ;^XTV(8989.51 PARAMETER DEFINITION FILE, file # 8989.51
 ;
 ;External References
 ;FIND^DIC     FileMan silent database call, returns an array of records
 ;             matching or partly matching a value searched on.
 ;^DIR         FileMan general purpose response reader
 ;KTG^ORWDBA8  Kills the temp globals
 ;LISTA^ORWDBA8
 ;             Builds temp global ^TMP("ORPAL", a list of providers who
 ;             have the Enable CIDC parameter assigned to them.
 ;LISTU^ORWDBA8
 ;             Builds temp global ^TMP("ORPUL", a list of providers who
 ;             do not have the Enable CIDC parameter assigned to them.
 ;ADD^XPAR     PARAMETER TOOLS, API to add a new parameter value
 ;
START ;Starting point of this program
 N CNT,DIR,DTOUT,DUOUT,OREM,ENT,FILE,FLD,FLG,FST,HC,ID,IEN,IND,INST,NAME
 N NUM,NX0,NXC,NXH,PAR,RF,RFC,ORSCR,SP,VAL,X,X1,Y
 ;Ask user for provider
 S DIR(0)=$P($T(FT0),";",3)
 S DIR("A")=$P($T(FA),";",3)
 S DIR("?",1)=$P($T(FH1),";",3)
 S DIR("?",2)=$P($T(FH2),";",3)
 S DIR("?",3)=$P($T(FH3),";",3)
 S DIR("?")=$P($T(FH4),";",3)
 D SCRHDR,^DIR
 ;Process user entry, search for provider
 I Y=""!($D(DTOUT))!($D(DUOUT)) G EXIT
 S FILE=200,FLD="@;.01",FLG="CP",(ID,IEN,IND,SP)="",NUM="*",VAL=Y
 S ORSCR="I $D(^XUSEC(""PROVIDER"",Y)"
 S ORSCR("S")="I $D(^TMP(""ORPUL"",$J,""A"",Y))=1"
 D FIND^DIC(FILE,IEN,FLD,FLG,VAL,NUM,IND,.ORSCR,ID,"RF","OREM")
 S RFC=$P(RF("DILIST",0),U)
 ;No matchs found alert user
 I RFC=0 D ALERT G START
 ;Single match found skip to parameter assign
 I RFC=1 S SP=RFC D ASSIGN G START
 ;10 or less matchs found, present for user selection
 I RFC<10!(RFC=10) D LTE10P
 ;More than 10 matchs found, present for user selection
 I RFC>10 S FST=1 D MT10P
 ;Process user selection from LTE10P or MT10P
 I SP="Q" G EXIT
 I SP="" D KILLVAR G START
 D ASSIGN G START
EXIT ;Exit point for this program
 Q
ALERT ;Alert the user that the selection returned no records.
 K DIR,X1
 S DIR(0)="E",X1=""
 S DIR("A",1)=$P($T(UA1),";",3)_" "_VAL_"."
 F X=2:1:5 S X1="UA"_X,DIR("A",X)=$P($T(@X1),";",3)
 S DIR("A")=$P($T(UA6),";",3)
 D SCRHDR,^DIR
 D KILLVAR
 Q
ASSIGN ;Assign the parameter and enable/disable CIDC functionality
 S IEN=$P(RF("DILIST",SP,0),U),NAME=$P(RF("DILIST",SP,0),U,2)
 S DIR(0)=$P($T(SCO),";",3)_$P($T(PE),";",3)_";"_$P($T(PD),";",3)
 S DIR("A")=$P($T(PA),";",3)
 S DIR("?",1)=$P($T(PHE),";",3),DIR("?")=$P($T(PHE),";",3)
 D SCRHDR
 W !!,$P($T(M1),";",3)," ",NAME," ",$P($T(M2),";",3),!,$P($T(M3),";",3)
 D ^DIR
 I Y=""!($D(DTOUT))!($D(DUOUT)) Q
 S VAL=$S(Y="E":1,1:0),ENT=IEN_";VA(200,",INST=1,OREM=""
 S PAR=$QS($Q(^XTV(8989.51,"B","OR BILLING AWARENESS BY USER")),4)
 D ADD^XPAR(ENT,PAR,INST,VAL,.OREM)
 D KILLVAR,KTG,LISTA,LISTU
 Q
LTE10P ;If search returned a list less then or equal to 10
 D SETDIR
 F X=1:1:RFC  S DIR(0)=DIR(0)_X_":"_$P(RF("DILIST",X,0),U,2)_";"
 D SCRHDR,^DIR
 I $D(DTOUT)!($D(DUOUT)) S SP="Q"
 E  S SP=Y
 Q
MT10P ;If search returned more then 10 providers
 D SETDIR
 S CNT=0,HC=1,(NXC,NX0,NXH,SP,X,Y)=""
 F X=FST:1:10+(FST-1) Q:$D(RF("DILIST",X,0))=0  D
 . S CNT=CNT+1
 . S DIR(0)=DIR(0)_X_":"_$P(RF("DILIST",X,0),U,2)_";"
 S NXC=RFC-X,NXC=$S(NXC>10:10,1:NXC)
 S NX0=$P($P($T(D0N),";",3),"|",1)_NXC_$P($P($T(D0N),";",3),"|",2)
 S NXH=$P($P($T(DHN),";",3),"|",1)_NXC_$P($P($T(DHN),";",3),"|",2)
 S:CNT=10 DIR(0)=DIR(0)_";"_NX0
 S:FST>10 DIR(0)=DIR(0)_";"_$P($T(D0P),";",3)
 S:CNT=10 HC=HC+1,DIR("?",HC)=NXH
 S:FST>10 HC=HC+1,DIR("?",HC)=$P($T(DHP),";",3)
 D SCRHDR,^DIR
 I $D(DTOUT)!($D(DUOUT)) S SP="Q" Q
 I Y="N"!(Y="P") S FST=$S(Y="N":FST+10,1:FST-10) G MT10P
 S SP=Y Q
 ;
SETDIR ;Set common values for DIR used by LTE10P and MT10P 
 K DIR
 S DIR(0)=$P($T(SCO),";",3)
 S DIR("?",1)=$P($T(DH),";",3)
 S DIR("?")=$P($T(DHS),";",3)
 S DIR("A")=$P($T(DA),";",3)
 Q
SCRHDR ;Screen Header
 W:$D(IOF) @IOF
 W !,$P($T(SH1),";",3),!,$P($T(SH2),";",3),!
 Q
KILLVAR ;Kill variables to prepare for next look up
 K DIR,DTOUT,DUOUT,OREM,ENT,FILE,FLD,FLG,ID,IEN,IND,INST,NAME,NUM,NXC,NX0
 K NXH,RF,RFC,ORSCR,SP,VAL,X,X1,Y
 Q
KTG ;Kill the temp globals used by this program
 K ^TMP("ORPAL",$J),^TMP("ORPUL",$J) Q
LISTA ;Build a list of providers with the parameter already assigned to them.
 N ORERR,GBL,IEN,INST,LIST,PAR,X
 S LIST="^TMP(""ORPAL"",$J,""A"")",(INST,GBL)=1,ORERR=""
 S PAR=$QS($Q(^XTV(8989.51,"B","OR BILLING AWARENESS BY USER")),4)
 D ENVAL^XPAR(LIST,PAR,INST,.ORERR,GBL)
 S (IEN,X)="" F  S X=$O(^TMP("ORPAL",$J,"A",X)) Q:X=""  D
 . S IEN=$P(X,";"),^TMP("ORPAL",$J,"B",IEN)=""
 Q
LISTU ;Build a list of providers who have not been assigned the parameter
 N CNT,IEN
 S IEN="",CNT=0,^TMP("ORPUL",$J,"A")=CNT
 F  S IEN=$O(^XUSEC("PROVIDER",IEN)) Q:IEN=""  D
 . I $D(^TMP("ORPAL",$J,"A",IEN_";VA(200,",1))=1 Q
 . S CNT=CNT+1,^TMP("ORPUL",$J,"A")=CNT
 . S ^TMP("ORPUL",$J,"A",IEN)=IEN_";VA(200,"
 Q
 ;;Text used to build options, user messages, and help
FT0 ;;FO^1:40
FA ;;Select the provider to assign the parameter
FH1 ;;Enter the name/partial name of the provider to assign the parameter.
FH2 ;;This is free text, 1 to 40 characters in length.
FH3 ;;This search will only return those with the PROVIDER key and who
FH4 ;;do not have the CIDC parameter assigned to them. 
SCO ;;SO^
SH1 ;;Enable Clinical Indicator Data Capture By Provider Parameter Management
SH2 ;;Assign and Enable/Disable Parameter By Individual Provider Option
UA1 ;;Found no records matching the search criteria of
UA2 ;;The reasons for this could be that during the search:
UA3 ;;   1. The parameter is already assigned to any provider found.
UA4 ;;   2. No providers found.
UA5 ;;   3. No records found.
UA6 ;;Please try again
M1 ;;You have selected
M2 ;;to assign the Enable Clinical Indicator Data
M3 ;;Capture By Provider parameter to.
PE ;;E:Assign parameter and Enable CIDC for this provider
PD ;;D:Assign parameter and Disable CIDC for this provider
PA ;;Assign the parameter to this provider
PHE ;;Enter E to assign the parameter and enable CIDC for this provider.
PHD ;;Enter D to assign the parameter and disable CIDC for this provider.
D0N ;;N:Next | providers
D0P ;;P:Previous 10 providers
DH ;;Select the provider who the parameter will be assigned to.
DHN ;;Enter N to get the next | providers.
DHP ;;Enter P to get the previous 10 providers.
DHS ;;Enter "^" to exit or the Enter key to return to provider lookup.
DA ;;Select the provider to assign the parameter
