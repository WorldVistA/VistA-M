IBDEI1QD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28946,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,28946,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,28946,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,28947,0)
 ;;=G10.^^132^1340^19
 ;;^UTILITY(U,$J,358.3,28947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28947,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,28947,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,28947,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,28948,0)
 ;;=G10.^^132^1340^20
 ;;^UTILITY(U,$J,358.3,28948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28948,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28948,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,28948,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,28949,0)
 ;;=G90.3^^132^1340^21
 ;;^UTILITY(U,$J,358.3,28949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28949,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,28949,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,28949,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,28950,0)
 ;;=G91.2^^132^1340^22
 ;;^UTILITY(U,$J,358.3,28950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28950,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28950,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,28950,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,28951,0)
 ;;=G91.2^^132^1340^23
 ;;^UTILITY(U,$J,358.3,28951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28951,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28951,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,28951,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,28952,0)
 ;;=G30.8^^132^1340^5
 ;;^UTILITY(U,$J,358.3,28952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28952,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,28952,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,28952,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,28953,0)
 ;;=G31.09^^132^1340^16
 ;;^UTILITY(U,$J,358.3,28953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28953,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,28953,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,28953,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,28954,0)
 ;;=G20.^^132^1340^24
 ;;^UTILITY(U,$J,358.3,28954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28954,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28954,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,28954,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,28955,0)
 ;;=G20.^^132^1340^25
 ;;^UTILITY(U,$J,358.3,28955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28955,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28955,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,28955,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,28956,0)
 ;;=G31.01^^132^1340^26
 ;;^UTILITY(U,$J,358.3,28956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28956,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,28956,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,28956,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,28957,0)
 ;;=G23.1^^132^1340^28
 ;;^UTILITY(U,$J,358.3,28957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28957,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,28957,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,28957,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,28958,0)
 ;;=Z79.2^^132^1341^1
 ;;^UTILITY(U,$J,358.3,28958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28958,1,3,0)
 ;;=3^Antibiotics
