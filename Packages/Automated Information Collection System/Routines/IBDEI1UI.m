IBDEI1UI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31343,1,3,0)
 ;;=3^11604
 ;;^UTILITY(U,$J,358.3,31344,0)
 ;;=11606^^125^1585^6^^^^1
 ;;^UTILITY(U,$J,358.3,31344,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31344,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; over 4.0cm
 ;;^UTILITY(U,$J,358.3,31344,1,3,0)
 ;;=3^11606
 ;;^UTILITY(U,$J,358.3,31345,0)
 ;;=11620^^125^1585^7^^^^1
 ;;^UTILITY(U,$J,358.3,31345,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31345,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,31345,1,3,0)
 ;;=3^11620
 ;;^UTILITY(U,$J,358.3,31346,0)
 ;;=11621^^125^1585^8^^^^1
 ;;^UTILITY(U,$J,358.3,31346,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31346,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,31346,1,3,0)
 ;;=3^11621
 ;;^UTILITY(U,$J,358.3,31347,0)
 ;;=11622^^125^1585^9^^^^1
 ;;^UTILITY(U,$J,358.3,31347,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31347,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,31347,1,3,0)
 ;;=3^11622
 ;;^UTILITY(U,$J,358.3,31348,0)
 ;;=11623^^125^1585^10^^^^1
 ;;^UTILITY(U,$J,358.3,31348,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31348,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,31348,1,3,0)
 ;;=3^11623
 ;;^UTILITY(U,$J,358.3,31349,0)
 ;;=11624^^125^1585^11^^^^1
 ;;^UTILITY(U,$J,358.3,31349,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31349,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,31349,1,3,0)
 ;;=3^11624
 ;;^UTILITY(U,$J,358.3,31350,0)
 ;;=11626^^125^1585^12^^^^1
 ;;^UTILITY(U,$J,358.3,31350,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31350,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, gentalia; over 4.0cm
 ;;^UTILITY(U,$J,358.3,31350,1,3,0)
 ;;=3^11626
 ;;^UTILITY(U,$J,358.3,31351,0)
 ;;=12001^^125^1586^8^^^^1
 ;;^UTILITY(U,$J,358.3,31351,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31351,1,2,0)
 ;;=2^Simple Repair of Wnd-Scalp,Neck,Axillae,Trunk;2.5cm or less
 ;;^UTILITY(U,$J,358.3,31351,1,3,0)
 ;;=3^12001
 ;;^UTILITY(U,$J,358.3,31352,0)
 ;;=12002^^125^1586^9^^^^1
 ;;^UTILITY(U,$J,358.3,31352,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31352,1,2,0)
 ;;=2^Simple Repair of Wnd-Scalp,Neck,Axillae,Trunk;2.6cm-7.5cm
 ;;^UTILITY(U,$J,358.3,31352,1,3,0)
 ;;=3^12002
 ;;^UTILITY(U,$J,358.3,31353,0)
 ;;=12041^^125^1586^1^^^^1
 ;;^UTILITY(U,$J,358.3,31353,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31353,1,2,0)
 ;;=2^Layer Closure of Wnd-Neck,Hands,Feet,Ext Genitalia;2.5cm or less
 ;;^UTILITY(U,$J,358.3,31353,1,3,0)
 ;;=3^12041
 ;;^UTILITY(U,$J,358.3,31354,0)
 ;;=12042^^125^1586^2^^^^1
 ;;^UTILITY(U,$J,358.3,31354,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31354,1,2,0)
 ;;=2^Layer Closure of Wnd-Neck,Hands,Feet,Ext Genitalia;2.6cm-7.5cm
 ;;^UTILITY(U,$J,358.3,31354,1,3,0)
 ;;=3^12042
 ;;^UTILITY(U,$J,358.3,31355,0)
 ;;=12031^^125^1586^3^^^^1
 ;;^UTILITY(U,$J,358.3,31355,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31355,1,2,0)
 ;;=2^Layer Closure of Wnd-Scalp,Axillae,Trunk,Extrem;2.5cm or less
 ;;^UTILITY(U,$J,358.3,31355,1,3,0)
 ;;=3^12031
 ;;^UTILITY(U,$J,358.3,31356,0)
 ;;=12032^^125^1586^4^^^^1
 ;;^UTILITY(U,$J,358.3,31356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31356,1,2,0)
 ;;=2^Layer Closure of Wnd-Scalp,Axillae,Trunk,Extrem;2.6cm-7.5cm
 ;;^UTILITY(U,$J,358.3,31356,1,3,0)
 ;;=3^12032
