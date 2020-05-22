IBDEI308 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47981,1,3,0)
 ;;=3^Postprocedural State,Peripheral Vascular Angioplasty
 ;;^UTILITY(U,$J,358.3,47981,1,4,0)
 ;;=4^Z98.62
 ;;^UTILITY(U,$J,358.3,47981,2)
 ;;=^5063743
 ;;^UTILITY(U,$J,358.3,47982,0)
 ;;=Z95.810^^185^2414^63
 ;;^UTILITY(U,$J,358.3,47982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47982,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,47982,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,47982,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,47983,0)
 ;;=Z95.5^^185^2414^66
 ;;^UTILITY(U,$J,358.3,47983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47983,1,3,0)
 ;;=3^Presence of Coronary Angioplasty Implant & Graft
 ;;^UTILITY(U,$J,358.3,47983,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,47983,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,47984,0)
 ;;=Z95.811^^185^2414^68
 ;;^UTILITY(U,$J,358.3,47984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47984,1,3,0)
 ;;=3^Presence of Heart Assist Device
 ;;^UTILITY(U,$J,358.3,47984,1,4,0)
 ;;=4^Z95.811
 ;;^UTILITY(U,$J,358.3,47984,2)
 ;;=^5063675
 ;;^UTILITY(U,$J,358.3,47985,0)
 ;;=Z95.812^^185^2414^67
 ;;^UTILITY(U,$J,358.3,47985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47985,1,3,0)
 ;;=3^Presence of Fully Implantable Artificial Heart
 ;;^UTILITY(U,$J,358.3,47985,1,4,0)
 ;;=4^Z95.812
 ;;^UTILITY(U,$J,358.3,47985,2)
 ;;=^5063676
 ;;^UTILITY(U,$J,358.3,47986,0)
 ;;=Z95.818^^185^2414^64
 ;;^UTILITY(U,$J,358.3,47986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47986,1,3,0)
 ;;=3^Presence of Cardiac Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,47986,1,4,0)
 ;;=4^Z95.818
 ;;^UTILITY(U,$J,358.3,47986,2)
 ;;=^5063677
 ;;^UTILITY(U,$J,358.3,47987,0)
 ;;=Z95.820^^185^2414^69
 ;;^UTILITY(U,$J,358.3,47987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47987,1,3,0)
 ;;=3^Presence of Peripheral Vasc Angioplasty w/ Implants & Grafts
 ;;^UTILITY(U,$J,358.3,47987,1,4,0)
 ;;=4^Z95.820
 ;;^UTILITY(U,$J,358.3,47987,2)
 ;;=^5063678
 ;;^UTILITY(U,$J,358.3,47988,0)
 ;;=Z95.828^^185^2414^71
 ;;^UTILITY(U,$J,358.3,47988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47988,1,3,0)
 ;;=3^Presence of Vascular Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,47988,1,4,0)
 ;;=4^Z95.828
 ;;^UTILITY(U,$J,358.3,47988,2)
 ;;=^5063679
 ;;^UTILITY(U,$J,358.3,47989,0)
 ;;=Z95.2^^185^2414^70
 ;;^UTILITY(U,$J,358.3,47989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47989,1,3,0)
 ;;=3^Presence of Prostetic Heart Valve
 ;;^UTILITY(U,$J,358.3,47989,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,47989,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,47990,0)
 ;;=Z95.3^^185^2414^72
 ;;^UTILITY(U,$J,358.3,47990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47990,1,3,0)
 ;;=3^Presence of Xenogenic Heart Valve
 ;;^UTILITY(U,$J,358.3,47990,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,47990,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,47991,0)
 ;;=I27.9^^185^2414^73
 ;;^UTILITY(U,$J,358.3,47991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47991,1,3,0)
 ;;=3^Pulmonary Heart Disease,Unspec
 ;;^UTILITY(U,$J,358.3,47991,1,4,0)
 ;;=4^I27.9
 ;;^UTILITY(U,$J,358.3,47991,2)
 ;;=^5007154
 ;;^UTILITY(U,$J,358.3,47992,0)
 ;;=I27.0^^185^2414^74
 ;;^UTILITY(U,$J,358.3,47992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47992,1,3,0)
 ;;=3^Pulmonary Hypertension,Primary
 ;;^UTILITY(U,$J,358.3,47992,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,47992,2)
 ;;=^265310
