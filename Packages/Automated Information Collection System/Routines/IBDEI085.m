IBDEI085 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3252,0)
 ;;=Z98.62^^28^249^58
 ;;^UTILITY(U,$J,358.3,3252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3252,1,3,0)
 ;;=3^Postprocedural State,Peripheral Vascular Angioplasty
 ;;^UTILITY(U,$J,358.3,3252,1,4,0)
 ;;=4^Z98.62
 ;;^UTILITY(U,$J,358.3,3252,2)
 ;;=^5063743
 ;;^UTILITY(U,$J,358.3,3253,0)
 ;;=Z95.810^^28^249^59
 ;;^UTILITY(U,$J,358.3,3253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3253,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,3253,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,3253,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,3254,0)
 ;;=Z95.5^^28^249^62
 ;;^UTILITY(U,$J,358.3,3254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3254,1,3,0)
 ;;=3^Presence of Coronary Angioplasty Implant & Graft
 ;;^UTILITY(U,$J,358.3,3254,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,3254,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,3255,0)
 ;;=Z95.811^^28^249^64
 ;;^UTILITY(U,$J,358.3,3255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3255,1,3,0)
 ;;=3^Presence of Heart Assist Device
 ;;^UTILITY(U,$J,358.3,3255,1,4,0)
 ;;=4^Z95.811
 ;;^UTILITY(U,$J,358.3,3255,2)
 ;;=^5063675
 ;;^UTILITY(U,$J,358.3,3256,0)
 ;;=Z95.812^^28^249^63
 ;;^UTILITY(U,$J,358.3,3256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3256,1,3,0)
 ;;=3^Presence of Fully Implantable Artificial Heart
 ;;^UTILITY(U,$J,358.3,3256,1,4,0)
 ;;=4^Z95.812
 ;;^UTILITY(U,$J,358.3,3256,2)
 ;;=^5063676
 ;;^UTILITY(U,$J,358.3,3257,0)
 ;;=Z95.818^^28^249^60
 ;;^UTILITY(U,$J,358.3,3257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3257,1,3,0)
 ;;=3^Presence of Cardiac Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,3257,1,4,0)
 ;;=4^Z95.818
 ;;^UTILITY(U,$J,358.3,3257,2)
 ;;=^5063677
 ;;^UTILITY(U,$J,358.3,3258,0)
 ;;=Z95.820^^28^249^65
 ;;^UTILITY(U,$J,358.3,3258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3258,1,3,0)
 ;;=3^Presence of Peripheral Vasc Angioplasty w/ Implants & Grafts
 ;;^UTILITY(U,$J,358.3,3258,1,4,0)
 ;;=4^Z95.820
 ;;^UTILITY(U,$J,358.3,3258,2)
 ;;=^5063678
 ;;^UTILITY(U,$J,358.3,3259,0)
 ;;=Z95.828^^28^249^67
 ;;^UTILITY(U,$J,358.3,3259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3259,1,3,0)
 ;;=3^Presence of Vascular Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,3259,1,4,0)
 ;;=4^Z95.828
 ;;^UTILITY(U,$J,358.3,3259,2)
 ;;=^5063679
 ;;^UTILITY(U,$J,358.3,3260,0)
 ;;=Z95.2^^28^249^66
 ;;^UTILITY(U,$J,358.3,3260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3260,1,3,0)
 ;;=3^Presence of Prostetic Heart Valve
 ;;^UTILITY(U,$J,358.3,3260,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,3260,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,3261,0)
 ;;=Z95.3^^28^249^68
 ;;^UTILITY(U,$J,358.3,3261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3261,1,3,0)
 ;;=3^Presence of Xenogenic Heart Valve
 ;;^UTILITY(U,$J,358.3,3261,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,3261,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,3262,0)
 ;;=I27.9^^28^249^69
 ;;^UTILITY(U,$J,358.3,3262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3262,1,3,0)
 ;;=3^Pulmonary Heart Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3262,1,4,0)
 ;;=4^I27.9
 ;;^UTILITY(U,$J,358.3,3262,2)
 ;;=^5007154
 ;;^UTILITY(U,$J,358.3,3263,0)
 ;;=I27.0^^28^249^70
 ;;^UTILITY(U,$J,358.3,3263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3263,1,3,0)
 ;;=3^Pulmonary Hypertension,Primary
 ;;^UTILITY(U,$J,358.3,3263,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,3263,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,3264,0)
 ;;=I73.00^^28^249^71
 ;;^UTILITY(U,$J,358.3,3264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3264,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,3264,1,4,0)
 ;;=4^I73.00
