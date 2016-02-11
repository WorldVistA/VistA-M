IBDEI123 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17592,1,2,0)
 ;;=2^43216
 ;;^UTILITY(U,$J,358.3,17592,1,3,0)
 ;;=3^Esophagoscopy w/ Remov Tumor/Polyp-Hot Bx
 ;;^UTILITY(U,$J,358.3,17593,0)
 ;;=43217^^90^869^37^^^^1
 ;;^UTILITY(U,$J,358.3,17593,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17593,1,2,0)
 ;;=2^43217
 ;;^UTILITY(U,$J,358.3,17593,1,3,0)
 ;;=3^Esophagoscopy w/ Remov Tumor/Polyp-Snare
 ;;^UTILITY(U,$J,358.3,17594,0)
 ;;=43231^^90^869^30^^^^1
 ;;^UTILITY(U,$J,358.3,17594,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17594,1,2,0)
 ;;=2^43231
 ;;^UTILITY(U,$J,358.3,17594,1,3,0)
 ;;=3^Esophagoscopy w/ Endoscopic US
 ;;^UTILITY(U,$J,358.3,17595,0)
 ;;=43232^^90^869^40^^^^1
 ;;^UTILITY(U,$J,358.3,17595,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17595,1,2,0)
 ;;=2^43232
 ;;^UTILITY(U,$J,358.3,17595,1,3,0)
 ;;=3^Esophagoscopy w/ US Guided Intramural/FNA or Bx
 ;;^UTILITY(U,$J,358.3,17596,0)
 ;;=43236^^90^869^20^^^^1
 ;;^UTILITY(U,$J,358.3,17596,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17596,1,2,0)
 ;;=2^43236
 ;;^UTILITY(U,$J,358.3,17596,1,3,0)
 ;;=3^EGD, Diagnostic w/submucosal inj(s)
 ;;^UTILITY(U,$J,358.3,17597,0)
 ;;=43237^^90^869^22^^^^1
 ;;^UTILITY(U,$J,358.3,17597,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17597,1,2,0)
 ;;=2^43237
 ;;^UTILITY(U,$J,358.3,17597,1,3,0)
 ;;=3^EGD,Diag US of esophagus
 ;;^UTILITY(U,$J,358.3,17598,0)
 ;;=43238^^90^869^21^^^^1
 ;;^UTILITY(U,$J,358.3,17598,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17598,1,2,0)
 ;;=2^43238
 ;;^UTILITY(U,$J,358.3,17598,1,3,0)
 ;;=3^EGD, Dx w/transendoscope U/S FNA/bx
 ;;^UTILITY(U,$J,358.3,17599,0)
 ;;=43257^^90^869^14^^^^1
 ;;^UTILITY(U,$J,358.3,17599,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17599,1,2,0)
 ;;=2^43257
 ;;^UTILITY(U,$J,358.3,17599,1,3,0)
 ;;=3^EGD w/Thermal Energy Delivery
 ;;^UTILITY(U,$J,358.3,17600,0)
 ;;=43235^^90^869^23^^^^1
 ;;^UTILITY(U,$J,358.3,17600,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17600,1,2,0)
 ;;=2^43235
 ;;^UTILITY(U,$J,358.3,17600,1,3,0)
 ;;=3^EGD,Simple Primary Exam
 ;;^UTILITY(U,$J,358.3,17601,0)
 ;;=43240^^90^869^15^^^^1
 ;;^UTILITY(U,$J,358.3,17601,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17601,1,2,0)
 ;;=2^43240
 ;;^UTILITY(U,$J,358.3,17601,1,3,0)
 ;;=3^EGD w/Transmural Drain Cyst
 ;;^UTILITY(U,$J,358.3,17602,0)
 ;;=43241^^90^869^16^^^^1
 ;;^UTILITY(U,$J,358.3,17602,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17602,1,2,0)
 ;;=2^43241
 ;;^UTILITY(U,$J,358.3,17602,1,3,0)
 ;;=3^EGD w/Tube or Cath
 ;;^UTILITY(U,$J,358.3,17603,0)
 ;;=43242^^90^869^4^^^^1
 ;;^UTILITY(U,$J,358.3,17603,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17603,1,2,0)
 ;;=2^43242
 ;;^UTILITY(U,$J,358.3,17603,1,3,0)
 ;;=3^EGD w/Cath Placement
 ;;^UTILITY(U,$J,358.3,17604,0)
 ;;=43252^^90^869^12^^^^1
 ;;^UTILITY(U,$J,358.3,17604,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17604,1,2,0)
 ;;=2^43252
 ;;^UTILITY(U,$J,358.3,17604,1,3,0)
 ;;=3^EGD w/Optical Endomicroscopy
 ;;^UTILITY(U,$J,358.3,17605,0)
 ;;=43259^^90^869^7^^^^1
 ;;^UTILITY(U,$J,358.3,17605,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17605,1,2,0)
 ;;=2^43259
 ;;^UTILITY(U,$J,358.3,17605,1,3,0)
 ;;=3^EGD w/Endoscopic Ultrasound Exam
 ;;^UTILITY(U,$J,358.3,17606,0)
 ;;=43233^^90^869^9^^^^1
 ;;^UTILITY(U,$J,358.3,17606,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17606,1,2,0)
 ;;=2^43233
 ;;^UTILITY(U,$J,358.3,17606,1,3,0)
 ;;=3^EGD w/Esoph Dilation by Balloon >30mm
 ;;^UTILITY(U,$J,358.3,17607,0)
 ;;=43214^^90^869^26^^^^1
 ;;^UTILITY(U,$J,358.3,17607,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17607,1,2,0)
 ;;=2^43214
 ;;^UTILITY(U,$J,358.3,17607,1,3,0)
 ;;=3^Esophagoscopy w/ Balloon Dilation >+30mm
