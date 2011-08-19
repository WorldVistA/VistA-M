ACKQAS1 ;AUG/JLTP BIR/PTD HCIOFO/BH-New Clinic Visits - CONTINUED ; [ 04/12/96   10:38 AM ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
LAMD(DFN) ;FIND LATEST AUDIOMETRIC DATA FOR A PATIENT
 N ACKC,ACKD0,ACKLAMD,X
 S X=$O(^ACK(509850.6,"AMD",DFN,0)),ACKD0=$O(^ACK(509850.6,"AMD",DFN,+X,0)),ACKLAMD=9999999-X
 I 'X!('$D(^ACK(509850.6,+ACKD0,0))) Q 0
 W !!,$C(7),"Audiometric testing for this patient last completed ",$$NUMDT^ACKQUTL(ACKLAMD),"."
 D PULL2^ACKQCP1 W ! S ACKC=0 F  S ACKC=$O(ACKC(ACKC)) Q:('ACKC)!(ACKC>11)  W !,ACKC(ACKC)
LAMDR S DIR(0)="Y",DIR("A")="Do you wish to use these scores ",DIR("?",1)="If you say YES, I will use these existing audiometric scores and",DIR("?")="you will not be asked to enter audiometric data for the current exam."
 D ^DIR K DIR
 I X?1"^"1.E W !,"Jumping not allowed.",! G LAMDR
 I Y'=1 K Y Q 0
 K Y Q ACKLAMD_U_$G(^ACK(509850.6,ACKD0,4))
 Q
 ;
 ; -----------------------------------------------------------------
 ;
DCXFM ; INPUT TRANSFORM FOR DIAG CODE MODIFIER
 ; These Modifiers are no longer used after the install for QSR V.3.0
 W !,$C(7),"After the installation of QUASAR V.3.0 this field is no longer in use !" K X
 Q
 ;
PCXFM ; INPUT TRANSFORM FOR PROC CODE MODIFIER
 ; These Modifiers are no longer used after the install for QSR V.3.0
 W !,$C(7),"After the installation of QUASAR V.3.0 this field is no longer in use !" K X
 Q
 ;
