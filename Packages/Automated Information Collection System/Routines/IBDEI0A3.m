IBDEI0A3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4193,1,3,0)
 ;;=3^Illness,Unspec
 ;;^UTILITY(U,$J,358.3,4193,1,4,0)
 ;;=4^R69.
 ;;^UTILITY(U,$J,358.3,4193,2)
 ;;=^5019558
 ;;^UTILITY(U,$J,358.3,4194,0)
 ;;=D89.9^^28^263^68
 ;;^UTILITY(U,$J,358.3,4194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4194,1,3,0)
 ;;=3^Immune Mechanism Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,4194,1,4,0)
 ;;=4^D89.9
 ;;^UTILITY(U,$J,358.3,4194,2)
 ;;=^5002459
 ;;^UTILITY(U,$J,358.3,4195,0)
 ;;=D84.9^^28^263^70
 ;;^UTILITY(U,$J,358.3,4195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4195,1,3,0)
 ;;=3^Immunodeficiency,Unspec
 ;;^UTILITY(U,$J,358.3,4195,1,4,0)
 ;;=4^D84.9
 ;;^UTILITY(U,$J,358.3,4195,2)
 ;;=^5002441
 ;;^UTILITY(U,$J,358.3,4196,0)
 ;;=R68.82^^28^263^72
 ;;^UTILITY(U,$J,358.3,4196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4196,1,3,0)
 ;;=3^Libido,Decreased
 ;;^UTILITY(U,$J,358.3,4196,1,4,0)
 ;;=4^R68.82
 ;;^UTILITY(U,$J,358.3,4196,2)
 ;;=^329956
 ;;^UTILITY(U,$J,358.3,4197,0)
 ;;=R53.81^^28^263^73
 ;;^UTILITY(U,$J,358.3,4197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4197,1,3,0)
 ;;=3^Malaise,Other
 ;;^UTILITY(U,$J,358.3,4197,1,4,0)
 ;;=4^R53.81
 ;;^UTILITY(U,$J,358.3,4197,2)
 ;;=^5019518
 ;;^UTILITY(U,$J,358.3,4198,0)
 ;;=Z91.11^^28^263^74
 ;;^UTILITY(U,$J,358.3,4198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4198,1,3,0)
 ;;=3^Noncompliance w/ Dietary Regimen
 ;;^UTILITY(U,$J,358.3,4198,1,4,0)
 ;;=4^Z91.11
 ;;^UTILITY(U,$J,358.3,4198,2)
 ;;=^5063611
 ;;^UTILITY(U,$J,358.3,4199,0)
 ;;=Z91.120^^28^263^77
 ;;^UTILITY(U,$J,358.3,4199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4199,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,4199,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,4199,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,4200,0)
 ;;=Z91.128^^28^263^78
 ;;^UTILITY(U,$J,358.3,4200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4200,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Other Reasons
 ;;^UTILITY(U,$J,358.3,4200,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,4200,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,4201,0)
 ;;=Z91.130^^28^263^76
 ;;^UTILITY(U,$J,358.3,4201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4201,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Age-Related Debility
 ;;^UTILITY(U,$J,358.3,4201,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,4201,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,4202,0)
 ;;=Z91.138^^28^263^75
 ;;^UTILITY(U,$J,358.3,4202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4202,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen Unintentional
 ;;^UTILITY(U,$J,358.3,4202,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,4202,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,4203,0)
 ;;=Z91.19^^28^263^79
 ;;^UTILITY(U,$J,358.3,4203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4203,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,4203,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,4203,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,4204,0)
 ;;=Z91.15^^28^263^80
 ;;^UTILITY(U,$J,358.3,4204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4204,1,3,0)
 ;;=3^Noncompliance w/ Renal Dialysis
 ;;^UTILITY(U,$J,358.3,4204,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,4204,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,4205,0)
 ;;=Z57.2^^28^263^85
 ;;^UTILITY(U,$J,358.3,4205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4205,1,3,0)
 ;;=3^Occupational Exposure to Dust
 ;;^UTILITY(U,$J,358.3,4205,1,4,0)
 ;;=4^Z57.2
 ;;^UTILITY(U,$J,358.3,4205,2)
 ;;=^5063120
 ;;^UTILITY(U,$J,358.3,4206,0)
 ;;=Z57.31^^28^263^91
 ;;^UTILITY(U,$J,358.3,4206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4206,1,3,0)
 ;;=3^Occupational Exposure to Tobacco Smoke,Environmental
