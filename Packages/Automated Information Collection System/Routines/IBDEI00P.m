IBDEI00P ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1136,1,3,0)
 ;;=3^Chronic myeloid leuk, BCR/ABL-positive, not achieve remis
 ;;^UTILITY(U,$J,358.3,1136,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,1136,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,1137,0)
 ;;=C92.11^^10^77^29
 ;;^UTILITY(U,$J,358.3,1137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1137,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,1137,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,1137,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,1138,0)
 ;;=C92.12^^10^77^30
 ;;^UTILITY(U,$J,358.3,1138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1138,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in relapse
 ;;^UTILITY(U,$J,358.3,1138,1,4,0)
 ;;=4^C92.12
 ;;^UTILITY(U,$J,358.3,1138,2)
 ;;=^5001794
 ;;^UTILITY(U,$J,358.3,1139,0)
 ;;=C92.20^^10^77^22
 ;;^UTILITY(U,$J,358.3,1139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1139,1,3,0)
 ;;=3^Atyp chronic myeloid leuk, BCR/ABL-neg, not achieve remis
 ;;^UTILITY(U,$J,358.3,1139,1,4,0)
 ;;=4^C92.20
 ;;^UTILITY(U,$J,358.3,1139,2)
 ;;=^5001795
 ;;^UTILITY(U,$J,358.3,1140,0)
 ;;=C92.21^^10^77^23
 ;;^UTILITY(U,$J,358.3,1140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1140,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in remission
 ;;^UTILITY(U,$J,358.3,1140,1,4,0)
 ;;=4^C92.21
 ;;^UTILITY(U,$J,358.3,1140,2)
 ;;=^5001796
 ;;^UTILITY(U,$J,358.3,1141,0)
 ;;=C92.22^^10^77^24
 ;;^UTILITY(U,$J,358.3,1141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1141,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in relapse
 ;;^UTILITY(U,$J,358.3,1141,1,4,0)
 ;;=4^C92.22
 ;;^UTILITY(U,$J,358.3,1141,2)
 ;;=^5001797
 ;;^UTILITY(U,$J,358.3,1142,0)
 ;;=C92.30^^10^77^57
 ;;^UTILITY(U,$J,358.3,1142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1142,1,3,0)
 ;;=3^Myeloid sarcoma, not having achieved remission
 ;;^UTILITY(U,$J,358.3,1142,1,4,0)
 ;;=4^C92.30
 ;;^UTILITY(U,$J,358.3,1142,2)
 ;;=^5001798
 ;;^UTILITY(U,$J,358.3,1143,0)
 ;;=C92.31^^10^77^56
 ;;^UTILITY(U,$J,358.3,1143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1143,1,3,0)
 ;;=3^Myeloid sarcoma, in remission
 ;;^UTILITY(U,$J,358.3,1143,1,4,0)
 ;;=4^C92.31
 ;;^UTILITY(U,$J,358.3,1143,2)
 ;;=^5001799
 ;;^UTILITY(U,$J,358.3,1144,0)
 ;;=C92.32^^10^77^55
 ;;^UTILITY(U,$J,358.3,1144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1144,1,3,0)
 ;;=3^Myeloid sarcoma, in relapse
 ;;^UTILITY(U,$J,358.3,1144,1,4,0)
 ;;=4^C92.32
 ;;^UTILITY(U,$J,358.3,1144,2)
 ;;=^5001800
 ;;^UTILITY(U,$J,358.3,1145,0)
 ;;=C92.90^^10^77^54
 ;;^UTILITY(U,$J,358.3,1145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1145,1,3,0)
 ;;=3^Myeloid leukemia, unspecified, not having achieved remission
 ;;^UTILITY(U,$J,358.3,1145,1,4,0)
 ;;=4^C92.90
 ;;^UTILITY(U,$J,358.3,1145,2)
 ;;=^5001810
 ;;^UTILITY(U,$J,358.3,1146,0)
 ;;=C92.91^^10^77^53
 ;;^UTILITY(U,$J,358.3,1146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1146,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,1146,1,4,0)
 ;;=4^C92.91
 ;;^UTILITY(U,$J,358.3,1146,2)
 ;;=^5001811
 ;;^UTILITY(U,$J,358.3,1147,0)
 ;;=C92.92^^10^77^52
 ;;^UTILITY(U,$J,358.3,1147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1147,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,1147,1,4,0)
 ;;=4^C92.92
 ;;^UTILITY(U,$J,358.3,1147,2)
 ;;=^5001812
 ;;^UTILITY(U,$J,358.3,1148,0)
 ;;=C93.00^^10^77^12
 ;;^UTILITY(U,$J,358.3,1148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1148,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, not achieve remission
 ;;^UTILITY(U,$J,358.3,1148,1,4,0)
 ;;=4^C93.00
 ;;^UTILITY(U,$J,358.3,1148,2)
 ;;=^5001819
 ;;^UTILITY(U,$J,358.3,1149,0)
 ;;=C93.01^^10^77^10
 ;;^UTILITY(U,$J,358.3,1149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1149,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,1149,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,1149,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,1150,0)
 ;;=C93.02^^10^77^11
 ;;^UTILITY(U,$J,358.3,1150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1150,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,1150,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,1150,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,1151,0)
 ;;=C93.10^^10^77^31
 ;;^UTILITY(U,$J,358.3,1151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1151,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,1151,1,4,0)
 ;;=4^C93.10
 ;;^UTILITY(U,$J,358.3,1151,2)
 ;;=^5001822
 ;;^UTILITY(U,$J,358.3,1152,0)
 ;;=C93.11^^10^77^33
 ;;^UTILITY(U,$J,358.3,1152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1152,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,1152,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,1152,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,1153,0)
 ;;=C93.12^^10^77^32
 ;;^UTILITY(U,$J,358.3,1153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1153,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,1153,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,1153,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,1154,0)
 ;;=C93.90^^10^77^48
 ;;^UTILITY(U,$J,358.3,1154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1154,1,3,0)
 ;;=3^Monocytic leukemia, unsp, not having achieved remission
 ;;^UTILITY(U,$J,358.3,1154,1,4,0)
 ;;=4^C93.90
 ;;^UTILITY(U,$J,358.3,1154,2)
 ;;=^5001828
 ;;^UTILITY(U,$J,358.3,1155,0)
 ;;=C93.91^^10^77^50
 ;;^UTILITY(U,$J,358.3,1155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1155,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,1155,1,4,0)
 ;;=4^C93.91
 ;;^UTILITY(U,$J,358.3,1155,2)
 ;;=^5001829
 ;;^UTILITY(U,$J,358.3,1156,0)
 ;;=C93.92^^10^77^49
 ;;^UTILITY(U,$J,358.3,1156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1156,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,1156,1,4,0)
 ;;=4^C93.92
 ;;^UTILITY(U,$J,358.3,1156,2)
 ;;=^5001830
 ;;^UTILITY(U,$J,358.3,1157,0)
 ;;=C94.00^^10^77^3
 ;;^UTILITY(U,$J,358.3,1157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1157,1,3,0)
 ;;=3^Acute erythroid leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,1157,1,4,0)
 ;;=4^C94.00
 ;;^UTILITY(U,$J,358.3,1157,2)
 ;;=^5001834
 ;;^UTILITY(U,$J,358.3,1158,0)
 ;;=C94.01^^10^77^2
 ;;^UTILITY(U,$J,358.3,1158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1158,1,3,0)
 ;;=3^Acute erythroid leukemia, in remission
 ;;^UTILITY(U,$J,358.3,1158,1,4,0)
 ;;=4^C94.01
 ;;^UTILITY(U,$J,358.3,1158,2)
 ;;=^5001835
 ;;^UTILITY(U,$J,358.3,1159,0)
 ;;=C94.02^^10^77^1
 ;;^UTILITY(U,$J,358.3,1159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1159,1,3,0)
 ;;=3^Acute erythroid leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,1159,1,4,0)
 ;;=4^C94.02
 ;;^UTILITY(U,$J,358.3,1159,2)
 ;;=^5001836
 ;;^UTILITY(U,$J,358.3,1160,0)
 ;;=C94.20^^10^77^7
 ;;^UTILITY(U,$J,358.3,1160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1160,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,1160,1,4,0)
 ;;=4^C94.20
 ;;^UTILITY(U,$J,358.3,1160,2)
 ;;=^5001837
 ;;^UTILITY(U,$J,358.3,1161,0)
 ;;=C94.21^^10^77^9
 ;;^UTILITY(U,$J,358.3,1161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1161,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,1161,1,4,0)
 ;;=4^C94.21
 ;;^UTILITY(U,$J,358.3,1161,2)
 ;;=^5001838
 ;;^UTILITY(U,$J,358.3,1162,0)
 ;;=C94.22^^10^77^8
 ;;^UTILITY(U,$J,358.3,1162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1162,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,1162,1,4,0)
 ;;=4^C94.22
 ;;^UTILITY(U,$J,358.3,1162,2)
 ;;=^5001839
 ;;^UTILITY(U,$J,358.3,1163,0)
 ;;=C94.30^^10^77^45
 ;;^UTILITY(U,$J,358.3,1163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1163,1,3,0)
 ;;=3^Mast cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,1163,1,4,0)
 ;;=4^C94.30
 ;;^UTILITY(U,$J,358.3,1163,2)
 ;;=^5001840
 ;;^UTILITY(U,$J,358.3,1164,0)
 ;;=C94.31^^10^77^47
 ;;^UTILITY(U,$J,358.3,1164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1164,1,3,0)
 ;;=3^Mast cell leukemia, in remission
 ;;^UTILITY(U,$J,358.3,1164,1,4,0)
 ;;=4^C94.31
 ;;^UTILITY(U,$J,358.3,1164,2)
 ;;=^5001841
 ;;^UTILITY(U,$J,358.3,1165,0)
 ;;=C94.32^^10^77^46
 ;;^UTILITY(U,$J,358.3,1165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1165,1,3,0)
 ;;=3^Mast cell leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,1165,1,4,0)
 ;;=4^C94.32
 ;;^UTILITY(U,$J,358.3,1165,2)
 ;;=^5001842
 ;;^UTILITY(U,$J,358.3,1166,0)
 ;;=C95.00^^10^77^4
 ;;^UTILITY(U,$J,358.3,1166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1166,1,3,0)
 ;;=3^Acute leukemia of unsp cell type not achieve remission
 ;;^UTILITY(U,$J,358.3,1166,1,4,0)
 ;;=4^C95.00
 ;;^UTILITY(U,$J,358.3,1166,2)
 ;;=^5001850
 ;;^UTILITY(U,$J,358.3,1167,0)
 ;;=C95.01^^10^77^5
 ;;^UTILITY(U,$J,358.3,1167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1167,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in remission
 ;;^UTILITY(U,$J,358.3,1167,1,4,0)
 ;;=4^C95.01
 ;;^UTILITY(U,$J,358.3,1167,2)
 ;;=^5001851
 ;;^UTILITY(U,$J,358.3,1168,0)
 ;;=C95.02^^10^77^6
 ;;^UTILITY(U,$J,358.3,1168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1168,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in relapse
 ;;^UTILITY(U,$J,358.3,1168,1,4,0)
 ;;=4^C95.02
 ;;^UTILITY(U,$J,358.3,1168,2)
 ;;=^5001852
 ;;^UTILITY(U,$J,358.3,1169,0)
 ;;=D45.^^10^77^58
 ;;^UTILITY(U,$J,358.3,1169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1169,1,3,0)
 ;;=3^Polycythemia vera
 ;;^UTILITY(U,$J,358.3,1169,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,1169,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,1170,0)
 ;;=C95.10^^10^77^25
 ;;^UTILITY(U,$J,358.3,1170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1170,1,3,0)
 ;;=3^Chronic leukemia of unsp cell type not achieve remission
 ;;^UTILITY(U,$J,358.3,1170,1,4,0)
 ;;=4^C95.10
 ;;^UTILITY(U,$J,358.3,1170,2)
 ;;=^5001853
 ;;^UTILITY(U,$J,358.3,1171,0)
 ;;=C95.11^^10^77^26
 ;;^UTILITY(U,$J,358.3,1171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1171,1,3,0)
 ;;=3^Chronic leukemia of unspecified cell type, in remission
 ;;^UTILITY(U,$J,358.3,1171,1,4,0)
 ;;=4^C95.11
 ;;^UTILITY(U,$J,358.3,1171,2)
 ;;=^5001854
 ;;^UTILITY(U,$J,358.3,1172,0)
 ;;=C95.12^^10^77^27
 ;;^UTILITY(U,$J,358.3,1172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1172,1,3,0)
 ;;=3^Chronic leukemia of unspecified cell type, in relapse
 ;;^UTILITY(U,$J,358.3,1172,1,4,0)
 ;;=4^C95.12
 ;;^UTILITY(U,$J,358.3,1172,2)
 ;;=^5001855
 ;;^UTILITY(U,$J,358.3,1173,0)
 ;;=D46.9^^10^77^51
 ;;^UTILITY(U,$J,358.3,1173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1173,1,3,0)
 ;;=3^Myelodysplastic syndrome, unspecified
 ;;^UTILITY(U,$J,358.3,1173,1,4,0)
 ;;=4^D46.9
 ;;^UTILITY(U,$J,358.3,1173,2)
 ;;=^334031
 ;;^UTILITY(U,$J,358.3,1174,0)
 ;;=C95.90^^10^77^39
 ;;^UTILITY(U,$J,358.3,1174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1174,1,3,0)
 ;;=3^Leukemia, unspecified not having achieved remission
 ;;^UTILITY(U,$J,358.3,1174,1,4,0)
 ;;=4^C95.90
 ;;^UTILITY(U,$J,358.3,1174,2)
 ;;=^5001856
 ;;^UTILITY(U,$J,358.3,1175,0)
 ;;=C95.91^^10^77^41
 ;;^UTILITY(U,$J,358.3,1175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1175,1,3,0)
 ;;=3^Leukemia, unspecified, in remission
 ;;^UTILITY(U,$J,358.3,1175,1,4,0)
 ;;=4^C95.91
 ;;^UTILITY(U,$J,358.3,1175,2)
 ;;=^5001857
 ;;^UTILITY(U,$J,358.3,1176,0)
 ;;=C95.92^^10^77^40
 ;;^UTILITY(U,$J,358.3,1176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1176,1,3,0)
 ;;=3^Leukemia, unspecified, in relapse
 ;;^UTILITY(U,$J,358.3,1176,1,4,0)
 ;;=4^C95.92
 ;;^UTILITY(U,$J,358.3,1176,2)
 ;;=^5001858
 ;;^UTILITY(U,$J,358.3,1177,0)
 ;;=D72.9^^10^77^35
 ;;^UTILITY(U,$J,358.3,1177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1177,1,3,0)
 ;;=3^Disorder of white blood cells, unspecified
 ;;^UTILITY(U,$J,358.3,1177,1,4,0)
 ;;=4^D72.9
 ;;^UTILITY(U,$J,358.3,1177,2)
 ;;=^5002381
 ;;^UTILITY(U,$J,358.3,1178,0)
 ;;=D75.1^^10^77^59
 ;;^UTILITY(U,$J,358.3,1178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1178,1,3,0)
 ;;=3^Secondary polycythemia
 ;;^UTILITY(U,$J,358.3,1178,1,4,0)
 ;;=4^D75.1
 ;;^UTILITY(U,$J,358.3,1178,2)
 ;;=^186856
 ;;^UTILITY(U,$J,358.3,1179,0)
 ;;=D75.9^^10^77^34
 ;;^UTILITY(U,$J,358.3,1179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1179,1,3,0)
 ;;=3^Disease of blood and blood-forming organs, unspecified
 ;;^UTILITY(U,$J,358.3,1179,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,1179,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,1180,0)
 ;;=C7A.010^^10^77^42
 ;;^UTILITY(U,$J,358.3,1180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1180,1,3,0)
 ;;=3^Malignant carcinoid tumor of the duodenum
 ;;^UTILITY(U,$J,358.3,1180,1,4,0)
 ;;=4^C7A.010
 ;;^UTILITY(U,$J,358.3,1180,2)
 ;;=^5001359
 ;;^UTILITY(U,$J,358.3,1181,0)
 ;;=C7A.011^^10^77^44
 ;;^UTILITY(U,$J,358.3,1181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1181,1,3,0)
 ;;=3^Malignant carcinoid tumor of the jejunum
 ;;^UTILITY(U,$J,358.3,1181,1,4,0)
 ;;=4^C7A.011
 ;;^UTILITY(U,$J,358.3,1181,2)
 ;;=^5001360
 ;;^UTILITY(U,$J,358.3,1182,0)
 ;;=C7A.012^^10^77^43
 ;;^UTILITY(U,$J,358.3,1182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1182,1,3,0)
 ;;=3^Malignant carcinoid tumor of the ileum
 ;;^UTILITY(U,$J,358.3,1182,1,4,0)
 ;;=4^C7A.012
 ;;^UTILITY(U,$J,358.3,1182,2)
 ;;=^5001361
 ;;^UTILITY(U,$J,358.3,1183,0)
 ;;=C93.30^^10^77^38
 ;;^UTILITY(U,$J,358.3,1183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1183,1,3,0)
 ;;=3^Juvenile myelomonocytic leukemia,no remission
 ;;^UTILITY(U,$J,358.3,1183,1,4,0)
 ;;=4^C93.30
 ;;^UTILITY(U,$J,358.3,1183,2)
 ;;=^5001825
 ;;^UTILITY(U,$J,358.3,1184,0)
 ;;=C93.31^^10^77^37
 ;;^UTILITY(U,$J,358.3,1184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1184,1,3,0)
 ;;=3^Juvenile myelomonocytic leukemia,in remission
 ;;^UTILITY(U,$J,358.3,1184,1,4,0)
 ;;=4^C93.31
 ;;^UTILITY(U,$J,358.3,1184,2)
 ;;=^5001826
 ;;^UTILITY(U,$J,358.3,1185,0)
 ;;=C93.32^^10^77^36
 ;;^UTILITY(U,$J,358.3,1185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1185,1,3,0)
 ;;=3^Juvenile myelomonocytic leukemia,in relapse
 ;;^UTILITY(U,$J,358.3,1185,1,4,0)
 ;;=4^C93.32
 ;;^UTILITY(U,$J,358.3,1185,2)
 ;;=^5001827
 ;;^UTILITY(U,$J,358.3,1186,0)
 ;;=D48.0^^10^78^5
 ;;^UTILITY(U,$J,358.3,1186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1186,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of bone/artic cartl
 ;;^UTILITY(U,$J,358.3,1186,1,4,0)
 ;;=4^D48.0
 ;;^UTILITY(U,$J,358.3,1186,2)
 ;;=^81953
 ;;^UTILITY(U,$J,358.3,1187,0)
 ;;=D48.1^^10^78^6
 ;;^UTILITY(U,$J,358.3,1187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1187,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of connctv/soft tiss
 ;;^UTILITY(U,$J,358.3,1187,1,4,0)
 ;;=4^D48.1
 ;;^UTILITY(U,$J,358.3,1187,2)
 ;;=^267776
 ;;^UTILITY(U,$J,358.3,1188,0)
 ;;=D48.5^^10^78^10
 ;;^UTILITY(U,$J,358.3,1188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1188,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of skin
 ;;^UTILITY(U,$J,358.3,1188,1,4,0)
 ;;=4^D48.5
 ;;^UTILITY(U,$J,358.3,1188,2)
 ;;=^267777
 ;;^UTILITY(U,$J,358.3,1189,0)
 ;;=D48.61^^10^78^9
 ;;^UTILITY(U,$J,358.3,1189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1189,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of right breast
 ;;^UTILITY(U,$J,358.3,1189,1,4,0)
 ;;=4^D48.61
 ;;^UTILITY(U,$J,358.3,1189,2)
 ;;=^5002267
 ;;^UTILITY(U,$J,358.3,1190,0)
 ;;=D48.62^^10^78^7
 ;;^UTILITY(U,$J,358.3,1190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1190,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of left breast
 ;;^UTILITY(U,$J,358.3,1190,1,4,0)
 ;;=4^D48.62
 ;;^UTILITY(U,$J,358.3,1190,2)
 ;;=^5002268
 ;;^UTILITY(U,$J,358.3,1191,0)
 ;;=D46.0^^10^78^18
 ;;^UTILITY(U,$J,358.3,1191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1191,1,3,0)
 ;;=3^Refractory anemia without ring sideroblasts, so stated
 ;;^UTILITY(U,$J,358.3,1191,1,4,0)
 ;;=4^D46.0
 ;;^UTILITY(U,$J,358.3,1191,2)
 ;;=^5002245
 ;;^UTILITY(U,$J,358.3,1192,0)
 ;;=D46.1^^10^78^17
 ;;^UTILITY(U,$J,358.3,1192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1192,1,3,0)
 ;;=3^Refractory anemia with ring sideroblasts
 ;;^UTILITY(U,$J,358.3,1192,1,4,0)
 ;;=4^D46.1
 ;;^UTILITY(U,$J,358.3,1192,2)
 ;;=^5002246
 ;;^UTILITY(U,$J,358.3,1193,0)
 ;;=D46.20^^10^78^14
 ;;^UTILITY(U,$J,358.3,1193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1193,1,3,0)
 ;;=3^Refractory anemia with excess of blasts, unspecified
 ;;^UTILITY(U,$J,358.3,1193,1,4,0)
 ;;=4^D46.20
 ;;^UTILITY(U,$J,358.3,1193,2)
 ;;=^5002247
 ;;^UTILITY(U,$J,358.3,1194,0)
 ;;=D46.21^^10^78^15
 ;;^UTILITY(U,$J,358.3,1194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1194,1,3,0)
 ;;=3^Refractory anemia with excess of blasts 1
 ;;^UTILITY(U,$J,358.3,1194,1,4,0)
 ;;=4^D46.21
 ;;^UTILITY(U,$J,358.3,1194,2)
 ;;=^5002248
 ;;^UTILITY(U,$J,358.3,1195,0)
 ;;=D46.A^^10^78^19
 ;;^UTILITY(U,$J,358.3,1195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1195,1,3,0)
 ;;=3^Refractory cytopenia with multilineage dysplasia
 ;;^UTILITY(U,$J,358.3,1195,1,4,0)
 ;;=4^D46.A
 ;;^UTILITY(U,$J,358.3,1195,2)
 ;;=^5002251
 ;;^UTILITY(U,$J,358.3,1196,0)
 ;;=D46.B^^10^78^13
 ;;^UTILITY(U,$J,358.3,1196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1196,1,3,0)
 ;;=3^Refract cytopenia w multilin dysplasia and ring sideroblasts
 ;;^UTILITY(U,$J,358.3,1196,1,4,0)
 ;;=4^D46.B
 ;;^UTILITY(U,$J,358.3,1196,2)
 ;;=^5002252
 ;;^UTILITY(U,$J,358.3,1197,0)
 ;;=D46.22^^10^78^16
 ;;^UTILITY(U,$J,358.3,1197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1197,1,3,0)
 ;;=3^Refractory anemia with excess of blasts 2
 ;;^UTILITY(U,$J,358.3,1197,1,4,0)
 ;;=4^D46.22
 ;;^UTILITY(U,$J,358.3,1197,2)
 ;;=^5002249
 ;;^UTILITY(U,$J,358.3,1198,0)
 ;;=D46.C^^10^78^3
 ;;^UTILITY(U,$J,358.3,1198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1198,1,3,0)
 ;;=3^Myelodysplastic syndrome w isolated del(5q) chromsoml abnlt
 ;;^UTILITY(U,$J,358.3,1198,1,4,0)
 ;;=4^D46.C
 ;;^UTILITY(U,$J,358.3,1198,2)
 ;;=^5002253
 ;;^UTILITY(U,$J,358.3,1199,0)
 ;;=D46.9^^10^78^4
 ;;^UTILITY(U,$J,358.3,1199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1199,1,3,0)
 ;;=3^Myelodysplastic syndrome, unspecified
 ;;^UTILITY(U,$J,358.3,1199,1,4,0)
 ;;=4^D46.9
 ;;^UTILITY(U,$J,358.3,1199,2)
 ;;=^334031
 ;;^UTILITY(U,$J,358.3,1200,0)
 ;;=D47.1^^10^78^1
 ;;^UTILITY(U,$J,358.3,1200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1200,1,3,0)
 ;;=3^Chronic myeloproliferative disease
 ;;^UTILITY(U,$J,358.3,1200,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,1200,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,1201,0)
 ;;=D47.Z1^^10^78^12
 ;;^UTILITY(U,$J,358.3,1201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1201,1,3,0)
 ;;=3^Post-transplant lymphoproliferative disorder (PTLD)
 ;;^UTILITY(U,$J,358.3,1201,1,4,0)
 ;;=4^D47.Z1
 ;;^UTILITY(U,$J,358.3,1201,2)
 ;;=^5002261
 ;;^UTILITY(U,$J,358.3,1202,0)
 ;;=D48.7^^10^78^8
 ;;^UTILITY(U,$J,358.3,1202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1202,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of other specified sites
 ;;^UTILITY(U,$J,358.3,1202,1,4,0)
 ;;=4^D48.7
 ;;^UTILITY(U,$J,358.3,1202,2)
 ;;=^267779
 ;;^UTILITY(U,$J,358.3,1203,0)
 ;;=D48.9^^10^78^11
