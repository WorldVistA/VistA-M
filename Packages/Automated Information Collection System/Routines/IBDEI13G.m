IBDEI13G ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19612,2)
 ;;=^269620
 ;;^UTILITY(U,$J,358.3,19613,0)
 ;;=404.13^^131^1276^34
 ;;^UTILITY(U,$J,358.3,19613,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19613,1,4,0)
 ;;=4^404.13
 ;;^UTILITY(U,$J,358.3,19613,1,5,0)
 ;;=5^HTN with CHF & Renal failure
 ;;^UTILITY(U,$J,358.3,19613,2)
 ;;=^269621
 ;;^UTILITY(U,$J,358.3,19614,0)
 ;;=401.9^^131^1276^57
 ;;^UTILITY(U,$J,358.3,19614,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19614,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,19614,1,5,0)
 ;;=5^Hypertension, Essential
 ;;^UTILITY(U,$J,358.3,19614,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,19615,0)
 ;;=272.0^^131^1276^55
 ;;^UTILITY(U,$J,358.3,19615,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19615,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,19615,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,19615,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,19616,0)
 ;;=272.1^^131^1276^58
 ;;^UTILITY(U,$J,358.3,19616,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19616,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,19616,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,19616,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,19617,0)
 ;;=272.2^^131^1276^63
 ;;^UTILITY(U,$J,358.3,19617,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19617,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,19617,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,19617,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,19618,0)
 ;;=396.0^^131^1276^11
 ;;^UTILITY(U,$J,358.3,19618,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19618,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,19618,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,19618,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,19619,0)
 ;;=414.02^^131^1276^18
 ;;^UTILITY(U,$J,358.3,19619,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19619,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,19619,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,19619,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,19620,0)
 ;;=459.10^^131^1276^73
 ;;^UTILITY(U,$J,358.3,19620,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19620,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,19620,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,19620,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,19621,0)
 ;;=428.20^^131^1276^50
 ;;^UTILITY(U,$J,358.3,19621,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19621,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,19621,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,19621,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,19622,0)
 ;;=428.21^^131^1276^42
 ;;^UTILITY(U,$J,358.3,19622,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19622,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,19622,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,19622,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,19623,0)
 ;;=428.22^^131^1276^44
 ;;^UTILITY(U,$J,358.3,19623,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19623,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,19623,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,19623,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,19624,0)
 ;;=428.23^^131^1276^49
 ;;^UTILITY(U,$J,358.3,19624,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19624,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,19624,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,19624,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,19625,0)
 ;;=428.30^^131^1276^45
