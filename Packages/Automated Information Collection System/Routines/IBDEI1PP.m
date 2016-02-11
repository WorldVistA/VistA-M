IBDEI1PP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28646,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28646,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,28646,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,28647,0)
 ;;=F17.291^^132^1334^29
 ;;^UTILITY(U,$J,358.3,28647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28647,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,28647,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,28647,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,28648,0)
 ;;=F17.290^^132^1334^30
 ;;^UTILITY(U,$J,358.3,28648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28648,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28648,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,28648,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,28649,0)
 ;;=F17.221^^132^1334^24
 ;;^UTILITY(U,$J,358.3,28649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28649,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,28649,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,28649,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,28650,0)
 ;;=F17.220^^132^1334^25
 ;;^UTILITY(U,$J,358.3,28650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28650,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28650,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,28650,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,28651,0)
 ;;=F17.211^^132^1334^26
 ;;^UTILITY(U,$J,358.3,28651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28651,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,28651,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,28651,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,28652,0)
 ;;=F17.200^^132^1334^31
 ;;^UTILITY(U,$J,358.3,28652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28652,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28652,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,28652,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,28653,0)
 ;;=F11.120^^132^1334^32
 ;;^UTILITY(U,$J,358.3,28653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28653,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28653,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,28653,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,28654,0)
 ;;=F11.10^^132^1334^34
 ;;^UTILITY(U,$J,358.3,28654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28654,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28654,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,28654,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,28655,0)
 ;;=F11.129^^132^1334^33
 ;;^UTILITY(U,$J,358.3,28655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28655,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,28655,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,28655,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,28656,0)
 ;;=F10.21^^132^1334^3
 ;;^UTILITY(U,$J,358.3,28656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28656,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,28656,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,28656,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,28657,0)
 ;;=F12.10^^132^1334^5
 ;;^UTILITY(U,$J,358.3,28657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28657,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28657,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,28657,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,28658,0)
 ;;=F12.20^^132^1334^7
 ;;^UTILITY(U,$J,358.3,28658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28658,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
