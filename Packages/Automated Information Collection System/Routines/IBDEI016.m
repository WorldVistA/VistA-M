IBDEI016 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,50,1,2,0)
 ;;=2^309.82
 ;;^UTILITY(U,$J,358.3,50,1,5,0)
 ;;=5^Adj React w/ Phys Symptom
 ;;^UTILITY(U,$J,358.3,50,2)
 ;;=^268315
 ;;^UTILITY(U,$J,358.3,51,0)
 ;;=309.83^^2^6^2
 ;;^UTILITY(U,$J,358.3,51,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,51,1,2,0)
 ;;=2^309.83
 ;;^UTILITY(U,$J,358.3,51,1,5,0)
 ;;=5^Adj Reac w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,51,2)
 ;;=^268316
 ;;^UTILITY(U,$J,358.3,52,0)
 ;;=309.89^^2^6^7
 ;;^UTILITY(U,$J,358.3,52,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,52,1,2,0)
 ;;=2^309.89
 ;;^UTILITY(U,$J,358.3,52,1,5,0)
 ;;=5^Adj Reaction NEC
 ;;^UTILITY(U,$J,358.3,52,2)
 ;;=^268313
 ;;^UTILITY(U,$J,358.3,53,0)
 ;;=300.00^^2^7^4
 ;;^UTILITY(U,$J,358.3,53,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,53,1,2,0)
 ;;=2^300.00
 ;;^UTILITY(U,$J,358.3,53,1,5,0)
 ;;=5^Anxiety State
 ;;^UTILITY(U,$J,358.3,53,2)
 ;;=^9200
 ;;^UTILITY(U,$J,358.3,54,0)
 ;;=300.01^^2^7^9
 ;;^UTILITY(U,$J,358.3,54,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,54,1,2,0)
 ;;=2^300.01
 ;;^UTILITY(U,$J,358.3,54,1,5,0)
 ;;=5^Panic Disord w/o Agoraphobia
 ;;^UTILITY(U,$J,358.3,54,2)
 ;;=^89489
 ;;^UTILITY(U,$J,358.3,55,0)
 ;;=300.02^^2^7^7
 ;;^UTILITY(U,$J,358.3,55,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,55,1,2,0)
 ;;=2^300.02
 ;;^UTILITY(U,$J,358.3,55,1,5,0)
 ;;=5^Generalized Anxiety Dis
 ;;^UTILITY(U,$J,358.3,55,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,56,0)
 ;;=300.20^^2^7^14
 ;;^UTILITY(U,$J,358.3,56,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,56,1,2,0)
 ;;=2^300.20
 ;;^UTILITY(U,$J,358.3,56,1,5,0)
 ;;=5^Phobia, Unspecified
 ;;^UTILITY(U,$J,358.3,56,2)
 ;;=^93428
 ;;^UTILITY(U,$J,358.3,57,0)
 ;;=300.21^^2^7^10
 ;;^UTILITY(U,$J,358.3,57,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,57,1,2,0)
 ;;=2^300.21
 ;;^UTILITY(U,$J,358.3,57,1,5,0)
 ;;=5^Panic W/Agoraphobia
 ;;^UTILITY(U,$J,358.3,57,2)
 ;;=^268168
 ;;^UTILITY(U,$J,358.3,58,0)
 ;;=300.22^^2^7^3
 ;;^UTILITY(U,$J,358.3,58,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,58,1,2,0)
 ;;=2^300.22
 ;;^UTILITY(U,$J,358.3,58,1,5,0)
 ;;=5^Agoraphobia w/o Panic
 ;;^UTILITY(U,$J,358.3,58,2)
 ;;=^4218
 ;;^UTILITY(U,$J,358.3,59,0)
 ;;=300.23^^2^7^13
 ;;^UTILITY(U,$J,358.3,59,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,59,1,2,0)
 ;;=2^300.23
 ;;^UTILITY(U,$J,358.3,59,1,5,0)
 ;;=5^Phobia, Social
 ;;^UTILITY(U,$J,358.3,59,2)
 ;;=^93420
 ;;^UTILITY(U,$J,358.3,60,0)
 ;;=300.29^^2^7^12
 ;;^UTILITY(U,$J,358.3,60,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,60,1,2,0)
 ;;=2^300.29
 ;;^UTILITY(U,$J,358.3,60,1,5,0)
 ;;=5^Phobia, Simple
 ;;^UTILITY(U,$J,358.3,60,2)
 ;;=^87670
 ;;^UTILITY(U,$J,358.3,61,0)
 ;;=300.3^^2^7^8
 ;;^UTILITY(U,$J,358.3,61,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,61,1,2,0)
 ;;=2^300.3
 ;;^UTILITY(U,$J,358.3,61,1,5,0)
 ;;=5^Obsessive/Compulsive
 ;;^UTILITY(U,$J,358.3,61,2)
 ;;=^84904
 ;;^UTILITY(U,$J,358.3,62,0)
 ;;=308.9^^2^7^1
 ;;^UTILITY(U,$J,358.3,62,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,62,1,2,0)
 ;;=2^308.9
 ;;^UTILITY(U,$J,358.3,62,1,5,0)
 ;;=5^Acute Stress Reaction
 ;;^UTILITY(U,$J,358.3,62,2)
 ;;=^268303
 ;;^UTILITY(U,$J,358.3,63,0)
 ;;=300.15^^2^7^6
 ;;^UTILITY(U,$J,358.3,63,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,63,1,2,0)
 ;;=2^300.15
 ;;^UTILITY(U,$J,358.3,63,1,5,0)
 ;;=5^Dissociative Reaction
 ;;^UTILITY(U,$J,358.3,63,2)
 ;;=^35700
 ;;^UTILITY(U,$J,358.3,64,0)
 ;;=291.1^^2^8^5
 ;;^UTILITY(U,$J,358.3,64,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,64,1,2,0)
 ;;=2^291.1
 ;;^UTILITY(U,$J,358.3,64,1,5,0)
 ;;=5^Amnestic Syndrome Due to Alcohol
 ;;^UTILITY(U,$J,358.3,64,2)
 ;;=^303492
