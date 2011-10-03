SOWKHIRM ;B'HAM ISC/SAB-ROUTINE TO EDIT/START HIGH RISK PROFILES ; 15 Jun 93 / 10:16 AM [ 04/02/96  8:58 AM ]
 ;;3.0; Social Work ;**1,42**;27 Apr 93
BEG S DIR(0)="YO",DIR("A")="Do you want to screen Now (One to seven days)",DIR("B")="YES",DIR("?")="Enter 'YES' to run current date or up to seven days in the past." D ^DIR
 I X=""!Y=1 D ^SOWKHRM
CLO K DIR,DIRUT,DUOUT,DTOUT,X,Y
 Q
HOMELESS(DFN)      ;homeless API
 N X,FLAG
 S (FLAG,X)=0 F  S X=$O(^SOWK(650,"P",DFN,X)) Q:'X!(FLAG=1)  I $P(^SOWK(650,X,0),U,14)=4 S FLAG=1
 Q FLAG
