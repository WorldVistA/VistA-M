IBDEI2VI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48224,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,48225,0)
 ;;=F10.20^^213^2389^5
 ;;^UTILITY(U,$J,358.3,48225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48225,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48225,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,48225,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,48226,0)
 ;;=F11.29^^213^2389^38
 ;;^UTILITY(U,$J,358.3,48226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48226,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,48226,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,48226,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,48227,0)
 ;;=F13.20^^213^2389^50
 ;;^UTILITY(U,$J,358.3,48227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48227,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48227,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,48227,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,48228,0)
 ;;=F14.29^^213^2389^20
 ;;^UTILITY(U,$J,358.3,48228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48228,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,48228,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,48228,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,48229,0)
 ;;=F12.29^^213^2389^18
 ;;^UTILITY(U,$J,358.3,48229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48229,1,3,0)
 ;;=3^Cannabis Dependence w/ Unspec Cannabis-Induced Disorder
 ;;^UTILITY(U,$J,358.3,48229,1,4,0)
 ;;=4^F12.29
 ;;^UTILITY(U,$J,358.3,48229,2)
 ;;=^5003177
 ;;^UTILITY(U,$J,358.3,48230,0)
 ;;=F16.20^^213^2389^27
 ;;^UTILITY(U,$J,358.3,48230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48230,1,3,0)
 ;;=3^Hallucinogen Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48230,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,48230,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,48231,0)
 ;;=F19.20^^213^2389^42
 ;;^UTILITY(U,$J,358.3,48231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48231,1,3,0)
 ;;=3^Psychoactive Substance Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48231,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,48231,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,48232,0)
 ;;=F10.10^^213^2389^3
 ;;^UTILITY(U,$J,358.3,48232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48232,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48232,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,48232,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,48233,0)
 ;;=F12.10^^213^2389^17
 ;;^UTILITY(U,$J,358.3,48233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48233,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48233,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,48233,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,48234,0)
 ;;=F16.10^^213^2389^26
 ;;^UTILITY(U,$J,358.3,48234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48234,1,3,0)
 ;;=3^Hallucinogen Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48234,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,48234,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,48235,0)
 ;;=F13.10^^213^2389^49
 ;;^UTILITY(U,$J,358.3,48235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48235,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48235,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,48235,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,48236,0)
 ;;=F11.10^^213^2389^37
 ;;^UTILITY(U,$J,358.3,48236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48236,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48236,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,48236,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,48237,0)
 ;;=F14.10^^213^2389^19
 ;;^UTILITY(U,$J,358.3,48237,1,0)
 ;;=^358.31IA^4^2
