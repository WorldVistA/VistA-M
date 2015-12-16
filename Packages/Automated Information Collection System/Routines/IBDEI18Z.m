IBDEI18Z ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22109,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22109,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,22109,1,5,0)
 ;;=5^Hypertension, Essential
 ;;^UTILITY(U,$J,358.3,22109,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,22110,0)
 ;;=272.0^^125^1387^55
 ;;^UTILITY(U,$J,358.3,22110,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22110,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,22110,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,22110,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,22111,0)
 ;;=272.1^^125^1387^58
 ;;^UTILITY(U,$J,358.3,22111,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22111,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,22111,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,22111,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,22112,0)
 ;;=272.2^^125^1387^63
 ;;^UTILITY(U,$J,358.3,22112,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22112,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,22112,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,22112,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,22113,0)
 ;;=396.0^^125^1387^11
 ;;^UTILITY(U,$J,358.3,22113,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22113,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,22113,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,22113,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,22114,0)
 ;;=414.02^^125^1387^18
 ;;^UTILITY(U,$J,358.3,22114,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22114,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,22114,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,22114,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,22115,0)
 ;;=459.10^^125^1387^73
 ;;^UTILITY(U,$J,358.3,22115,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22115,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,22115,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,22115,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,22116,0)
 ;;=428.20^^125^1387^50
 ;;^UTILITY(U,$J,358.3,22116,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22116,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,22116,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,22116,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,22117,0)
 ;;=428.21^^125^1387^42
 ;;^UTILITY(U,$J,358.3,22117,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22117,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,22117,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,22117,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,22118,0)
 ;;=428.22^^125^1387^44
 ;;^UTILITY(U,$J,358.3,22118,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22118,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,22118,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,22118,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,22119,0)
 ;;=428.23^^125^1387^49
 ;;^UTILITY(U,$J,358.3,22119,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22119,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,22119,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,22119,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,22120,0)
 ;;=428.30^^125^1387^45
 ;;^UTILITY(U,$J,358.3,22120,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22120,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,22120,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,22120,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,22121,0)
 ;;=428.31^^125^1387^41
 ;;^UTILITY(U,$J,358.3,22121,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22121,1,4,0)
 ;;=4^428.31
