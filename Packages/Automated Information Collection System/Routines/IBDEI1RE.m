IBDEI1RE ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31082,1,3,0)
 ;;=3^Sprain of right wrist, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31082,1,4,0)
 ;;=4^S63.501A
 ;;^UTILITY(U,$J,358.3,31082,2)
 ;;=^5035583
 ;;^UTILITY(U,$J,358.3,31083,0)
 ;;=Z89.442^^179^1941^1
 ;;^UTILITY(U,$J,358.3,31083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31083,1,3,0)
 ;;=3^Acquired absence of left ankle
 ;;^UTILITY(U,$J,358.3,31083,1,4,0)
 ;;=4^Z89.442
 ;;^UTILITY(U,$J,358.3,31083,2)
 ;;=^5063564
 ;;^UTILITY(U,$J,358.3,31084,0)
 ;;=Z89.432^^179^1941^2
 ;;^UTILITY(U,$J,358.3,31084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31084,1,3,0)
 ;;=3^Acquired absence of left foot
 ;;^UTILITY(U,$J,358.3,31084,1,4,0)
 ;;=4^Z89.432
 ;;^UTILITY(U,$J,358.3,31084,2)
 ;;=^5063561
 ;;^UTILITY(U,$J,358.3,31085,0)
 ;;=Z89.412^^179^1941^3
 ;;^UTILITY(U,$J,358.3,31085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31085,1,3,0)
 ;;=3^Acquired absence of left great toe
 ;;^UTILITY(U,$J,358.3,31085,1,4,0)
 ;;=4^Z89.412
 ;;^UTILITY(U,$J,358.3,31085,2)
 ;;=^5063555
 ;;^UTILITY(U,$J,358.3,31086,0)
 ;;=Z89.112^^179^1941^4
 ;;^UTILITY(U,$J,358.3,31086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31086,1,3,0)
 ;;=3^Acquired absence of left hand
 ;;^UTILITY(U,$J,358.3,31086,1,4,0)
 ;;=4^Z89.112
 ;;^UTILITY(U,$J,358.3,31086,2)
 ;;=^5063538
 ;;^UTILITY(U,$J,358.3,31087,0)
 ;;=Z89.622^^179^1941^5
 ;;^UTILITY(U,$J,358.3,31087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31087,1,3,0)
 ;;=3^Acquired absence of left hip joint
 ;;^UTILITY(U,$J,358.3,31087,1,4,0)
 ;;=4^Z89.622
 ;;^UTILITY(U,$J,358.3,31087,2)
 ;;=^5063576
 ;;^UTILITY(U,$J,358.3,31088,0)
 ;;=Z89.612^^179^1941^6
 ;;^UTILITY(U,$J,358.3,31088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31088,1,3,0)
 ;;=3^Acquired absence of left leg above knee
 ;;^UTILITY(U,$J,358.3,31088,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,31088,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,31089,0)
 ;;=Z89.512^^179^1941^7
 ;;^UTILITY(U,$J,358.3,31089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31089,1,3,0)
 ;;=3^Acquired absence of left leg below knee
 ;;^UTILITY(U,$J,358.3,31089,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,31089,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,31090,0)
 ;;=Z89.212^^179^1941^8
 ;;^UTILITY(U,$J,358.3,31090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31090,1,3,0)
 ;;=3^Acquired absence of left upper limb below elbow
 ;;^UTILITY(U,$J,358.3,31090,1,4,0)
 ;;=4^Z89.212
 ;;^UTILITY(U,$J,358.3,31090,2)
 ;;=^5063546
 ;;^UTILITY(U,$J,358.3,31091,0)
 ;;=Z89.422^^179^1941^9
 ;;^UTILITY(U,$J,358.3,31091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31091,1,3,0)
 ;;=3^Acquired absence of other left toe(s)
 ;;^UTILITY(U,$J,358.3,31091,1,4,0)
 ;;=4^Z89.422
 ;;^UTILITY(U,$J,358.3,31091,2)
 ;;=^5063558
 ;;^UTILITY(U,$J,358.3,31092,0)
 ;;=Z89.421^^179^1941^10
 ;;^UTILITY(U,$J,358.3,31092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31092,1,3,0)
 ;;=3^Acquired absence of other right toe(s)
 ;;^UTILITY(U,$J,358.3,31092,1,4,0)
 ;;=4^Z89.421
 ;;^UTILITY(U,$J,358.3,31092,2)
 ;;=^5063557
 ;;^UTILITY(U,$J,358.3,31093,0)
 ;;=Z89.441^^179^1941^11
 ;;^UTILITY(U,$J,358.3,31093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31093,1,3,0)
 ;;=3^Acquired absence of right ankle
 ;;^UTILITY(U,$J,358.3,31093,1,4,0)
 ;;=4^Z89.441
 ;;^UTILITY(U,$J,358.3,31093,2)
 ;;=^5063563
 ;;^UTILITY(U,$J,358.3,31094,0)
 ;;=Z89.431^^179^1941^12
 ;;^UTILITY(U,$J,358.3,31094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31094,1,3,0)
 ;;=3^Acquired absence of right foot
 ;;^UTILITY(U,$J,358.3,31094,1,4,0)
 ;;=4^Z89.431
 ;;^UTILITY(U,$J,358.3,31094,2)
 ;;=^5063560
 ;;^UTILITY(U,$J,358.3,31095,0)
 ;;=Z89.411^^179^1941^13
