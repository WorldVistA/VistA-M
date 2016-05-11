IBDEI07V ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3380,0)
 ;;=M79.7^^18^219^34
 ;;^UTILITY(U,$J,358.3,3380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3380,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,3380,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,3380,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,3381,0)
 ;;=M84.50XA^^18^219^36
 ;;^UTILITY(U,$J,358.3,3381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3381,1,3,0)
 ;;=3^Fx in Neoplastic Disease,Unspec Site,Init Encntr
 ;;^UTILITY(U,$J,358.3,3381,1,4,0)
 ;;=4^M84.50XA
 ;;^UTILITY(U,$J,358.3,3381,2)
 ;;=^5014022
 ;;^UTILITY(U,$J,358.3,3382,0)
 ;;=M84.50XD^^18^219^39
 ;;^UTILITY(U,$J,358.3,3382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3382,1,3,0)
 ;;=3^Fx in Neoplastic Disease,Unspec Site,Routine Healing
 ;;^UTILITY(U,$J,358.3,3382,1,4,0)
 ;;=4^M84.50XD
 ;;^UTILITY(U,$J,358.3,3382,2)
 ;;=^5014023
 ;;^UTILITY(U,$J,358.3,3383,0)
 ;;=M84.50XS^^18^219^40
 ;;^UTILITY(U,$J,358.3,3383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3383,1,3,0)
 ;;=3^Fx in Neoplastic Disease,Unspec Site,Sequela
 ;;^UTILITY(U,$J,358.3,3383,1,4,0)
 ;;=4^M84.50XS
 ;;^UTILITY(U,$J,358.3,3383,2)
 ;;=^5014027
 ;;^UTILITY(U,$J,358.3,3384,0)
 ;;=M84.50XG^^18^219^35
 ;;^UTILITY(U,$J,358.3,3384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3384,1,3,0)
 ;;=3^Fx in Neoplastic Disease,Unspec Site,Delayed Healing
 ;;^UTILITY(U,$J,358.3,3384,1,4,0)
 ;;=4^M84.50XG
 ;;^UTILITY(U,$J,358.3,3384,2)
 ;;=^5014024
 ;;^UTILITY(U,$J,358.3,3385,0)
 ;;=M84.50XK^^18^219^38
 ;;^UTILITY(U,$J,358.3,3385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3385,1,3,0)
 ;;=3^Fx in Neoplastic Disease,Unspec Site,Nonunion
 ;;^UTILITY(U,$J,358.3,3385,1,4,0)
 ;;=4^M84.50XK
 ;;^UTILITY(U,$J,358.3,3385,2)
 ;;=^5014025
 ;;^UTILITY(U,$J,358.3,3386,0)
 ;;=M84.50XP^^18^219^37
 ;;^UTILITY(U,$J,358.3,3386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3386,1,3,0)
 ;;=3^Fx in Neoplastic Disease,Unspec Site,Malunion
 ;;^UTILITY(U,$J,358.3,3386,1,4,0)
 ;;=4^M84.50XP
 ;;^UTILITY(U,$J,358.3,3386,2)
 ;;=^5014026
 ;;^UTILITY(U,$J,358.3,3387,0)
 ;;=M84.60XA^^18^219^42
 ;;^UTILITY(U,$J,358.3,3387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3387,1,3,0)
 ;;=3^Fx in Oth Disease,Unspec Site,Init Encntr
 ;;^UTILITY(U,$J,358.3,3387,1,4,0)
 ;;=4^M84.60XA
 ;;^UTILITY(U,$J,358.3,3387,2)
 ;;=^5014214
 ;;^UTILITY(U,$J,358.3,3388,0)
 ;;=M84.60XD^^18^219^45
 ;;^UTILITY(U,$J,358.3,3388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3388,1,3,0)
 ;;=3^Fx in Oth Disease,Unspec Site,Rountine Healing
 ;;^UTILITY(U,$J,358.3,3388,1,4,0)
 ;;=4^M84.60XD
 ;;^UTILITY(U,$J,358.3,3388,2)
 ;;=^5014215
 ;;^UTILITY(U,$J,358.3,3389,0)
 ;;=M84.60XS^^18^219^46
 ;;^UTILITY(U,$J,358.3,3389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3389,1,3,0)
 ;;=3^Fx in Oth Disease,Unspec Site,Sequela
 ;;^UTILITY(U,$J,358.3,3389,1,4,0)
 ;;=4^M84.60XS
 ;;^UTILITY(U,$J,358.3,3389,2)
 ;;=^5014219
 ;;^UTILITY(U,$J,358.3,3390,0)
 ;;=M84.60XG^^18^219^41
 ;;^UTILITY(U,$J,358.3,3390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3390,1,3,0)
 ;;=3^Fx in Oth Disease,Unspec Site,Delayed Healing
 ;;^UTILITY(U,$J,358.3,3390,1,4,0)
 ;;=4^M84.60XG
 ;;^UTILITY(U,$J,358.3,3390,2)
 ;;=^5014216
 ;;^UTILITY(U,$J,358.3,3391,0)
 ;;=M84.60XK^^18^219^44
 ;;^UTILITY(U,$J,358.3,3391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3391,1,3,0)
 ;;=3^Fx in Oth Disease,Unspec Site,Nonunion
 ;;^UTILITY(U,$J,358.3,3391,1,4,0)
 ;;=4^M84.60XK
 ;;^UTILITY(U,$J,358.3,3391,2)
 ;;=^5014217
 ;;^UTILITY(U,$J,358.3,3392,0)
 ;;=M84.60XP^^18^219^43
 ;;^UTILITY(U,$J,358.3,3392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3392,1,3,0)
 ;;=3^Fx in Oth Disease,Unspec Site,Malunion
