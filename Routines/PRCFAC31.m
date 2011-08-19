PRCFAC31 ;WISC/SJG-CONTINUATION OF FISCAL VENDOR EDIT ;12/12/94  15:52
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;;
GET(VEN) ; Retrieve Vendor Payment Information from File 440
 N DA,DIC,DIQ,DR
 S DIC=440,DA=VEN,DIQ="PRCTMP(",DIQ(0)="IEN"
 S DR=".01;17;17.2;17.3;17.4;17.5;17.6;17.7;17.8;17.9;18.3;34;35;36;45"
 D EN^DIQ1
 QUIT
 ;
DISPLAY(VEN) ; Display Vendor Payment Information
 I $D(IOF) W @IOF D HDR^PRCFAC3
 W !,IOINHI,"Payment Information",IOINORM,!
 W !?2,IOINHI,"Vendor Name: ",IOINORM,$G(PRCTMP(440,VEN,.01,"E"))
 W !,IOINHI,"Vendor Number: ",IOINORM,VEN
 W ?40,IOINHI,"Non-Recurring/Recurring: ",IOINORM,$S($G(PRCTMP(440,VEN,36,"I"))="N":"NON-RECURRING",1:"RECURRING")
 W !!,IOINHI,?17,"FMS Vendor Code: ",IOINORM,$G(PRCTMP(440,VEN,34,"E"))
 W !,?5,IOINHI,"Alternate Address Indicator: ",IOINORM,$G(PRCTMP(440,VEN,35,"E"))
 W !!,?5,IOINHI,"Address: ",IOINORM
 I $D(PRCTMP(440,VEN,17.3,"E")) W ?14,$G(PRCTMP(440,VEN,17.3,"E")),!
 I $D(PRCTMP(440,VEN,17.4,"E")) W ?14,$G(PRCTMP(440,VEN,17.4,"E")),!
 I $D(PRCTMP(440,VEN,17.5,"E")) W ?14,$G(PRCTMP(440,VEN,17.5,"E")),!
 I $D(PRCTMP(440,VEN,17.6,"E")) W ?14,$G(PRCTMP(440,VEN,17.6,"E")),!
 I $D(PRCTMP(440,VEN,17.7,"E")) W ?14,$G(PRCTMP(440,VEN,17.7,"E"))
 I $D(PRCTMP(440,VEN,17.8,"I")) D
 .W ", "
 .W $P(^DIC(5,PRCTMP(440,VEN,17.8,"I"),0),U,2)
 .Q
 I $D(PRCTMP(440,VEN,17.9,"E")) W "  ",$G(PRCTMP(440,VEN,17.9,"E")),!!
 I $D(PRCTMP(440,VEN,17,"E")) W !?5,IOINHI,"Payment Contact Person: ",IOINORM,$G(PRCTMP(440,VEN,17,"E"))
 I $D(PRCTMP(440,VEN,17.2,"E")) W !?22,IOINHI,"Phone: ",IOINORM,?14,$G(PRCTMP(440,VEN,17.2,"E")),!
 Q
EDIT ; Prompt to edit
 W ! S DIR(0)="Y",DIR("A")="Edit the payment information on Vendor record",DIR("B")="YES"
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit this edit session."
 S DIR("?",4)="Enter 'YES' or 'Y' or 'RETURN' to continue."
 S DIR("?",1)="If the payment information on the Vendor record is changed,"
 S DIR("?",2)="a Vendor Request will be sent to FMS.",DIR("?",3)=" "
 D ^DIR K DIR W !
 Q
