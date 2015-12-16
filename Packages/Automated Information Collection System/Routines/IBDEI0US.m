IBDEI0US ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14955,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,14955,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,14955,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,14956,0)
 ;;=459.10^^81^936^73
 ;;^UTILITY(U,$J,358.3,14956,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14956,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,14956,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,14956,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,14957,0)
 ;;=428.20^^81^936^50
 ;;^UTILITY(U,$J,358.3,14957,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14957,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,14957,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,14957,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,14958,0)
 ;;=428.21^^81^936^42
 ;;^UTILITY(U,$J,358.3,14958,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14958,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,14958,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,14958,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,14959,0)
 ;;=428.22^^81^936^44
 ;;^UTILITY(U,$J,358.3,14959,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14959,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,14959,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,14959,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,14960,0)
 ;;=428.23^^81^936^49
 ;;^UTILITY(U,$J,358.3,14960,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14960,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,14960,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,14960,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,14961,0)
 ;;=428.30^^81^936^45
 ;;^UTILITY(U,$J,358.3,14961,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14961,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,14961,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,14961,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,14962,0)
 ;;=428.31^^81^936^41
 ;;^UTILITY(U,$J,358.3,14962,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14962,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,14962,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,14962,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,14963,0)
 ;;=428.32^^81^936^43
 ;;^UTILITY(U,$J,358.3,14963,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14963,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,14963,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,14963,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,14964,0)
 ;;=428.33^^81^936^47
 ;;^UTILITY(U,$J,358.3,14964,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14964,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,14964,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,14964,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,14965,0)
 ;;=428.40^^81^936^46
 ;;^UTILITY(U,$J,358.3,14965,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14965,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,14965,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,14965,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,14966,0)
 ;;=428.41^^81^936^48
 ;;^UTILITY(U,$J,358.3,14966,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14966,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,14966,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,14966,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
