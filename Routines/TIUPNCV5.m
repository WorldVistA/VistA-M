TIUPNCV5 ;SLC/DJP ;PNs ==> TIU cnv rtns ;5-7-97
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
INTRO ;Introduction text
 K DIR W @IOF W !!?16,"**** PROGRESS NOTE CONVERSION ****"
 I $P($G(^GMR(121.99,1,"TITLE")),U,4)'="FINISHED" D MOREWK Q
 D CANRUN Q:$G(TIU("QUIT"))
 W !!?5,"This option will copy the data from the Generic Progress Note"
 W !?5,"package (File #121) into the Text Integration Utility (TIU)"
 W !?5,"package (File #8925).  Entries missing required data fields"
 W !?5,"are ignored during processing but annotated on an error list."
 ;
 W !!?5,"The Generic Progress Note (^GMR 121) global will NOT be"
 W !?5,"automatically deleted during this process.  It is recommended"
 W !?5,"that the file be archived and purged as soon as possible after"
 W !?5,"the conversion has been verified as complete."
 ;
 W !!?5,"A mail message documenting all discrepancies encountered during"
 W !?5,"processing will be sent to you upon completion or halt of the"
 W " conversion.",!
 W !?5,"During conversion, a cross-reference is set in the"
 W !?5,"GENERIC PROGRESS NOTE file (#121)- which contains"
 W !?5,"the IEN of the progress note and the corresponding"
 W !?5,"IEN in the TIU DOCUMENT file (#8925).",!
 W !?5,"FORMAT:  ^GMR(121,""CNV"",IEN)=TIU IEN",!!
 S DIR(0)="E" D ^DIR I $D(DIRUT) S TIU("QUIT")=1 Q
 K DIR
 D PNIEN Q:$G(TIU("QUIT"))
 D MAIL Q:$G(TIU("QUIT"))
 Q
 ;
MOREWK ;Must run GMRP*2.5*44 before installing & implementing TIU
 S TIU("QUIT")=1
 K DIR
 W !!?5,"You MUST install and implement the patch, GMRP*2.5*44, prior"
 W !?5,"to converting data from the Generic Progress Note files to the"
 W !?5,"Text Integration Utility files.  This is a MUST DO action.",!
 W !?5,"Additional information concerning this patch may be found in the"
 W !?5,"TIU Implementation Guide."
 H 2
 Q
 ;
MAIL ;Mail Prompt
 S TIUMAIL=$P(^VA(200,TIU("DUZ"),0),U,1)
 W ! K DIR S DIR(0)="P^200:EMZ"
 S DIR("A")="Please enter person to receive the completion message"
 S DIR("B")=TIUMAIL,DIR("?")="^D HELP6^TIUPNCV5"
 D ^DIR K DIR I $D(DIRUT)!(Y<0) S TIU("QUIT")=1 Q
 S TIUUSER=$P(Y,U,1)
 Q
 ;
PNIEN ;GMRPN IEN Prompt
 N GMRPDA
 S GMRPDA="A"
 S GMRPDA=$O(^GMR(121,GMRPDA),-1)
 W ! K DIR S DIR(0)="NA^0:99999999"
 S DIR("A")="Enter IEN of last Progress Note in ^GMR(121 :  "
 S DIR("B")=GMRPDA,DIR("?")="^D HELP10^TIUPNCV7" D ^DIR K DIR
 I $D(DIRUT)!(Y<0) S TIU("QUIT")=1 Q
 S TIUPNIEN=+Y
 Q
 ;
HELP6 ;Help text for MAIL prompt
 W !!?5,"At the completion of the conversion a bulletin will sent"
 W !?5,"to this individual indicating completion status."
 Q
 ;
CANRUN ; If Progress Note Conversion is currently running or the
 ; Discharge Summary conversion is running, you CANNOT restart or
 ; begin to run the Progress Note Conversion
 S TIU2=$P($G(^TIU(8925.97,1,0)),U,2) ;start date
 S TIU5=$P($G(^TIU(8925.97,1,0)),U,3) ;completed date
 S TIU3=$P($G(^TIU(8925.97,1,0)),U,5) ;processing ien
 I +$G(TIU2),+$G(TIU5),'+$G(TIU3) D  Q
 . S TIU("QUIT")=1
 . W !!?5,"Progress Note Conversion now running.",!
 . W !?5,"DO NOT RUN CONVERSION",!
 . K TIU2,TIU5,TIU3
 . H 5
 I +$G(^GMR(128,"CNV","T0")),'+$G(^GMR(128,"CNV","T1")) D  Q
 . S TIU("QUIT")=1
 . W !!?5,"Discharge Summary Conversion now running.",!
 . W !?5,"Do not run Progress Note Conversion concurrently.",!
 . H 5
 Q
 ;
