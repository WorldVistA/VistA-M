IBDEI0WB ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15960,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15960,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,15960,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,15960,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,15961,0)
 ;;=272.1^^92^930^58
 ;;^UTILITY(U,$J,358.3,15961,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15961,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,15961,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,15961,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,15962,0)
 ;;=272.2^^92^930^63
 ;;^UTILITY(U,$J,358.3,15962,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15962,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,15962,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,15962,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,15963,0)
 ;;=396.0^^92^930^11
 ;;^UTILITY(U,$J,358.3,15963,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15963,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,15963,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,15963,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,15964,0)
 ;;=414.02^^92^930^18
 ;;^UTILITY(U,$J,358.3,15964,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15964,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,15964,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,15964,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,15965,0)
 ;;=459.10^^92^930^73
 ;;^UTILITY(U,$J,358.3,15965,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15965,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,15965,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,15965,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,15966,0)
 ;;=428.20^^92^930^50
 ;;^UTILITY(U,$J,358.3,15966,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15966,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,15966,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,15966,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,15967,0)
 ;;=428.21^^92^930^42
 ;;^UTILITY(U,$J,358.3,15967,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15967,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,15967,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,15967,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,15968,0)
 ;;=428.22^^92^930^44
 ;;^UTILITY(U,$J,358.3,15968,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15968,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,15968,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,15968,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,15969,0)
 ;;=428.23^^92^930^49
 ;;^UTILITY(U,$J,358.3,15969,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15969,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,15969,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,15969,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,15970,0)
 ;;=428.30^^92^930^45
 ;;^UTILITY(U,$J,358.3,15970,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15970,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,15970,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,15970,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,15971,0)
 ;;=428.31^^92^930^41
 ;;^UTILITY(U,$J,358.3,15971,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15971,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,15971,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,15971,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,15972,0)
 ;;=428.32^^92^930^43
 ;;^UTILITY(U,$J,358.3,15972,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15972,1,4,0)
 ;;=4^428.32
