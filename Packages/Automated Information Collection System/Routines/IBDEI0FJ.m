IBDEI0FJ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6699,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6699,1,2,0)
 ;;=2^Strapping/Taping,Ankle and/or Foot
 ;;^UTILITY(U,$J,358.3,6699,1,3,0)
 ;;=3^29540
 ;;^UTILITY(U,$J,358.3,6700,0)
 ;;=29260^^55^434^13^^^^1
 ;;^UTILITY(U,$J,358.3,6700,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6700,1,2,0)
 ;;=2^Strapping/Taping,Elbow/Wrist
 ;;^UTILITY(U,$J,358.3,6700,1,3,0)
 ;;=3^29260
 ;;^UTILITY(U,$J,358.3,6701,0)
 ;;=29520^^55^434^15^^^^1
 ;;^UTILITY(U,$J,358.3,6701,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6701,1,2,0)
 ;;=2^Strapping/Taping,Hip
 ;;^UTILITY(U,$J,358.3,6701,1,3,0)
 ;;=3^29520
 ;;^UTILITY(U,$J,358.3,6702,0)
 ;;=29530^^55^434^16^^^^1
 ;;^UTILITY(U,$J,358.3,6702,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6702,1,2,0)
 ;;=2^Strapping/Taping,Knee
 ;;^UTILITY(U,$J,358.3,6702,1,3,0)
 ;;=3^29530
 ;;^UTILITY(U,$J,358.3,6703,0)
 ;;=29240^^55^434^17^^^^1
 ;;^UTILITY(U,$J,358.3,6703,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6703,1,2,0)
 ;;=2^Strapping/Taping,Shoulder
 ;;^UTILITY(U,$J,358.3,6703,1,3,0)
 ;;=3^29240
 ;;^UTILITY(U,$J,358.3,6704,0)
 ;;=29550^^55^434^18^^^^1
 ;;^UTILITY(U,$J,358.3,6704,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6704,1,2,0)
 ;;=2^Strapping/Taping,Toes
 ;;^UTILITY(U,$J,358.3,6704,1,3,0)
 ;;=3^29550
 ;;^UTILITY(U,$J,358.3,6705,0)
 ;;=29280^^55^434^14^^^^1
 ;;^UTILITY(U,$J,358.3,6705,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6705,1,2,0)
 ;;=2^Strapping/Taping,Hand or Finger
 ;;^UTILITY(U,$J,358.3,6705,1,3,0)
 ;;=3^29280
 ;;^UTILITY(U,$J,358.3,6706,0)
 ;;=20999^^55^434^2^^^^1
 ;;^UTILITY(U,$J,358.3,6706,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6706,1,2,0)
 ;;=2^Dry Needling
 ;;^UTILITY(U,$J,358.3,6706,1,3,0)
 ;;=3^20999
 ;;^UTILITY(U,$J,358.3,6707,0)
 ;;=98940^^55^435^1^^^^1
 ;;^UTILITY(U,$J,358.3,6707,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6707,1,2,0)
 ;;=2^CMT; Spinal, one to two regions
 ;;^UTILITY(U,$J,358.3,6707,1,3,0)
 ;;=3^98940
 ;;^UTILITY(U,$J,358.3,6708,0)
 ;;=98941^^55^435^2^^^^1
 ;;^UTILITY(U,$J,358.3,6708,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6708,1,2,0)
 ;;=2^CMT; Spinal, three to four regions
 ;;^UTILITY(U,$J,358.3,6708,1,3,0)
 ;;=3^98941
 ;;^UTILITY(U,$J,358.3,6709,0)
 ;;=98942^^55^435^3^^^^1
 ;;^UTILITY(U,$J,358.3,6709,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6709,1,2,0)
 ;;=2^CMT; Spinal, five regions
 ;;^UTILITY(U,$J,358.3,6709,1,3,0)
 ;;=3^98942
 ;;^UTILITY(U,$J,358.3,6710,0)
 ;;=98943^^55^435^4^^^^1
 ;;^UTILITY(U,$J,358.3,6710,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6710,1,2,0)
 ;;=2^CMT; Extraspinal, one or more regions
 ;;^UTILITY(U,$J,358.3,6710,1,3,0)
 ;;=3^98943
 ;;^UTILITY(U,$J,358.3,6711,0)
 ;;=98925^^55^436^1^^^^1
 ;;^UTILITY(U,$J,358.3,6711,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6711,1,2,0)
 ;;=2^OMT, 1-2 body regions involved
 ;;^UTILITY(U,$J,358.3,6711,1,3,0)
 ;;=3^98925
 ;;^UTILITY(U,$J,358.3,6712,0)
 ;;=98926^^55^436^2^^^^1
 ;;^UTILITY(U,$J,358.3,6712,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6712,1,2,0)
 ;;=2^OMT, 3-4 body regions involved
 ;;^UTILITY(U,$J,358.3,6712,1,3,0)
 ;;=3^98926
 ;;^UTILITY(U,$J,358.3,6713,0)
 ;;=98927^^55^436^3^^^^1
 ;;^UTILITY(U,$J,358.3,6713,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6713,1,2,0)
 ;;=2^OMT, 5-6 body regions involved
 ;;^UTILITY(U,$J,358.3,6713,1,3,0)
 ;;=3^98927
 ;;^UTILITY(U,$J,358.3,6714,0)
 ;;=98928^^55^436^4^^^^1
 ;;^UTILITY(U,$J,358.3,6714,1,0)
 ;;=^358.31IA^3^2
