IBDEI0ZP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16455,1,3,0)
 ;;=3^Nevus,Non-Neoplastic
 ;;^UTILITY(U,$J,358.3,16455,1,4,0)
 ;;=4^I78.1
 ;;^UTILITY(U,$J,358.3,16455,2)
 ;;=^269807
 ;;^UTILITY(U,$J,358.3,16456,0)
 ;;=Z95.0^^88^847^61
 ;;^UTILITY(U,$J,358.3,16456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16456,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,16456,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,16456,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,16457,0)
 ;;=I73.9^^88^847^55
 ;;^UTILITY(U,$J,358.3,16457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16457,1,3,0)
 ;;=3^PVD,Unspec
 ;;^UTILITY(U,$J,358.3,16457,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,16457,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,16458,0)
 ;;=I80.9^^88^847^56
 ;;^UTILITY(U,$J,358.3,16458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16458,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,16458,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,16458,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,16459,0)
 ;;=Z98.61^^88^847^57
 ;;^UTILITY(U,$J,358.3,16459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16459,1,3,0)
 ;;=3^Postprocedural State,Coronary Angioplasty
 ;;^UTILITY(U,$J,358.3,16459,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,16459,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,16460,0)
 ;;=Z98.62^^88^847^58
 ;;^UTILITY(U,$J,358.3,16460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16460,1,3,0)
 ;;=3^Postprocedural State,Peripheral Vascular Angioplasty
 ;;^UTILITY(U,$J,358.3,16460,1,4,0)
 ;;=4^Z98.62
 ;;^UTILITY(U,$J,358.3,16460,2)
 ;;=^5063743
 ;;^UTILITY(U,$J,358.3,16461,0)
 ;;=Z95.810^^88^847^59
 ;;^UTILITY(U,$J,358.3,16461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16461,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,16461,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,16461,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,16462,0)
 ;;=Z95.5^^88^847^62
 ;;^UTILITY(U,$J,358.3,16462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16462,1,3,0)
 ;;=3^Presence of Coronary Angioplasty Implant & Graft
 ;;^UTILITY(U,$J,358.3,16462,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,16462,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,16463,0)
 ;;=Z95.811^^88^847^64
 ;;^UTILITY(U,$J,358.3,16463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16463,1,3,0)
 ;;=3^Presence of Heart Assist Device
 ;;^UTILITY(U,$J,358.3,16463,1,4,0)
 ;;=4^Z95.811
 ;;^UTILITY(U,$J,358.3,16463,2)
 ;;=^5063675
 ;;^UTILITY(U,$J,358.3,16464,0)
 ;;=Z95.812^^88^847^63
 ;;^UTILITY(U,$J,358.3,16464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16464,1,3,0)
 ;;=3^Presence of Fully Implantable Artificial Heart
 ;;^UTILITY(U,$J,358.3,16464,1,4,0)
 ;;=4^Z95.812
 ;;^UTILITY(U,$J,358.3,16464,2)
 ;;=^5063676
 ;;^UTILITY(U,$J,358.3,16465,0)
 ;;=Z95.818^^88^847^60
 ;;^UTILITY(U,$J,358.3,16465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16465,1,3,0)
 ;;=3^Presence of Cardiac Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,16465,1,4,0)
 ;;=4^Z95.818
 ;;^UTILITY(U,$J,358.3,16465,2)
 ;;=^5063677
 ;;^UTILITY(U,$J,358.3,16466,0)
 ;;=Z95.820^^88^847^65
 ;;^UTILITY(U,$J,358.3,16466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16466,1,3,0)
 ;;=3^Presence of Peripheral Vasc Angioplasty w/ Implants & Grafts
 ;;^UTILITY(U,$J,358.3,16466,1,4,0)
 ;;=4^Z95.820
 ;;^UTILITY(U,$J,358.3,16466,2)
 ;;=^5063678
 ;;^UTILITY(U,$J,358.3,16467,0)
 ;;=Z95.828^^88^847^67
 ;;^UTILITY(U,$J,358.3,16467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16467,1,3,0)
 ;;=3^Presence of Vascular Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,16467,1,4,0)
 ;;=4^Z95.828
 ;;^UTILITY(U,$J,358.3,16467,2)
 ;;=^5063679
 ;;^UTILITY(U,$J,358.3,16468,0)
 ;;=Z95.2^^88^847^66
