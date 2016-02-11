IBDEI1FE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23805,1,3,0)
 ;;=3^Back strain, lower, unspec, init encntr
 ;;^UTILITY(U,$J,358.3,23805,1,4,0)
 ;;=4^S39.012A
 ;;^UTILITY(U,$J,358.3,23805,2)
 ;;=^5026102
 ;;^UTILITY(U,$J,358.3,23806,0)
 ;;=F31.10^^116^1162^1
 ;;^UTILITY(U,$J,358.3,23806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23806,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unspec
 ;;^UTILITY(U,$J,358.3,23806,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,23806,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,23807,0)
 ;;=F31.30^^116^1162^2
 ;;^UTILITY(U,$J,358.3,23807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23807,1,3,0)
 ;;=3^Bipolar disord, crnt epsd depress, mild or mod severt, unspec
 ;;^UTILITY(U,$J,358.3,23807,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,23807,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,23808,0)
 ;;=F31.60^^116^1162^3
 ;;^UTILITY(U,$J,358.3,23808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23808,1,3,0)
 ;;=3^Bipolar disorder, current episode mixed, unspec
 ;;^UTILITY(U,$J,358.3,23808,1,4,0)
 ;;=4^F31.60
 ;;^UTILITY(U,$J,358.3,23808,2)
 ;;=^5003505
 ;;^UTILITY(U,$J,358.3,23809,0)
 ;;=F31.9^^116^1162^4
 ;;^UTILITY(U,$J,358.3,23809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23809,1,3,0)
 ;;=3^Bipolar disorder, unspec
 ;;^UTILITY(U,$J,358.3,23809,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,23809,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,23810,0)
 ;;=C15.9^^116^1163^6
 ;;^UTILITY(U,$J,358.3,23810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23810,1,3,0)
 ;;=3^Malig Neop of esophagus, unspec
 ;;^UTILITY(U,$J,358.3,23810,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,23810,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,23811,0)
 ;;=C18.9^^116^1163^5
 ;;^UTILITY(U,$J,358.3,23811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23811,1,3,0)
 ;;=3^Malig Neop of colon, unspec
 ;;^UTILITY(U,$J,358.3,23811,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,23811,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,23812,0)
 ;;=C32.9^^116^1163^7
 ;;^UTILITY(U,$J,358.3,23812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23812,1,3,0)
 ;;=3^Malig Neop of larynx, unspec
 ;;^UTILITY(U,$J,358.3,23812,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,23812,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,23813,0)
 ;;=C34.91^^116^1163^13
 ;;^UTILITY(U,$J,358.3,23813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23813,1,3,0)
 ;;=3^Malig Neop of rt bronchus or lung, unsp part
 ;;^UTILITY(U,$J,358.3,23813,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,23813,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,23814,0)
 ;;=C34.92^^116^1163^9
 ;;^UTILITY(U,$J,358.3,23814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23814,1,3,0)
 ;;=3^Malig Neop of lft bronchus or lung, unsp part
 ;;^UTILITY(U,$J,358.3,23814,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,23814,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,23815,0)
 ;;=C44.91^^116^1163^1
 ;;^UTILITY(U,$J,358.3,23815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23815,1,3,0)
 ;;=3^Basal cell carcinoma of skin, unspec
 ;;^UTILITY(U,$J,358.3,23815,1,4,0)
 ;;=4^C44.91
 ;;^UTILITY(U,$J,358.3,23815,2)
 ;;=^5001092
 ;;^UTILITY(U,$J,358.3,23816,0)
 ;;=C44.99^^116^1163^15
 ;;^UTILITY(U,$J,358.3,23816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23816,1,3,0)
 ;;=3^Malig Neop of skin, oth spec, unspec
 ;;^UTILITY(U,$J,358.3,23816,1,4,0)
 ;;=4^C44.99
 ;;^UTILITY(U,$J,358.3,23816,2)
 ;;=^5001094
 ;;^UTILITY(U,$J,358.3,23817,0)
 ;;=C50.912^^116^1163^8
 ;;^UTILITY(U,$J,358.3,23817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23817,1,3,0)
 ;;=3^Malig Neop of lft breast, female, unspec site
 ;;^UTILITY(U,$J,358.3,23817,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,23817,2)
 ;;=^5001196
