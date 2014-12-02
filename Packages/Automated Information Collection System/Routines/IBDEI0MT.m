IBDEI0MT ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11200,1,2,0)
 ;;=2^43243
 ;;^UTILITY(U,$J,358.3,11200,1,3,0)
 ;;=3^EGD w/Sclerosis Injection
 ;;^UTILITY(U,$J,358.3,11201,0)
 ;;=43205^^72^730^33^^^^1
 ;;^UTILITY(U,$J,358.3,11201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11201,1,2,0)
 ;;=2^43205
 ;;^UTILITY(U,$J,358.3,11201,1,3,0)
 ;;=3^Esophagoscopy w/Ligation of Varices
 ;;^UTILITY(U,$J,358.3,11202,0)
 ;;=43201^^72^730^36^^^^1
 ;;^UTILITY(U,$J,358.3,11202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11202,1,2,0)
 ;;=2^43201
 ;;^UTILITY(U,$J,358.3,11202,1,3,0)
 ;;=3^Esophagoscopy w/submucosal injection
 ;;^UTILITY(U,$J,358.3,11203,0)
 ;;=43204^^72^730^24^^^^1
 ;;^UTILITY(U,$J,358.3,11203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11203,1,2,0)
 ;;=2^43204
 ;;^UTILITY(U,$J,358.3,11203,1,3,0)
 ;;=3^Esoph Scope w/Sclerosis Inj
 ;;^UTILITY(U,$J,358.3,11204,0)
 ;;=43216^^72^730^35^^^^1
 ;;^UTILITY(U,$J,358.3,11204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11204,1,2,0)
 ;;=2^43216
 ;;^UTILITY(U,$J,358.3,11204,1,3,0)
 ;;=3^Esophagoscopy w/remov tumor/polyp-hot bx
 ;;^UTILITY(U,$J,358.3,11205,0)
 ;;=43217^^72^730^34^^^^1
 ;;^UTILITY(U,$J,358.3,11205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11205,1,2,0)
 ;;=2^43217
 ;;^UTILITY(U,$J,358.3,11205,1,3,0)
 ;;=3^Esophagoscopy w/remov tumor/polyp-Snare
 ;;^UTILITY(U,$J,358.3,11206,0)
 ;;=43231^^72^730^26^^^^1
 ;;^UTILITY(U,$J,358.3,11206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11206,1,2,0)
 ;;=2^43231
 ;;^UTILITY(U,$J,358.3,11206,1,3,0)
 ;;=3^Esophagoscopy w endoscopic ultrasound
 ;;^UTILITY(U,$J,358.3,11207,0)
 ;;=43232^^72^730^37^^^^1
 ;;^UTILITY(U,$J,358.3,11207,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11207,1,2,0)
 ;;=2^43232
 ;;^UTILITY(U,$J,358.3,11207,1,3,0)
 ;;=3^Esophagoscopy w/tx-endoscop U/S FNA/bx
 ;;^UTILITY(U,$J,358.3,11208,0)
 ;;=43236^^72^730^20^^^^1
 ;;^UTILITY(U,$J,358.3,11208,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11208,1,2,0)
 ;;=2^43236
 ;;^UTILITY(U,$J,358.3,11208,1,3,0)
 ;;=3^EGD, Diagnostic w/submucosal inj(s)
 ;;^UTILITY(U,$J,358.3,11209,0)
 ;;=43237^^72^730^22^^^^1
 ;;^UTILITY(U,$J,358.3,11209,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11209,1,2,0)
 ;;=2^43237
 ;;^UTILITY(U,$J,358.3,11209,1,3,0)
 ;;=3^EGD,Diag US of esophagus
 ;;^UTILITY(U,$J,358.3,11210,0)
 ;;=43238^^72^730^18^^^^1
 ;;^UTILITY(U,$J,358.3,11210,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11210,1,2,0)
 ;;=2^43238
 ;;^UTILITY(U,$J,358.3,11210,1,3,0)
 ;;=3^EGD, Diag-w/transendoscope U/S FNA/bx
 ;;^UTILITY(U,$J,358.3,11211,0)
 ;;=43257^^72^730^14^^^^1
 ;;^UTILITY(U,$J,358.3,11211,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11211,1,2,0)
 ;;=2^43257
 ;;^UTILITY(U,$J,358.3,11211,1,3,0)
 ;;=3^EGD w/Thermal Energy Delivery
 ;;^UTILITY(U,$J,358.3,11212,0)
 ;;=43235^^72^730^23^^^^1
 ;;^UTILITY(U,$J,358.3,11212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11212,1,2,0)
 ;;=2^43235
 ;;^UTILITY(U,$J,358.3,11212,1,3,0)
 ;;=3^EGD,Simple Primary Exam
 ;;^UTILITY(U,$J,358.3,11213,0)
 ;;=43240^^72^730^15^^^^1
 ;;^UTILITY(U,$J,358.3,11213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11213,1,2,0)
 ;;=2^43240
 ;;^UTILITY(U,$J,358.3,11213,1,3,0)
 ;;=3^EGD w/Transmural Drain Cyst
 ;;^UTILITY(U,$J,358.3,11214,0)
 ;;=43241^^72^730^16^^^^1
 ;;^UTILITY(U,$J,358.3,11214,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11214,1,2,0)
 ;;=2^43241
 ;;^UTILITY(U,$J,358.3,11214,1,3,0)
 ;;=3^EGD w/Tube
 ;;^UTILITY(U,$J,358.3,11215,0)
 ;;=43242^^72^730^4^^^^1
 ;;^UTILITY(U,$J,358.3,11215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11215,1,2,0)
 ;;=2^43242
 ;;^UTILITY(U,$J,358.3,11215,1,3,0)
 ;;=3^EGD w/Cath Placement
