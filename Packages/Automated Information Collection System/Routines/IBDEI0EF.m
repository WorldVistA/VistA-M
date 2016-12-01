IBDEI0EF ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18218,1,4,0)
 ;;=4^A60.9
 ;;^UTILITY(U,$J,358.3,18218,2)
 ;;=^5000359
 ;;^UTILITY(U,$J,358.3,18219,0)
 ;;=M00.20^^53^755^4
 ;;^UTILITY(U,$J,358.3,18219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18219,1,3,0)
 ;;=3^Arthritis Streptococcal,Unspec Joint
 ;;^UTILITY(U,$J,358.3,18219,1,4,0)
 ;;=4^M00.20
 ;;^UTILITY(U,$J,358.3,18219,2)
 ;;=^5009645
 ;;^UTILITY(U,$J,358.3,18220,0)
 ;;=M00.80^^53^755^5
 ;;^UTILITY(U,$J,358.3,18220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18220,1,3,0)
 ;;=3^Arthritis d/t Bacteria,Unspec Joint
 ;;^UTILITY(U,$J,358.3,18220,1,4,0)
 ;;=4^M00.80
 ;;^UTILITY(U,$J,358.3,18220,2)
 ;;=^5009669
 ;;^UTILITY(U,$J,358.3,18221,0)
 ;;=A69.23^^53^755^6
 ;;^UTILITY(U,$J,358.3,18221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18221,1,3,0)
 ;;=3^Arthritis d/t Lyme Disease
 ;;^UTILITY(U,$J,358.3,18221,1,4,0)
 ;;=4^A69.23
 ;;^UTILITY(U,$J,358.3,18221,2)
 ;;=^5000378
 ;;^UTILITY(U,$J,358.3,18222,0)
 ;;=J20.2^^53^755^15
 ;;^UTILITY(U,$J,358.3,18222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18222,1,3,0)
 ;;=3^Bronchitis,Acute d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,18222,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,18222,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,18223,0)
 ;;=J20.3^^53^755^7
 ;;^UTILITY(U,$J,358.3,18223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18223,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,18223,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,18223,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,18224,0)
 ;;=J20.7^^53^755^8
 ;;^UTILITY(U,$J,358.3,18224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18224,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,18224,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,18224,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,18225,0)
 ;;=J20.1^^53^755^9
 ;;^UTILITY(U,$J,358.3,18225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18225,1,3,0)
 ;;=3^Bronchitis,Acute d/t Hemophilus Influenzae
 ;;^UTILITY(U,$J,358.3,18225,1,4,0)
 ;;=4^J20.1
 ;;^UTILITY(U,$J,358.3,18225,2)
 ;;=^5008187
 ;;^UTILITY(U,$J,358.3,18226,0)
 ;;=J20.0^^53^755^10
 ;;^UTILITY(U,$J,358.3,18226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18226,1,3,0)
 ;;=3^Bronchitis,Acute d/t Mycoplasma Pneumoniae
 ;;^UTILITY(U,$J,358.3,18226,1,4,0)
 ;;=4^J20.0
 ;;^UTILITY(U,$J,358.3,18226,2)
 ;;=^5008186
 ;;^UTILITY(U,$J,358.3,18227,0)
 ;;=J20.8^^53^755^11
 ;;^UTILITY(U,$J,358.3,18227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18227,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,18227,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,18227,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,18228,0)
 ;;=J20.4^^53^755^12
 ;;^UTILITY(U,$J,358.3,18228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18228,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,18228,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,18228,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,18229,0)
 ;;=J20.5^^53^755^13
 ;;^UTILITY(U,$J,358.3,18229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18229,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,18229,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,18229,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,18230,0)
 ;;=J20.6^^53^755^14
 ;;^UTILITY(U,$J,358.3,18230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18230,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,18230,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,18230,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,18231,0)
 ;;=A69.29^^53^755^24
 ;;^UTILITY(U,$J,358.3,18231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18231,1,3,0)
 ;;=3^Conditions d/t Lyme Disease
 ;;^UTILITY(U,$J,358.3,18231,1,4,0)
 ;;=4^A69.29
 ;;^UTILITY(U,$J,358.3,18231,2)
 ;;=^5000379
 ;;^UTILITY(U,$J,358.3,18232,0)
 ;;=N30.91^^53^755^25
 ;;^UTILITY(U,$J,358.3,18232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18232,1,3,0)
 ;;=3^Cystitis w/ hematuria
 ;;^UTILITY(U,$J,358.3,18232,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,18232,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,18233,0)
 ;;=B97.10^^53^755^27
 ;;^UTILITY(U,$J,358.3,18233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18233,1,3,0)
 ;;=3^Enterovirus Cause of Disease
 ;;^UTILITY(U,$J,358.3,18233,1,4,0)
 ;;=4^B97.10
 ;;^UTILITY(U,$J,358.3,18233,2)
 ;;=^5000861
 ;;^UTILITY(U,$J,358.3,18234,0)
 ;;=R50.2^^53^755^29
 ;;^UTILITY(U,$J,358.3,18234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18234,1,3,0)
 ;;=3^Fever,Drug-Induced
 ;;^UTILITY(U,$J,358.3,18234,1,4,0)
 ;;=4^R50.2
 ;;^UTILITY(U,$J,358.3,18234,2)
 ;;=^5019507
 ;;^UTILITY(U,$J,358.3,18235,0)
 ;;=J11.00^^53^755^30
 ;;^UTILITY(U,$J,358.3,18235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18235,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,18235,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,18235,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,18236,0)
 ;;=A51.0^^53^755^31
 ;;^UTILITY(U,$J,358.3,18236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18236,1,3,0)
 ;;=3^Genital Syphilis,Primary
 ;;^UTILITY(U,$J,358.3,18236,1,4,0)
 ;;=4^A51.0
 ;;^UTILITY(U,$J,358.3,18236,2)
 ;;=^5000272
 ;;^UTILITY(U,$J,358.3,18237,0)
 ;;=N41.9^^53^755^53
 ;;^UTILITY(U,$J,358.3,18237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18237,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
 ;;^UTILITY(U,$J,358.3,18237,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,18237,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,18238,0)
 ;;=N72.^^53^755^51
 ;;^UTILITY(U,$J,358.3,18238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18238,1,3,0)
 ;;=3^Inflammatory Disease of Cervix Uteri
 ;;^UTILITY(U,$J,358.3,18238,1,4,0)
 ;;=4^N72.
 ;;^UTILITY(U,$J,358.3,18238,2)
 ;;=^5015812
 ;;^UTILITY(U,$J,358.3,18239,0)
 ;;=A56.11^^53^755^50
 ;;^UTILITY(U,$J,358.3,18239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18239,1,3,0)
 ;;=3^Inflammatory Disease Chlamydial Female Pelvic
 ;;^UTILITY(U,$J,358.3,18239,1,4,0)
 ;;=4^A56.11
 ;;^UTILITY(U,$J,358.3,18239,2)
 ;;=^5000342
 ;;^UTILITY(U,$J,358.3,18240,0)
 ;;=N73.9^^53^755^52
 ;;^UTILITY(U,$J,358.3,18240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18240,1,3,0)
 ;;=3^Inflammatory Disease of Female Pelvice,Unspec
 ;;^UTILITY(U,$J,358.3,18240,1,4,0)
 ;;=4^N73.9
 ;;^UTILITY(U,$J,358.3,18240,2)
 ;;=^5015820
 ;;^UTILITY(U,$J,358.3,18241,0)
 ;;=J10.01^^53^755^56
 ;;^UTILITY(U,$J,358.3,18241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18241,1,3,0)
 ;;=3^Influenza d/t Oth Indent Flu Virus w/ Same Oth Ident Flu Virus
 ;;^UTILITY(U,$J,358.3,18241,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,18241,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,18242,0)
 ;;=J10.00^^53^755^57
 ;;^UTILITY(U,$J,358.3,18242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18242,1,3,0)
 ;;=3^Influenza d/t Oth Indent Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,18242,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,18242,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,18243,0)
 ;;=J10.08^^53^755^55
 ;;^UTILITY(U,$J,358.3,18243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18243,1,3,0)
 ;;=3^Influenza d/t Oth Indent Flu Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,18243,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,18243,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,18244,0)
 ;;=J10.1^^53^755^58
 ;;^UTILITY(U,$J,358.3,18244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18244,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,18244,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,18244,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,18245,0)
 ;;=J11.08^^53^755^59
 ;;^UTILITY(U,$J,358.3,18245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18245,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,18245,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,18245,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,18246,0)
 ;;=A52.9^^53^755^65
 ;;^UTILITY(U,$J,358.3,18246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18246,1,3,0)
 ;;=3^Late Syphilis,Unspec
 ;;^UTILITY(U,$J,358.3,18246,1,4,0)
 ;;=4^A52.9
 ;;^UTILITY(U,$J,358.3,18246,2)
 ;;=^5000308
 ;;^UTILITY(U,$J,358.3,18247,0)
 ;;=A69.21^^53^755^69
 ;;^UTILITY(U,$J,358.3,18247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18247,1,3,0)
 ;;=3^Meningitis d/t Lyme Disease
 ;;^UTILITY(U,$J,358.3,18247,1,4,0)
 ;;=4^A69.21
 ;;^UTILITY(U,$J,358.3,18247,2)
 ;;=^5000376
 ;;^UTILITY(U,$J,358.3,18248,0)
 ;;=A69.22^^53^755^78
 ;;^UTILITY(U,$J,358.3,18248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18248,1,3,0)
 ;;=3^Neurologic Disorders d/t Lyme Disease
 ;;^UTILITY(U,$J,358.3,18248,1,4,0)
 ;;=4^A69.22
 ;;^UTILITY(U,$J,358.3,18248,2)
 ;;=^5000377
 ;;^UTILITY(U,$J,358.3,18249,0)
 ;;=A52.10^^53^755^79
 ;;^UTILITY(U,$J,358.3,18249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18249,1,3,0)
 ;;=3^Neurosyphilis Symptomatic,Unspec
 ;;^UTILITY(U,$J,358.3,18249,1,4,0)
 ;;=4^A52.10
 ;;^UTILITY(U,$J,358.3,18249,2)
 ;;=^5000291
 ;;^UTILITY(U,$J,358.3,18250,0)
 ;;=A52.3^^53^755^80
 ;;^UTILITY(U,$J,358.3,18250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18250,1,3,0)
 ;;=3^Neurosyphilis,Unspec
 ;;^UTILITY(U,$J,358.3,18250,1,4,0)
 ;;=4^A52.3
 ;;^UTILITY(U,$J,358.3,18250,2)
 ;;=^5000298
 ;;^UTILITY(U,$J,358.3,18251,0)
 ;;=N70.92^^53^755^81
 ;;^UTILITY(U,$J,358.3,18251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18251,1,3,0)
 ;;=3^Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,18251,1,4,0)
 ;;=4^N70.92
 ;;^UTILITY(U,$J,358.3,18251,2)
 ;;=^5015807
 ;;^UTILITY(U,$J,358.3,18252,0)
 ;;=M86.40^^53^755^82
 ;;^UTILITY(U,$J,358.3,18252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18252,1,3,0)
 ;;=3^Osteomyelitis w/ Draining Sinus,Chronic,Unspec Site
 ;;^UTILITY(U,$J,358.3,18252,1,4,0)
 ;;=4^M86.40
 ;;^UTILITY(U,$J,358.3,18252,2)
 ;;=^5014583
 ;;^UTILITY(U,$J,358.3,18253,0)
 ;;=M86.00^^53^755^85
 ;;^UTILITY(U,$J,358.3,18253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18253,1,3,0)
 ;;=3^Osteomyelitis,Acute Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,18253,1,4,0)
 ;;=4^M86.00
