ACKQFIL ;BIR/PTD-Update A&SP Files per CO Directive ; [ 08/23/95   3:02 PM ] 
 ;;3.0;QUASAR;**1**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
ACCESS ; Only A&SP staff designated as supervisors can access this option.
 N ACKDUZ
 S ACKDUZ=$$PROVCHK^ACKQASU4(DUZ) S:ACKDUZ="" ACKDUZ=" "
 W @IOF I $O(^ACK(509850.3,ACKDUZ,""))="" W !,"You are not listed in the A&SP STAFF file (#509850.3).",!,"Access denied." G EXIT
 S X=$$STACT^ACKQUTL(ACKDUZ) I ((X=-2)!(X=-6)) W !,"Only clinicians may access this option!" G EXIT
 I X W !,"The A&SP STAFF file (#509850.3) indicates that you have been inactivated.",!,"Access denied." G EXIT
 I $P(^ACK(509850.3,ACKDUZ,0),"^",6)'=1 W !,"You must be listed as a SUPERVISOR in the A&SP STAFF file (#509850.3)",!,"in order to use this option.  Access denied." G EXIT
OPTN ;  Introduce option.
 W !,"This option can be used to update the CDR ACCOUNT file, the",!,"A&SP PROCEDURE CODE file, or the A&SP DIAGNOSTIC CONDITION file.",!
WARN ;  This option should be used only with CO directive.
 W !!?20,"********** WARNING **********"
 W !!?5,"This option is to be used ONLY with direction from the",!?5,"Director, Audiology and Speech Pathology Service (VAHQ).",!!?20,"*****************************",!!
SURE ;  Give user opportunity to exit if unsure.
 S DIR(0)="Y",DIR("A")="Are you sure you should continue",DIR("B")="NO",DIR("?")="Enter YES to continue; enter NO or press return to exit."
 S DIR("??")="^D SURE^ACKQHLP1" D ^DIR K DIR I $D(DIRUT)!(Y=0) G EXIT
FILE ;  Display files user can update and allow selection.
 W @IOF K DIR,X,Y S DIR(0)="NAO^1:3"
 S DIR("A",1)="Select the action you wish to take."
 S DIR("A",2)=""
 S DIR("A",3)="1. Update the CDR ACCOUNT file (#509850)."
 S DIR("A",4)="2. Update the A&SP DIAGNOSTIC CONDITION file (#509850.1)."
 S DIR("A",5)="3. Update the A&SP PROCEDURE CODE file (#509850.4)."
 ;
 S DIR("A")="Enter a number 1 thru 3: "
 S DIR("?")="Select a number from 1 thru 3 or press <Return> to exit"
 S DIR("??")="^D FILE^ACKQHLP1" D ^DIR K DIR I $D(DIRUT)!(Y="") G EXIT
 S ACKANS=+Y,ACKFNUM=509850_$S(ACKANS=3:".4",ACKANS=2:".1",1:"")
 S ACKFNAM=$S(ACKANS=3:"A&SP PROCEDURE CODE",ACKANS=2:"A&SP DIAGNOSTIC CONDITION",1:"CDR ACCOUNT")
ACTION ;  Display actions user can take on selected file.
 W @IOF K ACKANS,DIR,X,Y S DIR(0)="NAO^1:2",DIR("A",1)="What do you want to do with the "_ACKFNAM_" file (#"_ACKFNUM_")?",DIR("A",2)="",DIR("A",3)="1. Inactivate selected entries.",DIR("A",4)="2. Add new file entries.",DIR("A",5)=""
 S DIR("A")="Enter a number, 1 or 2: ",DIR("?")="Answer 1 to make an entry inactive; answer 2 to add a new entry"
 S DIR("??")="^D ACTION^ACKQHLP1" D ^DIR K DIR G:$D(DIRUT) EXIT
 S ACKANS=+Y W @IOF,!! D CNTR^ACKQUTL(ACKFNAM_" file (#"_ACKFNUM_")") W ! I ACKANS=2 K ACKANS,DIR,X,Y G ^ACKQFIL1
INACT ;User wants to inactivate selected entries.
 S DIC="^ACK("_ACKFNUM_",",DIC(0)="QEAM",DIC("A")="Select entry to inactivate: " D ^DIC K DIC I Y<0 D EXIT G FILE
 S ACKIEN=+Y
 I ACKFNUM="509850.4" D LONG^ACKQUTL6(ACKIEN,"1")
 S ACKPC=$S(ACKFNUM="509850.4":4,ACKFNUM="509850.1":6,1:5),ACKZNODE=^ACK(ACKFNUM,ACKIEN,0),ACKACT=$P(ACKZNODE,"^",ACKPC)
 I ACKACT=1 S $P(^ACK(ACKFNUM,ACKIEN,0),"^",ACKPC)=0 W !,"This entry has been inactivated.",! D KVAR G INACT
CHANGE ;Else entry is already marked as INACTIVE.
 W ! K DIR,X,Y S DIR(0)="Y",DIR("A",1)="This entry is already marked as INACTIVE.",DIR("A")="Do you want to make it ACTIVE",DIR("B")="NO",DIR("?")="Answer YES to make the entry ACTIVE; enter NO to make no change."
 S DIR("??")="^D CHANGE^ACKQHLP1" D ^DIR K DIR I $D(DIRUT)!(Y=0) W !,"No change made.  This entry is still inactive.",! D KVAR G INACT
 ;User wants to change the INACTIVE entry ACTIVE.
 S $P(^ACK(ACKFNUM,ACKIEN,0),"^",ACKPC)=1 W !,"This entry has been changed to active.",! D KVAR G INACT
 ;
EXIT ;Kill variables and exit routine.
 I $D(ACKIEN) L -^ACK(ACKFNUM,ACKIEN)
 K %,ACKACT,ACKANS,ACKCOMP,ACKFNAM,ACKFNUM,ACKHRLOS,ACKIEN,ACKLAYGO,ACKMOD,ACKNEW,ACKORIG,ACKPC,ACKSUB,ACKZNODE,DA,DIC,DIE,DIK,DIR,DIRUT,DLAYGO,DR,DTOUT,DUOUT,PC,X,Y
 Q
 ;
KVAR ;Kill selected variables.
 K ACKACT,ACKPC,ACKZNODE,DIC,DIR,X,Y
 Q
