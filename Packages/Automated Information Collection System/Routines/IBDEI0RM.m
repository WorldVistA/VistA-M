IBDEI0RM ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13640,0)
 ;;=414.02^^90^848^18
 ;;^UTILITY(U,$J,358.3,13640,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13640,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,13640,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,13640,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,13641,0)
 ;;=459.10^^90^848^73
 ;;^UTILITY(U,$J,358.3,13641,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13641,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,13641,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,13641,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,13642,0)
 ;;=428.20^^90^848^50
 ;;^UTILITY(U,$J,358.3,13642,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13642,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,13642,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,13642,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,13643,0)
 ;;=428.21^^90^848^42
 ;;^UTILITY(U,$J,358.3,13643,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13643,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,13643,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,13643,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,13644,0)
 ;;=428.22^^90^848^44
 ;;^UTILITY(U,$J,358.3,13644,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13644,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,13644,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,13644,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,13645,0)
 ;;=428.23^^90^848^49
 ;;^UTILITY(U,$J,358.3,13645,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13645,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,13645,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,13645,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,13646,0)
 ;;=428.30^^90^848^45
 ;;^UTILITY(U,$J,358.3,13646,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13646,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,13646,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,13646,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,13647,0)
 ;;=428.31^^90^848^41
 ;;^UTILITY(U,$J,358.3,13647,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13647,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,13647,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,13647,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,13648,0)
 ;;=428.32^^90^848^43
 ;;^UTILITY(U,$J,358.3,13648,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13648,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,13648,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,13648,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,13649,0)
 ;;=428.33^^90^848^47
 ;;^UTILITY(U,$J,358.3,13649,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13649,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,13649,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,13649,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,13650,0)
 ;;=428.40^^90^848^46
 ;;^UTILITY(U,$J,358.3,13650,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13650,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,13650,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,13650,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,13651,0)
 ;;=428.41^^90^848^48
 ;;^UTILITY(U,$J,358.3,13651,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13651,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,13651,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
