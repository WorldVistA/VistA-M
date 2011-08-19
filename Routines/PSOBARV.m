PSOBARV ;BHAM ISC/DMA - CHECK QUALITY OF BARCODES ; 1/15/88 8:20 AM
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 S DIR("A")="Do you need instructions? ",DIR("B")="N",DIR(0)="SA^1:YES;0:NO",DIR("?")="Enter 'Yes' if instructions are needed, otherwise press RETURN."
 D ^DIR G:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) OUT I Y D INST
RUN K DIR R !!,"Read Barcode : ",X:DTIME,! S:'$T X="^" G OUT:"^"[X G HELP:X["?" G RUN
OUT K DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,J,Y Q
HELP S DIR("A",1)="Scan the barcode now",DIR("A")="Do you need further instructions? ",DIR("B")="N",DIR(0)="SA^1:YES;0:NO",DIR("?")="Enter 'Yes' if instructions are needed, otherwise press RETURN."
 D ^DIR G:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) OUT I Y D INST
 G RUN
INST F J=1:1 S D=$T(NEWS+J) Q:D=""  W !,?5,$P(D,";;",2,2000) I J#22=0 R !,"return to continue ",X:DTIME S:'$T X="^" Q:X="^"
 K D Q
 ;
NEWS ;
 ;;
 ;;This option allows you to check the quality of your printed
 ;;barcodes.  It can also be used for practice in using the
 ;;barcode reader.
 ;;
 ;;ABSOLUTELY NO ACTION IS TAKEN ON THE PRESCRIPTION BY
 ;;                  USING THIS OPTION
 ;;
 ;;Common causes for failure to read are:
 ;;1.  Barcode too faint  (change printer ribbon)
 ;;2.  Improper scanning  (move the wand at a steady rate)
 ;;3.  Defective barcode reader  (replace the reader)
 ;;
