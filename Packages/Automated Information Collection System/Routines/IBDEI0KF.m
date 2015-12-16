IBDEI0KF ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9663,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9663,1,2,0)
 ;;=2^Remove Corneal Epith, EDTA
 ;;^UTILITY(U,$J,358.3,9663,1,3,0)
 ;;=3^65436
 ;;^UTILITY(U,$J,358.3,9664,0)
 ;;=65772^^43^551^24^^^^1
 ;;^UTILITY(U,$J,358.3,9664,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9664,1,2,0)
 ;;=2^Incision, Cornea, Relaxation
 ;;^UTILITY(U,$J,358.3,9664,1,3,0)
 ;;=3^65772
 ;;^UTILITY(U,$J,358.3,9665,0)
 ;;=37609^^43^551^32^^^^1
 ;;^UTILITY(U,$J,358.3,9665,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9665,1,2,0)
 ;;=2^Temporal Artery Biopsy
 ;;^UTILITY(U,$J,358.3,9665,1,3,0)
 ;;=3^37609
 ;;^UTILITY(U,$J,358.3,9666,0)
 ;;=66170^^43^551^23^^^^1
 ;;^UTILITY(U,$J,358.3,9666,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9666,1,2,0)
 ;;=2^Fistulization Sclera for Glauc Trabeculectomy
 ;;^UTILITY(U,$J,358.3,9666,1,3,0)
 ;;=3^66170
 ;;^UTILITY(U,$J,358.3,9667,0)
 ;;=65800^^43^551^13^^^^1
 ;;^UTILITY(U,$J,358.3,9667,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9667,1,2,0)
 ;;=2^Drainage of Eye
 ;;^UTILITY(U,$J,358.3,9667,1,3,0)
 ;;=3^65800
 ;;^UTILITY(U,$J,358.3,9668,0)
 ;;=67805^^43^551^6^^^^1
 ;;^UTILITY(U,$J,358.3,9668,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9668,1,2,0)
 ;;=2^Chalazion-Excision;Mult,Different Lid
 ;;^UTILITY(U,$J,358.3,9668,1,3,0)
 ;;=3^67805
 ;;^UTILITY(U,$J,358.3,9669,0)
 ;;=67801^^43^551^7^^^^1
 ;;^UTILITY(U,$J,358.3,9669,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9669,1,2,0)
 ;;=2^Chalazion-Excision;Mult,Same Lid
 ;;^UTILITY(U,$J,358.3,9669,1,3,0)
 ;;=3^67801
 ;;^UTILITY(U,$J,358.3,9670,0)
 ;;=68110^^43^551^29^^^^1
 ;;^UTILITY(U,$J,358.3,9670,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9670,1,2,0)
 ;;=2^Remove Eyelid Lining Lesion
 ;;^UTILITY(U,$J,358.3,9670,1,3,0)
 ;;=3^68110
 ;;^UTILITY(U,$J,358.3,9671,0)
 ;;=65855^^43^552^11^^^^1
 ;;^UTILITY(U,$J,358.3,9671,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9671,1,2,0)
 ;;=2^Trabeculoplasty, one/more sessions
 ;;^UTILITY(U,$J,358.3,9671,1,3,0)
 ;;=3^65855
 ;;^UTILITY(U,$J,358.3,9672,0)
 ;;=65860^^43^552^10^^^^1
 ;;^UTILITY(U,$J,358.3,9672,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9672,1,2,0)
 ;;=2^Sever Adhesions of Ant Segment
 ;;^UTILITY(U,$J,358.3,9672,1,3,0)
 ;;=3^65860
 ;;^UTILITY(U,$J,358.3,9673,0)
 ;;=66761^^43^552^5^^^^1
 ;;^UTILITY(U,$J,358.3,9673,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9673,1,2,0)
 ;;=2^Iridotomy/Iridectomy, one/more session
 ;;^UTILITY(U,$J,358.3,9673,1,3,0)
 ;;=3^66761
 ;;^UTILITY(U,$J,358.3,9674,0)
 ;;=66762^^43^552^4^^^^1
 ;;^UTILITY(U,$J,358.3,9674,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9674,1,2,0)
 ;;=2^Iridoplasty, one/more sessions
 ;;^UTILITY(U,$J,358.3,9674,1,3,0)
 ;;=3^66762
 ;;^UTILITY(U,$J,358.3,9675,0)
 ;;=67105^^43^552^9^^^^1
 ;;^UTILITY(U,$J,358.3,9675,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9675,1,2,0)
 ;;=2^Repair Detach Retina 1 or + Sessions,Photocoag
 ;;^UTILITY(U,$J,358.3,9675,1,3,0)
 ;;=3^67105
 ;;^UTILITY(U,$J,358.3,9676,0)
 ;;=67145^^43^552^8^^^^1
 ;;^UTILITY(U,$J,358.3,9676,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9676,1,2,0)
 ;;=2^Prophylactic Tx of Retina 1 or + Sessions,Photocoag
 ;;^UTILITY(U,$J,358.3,9676,1,3,0)
 ;;=3^67145
 ;;^UTILITY(U,$J,358.3,9677,0)
 ;;=67210^^43^552^3^^^^1
 ;;^UTILITY(U,$J,358.3,9677,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9677,1,2,0)
 ;;=2^Destroy Retinal Lesion 1 or + Sessions,Photocoag
 ;;^UTILITY(U,$J,358.3,9677,1,3,0)
 ;;=3^67210
 ;;^UTILITY(U,$J,358.3,9678,0)
 ;;=67228^^43^552^2^^^^1
 ;;^UTILITY(U,$J,358.3,9678,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9678,1,2,0)
 ;;=2^Destroy Ext Retinopathy, one/more sessions
