IBDEI021 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,461,1,3,0)
 ;;=3^Alcohol Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,461,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,461,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,462,0)
 ;;=F10.121^^3^49^20
 ;;^UTILITY(U,$J,358.3,462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,462,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,462,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,462,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,463,0)
 ;;=F10.221^^3^49^21
 ;;^UTILITY(U,$J,358.3,463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,463,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,463,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,463,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,464,0)
 ;;=F10.921^^3^49^22
 ;;^UTILITY(U,$J,358.3,464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,464,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,464,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,464,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,465,0)
 ;;=F10.129^^3^49^23
 ;;^UTILITY(U,$J,358.3,465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,465,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,465,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,465,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,466,0)
 ;;=F10.229^^3^49^24
 ;;^UTILITY(U,$J,358.3,466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,466,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,466,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,466,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,467,0)
 ;;=F10.929^^3^49^25
 ;;^UTILITY(U,$J,358.3,467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,467,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,467,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,467,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,468,0)
 ;;=F10.99^^3^49^26
 ;;^UTILITY(U,$J,358.3,468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,468,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,468,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,468,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,469,0)
 ;;=F15.10^^3^50^4
 ;;^UTILITY(U,$J,358.3,469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,469,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,469,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,469,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,470,0)
 ;;=F15.14^^3^50^2
 ;;^UTILITY(U,$J,358.3,470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,470,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,470,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,470,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,471,0)
 ;;=F15.182^^3^50^3
 ;;^UTILITY(U,$J,358.3,471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,471,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,471,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,471,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,472,0)
 ;;=F15.20^^3^50^5
 ;;^UTILITY(U,$J,358.3,472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,472,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,472,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,472,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,473,0)
 ;;=F15.21^^3^50^6
 ;;^UTILITY(U,$J,358.3,473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,473,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,473,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,473,2)
 ;;=^5003296
