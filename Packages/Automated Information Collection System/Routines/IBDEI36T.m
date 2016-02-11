IBDEI36T ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53522,0)
 ;;=21555^^248^2692^4^^^^1
 ;;^UTILITY(U,$J,358.3,53522,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53522,1,2,0)
 ;;=2^21555
 ;;^UTILITY(U,$J,358.3,53522,1,3,0)
 ;;=3^Exc Tumor,Neck/Thorax,SQ < 3cm
 ;;^UTILITY(U,$J,358.3,53523,0)
 ;;=21556^^248^2692^5^^^^1
 ;;^UTILITY(U,$J,358.3,53523,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53523,1,2,0)
 ;;=2^21556
 ;;^UTILITY(U,$J,358.3,53523,1,3,0)
 ;;=3^Exc Tumor,Neck/Thorax;Deep < 5cm
 ;;^UTILITY(U,$J,358.3,53524,0)
 ;;=21600^^248^2692^8^^^^1
 ;;^UTILITY(U,$J,358.3,53524,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53524,1,2,0)
 ;;=2^21600
 ;;^UTILITY(U,$J,358.3,53524,1,3,0)
 ;;=3^Excision of Rib,Partial
 ;;^UTILITY(U,$J,358.3,53525,0)
 ;;=21825^^248^2692^10^^^^1
 ;;^UTILITY(U,$J,358.3,53525,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53525,1,2,0)
 ;;=2^21825
 ;;^UTILITY(U,$J,358.3,53525,1,3,0)
 ;;=3^Open Tx Sternum Fx w/ or w/o Fixation
 ;;^UTILITY(U,$J,358.3,53526,0)
 ;;=21557^^248^2692^13^^^^1
 ;;^UTILITY(U,$J,358.3,53526,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53526,1,2,0)
 ;;=2^21557
 ;;^UTILITY(U,$J,358.3,53526,1,3,0)
 ;;=3^Radical Resection of Tumor,Neck/Thorax
 ;;^UTILITY(U,$J,358.3,53527,0)
 ;;=21630^^248^2692^12^^^^1
 ;;^UTILITY(U,$J,358.3,53527,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53527,1,2,0)
 ;;=2^21630
 ;;^UTILITY(U,$J,358.3,53527,1,3,0)
 ;;=3^Radical Resection of Sternum
 ;;^UTILITY(U,$J,358.3,53528,0)
 ;;=21632^^248^2692^11^^^^1
 ;;^UTILITY(U,$J,358.3,53528,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53528,1,2,0)
 ;;=2^21632
 ;;^UTILITY(U,$J,358.3,53528,1,3,0)
 ;;=3^Radical Resection Sternum w/Media Lymphadenectomy
 ;;^UTILITY(U,$J,358.3,53529,0)
 ;;=21740^^248^2692^16^^^^1
 ;;^UTILITY(U,$J,358.3,53529,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53529,1,2,0)
 ;;=2^21740
 ;;^UTILITY(U,$J,358.3,53529,1,3,0)
 ;;=3^Recons Repair Pectus Excavatum/Carinatum;Open
 ;;^UTILITY(U,$J,358.3,53530,0)
 ;;=21742^^248^2692^15^^^^1
 ;;^UTILITY(U,$J,358.3,53530,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53530,1,2,0)
 ;;=2^21742
 ;;^UTILITY(U,$J,358.3,53530,1,3,0)
 ;;=3^Recons Rep Pectus,Nuss Proc w/o Thoracoscopy
 ;;^UTILITY(U,$J,358.3,53531,0)
 ;;=21743^^248^2692^14^^^^1
 ;;^UTILITY(U,$J,358.3,53531,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53531,1,2,0)
 ;;=2^21743
 ;;^UTILITY(U,$J,358.3,53531,1,3,0)
 ;;=3^Recons Rep Pectus,Nuss Proc w/Thoracoscopy
 ;;^UTILITY(U,$J,358.3,53532,0)
 ;;=21550^^248^2692^1^^^^1
 ;;^UTILITY(U,$J,358.3,53532,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53532,1,2,0)
 ;;=2^21550
 ;;^UTILITY(U,$J,358.3,53532,1,3,0)
 ;;=3^Biopsy Soft Tissue Neck, Thorax
 ;;^UTILITY(U,$J,358.3,53533,0)
 ;;=21552^^248^2692^3^^^^1
 ;;^UTILITY(U,$J,358.3,53533,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53533,1,2,0)
 ;;=2^21552
 ;;^UTILITY(U,$J,358.3,53533,1,3,0)
 ;;=3^Exc Tumor, Neck/Thorax, SQ >3cm
 ;;^UTILITY(U,$J,358.3,53534,0)
 ;;=22010^^248^2692^9^^^^1
 ;;^UTILITY(U,$J,358.3,53534,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53534,1,2,0)
 ;;=2^22010
 ;;^UTILITY(U,$J,358.3,53534,1,3,0)
 ;;=3^I & D Open,Deep Abscess Posteria Spine
 ;;^UTILITY(U,$J,358.3,53535,0)
 ;;=19272^^248^2692^2^^^^1
 ;;^UTILITY(U,$J,358.3,53535,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53535,1,2,0)
 ;;=2^19272
 ;;^UTILITY(U,$J,358.3,53535,1,3,0)
 ;;=3^Exc Chest Wall Tumor w/Mediastinal Lymphadenectomy
 ;;^UTILITY(U,$J,358.3,53536,0)
 ;;=32096^^248^2693^21^^^^1
 ;;^UTILITY(U,$J,358.3,53536,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53536,1,2,0)
 ;;=2^32096
 ;;^UTILITY(U,$J,358.3,53536,1,3,0)
 ;;=3^Thoracotomy incl Diag Biopsy Lung Infiltr Unilat
