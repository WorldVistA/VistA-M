IBDEI06Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2949,1,3,0)
 ;;=3^Myocardial Infarction,Acute,Unspec Site
 ;;^UTILITY(U,$J,358.3,2949,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,2949,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,2950,0)
 ;;=I25.2^^18^210^53
 ;;^UTILITY(U,$J,358.3,2950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2950,1,3,0)
 ;;=3^Myocardial Infarction,Old
 ;;^UTILITY(U,$J,358.3,2950,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,2950,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,2951,0)
 ;;=I78.1^^18^210^54
 ;;^UTILITY(U,$J,358.3,2951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2951,1,3,0)
 ;;=3^Nevus,Non-Neoplastic
 ;;^UTILITY(U,$J,358.3,2951,1,4,0)
 ;;=4^I78.1
 ;;^UTILITY(U,$J,358.3,2951,2)
 ;;=^269807
 ;;^UTILITY(U,$J,358.3,2952,0)
 ;;=Z95.0^^18^210^61
 ;;^UTILITY(U,$J,358.3,2952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2952,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,2952,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,2952,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,2953,0)
 ;;=I73.9^^18^210^55
 ;;^UTILITY(U,$J,358.3,2953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2953,1,3,0)
 ;;=3^PVD,Unspec
 ;;^UTILITY(U,$J,358.3,2953,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,2953,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,2954,0)
 ;;=I80.9^^18^210^56
 ;;^UTILITY(U,$J,358.3,2954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2954,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,2954,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,2954,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,2955,0)
 ;;=Z98.61^^18^210^57
 ;;^UTILITY(U,$J,358.3,2955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2955,1,3,0)
 ;;=3^Postprocedural State,Coronary Angioplasty
 ;;^UTILITY(U,$J,358.3,2955,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,2955,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,2956,0)
 ;;=Z98.62^^18^210^58
 ;;^UTILITY(U,$J,358.3,2956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2956,1,3,0)
 ;;=3^Postprocedural State,Peripheral Vascular Angioplasty
 ;;^UTILITY(U,$J,358.3,2956,1,4,0)
 ;;=4^Z98.62
 ;;^UTILITY(U,$J,358.3,2956,2)
 ;;=^5063743
 ;;^UTILITY(U,$J,358.3,2957,0)
 ;;=Z95.810^^18^210^59
 ;;^UTILITY(U,$J,358.3,2957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2957,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,2957,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,2957,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,2958,0)
 ;;=Z95.5^^18^210^62
 ;;^UTILITY(U,$J,358.3,2958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2958,1,3,0)
 ;;=3^Presence of Coronary Angioplasty Implant & Graft
 ;;^UTILITY(U,$J,358.3,2958,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,2958,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,2959,0)
 ;;=Z95.811^^18^210^64
 ;;^UTILITY(U,$J,358.3,2959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2959,1,3,0)
 ;;=3^Presence of Heart Assist Device
 ;;^UTILITY(U,$J,358.3,2959,1,4,0)
 ;;=4^Z95.811
 ;;^UTILITY(U,$J,358.3,2959,2)
 ;;=^5063675
 ;;^UTILITY(U,$J,358.3,2960,0)
 ;;=Z95.812^^18^210^63
 ;;^UTILITY(U,$J,358.3,2960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2960,1,3,0)
 ;;=3^Presence of Fully Implantable Artificial Heart
 ;;^UTILITY(U,$J,358.3,2960,1,4,0)
 ;;=4^Z95.812
 ;;^UTILITY(U,$J,358.3,2960,2)
 ;;=^5063676
 ;;^UTILITY(U,$J,358.3,2961,0)
 ;;=Z95.818^^18^210^60
 ;;^UTILITY(U,$J,358.3,2961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2961,1,3,0)
 ;;=3^Presence of Cardiac Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,2961,1,4,0)
 ;;=4^Z95.818
 ;;^UTILITY(U,$J,358.3,2961,2)
 ;;=^5063677
 ;;^UTILITY(U,$J,358.3,2962,0)
 ;;=Z95.820^^18^210^65
 ;;^UTILITY(U,$J,358.3,2962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2962,1,3,0)
 ;;=3^Presence of Peripheral Vasc Angioplasty w/ Implants & Grafts
