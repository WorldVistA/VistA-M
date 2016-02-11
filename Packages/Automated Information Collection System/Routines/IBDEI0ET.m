IBDEI0ET ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6473,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,6473,2)
 ;;=^5007569^F01.51
 ;;^UTILITY(U,$J,358.3,6474,0)
 ;;=I69.992^^43^401^13
 ;;^UTILITY(U,$J,358.3,6474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6474,1,3,0)
 ;;=3^Facial Weakness Following Cerebrovascular Disease w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6474,1,4,0)
 ;;=4^I69.992
 ;;^UTILITY(U,$J,358.3,6474,2)
 ;;=^5007570^F01.51
 ;;^UTILITY(U,$J,358.3,6475,0)
 ;;=I69.993^^43^401^3
 ;;^UTILITY(U,$J,358.3,6475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6475,1,3,0)
 ;;=3^Ataxia Following Cerebrovascular Disease w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6475,1,4,0)
 ;;=4^I69.993
 ;;^UTILITY(U,$J,358.3,6475,2)
 ;;=^5007571^F01.51
 ;;^UTILITY(U,$J,358.3,6476,0)
 ;;=I69.991^^43^401^12
 ;;^UTILITY(U,$J,358.3,6476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6476,1,3,0)
 ;;=3^Dysphagia Following Cerebrovascular Disease w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6476,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,6476,2)
 ;;=^5007569^F01.50
 ;;^UTILITY(U,$J,358.3,6477,0)
 ;;=I69.992^^43^401^14
 ;;^UTILITY(U,$J,358.3,6477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6477,1,3,0)
 ;;=3^Facial Weakness Following Cerebrovascular Disease w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6477,1,4,0)
 ;;=4^I69.992
 ;;^UTILITY(U,$J,358.3,6477,2)
 ;;=^5007570^F01.50
 ;;^UTILITY(U,$J,358.3,6478,0)
 ;;=I69.993^^43^401^4
 ;;^UTILITY(U,$J,358.3,6478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6478,1,3,0)
 ;;=3^Ataxia Following Cerebrovascular Disease w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6478,1,4,0)
 ;;=4^I69.993
 ;;^UTILITY(U,$J,358.3,6478,2)
 ;;=^5007571^F01.50
 ;;^UTILITY(U,$J,358.3,6479,0)
 ;;=99201^^44^402^1
 ;;^UTILITY(U,$J,358.3,6479,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6479,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,6479,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,6480,0)
 ;;=99202^^44^402^2
 ;;^UTILITY(U,$J,358.3,6480,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6480,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,6480,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,6481,0)
 ;;=99203^^44^402^3
 ;;^UTILITY(U,$J,358.3,6481,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6481,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,6481,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,6482,0)
 ;;=99204^^44^402^4
 ;;^UTILITY(U,$J,358.3,6482,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6482,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,6482,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,6483,0)
 ;;=99205^^44^402^5
 ;;^UTILITY(U,$J,358.3,6483,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6483,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,6483,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,6484,0)
 ;;=99211^^44^403^1
 ;;^UTILITY(U,$J,358.3,6484,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6484,1,1,0)
 ;;=1^Brief (no MD seen)
 ;;^UTILITY(U,$J,358.3,6484,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,6485,0)
 ;;=99212^^44^403^2
 ;;^UTILITY(U,$J,358.3,6485,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6485,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,6485,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,6486,0)
 ;;=99213^^44^403^3
 ;;^UTILITY(U,$J,358.3,6486,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6486,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,6486,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,6487,0)
 ;;=99214^^44^403^4
 ;;^UTILITY(U,$J,358.3,6487,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6487,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,6487,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,6488,0)
 ;;=99215^^44^403^5
