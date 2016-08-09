IBDEI0K0 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20163,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,20163,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,20163,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,20164,0)
 ;;=J20.5^^86^996^14
 ;;^UTILITY(U,$J,358.3,20164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20164,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,20164,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,20164,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,20165,0)
 ;;=J20.7^^86^996^9
 ;;^UTILITY(U,$J,358.3,20165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20165,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,20165,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,20165,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,20166,0)
 ;;=J20.6^^86^996^15
 ;;^UTILITY(U,$J,358.3,20166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20166,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,20166,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,20166,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,20167,0)
 ;;=J18.9^^86^996^67
 ;;^UTILITY(U,$J,358.3,20167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20167,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,20167,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,20167,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,20168,0)
 ;;=J18.8^^86^996^68
 ;;^UTILITY(U,$J,358.3,20168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20168,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,20168,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,20168,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,20169,0)
 ;;=J11.00^^86^996^28
 ;;^UTILITY(U,$J,358.3,20169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20169,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,20169,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,20169,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,20170,0)
 ;;=J12.9^^86^996^69
 ;;^UTILITY(U,$J,358.3,20170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20170,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,20170,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,20170,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,20171,0)
 ;;=J10.08^^86^996^41
 ;;^UTILITY(U,$J,358.3,20171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20171,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,20171,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,20171,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,20172,0)
 ;;=J10.00^^86^996^40
 ;;^UTILITY(U,$J,358.3,20172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20172,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,20172,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,20172,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,20173,0)
 ;;=J11.08^^86^996^43
 ;;^UTILITY(U,$J,358.3,20173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20173,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,20173,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,20173,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,20174,0)
 ;;=J10.1^^86^996^42
 ;;^UTILITY(U,$J,358.3,20174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20174,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,20174,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,20174,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,20175,0)
 ;;=J10.01^^86^996^39
 ;;^UTILITY(U,$J,358.3,20175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20175,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,20175,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,20175,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,20176,0)
 ;;=J11.1^^86^996^44
 ;;^UTILITY(U,$J,358.3,20176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20176,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,20176,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,20176,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,20177,0)
 ;;=N12.^^86^996^85
 ;;^UTILITY(U,$J,358.3,20177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20177,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,20177,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,20177,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,20178,0)
 ;;=N11.9^^86^996^86
 ;;^UTILITY(U,$J,358.3,20178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20178,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,20178,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,20178,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,20179,0)
 ;;=N13.6^^86^996^73
 ;;^UTILITY(U,$J,358.3,20179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20179,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,20179,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,20179,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,20180,0)
 ;;=N30.91^^86^996^19
 ;;^UTILITY(U,$J,358.3,20180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20180,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,20180,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,20180,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,20181,0)
 ;;=N30.90^^86^996^20
 ;;^UTILITY(U,$J,358.3,20181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20181,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,20181,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,20181,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,20182,0)
 ;;=N41.9^^86^996^38
 ;;^UTILITY(U,$J,358.3,20182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20182,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
 ;;^UTILITY(U,$J,358.3,20182,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,20182,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,20183,0)
 ;;=N70.91^^86^996^75
 ;;^UTILITY(U,$J,358.3,20183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20183,1,3,0)
 ;;=3^Salpingitis,Unspec
 ;;^UTILITY(U,$J,358.3,20183,1,4,0)
 ;;=4^N70.91
 ;;^UTILITY(U,$J,358.3,20183,2)
 ;;=^5015806
 ;;^UTILITY(U,$J,358.3,20184,0)
 ;;=N70.93^^86^996^74
 ;;^UTILITY(U,$J,358.3,20184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20184,1,3,0)
 ;;=3^Salpingitis & Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,20184,1,4,0)
 ;;=4^N70.93
 ;;^UTILITY(U,$J,358.3,20184,2)
 ;;=^5015808
 ;;^UTILITY(U,$J,358.3,20185,0)
 ;;=N70.92^^86^996^55
 ;;^UTILITY(U,$J,358.3,20185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20185,1,3,0)
 ;;=3^Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,20185,1,4,0)
 ;;=4^N70.92
 ;;^UTILITY(U,$J,358.3,20185,2)
 ;;=^5015807
 ;;^UTILITY(U,$J,358.3,20186,0)
 ;;=N73.9^^86^996^37
 ;;^UTILITY(U,$J,358.3,20186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20186,1,3,0)
 ;;=3^Inflammatory Disease Female Pelvic,Unspec
 ;;^UTILITY(U,$J,358.3,20186,1,4,0)
 ;;=4^N73.9
 ;;^UTILITY(U,$J,358.3,20186,2)
 ;;=^5015820
 ;;^UTILITY(U,$J,358.3,20187,0)
 ;;=A56.11^^86^996^36
 ;;^UTILITY(U,$J,358.3,20187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20187,1,3,0)
 ;;=3^Inflammatory Disease Chlamydial Female Pelvic
 ;;^UTILITY(U,$J,358.3,20187,1,4,0)
 ;;=4^A56.11
 ;;^UTILITY(U,$J,358.3,20187,2)
 ;;=^5000342
 ;;^UTILITY(U,$J,358.3,20188,0)
 ;;=N73.5^^86^996^64
 ;;^UTILITY(U,$J,358.3,20188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20188,1,3,0)
 ;;=3^Peritonitis Female Pelvic,Unspec
 ;;^UTILITY(U,$J,358.3,20188,1,4,0)
 ;;=4^N73.5
 ;;^UTILITY(U,$J,358.3,20188,2)
 ;;=^5015817
 ;;^UTILITY(U,$J,358.3,20189,0)
 ;;=N72.^^86^996^35
 ;;^UTILITY(U,$J,358.3,20189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20189,1,3,0)
 ;;=3^Inflammatory Disease Cervix Uteri
 ;;^UTILITY(U,$J,358.3,20189,1,4,0)
 ;;=4^N72.
 ;;^UTILITY(U,$J,358.3,20189,2)
 ;;=^5015812
 ;;^UTILITY(U,$J,358.3,20190,0)
 ;;=N76.3^^86^996^92
 ;;^UTILITY(U,$J,358.3,20190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20190,1,3,0)
 ;;=3^Vulvitis,Subacute & Chronic
 ;;^UTILITY(U,$J,358.3,20190,1,4,0)
 ;;=4^N76.3
 ;;^UTILITY(U,$J,358.3,20190,2)
 ;;=^5015829
 ;;^UTILITY(U,$J,358.3,20191,0)
 ;;=N76.1^^86^996^88
