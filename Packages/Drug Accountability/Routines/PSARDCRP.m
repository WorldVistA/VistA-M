PSARDCRP ;BIRM/JMC - Return Drug Credit Report User Input Parameter ;06/04/08
 ;;3.0;DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**69**;10/24/97;Build 9
 ; 
 I '$$CHKEY^PSARDCUT() Q
 N DIR,DIRUT,DUOUT,DTOUT,PSAPHLOC,PSADTRNG,PSARDRBD,PSARDRED,PSABASTS
 N PSARDRT,PSAEXCEL
 ; - Pharmacy location selection
 S PSAPHLOC=$$PHLOC^PSARDCUT() I PSAPHLOC=""!($D(DIRUT)) Q
 ;
 ; - Date range selection
 W ! S PSADTRNG=$$DTRNG^PSARDCUT("T-90","T") I PSADTRNG="^"!($D(DIRUT)) Q
 S PSARDRBD=$P(PSADTRNG,"^"),PSARDRED=$P(PSADTRNG,"^",2)
 ; 
 ; - Return drug credit status selection
 W ! S PSABASTS=$$STASEL^PSARDCUT() I PSABASTS=""!($D(DIRUT)) Q
 I PSABASTS="ALL" S PSABASTS="AP,PU,CA,CO"
 ;
 ; - Report type selection
 W ! S PSARDRTP=$$DETSUM() I PSARDRTP=""!($D(DIRUT)) Q
 ;
 ; - Export to Spreadsheet
 W ! S PSAEXCEL=$$EXCEL^PSARDCUT() I PSAEXCEL=""!(PSAEXCEL="^")!($D(DIRUT)) Q
 ;
DEVICE ; - Select Device
 W ! K %ZIS,IOP,POP,ZTSK S %ZIS="QM" D ^%ZIS I POP D  D EXIT Q
 . W !!,"No device selected.  Exiting...",!! S DIR(0)="E" W ! D ^DIR K DIR
 I $D(IO("Q")) D  D EXIT Q
 . N G K ZTIO,ZTSAVE,ZTDTH,ZTSK
 . S ZTRTN=$S(PSARDRTP="S":"^PSARDCRS",1:"^PSARDCRD"),ZTDESC="Returned Drug Credit Report"_$S(PSARDRTP="S":"(Summary)",1:" (Detailed")
 . F G="PSAPHLOC","PSARDRBD","PSARDRED","PSABASTS","PSARDCMF","PSARDRTP","PSAEXCEL" S ZTSAVE(G)=""
 . D ^%ZTLOAD
 . I $D(ZTSK) W !,"Report is Queued to print as Task #: ",ZTSK,!! S DIR(0)="E" W ! D ^DIR K DIR Q
 ; - Determine which report routine to call based on report type selected.
 I $G(PSARDRTP)="S" D ^PSARDCRS
 I $G(PSARDRTP)="D" D ^PSARDCRD
 Q:$D(DIRUT)!($D(DUOUT))
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR
 D EXIT
 Q
 ;
EXIT I IO'=IO(0) D ^%ZISC
 K IO("Q"),ZTSK,%ZIS,ZTIO,ZTSAVE,ZTDTH,Y,X
 Q
DETSUM() ; Detailed or Summary report type selection.
 K DIR S DIR(0)="SA^D:DETAILED;S:SUMMARY;",DIR("A")="REPORT TYPE: ",DIR("B")="SUMMARY"
 S DIR("?")="Enter 'D' to print a detailed report or 'S' for a summary report" D ^DIR K DIR
 I $D(DIRUT) Q ""
 Q Y
 ; 
