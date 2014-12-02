IBDEI0DJ ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6512,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6512,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,6512,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,6512,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,6513,0)
 ;;=272.1^^55^567^58
 ;;^UTILITY(U,$J,358.3,6513,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6513,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,6513,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,6513,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,6514,0)
 ;;=272.2^^55^567^63
 ;;^UTILITY(U,$J,358.3,6514,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6514,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,6514,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,6514,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,6515,0)
 ;;=396.0^^55^567^11
 ;;^UTILITY(U,$J,358.3,6515,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6515,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,6515,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,6515,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,6516,0)
 ;;=414.02^^55^567^18
 ;;^UTILITY(U,$J,358.3,6516,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6516,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,6516,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,6516,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,6517,0)
 ;;=459.10^^55^567^73
 ;;^UTILITY(U,$J,358.3,6517,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6517,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,6517,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,6517,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,6518,0)
 ;;=428.20^^55^567^50
 ;;^UTILITY(U,$J,358.3,6518,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6518,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,6518,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,6518,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,6519,0)
 ;;=428.21^^55^567^42
 ;;^UTILITY(U,$J,358.3,6519,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6519,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,6519,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,6519,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,6520,0)
 ;;=428.22^^55^567^44
 ;;^UTILITY(U,$J,358.3,6520,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6520,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,6520,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,6520,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,6521,0)
 ;;=428.23^^55^567^49
 ;;^UTILITY(U,$J,358.3,6521,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6521,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,6521,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6521,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,6522,0)
 ;;=428.30^^55^567^45
 ;;^UTILITY(U,$J,358.3,6522,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6522,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,6522,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,6522,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,6523,0)
 ;;=428.31^^55^567^41
 ;;^UTILITY(U,$J,358.3,6523,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6523,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,6523,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,6523,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,6524,0)
 ;;=428.32^^55^567^43
 ;;^UTILITY(U,$J,358.3,6524,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6524,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,6524,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
