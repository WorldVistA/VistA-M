IBDEI01U ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,398,0)
 ;;=99335^^3^40^2
 ;;^UTILITY(U,$J,358.3,398,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,398,1,1,0)
 ;;=1^Exp Prob Focus Hx/Exam;Low Complex MDM
 ;;^UTILITY(U,$J,358.3,398,1,2,0)
 ;;=2^99335
 ;;^UTILITY(U,$J,358.3,399,0)
 ;;=99336^^3^40^3
 ;;^UTILITY(U,$J,358.3,399,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,399,1,1,0)
 ;;=1^Detailed Hx/Exam;Mod Complex MDM
 ;;^UTILITY(U,$J,358.3,399,1,2,0)
 ;;=2^99336
 ;;^UTILITY(U,$J,358.3,400,0)
 ;;=99337^^3^40^4
 ;;^UTILITY(U,$J,358.3,400,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,400,1,1,0)
 ;;=1^Comp Hx/Exam;Mod Complex MDM
 ;;^UTILITY(U,$J,358.3,400,1,2,0)
 ;;=2^99337
 ;;^UTILITY(U,$J,358.3,401,0)
 ;;=99324^^3^41^1
 ;;^UTILITY(U,$J,358.3,401,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,401,1,1,0)
 ;;=1^Problem Focused Hx/Exam;Straight MDM
 ;;^UTILITY(U,$J,358.3,401,1,2,0)
 ;;=2^99324
 ;;^UTILITY(U,$J,358.3,402,0)
 ;;=99325^^3^41^2
 ;;^UTILITY(U,$J,358.3,402,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,402,1,1,0)
 ;;=1^Exp Prob Focus Hx/Exam;Low Complex MDM
 ;;^UTILITY(U,$J,358.3,402,1,2,0)
 ;;=2^99325
 ;;^UTILITY(U,$J,358.3,403,0)
 ;;=99326^^3^41^3
 ;;^UTILITY(U,$J,358.3,403,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,403,1,1,0)
 ;;=1^Detailed Hx/Exam;Mod Complex MDM
 ;;^UTILITY(U,$J,358.3,403,1,2,0)
 ;;=2^99326
 ;;^UTILITY(U,$J,358.3,404,0)
 ;;=99327^^3^41^4
 ;;^UTILITY(U,$J,358.3,404,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,404,1,1,0)
 ;;=1^Comp Hx/Exam;Mod Complex MDM
 ;;^UTILITY(U,$J,358.3,404,1,2,0)
 ;;=2^99327
 ;;^UTILITY(U,$J,358.3,405,0)
 ;;=99328^^3^41^5
 ;;^UTILITY(U,$J,358.3,405,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,405,1,1,0)
 ;;=1^Comp Hx/Exam;High Complex MDM
 ;;^UTILITY(U,$J,358.3,405,1,2,0)
 ;;=2^99328
 ;;^UTILITY(U,$J,358.3,406,0)
 ;;=99201^^4^42^1
 ;;^UTILITY(U,$J,358.3,406,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,406,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,406,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,407,0)
 ;;=99202^^4^42^2
 ;;^UTILITY(U,$J,358.3,407,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,407,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,407,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,408,0)
 ;;=99203^^4^42^3
 ;;^UTILITY(U,$J,358.3,408,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,408,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,408,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,409,0)
 ;;=99204^^4^42^4
 ;;^UTILITY(U,$J,358.3,409,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,409,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,409,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,410,0)
 ;;=99205^^4^42^5
 ;;^UTILITY(U,$J,358.3,410,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,410,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,410,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,411,0)
 ;;=99211^^4^43^1
 ;;^UTILITY(U,$J,358.3,411,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,411,1,1,0)
 ;;=1^Brief (no MD seen)
 ;;^UTILITY(U,$J,358.3,411,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,412,0)
 ;;=99212^^4^43^2
 ;;^UTILITY(U,$J,358.3,412,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,412,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,412,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,413,0)
 ;;=99213^^4^43^3
 ;;^UTILITY(U,$J,358.3,413,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,413,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,413,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,414,0)
 ;;=99214^^4^43^4
 ;;^UTILITY(U,$J,358.3,414,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,414,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,414,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,415,0)
 ;;=99215^^4^43^5
