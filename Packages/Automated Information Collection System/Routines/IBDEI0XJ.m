IBDEI0XJ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16308,1,3,0)
 ;;=3^Compliance Study
 ;;^UTILITY(U,$J,358.3,16309,0)
 ;;=94375^^82^962^6^^^^1
 ;;^UTILITY(U,$J,358.3,16309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16309,1,2,0)
 ;;=2^94375
 ;;^UTILITY(U,$J,358.3,16309,1,3,0)
 ;;=3^Flow Volume Loop (included w/94010)
 ;;^UTILITY(U,$J,358.3,16310,0)
 ;;=94070^^82^962^11^^^^1
 ;;^UTILITY(U,$J,358.3,16310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16310,1,2,0)
 ;;=2^94070
 ;;^UTILITY(U,$J,358.3,16310,1,3,0)
 ;;=3^Prolong Eval of Bronchospasm/Methacholine
 ;;^UTILITY(U,$J,358.3,16311,0)
 ;;=94200^^82^962^9^^^^1
 ;;^UTILITY(U,$J,358.3,16311,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16311,1,2,0)
 ;;=2^94200
 ;;^UTILITY(U,$J,358.3,16311,1,3,0)
 ;;=3^Max Voluntary Ventilation (included w/94010)
 ;;^UTILITY(U,$J,358.3,16312,0)
 ;;=94014^^82^962^1^^^^1
 ;;^UTILITY(U,$J,358.3,16312,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16312,1,2,0)
 ;;=2^94014
 ;;^UTILITY(U,$J,358.3,16312,1,3,0)
 ;;=3^30 day Spirometry
 ;;^UTILITY(U,$J,358.3,16313,0)
 ;;=94726^^82^962^10^^^^1
 ;;^UTILITY(U,$J,358.3,16313,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16313,1,2,0)
 ;;=2^94726
 ;;^UTILITY(U,$J,358.3,16313,1,3,0)
 ;;=3^Plethysmography for Lung Volumes
 ;;^UTILITY(U,$J,358.3,16314,0)
 ;;=94727^^82^962^7^^^^1
 ;;^UTILITY(U,$J,358.3,16314,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16314,1,2,0)
 ;;=2^94727
 ;;^UTILITY(U,$J,358.3,16314,1,3,0)
 ;;=3^Gas Dilution or Washout for Lung Volumes
 ;;^UTILITY(U,$J,358.3,16315,0)
 ;;=94728^^82^962^2^^^^1
 ;;^UTILITY(U,$J,358.3,16315,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16315,1,2,0)
 ;;=2^94728
 ;;^UTILITY(U,$J,358.3,16315,1,3,0)
 ;;=3^Airway Resistance by Impulse Oscillometry
 ;;^UTILITY(U,$J,358.3,16316,0)
 ;;=94729^^82^962^4^^^^1
 ;;^UTILITY(U,$J,358.3,16316,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16316,1,2,0)
 ;;=2^94729
 ;;^UTILITY(U,$J,358.3,16316,1,3,0)
 ;;=3^Diffusing Capacity
 ;;^UTILITY(U,$J,358.3,16317,0)
 ;;=94250^^82^962^5^^^^1
 ;;^UTILITY(U,$J,358.3,16317,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16317,1,2,0)
 ;;=2^94250
 ;;^UTILITY(U,$J,358.3,16317,1,3,0)
 ;;=3^Expired Gas Collection
 ;;^UTILITY(U,$J,358.3,16318,0)
 ;;=94799^^82^962^8^^^^1
 ;;^UTILITY(U,$J,358.3,16318,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16318,1,2,0)
 ;;=2^94799
 ;;^UTILITY(U,$J,358.3,16318,1,3,0)
 ;;=3^MIP/MEP's
 ;;^UTILITY(U,$J,358.3,16319,0)
 ;;=94150^^82^962^14^^^^1
 ;;^UTILITY(U,$J,358.3,16319,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16319,1,2,0)
 ;;=2^94150
 ;;^UTILITY(U,$J,358.3,16319,1,3,0)
 ;;=3^Vital Capacity Test
 ;;^UTILITY(U,$J,358.3,16320,0)
 ;;=32400^^82^963^2^^^^1
 ;;^UTILITY(U,$J,358.3,16320,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16320,1,2,0)
 ;;=2^32400
 ;;^UTILITY(U,$J,358.3,16320,1,3,0)
 ;;=3^Pleural Biopsy
 ;;^UTILITY(U,$J,358.3,16321,0)
 ;;=32554^^82^963^7^^^^1
 ;;^UTILITY(U,$J,358.3,16321,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16321,1,2,0)
 ;;=2^32554
 ;;^UTILITY(U,$J,358.3,16321,1,3,0)
 ;;=3^Thoracentesis w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,16322,0)
 ;;=32555^^82^963^6^^^^1
 ;;^UTILITY(U,$J,358.3,16322,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16322,1,2,0)
 ;;=2^32555
 ;;^UTILITY(U,$J,358.3,16322,1,3,0)
 ;;=3^Thoracentesis w/ Image Guidance
 ;;^UTILITY(U,$J,358.3,16323,0)
 ;;=32556^^82^963^4^^^^1
 ;;^UTILITY(U,$J,358.3,16323,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16323,1,2,0)
 ;;=2^32556
 ;;^UTILITY(U,$J,358.3,16323,1,3,0)
 ;;=3^Pleural Drainage Perc w/ Cath w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,16324,0)
 ;;=32557^^82^963^3^^^^1
