ORWDBA12 ; SLC/GDU - Billing Awareness - Phase I [10/18/04 10:24]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
 ;Enable Clinical Indicator Data Capture By Provider Parameter Module
 ;ORWDBA12 - Delete the assigned parameter
 ;
 ;This program is used to delete the assigned parameter of a selected
 ;provider.
 ;
 ;Programs Called:
 ; GETS^DIQ      Silent FileMan DBS call to get provider information
 ; ^DIR          General purpose response reader
 ; DEL^XPAR      Deletes the selected parameter
 ; ENVAL^XPAR    Returns list of records related to the parameter
 ;
 ;Variables used:
 ; BAEI       Billing Awareness Enabled Parameter Internal value
 ; DIR        Input array variable for ^DIR
 ; DTOUT      Timeout indicator output variable for ^DIR
 ; DUOUT      Up Arrow '^' indictor output variable for ^DIR
 ; ENT        Enitity, input variable for ^XPAR
 ; ORERR      Error, output variable for ^XPAR, and ^DIQ
 ; FILE       File number, input variable for ^DIQ
 ; FLD        Field number, input variable for ^DIQ
 ; FLG        Flag, input parameters variable for ^DIQ
 ; FST        Work variable controls build of user selection display
 ; GBL        Global, input parameter to direct ^XPAR output to a global
 ; HC         Help Count, work variable to set help text lines for ^DIR
 ; INST       Instance, input variable for ^XPAR
 ; LIST       List, output variable for ^XPAR
 ; OPTCNT     Option Count, counter variable to build options display
 ;            input variable for ^DIR
 ; PAR        Parameter, IEN of the parameter being worked with, input
 ;            variable for ^XPAR
 ; PRVCNT     Provider Count, counter variable to determine the number
 ;            of providers with the parameter assigned to them
 ; PRVIEN     Provider IEN, the internal entry number of the provider
 ; PRVNAME    Provider Name, the name of the provider
 ; RF         Record Found, output variable for ^DIQ
 ; SELKEY     Selected Key, work variable the IEN of the temp global
 ;            indicating the user's selection.
 ; U          Delemiter variable, defaulted to ^
 ; X          Standard work variable
 ; Y          Processed user selection output variable for ^DIC
 ;
 ;Globals Used:
 ;^XTV(8989.51,"B"
 ;    Standard B index for the Parameters file.
 ;    ^XTV(8989.51,"B",Parameter Name,Parameter IEN)
 ;^TMP("ORPAL",$J
 ;    Multipurpose temp global used for the delete process
 ;    Output global for ^XPAR
 ;    ^TMP("ORPAL",$J,"A")=total records returned
 ;    ^TMP("ORPAL",$J,"A",Provider IEN_";VA(200,",1)=parameter value
 ;    First pass processing of ^XPAR output
 ;    ^TMP("ORPAL",$J,"B",Provider Name)=IEN^param value
 ;    Second pass processing of ^XPAR output, work data for program
 ;    ^TMP("ORPAL",$J,"C",Record Count)=Name^IEN^param value
 ;    Third pass processing of ^XPAR output, input data for ^DIR, used
 ;    to create the user selection interface
 ;    ^TMP("ORPAL",$J,"D",Provider Name)=Record Count from "C"
MAIN ;Main starting point for the delete assigned Enable BA By User
 ;process
 N BAEI,DIR,DTOUT,DUOUT,ENT,ORERR,FILE,FLD,FLG,FST,GBL,HC,INST,LIST
 N OPTCNT,PAR,PRVCNT,PRVIEN,PRVNAME,RF,SELKEY,U,X,Y
 K ^TMP("ORPAL",$J),^TMP("SPL",$J)
 S U="^",(INST,GBL)=1
 S PAR=$QS($Q(^XTV(8989.51,"B","OR BILLING AWARENESS BY USER")),4)
BLDLST ;Build list of providers with the Enable CIDC By User parameter already
 ;assigned to them.
 S LIST="^TMP(""ORPAL"",$J,""A"")"
 D ENVAL^XPAR(LIST,PAR,INST,.ORERR,GBL)
 I ^TMP("ORPAL",$J,"A")=0 D  G EXIT
 . D SCRHDR
 . S DIR(0)="E"
 . S DIR("A",1)=$P($T(NPA1),";",2)
 . S DIR("A",2)=$P($T(NPA2),";",2)
 . S DIR("A",3)=$P($T(NPA3),";",2)
 . S DIR("A")=$P($T(NPA4),";",2)
 . W !!! D ^DIR K DIR
 S FILE=200,FLD=.01,(BAEI,FLG,PRVIEN,PRVNAME,X)=""
 F  S X=$O(^TMP("ORPAL",$J,"A",X)) Q:X=""  D
 . S PRVIEN=$P(X,";")
 . S BAEI=^TMP("ORPAL",$J,"A",X,1)
 . K RF,ERR
 . D GETS^DIQ(FILE,PRVIEN,FLD,FLG,"RF","ERR")
 . S PRVNAME=RF(FILE,PRVIEN_",",.01)
 . S ^TMP("ORPAL",$J,"B",PRVNAME)=PRVIEN_U_BAEI
 S PRVNAME="",PRVCNT=0
 F  S PRVNAME=$O(^TMP("ORPAL",$J,"B",PRVNAME)) Q:PRVNAME=""  D
 . S PRVCNT=PRVCNT+1
 . S ^TMP("ORPAL",$J,"C",PRVCNT)=PRVNAME_U_^TMP("ORPAL",$J,"B",PRVNAME)
 S PRVNAME="",PRVCNT=0
 F  S PRVCNT=$O(^TMP("ORPAL",$J,"C",PRVCNT)) Q:PRVCNT=""  D
 . S PRVNAME=$P(^TMP("ORPAL",$J,"C",PRVCNT),U)
 . S ^TMP("ORPAL",$J,"D",PRVNAME)=PRVCNT
 S FST=1  ;Prepare for display
DISOPT ;Display the list of providers with the Enable BDC By User parameter
 ;assigned to them. The user selects from this list the provider
 ;whose parameter is to be deleted.
DO1 S FST=1  ;Prepare for display
DO2 D SCRHDR  ;Display starts here
 S (OPTCNT,PRVNAME,X)="",DIR(0)="SO"_U
 F X=FST:1:10+(FST-1) Q:$D(^TMP("ORPAL",$J,"C",X))=0  D
 . S OPTCNT=OPTCNT+1
 . S:OPTCNT>10 OPTCNT=1
 . S PRVNAME=$P(^TMP("ORPAL",$J,"C",X),U)
 . S DIR(0)=DIR(0)_OPTCNT_":"_PRVNAME_";"
 S:OPTCNT=10 DIR(0)=DIR(0)_";"_$P($T(D0N),";",2)
 S:FST>10 DIR(0)=DIR(0)_";"_$P($T(D0P),";",2)
 S DIR(0)=DIR(0)_";"_$P($T(D0Q),";",2)
 S HC=1,DIR("?",HC)=$P($T(DHD),";",2)
 S:OPTCNT=10 HC=HC+1,DIR("?",HC)=$P($T(DHN),";",2)
 S:FST>10 HC=HC+1,DIR("?",HC)=$P($T(DHP),";",2)
 S DIR("A")=$P($T(DAD),";",2)
 S DIR("?")=$P($T(DHQ),";",2)
 D ^DIR K DIR
 I Y="Q"!(Y="")!($D(DTOUT))!($D(DUOUT)) G EXIT
 I Y="N" S FST=FST+10 G DO2
 I Y="P" S FST=FST-10 G DO2
 S PRVNAME=Y(0),(SELKEY,PRVIEN)=""
 S SELKEY=^TMP("ORPAL",$J,"D",PRVNAME)
 S PRVIEN=$P(^TMP("ORPAL",$J,"C",SELKEY),U,2)
 S BAEI=$P(^TMP("ORPAL",$J,"C",SELKEY),U,3)
DELETE ;Confirm the selected provider and delete the selected provider's
 ;assigned Enable BDC By User parameter
 D SCRHDR
 W !!,$P($P($T(DPM),";",2),"|"),PRVNAME,$P($P($T(DPM),";",2),"|",2)
 I BAEI=1 W !,$P($T(DPEM),";",2)
 E  W !,$P($T(DPDM),";",2)
 S DIR(0)="Y"
 S DIR("A")=$P($T(DPA),";",2)
 S DIR("B")="N"
 S DIR("?",1)=$P($T(DPHY),";",2)
 S DIR("?")=$P($T(DPHN),";",2)
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) Q
 I Y=1 D
 . S ENT=PRVIEN_";VA(200,"
 . D DEL^XPAR(ENT,PAR,INST,.ORERR)
AGAIN ;Ask the user if they want to do the delete process again.
 S DIR(0)="Y"
 S DIR("A")=$P($T(ADA),";",2)
 S DIR("B")="N"
 S DIR("?",1)=$P($T(ADHY),";",2)
 S DIR("?")=$P($T(ADHN),";",2)
 W !! D ^DIR K DIR
 I Y=1 G MAIN
 G EXIT
NPA ;No Parameter Set
 ;Error trap for no Enable BDC By User parameter are currently assigned
 D SCRHDR
 S DIR(0)="E"
 S DIR("A",1)=$P($T(NPA1),";",2)
 S DIR("A",2)=$P($T(NPA2),";",2)
 S DIR("A",3)=$P($T(NPA3),";",2)
 S DIR("A")=$P($T(NPA4),";",2)
EXIT ;Common exit point for this program
 K ^TMP("ORPAL",$J)
 Q
SCRHDR ;Screen Header Display
 W:$D(IOF) @IOF
 W !,"Enable Clinical Indicator Data Capture By Provider Parameter Management"
 W !,"Delete Assigned Parameter"
 Q
 ;Text for the user prompt in NPA
NPA1 ;No providers currently have the parameter assigned to them.
NPA2 ;You will need to select the 'Assign parameter to provider' option and
NPA3 ;assign this parameter to the providers.
NPA4 ;Press the return key or '^' to continue
 ;This is the text to build the DIR variables for use with ^DIR in
 ;DISOPT
D0N ;N:Next 10 Providers
D0P ;P:Previous 10 Providers
D0Q ;Q:Quit
DAD ;Select the provider to delete the assigned parameter
DHD ;Select the provider whose assigned parameter value is to be deleted.
DHN ;Enter N for the next 10 providers in the list.
DHP ;Enter P for the previous 10 providers in the list.
DHQ ;Enter Q to quit and return to the previous menu
 ;This is the text to build the DIR variable for use with ^DIR in DELETE
 ;and the user message.
DPM ;You have selected | to delete.
DPEM ;Clinical Indicator Data Capture for this provider is currently enabled.
DPDM ;Clinical Indicator Data Capture for this provider is currently disabled.
DPA ;Are you sure that you want to delete this provider's parameter
DPHY ;Enter Y for Yes to confirm deletion of this provider's parameter.
DPHN ;Enter N for No to not delete this provider's parameter.
 ;This is the text to build the DIR variable for use with ^DIR in AGAIN
ADA ;Delete another provider's parameter
ADHY ;Enter Y for Yes to delete another provider's parameter.
ADHN ;Enter N for No to not delete another provider's parameter.
