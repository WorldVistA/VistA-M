IBDEI0A8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4258,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,4258,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,4259,0)
 ;;=Z59.7^^28^263^139
 ;;^UTILITY(U,$J,358.3,4259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4259,1,3,0)
 ;;=3^Problems Related to Insufficient Social Insurance/Welfare Support
 ;;^UTILITY(U,$J,358.3,4259,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,4259,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,4260,0)
 ;;=Z59.4^^28^263^140
 ;;^UTILITY(U,$J,358.3,4260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4260,1,3,0)
 ;;=3^Problems Related to Lack of Food/Drinking Water
 ;;^UTILITY(U,$J,358.3,4260,1,4,0)
 ;;=4^Z59.4
 ;;^UTILITY(U,$J,358.3,4260,2)
 ;;=^5063133
 ;;^UTILITY(U,$J,358.3,4261,0)
 ;;=Z73.9^^28^263^141
 ;;^UTILITY(U,$J,358.3,4261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4261,1,3,0)
 ;;=3^Problems Related to Life Management Difficulty
 ;;^UTILITY(U,$J,358.3,4261,1,4,0)
 ;;=4^Z73.9
 ;;^UTILITY(U,$J,358.3,4261,2)
 ;;=^5063281
 ;;^UTILITY(U,$J,358.3,4262,0)
 ;;=Z72.9^^28^263^142
 ;;^UTILITY(U,$J,358.3,4262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4262,1,3,0)
 ;;=3^Problems Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,4262,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,4262,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,4263,0)
 ;;=Z73.6^^28^263^124
 ;;^UTILITY(U,$J,358.3,4263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4263,1,3,0)
 ;;=3^Problems Related to Activity Limitations d/t Disability
 ;;^UTILITY(U,$J,358.3,4263,1,4,0)
 ;;=4^Z73.6
 ;;^UTILITY(U,$J,358.3,4263,2)
 ;;=^5063274
 ;;^UTILITY(U,$J,358.3,4264,0)
 ;;=Z60.2^^28^263^143
 ;;^UTILITY(U,$J,358.3,4264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4264,1,3,0)
 ;;=3^Problems Related to Living Alone
 ;;^UTILITY(U,$J,358.3,4264,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,4264,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,4265,0)
 ;;=Z59.3^^28^263^144
 ;;^UTILITY(U,$J,358.3,4265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4265,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,4265,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,4265,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,4266,0)
 ;;=Z59.6^^28^263^145
 ;;^UTILITY(U,$J,358.3,4266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4266,1,3,0)
 ;;=3^Problems Related to Low Income
 ;;^UTILITY(U,$J,358.3,4266,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,4266,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,4267,0)
 ;;=Z75.9^^28^263^146
 ;;^UTILITY(U,$J,358.3,4267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4267,1,3,0)
 ;;=3^Problems Related to Med Facilities/Health Care
 ;;^UTILITY(U,$J,358.3,4267,1,4,0)
 ;;=4^Z75.9
 ;;^UTILITY(U,$J,358.3,4267,2)
 ;;=^5063296
 ;;^UTILITY(U,$J,358.3,4268,0)
 ;;=Z75.0^^28^263^147
 ;;^UTILITY(U,$J,358.3,4268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4268,1,3,0)
 ;;=3^Problems Related to Med Services not Available in Home
 ;;^UTILITY(U,$J,358.3,4268,1,4,0)
 ;;=4^Z75.0
 ;;^UTILITY(U,$J,358.3,4268,2)
 ;;=^5063289
 ;;^UTILITY(U,$J,358.3,4269,0)
 ;;=Z74.2^^28^263^149
 ;;^UTILITY(U,$J,358.3,4269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4269,1,3,0)
 ;;=3^Problems Related to Need for Assistance at Home
 ;;^UTILITY(U,$J,358.3,4269,1,4,0)
 ;;=4^Z74.2
 ;;^UTILITY(U,$J,358.3,4269,2)
 ;;=^5063285
 ;;^UTILITY(U,$J,358.3,4270,0)
 ;;=Z74.1^^28^263^150
 ;;^UTILITY(U,$J,358.3,4270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4270,1,3,0)
 ;;=3^Problems Related to Need for Assistance w/ Personal Care
 ;;^UTILITY(U,$J,358.3,4270,1,4,0)
 ;;=4^Z74.1
 ;;^UTILITY(U,$J,358.3,4270,2)
 ;;=^5063284
 ;;^UTILITY(U,$J,358.3,4271,0)
 ;;=Z74.3^^28^263^151
 ;;^UTILITY(U,$J,358.3,4271,1,0)
 ;;=^358.31IA^4^2
