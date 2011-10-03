SDRRLRP ;10N20/MAH ; Recall Reminder Manual Printing; 01/22/2008
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
 ;;CHECK TO SEE HOW A SITE HAS BEEN SETUP FOR CLINIC RECALL
 ;;in the OUTPATIENT CLINIC RECALL PARAM FILE
 ;;if set to letters it will run SDRRRECL routine
 ;;if set to cards it will run SDRRRECP routine
STR N DIRUT,TYPE
 W ! S DIR("A")="What Clinic Recall Division will you be printing From ",DIR(0)="P^403.53:AEMQZ" D ^DIR Q:$D(DIRUT)  S IEN=+Y K Y,Q,DIR
 S TYPE=$P($G(^SD(403.53,IEN,0)),"^",2) I TYPE="" S TYPE="C" K IEN
 I TYPE["C" D ^SDRRRECP Q
 I TYPE["L" D ^SDRRRECL Q
 Q
