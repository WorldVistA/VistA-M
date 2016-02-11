IBDEI28Y ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37723,1,3,0)
 ;;=3^Sprain of left wrist, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37723,1,4,0)
 ;;=4^S63.502D
 ;;^UTILITY(U,$J,358.3,37723,2)
 ;;=^5035587
 ;;^UTILITY(U,$J,358.3,37724,0)
 ;;=S63.501D^^172^1890^30
 ;;^UTILITY(U,$J,358.3,37724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37724,1,3,0)
 ;;=3^Sprain of right wrist, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37724,1,4,0)
 ;;=4^S63.501D
 ;;^UTILITY(U,$J,358.3,37724,2)
 ;;=^5035584
 ;;^UTILITY(U,$J,358.3,37725,0)
 ;;=S52.501D^^172^1890^12
 ;;^UTILITY(U,$J,358.3,37725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37725,1,3,0)
 ;;=3^Fracture of the lower end of right radius, subs encntr
 ;;^UTILITY(U,$J,358.3,37725,1,4,0)
 ;;=4^S52.501D
 ;;^UTILITY(U,$J,358.3,37725,2)
 ;;=^5030590
 ;;^UTILITY(U,$J,358.3,37726,0)
 ;;=Z89.442^^172^1891^1
 ;;^UTILITY(U,$J,358.3,37726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37726,1,3,0)
 ;;=3^Acquired absence of left ankle
 ;;^UTILITY(U,$J,358.3,37726,1,4,0)
 ;;=4^Z89.442
 ;;^UTILITY(U,$J,358.3,37726,2)
 ;;=^5063564
 ;;^UTILITY(U,$J,358.3,37727,0)
 ;;=Z89.432^^172^1891^2
 ;;^UTILITY(U,$J,358.3,37727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37727,1,3,0)
 ;;=3^Acquired absence of left foot
 ;;^UTILITY(U,$J,358.3,37727,1,4,0)
 ;;=4^Z89.432
 ;;^UTILITY(U,$J,358.3,37727,2)
 ;;=^5063561
 ;;^UTILITY(U,$J,358.3,37728,0)
 ;;=Z89.412^^172^1891^3
 ;;^UTILITY(U,$J,358.3,37728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37728,1,3,0)
 ;;=3^Acquired absence of left great toe
 ;;^UTILITY(U,$J,358.3,37728,1,4,0)
 ;;=4^Z89.412
 ;;^UTILITY(U,$J,358.3,37728,2)
 ;;=^5063555
 ;;^UTILITY(U,$J,358.3,37729,0)
 ;;=Z89.112^^172^1891^4
 ;;^UTILITY(U,$J,358.3,37729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37729,1,3,0)
 ;;=3^Acquired absence of left hand
 ;;^UTILITY(U,$J,358.3,37729,1,4,0)
 ;;=4^Z89.112
 ;;^UTILITY(U,$J,358.3,37729,2)
 ;;=^5063538
 ;;^UTILITY(U,$J,358.3,37730,0)
 ;;=Z89.622^^172^1891^5
 ;;^UTILITY(U,$J,358.3,37730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37730,1,3,0)
 ;;=3^Acquired absence of left hip joint
 ;;^UTILITY(U,$J,358.3,37730,1,4,0)
 ;;=4^Z89.622
 ;;^UTILITY(U,$J,358.3,37730,2)
 ;;=^5063576
 ;;^UTILITY(U,$J,358.3,37731,0)
 ;;=Z89.612^^172^1891^6
 ;;^UTILITY(U,$J,358.3,37731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37731,1,3,0)
 ;;=3^Acquired absence of left leg above knee
 ;;^UTILITY(U,$J,358.3,37731,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,37731,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,37732,0)
 ;;=Z89.512^^172^1891^7
 ;;^UTILITY(U,$J,358.3,37732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37732,1,3,0)
 ;;=3^Acquired absence of left leg below knee
 ;;^UTILITY(U,$J,358.3,37732,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,37732,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,37733,0)
 ;;=Z89.212^^172^1891^8
 ;;^UTILITY(U,$J,358.3,37733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37733,1,3,0)
 ;;=3^Acquired absence of left upper limb below elbow
 ;;^UTILITY(U,$J,358.3,37733,1,4,0)
 ;;=4^Z89.212
 ;;^UTILITY(U,$J,358.3,37733,2)
 ;;=^5063546
 ;;^UTILITY(U,$J,358.3,37734,0)
 ;;=Z89.422^^172^1891^9
 ;;^UTILITY(U,$J,358.3,37734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37734,1,3,0)
 ;;=3^Acquired absence of other left toe(s)
 ;;^UTILITY(U,$J,358.3,37734,1,4,0)
 ;;=4^Z89.422
 ;;^UTILITY(U,$J,358.3,37734,2)
 ;;=^5063558
 ;;^UTILITY(U,$J,358.3,37735,0)
 ;;=Z89.421^^172^1891^10
 ;;^UTILITY(U,$J,358.3,37735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37735,1,3,0)
 ;;=3^Acquired absence of other right toe(s)
 ;;^UTILITY(U,$J,358.3,37735,1,4,0)
 ;;=4^Z89.421
 ;;^UTILITY(U,$J,358.3,37735,2)
 ;;=^5063557
