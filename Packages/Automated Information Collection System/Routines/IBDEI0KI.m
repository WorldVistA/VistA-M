IBDEI0KI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9271,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9271,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,9271,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,9272,0)
 ;;=G40.A09^^61^588^4
 ;;^UTILITY(U,$J,358.3,9272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9272,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9272,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,9272,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,9273,0)
 ;;=G40.A11^^61^588^1
 ;;^UTILITY(U,$J,358.3,9273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9273,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9273,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,9273,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,9274,0)
 ;;=G40.A19^^61^588^2
 ;;^UTILITY(U,$J,358.3,9274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9274,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9274,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,9274,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,9275,0)
 ;;=G40.309^^61^588^16
 ;;^UTILITY(U,$J,358.3,9275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9275,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9275,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,9275,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,9276,0)
 ;;=G40.311^^61^588^14
 ;;^UTILITY(U,$J,358.3,9276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9276,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9276,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,9276,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,9277,0)
 ;;=G40.319^^61^588^15
 ;;^UTILITY(U,$J,358.3,9277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9277,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9277,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,9277,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,9278,0)
 ;;=G40.409^^61^588^19
 ;;^UTILITY(U,$J,358.3,9278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9278,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9278,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,9278,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,9279,0)
 ;;=G40.411^^61^588^17
 ;;^UTILITY(U,$J,358.3,9279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9279,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9279,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,9279,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,9280,0)
 ;;=G40.419^^61^588^18
 ;;^UTILITY(U,$J,358.3,9280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9280,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9280,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,9280,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,9281,0)
 ;;=G40.209^^61^588^7
 ;;^UTILITY(U,$J,358.3,9281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9281,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9281,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,9281,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,9282,0)
 ;;=G40.211^^61^588^5
 ;;^UTILITY(U,$J,358.3,9282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9282,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9282,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,9282,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,9283,0)
 ;;=G40.219^^61^588^6
 ;;^UTILITY(U,$J,358.3,9283,1,0)
 ;;=^358.31IA^4^2
