IBDEI1EW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24003,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,24003,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,24004,0)
 ;;=G94.^^90^1039^7
 ;;^UTILITY(U,$J,358.3,24004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24004,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,24004,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,24004,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,24005,0)
 ;;=G31.83^^90^1039^16
 ;;^UTILITY(U,$J,358.3,24005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24005,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,24005,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,24005,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,24006,0)
 ;;=G31.89^^90^1039^11
 ;;^UTILITY(U,$J,358.3,24006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24006,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,24006,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,24006,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,24007,0)
 ;;=G31.9^^90^1039^12
 ;;^UTILITY(U,$J,358.3,24007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24007,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,24007,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,24007,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,24008,0)
 ;;=G23.8^^90^1039^10
 ;;^UTILITY(U,$J,358.3,24008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24008,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,24008,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,24008,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,24009,0)
 ;;=G31.09^^90^1039^22
 ;;^UTILITY(U,$J,358.3,24009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24009,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,24009,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,24009,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,24010,0)
 ;;=G30.0^^90^1039^3
 ;;^UTILITY(U,$J,358.3,24010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24010,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,24010,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,24010,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,24011,0)
 ;;=G30.1^^90^1039^4
 ;;^UTILITY(U,$J,358.3,24011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24011,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,24011,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,24011,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,24012,0)
 ;;=B20.^^90^1039^18
 ;;^UTILITY(U,$J,358.3,24012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24012,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,24012,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,24012,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,24013,0)
 ;;=B20.^^90^1039^19
 ;;^UTILITY(U,$J,358.3,24013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24013,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,24013,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,24013,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,24014,0)
 ;;=G10.^^90^1039^20
 ;;^UTILITY(U,$J,358.3,24014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24014,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,24014,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,24014,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,24015,0)
 ;;=G10.^^90^1039^21
 ;;^UTILITY(U,$J,358.3,24015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24015,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,24015,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,24015,2)
 ;;=^5003751^F02.80
