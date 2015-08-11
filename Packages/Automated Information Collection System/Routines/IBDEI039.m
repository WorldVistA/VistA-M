IBDEI039 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1123,0)
 ;;=33010^^10^108^4^^^^1
 ;;^UTILITY(U,$J,358.3,1123,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1123,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,1123,1,3,0)
 ;;=3^Pericardiocentesis
 ;;^UTILITY(U,$J,358.3,1124,0)
 ;;=92970^^10^108^2^^^^1
 ;;^UTILITY(U,$J,358.3,1124,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1124,1,2,0)
 ;;=2^92970
 ;;^UTILITY(U,$J,358.3,1124,1,3,0)
 ;;=3^Cardio Assist Dev Insert
 ;;^UTILITY(U,$J,358.3,1125,0)
 ;;=94760^^10^108^3^^^^1
 ;;^UTILITY(U,$J,358.3,1125,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1125,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,1125,1,3,0)
 ;;=3^MEASURE BLOOD OXYGEN LEVEL
 ;;^UTILITY(U,$J,358.3,1126,0)
 ;;=93503^^10^109^23^^^^1
 ;;^UTILITY(U,$J,358.3,1126,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1126,1,2,0)
 ;;=2^93503
 ;;^UTILITY(U,$J,358.3,1126,1,3,0)
 ;;=3^Swan Ganz Placement
 ;;^UTILITY(U,$J,358.3,1127,0)
 ;;=93451^^10^109^20^^^^1
 ;;^UTILITY(U,$J,358.3,1127,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1127,1,2,0)
 ;;=2^93451
 ;;^UTILITY(U,$J,358.3,1127,1,3,0)
 ;;=3^Right Hrt Cath incl O2 & Cardiac Outpt
 ;;^UTILITY(U,$J,358.3,1128,0)
 ;;=93452^^10^109^12^^^^1
 ;;^UTILITY(U,$J,358.3,1128,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1128,1,2,0)
 ;;=2^93452
 ;;^UTILITY(U,$J,358.3,1128,1,3,0)
 ;;=3^LHC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1129,0)
 ;;=93453^^10^109^18^^^^1
 ;;^UTILITY(U,$J,358.3,1129,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1129,1,2,0)
 ;;=2^93453
 ;;^UTILITY(U,$J,358.3,1129,1,3,0)
 ;;=3^R&L HC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1130,0)
 ;;=93454^^10^109^5^^^^1
 ;;^UTILITY(U,$J,358.3,1130,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1130,1,2,0)
 ;;=2^93454
 ;;^UTILITY(U,$J,358.3,1130,1,3,0)
 ;;=3^Coronary Angiography, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1131,0)
 ;;=93455^^10^109^1^^^^1
 ;;^UTILITY(U,$J,358.3,1131,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1131,1,2,0)
 ;;=2^93455
 ;;^UTILITY(U,$J,358.3,1131,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and Bypass angio
 ;;^UTILITY(U,$J,358.3,1132,0)
 ;;=93456^^10^109^2^^^^1
 ;;^UTILITY(U,$J,358.3,1132,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1132,1,2,0)
 ;;=2^93456
 ;;^UTILITY(U,$J,358.3,1132,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and R Heart Cath
 ;;^UTILITY(U,$J,358.3,1133,0)
 ;;=93457^^10^109^21^^^^1
 ;;^UTILITY(U,$J,358.3,1133,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1133,1,2,0)
 ;;=2^93457
 ;;^UTILITY(U,$J,358.3,1133,1,3,0)
 ;;=3^Rt Hrt Angio,Bypass Grft,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1134,0)
 ;;=93458^^10^109^3^^^^1
 ;;^UTILITY(U,$J,358.3,1134,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1134,1,2,0)
 ;;=2^93458
 ;;^UTILITY(U,$J,358.3,1134,1,3,0)
 ;;=3^Cor Angio, LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1135,0)
 ;;=93459^^10^109^13^^^^1
 ;;^UTILITY(U,$J,358.3,1135,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1135,1,2,0)
 ;;=2^93459
 ;;^UTILITY(U,$J,358.3,1135,1,3,0)
 ;;=3^Lt Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1136,0)
 ;;=93460^^10^109^4^^^^1
 ;;^UTILITY(U,$J,358.3,1136,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1136,1,2,0)
 ;;=2^93460
 ;;^UTILITY(U,$J,358.3,1136,1,3,0)
 ;;=3^Cor Angio, RHC/LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1137,0)
 ;;=93461^^10^109^19^^^^1
 ;;^UTILITY(U,$J,358.3,1137,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1137,1,2,0)
 ;;=2^93461
 ;;^UTILITY(U,$J,358.3,1137,1,3,0)
 ;;=3^R&L Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1138,0)
 ;;=93462^^10^109^14^^^^1
 ;;^UTILITY(U,$J,358.3,1138,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1138,1,2,0)
 ;;=2^93462
