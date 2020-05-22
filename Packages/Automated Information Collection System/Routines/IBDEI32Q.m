IBDEI32Q ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49082,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,49082,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,49083,0)
 ;;=Z73.6^^185^2428^124
 ;;^UTILITY(U,$J,358.3,49083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49083,1,3,0)
 ;;=3^Problems Related to Activity Limitations d/t Disability
 ;;^UTILITY(U,$J,358.3,49083,1,4,0)
 ;;=4^Z73.6
 ;;^UTILITY(U,$J,358.3,49083,2)
 ;;=^5063274
 ;;^UTILITY(U,$J,358.3,49084,0)
 ;;=Z60.2^^185^2428^143
 ;;^UTILITY(U,$J,358.3,49084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49084,1,3,0)
 ;;=3^Problems Related to Living Alone
 ;;^UTILITY(U,$J,358.3,49084,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,49084,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,49085,0)
 ;;=Z59.3^^185^2428^144
 ;;^UTILITY(U,$J,358.3,49085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49085,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,49085,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,49085,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,49086,0)
 ;;=Z59.6^^185^2428^145
 ;;^UTILITY(U,$J,358.3,49086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49086,1,3,0)
 ;;=3^Problems Related to Low Income
 ;;^UTILITY(U,$J,358.3,49086,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,49086,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,49087,0)
 ;;=Z75.9^^185^2428^146
 ;;^UTILITY(U,$J,358.3,49087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49087,1,3,0)
 ;;=3^Problems Related to Med Facilities/Health Care
 ;;^UTILITY(U,$J,358.3,49087,1,4,0)
 ;;=4^Z75.9
 ;;^UTILITY(U,$J,358.3,49087,2)
 ;;=^5063296
 ;;^UTILITY(U,$J,358.3,49088,0)
 ;;=Z75.0^^185^2428^147
 ;;^UTILITY(U,$J,358.3,49088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49088,1,3,0)
 ;;=3^Problems Related to Med Services not Available in Home
 ;;^UTILITY(U,$J,358.3,49088,1,4,0)
 ;;=4^Z75.0
 ;;^UTILITY(U,$J,358.3,49088,2)
 ;;=^5063289
 ;;^UTILITY(U,$J,358.3,49089,0)
 ;;=Z74.2^^185^2428^149
 ;;^UTILITY(U,$J,358.3,49089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49089,1,3,0)
 ;;=3^Problems Related to Need for Assistance at Home
 ;;^UTILITY(U,$J,358.3,49089,1,4,0)
 ;;=4^Z74.2
 ;;^UTILITY(U,$J,358.3,49089,2)
 ;;=^5063285
 ;;^UTILITY(U,$J,358.3,49090,0)
 ;;=Z74.1^^185^2428^150
 ;;^UTILITY(U,$J,358.3,49090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49090,1,3,0)
 ;;=3^Problems Related to Need for Assistance w/ Personal Care
 ;;^UTILITY(U,$J,358.3,49090,1,4,0)
 ;;=4^Z74.1
 ;;^UTILITY(U,$J,358.3,49090,2)
 ;;=^5063284
 ;;^UTILITY(U,$J,358.3,49091,0)
 ;;=Z74.3^^185^2428^151
 ;;^UTILITY(U,$J,358.3,49091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49091,1,3,0)
 ;;=3^Problems Related to Need for Continuous Supervision
 ;;^UTILITY(U,$J,358.3,49091,1,4,0)
 ;;=4^Z74.3
 ;;^UTILITY(U,$J,358.3,49091,2)
 ;;=^5063286
 ;;^UTILITY(U,$J,358.3,49092,0)
 ;;=Z75.1^^185^2428^126
 ;;^UTILITY(U,$J,358.3,49092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49092,1,3,0)
 ;;=3^Problems Related to Awaiting Facility Admission
 ;;^UTILITY(U,$J,358.3,49092,1,4,0)
 ;;=4^Z75.1
 ;;^UTILITY(U,$J,358.3,49092,2)
 ;;=^5063290
 ;;^UTILITY(U,$J,358.3,49093,0)
 ;;=Z63.9^^185^2428^152
 ;;^UTILITY(U,$J,358.3,49093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49093,1,3,0)
 ;;=3^Problems Related to Primary Support Group
 ;;^UTILITY(U,$J,358.3,49093,1,4,0)
 ;;=4^Z63.9
 ;;^UTILITY(U,$J,358.3,49093,2)
 ;;=^5063175
 ;;^UTILITY(U,$J,358.3,49094,0)
 ;;=Z74.09^^185^2428^154
 ;;^UTILITY(U,$J,358.3,49094,1,0)
 ;;=^358.31IA^4^2
