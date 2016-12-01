IBDEI0VS ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41738,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in relapse
 ;;^UTILITY(U,$J,358.3,41738,1,4,0)
 ;;=4^C91.12
 ;;^UTILITY(U,$J,358.3,41738,2)
 ;;=^5001767
 ;;^UTILITY(U,$J,358.3,41739,0)
 ;;=C91.Z1^^124^1803^32
 ;;^UTILITY(U,$J,358.3,41739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41739,1,3,0)
 ;;=3^Lymphoid leukemia, in remission NEC
 ;;^UTILITY(U,$J,358.3,41739,1,4,0)
 ;;=4^C91.Z1
 ;;^UTILITY(U,$J,358.3,41739,2)
 ;;=^5001787
 ;;^UTILITY(U,$J,358.3,41740,0)
 ;;=C91.Z2^^124^1803^31
 ;;^UTILITY(U,$J,358.3,41740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41740,1,3,0)
 ;;=3^Lymphoid leukemia, in relapse NEC
 ;;^UTILITY(U,$J,358.3,41740,1,4,0)
 ;;=4^C91.Z2
 ;;^UTILITY(U,$J,358.3,41740,2)
 ;;=^5001788
 ;;^UTILITY(U,$J,358.3,41741,0)
 ;;=C92.01^^124^1803^6
 ;;^UTILITY(U,$J,358.3,41741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41741,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,41741,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,41741,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,41742,0)
 ;;=C92.41^^124^1803^10
 ;;^UTILITY(U,$J,358.3,41742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41742,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,41742,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,41742,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,41743,0)
 ;;=C92.51^^124^1803^8
 ;;^UTILITY(U,$J,358.3,41743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41743,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,41743,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,41743,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,41744,0)
 ;;=C92.02^^124^1803^5
 ;;^UTILITY(U,$J,358.3,41744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41744,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,41744,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,41744,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,41745,0)
 ;;=C92.42^^124^1803^9
 ;;^UTILITY(U,$J,358.3,41745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41745,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,41745,1,4,0)
 ;;=4^C92.42
 ;;^UTILITY(U,$J,358.3,41745,2)
 ;;=^5001803
 ;;^UTILITY(U,$J,358.3,41746,0)
 ;;=C92.52^^124^1803^7
 ;;^UTILITY(U,$J,358.3,41746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41746,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,41746,1,4,0)
 ;;=4^C92.52
 ;;^UTILITY(U,$J,358.3,41746,2)
 ;;=^5001806
 ;;^UTILITY(U,$J,358.3,41747,0)
 ;;=C92.11^^124^1803^18
 ;;^UTILITY(U,$J,358.3,41747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41747,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,41747,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,41747,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,41748,0)
 ;;=C92.12^^124^1803^19
 ;;^UTILITY(U,$J,358.3,41748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41748,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in relapse
 ;;^UTILITY(U,$J,358.3,41748,1,4,0)
 ;;=4^C92.12
 ;;^UTILITY(U,$J,358.3,41748,2)
 ;;=^5001794
 ;;^UTILITY(U,$J,358.3,41749,0)
 ;;=C92.21^^124^1803^13
 ;;^UTILITY(U,$J,358.3,41749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41749,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in remission
 ;;^UTILITY(U,$J,358.3,41749,1,4,0)
 ;;=4^C92.21
 ;;^UTILITY(U,$J,358.3,41749,2)
 ;;=^5001796
 ;;^UTILITY(U,$J,358.3,41750,0)
 ;;=C92.22^^124^1803^14
 ;;^UTILITY(U,$J,358.3,41750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41750,1,3,0)
 ;;=3^Atypical chronic myeloid leukemia, BCR/ABL-neg, in relapse
 ;;^UTILITY(U,$J,358.3,41750,1,4,0)
 ;;=4^C92.22
 ;;^UTILITY(U,$J,358.3,41750,2)
 ;;=^5001797
 ;;^UTILITY(U,$J,358.3,41751,0)
 ;;=C93.01^^124^1803^3
 ;;^UTILITY(U,$J,358.3,41751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41751,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,41751,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,41751,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,41752,0)
 ;;=C93.02^^124^1803^4
 ;;^UTILITY(U,$J,358.3,41752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41752,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,41752,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,41752,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,41753,0)
 ;;=C93.11^^124^1803^21
 ;;^UTILITY(U,$J,358.3,41753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41753,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,41753,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,41753,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,41754,0)
 ;;=C93.12^^124^1803^20
 ;;^UTILITY(U,$J,358.3,41754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41754,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,41754,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,41754,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,41755,0)
 ;;=C93.91^^124^1803^38
 ;;^UTILITY(U,$J,358.3,41755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41755,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,41755,1,4,0)
 ;;=4^C93.91
 ;;^UTILITY(U,$J,358.3,41755,2)
 ;;=^5001829
 ;;^UTILITY(U,$J,358.3,41756,0)
 ;;=C93.92^^124^1803^37
 ;;^UTILITY(U,$J,358.3,41756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41756,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,41756,1,4,0)
 ;;=4^C93.92
 ;;^UTILITY(U,$J,358.3,41756,2)
 ;;=^5001830
 ;;^UTILITY(U,$J,358.3,41757,0)
 ;;=E88.3^^124^1803^51
 ;;^UTILITY(U,$J,358.3,41757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41757,1,3,0)
 ;;=3^Tumor lysis syndrome
 ;;^UTILITY(U,$J,358.3,41757,1,4,0)
 ;;=4^E88.3
 ;;^UTILITY(U,$J,358.3,41757,2)
 ;;=^338229
 ;;^UTILITY(U,$J,358.3,41758,0)
 ;;=C62.11^^124^1804^2
 ;;^UTILITY(U,$J,358.3,41758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41758,1,3,0)
 ;;=3^Malignant neoplasm of descended right testis
 ;;^UTILITY(U,$J,358.3,41758,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,41758,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,41759,0)
 ;;=C62.12^^124^1804^1
 ;;^UTILITY(U,$J,358.3,41759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41759,1,3,0)
 ;;=3^Malignant neoplasm of descended left testis
 ;;^UTILITY(U,$J,358.3,41759,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,41759,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,41760,0)
 ;;=M81.0^^124^1805^1
 ;;^UTILITY(U,$J,358.3,41760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41760,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,41760,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,41760,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,41761,0)
 ;;=E10.9^^124^1805^2
 ;;^UTILITY(U,$J,358.3,41761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41761,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,41761,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,41761,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,41762,0)
 ;;=E11.9^^124^1805^3
 ;;^UTILITY(U,$J,358.3,41762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41762,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,41762,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,41762,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,41763,0)
 ;;=R10.9^^124^1806^2
 ;;^UTILITY(U,$J,358.3,41763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41763,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,41763,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,41763,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,41764,0)
 ;;=R10.11^^124^1806^42
 ;;^UTILITY(U,$J,358.3,41764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41764,1,3,0)
 ;;=3^Right upper quadrant pain
 ;;^UTILITY(U,$J,358.3,41764,1,4,0)
 ;;=4^R10.11
 ;;^UTILITY(U,$J,358.3,41764,2)
 ;;=^5019206
 ;;^UTILITY(U,$J,358.3,41765,0)
 ;;=R10.31^^124^1806^41
 ;;^UTILITY(U,$J,358.3,41765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41765,1,3,0)
 ;;=3^Right lower quadrant pain
 ;;^UTILITY(U,$J,358.3,41765,1,4,0)
 ;;=4^R10.31
 ;;^UTILITY(U,$J,358.3,41765,2)
 ;;=^5019211
 ;;^UTILITY(U,$J,358.3,41766,0)
 ;;=R10.84^^124^1806^1
 ;;^UTILITY(U,$J,358.3,41766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41766,1,3,0)
 ;;=3^Abdominal Pain,Generalized
 ;;^UTILITY(U,$J,358.3,41766,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,41766,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,41767,0)
 ;;=R10.10^^124^1806^44
 ;;^UTILITY(U,$J,358.3,41767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41767,1,3,0)
 ;;=3^Upper abdominal pain, unspecified
 ;;^UTILITY(U,$J,358.3,41767,1,4,0)
 ;;=4^R10.10
 ;;^UTILITY(U,$J,358.3,41767,2)
 ;;=^5019205
 ;;^UTILITY(U,$J,358.3,41768,0)
 ;;=R10.30^^124^1806^28
 ;;^UTILITY(U,$J,358.3,41768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41768,1,3,0)
 ;;=3^Lower abdominal pain, unspecified
 ;;^UTILITY(U,$J,358.3,41768,1,4,0)
 ;;=4^R10.30
 ;;^UTILITY(U,$J,358.3,41768,2)
 ;;=^5019210
 ;;^UTILITY(U,$J,358.3,41769,0)
 ;;=R10.2^^124^1806^35
 ;;^UTILITY(U,$J,358.3,41769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41769,1,3,0)
 ;;=3^Pelvic and perineal pain
 ;;^UTILITY(U,$J,358.3,41769,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,41769,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,41770,0)
 ;;=R18.8^^124^1806^9
 ;;^UTILITY(U,$J,358.3,41770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41770,1,3,0)
 ;;=3^Ascites NEC
 ;;^UTILITY(U,$J,358.3,41770,1,4,0)
 ;;=4^R18.8
 ;;^UTILITY(U,$J,358.3,41770,2)
 ;;=^5019253
 ;;^UTILITY(U,$J,358.3,41771,0)
 ;;=R19.7^^124^1806^16
 ;;^UTILITY(U,$J,358.3,41771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41771,1,3,0)
 ;;=3^Diarrhea, unspecified
 ;;^UTILITY(U,$J,358.3,41771,1,4,0)
 ;;=4^R19.7
 ;;^UTILITY(U,$J,358.3,41771,2)
 ;;=^5019276
 ;;^UTILITY(U,$J,358.3,41772,0)
 ;;=R11.2^^124^1806^32
 ;;^UTILITY(U,$J,358.3,41772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41772,1,3,0)
 ;;=3^Nausea with vomiting, unspecified
 ;;^UTILITY(U,$J,358.3,41772,1,4,0)
 ;;=4^R11.2
 ;;^UTILITY(U,$J,358.3,41772,2)
 ;;=^5019237
