IBDEI02F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,583,1,4,0)
 ;;=4^C95.00
 ;;^UTILITY(U,$J,358.3,583,2)
 ;;=^5001850
 ;;^UTILITY(U,$J,358.3,584,0)
 ;;=C95.01^^2^24^5
 ;;^UTILITY(U,$J,358.3,584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,584,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in remission
 ;;^UTILITY(U,$J,358.3,584,1,4,0)
 ;;=4^C95.01
 ;;^UTILITY(U,$J,358.3,584,2)
 ;;=^5001851
 ;;^UTILITY(U,$J,358.3,585,0)
 ;;=C95.02^^2^24^6
 ;;^UTILITY(U,$J,358.3,585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,585,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in relapse
 ;;^UTILITY(U,$J,358.3,585,1,4,0)
 ;;=4^C95.02
 ;;^UTILITY(U,$J,358.3,585,2)
 ;;=^5001852
 ;;^UTILITY(U,$J,358.3,586,0)
 ;;=D45.^^2^24^55
 ;;^UTILITY(U,$J,358.3,586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,586,1,3,0)
 ;;=3^Polycythemia vera
 ;;^UTILITY(U,$J,358.3,586,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,586,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,587,0)
 ;;=C95.10^^2^24^25
 ;;^UTILITY(U,$J,358.3,587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,587,1,3,0)
 ;;=3^Chronic leukemia of unsp cell type not achieve remission
 ;;^UTILITY(U,$J,358.3,587,1,4,0)
 ;;=4^C95.10
 ;;^UTILITY(U,$J,358.3,587,2)
 ;;=^5001853
 ;;^UTILITY(U,$J,358.3,588,0)
 ;;=C95.11^^2^24^26
 ;;^UTILITY(U,$J,358.3,588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,588,1,3,0)
 ;;=3^Chronic leukemia of unspecified cell type, in remission
 ;;^UTILITY(U,$J,358.3,588,1,4,0)
 ;;=4^C95.11
 ;;^UTILITY(U,$J,358.3,588,2)
 ;;=^5001854
 ;;^UTILITY(U,$J,358.3,589,0)
 ;;=C95.12^^2^24^27
 ;;^UTILITY(U,$J,358.3,589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,589,1,3,0)
 ;;=3^Chronic leukemia of unspecified cell type, in relapse
 ;;^UTILITY(U,$J,358.3,589,1,4,0)
 ;;=4^C95.12
 ;;^UTILITY(U,$J,358.3,589,2)
 ;;=^5001855
 ;;^UTILITY(U,$J,358.3,590,0)
 ;;=D46.9^^2^24^48
 ;;^UTILITY(U,$J,358.3,590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,590,1,3,0)
 ;;=3^Myelodysplastic syndrome, unspecified
 ;;^UTILITY(U,$J,358.3,590,1,4,0)
 ;;=4^D46.9
 ;;^UTILITY(U,$J,358.3,590,2)
 ;;=^334031
 ;;^UTILITY(U,$J,358.3,591,0)
 ;;=C95.90^^2^24^36
 ;;^UTILITY(U,$J,358.3,591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,591,1,3,0)
 ;;=3^Leukemia, unspecified not having achieved remission
 ;;^UTILITY(U,$J,358.3,591,1,4,0)
 ;;=4^C95.90
 ;;^UTILITY(U,$J,358.3,591,2)
 ;;=^5001856
 ;;^UTILITY(U,$J,358.3,592,0)
 ;;=C95.91^^2^24^38
 ;;^UTILITY(U,$J,358.3,592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,592,1,3,0)
 ;;=3^Leukemia, unspecified, in remission
 ;;^UTILITY(U,$J,358.3,592,1,4,0)
 ;;=4^C95.91
 ;;^UTILITY(U,$J,358.3,592,2)
 ;;=^5001857
 ;;^UTILITY(U,$J,358.3,593,0)
 ;;=C95.92^^2^24^37
 ;;^UTILITY(U,$J,358.3,593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,593,1,3,0)
 ;;=3^Leukemia, unspecified, in relapse
 ;;^UTILITY(U,$J,358.3,593,1,4,0)
 ;;=4^C95.92
 ;;^UTILITY(U,$J,358.3,593,2)
 ;;=^5001858
 ;;^UTILITY(U,$J,358.3,594,0)
 ;;=D72.9^^2^24^35
 ;;^UTILITY(U,$J,358.3,594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,594,1,3,0)
 ;;=3^Disorder of white blood cells, unspecified
 ;;^UTILITY(U,$J,358.3,594,1,4,0)
 ;;=4^D72.9
 ;;^UTILITY(U,$J,358.3,594,2)
 ;;=^5002381
 ;;^UTILITY(U,$J,358.3,595,0)
 ;;=D75.1^^2^24^56
 ;;^UTILITY(U,$J,358.3,595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,595,1,3,0)
 ;;=3^Secondary polycythemia
 ;;^UTILITY(U,$J,358.3,595,1,4,0)
 ;;=4^D75.1
 ;;^UTILITY(U,$J,358.3,595,2)
 ;;=^186856
 ;;^UTILITY(U,$J,358.3,596,0)
 ;;=D75.9^^2^24^34
 ;;^UTILITY(U,$J,358.3,596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,596,1,3,0)
 ;;=3^Disease of blood and blood-forming organs, unspecified
 ;;^UTILITY(U,$J,358.3,596,1,4,0)
 ;;=4^D75.9
