IBDEI0L0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9515,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9515,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,9515,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,9516,0)
 ;;=G40.A09^^65^617^4
 ;;^UTILITY(U,$J,358.3,9516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9516,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9516,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,9516,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,9517,0)
 ;;=G40.A11^^65^617^1
 ;;^UTILITY(U,$J,358.3,9517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9517,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9517,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,9517,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,9518,0)
 ;;=G40.A19^^65^617^2
 ;;^UTILITY(U,$J,358.3,9518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9518,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9518,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,9518,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,9519,0)
 ;;=G40.309^^65^617^16
 ;;^UTILITY(U,$J,358.3,9519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9519,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9519,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,9519,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,9520,0)
 ;;=G40.311^^65^617^14
 ;;^UTILITY(U,$J,358.3,9520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9520,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9520,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,9520,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,9521,0)
 ;;=G40.319^^65^617^15
 ;;^UTILITY(U,$J,358.3,9521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9521,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9521,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,9521,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,9522,0)
 ;;=G40.409^^65^617^19
 ;;^UTILITY(U,$J,358.3,9522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9522,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9522,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,9522,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,9523,0)
 ;;=G40.411^^65^617^17
 ;;^UTILITY(U,$J,358.3,9523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9523,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9523,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,9523,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,9524,0)
 ;;=G40.419^^65^617^18
 ;;^UTILITY(U,$J,358.3,9524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9524,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9524,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,9524,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,9525,0)
 ;;=G40.209^^65^617^7
 ;;^UTILITY(U,$J,358.3,9525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9525,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9525,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,9525,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,9526,0)
 ;;=G40.211^^65^617^5
 ;;^UTILITY(U,$J,358.3,9526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9526,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9526,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,9526,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,9527,0)
 ;;=G40.219^^65^617^6
