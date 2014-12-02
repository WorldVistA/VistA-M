IBDEI06W ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3050,0)
 ;;=272.0^^33^271^56
 ;;^UTILITY(U,$J,358.3,3050,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3050,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,3050,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,3050,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,3051,0)
 ;;=272.1^^33^271^60
 ;;^UTILITY(U,$J,358.3,3051,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3051,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,3051,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,3051,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,3052,0)
 ;;=272.2^^33^271^64
 ;;^UTILITY(U,$J,358.3,3052,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3052,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,3052,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,3052,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,3053,0)
 ;;=396.0^^33^271^13
 ;;^UTILITY(U,$J,358.3,3053,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3053,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,3053,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,3053,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,3054,0)
 ;;=414.02^^33^271^18
 ;;^UTILITY(U,$J,358.3,3054,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3054,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,3054,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,3054,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,3055,0)
 ;;=459.10^^33^271^75
 ;;^UTILITY(U,$J,358.3,3055,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3055,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,3055,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,3055,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,3056,0)
 ;;=428.20^^33^271^52
 ;;^UTILITY(U,$J,358.3,3056,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3056,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,3056,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,3056,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,3057,0)
 ;;=428.21^^33^271^44
 ;;^UTILITY(U,$J,358.3,3057,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3057,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,3057,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,3057,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,3058,0)
 ;;=428.22^^33^271^46
 ;;^UTILITY(U,$J,358.3,3058,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3058,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,3058,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,3058,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,3059,0)
 ;;=428.23^^33^271^51
 ;;^UTILITY(U,$J,358.3,3059,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3059,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,3059,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,3059,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,3060,0)
 ;;=428.30^^33^271^47
 ;;^UTILITY(U,$J,358.3,3060,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3060,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,3060,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,3060,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,3061,0)
 ;;=428.31^^33^271^43
 ;;^UTILITY(U,$J,358.3,3061,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3061,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,3061,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,3061,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,3062,0)
 ;;=428.32^^33^271^45
 ;;^UTILITY(U,$J,358.3,3062,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3062,1,4,0)
 ;;=4^428.32
