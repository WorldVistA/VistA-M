IBDEI01N ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,272,1,4,0)
 ;;=4^Z56.89
 ;;^UTILITY(U,$J,358.3,272,2)
 ;;=^5063116
 ;;^UTILITY(U,$J,358.3,273,0)
 ;;=F64.1^^3^32^2
 ;;^UTILITY(U,$J,358.3,273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,273,1,3,0)
 ;;=3^Gender Dysphoria in Adolescents & Adults
 ;;^UTILITY(U,$J,358.3,273,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,273,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,274,0)
 ;;=F64.8^^3^32^1
 ;;^UTILITY(U,$J,358.3,274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,274,1,3,0)
 ;;=3^Gender Dysphoria NEC
 ;;^UTILITY(U,$J,358.3,274,1,4,0)
 ;;=4^F64.8
 ;;^UTILITY(U,$J,358.3,274,2)
 ;;=^5003649
 ;;^UTILITY(U,$J,358.3,275,0)
 ;;=F64.9^^3^32^3
 ;;^UTILITY(U,$J,358.3,275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,275,1,3,0)
 ;;=3^Gender Dysphoria,Unspec
 ;;^UTILITY(U,$J,358.3,275,1,4,0)
 ;;=4^F64.9
 ;;^UTILITY(U,$J,358.3,275,2)
 ;;=^5003650
 ;;^UTILITY(U,$J,358.3,276,0)
 ;;=Z59.2^^3^33^1
 ;;^UTILITY(U,$J,358.3,276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,276,1,3,0)
 ;;=3^Discord w/ Neighbors,Lodgers or Landlord
 ;;^UTILITY(U,$J,358.3,276,1,4,0)
 ;;=4^Z59.2
 ;;^UTILITY(U,$J,358.3,276,2)
 ;;=^5063131
 ;;^UTILITY(U,$J,358.3,277,0)
 ;;=Z59.0^^3^33^3
 ;;^UTILITY(U,$J,358.3,277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,277,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,277,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,277,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,278,0)
 ;;=Z59.1^^3^33^5
 ;;^UTILITY(U,$J,358.3,278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,278,1,3,0)
 ;;=3^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,278,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,278,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,279,0)
 ;;=Z59.3^^3^33^9
 ;;^UTILITY(U,$J,358.3,279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,279,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,279,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,279,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,280,0)
 ;;=Z59.4^^3^33^7
 ;;^UTILITY(U,$J,358.3,280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,280,1,3,0)
 ;;=3^Lack of Adequate Food or Safe Drinking Water
 ;;^UTILITY(U,$J,358.3,280,1,4,0)
 ;;=4^Z59.4
 ;;^UTILITY(U,$J,358.3,280,2)
 ;;=^5063133
 ;;^UTILITY(U,$J,358.3,281,0)
 ;;=Z59.5^^3^33^2
 ;;^UTILITY(U,$J,358.3,281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,281,1,3,0)
 ;;=3^Extreme Poverty
 ;;^UTILITY(U,$J,358.3,281,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,281,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,282,0)
 ;;=Z59.6^^3^33^8
 ;;^UTILITY(U,$J,358.3,282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,282,1,3,0)
 ;;=3^Low Income
 ;;^UTILITY(U,$J,358.3,282,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,282,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,283,0)
 ;;=Z59.7^^3^33^6
 ;;^UTILITY(U,$J,358.3,283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,283,1,3,0)
 ;;=3^Insufficient Social Insurance/Welfare Support
 ;;^UTILITY(U,$J,358.3,283,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,283,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,284,0)
 ;;=Z59.9^^3^33^4
 ;;^UTILITY(U,$J,358.3,284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,284,1,3,0)
 ;;=3^Housing/Economic Problems,Unspec
 ;;^UTILITY(U,$J,358.3,284,1,4,0)
 ;;=4^Z59.9
 ;;^UTILITY(U,$J,358.3,284,2)
 ;;=^5063138
 ;;^UTILITY(U,$J,358.3,285,0)
 ;;=G21.19^^3^34^11
 ;;^UTILITY(U,$J,358.3,285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,285,1,3,0)
 ;;=3^Medication-Induced Parkinsonism NEC
 ;;^UTILITY(U,$J,358.3,285,1,4,0)
 ;;=4^G21.19
 ;;^UTILITY(U,$J,358.3,285,2)
 ;;=^5003773
 ;;^UTILITY(U,$J,358.3,286,0)
 ;;=G21.11^^3^34^14
 ;;^UTILITY(U,$J,358.3,286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,286,1,3,0)
 ;;=3^Neuroleptic-Induced Parkinsonism
