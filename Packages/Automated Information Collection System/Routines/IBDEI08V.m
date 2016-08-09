IBDEI08V ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8813,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,8813,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,8813,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,8814,0)
 ;;=F01.50^^42^518^31
 ;;^UTILITY(U,$J,358.3,8814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8814,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,8814,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,8814,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,8815,0)
 ;;=A81.9^^42^518^6
 ;;^UTILITY(U,$J,358.3,8815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8815,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,8815,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,8815,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,8816,0)
 ;;=A81.09^^42^518^8
 ;;^UTILITY(U,$J,358.3,8816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8816,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,8816,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,8816,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,8817,0)
 ;;=A81.00^^42^518^9
 ;;^UTILITY(U,$J,358.3,8817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8817,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8817,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,8817,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,8818,0)
 ;;=A81.01^^42^518^10
 ;;^UTILITY(U,$J,358.3,8818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8818,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,8818,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,8818,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,8819,0)
 ;;=A81.89^^42^518^7
 ;;^UTILITY(U,$J,358.3,8819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8819,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,8819,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,8819,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,8820,0)
 ;;=A81.2^^42^518^27
 ;;^UTILITY(U,$J,358.3,8820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8820,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,8820,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,8820,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,8821,0)
 ;;=B20.^^42^518^17
 ;;^UTILITY(U,$J,358.3,8821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8821,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,8821,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,8821,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,8822,0)
 ;;=B20.^^42^518^18
 ;;^UTILITY(U,$J,358.3,8822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8822,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,8822,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,8822,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,8823,0)
 ;;=F10.27^^42^518^1
 ;;^UTILITY(U,$J,358.3,8823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8823,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,8823,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,8823,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,8824,0)
 ;;=F19.97^^42^518^29
 ;;^UTILITY(U,$J,358.3,8824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8824,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,8824,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,8824,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,8825,0)
 ;;=F03.90^^42^518^15
 ;;^UTILITY(U,$J,358.3,8825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8825,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,8825,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,8825,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,8826,0)
 ;;=G30.0^^42^518^2
 ;;^UTILITY(U,$J,358.3,8826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8826,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,8826,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,8826,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,8827,0)
 ;;=G30.1^^42^518^3
 ;;^UTILITY(U,$J,358.3,8827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8827,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,8827,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,8827,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,8828,0)
 ;;=G30.9^^42^518^4
 ;;^UTILITY(U,$J,358.3,8828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8828,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8828,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,8828,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,8829,0)
 ;;=G10.^^42^518^19
 ;;^UTILITY(U,$J,358.3,8829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8829,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,8829,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,8829,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,8830,0)
 ;;=G10.^^42^518^20
 ;;^UTILITY(U,$J,358.3,8830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8830,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,8830,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,8830,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,8831,0)
 ;;=G90.3^^42^518^21
 ;;^UTILITY(U,$J,358.3,8831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8831,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,8831,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,8831,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,8832,0)
 ;;=G91.2^^42^518^22
 ;;^UTILITY(U,$J,358.3,8832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8832,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,8832,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,8832,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,8833,0)
 ;;=G91.2^^42^518^23
 ;;^UTILITY(U,$J,358.3,8833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8833,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,8833,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,8833,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,8834,0)
 ;;=G30.8^^42^518^5
 ;;^UTILITY(U,$J,358.3,8834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8834,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,8834,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,8834,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,8835,0)
 ;;=G31.09^^42^518^16
 ;;^UTILITY(U,$J,358.3,8835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8835,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,8835,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,8835,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,8836,0)
 ;;=G20.^^42^518^24
 ;;^UTILITY(U,$J,358.3,8836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8836,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,8836,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,8836,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,8837,0)
 ;;=G20.^^42^518^25
 ;;^UTILITY(U,$J,358.3,8837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8837,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,8837,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,8837,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,8838,0)
 ;;=G31.01^^42^518^26
 ;;^UTILITY(U,$J,358.3,8838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8838,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,8838,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,8838,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,8839,0)
 ;;=G23.1^^42^518^28
 ;;^UTILITY(U,$J,358.3,8839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8839,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,8839,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,8839,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,8840,0)
 ;;=Z79.2^^42^519^1
 ;;^UTILITY(U,$J,358.3,8840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8840,1,3,0)
 ;;=3^Antibiotics
 ;;^UTILITY(U,$J,358.3,8840,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,8840,2)
 ;;=^321546
