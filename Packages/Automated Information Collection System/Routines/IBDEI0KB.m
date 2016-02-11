IBDEI0KB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9175,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9175,1,4,0)
 ;;=4^G40.B11
 ;;^UTILITY(U,$J,358.3,9175,2)
 ;;=^5003874
 ;;^UTILITY(U,$J,358.3,9176,0)
 ;;=G40.B19^^58^572^21
 ;;^UTILITY(U,$J,358.3,9176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9176,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9176,1,4,0)
 ;;=4^G40.B19
 ;;^UTILITY(U,$J,358.3,9176,2)
 ;;=^5003875
 ;;^UTILITY(U,$J,358.3,9177,0)
 ;;=G40.509^^58^572^13
 ;;^UTILITY(U,$J,358.3,9177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9177,1,3,0)
 ;;=3^Epileptic Seizures d/t External Causes Not Intractalbe w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9177,1,4,0)
 ;;=4^G40.509
 ;;^UTILITY(U,$J,358.3,9177,2)
 ;;=^5003850
 ;;^UTILITY(U,$J,358.3,9178,0)
 ;;=G40.909^^58^572^12
 ;;^UTILITY(U,$J,358.3,9178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9178,1,3,0)
 ;;=3^Epilepsy Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9178,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,9178,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,9179,0)
 ;;=G40.911^^58^572^10
 ;;^UTILITY(U,$J,358.3,9179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9179,1,3,0)
 ;;=3^Epilepsy Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9179,1,4,0)
 ;;=4^G40.911
 ;;^UTILITY(U,$J,358.3,9179,2)
 ;;=^5003866
 ;;^UTILITY(U,$J,358.3,9180,0)
 ;;=G40.919^^58^572^11
 ;;^UTILITY(U,$J,358.3,9180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9180,1,3,0)
 ;;=3^Epilepsy Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9180,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,9180,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,9181,0)
 ;;=G93.81^^58^572^23
 ;;^UTILITY(U,$J,358.3,9181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9181,1,3,0)
 ;;=3^Mesial Temporal Sclerosis
 ;;^UTILITY(U,$J,358.3,9181,1,4,0)
 ;;=4^G93.81
 ;;^UTILITY(U,$J,358.3,9181,2)
 ;;=^338233
 ;;^UTILITY(U,$J,358.3,9182,0)
 ;;=F44.5^^58^572^8
 ;;^UTILITY(U,$J,358.3,9182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9182,1,3,0)
 ;;=3^Conversion Disorder w/ Seizures/Convulsions
 ;;^UTILITY(U,$J,358.3,9182,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,9182,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,9183,0)
 ;;=R40.4^^58^572^30
 ;;^UTILITY(U,$J,358.3,9183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9183,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,9183,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,9183,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,9184,0)
 ;;=R40.1^^58^572^29
 ;;^UTILITY(U,$J,358.3,9184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9184,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,9184,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,9184,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,9185,0)
 ;;=R40.0^^58^572^28
 ;;^UTILITY(U,$J,358.3,9185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9185,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,9185,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,9185,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,9186,0)
 ;;=R56.9^^58^572^9
 ;;^UTILITY(U,$J,358.3,9186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9186,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,9186,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,9186,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,9187,0)
 ;;=R56.1^^58^572^24
 ;;^UTILITY(U,$J,358.3,9187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9187,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,9187,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,9187,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,9188,0)
 ;;=G45.0^^58^573^15
