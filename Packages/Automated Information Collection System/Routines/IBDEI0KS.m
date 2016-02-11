IBDEI0KS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9407,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,9407,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,9408,0)
 ;;=G40.A19^^63^604^2
 ;;^UTILITY(U,$J,358.3,9408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9408,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9408,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,9408,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,9409,0)
 ;;=G40.309^^63^604^16
 ;;^UTILITY(U,$J,358.3,9409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9409,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9409,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,9409,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,9410,0)
 ;;=G40.311^^63^604^14
 ;;^UTILITY(U,$J,358.3,9410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9410,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9410,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,9410,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,9411,0)
 ;;=G40.319^^63^604^15
 ;;^UTILITY(U,$J,358.3,9411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9411,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9411,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,9411,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,9412,0)
 ;;=G40.409^^63^604^19
 ;;^UTILITY(U,$J,358.3,9412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9412,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9412,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,9412,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,9413,0)
 ;;=G40.411^^63^604^17
 ;;^UTILITY(U,$J,358.3,9413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9413,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9413,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,9413,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,9414,0)
 ;;=G40.419^^63^604^18
 ;;^UTILITY(U,$J,358.3,9414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9414,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9414,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,9414,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,9415,0)
 ;;=G40.209^^63^604^7
 ;;^UTILITY(U,$J,358.3,9415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9415,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9415,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,9415,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,9416,0)
 ;;=G40.211^^63^604^5
 ;;^UTILITY(U,$J,358.3,9416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9416,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9416,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,9416,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,9417,0)
 ;;=G40.219^^63^604^6
 ;;^UTILITY(U,$J,358.3,9417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9417,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9417,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,9417,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,9418,0)
 ;;=G40.109^^63^604^27
 ;;^UTILITY(U,$J,358.3,9418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9418,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9418,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,9418,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,9419,0)
 ;;=G40.111^^63^604^25
 ;;^UTILITY(U,$J,358.3,9419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9419,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
