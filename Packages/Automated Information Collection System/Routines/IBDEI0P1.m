IBDEI0P1 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11238,1,3,0)
 ;;=3^Housing Instability,Housed,Unspec
 ;;^UTILITY(U,$J,358.3,11238,1,4,0)
 ;;=4^Z59.819
 ;;^UTILITY(U,$J,358.3,11238,2)
 ;;=^5161311
 ;;^UTILITY(U,$J,358.3,11239,0)
 ;;=Z59.89^^42^514^16
 ;;^UTILITY(U,$J,358.3,11239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11239,1,3,0)
 ;;=3^Problems Related to Housing & Economic Circumstances,Other
 ;;^UTILITY(U,$J,358.3,11239,1,4,0)
 ;;=4^Z59.89
 ;;^UTILITY(U,$J,358.3,11239,2)
 ;;=^5161312
 ;;^UTILITY(U,$J,358.3,11240,0)
 ;;=Z59.2^^42^514^2
 ;;^UTILITY(U,$J,358.3,11240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11240,1,3,0)
 ;;=3^Discord w/ Neighbors,Lodgers,Landlords
 ;;^UTILITY(U,$J,358.3,11240,1,4,0)
 ;;=4^Z59.2
 ;;^UTILITY(U,$J,358.3,11240,2)
 ;;=^5063131
 ;;^UTILITY(U,$J,358.3,11241,0)
 ;;=Z59.9^^42^514^17
 ;;^UTILITY(U,$J,358.3,11241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11241,1,3,0)
 ;;=3^Problems Related to Housing & Economic Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,11241,1,4,0)
 ;;=4^Z59.9
 ;;^UTILITY(U,$J,358.3,11241,2)
 ;;=^5063138
 ;;^UTILITY(U,$J,358.3,11242,0)
 ;;=Z59.7^^42^514^13
 ;;^UTILITY(U,$J,358.3,11242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11242,1,3,0)
 ;;=3^Insufficient Social Insurance & Welfare Support
 ;;^UTILITY(U,$J,358.3,11242,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,11242,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,11243,0)
 ;;=Z59.41^^42^514^4
 ;;^UTILITY(U,$J,358.3,11243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11243,1,3,0)
 ;;=3^Food Insecurity
 ;;^UTILITY(U,$J,358.3,11243,1,4,0)
 ;;=4^Z59.41
 ;;^UTILITY(U,$J,358.3,11243,2)
 ;;=^5161307
 ;;^UTILITY(U,$J,358.3,11244,0)
 ;;=Z59.48^^42^514^14
 ;;^UTILITY(U,$J,358.3,11244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11244,1,3,0)
 ;;=3^Lack of Adequate Food,Other Spec
 ;;^UTILITY(U,$J,358.3,11244,1,4,0)
 ;;=4^Z59.48
 ;;^UTILITY(U,$J,358.3,11244,2)
 ;;=^5161308
 ;;^UTILITY(U,$J,358.3,11245,0)
 ;;=Z72.51^^42^515^2
 ;;^UTILITY(U,$J,358.3,11245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11245,1,3,0)
 ;;=3^High Risk Heterosexual Behavior
 ;;^UTILITY(U,$J,358.3,11245,1,4,0)
 ;;=4^Z72.51
 ;;^UTILITY(U,$J,358.3,11245,2)
 ;;=^5063258
 ;;^UTILITY(U,$J,358.3,11246,0)
 ;;=Z72.6^^42^515^1
 ;;^UTILITY(U,$J,358.3,11246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11246,1,3,0)
 ;;=3^Gambling/Betting
 ;;^UTILITY(U,$J,358.3,11246,1,4,0)
 ;;=4^Z72.6
 ;;^UTILITY(U,$J,358.3,11246,2)
 ;;=^5063261
 ;;^UTILITY(U,$J,358.3,11247,0)
 ;;=Z72.3^^42^515^4
 ;;^UTILITY(U,$J,358.3,11247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11247,1,3,0)
 ;;=3^Lack of Physical Exercise
 ;;^UTILITY(U,$J,358.3,11247,1,4,0)
 ;;=4^Z72.3
 ;;^UTILITY(U,$J,358.3,11247,2)
 ;;=^5063256
 ;;^UTILITY(U,$J,358.3,11248,0)
 ;;=Z72.4^^42^515^3
 ;;^UTILITY(U,$J,358.3,11248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11248,1,3,0)
 ;;=3^Inappropriate Diet/Eating Habits
 ;;^UTILITY(U,$J,358.3,11248,1,4,0)
 ;;=4^Z72.4
 ;;^UTILITY(U,$J,358.3,11248,2)
 ;;=^5063257
 ;;^UTILITY(U,$J,358.3,11249,0)
 ;;=Z72.820^^42^515^6
 ;;^UTILITY(U,$J,358.3,11249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11249,1,3,0)
 ;;=3^Sleep Deprivation
 ;;^UTILITY(U,$J,358.3,11249,1,4,0)
 ;;=4^Z72.820
 ;;^UTILITY(U,$J,358.3,11249,2)
 ;;=^5063264
 ;;^UTILITY(U,$J,358.3,11250,0)
 ;;=Z72.9^^42^515^5
 ;;^UTILITY(U,$J,358.3,11250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11250,1,3,0)
 ;;=3^Lifestyle Related Problems,Unspec
