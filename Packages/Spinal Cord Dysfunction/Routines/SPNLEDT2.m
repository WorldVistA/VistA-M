SPNLEDT2 ;HISC/JWR-Edits only non-clinical registration fields;10/25/2001
 ;;2.0;Spinal Cord Dysfunction;**16**;01/02/1997
EN1 S SPNLFLAG=0
 F  D  Q:SPNLFLAG=1
 . K DIC S DIC="^SPNL(154,",DIC(0)="AELMQZ",DIC("A")="Select PATIENT: "
 . W ! S DLAYGO=154 D ^DIC S SPNLD0=+Y K DIC I +Y<0 S SPNLFLAG=1 Q
 . I $P(Y,U,3)=1 D
 .. K DA,DIE,DR
 .. S DIE="^SPNL(154,",DA=+SPNLD0
 .. S DR=".03///SCD - CURRENTLY SERVED"
 .. S DR=DR_";.05///NOW;.06///`"_DUZ
 .. D ^DIE
 .. Q
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
 S DR="[SPNLPFM3]",DDSFILE=154,DA=SPNLD0
 S DDSPARM="C" D ^DDS
 K DDSPARM,DDSCHANG,SPNLTRIG,DR,DIE
 S DIE=154,DR=".05///NOW;.06///`"_DUZ,DA=SPNLD0 D ^DIE
 I $D(DIMSG) W !,"The screen-based entry process has failed!!",!
 K DR,DIE,DR Q
