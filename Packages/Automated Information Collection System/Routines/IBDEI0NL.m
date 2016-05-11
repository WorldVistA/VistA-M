IBDEI0NL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11013,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,11013,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,11013,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,11014,0)
 ;;=I73.9^^47^524^55
 ;;^UTILITY(U,$J,358.3,11014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11014,1,3,0)
 ;;=3^PVD,Unspec
 ;;^UTILITY(U,$J,358.3,11014,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,11014,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,11015,0)
 ;;=I80.9^^47^524^56
 ;;^UTILITY(U,$J,358.3,11015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11015,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,11015,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,11015,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,11016,0)
 ;;=Z98.61^^47^524^57
 ;;^UTILITY(U,$J,358.3,11016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11016,1,3,0)
 ;;=3^Postprocedural State,Coronary Angioplasty
 ;;^UTILITY(U,$J,358.3,11016,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,11016,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,11017,0)
 ;;=Z98.62^^47^524^58
 ;;^UTILITY(U,$J,358.3,11017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11017,1,3,0)
 ;;=3^Postprocedural State,Peripheral Vascular Angioplasty
 ;;^UTILITY(U,$J,358.3,11017,1,4,0)
 ;;=4^Z98.62
 ;;^UTILITY(U,$J,358.3,11017,2)
 ;;=^5063743
 ;;^UTILITY(U,$J,358.3,11018,0)
 ;;=Z95.810^^47^524^59
 ;;^UTILITY(U,$J,358.3,11018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11018,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,11018,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,11018,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,11019,0)
 ;;=Z95.5^^47^524^62
 ;;^UTILITY(U,$J,358.3,11019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11019,1,3,0)
 ;;=3^Presence of Coronary Angioplasty Implant & Graft
 ;;^UTILITY(U,$J,358.3,11019,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,11019,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,11020,0)
 ;;=Z95.811^^47^524^64
 ;;^UTILITY(U,$J,358.3,11020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11020,1,3,0)
 ;;=3^Presence of Heart Assist Device
 ;;^UTILITY(U,$J,358.3,11020,1,4,0)
 ;;=4^Z95.811
 ;;^UTILITY(U,$J,358.3,11020,2)
 ;;=^5063675
 ;;^UTILITY(U,$J,358.3,11021,0)
 ;;=Z95.812^^47^524^63
 ;;^UTILITY(U,$J,358.3,11021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11021,1,3,0)
 ;;=3^Presence of Fully Implantable Artificial Heart
 ;;^UTILITY(U,$J,358.3,11021,1,4,0)
 ;;=4^Z95.812
 ;;^UTILITY(U,$J,358.3,11021,2)
 ;;=^5063676
 ;;^UTILITY(U,$J,358.3,11022,0)
 ;;=Z95.818^^47^524^60
 ;;^UTILITY(U,$J,358.3,11022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11022,1,3,0)
 ;;=3^Presence of Cardiac Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,11022,1,4,0)
 ;;=4^Z95.818
 ;;^UTILITY(U,$J,358.3,11022,2)
 ;;=^5063677
 ;;^UTILITY(U,$J,358.3,11023,0)
 ;;=Z95.820^^47^524^65
 ;;^UTILITY(U,$J,358.3,11023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11023,1,3,0)
 ;;=3^Presence of Peripheral Vasc Angioplasty w/ Implants & Grafts
 ;;^UTILITY(U,$J,358.3,11023,1,4,0)
 ;;=4^Z95.820
 ;;^UTILITY(U,$J,358.3,11023,2)
 ;;=^5063678
 ;;^UTILITY(U,$J,358.3,11024,0)
 ;;=Z95.828^^47^524^67
 ;;^UTILITY(U,$J,358.3,11024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11024,1,3,0)
 ;;=3^Presence of Vascular Implants & Grafts,Other
 ;;^UTILITY(U,$J,358.3,11024,1,4,0)
 ;;=4^Z95.828
 ;;^UTILITY(U,$J,358.3,11024,2)
 ;;=^5063679
 ;;^UTILITY(U,$J,358.3,11025,0)
 ;;=Z95.2^^47^524^66
 ;;^UTILITY(U,$J,358.3,11025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11025,1,3,0)
 ;;=3^Presence of Prostetic Heart Valve
 ;;^UTILITY(U,$J,358.3,11025,1,4,0)
 ;;=4^Z95.2
