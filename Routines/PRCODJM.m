PRCODJM ;WISC/DJM/BGJ-IFCAP TESTING READER CODE ; 7/22/99 2:19pm
V ;;5.1;IFCAP;**48**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; THIS ROUTINE IS CALLED FROM THE OPTION 'PRCO EDI REPORTS'
 ; AT THE 'ENTRY ACTION'.  THE CODE IN THIS ROUTINE WAS ATTEMPTED
 ; TO BE PLACED IN THE ROUTINE 'PRCOER' BUT WHEN 'HELP1' (?? HELP)
 ; WAS SELECTED AND EXITED THE QUESTION/S IN THIS ROUTINE WERE ASKED
 ; AGAIN.  PUTTING THE QUESTION/S HERE ELIMINATED THE PROBLEM.
 ;
BEGIN ; FIND OUT STATUS OF USER.
 K PRCOFLG
 N DIC,DIR
 S USER=$P($G(^VA(200,DUZ,400)),U)
 S SENDER=0
 S PRCOFLG=""
 I USER'>0 S PRCOFLG=-1 D EN^DDIOL("You are not an A&MM EMPLOYEE, exiting option.","","!!?10") G EXIT
 ;
 ; FIND OUT IF USER WANTS TO SEE EVERYTHING.
 ;
 S DIR("A")="Do you want to see all the records now"
 S DIR("B")="Yes"
 S DIR(0)="Y"
 S DIR("?",1)="Answering Yes or Y to this question will let you"
 S DIR("?",2)="see information about all the PHA, RFQ and TXT"
 S DIR("?",3)="transactions from all SENDERs."
 S DIR("?",4)=""
 S DIR("?",5)="Answering No or N will limit you to viewing the"
 S DIR("?",6)="PHA, RFQ and TXT transactions from one SENDER."
 S DIR("?",7)=""
 S DIR("?")="Enter '^' to exit this option."
 D ^DIR
 I Y["^" S PRCOFLG=-1 D EN^DDIOL("Exiting option.","","!!?10") G EXIT
 ;
 ; Y=1 is YES, I want to see all the entries.
 ;
 I Y=1 G EXIT
 ;
SENDER ; COME HERE TO SELECT ONE PERSON THAT ENTERED RECORDS IN FILE 443.75.
 D EN^DDIOL("","","!")
 K DTOUT
 K DUOUT
 K Y
 I $O(^PRC(443.75,"C",DUZ,0))>0 D
 .  S DIC("B")=$P($G(^VA(200,DUZ,0)),U)
 .  Q
 S DIC="^PRC(443.75,"
 S DIC(0)="AEQ"
 S D="C"
 D IX^DIC
 I Y=-1!($D(DTOUT))!($D(DUOUT)) S PRCOFLG=-1 G EXIT
 S:$P(Y,U)>0 SENDER=$P(^PRC(443.75,$P(Y,U),0),U,11)
 ;
EXIT ; LETS QUIT
 I $G(PRCOFLG)'=-1 D
 .  D EN^DDIOL("","","!!")
 .  D WAIT^DICD
 .  Q
 Q
