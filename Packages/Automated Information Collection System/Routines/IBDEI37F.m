IBDEI37F ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53828,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,53829,0)
 ;;=C91.12^^253^2724^17
 ;;^UTILITY(U,$J,358.3,53829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53829,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in relapse
 ;;^UTILITY(U,$J,358.3,53829,1,4,0)
 ;;=4^C91.12
 ;;^UTILITY(U,$J,358.3,53829,2)
 ;;=^5001767
 ;;^UTILITY(U,$J,358.3,53830,0)
 ;;=C91.Z1^^253^2724^32
 ;;^UTILITY(U,$J,358.3,53830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53830,1,3,0)
 ;;=3^Lymphoid leukemia, in remission NEC
 ;;^UTILITY(U,$J,358.3,53830,1,4,0)
 ;;=4^C91.Z1
 ;;^UTILITY(U,$J,358.3,53830,2)
 ;;=^5001787
 ;;^UTILITY(U,$J,358.3,53831,0)
 ;;=C91.Z2^^253^2724^31
 ;;^UTILITY(U,$J,358.3,53831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53831,1,3,0)
 ;;=3^Lymphoid leukemia, in relapse NEC
 ;;^UTILITY(U,$J,358.3,53831,1,4,0)
 ;;=4^C91.Z2
 ;;^UTILITY(U,$J,358.3,53831,2)
 ;;=^5001788
 ;;^UTILITY(U,$J,358.3,53832,0)
 ;;=C92.01^^253^2724^6
 ;;^UTILITY(U,$J,358.3,53832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53832,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,53832,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,53832,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,53833,0)
 ;;=C92.41^^253^2724^10
 ;;^UTILITY(U,$J,358.3,53833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53833,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,53833,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,53833,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,53834,0)
 ;;=C92.51^^253^2724^8
 ;;^UTILITY(U,$J,358.3,53834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53834,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,53834,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,53834,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,53835,0)
 ;;=C92.02^^253^2724^5
 ;;^UTILITY(U,$J,358.3,53835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53835,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,53835,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,53835,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,53836,0)
 ;;=C92.42^^253^2724^9
 ;;^UTILITY(U,$J,358.3,53836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53836,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,53836,1,4,0)
 ;;=4^C92.42
 ;;^UTILITY(U,$J,358.3,53836,2)
 ;;=^5001803
 ;;^UTILITY(U,$J,358.3,53837,0)
 ;;=C92.52^^253^2724^7
 ;;^UTILITY(U,$J,358.3,53837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53837,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,53837,1,4,0)
 ;;=4^C92.52
 ;;^UTILITY(U,$J,358.3,53837,2)
 ;;=^5001806
 ;;^UTILITY(U,$J,358.3,53838,0)
 ;;=C92.11^^253^2724^18
 ;;^UTILITY(U,$J,358.3,53838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53838,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,53838,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,53838,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,53839,0)
 ;;=C92.12^^253^2724^19
 ;;^UTILITY(U,$J,358.3,53839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53839,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in relapse
 ;;^UTILITY(U,$J,358.3,53839,1,4,0)
 ;;=4^C92.12
 ;;^UTILITY(U,$J,358.3,53839,2)
 ;;=^5001794
 ;;^UTILITY(U,$J,358.3,53840,0)
 ;;=C92.21^^253^2724^13
 ;;^UTILITY(U,$J,358.3,53840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53840,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in remission
 ;;^UTILITY(U,$J,358.3,53840,1,4,0)
 ;;=4^C92.21
 ;;^UTILITY(U,$J,358.3,53840,2)
 ;;=^5001796
 ;;^UTILITY(U,$J,358.3,53841,0)
 ;;=C92.22^^253^2724^14
