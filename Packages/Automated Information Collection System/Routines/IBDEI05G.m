IBDEI05G ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6750,0)
 ;;=Z94.7^^26^403^16
 ;;^UTILITY(U,$J,358.3,6750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6750,1,3,0)
 ;;=3^Corneal Transplant Status
 ;;^UTILITY(U,$J,358.3,6750,1,4,0)
 ;;=4^Z94.7
 ;;^UTILITY(U,$J,358.3,6750,2)
 ;;=^5063661
 ;;^UTILITY(U,$J,358.3,6751,0)
 ;;=Z83.511^^26^403^30
 ;;^UTILITY(U,$J,358.3,6751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6751,1,3,0)
 ;;=3^Family Hx of Glaucoma
 ;;^UTILITY(U,$J,358.3,6751,1,4,0)
 ;;=4^Z83.511
 ;;^UTILITY(U,$J,358.3,6751,2)
 ;;=^5063382
 ;;^UTILITY(U,$J,358.3,6752,0)
 ;;=Z80.52^^26^403^33
 ;;^UTILITY(U,$J,358.3,6752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6752,1,3,0)
 ;;=3^Family Hx of Malig Neop of Baldder
 ;;^UTILITY(U,$J,358.3,6752,1,4,0)
 ;;=4^Z80.52
 ;;^UTILITY(U,$J,358.3,6752,2)
 ;;=^5063352
 ;;^UTILITY(U,$J,358.3,6753,0)
 ;;=Z80.51^^26^403^36
 ;;^UTILITY(U,$J,358.3,6753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6753,1,3,0)
 ;;=3^Family Hx of Malig Neop of Kidney
 ;;^UTILITY(U,$J,358.3,6753,1,4,0)
 ;;=4^Z80.51
 ;;^UTILITY(U,$J,358.3,6753,2)
 ;;=^321159
 ;;^UTILITY(U,$J,358.3,6754,0)
 ;;=Z83.41^^26^403^43
 ;;^UTILITY(U,$J,358.3,6754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6754,1,3,0)
 ;;=3^Family Hx of Mult Endocrine Neoplasia Syndrome
 ;;^UTILITY(U,$J,358.3,6754,1,4,0)
 ;;=4^Z83.41
 ;;^UTILITY(U,$J,358.3,6754,2)
 ;;=^5063380
 ;;^UTILITY(U,$J,358.3,6755,0)
 ;;=Z81.8^^26^403^50
 ;;^UTILITY(U,$J,358.3,6755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6755,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence,Psychoactive
 ;;^UTILITY(U,$J,358.3,6755,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,6755,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,6756,0)
 ;;=Z81.4^^26^403^51
 ;;^UTILITY(U,$J,358.3,6756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6756,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence NEC
 ;;^UTILITY(U,$J,358.3,6756,1,4,0)
 ;;=4^Z81.4
 ;;^UTILITY(U,$J,358.3,6756,2)
 ;;=^5063362
 ;;^UTILITY(U,$J,358.3,6757,0)
 ;;=Z98.0^^26^403^62
 ;;^UTILITY(U,$J,358.3,6757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6757,1,3,0)
 ;;=3^Intestinal Bypass/Anastomosis Status
 ;;^UTILITY(U,$J,358.3,6757,1,4,0)
 ;;=4^Z98.0
 ;;^UTILITY(U,$J,358.3,6757,2)
 ;;=^5063733
 ;;^UTILITY(U,$J,358.3,6758,0)
 ;;=Z91.128^^26^403^61
 ;;^UTILITY(U,$J,358.3,6758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6758,1,3,0)
 ;;=3^Intentional Underdose of Meds d/t Other Reasons
 ;;^UTILITY(U,$J,358.3,6758,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,6758,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,6759,0)
 ;;=Z77.120^^26^403^67
 ;;^UTILITY(U,$J,358.3,6759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6759,1,3,0)
 ;;=3^Mold (Toxic) Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6759,1,4,0)
 ;;=4^Z77.120
 ;;^UTILITY(U,$J,358.3,6759,2)
 ;;=^5063318
 ;;^UTILITY(U,$J,358.3,6760,0)
 ;;=Z86.74^^26^403^110
 ;;^UTILITY(U,$J,358.3,6760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6760,1,3,0)
 ;;=3^Personal Hx of Sudden Cardiac Arrest 
 ;;^UTILITY(U,$J,358.3,6760,1,4,0)
 ;;=4^Z86.74
 ;;^UTILITY(U,$J,358.3,6760,2)
 ;;=^5063478
 ;;^UTILITY(U,$J,358.3,6761,0)
 ;;=Z86.718^^26^403^117
 ;;^UTILITY(U,$J,358.3,6761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6761,1,3,0)
 ;;=3^Personal Hx of Venous Thrombosis/Embolism (DVT)
 ;;^UTILITY(U,$J,358.3,6761,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,6761,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,6762,0)
 ;;=Z96.1^^26^403^127
 ;;^UTILITY(U,$J,358.3,6762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6762,1,3,0)
 ;;=3^Presence of Intraocular Lens
 ;;^UTILITY(U,$J,358.3,6762,1,4,0)
 ;;=4^Z96.1
 ;;^UTILITY(U,$J,358.3,6762,2)
 ;;=^5063682
 ;;^UTILITY(U,$J,358.3,6763,0)
 ;;=Z96.612^^26^403^132
 ;;^UTILITY(U,$J,358.3,6763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6763,1,3,0)
 ;;=3^Presence of Left Artificial Shoulder Joint
 ;;^UTILITY(U,$J,358.3,6763,1,4,0)
 ;;=4^Z96.612
 ;;^UTILITY(U,$J,358.3,6763,2)
 ;;=^5063693
 ;;^UTILITY(U,$J,358.3,6764,0)
 ;;=Z96.611^^26^403^137
 ;;^UTILITY(U,$J,358.3,6764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6764,1,3,0)
 ;;=3^Presence of Right Artificial Shoulder Joint
 ;;^UTILITY(U,$J,358.3,6764,1,4,0)
 ;;=4^Z96.611
 ;;^UTILITY(U,$J,358.3,6764,2)
 ;;=^5063692
 ;;^UTILITY(U,$J,358.3,6765,0)
 ;;=Z93.0^^26^403^145
 ;;^UTILITY(U,$J,358.3,6765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6765,1,3,0)
 ;;=3^Tracheostomy Status
 ;;^UTILITY(U,$J,358.3,6765,1,4,0)
 ;;=4^Z93.0
 ;;^UTILITY(U,$J,358.3,6765,2)
 ;;=^5063642
 ;;^UTILITY(U,$J,358.3,6766,0)
 ;;=Z99.3^^26^403^149
 ;;^UTILITY(U,$J,358.3,6766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6766,1,3,0)
 ;;=3^Wheelchair Dependence
 ;;^UTILITY(U,$J,358.3,6766,1,4,0)
 ;;=4^Z99.3
 ;;^UTILITY(U,$J,358.3,6766,2)
 ;;=^5063759
 ;;^UTILITY(U,$J,358.3,6767,0)
 ;;=A15.0^^26^404^88
 ;;^UTILITY(U,$J,358.3,6767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6767,1,3,0)
 ;;=3^Tuberculosis of Lung
 ;;^UTILITY(U,$J,358.3,6767,1,4,0)
 ;;=4^A15.0
 ;;^UTILITY(U,$J,358.3,6767,2)
 ;;=^5000062
 ;;^UTILITY(U,$J,358.3,6768,0)
 ;;=B20.^^26^404^32
 ;;^UTILITY(U,$J,358.3,6768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6768,1,3,0)
 ;;=3^HIV Disease
 ;;^UTILITY(U,$J,358.3,6768,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,6768,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,6769,0)
 ;;=B02.9^^26^404^97
 ;;^UTILITY(U,$J,358.3,6769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6769,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,6769,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,6769,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,6770,0)
 ;;=A60.9^^26^404^3
 ;;^UTILITY(U,$J,358.3,6770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6770,1,3,0)
 ;;=3^Anogenital Herpesviral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,6770,1,4,0)
 ;;=4^A60.9
 ;;^UTILITY(U,$J,358.3,6770,2)
 ;;=^5000359
 ;;^UTILITY(U,$J,358.3,6771,0)
 ;;=A60.04^^26^404^35
 ;;^UTILITY(U,$J,358.3,6771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6771,1,3,0)
 ;;=3^Herpesviral Vulvovaginitis
 ;;^UTILITY(U,$J,358.3,6771,1,4,0)
 ;;=4^A60.04
 ;;^UTILITY(U,$J,358.3,6771,2)
 ;;=^5000356
 ;;^UTILITY(U,$J,358.3,6772,0)
 ;;=A60.01^^26^404^33
 ;;^UTILITY(U,$J,358.3,6772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6772,1,3,0)
 ;;=3^Herpesviral Infection of Penis
 ;;^UTILITY(U,$J,358.3,6772,1,4,0)
 ;;=4^A60.01
 ;;^UTILITY(U,$J,358.3,6772,2)
 ;;=^5000353
 ;;^UTILITY(U,$J,358.3,6773,0)
 ;;=B00.1^^26^404^34
 ;;^UTILITY(U,$J,358.3,6773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6773,1,3,0)
 ;;=3^Herpesviral Vesicular Dermatitis
 ;;^UTILITY(U,$J,358.3,6773,1,4,0)
 ;;=4^B00.1
 ;;^UTILITY(U,$J,358.3,6773,2)
 ;;=^5000468
 ;;^UTILITY(U,$J,358.3,6774,0)
 ;;=B97.89^^26^404^93
 ;;^UTILITY(U,$J,358.3,6774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6774,1,3,0)
 ;;=3^Viral Agent Cause of Disease
 ;;^UTILITY(U,$J,358.3,6774,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,6774,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,6775,0)
 ;;=B97.10^^26^404^22
 ;;^UTILITY(U,$J,358.3,6775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6775,1,3,0)
 ;;=3^Enterovirus Cause of Disease
 ;;^UTILITY(U,$J,358.3,6775,1,4,0)
 ;;=4^B97.10
 ;;^UTILITY(U,$J,358.3,6775,2)
 ;;=^5000861
 ;;^UTILITY(U,$J,358.3,6776,0)
 ;;=B34.9^^26^404^94
 ;;^UTILITY(U,$J,358.3,6776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6776,1,3,0)
 ;;=3^Viral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,6776,1,4,0)
 ;;=4^B34.9
 ;;^UTILITY(U,$J,358.3,6776,2)
 ;;=^5000603
 ;;^UTILITY(U,$J,358.3,6777,0)
 ;;=A69.20^^26^404^51
 ;;^UTILITY(U,$J,358.3,6777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6777,1,3,0)
 ;;=3^Lyme Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6777,1,4,0)
 ;;=4^A69.20
 ;;^UTILITY(U,$J,358.3,6777,2)
 ;;=^5000375
 ;;^UTILITY(U,$J,358.3,6778,0)
 ;;=A69.22^^26^404^53
 ;;^UTILITY(U,$J,358.3,6778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6778,1,3,0)
 ;;=3^Neurologic Disorders d/t Lyme Disease
 ;;^UTILITY(U,$J,358.3,6778,1,4,0)
 ;;=4^A69.22
 ;;^UTILITY(U,$J,358.3,6778,2)
 ;;=^5000377
 ;;^UTILITY(U,$J,358.3,6779,0)
 ;;=A69.21^^26^404^52
 ;;^UTILITY(U,$J,358.3,6779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6779,1,3,0)
 ;;=3^Meningitis d/t Lyme Disease
 ;;^UTILITY(U,$J,358.3,6779,1,4,0)
 ;;=4^A69.21
 ;;^UTILITY(U,$J,358.3,6779,2)
 ;;=^5000376
 ;;^UTILITY(U,$J,358.3,6780,0)
 ;;=A69.29^^26^404^19
 ;;^UTILITY(U,$J,358.3,6780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6780,1,3,0)
 ;;=3^Conditions d/t Lyme Disease
 ;;^UTILITY(U,$J,358.3,6780,1,4,0)
 ;;=4^A69.29
 ;;^UTILITY(U,$J,358.3,6780,2)
 ;;=^5000379
 ;;^UTILITY(U,$J,358.3,6781,0)
 ;;=A69.23^^26^404^6
 ;;^UTILITY(U,$J,358.3,6781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6781,1,3,0)
 ;;=3^Arthritis d/t Lyme Disease
 ;;^UTILITY(U,$J,358.3,6781,1,4,0)
 ;;=4^A69.23
 ;;^UTILITY(U,$J,358.3,6781,2)
 ;;=^5000378
 ;;^UTILITY(U,$J,358.3,6782,0)
 ;;=A51.0^^26^404^30
 ;;^UTILITY(U,$J,358.3,6782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6782,1,3,0)
 ;;=3^Genital Syphilis,Primary
 ;;^UTILITY(U,$J,358.3,6782,1,4,0)
 ;;=4^A51.0
 ;;^UTILITY(U,$J,358.3,6782,2)
 ;;=^5000272
 ;;^UTILITY(U,$J,358.3,6783,0)
 ;;=A52.3^^26^404^55
 ;;^UTILITY(U,$J,358.3,6783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6783,1,3,0)
 ;;=3^Neurosyphilis,Unspec
 ;;^UTILITY(U,$J,358.3,6783,1,4,0)
 ;;=4^A52.3
 ;;^UTILITY(U,$J,358.3,6783,2)
 ;;=^5000298
 ;;^UTILITY(U,$J,358.3,6784,0)
 ;;=A52.10^^26^404^54
 ;;^UTILITY(U,$J,358.3,6784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6784,1,3,0)
 ;;=3^Neurosyphilis Symptomatic,Unspec
 ;;^UTILITY(U,$J,358.3,6784,1,4,0)
 ;;=4^A52.10
 ;;^UTILITY(U,$J,358.3,6784,2)
 ;;=^5000291
 ;;^UTILITY(U,$J,358.3,6785,0)
 ;;=A52.9^^26^404^50
 ;;^UTILITY(U,$J,358.3,6785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6785,1,3,0)
 ;;=3^Late Syphilis,Unspec
 ;;^UTILITY(U,$J,358.3,6785,1,4,0)
 ;;=4^A52.9
 ;;^UTILITY(U,$J,358.3,6785,2)
 ;;=^5000308
 ;;^UTILITY(U,$J,358.3,6786,0)
 ;;=A53.9^^26^404^83
 ;;^UTILITY(U,$J,358.3,6786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6786,1,3,0)
 ;;=3^Syphilis,Unspec
