IBDEI01C ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,87,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,87,1,1,0)
 ;;=1^Problem Focused Hx/Exam;Straight MDM
 ;;^UTILITY(U,$J,358.3,87,1,2,0)
 ;;=2^99324
 ;;^UTILITY(U,$J,358.3,88,0)
 ;;=99325^^2^19^2
 ;;^UTILITY(U,$J,358.3,88,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,88,1,1,0)
 ;;=1^Exp Prob Focus Hx/Exam;Low Complex MDM
 ;;^UTILITY(U,$J,358.3,88,1,2,0)
 ;;=2^99325
 ;;^UTILITY(U,$J,358.3,89,0)
 ;;=99326^^2^19^3
 ;;^UTILITY(U,$J,358.3,89,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,89,1,1,0)
 ;;=1^Detailed Hx/Exam;Mod Complex MDM
 ;;^UTILITY(U,$J,358.3,89,1,2,0)
 ;;=2^99326
 ;;^UTILITY(U,$J,358.3,90,0)
 ;;=99327^^2^19^4
 ;;^UTILITY(U,$J,358.3,90,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,90,1,1,0)
 ;;=1^Comp Hx/Exam;Mod Complex MDM
 ;;^UTILITY(U,$J,358.3,90,1,2,0)
 ;;=2^99327
 ;;^UTILITY(U,$J,358.3,91,0)
 ;;=99328^^2^19^5
 ;;^UTILITY(U,$J,358.3,91,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,91,1,1,0)
 ;;=1^Comp Hx/Exam;High Complex MDM
 ;;^UTILITY(U,$J,358.3,91,1,2,0)
 ;;=2^99328
 ;;^UTILITY(U,$J,358.3,92,0)
 ;;=99347^^2^20^1
 ;;^UTILITY(U,$J,358.3,92,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,92,1,1,0)
 ;;=1^Problem Focused Hx/Exam;Straight MDM
 ;;^UTILITY(U,$J,358.3,92,1,2,0)
 ;;=2^99347
 ;;^UTILITY(U,$J,358.3,93,0)
 ;;=99348^^2^20^2
 ;;^UTILITY(U,$J,358.3,93,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,93,1,1,0)
 ;;=1^Exp Prob Focus Hx/Exam;Low Complex MDM
 ;;^UTILITY(U,$J,358.3,93,1,2,0)
 ;;=2^99348
 ;;^UTILITY(U,$J,358.3,94,0)
 ;;=99349^^2^20^3
 ;;^UTILITY(U,$J,358.3,94,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,94,1,1,0)
 ;;=1^Detailed Dx/Exam;Mod Complex MDM
 ;;^UTILITY(U,$J,358.3,94,1,2,0)
 ;;=2^99349
 ;;^UTILITY(U,$J,358.3,95,0)
 ;;=99350^^2^20^4
 ;;^UTILITY(U,$J,358.3,95,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,95,1,1,0)
 ;;=1^Comp Hx/Exam;High Complex MDM
 ;;^UTILITY(U,$J,358.3,95,1,2,0)
 ;;=2^99350
 ;;^UTILITY(U,$J,358.3,96,0)
 ;;=99342^^2^21^1
 ;;^UTILITY(U,$J,358.3,96,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,96,1,1,0)
 ;;=1^Exp Prob Fuocus Hx/Exam;Low Complex MDM
 ;;^UTILITY(U,$J,358.3,96,1,2,0)
 ;;=2^99342
 ;;^UTILITY(U,$J,358.3,97,0)
 ;;=99343^^2^21^2
 ;;^UTILITY(U,$J,358.3,97,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,97,1,1,0)
 ;;=1^Detailed Hx/Exam;Mod Complex MDM
 ;;^UTILITY(U,$J,358.3,97,1,2,0)
 ;;=2^99343
 ;;^UTILITY(U,$J,358.3,98,0)
 ;;=99344^^2^21^3
 ;;^UTILITY(U,$J,358.3,98,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,98,1,1,0)
 ;;=1^Comp Hx/Exam;Mod Complex MDM
 ;;^UTILITY(U,$J,358.3,98,1,2,0)
 ;;=2^99344
 ;;^UTILITY(U,$J,358.3,99,0)
 ;;=99345^^2^21^4
 ;;^UTILITY(U,$J,358.3,99,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,99,1,1,0)
 ;;=1^Comp Hx/Exam;High Complex MDM
 ;;^UTILITY(U,$J,358.3,99,1,2,0)
 ;;=2^99345
 ;;^UTILITY(U,$J,358.3,100,0)
 ;;=99366^^2^22^2
 ;;^UTILITY(U,$J,358.3,100,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,100,1,1,0)
 ;;=1^Team Conf,HCP,Pt Present > 29 Min
 ;;^UTILITY(U,$J,358.3,100,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,101,0)
 ;;=99367^^2^22^3
 ;;^UTILITY(U,$J,358.3,101,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,101,1,1,0)
 ;;=1^Team Conf,Phys,Pt Not Present > 29 Min
 ;;^UTILITY(U,$J,358.3,101,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,102,0)
 ;;=99368^^2^22^1
 ;;^UTILITY(U,$J,358.3,102,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,102,1,1,0)
 ;;=1^Team Conf,HCP,Pt Not Present > 29 Min
 ;;^UTILITY(U,$J,358.3,102,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,103,0)
 ;;=309.24^^3^23^3
 ;;^UTILITY(U,$J,358.3,103,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,103,1,2,0)
 ;;=2^309.24
 ;;^UTILITY(U,$J,358.3,103,1,5,0)
 ;;=5^Adj Reac w/Anx Mood
