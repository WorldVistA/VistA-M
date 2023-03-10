IBDEI0JG ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8751,1,3,0)
 ;;=3^Soil Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,8751,1,4,0)
 ;;=4^Z77.112
 ;;^UTILITY(U,$J,358.3,8751,2)
 ;;=^5063316
 ;;^UTILITY(U,$J,358.3,8752,0)
 ;;=Z77.111^^39^402^155
 ;;^UTILITY(U,$J,358.3,8752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8752,1,3,0)
 ;;=3^Water Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,8752,1,4,0)
 ;;=4^Z77.111
 ;;^UTILITY(U,$J,358.3,8752,2)
 ;;=^5063315
 ;;^UTILITY(U,$J,358.3,8753,0)
 ;;=Z77.128^^39^402^113
 ;;^UTILITY(U,$J,358.3,8753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8753,1,3,0)
 ;;=3^Physical Environment Hazards Contact/Exposure
 ;;^UTILITY(U,$J,358.3,8753,1,4,0)
 ;;=4^Z77.128
 ;;^UTILITY(U,$J,358.3,8753,2)
 ;;=^5063322
 ;;^UTILITY(U,$J,358.3,8754,0)
 ;;=Z77.123^^39^402^146
 ;;^UTILITY(U,$J,358.3,8754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8754,1,3,0)
 ;;=3^Radon/Radiation Contact/Exposure
 ;;^UTILITY(U,$J,358.3,8754,1,4,0)
 ;;=4^Z77.123
 ;;^UTILITY(U,$J,358.3,8754,2)
 ;;=^5063321
 ;;^UTILITY(U,$J,358.3,8755,0)
 ;;=Z77.122^^39^402^61
 ;;^UTILITY(U,$J,358.3,8755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8755,1,3,0)
 ;;=3^Noise Contact/Exposure
 ;;^UTILITY(U,$J,358.3,8755,1,4,0)
 ;;=4^Z77.122
 ;;^UTILITY(U,$J,358.3,8755,2)
 ;;=^5063320
 ;;^UTILITY(U,$J,358.3,8756,0)
 ;;=Z77.118^^39^402^11
 ;;^UTILITY(U,$J,358.3,8756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8756,1,3,0)
 ;;=3^Environmental Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,8756,1,4,0)
 ;;=4^Z77.118
 ;;^UTILITY(U,$J,358.3,8756,2)
 ;;=^5063317
 ;;^UTILITY(U,$J,358.3,8757,0)
 ;;=Z77.9^^39^402^47
 ;;^UTILITY(U,$J,358.3,8757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8757,1,3,0)
 ;;=3^Health Hazard Contact/Exposure
 ;;^UTILITY(U,$J,358.3,8757,1,4,0)
 ;;=4^Z77.9
 ;;^UTILITY(U,$J,358.3,8757,2)
 ;;=^5063326
 ;;^UTILITY(U,$J,358.3,8758,0)
 ;;=Z77.22^^39^402^10
 ;;^UTILITY(U,$J,358.3,8758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8758,1,3,0)
 ;;=3^Environmental Exposure Tobacco Smoke/Second-Hand Smoke
 ;;^UTILITY(U,$J,358.3,8758,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,8758,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,8759,0)
 ;;=Z80.0^^39^402^28
 ;;^UTILITY(U,$J,358.3,8759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8759,1,3,0)
 ;;=3^Family Hx of Malig Neop of Digestive Organs
 ;;^UTILITY(U,$J,358.3,8759,1,4,0)
 ;;=4^Z80.0
 ;;^UTILITY(U,$J,358.3,8759,2)
 ;;=^5063344
 ;;^UTILITY(U,$J,358.3,8760,0)
 ;;=Z80.1^^39^402^34
 ;;^UTILITY(U,$J,358.3,8760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8760,1,3,0)
 ;;=3^Family Hx of Malig Neop of Trachea,Bronc & Lung
 ;;^UTILITY(U,$J,358.3,8760,1,4,0)
 ;;=4^Z80.1
 ;;^UTILITY(U,$J,358.3,8760,2)
 ;;=^5063345
 ;;^UTILITY(U,$J,358.3,8761,0)
 ;;=Z80.3^^39^402^27
 ;;^UTILITY(U,$J,358.3,8761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8761,1,3,0)
 ;;=3^Family Hx of Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,8761,1,4,0)
 ;;=4^Z80.3
 ;;^UTILITY(U,$J,358.3,8761,2)
 ;;=^5063347
 ;;^UTILITY(U,$J,358.3,8762,0)
 ;;=Z80.41^^39^402^31
 ;;^UTILITY(U,$J,358.3,8762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8762,1,3,0)
 ;;=3^Family Hx of Malig Neop of Ovary
 ;;^UTILITY(U,$J,358.3,8762,1,4,0)
 ;;=4^Z80.41
 ;;^UTILITY(U,$J,358.3,8762,2)
 ;;=^5063348
 ;;^UTILITY(U,$J,358.3,8763,0)
 ;;=Z80.42^^39^402^32
 ;;^UTILITY(U,$J,358.3,8763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8763,1,3,0)
 ;;=3^Family Hx of Malig Neop of Prostate
