IBDEI0UP ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15176,1,5,0)
 ;;=5^Alcohol Dep-Remission
 ;;^UTILITY(U,$J,358.3,15176,2)
 ;;=^268190
 ;;^UTILITY(U,$J,358.3,15177,0)
 ;;=305.00^^93^914^9
 ;;^UTILITY(U,$J,358.3,15177,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15177,1,2,0)
 ;;=2^305.00
 ;;^UTILITY(U,$J,358.3,15177,1,5,0)
 ;;=5^Alcohol Abuse
 ;;^UTILITY(U,$J,358.3,15177,2)
 ;;=^268227
 ;;^UTILITY(U,$J,358.3,15178,0)
 ;;=305.03^^93^914^10
 ;;^UTILITY(U,$J,358.3,15178,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15178,1,2,0)
 ;;=2^305.03
 ;;^UTILITY(U,$J,358.3,15178,1,5,0)
 ;;=5^Alcohol Abuse-Remission
 ;;^UTILITY(U,$J,358.3,15178,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,15179,0)
 ;;=304.00^^93^914^74
 ;;^UTILITY(U,$J,358.3,15179,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15179,1,2,0)
 ;;=2^304.00
 ;;^UTILITY(U,$J,358.3,15179,1,5,0)
 ;;=5^Opioid Dependence
 ;;^UTILITY(U,$J,358.3,15179,2)
 ;;=^81364
 ;;^UTILITY(U,$J,358.3,15180,0)
 ;;=304.23^^93^914^72
 ;;^UTILITY(U,$J,358.3,15180,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15180,1,2,0)
 ;;=2^304.23
 ;;^UTILITY(U,$J,358.3,15180,1,5,0)
 ;;=5^Opioid Dep-Remission
 ;;^UTILITY(U,$J,358.3,15180,2)
 ;;=^268200
 ;;^UTILITY(U,$J,358.3,15181,0)
 ;;=305.50^^93^914^68
 ;;^UTILITY(U,$J,358.3,15181,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15181,1,2,0)
 ;;=2^305.50
 ;;^UTILITY(U,$J,358.3,15181,1,5,0)
 ;;=5^Opioid Abuse
 ;;^UTILITY(U,$J,358.3,15181,2)
 ;;=^85868
 ;;^UTILITY(U,$J,358.3,15182,0)
 ;;=305.53^^93^914^71
 ;;^UTILITY(U,$J,358.3,15182,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15182,1,2,0)
 ;;=2^305.53
 ;;^UTILITY(U,$J,358.3,15182,1,5,0)
 ;;=5^Opioid Abuse-Remission
 ;;^UTILITY(U,$J,358.3,15182,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,15183,0)
 ;;=304.10^^93^914^31
 ;;^UTILITY(U,$J,358.3,15183,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15183,1,2,0)
 ;;=2^304.10
 ;;^UTILITY(U,$J,358.3,15183,1,5,0)
 ;;=5^Anxiolytic Dependence
 ;;^UTILITY(U,$J,358.3,15183,2)
 ;;=^268194
 ;;^UTILITY(U,$J,358.3,15184,0)
 ;;=304.13^^93^914^28
 ;;^UTILITY(U,$J,358.3,15184,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15184,1,2,0)
 ;;=2^304.13
 ;;^UTILITY(U,$J,358.3,15184,1,5,0)
 ;;=5^Anxiolytic Dep-Remis
 ;;^UTILITY(U,$J,358.3,15184,2)
 ;;=^268197
 ;;^UTILITY(U,$J,358.3,15185,0)
 ;;=305.40^^93^914^24
 ;;^UTILITY(U,$J,358.3,15185,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15185,1,2,0)
 ;;=2^305.40
 ;;^UTILITY(U,$J,358.3,15185,1,5,0)
 ;;=5^Anxiolytic Abuse
 ;;^UTILITY(U,$J,358.3,15185,2)
 ;;=^268240
 ;;^UTILITY(U,$J,358.3,15186,0)
 ;;=305.43^^93^914^27
 ;;^UTILITY(U,$J,358.3,15186,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15186,1,2,0)
 ;;=2^305.43
 ;;^UTILITY(U,$J,358.3,15186,1,5,0)
 ;;=5^Anxiolytic Abuse-Remission
 ;;^UTILITY(U,$J,358.3,15186,2)
 ;;=^268243
 ;;^UTILITY(U,$J,358.3,15187,0)
 ;;=304.20^^93^914^46
 ;;^UTILITY(U,$J,358.3,15187,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15187,1,2,0)
 ;;=2^304.20
 ;;^UTILITY(U,$J,358.3,15187,1,5,0)
 ;;=5^Cocaine Dependence
 ;;^UTILITY(U,$J,358.3,15187,2)
 ;;=^25599
 ;;^UTILITY(U,$J,358.3,15188,0)
 ;;=305.60^^93^914^40
 ;;^UTILITY(U,$J,358.3,15188,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15188,1,2,0)
 ;;=2^305.60
 ;;^UTILITY(U,$J,358.3,15188,1,5,0)
 ;;=5^Cocaine Abuse   
 ;;^UTILITY(U,$J,358.3,15188,2)
 ;;=^25596
 ;;^UTILITY(U,$J,358.3,15189,0)
 ;;=305.63^^93^914^43
 ;;^UTILITY(U,$J,358.3,15189,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15189,1,2,0)
 ;;=2^305.63
 ;;^UTILITY(U,$J,358.3,15189,1,5,0)
 ;;=5^Cocaine Abuse-Remission
 ;;^UTILITY(U,$J,358.3,15189,2)
 ;;=^268249
 ;;^UTILITY(U,$J,358.3,15190,0)
 ;;=304.30^^93^914^39
 ;;^UTILITY(U,$J,358.3,15190,1,0)
 ;;=^358.31IA^5^2