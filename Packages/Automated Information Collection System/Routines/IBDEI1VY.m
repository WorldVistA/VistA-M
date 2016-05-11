IBDEI1VY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32025,0)
 ;;=S92.152A^^126^1609^7
 ;;^UTILITY(U,$J,358.3,32025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32025,1,3,0)
 ;;=3^Disp avulsion fx (chip) of lft talus, init
 ;;^UTILITY(U,$J,358.3,32025,1,4,0)
 ;;=4^S92.152A
 ;;^UTILITY(U,$J,358.3,32025,2)
 ;;=^5044780
 ;;^UTILITY(U,$J,358.3,32026,0)
 ;;=S92.135A^^126^1609^341
 ;;^UTILITY(U,$J,358.3,32026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32026,1,3,0)
 ;;=3^Nondisp fx of posterior process of lft talus, init
 ;;^UTILITY(U,$J,358.3,32026,1,4,0)
 ;;=4^S92.135A
 ;;^UTILITY(U,$J,358.3,32026,2)
 ;;=^5044717
 ;;^UTILITY(U,$J,358.3,32027,0)
 ;;=S92.151A^^126^1609^8
 ;;^UTILITY(U,$J,358.3,32027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32027,1,3,0)
 ;;=3^Disp avulsion fx (chip) of rt talus, init
 ;;^UTILITY(U,$J,358.3,32027,1,4,0)
 ;;=4^S92.151A
 ;;^UTILITY(U,$J,358.3,32027,2)
 ;;=^5044773
 ;;^UTILITY(U,$J,358.3,32028,0)
 ;;=S92.145A^^126^1609^245
 ;;^UTILITY(U,$J,358.3,32028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32028,1,3,0)
 ;;=3^Nondisp dome fx of lft talus, init
 ;;^UTILITY(U,$J,358.3,32028,1,4,0)
 ;;=4^S92.145A
 ;;^UTILITY(U,$J,358.3,32028,2)
 ;;=^5044759
 ;;^UTILITY(U,$J,358.3,32029,0)
 ;;=S92.144A^^126^1609^247
 ;;^UTILITY(U,$J,358.3,32029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32029,1,3,0)
 ;;=3^Nondisp dome fx of rt talus, init
 ;;^UTILITY(U,$J,358.3,32029,1,4,0)
 ;;=4^S92.144A
 ;;^UTILITY(U,$J,358.3,32029,2)
 ;;=^5044752
 ;;^UTILITY(U,$J,358.3,32030,0)
 ;;=S92.142A^^126^1609^21
 ;;^UTILITY(U,$J,358.3,32030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32030,1,3,0)
 ;;=3^Disp dome fx of lft talus, init
 ;;^UTILITY(U,$J,358.3,32030,1,4,0)
 ;;=4^S92.142A
 ;;^UTILITY(U,$J,358.3,32030,2)
 ;;=^5044738
 ;;^UTILITY(U,$J,358.3,32031,0)
 ;;=S92.141A^^126^1609^22
 ;;^UTILITY(U,$J,358.3,32031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32031,1,3,0)
 ;;=3^Disp dome fx of rt talus, init
 ;;^UTILITY(U,$J,358.3,32031,1,4,0)
 ;;=4^S92.141A
 ;;^UTILITY(U,$J,358.3,32031,2)
 ;;=^5044731
 ;;^UTILITY(U,$J,358.3,32032,0)
 ;;=S92.101A^^126^1609^219
 ;;^UTILITY(U,$J,358.3,32032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32032,1,3,0)
 ;;=3^Fx of rt talus, unspec, init
 ;;^UTILITY(U,$J,358.3,32032,1,4,0)
 ;;=4^S92.101A
 ;;^UTILITY(U,$J,358.3,32032,2)
 ;;=^5044591
 ;;^UTILITY(U,$J,358.3,32033,0)
 ;;=S92.111A^^126^1609^115
 ;;^UTILITY(U,$J,358.3,32033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32033,1,3,0)
 ;;=3^Disp fx of neck of rt talus, init
 ;;^UTILITY(U,$J,358.3,32033,1,4,0)
 ;;=4^S92.111A
 ;;^UTILITY(U,$J,358.3,32033,2)
 ;;=^5044605
 ;;^UTILITY(U,$J,358.3,32034,0)
 ;;=S92.102A^^126^1609^202
 ;;^UTILITY(U,$J,358.3,32034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32034,1,3,0)
 ;;=3^Fx of lft talus, unspec, init
 ;;^UTILITY(U,$J,358.3,32034,1,4,0)
 ;;=4^S92.102A
 ;;^UTILITY(U,$J,358.3,32034,2)
 ;;=^5044598
 ;;^UTILITY(U,$J,358.3,32035,0)
 ;;=S92.134A^^126^1609^342
 ;;^UTILITY(U,$J,358.3,32035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32035,1,3,0)
 ;;=3^Nondisp fx of posterior process of rt talus, init
 ;;^UTILITY(U,$J,358.3,32035,1,4,0)
 ;;=4^S92.134A
 ;;^UTILITY(U,$J,358.3,32035,2)
 ;;=^5044710
 ;;^UTILITY(U,$J,358.3,32036,0)
 ;;=S92.132A^^126^1609^116
 ;;^UTILITY(U,$J,358.3,32036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32036,1,3,0)
 ;;=3^Disp fx of posterior process of lft talus, init
 ;;^UTILITY(U,$J,358.3,32036,1,4,0)
 ;;=4^S92.132A
 ;;^UTILITY(U,$J,358.3,32036,2)
 ;;=^5044696
 ;;^UTILITY(U,$J,358.3,32037,0)
 ;;=S92.131A^^126^1609^117
 ;;^UTILITY(U,$J,358.3,32037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32037,1,3,0)
 ;;=3^Disp fx of posterior process of rt talus, init
