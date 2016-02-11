IBDEI026 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,242,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,242,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,243,0)
 ;;=Z55.9^^3^31^1
 ;;^UTILITY(U,$J,358.3,243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,243,1,3,0)
 ;;=3^Acedemic/Educational Problem
 ;;^UTILITY(U,$J,358.3,243,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,243,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,244,0)
 ;;=Z56.81^^3^31^9
 ;;^UTILITY(U,$J,358.3,244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,244,1,3,0)
 ;;=3^Sexual Harassment on the Job
 ;;^UTILITY(U,$J,358.3,244,1,4,0)
 ;;=4^Z56.81
 ;;^UTILITY(U,$J,358.3,244,2)
 ;;=^5063114
 ;;^UTILITY(U,$J,358.3,245,0)
 ;;=Z56.9^^3^31^8
 ;;^UTILITY(U,$J,358.3,245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,245,1,3,0)
 ;;=3^Problems Related to Employment NEC
 ;;^UTILITY(U,$J,358.3,245,1,4,0)
 ;;=4^Z56.9
 ;;^UTILITY(U,$J,358.3,245,2)
 ;;=^5063117
 ;;^UTILITY(U,$J,358.3,246,0)
 ;;=Z56.82^^3^31^6
 ;;^UTILITY(U,$J,358.3,246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,246,1,3,0)
 ;;=3^Problems Related to Current Military Deployment Status
 ;;^UTILITY(U,$J,358.3,246,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,246,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,247,0)
 ;;=Z56.0^^3^31^13
 ;;^UTILITY(U,$J,358.3,247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,247,1,3,0)
 ;;=3^Unemployeement,Unspec
 ;;^UTILITY(U,$J,358.3,247,1,4,0)
 ;;=4^Z56.0
 ;;^UTILITY(U,$J,358.3,247,2)
 ;;=^5063107
 ;;^UTILITY(U,$J,358.3,248,0)
 ;;=Z56.1^^3^31^2
 ;;^UTILITY(U,$J,358.3,248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,248,1,3,0)
 ;;=3^Change of Job
 ;;^UTILITY(U,$J,358.3,248,1,4,0)
 ;;=4^Z56.1
 ;;^UTILITY(U,$J,358.3,248,2)
 ;;=^5063108
 ;;^UTILITY(U,$J,358.3,249,0)
 ;;=Z56.2^^3^31^11
 ;;^UTILITY(U,$J,358.3,249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,249,1,3,0)
 ;;=3^Threat of Job Loss
 ;;^UTILITY(U,$J,358.3,249,1,4,0)
 ;;=4^Z56.2
 ;;^UTILITY(U,$J,358.3,249,2)
 ;;=^5063109
 ;;^UTILITY(U,$J,358.3,250,0)
 ;;=Z56.3^^3^31^10
 ;;^UTILITY(U,$J,358.3,250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,250,1,3,0)
 ;;=3^Stressful Work Schedule
 ;;^UTILITY(U,$J,358.3,250,1,4,0)
 ;;=4^Z56.3
 ;;^UTILITY(U,$J,358.3,250,2)
 ;;=^5063110
 ;;^UTILITY(U,$J,358.3,251,0)
 ;;=Z56.4^^3^31^3
 ;;^UTILITY(U,$J,358.3,251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,251,1,3,0)
 ;;=3^Discord w/ Boss & Workmates
 ;;^UTILITY(U,$J,358.3,251,1,4,0)
 ;;=4^Z56.4
 ;;^UTILITY(U,$J,358.3,251,2)
 ;;=^5063111
 ;;^UTILITY(U,$J,358.3,252,0)
 ;;=Z56.5^^3^31^12
 ;;^UTILITY(U,$J,358.3,252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,252,1,3,0)
 ;;=3^Uncongenial Work Environment
 ;;^UTILITY(U,$J,358.3,252,1,4,0)
 ;;=4^Z56.5
 ;;^UTILITY(U,$J,358.3,252,2)
 ;;=^5063112
 ;;^UTILITY(U,$J,358.3,253,0)
 ;;=Z56.6^^3^31^5
 ;;^UTILITY(U,$J,358.3,253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,253,1,3,0)
 ;;=3^Physical & Mental Strain Related to Work NEC
 ;;^UTILITY(U,$J,358.3,253,1,4,0)
 ;;=4^Z56.6
 ;;^UTILITY(U,$J,358.3,253,2)
 ;;=^5063113
 ;;^UTILITY(U,$J,358.3,254,0)
 ;;=Z56.82^^3^31^4
 ;;^UTILITY(U,$J,358.3,254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,254,1,3,0)
 ;;=3^Military Deployment Status
 ;;^UTILITY(U,$J,358.3,254,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,254,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,255,0)
 ;;=Z56.89^^3^31^7
 ;;^UTILITY(U,$J,358.3,255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,255,1,3,0)
 ;;=3^Problems Related to Employment,Other
 ;;^UTILITY(U,$J,358.3,255,1,4,0)
 ;;=4^Z56.89
 ;;^UTILITY(U,$J,358.3,255,2)
 ;;=^5063116
 ;;^UTILITY(U,$J,358.3,256,0)
 ;;=F64.1^^3^32^2
 ;;^UTILITY(U,$J,358.3,256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,256,1,3,0)
 ;;=3^Gender Dysphoria in Adolescents & Adults
