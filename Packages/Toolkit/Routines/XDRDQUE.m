XDRDQUE ;SF-IRMFO/IHS/OHPRD/JCM - START AND STOP DUPLICATE CHECKER SEARCH ;8/28/08  18:23
 ;;7.3;TOOLKIT;**23,47,113**;Apr 25, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
START ;
 S XDRQFLG=0
 ;*** following commented line to be removed from Toolkit ver after 7.3
 ;S XDRDQUE("TASKMAN STATUS")=$P(@$Q(^%ZTSCH("STATUS","")),U,2) I XDRDQUE("TASKMAN STATUS")'="RUN" W !!,"Taskman does not seem to be running properly, Please notify your site manager.",!! G END
 S XDRDQUE("TASKMAN STATUS")=$$TM^%ZTLOAD
 I 'XDRDQUE("TASKMAN STATUS") W !!,"Taskman does not seem to be running properly, Please notify your site manager.",!! G END
 ; XT*7.3*113, variable XDRNOPT=1 makes option unavailable for the PATIENT file
 N XDRNOPT S XDRNOPT=1
 D FILE G:XDRQFLG END ; Asks user which file to check for dups
 D CHECK^XDRU1 G:XDRQFLG END ; Checks the Duplicate Resolution file
 D ASK G:XDRQFLG END ; Asks user what action and type of search
 D QUEUE G:XDRQFLG END ; Queues search
 I XDRDNSTA="r" D ASK3 D:'XDRQFLG QUEUE
END D EOJ ; Clean up variables
 Q
 ;
FILE ; EP - Called by XDRDCOMP,XDRDLIST,XDRDSCOR,XDRMADD,XDRCNT
 K DIC("B")
 K X S:$D(XDRFL) X=XDRFL
 S DIC(0)=$S($D(X):"Z",1:"QEAZ")
 S:'$D(DIC("A")) DIC("A")="Select file to be checked for duplicates: "
 ; If XDRNOPT=1, don't allow selection of PATIENT file.(new with XT*7.3*113)
 I $G(XDRNOPT)=1 D
 . S DIC("S")="I Y'=2"
 . W:'$D(ZTQUEUED) !,"* This option is not available for PATIENTS"
 . Q
 S DIC="^VA(15.1," D ^DIC K DIC,X
 I Y=-1 S XDRQFLG=1 G FILEX
 S XDRD(0)=Y(0),XDRD(0,0)=Y(0,0),XDRFL=$P(Y(0),U),PRIFILE=XDRFL K Y
 W:'$D(ZTQUEUED) !!
FILEX Q
 ;
ASK ;
 D DISP
 D ASK1 G:XDRQFLG ASKX
 I XDRDSTA="c"&($D(^VA(15.1,XDRFL,"APDTI"))) S XDRDPDTI="" W !!,"Since the Potential Duplicate Threshold has been raised",!,"I will only go through the Potential Duplicates and see if they",!,"meet the new threshold." G ASKX
 D:XDRDSTA="c"&('XDRQFLG) ASK2
ASKX ;
 Q
DISP ;
 D DISP^XDRDSTAT
 S XDRDSTA=$P(XDRD(0),U,2)
 S XDRDTYPE=$P(XDRD(0),U,5)
 Q
ASK1 ;
 S:XDRDSTA']"" XDRDSTA="c"
 S DIR(0)="Y",DIR("A")="Do You wish to "_$S(XDRDSTA="h":"CONTINUE",XDRDSTA="e":"CONTINUE",XDRDSTA="r":"HALT",1:"RUN")_" "_$S(XDRDSTA="r":"this",XDRDSTA="h":"this",XDRDSTA="e":"this",1:"a")_" search (Y/N)"
 D ^DIR K DIR D OUT
 I 'XDRQFLG,'Y,$S(XDRDSTA="r":0,XDRDSTA="c":0,1:1) D  S Y=0
 . S DIR(0)="Y",DIR("A")="Do you wish to mark this run COMPLETED (Y/N)",DIR("B")="NO" D ^DIR K DIR D OUT
 . I Y,'XDRQFLG S DIE="^VA(15.1,",DA=XDRFL,DR=".02////c" D ^DIE K DA,DIE,DR
 S:'Y XDRQFLG=1
 K XDRDNSTA
 S:'XDRQFLG XDRDNSTA=$S(XDRDSTA="h":"r",XDRDSTA="r":"h",1:"r")
 Q
ASK2 ;
 K XDRDTYPE
 S DIR(0)="15.1,.05A",DIR("A")="Which type of Search do you wish to run ? (BASIC/NEW) "
 S DIR("B")="BASIC",DIR("?")="A 'BASIC' search starts at the beginning of the file.  A 'NEW' search uses a cross-reference you specify to determine which entries to test."
 D ^DIR K DIR D OUT
 S XDRDTYPE=$S(Y="b":"BASIC",1:"NEW")
 I XDRDTYPE="BASIC" D
 . N DIR S DIR(0)="Y"
 . S DIR("A",1)="This process will take a **LONG** time (known to exceed 100  hours),"
 . S DIR("A",2)="but you CAN stop and restart the process when you want using"
 . S DIR("A")="the options  OK"
 . D ^DIR S:Y'>0 XDRQFLG=1
 . Q
 Q
 ;
ASK3 ;
 W !
 S DIR(0)="Y",DIR("A")="Do You wish to schedule a time to HALT this search (Y/N)"
 D ^DIR K DIR D OUT
 S:'Y XDRQFLG=1
 G:XDRQFLG ASK3X
 S XDRDNSTA="h"
ASK3X Q
 ;
QUEUE ;
 S ZTRTN="XDRDMAIN",ZTIO="",ZTDESC="Duplicate "_XDRD(0,0)_" Search"
 S:XDRDNSTA="h" ZTDESC="Halt "_ZTDESC
 S ZTSAVE("XDRFL")="" S:$D(XDRDPDTI) ZTSAVE("XDRDPDTI")=""
 S ZTSAVE("XDRDTYPE")="",ZTSAVE("XDRDNSTA")=""
 D ^%ZTLOAD
 S:'$D(ZTQUEUED) XDRQFLG=1
 K ZTSK
QUEUEX Q
 ;
OUT ;
 ; Common point to take care of DIR,DIC, and DIE calls
 I ($D(DTOUT))!($D(DUOUT))!($D(DIRUT)) K DTOUT,DUOUT,DIRUT S XDRQFLG=1
 Q
EOJ ;
 K X,Y,XDRFL,XDRDNSTA,XDRDSTA,XDRQFLG,XDRD,XDRDPDTI,XDRDQUE
 Q
