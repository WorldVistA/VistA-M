IBDEI2FM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40834,1,3,0)
 ;;=3^Nondisp dome fx of rt talus, init
 ;;^UTILITY(U,$J,358.3,40834,1,4,0)
 ;;=4^S92.144A
 ;;^UTILITY(U,$J,358.3,40834,2)
 ;;=^5044752
 ;;^UTILITY(U,$J,358.3,40835,0)
 ;;=S92.142A^^189^2086^21
 ;;^UTILITY(U,$J,358.3,40835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40835,1,3,0)
 ;;=3^Disp dome fx of lft talus, init
 ;;^UTILITY(U,$J,358.3,40835,1,4,0)
 ;;=4^S92.142A
 ;;^UTILITY(U,$J,358.3,40835,2)
 ;;=^5044738
 ;;^UTILITY(U,$J,358.3,40836,0)
 ;;=S92.141A^^189^2086^22
 ;;^UTILITY(U,$J,358.3,40836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40836,1,3,0)
 ;;=3^Disp dome fx of rt talus, init
 ;;^UTILITY(U,$J,358.3,40836,1,4,0)
 ;;=4^S92.141A
 ;;^UTILITY(U,$J,358.3,40836,2)
 ;;=^5044731
 ;;^UTILITY(U,$J,358.3,40837,0)
 ;;=S92.101A^^189^2086^219
 ;;^UTILITY(U,$J,358.3,40837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40837,1,3,0)
 ;;=3^Fx of rt talus, unspec, init
 ;;^UTILITY(U,$J,358.3,40837,1,4,0)
 ;;=4^S92.101A
 ;;^UTILITY(U,$J,358.3,40837,2)
 ;;=^5044591
 ;;^UTILITY(U,$J,358.3,40838,0)
 ;;=S92.111A^^189^2086^115
 ;;^UTILITY(U,$J,358.3,40838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40838,1,3,0)
 ;;=3^Disp fx of neck of rt talus, init
 ;;^UTILITY(U,$J,358.3,40838,1,4,0)
 ;;=4^S92.111A
 ;;^UTILITY(U,$J,358.3,40838,2)
 ;;=^5044605
 ;;^UTILITY(U,$J,358.3,40839,0)
 ;;=S92.102A^^189^2086^202
 ;;^UTILITY(U,$J,358.3,40839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40839,1,3,0)
 ;;=3^Fx of lft talus, unspec, init
 ;;^UTILITY(U,$J,358.3,40839,1,4,0)
 ;;=4^S92.102A
 ;;^UTILITY(U,$J,358.3,40839,2)
 ;;=^5044598
 ;;^UTILITY(U,$J,358.3,40840,0)
 ;;=S92.134A^^189^2086^342
 ;;^UTILITY(U,$J,358.3,40840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40840,1,3,0)
 ;;=3^Nondisp fx of posterior process of rt talus, init
 ;;^UTILITY(U,$J,358.3,40840,1,4,0)
 ;;=4^S92.134A
 ;;^UTILITY(U,$J,358.3,40840,2)
 ;;=^5044710
 ;;^UTILITY(U,$J,358.3,40841,0)
 ;;=S92.132A^^189^2086^116
 ;;^UTILITY(U,$J,358.3,40841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40841,1,3,0)
 ;;=3^Disp fx of posterior process of lft talus, init
 ;;^UTILITY(U,$J,358.3,40841,1,4,0)
 ;;=4^S92.132A
 ;;^UTILITY(U,$J,358.3,40841,2)
 ;;=^5044696
 ;;^UTILITY(U,$J,358.3,40842,0)
 ;;=S92.131A^^189^2086^117
 ;;^UTILITY(U,$J,358.3,40842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40842,1,3,0)
 ;;=3^Disp fx of posterior process of rt talus, init
 ;;^UTILITY(U,$J,358.3,40842,1,4,0)
 ;;=4^S92.131A
 ;;^UTILITY(U,$J,358.3,40842,2)
 ;;=^5044689
 ;;^UTILITY(U,$J,358.3,40843,0)
 ;;=S92.125A^^189^2086^307
 ;;^UTILITY(U,$J,358.3,40843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40843,1,3,0)
 ;;=3^Nondisp fx of body of lft talus, init
 ;;^UTILITY(U,$J,358.3,40843,1,4,0)
 ;;=4^S92.125A
 ;;^UTILITY(U,$J,358.3,40843,2)
 ;;=^5044675
 ;;^UTILITY(U,$J,358.3,40844,0)
 ;;=S92.124A^^189^2086^309
 ;;^UTILITY(U,$J,358.3,40844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40844,1,3,0)
 ;;=3^Nondisp fx of body of rt talus, init
 ;;^UTILITY(U,$J,358.3,40844,1,4,0)
 ;;=4^S92.124A
 ;;^UTILITY(U,$J,358.3,40844,2)
 ;;=^5044668
 ;;^UTILITY(U,$J,358.3,40845,0)
 ;;=S92.122A^^189^2086^82
 ;;^UTILITY(U,$J,358.3,40845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40845,1,3,0)
 ;;=3^Disp fx of body of lft talus, init
 ;;^UTILITY(U,$J,358.3,40845,1,4,0)
 ;;=4^S92.122A
 ;;^UTILITY(U,$J,358.3,40845,2)
 ;;=^5044654
 ;;^UTILITY(U,$J,358.3,40846,0)
 ;;=S92.121A^^189^2086^84
 ;;^UTILITY(U,$J,358.3,40846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40846,1,3,0)
 ;;=3^Disp fx of body of rt talus, init
 ;;^UTILITY(U,$J,358.3,40846,1,4,0)
 ;;=4^S92.121A
