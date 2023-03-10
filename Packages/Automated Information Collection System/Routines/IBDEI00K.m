IBDEI00K ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,790,1,1,0)
 ;;=1^Low Complex MDM or 30-44 mins
 ;;^UTILITY(U,$J,358.3,790,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,791,0)
 ;;=99204^^9^61^3
 ;;^UTILITY(U,$J,358.3,791,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,791,1,1,0)
 ;;=1^Mod Complex MDM or 45-59 mins
 ;;^UTILITY(U,$J,358.3,791,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,792,0)
 ;;=99205^^9^61^4
 ;;^UTILITY(U,$J,358.3,792,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,792,1,1,0)
 ;;=1^High Complex MDM or 60-74 mins
 ;;^UTILITY(U,$J,358.3,792,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,793,0)
 ;;=99211^^9^62^1
 ;;^UTILITY(U,$J,358.3,793,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,793,1,1,0)
 ;;=1^Brief (no MD seen)
 ;;^UTILITY(U,$J,358.3,793,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,794,0)
 ;;=99212^^9^62^2
 ;;^UTILITY(U,$J,358.3,794,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,794,1,1,0)
 ;;=1^SF MDM or 10-19 mins
 ;;^UTILITY(U,$J,358.3,794,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,795,0)
 ;;=99213^^9^62^3
 ;;^UTILITY(U,$J,358.3,795,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,795,1,1,0)
 ;;=1^Low Complex MDM or 20-29 mins
 ;;^UTILITY(U,$J,358.3,795,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,796,0)
 ;;=99214^^9^62^4
 ;;^UTILITY(U,$J,358.3,796,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,796,1,1,0)
 ;;=1^Mod Complex MDM or 30-39 mins
 ;;^UTILITY(U,$J,358.3,796,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,797,0)
 ;;=99215^^9^62^5
 ;;^UTILITY(U,$J,358.3,797,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,797,1,1,0)
 ;;=1^High Complex MDM or 40-54 mins
 ;;^UTILITY(U,$J,358.3,797,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,798,0)
 ;;=99241^^9^63^1
 ;;^UTILITY(U,$J,358.3,798,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,798,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,798,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,799,0)
 ;;=99242^^9^63^2
 ;;^UTILITY(U,$J,358.3,799,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,799,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,799,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,800,0)
 ;;=99243^^9^63^3
 ;;^UTILITY(U,$J,358.3,800,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,800,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,800,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,801,0)
 ;;=99244^^9^63^4
 ;;^UTILITY(U,$J,358.3,801,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,801,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,801,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,802,0)
 ;;=99245^^9^63^5
 ;;^UTILITY(U,$J,358.3,802,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,802,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,802,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,803,0)
 ;;=99487^^9^64^1
 ;;^UTILITY(U,$J,358.3,803,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,803,1,1,0)
 ;;=1^Complex Chr Care w/o Pt Visit
 ;;^UTILITY(U,$J,358.3,803,1,2,0)
 ;;=2^99487
 ;;^UTILITY(U,$J,358.3,804,0)
 ;;=99489^^9^64^2
 ;;^UTILITY(U,$J,358.3,804,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,804,1,1,0)
 ;;=1^Comp Chr Care,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,804,1,2,0)
 ;;=2^99489
 ;;^UTILITY(U,$J,358.3,805,0)
 ;;=D50.9^^10^65^34
 ;;^UTILITY(U,$J,358.3,805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,805,1,3,0)
 ;;=3^Iron deficiency anemia, unspecified
 ;;^UTILITY(U,$J,358.3,805,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,805,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,806,0)
 ;;=D51.0^^10^65^44
 ;;^UTILITY(U,$J,358.3,806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,806,1,3,0)
 ;;=3^Vitamin B12 defic anemia due to intrinsic factor deficiency
 ;;^UTILITY(U,$J,358.3,806,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,806,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,807,0)
 ;;=D53.8^^10^65^38
 ;;^UTILITY(U,$J,358.3,807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,807,1,3,0)
 ;;=3^Nutritional Anemias NEC
 ;;^UTILITY(U,$J,358.3,807,1,4,0)
 ;;=4^D53.8
 ;;^UTILITY(U,$J,358.3,807,2)
 ;;=^5002297
 ;;^UTILITY(U,$J,358.3,808,0)
 ;;=D52.0^^10^65^20
 ;;^UTILITY(U,$J,358.3,808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,808,1,3,0)
 ;;=3^Dietary folate deficiency anemia
 ;;^UTILITY(U,$J,358.3,808,1,4,0)
 ;;=4^D52.0
 ;;^UTILITY(U,$J,358.3,808,2)
 ;;=^5002290
 ;;^UTILITY(U,$J,358.3,809,0)
 ;;=D52.1^^10^65^22
 ;;^UTILITY(U,$J,358.3,809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,809,1,3,0)
 ;;=3^Drug-induced folate deficiency anemia
 ;;^UTILITY(U,$J,358.3,809,1,4,0)
 ;;=4^D52.1
 ;;^UTILITY(U,$J,358.3,809,2)
 ;;=^5002291
 ;;^UTILITY(U,$J,358.3,810,0)
 ;;=D52.8^^10^65^26
 ;;^UTILITY(U,$J,358.3,810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,810,1,3,0)
 ;;=3^Folate deficiency anemias NEC
 ;;^UTILITY(U,$J,358.3,810,1,4,0)
 ;;=4^D52.8
 ;;^UTILITY(U,$J,358.3,810,2)
 ;;=^5002292
 ;;^UTILITY(U,$J,358.3,811,0)
 ;;=D52.9^^10^65^25
 ;;^UTILITY(U,$J,358.3,811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,811,1,3,0)
 ;;=3^Folate deficiency anemia, unspecified
 ;;^UTILITY(U,$J,358.3,811,1,4,0)
 ;;=4^D52.9
 ;;^UTILITY(U,$J,358.3,811,2)
 ;;=^5002293
 ;;^UTILITY(U,$J,358.3,812,0)
 ;;=D53.1^^10^65^35
 ;;^UTILITY(U,$J,358.3,812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,812,1,3,0)
 ;;=3^Megaloblastic Anemias NEC
 ;;^UTILITY(U,$J,358.3,812,1,4,0)
 ;;=4^D53.1
 ;;^UTILITY(U,$J,358.3,812,2)
 ;;=^5002295
 ;;^UTILITY(U,$J,358.3,813,0)
 ;;=D53.0^^10^65^42
 ;;^UTILITY(U,$J,358.3,813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,813,1,3,0)
 ;;=3^Protein deficiency anemia
 ;;^UTILITY(U,$J,358.3,813,1,4,0)
 ;;=4^D53.0
 ;;^UTILITY(U,$J,358.3,813,2)
 ;;=^5002294
 ;;^UTILITY(U,$J,358.3,814,0)
 ;;=D53.9^^10^65^39
 ;;^UTILITY(U,$J,358.3,814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,814,1,3,0)
 ;;=3^Nutritional anemia, unspecified
 ;;^UTILITY(U,$J,358.3,814,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,814,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,815,0)
 ;;=D57.40^^10^65^43
 ;;^UTILITY(U,$J,358.3,815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,815,1,3,0)
 ;;=3^Sickle-cell thalassemia without crisis
 ;;^UTILITY(U,$J,358.3,815,1,4,0)
 ;;=4^D57.40
 ;;^UTILITY(U,$J,358.3,815,2)
 ;;=^329908
 ;;^UTILITY(U,$J,358.3,816,0)
 ;;=D58.0^^10^65^33
 ;;^UTILITY(U,$J,358.3,816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,816,1,3,0)
 ;;=3^Hereditary spherocytosis
 ;;^UTILITY(U,$J,358.3,816,1,4,0)
 ;;=4^D58.0
 ;;^UTILITY(U,$J,358.3,816,2)
 ;;=^5002321
 ;;^UTILITY(U,$J,358.3,817,0)
 ;;=D58.1^^10^65^30
 ;;^UTILITY(U,$J,358.3,817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,817,1,3,0)
 ;;=3^Hereditary elliptocytosis
 ;;^UTILITY(U,$J,358.3,817,1,4,0)
 ;;=4^D58.1
 ;;^UTILITY(U,$J,358.3,817,2)
 ;;=^39378
 ;;^UTILITY(U,$J,358.3,818,0)
 ;;=D55.0^^10^65^5
 ;;^UTILITY(U,$J,358.3,818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,818,1,3,0)
 ;;=3^Anemia due to glucose-6-phosphate dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,818,1,4,0)
 ;;=4^D55.0
 ;;^UTILITY(U,$J,358.3,818,2)
 ;;=^5002299
 ;;^UTILITY(U,$J,358.3,819,0)
 ;;=D55.1^^10^65^6
 ;;^UTILITY(U,$J,358.3,819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,819,1,3,0)
 ;;=3^Anemia due to other disorders of glutathione metabolism
 ;;^UTILITY(U,$J,358.3,819,1,4,0)
 ;;=4^D55.1
 ;;^UTILITY(U,$J,358.3,819,2)
 ;;=^5002300
 ;;^UTILITY(U,$J,358.3,820,0)
 ;;=D55.8^^10^65^12
 ;;^UTILITY(U,$J,358.3,820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,820,1,3,0)
 ;;=3^Anemias due to enzyme disorders
 ;;^UTILITY(U,$J,358.3,820,1,4,0)
 ;;=4^D55.8
 ;;^UTILITY(U,$J,358.3,820,2)
 ;;=^5002303
 ;;^UTILITY(U,$J,358.3,821,0)
 ;;=D58.9^^10^65^31
 ;;^UTILITY(U,$J,358.3,821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,821,1,3,0)
 ;;=3^Hereditary hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,821,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,821,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,822,0)
 ;;=D59.0^^10^65^21
 ;;^UTILITY(U,$J,358.3,822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,822,1,3,0)
 ;;=3^Drug-induced autoimmune hemolytic anemia
 ;;^UTILITY(U,$J,358.3,822,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,822,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,823,0)
 ;;=D59.3^^10^65^29
 ;;^UTILITY(U,$J,358.3,823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,823,1,3,0)
 ;;=3^Hemolytic-uremic syndrome
 ;;^UTILITY(U,$J,358.3,823,1,4,0)
 ;;=4^D59.3
 ;;^UTILITY(U,$J,358.3,823,2)
 ;;=^55823
 ;;^UTILITY(U,$J,358.3,824,0)
 ;;=D59.4^^10^65^37
 ;;^UTILITY(U,$J,358.3,824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,824,1,3,0)
 ;;=3^Nonautoimmune hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,824,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,824,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,825,0)
 ;;=D59.5^^10^65^41
 ;;^UTILITY(U,$J,358.3,825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,825,1,3,0)
 ;;=3^Paroxysmal nocturnal hemoglobinuria [Marchiafava-Micheli]
 ;;^UTILITY(U,$J,358.3,825,1,4,0)
 ;;=4^D59.5
 ;;^UTILITY(U,$J,358.3,825,2)
 ;;=^5002327
 ;;^UTILITY(U,$J,358.3,826,0)
 ;;=D59.6^^10^65^28
 ;;^UTILITY(U,$J,358.3,826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,826,1,3,0)
 ;;=3^Hemoglobinuria due to hemolysis from other external causes
 ;;^UTILITY(U,$J,358.3,826,1,4,0)
 ;;=4^D59.6
 ;;^UTILITY(U,$J,358.3,826,2)
 ;;=^5002328
 ;;^UTILITY(U,$J,358.3,827,0)
 ;;=D59.8^^10^65^2
 ;;^UTILITY(U,$J,358.3,827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,827,1,3,0)
 ;;=3^Acquired hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,827,1,4,0)
 ;;=4^D59.8
 ;;^UTILITY(U,$J,358.3,827,2)
 ;;=^5002329
 ;;^UTILITY(U,$J,358.3,828,0)
 ;;=D59.9^^10^65^1
 ;;^UTILITY(U,$J,358.3,828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,828,1,3,0)
 ;;=3^Acquired hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,828,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,828,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,829,0)
 ;;=D61.810^^10^65^13
 ;;^UTILITY(U,$J,358.3,829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,829,1,3,0)
 ;;=3^Antineoplastic chemotherapy induced pancytopenia
 ;;^UTILITY(U,$J,358.3,829,1,4,0)
 ;;=4^D61.810
 ;;^UTILITY(U,$J,358.3,829,2)
 ;;=^5002339
 ;;^UTILITY(U,$J,358.3,830,0)
 ;;=D61.811^^10^65^24
 ;;^UTILITY(U,$J,358.3,830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,830,1,3,0)
 ;;=3^Drug-induced pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,830,1,4,0)
 ;;=4^D61.811
 ;;^UTILITY(U,$J,358.3,830,2)
 ;;=^5002340
 ;;^UTILITY(U,$J,358.3,831,0)
 ;;=D61.818^^10^65^40
 ;;^UTILITY(U,$J,358.3,831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,831,1,3,0)
 ;;=3^Pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,831,1,4,0)
 ;;=4^D61.818
 ;;^UTILITY(U,$J,358.3,831,2)
 ;;=^340501
 ;;^UTILITY(U,$J,358.3,832,0)
 ;;=D61.82^^10^65^36
 ;;^UTILITY(U,$J,358.3,832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,832,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,832,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,832,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,833,0)
 ;;=D61.9^^10^65^14
 ;;^UTILITY(U,$J,358.3,833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,833,1,3,0)
 ;;=3^Aplastic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,833,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,833,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,834,0)
 ;;=D62.^^10^65^3
 ;;^UTILITY(U,$J,358.3,834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,834,1,3,0)
 ;;=3^Acute posthemorrhagic anemia
 ;;^UTILITY(U,$J,358.3,834,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,834,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,835,0)
 ;;=D63.1^^10^65^7
 ;;^UTILITY(U,$J,358.3,835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,835,1,3,0)
 ;;=3^Anemia in chronic kidney disease
 ;;^UTILITY(U,$J,358.3,835,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,835,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,836,0)
 ;;=D63.0^^10^65^8
 ;;^UTILITY(U,$J,358.3,836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,836,1,3,0)
 ;;=3^Anemia in neoplastic disease
 ;;^UTILITY(U,$J,358.3,836,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,836,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,837,0)
 ;;=D63.8^^10^65^9
 ;;^UTILITY(U,$J,358.3,837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,837,1,3,0)
 ;;=3^Anemia in other chronic diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,837,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,837,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,838,0)
 ;;=D64.81^^10^65^4
 ;;^UTILITY(U,$J,358.3,838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,838,1,3,0)
 ;;=3^Anemia due to antineoplastic chemotherapy
 ;;^UTILITY(U,$J,358.3,838,1,4,0)
 ;;=4^D64.81
 ;;^UTILITY(U,$J,358.3,838,2)
 ;;=^5002349
 ;;^UTILITY(U,$J,358.3,839,0)
 ;;=D64.89^^10^65^11
 ;;^UTILITY(U,$J,358.3,839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,839,1,3,0)
 ;;=3^Anemias NEC
 ;;^UTILITY(U,$J,358.3,839,1,4,0)
 ;;=4^D64.89
 ;;^UTILITY(U,$J,358.3,839,2)
 ;;=^5002350
 ;;^UTILITY(U,$J,358.3,840,0)
 ;;=D64.9^^10^65^10
 ;;^UTILITY(U,$J,358.3,840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,840,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,840,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,840,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,841,0)
 ;;=D58.2^^10^65^27
 ;;^UTILITY(U,$J,358.3,841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,841,1,3,0)
 ;;=3^Hemoglobinopathies NEC
 ;;^UTILITY(U,$J,358.3,841,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,841,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,842,0)
 ;;=D58.8^^10^65^32
 ;;^UTILITY(U,$J,358.3,842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,842,1,3,0)
 ;;=3^Hereditary hemolytic anemias,oth specified
 ;;^UTILITY(U,$J,358.3,842,1,4,0)
 ;;=4^D58.8
 ;;^UTILITY(U,$J,358.3,842,2)
 ;;=^267984
 ;;^UTILITY(U,$J,358.3,843,0)
 ;;=D59.2^^10^65^23
 ;;^UTILITY(U,$J,358.3,843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,843,1,3,0)
 ;;=3^Drug-induced nonautoimmune hemolytic anemia
 ;;^UTILITY(U,$J,358.3,843,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,843,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,844,0)
 ;;=D59.10^^10^65^18
 ;;^UTILITY(U,$J,358.3,844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,844,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,844,1,4,0)
 ;;=4^D59.10
 ;;^UTILITY(U,$J,358.3,844,2)
 ;;=^5159101
 ;;^UTILITY(U,$J,358.3,845,0)
 ;;=D59.11^^10^65^19
 ;;^UTILITY(U,$J,358.3,845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,845,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Warm
 ;;^UTILITY(U,$J,358.3,845,1,4,0)
 ;;=4^D59.11
 ;;^UTILITY(U,$J,358.3,845,2)
 ;;=^5159102
 ;;^UTILITY(U,$J,358.3,846,0)
 ;;=D59.12^^10^65^15
 ;;^UTILITY(U,$J,358.3,846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,846,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Cold
 ;;^UTILITY(U,$J,358.3,846,1,4,0)
 ;;=4^D59.12
 ;;^UTILITY(U,$J,358.3,846,2)
 ;;=^5159103
 ;;^UTILITY(U,$J,358.3,847,0)
 ;;=D59.13^^10^65^16
 ;;^UTILITY(U,$J,358.3,847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,847,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Mixed Type
 ;;^UTILITY(U,$J,358.3,847,1,4,0)
 ;;=4^D59.13
 ;;^UTILITY(U,$J,358.3,847,2)
 ;;=^5159104
 ;;^UTILITY(U,$J,358.3,848,0)
 ;;=D59.19^^10^65^17
 ;;^UTILITY(U,$J,358.3,848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,848,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Other
 ;;^UTILITY(U,$J,358.3,848,1,4,0)
 ;;=4^D59.19
 ;;^UTILITY(U,$J,358.3,848,2)
 ;;=^5159105
 ;;^UTILITY(U,$J,358.3,849,0)
 ;;=Z93.0^^10^66^9
 ;;^UTILITY(U,$J,358.3,849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,849,1,3,0)
 ;;=3^Tracheostomy status
 ;;^UTILITY(U,$J,358.3,849,1,4,0)
 ;;=4^Z93.0
 ;;^UTILITY(U,$J,358.3,849,2)
 ;;=^5063642
 ;;^UTILITY(U,$J,358.3,850,0)
 ;;=Z93.1^^10^66^7
 ;;^UTILITY(U,$J,358.3,850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,850,1,3,0)
 ;;=3^Gastrostomy status
 ;;^UTILITY(U,$J,358.3,850,1,4,0)
 ;;=4^Z93.1
 ;;^UTILITY(U,$J,358.3,850,2)
 ;;=^5063643
 ;;^UTILITY(U,$J,358.3,851,0)
 ;;=Z93.2^^10^66^8
 ;;^UTILITY(U,$J,358.3,851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,851,1,3,0)
 ;;=3^Ileostomy status
 ;;^UTILITY(U,$J,358.3,851,1,4,0)
 ;;=4^Z93.2
 ;;^UTILITY(U,$J,358.3,851,2)
 ;;=^5063644
 ;;^UTILITY(U,$J,358.3,852,0)
 ;;=Z93.3^^10^66^5
 ;;^UTILITY(U,$J,358.3,852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,852,1,3,0)
 ;;=3^Colostomy status
 ;;^UTILITY(U,$J,358.3,852,1,4,0)
 ;;=4^Z93.3
 ;;^UTILITY(U,$J,358.3,852,2)
 ;;=^5063645
 ;;^UTILITY(U,$J,358.3,853,0)
 ;;=Z93.4^^10^66^3
 ;;^UTILITY(U,$J,358.3,853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,853,1,3,0)
 ;;=3^Artificial openings of gastrointestinal tract status NEC
 ;;^UTILITY(U,$J,358.3,853,1,4,0)
 ;;=4^Z93.4
 ;;^UTILITY(U,$J,358.3,853,2)
 ;;=^5063646
 ;;^UTILITY(U,$J,358.3,854,0)
 ;;=Z93.50^^10^66^6
 ;;^UTILITY(U,$J,358.3,854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,854,1,3,0)
 ;;=3^Cystostomy Status,Unspec
 ;;^UTILITY(U,$J,358.3,854,1,4,0)
 ;;=4^Z93.50
 ;;^UTILITY(U,$J,358.3,854,2)
 ;;=^5063647
 ;;^UTILITY(U,$J,358.3,855,0)
 ;;=Z93.6^^10^66^4
 ;;^UTILITY(U,$J,358.3,855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,855,1,3,0)
 ;;=3^Artificial openings of urinary tract status NEC
 ;;^UTILITY(U,$J,358.3,855,1,4,0)
 ;;=4^Z93.6
 ;;^UTILITY(U,$J,358.3,855,2)
 ;;=^5063651
 ;;^UTILITY(U,$J,358.3,856,0)
 ;;=Z93.8^^10^66^1
 ;;^UTILITY(U,$J,358.3,856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,856,1,3,0)
 ;;=3^Artificial opening status NEC
 ;;^UTILITY(U,$J,358.3,856,1,4,0)
 ;;=4^Z93.8
 ;;^UTILITY(U,$J,358.3,856,2)
 ;;=^5063652
 ;;^UTILITY(U,$J,358.3,857,0)
 ;;=Z93.9^^10^66^2
 ;;^UTILITY(U,$J,358.3,857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,857,1,3,0)
 ;;=3^Artificial opening status, unspecified
 ;;^UTILITY(U,$J,358.3,857,1,4,0)
 ;;=4^Z93.9
 ;;^UTILITY(U,$J,358.3,857,2)
 ;;=^5063653
 ;;^UTILITY(U,$J,358.3,858,0)
 ;;=C50.912^^10^67^5
 ;;^UTILITY(U,$J,358.3,858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,858,1,3,0)
 ;;=3^Malignant neoplasm of left female breast,unsp site
 ;;^UTILITY(U,$J,358.3,858,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,858,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,859,0)
 ;;=C50.911^^10^67^9
 ;;^UTILITY(U,$J,358.3,859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,859,1,3,0)
 ;;=3^Malignant neoplasm of right female breast,unsp site
 ;;^UTILITY(U,$J,358.3,859,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,859,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,860,0)
 ;;=C55.^^10^67^11
 ;;^UTILITY(U,$J,358.3,860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,860,1,3,0)
 ;;=3^Malignant neoplasm of uterus, part unspecified
 ;;^UTILITY(U,$J,358.3,860,1,4,0)
 ;;=4^C55.
 ;;^UTILITY(U,$J,358.3,860,2)
 ;;=^5001211
 ;;^UTILITY(U,$J,358.3,861,0)
 ;;=C53.9^^10^67^1
 ;;^UTILITY(U,$J,358.3,861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,861,1,3,0)
 ;;=3^Malignant neoplasm of cervix uteri, unspecified
 ;;^UTILITY(U,$J,358.3,861,1,4,0)
 ;;=4^C53.9
 ;;^UTILITY(U,$J,358.3,861,2)
 ;;=^5001204
 ;;^UTILITY(U,$J,358.3,862,0)
 ;;=C56.1^^10^67^10
 ;;^UTILITY(U,$J,358.3,862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,862,1,3,0)
 ;;=3^Malignant neoplasm of right ovary
 ;;^UTILITY(U,$J,358.3,862,1,4,0)
 ;;=4^C56.1
 ;;^UTILITY(U,$J,358.3,862,2)
 ;;=^5001212
 ;;^UTILITY(U,$J,358.3,863,0)
 ;;=C56.2^^10^67^6
 ;;^UTILITY(U,$J,358.3,863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,863,1,3,0)
 ;;=3^Malignant neoplasm of left ovary
 ;;^UTILITY(U,$J,358.3,863,1,4,0)
 ;;=4^C56.2
 ;;^UTILITY(U,$J,358.3,863,2)
 ;;=^5001213
 ;;^UTILITY(U,$J,358.3,864,0)
 ;;=C57.01^^10^67^8
 ;;^UTILITY(U,$J,358.3,864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,864,1,3,0)
 ;;=3^Malignant neoplasm of right fallopian tube
