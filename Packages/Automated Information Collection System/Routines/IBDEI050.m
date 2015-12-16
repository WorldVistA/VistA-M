IBDEI050 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1821,0)
 ;;=E08.10^^3^56^2
 ;;^UTILITY(U,$J,358.3,1821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1821,1,3,0)
 ;;=3^Diabetes due to underlying condition w ketoacidosis w/o coma
 ;;^UTILITY(U,$J,358.3,1821,1,4,0)
 ;;=4^E08.10
 ;;^UTILITY(U,$J,358.3,1821,2)
 ;;=^5002505
 ;;^UTILITY(U,$J,358.3,1822,0)
 ;;=E09.10^^3^56^41
 ;;^UTILITY(U,$J,358.3,1822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1822,1,3,0)
 ;;=3^Drug/chem diabetes w ketoacidosis w/o coma
 ;;^UTILITY(U,$J,358.3,1822,1,4,0)
 ;;=4^E09.10
 ;;^UTILITY(U,$J,358.3,1822,2)
 ;;=^5002547
 ;;^UTILITY(U,$J,358.3,1823,0)
 ;;=E08.01^^3^56^3
 ;;^UTILITY(U,$J,358.3,1823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1823,1,3,0)
 ;;=3^Diabetes due to underlying condition w hyprosm w coma
 ;;^UTILITY(U,$J,358.3,1823,1,4,0)
 ;;=4^E08.01
 ;;^UTILITY(U,$J,358.3,1823,2)
 ;;=^5002504
 ;;^UTILITY(U,$J,358.3,1824,0)
 ;;=E09.01^^3^56^37
 ;;^UTILITY(U,$J,358.3,1824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1824,1,3,0)
 ;;=3^Drug/chem diabetes w hyperosmolarity w coma
 ;;^UTILITY(U,$J,358.3,1824,1,4,0)
 ;;=4^E09.01
 ;;^UTILITY(U,$J,358.3,1824,2)
 ;;=^5002546
 ;;^UTILITY(U,$J,358.3,1825,0)
 ;;=E08.11^^3^56^4
 ;;^UTILITY(U,$J,358.3,1825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1825,1,3,0)
 ;;=3^Diabetes due to underlying condition w ketoacidosis w coma
 ;;^UTILITY(U,$J,358.3,1825,1,4,0)
 ;;=4^E08.11
 ;;^UTILITY(U,$J,358.3,1825,2)
 ;;=^5002506
 ;;^UTILITY(U,$J,358.3,1826,0)
 ;;=E08.641^^3^56^5
 ;;^UTILITY(U,$J,358.3,1826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1826,1,3,0)
 ;;=3^Diabetes due to underlying condition w hypoglycemia w coma
 ;;^UTILITY(U,$J,358.3,1826,1,4,0)
 ;;=4^E08.641
 ;;^UTILITY(U,$J,358.3,1826,2)
 ;;=^5002539
 ;;^UTILITY(U,$J,358.3,1827,0)
 ;;=E09.11^^3^56^40
 ;;^UTILITY(U,$J,358.3,1827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1827,1,3,0)
 ;;=3^Drug/chem diabetes w ketoacidosis w coma
 ;;^UTILITY(U,$J,358.3,1827,1,4,0)
 ;;=4^E09.11
 ;;^UTILITY(U,$J,358.3,1827,2)
 ;;=^5002548
 ;;^UTILITY(U,$J,358.3,1828,0)
 ;;=E09.641^^3^56^38
 ;;^UTILITY(U,$J,358.3,1828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1828,1,3,0)
 ;;=3^Drug/chem diabetes w hypoglycemia w coma
 ;;^UTILITY(U,$J,358.3,1828,1,4,0)
 ;;=4^E09.641
 ;;^UTILITY(U,$J,358.3,1828,2)
 ;;=^5002581
 ;;^UTILITY(U,$J,358.3,1829,0)
 ;;=E08.21^^3^56^6
 ;;^UTILITY(U,$J,358.3,1829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1829,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic nephropathy
 ;;^UTILITY(U,$J,358.3,1829,1,4,0)
 ;;=4^E08.21
 ;;^UTILITY(U,$J,358.3,1829,2)
 ;;=^5002507
 ;;^UTILITY(U,$J,358.3,1830,0)
 ;;=E09.21^^3^56^34
 ;;^UTILITY(U,$J,358.3,1830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1830,1,3,0)
 ;;=3^Drug/chem diabetes w diabetic nephropathy
 ;;^UTILITY(U,$J,358.3,1830,1,4,0)
 ;;=4^E09.21
 ;;^UTILITY(U,$J,358.3,1830,2)
 ;;=^5002549
 ;;^UTILITY(U,$J,358.3,1831,0)
 ;;=E08.311^^3^56^7
 ;;^UTILITY(U,$J,358.3,1831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1831,1,3,0)
 ;;=3^Diabetes due to underlying condition w unsp diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,1831,1,4,0)
 ;;=4^E08.311
 ;;^UTILITY(U,$J,358.3,1831,2)
 ;;=^5002510
 ;;^UTILITY(U,$J,358.3,1832,0)
 ;;=E08.319^^3^56^8
 ;;^UTILITY(U,$J,358.3,1832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1832,1,3,0)
 ;;=3^Diabetes due to underlying condition w unsp diab rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,1832,1,4,0)
 ;;=4^E08.319
 ;;^UTILITY(U,$J,358.3,1832,2)
 ;;=^5002511
 ;;^UTILITY(U,$J,358.3,1833,0)
 ;;=E08.36^^3^56^9
 ;;^UTILITY(U,$J,358.3,1833,1,0)
 ;;=^358.31IA^4^2
