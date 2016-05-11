IBDEI0H1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7873,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,7873,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,7874,0)
 ;;=B20.^^30^416^18
 ;;^UTILITY(U,$J,358.3,7874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7874,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,7874,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,7874,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,7875,0)
 ;;=F10.27^^30^416^1
 ;;^UTILITY(U,$J,358.3,7875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7875,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,7875,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,7875,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,7876,0)
 ;;=F19.97^^30^416^29
 ;;^UTILITY(U,$J,358.3,7876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7876,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,7876,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,7876,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,7877,0)
 ;;=F03.90^^30^416^15
 ;;^UTILITY(U,$J,358.3,7877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7877,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,7877,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,7877,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,7878,0)
 ;;=G30.0^^30^416^2
 ;;^UTILITY(U,$J,358.3,7878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7878,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,7878,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,7878,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,7879,0)
 ;;=G30.1^^30^416^3
 ;;^UTILITY(U,$J,358.3,7879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7879,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,7879,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,7879,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,7880,0)
 ;;=G30.9^^30^416^4
 ;;^UTILITY(U,$J,358.3,7880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7880,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7880,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,7880,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,7881,0)
 ;;=G10.^^30^416^19
 ;;^UTILITY(U,$J,358.3,7881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7881,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,7881,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,7881,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,7882,0)
 ;;=G10.^^30^416^20
 ;;^UTILITY(U,$J,358.3,7882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7882,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,7882,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,7882,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,7883,0)
 ;;=G90.3^^30^416^21
 ;;^UTILITY(U,$J,358.3,7883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7883,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,7883,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,7883,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,7884,0)
 ;;=G91.2^^30^416^22
 ;;^UTILITY(U,$J,358.3,7884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7884,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,7884,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,7884,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,7885,0)
 ;;=G91.2^^30^416^23
 ;;^UTILITY(U,$J,358.3,7885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7885,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,7885,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,7885,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,7886,0)
 ;;=G30.8^^30^416^5
