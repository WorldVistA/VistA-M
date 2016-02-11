IBDEI1EE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23329,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,23330,0)
 ;;=F43.12^^113^1120^7
 ;;^UTILITY(U,$J,358.3,23330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23330,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,23330,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,23330,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,23331,0)
 ;;=E53.8^^113^1121^1
 ;;^UTILITY(U,$J,358.3,23331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23331,1,3,0)
 ;;=3^B Vitamin Deficiency
 ;;^UTILITY(U,$J,358.3,23331,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,23331,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,23332,0)
 ;;=R00.1^^113^1121^6
 ;;^UTILITY(U,$J,358.3,23332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23332,1,3,0)
 ;;=3^Bradycardia, unspec
 ;;^UTILITY(U,$J,358.3,23332,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,23332,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,23333,0)
 ;;=J20.9^^113^1121^7
 ;;^UTILITY(U,$J,358.3,23333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23333,1,3,0)
 ;;=3^Bronchitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,23333,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,23333,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,23334,0)
 ;;=N32.0^^113^1121^5
 ;;^UTILITY(U,$J,358.3,23334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23334,1,3,0)
 ;;=3^Bladder-neck obstruction
 ;;^UTILITY(U,$J,358.3,23334,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,23334,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,23335,0)
 ;;=N40.0^^113^1121^3
 ;;^UTILITY(U,$J,358.3,23335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23335,1,3,0)
 ;;=3^BPH w/o lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,23335,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,23335,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,23336,0)
 ;;=N40.1^^113^1121^2
 ;;^UTILITY(U,$J,358.3,23336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23336,1,3,0)
 ;;=3^BPH w/ lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,23336,1,4,0)
 ;;=4^N40.1
 ;;^UTILITY(U,$J,358.3,23336,2)
 ;;=^5015690
 ;;^UTILITY(U,$J,358.3,23337,0)
 ;;=M71.50^^113^1121^8
 ;;^UTILITY(U,$J,358.3,23337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23337,1,3,0)
 ;;=3^Bursitis, Site Unspec NEC
 ;;^UTILITY(U,$J,358.3,23337,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,23337,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,23338,0)
 ;;=S39.012A^^113^1121^4
 ;;^UTILITY(U,$J,358.3,23338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23338,1,3,0)
 ;;=3^Back strain, lower, unspec, init encntr
 ;;^UTILITY(U,$J,358.3,23338,1,4,0)
 ;;=4^S39.012A
 ;;^UTILITY(U,$J,358.3,23338,2)
 ;;=^5026102
 ;;^UTILITY(U,$J,358.3,23339,0)
 ;;=F31.10^^113^1122^1
 ;;^UTILITY(U,$J,358.3,23339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23339,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unspec
 ;;^UTILITY(U,$J,358.3,23339,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,23339,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,23340,0)
 ;;=F31.30^^113^1122^2
 ;;^UTILITY(U,$J,358.3,23340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23340,1,3,0)
 ;;=3^Bipolar disord, crnt epsd depress, mild or mod severt, unspec
 ;;^UTILITY(U,$J,358.3,23340,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,23340,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,23341,0)
 ;;=F31.60^^113^1122^3
 ;;^UTILITY(U,$J,358.3,23341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23341,1,3,0)
 ;;=3^Bipolar disorder, current episode mixed, unspec
 ;;^UTILITY(U,$J,358.3,23341,1,4,0)
 ;;=4^F31.60
 ;;^UTILITY(U,$J,358.3,23341,2)
 ;;=^5003505
 ;;^UTILITY(U,$J,358.3,23342,0)
 ;;=F31.9^^113^1122^4
 ;;^UTILITY(U,$J,358.3,23342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23342,1,3,0)
 ;;=3^Bipolar disorder, unspec
