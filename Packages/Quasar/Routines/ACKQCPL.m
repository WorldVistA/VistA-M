ACKQCPL ;AUG/JLTP BIR/PTD HCIOFO/BH-Lookup for C&P Exams Awaiting Adequation ; 04/22/96 14:16
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
BUILD ;  Build array of exams user can adequate in ^TMP(.
 N ACK5,ACKSTN,ACKDIV,ACKSTAT,ACKDUZ
 S ACKDUZ=$$PROVCHK^ACKQASU4(DUZ) S:ACKDUZ="" ACKDUZ=" "
 S ACKSUPER=$P($G(^ACK(509850.3,ACKDUZ,0)),U,6)
 K ^TMP("ACKQCPL",$J) S (ACKWT,ACKCNT)=0 F  S ACKWT=$O(^ACK(509850.6,"AWAIT",2,ACKWT)) Q:'ACKWT  I ACKSUPER!($D(^ACK(509850.6,"ST",ACKDUZ,ACKWT))) D
 .S ACKZNODE=$G(^ACK(509850.6,ACKWT,0))
 .I $P(ACKZNODE,U,8),$$EN1^DVBCTRN($P(ACKZNODE,U,2),"AUDIO",$P(ACKZNODE,U,8))>0 D
 ..S ACK5=$G(^ACK(509850.6,ACKWT,5))
 ..S ACKCNT=ACKCNT+1,ACKDFN=$G(^DPT(+$P(ACKZNODE,U,2),0))
 ..S Y=+ACKZNODE S:Y["." Y=$P(Y,".",1)
 ..I $D(ACK5) S Y=Y_$P(ACK5,U,8)  ;  Concatenate App. time to Visit Date
 ..X ^DD("DD") S Y=$P(Y,":",1,2),ACKVDT=Y,ACKSP="                                     "
 ..S ACKSSN=$E($P(ACKDFN,U,9),1,3)_"-"_$E($P(ACKDFN,U,9),4,5)_"-"_$E($P(ACKDFN,U,9),6,9)
 ..S ACKVDIV=$P(ACK5,U,1)  ;  Get division code
 ..S ACKSTN=$$GET1^DIQ(40.8,ACKVDIV,1)  ;  Get Division Station Number
 ..S ^TMP("ACKQCPL",$J,ACKCNT,ACKWT)=$E(ACKVDT_ACKSP,1,18)_$P(ACKDFN,U)_$E(ACKSP,$L($P(ACKDFN,U))+1,37)_ACKSSN_"  "_$E(ACKSTN_ACKSP,1,7)
 ;  If no exams
 I '$O(^TMP("ACKQCPL",$J,0)) D  G EXIT
 . W !,$C(7)
 . W "No C&P exams awaiting adequation now." S DIRUT=1
 ;
 ;  If only one exam
 I ACKCNT=1 D  G:$D(DIRUT) EXIT G SET
 . W !,"There is only one C&P exam awaiting adequation.",!! D HEAD(0)
 . W !,^TMP("ACKQCPL",$J,1,$O(^TMP("ACKQCPL",$J,1,0))),!!!
 . ;
 . S ACKVIEN=$O(^TMP("ACKQCPL",$J,1,0))
 . W "Press RETURN to process this exam.",!
 . S ACKNUM=1 S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT)
 . ;  Check this entry is not locked
 . L +^ACK(509850.6,ACKVIEN):2 E  W !!,"This record is locked by another process - Please try again later.",!! S DIRUT=1 Q
 ;
 ;
CHOICE ;  Display list of C&P exams to adequate.
 D HEAD(1)
 S ACKNUM=0 F  S ACKNUM=$O(^TMP("ACKQCPL",$J,ACKNUM)) Q:'ACKNUM!($D(DIRUT))  D
 .I $Y>(IOSL-5) D PAUSE^ACKQUTL Q:$D(DIRUT)  W @IOF D HEAD(1)
 .W !,$J(ACKNUM,3),". ",^TMP("ACKQCPL",$J,ACKNUM,$O(^TMP("ACKQCPL",$J,ACKNUM,0)))
 ;  Select one
 I $D(DIRUT) G EXIT
CHOICE1 S DIR(0)="NA^1:"_ACKCNT,DIR("A")="Select, by number, the exam you wish to adequate: ",DIR("?")="Choose a number from the list of exams"
 W ! D ^DIR K DIR I $D(DIRUT) G EXIT
 S ACKNUM=Y
 ;
SET ;  Set ACKD0, ACKSFT, and DFN before exit and check for locking
 S ACKD0=$O(^TMP("ACKQCPL",$J,ACKNUM,0))
 ;
 ;  Check this entry is not locked
 L +^ACK(509850.6,ACKD0):2 E  W !!,"This record is locked by another process - Please try again later.",!! K ACKD0 G CHOICE1
 ;
 S DFN=+$P(^ACK(509850.6,ACKD0,0),U,2),ACKSFT=$P(^ACK(509850.6,ACKD0,0),U,8)
 ;
EXIT ;  Kill variables and return to calling routine.
 K ACKCNT,ACKDFN,ACKNUM,ACKSP,ACKSSN,ACKSUPER,ACKVDT,ACKWT,ACKZNODE
 K DIR,X,Y,^TMP("ACKQCPL",$J),ACKVIEN
 Q
 ;
HEAD(ACKX) ;  Draws Heading on screen
 W ! W:ACKX "     " W "Visit Date/Time   Name                                 SSN          Stn. #",!
 Q
 ;
 ;
