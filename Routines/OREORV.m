OREORV ; SLC/GDU - Orderable Items File Record Validation [10/15/04 09:16]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**217**;Dec 17, 1997
 ;OREORV - Orderable Item Record Validation
 ;
 ;FIX FOR NOIS CASES:
 ;DAN-0204-42157, ALB-1001-51034, SBY-0803-30443, NJH-0402-20607
 ;
 ;Presents the user with an explanation of the purpose of this program.
 ;It will ask the user if they wish to run the OI record validation.
 ;Allows the user to select where the output of the report is sent to.
 ;Also allows the user to queue the program run to TASKMAN.
 ;
 ;External Variables
 ;  IO  - Selected IO device
 ;  IOF - IO device Form Feed
 ;  ION - IO device logical name
 ;
 ;External References
 ;  ^%ZIS    - DBIA 10086
 ;  ^%ZISC   - DBIA 10089
 ;  ^%ZTLOAD - DBIA 10063
 ;  ^DIR     - DBIA 10026
 ;  ^OREORV1 - Second routine of this utility
 ;  ^OREORV2 - Third routine of this utility
 ;
MAIN ;Main entry point for this program
 ;Local Variables
 ;  %ZIS   - Input specification variable, ^%ZIS
 ;  DIR    - Input array variable for ^DIR
 ;  DLI    - Description Line Index
 ;  DL     - Description Line, indirect variable
 ;  DTOUT  - Time out indicator, output variable ^DIR
 ;  DUOUT  - Up arrow out indicator, output variable ^DIR
 ;  PLI    - Prompt Line Index
 ;  PL     - Prompt Line, indirect variable
 ;  POP    - Exit Status, output variable ^%ZIS
 ;  ZTDESC - Task Description, input variable ^%ZTLOAD
 ;  ZTIO   - Task IO device, input variable ^%ZTLOAD
 ;  ZTRTN  - Task routine entry point, input variable ^%ZTLOAD
 ;  ZTSK   - Task number assigned, output variable ^%ZTLOAD
 ;  Y      - Processed user input, output variable ^DIR
 N %ZIS,DIR,DLI,DL,DTOUT,DUOUT,PLI,PL,POP,ZTDESC,ZTIO,ZTRTN,ZTSK,Y
 ;Clears screen and presents explanation, asks if user wants to continue
 W:$D(IOF) @IOF
 W $P($T(SH),";",3),!
 F DLI=1:1:19 S DL="DL"_DLI W !,$P($T(@DL),";",3)
 S DIR(0)="Y",DIR("A")=$P($T(PMT1),";",3)
 W ! D ^DIR
 ;If user selects No, up-arrows out, or times out program is stopped
 I Y=0!($D(DTOUT))!($D(DUOUT)) G EXIT
 ;If user selects Yes, programs presents user with device selection.
 W:$D(IOF) @IOF
 W $P($T(SH),";",3),!
 F PLI=1:1:6 S PL="PL"_PLI W !,$P($T(@PL),";",3)
 W !
 S %ZIS="Q" D ^%ZIS
 ;Processing user device selection
 I POP G EXIT
 I $D(IO("Q")) D  K IO("Q") G EXIT
 . S ZTDESC="Orderable Item Validation Report"
 . S ZTRTN="EN^OREORV"
 . S ZTIO=ION
 . D ^%ZTLOAD I $D(ZTSK) W !?32,"REQUEST QUEUED"
 U IO D EN
EXIT ;Exit point for this program
 D ^%ZISC
 Q
EN ;Process the File 101.43
 ;TASKMAN entry point
 ;^TMP($J,"OIC" is fully documented in OREORV1
 K ^TMP($J,"OIC")
 ;Builds temp global ^TMP($J,"OIC", flags active OI records w/o matching
 ;source records.
 D ^OREORV1
 ;Print report from contents of ^TMP($J,"OIC"
 D ^OREORV2
 K ^TMP($J,"OIC")
 Q
 ;User interface text
SH ;;Orderable Items File Record Validation
DL1 ;;Brief Description:
DL2 ;;This program scans the Orderable Items file, file # 101.43.
DL3 ;;It take the value stored in the ID field and performs a set of tests.
DL4 ;;
DL5 ;;   1. It determines if the ID field is null.
DL6 ;;   2. It determines if it has a source record IEN
DL7 ;;   3. It determines if it has a source record package code
DL8 ;;   4. It determines if the package code is formatted properly
DL9 ;;   5. It determines if the package code is in the current spec*
DL10 ;;      If package code is not in current spec*, it is included in the
DL11 ;;      report for manual confirmation. It is not modified by this
DL12 ;;      utility.
DL13 ;;   6. It Validates records by matching to a source file record
DL14 ;;      If no match found and record is active it is flagged inactive.
DL15 ;;   7. It creates a report detailing its findings.
DL16 ;;
DL17 ;;* The source files the orderable item record is tested against are
DL18 ;;defined in the OE/RR Version 3 Package Interface Specification July
DL19 ;;2001
PMT1 ;;Do you wish to run this program? Enter Yes or No
PL1 ;;Select where you want the report to print to.
PL2 ;;
PL3 ;;Just hit enter to send the report to the screen.
PL4 ;;Enter the name of the printer.
PL5 ;;Queue the program to run at a later time.
PL6 ;;Enter "^" to quit
