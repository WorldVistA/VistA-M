IBDEI08X ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3713,0)
 ;;=296.36^^11^160^6
 ;;^UTILITY(U,$J,358.3,3713,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3713,1,2,0)
 ;;=2^296.36
 ;;^UTILITY(U,$J,358.3,3713,1,5,0)
 ;;=5^MDD, Recur, Full Remiss
 ;;^UTILITY(U,$J,358.3,3713,2)
 ;;=^268122
 ;;^UTILITY(U,$J,358.3,3714,0)
 ;;=311.^^11^160^1
 ;;^UTILITY(U,$J,358.3,3714,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3714,1,2,0)
 ;;=2^311.
 ;;^UTILITY(U,$J,358.3,3714,1,5,0)
 ;;=5^Depression, NOS
 ;;^UTILITY(U,$J,358.3,3714,2)
 ;;=^35603
 ;;^UTILITY(U,$J,358.3,3715,0)
 ;;=296.26^^11^160^11
 ;;^UTILITY(U,$J,358.3,3715,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3715,1,2,0)
 ;;=2^296.26
 ;;^UTILITY(U,$J,358.3,3715,1,5,0)
 ;;=5^MDD, Single, Full Remiss
 ;;^UTILITY(U,$J,358.3,3715,2)
 ;;=^268115
 ;;^UTILITY(U,$J,358.3,3716,0)
 ;;=301.13^^11^161^1
 ;;^UTILITY(U,$J,358.3,3716,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3716,1,2,0)
 ;;=2^301.13
 ;;^UTILITY(U,$J,358.3,3716,1,5,0)
 ;;=5^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,3716,2)
 ;;=^30028
 ;;^UTILITY(U,$J,358.3,3717,0)
 ;;=300.4^^11^161^2
 ;;^UTILITY(U,$J,358.3,3717,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3717,1,2,0)
 ;;=2^300.4
 ;;^UTILITY(U,$J,358.3,3717,1,5,0)
 ;;=5^Dysthymia
 ;;^UTILITY(U,$J,358.3,3717,2)
 ;;=^303478
 ;;^UTILITY(U,$J,358.3,3718,0)
 ;;=293.82^^11^161^4
 ;;^UTILITY(U,$J,358.3,3718,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3718,1,2,0)
 ;;=2^293.82
 ;;^UTILITY(U,$J,358.3,3718,1,5,0)
 ;;=5^Psychotic D/O,Transient,Hallucination
 ;;^UTILITY(U,$J,358.3,3718,2)
 ;;=^331837
 ;;^UTILITY(U,$J,358.3,3719,0)
 ;;=293.83^^11^161^3
 ;;^UTILITY(U,$J,358.3,3719,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3719,1,2,0)
 ;;=2^293.83
 ;;^UTILITY(U,$J,358.3,3719,1,5,0)
 ;;=5^Mood D/O,Transient,Depressive
 ;;^UTILITY(U,$J,358.3,3719,2)
 ;;=^331838
 ;;^UTILITY(U,$J,358.3,3720,0)
 ;;=295.12^^11^162^2
 ;;^UTILITY(U,$J,358.3,3720,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3720,1,2,0)
 ;;=2^295.12
 ;;^UTILITY(U,$J,358.3,3720,1,5,0)
 ;;=5^Disorganized Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,3720,2)
 ;;=^268051
 ;;^UTILITY(U,$J,358.3,3721,0)
 ;;=295.14^^11^162^3
 ;;^UTILITY(U,$J,358.3,3721,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3721,1,2,0)
 ;;=2^295.14
 ;;^UTILITY(U,$J,358.3,3721,1,5,0)
 ;;=5^Disorganized Schizophrenia,Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,3721,2)
 ;;=^268053
 ;;^UTILITY(U,$J,358.3,3722,0)
 ;;=295.52^^11^162^6
 ;;^UTILITY(U,$J,358.3,3722,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3722,1,2,0)
 ;;=2^295.52
 ;;^UTILITY(U,$J,358.3,3722,1,5,0)
 ;;=5^Latent Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,3722,2)
 ;;=Latent Schizophrenia, Chronic^268073
 ;;^UTILITY(U,$J,358.3,3723,0)
 ;;=295.54^^11^162^5
 ;;^UTILITY(U,$J,358.3,3723,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3723,1,2,0)
 ;;=2^295.54
 ;;^UTILITY(U,$J,358.3,3723,1,5,0)
 ;;=5^Latent Schizophrenia, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,3723,2)
 ;;=^268075
 ;;^UTILITY(U,$J,358.3,3724,0)
 ;;=295.32^^11^162^8
 ;;^UTILITY(U,$J,358.3,3724,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3724,1,2,0)
 ;;=2^295.32
 ;;^UTILITY(U,$J,358.3,3724,1,5,0)
 ;;=5^Paranoid Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,3724,2)
 ;;=Paranoid Schizophrenia, Chronic^268061
 ;;^UTILITY(U,$J,358.3,3725,0)
 ;;=295.34^^11^162^9
 ;;^UTILITY(U,$J,358.3,3725,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3725,1,2,0)
 ;;=2^295.34
 ;;^UTILITY(U,$J,358.3,3725,1,5,0)
 ;;=5^Paranoid, Schizophrenia Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,3725,2)
 ;;=^268063
 ;;^UTILITY(U,$J,358.3,3726,0)
 ;;=295.62^^11^162^23
 ;;^UTILITY(U,$J,358.3,3726,1,0)
 ;;=^358.31IA^5^2
