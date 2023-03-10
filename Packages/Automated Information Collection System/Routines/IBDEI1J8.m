IBDEI1J8 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24802,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Deep Vessels Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,24802,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,24802,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,24803,0)
 ;;=I80.203^^85^1091^45
 ;;^UTILITY(U,$J,358.3,24803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24803,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Deep Vessels Bilateral Lower Extremity
 ;;^UTILITY(U,$J,358.3,24803,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,24803,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,24804,0)
 ;;=K27.9^^85^1091^40
 ;;^UTILITY(U,$J,358.3,24804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24804,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,24804,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,24804,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,24805,0)
 ;;=G89.29^^85^1091^10
 ;;^UTILITY(U,$J,358.3,24805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24805,1,3,0)
 ;;=3^Pain,Chronic,Other
 ;;^UTILITY(U,$J,358.3,24805,1,4,0)
 ;;=4^G89.29
 ;;^UTILITY(U,$J,358.3,24805,2)
 ;;=^5004158
 ;;^UTILITY(U,$J,358.3,24806,0)
 ;;=G89.21^^85^1091^9
 ;;^UTILITY(U,$J,358.3,24806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24806,1,3,0)
 ;;=3^Pain,Chronic d/t Trauma
 ;;^UTILITY(U,$J,358.3,24806,1,4,0)
 ;;=4^G89.21
 ;;^UTILITY(U,$J,358.3,24806,2)
 ;;=^5004155
 ;;^UTILITY(U,$J,358.3,24807,0)
 ;;=G89.22^^85^1091^11
 ;;^UTILITY(U,$J,358.3,24807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24807,1,3,0)
 ;;=3^Pain,Chronic,Post-Thoracotomy
 ;;^UTILITY(U,$J,358.3,24807,1,4,0)
 ;;=4^G89.22
 ;;^UTILITY(U,$J,358.3,24807,2)
 ;;=^5004156
 ;;^UTILITY(U,$J,358.3,24808,0)
 ;;=G89.28^^85^1091^8
 ;;^UTILITY(U,$J,358.3,24808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24808,1,3,0)
 ;;=3^Pain,Chronic Postprocedural Pain
 ;;^UTILITY(U,$J,358.3,24808,1,4,0)
 ;;=4^G89.28
 ;;^UTILITY(U,$J,358.3,24808,2)
 ;;=^5004157
 ;;^UTILITY(U,$J,358.3,24809,0)
 ;;=K85.90^^85^1091^38
 ;;^UTILITY(U,$J,358.3,24809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24809,1,3,0)
 ;;=3^Pancreatitis,Acute w/o Necrosis/Infection,Unspec
 ;;^UTILITY(U,$J,358.3,24809,1,4,0)
 ;;=4^K85.90
 ;;^UTILITY(U,$J,358.3,24809,2)
 ;;=^5138761
 ;;^UTILITY(U,$J,358.3,24810,0)
 ;;=K85.91^^85^1091^37
 ;;^UTILITY(U,$J,358.3,24810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24810,1,3,0)
 ;;=3^Pancreatitis,Acute w/ Uninfected Necrosis,Unspec
 ;;^UTILITY(U,$J,358.3,24810,1,4,0)
 ;;=4^K85.91
 ;;^UTILITY(U,$J,358.3,24810,2)
 ;;=^5138762
 ;;^UTILITY(U,$J,358.3,24811,0)
 ;;=K85.92^^85^1091^36
 ;;^UTILITY(U,$J,358.3,24811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24811,1,3,0)
 ;;=3^Pancreatitis,Acute w/ Infected Necrosis,Unspec
 ;;^UTILITY(U,$J,358.3,24811,1,4,0)
 ;;=4^K85.92
 ;;^UTILITY(U,$J,358.3,24811,2)
 ;;=^5138763
 ;;^UTILITY(U,$J,358.3,24812,0)
 ;;=Z98.890^^85^1091^52
 ;;^UTILITY(U,$J,358.3,24812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24812,1,3,0)
 ;;=3^Postprocedural States,Other Specified
 ;;^UTILITY(U,$J,358.3,24812,1,4,0)
 ;;=4^Z98.890
 ;;^UTILITY(U,$J,358.3,24812,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,24813,0)
 ;;=R10.9^^85^1091^4
 ;;^UTILITY(U,$J,358.3,24813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24813,1,3,0)
 ;;=3^Pain,Abdominal,Unspec
 ;;^UTILITY(U,$J,358.3,24813,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,24813,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,24814,0)
 ;;=M79.602^^85^1091^13
 ;;^UTILITY(U,$J,358.3,24814,1,0)
 ;;=^358.31IA^4^2
