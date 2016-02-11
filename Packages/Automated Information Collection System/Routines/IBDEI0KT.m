IBDEI0KT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9419,1,4,0)
 ;;=4^G40.111
 ;;^UTILITY(U,$J,358.3,9419,2)
 ;;=^5003835
 ;;^UTILITY(U,$J,358.3,9420,0)
 ;;=G40.119^^63^604^26
 ;;^UTILITY(U,$J,358.3,9420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9420,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9420,1,4,0)
 ;;=4^G40.119
 ;;^UTILITY(U,$J,358.3,9420,2)
 ;;=^5003836
 ;;^UTILITY(U,$J,358.3,9421,0)
 ;;=G40.B09^^63^604^22
 ;;^UTILITY(U,$J,358.3,9421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9421,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9421,1,4,0)
 ;;=4^G40.B09
 ;;^UTILITY(U,$J,358.3,9421,2)
 ;;=^5003873
 ;;^UTILITY(U,$J,358.3,9422,0)
 ;;=G40.B11^^63^604^20
 ;;^UTILITY(U,$J,358.3,9422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9422,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9422,1,4,0)
 ;;=4^G40.B11
 ;;^UTILITY(U,$J,358.3,9422,2)
 ;;=^5003874
 ;;^UTILITY(U,$J,358.3,9423,0)
 ;;=G40.B19^^63^604^21
 ;;^UTILITY(U,$J,358.3,9423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9423,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9423,1,4,0)
 ;;=4^G40.B19
 ;;^UTILITY(U,$J,358.3,9423,2)
 ;;=^5003875
 ;;^UTILITY(U,$J,358.3,9424,0)
 ;;=G40.509^^63^604^13
 ;;^UTILITY(U,$J,358.3,9424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9424,1,3,0)
 ;;=3^Epileptic Seizures d/t External Causes Not Intractalbe w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9424,1,4,0)
 ;;=4^G40.509
 ;;^UTILITY(U,$J,358.3,9424,2)
 ;;=^5003850
 ;;^UTILITY(U,$J,358.3,9425,0)
 ;;=G40.909^^63^604^12
 ;;^UTILITY(U,$J,358.3,9425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9425,1,3,0)
 ;;=3^Epilepsy Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9425,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,9425,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,9426,0)
 ;;=G40.911^^63^604^10
 ;;^UTILITY(U,$J,358.3,9426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9426,1,3,0)
 ;;=3^Epilepsy Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9426,1,4,0)
 ;;=4^G40.911
 ;;^UTILITY(U,$J,358.3,9426,2)
 ;;=^5003866
 ;;^UTILITY(U,$J,358.3,9427,0)
 ;;=G40.919^^63^604^11
 ;;^UTILITY(U,$J,358.3,9427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9427,1,3,0)
 ;;=3^Epilepsy Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9427,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,9427,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,9428,0)
 ;;=G93.81^^63^604^23
 ;;^UTILITY(U,$J,358.3,9428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9428,1,3,0)
 ;;=3^Mesial Temporal Sclerosis
 ;;^UTILITY(U,$J,358.3,9428,1,4,0)
 ;;=4^G93.81
 ;;^UTILITY(U,$J,358.3,9428,2)
 ;;=^338233
 ;;^UTILITY(U,$J,358.3,9429,0)
 ;;=F44.5^^63^604^8
 ;;^UTILITY(U,$J,358.3,9429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9429,1,3,0)
 ;;=3^Conversion Disorder w/ Seizures/Convulsions
 ;;^UTILITY(U,$J,358.3,9429,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,9429,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,9430,0)
 ;;=R40.4^^63^604^30
 ;;^UTILITY(U,$J,358.3,9430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9430,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,9430,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,9430,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,9431,0)
 ;;=R40.1^^63^604^29
 ;;^UTILITY(U,$J,358.3,9431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9431,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,9431,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,9431,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,9432,0)
 ;;=R40.0^^63^604^28
