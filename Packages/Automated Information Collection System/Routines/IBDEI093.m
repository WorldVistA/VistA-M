IBDEI093 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3968,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,3968,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,3969,0)
 ;;=Z59.3^^18^224^144
 ;;^UTILITY(U,$J,358.3,3969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3969,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,3969,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,3969,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,3970,0)
 ;;=Z59.6^^18^224^145
 ;;^UTILITY(U,$J,358.3,3970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3970,1,3,0)
 ;;=3^Problems Related to Low Income
 ;;^UTILITY(U,$J,358.3,3970,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,3970,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,3971,0)
 ;;=Z75.9^^18^224^146
 ;;^UTILITY(U,$J,358.3,3971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3971,1,3,0)
 ;;=3^Problems Related to Med Facilities/Health Care
 ;;^UTILITY(U,$J,358.3,3971,1,4,0)
 ;;=4^Z75.9
 ;;^UTILITY(U,$J,358.3,3971,2)
 ;;=^5063296
 ;;^UTILITY(U,$J,358.3,3972,0)
 ;;=Z75.0^^18^224^147
 ;;^UTILITY(U,$J,358.3,3972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3972,1,3,0)
 ;;=3^Problems Related to Med Services not Available in Home
 ;;^UTILITY(U,$J,358.3,3972,1,4,0)
 ;;=4^Z75.0
 ;;^UTILITY(U,$J,358.3,3972,2)
 ;;=^5063289
 ;;^UTILITY(U,$J,358.3,3973,0)
 ;;=Z74.2^^18^224^149
 ;;^UTILITY(U,$J,358.3,3973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3973,1,3,0)
 ;;=3^Problems Related to Need for Assistance at Home
 ;;^UTILITY(U,$J,358.3,3973,1,4,0)
 ;;=4^Z74.2
 ;;^UTILITY(U,$J,358.3,3973,2)
 ;;=^5063285
 ;;^UTILITY(U,$J,358.3,3974,0)
 ;;=Z74.1^^18^224^150
 ;;^UTILITY(U,$J,358.3,3974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3974,1,3,0)
 ;;=3^Problems Related to Need for Assistance w/ Personal Care
 ;;^UTILITY(U,$J,358.3,3974,1,4,0)
 ;;=4^Z74.1
 ;;^UTILITY(U,$J,358.3,3974,2)
 ;;=^5063284
 ;;^UTILITY(U,$J,358.3,3975,0)
 ;;=Z74.3^^18^224^151
 ;;^UTILITY(U,$J,358.3,3975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3975,1,3,0)
 ;;=3^Problems Related to Need for Continuous Supervision
 ;;^UTILITY(U,$J,358.3,3975,1,4,0)
 ;;=4^Z74.3
 ;;^UTILITY(U,$J,358.3,3975,2)
 ;;=^5063286
 ;;^UTILITY(U,$J,358.3,3976,0)
 ;;=Z75.1^^18^224^126
 ;;^UTILITY(U,$J,358.3,3976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3976,1,3,0)
 ;;=3^Problems Related to Awaiting Facility Admission
 ;;^UTILITY(U,$J,358.3,3976,1,4,0)
 ;;=4^Z75.1
 ;;^UTILITY(U,$J,358.3,3976,2)
 ;;=^5063290
 ;;^UTILITY(U,$J,358.3,3977,0)
 ;;=Z63.9^^18^224^152
 ;;^UTILITY(U,$J,358.3,3977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3977,1,3,0)
 ;;=3^Problems Related to Primary Support Group
 ;;^UTILITY(U,$J,358.3,3977,1,4,0)
 ;;=4^Z63.9
 ;;^UTILITY(U,$J,358.3,3977,2)
 ;;=^5063175
 ;;^UTILITY(U,$J,358.3,3978,0)
 ;;=Z74.09^^18^224^154
 ;;^UTILITY(U,$J,358.3,3978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3978,1,3,0)
 ;;=3^Problems Related to Reduced Mobility
 ;;^UTILITY(U,$J,358.3,3978,1,4,0)
 ;;=4^Z74.09
 ;;^UTILITY(U,$J,358.3,3978,2)
 ;;=^5063283
 ;;^UTILITY(U,$J,358.3,3979,0)
 ;;=Z60.9^^18^224^156
 ;;^UTILITY(U,$J,358.3,3979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3979,1,3,0)
 ;;=3^Problems Related to Social Environment
 ;;^UTILITY(U,$J,358.3,3979,1,4,0)
 ;;=4^Z60.9
 ;;^UTILITY(U,$J,358.3,3979,2)
 ;;=^5063145
 ;;^UTILITY(U,$J,358.3,3980,0)
 ;;=Z60.4^^18^224^157
 ;;^UTILITY(U,$J,358.3,3980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3980,1,3,0)
 ;;=3^Problems Related to Social Exclusion/Rejection
 ;;^UTILITY(U,$J,358.3,3980,1,4,0)
 ;;=4^Z60.4
 ;;^UTILITY(U,$J,358.3,3980,2)
 ;;=^5063142
 ;;^UTILITY(U,$J,358.3,3981,0)
 ;;=Z60.5^^18^224^125
 ;;^UTILITY(U,$J,358.3,3981,1,0)
 ;;=^358.31IA^4^2
