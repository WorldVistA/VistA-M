IBDEI22S ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33135,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33135,1,2,0)
 ;;=2^97755
 ;;^UTILITY(U,$J,358.3,33135,1,3,0)
 ;;=3^Assistive Technology Assessment,Ea 15 min
 ;;^UTILITY(U,$J,358.3,33136,0)
 ;;=97110^^129^1682^18^^^^1
 ;;^UTILITY(U,$J,358.3,33136,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33136,1,2,0)
 ;;=2^97110
 ;;^UTILITY(U,$J,358.3,33136,1,3,0)
 ;;=3^Therapeutic Exercises,Ea 15 min
 ;;^UTILITY(U,$J,358.3,33137,0)
 ;;=97112^^129^1682^12^^^^1
 ;;^UTILITY(U,$J,358.3,33137,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33137,1,2,0)
 ;;=2^97112
 ;;^UTILITY(U,$J,358.3,33137,1,3,0)
 ;;=3^Neuromuscular Re-education (EV Trng),Ea 15 min
 ;;^UTILITY(U,$J,358.3,33138,0)
 ;;=97140^^129^1682^11^^^^1
 ;;^UTILITY(U,$J,358.3,33138,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33138,1,2,0)
 ;;=2^97140
 ;;^UTILITY(U,$J,358.3,33138,1,3,0)
 ;;=3^Manual Therapy 1/> Regions,Ea 15 min
 ;;^UTILITY(U,$J,358.3,33139,0)
 ;;=97150^^129^1682^7^^^^1
 ;;^UTILITY(U,$J,358.3,33139,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33139,1,2,0)
 ;;=2^97150
 ;;^UTILITY(U,$J,358.3,33139,1,3,0)
 ;;=3^Group Therapeutic Procedures,Ea 15 min
 ;;^UTILITY(U,$J,358.3,33140,0)
 ;;=97530^^129^1682^17^^^^1
 ;;^UTILITY(U,$J,358.3,33140,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33140,1,2,0)
 ;;=2^97530
 ;;^UTILITY(U,$J,358.3,33140,1,3,0)
 ;;=3^Therapeutic Activities,Ea 15 min
 ;;^UTILITY(U,$J,358.3,33141,0)
 ;;=97763^^129^1682^5^^^^1
 ;;^UTILITY(U,$J,358.3,33141,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33141,1,2,0)
 ;;=2^97763
 ;;^UTILITY(U,$J,358.3,33141,1,3,0)
 ;;=3^Orthotic/Prosthetic Mgmt,Subsq Visit,Ea 15 min
 ;;^UTILITY(U,$J,358.3,33142,0)
 ;;=99367^^129^1682^16^^^^1
 ;;^UTILITY(U,$J,358.3,33142,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33142,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,33142,1,3,0)
 ;;=3^Team Conf w/o Pat by Physician
 ;;^UTILITY(U,$J,358.3,33143,0)
 ;;=V2615^^129^1682^19^^^^1
 ;;^UTILITY(U,$J,358.3,33143,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33143,1,2,0)
 ;;=2^V2615
 ;;^UTILITY(U,$J,358.3,33143,1,3,0)
 ;;=3^Fit Telescope/Compound Lens System
 ;;^UTILITY(U,$J,358.3,33144,0)
 ;;=V2600^^129^1682^20^^^^1
 ;;^UTILITY(U,$J,358.3,33144,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33144,1,2,0)
 ;;=2^V2600
 ;;^UTILITY(U,$J,358.3,33144,1,3,0)
 ;;=3^Fit Hand Held Mag/Non-spectacle Mounted Aid
 ;;^UTILITY(U,$J,358.3,33145,0)
 ;;=V2610^^129^1682^21^^^^1
 ;;^UTILITY(U,$J,358.3,33145,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33145,1,2,0)
 ;;=2^V2610
 ;;^UTILITY(U,$J,358.3,33145,1,3,0)
 ;;=3^Fit Single Lens Spec Mounted Low Vision Device
 ;;^UTILITY(U,$J,358.3,33146,0)
 ;;=92354^^129^1682^22^^^^1
 ;;^UTILITY(U,$J,358.3,33146,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33146,1,2,0)
 ;;=2^92354
 ;;^UTILITY(U,$J,358.3,33146,1,3,0)
 ;;=3^Fit Spec Mounted Low Vision Device Single Element
 ;;^UTILITY(U,$J,358.3,33147,0)
 ;;=92355^^129^1682^23^^^^1
 ;;^UTILITY(U,$J,358.3,33147,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33147,1,2,0)
 ;;=2^92355
 ;;^UTILITY(U,$J,358.3,33147,1,3,0)
 ;;=3^Fit Spec Mount TS or Compound Device
 ;;^UTILITY(U,$J,358.3,33148,0)
 ;;=V2118^^129^1682^24^^^^1
 ;;^UTILITY(U,$J,358.3,33148,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33148,1,2,0)
 ;;=2^V2118
 ;;^UTILITY(U,$J,358.3,33148,1,3,0)
 ;;=3^Fit Aniseikonic Lens Single Vision
 ;;^UTILITY(U,$J,358.3,33149,0)
 ;;=V2718^^129^1682^25^^^^1
