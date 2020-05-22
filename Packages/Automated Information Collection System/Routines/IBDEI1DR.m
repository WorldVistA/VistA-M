IBDEI1DR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22059,1,3,0)
 ;;=3^Counseling, unspec
 ;;^UTILITY(U,$J,358.3,22059,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,22059,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,22060,0)
 ;;=Z63.4^^99^1125^8
 ;;^UTILITY(U,$J,358.3,22060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22060,1,3,0)
 ;;=3^Disappearance & death of family member
 ;;^UTILITY(U,$J,358.3,22060,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,22060,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,22061,0)
 ;;=Z73.82^^99^1125^9
 ;;^UTILITY(U,$J,358.3,22061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22061,1,3,0)
 ;;=3^Dual sensory impairment
 ;;^UTILITY(U,$J,358.3,22061,1,4,0)
 ;;=4^Z73.82
 ;;^UTILITY(U,$J,358.3,22061,2)
 ;;=^5063279
 ;;^UTILITY(U,$J,358.3,22062,0)
 ;;=Z04.41^^99^1125^10
 ;;^UTILITY(U,$J,358.3,22062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22062,1,3,0)
 ;;=3^Encntr for exam & obs folwng alleged adlt rape
 ;;^UTILITY(U,$J,358.3,22062,1,4,0)
 ;;=4^Z04.41
 ;;^UTILITY(U,$J,358.3,22062,2)
 ;;=^5062660
 ;;^UTILITY(U,$J,358.3,22063,0)
 ;;=Z76.0^^99^1125^11
 ;;^UTILITY(U,$J,358.3,22063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22063,1,3,0)
 ;;=3^Encntr for issue of repeat prescription
 ;;^UTILITY(U,$J,358.3,22063,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,22063,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,22064,0)
 ;;=Z69.12^^99^1125^13
 ;;^UTILITY(U,$J,358.3,22064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22064,1,3,0)
 ;;=3^Encntr for mntl hlth serv for perp of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,22064,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,22064,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,22065,0)
 ;;=Z69.010^^99^1125^14
 ;;^UTILITY(U,$J,358.3,22065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22065,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of prntl child abuse
 ;;^UTILITY(U,$J,358.3,22065,1,4,0)
 ;;=4^Z69.010
 ;;^UTILITY(U,$J,358.3,22065,2)
 ;;=^5063228
 ;;^UTILITY(U,$J,358.3,22066,0)
 ;;=Z69.11^^99^1125^15
 ;;^UTILITY(U,$J,358.3,22066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22066,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,22066,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,22066,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,22067,0)
 ;;=Z65.5^^99^1125^16
 ;;^UTILITY(U,$J,358.3,22067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22067,1,3,0)
 ;;=3^Expsr to disaster, war & oth hostilities
 ;;^UTILITY(U,$J,358.3,22067,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,22067,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,22068,0)
 ;;=Z59.0^^99^1125^18
 ;;^UTILITY(U,$J,358.3,22068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22068,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,22068,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,22068,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,22069,0)
 ;;=Z59.5^^99^1125^17
 ;;^UTILITY(U,$J,358.3,22069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22069,1,3,0)
 ;;=3^Extreme poverty
 ;;^UTILITY(U,$J,358.3,22069,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,22069,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,22070,0)
 ;;=Z71.7^^99^1125^19
 ;;^UTILITY(U,$J,358.3,22070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22070,1,3,0)
 ;;=3^Human immunodeficiency virus [HIV] counseling
 ;;^UTILITY(U,$J,358.3,22070,1,4,0)
 ;;=4^Z71.7
 ;;^UTILITY(U,$J,358.3,22070,2)
 ;;=^5063251
 ;;^UTILITY(U,$J,358.3,22071,0)
 ;;=Z73.4^^99^1125^20
 ;;^UTILITY(U,$J,358.3,22071,1,0)
 ;;=^358.31IA^4^2
