IBDEI14O ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18300,1,2,0)
 ;;=2^94200
 ;;^UTILITY(U,$J,358.3,18300,1,3,0)
 ;;=3^Max Voluntary Ventilation (included w/94010)
 ;;^UTILITY(U,$J,358.3,18301,0)
 ;;=94014^^62^814^1^^^^1
 ;;^UTILITY(U,$J,358.3,18301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18301,1,2,0)
 ;;=2^94014
 ;;^UTILITY(U,$J,358.3,18301,1,3,0)
 ;;=3^30 day Spirometry
 ;;^UTILITY(U,$J,358.3,18302,0)
 ;;=94726^^62^814^8^^^^1
 ;;^UTILITY(U,$J,358.3,18302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18302,1,2,0)
 ;;=2^94726
 ;;^UTILITY(U,$J,358.3,18302,1,3,0)
 ;;=3^Plethysmography for Lung Volumes
 ;;^UTILITY(U,$J,358.3,18303,0)
 ;;=94727^^62^814^5^^^^1
 ;;^UTILITY(U,$J,358.3,18303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18303,1,2,0)
 ;;=2^94727
 ;;^UTILITY(U,$J,358.3,18303,1,3,0)
 ;;=3^Gas Dilution or Washout for Lung Volumes
 ;;^UTILITY(U,$J,358.3,18304,0)
 ;;=94728^^62^814^2^^^^1
 ;;^UTILITY(U,$J,358.3,18304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18304,1,2,0)
 ;;=2^94728
 ;;^UTILITY(U,$J,358.3,18304,1,3,0)
 ;;=3^Airway Resistance by Impulse Oscillometry
 ;;^UTILITY(U,$J,358.3,18305,0)
 ;;=94729^^62^814^3^^^^1
 ;;^UTILITY(U,$J,358.3,18305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18305,1,2,0)
 ;;=2^94729
 ;;^UTILITY(U,$J,358.3,18305,1,3,0)
 ;;=3^Diffusing Capacity
 ;;^UTILITY(U,$J,358.3,18306,0)
 ;;=94799^^62^814^6^^^^1
 ;;^UTILITY(U,$J,358.3,18306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18306,1,2,0)
 ;;=2^94799
 ;;^UTILITY(U,$J,358.3,18306,1,3,0)
 ;;=3^MIP/MEP's
 ;;^UTILITY(U,$J,358.3,18307,0)
 ;;=94150^^62^814^12^^^^1
 ;;^UTILITY(U,$J,358.3,18307,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18307,1,2,0)
 ;;=2^94150
 ;;^UTILITY(U,$J,358.3,18307,1,3,0)
 ;;=3^Vital Capacity Test
 ;;^UTILITY(U,$J,358.3,18308,0)
 ;;=32400^^62^815^2^^^^1
 ;;^UTILITY(U,$J,358.3,18308,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18308,1,2,0)
 ;;=2^32400
 ;;^UTILITY(U,$J,358.3,18308,1,3,0)
 ;;=3^Pleural Biopsy
 ;;^UTILITY(U,$J,358.3,18309,0)
 ;;=32554^^62^815^7^^^^1
 ;;^UTILITY(U,$J,358.3,18309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18309,1,2,0)
 ;;=2^32554
 ;;^UTILITY(U,$J,358.3,18309,1,3,0)
 ;;=3^Thoracentesis w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,18310,0)
 ;;=32555^^62^815^6^^^^1
 ;;^UTILITY(U,$J,358.3,18310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18310,1,2,0)
 ;;=2^32555
 ;;^UTILITY(U,$J,358.3,18310,1,3,0)
 ;;=3^Thoracentesis w/ Image Guidance
 ;;^UTILITY(U,$J,358.3,18311,0)
 ;;=32556^^62^815^4^^^^1
 ;;^UTILITY(U,$J,358.3,18311,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18311,1,2,0)
 ;;=2^32556
 ;;^UTILITY(U,$J,358.3,18311,1,3,0)
 ;;=3^Pleural Drainage Perc w/ Cath w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,18312,0)
 ;;=32557^^62^815^3^^^^1
 ;;^UTILITY(U,$J,358.3,18312,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18312,1,2,0)
 ;;=2^32557
 ;;^UTILITY(U,$J,358.3,18312,1,3,0)
 ;;=3^Pleural Drainage Perc w/ Cath w/ Image Guidance
 ;;^UTILITY(U,$J,358.3,18313,0)
 ;;=32551^^62^815^1^^^^1
 ;;^UTILITY(U,$J,358.3,18313,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18313,1,2,0)
 ;;=2^32551
 ;;^UTILITY(U,$J,358.3,18313,1,3,0)
 ;;=3^Insert Chest Tube w/ Water Seal
 ;;^UTILITY(U,$J,358.3,18314,0)
 ;;=32552^^62^815^5^^^^1
 ;;^UTILITY(U,$J,358.3,18314,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18314,1,2,0)
 ;;=2^32552
 ;;^UTILITY(U,$J,358.3,18314,1,3,0)
 ;;=3^Remove Chest Tube
