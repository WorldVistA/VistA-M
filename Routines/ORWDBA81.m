ORWDBA81 ; SLC/GDU - Billing Awareness - Phase I [10/18/04 10:42]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
 ;Enable Clinical Indicator Data Capture By Provider Parameter Module
 ;ORWDBA81 - Mass assign the parameter to all providers without the 
 ;           parameter and set it to 1 to enable the CIDC functionality.
 ;
 ;Local Variables
 ;DIR          Input array variable for ^DIR
 ;DTOUT        Timeout indicator, output variable of ^DIR
 ;DUOUT        Up arrow indicator, output variable of ^DIR
 ;ENT          Entity the parameter is assigned to, input variable for
 ;             ADD^XPAR
 ;ORERR        Error Message, output variable of ADD^XPAR
 ;INST         Instance indicator, input variable for ADD^XPAR
 ;IOF          Clear Screen and move cursor to top of screen, standard
 ;             Kernal IO variable
 ;PAR          The Name or IEN of a parameter in the PARAMETER DEFINITION
 ;             FILE, input variable for ADD^XPAR 
 ;VAL          Value of the parameter being added, input variable for
 ;             ADD^XPAR
 ;X            Standard FileMan work varaible
 ;Y            Processed output of user selection, output variable for
 ;             ^DIR
 ;
 ;Global Variables
 ;^TMP("ORPUL" Temp global for providers who do not have the
 ;             Enable/Disable CIDC By Provider parameter assigned to them
 ;^XTV(8989.51 PARAMETER DEFINITION FILE, file # 8989.51
 ;
 ;External References
 ;^DIR         FileMan general purpose response reader
 ;ADD^XPAR     PARAMETER TOOLS, API to add a new parameter value
 ;
MAIN ;Starting point of this program
 N DIR,DTOUT,DUOUT,ENT,ORERR,INST,PAR,VAL,X,Y
 ;Prepare and display user options for this program
 S DIR(0)=$P($T(SXOPT),";",3)_";"
 S DIR(0)=DIR(0)_$P($T(OY),";",3)_";"_$P($T(ON),";",3)
 S DIR("A",1)=^TMP("ORPUL",$J,"A")_" "_$P($T(A1),";",3)
 S DIR("A",2)=$P($T(A2),";",3)
 S DIR("A",3)=$P($T(A3),";",3)
 S DIR("A")=$P($T(A4),";",3)
 S DIR("?",1)=$P($T(HY),";",3)
 S DIR("?")=$P($T(HN),";",3)
 D SCRHDR,^DIR K DIR
 ;Process user selection.
 I Y="NO"!($D(DTOUT))!($D(DUOUT)) Q  ;If NO, timeout, or up arrow quit
 ;Process the mass parameter assignment and functionality enabling
 S (ENT,X)="",(INST,VAL)=1
 S PAR=$QS($Q(^XTV(8989.51,"B","OR BILLING AWARENESS BY USER")),4)
 D SCRHDR
 W !!,$P($T(EP),";",3),!
 S X="" F  S X=$O(^TMP("ORPUL",$J,"A",X)) Q:X=""  D
 . W "."
 . S ENT=^TMP("ORPUL",$J,"A",X)
 . D ADD^XPAR(ENT,PAR,INST,VAL,.ORERR)
 ;Alert user the mass parameter assignment and functionality enabling is
 ;done.
 S DIR(0)="E",DIR("A")=$P($T(EC),";",3)
 D ^DIR K DIR Q
SCRHDR ;Screen Header
 W:$D(IOF) @IOF
 W !,$P($T(SH1),";",3),!,$P($T(SH2),";",3)
 Q
SXOPT ;;SX^
SH1 ;;Enable Clinical Indicator Data Capture By Provider Parameter Management
SH2 ;;Assign/Enable Parameter For All Providers Option
OY ;;YES:Enter YES to begin process of assign/enable
ON ;;NO:Enter NO to cancel process of assign/enable and quit
A1 ;;providers do not have this parameter assigned to them.
A2 ;;You have selected to assign the parameter and enable Clinical Indictor
A3 ;;Data Capture for all of these providers. This may take some time.
A4 ;;Are you sure you want to do this? (YES/NO - must be all caps)
HY ;;Enter YES to begin the assign/enable process.
HN ;;Enter NO to cancel the assign/enable process and quit.
EP ;;Now assigning CIDC parameter and enabling the functionality.
EC ;;CIDC parameter assignment and functionality enabling complete.
