IBDEI0GX ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22798,0)
 ;;=22010^^180^1533^9^^^^1
 ;;^UTILITY(U,$J,358.3,22798,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22798,1,2,0)
 ;;=2^22010
 ;;^UTILITY(U,$J,358.3,22798,1,3,0)
 ;;=3^Incis and Drainage,Open, Deep Abscess Thoracic
 ;;^UTILITY(U,$J,358.3,22799,0)
 ;;=19272^^180^1533^2^^^^1
 ;;^UTILITY(U,$J,358.3,22799,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22799,1,2,0)
 ;;=2^19272
 ;;^UTILITY(U,$J,358.3,22799,1,3,0)
 ;;=3^Exc Chest Wall Tumor w/Mediastinal Lymphadenectomy
 ;;^UTILITY(U,$J,358.3,22800,0)
 ;;=32096^^180^1534^21^^^^1
 ;;^UTILITY(U,$J,358.3,22800,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22800,1,2,0)
 ;;=2^32096
 ;;^UTILITY(U,$J,358.3,22800,1,3,0)
 ;;=3^Thoracotomy incl Diag Biopsy Lung Infiltr Unilat
 ;;^UTILITY(U,$J,358.3,22801,0)
 ;;=32097^^180^1534^22^^^^1
 ;;^UTILITY(U,$J,358.3,22801,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22801,1,2,0)
 ;;=2^32097
 ;;^UTILITY(U,$J,358.3,22801,1,3,0)
 ;;=3^Thoracotomy incl Diag Biopsy Lung Nodule Unilat
 ;;^UTILITY(U,$J,358.3,22802,0)
 ;;=32098^^180^1534^23^^^^1
 ;;^UTILITY(U,$J,358.3,22802,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22802,1,2,0)
 ;;=2^32098
 ;;^UTILITY(U,$J,358.3,22802,1,3,0)
 ;;=3^Thoracotomy incl Diag Biopsy of Pleura
 ;;^UTILITY(U,$J,358.3,22803,0)
 ;;=32505^^180^1534^24^^^^1
 ;;^UTILITY(U,$J,358.3,22803,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22803,1,2,0)
 ;;=2^32505
 ;;^UTILITY(U,$J,358.3,22803,1,3,0)
 ;;=3^Thoracotomy incl Wedge Resection,Init
 ;;^UTILITY(U,$J,358.3,22804,0)
 ;;=32506^^180^1534^29^^^^1
 ;;^UTILITY(U,$J,358.3,22804,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22804,1,2,0)
 ;;=2^32506
 ;;^UTILITY(U,$J,358.3,22804,1,3,0)
 ;;=3^Wedge Resect,ea addl Resection,Ipsilateral
 ;;^UTILITY(U,$J,358.3,22805,0)
 ;;=32507^^180^1534^28^^^^1
 ;;^UTILITY(U,$J,358.3,22805,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22805,1,2,0)
 ;;=2^32507
 ;;^UTILITY(U,$J,358.3,22805,1,3,0)
 ;;=3^Wedge Resect w/Anatomic Lung Resect
 ;;^UTILITY(U,$J,358.3,22806,0)
 ;;=32601^^180^1534^12^^^^1
 ;;^UTILITY(U,$J,358.3,22806,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22806,1,2,0)
 ;;=2^32601
 ;;^UTILITY(U,$J,358.3,22806,1,3,0)
 ;;=3^Thoracoscopy w/Diag Bx of Lung Infilt Unilat
 ;;^UTILITY(U,$J,358.3,22807,0)
 ;;=32608^^180^1534^11^^^^1
 ;;^UTILITY(U,$J,358.3,22807,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22807,1,2,0)
 ;;=2^32608
 ;;^UTILITY(U,$J,358.3,22807,1,3,0)
 ;;=3^Thoracoscopy w/BX Lung Nodule Unilat
 ;;^UTILITY(U,$J,358.3,22808,0)
 ;;=32609^^180^1534^26^^^^1
 ;;^UTILITY(U,$J,358.3,22808,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22808,1,2,0)
 ;;=2^32609
 ;;^UTILITY(U,$J,358.3,22808,1,3,0)
 ;;=3^Throacoscopy w/BX Pleura
 ;;^UTILITY(U,$J,358.3,22809,0)
 ;;=32650^^180^1534^15^^^^1
 ;;^UTILITY(U,$J,358.3,22809,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22809,1,2,0)
 ;;=2^32650
 ;;^UTILITY(U,$J,358.3,22809,1,3,0)
 ;;=3^Thoracoscopy w/Pleurodesis
 ;;^UTILITY(U,$J,358.3,22810,0)
 ;;=32651^^180^1534^14^^^^1
 ;;^UTILITY(U,$J,358.3,22810,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22810,1,2,0)
 ;;=2^32651
 ;;^UTILITY(U,$J,358.3,22810,1,3,0)
 ;;=3^Thoracoscopy w/Partial Pulm Decortication
 ;;^UTILITY(U,$J,358.3,22811,0)
 ;;=32652^^180^1534^25^^^^1
 ;;^UTILITY(U,$J,358.3,22811,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22811,1,2,0)
 ;;=2^32652
 ;;^UTILITY(U,$J,358.3,22811,1,3,0)
 ;;=3^Thorascoscopy w/Total Pulm Decortication
 ;;^UTILITY(U,$J,358.3,22812,0)
 ;;=32666^^180^1534^20^^^^1
 ;;^UTILITY(U,$J,358.3,22812,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22812,1,2,0)
 ;;=2^32666
 ;;^UTILITY(U,$J,358.3,22812,1,3,0)
 ;;=3^Thoracoscopy w/Wedge Resection,Init
 ;;^UTILITY(U,$J,358.3,22813,0)
 ;;=32667^^180^1534^19^^^^1
 ;;^UTILITY(U,$J,358.3,22813,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22813,1,2,0)
 ;;=2^32667
 ;;^UTILITY(U,$J,358.3,22813,1,3,0)
 ;;=3^Thoracoscopy w/Wedge Resect,Ea Addl Resect
 ;;^UTILITY(U,$J,358.3,22814,0)
 ;;=32668^^180^1534^18^^^^1
 ;;^UTILITY(U,$J,358.3,22814,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22814,1,2,0)
 ;;=2^32668
 ;;^UTILITY(U,$J,358.3,22814,1,3,0)
 ;;=3^Thoracoscopy w/Wedge Resect w/Anatomic Lung Resect
 ;;^UTILITY(U,$J,358.3,22815,0)
 ;;=32669^^180^1534^16^^^^1
 ;;^UTILITY(U,$J,358.3,22815,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22815,1,2,0)
 ;;=2^32669
 ;;^UTILITY(U,$J,358.3,22815,1,3,0)
 ;;=3^Thoracoscopy w/Reml Single Lung Section
 ;;^UTILITY(U,$J,358.3,22816,0)
 ;;=32670^^180^1534^6^^^^1
 ;;^UTILITY(U,$J,358.3,22816,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22816,1,2,0)
 ;;=2^32670
 ;;^UTILITY(U,$J,358.3,22816,1,3,0)
 ;;=3^Thoracoscopy Bilobectomy
 ;;^UTILITY(U,$J,358.3,22817,0)
 ;;=32671^^180^1534^7^^^^1
 ;;^UTILITY(U,$J,358.3,22817,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22817,1,2,0)
 ;;=2^32671
 ;;^UTILITY(U,$J,358.3,22817,1,3,0)
 ;;=3^Thoracoscopy Pneumonectomy
 ;;^UTILITY(U,$J,358.3,22818,0)
 ;;=32672^^180^1534^8^^^^1
 ;;^UTILITY(U,$J,358.3,22818,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22818,1,2,0)
 ;;=2^32672
 ;;^UTILITY(U,$J,358.3,22818,1,3,0)
 ;;=3^Thoracoscopy for LVRS
 ;;^UTILITY(U,$J,358.3,22819,0)
 ;;=32673^^180^1534^17^^^^1
 ;;^UTILITY(U,$J,358.3,22819,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22819,1,2,0)
 ;;=2^32673
 ;;^UTILITY(U,$J,358.3,22819,1,3,0)
 ;;=3^Thoracoscopy w/Thymus Resect
 ;;^UTILITY(U,$J,358.3,22820,0)
 ;;=32674^^180^1534^13^^^^1
 ;;^UTILITY(U,$J,358.3,22820,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22820,1,2,0)
 ;;=2^32674
 ;;^UTILITY(U,$J,358.3,22820,1,3,0)
 ;;=3^Thoracoscopy w/Mediastinal/Lymphadenectomy
 ;;^UTILITY(U,$J,358.3,22821,0)
 ;;=32551^^180^1534^27^^^^1
 ;;^UTILITY(U,$J,358.3,22821,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22821,1,2,0)
 ;;=2^32551
 ;;^UTILITY(U,$J,358.3,22821,1,3,0)
 ;;=3^Tube Thoracostomy
 ;;^UTILITY(U,$J,358.3,22822,0)
 ;;=32554^^180^1534^5^^^^1
 ;;^UTILITY(U,$J,358.3,22822,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22822,1,2,0)
 ;;=2^32554
 ;;^UTILITY(U,$J,358.3,22822,1,3,0)
 ;;=3^Thoracentesis w/o Imaging
 ;;^UTILITY(U,$J,358.3,22823,0)
 ;;=32555^^180^1534^4^^^^1
 ;;^UTILITY(U,$J,358.3,22823,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22823,1,2,0)
 ;;=2^32555
 ;;^UTILITY(U,$J,358.3,22823,1,3,0)
 ;;=3^Thoracentesis w/ Imaging
 ;;^UTILITY(U,$J,358.3,22824,0)
 ;;=32556^^180^1534^2^^^^1
 ;;^UTILITY(U,$J,358.3,22824,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22824,1,2,0)
 ;;=2^32556
 ;;^UTILITY(U,$J,358.3,22824,1,3,0)
 ;;=3^Insert Cath Pleura w/o Image
 ;;^UTILITY(U,$J,358.3,22825,0)
 ;;=32557^^180^1534^1^^^^1
 ;;^UTILITY(U,$J,358.3,22825,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22825,1,2,0)
 ;;=2^32557
 ;;^UTILITY(U,$J,358.3,22825,1,3,0)
 ;;=3^Insert Cath Pleura w/ Image
 ;;^UTILITY(U,$J,358.3,22826,0)
 ;;=32561^^180^1534^3^^^^1
 ;;^UTILITY(U,$J,358.3,22826,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22826,1,2,0)
 ;;=2^32561
 ;;^UTILITY(U,$J,358.3,22826,1,3,0)
 ;;=3^Instillation via Chest Tube,Fibrin;Init Day
 ;;^UTILITY(U,$J,358.3,22827,0)
 ;;=32669^^180^1534^9^^^^1
 ;;^UTILITY(U,$J,358.3,22827,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22827,1,2,0)
 ;;=2^32669
 ;;^UTILITY(U,$J,358.3,22827,1,3,0)
 ;;=3^Thoracoscopy w/ Reml Lung Section
 ;;^UTILITY(U,$J,358.3,22828,0)
 ;;=32673^^180^1534^10^^^^1
 ;;^UTILITY(U,$J,358.3,22828,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22828,1,2,0)
 ;;=2^32673
 ;;^UTILITY(U,$J,358.3,22828,1,3,0)
 ;;=3^Thoracoscopy w/ Thymus Resect
 ;;^UTILITY(U,$J,358.3,22829,0)
 ;;=32997^^180^1535^1^^^^1
 ;;^UTILITY(U,$J,358.3,22829,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22829,1,2,0)
 ;;=2^32997
 ;;^UTILITY(U,$J,358.3,22829,1,3,0)
 ;;=3^Total Lung Lavage
 ;;^UTILITY(U,$J,358.3,22830,0)
 ;;=99201^^181^1536^1
 ;;^UTILITY(U,$J,358.3,22830,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22830,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,22830,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,22831,0)
 ;;=99202^^181^1536^2
 ;;^UTILITY(U,$J,358.3,22831,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22831,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,22831,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,22832,0)
 ;;=99203^^181^1536^3
 ;;^UTILITY(U,$J,358.3,22832,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22832,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,22832,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,22833,0)
 ;;=99204^^181^1536^4
 ;;^UTILITY(U,$J,358.3,22833,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22833,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,22833,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,22834,0)
 ;;=99205^^181^1536^5
 ;;^UTILITY(U,$J,358.3,22834,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22834,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,22834,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,22835,0)
 ;;=99211^^181^1537^1
 ;;^UTILITY(U,$J,358.3,22835,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22835,1,1,0)
 ;;=1^Brief (no MD seen)
 ;;^UTILITY(U,$J,358.3,22835,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,22836,0)
 ;;=99212^^181^1537^2
 ;;^UTILITY(U,$J,358.3,22836,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22836,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,22836,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,22837,0)
 ;;=99213^^181^1537^3
 ;;^UTILITY(U,$J,358.3,22837,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22837,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,22837,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,22838,0)
 ;;=99214^^181^1537^4
 ;;^UTILITY(U,$J,358.3,22838,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22838,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,22838,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,22839,0)
 ;;=99215^^181^1537^5
 ;;^UTILITY(U,$J,358.3,22839,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,22839,1,1,0)
 ;;=1^Comprehensive
 ;;^UTILITY(U,$J,358.3,22839,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,22840,0)
 ;;=99241^^181^1538^1
 ;;^UTILITY(U,$J,358.3,22840,1,0)
 ;;=^358.31IA^2^2
