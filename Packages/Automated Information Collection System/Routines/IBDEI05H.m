IBDEI05H ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6786,1,4,0)
 ;;=4^A53.9
 ;;^UTILITY(U,$J,358.3,6786,2)
 ;;=^5000310
 ;;^UTILITY(U,$J,358.3,6787,0)
 ;;=B37.3^^26^404^18
 ;;^UTILITY(U,$J,358.3,6787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6787,1,3,0)
 ;;=3^Candidiasis Vulva/Vagina
 ;;^UTILITY(U,$J,358.3,6787,1,4,0)
 ;;=4^B37.3
 ;;^UTILITY(U,$J,358.3,6787,2)
 ;;=^5000615
 ;;^UTILITY(U,$J,358.3,6788,0)
 ;;=B58.9^^26^404^86
 ;;^UTILITY(U,$J,358.3,6788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6788,1,3,0)
 ;;=3^Toxoplasmosis,Unspec
 ;;^UTILITY(U,$J,358.3,6788,1,4,0)
 ;;=4^B58.9
 ;;^UTILITY(U,$J,358.3,6788,2)
 ;;=^5000733
 ;;^UTILITY(U,$J,358.3,6789,0)
 ;;=A59.01^^26^404^87
 ;;^UTILITY(U,$J,358.3,6789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6789,1,3,0)
 ;;=3^Trichomonal Vulvovaginitis
 ;;^UTILITY(U,$J,358.3,6789,1,4,0)
 ;;=4^A59.01
 ;;^UTILITY(U,$J,358.3,6789,2)
 ;;=^121763
 ;;^UTILITY(U,$J,358.3,6790,0)
 ;;=B59.^^26^404^70
 ;;^UTILITY(U,$J,358.3,6790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6790,1,3,0)
 ;;=3^Pneumocystosis
 ;;^UTILITY(U,$J,358.3,6790,1,4,0)
 ;;=4^B59.
 ;;^UTILITY(U,$J,358.3,6790,2)
 ;;=^5000734
 ;;^UTILITY(U,$J,358.3,6791,0)
 ;;=H83.09^^26^404^49
 ;;^UTILITY(U,$J,358.3,6791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6791,1,3,0)
 ;;=3^Labyrinthitis,Unspec Ear
 ;;^UTILITY(U,$J,358.3,6791,1,4,0)
 ;;=4^H83.09
 ;;^UTILITY(U,$J,358.3,6791,2)
 ;;=^5006897
 ;;^UTILITY(U,$J,358.3,6792,0)
 ;;=H83.01^^26^404^48
 ;;^UTILITY(U,$J,358.3,6792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6792,1,3,0)
 ;;=3^Labyrinthitis,Right Ear
 ;;^UTILITY(U,$J,358.3,6792,1,4,0)
 ;;=4^H83.01
 ;;^UTILITY(U,$J,358.3,6792,2)
 ;;=^5006894
 ;;^UTILITY(U,$J,358.3,6793,0)
 ;;=H83.03^^26^404^46
 ;;^UTILITY(U,$J,358.3,6793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6793,1,3,0)
 ;;=3^Labyrinthitis,Bilateral
 ;;^UTILITY(U,$J,358.3,6793,1,4,0)
 ;;=4^H83.03
 ;;^UTILITY(U,$J,358.3,6793,2)
 ;;=^5006896
 ;;^UTILITY(U,$J,358.3,6794,0)
 ;;=H83.02^^26^404^47
 ;;^UTILITY(U,$J,358.3,6794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6794,1,3,0)
 ;;=3^Labyrinthitis,Left Ear
 ;;^UTILITY(U,$J,358.3,6794,1,4,0)
 ;;=4^H83.02
 ;;^UTILITY(U,$J,358.3,6794,2)
 ;;=^5006895
 ;;^UTILITY(U,$J,358.3,6795,0)
 ;;=J01.91^^26^404^80
 ;;^UTILITY(U,$J,358.3,6795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6795,1,3,0)
 ;;=3^Sinusitis,Acute Recurrent Unspec
 ;;^UTILITY(U,$J,358.3,6795,1,4,0)
 ;;=4^J01.91
 ;;^UTILITY(U,$J,358.3,6795,2)
 ;;=^5008128
 ;;^UTILITY(U,$J,358.3,6796,0)
 ;;=J03.90^^26^404^85
 ;;^UTILITY(U,$J,358.3,6796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6796,1,3,0)
 ;;=3^Tonsillitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,6796,1,4,0)
 ;;=4^J03.90
 ;;^UTILITY(U,$J,358.3,6796,2)
 ;;=^5008135
 ;;^UTILITY(U,$J,358.3,6797,0)
 ;;=J01.90^^26^404^81
 ;;^UTILITY(U,$J,358.3,6797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6797,1,3,0)
 ;;=3^Sinusitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,6797,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,6797,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,6798,0)
 ;;=J20.1^^26^404^11
 ;;^UTILITY(U,$J,358.3,6798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6798,1,3,0)
 ;;=3^Bronchitis,Acute d/t Hemophilus Influenza
 ;;^UTILITY(U,$J,358.3,6798,1,4,0)
 ;;=4^J20.1
 ;;^UTILITY(U,$J,358.3,6798,2)
 ;;=^5008187
 ;;^UTILITY(U,$J,358.3,6799,0)
 ;;=J20.0^^26^404^12
 ;;^UTILITY(U,$J,358.3,6799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6799,1,3,0)
 ;;=3^Bronchitis,Acute d/t Mycoplasma Pneumonia
 ;;^UTILITY(U,$J,358.3,6799,1,4,0)
 ;;=4^J20.0
 ;;^UTILITY(U,$J,358.3,6799,2)
 ;;=^5008186
 ;;^UTILITY(U,$J,358.3,6800,0)
 ;;=J20.2^^26^404^7
 ;;^UTILITY(U,$J,358.3,6800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6800,1,3,0)
 ;;=3^Bonchitis,Acute d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,6800,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,6800,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,6801,0)
 ;;=J20.4^^26^404^14
 ;;^UTILITY(U,$J,358.3,6801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6801,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,6801,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,6801,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,6802,0)
 ;;=J20.3^^26^404^9
 ;;^UTILITY(U,$J,358.3,6802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6802,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,6802,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,6802,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,6803,0)
 ;;=J20.9^^26^404^8
 ;;^UTILITY(U,$J,358.3,6803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6803,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,6803,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,6803,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,6804,0)
 ;;=J20.8^^26^404^13
 ;;^UTILITY(U,$J,358.3,6804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6804,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,6804,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,6804,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,6805,0)
 ;;=J20.5^^26^404^15
 ;;^UTILITY(U,$J,358.3,6805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6805,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,6805,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,6805,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,6806,0)
 ;;=J20.7^^26^404^10
 ;;^UTILITY(U,$J,358.3,6806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6806,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,6806,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,6806,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,6807,0)
 ;;=J20.6^^26^404^16
 ;;^UTILITY(U,$J,358.3,6807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6807,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,6807,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,6807,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,6808,0)
 ;;=J18.9^^26^404^71
 ;;^UTILITY(U,$J,358.3,6808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6808,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,6808,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,6808,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,6809,0)
 ;;=J18.8^^26^404^72
 ;;^UTILITY(U,$J,358.3,6809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6809,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,6809,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,6809,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,6810,0)
 ;;=J11.00^^26^404^29
 ;;^UTILITY(U,$J,358.3,6810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6810,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,6810,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,6810,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,6811,0)
 ;;=J12.9^^26^404^73
 ;;^UTILITY(U,$J,358.3,6811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6811,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,6811,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,6811,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,6812,0)
 ;;=J10.08^^26^404^42
 ;;^UTILITY(U,$J,358.3,6812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6812,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,6812,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,6812,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,6813,0)
 ;;=J10.00^^26^404^41
 ;;^UTILITY(U,$J,358.3,6813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6813,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,6813,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,6813,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,6814,0)
 ;;=J11.08^^26^404^44
 ;;^UTILITY(U,$J,358.3,6814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6814,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,6814,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,6814,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,6815,0)
 ;;=J10.1^^26^404^43
 ;;^UTILITY(U,$J,358.3,6815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6815,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,6815,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,6815,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,6816,0)
 ;;=J10.01^^26^404^40
 ;;^UTILITY(U,$J,358.3,6816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6816,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,6816,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,6816,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,6817,0)
 ;;=J11.1^^26^404^45
 ;;^UTILITY(U,$J,358.3,6817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6817,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,6817,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,6817,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,6818,0)
 ;;=N12.^^26^404^89
 ;;^UTILITY(U,$J,358.3,6818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6818,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,6818,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,6818,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,6819,0)
 ;;=N11.9^^26^404^90
 ;;^UTILITY(U,$J,358.3,6819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6819,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,6819,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,6819,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,6820,0)
 ;;=N13.6^^26^404^77
 ;;^UTILITY(U,$J,358.3,6820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6820,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,6820,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,6820,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,6821,0)
 ;;=N30.91^^26^404^20
 ;;^UTILITY(U,$J,358.3,6821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6821,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,6821,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,6821,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,6822,0)
 ;;=N30.90^^26^404^21
 ;;^UTILITY(U,$J,358.3,6822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6822,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,6822,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,6822,2)
 ;;=^5015642
