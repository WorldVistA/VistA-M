IBDEI0JD ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9482,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9482,1,4,0)
 ;;=4^402.11
 ;;^UTILITY(U,$J,358.3,9482,1,5,0)
 ;;=5^HTN with CHF
 ;;^UTILITY(U,$J,358.3,9482,2)
 ;;=HTN with CHF^269599
 ;;^UTILITY(U,$J,358.3,9483,0)
 ;;=403.11^^67^662^37
 ;;^UTILITY(U,$J,358.3,9483,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9483,1,4,0)
 ;;=4^403.11
 ;;^UTILITY(U,$J,358.3,9483,1,5,0)
 ;;=5^HTN with Renal Failure
 ;;^UTILITY(U,$J,358.3,9483,2)
 ;;=^269608
 ;;^UTILITY(U,$J,358.3,9484,0)
 ;;=404.10^^67^662^35
 ;;^UTILITY(U,$J,358.3,9484,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9484,1,4,0)
 ;;=4^404.10
 ;;^UTILITY(U,$J,358.3,9484,1,5,0)
 ;;=5^HTN with Heart & Renal Involvement
 ;;^UTILITY(U,$J,358.3,9484,2)
 ;;=^269618
 ;;^UTILITY(U,$J,358.3,9485,0)
 ;;=404.11^^67^662^33
 ;;^UTILITY(U,$J,358.3,9485,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9485,1,4,0)
 ;;=4^404.11
 ;;^UTILITY(U,$J,358.3,9485,1,5,0)
 ;;=5^HTN with CHF & Renal Involvement
 ;;^UTILITY(U,$J,358.3,9485,2)
 ;;=^269619
 ;;^UTILITY(U,$J,358.3,9486,0)
 ;;=404.12^^67^662^36
 ;;^UTILITY(U,$J,358.3,9486,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9486,1,4,0)
 ;;=4^404.12
 ;;^UTILITY(U,$J,358.3,9486,1,5,0)
 ;;=5^HTN with Heart Involvement & Renal Failure
 ;;^UTILITY(U,$J,358.3,9486,2)
 ;;=^269620
 ;;^UTILITY(U,$J,358.3,9487,0)
 ;;=404.13^^67^662^34
 ;;^UTILITY(U,$J,358.3,9487,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9487,1,4,0)
 ;;=4^404.13
 ;;^UTILITY(U,$J,358.3,9487,1,5,0)
 ;;=5^HTN with CHF & Renal failure
 ;;^UTILITY(U,$J,358.3,9487,2)
 ;;=^269621
 ;;^UTILITY(U,$J,358.3,9488,0)
 ;;=401.9^^67^662^57
 ;;^UTILITY(U,$J,358.3,9488,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9488,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,9488,1,5,0)
 ;;=5^Hypertension, Essential
 ;;^UTILITY(U,$J,358.3,9488,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,9489,0)
 ;;=272.0^^67^662^55
 ;;^UTILITY(U,$J,358.3,9489,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9489,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,9489,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,9489,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,9490,0)
 ;;=272.1^^67^662^58
 ;;^UTILITY(U,$J,358.3,9490,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9490,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,9490,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,9490,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,9491,0)
 ;;=272.2^^67^662^63
 ;;^UTILITY(U,$J,358.3,9491,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9491,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,9491,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,9491,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,9492,0)
 ;;=396.0^^67^662^11
 ;;^UTILITY(U,$J,358.3,9492,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9492,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,9492,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,9492,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,9493,0)
 ;;=414.02^^67^662^18
 ;;^UTILITY(U,$J,358.3,9493,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9493,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,9493,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,9493,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,9494,0)
 ;;=459.10^^67^662^73
 ;;^UTILITY(U,$J,358.3,9494,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9494,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,9494,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,9494,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,9495,0)
 ;;=428.20^^67^662^50
 ;;^UTILITY(U,$J,358.3,9495,1,0)
 ;;=^358.31IA^5^2
