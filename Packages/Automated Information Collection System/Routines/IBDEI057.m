IBDEI057 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2043,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2043,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,2043,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,2044,0)
 ;;=33010^^12^165^4^^^^1
 ;;^UTILITY(U,$J,358.3,2044,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2044,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,2044,1,3,0)
 ;;=3^Pericardiocentesis
 ;;^UTILITY(U,$J,358.3,2045,0)
 ;;=92970^^12^165^2^^^^1
 ;;^UTILITY(U,$J,358.3,2045,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2045,1,2,0)
 ;;=2^92970
 ;;^UTILITY(U,$J,358.3,2045,1,3,0)
 ;;=3^Cardio Assist Dev Insert
 ;;^UTILITY(U,$J,358.3,2046,0)
 ;;=94760^^12^165^3^^^^1
 ;;^UTILITY(U,$J,358.3,2046,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2046,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,2046,1,3,0)
 ;;=3^MEASURE BLOOD OXYGEN LEVEL
 ;;^UTILITY(U,$J,358.3,2047,0)
 ;;=93503^^12^166^23^^^^1
 ;;^UTILITY(U,$J,358.3,2047,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2047,1,2,0)
 ;;=2^93503
 ;;^UTILITY(U,$J,358.3,2047,1,3,0)
 ;;=3^Swan Ganz Placement
 ;;^UTILITY(U,$J,358.3,2048,0)
 ;;=93451^^12^166^20^^^^1
 ;;^UTILITY(U,$J,358.3,2048,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2048,1,2,0)
 ;;=2^93451
 ;;^UTILITY(U,$J,358.3,2048,1,3,0)
 ;;=3^Right Hrt Cath incl O2 & Cardiac Outpt
 ;;^UTILITY(U,$J,358.3,2049,0)
 ;;=93452^^12^166^12^^^^1
 ;;^UTILITY(U,$J,358.3,2049,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2049,1,2,0)
 ;;=2^93452
 ;;^UTILITY(U,$J,358.3,2049,1,3,0)
 ;;=3^LHC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,2050,0)
 ;;=93453^^12^166^18^^^^1
 ;;^UTILITY(U,$J,358.3,2050,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2050,1,2,0)
 ;;=2^93453
 ;;^UTILITY(U,$J,358.3,2050,1,3,0)
 ;;=3^R&L HC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,2051,0)
 ;;=93454^^12^166^5^^^^1
 ;;^UTILITY(U,$J,358.3,2051,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2051,1,2,0)
 ;;=2^93454
 ;;^UTILITY(U,$J,358.3,2051,1,3,0)
 ;;=3^Coronary Angiography, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2052,0)
 ;;=93455^^12^166^1^^^^1
 ;;^UTILITY(U,$J,358.3,2052,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2052,1,2,0)
 ;;=2^93455
 ;;^UTILITY(U,$J,358.3,2052,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and Bypass angio
 ;;^UTILITY(U,$J,358.3,2053,0)
 ;;=93456^^12^166^2^^^^1
 ;;^UTILITY(U,$J,358.3,2053,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2053,1,2,0)
 ;;=2^93456
 ;;^UTILITY(U,$J,358.3,2053,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and R Heart Cath
 ;;^UTILITY(U,$J,358.3,2054,0)
 ;;=93457^^12^166^21^^^^1
 ;;^UTILITY(U,$J,358.3,2054,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2054,1,2,0)
 ;;=2^93457
 ;;^UTILITY(U,$J,358.3,2054,1,3,0)
 ;;=3^Rt Hrt Angio,Bypass Grft,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2055,0)
 ;;=93458^^12^166^3^^^^1
 ;;^UTILITY(U,$J,358.3,2055,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2055,1,2,0)
 ;;=2^93458
 ;;^UTILITY(U,$J,358.3,2055,1,3,0)
 ;;=3^Cor Angio, LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2056,0)
 ;;=93459^^12^166^13^^^^1
 ;;^UTILITY(U,$J,358.3,2056,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2056,1,2,0)
 ;;=2^93459
 ;;^UTILITY(U,$J,358.3,2056,1,3,0)
 ;;=3^Lt Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2057,0)
 ;;=93460^^12^166^4^^^^1
 ;;^UTILITY(U,$J,358.3,2057,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2057,1,2,0)
 ;;=2^93460
 ;;^UTILITY(U,$J,358.3,2057,1,3,0)
 ;;=3^Cor Angio, RHC/LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2058,0)
 ;;=93461^^12^166^19^^^^1
 ;;^UTILITY(U,$J,358.3,2058,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2058,1,2,0)
 ;;=2^93461
 ;;^UTILITY(U,$J,358.3,2058,1,3,0)
 ;;=3^R&L Hrt Angio,V-Gram,Bypass,incl inj & S&I
