IBDEI1PM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29042,1,4,0)
 ;;=4^O35.4XX3
 ;;^UTILITY(U,$J,358.3,29042,2)
 ;;=^5016806
 ;;^UTILITY(U,$J,358.3,29043,0)
 ;;=O35.4XX4^^115^1455^90
 ;;^UTILITY(U,$J,358.3,29043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29043,1,3,0)
 ;;=3^Maternal care for damage to fetus from alcohol, fetus 4
 ;;^UTILITY(U,$J,358.3,29043,1,4,0)
 ;;=4^O35.4XX4
 ;;^UTILITY(U,$J,358.3,29043,2)
 ;;=^5016807
 ;;^UTILITY(U,$J,358.3,29044,0)
 ;;=O35.4XX5^^115^1455^91
 ;;^UTILITY(U,$J,358.3,29044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29044,1,3,0)
 ;;=3^Maternal care for damage to fetus from alcohol, fetus 5
 ;;^UTILITY(U,$J,358.3,29044,1,4,0)
 ;;=4^O35.4XX5
 ;;^UTILITY(U,$J,358.3,29044,2)
 ;;=^5016808
 ;;^UTILITY(U,$J,358.3,29045,0)
 ;;=O35.8XX0^^115^1455^140
 ;;^UTILITY(U,$J,358.3,29045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29045,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, unsp
 ;;^UTILITY(U,$J,358.3,29045,1,4,0)
 ;;=4^O35.8XX0
 ;;^UTILITY(U,$J,358.3,29045,2)
 ;;=^5016830
 ;;^UTILITY(U,$J,358.3,29046,0)
 ;;=O35.8XX1^^115^1455^141
 ;;^UTILITY(U,$J,358.3,29046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29046,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 1
 ;;^UTILITY(U,$J,358.3,29046,1,4,0)
 ;;=4^O35.8XX1
 ;;^UTILITY(U,$J,358.3,29046,2)
 ;;=^5016831
 ;;^UTILITY(U,$J,358.3,29047,0)
 ;;=O35.8XX2^^115^1455^142
 ;;^UTILITY(U,$J,358.3,29047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29047,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 2
 ;;^UTILITY(U,$J,358.3,29047,1,4,0)
 ;;=4^O35.8XX2
 ;;^UTILITY(U,$J,358.3,29047,2)
 ;;=^5016832
 ;;^UTILITY(U,$J,358.3,29048,0)
 ;;=O35.8XX3^^115^1455^143
 ;;^UTILITY(U,$J,358.3,29048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29048,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 3
 ;;^UTILITY(U,$J,358.3,29048,1,4,0)
 ;;=4^O35.8XX3
 ;;^UTILITY(U,$J,358.3,29048,2)
 ;;=^5016833
 ;;^UTILITY(U,$J,358.3,29049,0)
 ;;=O35.8XX4^^115^1455^144
 ;;^UTILITY(U,$J,358.3,29049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29049,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 4
 ;;^UTILITY(U,$J,358.3,29049,1,4,0)
 ;;=4^O35.8XX4
 ;;^UTILITY(U,$J,358.3,29049,2)
 ;;=^5016834
 ;;^UTILITY(U,$J,358.3,29050,0)
 ;;=O35.8XX5^^115^1455^145
 ;;^UTILITY(U,$J,358.3,29050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29050,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 5
 ;;^UTILITY(U,$J,358.3,29050,1,4,0)
 ;;=4^O35.8XX5
 ;;^UTILITY(U,$J,358.3,29050,2)
 ;;=^5016835
 ;;^UTILITY(U,$J,358.3,29051,0)
 ;;=O35.5XX0^^115^1455^73
 ;;^UTILITY(U,$J,358.3,29051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29051,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, unsp
 ;;^UTILITY(U,$J,358.3,29051,1,4,0)
 ;;=4^O35.5XX0
 ;;^UTILITY(U,$J,358.3,29051,2)
 ;;=^5016810
 ;;^UTILITY(U,$J,358.3,29052,0)
 ;;=O35.5XX1^^115^1455^74
 ;;^UTILITY(U,$J,358.3,29052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29052,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 1
 ;;^UTILITY(U,$J,358.3,29052,1,4,0)
 ;;=4^O35.5XX1
 ;;^UTILITY(U,$J,358.3,29052,2)
 ;;=^5016811
 ;;^UTILITY(U,$J,358.3,29053,0)
 ;;=O35.5XX2^^115^1455^75
 ;;^UTILITY(U,$J,358.3,29053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29053,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 2
 ;;^UTILITY(U,$J,358.3,29053,1,4,0)
 ;;=4^O35.5XX2
 ;;^UTILITY(U,$J,358.3,29053,2)
 ;;=^5016812
 ;;^UTILITY(U,$J,358.3,29054,0)
 ;;=O35.5XX3^^115^1455^76
 ;;^UTILITY(U,$J,358.3,29054,1,0)
 ;;=^358.31IA^4^2
