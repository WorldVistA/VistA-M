IBDEI045 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5051,1,4,0)
 ;;=4^C93.Z1
 ;;^UTILITY(U,$J,358.3,5051,2)
 ;;=^5001832
 ;;^UTILITY(U,$J,358.3,5052,0)
 ;;=C93.Z2^^22^216^341
 ;;^UTILITY(U,$J,358.3,5052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5052,1,3,0)
 ;;=3^Monocytic Leukemia NEC,In Relapse
 ;;^UTILITY(U,$J,358.3,5052,1,4,0)
 ;;=4^C93.Z2
 ;;^UTILITY(U,$J,358.3,5052,2)
 ;;=^5001833
 ;;^UTILITY(U,$J,358.3,5053,0)
 ;;=C93.90^^22^216^346
 ;;^UTILITY(U,$J,358.3,5053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5053,1,3,0)
 ;;=3^Monocytic Leukemia,Unspec,Not in Remission
 ;;^UTILITY(U,$J,358.3,5053,1,4,0)
 ;;=4^C93.90
 ;;^UTILITY(U,$J,358.3,5053,2)
 ;;=^5001828
 ;;^UTILITY(U,$J,358.3,5054,0)
 ;;=C93.91^^22^216^345
 ;;^UTILITY(U,$J,358.3,5054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5054,1,3,0)
 ;;=3^Monocytic Leukemia,Unspec,In Remission
 ;;^UTILITY(U,$J,358.3,5054,1,4,0)
 ;;=4^C93.91
 ;;^UTILITY(U,$J,358.3,5054,2)
 ;;=^5001829
 ;;^UTILITY(U,$J,358.3,5055,0)
 ;;=C93.92^^22^216^344
 ;;^UTILITY(U,$J,358.3,5055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5055,1,3,0)
 ;;=3^Monocytic Leukemia,Unspec,In Relapse
 ;;^UTILITY(U,$J,358.3,5055,1,4,0)
 ;;=4^C93.92
 ;;^UTILITY(U,$J,358.3,5055,2)
 ;;=^5001830
 ;;^UTILITY(U,$J,358.3,5056,0)
 ;;=C94.00^^22^216^3
 ;;^UTILITY(U,$J,358.3,5056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5056,1,3,0)
 ;;=3^Acute Erythroid Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5056,1,4,0)
 ;;=4^C94.00
 ;;^UTILITY(U,$J,358.3,5056,2)
 ;;=^5001834
 ;;^UTILITY(U,$J,358.3,5057,0)
 ;;=C94.01^^22^216^2
 ;;^UTILITY(U,$J,358.3,5057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5057,1,3,0)
 ;;=3^Acute Erythroid Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,5057,1,4,0)
 ;;=4^C94.01
 ;;^UTILITY(U,$J,358.3,5057,2)
 ;;=^5001835
 ;;^UTILITY(U,$J,358.3,5058,0)
 ;;=C94.02^^22^216^1
 ;;^UTILITY(U,$J,358.3,5058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5058,1,3,0)
 ;;=3^Acute Erythroid Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,5058,1,4,0)
 ;;=4^C94.02
 ;;^UTILITY(U,$J,358.3,5058,2)
 ;;=^5001836
 ;;^UTILITY(U,$J,358.3,5059,0)
 ;;=C94.20^^22^216^12
 ;;^UTILITY(U,$J,358.3,5059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5059,1,3,0)
 ;;=3^Acute Megakaryoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5059,1,4,0)
 ;;=4^C94.20
 ;;^UTILITY(U,$J,358.3,5059,2)
 ;;=^5001837
 ;;^UTILITY(U,$J,358.3,5060,0)
 ;;=C94.21^^22^216^11
 ;;^UTILITY(U,$J,358.3,5060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5060,1,3,0)
 ;;=3^Acute Megakaryoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,5060,1,4,0)
 ;;=4^C94.21
 ;;^UTILITY(U,$J,358.3,5060,2)
 ;;=^5001838
 ;;^UTILITY(U,$J,358.3,5061,0)
 ;;=C94.22^^22^216^10
 ;;^UTILITY(U,$J,358.3,5061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5061,1,3,0)
 ;;=3^Acute Megakaryoblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,5061,1,4,0)
 ;;=4^C94.22
 ;;^UTILITY(U,$J,358.3,5061,2)
 ;;=^5001839
 ;;^UTILITY(U,$J,358.3,5062,0)
 ;;=C94.30^^22^216^298
 ;;^UTILITY(U,$J,358.3,5062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5062,1,3,0)
 ;;=3^Mast Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5062,1,4,0)
 ;;=4^C94.30
 ;;^UTILITY(U,$J,358.3,5062,2)
 ;;=^5001840
 ;;^UTILITY(U,$J,358.3,5063,0)
 ;;=C94.31^^22^216^297
 ;;^UTILITY(U,$J,358.3,5063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5063,1,3,0)
 ;;=3^Mast Cell Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,5063,1,4,0)
 ;;=4^C94.31
 ;;^UTILITY(U,$J,358.3,5063,2)
 ;;=^5001841
 ;;^UTILITY(U,$J,358.3,5064,0)
 ;;=C94.32^^22^216^296
 ;;^UTILITY(U,$J,358.3,5064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5064,1,3,0)
 ;;=3^Mast Cell Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,5064,1,4,0)
 ;;=4^C94.32
 ;;^UTILITY(U,$J,358.3,5064,2)
 ;;=^5001842
 ;;^UTILITY(U,$J,358.3,5065,0)
 ;;=C94.40^^22^216^30
 ;;^UTILITY(U,$J,358.3,5065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5065,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,5065,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,5065,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,5066,0)
 ;;=C94.41^^22^216^28
 ;;^UTILITY(U,$J,358.3,5066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5066,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,5066,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,5066,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,5067,0)
 ;;=C94.42^^22^216^29
 ;;^UTILITY(U,$J,358.3,5067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5067,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,5067,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,5067,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,5068,0)
 ;;=C94.6^^22^216^362
 ;;^UTILITY(U,$J,358.3,5068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5068,1,3,0)
 ;;=3^Myelodysplastic Disease NEC
 ;;^UTILITY(U,$J,358.3,5068,1,4,0)
 ;;=4^C94.6
 ;;^UTILITY(U,$J,358.3,5068,2)
 ;;=^5001846
 ;;^UTILITY(U,$J,358.3,5069,0)
 ;;=C94.80^^22^216^244
 ;;^UTILITY(U,$J,358.3,5069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5069,1,3,0)
 ;;=3^Leukemias NEC,Not in Remission
 ;;^UTILITY(U,$J,358.3,5069,1,4,0)
 ;;=4^C94.80
 ;;^UTILITY(U,$J,358.3,5069,2)
 ;;=^5001847
 ;;^UTILITY(U,$J,358.3,5070,0)
 ;;=C94.81^^22^216^243
 ;;^UTILITY(U,$J,358.3,5070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5070,1,3,0)
 ;;=3^Leukemias NEC,In Remission
 ;;^UTILITY(U,$J,358.3,5070,1,4,0)
 ;;=4^C94.81
 ;;^UTILITY(U,$J,358.3,5070,2)
 ;;=^5001848
 ;;^UTILITY(U,$J,358.3,5071,0)
 ;;=C94.82^^22^216^242
 ;;^UTILITY(U,$J,358.3,5071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5071,1,3,0)
 ;;=3^Leukemias NEC,In Relapse
 ;;^UTILITY(U,$J,358.3,5071,1,4,0)
 ;;=4^C94.82
 ;;^UTILITY(U,$J,358.3,5071,2)
 ;;=^5001849
 ;;^UTILITY(U,$J,358.3,5072,0)
 ;;=C95.00^^22^216^6
 ;;^UTILITY(U,$J,358.3,5072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5072,1,3,0)
 ;;=3^Acute Leukemia,Unspec Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,5072,1,4,0)
 ;;=4^C95.00
 ;;^UTILITY(U,$J,358.3,5072,2)
 ;;=^5001850
 ;;^UTILITY(U,$J,358.3,5073,0)
 ;;=C95.01^^22^216^5
 ;;^UTILITY(U,$J,358.3,5073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5073,1,3,0)
 ;;=3^Acute Leukemia,Unspec Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,5073,1,4,0)
 ;;=4^C95.01
 ;;^UTILITY(U,$J,358.3,5073,2)
 ;;=^5001851
 ;;^UTILITY(U,$J,358.3,5074,0)
 ;;=C95.02^^22^216^4
 ;;^UTILITY(U,$J,358.3,5074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5074,1,3,0)
 ;;=3^Acute Leukemia,Unspec Cell Type,In Relapse
 ;;^UTILITY(U,$J,358.3,5074,1,4,0)
 ;;=4^C95.02
 ;;^UTILITY(U,$J,358.3,5074,2)
 ;;=^5001852
 ;;^UTILITY(U,$J,358.3,5075,0)
 ;;=C95.10^^22^216^81
 ;;^UTILITY(U,$J,358.3,5075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5075,1,3,0)
 ;;=3^Chronic Leukemia,Unspec Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,5075,1,4,0)
 ;;=4^C95.10
 ;;^UTILITY(U,$J,358.3,5075,2)
 ;;=^5001853
 ;;^UTILITY(U,$J,358.3,5076,0)
 ;;=C95.11^^22^216^79
 ;;^UTILITY(U,$J,358.3,5076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5076,1,3,0)
 ;;=3^Chronic Leukemia,Unspec Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,5076,1,4,0)
 ;;=4^C95.11
 ;;^UTILITY(U,$J,358.3,5076,2)
 ;;=^5001854
 ;;^UTILITY(U,$J,358.3,5077,0)
 ;;=C95.12^^22^216^80
 ;;^UTILITY(U,$J,358.3,5077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5077,1,3,0)
 ;;=3^Chronic Leukemia,Unspec Cell Type,In Relapse
 ;;^UTILITY(U,$J,358.3,5077,1,4,0)
 ;;=4^C95.12
 ;;^UTILITY(U,$J,358.3,5077,2)
 ;;=^5001855
 ;;^UTILITY(U,$J,358.3,5078,0)
 ;;=C95.90^^22^216^241
 ;;^UTILITY(U,$J,358.3,5078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5078,1,3,0)
 ;;=3^Leukemia,Unspec,Not in Remission
 ;;^UTILITY(U,$J,358.3,5078,1,4,0)
 ;;=4^C95.90
 ;;^UTILITY(U,$J,358.3,5078,2)
 ;;=^5001856
 ;;^UTILITY(U,$J,358.3,5079,0)
 ;;=C95.91^^22^216^240
 ;;^UTILITY(U,$J,358.3,5079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5079,1,3,0)
 ;;=3^Leukemia,Unspec,In Remission
 ;;^UTILITY(U,$J,358.3,5079,1,4,0)
 ;;=4^C95.91
 ;;^UTILITY(U,$J,358.3,5079,2)
 ;;=^5001857
 ;;^UTILITY(U,$J,358.3,5080,0)
 ;;=C95.92^^22^216^239
 ;;^UTILITY(U,$J,358.3,5080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5080,1,3,0)
 ;;=3^Leukemia,Unspec,In Relapse
 ;;^UTILITY(U,$J,358.3,5080,1,4,0)
 ;;=4^C95.92
 ;;^UTILITY(U,$J,358.3,5080,2)
 ;;=^5001858
 ;;^UTILITY(U,$J,358.3,5081,0)
 ;;=C96.0^^22^216^347
 ;;^UTILITY(U,$J,358.3,5081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5081,1,3,0)
 ;;=3^Multifocal/Multisystemic Langerhans-Cell Histiocytosis
 ;;^UTILITY(U,$J,358.3,5081,1,4,0)
 ;;=4^C96.0
 ;;^UTILITY(U,$J,358.3,5081,2)
 ;;=^5001859
 ;;^UTILITY(U,$J,358.3,5082,0)
 ;;=C96.2^^22^216^283
 ;;^UTILITY(U,$J,358.3,5082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5082,1,3,0)
 ;;=3^Malig Mast Cell Tumor
 ;;^UTILITY(U,$J,358.3,5082,1,4,0)
 ;;=4^C96.2
 ;;^UTILITY(U,$J,358.3,5082,2)
 ;;=^5001860
 ;;^UTILITY(U,$J,358.3,5083,0)
 ;;=C96.4^^22^216^452
 ;;^UTILITY(U,$J,358.3,5083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5083,1,3,0)
 ;;=3^Sarcoma of Dendritic Cells
 ;;^UTILITY(U,$J,358.3,5083,1,4,0)
 ;;=4^C96.4
 ;;^UTILITY(U,$J,358.3,5083,2)
 ;;=^5001861
 ;;^UTILITY(U,$J,358.3,5084,0)
 ;;=C96.5^^22^216^348
 ;;^UTILITY(U,$J,358.3,5084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5084,1,3,0)
 ;;=3^Multifocal/Unisystemic Langerhans-Cell Histiocytosis
 ;;^UTILITY(U,$J,358.3,5084,1,4,0)
 ;;=4^C96.5
 ;;^UTILITY(U,$J,358.3,5084,2)
 ;;=^5001862
 ;;^UTILITY(U,$J,358.3,5085,0)
 ;;=C96.6^^22^216^477
 ;;^UTILITY(U,$J,358.3,5085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5085,1,3,0)
 ;;=3^Uniforcal Langerhans-Cell Histiocytosis
 ;;^UTILITY(U,$J,358.3,5085,1,4,0)
 ;;=4^C96.6
 ;;^UTILITY(U,$J,358.3,5085,2)
 ;;=^5001863
 ;;^UTILITY(U,$J,358.3,5086,0)
 ;;=C96.A^^22^216^214
 ;;^UTILITY(U,$J,358.3,5086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5086,1,3,0)
 ;;=3^Histiocytic Sarcoma
 ;;^UTILITY(U,$J,358.3,5086,1,4,0)
 ;;=4^C96.A
 ;;^UTILITY(U,$J,358.3,5086,2)
 ;;=^5001865
 ;;^UTILITY(U,$J,358.3,5087,0)
 ;;=C96.Z^^22^216^284
 ;;^UTILITY(U,$J,358.3,5087,1,0)
 ;;=^358.31IA^4^2
