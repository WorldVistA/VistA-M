IBDEI0KH ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9994,1,3,0)
 ;;=3^Esophagoscopy w/submucosal injection
 ;;^UTILITY(U,$J,358.3,9995,0)
 ;;=43204^^59^651^25^^^^1
 ;;^UTILITY(U,$J,358.3,9995,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9995,1,2,0)
 ;;=2^43204
 ;;^UTILITY(U,$J,358.3,9995,1,3,0)
 ;;=3^Esoph Scope w/Sclerosis Inj
 ;;^UTILITY(U,$J,358.3,9996,0)
 ;;=43216^^59^651^36^^^^1
 ;;^UTILITY(U,$J,358.3,9996,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9996,1,2,0)
 ;;=2^43216
 ;;^UTILITY(U,$J,358.3,9996,1,3,0)
 ;;=3^Esophagoscopy w/remov tumor/polyp-hot bx
 ;;^UTILITY(U,$J,358.3,9997,0)
 ;;=43217^^59^651^35^^^^1
 ;;^UTILITY(U,$J,358.3,9997,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9997,1,2,0)
 ;;=2^43217
 ;;^UTILITY(U,$J,358.3,9997,1,3,0)
 ;;=3^Esophagoscopy w/remov tumor/polyp-Snare
 ;;^UTILITY(U,$J,358.3,9998,0)
 ;;=43231^^59^651^27^^^^1
 ;;^UTILITY(U,$J,358.3,9998,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9998,1,2,0)
 ;;=2^43231
 ;;^UTILITY(U,$J,358.3,9998,1,3,0)
 ;;=3^Esophagoscopy w endoscopic ultrasound
 ;;^UTILITY(U,$J,358.3,9999,0)
 ;;=43232^^59^651^38^^^^1
 ;;^UTILITY(U,$J,358.3,9999,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9999,1,2,0)
 ;;=2^43232
 ;;^UTILITY(U,$J,358.3,9999,1,3,0)
 ;;=3^Esophagoscopy w/tx-endoscop U/S FNA/bx
 ;;^UTILITY(U,$J,358.3,10000,0)
 ;;=43236^^59^651^20^^^^1
 ;;^UTILITY(U,$J,358.3,10000,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10000,1,2,0)
 ;;=2^43236
 ;;^UTILITY(U,$J,358.3,10000,1,3,0)
 ;;=3^EGD, Diagnostic w/submucosal inj(s)
 ;;^UTILITY(U,$J,358.3,10001,0)
 ;;=43237^^59^651^22^^^^1
 ;;^UTILITY(U,$J,358.3,10001,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10001,1,2,0)
 ;;=2^43237
 ;;^UTILITY(U,$J,358.3,10001,1,3,0)
 ;;=3^EGD,Diag US of esophagus
 ;;^UTILITY(U,$J,358.3,10002,0)
 ;;=43238^^59^651^18^^^^1
 ;;^UTILITY(U,$J,358.3,10002,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10002,1,2,0)
 ;;=2^43238
 ;;^UTILITY(U,$J,358.3,10002,1,3,0)
 ;;=3^EGD, Diag-w/transendoscope U/S FNA/bx
 ;;^UTILITY(U,$J,358.3,10003,0)
 ;;=43257^^59^651^14^^^^1
 ;;^UTILITY(U,$J,358.3,10003,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10003,1,2,0)
 ;;=2^43257
 ;;^UTILITY(U,$J,358.3,10003,1,3,0)
 ;;=3^EGD w/Thermal Energy Delivery
 ;;^UTILITY(U,$J,358.3,10004,0)
 ;;=43235^^59^651^23^^^^1
 ;;^UTILITY(U,$J,358.3,10004,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10004,1,2,0)
 ;;=2^43235
 ;;^UTILITY(U,$J,358.3,10004,1,3,0)
 ;;=3^EGD,Simple Primary Exam
 ;;^UTILITY(U,$J,358.3,10005,0)
 ;;=43240^^59^651^15^^^^1
 ;;^UTILITY(U,$J,358.3,10005,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10005,1,2,0)
 ;;=2^43240
 ;;^UTILITY(U,$J,358.3,10005,1,3,0)
 ;;=3^EGD w/Transmural Drain Cyst
 ;;^UTILITY(U,$J,358.3,10006,0)
 ;;=43241^^59^651^16^^^^1
 ;;^UTILITY(U,$J,358.3,10006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10006,1,2,0)
 ;;=2^43241
 ;;^UTILITY(U,$J,358.3,10006,1,3,0)
 ;;=3^EGD w/Tube or Cath
 ;;^UTILITY(U,$J,358.3,10007,0)
 ;;=43242^^59^651^4^^^^1
 ;;^UTILITY(U,$J,358.3,10007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10007,1,2,0)
 ;;=2^43242
 ;;^UTILITY(U,$J,358.3,10007,1,3,0)
 ;;=3^EGD w/Cath Placement
 ;;^UTILITY(U,$J,358.3,10008,0)
 ;;=43252^^59^651^12^^^^1
 ;;^UTILITY(U,$J,358.3,10008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10008,1,2,0)
 ;;=2^43252
 ;;^UTILITY(U,$J,358.3,10008,1,3,0)
 ;;=3^EGD w/Optical Endomicroscopy
 ;;^UTILITY(U,$J,358.3,10009,0)
 ;;=43259^^59^651^7^^^^1
 ;;^UTILITY(U,$J,358.3,10009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10009,1,2,0)
 ;;=2^43259
 ;;^UTILITY(U,$J,358.3,10009,1,3,0)
 ;;=3^EGD w/Endoscopic Ultrasound Exam
 ;;^UTILITY(U,$J,358.3,10010,0)
 ;;=43233^^59^651^9^^^^1
