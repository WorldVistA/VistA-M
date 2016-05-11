IBDEI0Q0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12166,1,3,0)
 ;;=3^Transendoscopic Stent Placement
 ;;^UTILITY(U,$J,358.3,12167,0)
 ;;=43212^^49^546^32^^^^1
 ;;^UTILITY(U,$J,358.3,12167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12167,1,2,0)
 ;;=2^43212
 ;;^UTILITY(U,$J,358.3,12167,1,3,0)
 ;;=3^Esophagoscopy w/ Insert Plastic Tube/Stent
 ;;^UTILITY(U,$J,358.3,12168,0)
 ;;=43270^^49^546^1^^^^1
 ;;^UTILITY(U,$J,358.3,12168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12168,1,2,0)
 ;;=2^43270
 ;;^UTILITY(U,$J,358.3,12168,1,3,0)
 ;;=3^EGD w/Ablation Tumor/Polyp
 ;;^UTILITY(U,$J,358.3,12169,0)
 ;;=43211^^49^546^34^^^^1
 ;;^UTILITY(U,$J,358.3,12169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12169,1,2,0)
 ;;=2^43211
 ;;^UTILITY(U,$J,358.3,12169,1,3,0)
 ;;=3^Esophagoscopy w/ Muscosal Resection
 ;;^UTILITY(U,$J,358.3,12170,0)
 ;;=43206^^49^546^35^^^^1
 ;;^UTILITY(U,$J,358.3,12170,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12170,1,2,0)
 ;;=2^43206
 ;;^UTILITY(U,$J,358.3,12170,1,3,0)
 ;;=3^Esophagoscopy w/ Optical Endomicroscopy
 ;;^UTILITY(U,$J,358.3,12171,0)
 ;;=44360^^49^547^2^^^^1
 ;;^UTILITY(U,$J,358.3,12171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12171,1,2,0)
 ;;=2^44360
 ;;^UTILITY(U,$J,358.3,12171,1,3,0)
 ;;=3^Sm Intestine Endoscopy Diagnostic
 ;;^UTILITY(U,$J,358.3,12172,0)
 ;;=44361^^49^547^1^^^^1
 ;;^UTILITY(U,$J,358.3,12172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12172,1,2,0)
 ;;=2^44361
 ;;^UTILITY(U,$J,358.3,12172,1,3,0)
 ;;=3^Sm Intentine Endoscopy w/Biopsy
 ;;^UTILITY(U,$J,358.3,12173,0)
 ;;=44365^^49^547^6^^^^1
 ;;^UTILITY(U,$J,358.3,12173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12173,1,2,0)
 ;;=2^44365
 ;;^UTILITY(U,$J,358.3,12173,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Hot cautery tumor removal
 ;;^UTILITY(U,$J,358.3,12174,0)
 ;;=44364^^49^547^9^^^^1
 ;;^UTILITY(U,$J,358.3,12174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12174,1,2,0)
 ;;=2^44364
 ;;^UTILITY(U,$J,358.3,12174,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Snare Tumor Removal
 ;;^UTILITY(U,$J,358.3,12175,0)
 ;;=44363^^49^547^5^^^^1
 ;;^UTILITY(U,$J,358.3,12175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12175,1,2,0)
 ;;=2^44363
 ;;^UTILITY(U,$J,358.3,12175,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/FB Removal
 ;;^UTILITY(U,$J,358.3,12176,0)
 ;;=44369^^49^547^3^^^^1
 ;;^UTILITY(U,$J,358.3,12176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12176,1,2,0)
 ;;=2^44369
 ;;^UTILITY(U,$J,358.3,12176,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Ablation of Tumor
 ;;^UTILITY(U,$J,358.3,12177,0)
 ;;=44366^^49^547^4^^^^1
 ;;^UTILITY(U,$J,358.3,12177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12177,1,2,0)
 ;;=2^44366
 ;;^UTILITY(U,$J,358.3,12177,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Control of Hemorrhage
 ;;^UTILITY(U,$J,358.3,12178,0)
 ;;=44370^^49^547^10^^^^1
 ;;^UTILITY(U,$J,358.3,12178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12178,1,2,0)
 ;;=2^44370
 ;;^UTILITY(U,$J,358.3,12178,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Stent Placement
 ;;^UTILITY(U,$J,358.3,12179,0)
 ;;=44372^^49^547^8^^^^1
 ;;^UTILITY(U,$J,358.3,12179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12179,1,2,0)
 ;;=2^44372
 ;;^UTILITY(U,$J,358.3,12179,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/J-Tube Placement
 ;;^UTILITY(U,$J,358.3,12180,0)
 ;;=44373^^49^547^7^^^^1
 ;;^UTILITY(U,$J,358.3,12180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12180,1,2,0)
 ;;=2^44373
 ;;^UTILITY(U,$J,358.3,12180,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/J-Tube Conversion
 ;;^UTILITY(U,$J,358.3,12181,0)
 ;;=46600^^49^548^11^^^^1
 ;;^UTILITY(U,$J,358.3,12181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12181,1,2,0)
 ;;=2^46600
