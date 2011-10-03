MCARENV1 ;WISC/MLH-MEDICINE PACKAGE INSTALLATION-ENVIRONMENT CHECK ROUTINE #2 ;5/2/96  10:26
 ;;2.3;Medicine;;09/13/1996
 ;
 ;    define bells & whistles
 N MCSCATT
 I $G(IOST)?1"C-VT".E F I=0:1:7 S MCSCATT(I)=$C(27,91)_I_"m"
 E  F I=0:1:7 S MCSCATT(I)=""
 ;
 ;    clean up some files before we start
 S OKTOGO=$$NOTIFY
 I OKTOGO S OKTOGO=$$NOTIFY1
 ;    abort the init if user has requested a bailout
 IF 'OKTOGO D
 .  W !!,"OK, stopping the installation here..nothing changed!"
 .  K DIFQ
 .  Q
 ;END IF
 ;
 QUIT
 ;
NOTIFY(X) ;    alert user to cleanup, allow them to bail out
 W @IOF,"*********************************************************"
 W !,"*                                                       *"
 W !,"*     "
 W *7,MCSCATT(5),MCSCATT(7),"C A U T I O N !",MCSCATT(0),*7
 W "                                   *",*7
 W !,"*                                                       *"
 W !,"*     This pre-initialization routine will "
 W MCSCATT(4),"delete",MCSCATT(0)," the   *"
 W !,"*     ",MCSCATT(1),"DATA DICTIONARIES",MCSCATT(0)
 W " (but ",MCSCATT(4),"retain",MCSCATT(0)," the data) for the   *"
 W !,"*     following files:                                  *"
 W !,"*                                                       *"
 W !,"*         690   (MEDICAL PATIENT)                       *"
 W !,"*         691.1 (CARDIAC CATHETERIZATION)               *"
 W !,"*         697   (ANATOMY)                               *"
 W !,"*         697.5 (MEDICAL DIAGNOSIS/ICD CODES)           *"
 W !,"*         699.6 (DIAG/THERAP INTERVENT)                 *"
 W !,"*                                                       *"
 W !,"*     You "
 W MCSCATT(1),"MUST",MCSCATT(0)," save any local modifications to the      *"
 W !,"*     data dictionaries for these files before          *"
 W !,"*     proceeding with this routine.                     *"
 W !,"*     (See the Installation Guide for instructions.)    *"
 W !,"*     Any changes not saved will be "
 W MCSCATT(1),"LOST!",MCSCATT(0),"               *"
 W !,"*                                                       *"
 W !,"*********************************************************",!
 S DIR(0)="E",DIR("A")="Press ""^"" to abort the installation here, or RETURN to continue"
 D ^DIR
 Q Y
 ;
NOTIFY1(X) ;    alert user to cleanup -- part 2
 W @IOF,"*********************************************************"
 W !,"*                                                       *"
 W !,"*     "
 W *7,MCSCATT(5),MCSCATT(7),"C A U T I O N !",MCSCATT(0),*7
 W "                                   *",*7
 W !,"*                                                       *"
 W !,"*     This pre-initialization routine will "
 W MCSCATT(4),"delete",MCSCATT(0)," the   *"
 W !,"*     ",MCSCATT(1),"DATA DICTIONARIES ",MCSCATT(0)
 W MCSCATT(4),"and",MCSCATT(0),MCSCATT(1)," DATA",MCSCATT(0)
 W " for the following      *"
 W !,"*     file:                                             *"
 W !,"*                                                       *"
 W !,"*         697.3 (MEDICINE SCREEN)                       *"
 W !,"*                                                       *"
 W !,"*     You "
 W MCSCATT(1),"MUST",MCSCATT(0)," save any local modifications to the      *"
 W !,"*     data dictionaries and data for this file          *"
 W !,"*     before proceeding with this routine.              *"
 W !,"*     (See the Installation Guide for instructions.)    *"
 W !,"*     Any changes not saved will be "
 W MCSCATT(1),"LOST!",MCSCATT(0),"               *"
 W !,"*                                                       *"
 W !,"*********************************************************",!
 S DIR(0)="E",DIR("A")="Press ""^"" to abort the installation here, or RETURN to continue"
 D ^DIR
 Q Y
