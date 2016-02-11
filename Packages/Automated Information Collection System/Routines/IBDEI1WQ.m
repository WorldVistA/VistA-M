IBDEI1WQ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31939,0)
 ;;=A81.00^^141^1478^9
 ;;^UTILITY(U,$J,358.3,31939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31939,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,31939,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,31939,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,31940,0)
 ;;=A81.01^^141^1478^38
 ;;^UTILITY(U,$J,358.3,31940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31940,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,31940,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,31940,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,31941,0)
 ;;=A81.09^^141^1478^8
 ;;^UTILITY(U,$J,358.3,31941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31941,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,31941,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,31941,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,31942,0)
 ;;=A81.2^^141^1478^33
 ;;^UTILITY(U,$J,358.3,31942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31942,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,31942,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,31942,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,31943,0)
 ;;=F01.50^^141^1478^31
 ;;^UTILITY(U,$J,358.3,31943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31943,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,31943,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,31943,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,31944,0)
 ;;=F01.51^^141^1478^32
 ;;^UTILITY(U,$J,358.3,31944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31944,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,31944,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,31944,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,31945,0)
 ;;=F10.27^^141^1478^1
 ;;^UTILITY(U,$J,358.3,31945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31945,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,31945,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,31945,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,31946,0)
 ;;=F19.97^^141^1478^37
 ;;^UTILITY(U,$J,358.3,31946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31946,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,31946,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,31946,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,31947,0)
 ;;=F02.80^^141^1478^13
 ;;^UTILITY(U,$J,358.3,31947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31947,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,31947,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,31947,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,31948,0)
 ;;=F02.81^^141^1478^14
 ;;^UTILITY(U,$J,358.3,31948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31948,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,31948,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,31948,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,31949,0)
 ;;=F06.8^^141^1478^24
 ;;^UTILITY(U,$J,358.3,31949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31949,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,31949,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,31949,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,31950,0)
 ;;=G30.9^^141^1478^5
 ;;^UTILITY(U,$J,358.3,31950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31950,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,31950,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,31950,2)
 ;;=^5003808
