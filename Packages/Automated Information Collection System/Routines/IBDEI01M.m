IBDEI01M ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,258,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,258,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,259,0)
 ;;=F50.8^^3^30^8
 ;;^UTILITY(U,$J,358.3,259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,259,1,3,0)
 ;;=3^Pica,In Adults
 ;;^UTILITY(U,$J,358.3,259,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,259,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,260,0)
 ;;=Z55.9^^3^31^1
 ;;^UTILITY(U,$J,358.3,260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,260,1,3,0)
 ;;=3^Acedemic/Educational Problem
 ;;^UTILITY(U,$J,358.3,260,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,260,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,261,0)
 ;;=Z56.81^^3^31^9
 ;;^UTILITY(U,$J,358.3,261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,261,1,3,0)
 ;;=3^Sexual Harassment on the Job
 ;;^UTILITY(U,$J,358.3,261,1,4,0)
 ;;=4^Z56.81
 ;;^UTILITY(U,$J,358.3,261,2)
 ;;=^5063114
 ;;^UTILITY(U,$J,358.3,262,0)
 ;;=Z56.9^^3^31^8
 ;;^UTILITY(U,$J,358.3,262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,262,1,3,0)
 ;;=3^Problems Related to Employment NEC
 ;;^UTILITY(U,$J,358.3,262,1,4,0)
 ;;=4^Z56.9
 ;;^UTILITY(U,$J,358.3,262,2)
 ;;=^5063117
 ;;^UTILITY(U,$J,358.3,263,0)
 ;;=Z56.82^^3^31^6
 ;;^UTILITY(U,$J,358.3,263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,263,1,3,0)
 ;;=3^Problems Related to Current Military Deployment Status
 ;;^UTILITY(U,$J,358.3,263,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,263,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,264,0)
 ;;=Z56.0^^3^31^13
 ;;^UTILITY(U,$J,358.3,264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,264,1,3,0)
 ;;=3^Unemployeement,Unspec
 ;;^UTILITY(U,$J,358.3,264,1,4,0)
 ;;=4^Z56.0
 ;;^UTILITY(U,$J,358.3,264,2)
 ;;=^5063107
 ;;^UTILITY(U,$J,358.3,265,0)
 ;;=Z56.1^^3^31^2
 ;;^UTILITY(U,$J,358.3,265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,265,1,3,0)
 ;;=3^Change of Job
 ;;^UTILITY(U,$J,358.3,265,1,4,0)
 ;;=4^Z56.1
 ;;^UTILITY(U,$J,358.3,265,2)
 ;;=^5063108
 ;;^UTILITY(U,$J,358.3,266,0)
 ;;=Z56.2^^3^31^11
 ;;^UTILITY(U,$J,358.3,266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,266,1,3,0)
 ;;=3^Threat of Job Loss
 ;;^UTILITY(U,$J,358.3,266,1,4,0)
 ;;=4^Z56.2
 ;;^UTILITY(U,$J,358.3,266,2)
 ;;=^5063109
 ;;^UTILITY(U,$J,358.3,267,0)
 ;;=Z56.3^^3^31^10
 ;;^UTILITY(U,$J,358.3,267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,267,1,3,0)
 ;;=3^Stressful Work Schedule
 ;;^UTILITY(U,$J,358.3,267,1,4,0)
 ;;=4^Z56.3
 ;;^UTILITY(U,$J,358.3,267,2)
 ;;=^5063110
 ;;^UTILITY(U,$J,358.3,268,0)
 ;;=Z56.4^^3^31^3
 ;;^UTILITY(U,$J,358.3,268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,268,1,3,0)
 ;;=3^Discord w/ Boss & Workmates
 ;;^UTILITY(U,$J,358.3,268,1,4,0)
 ;;=4^Z56.4
 ;;^UTILITY(U,$J,358.3,268,2)
 ;;=^5063111
 ;;^UTILITY(U,$J,358.3,269,0)
 ;;=Z56.5^^3^31^12
 ;;^UTILITY(U,$J,358.3,269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,269,1,3,0)
 ;;=3^Uncongenial Work Environment
 ;;^UTILITY(U,$J,358.3,269,1,4,0)
 ;;=4^Z56.5
 ;;^UTILITY(U,$J,358.3,269,2)
 ;;=^5063112
 ;;^UTILITY(U,$J,358.3,270,0)
 ;;=Z56.6^^3^31^5
 ;;^UTILITY(U,$J,358.3,270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,270,1,3,0)
 ;;=3^Physical & Mental Strain Related to Work NEC
 ;;^UTILITY(U,$J,358.3,270,1,4,0)
 ;;=4^Z56.6
 ;;^UTILITY(U,$J,358.3,270,2)
 ;;=^5063113
 ;;^UTILITY(U,$J,358.3,271,0)
 ;;=Z56.82^^3^31^4
 ;;^UTILITY(U,$J,358.3,271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,271,1,3,0)
 ;;=3^Military Deployment Status
 ;;^UTILITY(U,$J,358.3,271,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,271,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,272,0)
 ;;=Z56.89^^3^31^7
 ;;^UTILITY(U,$J,358.3,272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,272,1,3,0)
 ;;=3^Problems Related to Employment,Other
