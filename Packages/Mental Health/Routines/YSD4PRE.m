YSD4PRE ;DALISC/LJA - Mental Health 5.01 Pre-init ;[ 04/10/94  10:39 AM ]
 ;;5.01;MENTAL HEALTH;**6**;Dec 30, 1994
 ;
CTRL ;  Master control module
 D END ;                     Clean up variables
 D STARTMSG
 D CKALL I 'YSD4OK D  QUIT  ;->
 .  K DIFQ
 .  D END
 D CLNUP ;                    Conditional MH PN message
 D PCKGE ;                    Tell user about 'MH System' package file entry
 D OUT^YSD4PRE0 ;             Place DSM options out of order
 D PCKCHG^YSD4PRE0 ;          Check/Reset MH Package file entries
 D DELMHPN^YSD4PRE0 ;         Delete MH PN files
 D ICD^YSD4PRE0 ;             Conditional ICD9 message
 D GMRDEL ;                   Delete 'DD' of File 121 field 30 - DXLS
 D END ;                      Clean up variables
 QUIT
 ;
STARTMSG ;
 W !!,"Starting the Mental Health 5.01 pre-init now...",!!
 H 2
 QUIT
 ;
CKALL ;  Check all possibilities why this process should not continue.
 ;  Tell users ALL reasons every time invoked...
 ;
 ;  Set necessary variables...
 S YSD4OK=1 ;    Assume all OK...
 K YSD4REA ;     Clean area holding reasons for process stoppage
 S YSD4NREA=0 ;  Number of reasons for process stoppage
 ;
 ;  Now, call the various checks...
 D DUZCK,VA200,PIMS,GMR
 I 'YSD4OK D  QUIT  ;->
 .  K DIFQ
 .  W !!,"The installation of Mental Health 5.01 cannot continue for the following"
 .  W !,"reason(s)",$S(YSD4NREA>1:"s",1:""),":"
 .  F YSD4I=1:1:YSD4NREA W !,YSD4REA(+YSD4I)
 QUIT
 ;
DUZCK ;  DUZ, DUZ(2) check...
 I $S('($D(DUZ)#2):1,'($D(DUZ(0))#2):1,'DUZ:1,1:0) D  QUIT  ;->
 .  S YSD4OK=0
 .  S YSD4NREA=YSD4NREA+1
 .  S YSD4REA(+YSD4NREA)="  "_YSD4NREA_".  DUZ and DUZ(0) must be defined."
 ;
 I DUZ(0)'="@" D  QUIT  ;->
 .  S YSD4NREA=YSD4NREA+1
 .  S YSD4REA(+YSD4NREA)="  "_YSD4NREA_".  Programmer access code must be set."
 QUIT
 ;
VA200 ;  New Person file check...
 I '($D(^VA(200,0))#2) D  QUIT  ;->
 .  S YSD4OK=0
 .  S YSD4NREA=YSD4NREA+1
 .  S YSD4REA(+YSD4NREA)="  "_YSD4NREA_".  NEW PERSON file not installed."
 QUIT
 ;
PIMS ;  PIMS version check...
 I $S('$D(^DD(2,0,"VR")):1,^DD(2,0,"VR")<5.1:1,1:0) D  QUIT  ;->
 .  S YSD4OK=0
 .  S YSD4NREA=YSD4NREA+1
 .  S YSD4REA(+YSD4NREA)="  "_YSD4NREA_".  PIMS 5.1 or higher required."
 QUIT
 ;
GMR ;  Gen Prog Notes check...
 I $S('$D(^DD(121,0,"VR")):1,^DD(121,0,"VR")<2.2:1,1:0) D  QUIT  ;->
 .  S YSD4OK=0
 .  S YSD4NREA=YSD4NREA+1
 .  S YSD4REA(+YSD4NREA)="  "_YSD4NREA_".  Generic Progress Notes 2.5 required."
 QUIT
 ;
CLNUP I $D(^YSP(606))!($P(^GMR(121.99,1,"CONV"),U,3)'=1) D
 .  W !!!,?10,"*** MENTAL HEALTH - PROGRESS NOTE CLEAN-UP ***",!!
 .  W !,?5,"As part of the Pre-Init process the old Mental Health"
 .  W !,?5,"Progress Note functionality will be removed.  The following"
 .  W !,?5,"will be purged at this time: ",!
 .  W !,?9,"1. Data and Data Dictionaries for File #606"
 .  W !,?9,"2. Data and Data Dictionaries for File #606.5"
 .  W !,?9,"3. All YSPN* options in the OPTION file #19"
 .  W !!,?5,"Please reference the Progress Notes Package 'Installation"
 .  W !,?5,"Guide' for instructions as to how to remove the Mental Health"
 .  W !,?5,"Progress Note routines.  Make sure you have followed the"
 .  W !,?5,"Clean-Up instructions and have a backup of your Mental"
 .  W !,?5,"Health package before continuing this INIT process!!",!!
 .  D ASK
 QUIT
 ;
ASK ; Are you sure you want to continue ... ?
 K DIR S DIR(0)="Y",DIR("A")="Are you ready to continue the Pre-Init "
 S DIR("?",1)="Enter YES if you are ready to do the clean-up;"
 S DIR("?")="Enter NO to exit this Pre-Init."
 D ^DIR
 K DIR I $D(DIRUT)!(Y=0) K DIFQ G END
 QUIT
 ;
PCKGE ;
 ;  Rename 'Mental Health System' package file entry, if exists...
 W !!,"If your package file contains an entry named 'Mental Health System' "
 W !,"it will be renamed 'Mental Health' ...",!!
 QUIT
 ;
GMRDEL ;
 N DA,DIK
 S DIK="^DD(121,",DA=30,DA(1)=121
 D ^DIK
 QUIT
 ;
END ;
 K ^DIC(627,310.1)
 ; YS*5.01*6 - above line was added to delete this entry
 K %,DA,DIE,DIK,DIR,DIU,DR,X,Y
 K YSD451,YSD4COM,YSD4I,YSD4NREA,YSD4OK,YSD4REA,YSOPTION,YSPNOPT
 QUIT
 ;
EOR ;YSD4PRE - Mental Health 5.01 Pre-init ; 4/10/94 9:20
