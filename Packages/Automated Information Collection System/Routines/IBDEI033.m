IBDEI033 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,698,1,3,0)
 ;;=3^Acne Vulgaris
 ;;^UTILITY(U,$J,358.3,698,1,4,0)
 ;;=4^L70.0
 ;;^UTILITY(U,$J,358.3,698,2)
 ;;=^5009268
 ;;^UTILITY(U,$J,358.3,699,0)
 ;;=L70.8^^9^88^4
 ;;^UTILITY(U,$J,358.3,699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,699,1,3,0)
 ;;=3^Acne,Other
 ;;^UTILITY(U,$J,358.3,699,1,4,0)
 ;;=4^L70.8
 ;;^UTILITY(U,$J,358.3,699,2)
 ;;=^87239
 ;;^UTILITY(U,$J,358.3,700,0)
 ;;=H10.33^^9^88^5
 ;;^UTILITY(U,$J,358.3,700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,700,1,3,0)
 ;;=3^Acute Conjunctivitis,Bilateral
 ;;^UTILITY(U,$J,358.3,700,1,4,0)
 ;;=4^H10.33
 ;;^UTILITY(U,$J,358.3,700,2)
 ;;=^5004680
 ;;^UTILITY(U,$J,358.3,701,0)
 ;;=H10.32^^9^88^6
 ;;^UTILITY(U,$J,358.3,701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,701,1,3,0)
 ;;=3^Acute Conjunctivitis,Left Eye
 ;;^UTILITY(U,$J,358.3,701,1,4,0)
 ;;=4^H10.32
 ;;^UTILITY(U,$J,358.3,701,2)
 ;;=^5133459
 ;;^UTILITY(U,$J,358.3,702,0)
 ;;=H10.31^^9^88^7
 ;;^UTILITY(U,$J,358.3,702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,702,1,3,0)
 ;;=3^Acute Conjunctivitis,Right Eye
 ;;^UTILITY(U,$J,358.3,702,1,4,0)
 ;;=4^H10.31
 ;;^UTILITY(U,$J,358.3,702,2)
 ;;=^5133458
 ;;^UTILITY(U,$J,358.3,703,0)
 ;;=J02.9^^9^88^8
 ;;^UTILITY(U,$J,358.3,703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,703,1,3,0)
 ;;=3^Acute Pharyngitis,Unspec
 ;;^UTILITY(U,$J,358.3,703,1,4,0)
 ;;=4^J02.9
 ;;^UTILITY(U,$J,358.3,703,2)
 ;;=^5008130
 ;;^UTILITY(U,$J,358.3,704,0)
 ;;=J01.90^^9^88^9
 ;;^UTILITY(U,$J,358.3,704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,704,1,3,0)
 ;;=3^Acute Sinusitis,Unspec
 ;;^UTILITY(U,$J,358.3,704,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,704,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,705,0)
 ;;=J06.9^^9^88^10
 ;;^UTILITY(U,$J,358.3,705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,705,1,3,0)
 ;;=3^Acute Upper Respiratory Infection,Unspec
 ;;^UTILITY(U,$J,358.3,705,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,705,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,706,0)
 ;;=T50.995A^^9^88^11
 ;;^UTILITY(U,$J,358.3,706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,706,1,3,0)
 ;;=3^Adverse Effect of Drug/Meds/Biol Subst,Initial
 ;;^UTILITY(U,$J,358.3,706,1,4,0)
 ;;=4^T50.995A
 ;;^UTILITY(U,$J,358.3,706,2)
 ;;=^5052178
 ;;^UTILITY(U,$J,358.3,707,0)
 ;;=T50.905A^^9^88^12
 ;;^UTILITY(U,$J,358.3,707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,707,1,3,0)
 ;;=3^Adverse Effect of Unspec Drug/Meds/Biol Subst,Initial
 ;;^UTILITY(U,$J,358.3,707,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,707,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,708,0)
 ;;=J30.9^^9^88^23
 ;;^UTILITY(U,$J,358.3,708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,708,1,3,0)
 ;;=3^Allergic Rhinitis,Unspec
 ;;^UTILITY(U,$J,358.3,708,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,708,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,709,0)
 ;;=L50.0^^9^88^24
 ;;^UTILITY(U,$J,358.3,709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,709,1,3,0)
 ;;=3^Allergic Urticaria
 ;;^UTILITY(U,$J,358.3,709,1,4,0)
 ;;=4^L50.0
 ;;^UTILITY(U,$J,358.3,709,2)
 ;;=^5009200
 ;;^UTILITY(U,$J,358.3,710,0)
 ;;=T78.00XA^^9^88^40
 ;;^UTILITY(U,$J,358.3,710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,710,1,3,0)
 ;;=3^Anaphylactic Reaction d/t Food,Initial
 ;;^UTILITY(U,$J,358.3,710,1,4,0)
 ;;=4^T78.00XA
 ;;^UTILITY(U,$J,358.3,710,2)
 ;;=^5054245
 ;;^UTILITY(U,$J,358.3,711,0)
 ;;=T78.2XXA^^9^88^41
 ;;^UTILITY(U,$J,358.3,711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,711,1,3,0)
 ;;=3^Anaphylactic Shock,Initial
 ;;^UTILITY(U,$J,358.3,711,1,4,0)
 ;;=4^T78.2XXA
 ;;^UTILITY(U,$J,358.3,711,2)
 ;;=^5054278
 ;;^UTILITY(U,$J,358.3,712,0)
 ;;=D64.9^^9^88^42
