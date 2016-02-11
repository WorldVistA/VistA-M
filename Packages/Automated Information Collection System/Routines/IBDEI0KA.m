IBDEI0KA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9163,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9163,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,9163,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,9164,0)
 ;;=G40.319^^58^572^15
 ;;^UTILITY(U,$J,358.3,9164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9164,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9164,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,9164,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,9165,0)
 ;;=G40.409^^58^572^19
 ;;^UTILITY(U,$J,358.3,9165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9165,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9165,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,9165,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,9166,0)
 ;;=G40.411^^58^572^17
 ;;^UTILITY(U,$J,358.3,9166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9166,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9166,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,9166,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,9167,0)
 ;;=G40.419^^58^572^18
 ;;^UTILITY(U,$J,358.3,9167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9167,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9167,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,9167,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,9168,0)
 ;;=G40.209^^58^572^7
 ;;^UTILITY(U,$J,358.3,9168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9168,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9168,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,9168,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,9169,0)
 ;;=G40.211^^58^572^5
 ;;^UTILITY(U,$J,358.3,9169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9169,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9169,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,9169,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,9170,0)
 ;;=G40.219^^58^572^6
 ;;^UTILITY(U,$J,358.3,9170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9170,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9170,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,9170,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,9171,0)
 ;;=G40.109^^58^572^27
 ;;^UTILITY(U,$J,358.3,9171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9171,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9171,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,9171,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,9172,0)
 ;;=G40.111^^58^572^25
 ;;^UTILITY(U,$J,358.3,9172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9172,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9172,1,4,0)
 ;;=4^G40.111
 ;;^UTILITY(U,$J,358.3,9172,2)
 ;;=^5003835
 ;;^UTILITY(U,$J,358.3,9173,0)
 ;;=G40.119^^58^572^26
 ;;^UTILITY(U,$J,358.3,9173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9173,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9173,1,4,0)
 ;;=4^G40.119
 ;;^UTILITY(U,$J,358.3,9173,2)
 ;;=^5003836
 ;;^UTILITY(U,$J,358.3,9174,0)
 ;;=G40.B09^^58^572^22
 ;;^UTILITY(U,$J,358.3,9174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9174,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9174,1,4,0)
 ;;=4^G40.B09
 ;;^UTILITY(U,$J,358.3,9174,2)
 ;;=^5003873
 ;;^UTILITY(U,$J,358.3,9175,0)
 ;;=G40.B11^^58^572^20
