IBDEI03U ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4672,1,3,0)
 ;;=3^Hodgkin Lymphoma,Head/Face/Neck Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,4672,1,4,0)
 ;;=4^C81.91
 ;;^UTILITY(U,$J,358.3,4672,2)
 ;;=^5001452
 ;;^UTILITY(U,$J,358.3,4673,0)
 ;;=C81.92^^22^216^228
 ;;^UTILITY(U,$J,358.3,4673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4673,1,3,0)
 ;;=3^Hodgkin Lymphoma,Intrathoracic Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,4673,1,4,0)
 ;;=4^C81.92
 ;;^UTILITY(U,$J,358.3,4673,2)
 ;;=^5001453
 ;;^UTILITY(U,$J,358.3,4674,0)
 ;;=C81.93^^22^216^224
 ;;^UTILITY(U,$J,358.3,4674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4674,1,3,0)
 ;;=3^Hodgkin Lymphoma,Intra-Abdominal Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,4674,1,4,0)
 ;;=4^C81.93
 ;;^UTILITY(U,$J,358.3,4674,2)
 ;;=^5001454
 ;;^UTILITY(U,$J,358.3,4675,0)
 ;;=C81.94^^22^216^216
 ;;^UTILITY(U,$J,358.3,4675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4675,1,3,0)
 ;;=3^Hodgkin Lymphoma,Axilla/Upper Limb Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,4675,1,4,0)
 ;;=4^C81.94
 ;;^UTILITY(U,$J,358.3,4675,2)
 ;;=^5001455
 ;;^UTILITY(U,$J,358.3,4676,0)
 ;;=C81.95^^22^216^222
 ;;^UTILITY(U,$J,358.3,4676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4676,1,3,0)
 ;;=3^Hodgkin Lymphoma,Ing Region/Lower Limb Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,4676,1,4,0)
 ;;=4^C81.95
 ;;^UTILITY(U,$J,358.3,4676,2)
 ;;=^5001456
 ;;^UTILITY(U,$J,358.3,4677,0)
 ;;=C81.96^^22^216^226
 ;;^UTILITY(U,$J,358.3,4677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4677,1,3,0)
 ;;=3^Hodgkin Lymphoma,Intrapelvic Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,4677,1,4,0)
 ;;=4^C81.96
 ;;^UTILITY(U,$J,358.3,4677,2)
 ;;=^5001457
 ;;^UTILITY(U,$J,358.3,4678,0)
 ;;=C81.97^^22^216^232
 ;;^UTILITY(U,$J,358.3,4678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4678,1,3,0)
 ;;=3^Hodgkin Lymphoma,Spleen,Unspec
 ;;^UTILITY(U,$J,358.3,4678,1,4,0)
 ;;=4^C81.97
 ;;^UTILITY(U,$J,358.3,4678,2)
 ;;=^5001458
 ;;^UTILITY(U,$J,358.3,4679,0)
 ;;=C81.98^^22^216^230
 ;;^UTILITY(U,$J,358.3,4679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4679,1,3,0)
 ;;=3^Hodgkin Lymphoma,Mult Site Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,4679,1,4,0)
 ;;=4^C81.98
 ;;^UTILITY(U,$J,358.3,4679,2)
 ;;=^5001459
 ;;^UTILITY(U,$J,358.3,4680,0)
 ;;=C81.99^^22^216^218
 ;;^UTILITY(U,$J,358.3,4680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4680,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extranodal/Solid Organ Sites,Unspec
 ;;^UTILITY(U,$J,358.3,4680,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,4680,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,4681,0)
 ;;=C82.00^^22^216^149
 ;;^UTILITY(U,$J,358.3,4681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4681,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,4681,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,4681,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,4682,0)
 ;;=C82.01^^22^216^142
 ;;^UTILITY(U,$J,358.3,4682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4682,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4682,1,4,0)
 ;;=4^C82.01
 ;;^UTILITY(U,$J,358.3,4682,2)
 ;;=^5001462
 ;;^UTILITY(U,$J,358.3,4683,0)
 ;;=C82.02^^22^216^146
 ;;^UTILITY(U,$J,358.3,4683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4683,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4683,1,4,0)
 ;;=4^C82.02
 ;;^UTILITY(U,$J,358.3,4683,2)
 ;;=^5001463
 ;;^UTILITY(U,$J,358.3,4684,0)
 ;;=C82.03^^22^216^144
 ;;^UTILITY(U,$J,358.3,4684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4684,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4684,1,4,0)
 ;;=4^C82.03
 ;;^UTILITY(U,$J,358.3,4684,2)
 ;;=^5001464
 ;;^UTILITY(U,$J,358.3,4685,0)
 ;;=C82.04^^22^216^140
 ;;^UTILITY(U,$J,358.3,4685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4685,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4685,1,4,0)
 ;;=4^C82.04
 ;;^UTILITY(U,$J,358.3,4685,2)
 ;;=^5001465
 ;;^UTILITY(U,$J,358.3,4686,0)
 ;;=C82.05^^22^216^143
 ;;^UTILITY(U,$J,358.3,4686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4686,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4686,1,4,0)
 ;;=4^C82.05
 ;;^UTILITY(U,$J,358.3,4686,2)
 ;;=^5001466
 ;;^UTILITY(U,$J,358.3,4687,0)
 ;;=C82.06^^22^216^145
 ;;^UTILITY(U,$J,358.3,4687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4687,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4687,1,4,0)
 ;;=4^C82.06
 ;;^UTILITY(U,$J,358.3,4687,2)
 ;;=^5001467
 ;;^UTILITY(U,$J,358.3,4688,0)
 ;;=C82.07^^22^216^148
 ;;^UTILITY(U,$J,358.3,4688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4688,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Spleen
 ;;^UTILITY(U,$J,358.3,4688,1,4,0)
 ;;=4^C82.07
 ;;^UTILITY(U,$J,358.3,4688,2)
 ;;=^5001468
 ;;^UTILITY(U,$J,358.3,4689,0)
 ;;=C82.08^^22^216^147
 ;;^UTILITY(U,$J,358.3,4689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4689,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4689,1,4,0)
 ;;=4^C82.08
 ;;^UTILITY(U,$J,358.3,4689,2)
 ;;=^5001469
 ;;^UTILITY(U,$J,358.3,4690,0)
 ;;=C82.09^^22^216^141
 ;;^UTILITY(U,$J,358.3,4690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4690,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4690,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,4690,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,4691,0)
 ;;=C82.10^^22^216^159
 ;;^UTILITY(U,$J,358.3,4691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4691,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,4691,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,4691,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,4692,0)
 ;;=C82.11^^22^216^152
 ;;^UTILITY(U,$J,358.3,4692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4692,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Head/Face/Neck
 ;;^UTILITY(U,$J,358.3,4692,1,4,0)
 ;;=4^C82.11
 ;;^UTILITY(U,$J,358.3,4692,2)
 ;;=^5001472
 ;;^UTILITY(U,$J,358.3,4693,0)
 ;;=C82.12^^22^216^156
 ;;^UTILITY(U,$J,358.3,4693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4693,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4693,1,4,0)
 ;;=4^C82.12
 ;;^UTILITY(U,$J,358.3,4693,2)
 ;;=^5001473
 ;;^UTILITY(U,$J,358.3,4694,0)
 ;;=C82.13^^22^216^154
 ;;^UTILITY(U,$J,358.3,4694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4694,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4694,1,4,0)
 ;;=4^C82.13
 ;;^UTILITY(U,$J,358.3,4694,2)
 ;;=^5001474
 ;;^UTILITY(U,$J,358.3,4695,0)
 ;;=C82.14^^22^216^150
 ;;^UTILITY(U,$J,358.3,4695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4695,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4695,1,4,0)
 ;;=4^C82.14
 ;;^UTILITY(U,$J,358.3,4695,2)
 ;;=^5001475
 ;;^UTILITY(U,$J,358.3,4696,0)
 ;;=C82.15^^22^216^153
 ;;^UTILITY(U,$J,358.3,4696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4696,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4696,1,4,0)
 ;;=4^C82.15
 ;;^UTILITY(U,$J,358.3,4696,2)
 ;;=^5001476
 ;;^UTILITY(U,$J,358.3,4697,0)
 ;;=C82.16^^22^216^155
 ;;^UTILITY(U,$J,358.3,4697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4697,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4697,1,4,0)
 ;;=4^C82.16
 ;;^UTILITY(U,$J,358.3,4697,2)
 ;;=^5001477
 ;;^UTILITY(U,$J,358.3,4698,0)
 ;;=C82.17^^22^216^158
 ;;^UTILITY(U,$J,358.3,4698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4698,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Spleen
 ;;^UTILITY(U,$J,358.3,4698,1,4,0)
 ;;=4^C82.17
 ;;^UTILITY(U,$J,358.3,4698,2)
 ;;=^5001478
 ;;^UTILITY(U,$J,358.3,4699,0)
 ;;=C82.18^^22^216^157
 ;;^UTILITY(U,$J,358.3,4699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4699,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4699,1,4,0)
 ;;=4^C82.18
 ;;^UTILITY(U,$J,358.3,4699,2)
 ;;=^5001479
 ;;^UTILITY(U,$J,358.3,4700,0)
 ;;=C82.19^^22^216^151
 ;;^UTILITY(U,$J,358.3,4700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4700,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4700,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,4700,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,4701,0)
 ;;=C82.20^^22^216^169
 ;;^UTILITY(U,$J,358.3,4701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4701,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Uspec Site
 ;;^UTILITY(U,$J,358.3,4701,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,4701,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,4702,0)
 ;;=C82.21^^22^216^162
 ;;^UTILITY(U,$J,358.3,4702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4702,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4702,1,4,0)
 ;;=4^C82.21
 ;;^UTILITY(U,$J,358.3,4702,2)
 ;;=^5001482
 ;;^UTILITY(U,$J,358.3,4703,0)
 ;;=C82.23^^22^216^164
 ;;^UTILITY(U,$J,358.3,4703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4703,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4703,1,4,0)
 ;;=4^C82.23
 ;;^UTILITY(U,$J,358.3,4703,2)
 ;;=^5001484
 ;;^UTILITY(U,$J,358.3,4704,0)
 ;;=C82.22^^22^216^166
 ;;^UTILITY(U,$J,358.3,4704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4704,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4704,1,4,0)
 ;;=4^C82.22
 ;;^UTILITY(U,$J,358.3,4704,2)
 ;;=^5001483
 ;;^UTILITY(U,$J,358.3,4705,0)
 ;;=C82.24^^22^216^160
 ;;^UTILITY(U,$J,358.3,4705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4705,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4705,1,4,0)
 ;;=4^C82.24
 ;;^UTILITY(U,$J,358.3,4705,2)
 ;;=^5001485
 ;;^UTILITY(U,$J,358.3,4706,0)
 ;;=C82.25^^22^216^163
 ;;^UTILITY(U,$J,358.3,4706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4706,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Ing Region/Lower Limb Nodes
