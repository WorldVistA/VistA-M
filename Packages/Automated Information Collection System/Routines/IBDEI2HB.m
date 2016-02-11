IBDEI2HB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41595,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41595,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,41595,1,3,0)
 ;;=3^11624
 ;;^UTILITY(U,$J,358.3,41596,0)
 ;;=11626^^191^2113^12^^^^1
 ;;^UTILITY(U,$J,358.3,41596,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41596,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, gentalia; over 4.0cm
 ;;^UTILITY(U,$J,358.3,41596,1,3,0)
 ;;=3^11626
 ;;^UTILITY(U,$J,358.3,41597,0)
 ;;=12001^^191^2114^8^^^^1
 ;;^UTILITY(U,$J,358.3,41597,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41597,1,2,0)
 ;;=2^Simple Repair of Wnd-Scalp,Neck,Axillae,Trunk;2.5cm or less
 ;;^UTILITY(U,$J,358.3,41597,1,3,0)
 ;;=3^12001
 ;;^UTILITY(U,$J,358.3,41598,0)
 ;;=12002^^191^2114^9^^^^1
 ;;^UTILITY(U,$J,358.3,41598,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41598,1,2,0)
 ;;=2^Simple Repair of Wnd-Scalp,Neck,Axillae,Trunk;2.6cm-7.5cm
 ;;^UTILITY(U,$J,358.3,41598,1,3,0)
 ;;=3^12002
 ;;^UTILITY(U,$J,358.3,41599,0)
 ;;=12041^^191^2114^1^^^^1
 ;;^UTILITY(U,$J,358.3,41599,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41599,1,2,0)
 ;;=2^Layer Closure of Wnd-Neck,Hands,Feet,Ext Genitalia;2.5cm or less
 ;;^UTILITY(U,$J,358.3,41599,1,3,0)
 ;;=3^12041
 ;;^UTILITY(U,$J,358.3,41600,0)
 ;;=12042^^191^2114^2^^^^1
 ;;^UTILITY(U,$J,358.3,41600,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41600,1,2,0)
 ;;=2^Layer Closure of Wnd-Neck,Hands,Feet,Ext Genitalia;2.6cm-7.5cm
 ;;^UTILITY(U,$J,358.3,41600,1,3,0)
 ;;=3^12042
 ;;^UTILITY(U,$J,358.3,41601,0)
 ;;=12031^^191^2114^3^^^^1
 ;;^UTILITY(U,$J,358.3,41601,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41601,1,2,0)
 ;;=2^Layer Closure of Wnd-Scalp,Axillae,Trunk,Extrem;2.5cm or less
 ;;^UTILITY(U,$J,358.3,41601,1,3,0)
 ;;=3^12031
 ;;^UTILITY(U,$J,358.3,41602,0)
 ;;=12032^^191^2114^4^^^^1
 ;;^UTILITY(U,$J,358.3,41602,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41602,1,2,0)
 ;;=2^Layer Closure of Wnd-Scalp,Axillae,Trunk,Extrem;2.6cm-7.5cm
 ;;^UTILITY(U,$J,358.3,41602,1,3,0)
 ;;=3^12032
 ;;^UTILITY(U,$J,358.3,41603,0)
 ;;=12020^^191^2114^10^^^^1
 ;;^UTILITY(U,$J,358.3,41603,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41603,1,2,0)
 ;;=2^TX of Superficial Wound Dehiscence; simple closure
 ;;^UTILITY(U,$J,358.3,41603,1,3,0)
 ;;=3^12020
 ;;^UTILITY(U,$J,358.3,41604,0)
 ;;=12021^^191^2114^11^^^^1
 ;;^UTILITY(U,$J,358.3,41604,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41604,1,2,0)
 ;;=2^TX of Superficial Wound Dehiscence; simple closure with packing
 ;;^UTILITY(U,$J,358.3,41604,1,3,0)
 ;;=3^12021
 ;;^UTILITY(U,$J,358.3,41605,0)
 ;;=13160^^191^2114^7^^^^1
 ;;^UTILITY(U,$J,358.3,41605,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41605,1,2,0)
 ;;=2^Secondary Closure of Surgical Wound or Dehiscence, extensive or complicated 
 ;;^UTILITY(U,$J,358.3,41605,1,3,0)
 ;;=3^13160
 ;;^UTILITY(U,$J,358.3,41606,0)
 ;;=27650^^191^2114^6^^^^1
 ;;^UTILITY(U,$J,358.3,41606,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41606,1,2,0)
 ;;=2^Repair Primary Ruptured Achilles Tendon
 ;;^UTILITY(U,$J,358.3,41606,1,3,0)
 ;;=3^27650
 ;;^UTILITY(U,$J,358.3,41607,0)
 ;;=28406^^191^2114^5^^^^1
 ;;^UTILITY(U,$J,358.3,41607,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41607,1,2,0)
 ;;=2^Perc Fixation Calcaneous Fx
 ;;^UTILITY(U,$J,358.3,41607,1,3,0)
 ;;=3^28406
 ;;^UTILITY(U,$J,358.3,41608,0)
 ;;=16020^^191^2115^2^^^^1
 ;;^UTILITY(U,$J,358.3,41608,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41608,1,2,0)
 ;;=2^Dressings and/or Debridement, initial or subsequent; without anesthesia, office or hospital, small
