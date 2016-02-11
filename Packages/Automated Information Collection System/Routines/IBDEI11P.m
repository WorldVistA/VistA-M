IBDEI11P ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17406,1,3,0)
 ;;=3^Noncompliance w/ Dietary Regimen
 ;;^UTILITY(U,$J,358.3,17406,1,4,0)
 ;;=4^Z91.11
 ;;^UTILITY(U,$J,358.3,17406,2)
 ;;=^5063611
 ;;^UTILITY(U,$J,358.3,17407,0)
 ;;=Z91.120^^88^861^77
 ;;^UTILITY(U,$J,358.3,17407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17407,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,17407,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,17407,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,17408,0)
 ;;=Z91.128^^88^861^78
 ;;^UTILITY(U,$J,358.3,17408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17408,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Other Reasons
 ;;^UTILITY(U,$J,358.3,17408,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,17408,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,17409,0)
 ;;=Z91.130^^88^861^76
 ;;^UTILITY(U,$J,358.3,17409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17409,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Age-Related Debility
 ;;^UTILITY(U,$J,358.3,17409,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,17409,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,17410,0)
 ;;=Z91.138^^88^861^75
 ;;^UTILITY(U,$J,358.3,17410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17410,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen Unintentional
 ;;^UTILITY(U,$J,358.3,17410,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,17410,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,17411,0)
 ;;=Z91.19^^88^861^79
 ;;^UTILITY(U,$J,358.3,17411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17411,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,17411,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,17411,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,17412,0)
 ;;=Z91.15^^88^861^80
 ;;^UTILITY(U,$J,358.3,17412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17412,1,3,0)
 ;;=3^Noncompliance w/ Renal Dialysis
 ;;^UTILITY(U,$J,358.3,17412,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,17412,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,17413,0)
 ;;=Z57.2^^88^861^85
 ;;^UTILITY(U,$J,358.3,17413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17413,1,3,0)
 ;;=3^Occupational Exposure to Dust
 ;;^UTILITY(U,$J,358.3,17413,1,4,0)
 ;;=4^Z57.2
 ;;^UTILITY(U,$J,358.3,17413,2)
 ;;=^5063120
 ;;^UTILITY(U,$J,358.3,17414,0)
 ;;=Z57.31^^88^861^91
 ;;^UTILITY(U,$J,358.3,17414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17414,1,3,0)
 ;;=3^Occupational Exposure to Tobacco Smoke,Environmental
 ;;^UTILITY(U,$J,358.3,17414,1,4,0)
 ;;=4^Z57.31
 ;;^UTILITY(U,$J,358.3,17414,2)
 ;;=^5063121
 ;;^UTILITY(U,$J,358.3,17415,0)
 ;;=Z57.6^^88^861^86
 ;;^UTILITY(U,$J,358.3,17415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17415,1,3,0)
 ;;=3^Occupational Exposure to Extreme Temperature
 ;;^UTILITY(U,$J,358.3,17415,1,4,0)
 ;;=4^Z57.6
 ;;^UTILITY(U,$J,358.3,17415,2)
 ;;=^5063125
 ;;^UTILITY(U,$J,358.3,17416,0)
 ;;=Z57.0^^88^861^88
 ;;^UTILITY(U,$J,358.3,17416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17416,1,3,0)
 ;;=3^Occupational Exposure to Noise
 ;;^UTILITY(U,$J,358.3,17416,1,4,0)
 ;;=4^Z57.0
 ;;^UTILITY(U,$J,358.3,17416,2)
 ;;=^5063118
 ;;^UTILITY(U,$J,358.3,17417,0)
 ;;=Z57.39^^88^861^84
 ;;^UTILITY(U,$J,358.3,17417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17417,1,3,0)
 ;;=3^Occupational Exposure to Air Contaminants
 ;;^UTILITY(U,$J,358.3,17417,1,4,0)
 ;;=4^Z57.39
 ;;^UTILITY(U,$J,358.3,17417,2)
 ;;=^5063122
 ;;^UTILITY(U,$J,358.3,17418,0)
 ;;=Z57.8^^88^861^89
 ;;^UTILITY(U,$J,358.3,17418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17418,1,3,0)
 ;;=3^Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,17418,1,4,0)
 ;;=4^Z57.8
