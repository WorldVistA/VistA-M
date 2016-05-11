IBDEI0PQ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12028,1,3,0)
 ;;=3^Problems Related to Activity Limitations d/t Disability
 ;;^UTILITY(U,$J,358.3,12028,1,4,0)
 ;;=4^Z73.6
 ;;^UTILITY(U,$J,358.3,12028,2)
 ;;=^5063274
 ;;^UTILITY(U,$J,358.3,12029,0)
 ;;=Z60.2^^47^538^143
 ;;^UTILITY(U,$J,358.3,12029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12029,1,3,0)
 ;;=3^Problems Related to Living Alone
 ;;^UTILITY(U,$J,358.3,12029,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,12029,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,12030,0)
 ;;=Z59.3^^47^538^144
 ;;^UTILITY(U,$J,358.3,12030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12030,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,12030,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,12030,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,12031,0)
 ;;=Z59.6^^47^538^145
 ;;^UTILITY(U,$J,358.3,12031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12031,1,3,0)
 ;;=3^Problems Related to Low Income
 ;;^UTILITY(U,$J,358.3,12031,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,12031,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,12032,0)
 ;;=Z75.9^^47^538^146
 ;;^UTILITY(U,$J,358.3,12032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12032,1,3,0)
 ;;=3^Problems Related to Med Facilities/Health Care
 ;;^UTILITY(U,$J,358.3,12032,1,4,0)
 ;;=4^Z75.9
 ;;^UTILITY(U,$J,358.3,12032,2)
 ;;=^5063296
 ;;^UTILITY(U,$J,358.3,12033,0)
 ;;=Z75.0^^47^538^147
 ;;^UTILITY(U,$J,358.3,12033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12033,1,3,0)
 ;;=3^Problems Related to Med Services not Available in Home
 ;;^UTILITY(U,$J,358.3,12033,1,4,0)
 ;;=4^Z75.0
 ;;^UTILITY(U,$J,358.3,12033,2)
 ;;=^5063289
 ;;^UTILITY(U,$J,358.3,12034,0)
 ;;=Z74.2^^47^538^149
 ;;^UTILITY(U,$J,358.3,12034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12034,1,3,0)
 ;;=3^Problems Related to Need for Assistance at Home
 ;;^UTILITY(U,$J,358.3,12034,1,4,0)
 ;;=4^Z74.2
 ;;^UTILITY(U,$J,358.3,12034,2)
 ;;=^5063285
 ;;^UTILITY(U,$J,358.3,12035,0)
 ;;=Z74.1^^47^538^150
 ;;^UTILITY(U,$J,358.3,12035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12035,1,3,0)
 ;;=3^Problems Related to Need for Assistance w/ Personal Care
 ;;^UTILITY(U,$J,358.3,12035,1,4,0)
 ;;=4^Z74.1
 ;;^UTILITY(U,$J,358.3,12035,2)
 ;;=^5063284
 ;;^UTILITY(U,$J,358.3,12036,0)
 ;;=Z74.3^^47^538^151
 ;;^UTILITY(U,$J,358.3,12036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12036,1,3,0)
 ;;=3^Problems Related to Need for Continuous Supervision
 ;;^UTILITY(U,$J,358.3,12036,1,4,0)
 ;;=4^Z74.3
 ;;^UTILITY(U,$J,358.3,12036,2)
 ;;=^5063286
 ;;^UTILITY(U,$J,358.3,12037,0)
 ;;=Z75.1^^47^538^126
 ;;^UTILITY(U,$J,358.3,12037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12037,1,3,0)
 ;;=3^Problems Related to Awaiting Facility Admission
 ;;^UTILITY(U,$J,358.3,12037,1,4,0)
 ;;=4^Z75.1
 ;;^UTILITY(U,$J,358.3,12037,2)
 ;;=^5063290
 ;;^UTILITY(U,$J,358.3,12038,0)
 ;;=Z63.9^^47^538^152
 ;;^UTILITY(U,$J,358.3,12038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12038,1,3,0)
 ;;=3^Problems Related to Primary Support Group
 ;;^UTILITY(U,$J,358.3,12038,1,4,0)
 ;;=4^Z63.9
 ;;^UTILITY(U,$J,358.3,12038,2)
 ;;=^5063175
 ;;^UTILITY(U,$J,358.3,12039,0)
 ;;=Z74.09^^47^538^154
 ;;^UTILITY(U,$J,358.3,12039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12039,1,3,0)
 ;;=3^Problems Related to Reduced Mobility
 ;;^UTILITY(U,$J,358.3,12039,1,4,0)
 ;;=4^Z74.09
 ;;^UTILITY(U,$J,358.3,12039,2)
 ;;=^5063283
 ;;^UTILITY(U,$J,358.3,12040,0)
 ;;=Z60.9^^47^538^156
 ;;^UTILITY(U,$J,358.3,12040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12040,1,3,0)
 ;;=3^Problems Related to Social Environment
