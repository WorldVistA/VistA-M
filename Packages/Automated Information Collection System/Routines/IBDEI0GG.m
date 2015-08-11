IBDEI0GG ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7949,1,2,0)
 ;;=2^Destroy Retinal Lesion 1 or + Sessions,Photocoag
 ;;^UTILITY(U,$J,358.3,7949,1,3,0)
 ;;=3^67210
 ;;^UTILITY(U,$J,358.3,7950,0)
 ;;=67228^^51^572^2^^^^1
 ;;^UTILITY(U,$J,358.3,7950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7950,1,2,0)
 ;;=2^Destroy Ext Retinopathy, one/more sessions
 ;;^UTILITY(U,$J,358.3,7950,1,3,0)
 ;;=3^67228
 ;;^UTILITY(U,$J,358.3,7951,0)
 ;;=67220^^51^572^1^^^^1
 ;;^UTILITY(U,$J,358.3,7951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7951,1,2,0)
 ;;=2^Destroy Choroid Lesion, one/more sessions
 ;;^UTILITY(U,$J,358.3,7951,1,3,0)
 ;;=3^67220
 ;;^UTILITY(U,$J,358.3,7952,0)
 ;;=67221^^51^572^6^^^^1
 ;;^UTILITY(U,$J,358.3,7952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7952,1,2,0)
 ;;=2^Photodynamic Therapy, one/more sessions
 ;;^UTILITY(U,$J,358.3,7952,1,3,0)
 ;;=3^67221
 ;;^UTILITY(U,$J,358.3,7953,0)
 ;;=67225^^51^572^7^^^^1
 ;;^UTILITY(U,$J,358.3,7953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7953,1,2,0)
 ;;=2^Photodynamic Tx,2nd eye/1 session
 ;;^UTILITY(U,$J,358.3,7953,1,3,0)
 ;;=3^67225
 ;;^UTILITY(U,$J,358.3,7954,0)
 ;;=66821^^51^572^12^^^^1
 ;;^UTILITY(U,$J,358.3,7954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7954,1,2,0)
 ;;=2^YAG Capsulotomy
 ;;^UTILITY(U,$J,358.3,7954,1,3,0)
 ;;=3^66821
 ;;^UTILITY(U,$J,358.3,7955,0)
 ;;=92134^^51^573^2^^^^1
 ;;^UTILITY(U,$J,358.3,7955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7955,1,2,0)
 ;;=2^CPTR Ophth Dx Img Post Segmt
 ;;^UTILITY(U,$J,358.3,7955,1,3,0)
 ;;=3^92134
 ;;^UTILITY(U,$J,358.3,7956,0)
 ;;=92235^^51^573^5^^^^1
 ;;^UTILITY(U,$J,358.3,7956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7956,1,2,0)
 ;;=2^Fluorescein Angiography
 ;;^UTILITY(U,$J,358.3,7956,1,3,0)
 ;;=3^92235
 ;;^UTILITY(U,$J,358.3,7957,0)
 ;;=92240^^51^573^7^^^^1
 ;;^UTILITY(U,$J,358.3,7957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7957,1,2,0)
 ;;=2^ICG Angiography
 ;;^UTILITY(U,$J,358.3,7957,1,3,0)
 ;;=3^92240
 ;;^UTILITY(U,$J,358.3,7958,0)
 ;;=67145^^51^573^9^^^^1
 ;;^UTILITY(U,$J,358.3,7958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7958,1,2,0)
 ;;=2^Laser-Retinal Tear
 ;;^UTILITY(U,$J,358.3,7958,1,3,0)
 ;;=3^67145
 ;;^UTILITY(U,$J,358.3,7959,0)
 ;;=67220^^51^573^8^^^^1
 ;;^UTILITY(U,$J,358.3,7959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7959,1,2,0)
 ;;=2^Laser-Choroidal Lesion
 ;;^UTILITY(U,$J,358.3,7959,1,3,0)
 ;;=3^67220
 ;;^UTILITY(U,$J,358.3,7960,0)
 ;;=67221^^51^573^10^^^^1
 ;;^UTILITY(U,$J,358.3,7960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7960,1,2,0)
 ;;=2^Photodynamic Therapy
 ;;^UTILITY(U,$J,358.3,7960,1,3,0)
 ;;=3^67221
 ;;^UTILITY(U,$J,358.3,7961,0)
 ;;=67225^^51^573^11^^^^1
 ;;^UTILITY(U,$J,358.3,7961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7961,1,2,0)
 ;;=2^Photodynamic Therapy,2nd Eye
 ;;^UTILITY(U,$J,358.3,7961,1,3,0)
 ;;=3^67225
 ;;^UTILITY(U,$J,358.3,7962,0)
 ;;=67141^^51^573^4^^^^1
 ;;^UTILITY(U,$J,358.3,7962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7962,1,2,0)
 ;;=2^Cryotherapy-Retinal Tear
 ;;^UTILITY(U,$J,358.3,7962,1,3,0)
 ;;=3^67141
 ;;^UTILITY(U,$J,358.3,7963,0)
 ;;=67101^^51^573^3^^^^1
 ;;^UTILITY(U,$J,358.3,7963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7963,1,2,0)
 ;;=2^Cryotherapy-Retinal Detachment
 ;;^UTILITY(U,$J,358.3,7963,1,3,0)
 ;;=3^67101
 ;;^UTILITY(U,$J,358.3,7964,0)
 ;;=67110^^51^573^12^^^^1
 ;;^UTILITY(U,$J,358.3,7964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7964,1,2,0)
 ;;=2^Pneumatic Retinopexy
 ;;^UTILITY(U,$J,358.3,7964,1,3,0)
 ;;=3^67110
 ;;^UTILITY(U,$J,358.3,7965,0)
 ;;=92250^^51^573^6^^^^1
