IBDEI01X ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,386,2)
 ;;=^268120
 ;;^UTILITY(U,$J,358.3,387,0)
 ;;=296.35^^3^38^10
 ;;^UTILITY(U,$J,358.3,387,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,387,1,2,0)
 ;;=2^296.35
 ;;^UTILITY(U,$J,358.3,387,1,5,0)
 ;;=5^MDD, Recur, Part Remiss
 ;;^UTILITY(U,$J,358.3,387,2)
 ;;=^268121
 ;;^UTILITY(U,$J,358.3,388,0)
 ;;=296.36^^3^38^6
 ;;^UTILITY(U,$J,358.3,388,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,388,1,2,0)
 ;;=2^296.36
 ;;^UTILITY(U,$J,358.3,388,1,5,0)
 ;;=5^MDD, Recur, Full Remiss
 ;;^UTILITY(U,$J,358.3,388,2)
 ;;=^268122
 ;;^UTILITY(U,$J,358.3,389,0)
 ;;=311.^^3^38^1
 ;;^UTILITY(U,$J,358.3,389,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,389,1,2,0)
 ;;=2^311.
 ;;^UTILITY(U,$J,358.3,389,1,5,0)
 ;;=5^Depression, NOS
 ;;^UTILITY(U,$J,358.3,389,2)
 ;;=^35603
 ;;^UTILITY(U,$J,358.3,390,0)
 ;;=296.26^^3^38^11
 ;;^UTILITY(U,$J,358.3,390,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,390,1,2,0)
 ;;=2^296.26
 ;;^UTILITY(U,$J,358.3,390,1,5,0)
 ;;=5^MDD, Single, Full Remiss
 ;;^UTILITY(U,$J,358.3,390,2)
 ;;=^268115
 ;;^UTILITY(U,$J,358.3,391,0)
 ;;=301.13^^3^39^1
 ;;^UTILITY(U,$J,358.3,391,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,391,1,2,0)
 ;;=2^301.13
 ;;^UTILITY(U,$J,358.3,391,1,5,0)
 ;;=5^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,391,2)
 ;;=^30028
 ;;^UTILITY(U,$J,358.3,392,0)
 ;;=300.4^^3^39^2
 ;;^UTILITY(U,$J,358.3,392,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,392,1,2,0)
 ;;=2^300.4
 ;;^UTILITY(U,$J,358.3,392,1,5,0)
 ;;=5^Dysthymia
 ;;^UTILITY(U,$J,358.3,392,2)
 ;;=^303478
 ;;^UTILITY(U,$J,358.3,393,0)
 ;;=293.82^^3^39^4
 ;;^UTILITY(U,$J,358.3,393,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,393,1,2,0)
 ;;=2^293.82
 ;;^UTILITY(U,$J,358.3,393,1,5,0)
 ;;=5^Mood D/O,Transient,Hallucinator
 ;;^UTILITY(U,$J,358.3,393,2)
 ;;=^331837
 ;;^UTILITY(U,$J,358.3,394,0)
 ;;=293.83^^3^39^3
 ;;^UTILITY(U,$J,358.3,394,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,394,1,2,0)
 ;;=2^293.83
 ;;^UTILITY(U,$J,358.3,394,1,5,0)
 ;;=5^Mood D/O,Transient,Depressive
 ;;^UTILITY(U,$J,358.3,394,2)
 ;;=^331838
 ;;^UTILITY(U,$J,358.3,395,0)
 ;;=295.12^^3^40^2
 ;;^UTILITY(U,$J,358.3,395,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,395,1,2,0)
 ;;=2^295.12
 ;;^UTILITY(U,$J,358.3,395,1,5,0)
 ;;=5^Disorganized Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,395,2)
 ;;=^268051
 ;;^UTILITY(U,$J,358.3,396,0)
 ;;=295.14^^3^40^3
 ;;^UTILITY(U,$J,358.3,396,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,396,1,2,0)
 ;;=2^295.14
 ;;^UTILITY(U,$J,358.3,396,1,5,0)
 ;;=5^Disorganized Schizophrenia,Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,396,2)
 ;;=^268053
 ;;^UTILITY(U,$J,358.3,397,0)
 ;;=295.52^^3^40^6
 ;;^UTILITY(U,$J,358.3,397,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,397,1,2,0)
 ;;=2^295.52
 ;;^UTILITY(U,$J,358.3,397,1,5,0)
 ;;=5^Latent Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,397,2)
 ;;=Latent Schizophrenia, Chronic^268073
 ;;^UTILITY(U,$J,358.3,398,0)
 ;;=295.54^^3^40^5
 ;;^UTILITY(U,$J,358.3,398,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,398,1,2,0)
 ;;=2^295.54
 ;;^UTILITY(U,$J,358.3,398,1,5,0)
 ;;=5^Latent Schizophrenia, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,398,2)
 ;;=^268075
 ;;^UTILITY(U,$J,358.3,399,0)
 ;;=295.32^^3^40^8
 ;;^UTILITY(U,$J,358.3,399,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,399,1,2,0)
 ;;=2^295.32
 ;;^UTILITY(U,$J,358.3,399,1,5,0)
 ;;=5^Paranoid Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,399,2)
 ;;=Paranoid Schizophrenia, Chronic^268061
 ;;^UTILITY(U,$J,358.3,400,0)
 ;;=295.34^^3^40^9
 ;;^UTILITY(U,$J,358.3,400,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,400,1,2,0)
 ;;=2^295.34
 ;;^UTILITY(U,$J,358.3,400,1,5,0)
 ;;=5^Paranoid, Schizophrenia Chr w/Exacerbation
