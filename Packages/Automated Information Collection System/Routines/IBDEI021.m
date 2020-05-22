IBDEI021 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4535,1,3,0)
 ;;=3^Burkitt lymphoma, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,4535,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,4535,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,4536,0)
 ;;=C81.90^^34^294^40
 ;;^UTILITY(U,$J,358.3,4536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4536,1,3,0)
 ;;=3^Hodgkin lymphoma, unspecified, unspecified site
 ;;^UTILITY(U,$J,358.3,4536,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,4536,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,4537,0)
 ;;=C81.99^^34^294^39
 ;;^UTILITY(U,$J,358.3,4537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4537,1,3,0)
 ;;=3^Hodgkin lymphoma, unsp, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,4537,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,4537,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,4538,0)
 ;;=C82.90^^34^294^33
 ;;^UTILITY(U,$J,358.3,4538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4538,1,3,0)
 ;;=3^Follicular lymphoma, unspecified, unspecified site
 ;;^UTILITY(U,$J,358.3,4538,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,4538,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,4539,0)
 ;;=C82.99^^34^294^32
 ;;^UTILITY(U,$J,358.3,4539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4539,1,3,0)
 ;;=3^Follicular lymphoma, unsp, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,4539,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,4539,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,4540,0)
 ;;=C91.40^^34^294^34
 ;;^UTILITY(U,$J,358.3,4540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4540,1,3,0)
 ;;=3^Hairy cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,4540,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,4540,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,4541,0)
 ;;=C90.00^^34^294^88
 ;;^UTILITY(U,$J,358.3,4541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4541,1,3,0)
 ;;=3^Multiple myeloma not having achieved remission
 ;;^UTILITY(U,$J,358.3,4541,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,4541,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,4542,0)
 ;;=C90.01^^34^294^87
 ;;^UTILITY(U,$J,358.3,4542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4542,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,4542,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,4542,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,4543,0)
 ;;=C91.00^^34^294^3
 ;;^UTILITY(U,$J,358.3,4543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4543,1,3,0)
 ;;=3^Acute lymphoblastic leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,4543,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,4543,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,4544,0)
 ;;=C91.01^^34^294^4
 ;;^UTILITY(U,$J,358.3,4544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4544,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,4544,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,4544,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,4545,0)
 ;;=C91.10^^34^294^23
 ;;^UTILITY(U,$J,358.3,4545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4545,1,3,0)
 ;;=3^Chronic lymphocytic leuk of B-cell type not achieve remis
 ;;^UTILITY(U,$J,358.3,4545,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,4545,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,4546,0)
 ;;=C91.11^^34^294^24
 ;;^UTILITY(U,$J,358.3,4546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4546,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in remission
 ;;^UTILITY(U,$J,358.3,4546,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,4546,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,4547,0)
 ;;=C92.00^^34^294^6
 ;;^UTILITY(U,$J,358.3,4547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4547,1,3,0)
 ;;=3^Acute myeloblastic leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,4547,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,4547,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,4548,0)
 ;;=C92.01^^34^294^5
 ;;^UTILITY(U,$J,358.3,4548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4548,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,4548,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,4548,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,4549,0)
 ;;=C92.10^^34^294^25
 ;;^UTILITY(U,$J,358.3,4549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4549,1,3,0)
 ;;=3^Chronic myeloid leuk, BCR/ABL-positive, not achieve remis
 ;;^UTILITY(U,$J,358.3,4549,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,4549,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,4550,0)
 ;;=C92.11^^34^294^26
 ;;^UTILITY(U,$J,358.3,4550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4550,1,3,0)
 ;;=3^Chronic myeloid leukemia, BCR/ABL-positive, in remission
 ;;^UTILITY(U,$J,358.3,4550,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,4550,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,4551,0)
 ;;=D04.9^^34^294^21
 ;;^UTILITY(U,$J,358.3,4551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4551,1,3,0)
 ;;=3^Carcinoma in situ of skin, unspecified
 ;;^UTILITY(U,$J,358.3,4551,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,4551,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,4552,0)
 ;;=D06.9^^34^294^20
 ;;^UTILITY(U,$J,358.3,4552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4552,1,3,0)
 ;;=3^Carcinoma in situ of cervix, unspecified
 ;;^UTILITY(U,$J,358.3,4552,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,4552,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,4553,0)
 ;;=D09.0^^34^294^19
 ;;^UTILITY(U,$J,358.3,4553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4553,1,3,0)
 ;;=3^Carcinoma in situ of bladder
 ;;^UTILITY(U,$J,358.3,4553,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,4553,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,4554,0)
 ;;=D45.^^34^294^93
 ;;^UTILITY(U,$J,358.3,4554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4554,1,3,0)
 ;;=3^Polycythemia vera
 ;;^UTILITY(U,$J,358.3,4554,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,4554,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,4555,0)
 ;;=C94.40^^34^294^7
 ;;^UTILITY(U,$J,358.3,4555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4555,1,3,0)
 ;;=3^Acute panmyelosis w myelofibrosis not achieve remission
 ;;^UTILITY(U,$J,358.3,4555,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,4555,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,4556,0)
 ;;=C94.41^^34^294^8
 ;;^UTILITY(U,$J,358.3,4556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4556,1,3,0)
 ;;=3^Acute panmyelosis w myelofibrosis, in remission
 ;;^UTILITY(U,$J,358.3,4556,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,4556,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,4557,0)
 ;;=C94.42^^34^294^9
 ;;^UTILITY(U,$J,358.3,4557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4557,1,3,0)
 ;;=3^Acute panmyelosis w myelofibrosis, in relapse
 ;;^UTILITY(U,$J,358.3,4557,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,4557,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,4558,0)
 ;;=D47.1^^34^294^27
 ;;^UTILITY(U,$J,358.3,4558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4558,1,3,0)
 ;;=3^Chronic myeloproliferative disease
 ;;^UTILITY(U,$J,358.3,4558,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,4558,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,4559,0)
 ;;=D47.9^^34^294^90
 ;;^UTILITY(U,$J,358.3,4559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4559,1,3,0)
 ;;=3^Neoplm of uncrt behav of lymphoid,hematpoetc & rel tiss,unsp
 ;;^UTILITY(U,$J,358.3,4559,1,4,0)
 ;;=4^D47.9
 ;;^UTILITY(U,$J,358.3,4559,2)
 ;;=^5002260
 ;;^UTILITY(U,$J,358.3,4560,0)
 ;;=C88.0^^34^294^134
 ;;^UTILITY(U,$J,358.3,4560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4560,1,3,0)
 ;;=3^Waldenstrom macroglobulinemia
 ;;^UTILITY(U,$J,358.3,4560,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,4560,2)
 ;;=^5001748
 ;;^UTILITY(U,$J,358.3,4561,0)
 ;;=D50.0^^34^294^41
 ;;^UTILITY(U,$J,358.3,4561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4561,1,3,0)
 ;;=3^Iron deficiency anemia secondary to blood loss (chronic)
 ;;^UTILITY(U,$J,358.3,4561,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,4561,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,4562,0)
 ;;=D50.9^^34^294^42
 ;;^UTILITY(U,$J,358.3,4562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4562,1,3,0)
 ;;=3^Iron deficiency anemia, unspecified
 ;;^UTILITY(U,$J,358.3,4562,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,4562,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,4563,0)
 ;;=D51.0^^34^294^131
 ;;^UTILITY(U,$J,358.3,4563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4563,1,3,0)
 ;;=3^Vit B12 defic anemia d/t intrinsic factor deficiency
 ;;^UTILITY(U,$J,358.3,4563,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,4563,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,4564,0)
 ;;=D51.1^^34^294^132
 ;;^UTILITY(U,$J,358.3,4564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4564,1,3,0)
 ;;=3^Vit B12 defic anemia d/t slctv vit B12 malabsorp w protein
 ;;^UTILITY(U,$J,358.3,4564,1,4,0)
 ;;=4^D51.1
 ;;^UTILITY(U,$J,358.3,4564,2)
 ;;=^5002285
 ;;^UTILITY(U,$J,358.3,4565,0)
 ;;=D53.9^^34^294^91
 ;;^UTILITY(U,$J,358.3,4565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4565,1,3,0)
 ;;=3^Nutritional anemia, unspecified
 ;;^UTILITY(U,$J,358.3,4565,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,4565,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,4566,0)
 ;;=D57.1^^34^294^128
 ;;^UTILITY(U,$J,358.3,4566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4566,1,3,0)
 ;;=3^Sickle-cell disease without crisis
 ;;^UTILITY(U,$J,358.3,4566,1,4,0)
 ;;=4^D57.1
 ;;^UTILITY(U,$J,358.3,4566,2)
 ;;=^5002309
 ;;^UTILITY(U,$J,358.3,4567,0)
 ;;=D57.00^^34^294^35
 ;;^UTILITY(U,$J,358.3,4567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4567,1,3,0)
 ;;=3^Hb-SS disease with crisis, unspecified
 ;;^UTILITY(U,$J,358.3,4567,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,4567,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,4568,0)
 ;;=D58.9^^34^294^38
 ;;^UTILITY(U,$J,358.3,4568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4568,1,3,0)
 ;;=3^Hereditary hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,4568,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,4568,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,4569,0)
 ;;=D59.0^^34^294^29
 ;;^UTILITY(U,$J,358.3,4569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4569,1,3,0)
 ;;=3^Drug-induced autoimmune hemolytic anemia
 ;;^UTILITY(U,$J,358.3,4569,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,4569,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,4570,0)
 ;;=D59.9^^34^294^2
 ;;^UTILITY(U,$J,358.3,4570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4570,1,3,0)
 ;;=3^Acquired hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,4570,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,4570,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,4571,0)
 ;;=D61.82^^34^294^89
 ;;^UTILITY(U,$J,358.3,4571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4571,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,4571,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,4571,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,4572,0)
 ;;=D61.9^^34^294^16
 ;;^UTILITY(U,$J,358.3,4572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4572,1,3,0)
 ;;=3^Aplastic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,4572,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,4572,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,4573,0)
 ;;=D62.^^34^294^10
 ;;^UTILITY(U,$J,358.3,4573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4573,1,3,0)
 ;;=3^Acute posthemorrhagic anemia
 ;;^UTILITY(U,$J,358.3,4573,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,4573,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,4574,0)
 ;;=D63.1^^34^294^11
 ;;^UTILITY(U,$J,358.3,4574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4574,1,3,0)
 ;;=3^Anemia in chronic kidney disease
 ;;^UTILITY(U,$J,358.3,4574,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,4574,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,4575,0)
 ;;=D63.0^^34^294^12
 ;;^UTILITY(U,$J,358.3,4575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4575,1,3,0)
 ;;=3^Anemia in neoplastic disease
 ;;^UTILITY(U,$J,358.3,4575,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,4575,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,4576,0)
 ;;=D63.8^^34^294^13
 ;;^UTILITY(U,$J,358.3,4576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4576,1,3,0)
 ;;=3^Anemia in other chronic diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,4576,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,4576,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,4577,0)
 ;;=D64.9^^34^294^14
 ;;^UTILITY(U,$J,358.3,4577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4577,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,4577,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,4577,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,4578,0)
 ;;=D68.0^^34^294^133
 ;;^UTILITY(U,$J,358.3,4578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4578,1,3,0)
 ;;=3^Von Willebrand's disease
 ;;^UTILITY(U,$J,358.3,4578,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,4578,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,4579,0)
 ;;=D68.4^^34^294^1
 ;;^UTILITY(U,$J,358.3,4579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4579,1,3,0)
 ;;=3^Acquired coagulation factor deficiency
 ;;^UTILITY(U,$J,358.3,4579,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,4579,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,4580,0)
 ;;=D68.32^^34^294^36
 ;;^UTILITY(U,$J,358.3,4580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4580,1,3,0)
 ;;=3^Hemorrhagic disord d/t extrinsic circulating anticoagulants
 ;;^UTILITY(U,$J,358.3,4580,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,4580,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,4581,0)
 ;;=D68.9^^34^294^28
 ;;^UTILITY(U,$J,358.3,4581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4581,1,3,0)
 ;;=3^Coagulation defect, unspecified
 ;;^UTILITY(U,$J,358.3,4581,1,4,0)
 ;;=4^D68.9
 ;;^UTILITY(U,$J,358.3,4581,2)
 ;;=^5002364
 ;;^UTILITY(U,$J,358.3,4582,0)
 ;;=D47.3^^34^294^31
 ;;^UTILITY(U,$J,358.3,4582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4582,1,3,0)
 ;;=3^Essential (hemorrhagic) thrombocythemia
 ;;^UTILITY(U,$J,358.3,4582,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,4582,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,4583,0)
 ;;=D69.6^^34^294^129
 ;;^UTILITY(U,$J,358.3,4583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4583,1,3,0)
 ;;=3^Thrombocytopenia, unspecified
 ;;^UTILITY(U,$J,358.3,4583,1,4,0)
 ;;=4^D69.6
 ;;^UTILITY(U,$J,358.3,4583,2)
 ;;=^5002370
 ;;^UTILITY(U,$J,358.3,4584,0)
 ;;=D75.1^^34^294^127
 ;;^UTILITY(U,$J,358.3,4584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4584,1,3,0)
 ;;=3^Secondary polycythemia
 ;;^UTILITY(U,$J,358.3,4584,1,4,0)
 ;;=4^D75.1
 ;;^UTILITY(U,$J,358.3,4584,2)
 ;;=^186856
 ;;^UTILITY(U,$J,358.3,4585,0)
 ;;=M31.1^^34^294^130
 ;;^UTILITY(U,$J,358.3,4585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4585,1,3,0)
 ;;=3^Thrombotic microangiopathy
 ;;^UTILITY(U,$J,358.3,4585,1,4,0)
 ;;=4^M31.1
 ;;^UTILITY(U,$J,358.3,4585,2)
 ;;=^119061
 ;;^UTILITY(U,$J,358.3,4586,0)
 ;;=I80.9^^34^294^92
 ;;^UTILITY(U,$J,358.3,4586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4586,1,3,0)
 ;;=3^Phlebitis and thrombophlebitis of unspecified site
 ;;^UTILITY(U,$J,358.3,4586,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,4586,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,4587,0)
 ;;=R59.9^^34^294^30
 ;;^UTILITY(U,$J,358.3,4587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4587,1,3,0)
 ;;=3^Enlarged lymph nodes, unspecified
 ;;^UTILITY(U,$J,358.3,4587,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,4587,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,4588,0)
 ;;=Z85.819^^34^294^112
 ;;^UTILITY(U,$J,358.3,4588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4588,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of unsp site lip,oral cav,& pharynx
 ;;^UTILITY(U,$J,358.3,4588,1,4,0)
 ;;=4^Z85.819
 ;;^UTILITY(U,$J,358.3,4588,2)
 ;;=^5063440
 ;;^UTILITY(U,$J,358.3,4589,0)
 ;;=Z85.818^^34^294^108
 ;;^UTILITY(U,$J,358.3,4589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4589,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of site of lip, oral cav, & pharynx
 ;;^UTILITY(U,$J,358.3,4589,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,4589,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,4590,0)
 ;;=Z85.01^^34^294^100
 ;;^UTILITY(U,$J,358.3,4590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4590,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of esophagus
 ;;^UTILITY(U,$J,358.3,4590,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,4590,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,4591,0)
 ;;=Z85.028^^34^294^110
 ;;^UTILITY(U,$J,358.3,4591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4591,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of stomach
 ;;^UTILITY(U,$J,358.3,4591,1,4,0)
 ;;=4^Z85.028
 ;;^UTILITY(U,$J,358.3,4591,2)
 ;;=^5063397
 ;;^UTILITY(U,$J,358.3,4592,0)
 ;;=Z85.038^^34^294^102
 ;;^UTILITY(U,$J,358.3,4592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4592,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of large intestine
 ;;^UTILITY(U,$J,358.3,4592,1,4,0)
 ;;=4^Z85.038
 ;;^UTILITY(U,$J,358.3,4592,2)
 ;;=^5063399
 ;;^UTILITY(U,$J,358.3,4593,0)
 ;;=Z85.048^^34^294^107
 ;;^UTILITY(U,$J,358.3,4593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4593,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of rectum, rectosig junct, and anus
 ;;^UTILITY(U,$J,358.3,4593,1,4,0)
 ;;=4^Z85.048
 ;;^UTILITY(U,$J,358.3,4593,2)
 ;;=^5063401
 ;;^UTILITY(U,$J,358.3,4594,0)
 ;;=Z85.118^^34^294^98
 ;;^UTILITY(U,$J,358.3,4594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4594,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of bronchus/lung
 ;;^UTILITY(U,$J,358.3,4594,1,4,0)
 ;;=4^Z85.118
 ;;^UTILITY(U,$J,358.3,4594,2)
 ;;=^5063408
 ;;^UTILITY(U,$J,358.3,4595,0)
 ;;=Z85.21^^34^294^103
 ;;^UTILITY(U,$J,358.3,4595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4595,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of larynx
 ;;^UTILITY(U,$J,358.3,4595,1,4,0)
 ;;=4^Z85.21
 ;;^UTILITY(U,$J,358.3,4595,2)
 ;;=^5063411
 ;;^UTILITY(U,$J,358.3,4596,0)
 ;;=Z85.3^^34^294^97
 ;;^UTILITY(U,$J,358.3,4596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4596,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of breast
 ;;^UTILITY(U,$J,358.3,4596,1,4,0)
 ;;=4^Z85.3
 ;;^UTILITY(U,$J,358.3,4596,2)
 ;;=^5063416
 ;;^UTILITY(U,$J,358.3,4597,0)
 ;;=Z85.41^^34^294^99
 ;;^UTILITY(U,$J,358.3,4597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4597,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of cervix uteri
 ;;^UTILITY(U,$J,358.3,4597,1,4,0)
 ;;=4^Z85.41
 ;;^UTILITY(U,$J,358.3,4597,2)
 ;;=^5063418
 ;;^UTILITY(U,$J,358.3,4598,0)
 ;;=Z85.43^^34^294^105
 ;;^UTILITY(U,$J,358.3,4598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4598,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of ovary
 ;;^UTILITY(U,$J,358.3,4598,1,4,0)
 ;;=4^Z85.43
 ;;^UTILITY(U,$J,358.3,4598,2)
 ;;=^5063420
 ;;^UTILITY(U,$J,358.3,4599,0)
 ;;=Z85.46^^34^294^106
 ;;^UTILITY(U,$J,358.3,4599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4599,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of prostate
 ;;^UTILITY(U,$J,358.3,4599,1,4,0)
 ;;=4^Z85.46
 ;;^UTILITY(U,$J,358.3,4599,2)
 ;;=^5063423
 ;;^UTILITY(U,$J,358.3,4600,0)
 ;;=Z85.47^^34^294^111
 ;;^UTILITY(U,$J,358.3,4600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4600,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of testis
 ;;^UTILITY(U,$J,358.3,4600,1,4,0)
 ;;=4^Z85.47
 ;;^UTILITY(U,$J,358.3,4600,2)
 ;;=^5063424
 ;;^UTILITY(U,$J,358.3,4601,0)
 ;;=Z85.51^^34^294^96
 ;;^UTILITY(U,$J,358.3,4601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4601,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of bladder
 ;;^UTILITY(U,$J,358.3,4601,1,4,0)
 ;;=4^Z85.51
 ;;^UTILITY(U,$J,358.3,4601,2)
 ;;=^5063428
 ;;^UTILITY(U,$J,358.3,4602,0)
 ;;=Z85.528^^34^294^101
 ;;^UTILITY(U,$J,358.3,4602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4602,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of kidney
 ;;^UTILITY(U,$J,358.3,4602,1,4,0)
 ;;=4^Z85.528
 ;;^UTILITY(U,$J,358.3,4602,2)
 ;;=^5063430
