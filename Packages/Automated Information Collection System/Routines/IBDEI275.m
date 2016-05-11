IBDEI275 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37260,1,3,0)
 ;;=3^Disorders of tendon, lft wrist, oth, spec
 ;;^UTILITY(U,$J,358.3,37260,1,4,0)
 ;;=4^M67.834
 ;;^UTILITY(U,$J,358.3,37260,2)
 ;;=^5012997
 ;;^UTILITY(U,$J,358.3,37261,0)
 ;;=M67.841^^140^1787^115
 ;;^UTILITY(U,$J,358.3,37261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37261,1,3,0)
 ;;=3^Disorders of synovium, rt hand, oth, spec
 ;;^UTILITY(U,$J,358.3,37261,1,4,0)
 ;;=4^M67.841
 ;;^UTILITY(U,$J,358.3,37261,2)
 ;;=^5012999
 ;;^UTILITY(U,$J,358.3,37262,0)
 ;;=M67.842^^140^1787^108
 ;;^UTILITY(U,$J,358.3,37262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37262,1,3,0)
 ;;=3^Disorders of synovium, lft hand, oth, spec
 ;;^UTILITY(U,$J,358.3,37262,1,4,0)
 ;;=4^M67.842
 ;;^UTILITY(U,$J,358.3,37262,2)
 ;;=^5013000
 ;;^UTILITY(U,$J,358.3,37263,0)
 ;;=M67.843^^140^1787^129
 ;;^UTILITY(U,$J,358.3,37263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37263,1,3,0)
 ;;=3^Disorders of tendon, rt hand, oth, spec
 ;;^UTILITY(U,$J,358.3,37263,1,4,0)
 ;;=4^M67.843
 ;;^UTILITY(U,$J,358.3,37263,2)
 ;;=^5013001
 ;;^UTILITY(U,$J,358.3,37264,0)
 ;;=M67.844^^140^1787^122
 ;;^UTILITY(U,$J,358.3,37264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37264,1,3,0)
 ;;=3^Disorders of tendon, lft hand, oth, spec
 ;;^UTILITY(U,$J,358.3,37264,1,4,0)
 ;;=4^M67.844
 ;;^UTILITY(U,$J,358.3,37264,2)
 ;;=^5013002
 ;;^UTILITY(U,$J,358.3,37265,0)
 ;;=M67.851^^140^1787^116
 ;;^UTILITY(U,$J,358.3,37265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37265,1,3,0)
 ;;=3^Disorders of synovium, rt hip, oth, spec
 ;;^UTILITY(U,$J,358.3,37265,1,4,0)
 ;;=4^M67.851
 ;;^UTILITY(U,$J,358.3,37265,2)
 ;;=^5013004
 ;;^UTILITY(U,$J,358.3,37266,0)
 ;;=M67.852^^140^1787^109
 ;;^UTILITY(U,$J,358.3,37266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37266,1,3,0)
 ;;=3^Disorders of synovium, lft hip, oth, spec
 ;;^UTILITY(U,$J,358.3,37266,1,4,0)
 ;;=4^M67.852
 ;;^UTILITY(U,$J,358.3,37266,2)
 ;;=^5013005
 ;;^UTILITY(U,$J,358.3,37267,0)
 ;;=M67.853^^140^1787^130
 ;;^UTILITY(U,$J,358.3,37267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37267,1,3,0)
 ;;=3^Disorders of tendon, rt hip, oth, spec
 ;;^UTILITY(U,$J,358.3,37267,1,4,0)
 ;;=4^M67.853
 ;;^UTILITY(U,$J,358.3,37267,2)
 ;;=^5013006
 ;;^UTILITY(U,$J,358.3,37268,0)
 ;;=M67.854^^140^1787^123
 ;;^UTILITY(U,$J,358.3,37268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37268,1,3,0)
 ;;=3^Disorders of tendon, lft hip, oth, spec
 ;;^UTILITY(U,$J,358.3,37268,1,4,0)
 ;;=4^M67.854
 ;;^UTILITY(U,$J,358.3,37268,2)
 ;;=^5013007
 ;;^UTILITY(U,$J,358.3,37269,0)
 ;;=M67.861^^140^1787^117
 ;;^UTILITY(U,$J,358.3,37269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37269,1,3,0)
 ;;=3^Disorders of synovium, rt knee, oth, spec
 ;;^UTILITY(U,$J,358.3,37269,1,4,0)
 ;;=4^M67.861
 ;;^UTILITY(U,$J,358.3,37269,2)
 ;;=^5013009
 ;;^UTILITY(U,$J,358.3,37270,0)
 ;;=M67.862^^140^1787^110
 ;;^UTILITY(U,$J,358.3,37270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37270,1,3,0)
 ;;=3^Disorders of synovium, lft knee
 ;;^UTILITY(U,$J,358.3,37270,1,4,0)
 ;;=4^M67.862
 ;;^UTILITY(U,$J,358.3,37270,2)
 ;;=^5013010
 ;;^UTILITY(U,$J,358.3,37271,0)
 ;;=M67.863^^140^1787^131
 ;;^UTILITY(U,$J,358.3,37271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37271,1,3,0)
 ;;=3^Disorders of tendon, rt knee, oth, spec
 ;;^UTILITY(U,$J,358.3,37271,1,4,0)
 ;;=4^M67.863
 ;;^UTILITY(U,$J,358.3,37271,2)
 ;;=^5013011
 ;;^UTILITY(U,$J,358.3,37272,0)
 ;;=M67.864^^140^1787^124
 ;;^UTILITY(U,$J,358.3,37272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37272,1,3,0)
 ;;=3^Disorders of tendon, lft knee, oth, spec
 ;;^UTILITY(U,$J,358.3,37272,1,4,0)
 ;;=4^M67.864
