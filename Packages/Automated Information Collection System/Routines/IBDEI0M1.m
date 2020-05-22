IBDEI0M1 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9790,1,3,0)
 ;;=3^Clostridium Difficile Enterocolitis,Recurrent
 ;;^UTILITY(U,$J,358.3,9790,1,4,0)
 ;;=4^A04.71
 ;;^UTILITY(U,$J,358.3,9790,2)
 ;;=^5151291
 ;;^UTILITY(U,$J,358.3,9791,0)
 ;;=A04.72^^72^652^29
 ;;^UTILITY(U,$J,358.3,9791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9791,1,3,0)
 ;;=3^Clostridium Difficile Enterocolitis,Not Spec as Recurrent
 ;;^UTILITY(U,$J,358.3,9791,1,4,0)
 ;;=4^A04.72
 ;;^UTILITY(U,$J,358.3,9791,2)
 ;;=^5151292
 ;;^UTILITY(U,$J,358.3,9792,0)
 ;;=T81.44XA^^72^652^14
 ;;^UTILITY(U,$J,358.3,9792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9792,1,3,0)
 ;;=3^Sepsis Following a Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,9792,1,4,0)
 ;;=4^T81.44XA
 ;;^UTILITY(U,$J,358.3,9792,2)
 ;;=^5157596
 ;;^UTILITY(U,$J,358.3,9793,0)
 ;;=T81.41XA^^72^652^40
 ;;^UTILITY(U,$J,358.3,9793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9793,1,3,0)
 ;;=3^Stitch Abscess Following a Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,9793,1,4,0)
 ;;=4^T81.41XA
 ;;^UTILITY(U,$J,358.3,9793,2)
 ;;=^5157587
 ;;^UTILITY(U,$J,358.3,9794,0)
 ;;=T81.42XA^^72^652^41
 ;;^UTILITY(U,$J,358.3,9794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9794,1,3,0)
 ;;=3^Intra-Muscular Abscess Following a Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,9794,1,4,0)
 ;;=4^T81.42XA
 ;;^UTILITY(U,$J,358.3,9794,2)
 ;;=^5157590
 ;;^UTILITY(U,$J,358.3,9795,0)
 ;;=T81.43XA^^72^652^42
 ;;^UTILITY(U,$J,358.3,9795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9795,1,3,0)
 ;;=3^Intra-Abdominal Abscess Following a Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,9795,1,4,0)
 ;;=4^T81.43XA
 ;;^UTILITY(U,$J,358.3,9795,2)
 ;;=^5157593
 ;;^UTILITY(U,$J,358.3,9796,0)
 ;;=M25.50^^72^653^1
 ;;^UTILITY(U,$J,358.3,9796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9796,1,3,0)
 ;;=3^Pain in Joint
 ;;^UTILITY(U,$J,358.3,9796,1,4,0)
 ;;=4^M25.50
 ;;^UTILITY(U,$J,358.3,9796,2)
 ;;=^5011601
 ;;^UTILITY(U,$J,358.3,9797,0)
 ;;=M10.9^^72^653^2
 ;;^UTILITY(U,$J,358.3,9797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9797,1,3,0)
 ;;=3^Gout
 ;;^UTILITY(U,$J,358.3,9797,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,9797,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,9798,0)
 ;;=S09.90XA^^72^653^3
 ;;^UTILITY(U,$J,358.3,9798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9798,1,3,0)
 ;;=3^Head Injury
 ;;^UTILITY(U,$J,358.3,9798,1,4,0)
 ;;=4^S09.90XA
 ;;^UTILITY(U,$J,358.3,9798,2)
 ;;=^5021332
 ;;^UTILITY(U,$J,358.3,9799,0)
 ;;=S02.91XA^^72^653^4
 ;;^UTILITY(U,$J,358.3,9799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9799,1,3,0)
 ;;=3^Skull Fracture
 ;;^UTILITY(U,$J,358.3,9799,1,4,0)
 ;;=4^S02.91XA
 ;;^UTILITY(U,$J,358.3,9799,2)
 ;;=^5020432
 ;;^UTILITY(U,$J,358.3,9800,0)
 ;;=S06.5X0A^^72^653^5
 ;;^UTILITY(U,$J,358.3,9800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9800,1,3,0)
 ;;=3^Traumatic Subdural Hemorrhage w/o LOC
 ;;^UTILITY(U,$J,358.3,9800,1,4,0)
 ;;=4^S06.5X0A
 ;;^UTILITY(U,$J,358.3,9800,2)
 ;;=^5021056
 ;;^UTILITY(U,$J,358.3,9801,0)
 ;;=S06.5X1A^^72^653^6
 ;;^UTILITY(U,$J,358.3,9801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9801,1,3,0)
 ;;=3^Traumatic Subdural Hemorrhage w/ LOC
 ;;^UTILITY(U,$J,358.3,9801,1,4,0)
 ;;=4^S06.5X1A
 ;;^UTILITY(U,$J,358.3,9801,2)
 ;;=^5021059
 ;;^UTILITY(U,$J,358.3,9802,0)
 ;;=S06.6X0A^^72^653^7
 ;;^UTILITY(U,$J,358.3,9802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9802,1,3,0)
 ;;=3^Traumatic Subarachnoid Hemorrhage w/o LOC
