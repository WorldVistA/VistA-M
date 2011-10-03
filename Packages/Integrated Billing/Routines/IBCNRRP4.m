IBCNRRP4 ;DAOU/DB - Pharmacy Plan Report ;08-MAR-2004
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; New the FileMan variables
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 N L,DIC,FLDS,BY,FR,TO,DHD,DIOBEG,D0
 ; Ask user for which sort method
 ; Set up the variables used by the reader
 I '$D(IOF) D HOME^%ZIS
 W @IOF
 S DIR(0)="SO^1:PLAN NAME;2:BIN AND PCN"
 S DIR("A")="Enter Report Sort Option",DIR("?")="Enter the desired sort for the report"
 D ^DIR
 ; Validate output from the reader
 I Y'=1,Y'=2 Q
 ; Set up variables for calling the print option
 ; .01-ID, .02-PLAN, 10.02-BANKING IDENTIFICATION NUMBER, 10.03-PROCESSOR CONTROL NUMBER (PCN)
 S L=0,DIC="^IBCNR(366.03,",DIOBEG="I $E(IOST,1,2)=""C-"" W @IOF"
 I Y=1 S BY=".02",DHD="PHARMACY PLAN LIST BY NAME"
 E  S BY="10.02,10.03",DHD="PHARMACY PLAN LIST BY BIN AND PCN"
 S FR="",TO=""
 S FLDS=".01;L10;""PLAN ID"",.02;L40;""PLAN NAME"",10.02;L8;""BIN"",10.03;L16;""PCN"""
 D EN1^DIP
 Q
