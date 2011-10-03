SPNFEDT3 ;HISC/DAD-INPUT/OUTPUT PROCESS FOR SURVEY (ROLL&SCROLL) ;9/25/95  09:04
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
EN1 ;Enter/Edit local registry file (#154) & FIM file (#154.1)
 S (SPNLFLAG,SPNEXIT)=0,SPNFTYPE=1
 F  D  Q:SPNLFLAG=1
 . K DIC
 . S DIC="^SPNL(154,",DIC(0)="AELMQZ",DIC("A")="Select PATIENT: "
 . W !! S DLAYGO=154 D ^DIC S SPNLD0=Y I SPNLD0'>0 S SPNLFLAG=1 Q
 . I $P(SPNLD0,U,3)=1 D  Q:SPNEXIT
 .. K DR S DR=".03///SCD - CURRENTLY SERVED;.04///TRANSMIT"
 .. D EDITREG(+SPNLD0,.DR)
 .. Q
 . K DR S DR=".05///NOW;.06///`"_DUZ
 . D EDITREG(+SPNLD0,.DR) Q:SPNEXIT
 . D ADDEDIT^SPNFEDT4(SPNFTYPE,+$P(SPNLD0,U,2)) Q:SPNEXIT
 . ; *** reg1 ***
 . K DR W !
 . S DR=".03;.04;2.3;4;2.1;5.04;5.05;5.06;5.07;5.08;5.09"
 . S DR(1,154,1)="5.1;S:X'>0 Y=""@3"";2.5;S Y=""@4"";@3;2.5///@;@4;5.11;5.12"
 . S DR(2,154.004)=".01;.02;S:$$GET1^DIQ(154.004,DA_"",""_DA(1)_"","",.02)'[""OTHER"" Y=""@1"";.03;S Y=""@2"";@1;.03///@;@2"
 . D EDITREG(SPNLD0,.DR) Q:SPNEXIT
 . ; *** fim1 ***
 . K DR S SPNEXIT=0
 . S DR="2.08;S:X'>0 Y=""@1"";2.09;S Y=""@2"";@1;2.09///@;@2;2.06;2.07;.16;.17;.13:.15;.05:.12;2.01:2.05"
 . D EDITFIM(SPNFD0,.DR) Q:SPNEXIT
 . ; *** reg2 ***
 . K DR
 . S DR="5.03;5.02"
 . D EDITREG(SPNLD0,.DR) Q:SPNEXIT
 . ; *** fim2 ***
 . K DR
 . S DR="2.1;S:X>4 Y=""@1"";2.11;S Y=""@2"";@1;2.11///@;@2"
 . D EDITFIM(SPNFD0,.DR) Q:SPNEXIT
 . D CHKREC^SPNFEDT4(+SPNLD0,+SPNFD0)
 . D SCORE^SPNFEDT2(+SPNFD0)
 . Q
EXIT ; *** Clean-up & Quit
 K D,DA,DD,DIC,DIE,DINUM,DIR,DIRUT,DLAYGO,DO,DR,DTOUT,DUOUT
 K SPNEXIT,SPNFACTN,SPNFD0,SPNFDFN,SPNFFLAG,SPNFTYPE,SPNLD0,SPNLFLAG
 Q
 ;
EDITREG(SPNLD0,DR) ; *** Edit a record in SCD file (#154)
 ;  SPNLD0 = IEN in SCD file (#154)
 ;  DR     = DR string of fields to edit
 L +^SPNL(154,+SPNLD0,0):0 I '$T D  Q
 . W !!?5,"Another user is editing this record."
 . W !?5,"Please try again later.",$C(7)
 . S SPNEXIT=1
 . Q
 K DA,DIE
 S DIE="^SPNL(154,",DA=+SPNLD0
 D ^DIE S SPNEXIT=($D(Y)>0)
 L -^SPNL(154,SPNLD0,0)
 Q
 ;
EDITFIM(SPNFD0,DR) ; *** Edit a record in the FIM file (#154.1)
 ;  SPNfD0 = IEN in FIM file (#154.1)
 ;  DR     = DR string of fields to edit
 I $P($G(^SPNL(154.1,+SPNFD0,0)),U)'>0 Q
 L +^SPNL(154.1,SPNFD0):0 I '$T D  Q
 . W !!?5,"Another user is editing this record."
 . W !?5,"Please try again later.",$C(7)
 . S SPNEXIT=1
 . Q
 K DA,DIE
 S DIE="^SPNL(154.1,",DA=SPNFD0
 D ^DIE S SPNEXIT=($D(Y)>0)
 L -^SPNL(154.1,SPNFD0)
 Q
