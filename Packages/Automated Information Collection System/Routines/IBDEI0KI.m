IBDEI0KI ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10010,1,2,0)
 ;;=2^43233
 ;;^UTILITY(U,$J,358.3,10010,1,3,0)
 ;;=3^EGD w/Esoph Dilation by Balloon >30mm
 ;;^UTILITY(U,$J,358.3,10011,0)
 ;;=43214^^59^651^31^^^^1
 ;;^UTILITY(U,$J,358.3,10011,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10011,1,2,0)
 ;;=2^43214
 ;;^UTILITY(U,$J,358.3,10011,1,3,0)
 ;;=3^Esophagoscopy w/Balloon Dilation >+30mm
 ;;^UTILITY(U,$J,358.3,10012,0)
 ;;=43229^^59^651^29^^^^1
 ;;^UTILITY(U,$J,358.3,10012,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10012,1,2,0)
 ;;=2^43229
 ;;^UTILITY(U,$J,358.3,10012,1,3,0)
 ;;=3^Esophagoscopy w/Ablation Tumor
 ;;^UTILITY(U,$J,358.3,10013,0)
 ;;=43266^^59^651^42^^^^1
 ;;^UTILITY(U,$J,358.3,10013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10013,1,2,0)
 ;;=2^43266
 ;;^UTILITY(U,$J,358.3,10013,1,3,0)
 ;;=3^Transendoscopic Stent Placement
 ;;^UTILITY(U,$J,358.3,10014,0)
 ;;=43212^^59^651^26^^^^1
 ;;^UTILITY(U,$J,358.3,10014,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10014,1,2,0)
 ;;=2^43212
 ;;^UTILITY(U,$J,358.3,10014,1,3,0)
 ;;=3^Esophag w/Insert Plastic Tube/Stent
 ;;^UTILITY(U,$J,358.3,10015,0)
 ;;=43270^^59^651^1^^^^1
 ;;^UTILITY(U,$J,358.3,10015,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10015,1,2,0)
 ;;=2^43270
 ;;^UTILITY(U,$J,358.3,10015,1,3,0)
 ;;=3^EGD w/Ablation Tumor/Polyp
 ;;^UTILITY(U,$J,358.3,10016,0)
 ;;=43211^^59^651^28^^^^1
 ;;^UTILITY(U,$J,358.3,10016,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10016,1,2,0)
 ;;=2^43211
 ;;^UTILITY(U,$J,358.3,10016,1,3,0)
 ;;=3^Esophagoscopy w/ Muscosal Resection
 ;;^UTILITY(U,$J,358.3,10017,0)
 ;;=43206^^59^651^24^^^^1
 ;;^UTILITY(U,$J,358.3,10017,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10017,1,2,0)
 ;;=2^43206
 ;;^UTILITY(U,$J,358.3,10017,1,3,0)
 ;;=3^Esoph Optical Endomicroscopy
 ;;^UTILITY(U,$J,358.3,10018,0)
 ;;=44360^^59^652^5^^^^1
 ;;^UTILITY(U,$J,358.3,10018,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10018,1,2,0)
 ;;=2^44360
 ;;^UTILITY(U,$J,358.3,10018,1,3,0)
 ;;=3^Sm Intestine Endoscopy Diagnostic
 ;;^UTILITY(U,$J,358.3,10019,0)
 ;;=44361^^59^652^1^^^^1
 ;;^UTILITY(U,$J,358.3,10019,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10019,1,2,0)
 ;;=2^44361
 ;;^UTILITY(U,$J,358.3,10019,1,3,0)
 ;;=3^Sm Intentine Endoscopy w/Biopsy
 ;;^UTILITY(U,$J,358.3,10020,0)
 ;;=44365^^59^652^9^^^^1
 ;;^UTILITY(U,$J,358.3,10020,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10020,1,2,0)
 ;;=2^44365
 ;;^UTILITY(U,$J,358.3,10020,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Hot cautery tumor removal
 ;;^UTILITY(U,$J,358.3,10021,0)
 ;;=44364^^59^652^10^^^^1
 ;;^UTILITY(U,$J,358.3,10021,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10021,1,2,0)
 ;;=2^44364
 ;;^UTILITY(U,$J,358.3,10021,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Snare Tumor Removal
 ;;^UTILITY(U,$J,358.3,10022,0)
 ;;=44363^^59^652^8^^^^1
 ;;^UTILITY(U,$J,358.3,10022,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10022,1,2,0)
 ;;=2^44363
 ;;^UTILITY(U,$J,358.3,10022,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/FB Removal
 ;;^UTILITY(U,$J,358.3,10023,0)
 ;;=44369^^59^652^6^^^^1
 ;;^UTILITY(U,$J,358.3,10023,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10023,1,2,0)
 ;;=2^44369
 ;;^UTILITY(U,$J,358.3,10023,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Ablation of Tumor
 ;;^UTILITY(U,$J,358.3,10024,0)
 ;;=44366^^59^652^7^^^^1
 ;;^UTILITY(U,$J,358.3,10024,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10024,1,2,0)
 ;;=2^44366
 ;;^UTILITY(U,$J,358.3,10024,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Control of Hemorrhage
 ;;^UTILITY(U,$J,358.3,10025,0)
 ;;=44370^^59^652^4^^^^1
 ;;^UTILITY(U,$J,358.3,10025,1,0)
 ;;=^358.31IA^3^2
