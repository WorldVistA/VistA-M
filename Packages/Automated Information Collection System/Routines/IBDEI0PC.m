IBDEI0PC ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12505,1,5,0)
 ;;=5^HTN w/ Heart & Renal Involvement
 ;;^UTILITY(U,$J,358.3,12505,2)
 ;;=^269618
 ;;^UTILITY(U,$J,358.3,12506,0)
 ;;=404.11^^87^819^33
 ;;^UTILITY(U,$J,358.3,12506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12506,1,4,0)
 ;;=4^404.11
 ;;^UTILITY(U,$J,358.3,12506,1,5,0)
 ;;=5^HTN w/ CHF & Renal Involvement
 ;;^UTILITY(U,$J,358.3,12506,2)
 ;;=^269619
 ;;^UTILITY(U,$J,358.3,12507,0)
 ;;=404.12^^87^819^36
 ;;^UTILITY(U,$J,358.3,12507,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12507,1,4,0)
 ;;=4^404.12
 ;;^UTILITY(U,$J,358.3,12507,1,5,0)
 ;;=5^HTN w/ Hrt & Renal w/o CHF w/ ESRD
 ;;^UTILITY(U,$J,358.3,12507,2)
 ;;=^269620
 ;;^UTILITY(U,$J,358.3,12508,0)
 ;;=404.13^^87^819^41
 ;;^UTILITY(U,$J,358.3,12508,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12508,1,4,0)
 ;;=4^404.13
 ;;^UTILITY(U,$J,358.3,12508,1,5,0)
 ;;=5^HTN with CHF & Renal failure
 ;;^UTILITY(U,$J,358.3,12508,2)
 ;;=^269621
 ;;^UTILITY(U,$J,358.3,12509,0)
 ;;=401.9^^87^819^60
 ;;^UTILITY(U,$J,358.3,12509,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12509,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,12509,1,5,0)
 ;;=5^Hypertension, Essential NOS
 ;;^UTILITY(U,$J,358.3,12509,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,12510,0)
 ;;=396.0^^87^819^10
 ;;^UTILITY(U,$J,358.3,12510,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12510,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,12510,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,12510,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,12511,0)
 ;;=414.02^^87^819^14
 ;;^UTILITY(U,$J,358.3,12511,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12511,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,12511,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,12511,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,12512,0)
 ;;=459.10^^87^819^72
 ;;^UTILITY(U,$J,358.3,12512,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12512,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,12512,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,12512,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,12513,0)
 ;;=428.20^^87^819^53
 ;;^UTILITY(U,$J,358.3,12513,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12513,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,12513,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,12513,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,12514,0)
 ;;=428.21^^87^819^47
 ;;^UTILITY(U,$J,358.3,12514,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12514,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,12514,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,12514,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,12515,0)
 ;;=428.22^^87^819^49
 ;;^UTILITY(U,$J,358.3,12515,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12515,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,12515,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,12515,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,12516,0)
 ;;=428.23^^87^819^57
 ;;^UTILITY(U,$J,358.3,12516,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12516,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,12516,1,5,0)
 ;;=5^Heart Failure,Systolic,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,12516,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,12517,0)
 ;;=428.30^^87^819^50
 ;;^UTILITY(U,$J,358.3,12517,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12517,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,12517,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,12517,2)
 ;;=Heart Failure, Diastolic^328595
