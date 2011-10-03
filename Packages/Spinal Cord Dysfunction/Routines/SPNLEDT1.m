SPNLEDT1 ;ISC-SF/DAD-CLINICAL REGISTRATION MODULE ;10/25/2001
 ;;2.0;Spinal Cord Dysfunction;**16**;01/02/1997
 ;
EN1 ; *** Edits the clinical registration fields
 S SPNLFLAG=0
 F  D  Q:SPNLFLAG=1
 . K DIC S DIC="^SPNL(154,",DIC(0)="AEMQZ",DIC("A")="Select PATIENT: "
 . W ! D ^DIC S SPNLD0=+Y K DIC I +Y<0 S SPNLFLAG=1 Q
 . L +^SPNL(154,SPNLD0,0):0 I '$T D  Q
 .. W !!?5,"Another user is editing this record."
 .. W !?5,"Please try again later.",$C(7)
 .. Q
 . D EDIT(SPNLD0)
 . L -^SPNL(154,SPNLD0,0)
 . Q
 K DA,DDSFILE,DIC,DIE,DIMSG,DR,SPNLD0,SPNLFLAG,X,Y
 Q
EDIT(SPNLD0) ; *** Edit the Clinical Registration fields
 ;  Input: SPNLD0 = Internal Entry number in SCD Registry file (#154)
 S DDSFILE=154,DR="[SPNLPFM2]",DA=SPNLD0
 S DDSPARM="C" D ^DDS
 K DDSPARM,DDSCHANG,CNT,SPNLTRIG,DR,DIE
 S DIE=154,DR=".05///NOW;.06///`"_DUZ,DA=SPNLD0 D ^DIE
 I $D(DIMSG) W !,"The screen-based entry process has failed!!",!
 Q
