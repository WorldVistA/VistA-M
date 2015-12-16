IBDEI07Q ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3116,0)
 ;;=F64.9^^8^94^3
 ;;^UTILITY(U,$J,358.3,3116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3116,1,3,0)
 ;;=3^Gender Dysphoria,Unspec
 ;;^UTILITY(U,$J,358.3,3116,1,4,0)
 ;;=4^F64.9
 ;;^UTILITY(U,$J,358.3,3116,2)
 ;;=^5003650
 ;;^UTILITY(U,$J,358.3,3117,0)
 ;;=Z59.2^^8^95^1
 ;;^UTILITY(U,$J,358.3,3117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3117,1,3,0)
 ;;=3^Discord w/ Neighbors,Lodgers or Landlord
 ;;^UTILITY(U,$J,358.3,3117,1,4,0)
 ;;=4^Z59.2
 ;;^UTILITY(U,$J,358.3,3117,2)
 ;;=^5063131
 ;;^UTILITY(U,$J,358.3,3118,0)
 ;;=Z59.0^^8^95^3
 ;;^UTILITY(U,$J,358.3,3118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3118,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,3118,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,3118,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,3119,0)
 ;;=Z59.1^^8^95^5
 ;;^UTILITY(U,$J,358.3,3119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3119,1,3,0)
 ;;=3^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,3119,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,3119,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,3120,0)
 ;;=Z59.3^^8^95^9
 ;;^UTILITY(U,$J,358.3,3120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3120,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,3120,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,3120,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,3121,0)
 ;;=Z59.4^^8^95^7
 ;;^UTILITY(U,$J,358.3,3121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3121,1,3,0)
 ;;=3^Lack of Adequate Food or Safe Drinking Water
 ;;^UTILITY(U,$J,358.3,3121,1,4,0)
 ;;=4^Z59.4
 ;;^UTILITY(U,$J,358.3,3121,2)
 ;;=^5063133
 ;;^UTILITY(U,$J,358.3,3122,0)
 ;;=Z59.5^^8^95^2
 ;;^UTILITY(U,$J,358.3,3122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3122,1,3,0)
 ;;=3^Extreme Poverty
 ;;^UTILITY(U,$J,358.3,3122,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,3122,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,3123,0)
 ;;=Z59.6^^8^95^8
 ;;^UTILITY(U,$J,358.3,3123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3123,1,3,0)
 ;;=3^Low Income
 ;;^UTILITY(U,$J,358.3,3123,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,3123,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,3124,0)
 ;;=Z59.7^^8^95^6
 ;;^UTILITY(U,$J,358.3,3124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3124,1,3,0)
 ;;=3^Insufficient Social Insurance/Welfare Support
 ;;^UTILITY(U,$J,358.3,3124,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,3124,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,3125,0)
 ;;=Z59.9^^8^95^4
 ;;^UTILITY(U,$J,358.3,3125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3125,1,3,0)
 ;;=3^Housing/Economic Problems,Unspec
 ;;^UTILITY(U,$J,358.3,3125,1,4,0)
 ;;=4^Z59.9
 ;;^UTILITY(U,$J,358.3,3125,2)
 ;;=^5063138
 ;;^UTILITY(U,$J,358.3,3126,0)
 ;;=G21.19^^8^96^3
 ;;^UTILITY(U,$J,358.3,3126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3126,1,3,0)
 ;;=3^Medication-Induced Parkinsonism NEC
 ;;^UTILITY(U,$J,358.3,3126,1,4,0)
 ;;=4^G21.19
 ;;^UTILITY(U,$J,358.3,3126,2)
 ;;=^5003773
 ;;^UTILITY(U,$J,358.3,3127,0)
 ;;=G21.11^^8^96^5
 ;;^UTILITY(U,$J,358.3,3127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3127,1,3,0)
 ;;=3^Neuroleptic-Induced Parkinsonism
 ;;^UTILITY(U,$J,358.3,3127,1,4,0)
 ;;=4^G21.11
 ;;^UTILITY(U,$J,358.3,3127,2)
 ;;=^5003772
 ;;^UTILITY(U,$J,358.3,3128,0)
 ;;=G24.02^^8^96^1
 ;;^UTILITY(U,$J,358.3,3128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3128,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,3128,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,3128,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,3129,0)
 ;;=G24.01^^8^96^7
 ;;^UTILITY(U,$J,358.3,3129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3129,1,3,0)
 ;;=3^Tardive Dyskinesia
