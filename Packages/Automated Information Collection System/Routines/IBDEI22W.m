IBDEI22W ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35244,0)
 ;;=94070^^132^1704^11^^^^1
 ;;^UTILITY(U,$J,358.3,35244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35244,1,2,0)
 ;;=2^94070
 ;;^UTILITY(U,$J,358.3,35244,1,3,0)
 ;;=3^Prolong Eval of Bronchospasm/Methacholine
 ;;^UTILITY(U,$J,358.3,35245,0)
 ;;=94200^^132^1704^9^^^^1
 ;;^UTILITY(U,$J,358.3,35245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35245,1,2,0)
 ;;=2^94200
 ;;^UTILITY(U,$J,358.3,35245,1,3,0)
 ;;=3^Max Voluntary Ventilation (included w/94010)
 ;;^UTILITY(U,$J,358.3,35246,0)
 ;;=94014^^132^1704^1^^^^1
 ;;^UTILITY(U,$J,358.3,35246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35246,1,2,0)
 ;;=2^94014
 ;;^UTILITY(U,$J,358.3,35246,1,3,0)
 ;;=3^30 day Spirometry
 ;;^UTILITY(U,$J,358.3,35247,0)
 ;;=94726^^132^1704^10^^^^1
 ;;^UTILITY(U,$J,358.3,35247,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35247,1,2,0)
 ;;=2^94726
 ;;^UTILITY(U,$J,358.3,35247,1,3,0)
 ;;=3^Plethysmography for Lung Volumes
 ;;^UTILITY(U,$J,358.3,35248,0)
 ;;=94727^^132^1704^7^^^^1
 ;;^UTILITY(U,$J,358.3,35248,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35248,1,2,0)
 ;;=2^94727
 ;;^UTILITY(U,$J,358.3,35248,1,3,0)
 ;;=3^Gas Dilution or Washout for Lung Volumes
 ;;^UTILITY(U,$J,358.3,35249,0)
 ;;=94728^^132^1704^2^^^^1
 ;;^UTILITY(U,$J,358.3,35249,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35249,1,2,0)
 ;;=2^94728
 ;;^UTILITY(U,$J,358.3,35249,1,3,0)
 ;;=3^Airway Resistance by Impulse Oscillometry
 ;;^UTILITY(U,$J,358.3,35250,0)
 ;;=94729^^132^1704^4^^^^1
 ;;^UTILITY(U,$J,358.3,35250,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35250,1,2,0)
 ;;=2^94729
 ;;^UTILITY(U,$J,358.3,35250,1,3,0)
 ;;=3^Diffusing Capacity
 ;;^UTILITY(U,$J,358.3,35251,0)
 ;;=94250^^132^1704^5^^^^1
 ;;^UTILITY(U,$J,358.3,35251,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35251,1,2,0)
 ;;=2^94250
 ;;^UTILITY(U,$J,358.3,35251,1,3,0)
 ;;=3^Expired Gas Collection
 ;;^UTILITY(U,$J,358.3,35252,0)
 ;;=94799^^132^1704^8^^^^1
 ;;^UTILITY(U,$J,358.3,35252,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35252,1,2,0)
 ;;=2^94799
 ;;^UTILITY(U,$J,358.3,35252,1,3,0)
 ;;=3^MIP/MEP's
 ;;^UTILITY(U,$J,358.3,35253,0)
 ;;=94150^^132^1704^14^^^^1
 ;;^UTILITY(U,$J,358.3,35253,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35253,1,2,0)
 ;;=2^94150
 ;;^UTILITY(U,$J,358.3,35253,1,3,0)
 ;;=3^Vital Capacity Test
 ;;^UTILITY(U,$J,358.3,35254,0)
 ;;=32400^^132^1705^2^^^^1
 ;;^UTILITY(U,$J,358.3,35254,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35254,1,2,0)
 ;;=2^32400
 ;;^UTILITY(U,$J,358.3,35254,1,3,0)
 ;;=3^Pleural Biopsy
 ;;^UTILITY(U,$J,358.3,35255,0)
 ;;=32554^^132^1705^7^^^^1
 ;;^UTILITY(U,$J,358.3,35255,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35255,1,2,0)
 ;;=2^32554
 ;;^UTILITY(U,$J,358.3,35255,1,3,0)
 ;;=3^Thoracentesis w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,35256,0)
 ;;=32555^^132^1705^6^^^^1
 ;;^UTILITY(U,$J,358.3,35256,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35256,1,2,0)
 ;;=2^32555
 ;;^UTILITY(U,$J,358.3,35256,1,3,0)
 ;;=3^Thoracentesis w/ Image Guidance
 ;;^UTILITY(U,$J,358.3,35257,0)
 ;;=32556^^132^1705^4^^^^1
 ;;^UTILITY(U,$J,358.3,35257,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35257,1,2,0)
 ;;=2^32556
 ;;^UTILITY(U,$J,358.3,35257,1,3,0)
 ;;=3^Pleural Drainage Perc w/ Cath w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,35258,0)
 ;;=32557^^132^1705^3^^^^1
 ;;^UTILITY(U,$J,358.3,35258,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35258,1,2,0)
 ;;=2^32557
 ;;^UTILITY(U,$J,358.3,35258,1,3,0)
 ;;=3^Pleural Drainage Perc w/ Cath w/ Image Guidance
 ;;^UTILITY(U,$J,358.3,35259,0)
 ;;=32551^^132^1705^1^^^^1
 ;;^UTILITY(U,$J,358.3,35259,1,0)
 ;;=^358.31IA^3^2
