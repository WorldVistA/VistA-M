IBDEI2JS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40674,0)
 ;;=F17.210^^152^2014^30
 ;;^UTILITY(U,$J,358.3,40674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40674,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,40674,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,40674,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,40675,0)
 ;;=F17.291^^152^2014^32
 ;;^UTILITY(U,$J,358.3,40675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40675,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,40675,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,40675,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,40676,0)
 ;;=F17.290^^152^2014^33
 ;;^UTILITY(U,$J,358.3,40676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40676,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,40676,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,40676,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,40677,0)
 ;;=F17.221^^152^2014^27
 ;;^UTILITY(U,$J,358.3,40677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40677,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,40677,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,40677,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,40678,0)
 ;;=F17.220^^152^2014^28
 ;;^UTILITY(U,$J,358.3,40678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40678,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,40678,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,40678,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,40679,0)
 ;;=F17.211^^152^2014^29
 ;;^UTILITY(U,$J,358.3,40679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40679,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,40679,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,40679,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,40680,0)
 ;;=F17.200^^152^2014^34
 ;;^UTILITY(U,$J,358.3,40680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40680,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,40680,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,40680,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,40681,0)
 ;;=F11.120^^152^2014^35
 ;;^UTILITY(U,$J,358.3,40681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40681,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,40681,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,40681,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,40682,0)
 ;;=F11.10^^152^2014^38
 ;;^UTILITY(U,$J,358.3,40682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40682,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,40682,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,40682,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,40683,0)
 ;;=F11.129^^152^2014^36
 ;;^UTILITY(U,$J,358.3,40683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40683,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,40683,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,40683,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,40684,0)
 ;;=F10.21^^152^2014^4
 ;;^UTILITY(U,$J,358.3,40684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40684,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,40684,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,40684,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,40685,0)
 ;;=F12.10^^152^2014^7
 ;;^UTILITY(U,$J,358.3,40685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40685,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,40685,1,4,0)
 ;;=4^F12.10
