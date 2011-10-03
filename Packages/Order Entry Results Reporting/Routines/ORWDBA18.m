ORWDBA18 ; SLC/GDU - Billing Awareness - Phase I [10/18/04 10:30]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
 ;Enable Billing Awareness By User Parameter Module
 ;ORWDBA18 - Assign the parameter utilities
 ;
SETUP ;Run temp global kill, build assigned list, build unassigned list
 D KTG,LISTA,LISTU Q
 ;
KTG ;Kill the temp globals used by this program
 K ^TMP("ORPAL",$J),^TMP("ORPUL",$J) Q
LISTA ;Build a list of providers with the parameter already assigned to them.
 N ORERR,PIV,NAME,X
 S (ORERR,X)="",U="^"
 D ENVAL^XPAR("^TMP(""ORPAL"",$J,""A"")","OR BILLING AWARENESS BY USER",1,.ORERR,1)
 Q:^TMP("ORPAL",$J,"A")=0
 F  S X=$O(^TMP("ORPAL",$J,"A",X)) Q:X=""  D
 . S IEN=$P(X,";"),PIV=^TMP("ORPAL",$J,"A",X,1)
 . S NAME=$$GET1^DIQ(200,IEN,.01)
 . S ^TMP("ORPAL",$J,"B",IEN)=NAME_U_PIV
 Q
LISTU ;Build a list of providers who have not been assigned the parameter
 N CNT,IEN,PRVKEY,NAME
 S (NAME,IEN,PRVKEY)="",(CNT,^TMP("ORPUL",$J,"A"))=0
 F  S NAME=$O(^VA(200,"B",NAME)) Q:NAME=""  D
 . S IEN=$QS($Q(^VA(200,"B",NAME)),4)
 . S PRVKEY=$$PRVKEY^ORWDBA1(IEN)  ;Check for provider key
 . I PRVKEY=0 Q  ;If not a provider quit
 . I $D(^TMP("ORPAL",$J,"B",IEN))=1 Q  ;If already assigned quit
 . ;Build ^TMP("ORPUL"
 . S CNT=CNT+1,^TMP("ORPUL",$J,"A")=CNT
 . S ^TMP("ORPUL",$J,"B",CNT)=NAME_U_IEN
 . S ^TMP("ORPUL",$J,"C",NAME)=CNT
 Q
ALERT ;Alert the user, all providers have been assigned the parameter
 ;Kill temp globals and quit
 N DIR
 D SCRHDR S DIR(0)="E"
 W !!,$P($T(ALLPA),";",2),!!
 D ^DIR K DIR
 D KTG Q
 ;
DISPRV ;Displays the providers in the unassigned list for user selection
 ;PRVNAME is set to null in ORWDBA8 and is reset based on user selection
 ;Selection of Q for quit, timeout, and up arrow will set PRVNAME to Q
 ;Selection of provider will set PRVNAME to the selected provider's name
 ;Prepare for display of providers
 ;N CNT,DIR,DTOUT,DUOUT,FST,HC,U,X,Y
 S FST=1,U="^"
DPO ;Display process starts here
 D SCRHDR
 S (X,Y)="",CNT=0,HC=1,DIR(0)=$P($T(SOOPT),";",3)
 F X=FST:1:10+(FST-1) Q:$D(^TMP("ORPUL",$J,"B",X))=0  D
 . S CNT=CNT+1 S:CNT>10 CNT=1
 . S DIR(0)=DIR(0)_CNT_":"_$P(^TMP("ORPUL",$J,"B",X),U)_";"
 S:CNT=10 DIR(0)=DIR(0)_";"_$P($T(D0N),";",3)
 S:FST>10 DIR(0)=DIR(0)_";"_$P($T(D0P),";",3)
 S DIR(0)=DIR(0)_";"_$P($TEXT(D0Q),";",3)
 S DIR("A")=$P($T(DA),";",3)
 S DIR("?",HC)=$P($T(DH),";",3)
 S:CNT=10 HC=HC+1,DIR("?",HC)=$P($T(DHN),";",3)
 S:FST>10 HC=HC+1,DIR("?",HC)=$P($T(DHP),";",3)
 S DIR("?")=$P($T(DHQ),";",3)
 D ^DIR K DIR
 I Y="Q"!(Y="")!($D(DTOUT))!($D(DUOUT)) S PRVNAME="Q" Q
 I Y="N"!(Y="P") S FST=$S(Y="N":FST+10,1:FST-10) G DPO
 S PRVNAME=Y(0) Q
CONMAS ;Confirm the mass assignment of the parameter
 ;MRC is set to null and ORWDBA8 and reset based on user selection here
 ;DIR array is set to values based on user selection in ORWDBA8
 ;Selection of NO, timeout, and up arrow will set MRC=0
 ;Selection of YES will set MRC=1
 S Y="" D SCRHDR,^DIR K DIR I Y="NO"!($D(DTOUT))!($D(DUOUT)) S MRC=0 Q
 S MRC=1 Q
MASASN ;Mass Assignment of the parameter
 ;SEL is set in ORWDBA8 by user selection.
 ;SEL="E", the parameter is set to 1 to enable Billing Data Capture
 ;SEL="D", the parameter is set to 0 to disable Billing Data Capture
 N DIR,ENT,ORERR,INST,PAR,U,VAL,X
 S (ENT,X)="",U="^",INST=1,VAL=$S(SEL="E":1,1:0)
 S PAR=$QS($Q(^XTV(8989.1,"B","OR BILLING AWARENESS BY USER")),4)
 D SCRHDR W !!
 F X=1:1:^TMP("ORPUL",$J,"A") D
 . W "."
 . S ENT=$P(^TMP("ORPUL",$J,"B",X),U,2)_";VA(200,"
 . D ADD^XPAR(ENT,PAR,INST,VAL,.ORERR)
 S DIR(0)="E",DIR("A")=$S(SEL="E":$P($T(MEC),";",3),1:$P($T(MDC),";",3))
 D ^DIR K DIR Q
SCRHDR ;Screen Header
 W:$D(IOF) @IOF
 W !,$P($T(SH),";",3),!
 W:SEL="" $P($T(SHA),";",3)
 W:SEL="E" $P($T(SHAE),";",3)
 W:SEL="D" $P($T(SHAD),";",3)
 W:SEL="I" $P($T(SHAI),";",3)
 Q
 ;;Text for user messages, selection options, user help
ALLPA ;;All providers have been assigned the parameter.
SOOPT ;;SO^
SXOPT ;;SX^
SH ;;Enable Clinical Indicator Data Capture By Provider Parameter Management
SHA ;;Assign Parameter To Provider Option
SHAE ;;Assign/Enable Parameter For All Providers Option
SHAD ;;Assign/Disable Parameter For All Providers Option
SHAI ;;Assign and Enable/Disable Parameter By Individual Provider Option
MMPA ;;All providers have the Enable CIDC By User parameter assigned.
DH ;;Select the provider who the parameter will be assigned to.
DHN ;;Enter N to get the next 10 providers in the list.
DHP ;;Enter P to get the previous 10 providers in the list.
DHQ ;;Enter Q to quit and return to previous menu.
D0N ;;N:Next 10 providers
D0P ;;P:Previous 10 providers
D0Q ;;Q:Quit
DA ;;Select the provider to assign the parameter
MEP ;;Now assigning and enabling the Clinical Indicatr Data Capture parameter
MEC ;;Assignment and enable Clinical Indicator Data Capture complete
MDP ;;Now assigning and disabling the Clinical Indicator Data Capture parameter
MDC ;;Assignment and disable Clinical Indicator Data Capture complete
