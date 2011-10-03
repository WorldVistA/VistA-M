ACKQFILP ;BIR/PTD-Print A&SP File Entries ; [ 02/16/96   11:28 AM ] 
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
OPTN ;  Introduce option.
 W @IOF,!,"This option can be used to list entries from the CDR ACCOUNT file, the",!,"A&SP PROCEDURE CODE file, or the A&SP DIAGNOSTIC CONDITION file."
FILE ;  Display files user can print from and allow selection.
 W ! K DIR,X,Y S DIR(0)="NAO^1:3"
 S DIR("A",1)="Select number for the file from which you wish to print."
 S DIR("A",2)=""
 S DIR("A",3)="1. CDR ACCOUNT file (#509850)"
 S DIR("A",4)="2. A&SP DIAGNOSTIC CONDITION file (#509850.1)"
 S DIR("A",5)="3. A&SP PROCEDURE CODE file (#509850.4)"
 S DIR("A",6)=""
 S DIR("A")="Enter a number 1 thru 3: "
 S DIR("?")="Select a number from 1 thru 3 or press <Return> to exit."
 S DIR("??")="^D PRINT^ACKQHLP1" D ^DIR K DIR I $D(DIRUT)!(Y="") G EXIT
 S ACKANS=+Y,ACKFNUM=509850_$S(ACKANS=3:".4",ACKANS=2:".1",1:"")
DIP ;  Set up appropriate fields for file.
 S DIC=ACKFNUM,L=0,(FR,TO)="",BY=".01"
 I ACKANS=1 S FLDS=".01,1,4"
 I ACKANS=2 S FLDS=".01,.01:3;""DIAGNOSIS"",.06;C50,1;C12,.01;""MODIFIER"",.02;C17"
 I ACKANS=3 S FLDS=".01,.01:2;""PROCEDURE"",.06;C50,.04;C65,1;C12,.01;""MODIFIER (*Not CPT Modifier*)"",.02;C17,.03;C50"
 W !!,"The right margin for this report is 80.",!,"You can queue it to run at a later time.",!
 D EN1^DIP
 ;
EXIT ;  Kill variables and exit routine.
 K %,ACKANS,ACKFNUM,BY,DIC,FLDS,FR,DIR,DIRUT,DTOUT,DUOUT,L,TO,X,Y
 Q
