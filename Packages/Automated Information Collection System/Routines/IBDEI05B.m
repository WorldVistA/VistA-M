IBDEI05B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1824,1,2,0)
 ;;=2^93610
 ;;^UTILITY(U,$J,358.3,1824,1,3,0)
 ;;=3^Intra-Atrial Pacing
 ;;^UTILITY(U,$J,358.3,1825,0)
 ;;=93612^^17^171^23^^^^1
 ;;^UTILITY(U,$J,358.3,1825,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1825,1,2,0)
 ;;=2^93612
 ;;^UTILITY(U,$J,358.3,1825,1,3,0)
 ;;=3^Intraventricular Pacing
 ;;^UTILITY(U,$J,358.3,1826,0)
 ;;=93615^^17^171^17^^^^1
 ;;^UTILITY(U,$J,358.3,1826,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1826,1,2,0)
 ;;=2^93615
 ;;^UTILITY(U,$J,358.3,1826,1,3,0)
 ;;=3^Esoph Record
 ;;^UTILITY(U,$J,358.3,1827,0)
 ;;=93616^^17^171^18^^^^1
 ;;^UTILITY(U,$J,358.3,1827,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1827,1,2,0)
 ;;=2^93616
 ;;^UTILITY(U,$J,358.3,1827,1,3,0)
 ;;=3^Esoph Record W/Pacing
 ;;^UTILITY(U,$J,358.3,1828,0)
 ;;=93618^^17^171^19^^^^1
 ;;^UTILITY(U,$J,358.3,1828,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1828,1,2,0)
 ;;=2^93618
 ;;^UTILITY(U,$J,358.3,1828,1,3,0)
 ;;=3^Induct Of Arryth By Elec Pace
 ;;^UTILITY(U,$J,358.3,1829,0)
 ;;=93619^^17^171^14^^^^1
 ;;^UTILITY(U,$J,358.3,1829,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1829,1,2,0)
 ;;=2^93619
 ;;^UTILITY(U,$J,358.3,1829,1,3,0)
 ;;=3^Eps Eval, No Induct Of Arryth
 ;;^UTILITY(U,$J,358.3,1830,0)
 ;;=93620^^17^171^11^^^^1
 ;;^UTILITY(U,$J,358.3,1830,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1830,1,2,0)
 ;;=2^93620
 ;;^UTILITY(U,$J,358.3,1830,1,3,0)
 ;;=3^Eps Eval W/Induct Of Arryth
 ;;^UTILITY(U,$J,358.3,1831,0)
 ;;=93621^^17^171^10^^^^1
 ;;^UTILITY(U,$J,358.3,1831,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1831,1,2,0)
 ;;=2^93621
 ;;^UTILITY(U,$J,358.3,1831,1,3,0)
 ;;=3^Eps Eval W/Atrial Record
 ;;^UTILITY(U,$J,358.3,1832,0)
 ;;=93622^^17^171^12^^^^1
 ;;^UTILITY(U,$J,358.3,1832,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1832,1,2,0)
 ;;=2^93622
 ;;^UTILITY(U,$J,358.3,1832,1,3,0)
 ;;=3^Eps Eval W/L Vent Record
 ;;^UTILITY(U,$J,358.3,1833,0)
 ;;=93623^^17^171^13^^^^1
 ;;^UTILITY(U,$J,358.3,1833,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1833,1,2,0)
 ;;=2^93623
 ;;^UTILITY(U,$J,358.3,1833,1,3,0)
 ;;=3^Eps Eval W/Prog Stim Drug (W/
 ;;^UTILITY(U,$J,358.3,1834,0)
 ;;=93624^^17^171^15^^^^1
 ;;^UTILITY(U,$J,358.3,1834,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1834,1,2,0)
 ;;=2^93624
 ;;^UTILITY(U,$J,358.3,1834,1,3,0)
 ;;=3^Eps F/U Study W/Pace W/Record
 ;;^UTILITY(U,$J,358.3,1835,0)
 ;;=93640^^17^171^8^^^^1
 ;;^UTILITY(U,$J,358.3,1835,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1835,1,2,0)
 ;;=2^93640
 ;;^UTILITY(U,$J,358.3,1835,1,3,0)
 ;;=3^Eps Eval Sgl/Dual Lead
 ;;^UTILITY(U,$J,358.3,1836,0)
 ;;=93641^^17^171^16^^^^1
 ;;^UTILITY(U,$J,358.3,1836,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1836,1,2,0)
 ;;=2^93641
 ;;^UTILITY(U,$J,358.3,1836,1,3,0)
 ;;=3^Eps Test Sgl/Dual Pulse Gen
 ;;^UTILITY(U,$J,358.3,1837,0)
 ;;=93642^^17^171^9^^^^1
 ;;^UTILITY(U,$J,358.3,1837,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1837,1,2,0)
 ;;=2^93642
 ;;^UTILITY(U,$J,358.3,1837,1,3,0)
 ;;=3^Eps Eval Sgl/Dual W/Pgm,Repgm
 ;;^UTILITY(U,$J,358.3,1838,0)
 ;;=93650^^17^171^1^^^^1
 ;;^UTILITY(U,$J,358.3,1838,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1838,1,2,0)
 ;;=2^93650
 ;;^UTILITY(U,$J,358.3,1838,1,3,0)
 ;;=3^Ablate AV Node,Create Heart Block
 ;;^UTILITY(U,$J,358.3,1839,0)
 ;;=93653^^17^171^4^^^^1
 ;;^UTILITY(U,$J,358.3,1839,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1839,1,2,0)
 ;;=2^93653
 ;;^UTILITY(U,$J,358.3,1839,1,3,0)
 ;;=3^EP & Ablate Supravent Arrhyt
 ;;^UTILITY(U,$J,358.3,1840,0)
 ;;=93654^^17^171^5^^^^1
 ;;^UTILITY(U,$J,358.3,1840,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1840,1,2,0)
 ;;=2^93654
