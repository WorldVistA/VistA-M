IBDEI086 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3264,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,3265,0)
 ;;=R57.0^^28^249^72
 ;;^UTILITY(U,$J,358.3,3265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3265,1,3,0)
 ;;=3^Shock,Cardiogenic
 ;;^UTILITY(U,$J,358.3,3265,1,4,0)
 ;;=4^R57.0
 ;;^UTILITY(U,$J,358.3,3265,2)
 ;;=^5019525
 ;;^UTILITY(U,$J,358.3,3266,0)
 ;;=R57.1^^28^249^73
 ;;^UTILITY(U,$J,358.3,3266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3266,1,3,0)
 ;;=3^Shock,Hypovolemic
 ;;^UTILITY(U,$J,358.3,3266,1,4,0)
 ;;=4^R57.1
 ;;^UTILITY(U,$J,358.3,3266,2)
 ;;=^60845
 ;;^UTILITY(U,$J,358.3,3267,0)
 ;;=R57.9^^28^249^74
 ;;^UTILITY(U,$J,358.3,3267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3267,1,3,0)
 ;;=3^Shock,Unspec
 ;;^UTILITY(U,$J,358.3,3267,1,4,0)
 ;;=4^R57.9
 ;;^UTILITY(U,$J,358.3,3267,2)
 ;;=^5019527
 ;;^UTILITY(U,$J,358.3,3268,0)
 ;;=R55.^^28^249^75
 ;;^UTILITY(U,$J,358.3,3268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3268,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,3268,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,3268,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,3269,0)
 ;;=I78.0^^28^249^76
 ;;^UTILITY(U,$J,358.3,3269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3269,1,3,0)
 ;;=3^Telangiectasia,Hereditary Hemorrhagic
 ;;^UTILITY(U,$J,358.3,3269,1,4,0)
 ;;=4^I78.0
 ;;^UTILITY(U,$J,358.3,3269,2)
 ;;=^117566
 ;;^UTILITY(U,$J,358.3,3270,0)
 ;;=I73.1^^28^249^20
 ;;^UTILITY(U,$J,358.3,3270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3270,1,3,0)
 ;;=3^Buerger's Disease
 ;;^UTILITY(U,$J,358.3,3270,1,4,0)
 ;;=4^I73.1
 ;;^UTILITY(U,$J,358.3,3270,2)
 ;;=^5007798
 ;;^UTILITY(U,$J,358.3,3271,0)
 ;;=G45.9^^28^249^77
 ;;^UTILITY(U,$J,358.3,3271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3271,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
 ;;^UTILITY(U,$J,358.3,3271,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,3271,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,3272,0)
 ;;=G45.8^^28^249^78
 ;;^UTILITY(U,$J,358.3,3272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3272,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks & Related Syndromes
 ;;^UTILITY(U,$J,358.3,3272,1,4,0)
 ;;=4^G45.8
 ;;^UTILITY(U,$J,358.3,3272,2)
 ;;=^5003958
 ;;^UTILITY(U,$J,358.3,3273,0)
 ;;=I83.019^^28^249^81
 ;;^UTILITY(U,$J,358.3,3273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3273,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer Unspec Site
 ;;^UTILITY(U,$J,358.3,3273,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,3273,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,3274,0)
 ;;=I83.899^^28^249^79
 ;;^UTILITY(U,$J,358.3,3274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3274,1,3,0)
 ;;=3^Varicose Veins Lower Extrem w/ Other Complications
 ;;^UTILITY(U,$J,358.3,3274,1,4,0)
 ;;=4^I83.899
 ;;^UTILITY(U,$J,358.3,3274,2)
 ;;=^5008018
 ;;^UTILITY(U,$J,358.3,3275,0)
 ;;=I83.90^^28^249^80
 ;;^UTILITY(U,$J,358.3,3275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3275,1,3,0)
 ;;=3^Varicose Veins Lower Extrem,Asymptomatic
 ;;^UTILITY(U,$J,358.3,3275,1,4,0)
 ;;=4^I83.90
 ;;^UTILITY(U,$J,358.3,3275,2)
 ;;=^5008019
 ;;^UTILITY(U,$J,358.3,3276,0)
 ;;=I87.2^^28^249^82
 ;;^UTILITY(U,$J,358.3,3276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3276,1,3,0)
 ;;=3^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,3276,1,4,0)
 ;;=4^I87.2
 ;;^UTILITY(U,$J,358.3,3276,2)
 ;;=^5008047
 ;;^UTILITY(U,$J,358.3,3277,0)
 ;;=H61.23^^28^250^1
 ;;^UTILITY(U,$J,358.3,3277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3277,1,3,0)
 ;;=3^Cerumen Impaction,Bilateral
 ;;^UTILITY(U,$J,358.3,3277,1,4,0)
 ;;=4^H61.23
 ;;^UTILITY(U,$J,358.3,3277,2)
 ;;=^5006533
 ;;^UTILITY(U,$J,358.3,3278,0)
 ;;=H61.22^^28^250^2
