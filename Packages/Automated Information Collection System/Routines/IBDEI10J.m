IBDEI10J ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17184,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,17185,0)
 ;;=N40.0^^73^823^3
 ;;^UTILITY(U,$J,358.3,17185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17185,1,3,0)
 ;;=3^BPH w/o lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,17185,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,17185,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,17186,0)
 ;;=N40.1^^73^823^2
 ;;^UTILITY(U,$J,358.3,17186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17186,1,3,0)
 ;;=3^BPH w/ lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,17186,1,4,0)
 ;;=4^N40.1
 ;;^UTILITY(U,$J,358.3,17186,2)
 ;;=^5015690
 ;;^UTILITY(U,$J,358.3,17187,0)
 ;;=M71.50^^73^823^8
 ;;^UTILITY(U,$J,358.3,17187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17187,1,3,0)
 ;;=3^Bursitis, Site Unspec NEC
 ;;^UTILITY(U,$J,358.3,17187,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,17187,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,17188,0)
 ;;=S39.012A^^73^823^4
 ;;^UTILITY(U,$J,358.3,17188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17188,1,3,0)
 ;;=3^Back strain, lower, unspec, init encntr
 ;;^UTILITY(U,$J,358.3,17188,1,4,0)
 ;;=4^S39.012A
 ;;^UTILITY(U,$J,358.3,17188,2)
 ;;=^5026102
 ;;^UTILITY(U,$J,358.3,17189,0)
 ;;=F31.10^^73^824^1
 ;;^UTILITY(U,$J,358.3,17189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17189,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unspec
 ;;^UTILITY(U,$J,358.3,17189,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,17189,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,17190,0)
 ;;=F31.30^^73^824^2
 ;;^UTILITY(U,$J,358.3,17190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17190,1,3,0)
 ;;=3^Bipolar disord, crnt epsd depress, mild or mod severt, unspec
 ;;^UTILITY(U,$J,358.3,17190,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,17190,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,17191,0)
 ;;=F31.60^^73^824^3
 ;;^UTILITY(U,$J,358.3,17191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17191,1,3,0)
 ;;=3^Bipolar disorder, current episode mixed, unspec
 ;;^UTILITY(U,$J,358.3,17191,1,4,0)
 ;;=4^F31.60
 ;;^UTILITY(U,$J,358.3,17191,2)
 ;;=^5003505
 ;;^UTILITY(U,$J,358.3,17192,0)
 ;;=F31.9^^73^824^4
 ;;^UTILITY(U,$J,358.3,17192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17192,1,3,0)
 ;;=3^Bipolar disorder, unspec
 ;;^UTILITY(U,$J,358.3,17192,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,17192,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,17193,0)
 ;;=C15.9^^73^825^6
 ;;^UTILITY(U,$J,358.3,17193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17193,1,3,0)
 ;;=3^Malig Neop of esophagus, unspec
 ;;^UTILITY(U,$J,358.3,17193,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,17193,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,17194,0)
 ;;=C18.9^^73^825^5
 ;;^UTILITY(U,$J,358.3,17194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17194,1,3,0)
 ;;=3^Malig Neop of colon, unspec
 ;;^UTILITY(U,$J,358.3,17194,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,17194,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,17195,0)
 ;;=C32.9^^73^825^7
 ;;^UTILITY(U,$J,358.3,17195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17195,1,3,0)
 ;;=3^Malig Neop of larynx, unspec
 ;;^UTILITY(U,$J,358.3,17195,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,17195,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,17196,0)
 ;;=C34.91^^73^825^13
 ;;^UTILITY(U,$J,358.3,17196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17196,1,3,0)
 ;;=3^Malig Neop of rt bronchus or lung, unsp part
 ;;^UTILITY(U,$J,358.3,17196,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,17196,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,17197,0)
 ;;=C34.92^^73^825^9
 ;;^UTILITY(U,$J,358.3,17197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17197,1,3,0)
 ;;=3^Malig Neop of lft bronchus or lung, unsp part
