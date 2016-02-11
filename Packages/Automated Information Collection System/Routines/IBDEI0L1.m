IBDEI0L1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9527,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9527,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,9527,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,9528,0)
 ;;=G40.109^^65^617^27
 ;;^UTILITY(U,$J,358.3,9528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9528,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9528,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,9528,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,9529,0)
 ;;=G40.111^^65^617^25
 ;;^UTILITY(U,$J,358.3,9529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9529,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9529,1,4,0)
 ;;=4^G40.111
 ;;^UTILITY(U,$J,358.3,9529,2)
 ;;=^5003835
 ;;^UTILITY(U,$J,358.3,9530,0)
 ;;=G40.119^^65^617^26
 ;;^UTILITY(U,$J,358.3,9530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9530,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9530,1,4,0)
 ;;=4^G40.119
 ;;^UTILITY(U,$J,358.3,9530,2)
 ;;=^5003836
 ;;^UTILITY(U,$J,358.3,9531,0)
 ;;=G40.B09^^65^617^22
 ;;^UTILITY(U,$J,358.3,9531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9531,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9531,1,4,0)
 ;;=4^G40.B09
 ;;^UTILITY(U,$J,358.3,9531,2)
 ;;=^5003873
 ;;^UTILITY(U,$J,358.3,9532,0)
 ;;=G40.B11^^65^617^20
 ;;^UTILITY(U,$J,358.3,9532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9532,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9532,1,4,0)
 ;;=4^G40.B11
 ;;^UTILITY(U,$J,358.3,9532,2)
 ;;=^5003874
 ;;^UTILITY(U,$J,358.3,9533,0)
 ;;=G40.B19^^65^617^21
 ;;^UTILITY(U,$J,358.3,9533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9533,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9533,1,4,0)
 ;;=4^G40.B19
 ;;^UTILITY(U,$J,358.3,9533,2)
 ;;=^5003875
 ;;^UTILITY(U,$J,358.3,9534,0)
 ;;=G40.509^^65^617^13
 ;;^UTILITY(U,$J,358.3,9534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9534,1,3,0)
 ;;=3^Epileptic Seizures d/t External Causes Not Intractalbe w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9534,1,4,0)
 ;;=4^G40.509
 ;;^UTILITY(U,$J,358.3,9534,2)
 ;;=^5003850
 ;;^UTILITY(U,$J,358.3,9535,0)
 ;;=G40.909^^65^617^12
 ;;^UTILITY(U,$J,358.3,9535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9535,1,3,0)
 ;;=3^Epilepsy Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9535,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,9535,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,9536,0)
 ;;=G40.911^^65^617^10
 ;;^UTILITY(U,$J,358.3,9536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9536,1,3,0)
 ;;=3^Epilepsy Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9536,1,4,0)
 ;;=4^G40.911
 ;;^UTILITY(U,$J,358.3,9536,2)
 ;;=^5003866
 ;;^UTILITY(U,$J,358.3,9537,0)
 ;;=G40.919^^65^617^11
 ;;^UTILITY(U,$J,358.3,9537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9537,1,3,0)
 ;;=3^Epilepsy Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9537,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,9537,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,9538,0)
 ;;=G93.81^^65^617^23
 ;;^UTILITY(U,$J,358.3,9538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9538,1,3,0)
 ;;=3^Mesial Temporal Sclerosis
 ;;^UTILITY(U,$J,358.3,9538,1,4,0)
 ;;=4^G93.81
 ;;^UTILITY(U,$J,358.3,9538,2)
 ;;=^338233
 ;;^UTILITY(U,$J,358.3,9539,0)
 ;;=F44.5^^65^617^8
 ;;^UTILITY(U,$J,358.3,9539,1,0)
 ;;=^358.31IA^4^2
