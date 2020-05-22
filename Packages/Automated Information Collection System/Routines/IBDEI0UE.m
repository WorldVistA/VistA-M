IBDEI0UE ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13536,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,13536,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,13536,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,13537,0)
 ;;=Z95.5^^83^812^66
 ;;^UTILITY(U,$J,358.3,13537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13537,1,3,0)
 ;;=3^Presence of Coronary Angioplasty Implant & Graft
 ;;^UTILITY(U,$J,358.3,13537,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,13537,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,13538,0)
 ;;=Z95.811^^83^812^68
 ;;^UTILITY(U,$J,358.3,13538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13538,1,3,0)
 ;;=3^Presence of Heart Assist Device
 ;;^UTILITY(U,$J,358.3,13538,1,4,0)
 ;;=4^Z95.811
 ;;^UTILITY(U,$J,358.3,13538,2)
 ;;=^5063675
 ;;^UTILITY(U,$J,358.3,13539,0)
 ;;=Z95.812^^83^812^67
 ;;^UTILITY(U,$J,358.3,13539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13539,1,3,0)
 ;;=3^Presence of Fully Implantable Artificial Heart
 ;;^UTILITY(U,$J,358.3,13539,1,4,0)
 ;;=4^Z95.812
 ;;^UTILITY(U,$J,358.3,13539,2)
 ;;=^5063676
 ;;^UTILITY(U,$J,358.3,13540,0)
 ;;=Z95.818^^83^812^64
 ;;^UTILITY(U,$J,358.3,13540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13540,1,3,0)
 ;;=3^Presence of Cardiac Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,13540,1,4,0)
 ;;=4^Z95.818
 ;;^UTILITY(U,$J,358.3,13540,2)
 ;;=^5063677
 ;;^UTILITY(U,$J,358.3,13541,0)
 ;;=Z95.820^^83^812^69
 ;;^UTILITY(U,$J,358.3,13541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13541,1,3,0)
 ;;=3^Presence of Peripheral Vasc Angioplasty w/ Implants & Grafts
 ;;^UTILITY(U,$J,358.3,13541,1,4,0)
 ;;=4^Z95.820
 ;;^UTILITY(U,$J,358.3,13541,2)
 ;;=^5063678
 ;;^UTILITY(U,$J,358.3,13542,0)
 ;;=Z95.828^^83^812^71
 ;;^UTILITY(U,$J,358.3,13542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13542,1,3,0)
 ;;=3^Presence of Vascular Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,13542,1,4,0)
 ;;=4^Z95.828
 ;;^UTILITY(U,$J,358.3,13542,2)
 ;;=^5063679
 ;;^UTILITY(U,$J,358.3,13543,0)
 ;;=Z95.2^^83^812^70
 ;;^UTILITY(U,$J,358.3,13543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13543,1,3,0)
 ;;=3^Presence of Prostetic Heart Valve
 ;;^UTILITY(U,$J,358.3,13543,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,13543,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,13544,0)
 ;;=Z95.3^^83^812^72
 ;;^UTILITY(U,$J,358.3,13544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13544,1,3,0)
 ;;=3^Presence of Xenogenic Heart Valve
 ;;^UTILITY(U,$J,358.3,13544,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,13544,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,13545,0)
 ;;=I27.9^^83^812^73
 ;;^UTILITY(U,$J,358.3,13545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13545,1,3,0)
 ;;=3^Pulmonary Heart Disease,Unspec
 ;;^UTILITY(U,$J,358.3,13545,1,4,0)
 ;;=4^I27.9
 ;;^UTILITY(U,$J,358.3,13545,2)
 ;;=^5007154
 ;;^UTILITY(U,$J,358.3,13546,0)
 ;;=I27.0^^83^812^74
 ;;^UTILITY(U,$J,358.3,13546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13546,1,3,0)
 ;;=3^Pulmonary Hypertension,Primary
 ;;^UTILITY(U,$J,358.3,13546,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,13546,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,13547,0)
 ;;=I73.00^^83^812^75
 ;;^UTILITY(U,$J,358.3,13547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13547,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,13547,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,13547,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,13548,0)
 ;;=R57.0^^83^812^76
