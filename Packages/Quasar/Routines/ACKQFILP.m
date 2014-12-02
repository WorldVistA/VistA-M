ACKQFILP ;BIR/PTD - Print A&SP File Entries ;30 Jan 2013  3:28 PM
 ;;3.0;QUASAR;**21**;Feb 11, 2000;Build 40
 ; 
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
 I ACKFNUM=509850.1 D  G EXIT
 . W !!,"The right margin for this report is 80.",!,"You can queue it to run at a later time.",!
 . I '$D(ZTQUEUED) D ZIS W !
 . S DIC=ACKFNUM,L=0,(FR,TO)="",BY="[ACKQ DIAG COND ICD-9]"
 . S FLDS="[ACKQ DIAG COND 9]"
 . W @IOF S IOP=IO D EN1^DIP
 . S DIC=ACKFNUM,L=0,(FR,TO)="",BY="[ACKQ DIAG COND ICD-10]"
 . S FLDS="[ACKQ DIAG COND 10]"
 . S IOP=IO D EN1^DIP
 . Q
 S DIC=ACKFNUM,L=0,(FR,TO)="",BY=$S(ACKFNUM=509850.1:"[ACKQ DIAG COND ICD-9]",1:".01")
 I ACKANS=1 S FLDS=".01,1,4"
 ;I ACKANS=2 S FLDS="[ACKQ DIAG COND 9]"
 ;I ACKANS=2 S FLDS=".01,.01:3;""DIAGNOSIS"",.06;C50,1;C12,.01;""MODIFIER"",.02;C17"
 I ACKANS=3 S FLDS=".01,.01:2;""PROCEDURE"",.06;C50,.04;C65,1;C12,.01;""MODIFIER (*Not CPT Modifier*)"",.02;C17,.03;C50"
 W !!,"The right margin for this report is 80.",!,"You can queue it to run at a later time.",!
 D EN1^DIP
 ;
EXIT ;  Kill variables and exit routine.
 K %,ACKANS,ACKFNUM,BY,DIC,FLDS,FR,DIR,DIRUT,DTOUT,DUOUT,L,TO,X,Y
 Q
ZIS W ! K IOP,IO("Q") S POP=0,%ZIS="QMP"
 D ^%ZIS K %ZIS,IOP Q:POP
 I $D(IO("Q")) S ZTDESC="A&SP DIAGNOSIS",ZTRTN="DIP^ACKQFILP",ZTSAVE("ACK*")="" S POP=1 G CLOSE
CLOSE Q:$D(ZTQUEUED)  N POP D ^%ZISC
 K ZTDESC,ZTRTN,ZTSAVE,ZTQUEUED,POP
