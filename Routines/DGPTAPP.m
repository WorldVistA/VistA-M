DGPTAPP ;MTC/ALB - PTF Purge Utilities; 10-14-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
PUR ;-- entry point from protocol 'DGPT A/P PURGE'
 N DGTMP
 ;
 ;-- get template to purge
 D SEL^VALM2 I '$D(VALMY) G PURQ
 S DGTMP=$O(^TMP("ARCPTF",$J,"AP LIST","REC",+$O(VALMY(0)),0))
 ;--if data has not been archived quit
 I '$P($G(^DGP(45.62,+DGTMP,0)),U,4) W !,*7,">>> Data Must be Archived before Purge..." H 2 G PURQ
 ;--if data has been already purged quit
 I $P($G(^DGP(45.62,+DGTMP,0)),U,7) W !,*7,">>> Data Already Purged..." H 2 G PURQ
 ;
 ;-- perfrom purge
 I $$WARNING D
 . D PURGE^DGPTAPP1(DGTMP)
 . ;-- update history file
 . D ADDPUR(DGTMP)
 ;
PURQ Q
 ;
PUREX ;-- exit point from protocol 'DGPT A/P PURGE'
 D TMPINT^DGPTLMU2
 S VALMBCK="R"
 Q
 ;
ADDPUR(TEMP) ;-- This function will add PURGE date, user and status
 ;
 ;   INPUT : TEMP - IFN of the History File to update
 ;
 I '$D(^DGP(45.62,TEMP,0)) G ADDPURQ
 W !,">>> Adding Purge data to PTF Archive/Purge History entry."
 W !,"    Deleting Archive Data..." H 2
 S DA=TEMP,DIE="^DGP(45.62,",DR=".05////^S X=DUZ;.06///NOW;.07///1;100///@"
 D ^DIE
 K DIE,DR,DA
ADDPURQ Q
 ;
WARNING() ; This function will display a warning to the user before the
 ; purge of the data will occur. A '1' will be returned if the purge
 ; should continue.
 ;  OUTPUT : 1 - DO NOT CONTINUE
 ;           0 - OK
 W !,*7,"This option will permanently purge data from the Data Base."
 S DIR(0)="Y",DIR("A")="Are you sure that you want to continue ",DIR("B")="NO" D ^DIR K DIR
 Q $S(Y:1,1:0)
 ;
