IBDEI04Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1916,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1916,1,2,0)
 ;;=2^33237
 ;;^UTILITY(U,$J,358.3,1916,1,3,0)
 ;;=3^Remove Electrode/Thoracotomy Dual
 ;;^UTILITY(U,$J,358.3,1917,0)
 ;;=33249^^12^160^47^^^^1
 ;;^UTILITY(U,$J,358.3,1917,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1917,1,2,0)
 ;;=2^33249
 ;;^UTILITY(U,$J,358.3,1917,1,3,0)
 ;;=3^Remove ICD Leads/Thoracotomy
 ;;^UTILITY(U,$J,358.3,1918,0)
 ;;=92992^^12^161^1^^^^1
 ;;^UTILITY(U,$J,358.3,1918,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1918,1,2,0)
 ;;=2^92992
 ;;^UTILITY(U,$J,358.3,1918,1,3,0)
 ;;=3^Atrial Septectomy Trans Balloon (Inc Cath)
 ;;^UTILITY(U,$J,358.3,1919,0)
 ;;=92993^^12^161^21^^^^1
 ;;^UTILITY(U,$J,358.3,1919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1919,1,2,0)
 ;;=2^92993
 ;;^UTILITY(U,$J,358.3,1919,1,3,0)
 ;;=3^Park Septostomy,Includes Cath
 ;;^UTILITY(U,$J,358.3,1920,0)
 ;;=92975^^12^161^27^^^^1
 ;;^UTILITY(U,$J,358.3,1920,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1920,1,2,0)
 ;;=2^92975
 ;;^UTILITY(U,$J,358.3,1920,1,3,0)
 ;;=3^Thrombo Cor Includes Cor Angiog
 ;;^UTILITY(U,$J,358.3,1921,0)
 ;;=92977^^12^161^28^^^^1
 ;;^UTILITY(U,$J,358.3,1921,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1921,1,2,0)
 ;;=2^92977
 ;;^UTILITY(U,$J,358.3,1921,1,3,0)
 ;;=3^Thrombo Cor,Inc Cor Angio Iv Inf
 ;;^UTILITY(U,$J,358.3,1922,0)
 ;;=92978^^12^161^6^^^^1
 ;;^UTILITY(U,$J,358.3,1922,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1922,1,2,0)
 ;;=2^92978
 ;;^UTILITY(U,$J,358.3,1922,1,3,0)
 ;;=3^Intr Vasc U/S During Diag Eval
 ;;^UTILITY(U,$J,358.3,1923,0)
 ;;=92979^^12^161^7^^^^1
 ;;^UTILITY(U,$J,358.3,1923,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1923,1,2,0)
 ;;=2^92979
 ;;^UTILITY(U,$J,358.3,1923,1,3,0)
 ;;=3^     Each Add'L Vessel (W/92978)
 ;;^UTILITY(U,$J,358.3,1924,0)
 ;;=36010^^12^161^4^^^^1
 ;;^UTILITY(U,$J,358.3,1924,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1924,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,1924,1,3,0)
 ;;=3^Cath Place Svc/Ivc (Sheath)
 ;;^UTILITY(U,$J,358.3,1925,0)
 ;;=36011^^12^161^5^^^^1
 ;;^UTILITY(U,$J,358.3,1925,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1925,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1925,1,3,0)
 ;;=3^Cath Place Vein 1St Order(Sheath
 ;;^UTILITY(U,$J,358.3,1926,0)
 ;;=76930^^12^161^29^^^^1
 ;;^UTILITY(U,$J,358.3,1926,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1926,1,2,0)
 ;;=2^76930
 ;;^UTILITY(U,$J,358.3,1926,1,3,0)
 ;;=3^U/S Guide (W/33010)
 ;;^UTILITY(U,$J,358.3,1927,0)
 ;;=76000^^12^161^2^^^^1
 ;;^UTILITY(U,$J,358.3,1927,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1927,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,1927,1,3,0)
 ;;=3^Cardiac Fluoro<1Hr(No Cath Proc)
 ;;^UTILITY(U,$J,358.3,1928,0)
 ;;=92973^^12^161^22^^^^1
 ;;^UTILITY(U,$J,358.3,1928,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1928,1,2,0)
 ;;=2^92973
 ;;^UTILITY(U,$J,358.3,1928,1,3,0)
 ;;=3^Perc Coronary Thrombectomy Mechanical
 ;;^UTILITY(U,$J,358.3,1929,0)
 ;;=92974^^12^161^3^^^^1
 ;;^UTILITY(U,$J,358.3,1929,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1929,1,2,0)
 ;;=2^92974
 ;;^UTILITY(U,$J,358.3,1929,1,3,0)
 ;;=3^Cath Place Cardio Brachytx
 ;;^UTILITY(U,$J,358.3,1930,0)
 ;;=92920^^12^161^17^^^^1
 ;;^UTILITY(U,$J,358.3,1930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1930,1,2,0)
 ;;=2^92920
 ;;^UTILITY(U,$J,358.3,1930,1,3,0)
 ;;=3^PRQ Cardia Angioplast 1 Art
 ;;^UTILITY(U,$J,358.3,1931,0)
 ;;=92921^^12^161^18^^^^1
 ;;^UTILITY(U,$J,358.3,1931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1931,1,2,0)
 ;;=2^92921
 ;;^UTILITY(U,$J,358.3,1931,1,3,0)
 ;;=3^PRQ Cardiac Angio Addl Art
