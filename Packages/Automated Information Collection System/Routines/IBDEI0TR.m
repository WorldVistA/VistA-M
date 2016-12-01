IBDEI0TR ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39140,1,3,0)
 ;;=3^Defects in the complement system
 ;;^UTILITY(U,$J,358.3,39140,1,4,0)
 ;;=4^D84.1
 ;;^UTILITY(U,$J,358.3,39140,2)
 ;;=^5002439
 ;;^UTILITY(U,$J,358.3,39141,0)
 ;;=G95.9^^109^1615^8
 ;;^UTILITY(U,$J,358.3,39141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39141,1,3,0)
 ;;=3^Disease of spinal cord, unspec
 ;;^UTILITY(U,$J,358.3,39141,1,4,0)
 ;;=4^G95.9
 ;;^UTILITY(U,$J,358.3,39141,2)
 ;;=^5004194
 ;;^UTILITY(U,$J,358.3,39142,0)
 ;;=H16.321^^109^1615^7
 ;;^UTILITY(U,$J,358.3,39142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39142,1,3,0)
 ;;=3^Diffuse interstitial keratitis, rt eye
 ;;^UTILITY(U,$J,358.3,39142,1,4,0)
 ;;=4^H16.321
 ;;^UTILITY(U,$J,358.3,39142,2)
 ;;=^5004953
 ;;^UTILITY(U,$J,358.3,39143,0)
 ;;=H16.322^^109^1615^6
 ;;^UTILITY(U,$J,358.3,39143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39143,1,3,0)
 ;;=3^Diffuse interstitial keratitis, lft eye
 ;;^UTILITY(U,$J,358.3,39143,1,4,0)
 ;;=4^H16.322
 ;;^UTILITY(U,$J,358.3,39143,2)
 ;;=^5004954
 ;;^UTILITY(U,$J,358.3,39144,0)
 ;;=H16.323^^109^1615^5
 ;;^UTILITY(U,$J,358.3,39144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39144,1,3,0)
 ;;=3^Diffuse interstitial keratitis, bilat
 ;;^UTILITY(U,$J,358.3,39144,1,4,0)
 ;;=4^H16.323
 ;;^UTILITY(U,$J,358.3,39144,2)
 ;;=^5004955
 ;;^UTILITY(U,$J,358.3,39145,0)
 ;;=N28.9^^109^1615^9
 ;;^UTILITY(U,$J,358.3,39145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39145,1,3,0)
 ;;=3^Disorder of kidney & ureter, unspec
 ;;^UTILITY(U,$J,358.3,39145,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,39145,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,39146,0)
 ;;=M15.1^^109^1615^13
 ;;^UTILITY(U,$J,358.3,39146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39146,1,3,0)
 ;;=3^Heberden's nodes (w/ arthropathy)
 ;;^UTILITY(U,$J,358.3,39146,1,4,0)
 ;;=4^M15.1
 ;;^UTILITY(U,$J,358.3,39146,2)
 ;;=^5010763
 ;;^UTILITY(U,$J,358.3,39147,0)
 ;;=R26.2^^109^1615^4
 ;;^UTILITY(U,$J,358.3,39147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39147,1,3,0)
 ;;=3^Difficulty in walking, NEC
 ;;^UTILITY(U,$J,358.3,39147,1,4,0)
 ;;=4^R26.2
 ;;^UTILITY(U,$J,358.3,39147,2)
 ;;=^5019306
 ;;^UTILITY(U,$J,358.3,39148,0)
 ;;=M15.2^^109^1615^2
 ;;^UTILITY(U,$J,358.3,39148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39148,1,3,0)
 ;;=3^Bouchard's nodes (w/ arthropathy)
 ;;^UTILITY(U,$J,358.3,39148,1,4,0)
 ;;=4^M15.2
 ;;^UTILITY(U,$J,358.3,39148,2)
 ;;=^5010764
 ;;^UTILITY(U,$J,358.3,39149,0)
 ;;=M87.00^^109^1615^14
 ;;^UTILITY(U,$J,358.3,39149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39149,1,3,0)
 ;;=3^Idiopth aseptic necr of unspec bone
 ;;^UTILITY(U,$J,358.3,39149,1,4,0)
 ;;=4^M87.00
 ;;^UTILITY(U,$J,358.3,39149,2)
 ;;=^5014657
 ;;^UTILITY(U,$J,358.3,39150,0)
 ;;=R53.81^^109^1615^15
 ;;^UTILITY(U,$J,358.3,39150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39150,1,3,0)
 ;;=3^Malaise, oth
 ;;^UTILITY(U,$J,358.3,39150,1,4,0)
 ;;=4^R53.81
 ;;^UTILITY(U,$J,358.3,39150,2)
 ;;=^5019518
 ;;^UTILITY(U,$J,358.3,39151,0)
 ;;=R53.83^^109^1615^11
 ;;^UTILITY(U,$J,358.3,39151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39151,1,3,0)
 ;;=3^Fatigue, oth
 ;;^UTILITY(U,$J,358.3,39151,1,4,0)
 ;;=4^R53.83
 ;;^UTILITY(U,$J,358.3,39151,2)
 ;;=^5019520
 ;;^UTILITY(U,$J,358.3,39152,0)
 ;;=R51.^^109^1615^12
 ;;^UTILITY(U,$J,358.3,39152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39152,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,39152,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,39152,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,39153,0)
 ;;=T50.905A^^109^1615^1
 ;;^UTILITY(U,$J,358.3,39153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39153,1,3,0)
 ;;=3^Advrs effect of unsp drug/meds/biol subst, init
 ;;^UTILITY(U,$J,358.3,39153,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,39153,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,39154,0)
 ;;=Z09.^^109^1615^10
 ;;^UTILITY(U,$J,358.3,39154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39154,1,3,0)
 ;;=3^Encntr for f/u exam aft trtmt for cond oth than malig neoplm
 ;;^UTILITY(U,$J,358.3,39154,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,39154,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,39155,0)
 ;;=G95.89^^109^1616^1
 ;;^UTILITY(U,$J,358.3,39155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39155,1,3,0)
 ;;=3^Diseases of spinal cord, oth, spec
 ;;^UTILITY(U,$J,358.3,39155,1,4,0)
 ;;=4^G95.89
 ;;^UTILITY(U,$J,358.3,39155,2)
 ;;=^5004193
 ;;^UTILITY(U,$J,358.3,39156,0)
 ;;=M15.0^^109^1617^2
 ;;^UTILITY(U,$J,358.3,39156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39156,1,3,0)
 ;;=3^Prim generalized (osteo)arthritis
 ;;^UTILITY(U,$J,358.3,39156,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,39156,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,39157,0)
 ;;=M19.91^^109^1617^17
 ;;^UTILITY(U,$J,358.3,39157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39157,1,3,0)
 ;;=3^Prim osteoarthritis, unspec site
 ;;^UTILITY(U,$J,358.3,39157,1,4,0)
 ;;=4^M19.91
 ;;^UTILITY(U,$J,358.3,39157,2)
 ;;=^5010854
 ;;^UTILITY(U,$J,358.3,39158,0)
 ;;=M19.011^^109^1617^15
 ;;^UTILITY(U,$J,358.3,39158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39158,1,3,0)
 ;;=3^Prim osteoarthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,39158,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,39158,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,39159,0)
 ;;=M19.012^^109^1617^8
 ;;^UTILITY(U,$J,358.3,39159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39159,1,3,0)
 ;;=3^Prim osteoarthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,39159,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,39159,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,39160,0)
 ;;=M19.021^^109^1617^11
 ;;^UTILITY(U,$J,358.3,39160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39160,1,3,0)
 ;;=3^Prim osteoarthritis, rt elbow
 ;;^UTILITY(U,$J,358.3,39160,1,4,0)
 ;;=4^M19.021
 ;;^UTILITY(U,$J,358.3,39160,2)
 ;;=^5010811
 ;;^UTILITY(U,$J,358.3,39161,0)
 ;;=M19.022^^109^1617^4
 ;;^UTILITY(U,$J,358.3,39161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39161,1,3,0)
 ;;=3^Prim osteoarthritis, lft elbow
 ;;^UTILITY(U,$J,358.3,39161,1,4,0)
 ;;=4^M19.022
 ;;^UTILITY(U,$J,358.3,39161,2)
 ;;=^5010812
 ;;^UTILITY(U,$J,358.3,39162,0)
 ;;=M19.031^^109^1617^16
 ;;^UTILITY(U,$J,358.3,39162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39162,1,3,0)
 ;;=3^Prim osteoarthritis, rt wrist
 ;;^UTILITY(U,$J,358.3,39162,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,39162,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,39163,0)
 ;;=M19.032^^109^1617^9
 ;;^UTILITY(U,$J,358.3,39163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39163,1,3,0)
 ;;=3^Prim osteoarthritis, lft wrist
 ;;^UTILITY(U,$J,358.3,39163,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,39163,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,39164,0)
 ;;=M19.041^^109^1617^12
 ;;^UTILITY(U,$J,358.3,39164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39164,1,3,0)
 ;;=3^Prim osteoarthritis, rt hand
 ;;^UTILITY(U,$J,358.3,39164,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,39164,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,39165,0)
 ;;=M19.042^^109^1617^5
 ;;^UTILITY(U,$J,358.3,39165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39165,1,3,0)
 ;;=3^Prim osteoarthritis, lft hand
 ;;^UTILITY(U,$J,358.3,39165,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,39165,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,39166,0)
 ;;=M19.071^^109^1617^10
 ;;^UTILITY(U,$J,358.3,39166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39166,1,3,0)
 ;;=3^Prim osteoarthritis, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,39166,1,4,0)
 ;;=4^M19.071
 ;;^UTILITY(U,$J,358.3,39166,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,39167,0)
 ;;=M19.072^^109^1617^3
 ;;^UTILITY(U,$J,358.3,39167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39167,1,3,0)
 ;;=3^Prim osteoarthritis, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,39167,1,4,0)
 ;;=4^M19.072
 ;;^UTILITY(U,$J,358.3,39167,2)
 ;;=^5010821
 ;;^UTILITY(U,$J,358.3,39168,0)
 ;;=M19.93^^109^1617^32
 ;;^UTILITY(U,$J,358.3,39168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39168,1,3,0)
 ;;=3^Second osteoarthritis, unspec site
 ;;^UTILITY(U,$J,358.3,39168,1,4,0)
 ;;=4^M19.93
 ;;^UTILITY(U,$J,358.3,39168,2)
 ;;=^5010856
 ;;^UTILITY(U,$J,358.3,39169,0)
 ;;=M19.211^^109^1617^30
 ;;^UTILITY(U,$J,358.3,39169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39169,1,3,0)
 ;;=3^Second osteoarthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,39169,1,4,0)
 ;;=4^M19.211
 ;;^UTILITY(U,$J,358.3,39169,2)
 ;;=^5010838
 ;;^UTILITY(U,$J,358.3,39170,0)
 ;;=M19.212^^109^1617^25
 ;;^UTILITY(U,$J,358.3,39170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39170,1,3,0)
 ;;=3^Second osteoarthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,39170,1,4,0)
 ;;=4^M19.212
 ;;^UTILITY(U,$J,358.3,39170,2)
 ;;=^5010839
 ;;^UTILITY(U,$J,358.3,39171,0)
 ;;=M19.221^^109^1617^28
 ;;^UTILITY(U,$J,358.3,39171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39171,1,3,0)
 ;;=3^Second osteoarthritis, rt elbow
 ;;^UTILITY(U,$J,358.3,39171,1,4,0)
 ;;=4^M19.221
 ;;^UTILITY(U,$J,358.3,39171,2)
 ;;=^5010841
 ;;^UTILITY(U,$J,358.3,39172,0)
 ;;=M19.222^^109^1617^23
 ;;^UTILITY(U,$J,358.3,39172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39172,1,3,0)
 ;;=3^Second osteoarthritis, lft elbow
 ;;^UTILITY(U,$J,358.3,39172,1,4,0)
 ;;=4^M19.222
 ;;^UTILITY(U,$J,358.3,39172,2)
 ;;=^5010842
 ;;^UTILITY(U,$J,358.3,39173,0)
 ;;=M19.231^^109^1617^31
 ;;^UTILITY(U,$J,358.3,39173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39173,1,3,0)
 ;;=3^Second osteoarthritis, rt wrist
 ;;^UTILITY(U,$J,358.3,39173,1,4,0)
 ;;=4^M19.231
 ;;^UTILITY(U,$J,358.3,39173,2)
 ;;=^5010844
 ;;^UTILITY(U,$J,358.3,39174,0)
 ;;=M19.232^^109^1617^26
 ;;^UTILITY(U,$J,358.3,39174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39174,1,3,0)
 ;;=3^Second osteoarthritis, lft wrist
 ;;^UTILITY(U,$J,358.3,39174,1,4,0)
 ;;=4^M19.232
 ;;^UTILITY(U,$J,358.3,39174,2)
 ;;=^5010845
 ;;^UTILITY(U,$J,358.3,39175,0)
 ;;=M19.241^^109^1617^29
 ;;^UTILITY(U,$J,358.3,39175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39175,1,3,0)
 ;;=3^Second osteoarthritis, rt hand
