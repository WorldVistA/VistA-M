IBDEI0FX ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6878,1,3,0)
 ;;=3^Cervical Disc Disorders at C4-C5 w/ Myelopathy
 ;;^UTILITY(U,$J,358.3,6878,1,4,0)
 ;;=4^M50.021
 ;;^UTILITY(U,$J,358.3,6878,2)
 ;;=^5138809
 ;;^UTILITY(U,$J,358.3,6879,0)
 ;;=M50.022^^56^441^13
 ;;^UTILITY(U,$J,358.3,6879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6879,1,3,0)
 ;;=3^Cervical Disc Disorders at C5-C6 w/ Myelopathy
 ;;^UTILITY(U,$J,358.3,6879,1,4,0)
 ;;=4^M50.022
 ;;^UTILITY(U,$J,358.3,6879,2)
 ;;=^5138810
 ;;^UTILITY(U,$J,358.3,6880,0)
 ;;=M50.023^^56^441^17
 ;;^UTILITY(U,$J,358.3,6880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6880,1,3,0)
 ;;=3^Cervical Disc Disorders at C6-C7 w/ Myelopathy
 ;;^UTILITY(U,$J,358.3,6880,1,4,0)
 ;;=4^M50.023
 ;;^UTILITY(U,$J,358.3,6880,2)
 ;;=^5138811
 ;;^UTILITY(U,$J,358.3,6881,0)
 ;;=M50.121^^56^441^10
 ;;^UTILITY(U,$J,358.3,6881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6881,1,3,0)
 ;;=3^Cervical Disc Disorders at C4-C5 w/ Radiculopathy
 ;;^UTILITY(U,$J,358.3,6881,1,4,0)
 ;;=4^M50.121
 ;;^UTILITY(U,$J,358.3,6881,2)
 ;;=^5138813
 ;;^UTILITY(U,$J,358.3,6882,0)
 ;;=M50.122^^56^441^14
 ;;^UTILITY(U,$J,358.3,6882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6882,1,3,0)
 ;;=3^Cervical Disc Disorders at C5-C6 w/ Radiculopathy
 ;;^UTILITY(U,$J,358.3,6882,1,4,0)
 ;;=4^M50.122
 ;;^UTILITY(U,$J,358.3,6882,2)
 ;;=^5138814
 ;;^UTILITY(U,$J,358.3,6883,0)
 ;;=M50.123^^56^441^18
 ;;^UTILITY(U,$J,358.3,6883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6883,1,3,0)
 ;;=3^Cervical Disc Disorders at C6-C7 w/ Radiculopathy
 ;;^UTILITY(U,$J,358.3,6883,1,4,0)
 ;;=4^M50.123
 ;;^UTILITY(U,$J,358.3,6883,2)
 ;;=^5138815
 ;;^UTILITY(U,$J,358.3,6884,0)
 ;;=M50.221^^56^441^21
 ;;^UTILITY(U,$J,358.3,6884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6884,1,3,0)
 ;;=3^Cervical Disc Displacement at C4-C5
 ;;^UTILITY(U,$J,358.3,6884,1,4,0)
 ;;=4^M50.221
 ;;^UTILITY(U,$J,358.3,6884,2)
 ;;=^5138817
 ;;^UTILITY(U,$J,358.3,6885,0)
 ;;=M50.222^^56^441^22
 ;;^UTILITY(U,$J,358.3,6885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6885,1,3,0)
 ;;=3^Cervical Disc Displacement at C5-C6
 ;;^UTILITY(U,$J,358.3,6885,1,4,0)
 ;;=4^M50.222
 ;;^UTILITY(U,$J,358.3,6885,2)
 ;;=^5138818
 ;;^UTILITY(U,$J,358.3,6886,0)
 ;;=M50.223^^56^441^23
 ;;^UTILITY(U,$J,358.3,6886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6886,1,3,0)
 ;;=3^Cervical Disc Displacement at C6-C7
 ;;^UTILITY(U,$J,358.3,6886,1,4,0)
 ;;=4^M50.223
 ;;^UTILITY(U,$J,358.3,6886,2)
 ;;=^5138819
 ;;^UTILITY(U,$J,358.3,6887,0)
 ;;=M99.88^^56^442^1
 ;;^UTILITY(U,$J,358.3,6887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6887,1,3,0)
 ;;=3^Biomechanical lesions of rib cage
 ;;^UTILITY(U,$J,358.3,6887,1,4,0)
 ;;=4^M99.88
 ;;^UTILITY(U,$J,358.3,6887,2)
 ;;=^5015488
 ;;^UTILITY(U,$J,358.3,6888,0)
 ;;=M99.82^^56^442^2
 ;;^UTILITY(U,$J,358.3,6888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6888,1,3,0)
 ;;=3^Biomechanical lesions of thoracic region
 ;;^UTILITY(U,$J,358.3,6888,1,4,0)
 ;;=4^M99.82
 ;;^UTILITY(U,$J,358.3,6888,2)
 ;;=^5015482
 ;;^UTILITY(U,$J,358.3,6889,0)
 ;;=M51.24^^56^442^5
 ;;^UTILITY(U,$J,358.3,6889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6889,1,3,0)
 ;;=3^Intervertebral disc displacement, thoracic region
 ;;^UTILITY(U,$J,358.3,6889,1,4,0)
 ;;=4^M51.24
 ;;^UTILITY(U,$J,358.3,6889,2)
 ;;=^5012247
 ;;^UTILITY(U,$J,358.3,6890,0)
 ;;=M51.34^^56^442^3
 ;;^UTILITY(U,$J,358.3,6890,1,0)
 ;;=^358.31IA^4^2
