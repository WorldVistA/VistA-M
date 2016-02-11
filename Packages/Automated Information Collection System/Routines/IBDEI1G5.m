IBDEI1G5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24161,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,24161,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,24162,0)
 ;;=Z71.41^^116^1187^3
 ;;^UTILITY(U,$J,358.3,24162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24162,1,3,0)
 ;;=3^Alcohol abuse counslng & surveil of alcoholic
 ;;^UTILITY(U,$J,358.3,24162,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,24162,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,24163,0)
 ;;=Z71.89^^116^1187^4
 ;;^UTILITY(U,$J,358.3,24163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24163,1,3,0)
 ;;=3^Counseling, oth, spec
 ;;^UTILITY(U,$J,358.3,24163,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,24163,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,24164,0)
 ;;=Z71.9^^116^1187^5
 ;;^UTILITY(U,$J,358.3,24164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24164,1,3,0)
 ;;=3^Counseling, unspec
 ;;^UTILITY(U,$J,358.3,24164,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,24164,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,24165,0)
 ;;=Z63.4^^116^1187^8
 ;;^UTILITY(U,$J,358.3,24165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24165,1,3,0)
 ;;=3^Disappearance & death of family member
 ;;^UTILITY(U,$J,358.3,24165,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,24165,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,24166,0)
 ;;=Z73.82^^116^1187^9
 ;;^UTILITY(U,$J,358.3,24166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24166,1,3,0)
 ;;=3^Dual sensory impairment
 ;;^UTILITY(U,$J,358.3,24166,1,4,0)
 ;;=4^Z73.82
 ;;^UTILITY(U,$J,358.3,24166,2)
 ;;=^5063279
 ;;^UTILITY(U,$J,358.3,24167,0)
 ;;=Z04.41^^116^1187^10
 ;;^UTILITY(U,$J,358.3,24167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24167,1,3,0)
 ;;=3^Encntr for exam & obs folwng alleged adlt rape
 ;;^UTILITY(U,$J,358.3,24167,1,4,0)
 ;;=4^Z04.41
 ;;^UTILITY(U,$J,358.3,24167,2)
 ;;=^5062660
 ;;^UTILITY(U,$J,358.3,24168,0)
 ;;=Z76.0^^116^1187^11
 ;;^UTILITY(U,$J,358.3,24168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24168,1,3,0)
 ;;=3^Encntr for issue of repeat prescription
 ;;^UTILITY(U,$J,358.3,24168,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,24168,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,24169,0)
 ;;=Z69.12^^116^1187^13
 ;;^UTILITY(U,$J,358.3,24169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24169,1,3,0)
 ;;=3^Encntr for mntl hlth serv for perp of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,24169,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24169,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24170,0)
 ;;=Z69.010^^116^1187^14
 ;;^UTILITY(U,$J,358.3,24170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24170,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of prntl child abuse
 ;;^UTILITY(U,$J,358.3,24170,1,4,0)
 ;;=4^Z69.010
 ;;^UTILITY(U,$J,358.3,24170,2)
 ;;=^5063228
 ;;^UTILITY(U,$J,358.3,24171,0)
 ;;=Z69.11^^116^1187^15
 ;;^UTILITY(U,$J,358.3,24171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24171,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,24171,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24171,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24172,0)
 ;;=Z65.5^^116^1187^16
 ;;^UTILITY(U,$J,358.3,24172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24172,1,3,0)
 ;;=3^Expsr to disaster, war & oth hostilities
 ;;^UTILITY(U,$J,358.3,24172,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,24172,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,24173,0)
 ;;=Z59.0^^116^1187^18
 ;;^UTILITY(U,$J,358.3,24173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24173,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,24173,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,24173,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,24174,0)
 ;;=Z59.5^^116^1187^17
 ;;^UTILITY(U,$J,358.3,24174,1,0)
 ;;=^358.31IA^4^2
