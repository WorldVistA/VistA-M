IBDEI0DZ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5961,1,2,0)
 ;;=2^94761
 ;;^UTILITY(U,$J,358.3,5961,1,3,0)
 ;;=3^Measure Blood Oxygen Level,Mult Times
 ;;^UTILITY(U,$J,358.3,5962,0)
 ;;=33289^^52^388^5^^^^1
 ;;^UTILITY(U,$J,358.3,5962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5962,1,2,0)
 ;;=2^33289
 ;;^UTILITY(U,$J,358.3,5962,1,3,0)
 ;;=3^Transcath Impl Wireless Pulm Art Sensor
 ;;^UTILITY(U,$J,358.3,5963,0)
 ;;=93503^^52^389^23^^^^1
 ;;^UTILITY(U,$J,358.3,5963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5963,1,2,0)
 ;;=2^93503
 ;;^UTILITY(U,$J,358.3,5963,1,3,0)
 ;;=3^Swan Ganz Placement
 ;;^UTILITY(U,$J,358.3,5964,0)
 ;;=93451^^52^389^20^^^^1
 ;;^UTILITY(U,$J,358.3,5964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5964,1,2,0)
 ;;=2^93451
 ;;^UTILITY(U,$J,358.3,5964,1,3,0)
 ;;=3^Right Hrt Cath incl O2 & Cardiac Outpt
 ;;^UTILITY(U,$J,358.3,5965,0)
 ;;=93452^^52^389^12^^^^1
 ;;^UTILITY(U,$J,358.3,5965,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5965,1,2,0)
 ;;=2^93452
 ;;^UTILITY(U,$J,358.3,5965,1,3,0)
 ;;=3^LHC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,5966,0)
 ;;=93453^^52^389^18^^^^1
 ;;^UTILITY(U,$J,358.3,5966,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5966,1,2,0)
 ;;=2^93453
 ;;^UTILITY(U,$J,358.3,5966,1,3,0)
 ;;=3^R&L HC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,5967,0)
 ;;=93454^^52^389^5^^^^1
 ;;^UTILITY(U,$J,358.3,5967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5967,1,2,0)
 ;;=2^93454
 ;;^UTILITY(U,$J,358.3,5967,1,3,0)
 ;;=3^Coronary Angiography, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,5968,0)
 ;;=93455^^52^389^1^^^^1
 ;;^UTILITY(U,$J,358.3,5968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5968,1,2,0)
 ;;=2^93455
 ;;^UTILITY(U,$J,358.3,5968,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and Bypass angio
 ;;^UTILITY(U,$J,358.3,5969,0)
 ;;=93456^^52^389^2^^^^1
 ;;^UTILITY(U,$J,358.3,5969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5969,1,2,0)
 ;;=2^93456
 ;;^UTILITY(U,$J,358.3,5969,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and R Heart Cath
 ;;^UTILITY(U,$J,358.3,5970,0)
 ;;=93457^^52^389^21^^^^1
 ;;^UTILITY(U,$J,358.3,5970,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5970,1,2,0)
 ;;=2^93457
 ;;^UTILITY(U,$J,358.3,5970,1,3,0)
 ;;=3^Rt Hrt Angio,Bypass Grft,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,5971,0)
 ;;=93458^^52^389^3^^^^1
 ;;^UTILITY(U,$J,358.3,5971,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5971,1,2,0)
 ;;=2^93458
 ;;^UTILITY(U,$J,358.3,5971,1,3,0)
 ;;=3^Cor Angio, LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,5972,0)
 ;;=93459^^52^389^13^^^^1
 ;;^UTILITY(U,$J,358.3,5972,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5972,1,2,0)
 ;;=2^93459
 ;;^UTILITY(U,$J,358.3,5972,1,3,0)
 ;;=3^Lt Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,5973,0)
 ;;=93460^^52^389^4^^^^1
 ;;^UTILITY(U,$J,358.3,5973,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5973,1,2,0)
 ;;=2^93460
 ;;^UTILITY(U,$J,358.3,5973,1,3,0)
 ;;=3^Cor Angio, RHC/LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,5974,0)
 ;;=93461^^52^389^19^^^^1
 ;;^UTILITY(U,$J,358.3,5974,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5974,1,2,0)
 ;;=2^93461
 ;;^UTILITY(U,$J,358.3,5974,1,3,0)
 ;;=3^R&L Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,5975,0)
 ;;=93462^^52^389^14^^^^1
 ;;^UTILITY(U,$J,358.3,5975,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5975,1,2,0)
 ;;=2^93462
 ;;^UTILITY(U,$J,358.3,5975,1,3,0)
 ;;=3^Lt Hrt Cath Trnsptl Puncture
