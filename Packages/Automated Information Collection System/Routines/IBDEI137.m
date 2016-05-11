IBDEI137 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18477,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,18477,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,18477,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,18478,0)
 ;;=C92.10^^79^879^64
 ;;^UTILITY(U,$J,358.3,18478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18478,1,3,0)
 ;;=3^Chronic Myeloid Leukemia BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,18478,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,18478,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,18479,0)
 ;;=C92.11^^79^879^65
 ;;^UTILITY(U,$J,358.3,18479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18479,1,3,0)
 ;;=3^Chronic Myeloid Leukemia BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,18479,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,18479,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,18480,0)
 ;;=D04.9^^79^879^66
 ;;^UTILITY(U,$J,358.3,18480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18480,1,3,0)
 ;;=3^Carcinoma in Situ of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,18480,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,18480,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,18481,0)
 ;;=D05.91^^79^879^67
 ;;^UTILITY(U,$J,358.3,18481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18481,1,3,0)
 ;;=3^Carcinoma in Situ of Right Breast
 ;;^UTILITY(U,$J,358.3,18481,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,18481,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,18482,0)
 ;;=D05.92^^79^879^68
 ;;^UTILITY(U,$J,358.3,18482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18482,1,3,0)
 ;;=3^Carcinoma in Situ of Left Breast
 ;;^UTILITY(U,$J,358.3,18482,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,18482,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,18483,0)
 ;;=D06.9^^79^879^69
 ;;^UTILITY(U,$J,358.3,18483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18483,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Unspec
 ;;^UTILITY(U,$J,358.3,18483,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,18483,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,18484,0)
 ;;=D09.0^^79^879^70
 ;;^UTILITY(U,$J,358.3,18484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18484,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,18484,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,18484,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,18485,0)
 ;;=D45.^^79^879^71
 ;;^UTILITY(U,$J,358.3,18485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18485,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,18485,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,18485,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,18486,0)
 ;;=D47.Z9^^79^879^72
 ;;^UTILITY(U,$J,358.3,18486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18486,1,3,0)
 ;;=3^Neop of Uncertain Behavior of Lymphoid/Hematpoetc/Related Tissue
 ;;^UTILITY(U,$J,358.3,18486,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,18486,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,18487,0)
 ;;=C94.40^^79^879^73
 ;;^UTILITY(U,$J,358.3,18487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18487,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,18487,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,18487,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,18488,0)
 ;;=C94.41^^79^879^74
 ;;^UTILITY(U,$J,358.3,18488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18488,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,18488,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,18488,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,18489,0)
 ;;=C94.42^^79^879^75
 ;;^UTILITY(U,$J,358.3,18489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18489,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,18489,1,4,0)
 ;;=4^C94.42
