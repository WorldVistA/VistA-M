IBDEI1X0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32488,2)
 ;;=^5011664
 ;;^UTILITY(U,$J,358.3,32489,0)
 ;;=L60.1^^126^1616^15
 ;;^UTILITY(U,$J,358.3,32489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32489,1,3,0)
 ;;=3^Onycholysis
 ;;^UTILITY(U,$J,358.3,32489,1,4,0)
 ;;=4^L60.1
 ;;^UTILITY(U,$J,358.3,32489,2)
 ;;=^186837
 ;;^UTILITY(U,$J,358.3,32490,0)
 ;;=M86.272^^126^1616^30
 ;;^UTILITY(U,$J,358.3,32490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32490,1,3,0)
 ;;=3^Subacute osteomyelitis, lft ankl & foot
 ;;^UTILITY(U,$J,358.3,32490,1,4,0)
 ;;=4^M86.272
 ;;^UTILITY(U,$J,358.3,32490,2)
 ;;=^5014555
 ;;^UTILITY(U,$J,358.3,32491,0)
 ;;=M86.071^^126^1616^2
 ;;^UTILITY(U,$J,358.3,32491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32491,1,3,0)
 ;;=3^Acute hematogenous osteomyelitis, rt ankl & ft
 ;;^UTILITY(U,$J,358.3,32491,1,4,0)
 ;;=4^M86.071
 ;;^UTILITY(U,$J,358.3,32491,2)
 ;;=^5014516
 ;;^UTILITY(U,$J,358.3,32492,0)
 ;;=M86.072^^126^1616^1
 ;;^UTILITY(U,$J,358.3,32492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32492,1,3,0)
 ;;=3^Acute hematogenous osteomyelitis, lft ankl & ft
 ;;^UTILITY(U,$J,358.3,32492,1,4,0)
 ;;=4^M86.072
 ;;^UTILITY(U,$J,358.3,32492,2)
 ;;=^5014517
 ;;^UTILITY(U,$J,358.3,32493,0)
 ;;=M86.171^^126^1616^4
 ;;^UTILITY(U,$J,358.3,32493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32493,1,3,0)
 ;;=3^Acute osteomyelitis, rt ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,32493,1,4,0)
 ;;=4^M86.171
 ;;^UTILITY(U,$J,358.3,32493,2)
 ;;=^5014530
 ;;^UTILITY(U,$J,358.3,32494,0)
 ;;=M86.172^^126^1616^3
 ;;^UTILITY(U,$J,358.3,32494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32494,1,3,0)
 ;;=3^Acute osteomyelitis, lft ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,32494,1,4,0)
 ;;=4^M86.172
 ;;^UTILITY(U,$J,358.3,32494,2)
 ;;=^5014531
 ;;^UTILITY(U,$J,358.3,32495,0)
 ;;=M86.271^^126^1616^31
 ;;^UTILITY(U,$J,358.3,32495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32495,1,3,0)
 ;;=3^Subacute osteomyelitis, rt ankl & ft
 ;;^UTILITY(U,$J,358.3,32495,1,4,0)
 ;;=4^M86.271
 ;;^UTILITY(U,$J,358.3,32495,2)
 ;;=^5014554
 ;;^UTILITY(U,$J,358.3,32496,0)
 ;;=M86.571^^126^1616^6
 ;;^UTILITY(U,$J,358.3,32496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32496,1,3,0)
 ;;=3^Chronic hematogenous osteomyel, rt ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,32496,1,4,0)
 ;;=4^M86.571
 ;;^UTILITY(U,$J,358.3,32496,2)
 ;;=^5014626
 ;;^UTILITY(U,$J,358.3,32497,0)
 ;;=M86.572^^126^1616^5
 ;;^UTILITY(U,$J,358.3,32497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32497,1,3,0)
 ;;=3^Chronic hematogenous osteomyel, lft ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,32497,1,4,0)
 ;;=4^M86.572
 ;;^UTILITY(U,$J,358.3,32497,2)
 ;;=^5014627
 ;;^UTILITY(U,$J,358.3,32498,0)
 ;;=M86.671^^126^1616^10
 ;;^UTILITY(U,$J,358.3,32498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32498,1,3,0)
 ;;=3^Chronic osteomyelitis, rt ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,32498,1,4,0)
 ;;=4^M86.671
 ;;^UTILITY(U,$J,358.3,32498,2)
 ;;=^5014641
 ;;^UTILITY(U,$J,358.3,32499,0)
 ;;=M86.672^^126^1616^9
 ;;^UTILITY(U,$J,358.3,32499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32499,1,3,0)
 ;;=3^Chronic osteomyelitis, lft ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,32499,1,4,0)
 ;;=4^M86.672
 ;;^UTILITY(U,$J,358.3,32499,2)
 ;;=^5014642
 ;;^UTILITY(U,$J,358.3,32500,0)
 ;;=M86.8X7^^126^1616^21
 ;;^UTILITY(U,$J,358.3,32500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32500,1,3,0)
 ;;=3^Osteomyelitis, ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,32500,1,4,0)
 ;;=4^M86.8X7
 ;;^UTILITY(U,$J,358.3,32500,2)
 ;;=^5014653
 ;;^UTILITY(U,$J,358.3,32501,0)
 ;;=M86.371^^126^1616^8
 ;;^UTILITY(U,$J,358.3,32501,1,0)
 ;;=^358.31IA^4^2
