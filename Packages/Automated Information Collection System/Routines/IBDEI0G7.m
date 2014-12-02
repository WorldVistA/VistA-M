IBDEI0G7 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7862,0)
 ;;=67210^^57^599^3^^^^1
 ;;^UTILITY(U,$J,358.3,7862,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7862,1,2,0)
 ;;=2^Destroy Retinal Lesion 1 or + Sessions,Photocoag
 ;;^UTILITY(U,$J,358.3,7862,1,3,0)
 ;;=3^67210
 ;;^UTILITY(U,$J,358.3,7863,0)
 ;;=67228^^57^599^2^^^^1
 ;;^UTILITY(U,$J,358.3,7863,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7863,1,2,0)
 ;;=2^Destroy Ext Retinopathy, one/more sessions
 ;;^UTILITY(U,$J,358.3,7863,1,3,0)
 ;;=3^67228
 ;;^UTILITY(U,$J,358.3,7864,0)
 ;;=67220^^57^599^1^^^^1
 ;;^UTILITY(U,$J,358.3,7864,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7864,1,2,0)
 ;;=2^Destroy Choroid Lesion, one/more sessions
 ;;^UTILITY(U,$J,358.3,7864,1,3,0)
 ;;=3^67220
 ;;^UTILITY(U,$J,358.3,7865,0)
 ;;=67221^^57^599^6^^^^1
 ;;^UTILITY(U,$J,358.3,7865,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7865,1,2,0)
 ;;=2^Photodynamic Therapy, one/more sessions
 ;;^UTILITY(U,$J,358.3,7865,1,3,0)
 ;;=3^67221
 ;;^UTILITY(U,$J,358.3,7866,0)
 ;;=67225^^57^599^7^^^^1
 ;;^UTILITY(U,$J,358.3,7866,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7866,1,2,0)
 ;;=2^Photodynamic Tx,2nd eye/1 session
 ;;^UTILITY(U,$J,358.3,7866,1,3,0)
 ;;=3^67225
 ;;^UTILITY(U,$J,358.3,7867,0)
 ;;=66821^^57^599^12^^^^1
 ;;^UTILITY(U,$J,358.3,7867,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7867,1,2,0)
 ;;=2^YAG Capsulotomy
 ;;^UTILITY(U,$J,358.3,7867,1,3,0)
 ;;=3^66821
 ;;^UTILITY(U,$J,358.3,7868,0)
 ;;=92134^^57^600^2^^^^1
 ;;^UTILITY(U,$J,358.3,7868,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7868,1,2,0)
 ;;=2^CPTR Ophth Dx Img Post Segmt
 ;;^UTILITY(U,$J,358.3,7868,1,3,0)
 ;;=3^92134
 ;;^UTILITY(U,$J,358.3,7869,0)
 ;;=76512^^57^600^13^^^^1
 ;;^UTILITY(U,$J,358.3,7869,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7869,1,2,0)
 ;;=2^Ultrasound B Scan
 ;;^UTILITY(U,$J,358.3,7869,1,3,0)
 ;;=3^76512
 ;;^UTILITY(U,$J,358.3,7870,0)
 ;;=92235^^57^600^5^^^^1
 ;;^UTILITY(U,$J,358.3,7870,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7870,1,2,0)
 ;;=2^Fluorescein Angiography
 ;;^UTILITY(U,$J,358.3,7870,1,3,0)
 ;;=3^92235
 ;;^UTILITY(U,$J,358.3,7871,0)
 ;;=92240^^57^600^7^^^^1
 ;;^UTILITY(U,$J,358.3,7871,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7871,1,2,0)
 ;;=2^ICG Angiography
 ;;^UTILITY(U,$J,358.3,7871,1,3,0)
 ;;=3^92240
 ;;^UTILITY(U,$J,358.3,7872,0)
 ;;=67145^^57^600^9^^^^1
 ;;^UTILITY(U,$J,358.3,7872,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7872,1,2,0)
 ;;=2^Laser-Retinal Tear
 ;;^UTILITY(U,$J,358.3,7872,1,3,0)
 ;;=3^67145
 ;;^UTILITY(U,$J,358.3,7873,0)
 ;;=67220^^57^600^8^^^^1
 ;;^UTILITY(U,$J,358.3,7873,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7873,1,2,0)
 ;;=2^Laser-Choroidal Lesion
 ;;^UTILITY(U,$J,358.3,7873,1,3,0)
 ;;=3^67220
 ;;^UTILITY(U,$J,358.3,7874,0)
 ;;=67221^^57^600^10^^^^1
 ;;^UTILITY(U,$J,358.3,7874,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7874,1,2,0)
 ;;=2^Photodynamic Therapy
 ;;^UTILITY(U,$J,358.3,7874,1,3,0)
 ;;=3^67221
 ;;^UTILITY(U,$J,358.3,7875,0)
 ;;=67225^^57^600^11^^^^1
 ;;^UTILITY(U,$J,358.3,7875,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7875,1,2,0)
 ;;=2^Photodynamic Therapy,2nd Eye
 ;;^UTILITY(U,$J,358.3,7875,1,3,0)
 ;;=3^67225
 ;;^UTILITY(U,$J,358.3,7876,0)
 ;;=67141^^57^600^4^^^^1
 ;;^UTILITY(U,$J,358.3,7876,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7876,1,2,0)
 ;;=2^Cryotherapy-Retinal Tear
 ;;^UTILITY(U,$J,358.3,7876,1,3,0)
 ;;=3^67141
 ;;^UTILITY(U,$J,358.3,7877,0)
 ;;=67101^^57^600^3^^^^1
 ;;^UTILITY(U,$J,358.3,7877,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7877,1,2,0)
 ;;=2^Cryotherapy-Retinal Detachment
 ;;^UTILITY(U,$J,358.3,7877,1,3,0)
 ;;=3^67101
