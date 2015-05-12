IBDEI03Z ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4844,1,3,0)
 ;;=3^Mycosis Fungoides,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4844,1,4,0)
 ;;=4^C84.03
 ;;^UTILITY(U,$J,358.3,4844,2)
 ;;=^5001624
 ;;^UTILITY(U,$J,358.3,4845,0)
 ;;=C84.04^^22^216^352
 ;;^UTILITY(U,$J,358.3,4845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4845,1,3,0)
 ;;=3^Mycosis Fungoides,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4845,1,4,0)
 ;;=4^C84.04
 ;;^UTILITY(U,$J,358.3,4845,2)
 ;;=^5001625
 ;;^UTILITY(U,$J,358.3,4846,0)
 ;;=C84.05^^22^216^355
 ;;^UTILITY(U,$J,358.3,4846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4846,1,3,0)
 ;;=3^Mycosis Fungoides,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4846,1,4,0)
 ;;=4^C84.05
 ;;^UTILITY(U,$J,358.3,4846,2)
 ;;=^5001626
 ;;^UTILITY(U,$J,358.3,4847,0)
 ;;=C84.06^^22^216^357
 ;;^UTILITY(U,$J,358.3,4847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4847,1,3,0)
 ;;=3^Mycosis Fungoides,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4847,1,4,0)
 ;;=4^C84.06
 ;;^UTILITY(U,$J,358.3,4847,2)
 ;;=^5001627
 ;;^UTILITY(U,$J,358.3,4848,0)
 ;;=C84.07^^22^216^360
 ;;^UTILITY(U,$J,358.3,4848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4848,1,3,0)
 ;;=3^Mycosis Fungoides,Spleen
 ;;^UTILITY(U,$J,358.3,4848,1,4,0)
 ;;=4^C84.07
 ;;^UTILITY(U,$J,358.3,4848,2)
 ;;=^5001628
 ;;^UTILITY(U,$J,358.3,4849,0)
 ;;=C84.08^^22^216^359
 ;;^UTILITY(U,$J,358.3,4849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4849,1,3,0)
 ;;=3^Mycosis Fungoides,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4849,1,4,0)
 ;;=4^C84.08
 ;;^UTILITY(U,$J,358.3,4849,2)
 ;;=^5001629
 ;;^UTILITY(U,$J,358.3,4850,0)
 ;;=C84.09^^22^216^353
 ;;^UTILITY(U,$J,358.3,4850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4850,1,3,0)
 ;;=3^Mycosis Fungoides,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4850,1,4,0)
 ;;=4^C84.09
 ;;^UTILITY(U,$J,358.3,4850,2)
 ;;=^5001630
 ;;^UTILITY(U,$J,358.3,4851,0)
 ;;=C84.10^^22^216^462
 ;;^UTILITY(U,$J,358.3,4851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4851,1,3,0)
 ;;=3^Sezary Disease,Unspec Site
 ;;^UTILITY(U,$J,358.3,4851,1,4,0)
 ;;=4^C84.10
 ;;^UTILITY(U,$J,358.3,4851,2)
 ;;=^5001631
 ;;^UTILITY(U,$J,358.3,4852,0)
 ;;=C84.11^^22^216^455
 ;;^UTILITY(U,$J,358.3,4852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4852,1,3,0)
 ;;=3^Sezary Disease,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4852,1,4,0)
 ;;=4^C84.11
 ;;^UTILITY(U,$J,358.3,4852,2)
 ;;=^5001632
 ;;^UTILITY(U,$J,358.3,4853,0)
 ;;=C84.12^^22^216^459
 ;;^UTILITY(U,$J,358.3,4853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4853,1,3,0)
 ;;=3^Sezary Disease,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4853,1,4,0)
 ;;=4^C84.12
 ;;^UTILITY(U,$J,358.3,4853,2)
 ;;=^5001633
 ;;^UTILITY(U,$J,358.3,4854,0)
 ;;=C84.13^^22^216^457
 ;;^UTILITY(U,$J,358.3,4854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4854,1,3,0)
 ;;=3^Sezary Disease,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4854,1,4,0)
 ;;=4^C84.13
 ;;^UTILITY(U,$J,358.3,4854,2)
 ;;=^5001634
 ;;^UTILITY(U,$J,358.3,4855,0)
 ;;=C84.14^^22^216^453
 ;;^UTILITY(U,$J,358.3,4855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4855,1,3,0)
 ;;=3^Sezary Disease,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4855,1,4,0)
 ;;=4^C84.14
 ;;^UTILITY(U,$J,358.3,4855,2)
 ;;=^5001635
 ;;^UTILITY(U,$J,358.3,4856,0)
 ;;=C84.15^^22^216^456
 ;;^UTILITY(U,$J,358.3,4856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4856,1,3,0)
 ;;=3^Sezary Disease,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4856,1,4,0)
 ;;=4^C84.15
 ;;^UTILITY(U,$J,358.3,4856,2)
 ;;=^5001636
 ;;^UTILITY(U,$J,358.3,4857,0)
 ;;=C84.16^^22^216^458
 ;;^UTILITY(U,$J,358.3,4857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4857,1,3,0)
 ;;=3^Sezary Disease,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4857,1,4,0)
 ;;=4^C84.16
 ;;^UTILITY(U,$J,358.3,4857,2)
 ;;=^5001637
 ;;^UTILITY(U,$J,358.3,4858,0)
 ;;=C84.17^^22^216^461
 ;;^UTILITY(U,$J,358.3,4858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4858,1,3,0)
 ;;=3^Sezary Disease,Spleen
 ;;^UTILITY(U,$J,358.3,4858,1,4,0)
 ;;=4^C84.17
 ;;^UTILITY(U,$J,358.3,4858,2)
 ;;=^5001638
 ;;^UTILITY(U,$J,358.3,4859,0)
 ;;=C84.18^^22^216^460
 ;;^UTILITY(U,$J,358.3,4859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4859,1,3,0)
 ;;=3^Sezary Disease,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4859,1,4,0)
 ;;=4^C84.18
 ;;^UTILITY(U,$J,358.3,4859,2)
 ;;=^5001639
 ;;^UTILITY(U,$J,358.3,4860,0)
 ;;=C84.19^^22^216^454
 ;;^UTILITY(U,$J,358.3,4860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4860,1,3,0)
 ;;=3^Sezary Disease,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4860,1,4,0)
 ;;=4^C84.19
 ;;^UTILITY(U,$J,358.3,4860,2)
 ;;=^5001640
 ;;^UTILITY(U,$J,358.3,4861,0)
 ;;=C84.40^^22^216^441
 ;;^UTILITY(U,$J,358.3,4861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4861,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,4861,1,4,0)
 ;;=4^C84.40
 ;;^UTILITY(U,$J,358.3,4861,2)
 ;;=^5001641
 ;;^UTILITY(U,$J,358.3,4862,0)
 ;;=C84.41^^22^216^434
 ;;^UTILITY(U,$J,358.3,4862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4862,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4862,1,4,0)
 ;;=4^C84.41
 ;;^UTILITY(U,$J,358.3,4862,2)
 ;;=^5001642
 ;;^UTILITY(U,$J,358.3,4863,0)
 ;;=C84.42^^22^216^438
 ;;^UTILITY(U,$J,358.3,4863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4863,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4863,1,4,0)
 ;;=4^C84.42
 ;;^UTILITY(U,$J,358.3,4863,2)
 ;;=^5001643
 ;;^UTILITY(U,$J,358.3,4864,0)
 ;;=C84.43^^22^216^436
 ;;^UTILITY(U,$J,358.3,4864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4864,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4864,1,4,0)
 ;;=4^C84.43
 ;;^UTILITY(U,$J,358.3,4864,2)
 ;;=^5001644
 ;;^UTILITY(U,$J,358.3,4865,0)
 ;;=C84.44^^22^216^432
 ;;^UTILITY(U,$J,358.3,4865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4865,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4865,1,4,0)
 ;;=4^C84.44
 ;;^UTILITY(U,$J,358.3,4865,2)
 ;;=^5001645
 ;;^UTILITY(U,$J,358.3,4866,0)
 ;;=C84.45^^22^216^435
 ;;^UTILITY(U,$J,358.3,4866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4866,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4866,1,4,0)
 ;;=4^C84.45
 ;;^UTILITY(U,$J,358.3,4866,2)
 ;;=^5001646
 ;;^UTILITY(U,$J,358.3,4867,0)
 ;;=C84.46^^22^216^437
 ;;^UTILITY(U,$J,358.3,4867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4867,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Intrapelvic Node
 ;;^UTILITY(U,$J,358.3,4867,1,4,0)
 ;;=4^C84.46
 ;;^UTILITY(U,$J,358.3,4867,2)
 ;;=^5001647
 ;;^UTILITY(U,$J,358.3,4868,0)
 ;;=C84.47^^22^216^440
 ;;^UTILITY(U,$J,358.3,4868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4868,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Spleen
 ;;^UTILITY(U,$J,358.3,4868,1,4,0)
 ;;=4^C84.47
 ;;^UTILITY(U,$J,358.3,4868,2)
 ;;=^5001648
 ;;^UTILITY(U,$J,358.3,4869,0)
 ;;=C84.48^^22^216^439
 ;;^UTILITY(U,$J,358.3,4869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4869,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4869,1,4,0)
 ;;=4^C84.48
 ;;^UTILITY(U,$J,358.3,4869,2)
 ;;=^5001649
 ;;^UTILITY(U,$J,358.3,4870,0)
 ;;=C84.49^^22^216^433
 ;;^UTILITY(U,$J,358.3,4870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4870,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4870,1,4,0)
 ;;=4^C84.49
 ;;^UTILITY(U,$J,358.3,4870,2)
 ;;=^5001650
 ;;^UTILITY(U,$J,358.3,4871,0)
 ;;=C84.60^^22^216^47
 ;;^UTILITY(U,$J,358.3,4871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4871,1,3,0)
 ;;=3^Anaplastic Large Cell Lymphoma,ALK-Positive,Unspec Site
 ;;^UTILITY(U,$J,358.3,4871,1,4,0)
 ;;=4^C84.60
 ;;^UTILITY(U,$J,358.3,4871,2)
 ;;=^5001651
 ;;^UTILITY(U,$J,358.3,4872,0)
 ;;=C84.61^^22^216^48
 ;;^UTILITY(U,$J,358.3,4872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4872,1,3,0)
 ;;=3^Anaplastic Large Cell Lymphoma,ALK-Positive,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4872,1,4,0)
 ;;=4^C84.61
 ;;^UTILITY(U,$J,358.3,4872,2)
 ;;=^5001652
 ;;^UTILITY(U,$J,358.3,4873,0)
 ;;=C84.62^^22^216^49
 ;;^UTILITY(U,$J,358.3,4873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4873,1,3,0)
 ;;=3^Anaplastic Large Cell Lymphoma,ALK-Positive,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4873,1,4,0)
 ;;=4^C84.62
 ;;^UTILITY(U,$J,358.3,4873,2)
 ;;=^5001653
 ;;^UTILITY(U,$J,358.3,4874,0)
 ;;=C84.63^^22^216^50
 ;;^UTILITY(U,$J,358.3,4874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4874,1,3,0)
 ;;=3^Anaplastic Large Cell Lymphoma,ALK-Positive,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4874,1,4,0)
 ;;=4^C84.63
 ;;^UTILITY(U,$J,358.3,4874,2)
 ;;=^5001654
 ;;^UTILITY(U,$J,358.3,4875,0)
 ;;=C84.64^^22^216^51
 ;;^UTILITY(U,$J,358.3,4875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4875,1,3,0)
 ;;=3^Anaplastic Large Cell Lymphoma,ALK-Positive,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4875,1,4,0)
 ;;=4^C84.64
 ;;^UTILITY(U,$J,358.3,4875,2)
 ;;=^5001655
 ;;^UTILITY(U,$J,358.3,4876,0)
 ;;=C84.65^^22^216^52
 ;;^UTILITY(U,$J,358.3,4876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4876,1,3,0)
 ;;=3^Anaplastic Large Cell Lymphoma,ALK-Positive,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4876,1,4,0)
 ;;=4^C84.65
 ;;^UTILITY(U,$J,358.3,4876,2)
 ;;=^5001656
 ;;^UTILITY(U,$J,358.3,4877,0)
 ;;=C84.66^^22^216^53
 ;;^UTILITY(U,$J,358.3,4877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4877,1,3,0)
 ;;=3^Anaplastic Large Cell Lymphoma,ALK-Positive,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4877,1,4,0)
 ;;=4^C84.66
 ;;^UTILITY(U,$J,358.3,4877,2)
 ;;=^5001657
 ;;^UTILITY(U,$J,358.3,4878,0)
 ;;=C84.67^^22^216^54
 ;;^UTILITY(U,$J,358.3,4878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4878,1,3,0)
 ;;=3^Anaplastic Large Cell Lymphoma,ALK-Positive,Spleen
 ;;^UTILITY(U,$J,358.3,4878,1,4,0)
 ;;=4^C84.67
 ;;^UTILITY(U,$J,358.3,4878,2)
 ;;=^5001658
