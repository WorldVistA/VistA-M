IBDEI1SC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30332,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in relapse
 ;;^UTILITY(U,$J,358.3,30332,1,4,0)
 ;;=4^C95.02
 ;;^UTILITY(U,$J,358.3,30332,2)
 ;;=^5001852
 ;;^UTILITY(U,$J,358.3,30333,0)
 ;;=D45.^^118^1505^58
 ;;^UTILITY(U,$J,358.3,30333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30333,1,3,0)
 ;;=3^Polycythemia vera
 ;;^UTILITY(U,$J,358.3,30333,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,30333,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,30334,0)
 ;;=C95.10^^118^1505^25
 ;;^UTILITY(U,$J,358.3,30334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30334,1,3,0)
 ;;=3^Chronic leukemia of unsp cell type not achieve remission
 ;;^UTILITY(U,$J,358.3,30334,1,4,0)
 ;;=4^C95.10
 ;;^UTILITY(U,$J,358.3,30334,2)
 ;;=^5001853
 ;;^UTILITY(U,$J,358.3,30335,0)
 ;;=C95.11^^118^1505^26
 ;;^UTILITY(U,$J,358.3,30335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30335,1,3,0)
 ;;=3^Chronic leukemia of unspecified cell type, in remission
 ;;^UTILITY(U,$J,358.3,30335,1,4,0)
 ;;=4^C95.11
 ;;^UTILITY(U,$J,358.3,30335,2)
 ;;=^5001854
 ;;^UTILITY(U,$J,358.3,30336,0)
 ;;=C95.12^^118^1505^27
 ;;^UTILITY(U,$J,358.3,30336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30336,1,3,0)
 ;;=3^Chronic leukemia of unspecified cell type, in relapse
 ;;^UTILITY(U,$J,358.3,30336,1,4,0)
 ;;=4^C95.12
 ;;^UTILITY(U,$J,358.3,30336,2)
 ;;=^5001855
 ;;^UTILITY(U,$J,358.3,30337,0)
 ;;=D46.9^^118^1505^51
 ;;^UTILITY(U,$J,358.3,30337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30337,1,3,0)
 ;;=3^Myelodysplastic syndrome, unspecified
 ;;^UTILITY(U,$J,358.3,30337,1,4,0)
 ;;=4^D46.9
 ;;^UTILITY(U,$J,358.3,30337,2)
 ;;=^334031
 ;;^UTILITY(U,$J,358.3,30338,0)
 ;;=C95.90^^118^1505^39
 ;;^UTILITY(U,$J,358.3,30338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30338,1,3,0)
 ;;=3^Leukemia, unspecified not having achieved remission
 ;;^UTILITY(U,$J,358.3,30338,1,4,0)
 ;;=4^C95.90
 ;;^UTILITY(U,$J,358.3,30338,2)
 ;;=^5001856
 ;;^UTILITY(U,$J,358.3,30339,0)
 ;;=C95.91^^118^1505^41
 ;;^UTILITY(U,$J,358.3,30339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30339,1,3,0)
 ;;=3^Leukemia, unspecified, in remission
 ;;^UTILITY(U,$J,358.3,30339,1,4,0)
 ;;=4^C95.91
 ;;^UTILITY(U,$J,358.3,30339,2)
 ;;=^5001857
 ;;^UTILITY(U,$J,358.3,30340,0)
 ;;=C95.92^^118^1505^40
 ;;^UTILITY(U,$J,358.3,30340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30340,1,3,0)
 ;;=3^Leukemia, unspecified, in relapse
 ;;^UTILITY(U,$J,358.3,30340,1,4,0)
 ;;=4^C95.92
 ;;^UTILITY(U,$J,358.3,30340,2)
 ;;=^5001858
 ;;^UTILITY(U,$J,358.3,30341,0)
 ;;=D72.9^^118^1505^35
 ;;^UTILITY(U,$J,358.3,30341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30341,1,3,0)
 ;;=3^Disorder of white blood cells, unspecified
 ;;^UTILITY(U,$J,358.3,30341,1,4,0)
 ;;=4^D72.9
 ;;^UTILITY(U,$J,358.3,30341,2)
 ;;=^5002381
 ;;^UTILITY(U,$J,358.3,30342,0)
 ;;=D75.1^^118^1505^59
 ;;^UTILITY(U,$J,358.3,30342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30342,1,3,0)
 ;;=3^Secondary polycythemia
 ;;^UTILITY(U,$J,358.3,30342,1,4,0)
 ;;=4^D75.1
 ;;^UTILITY(U,$J,358.3,30342,2)
 ;;=^186856
 ;;^UTILITY(U,$J,358.3,30343,0)
 ;;=D75.9^^118^1505^34
 ;;^UTILITY(U,$J,358.3,30343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30343,1,3,0)
 ;;=3^Disease of blood and blood-forming organs, unspecified
 ;;^UTILITY(U,$J,358.3,30343,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,30343,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,30344,0)
 ;;=C7A.010^^118^1505^42
 ;;^UTILITY(U,$J,358.3,30344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30344,1,3,0)
 ;;=3^Malignant carcinoid tumor of the duodenum
