IBDEI0D7 ; ; 03-MAY-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 03, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33123,1,3,0)
 ;;=3^Solitary plasmacytoma in remission
 ;;^UTILITY(U,$J,358.3,33123,1,4,0)
 ;;=4^C90.31
 ;;^UTILITY(U,$J,358.3,33123,2)
 ;;=^5001760
 ;;^UTILITY(U,$J,358.3,33124,0)
 ;;=C88.8^^102^1380^32
 ;;^UTILITY(U,$J,358.3,33124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33124,1,3,0)
 ;;=3^Malignant immunoproliferative diseases NEC
 ;;^UTILITY(U,$J,358.3,33124,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,33124,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,33125,0)
 ;;=C90.22^^102^1380^23
 ;;^UTILITY(U,$J,358.3,33125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33125,1,3,0)
 ;;=3^Extramedullary plasmacytoma in relapse
 ;;^UTILITY(U,$J,358.3,33125,1,4,0)
 ;;=4^C90.22
 ;;^UTILITY(U,$J,358.3,33125,2)
 ;;=^5001758
 ;;^UTILITY(U,$J,358.3,33126,0)
 ;;=C90.32^^102^1380^54
 ;;^UTILITY(U,$J,358.3,33126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33126,1,3,0)
 ;;=3^Solitary plasmacytoma in relapse
 ;;^UTILITY(U,$J,358.3,33126,1,4,0)
 ;;=4^C90.32
 ;;^UTILITY(U,$J,358.3,33126,2)
 ;;=^5001761
 ;;^UTILITY(U,$J,358.3,33127,0)
 ;;=C91.01^^102^1380^2
 ;;^UTILITY(U,$J,358.3,33127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33127,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,33127,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,33127,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,33128,0)
 ;;=C91.02^^102^1380^1
 ;;^UTILITY(U,$J,358.3,33128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33128,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,33128,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,33128,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,33129,0)
 ;;=C91.11^^102^1380^16
 ;;^UTILITY(U,$J,358.3,33129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33129,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in remission
 ;;^UTILITY(U,$J,358.3,33129,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,33129,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,33130,0)
 ;;=C91.12^^102^1380^17
 ;;^UTILITY(U,$J,358.3,33130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33130,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in relapse
 ;;^UTILITY(U,$J,358.3,33130,1,4,0)
 ;;=4^C91.12
 ;;^UTILITY(U,$J,358.3,33130,2)
 ;;=^5001767
 ;;^UTILITY(U,$J,358.3,33131,0)
 ;;=C91.Z1^^102^1380^31
 ;;^UTILITY(U,$J,358.3,33131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33131,1,3,0)
 ;;=3^Lymphoid leukemia, in remission NEC
 ;;^UTILITY(U,$J,358.3,33131,1,4,0)
 ;;=4^C91.Z1
 ;;^UTILITY(U,$J,358.3,33131,2)
 ;;=^5001787
 ;;^UTILITY(U,$J,358.3,33132,0)
 ;;=C91.Z2^^102^1380^30
 ;;^UTILITY(U,$J,358.3,33132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33132,1,3,0)
 ;;=3^Lymphoid leukemia, in relapse NEC
 ;;^UTILITY(U,$J,358.3,33132,1,4,0)
 ;;=4^C91.Z2
 ;;^UTILITY(U,$J,358.3,33132,2)
 ;;=^5001788
 ;;^UTILITY(U,$J,358.3,33133,0)
 ;;=C92.01^^102^1380^6
 ;;^UTILITY(U,$J,358.3,33133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33133,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,33133,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,33133,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,33134,0)
 ;;=C92.41^^102^1380^10
 ;;^UTILITY(U,$J,358.3,33134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33134,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,33134,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,33134,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,33135,0)
 ;;=C92.51^^102^1380^8
 ;;^UTILITY(U,$J,358.3,33135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33135,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,33135,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,33135,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,33136,0)
 ;;=C92.02^^102^1380^5
 ;;^UTILITY(U,$J,358.3,33136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33136,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,33136,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,33136,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,33137,0)
 ;;=C92.42^^102^1380^9
 ;;^UTILITY(U,$J,358.3,33137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33137,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,33137,1,4,0)
 ;;=4^C92.42
 ;;^UTILITY(U,$J,358.3,33137,2)
 ;;=^5001803
 ;;^UTILITY(U,$J,358.3,33138,0)
 ;;=C92.52^^102^1380^7
 ;;^UTILITY(U,$J,358.3,33138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33138,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,33138,1,4,0)
 ;;=4^C92.52
 ;;^UTILITY(U,$J,358.3,33138,2)
 ;;=^5001806
 ;;^UTILITY(U,$J,358.3,33139,0)
 ;;=C92.11^^102^1380^18
 ;;^UTILITY(U,$J,358.3,33139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33139,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,33139,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,33139,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,33140,0)
 ;;=C92.12^^102^1380^19
 ;;^UTILITY(U,$J,358.3,33140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33140,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in relapse
 ;;^UTILITY(U,$J,358.3,33140,1,4,0)
 ;;=4^C92.12
 ;;^UTILITY(U,$J,358.3,33140,2)
 ;;=^5001794
 ;;^UTILITY(U,$J,358.3,33141,0)
 ;;=C92.21^^102^1380^13
 ;;^UTILITY(U,$J,358.3,33141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33141,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in remission
 ;;^UTILITY(U,$J,358.3,33141,1,4,0)
 ;;=4^C92.21
 ;;^UTILITY(U,$J,358.3,33141,2)
 ;;=^5001796
 ;;^UTILITY(U,$J,358.3,33142,0)
 ;;=C92.22^^102^1380^14
 ;;^UTILITY(U,$J,358.3,33142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33142,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in relapse
 ;;^UTILITY(U,$J,358.3,33142,1,4,0)
 ;;=4^C92.22
 ;;^UTILITY(U,$J,358.3,33142,2)
 ;;=^5001797
 ;;^UTILITY(U,$J,358.3,33143,0)
 ;;=C93.01^^102^1380^3
 ;;^UTILITY(U,$J,358.3,33143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33143,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,33143,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,33143,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,33144,0)
 ;;=C93.02^^102^1380^4
 ;;^UTILITY(U,$J,358.3,33144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33144,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,33144,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,33144,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,33145,0)
 ;;=C93.11^^102^1380^21
 ;;^UTILITY(U,$J,358.3,33145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33145,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,33145,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,33145,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,33146,0)
 ;;=C93.12^^102^1380^20
 ;;^UTILITY(U,$J,358.3,33146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33146,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,33146,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,33146,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,33147,0)
 ;;=C93.91^^102^1380^40
 ;;^UTILITY(U,$J,358.3,33147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33147,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,33147,1,4,0)
 ;;=4^C93.91
 ;;^UTILITY(U,$J,358.3,33147,2)
 ;;=^5001829
 ;;^UTILITY(U,$J,358.3,33148,0)
 ;;=C93.92^^102^1380^39
 ;;^UTILITY(U,$J,358.3,33148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33148,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,33148,1,4,0)
 ;;=4^C93.92
 ;;^UTILITY(U,$J,358.3,33148,2)
 ;;=^5001830
 ;;^UTILITY(U,$J,358.3,33149,0)
 ;;=E88.3^^102^1380^56
 ;;^UTILITY(U,$J,358.3,33149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33149,1,3,0)
 ;;=3^Tumor lysis syndrome
 ;;^UTILITY(U,$J,358.3,33149,1,4,0)
 ;;=4^E88.3
 ;;^UTILITY(U,$J,358.3,33149,2)
 ;;=^338229
 ;;^UTILITY(U,$J,358.3,33150,0)
 ;;=C96.20^^102^1380^33
 ;;^UTILITY(U,$J,358.3,33150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33150,1,3,0)
 ;;=3^Malignant mast cell neoplasm, unspecified
 ;;^UTILITY(U,$J,358.3,33150,1,4,0)
 ;;=4^C96.20
 ;;^UTILITY(U,$J,358.3,33150,2)
 ;;=^5151293
 ;;^UTILITY(U,$J,358.3,33151,0)
 ;;=C96.21^^102^1380^35
 ;;^UTILITY(U,$J,358.3,33151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33151,1,3,0)
 ;;=3^Mastocytosis, aggressive systemic
 ;;^UTILITY(U,$J,358.3,33151,1,4,0)
 ;;=4^C96.21
 ;;^UTILITY(U,$J,358.3,33151,2)
 ;;=^5151294
 ;;^UTILITY(U,$J,358.3,33152,0)
 ;;=C96.22^^102^1380^52
 ;;^UTILITY(U,$J,358.3,33152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33152,1,3,0)
 ;;=3^Sarcoma, mast cell
 ;;^UTILITY(U,$J,358.3,33152,1,4,0)
 ;;=4^C96.22
 ;;^UTILITY(U,$J,358.3,33152,2)
 ;;=^5151295
 ;;^UTILITY(U,$J,358.3,33153,0)
 ;;=C96.29^^102^1380^45
 ;;^UTILITY(U,$J,358.3,33153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33153,1,3,0)
 ;;=3^Neoplasm, mast cell, oth malignant
 ;;^UTILITY(U,$J,358.3,33153,1,4,0)
 ;;=4^C96.29
 ;;^UTILITY(U,$J,358.3,33153,2)
 ;;=^5151296
 ;;^UTILITY(U,$J,358.3,33154,0)
 ;;=D47.01^^102^1380^36
 ;;^UTILITY(U,$J,358.3,33154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33154,1,3,0)
 ;;=3^Mastocytosis, cutaneous
 ;;^UTILITY(U,$J,358.3,33154,1,4,0)
 ;;=4^D47.01
 ;;^UTILITY(U,$J,358.3,33154,2)
 ;;=^5151297
 ;;^UTILITY(U,$J,358.3,33155,0)
 ;;=D47.02^^102^1380^37
 ;;^UTILITY(U,$J,358.3,33155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33155,1,3,0)
 ;;=3^Mastocytosis, systemic
 ;;^UTILITY(U,$J,358.3,33155,1,4,0)
 ;;=4^D47.02
 ;;^UTILITY(U,$J,358.3,33155,2)
 ;;=^5151298
 ;;^UTILITY(U,$J,358.3,33156,0)
 ;;=D47.09^^102^1380^46
 ;;^UTILITY(U,$J,358.3,33156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33156,1,3,0)
 ;;=3^Neoplasms, mast cell, oth, of uncertain behavior
 ;;^UTILITY(U,$J,358.3,33156,1,4,0)
 ;;=4^D47.09
 ;;^UTILITY(U,$J,358.3,33156,2)
 ;;=^5151299
 ;;^UTILITY(U,$J,358.3,33157,0)
 ;;=C62.11^^102^1381^2
 ;;^UTILITY(U,$J,358.3,33157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33157,1,3,0)
 ;;=3^Malignant neoplasm of descended right testis
 ;;^UTILITY(U,$J,358.3,33157,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,33157,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,33158,0)
 ;;=C62.12^^102^1381^1
 ;;^UTILITY(U,$J,358.3,33158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33158,1,3,0)
 ;;=3^Malignant neoplasm of descended left testis
 ;;^UTILITY(U,$J,358.3,33158,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,33158,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,33159,0)
 ;;=M81.0^^102^1382^1
 ;;^UTILITY(U,$J,358.3,33159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33159,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,33159,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,33159,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,33160,0)
 ;;=E10.9^^102^1382^5
 ;;^UTILITY(U,$J,358.3,33160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33160,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,33160,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,33160,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,33161,0)
 ;;=E11.9^^102^1382^8
 ;;^UTILITY(U,$J,358.3,33161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33161,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,33161,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,33161,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,33162,0)
 ;;=E11.10^^102^1382^7
 ;;^UTILITY(U,$J,358.3,33162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33162,1,3,0)
 ;;=3^Diabetes Type 2 w/ Ketoacidosis w/o Coma
 ;;^UTILITY(U,$J,358.3,33162,1,4,0)
 ;;=4^E11.10
 ;;^UTILITY(U,$J,358.3,33162,2)
 ;;=^5151300
 ;;^UTILITY(U,$J,358.3,33163,0)
 ;;=E11.11^^102^1382^6
 ;;^UTILITY(U,$J,358.3,33163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33163,1,3,0)
 ;;=3^Diabetes Type 2 w/ Ketoacidosis w/ Coma
 ;;^UTILITY(U,$J,358.3,33163,1,4,0)
 ;;=4^E11.11
 ;;^UTILITY(U,$J,358.3,33163,2)
 ;;=^5151301
 ;;^UTILITY(U,$J,358.3,33164,0)
 ;;=E85.81^^102^1382^2
 ;;^UTILITY(U,$J,358.3,33164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33164,1,3,0)
 ;;=3^Amyloidosis,Light Chain (AL)
 ;;^UTILITY(U,$J,358.3,33164,1,4,0)
 ;;=4^E85.81
 ;;^UTILITY(U,$J,358.3,33164,2)
 ;;=^5151302
 ;;^UTILITY(U,$J,358.3,33165,0)
 ;;=E85.82^^102^1382^4
 ;;^UTILITY(U,$J,358.3,33165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33165,1,3,0)
 ;;=3^Amyloidosis,Wild-Type Transthyretin-Related (ATTR)
 ;;^UTILITY(U,$J,358.3,33165,1,4,0)
 ;;=4^E85.82
 ;;^UTILITY(U,$J,358.3,33165,2)
 ;;=^5151303
 ;;^UTILITY(U,$J,358.3,33166,0)
 ;;=E85.89^^102^1382^3
 ;;^UTILITY(U,$J,358.3,33166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33166,1,3,0)
 ;;=3^Amyloidosis,Other
 ;;^UTILITY(U,$J,358.3,33166,1,4,0)
 ;;=4^E85.89
 ;;^UTILITY(U,$J,358.3,33166,2)
 ;;=^334034
 ;;^UTILITY(U,$J,358.3,33167,0)
 ;;=R10.9^^102^1383^2
 ;;^UTILITY(U,$J,358.3,33167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33167,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,33167,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,33167,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,33168,0)
 ;;=R10.11^^102^1383^47
 ;;^UTILITY(U,$J,358.3,33168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33168,1,3,0)
 ;;=3^Right upper quadrant pain
 ;;^UTILITY(U,$J,358.3,33168,1,4,0)
 ;;=4^R10.11
 ;;^UTILITY(U,$J,358.3,33168,2)
 ;;=^5019206
 ;;^UTILITY(U,$J,358.3,33169,0)
 ;;=R10.31^^102^1383^46
 ;;^UTILITY(U,$J,358.3,33169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33169,1,3,0)
 ;;=3^Right lower quadrant pain
 ;;^UTILITY(U,$J,358.3,33169,1,4,0)
 ;;=4^R10.31
 ;;^UTILITY(U,$J,358.3,33169,2)
 ;;=^5019211
 ;;^UTILITY(U,$J,358.3,33170,0)
 ;;=R10.84^^102^1383^1
 ;;^UTILITY(U,$J,358.3,33170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33170,1,3,0)
 ;;=3^Abdominal Pain,Generalized
 ;;^UTILITY(U,$J,358.3,33170,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,33170,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,33171,0)
 ;;=R10.10^^102^1383^49
 ;;^UTILITY(U,$J,358.3,33171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33171,1,3,0)
 ;;=3^Upper abdominal pain, unspecified
 ;;^UTILITY(U,$J,358.3,33171,1,4,0)
 ;;=4^R10.10
 ;;^UTILITY(U,$J,358.3,33171,2)
 ;;=^5019205
 ;;^UTILITY(U,$J,358.3,33172,0)
 ;;=R10.30^^102^1383^32
 ;;^UTILITY(U,$J,358.3,33172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33172,1,3,0)
 ;;=3^Lower abdominal pain, unspecified
 ;;^UTILITY(U,$J,358.3,33172,1,4,0)
 ;;=4^R10.30
 ;;^UTILITY(U,$J,358.3,33172,2)
 ;;=^5019210
 ;;^UTILITY(U,$J,358.3,33173,0)
 ;;=R10.2^^102^1383^40
 ;;^UTILITY(U,$J,358.3,33173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33173,1,3,0)
 ;;=3^Pelvic and perineal pain
 ;;^UTILITY(U,$J,358.3,33173,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,33173,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,33174,0)
 ;;=R18.8^^102^1383^9
 ;;^UTILITY(U,$J,358.3,33174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33174,1,3,0)
 ;;=3^Ascites NEC
 ;;^UTILITY(U,$J,358.3,33174,1,4,0)
 ;;=4^R18.8
 ;;^UTILITY(U,$J,358.3,33174,2)
 ;;=^5019253
 ;;^UTILITY(U,$J,358.3,33175,0)
 ;;=R19.7^^102^1383^17
 ;;^UTILITY(U,$J,358.3,33175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33175,1,3,0)
 ;;=3^Diarrhea, unspecified
 ;;^UTILITY(U,$J,358.3,33175,1,4,0)
 ;;=4^R19.7
 ;;^UTILITY(U,$J,358.3,33175,2)
 ;;=^5019276
 ;;^UTILITY(U,$J,358.3,33176,0)
 ;;=R11.2^^102^1383^36
 ;;^UTILITY(U,$J,358.3,33176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33176,1,3,0)
 ;;=3^Nausea with vomiting, unspecified
 ;;^UTILITY(U,$J,358.3,33176,1,4,0)
 ;;=4^R11.2
 ;;^UTILITY(U,$J,358.3,33176,2)
 ;;=^5019237
 ;;^UTILITY(U,$J,358.3,33177,0)
 ;;=R11.0^^102^1383^35
 ;;^UTILITY(U,$J,358.3,33177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33177,1,3,0)
 ;;=3^Nausea
 ;;^UTILITY(U,$J,358.3,33177,1,4,0)
 ;;=4^R11.0
 ;;^UTILITY(U,$J,358.3,33177,2)
 ;;=^5019231
 ;;^UTILITY(U,$J,358.3,33178,0)
 ;;=R11.10^^102^1383^51
 ;;^UTILITY(U,$J,358.3,33178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33178,1,3,0)
 ;;=3^Vomiting, unspecified
 ;;^UTILITY(U,$J,358.3,33178,1,4,0)
 ;;=4^R11.10
 ;;^UTILITY(U,$J,358.3,33178,2)
 ;;=^5019232
 ;;^UTILITY(U,$J,358.3,33179,0)
 ;;=R11.11^^102^1383^50
 ;;^UTILITY(U,$J,358.3,33179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33179,1,3,0)
 ;;=3^Vomiting without nausea
 ;;^UTILITY(U,$J,358.3,33179,1,4,0)
 ;;=4^R11.11
 ;;^UTILITY(U,$J,358.3,33179,2)
 ;;=^5019233
 ;;^UTILITY(U,$J,358.3,33180,0)
 ;;=R11.12^^102^1383^42
 ;;^UTILITY(U,$J,358.3,33180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33180,1,3,0)
 ;;=3^Projectile vomiting
 ;;^UTILITY(U,$J,358.3,33180,1,4,0)
 ;;=4^R11.12
 ;;^UTILITY(U,$J,358.3,33180,2)
 ;;=^5019234
 ;;^UTILITY(U,$J,358.3,33181,0)
 ;;=R62.7^^102^1383^5
 ;;^UTILITY(U,$J,358.3,33181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33181,1,3,0)
 ;;=3^Adult failure to thrive
 ;;^UTILITY(U,$J,358.3,33181,1,4,0)
 ;;=4^R62.7
 ;;^UTILITY(U,$J,358.3,33181,2)
 ;;=^322019
 ;;^UTILITY(U,$J,358.3,33182,0)
 ;;=R60.9^^102^1383^19
 ;;^UTILITY(U,$J,358.3,33182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33182,1,3,0)
 ;;=3^Edema, unspecified
 ;;^UTILITY(U,$J,358.3,33182,1,4,0)
 ;;=4^R60.9
 ;;^UTILITY(U,$J,358.3,33182,2)
 ;;=^5019534
 ;;^UTILITY(U,$J,358.3,33183,0)
 ;;=R60.1^^102^1383^20
 ;;^UTILITY(U,$J,358.3,33183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33183,1,3,0)
 ;;=3^Edema,Generalized
 ;;^UTILITY(U,$J,358.3,33183,1,4,0)
 ;;=4^R60.1
 ;;^UTILITY(U,$J,358.3,33183,2)
 ;;=^5019533
 ;;^UTILITY(U,$J,358.3,33184,0)
 ;;=R60.0^^102^1383^21
 ;;^UTILITY(U,$J,358.3,33184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33184,1,3,0)
 ;;=3^Edema,Localized
 ;;^UTILITY(U,$J,358.3,33184,1,4,0)
 ;;=4^R60.0
 ;;^UTILITY(U,$J,358.3,33184,2)
 ;;=^5019532
 ;;^UTILITY(U,$J,358.3,33185,0)
 ;;=L29.9^^102^1383^45
 ;;^UTILITY(U,$J,358.3,33185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33185,1,3,0)
 ;;=3^Pruritus, unspecified
 ;;^UTILITY(U,$J,358.3,33185,1,4,0)
 ;;=4^L29.9
 ;;^UTILITY(U,$J,358.3,33185,2)
 ;;=^5009153
 ;;^UTILITY(U,$J,358.3,33186,0)
 ;;=I95.9^^102^1383^28
 ;;^UTILITY(U,$J,358.3,33186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33186,1,3,0)
 ;;=3^Hypotension, unspecified
 ;;^UTILITY(U,$J,358.3,33186,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,33186,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,33187,0)
 ;;=I10.^^102^1383^24
 ;;^UTILITY(U,$J,358.3,33187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33187,1,3,0)
 ;;=3^Essential (primary) hypertension
 ;;^UTILITY(U,$J,358.3,33187,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,33187,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,33188,0)
 ;;=G89.29^^102^1383^13
 ;;^UTILITY(U,$J,358.3,33188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33188,1,3,0)
 ;;=3^Chronic Pain NEC
 ;;^UTILITY(U,$J,358.3,33188,1,4,0)
 ;;=4^G89.29
 ;;^UTILITY(U,$J,358.3,33188,2)
 ;;=^5004158
 ;;^UTILITY(U,$J,358.3,33189,0)
 ;;=F41.9^^102^1383^8
 ;;^UTILITY(U,$J,358.3,33189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33189,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,33189,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,33189,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,33190,0)
 ;;=F33.9^^102^1383^34
 ;;^UTILITY(U,$J,358.3,33190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33190,1,3,0)
 ;;=3^Major depressive disorder, recurrent, unspecified
 ;;^UTILITY(U,$J,358.3,33190,1,4,0)
 ;;=4^F33.9
