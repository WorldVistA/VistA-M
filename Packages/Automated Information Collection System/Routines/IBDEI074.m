IBDEI074 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2821,1,3,0)
 ;;=3^Cystitis w/o hematuria
 ;;^UTILITY(U,$J,358.3,2821,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,2821,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,2822,0)
 ;;=N76.0^^7^83^223
 ;;^UTILITY(U,$J,358.3,2822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2822,1,3,0)
 ;;=3^Vaginitis, Unspecified cause, acute
 ;;^UTILITY(U,$J,358.3,2822,1,4,0)
 ;;=4^N76.0
 ;;^UTILITY(U,$J,358.3,2822,2)
 ;;=^5015826
 ;;^UTILITY(U,$J,358.3,2823,0)
 ;;=N76.2^^7^83^14
 ;;^UTILITY(U,$J,358.3,2823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2823,1,3,0)
 ;;=3^Acute vulvitis
 ;;^UTILITY(U,$J,358.3,2823,1,4,0)
 ;;=4^N76.2
 ;;^UTILITY(U,$J,358.3,2823,2)
 ;;=^5015828
 ;;^UTILITY(U,$J,358.3,2824,0)
 ;;=N76.3^^7^83^206
 ;;^UTILITY(U,$J,358.3,2824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2824,1,3,0)
 ;;=3^Subacute and chronic vulvitis
 ;;^UTILITY(U,$J,358.3,2824,1,4,0)
 ;;=4^N76.3
 ;;^UTILITY(U,$J,358.3,2824,2)
 ;;=^5015829
 ;;^UTILITY(U,$J,358.3,2825,0)
 ;;=N76.1^^7^83^205
 ;;^UTILITY(U,$J,358.3,2825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2825,1,3,0)
 ;;=3^Subacute and chronic vaginitis
 ;;^UTILITY(U,$J,358.3,2825,1,4,0)
 ;;=4^N76.1
 ;;^UTILITY(U,$J,358.3,2825,2)
 ;;=^5015827
 ;;^UTILITY(U,$J,358.3,2826,0)
 ;;=B97.89^^7^83^224
 ;;^UTILITY(U,$J,358.3,2826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2826,1,3,0)
 ;;=3^Viral syndrome
 ;;^UTILITY(U,$J,358.3,2826,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,2826,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,2827,0)
 ;;=Z77.21^^7^83^76
 ;;^UTILITY(U,$J,358.3,2827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2827,1,3,0)
 ;;=3^Exposure to potentially hazardous bodily fluids
 ;;^UTILITY(U,$J,358.3,2827,1,4,0)
 ;;=4^Z77.21
 ;;^UTILITY(U,$J,358.3,2827,2)
 ;;=^5063323
 ;;^UTILITY(U,$J,358.3,2828,0)
 ;;=Z72.51^^7^83^112
 ;;^UTILITY(U,$J,358.3,2828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2828,1,3,0)
 ;;=3^High Risk Sexual Behaviors
 ;;^UTILITY(U,$J,358.3,2828,1,4,0)
 ;;=4^Z72.51
 ;;^UTILITY(U,$J,358.3,2828,2)
 ;;=^5063258
 ;;^UTILITY(U,$J,358.3,2829,0)
 ;;=Z20.828^^7^83^43
 ;;^UTILITY(U,$J,358.3,2829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2829,1,3,0)
 ;;=3^Contact or exposure to other viral diseases
 ;;^UTILITY(U,$J,358.3,2829,1,4,0)
 ;;=4^Z20.828
 ;;^UTILITY(U,$J,358.3,2829,2)
 ;;=^5062774
 ;;^UTILITY(U,$J,358.3,2830,0)
 ;;=Z79.899^^7^83^135
 ;;^UTILITY(U,$J,358.3,2830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2830,1,3,0)
 ;;=3^Long term use of medications
 ;;^UTILITY(U,$J,358.3,2830,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,2830,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,2831,0)
 ;;=Z23.^^7^83^67
 ;;^UTILITY(U,$J,358.3,2831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2831,1,3,0)
 ;;=3^Encounter for immunization
 ;;^UTILITY(U,$J,358.3,2831,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,2831,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,2832,0)
 ;;=A08.4^^7^83^88
 ;;^UTILITY(U,$J,358.3,2832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2832,1,3,0)
 ;;=3^Gastroenteritis, viral
 ;;^UTILITY(U,$J,358.3,2832,1,4,0)
 ;;=4^A08.4
 ;;^UTILITY(U,$J,358.3,2832,2)
 ;;=^5000059
 ;;^UTILITY(U,$J,358.3,2833,0)
 ;;=B16.9^^7^83^97
 ;;^UTILITY(U,$J,358.3,2833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2833,1,3,0)
 ;;=3^Hepatitis B, acute
 ;;^UTILITY(U,$J,358.3,2833,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,2833,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,2834,0)
 ;;=B18.1^^7^83^98
 ;;^UTILITY(U,$J,358.3,2834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2834,1,3,0)
 ;;=3^Hepatitis B, chronic without coma
 ;;^UTILITY(U,$J,358.3,2834,1,4,0)
 ;;=4^B18.1
