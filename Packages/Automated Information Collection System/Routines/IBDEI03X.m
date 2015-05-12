IBDEI03X ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4775,0)
 ;;=C83.04^^22^216^463
 ;;^UTILITY(U,$J,358.3,4775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4775,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4775,1,4,0)
 ;;=4^C83.04
 ;;^UTILITY(U,$J,358.3,4775,2)
 ;;=^5001555
 ;;^UTILITY(U,$J,358.3,4776,0)
 ;;=C83.05^^22^216^466
 ;;^UTILITY(U,$J,358.3,4776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4776,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4776,1,4,0)
 ;;=4^C83.05
 ;;^UTILITY(U,$J,358.3,4776,2)
 ;;=^5001556
 ;;^UTILITY(U,$J,358.3,4777,0)
 ;;=C83.06^^22^216^468
 ;;^UTILITY(U,$J,358.3,4777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4777,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4777,1,4,0)
 ;;=4^C83.06
 ;;^UTILITY(U,$J,358.3,4777,2)
 ;;=^5001557
 ;;^UTILITY(U,$J,358.3,4778,0)
 ;;=C83.07^^22^216^471
 ;;^UTILITY(U,$J,358.3,4778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4778,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Spleen
 ;;^UTILITY(U,$J,358.3,4778,1,4,0)
 ;;=4^C83.07
 ;;^UTILITY(U,$J,358.3,4778,2)
 ;;=^5001558
 ;;^UTILITY(U,$J,358.3,4779,0)
 ;;=C83.08^^22^216^470
 ;;^UTILITY(U,$J,358.3,4779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4779,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4779,1,4,0)
 ;;=4^C83.08
 ;;^UTILITY(U,$J,358.3,4779,2)
 ;;=^5001559
 ;;^UTILITY(U,$J,358.3,4780,0)
 ;;=C83.09^^22^216^464
 ;;^UTILITY(U,$J,358.3,4780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4780,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4780,1,4,0)
 ;;=4^C83.09
 ;;^UTILITY(U,$J,358.3,4780,2)
 ;;=^5001560
 ;;^UTILITY(U,$J,358.3,4781,0)
 ;;=C83.10^^22^216^295
 ;;^UTILITY(U,$J,358.3,4781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4781,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,4781,1,4,0)
 ;;=4^C83.10
 ;;^UTILITY(U,$J,358.3,4781,2)
 ;;=^5001561
 ;;^UTILITY(U,$J,358.3,4782,0)
 ;;=C83.11^^22^216^288
 ;;^UTILITY(U,$J,358.3,4782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4782,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4782,1,4,0)
 ;;=4^C83.11
 ;;^UTILITY(U,$J,358.3,4782,2)
 ;;=^5001562
 ;;^UTILITY(U,$J,358.3,4783,0)
 ;;=C83.12^^22^216^292
 ;;^UTILITY(U,$J,358.3,4783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4783,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4783,1,4,0)
 ;;=4^C83.12
 ;;^UTILITY(U,$J,358.3,4783,2)
 ;;=^5001563
 ;;^UTILITY(U,$J,358.3,4784,0)
 ;;=C83.13^^22^216^290
 ;;^UTILITY(U,$J,358.3,4784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4784,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4784,1,4,0)
 ;;=4^C83.13
 ;;^UTILITY(U,$J,358.3,4784,2)
 ;;=^5001564
 ;;^UTILITY(U,$J,358.3,4785,0)
 ;;=C83.14^^22^216^286
 ;;^UTILITY(U,$J,358.3,4785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4785,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4785,1,4,0)
 ;;=4^C83.14
 ;;^UTILITY(U,$J,358.3,4785,2)
 ;;=^5001565
 ;;^UTILITY(U,$J,358.3,4786,0)
 ;;=C83.15^^22^216^289
 ;;^UTILITY(U,$J,358.3,4786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4786,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4786,1,4,0)
 ;;=4^C83.15
 ;;^UTILITY(U,$J,358.3,4786,2)
 ;;=^5001566
 ;;^UTILITY(U,$J,358.3,4787,0)
 ;;=C83.16^^22^216^291
 ;;^UTILITY(U,$J,358.3,4787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4787,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4787,1,4,0)
 ;;=4^C83.16
 ;;^UTILITY(U,$J,358.3,4787,2)
 ;;=^5001567
 ;;^UTILITY(U,$J,358.3,4788,0)
 ;;=C83.17^^22^216^294
 ;;^UTILITY(U,$J,358.3,4788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4788,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Spleen
 ;;^UTILITY(U,$J,358.3,4788,1,4,0)
 ;;=4^C83.17
 ;;^UTILITY(U,$J,358.3,4788,2)
 ;;=^5001568
 ;;^UTILITY(U,$J,358.3,4789,0)
 ;;=C83.18^^22^216^293
 ;;^UTILITY(U,$J,358.3,4789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4789,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4789,1,4,0)
 ;;=4^C83.18
 ;;^UTILITY(U,$J,358.3,4789,2)
 ;;=^5001569
 ;;^UTILITY(U,$J,358.3,4790,0)
 ;;=C83.19^^22^216^287
 ;;^UTILITY(U,$J,358.3,4790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4790,1,3,0)
 ;;=3^Mantle Cell Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4790,1,4,0)
 ;;=4^C83.19
 ;;^UTILITY(U,$J,358.3,4790,2)
 ;;=^5001570
 ;;^UTILITY(U,$J,358.3,4791,0)
 ;;=C83.30^^22^216^133
 ;;^UTILITY(U,$J,358.3,4791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4791,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,4791,1,4,0)
 ;;=4^C83.30
 ;;^UTILITY(U,$J,358.3,4791,2)
 ;;=^5001571
 ;;^UTILITY(U,$J,358.3,4792,0)
 ;;=C83.31^^22^216^126
 ;;^UTILITY(U,$J,358.3,4792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4792,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4792,1,4,0)
 ;;=4^C83.31
 ;;^UTILITY(U,$J,358.3,4792,2)
 ;;=^5001572
 ;;^UTILITY(U,$J,358.3,4793,0)
 ;;=C83.32^^22^216^130
 ;;^UTILITY(U,$J,358.3,4793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4793,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4793,1,4,0)
 ;;=4^C83.32
 ;;^UTILITY(U,$J,358.3,4793,2)
 ;;=^5001573
 ;;^UTILITY(U,$J,358.3,4794,0)
 ;;=C83.33^^22^216^128
 ;;^UTILITY(U,$J,358.3,4794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4794,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4794,1,4,0)
 ;;=4^C83.33
 ;;^UTILITY(U,$J,358.3,4794,2)
 ;;=^5001574
 ;;^UTILITY(U,$J,358.3,4795,0)
 ;;=C83.34^^22^216^124
 ;;^UTILITY(U,$J,358.3,4795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4795,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4795,1,4,0)
 ;;=4^C83.34
 ;;^UTILITY(U,$J,358.3,4795,2)
 ;;=^5001575
 ;;^UTILITY(U,$J,358.3,4796,0)
 ;;=C83.35^^22^216^127
 ;;^UTILITY(U,$J,358.3,4796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4796,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Ing Region/Lower Limb
 ;;^UTILITY(U,$J,358.3,4796,1,4,0)
 ;;=4^C83.35
 ;;^UTILITY(U,$J,358.3,4796,2)
 ;;=^5001576
 ;;^UTILITY(U,$J,358.3,4797,0)
 ;;=C83.36^^22^216^129
 ;;^UTILITY(U,$J,358.3,4797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4797,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4797,1,4,0)
 ;;=4^C83.36
 ;;^UTILITY(U,$J,358.3,4797,2)
 ;;=^5001577
 ;;^UTILITY(U,$J,358.3,4798,0)
 ;;=C83.37^^22^216^132
 ;;^UTILITY(U,$J,358.3,4798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4798,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Spleen
 ;;^UTILITY(U,$J,358.3,4798,1,4,0)
 ;;=4^C83.37
 ;;^UTILITY(U,$J,358.3,4798,2)
 ;;=^5001578
 ;;^UTILITY(U,$J,358.3,4799,0)
 ;;=C83.38^^22^216^131
 ;;^UTILITY(U,$J,358.3,4799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4799,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4799,1,4,0)
 ;;=4^C83.38
 ;;^UTILITY(U,$J,358.3,4799,2)
 ;;=^5001579
 ;;^UTILITY(U,$J,358.3,4800,0)
 ;;=C83.39^^22^216^125
 ;;^UTILITY(U,$J,358.3,4800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4800,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4800,1,4,0)
 ;;=4^C83.39
 ;;^UTILITY(U,$J,358.3,4800,2)
 ;;=^5001580
 ;;^UTILITY(U,$J,358.3,4801,0)
 ;;=C83.50^^22^216^254
 ;;^UTILITY(U,$J,358.3,4801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4801,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,4801,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,4801,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,4802,0)
 ;;=C83.51^^22^216^247
 ;;^UTILITY(U,$J,358.3,4802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4802,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4802,1,4,0)
 ;;=4^C83.51
 ;;^UTILITY(U,$J,358.3,4802,2)
 ;;=^5001582
 ;;^UTILITY(U,$J,358.3,4803,0)
 ;;=C83.52^^22^216^251
 ;;^UTILITY(U,$J,358.3,4803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4803,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4803,1,4,0)
 ;;=4^C83.52
 ;;^UTILITY(U,$J,358.3,4803,2)
 ;;=^5001583
 ;;^UTILITY(U,$J,358.3,4804,0)
 ;;=C83.53^^22^216^249
 ;;^UTILITY(U,$J,358.3,4804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4804,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4804,1,4,0)
 ;;=4^C83.53
 ;;^UTILITY(U,$J,358.3,4804,2)
 ;;=^5001584
 ;;^UTILITY(U,$J,358.3,4805,0)
 ;;=C83.54^^22^216^245
 ;;^UTILITY(U,$J,358.3,4805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4805,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4805,1,4,0)
 ;;=4^C83.54
 ;;^UTILITY(U,$J,358.3,4805,2)
 ;;=^5001585
 ;;^UTILITY(U,$J,358.3,4806,0)
 ;;=C83.55^^22^216^248
 ;;^UTILITY(U,$J,358.3,4806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4806,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4806,1,4,0)
 ;;=4^C83.55
 ;;^UTILITY(U,$J,358.3,4806,2)
 ;;=^5001586
 ;;^UTILITY(U,$J,358.3,4807,0)
 ;;=C83.56^^22^216^250
 ;;^UTILITY(U,$J,358.3,4807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4807,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4807,1,4,0)
 ;;=4^C83.56
 ;;^UTILITY(U,$J,358.3,4807,2)
 ;;=^5001587
 ;;^UTILITY(U,$J,358.3,4808,0)
 ;;=C83.57^^22^216^253
 ;;^UTILITY(U,$J,358.3,4808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4808,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Spleen
 ;;^UTILITY(U,$J,358.3,4808,1,4,0)
 ;;=4^C83.57
 ;;^UTILITY(U,$J,358.3,4808,2)
 ;;=^5001588
 ;;^UTILITY(U,$J,358.3,4809,0)
 ;;=C83.58^^22^216^252
 ;;^UTILITY(U,$J,358.3,4809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4809,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Mult Site Nodes
