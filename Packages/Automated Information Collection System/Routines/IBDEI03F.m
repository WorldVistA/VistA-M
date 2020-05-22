IBDEI03F ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8113,2)
 ;;=^5008711
 ;;^UTILITY(U,$J,358.3,8114,0)
 ;;=K31.9^^45^447^13
 ;;^UTILITY(U,$J,358.3,8114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8114,1,3,0)
 ;;=3^Disease of Duodenum,Unsp
 ;;^UTILITY(U,$J,358.3,8114,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,8114,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,8115,0)
 ;;=K63.9^^45^447^14
 ;;^UTILITY(U,$J,358.3,8115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8115,1,3,0)
 ;;=3^Disease of Intestine,Unspec
 ;;^UTILITY(U,$J,358.3,8115,1,4,0)
 ;;=4^K63.9
 ;;^UTILITY(U,$J,358.3,8115,2)
 ;;=^5008768
 ;;^UTILITY(U,$J,358.3,8116,0)
 ;;=K56.50^^45^447^48
 ;;^UTILITY(U,$J,358.3,8116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8116,1,3,0)
 ;;=3^Obstruction of Sm Int,Partial or Complete,Adhesions
 ;;^UTILITY(U,$J,358.3,8116,1,4,0)
 ;;=4^K56.50
 ;;^UTILITY(U,$J,358.3,8116,2)
 ;;=^5151418
 ;;^UTILITY(U,$J,358.3,8117,0)
 ;;=K56.51^^45^447^50
 ;;^UTILITY(U,$J,358.3,8117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8117,1,3,0)
 ;;=3^Obstruction of Sm Int,Partial,Adhesions
 ;;^UTILITY(U,$J,358.3,8117,1,4,0)
 ;;=4^K56.51
 ;;^UTILITY(U,$J,358.3,8117,2)
 ;;=^5151419
 ;;^UTILITY(U,$J,358.3,8118,0)
 ;;=K56.52^^45^447^46
 ;;^UTILITY(U,$J,358.3,8118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8118,1,3,0)
 ;;=3^Obstruction of Sm Int,Complete,Adhesions
 ;;^UTILITY(U,$J,358.3,8118,1,4,0)
 ;;=4^K56.52
 ;;^UTILITY(U,$J,358.3,8118,2)
 ;;=^5151420
 ;;^UTILITY(U,$J,358.3,8119,0)
 ;;=K56.600^^45^447^47
 ;;^UTILITY(U,$J,358.3,8119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8119,1,3,0)
 ;;=3^Obstruction of Sm Int,Partial
 ;;^UTILITY(U,$J,358.3,8119,1,4,0)
 ;;=4^K56.600
 ;;^UTILITY(U,$J,358.3,8119,2)
 ;;=^5151421
 ;;^UTILITY(U,$J,358.3,8120,0)
 ;;=K56.601^^45^447^45
 ;;^UTILITY(U,$J,358.3,8120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8120,1,3,0)
 ;;=3^Obstruction of Sm Int,Complete
 ;;^UTILITY(U,$J,358.3,8120,1,4,0)
 ;;=4^K56.601
 ;;^UTILITY(U,$J,358.3,8120,2)
 ;;=^5151422
 ;;^UTILITY(U,$J,358.3,8121,0)
 ;;=K56.609^^45^447^49
 ;;^UTILITY(U,$J,358.3,8121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8121,1,3,0)
 ;;=3^Obstruction of Sm Int,Partial or Complete
 ;;^UTILITY(U,$J,358.3,8121,1,4,0)
 ;;=4^K56.609
 ;;^UTILITY(U,$J,358.3,8121,2)
 ;;=^5151423
 ;;^UTILITY(U,$J,358.3,8122,0)
 ;;=K29.81^^45^447^21
 ;;^UTILITY(U,$J,358.3,8122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8122,1,3,0)
 ;;=3^Duodenitis w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8122,1,4,0)
 ;;=4^K29.81
 ;;^UTILITY(U,$J,358.3,8122,2)
 ;;=^5008555
 ;;^UTILITY(U,$J,358.3,8123,0)
 ;;=K29.80^^45^447^22
 ;;^UTILITY(U,$J,358.3,8123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8123,1,3,0)
 ;;=3^Duodenitis w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8123,1,4,0)
 ;;=4^K29.80
 ;;^UTILITY(U,$J,358.3,8123,2)
 ;;=^5008554
 ;;^UTILITY(U,$J,358.3,8124,0)
 ;;=K26.7^^45^447^63
 ;;^UTILITY(U,$J,358.3,8124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8124,1,3,0)
 ;;=3^Ulcer,Duodenal,Chronic w/o Bleed or Perforation
 ;;^UTILITY(U,$J,358.3,8124,1,4,0)
 ;;=4^K26.7
 ;;^UTILITY(U,$J,358.3,8124,2)
 ;;=^5008526
 ;;^UTILITY(U,$J,358.3,8125,0)
 ;;=B96.81^^45^448^27
 ;;^UTILITY(U,$J,358.3,8125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8125,1,3,0)
 ;;=3^Helicobacter pylori w/ or w/o complications
 ;;^UTILITY(U,$J,358.3,8125,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,8125,2)
 ;;=^5000857
 ;;^UTILITY(U,$J,358.3,8126,0)
 ;;=C16.9^^45^448^34
 ;;^UTILITY(U,$J,358.3,8126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8126,1,3,0)
 ;;=3^Malignant neoplasm,Unsp stomach
 ;;^UTILITY(U,$J,358.3,8126,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,8126,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,8127,0)
 ;;=I86.4^^45^448^15
 ;;^UTILITY(U,$J,358.3,8127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8127,1,3,0)
 ;;=3^Gastric varices
 ;;^UTILITY(U,$J,358.3,8127,1,4,0)
 ;;=4^I86.4
 ;;^UTILITY(U,$J,358.3,8127,2)
 ;;=^49382
 ;;^UTILITY(U,$J,358.3,8128,0)
 ;;=K25.0^^45^448^39
 ;;^UTILITY(U,$J,358.3,8128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8128,1,3,0)
 ;;=3^Ulcer,Stomach,Acute w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8128,1,4,0)
 ;;=4^K25.0
 ;;^UTILITY(U,$J,358.3,8128,2)
 ;;=^270064
 ;;^UTILITY(U,$J,358.3,8129,0)
 ;;=K29.30^^45^448^22
 ;;^UTILITY(U,$J,358.3,8129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8129,1,3,0)
 ;;=3^Gastritis,Chronic superficial w/o bleeding
 ;;^UTILITY(U,$J,358.3,8129,1,4,0)
 ;;=4^K29.30
 ;;^UTILITY(U,$J,358.3,8129,2)
 ;;=^5008546
 ;;^UTILITY(U,$J,358.3,8130,0)
 ;;=K29.20^^45^448^19
 ;;^UTILITY(U,$J,358.3,8130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8130,1,3,0)
 ;;=3^Gastritis,Alcoholic w/o bleeding
 ;;^UTILITY(U,$J,358.3,8130,1,4,0)
 ;;=4^K29.20
 ;;^UTILITY(U,$J,358.3,8130,2)
 ;;=^5008544
 ;;^UTILITY(U,$J,358.3,8131,0)
 ;;=K31.89^^45^448^37
 ;;^UTILITY(U,$J,358.3,8131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8131,1,3,0)
 ;;=3^Portal hypertensive gastropathy
 ;;^UTILITY(U,$J,358.3,8131,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,8131,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,8132,0)
 ;;=K31.819^^45^448^3
 ;;^UTILITY(U,$J,358.3,8132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8132,1,3,0)
 ;;=3^Angiodysplasia Stomach w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8132,1,4,0)
 ;;=4^K31.819
 ;;^UTILITY(U,$J,358.3,8132,2)
 ;;=^5008568
 ;;^UTILITY(U,$J,358.3,8133,0)
 ;;=K31.811^^45^448^2
 ;;^UTILITY(U,$J,358.3,8133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8133,1,3,0)
 ;;=3^Angiodysplasia Stomach w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8133,1,4,0)
 ;;=4^K31.811
 ;;^UTILITY(U,$J,358.3,8133,2)
 ;;=^5008567
 ;;^UTILITY(U,$J,358.3,8134,0)
 ;;=K25.1^^45^448^40
 ;;^UTILITY(U,$J,358.3,8134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8134,1,3,0)
 ;;=3^Ulcer,Stomach,Acute w/ Perforation
 ;;^UTILITY(U,$J,358.3,8134,1,4,0)
 ;;=4^K25.1
 ;;^UTILITY(U,$J,358.3,8134,2)
 ;;=^270067
 ;;^UTILITY(U,$J,358.3,8135,0)
 ;;=K25.2^^45^448^38
 ;;^UTILITY(U,$J,358.3,8135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8135,1,3,0)
 ;;=3^Ulcer,Stomach,Acute w/ Bleed & Perf
 ;;^UTILITY(U,$J,358.3,8135,1,4,0)
 ;;=4^K25.2
 ;;^UTILITY(U,$J,358.3,8135,2)
 ;;=^5008518
 ;;^UTILITY(U,$J,358.3,8136,0)
 ;;=K25.3^^45^448^41
 ;;^UTILITY(U,$J,358.3,8136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8136,1,3,0)
 ;;=3^Ulcer,Stomach,Acute w/o Bleed or Perf
 ;;^UTILITY(U,$J,358.3,8136,1,4,0)
 ;;=4^K25.3
 ;;^UTILITY(U,$J,358.3,8136,2)
 ;;=^5008519
 ;;^UTILITY(U,$J,358.3,8137,0)
 ;;=K25.4^^45^448^43
 ;;^UTILITY(U,$J,358.3,8137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8137,1,3,0)
 ;;=3^Ulcer,Stomach,Chronic w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8137,1,4,0)
 ;;=4^K25.4
 ;;^UTILITY(U,$J,358.3,8137,2)
 ;;=^270076
 ;;^UTILITY(U,$J,358.3,8138,0)
 ;;=K25.5^^45^448^44
 ;;^UTILITY(U,$J,358.3,8138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8138,1,3,0)
 ;;=3^Ulcer,Stomach,Chronic w/ Perf
 ;;^UTILITY(U,$J,358.3,8138,1,4,0)
 ;;=4^K25.5
 ;;^UTILITY(U,$J,358.3,8138,2)
 ;;=^270079
 ;;^UTILITY(U,$J,358.3,8139,0)
 ;;=K25.6^^45^448^42
 ;;^UTILITY(U,$J,358.3,8139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8139,1,3,0)
 ;;=3^Ulcer,Stomach,Chronic w/ Bleed & Perf
 ;;^UTILITY(U,$J,358.3,8139,1,4,0)
 ;;=4^K25.6
 ;;^UTILITY(U,$J,358.3,8139,2)
 ;;=^5008520
 ;;^UTILITY(U,$J,358.3,8140,0)
 ;;=R93.3^^45^448^1
 ;;^UTILITY(U,$J,358.3,8140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8140,1,3,0)
 ;;=3^Abnormal imaging Digestive tract
 ;;^UTILITY(U,$J,358.3,8140,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,8140,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,8141,0)
 ;;=D13.1^^45^448^4
 ;;^UTILITY(U,$J,358.3,8141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8141,1,3,0)
 ;;=3^Benign neoplasm of Stomach
 ;;^UTILITY(U,$J,358.3,8141,1,4,0)
 ;;=4^D13.1
 ;;^UTILITY(U,$J,358.3,8141,2)
 ;;=^267589
 ;;^UTILITY(U,$J,358.3,8142,0)
 ;;=K31.82^^45^448^6
 ;;^UTILITY(U,$J,358.3,8142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8142,1,3,0)
 ;;=3^Dieulafoy lesion of Stomach
 ;;^UTILITY(U,$J,358.3,8142,1,4,0)
 ;;=4^K31.82
 ;;^UTILITY(U,$J,358.3,8142,2)
 ;;=^328530
 ;;^UTILITY(U,$J,358.3,8143,0)
 ;;=K52.81^^45^448^8
 ;;^UTILITY(U,$J,358.3,8143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8143,1,3,0)
 ;;=3^Eosinophilic gastritis or gastroenteritis
 ;;^UTILITY(U,$J,358.3,8143,1,4,0)
 ;;=4^K52.81
 ;;^UTILITY(U,$J,358.3,8143,2)
 ;;=^5008702
 ;;^UTILITY(U,$J,358.3,8144,0)
 ;;=K31.6^^45^448^9
 ;;^UTILITY(U,$J,358.3,8144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8144,1,3,0)
 ;;=3^Fistula of Stomach
 ;;^UTILITY(U,$J,358.3,8144,1,4,0)
 ;;=4^K31.6
 ;;^UTILITY(U,$J,358.3,8144,2)
 ;;=^5008565
 ;;^UTILITY(U,$J,358.3,8145,0)
 ;;=T18.2XXA^^45^448^10
 ;;^UTILITY(U,$J,358.3,8145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8145,1,3,0)
 ;;=3^Foreign body in Stomach,Initial
 ;;^UTILITY(U,$J,358.3,8145,1,4,0)
 ;;=4^T18.2XXA
 ;;^UTILITY(U,$J,358.3,8145,2)
 ;;=^5046603
 ;;^UTILITY(U,$J,358.3,8146,0)
 ;;=T18.2XXD^^45^448^12
 ;;^UTILITY(U,$J,358.3,8146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8146,1,3,0)
 ;;=3^Foreign body in Stomach,Subsequent
 ;;^UTILITY(U,$J,358.3,8146,1,4,0)
 ;;=4^T18.2XXD
 ;;^UTILITY(U,$J,358.3,8146,2)
 ;;=^5046604
 ;;^UTILITY(U,$J,358.3,8147,0)
 ;;=T18.2XXS^^45^448^11
 ;;^UTILITY(U,$J,358.3,8147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8147,1,3,0)
 ;;=3^Foreign body in Stomach,Sequela
 ;;^UTILITY(U,$J,358.3,8147,1,4,0)
 ;;=4^T18.2XXS
 ;;^UTILITY(U,$J,358.3,8147,2)
 ;;=^5046605
 ;;^UTILITY(U,$J,358.3,8148,0)
 ;;=K29.01^^45^448^16
 ;;^UTILITY(U,$J,358.3,8148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8148,1,3,0)
 ;;=3^Gastritis,Acute w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8148,1,4,0)
 ;;=4^K29.01
 ;;^UTILITY(U,$J,358.3,8148,2)
 ;;=^5008543
 ;;^UTILITY(U,$J,358.3,8149,0)
 ;;=K29.00^^45^448^17
 ;;^UTILITY(U,$J,358.3,8149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8149,1,3,0)
 ;;=3^Gastritis,Acute w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8149,1,4,0)
 ;;=4^K29.00
 ;;^UTILITY(U,$J,358.3,8149,2)
 ;;=^5008542
 ;;^UTILITY(U,$J,358.3,8150,0)
 ;;=K29.21^^45^448^18
 ;;^UTILITY(U,$J,358.3,8150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8150,1,3,0)
 ;;=3^Gastritis,Alcoholic w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8150,1,4,0)
 ;;=4^K29.21
 ;;^UTILITY(U,$J,358.3,8150,2)
 ;;=^5008545
 ;;^UTILITY(U,$J,358.3,8151,0)
 ;;=K29.41^^45^448^20
 ;;^UTILITY(U,$J,358.3,8151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8151,1,3,0)
 ;;=3^Gastritis,Chronic Atrophic w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8151,1,4,0)
 ;;=4^K29.41
 ;;^UTILITY(U,$J,358.3,8151,2)
 ;;=^5008549
 ;;^UTILITY(U,$J,358.3,8152,0)
 ;;=K29.40^^45^448^21
 ;;^UTILITY(U,$J,358.3,8152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8152,1,3,0)
 ;;=3^Gastritis,Chronic Atrophic w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8152,1,4,0)
 ;;=4^K29.40
 ;;^UTILITY(U,$J,358.3,8152,2)
 ;;=^5008548
 ;;^UTILITY(U,$J,358.3,8153,0)
 ;;=C49.A2^^45^448^25
 ;;^UTILITY(U,$J,358.3,8153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8153,1,3,0)
 ;;=3^Gastrointestinal stromal tumor of Stomach
 ;;^UTILITY(U,$J,358.3,8153,1,4,0)
 ;;=4^C49.A2
 ;;^UTILITY(U,$J,358.3,8153,2)
 ;;=^8148063
 ;;^UTILITY(U,$J,358.3,8154,0)
 ;;=K31.84^^45^448^26
 ;;^UTILITY(U,$J,358.3,8154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8154,1,3,0)
 ;;=3^Gastroparesis
 ;;^UTILITY(U,$J,358.3,8154,1,4,0)
 ;;=4^K31.84
 ;;^UTILITY(U,$J,358.3,8154,2)
 ;;=^264447
 ;;^UTILITY(U,$J,358.3,8155,0)
 ;;=E16.4^^45^448^28
 ;;^UTILITY(U,$J,358.3,8155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8155,1,3,0)
 ;;=3^Hypergastrinemia
 ;;^UTILITY(U,$J,358.3,8155,1,4,0)
 ;;=4^E16.4
 ;;^UTILITY(U,$J,358.3,8155,2)
 ;;=^5002710
 ;;^UTILITY(U,$J,358.3,8156,0)
 ;;=C16.2^^45^448^29
 ;;^UTILITY(U,$J,358.3,8156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8156,1,3,0)
 ;;=3^Malignant neoplasm,Body
 ;;^UTILITY(U,$J,358.3,8156,1,4,0)
 ;;=4^C16.2
 ;;^UTILITY(U,$J,358.3,8156,2)
 ;;=^267067
 ;;^UTILITY(U,$J,358.3,8157,0)
 ;;=C16.5^^45^448^32
 ;;^UTILITY(U,$J,358.3,8157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8157,1,3,0)
 ;;=3^Malignant neoplasm,Lesser curve
 ;;^UTILITY(U,$J,358.3,8157,1,4,0)
 ;;=4^C16.5
 ;;^UTILITY(U,$J,358.3,8157,2)
 ;;=^5000920
 ;;^UTILITY(U,$J,358.3,8158,0)
 ;;=C16.8^^45^448^33
 ;;^UTILITY(U,$J,358.3,8158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8158,1,3,0)
 ;;=3^Malignant neoplasm,Overlapping sites
 ;;^UTILITY(U,$J,358.3,8158,1,4,0)
 ;;=4^C16.8
 ;;^UTILITY(U,$J,358.3,8158,2)
 ;;=^5000922
 ;;^UTILITY(U,$J,358.3,8159,0)
 ;;=K31.1^^45^448^35
 ;;^UTILITY(U,$J,358.3,8159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8159,1,3,0)
 ;;=3^Obstruction of Pylorus
 ;;^UTILITY(U,$J,358.3,8159,1,4,0)
 ;;=4^K31.1
 ;;^UTILITY(U,$J,358.3,8159,2)
 ;;=^5008560
 ;;^UTILITY(U,$J,358.3,8160,0)
 ;;=K31.7^^45^448^36
 ;;^UTILITY(U,$J,358.3,8160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8160,1,3,0)
 ;;=3^Polyp of Stomach
 ;;^UTILITY(U,$J,358.3,8160,1,4,0)
 ;;=4^K31.7
 ;;^UTILITY(U,$J,358.3,8160,2)
 ;;=^5008566
 ;;^UTILITY(U,$J,358.3,8161,0)
 ;;=K25.7^^45^448^45
 ;;^UTILITY(U,$J,358.3,8161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8161,1,3,0)
 ;;=3^Ulcer,Stomach,Chronic w/o Bleed or Perf
 ;;^UTILITY(U,$J,358.3,8161,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,8161,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,8162,0)
 ;;=K56.2^^45^448^46
 ;;^UTILITY(U,$J,358.3,8162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8162,1,3,0)
 ;;=3^Volvulus
 ;;^UTILITY(U,$J,358.3,8162,1,4,0)
 ;;=4^K56.2
 ;;^UTILITY(U,$J,358.3,8162,2)
 ;;=^5008711
 ;;^UTILITY(U,$J,358.3,8163,0)
 ;;=K31.9^^45^448^7
 ;;^UTILITY(U,$J,358.3,8163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8163,1,3,0)
 ;;=3^Disease of Stomach,Unsp
 ;;^UTILITY(U,$J,358.3,8163,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,8163,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,8164,0)
 ;;=C16.1^^45^448^30
 ;;^UTILITY(U,$J,358.3,8164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8164,1,3,0)
 ;;=3^Malignant neoplasm,Fundus
 ;;^UTILITY(U,$J,358.3,8164,1,4,0)
 ;;=4^C16.1
 ;;^UTILITY(U,$J,358.3,8164,2)
 ;;=^267066
 ;;^UTILITY(U,$J,358.3,8165,0)
 ;;=C16.6^^45^448^31
 ;;^UTILITY(U,$J,358.3,8165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8165,1,3,0)
 ;;=3^Malignant neoplasm,Greater curve
 ;;^UTILITY(U,$J,358.3,8165,1,4,0)
 ;;=4^C16.6
 ;;^UTILITY(U,$J,358.3,8165,2)
 ;;=^5000921
 ;;^UTILITY(U,$J,358.3,8166,0)
 ;;=K31.811^^45^448^13
 ;;^UTILITY(U,$J,358.3,8166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8166,1,3,0)
 ;;=3^Gastric antral vascular ectasia w/ bleeding
 ;;^UTILITY(U,$J,358.3,8166,1,4,0)
 ;;=4^K31.811
 ;;^UTILITY(U,$J,358.3,8166,2)
 ;;=^5008567
 ;;^UTILITY(U,$J,358.3,8167,0)
 ;;=K31.819^^45^448^14
 ;;^UTILITY(U,$J,358.3,8167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8167,1,3,0)
 ;;=3^Gastric antral vascular ectasia w/o bleeding
 ;;^UTILITY(U,$J,358.3,8167,1,4,0)
 ;;=4^K31.819
 ;;^UTILITY(U,$J,358.3,8167,2)
 ;;=^5008568
 ;;^UTILITY(U,$J,358.3,8168,0)
 ;;=K29.71^^45^448^23
 ;;^UTILITY(U,$J,358.3,8168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8168,1,3,0)
 ;;=3^Gastritis,Unspec w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8168,1,4,0)
 ;;=4^K29.71
 ;;^UTILITY(U,$J,358.3,8168,2)
 ;;=^5008553
 ;;^UTILITY(U,$J,358.3,8169,0)
 ;;=K29.70^^45^448^24
 ;;^UTILITY(U,$J,358.3,8169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8169,1,3,0)
 ;;=3^Gastritis,Unspec w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8169,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,8169,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,8170,0)
 ;;=D00.2^^45^448^5
 ;;^UTILITY(U,$J,358.3,8170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8170,1,3,0)
 ;;=3^Carcinoma in Situ of Stomach
 ;;^UTILITY(U,$J,358.3,8170,1,4,0)
 ;;=4^D00.2
 ;;^UTILITY(U,$J,358.3,8170,2)
 ;;=^267711
 ;;^UTILITY(U,$J,358.3,8171,0)
 ;;=K91.1^^45^449^14
 ;;^UTILITY(U,$J,358.3,8171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8171,1,3,0)
 ;;=3^Postgastric surgery syndromes incl. Dumping syndrome
 ;;^UTILITY(U,$J,358.3,8171,1,4,0)
 ;;=4^K91.1
 ;;^UTILITY(U,$J,358.3,8171,2)
 ;;=^5008900
 ;;^UTILITY(U,$J,358.3,8172,0)
 ;;=Z93.1^^45^449^10
 ;;^UTILITY(U,$J,358.3,8172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8172,1,3,0)
 ;;=3^Gastrostomy status
 ;;^UTILITY(U,$J,358.3,8172,1,4,0)
 ;;=4^Z93.1
 ;;^UTILITY(U,$J,358.3,8172,2)
 ;;=^5063643
 ;;^UTILITY(U,$J,358.3,8173,0)
 ;;=Z90.3^^45^449^4
 ;;^UTILITY(U,$J,358.3,8173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8173,1,3,0)
 ;;=3^Acquired absence of Stomach
 ;;^UTILITY(U,$J,358.3,8173,1,4,0)
 ;;=4^Z90.3
 ;;^UTILITY(U,$J,358.3,8173,2)
 ;;=^5063586
 ;;^UTILITY(U,$J,358.3,8174,0)
 ;;=Z90.49^^45^449^1
 ;;^UTILITY(U,$J,358.3,8174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8174,1,3,0)
 ;;=3^Acquired absence of (specified) Digestive tract
 ;;^UTILITY(U,$J,358.3,8174,1,4,0)
 ;;=4^Z90.49
 ;;^UTILITY(U,$J,358.3,8174,2)
 ;;=^5063589
 ;;^UTILITY(U,$J,358.3,8175,0)
 ;;=Z90.411^^45^449^2
 ;;^UTILITY(U,$J,358.3,8175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8175,1,3,0)
 ;;=3^Acquired absence of Pancreas,Partial
 ;;^UTILITY(U,$J,358.3,8175,1,4,0)
 ;;=4^Z90.411
 ;;^UTILITY(U,$J,358.3,8175,2)
 ;;=^5063588
 ;;^UTILITY(U,$J,358.3,8176,0)
 ;;=Z90.410^^45^449^3
 ;;^UTILITY(U,$J,358.3,8176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8176,1,3,0)
 ;;=3^Acquired absence of Pancreas,Total
 ;;^UTILITY(U,$J,358.3,8176,1,4,0)
 ;;=4^Z90.410
 ;;^UTILITY(U,$J,358.3,8176,2)
 ;;=^5063587
 ;;^UTILITY(U,$J,358.3,8177,0)
 ;;=Z98.84^^45^449^5
 ;;^UTILITY(U,$J,358.3,8177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8177,1,3,0)
 ;;=3^Bariatric surgery status
 ;;^UTILITY(U,$J,358.3,8177,1,4,0)
 ;;=4^Z98.84
 ;;^UTILITY(U,$J,358.3,8177,2)
 ;;=^5063749
 ;;^UTILITY(U,$J,358.3,8178,0)
 ;;=Z93.3^^45^449^6
 ;;^UTILITY(U,$J,358.3,8178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8178,1,3,0)
 ;;=3^Colostomy status
 ;;^UTILITY(U,$J,358.3,8178,1,4,0)
 ;;=4^Z93.3
 ;;^UTILITY(U,$J,358.3,8178,2)
 ;;=^5063645
 ;;^UTILITY(U,$J,358.3,8179,0)
 ;;=K94.21^^45^449^8
 ;;^UTILITY(U,$J,358.3,8179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8179,1,3,0)
 ;;=3^Gastrostomy hemorrhage
 ;;^UTILITY(U,$J,358.3,8179,1,4,0)
 ;;=4^K94.21
 ;;^UTILITY(U,$J,358.3,8179,2)
 ;;=^5008929
 ;;^UTILITY(U,$J,358.3,8180,0)
 ;;=K94.23^^45^449^9
 ;;^UTILITY(U,$J,358.3,8180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8180,1,3,0)
 ;;=3^Gastrostomy malfunction
 ;;^UTILITY(U,$J,358.3,8180,1,4,0)
 ;;=4^K94.23
 ;;^UTILITY(U,$J,358.3,8180,2)
 ;;=^5008931
 ;;^UTILITY(U,$J,358.3,8181,0)
 ;;=Z93.2^^45^449^11
 ;;^UTILITY(U,$J,358.3,8181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8181,1,3,0)
 ;;=3^Ileostomy status
 ;;^UTILITY(U,$J,358.3,8181,1,4,0)
 ;;=4^Z93.2
 ;;^UTILITY(U,$J,358.3,8181,2)
 ;;=^5063644
 ;;^UTILITY(U,$J,358.3,8182,0)
 ;;=Z93.4^^45^449^13
 ;;^UTILITY(U,$J,358.3,8182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8182,1,3,0)
 ;;=3^Jejunostomy status
 ;;^UTILITY(U,$J,358.3,8182,1,4,0)
 ;;=4^Z93.4
 ;;^UTILITY(U,$J,358.3,8182,2)
 ;;=^5063646
 ;;^UTILITY(U,$J,358.3,8183,0)
 ;;=K94.29^^45^449^7
 ;;^UTILITY(U,$J,358.3,8183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8183,1,3,0)
 ;;=3^Gastrostomy Complications,Other
 ;;^UTILITY(U,$J,358.3,8183,1,4,0)
 ;;=4^K94.29
 ;;^UTILITY(U,$J,358.3,8183,2)
 ;;=^5008932
 ;;^UTILITY(U,$J,358.3,8184,0)
 ;;=K91.858^^45^449^12
