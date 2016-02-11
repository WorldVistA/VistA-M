IBDEI37G ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53841,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in relapse
 ;;^UTILITY(U,$J,358.3,53841,1,4,0)
 ;;=4^C92.22
 ;;^UTILITY(U,$J,358.3,53841,2)
 ;;=^5001797
 ;;^UTILITY(U,$J,358.3,53842,0)
 ;;=C93.01^^253^2724^3
 ;;^UTILITY(U,$J,358.3,53842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53842,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,53842,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,53842,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,53843,0)
 ;;=C93.02^^253^2724^4
 ;;^UTILITY(U,$J,358.3,53843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53843,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,53843,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,53843,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,53844,0)
 ;;=C93.11^^253^2724^21
 ;;^UTILITY(U,$J,358.3,53844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53844,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,53844,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,53844,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,53845,0)
 ;;=C93.12^^253^2724^20
 ;;^UTILITY(U,$J,358.3,53845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53845,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,53845,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,53845,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,53846,0)
 ;;=C93.91^^253^2724^38
 ;;^UTILITY(U,$J,358.3,53846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53846,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,53846,1,4,0)
 ;;=4^C93.91
 ;;^UTILITY(U,$J,358.3,53846,2)
 ;;=^5001829
 ;;^UTILITY(U,$J,358.3,53847,0)
 ;;=C93.92^^253^2724^37
 ;;^UTILITY(U,$J,358.3,53847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53847,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,53847,1,4,0)
 ;;=4^C93.92
 ;;^UTILITY(U,$J,358.3,53847,2)
 ;;=^5001830
 ;;^UTILITY(U,$J,358.3,53848,0)
 ;;=E88.3^^253^2724^51
 ;;^UTILITY(U,$J,358.3,53848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53848,1,3,0)
 ;;=3^Tumor lysis syndrome
 ;;^UTILITY(U,$J,358.3,53848,1,4,0)
 ;;=4^E88.3
 ;;^UTILITY(U,$J,358.3,53848,2)
 ;;=^338229
 ;;^UTILITY(U,$J,358.3,53849,0)
 ;;=C62.11^^253^2725^2
 ;;^UTILITY(U,$J,358.3,53849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53849,1,3,0)
 ;;=3^Malignant neoplasm of descended right testis
 ;;^UTILITY(U,$J,358.3,53849,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,53849,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,53850,0)
 ;;=C62.12^^253^2725^1
 ;;^UTILITY(U,$J,358.3,53850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53850,1,3,0)
 ;;=3^Malignant neoplasm of descended left testis
 ;;^UTILITY(U,$J,358.3,53850,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,53850,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,53851,0)
 ;;=M81.0^^253^2726^1
 ;;^UTILITY(U,$J,358.3,53851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53851,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,53851,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,53851,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,53852,0)
 ;;=E10.9^^253^2726^2
 ;;^UTILITY(U,$J,358.3,53852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53852,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,53852,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,53852,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,53853,0)
 ;;=E11.9^^253^2726^3
 ;;^UTILITY(U,$J,358.3,53853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53853,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
