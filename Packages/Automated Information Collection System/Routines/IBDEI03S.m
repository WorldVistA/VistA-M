IBDEI03S ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1445,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,1446,0)
 ;;=37238^^14^132^55^^^^1
 ;;^UTILITY(U,$J,358.3,1446,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1446,1,2,0)
 ;;=2^37238
 ;;^UTILITY(U,$J,358.3,1446,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stent,Init Vein
 ;;^UTILITY(U,$J,358.3,1447,0)
 ;;=37239^^14^132^57^^^^1
 ;;^UTILITY(U,$J,358.3,1447,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1447,1,2,0)
 ;;=2^37239
 ;;^UTILITY(U,$J,358.3,1447,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,1448,0)
 ;;=36005^^14^133^1^^^^1
 ;;^UTILITY(U,$J,358.3,1448,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1448,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,1448,1,3,0)
 ;;=3^Contrast Venography
 ;;^UTILITY(U,$J,358.3,1449,0)
 ;;=92950^^14^134^1^^^^1
 ;;^UTILITY(U,$J,358.3,1449,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1449,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,1449,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,1450,0)
 ;;=33010^^14^134^3^^^^1
 ;;^UTILITY(U,$J,358.3,1450,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1450,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,1450,1,3,0)
 ;;=3^Pericardiocentesis
 ;;^UTILITY(U,$J,358.3,1451,0)
 ;;=92970^^14^134^2^^^^1
 ;;^UTILITY(U,$J,358.3,1451,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1451,1,2,0)
 ;;=2^92970
 ;;^UTILITY(U,$J,358.3,1451,1,3,0)
 ;;=3^Cardio Assist Dev Insert
 ;;^UTILITY(U,$J,358.3,1452,0)
 ;;=93503^^14^135^18^^^^1
 ;;^UTILITY(U,$J,358.3,1452,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1452,1,2,0)
 ;;=2^93503
 ;;^UTILITY(U,$J,358.3,1452,1,3,0)
 ;;=3^Swan Ganz Placement
 ;;^UTILITY(U,$J,358.3,1453,0)
 ;;=93451^^14^135^15^^^^1
 ;;^UTILITY(U,$J,358.3,1453,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1453,1,2,0)
 ;;=2^93451
 ;;^UTILITY(U,$J,358.3,1453,1,3,0)
 ;;=3^Right Hrt Cath incl O2 & Cardiac Outpt
 ;;^UTILITY(U,$J,358.3,1454,0)
 ;;=93452^^14^135^8^^^^1
 ;;^UTILITY(U,$J,358.3,1454,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1454,1,2,0)
 ;;=2^93452
 ;;^UTILITY(U,$J,358.3,1454,1,3,0)
 ;;=3^LHC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1455,0)
 ;;=93453^^14^135^13^^^^1
 ;;^UTILITY(U,$J,358.3,1455,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1455,1,2,0)
 ;;=2^93453
 ;;^UTILITY(U,$J,358.3,1455,1,3,0)
 ;;=3^R&L HC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1456,0)
 ;;=93454^^14^135^5^^^^1
 ;;^UTILITY(U,$J,358.3,1456,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1456,1,2,0)
 ;;=2^93454
 ;;^UTILITY(U,$J,358.3,1456,1,3,0)
 ;;=3^Coronary Angiography, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1457,0)
 ;;=93455^^14^135^1^^^^1
 ;;^UTILITY(U,$J,358.3,1457,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1457,1,2,0)
 ;;=2^93455
 ;;^UTILITY(U,$J,358.3,1457,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and Bypass angio
 ;;^UTILITY(U,$J,358.3,1458,0)
 ;;=93456^^14^135^2^^^^1
 ;;^UTILITY(U,$J,358.3,1458,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1458,1,2,0)
 ;;=2^93456
 ;;^UTILITY(U,$J,358.3,1458,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and R Heart Cath
 ;;^UTILITY(U,$J,358.3,1459,0)
 ;;=93457^^14^135^16^^^^1
 ;;^UTILITY(U,$J,358.3,1459,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1459,1,2,0)
 ;;=2^93457
 ;;^UTILITY(U,$J,358.3,1459,1,3,0)
 ;;=3^Rt Hrt Angio,Bypass Grft,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1460,0)
 ;;=93458^^14^135^3^^^^1
 ;;^UTILITY(U,$J,358.3,1460,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1460,1,2,0)
 ;;=2^93458
 ;;^UTILITY(U,$J,358.3,1460,1,3,0)
 ;;=3^Cor Angio, LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1461,0)
 ;;=93459^^14^135^9^^^^1
 ;;^UTILITY(U,$J,358.3,1461,1,0)
 ;;=^358.31IA^3^2
