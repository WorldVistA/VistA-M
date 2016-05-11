IBDEI0KP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9649,0)
 ;;=67210^^43^489^3^^^^1
 ;;^UTILITY(U,$J,358.3,9649,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9649,1,2,0)
 ;;=2^Destroy Retinal Lesion 1 or + Sessions,Photocoag
 ;;^UTILITY(U,$J,358.3,9649,1,3,0)
 ;;=3^67210
 ;;^UTILITY(U,$J,358.3,9650,0)
 ;;=67228^^43^489^2^^^^1
 ;;^UTILITY(U,$J,358.3,9650,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9650,1,2,0)
 ;;=2^Destroy Ext Retinopathy, one/more sessions
 ;;^UTILITY(U,$J,358.3,9650,1,3,0)
 ;;=3^67228
 ;;^UTILITY(U,$J,358.3,9651,0)
 ;;=67220^^43^489^1^^^^1
 ;;^UTILITY(U,$J,358.3,9651,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9651,1,2,0)
 ;;=2^Destroy Choroid Lesion, one/more sessions
 ;;^UTILITY(U,$J,358.3,9651,1,3,0)
 ;;=3^67220
 ;;^UTILITY(U,$J,358.3,9652,0)
 ;;=67221^^43^489^6^^^^1
 ;;^UTILITY(U,$J,358.3,9652,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9652,1,2,0)
 ;;=2^Photodynamic Therapy, one/more sessions
 ;;^UTILITY(U,$J,358.3,9652,1,3,0)
 ;;=3^67221
 ;;^UTILITY(U,$J,358.3,9653,0)
 ;;=67225^^43^489^7^^^^1
 ;;^UTILITY(U,$J,358.3,9653,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9653,1,2,0)
 ;;=2^Photodynamic Tx,2nd eye/1 session
 ;;^UTILITY(U,$J,358.3,9653,1,3,0)
 ;;=3^67225
 ;;^UTILITY(U,$J,358.3,9654,0)
 ;;=66821^^43^489^12^^^^1
 ;;^UTILITY(U,$J,358.3,9654,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9654,1,2,0)
 ;;=2^YAG Capsulotomy
 ;;^UTILITY(U,$J,358.3,9654,1,3,0)
 ;;=3^66821
 ;;^UTILITY(U,$J,358.3,9655,0)
 ;;=92134^^43^490^2^^^^1
 ;;^UTILITY(U,$J,358.3,9655,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9655,1,2,0)
 ;;=2^CPTR Ophth Dx Img Post Segmt
 ;;^UTILITY(U,$J,358.3,9655,1,3,0)
 ;;=3^92134
 ;;^UTILITY(U,$J,358.3,9656,0)
 ;;=92235^^43^490^5^^^^1
 ;;^UTILITY(U,$J,358.3,9656,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9656,1,2,0)
 ;;=2^Fluorescein Angiography
 ;;^UTILITY(U,$J,358.3,9656,1,3,0)
 ;;=3^92235
 ;;^UTILITY(U,$J,358.3,9657,0)
 ;;=92240^^43^490^7^^^^1
 ;;^UTILITY(U,$J,358.3,9657,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9657,1,2,0)
 ;;=2^ICG Angiography
 ;;^UTILITY(U,$J,358.3,9657,1,3,0)
 ;;=3^92240
 ;;^UTILITY(U,$J,358.3,9658,0)
 ;;=67145^^43^490^9^^^^1
 ;;^UTILITY(U,$J,358.3,9658,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9658,1,2,0)
 ;;=2^Laser-Retinal Tear
 ;;^UTILITY(U,$J,358.3,9658,1,3,0)
 ;;=3^67145
 ;;^UTILITY(U,$J,358.3,9659,0)
 ;;=67220^^43^490^8^^^^1
 ;;^UTILITY(U,$J,358.3,9659,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9659,1,2,0)
 ;;=2^Laser-Choroidal Lesion
 ;;^UTILITY(U,$J,358.3,9659,1,3,0)
 ;;=3^67220
 ;;^UTILITY(U,$J,358.3,9660,0)
 ;;=67221^^43^490^10^^^^1
 ;;^UTILITY(U,$J,358.3,9660,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9660,1,2,0)
 ;;=2^Photodynamic Therapy
 ;;^UTILITY(U,$J,358.3,9660,1,3,0)
 ;;=3^67221
 ;;^UTILITY(U,$J,358.3,9661,0)
 ;;=67225^^43^490^11^^^^1
 ;;^UTILITY(U,$J,358.3,9661,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9661,1,2,0)
 ;;=2^Photodynamic Therapy,2nd Eye
 ;;^UTILITY(U,$J,358.3,9661,1,3,0)
 ;;=3^67225
 ;;^UTILITY(U,$J,358.3,9662,0)
 ;;=67141^^43^490^4^^^^1
 ;;^UTILITY(U,$J,358.3,9662,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9662,1,2,0)
 ;;=2^Cryotherapy-Retinal Tear
 ;;^UTILITY(U,$J,358.3,9662,1,3,0)
 ;;=3^67141
 ;;^UTILITY(U,$J,358.3,9663,0)
 ;;=67101^^43^490^3^^^^1
 ;;^UTILITY(U,$J,358.3,9663,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9663,1,2,0)
 ;;=2^Cryotherapy-Retinal Detachment
 ;;^UTILITY(U,$J,358.3,9663,1,3,0)
 ;;=3^67101
 ;;^UTILITY(U,$J,358.3,9664,0)
 ;;=67110^^43^490^12^^^^1
 ;;^UTILITY(U,$J,358.3,9664,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9664,1,2,0)
 ;;=2^Pneumatic Retinopexy
 ;;^UTILITY(U,$J,358.3,9664,1,3,0)
 ;;=3^67110
