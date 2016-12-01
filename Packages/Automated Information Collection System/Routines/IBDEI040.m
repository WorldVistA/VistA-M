IBDEI040 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4783,1,4,0)
 ;;=4^D22.9
 ;;^UTILITY(U,$J,358.3,4783,2)
 ;;=^5002058
 ;;^UTILITY(U,$J,358.3,4784,0)
 ;;=C44.00^^22^299^23
 ;;^UTILITY(U,$J,358.3,4784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4784,1,3,0)
 ;;=3^Malig Neop Skin of Lip,Unspec
 ;;^UTILITY(U,$J,358.3,4784,1,4,0)
 ;;=4^C44.00
 ;;^UTILITY(U,$J,358.3,4784,2)
 ;;=^340596
 ;;^UTILITY(U,$J,358.3,4785,0)
 ;;=C44.192^^22^299^27
 ;;^UTILITY(U,$J,358.3,4785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4785,1,3,0)
 ;;=3^Malig Neop Skin of Right Eyelid
 ;;^UTILITY(U,$J,358.3,4785,1,4,0)
 ;;=4^C44.192
 ;;^UTILITY(U,$J,358.3,4785,2)
 ;;=^5001026
 ;;^UTILITY(U,$J,358.3,4786,0)
 ;;=C44.199^^22^299^20
 ;;^UTILITY(U,$J,358.3,4786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4786,1,3,0)
 ;;=3^Malig Neop Skin of Left Eyelid
 ;;^UTILITY(U,$J,358.3,4786,1,4,0)
 ;;=4^C44.199
 ;;^UTILITY(U,$J,358.3,4786,2)
 ;;=^5001027
 ;;^UTILITY(U,$J,358.3,4787,0)
 ;;=C44.202^^22^299^26
 ;;^UTILITY(U,$J,358.3,4787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4787,1,3,0)
 ;;=3^Malig Neop Skin of Right Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,4787,1,4,0)
 ;;=4^C44.202
 ;;^UTILITY(U,$J,358.3,4787,2)
 ;;=^5001029
 ;;^UTILITY(U,$J,358.3,4788,0)
 ;;=C44.209^^22^299^19
 ;;^UTILITY(U,$J,358.3,4788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4788,1,3,0)
 ;;=3^Malig Neop Skin of Left Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,4788,1,4,0)
 ;;=4^C44.209
 ;;^UTILITY(U,$J,358.3,4788,2)
 ;;=^5001030
 ;;^UTILITY(U,$J,358.3,4789,0)
 ;;=C44.301^^22^299^24
 ;;^UTILITY(U,$J,358.3,4789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4789,1,3,0)
 ;;=3^Malig Neop Skin of Nose
 ;;^UTILITY(U,$J,358.3,4789,1,4,0)
 ;;=4^C44.301
 ;;^UTILITY(U,$J,358.3,4789,2)
 ;;=^5001041
 ;;^UTILITY(U,$J,358.3,4790,0)
 ;;=C44.49^^22^299^30
 ;;^UTILITY(U,$J,358.3,4790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4790,1,3,0)
 ;;=3^Malig Neop Skin of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,4790,1,4,0)
 ;;=4^C44.49
 ;;^UTILITY(U,$J,358.3,4790,2)
 ;;=^340478
 ;;^UTILITY(U,$J,358.3,4791,0)
 ;;=C44.509^^22^299^31
 ;;^UTILITY(U,$J,358.3,4791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4791,1,3,0)
 ;;=3^Malig Neop Skin of Trunk,Other Part
 ;;^UTILITY(U,$J,358.3,4791,1,4,0)
 ;;=4^C44.509
 ;;^UTILITY(U,$J,358.3,4791,2)
 ;;=^5001053
 ;;^UTILITY(U,$J,358.3,4792,0)
 ;;=C44.590^^22^299^17
 ;;^UTILITY(U,$J,358.3,4792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4792,1,3,0)
 ;;=3^Malig Neop Skin of Anus
 ;;^UTILITY(U,$J,358.3,4792,1,4,0)
 ;;=4^C44.590
 ;;^UTILITY(U,$J,358.3,4792,2)
 ;;=^5001060
 ;;^UTILITY(U,$J,358.3,4793,0)
 ;;=C44.591^^22^299^18
 ;;^UTILITY(U,$J,358.3,4793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4793,1,3,0)
 ;;=3^Malig Neop Skin of Breast
 ;;^UTILITY(U,$J,358.3,4793,1,4,0)
 ;;=4^C44.591
 ;;^UTILITY(U,$J,358.3,4793,2)
 ;;=^5001061
 ;;^UTILITY(U,$J,358.3,4794,0)
 ;;=C44.692^^22^299^29
 ;;^UTILITY(U,$J,358.3,4794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4794,1,3,0)
 ;;=3^Malig Neop Skin of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,4794,1,4,0)
 ;;=4^C44.692
 ;;^UTILITY(U,$J,358.3,4794,2)
 ;;=^5001073
 ;;^UTILITY(U,$J,358.3,4795,0)
 ;;=C44.699^^22^299^22
 ;;^UTILITY(U,$J,358.3,4795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4795,1,3,0)
 ;;=3^Malig Neop Skin of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,4795,1,4,0)
 ;;=4^C44.699
 ;;^UTILITY(U,$J,358.3,4795,2)
 ;;=^5001074
 ;;^UTILITY(U,$J,358.3,4796,0)
 ;;=C44.99^^22^299^33
 ;;^UTILITY(U,$J,358.3,4796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4796,1,3,0)
 ;;=3^Malig Neop Skin,Unspec Site
 ;;^UTILITY(U,$J,358.3,4796,1,4,0)
 ;;=4^C44.99
 ;;^UTILITY(U,$J,358.3,4796,2)
 ;;=^5001094
 ;;^UTILITY(U,$J,358.3,4797,0)
 ;;=C44.792^^22^299^28
 ;;^UTILITY(U,$J,358.3,4797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4797,1,3,0)
 ;;=3^Malig Neop Skin of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,4797,1,4,0)
 ;;=4^C44.792
 ;;^UTILITY(U,$J,358.3,4797,2)
 ;;=^5001085
 ;;^UTILITY(U,$J,358.3,4798,0)
 ;;=C44.799^^22^299^21
 ;;^UTILITY(U,$J,358.3,4798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4798,1,3,0)
 ;;=3^Malig Neop Skin of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4798,1,4,0)
 ;;=4^C44.799
 ;;^UTILITY(U,$J,358.3,4798,2)
 ;;=^5001086
 ;;^UTILITY(U,$J,358.3,4799,0)
 ;;=C44.89^^22^299^25
 ;;^UTILITY(U,$J,358.3,4799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4799,1,3,0)
 ;;=3^Malig Neop Skin of Overlapping Sites
 ;;^UTILITY(U,$J,358.3,4799,1,4,0)
 ;;=4^C44.89
 ;;^UTILITY(U,$J,358.3,4799,2)
 ;;=^5001090
 ;;^UTILITY(U,$J,358.3,4800,0)
 ;;=C43.0^^22^299^7
 ;;^UTILITY(U,$J,358.3,4800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4800,1,3,0)
 ;;=3^Malig Melanoma of Lip
 ;;^UTILITY(U,$J,358.3,4800,1,4,0)
 ;;=4^C43.0
 ;;^UTILITY(U,$J,358.3,4800,2)
 ;;=^5000994
 ;;^UTILITY(U,$J,358.3,4801,0)
 ;;=C43.12^^22^299^4
 ;;^UTILITY(U,$J,358.3,4801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4801,1,3,0)
 ;;=3^Malig Melanoma of Left Eyelid
 ;;^UTILITY(U,$J,358.3,4801,1,4,0)
 ;;=4^C43.12
 ;;^UTILITY(U,$J,358.3,4801,2)
 ;;=^5000997
 ;;^UTILITY(U,$J,358.3,4802,0)
 ;;=C43.11^^22^299^11
 ;;^UTILITY(U,$J,358.3,4802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4802,1,3,0)
 ;;=3^Malig Melanoma of Right Eyelid
 ;;^UTILITY(U,$J,358.3,4802,1,4,0)
 ;;=4^C43.11
 ;;^UTILITY(U,$J,358.3,4802,2)
 ;;=^5000996
 ;;^UTILITY(U,$J,358.3,4803,0)
 ;;=C43.21^^22^299^10
 ;;^UTILITY(U,$J,358.3,4803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4803,1,3,0)
 ;;=3^Malig Melanoma of Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,4803,1,4,0)
 ;;=4^C43.21
 ;;^UTILITY(U,$J,358.3,4803,2)
 ;;=^5000999
 ;;^UTILITY(U,$J,358.3,4804,0)
 ;;=C43.22^^22^299^3
 ;;^UTILITY(U,$J,358.3,4804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4804,1,3,0)
 ;;=3^Malig Melanoma of Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,4804,1,4,0)
 ;;=4^C43.22
 ;;^UTILITY(U,$J,358.3,4804,2)
 ;;=^5001000
 ;;^UTILITY(U,$J,358.3,4805,0)
 ;;=C43.31^^22^299^8
 ;;^UTILITY(U,$J,358.3,4805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4805,1,3,0)
 ;;=3^Malig Melanoma of Nose
 ;;^UTILITY(U,$J,358.3,4805,1,4,0)
 ;;=4^C43.31
 ;;^UTILITY(U,$J,358.3,4805,2)
 ;;=^5001002
 ;;^UTILITY(U,$J,358.3,4806,0)
 ;;=C43.39^^22^299^2
 ;;^UTILITY(U,$J,358.3,4806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4806,1,3,0)
 ;;=3^Malig Melanoma of Face,Other Parts
 ;;^UTILITY(U,$J,358.3,4806,1,4,0)
 ;;=4^C43.39
 ;;^UTILITY(U,$J,358.3,4806,2)
 ;;=^5001003
 ;;^UTILITY(U,$J,358.3,4807,0)
 ;;=C43.4^^22^299^14
 ;;^UTILITY(U,$J,358.3,4807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4807,1,3,0)
 ;;=3^Malig Melanoma of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,4807,1,4,0)
 ;;=4^C43.4
 ;;^UTILITY(U,$J,358.3,4807,2)
 ;;=^5001004
 ;;^UTILITY(U,$J,358.3,4808,0)
 ;;=C43.59^^22^299^16
 ;;^UTILITY(U,$J,358.3,4808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4808,1,3,0)
 ;;=3^Malig Melanoma of Trunk,Other Part
 ;;^UTILITY(U,$J,358.3,4808,1,4,0)
 ;;=4^C43.59
 ;;^UTILITY(U,$J,358.3,4808,2)
 ;;=^5001007
 ;;^UTILITY(U,$J,358.3,4809,0)
 ;;=C43.51^^22^299^1
 ;;^UTILITY(U,$J,358.3,4809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4809,1,3,0)
 ;;=3^Malig Melanoma of Anal Skin
 ;;^UTILITY(U,$J,358.3,4809,1,4,0)
 ;;=4^C43.51
 ;;^UTILITY(U,$J,358.3,4809,2)
 ;;=^5001005
 ;;^UTILITY(U,$J,358.3,4810,0)
 ;;=C43.52^^22^299^15
 ;;^UTILITY(U,$J,358.3,4810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4810,1,3,0)
 ;;=3^Malig Melanoma of Skin of Breast
 ;;^UTILITY(U,$J,358.3,4810,1,4,0)
 ;;=4^C43.52
 ;;^UTILITY(U,$J,358.3,4810,2)
 ;;=^5001006
 ;;^UTILITY(U,$J,358.3,4811,0)
 ;;=C43.61^^22^299^13
 ;;^UTILITY(U,$J,358.3,4811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4811,1,3,0)
 ;;=3^Malig Melanoma of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,4811,1,4,0)
 ;;=4^C43.61
 ;;^UTILITY(U,$J,358.3,4811,2)
 ;;=^5001009
 ;;^UTILITY(U,$J,358.3,4812,0)
 ;;=C43.62^^22^299^6
 ;;^UTILITY(U,$J,358.3,4812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4812,1,3,0)
 ;;=3^Malig Melanoma of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,4812,1,4,0)
 ;;=4^C43.62
 ;;^UTILITY(U,$J,358.3,4812,2)
 ;;=^5001010
 ;;^UTILITY(U,$J,358.3,4813,0)
 ;;=C43.71^^22^299^12
 ;;^UTILITY(U,$J,358.3,4813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4813,1,3,0)
 ;;=3^Malig Melanoma of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,4813,1,4,0)
 ;;=4^C43.71
 ;;^UTILITY(U,$J,358.3,4813,2)
 ;;=^5001012
 ;;^UTILITY(U,$J,358.3,4814,0)
 ;;=C43.72^^22^299^5
 ;;^UTILITY(U,$J,358.3,4814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4814,1,3,0)
 ;;=3^Malig Melanoma of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4814,1,4,0)
 ;;=4^C43.72
 ;;^UTILITY(U,$J,358.3,4814,2)
 ;;=^5001013
 ;;^UTILITY(U,$J,358.3,4815,0)
 ;;=C43.8^^22^299^9
 ;;^UTILITY(U,$J,358.3,4815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4815,1,3,0)
 ;;=3^Malig Melanoma of Overlapping Sites of Skin
 ;;^UTILITY(U,$J,358.3,4815,1,4,0)
 ;;=4^C43.8
 ;;^UTILITY(U,$J,358.3,4815,2)
 ;;=^5001014
 ;;^UTILITY(U,$J,358.3,4816,0)
 ;;=D03.0^^22^299^60
 ;;^UTILITY(U,$J,358.3,4816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4816,1,3,0)
 ;;=3^Melanoma in Situ of Lip
 ;;^UTILITY(U,$J,358.3,4816,1,4,0)
 ;;=4^D03.0
 ;;^UTILITY(U,$J,358.3,4816,2)
 ;;=^5001888
 ;;^UTILITY(U,$J,358.3,4817,0)
 ;;=D03.11^^22^299^54
 ;;^UTILITY(U,$J,358.3,4817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4817,1,3,0)
 ;;=3^Melanoma in Situ Right Eyelid
 ;;^UTILITY(U,$J,358.3,4817,1,4,0)
 ;;=4^D03.11
 ;;^UTILITY(U,$J,358.3,4817,2)
 ;;=^5001890
 ;;^UTILITY(U,$J,358.3,4818,0)
 ;;=D03.12^^22^299^50
 ;;^UTILITY(U,$J,358.3,4818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4818,1,3,0)
 ;;=3^Melanoma in Situ Left Eyelid
 ;;^UTILITY(U,$J,358.3,4818,1,4,0)
 ;;=4^D03.12
 ;;^UTILITY(U,$J,358.3,4818,2)
 ;;=^5001891
 ;;^UTILITY(U,$J,358.3,4819,0)
 ;;=D03.21^^22^299^53
 ;;^UTILITY(U,$J,358.3,4819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4819,1,3,0)
 ;;=3^Melanoma in Situ Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,4819,1,4,0)
 ;;=4^D03.21
