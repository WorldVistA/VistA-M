ORWDBA14 ; SLC/GDU - Billing Awareness - Phase I [10/18/04 10:26]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
 ;Enable Billing Data Capture By Provider Parameter
 ;ORWDBA14 - Get a report of assigned parameters
 ;
 ;Report to print out the providers with the Billing Data Capture By
 ;Provider parameter set.
 ;Billing Data Capture By Provider will be referred to as BDCBP.
 ;Billing Data Capture will be referred to as BDC
 ;The user has the option to search by:
 ; 1. For all providers with the BDCBP parameter
 ; 2. For all providers with the BDCBP parameter and BDC enabled
 ; 3. For all providers with the BDCBP parameter and BDC disabled
 ;
 ;Programs called:
 ; ^%ZIS         DBIA 10086
 ; ^%ZISC        DBIA 10089
 ; ^%ZTLOAD      DBIA 10063
 ; ^DIR          DBIA 10026
 ; RPT^ORWDBA16  Generates and prints the report
 ; ENVAL^XPAR    DBIA 2263
 ;
 ;Variables Used:
 ; %ZIS     KERNEL device selection variable
 ; DIR      Input array variable for ^DIR
 ; DTOUT    Timeout indicator variable, output from ^DIR
 ; DUOUT    Up Arrow '^' indicator variable, output from ^DIR
 ; ORERR    Error message output array variable from ENVAL^XPAR
 ; IO       Input / Output array variable, System settings
 ; IOF      Page feed variable, System settings
 ; ION      Device name, System settings
 ; POP      Cancel device select, program run output from ^%ZIS
 ; SEARCH   User select of type of report to run
 ; Y        Processed user selection, output from ^DIR
 ; ZTDESC   Description of queued job, input for ^%ZTLOAD
 ; ZTIO     Device selected for the queued job, input for ^%ZTLOAD
 ; ZTRTN    Routine selected for the queued job, input for ^%ZTLOAD
 ; ZTSAVE   Input parameters for the queued job, input for ^%ZTLOAD
 ; ZTSK     Internal Entry Number of the queued job, output from ^%ZTLOAD
 ;
 ;Globals Used:
 ; ^TMP("ORCK"
 ; Temp global to hold value of LIST, output from ENVAL^XPAR. If
 ; ^TMP("ORCK",$J,"A") has a count of 0 the user is alerted that there
 ; are no parameter assigned to providers. This is acknowledged by the
 ; user and the program quits.
 ;
MAIN ;Main starting point for this program
 ;User selects the type of report to run. Then selects the device the
 ;reports output will go.
 N %ZIS,DIR,DTOUT,DUOUT,ORERR,POP,SEARCH,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ;Check for assigned parameters.
 D ENVAL^XPAR("^TMP(""ORCK"",$J,""A"")","OR BILLING AWARENESS BY USER",1,.ORERR,1)
 ;If none found alert user, exit program
 I ^TMP("ORCK",$J,"A")=0 D  G EXIT
 . D SCRHDR
 . S DIR(0)="E"
 . S DIR("A",1)=$P($T(NPA1),";",3)
 . S DIR("A",2)=$P($T(NPA2),";",3)
 . S DIR("A",3)=$P($T(NPA3),";",3)
 . S DIR("A")=$P($T(NPA4),";",3)
 . W !! D ^DIR K DIR
 K ^TMP("ORCK",$J)
 S SEARCH=""
 S DIR(0)="SO^"_$P($T(L0A),";",3)_";"
 S DIR(0)=DIR(0)_$P($T(L0E),";",3)_";"
 S DIR(0)=DIR(0)_$P($T(L0D),";",3)
 S DIR("?",1)=$P($T(LHA),";",3)
 S DIR("?",2)=$P($T(LHE),";",3)
 S DIR("?")=$P($T(LHD),";",3)
 S DIR("A")=$P($T(LA),";",3)
 D SCRHDR,^DIR K DIR S SEARCH=Y
 I SEARCH="Q"!(SEARCH="")!($D(DTOUT))!($D(DUOUT)) G EXIT
 S %ZIS="Q" D ^%ZIS I POP G EXIT
 I $D(IO("Q")) D  K IO("Q") G EXIT
 . S ZTIO=ION
 . S ZTDESC="BA Enabled By User Report"
 . S ZTRTN="RPT^ORWDBA16"
 . S ZTSAVE("SEARCH")=""
 . D ^%ZTLOAD I $D(ZTSK) W !?32,"REQUEST QUEUED"
 U IO D RPT^ORWDBA16
 D ^%ZISC
AGAIN ;Ask if the user would like to repeat the parameter report process
 ;If yes, the program starts over.
 ;If no, the program quits and the user is returned to the previous menu.
 S DIR(0)="Y"
 S DIR("A")=$P($T(ALA),";",3)
 S DIR("B")="N"
 S DIR("?",1)=$P($T(ALHY),";",3)
 S DIR("?")=$P($T(ALHN),";",3)
 W !! D ^DIR K DIR
 I Y=1 G MAIN
EXIT ;Exit point for this program
 K ^TMP("ORCK",$J)
 D ^%ZISC
 Q
SCRHDR ;Screen Header Display
 W:$D(IOF) @IOF
 W !,"Enable Clinical Indicator Data Capture By Provider Parameter Management"
 W !,"Assigned Parameter Report"
 Q
 ;Text to build the DIR variable for ^DIR in LIST
L0A ;;A:All providers with CIDC parameter
L0E ;;E:Only providers with CIDC enabled
L0D ;;D:Only providers with CIDC disabled
LA ;;Enter the search criteria
LHA ;;Enter A to list all providers with Clinical Indicator Data Capture parameter.
LHE ;;Enter E to list only providers with Clinical Indicator Data Capture enabled.
LHD ;;Enter D to list only providers with Clinical Indicator Data Capture disabled.
 ;Text to build the DIR variable for ^DIR in NPA
NPA1 ;;No providers currently have the parameter assigned to them.
NPA2 ;;You will need to select the 'Manage parameter by provider' option and
NPA3 ;;assign this parameter to the providers.
NPA4 ;;Press the return key or '^' to continue.
 ;Text to build the DIR variable for ^DIR in AGAIN
ALA ;;Run another report
ALHY ;;Enter Y for Yes to run another report.
ALHN ;;Enter N for No to not run another report.
