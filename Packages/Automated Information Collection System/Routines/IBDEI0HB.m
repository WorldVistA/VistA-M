IBDEI0HB ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21935,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,21935,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,21935,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,21936,0)
 ;;=J20.8^^58^842^12
 ;;^UTILITY(U,$J,358.3,21936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21936,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,21936,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,21936,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,21937,0)
 ;;=J20.5^^58^842^14
 ;;^UTILITY(U,$J,358.3,21937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21937,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,21937,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,21937,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,21938,0)
 ;;=J20.7^^58^842^9
 ;;^UTILITY(U,$J,358.3,21938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21938,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,21938,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,21938,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,21939,0)
 ;;=J20.6^^58^842^15
 ;;^UTILITY(U,$J,358.3,21939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21939,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,21939,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,21939,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,21940,0)
 ;;=J18.9^^58^842^67
 ;;^UTILITY(U,$J,358.3,21940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21940,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,21940,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,21940,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,21941,0)
 ;;=J18.8^^58^842^68
 ;;^UTILITY(U,$J,358.3,21941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21941,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,21941,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,21941,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,21942,0)
 ;;=J11.00^^58^842^28
 ;;^UTILITY(U,$J,358.3,21942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21942,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,21942,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,21942,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,21943,0)
 ;;=J12.9^^58^842^69
 ;;^UTILITY(U,$J,358.3,21943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21943,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,21943,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,21943,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,21944,0)
 ;;=J10.08^^58^842^41
 ;;^UTILITY(U,$J,358.3,21944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21944,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,21944,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,21944,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,21945,0)
 ;;=J10.00^^58^842^40
 ;;^UTILITY(U,$J,358.3,21945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21945,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,21945,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,21945,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,21946,0)
 ;;=J11.08^^58^842^43
 ;;^UTILITY(U,$J,358.3,21946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21946,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,21946,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,21946,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,21947,0)
 ;;=J10.1^^58^842^42
 ;;^UTILITY(U,$J,358.3,21947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21947,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,21947,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,21947,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,21948,0)
 ;;=J10.01^^58^842^39
 ;;^UTILITY(U,$J,358.3,21948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21948,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,21948,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,21948,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,21949,0)
 ;;=J11.1^^58^842^44
 ;;^UTILITY(U,$J,358.3,21949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21949,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,21949,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,21949,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,21950,0)
 ;;=N12.^^58^842^85
 ;;^UTILITY(U,$J,358.3,21950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21950,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,21950,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,21950,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,21951,0)
 ;;=N11.9^^58^842^86
 ;;^UTILITY(U,$J,358.3,21951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21951,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,21951,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,21951,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,21952,0)
 ;;=N13.6^^58^842^73
 ;;^UTILITY(U,$J,358.3,21952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21952,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,21952,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,21952,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,21953,0)
 ;;=N30.91^^58^842^19
 ;;^UTILITY(U,$J,358.3,21953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21953,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,21953,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,21953,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,21954,0)
 ;;=N30.90^^58^842^20
 ;;^UTILITY(U,$J,358.3,21954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21954,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,21954,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,21954,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,21955,0)
 ;;=N41.9^^58^842^38
 ;;^UTILITY(U,$J,358.3,21955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21955,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
 ;;^UTILITY(U,$J,358.3,21955,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,21955,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,21956,0)
 ;;=N70.91^^58^842^75
 ;;^UTILITY(U,$J,358.3,21956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21956,1,3,0)
 ;;=3^Salpingitis,Unspec
 ;;^UTILITY(U,$J,358.3,21956,1,4,0)
 ;;=4^N70.91
 ;;^UTILITY(U,$J,358.3,21956,2)
 ;;=^5015806
 ;;^UTILITY(U,$J,358.3,21957,0)
 ;;=N70.93^^58^842^74
 ;;^UTILITY(U,$J,358.3,21957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21957,1,3,0)
 ;;=3^Salpingitis & Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,21957,1,4,0)
 ;;=4^N70.93
 ;;^UTILITY(U,$J,358.3,21957,2)
 ;;=^5015808
 ;;^UTILITY(U,$J,358.3,21958,0)
 ;;=N70.92^^58^842^55
 ;;^UTILITY(U,$J,358.3,21958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21958,1,3,0)
 ;;=3^Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,21958,1,4,0)
 ;;=4^N70.92
 ;;^UTILITY(U,$J,358.3,21958,2)
 ;;=^5015807
 ;;^UTILITY(U,$J,358.3,21959,0)
 ;;=N73.9^^58^842^37
 ;;^UTILITY(U,$J,358.3,21959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21959,1,3,0)
 ;;=3^Inflammatory Disease Female Pelvic,Unspec
 ;;^UTILITY(U,$J,358.3,21959,1,4,0)
 ;;=4^N73.9
 ;;^UTILITY(U,$J,358.3,21959,2)
 ;;=^5015820
 ;;^UTILITY(U,$J,358.3,21960,0)
 ;;=A56.11^^58^842^36
 ;;^UTILITY(U,$J,358.3,21960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21960,1,3,0)
 ;;=3^Inflammatory Disease Chlamydial Female Pelvic
 ;;^UTILITY(U,$J,358.3,21960,1,4,0)
 ;;=4^A56.11
 ;;^UTILITY(U,$J,358.3,21960,2)
 ;;=^5000342
 ;;^UTILITY(U,$J,358.3,21961,0)
 ;;=N73.5^^58^842^64
 ;;^UTILITY(U,$J,358.3,21961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21961,1,3,0)
 ;;=3^Peritonitis Female Pelvic,Unspec
 ;;^UTILITY(U,$J,358.3,21961,1,4,0)
 ;;=4^N73.5
 ;;^UTILITY(U,$J,358.3,21961,2)
 ;;=^5015817
 ;;^UTILITY(U,$J,358.3,21962,0)
 ;;=N72.^^58^842^35
 ;;^UTILITY(U,$J,358.3,21962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21962,1,3,0)
 ;;=3^Inflammatory Disease Cervix Uteri
 ;;^UTILITY(U,$J,358.3,21962,1,4,0)
 ;;=4^N72.
 ;;^UTILITY(U,$J,358.3,21962,2)
 ;;=^5015812
 ;;^UTILITY(U,$J,358.3,21963,0)
 ;;=N76.3^^58^842^92
 ;;^UTILITY(U,$J,358.3,21963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21963,1,3,0)
 ;;=3^Vulvitis,Subacute & Chronic
 ;;^UTILITY(U,$J,358.3,21963,1,4,0)
 ;;=4^N76.3
 ;;^UTILITY(U,$J,358.3,21963,2)
 ;;=^5015829
 ;;^UTILITY(U,$J,358.3,21964,0)
 ;;=N76.1^^58^842^88
 ;;^UTILITY(U,$J,358.3,21964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21964,1,3,0)
 ;;=3^Vaginitis,Subacute & Chronic
 ;;^UTILITY(U,$J,358.3,21964,1,4,0)
 ;;=4^N76.1
 ;;^UTILITY(U,$J,358.3,21964,2)
 ;;=^5015827
 ;;^UTILITY(U,$J,358.3,21965,0)
 ;;=N76.2^^58^842^91
 ;;^UTILITY(U,$J,358.3,21965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21965,1,3,0)
 ;;=3^Vulvitis,Acute
 ;;^UTILITY(U,$J,358.3,21965,1,4,0)
 ;;=4^N76.2
 ;;^UTILITY(U,$J,358.3,21965,2)
 ;;=^5015828
 ;;^UTILITY(U,$J,358.3,21966,0)
 ;;=N76.0^^58^842^87
 ;;^UTILITY(U,$J,358.3,21966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21966,1,3,0)
 ;;=3^Vaginitis,Acute
 ;;^UTILITY(U,$J,358.3,21966,1,4,0)
 ;;=4^N76.0
 ;;^UTILITY(U,$J,358.3,21966,2)
 ;;=^5015826
 ;;^UTILITY(U,$J,358.3,21967,0)
 ;;=M00.20^^58^842^3
 ;;^UTILITY(U,$J,358.3,21967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21967,1,3,0)
 ;;=3^Arthritis Streptococcal,Unspec Joint
 ;;^UTILITY(U,$J,358.3,21967,1,4,0)
 ;;=4^M00.20
 ;;^UTILITY(U,$J,358.3,21967,2)
 ;;=^5009645
 ;;^UTILITY(U,$J,358.3,21968,0)
 ;;=M00.80^^58^842^4
 ;;^UTILITY(U,$J,358.3,21968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21968,1,3,0)
 ;;=3^Arthritis d/t Bacteria,Unspec Joint
 ;;^UTILITY(U,$J,358.3,21968,1,4,0)
 ;;=4^M00.80
 ;;^UTILITY(U,$J,358.3,21968,2)
 ;;=^5009669
 ;;^UTILITY(U,$J,358.3,21969,0)
 ;;=M00.9^^58^842^72
 ;;^UTILITY(U,$J,358.3,21969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21969,1,3,0)
 ;;=3^Pyogenic Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,21969,1,4,0)
 ;;=4^M00.9
 ;;^UTILITY(U,$J,358.3,21969,2)
 ;;=^5009693
 ;;^UTILITY(U,$J,358.3,21970,0)
 ;;=M00.00^^58^842^78
 ;;^UTILITY(U,$J,358.3,21970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21970,1,3,0)
 ;;=3^Staphylococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,21970,1,4,0)
 ;;=4^M00.00
