IBDEI133 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17603,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,17603,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,17604,0)
 ;;=F17.201^^61^789^41
 ;;^UTILITY(U,$J,358.3,17604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17604,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,17604,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,17604,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,17605,0)
 ;;=F17.210^^61^789^40
 ;;^UTILITY(U,$J,358.3,17605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17605,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17605,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,17605,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,17606,0)
 ;;=F17.291^^61^789^42
 ;;^UTILITY(U,$J,358.3,17606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17606,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,17606,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,17606,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,17607,0)
 ;;=F17.290^^61^789^43
 ;;^UTILITY(U,$J,358.3,17607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17607,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17607,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,17607,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,17608,0)
 ;;=F17.221^^61^789^37
 ;;^UTILITY(U,$J,358.3,17608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17608,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,17608,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,17608,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,17609,0)
 ;;=F17.220^^61^789^38
 ;;^UTILITY(U,$J,358.3,17609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17609,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17609,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,17609,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,17610,0)
 ;;=F17.211^^61^789^39
 ;;^UTILITY(U,$J,358.3,17610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17610,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,17610,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,17610,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,17611,0)
 ;;=F17.200^^61^789^44
 ;;^UTILITY(U,$J,358.3,17611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17611,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17611,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,17611,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,17612,0)
 ;;=F11.120^^61^789^45
 ;;^UTILITY(U,$J,358.3,17612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17612,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17612,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,17612,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,17613,0)
 ;;=F11.10^^61^789^49
 ;;^UTILITY(U,$J,358.3,17613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17613,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17613,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,17613,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,17614,0)
 ;;=F11.129^^61^789^46
 ;;^UTILITY(U,$J,358.3,17614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17614,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,17614,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,17614,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,17615,0)
 ;;=F10.21^^61^789^8
 ;;^UTILITY(U,$J,358.3,17615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17615,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
