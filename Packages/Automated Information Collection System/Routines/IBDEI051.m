IBDEI051 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1833,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic cataract
 ;;^UTILITY(U,$J,358.3,1833,1,4,0)
 ;;=4^E08.36
 ;;^UTILITY(U,$J,358.3,1833,2)
 ;;=^5002520
 ;;^UTILITY(U,$J,358.3,1834,0)
 ;;=E08.39^^3^56^10
 ;;^UTILITY(U,$J,358.3,1834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1834,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth diabetic opth comp
 ;;^UTILITY(U,$J,358.3,1834,1,4,0)
 ;;=4^E08.39
 ;;^UTILITY(U,$J,358.3,1834,2)
 ;;=^5002521
 ;;^UTILITY(U,$J,358.3,1835,0)
 ;;=E09.311^^3^56^56
 ;;^UTILITY(U,$J,358.3,1835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1835,1,3,0)
 ;;=3^Drug/chem diabetes w unsp diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,1835,1,4,0)
 ;;=4^E09.311
 ;;^UTILITY(U,$J,358.3,1835,2)
 ;;=^5002552
 ;;^UTILITY(U,$J,358.3,1836,0)
 ;;=E09.319^^3^56^57
 ;;^UTILITY(U,$J,358.3,1836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1836,1,3,0)
 ;;=3^Drug/chem diabetes w unsp diabetic rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,1836,1,4,0)
 ;;=4^E09.319
 ;;^UTILITY(U,$J,358.3,1836,2)
 ;;=^5002553
 ;;^UTILITY(U,$J,358.3,1837,0)
 ;;=E09.36^^3^56^32
 ;;^UTILITY(U,$J,358.3,1837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1837,1,3,0)
 ;;=3^Drug/chem diabetes w diabetic cataract
 ;;^UTILITY(U,$J,358.3,1837,1,4,0)
 ;;=4^E09.36
 ;;^UTILITY(U,$J,358.3,1837,2)
 ;;=^5002562
 ;;^UTILITY(U,$J,358.3,1838,0)
 ;;=E09.39^^3^56^51
 ;;^UTILITY(U,$J,358.3,1838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1838,1,3,0)
 ;;=3^Drug/chem diabetes w oth diabetic ophthalmic complication
 ;;^UTILITY(U,$J,358.3,1838,1,4,0)
 ;;=4^E09.39
 ;;^UTILITY(U,$J,358.3,1838,2)
 ;;=^5002563
 ;;^UTILITY(U,$J,358.3,1839,0)
 ;;=E08.40^^3^56^11
 ;;^UTILITY(U,$J,358.3,1839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1839,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic neurop, unsp
 ;;^UTILITY(U,$J,358.3,1839,1,4,0)
 ;;=4^E08.40
 ;;^UTILITY(U,$J,358.3,1839,2)
 ;;=^5002522
 ;;^UTILITY(U,$J,358.3,1840,0)
 ;;=E08.41^^3^56^12
 ;;^UTILITY(U,$J,358.3,1840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1840,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic mononeuropathy
 ;;^UTILITY(U,$J,358.3,1840,1,4,0)
 ;;=4^E08.41
 ;;^UTILITY(U,$J,358.3,1840,2)
 ;;=^5002523
 ;;^UTILITY(U,$J,358.3,1841,0)
 ;;=E08.42^^3^56^13
 ;;^UTILITY(U,$J,358.3,1841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1841,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic polyneurop
 ;;^UTILITY(U,$J,358.3,1841,1,4,0)
 ;;=4^E08.42
 ;;^UTILITY(U,$J,358.3,1841,2)
 ;;=^5002524
 ;;^UTILITY(U,$J,358.3,1842,0)
 ;;=E08.43^^3^56^14
 ;;^UTILITY(U,$J,358.3,1842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1842,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic autonm (poly)neuropathy
 ;;^UTILITY(U,$J,358.3,1842,1,4,0)
 ;;=4^E08.43
 ;;^UTILITY(U,$J,358.3,1842,2)
 ;;=^5002525
 ;;^UTILITY(U,$J,358.3,1843,0)
 ;;=E08.44^^3^56^15
 ;;^UTILITY(U,$J,358.3,1843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1843,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic amyotrophy
 ;;^UTILITY(U,$J,358.3,1843,1,4,0)
 ;;=4^E08.44
 ;;^UTILITY(U,$J,358.3,1843,2)
 ;;=^5002526
 ;;^UTILITY(U,$J,358.3,1844,0)
 ;;=E08.49^^3^56^16
 ;;^UTILITY(U,$J,358.3,1844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1844,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth diabetic neuro comp
 ;;^UTILITY(U,$J,358.3,1844,1,4,0)
 ;;=4^E08.49
 ;;^UTILITY(U,$J,358.3,1844,2)
 ;;=^5002527
 ;;^UTILITY(U,$J,358.3,1845,0)
 ;;=E08.610^^3^56^17
 ;;^UTILITY(U,$J,358.3,1845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1845,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic neuropathic arthrop
