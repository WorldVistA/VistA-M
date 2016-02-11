IBDEI2IR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42276,1,3,0)
 ;;=3^Disp dome fx of lft talus, init
 ;;^UTILITY(U,$J,358.3,42276,1,4,0)
 ;;=4^S92.142A
 ;;^UTILITY(U,$J,358.3,42276,2)
 ;;=^5044738
 ;;^UTILITY(U,$J,358.3,42277,0)
 ;;=S92.141A^^192^2137^22
 ;;^UTILITY(U,$J,358.3,42277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42277,1,3,0)
 ;;=3^Disp dome fx of rt talus, init
 ;;^UTILITY(U,$J,358.3,42277,1,4,0)
 ;;=4^S92.141A
 ;;^UTILITY(U,$J,358.3,42277,2)
 ;;=^5044731
 ;;^UTILITY(U,$J,358.3,42278,0)
 ;;=S92.101A^^192^2137^219
 ;;^UTILITY(U,$J,358.3,42278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42278,1,3,0)
 ;;=3^Fx of rt talus, unspec, init
 ;;^UTILITY(U,$J,358.3,42278,1,4,0)
 ;;=4^S92.101A
 ;;^UTILITY(U,$J,358.3,42278,2)
 ;;=^5044591
 ;;^UTILITY(U,$J,358.3,42279,0)
 ;;=S92.111A^^192^2137^115
 ;;^UTILITY(U,$J,358.3,42279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42279,1,3,0)
 ;;=3^Disp fx of neck of rt talus, init
 ;;^UTILITY(U,$J,358.3,42279,1,4,0)
 ;;=4^S92.111A
 ;;^UTILITY(U,$J,358.3,42279,2)
 ;;=^5044605
 ;;^UTILITY(U,$J,358.3,42280,0)
 ;;=S92.102A^^192^2137^202
 ;;^UTILITY(U,$J,358.3,42280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42280,1,3,0)
 ;;=3^Fx of lft talus, unspec, init
 ;;^UTILITY(U,$J,358.3,42280,1,4,0)
 ;;=4^S92.102A
 ;;^UTILITY(U,$J,358.3,42280,2)
 ;;=^5044598
 ;;^UTILITY(U,$J,358.3,42281,0)
 ;;=S92.134A^^192^2137^342
 ;;^UTILITY(U,$J,358.3,42281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42281,1,3,0)
 ;;=3^Nondisp fx of posterior process of rt talus, init
 ;;^UTILITY(U,$J,358.3,42281,1,4,0)
 ;;=4^S92.134A
 ;;^UTILITY(U,$J,358.3,42281,2)
 ;;=^5044710
 ;;^UTILITY(U,$J,358.3,42282,0)
 ;;=S92.132A^^192^2137^116
 ;;^UTILITY(U,$J,358.3,42282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42282,1,3,0)
 ;;=3^Disp fx of posterior process of lft talus, init
 ;;^UTILITY(U,$J,358.3,42282,1,4,0)
 ;;=4^S92.132A
 ;;^UTILITY(U,$J,358.3,42282,2)
 ;;=^5044696
 ;;^UTILITY(U,$J,358.3,42283,0)
 ;;=S92.131A^^192^2137^117
 ;;^UTILITY(U,$J,358.3,42283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42283,1,3,0)
 ;;=3^Disp fx of posterior process of rt talus, init
 ;;^UTILITY(U,$J,358.3,42283,1,4,0)
 ;;=4^S92.131A
 ;;^UTILITY(U,$J,358.3,42283,2)
 ;;=^5044689
 ;;^UTILITY(U,$J,358.3,42284,0)
 ;;=S92.125A^^192^2137^307
 ;;^UTILITY(U,$J,358.3,42284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42284,1,3,0)
 ;;=3^Nondisp fx of body of lft talus, init
 ;;^UTILITY(U,$J,358.3,42284,1,4,0)
 ;;=4^S92.125A
 ;;^UTILITY(U,$J,358.3,42284,2)
 ;;=^5044675
 ;;^UTILITY(U,$J,358.3,42285,0)
 ;;=S92.124A^^192^2137^309
 ;;^UTILITY(U,$J,358.3,42285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42285,1,3,0)
 ;;=3^Nondisp fx of body of rt talus, init
 ;;^UTILITY(U,$J,358.3,42285,1,4,0)
 ;;=4^S92.124A
 ;;^UTILITY(U,$J,358.3,42285,2)
 ;;=^5044668
 ;;^UTILITY(U,$J,358.3,42286,0)
 ;;=S92.122A^^192^2137^82
 ;;^UTILITY(U,$J,358.3,42286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42286,1,3,0)
 ;;=3^Disp fx of body of lft talus, init
 ;;^UTILITY(U,$J,358.3,42286,1,4,0)
 ;;=4^S92.122A
 ;;^UTILITY(U,$J,358.3,42286,2)
 ;;=^5044654
 ;;^UTILITY(U,$J,358.3,42287,0)
 ;;=S92.121A^^192^2137^84
 ;;^UTILITY(U,$J,358.3,42287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42287,1,3,0)
 ;;=3^Disp fx of body of rt talus, init
 ;;^UTILITY(U,$J,358.3,42287,1,4,0)
 ;;=4^S92.121A
 ;;^UTILITY(U,$J,358.3,42287,2)
 ;;=^5044647
 ;;^UTILITY(U,$J,358.3,42288,0)
 ;;=S92.115A^^192^2137^339
 ;;^UTILITY(U,$J,358.3,42288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42288,1,3,0)
 ;;=3^Nondisp fx of neck of lft talus, init
 ;;^UTILITY(U,$J,358.3,42288,1,4,0)
 ;;=4^S92.115A
