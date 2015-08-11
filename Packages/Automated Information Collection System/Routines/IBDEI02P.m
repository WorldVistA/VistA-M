IBDEI02P ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,804,0)
 ;;=389.22^^8^87^14
 ;;^UTILITY(U,$J,358.3,804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,804,1,3,0)
 ;;=3^389.22
 ;;^UTILITY(U,$J,358.3,804,1,4,0)
 ;;=4^Mixed Hearing Loss,Bilat
 ;;^UTILITY(U,$J,358.3,804,2)
 ;;=^335261
 ;;^UTILITY(U,$J,358.3,805,0)
 ;;=389.13^^8^87^17
 ;;^UTILITY(U,$J,358.3,805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,805,1,3,0)
 ;;=3^389.13
 ;;^UTILITY(U,$J,358.3,805,1,4,0)
 ;;=4^Neural Hearing Loss,Unilat
 ;;^UTILITY(U,$J,358.3,805,2)
 ;;=^335258
 ;;^UTILITY(U,$J,358.3,806,0)
 ;;=993.0^^8^88^1
 ;;^UTILITY(U,$J,358.3,806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,806,1,3,0)
 ;;=3^993.0
 ;;^UTILITY(U,$J,358.3,806,1,4,0)
 ;;=4^Barotrauma, Otitic
 ;;^UTILITY(U,$J,358.3,806,2)
 ;;=^276247
 ;;^UTILITY(U,$J,358.3,807,0)
 ;;=931.^^8^88^3
 ;;^UTILITY(U,$J,358.3,807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,807,1,3,0)
 ;;=3^931.
 ;;^UTILITY(U,$J,358.3,807,1,4,0)
 ;;=4^Foreign Body In Ear
 ;;^UTILITY(U,$J,358.3,807,2)
 ;;=^275490
 ;;^UTILITY(U,$J,358.3,808,0)
 ;;=951.5^^8^88^6
 ;;^UTILITY(U,$J,358.3,808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,808,1,3,0)
 ;;=3^951.5
 ;;^UTILITY(U,$J,358.3,808,1,4,0)
 ;;=4^Injury To Acoustic Nerve
 ;;^UTILITY(U,$J,358.3,808,2)
 ;;=^275901
 ;;^UTILITY(U,$J,358.3,809,0)
 ;;=951.9^^8^88^5
 ;;^UTILITY(U,$J,358.3,809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,809,1,3,0)
 ;;=3^951.9
 ;;^UTILITY(U,$J,358.3,809,1,4,0)
 ;;=4^Injury Cranial Nerve Nos
 ;;^UTILITY(U,$J,358.3,809,2)
 ;;=^275905
 ;;^UTILITY(U,$J,358.3,810,0)
 ;;=300.11^^8^88^2
 ;;^UTILITY(U,$J,358.3,810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,810,1,3,0)
 ;;=3^300.11
 ;;^UTILITY(U,$J,358.3,810,1,4,0)
 ;;=4^Conversion Disorder
 ;;^UTILITY(U,$J,358.3,810,2)
 ;;=^28139
 ;;^UTILITY(U,$J,358.3,811,0)
 ;;=959.09^^8^88^7
 ;;^UTILITY(U,$J,358.3,811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,811,1,3,0)
 ;;=3^959.09
 ;;^UTILITY(U,$J,358.3,811,1,4,0)
 ;;=4^Injury of Face and Neck
 ;;^UTILITY(U,$J,358.3,811,2)
 ;;=^44326
 ;;^UTILITY(U,$J,358.3,812,0)
 ;;=V65.2^^8^88^8
 ;;^UTILITY(U,$J,358.3,812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,812,1,3,0)
 ;;=3^V65.2
 ;;^UTILITY(U,$J,358.3,812,1,4,0)
 ;;=4^Malingerer
 ;;^UTILITY(U,$J,358.3,812,2)
 ;;=^73536
 ;;^UTILITY(U,$J,358.3,813,0)
 ;;=V64.1^^8^88^9
 ;;^UTILITY(U,$J,358.3,813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,813,1,3,0)
 ;;=3^V64.1
 ;;^UTILITY(U,$J,358.3,813,1,4,0)
 ;;=4^No Procedure d/t Contraindication
 ;;^UTILITY(U,$J,358.3,813,2)
 ;;=^295558
 ;;^UTILITY(U,$J,358.3,814,0)
 ;;=V64.2^^8^88^10
 ;;^UTILITY(U,$J,358.3,814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,814,1,3,0)
 ;;=3^V64.2
 ;;^UTILITY(U,$J,358.3,814,1,4,0)
 ;;=4^No Procedure d/t Pt Decision
 ;;^UTILITY(U,$J,358.3,814,2)
 ;;=^295559
 ;;^UTILITY(U,$J,358.3,815,0)
 ;;=V71.89^^8^88^11
 ;;^UTILITY(U,$J,358.3,815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,815,1,3,0)
 ;;=3^V71.89
 ;;^UTILITY(U,$J,358.3,815,1,4,0)
 ;;=4^Observation of Spec Suspec Cond NEC
 ;;^UTILITY(U,$J,358.3,815,2)
 ;;=^322082
 ;;^UTILITY(U,$J,358.3,816,0)
 ;;=306.7^^8^88^12
 ;;^UTILITY(U,$J,358.3,816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,816,1,3,0)
 ;;=3^306.7
 ;;^UTILITY(U,$J,358.3,816,1,4,0)
 ;;=4^Psychogenic Sensory Dis
 ;;^UTILITY(U,$J,358.3,816,2)
 ;;=^268276
 ;;^UTILITY(U,$J,358.3,817,0)
 ;;=379.57^^8^89^6
 ;;^UTILITY(U,$J,358.3,817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,817,1,3,0)
 ;;=3^379.57
 ;;^UTILITY(U,$J,358.3,817,1,4,0)
 ;;=4^Saccadic Eye Movmnt Def
 ;;^UTILITY(U,$J,358.3,817,2)
 ;;=^269327
 ;;^UTILITY(U,$J,358.3,818,0)
 ;;=379.54^^8^89^4
 ;;^UTILITY(U,$J,358.3,818,1,0)
 ;;=^358.31IA^4^2
