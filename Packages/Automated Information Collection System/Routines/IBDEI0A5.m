IBDEI0A5 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12859,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,12859,1,4,0)
 ;;=4^L97.921
 ;;^UTILITY(U,$J,358.3,12859,2)
 ;;=^5133680
 ;;^UTILITY(U,$J,358.3,12860,0)
 ;;=L97.922^^43^613^192
 ;;^UTILITY(U,$J,358.3,12860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12860,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,12860,1,4,0)
 ;;=4^L97.922
 ;;^UTILITY(U,$J,358.3,12860,2)
 ;;=^5133682
 ;;^UTILITY(U,$J,358.3,12861,0)
 ;;=L97.923^^43^613^193
 ;;^UTILITY(U,$J,358.3,12861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12861,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,12861,1,4,0)
 ;;=4^L97.923
 ;;^UTILITY(U,$J,358.3,12861,2)
 ;;=^5133684
 ;;^UTILITY(U,$J,358.3,12862,0)
 ;;=L97.924^^43^613^194
 ;;^UTILITY(U,$J,358.3,12862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12862,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,12862,1,4,0)
 ;;=4^L97.924
 ;;^UTILITY(U,$J,358.3,12862,2)
 ;;=^5133686
 ;;^UTILITY(U,$J,358.3,12863,0)
 ;;=L97.929^^43^613^195
 ;;^UTILITY(U,$J,358.3,12863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12863,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,12863,1,4,0)
 ;;=4^L97.929
 ;;^UTILITY(U,$J,358.3,12863,2)
 ;;=^5133689
 ;;^UTILITY(U,$J,358.3,12864,0)
 ;;=L98.2^^43^613^149
 ;;^UTILITY(U,$J,358.3,12864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12864,1,3,0)
 ;;=3^Febrile Neutrophilic Dermatosis
 ;;^UTILITY(U,$J,358.3,12864,1,4,0)
 ;;=4^L98.2
 ;;^UTILITY(U,$J,358.3,12864,2)
 ;;=^5009575
 ;;^UTILITY(U,$J,358.3,12865,0)
 ;;=L98.9^^43^613^267
 ;;^UTILITY(U,$J,358.3,12865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12865,1,3,0)
 ;;=3^Skin/Subcutaneous Tissue Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,12865,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,12865,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,12866,0)
 ;;=I70.731^^43^613^80
 ;;^UTILITY(U,$J,358.3,12866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12866,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,12866,1,4,0)
 ;;=4^I70.731
 ;;^UTILITY(U,$J,358.3,12866,2)
 ;;=^5007769
 ;;^UTILITY(U,$J,358.3,12867,0)
 ;;=I70.732^^43^613^81
 ;;^UTILITY(U,$J,358.3,12867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12867,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,12867,1,4,0)
 ;;=4^I70.732
 ;;^UTILITY(U,$J,358.3,12867,2)
 ;;=^5007770
 ;;^UTILITY(U,$J,358.3,12868,0)
 ;;=I70.733^^43^613^82
 ;;^UTILITY(U,$J,358.3,12868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12868,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,12868,1,4,0)
 ;;=4^I70.733
 ;;^UTILITY(U,$J,358.3,12868,2)
 ;;=^5007771
 ;;^UTILITY(U,$J,358.3,12869,0)
 ;;=I70.734^^43^613^83
 ;;^UTILITY(U,$J,358.3,12869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12869,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,12869,1,4,0)
 ;;=4^I70.734
 ;;^UTILITY(U,$J,358.3,12869,2)
 ;;=^5007772
 ;;^UTILITY(U,$J,358.3,12870,0)
 ;;=I70.735^^43^613^84
 ;;^UTILITY(U,$J,358.3,12870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12870,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Oth Part Foot Ulcer
 ;;^UTILITY(U,$J,358.3,12870,1,4,0)
 ;;=4^I70.735
 ;;^UTILITY(U,$J,358.3,12870,2)
 ;;=^5007773
 ;;^UTILITY(U,$J,358.3,12871,0)
 ;;=I70.741^^43^613^79
 ;;^UTILITY(U,$J,358.3,12871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12871,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,12871,1,4,0)
 ;;=4^I70.741
 ;;^UTILITY(U,$J,358.3,12871,2)
 ;;=^5133601
 ;;^UTILITY(U,$J,358.3,12872,0)
 ;;=I70.742^^43^613^76
 ;;^UTILITY(U,$J,358.3,12872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12872,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,12872,1,4,0)
 ;;=4^I70.742
 ;;^UTILITY(U,$J,358.3,12872,2)
 ;;=^5133602
 ;;^UTILITY(U,$J,358.3,12873,0)
 ;;=I70.743^^43^613^75
 ;;^UTILITY(U,$J,358.3,12873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12873,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,12873,1,4,0)
 ;;=4^I70.743
 ;;^UTILITY(U,$J,358.3,12873,2)
 ;;=^5133603
 ;;^UTILITY(U,$J,358.3,12874,0)
 ;;=I70.744^^43^613^77
 ;;^UTILITY(U,$J,358.3,12874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12874,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,12874,1,4,0)
 ;;=4^I70.744
 ;;^UTILITY(U,$J,358.3,12874,2)
 ;;=^5133604
 ;;^UTILITY(U,$J,358.3,12875,0)
 ;;=I70.745^^43^613^78
 ;;^UTILITY(U,$J,358.3,12875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12875,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Oth Part Foot Ulcer
 ;;^UTILITY(U,$J,358.3,12875,1,4,0)
 ;;=4^I70.745
 ;;^UTILITY(U,$J,358.3,12875,2)
 ;;=^5133605
 ;;^UTILITY(U,$J,358.3,12876,0)
 ;;=I83.009^^43^613^287
 ;;^UTILITY(U,$J,358.3,12876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12876,1,3,0)
 ;;=3^Varicose Veins of Lower Extremity w/ Ulcer
 ;;^UTILITY(U,$J,358.3,12876,1,4,0)
 ;;=4^I83.009
 ;;^UTILITY(U,$J,358.3,12876,2)
 ;;=^5007972
 ;;^UTILITY(U,$J,358.3,12877,0)
 ;;=H65.03^^43^614^3
 ;;^UTILITY(U,$J,358.3,12877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12877,1,3,0)
 ;;=3^Acute Serous Otitis Media,Bilateral
 ;;^UTILITY(U,$J,358.3,12877,1,4,0)
 ;;=4^H65.03
 ;;^UTILITY(U,$J,358.3,12877,2)
 ;;=^5006572
 ;;^UTILITY(U,$J,358.3,12878,0)
 ;;=H65.01^^43^614^5
 ;;^UTILITY(U,$J,358.3,12878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12878,1,3,0)
 ;;=3^Acute Serous Otitis Media,Right Ear
 ;;^UTILITY(U,$J,358.3,12878,1,4,0)
 ;;=4^H65.01
 ;;^UTILITY(U,$J,358.3,12878,2)
 ;;=^5006570
 ;;^UTILITY(U,$J,358.3,12879,0)
 ;;=H65.23^^43^614^15
 ;;^UTILITY(U,$J,358.3,12879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12879,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Bilateral
 ;;^UTILITY(U,$J,358.3,12879,1,4,0)
 ;;=4^H65.23
 ;;^UTILITY(U,$J,358.3,12879,2)
 ;;=^5006596
 ;;^UTILITY(U,$J,358.3,12880,0)
 ;;=H65.22^^43^614^16
 ;;^UTILITY(U,$J,358.3,12880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12880,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Left Ear
 ;;^UTILITY(U,$J,358.3,12880,1,4,0)
 ;;=4^H65.22
 ;;^UTILITY(U,$J,358.3,12880,2)
 ;;=^5006595
 ;;^UTILITY(U,$J,358.3,12881,0)
 ;;=H65.21^^43^614^17
 ;;^UTILITY(U,$J,358.3,12881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12881,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Right Ear
 ;;^UTILITY(U,$J,358.3,12881,1,4,0)
 ;;=4^H65.21
 ;;^UTILITY(U,$J,358.3,12881,2)
 ;;=^5006594
 ;;^UTILITY(U,$J,358.3,12882,0)
 ;;=H66.012^^43^614^6
 ;;^UTILITY(U,$J,358.3,12882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12882,1,3,0)
 ;;=3^Acute Suppr Otitis Media w/ Spon Rupt Ear Drum,Left Ear
 ;;^UTILITY(U,$J,358.3,12882,1,4,0)
 ;;=4^H66.012
 ;;^UTILITY(U,$J,358.3,12882,2)
 ;;=^5133534
 ;;^UTILITY(U,$J,358.3,12883,0)
 ;;=H66.011^^43^614^7
 ;;^UTILITY(U,$J,358.3,12883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12883,1,3,0)
 ;;=3^Acute Suppr Otitis Media w/ Spon Rupt Ear Drum,Right Ear
 ;;^UTILITY(U,$J,358.3,12883,1,4,0)
 ;;=4^H66.011
 ;;^UTILITY(U,$J,358.3,12883,2)
 ;;=^5006621
 ;;^UTILITY(U,$J,358.3,12884,0)
 ;;=H66.91^^43^614^36
 ;;^UTILITY(U,$J,358.3,12884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12884,1,3,0)
 ;;=3^Otitis Media,Unspec,Right Ear
 ;;^UTILITY(U,$J,358.3,12884,1,4,0)
 ;;=4^H66.91
 ;;^UTILITY(U,$J,358.3,12884,2)
 ;;=^5006640
 ;;^UTILITY(U,$J,358.3,12885,0)
 ;;=H66.92^^43^614^35
 ;;^UTILITY(U,$J,358.3,12885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12885,1,3,0)
 ;;=3^Otitis Media,Unspec,Left Ear
 ;;^UTILITY(U,$J,358.3,12885,1,4,0)
 ;;=4^H66.92
 ;;^UTILITY(U,$J,358.3,12885,2)
 ;;=^5006641
 ;;^UTILITY(U,$J,358.3,12886,0)
 ;;=H66.93^^43^614^34
 ;;^UTILITY(U,$J,358.3,12886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12886,1,3,0)
 ;;=3^Otitis Media,Unspec,Bilateral
 ;;^UTILITY(U,$J,358.3,12886,1,4,0)
 ;;=4^H66.93
 ;;^UTILITY(U,$J,358.3,12886,2)
 ;;=^5006642
 ;;^UTILITY(U,$J,358.3,12887,0)
 ;;=H81.10^^43^614^37
 ;;^UTILITY(U,$J,358.3,12887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12887,1,3,0)
 ;;=3^Paroxysmal Veritgo,Benign,Unspec Ear
 ;;^UTILITY(U,$J,358.3,12887,1,4,0)
 ;;=4^H81.10
 ;;^UTILITY(U,$J,358.3,12887,2)
 ;;=^5006864
 ;;^UTILITY(U,$J,358.3,12888,0)
 ;;=H93.13^^43^614^38
 ;;^UTILITY(U,$J,358.3,12888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12888,1,3,0)
 ;;=3^Tinnitus,Bilateral
 ;;^UTILITY(U,$J,358.3,12888,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,12888,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,12889,0)
 ;;=H93.12^^43^614^39
 ;;^UTILITY(U,$J,358.3,12889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12889,1,3,0)
 ;;=3^Tinnitus,Left Ear
 ;;^UTILITY(U,$J,358.3,12889,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,12889,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,12890,0)
 ;;=H93.11^^43^614^40
 ;;^UTILITY(U,$J,358.3,12890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12890,1,3,0)
 ;;=3^Tinnitus,Right Ear
 ;;^UTILITY(U,$J,358.3,12890,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,12890,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,12891,0)
 ;;=H92.01^^43^614^33
 ;;^UTILITY(U,$J,358.3,12891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12891,1,3,0)
 ;;=3^Otalgia,Right Ear
 ;;^UTILITY(U,$J,358.3,12891,1,4,0)
 ;;=4^H92.01
 ;;^UTILITY(U,$J,358.3,12891,2)
 ;;=^5006945
 ;;^UTILITY(U,$J,358.3,12892,0)
 ;;=H92.02^^43^614^32
 ;;^UTILITY(U,$J,358.3,12892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12892,1,3,0)
 ;;=3^Otalgia,Left Ear
 ;;^UTILITY(U,$J,358.3,12892,1,4,0)
 ;;=4^H92.02
 ;;^UTILITY(U,$J,358.3,12892,2)
 ;;=^5006946
 ;;^UTILITY(U,$J,358.3,12893,0)
 ;;=H92.03^^43^614^31
 ;;^UTILITY(U,$J,358.3,12893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12893,1,3,0)
 ;;=3^Otalgia,Bilateral
