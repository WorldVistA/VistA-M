IBDEI027 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,256,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,256,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,257,0)
 ;;=F64.8^^3^32^1
 ;;^UTILITY(U,$J,358.3,257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,257,1,3,0)
 ;;=3^Gender Dysphoria NEC
 ;;^UTILITY(U,$J,358.3,257,1,4,0)
 ;;=4^F64.8
 ;;^UTILITY(U,$J,358.3,257,2)
 ;;=^5003649
 ;;^UTILITY(U,$J,358.3,258,0)
 ;;=F64.9^^3^32^3
 ;;^UTILITY(U,$J,358.3,258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,258,1,3,0)
 ;;=3^Gender Dysphoria,Unspec
 ;;^UTILITY(U,$J,358.3,258,1,4,0)
 ;;=4^F64.9
 ;;^UTILITY(U,$J,358.3,258,2)
 ;;=^5003650
 ;;^UTILITY(U,$J,358.3,259,0)
 ;;=Z59.2^^3^33^1
 ;;^UTILITY(U,$J,358.3,259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,259,1,3,0)
 ;;=3^Discord w/ Neighbors,Lodgers or Landlord
 ;;^UTILITY(U,$J,358.3,259,1,4,0)
 ;;=4^Z59.2
 ;;^UTILITY(U,$J,358.3,259,2)
 ;;=^5063131
 ;;^UTILITY(U,$J,358.3,260,0)
 ;;=Z59.0^^3^33^3
 ;;^UTILITY(U,$J,358.3,260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,260,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,260,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,260,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,261,0)
 ;;=Z59.1^^3^33^5
 ;;^UTILITY(U,$J,358.3,261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,261,1,3,0)
 ;;=3^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,261,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,261,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,262,0)
 ;;=Z59.3^^3^33^9
 ;;^UTILITY(U,$J,358.3,262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,262,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,262,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,262,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,263,0)
 ;;=Z59.4^^3^33^7
 ;;^UTILITY(U,$J,358.3,263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,263,1,3,0)
 ;;=3^Lack of Adequate Food or Safe Drinking Water
 ;;^UTILITY(U,$J,358.3,263,1,4,0)
 ;;=4^Z59.4
 ;;^UTILITY(U,$J,358.3,263,2)
 ;;=^5063133
 ;;^UTILITY(U,$J,358.3,264,0)
 ;;=Z59.5^^3^33^2
 ;;^UTILITY(U,$J,358.3,264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,264,1,3,0)
 ;;=3^Extreme Poverty
 ;;^UTILITY(U,$J,358.3,264,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,264,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,265,0)
 ;;=Z59.6^^3^33^8
 ;;^UTILITY(U,$J,358.3,265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,265,1,3,0)
 ;;=3^Low Income
 ;;^UTILITY(U,$J,358.3,265,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,265,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,266,0)
 ;;=Z59.7^^3^33^6
 ;;^UTILITY(U,$J,358.3,266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,266,1,3,0)
 ;;=3^Insufficient Social Insurance/Welfare Support
 ;;^UTILITY(U,$J,358.3,266,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,266,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,267,0)
 ;;=Z59.9^^3^33^4
 ;;^UTILITY(U,$J,358.3,267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,267,1,3,0)
 ;;=3^Housing/Economic Problems,Unspec
 ;;^UTILITY(U,$J,358.3,267,1,4,0)
 ;;=4^Z59.9
 ;;^UTILITY(U,$J,358.3,267,2)
 ;;=^5063138
 ;;^UTILITY(U,$J,358.3,268,0)
 ;;=G21.19^^3^34^3
 ;;^UTILITY(U,$J,358.3,268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,268,1,3,0)
 ;;=3^Medication-Induced Parkinsonism NEC
 ;;^UTILITY(U,$J,358.3,268,1,4,0)
 ;;=4^G21.19
 ;;^UTILITY(U,$J,358.3,268,2)
 ;;=^5003773
 ;;^UTILITY(U,$J,358.3,269,0)
 ;;=G21.11^^3^34^5
 ;;^UTILITY(U,$J,358.3,269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,269,1,3,0)
 ;;=3^Neuroleptic-Induced Parkinsonism
 ;;^UTILITY(U,$J,358.3,269,1,4,0)
 ;;=4^G21.11
 ;;^UTILITY(U,$J,358.3,269,2)
 ;;=^5003772
 ;;^UTILITY(U,$J,358.3,270,0)
 ;;=G24.02^^3^34^1
 ;;^UTILITY(U,$J,358.3,270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,270,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
