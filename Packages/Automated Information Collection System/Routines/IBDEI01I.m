IBDEI01I ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3232,1,3,0)
 ;;=3^29540
 ;;^UTILITY(U,$J,358.3,3233,0)
 ;;=29260^^23^200^15^^^^1
 ;;^UTILITY(U,$J,358.3,3233,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3233,1,2,0)
 ;;=2^Strapping/Taping,Elbow/Wrist
 ;;^UTILITY(U,$J,358.3,3233,1,3,0)
 ;;=3^29260
 ;;^UTILITY(U,$J,358.3,3234,0)
 ;;=29520^^23^200^17^^^^1
 ;;^UTILITY(U,$J,358.3,3234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3234,1,2,0)
 ;;=2^Strapping/Taping,Hip
 ;;^UTILITY(U,$J,358.3,3234,1,3,0)
 ;;=3^29520
 ;;^UTILITY(U,$J,358.3,3235,0)
 ;;=29530^^23^200^18^^^^1
 ;;^UTILITY(U,$J,358.3,3235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3235,1,2,0)
 ;;=2^Strapping/Taping,Knee
 ;;^UTILITY(U,$J,358.3,3235,1,3,0)
 ;;=3^29530
 ;;^UTILITY(U,$J,358.3,3236,0)
 ;;=29240^^23^200^19^^^^1
 ;;^UTILITY(U,$J,358.3,3236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3236,1,2,0)
 ;;=2^Strapping/Taping,Shoulder
 ;;^UTILITY(U,$J,358.3,3236,1,3,0)
 ;;=3^29240
 ;;^UTILITY(U,$J,358.3,3237,0)
 ;;=29550^^23^200^20^^^^1
 ;;^UTILITY(U,$J,358.3,3237,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3237,1,2,0)
 ;;=2^Strapping/Taping,Toes
 ;;^UTILITY(U,$J,358.3,3237,1,3,0)
 ;;=3^29550
 ;;^UTILITY(U,$J,358.3,3238,0)
 ;;=29280^^23^200^16^^^^1
 ;;^UTILITY(U,$J,358.3,3238,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3238,1,2,0)
 ;;=2^Strapping/Taping,Hand or Finger
 ;;^UTILITY(U,$J,358.3,3238,1,3,0)
 ;;=3^29280
 ;;^UTILITY(U,$J,358.3,3239,0)
 ;;=20560^^23^200^2^^^^1
 ;;^UTILITY(U,$J,358.3,3239,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3239,1,2,0)
 ;;=2^Dry Needling 1-2 Muscles
 ;;^UTILITY(U,$J,358.3,3239,1,3,0)
 ;;=3^20560
 ;;^UTILITY(U,$J,358.3,3240,0)
 ;;=20561^^23^200^3^^^^1
 ;;^UTILITY(U,$J,358.3,3240,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3240,1,2,0)
 ;;=2^Dry Needling 3+ Muscles
 ;;^UTILITY(U,$J,358.3,3240,1,3,0)
 ;;=3^20561
 ;;^UTILITY(U,$J,358.3,3241,0)
 ;;=97150^^23^200^6^^^^1
 ;;^UTILITY(U,$J,358.3,3241,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3241,1,2,0)
 ;;=2^Group Therapeutic Procedures
 ;;^UTILITY(U,$J,358.3,3241,1,3,0)
 ;;=3^97150
 ;;^UTILITY(U,$J,358.3,3242,0)
 ;;=97799^^23^200^24^^^^1
 ;;^UTILITY(U,$J,358.3,3242,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3242,1,2,0)
 ;;=2^Unlisted Physical Med/Rehab Svc/Proc
 ;;^UTILITY(U,$J,358.3,3242,1,3,0)
 ;;=3^97799
 ;;^UTILITY(U,$J,358.3,3243,0)
 ;;=98940^^23^201^1^^^^1
 ;;^UTILITY(U,$J,358.3,3243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3243,1,2,0)
 ;;=2^CMT; Spinal, one to two regions
 ;;^UTILITY(U,$J,358.3,3243,1,3,0)
 ;;=3^98940
 ;;^UTILITY(U,$J,358.3,3244,0)
 ;;=98941^^23^201^2^^^^1
 ;;^UTILITY(U,$J,358.3,3244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3244,1,2,0)
 ;;=2^CMT; Spinal, three to four regions
 ;;^UTILITY(U,$J,358.3,3244,1,3,0)
 ;;=3^98941
 ;;^UTILITY(U,$J,358.3,3245,0)
 ;;=98942^^23^201^3^^^^1
 ;;^UTILITY(U,$J,358.3,3245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3245,1,2,0)
 ;;=2^CMT; Spinal, five regions
 ;;^UTILITY(U,$J,358.3,3245,1,3,0)
 ;;=3^98942
 ;;^UTILITY(U,$J,358.3,3246,0)
 ;;=98943^^23^201^4^^^^1
 ;;^UTILITY(U,$J,358.3,3246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3246,1,2,0)
 ;;=2^CMT; Extraspinal, one or more regions
 ;;^UTILITY(U,$J,358.3,3246,1,3,0)
 ;;=3^98943
 ;;^UTILITY(U,$J,358.3,3247,0)
 ;;=98925^^23^202^1^^^^1
 ;;^UTILITY(U,$J,358.3,3247,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3247,1,2,0)
 ;;=2^OMT, 1-2 body regions involved
 ;;^UTILITY(U,$J,358.3,3247,1,3,0)
 ;;=3^98925
 ;;^UTILITY(U,$J,358.3,3248,0)
 ;;=98926^^23^202^2^^^^1
 ;;^UTILITY(U,$J,358.3,3248,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3248,1,2,0)
 ;;=2^OMT, 3-4 body regions involved
 ;;^UTILITY(U,$J,358.3,3248,1,3,0)
 ;;=3^98926
 ;;^UTILITY(U,$J,358.3,3249,0)
 ;;=98927^^23^202^3^^^^1
 ;;^UTILITY(U,$J,358.3,3249,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3249,1,2,0)
 ;;=2^OMT, 5-6 body regions involved
 ;;^UTILITY(U,$J,358.3,3249,1,3,0)
 ;;=3^98927
 ;;^UTILITY(U,$J,358.3,3250,0)
 ;;=98928^^23^202^4^^^^1
 ;;^UTILITY(U,$J,358.3,3250,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3250,1,2,0)
 ;;=2^OMT, 7-8 body regions involved
 ;;^UTILITY(U,$J,358.3,3250,1,3,0)
 ;;=3^98928
 ;;^UTILITY(U,$J,358.3,3251,0)
 ;;=98929^^23^202^5^^^^1
 ;;^UTILITY(U,$J,358.3,3251,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3251,1,2,0)
 ;;=2^OMT, 9-10 body regions involved
 ;;^UTILITY(U,$J,358.3,3251,1,3,0)
 ;;=3^98929
 ;;^UTILITY(U,$J,358.3,3252,0)
 ;;=97810^^23^203^3^^^^1
 ;;^UTILITY(U,$J,358.3,3252,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3252,1,2,0)
 ;;=2^Acupunct w/o Stimul,15min
 ;;^UTILITY(U,$J,358.3,3252,1,3,0)
 ;;=3^97810
 ;;^UTILITY(U,$J,358.3,3253,0)
 ;;=97811^^23^203^4^^^^1
 ;;^UTILITY(U,$J,358.3,3253,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3253,1,2,0)
 ;;=2^Acupunct w/o Stimul,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,3253,1,3,0)
 ;;=3^97811
 ;;^UTILITY(U,$J,358.3,3254,0)
 ;;=97813^^23^203^1^^^^1
 ;;^UTILITY(U,$J,358.3,3254,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3254,1,2,0)
 ;;=2^Acupunct w/ Stimul,15min
 ;;^UTILITY(U,$J,358.3,3254,1,3,0)
 ;;=3^97813
 ;;^UTILITY(U,$J,358.3,3255,0)
 ;;=97814^^23^203^2^^^^1
 ;;^UTILITY(U,$J,358.3,3255,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3255,1,2,0)
 ;;=2^Acupunct w/ Stimul,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,3255,1,3,0)
 ;;=3^97814
 ;;^UTILITY(U,$J,358.3,3256,0)
 ;;=S8930^^23^203^5^^^^1
 ;;^UTILITY(U,$J,358.3,3256,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3256,1,2,0)
 ;;=2^Acupuncture Electostim,Auricular,Ea 15min
 ;;^UTILITY(U,$J,358.3,3256,1,3,0)
 ;;=3^S8930
 ;;^UTILITY(U,$J,358.3,3257,0)
 ;;=98960^^23^204^1^^^^1
 ;;^UTILITY(U,$J,358.3,3257,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3257,1,2,0)
 ;;=2^Education for Self Mgt,Ind,Ea 30min
 ;;^UTILITY(U,$J,358.3,3257,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,3258,0)
 ;;=G43.C0^^24^205^83
 ;;^UTILITY(U,$J,358.3,3258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3258,1,3,0)
 ;;=3^Periodic headache syndr in chld/adlt, not intrctbl
 ;;^UTILITY(U,$J,358.3,3258,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,3258,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,3259,0)
 ;;=M19.011^^24^205^91
 ;;^UTILITY(U,$J,358.3,3259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3259,1,3,0)
 ;;=3^Primary osteoarthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,3259,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,3259,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,3260,0)
 ;;=M19.012^^24^205^88
 ;;^UTILITY(U,$J,358.3,3260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3260,1,3,0)
 ;;=3^Primary osteoarthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,3260,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,3260,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,3261,0)
 ;;=M19.041^^24^205^90
 ;;^UTILITY(U,$J,358.3,3261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3261,1,3,0)
 ;;=3^Primary osteoarthritis, rt hand
 ;;^UTILITY(U,$J,358.3,3261,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,3261,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,3262,0)
 ;;=M19.042^^24^205^87
 ;;^UTILITY(U,$J,358.3,3262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3262,1,3,0)
 ;;=3^Primary osteoarthritis, lft hand
 ;;^UTILITY(U,$J,358.3,3262,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,3262,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,3263,0)
 ;;=M19.071^^24^205^89
 ;;^UTILITY(U,$J,358.3,3263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3263,1,3,0)
 ;;=3^Primary osteoarthritis, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,3263,1,4,0)
 ;;=4^M19.071
 ;;^UTILITY(U,$J,358.3,3263,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,3264,0)
 ;;=M19.072^^24^205^86
 ;;^UTILITY(U,$J,358.3,3264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3264,1,3,0)
 ;;=3^Primary osteoarthritis, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,3264,1,4,0)
 ;;=4^M19.072
 ;;^UTILITY(U,$J,358.3,3264,2)
 ;;=^5010821
 ;;^UTILITY(U,$J,358.3,3265,0)
 ;;=M17.9^^24^205^75
 ;;^UTILITY(U,$J,358.3,3265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3265,1,3,0)
 ;;=3^Osteoarthritis of knee, unspec
 ;;^UTILITY(U,$J,358.3,3265,1,4,0)
 ;;=4^M17.9
 ;;^UTILITY(U,$J,358.3,3265,2)
 ;;=^5010794
 ;;^UTILITY(U,$J,358.3,3266,0)
 ;;=M12.9^^24^205^4
 ;;^UTILITY(U,$J,358.3,3266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3266,1,3,0)
 ;;=3^Arthropathy, unspec
 ;;^UTILITY(U,$J,358.3,3266,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,3266,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,3267,0)
 ;;=M22.41^^24^205^25
 ;;^UTILITY(U,$J,358.3,3267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3267,1,3,0)
 ;;=3^Chondromalacia patellae, rt knee
 ;;^UTILITY(U,$J,358.3,3267,1,4,0)
 ;;=4^M22.41
 ;;^UTILITY(U,$J,358.3,3267,2)
 ;;=^5011186
 ;;^UTILITY(U,$J,358.3,3268,0)
 ;;=M22.42^^24^205^24
 ;;^UTILITY(U,$J,358.3,3268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3268,1,3,0)
 ;;=3^Chondromalacia patellae, lft knee
 ;;^UTILITY(U,$J,358.3,3268,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,3268,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,3269,0)
 ;;=M22.91^^24^205^29
 ;;^UTILITY(U,$J,358.3,3269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3269,1,3,0)
 ;;=3^Disorder of patella, rt knee, unspec
 ;;^UTILITY(U,$J,358.3,3269,1,4,0)
 ;;=4^M22.91
 ;;^UTILITY(U,$J,358.3,3269,2)
 ;;=^5133780
 ;;^UTILITY(U,$J,358.3,3270,0)
 ;;=M22.92^^24^205^28
 ;;^UTILITY(U,$J,358.3,3270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3270,1,3,0)
 ;;=3^Disorder of patella, lft knee, unspec
 ;;^UTILITY(U,$J,358.3,3270,1,4,0)
 ;;=4^M22.92
 ;;^UTILITY(U,$J,358.3,3270,2)
 ;;=^5133781
 ;;^UTILITY(U,$J,358.3,3271,0)
 ;;=M23.91^^24^205^59
 ;;^UTILITY(U,$J,358.3,3271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3271,1,3,0)
 ;;=3^Internal derangement of rt knee, unspec
 ;;^UTILITY(U,$J,358.3,3271,1,4,0)
 ;;=4^M23.91
 ;;^UTILITY(U,$J,358.3,3271,2)
 ;;=^5133806
 ;;^UTILITY(U,$J,358.3,3272,0)
 ;;=M23.92^^24^205^58
 ;;^UTILITY(U,$J,358.3,3272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3272,1,3,0)
 ;;=3^Internal derangement of lft knee, unspec
 ;;^UTILITY(U,$J,358.3,3272,1,4,0)
 ;;=4^M23.92
 ;;^UTILITY(U,$J,358.3,3272,2)
 ;;=^5133807
 ;;^UTILITY(U,$J,358.3,3273,0)
 ;;=M24.811^^24^205^63
 ;;^UTILITY(U,$J,358.3,3273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3273,1,3,0)
 ;;=3^Joint derangements of rt shldr, oth, spec, NEC
 ;;^UTILITY(U,$J,358.3,3273,1,4,0)
 ;;=4^M24.811
 ;;^UTILITY(U,$J,358.3,3273,2)
 ;;=^5011453
 ;;^UTILITY(U,$J,358.3,3274,0)
 ;;=M24.812^^24^205^62
 ;;^UTILITY(U,$J,358.3,3274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3274,1,3,0)
 ;;=3^Joint derangements of lft shldr, oth, spec, NEC
 ;;^UTILITY(U,$J,358.3,3274,1,4,0)
 ;;=4^M24.812
 ;;^UTILITY(U,$J,358.3,3274,2)
 ;;=^5011454
 ;;^UTILITY(U,$J,358.3,3275,0)
 ;;=M25.311^^24^205^57
 ;;^UTILITY(U,$J,358.3,3275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3275,1,3,0)
 ;;=3^Instability, rt shldr
 ;;^UTILITY(U,$J,358.3,3275,1,4,0)
 ;;=4^M25.311
 ;;^UTILITY(U,$J,358.3,3275,2)
 ;;=^5011551
 ;;^UTILITY(U,$J,358.3,3276,0)
 ;;=M25.312^^24^205^54
 ;;^UTILITY(U,$J,358.3,3276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3276,1,3,0)
 ;;=3^Instability, lft shldr
 ;;^UTILITY(U,$J,358.3,3276,1,4,0)
 ;;=4^M25.312
 ;;^UTILITY(U,$J,358.3,3276,2)
 ;;=^5011552
 ;;^UTILITY(U,$J,358.3,3277,0)
 ;;=M25.211^^24^205^33
 ;;^UTILITY(U,$J,358.3,3277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3277,1,3,0)
 ;;=3^Flail joint, rt shldr
 ;;^UTILITY(U,$J,358.3,3277,1,4,0)
 ;;=4^M25.211
 ;;^UTILITY(U,$J,358.3,3277,2)
 ;;=^5011528
 ;;^UTILITY(U,$J,358.3,3278,0)
 ;;=M25.212^^24^205^31
 ;;^UTILITY(U,$J,358.3,3278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3278,1,3,0)
 ;;=3^Flail joint, lft shldr
 ;;^UTILITY(U,$J,358.3,3278,1,4,0)
 ;;=4^M25.212
 ;;^UTILITY(U,$J,358.3,3278,2)
 ;;=^5011529
 ;;^UTILITY(U,$J,358.3,3279,0)
 ;;=M25.261^^24^205^32
 ;;^UTILITY(U,$J,358.3,3279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3279,1,3,0)
 ;;=3^Flail joint, rt knee
 ;;^UTILITY(U,$J,358.3,3279,1,4,0)
 ;;=4^M25.261
 ;;^UTILITY(U,$J,358.3,3279,2)
 ;;=^5011543
 ;;^UTILITY(U,$J,358.3,3280,0)
 ;;=M25.262^^24^205^30
 ;;^UTILITY(U,$J,358.3,3280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3280,1,3,0)
 ;;=3^Flail joint, lft knee
 ;;^UTILITY(U,$J,358.3,3280,1,4,0)
 ;;=4^M25.262
 ;;^UTILITY(U,$J,358.3,3280,2)
 ;;=^5011544
 ;;^UTILITY(U,$J,358.3,3281,0)
 ;;=M25.361^^24^205^55
 ;;^UTILITY(U,$J,358.3,3281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3281,1,3,0)
 ;;=3^Instability, rt knee
 ;;^UTILITY(U,$J,358.3,3281,1,4,0)
 ;;=4^M25.361
 ;;^UTILITY(U,$J,358.3,3281,2)
 ;;=^5011566
 ;;^UTILITY(U,$J,358.3,3282,0)
 ;;=M25.362^^24^205^52
 ;;^UTILITY(U,$J,358.3,3282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3282,1,3,0)
 ;;=3^Instability, lft knee
 ;;^UTILITY(U,$J,358.3,3282,1,4,0)
 ;;=4^M25.362
 ;;^UTILITY(U,$J,358.3,3282,2)
 ;;=^5011567
 ;;^UTILITY(U,$J,358.3,3283,0)
 ;;=M23.51^^24^205^56
 ;;^UTILITY(U,$J,358.3,3283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3283,1,3,0)
 ;;=3^Instability, rt knee, chronic
 ;;^UTILITY(U,$J,358.3,3283,1,4,0)
 ;;=4^M23.51
 ;;^UTILITY(U,$J,358.3,3283,2)
 ;;=^5011254
 ;;^UTILITY(U,$J,358.3,3284,0)
 ;;=M23.52^^24^205^53
 ;;^UTILITY(U,$J,358.3,3284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3284,1,3,0)
 ;;=3^Instability, lft knee, chronic
 ;;^UTILITY(U,$J,358.3,3284,1,4,0)
 ;;=4^M23.52
 ;;^UTILITY(U,$J,358.3,3284,2)
 ;;=^5011255
 ;;^UTILITY(U,$J,358.3,3285,0)
 ;;=M23.8X1^^24^205^61
 ;;^UTILITY(U,$J,358.3,3285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3285,1,3,0)
 ;;=3^Internal derangements of rt knee, oth
 ;;^UTILITY(U,$J,358.3,3285,1,4,0)
 ;;=4^M23.8X1
 ;;^UTILITY(U,$J,358.3,3285,2)
 ;;=^5011273
 ;;^UTILITY(U,$J,358.3,3286,0)
 ;;=M23.8X2^^24^205^60
 ;;^UTILITY(U,$J,358.3,3286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3286,1,3,0)
 ;;=3^Internal derangements of lft knee, oth
 ;;^UTILITY(U,$J,358.3,3286,1,4,0)
 ;;=4^M23.8X2
 ;;^UTILITY(U,$J,358.3,3286,2)
 ;;=^5011274
 ;;^UTILITY(U,$J,358.3,3287,0)
 ;;=M25.50^^24^205^79
 ;;^UTILITY(U,$J,358.3,3287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3287,1,3,0)
 ;;=3^Pain in unspec joint
 ;;^UTILITY(U,$J,358.3,3287,1,4,0)
 ;;=4^M25.50
 ;;^UTILITY(U,$J,358.3,3287,2)
 ;;=^5011601
 ;;^UTILITY(U,$J,358.3,3288,0)
 ;;=M54.6^^24^205^78
 ;;^UTILITY(U,$J,358.3,3288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3288,1,3,0)
 ;;=3^Pain in thoracic spine
 ;;^UTILITY(U,$J,358.3,3288,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,3288,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,3289,0)
 ;;=M96.1^^24^205^85
 ;;^UTILITY(U,$J,358.3,3289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3289,1,3,0)
 ;;=3^Postlaminectomy syndrome, NEC
 ;;^UTILITY(U,$J,358.3,3289,1,4,0)
 ;;=4^M96.1
 ;;^UTILITY(U,$J,358.3,3289,2)
 ;;=^5015374
 ;;^UTILITY(U,$J,358.3,3290,0)
 ;;=M54.31^^24^205^94
 ;;^UTILITY(U,$J,358.3,3290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3290,1,3,0)
 ;;=3^Sciatica, right side
 ;;^UTILITY(U,$J,358.3,3290,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,3290,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,3291,0)
 ;;=M54.32^^24^205^93
 ;;^UTILITY(U,$J,358.3,3291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3291,1,3,0)
 ;;=3^Sciatica, left side
 ;;^UTILITY(U,$J,358.3,3291,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,3291,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,3292,0)
 ;;=M75.21^^24^205^6
 ;;^UTILITY(U,$J,358.3,3292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3292,1,3,0)
 ;;=3^Bicipital tendinitis, rt shldr
 ;;^UTILITY(U,$J,358.3,3292,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,3292,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,3293,0)
 ;;=M75.22^^24^205^5
 ;;^UTILITY(U,$J,358.3,3293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3293,1,3,0)
 ;;=3^Bicipital tendinitis, lft shldr
 ;;^UTILITY(U,$J,358.3,3293,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,3293,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,3294,0)
 ;;=M77.01^^24^205^67
 ;;^UTILITY(U,$J,358.3,3294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3294,1,3,0)
 ;;=3^Medial epicondylitis, rt elbow
 ;;^UTILITY(U,$J,358.3,3294,1,4,0)
 ;;=4^M77.01
 ;;^UTILITY(U,$J,358.3,3294,2)
 ;;=^5013301
 ;;^UTILITY(U,$J,358.3,3295,0)
 ;;=M77.02^^24^205^66
 ;;^UTILITY(U,$J,358.3,3295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3295,1,3,0)
 ;;=3^Medial epicondylitis, lft elbow
 ;;^UTILITY(U,$J,358.3,3295,1,4,0)
 ;;=4^M77.02
 ;;^UTILITY(U,$J,358.3,3295,2)
 ;;=^5013302
 ;;^UTILITY(U,$J,358.3,3296,0)
 ;;=M77.11^^24^205^65
 ;;^UTILITY(U,$J,358.3,3296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3296,1,3,0)
 ;;=3^Lateral epicondylitis, rt elbow
 ;;^UTILITY(U,$J,358.3,3296,1,4,0)
 ;;=4^M77.11
 ;;^UTILITY(U,$J,358.3,3296,2)
 ;;=^5013304
 ;;^UTILITY(U,$J,358.3,3297,0)
 ;;=M77.12^^24^205^64
 ;;^UTILITY(U,$J,358.3,3297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3297,1,3,0)
 ;;=3^Lateral epicondylitis, lft elbow
 ;;^UTILITY(U,$J,358.3,3297,1,4,0)
 ;;=4^M77.12
 ;;^UTILITY(U,$J,358.3,3297,2)
 ;;=^5013305
 ;;^UTILITY(U,$J,358.3,3298,0)
 ;;=M70.61^^24^205^112
 ;;^UTILITY(U,$J,358.3,3298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3298,1,3,0)
 ;;=3^Trochanteric bursitis, rt hip
 ;;^UTILITY(U,$J,358.3,3298,1,4,0)
 ;;=4^M70.61
 ;;^UTILITY(U,$J,358.3,3298,2)
 ;;=^5013059
 ;;^UTILITY(U,$J,358.3,3299,0)
 ;;=M70.62^^24^205^111
 ;;^UTILITY(U,$J,358.3,3299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3299,1,3,0)
 ;;=3^Trochanteric bursitis, lft hip
 ;;^UTILITY(U,$J,358.3,3299,1,4,0)
 ;;=4^M70.62
 ;;^UTILITY(U,$J,358.3,3299,2)
 ;;=^5013060
 ;;^UTILITY(U,$J,358.3,3300,0)
 ;;=M25.751^^24^205^77
 ;;^UTILITY(U,$J,358.3,3300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3300,1,3,0)
 ;;=3^Osteophyte, right hip
 ;;^UTILITY(U,$J,358.3,3300,1,4,0)
 ;;=4^M25.751
 ;;^UTILITY(U,$J,358.3,3300,2)
 ;;=^5011658
 ;;^UTILITY(U,$J,358.3,3301,0)
 ;;=M25.752^^24^205^76
 ;;^UTILITY(U,$J,358.3,3301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3301,1,3,0)
 ;;=3^Osteophyte, left hip
 ;;^UTILITY(U,$J,358.3,3301,1,4,0)
 ;;=4^M25.752
 ;;^UTILITY(U,$J,358.3,3301,2)
 ;;=^5011659
 ;;^UTILITY(U,$J,358.3,3302,0)
 ;;=M76.31^^24^205^35
 ;;^UTILITY(U,$J,358.3,3302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3302,1,3,0)
 ;;=3^Iliotibial band syndrome, rt leg
 ;;^UTILITY(U,$J,358.3,3302,1,4,0)
 ;;=4^M76.31
 ;;^UTILITY(U,$J,358.3,3302,2)
 ;;=^5013276
 ;;^UTILITY(U,$J,358.3,3303,0)
 ;;=M76.32^^24^205^34
 ;;^UTILITY(U,$J,358.3,3303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3303,1,3,0)
 ;;=3^Iliotibial band syndrome, lft leg
 ;;^UTILITY(U,$J,358.3,3303,1,4,0)
 ;;=4^M76.32
 ;;^UTILITY(U,$J,358.3,3303,2)
 ;;=^5013277
 ;;^UTILITY(U,$J,358.3,3304,0)
 ;;=M76.51^^24^205^82
 ;;^UTILITY(U,$J,358.3,3304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3304,1,3,0)
 ;;=3^Patellar tendinitis, right knee
 ;;^UTILITY(U,$J,358.3,3304,1,4,0)
 ;;=4^M76.51
 ;;^UTILITY(U,$J,358.3,3304,2)
 ;;=^5013282
 ;;^UTILITY(U,$J,358.3,3305,0)
 ;;=M76.52^^24^205^81
 ;;^UTILITY(U,$J,358.3,3305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3305,1,3,0)
 ;;=3^Patellar tendinitis, left knee
 ;;^UTILITY(U,$J,358.3,3305,1,4,0)
 ;;=4^M76.52
 ;;^UTILITY(U,$J,358.3,3305,2)
 ;;=^5013283
 ;;^UTILITY(U,$J,358.3,3306,0)
 ;;=M76.61^^24^205^3
 ;;^UTILITY(U,$J,358.3,3306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3306,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,3306,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,3306,2)
 ;;=^5013285
