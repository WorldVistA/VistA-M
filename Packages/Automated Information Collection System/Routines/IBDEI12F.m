IBDEI12F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18806,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18806,1,4,0)
 ;;=4^404.13
 ;;^UTILITY(U,$J,358.3,18806,1,5,0)
 ;;=5^HTN with CHF & Renal failure
 ;;^UTILITY(U,$J,358.3,18806,2)
 ;;=^269621
 ;;^UTILITY(U,$J,358.3,18807,0)
 ;;=401.9^^105^1222^57
 ;;^UTILITY(U,$J,358.3,18807,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18807,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,18807,1,5,0)
 ;;=5^Hypertension, Essential
 ;;^UTILITY(U,$J,358.3,18807,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,18808,0)
 ;;=272.0^^105^1222^55
 ;;^UTILITY(U,$J,358.3,18808,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18808,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,18808,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,18808,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,18809,0)
 ;;=272.1^^105^1222^58
 ;;^UTILITY(U,$J,358.3,18809,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18809,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,18809,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,18809,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,18810,0)
 ;;=272.2^^105^1222^63
 ;;^UTILITY(U,$J,358.3,18810,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18810,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,18810,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,18810,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,18811,0)
 ;;=396.0^^105^1222^11
 ;;^UTILITY(U,$J,358.3,18811,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18811,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,18811,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,18811,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,18812,0)
 ;;=414.02^^105^1222^18
 ;;^UTILITY(U,$J,358.3,18812,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18812,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,18812,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,18812,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,18813,0)
 ;;=459.10^^105^1222^73
 ;;^UTILITY(U,$J,358.3,18813,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18813,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,18813,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,18813,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,18814,0)
 ;;=428.20^^105^1222^50
 ;;^UTILITY(U,$J,358.3,18814,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18814,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,18814,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,18814,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,18815,0)
 ;;=428.21^^105^1222^42
 ;;^UTILITY(U,$J,358.3,18815,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18815,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,18815,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,18815,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,18816,0)
 ;;=428.22^^105^1222^44
 ;;^UTILITY(U,$J,358.3,18816,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18816,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,18816,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,18816,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,18817,0)
 ;;=428.23^^105^1222^49
 ;;^UTILITY(U,$J,358.3,18817,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18817,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,18817,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,18817,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,18818,0)
 ;;=428.30^^105^1222^45
 ;;^UTILITY(U,$J,358.3,18818,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18818,1,4,0)
 ;;=4^428.30
