IBDEI0X2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15243,1,4,0)
 ;;=4^S61.512A
 ;;^UTILITY(U,$J,358.3,15243,2)
 ;;=^5033029
 ;;^UTILITY(U,$J,358.3,15244,0)
 ;;=S01.21XA^^85^813^36
 ;;^UTILITY(U,$J,358.3,15244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15244,1,3,0)
 ;;=3^Laceration w/o FB of Nose,Init Encntr
 ;;^UTILITY(U,$J,358.3,15244,1,4,0)
 ;;=4^S01.21XA
 ;;^UTILITY(U,$J,358.3,15244,2)
 ;;=^5020093
 ;;^UTILITY(U,$J,358.3,15245,0)
 ;;=S01.81XA^^85^813^3
 ;;^UTILITY(U,$J,358.3,15245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15245,1,3,0)
 ;;=3^Laceration w/o FB of Head,Other Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,15245,1,4,0)
 ;;=4^S01.81XA
 ;;^UTILITY(U,$J,358.3,15245,2)
 ;;=^5020225
 ;;^UTILITY(U,$J,358.3,15246,0)
 ;;=S11.81XA^^85^813^34
 ;;^UTILITY(U,$J,358.3,15246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15246,1,3,0)
 ;;=3^Laceration w/o FB of Neck,Other Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,15246,1,4,0)
 ;;=4^S11.81XA
 ;;^UTILITY(U,$J,358.3,15246,2)
 ;;=^5021509
 ;;^UTILITY(U,$J,358.3,15247,0)
 ;;=S31.811A^^85^813^40
 ;;^UTILITY(U,$J,358.3,15247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15247,1,3,0)
 ;;=3^Laceration w/o FB of Right Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,15247,1,4,0)
 ;;=4^S31.811A
 ;;^UTILITY(U,$J,358.3,15247,2)
 ;;=^5024299
 ;;^UTILITY(U,$J,358.3,15248,0)
 ;;=S01.411A^^85^813^41
 ;;^UTILITY(U,$J,358.3,15248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15248,1,3,0)
 ;;=3^Laceration w/o FB of Right Cheek/TMJ Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,15248,1,4,0)
 ;;=4^S01.411A
 ;;^UTILITY(U,$J,358.3,15248,2)
 ;;=^5020153
 ;;^UTILITY(U,$J,358.3,15249,0)
 ;;=S01.311A^^85^813^42
 ;;^UTILITY(U,$J,358.3,15249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15249,1,3,0)
 ;;=3^Laceration w/o FB of Right Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,15249,1,4,0)
 ;;=4^S01.311A
 ;;^UTILITY(U,$J,358.3,15249,2)
 ;;=^5020114
 ;;^UTILITY(U,$J,358.3,15250,0)
 ;;=S51.011A^^85^813^43
 ;;^UTILITY(U,$J,358.3,15250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15250,1,3,0)
 ;;=3^Laceration w/o FB of Right Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,15250,1,4,0)
 ;;=4^S51.011A
 ;;^UTILITY(U,$J,358.3,15250,2)
 ;;=^5028626
 ;;^UTILITY(U,$J,358.3,15251,0)
 ;;=S91.211A^^85^813^45
 ;;^UTILITY(U,$J,358.3,15251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15251,1,3,0)
 ;;=3^Laceration w/o FB of Right Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15251,1,4,0)
 ;;=4^S91.211A
 ;;^UTILITY(U,$J,358.3,15251,2)
 ;;=^5044273
 ;;^UTILITY(U,$J,358.3,15252,0)
 ;;=S91.111A^^85^813^46
 ;;^UTILITY(U,$J,358.3,15252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15252,1,3,0)
 ;;=3^Laceration w/o FB of Right Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15252,1,4,0)
 ;;=4^S91.111A
 ;;^UTILITY(U,$J,358.3,15252,2)
 ;;=^5044183
 ;;^UTILITY(U,$J,358.3,15253,0)
 ;;=S61.411A^^85^813^47
 ;;^UTILITY(U,$J,358.3,15253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15253,1,3,0)
 ;;=3^Laceration w/o FB of Right Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,15253,1,4,0)
 ;;=4^S61.411A
 ;;^UTILITY(U,$J,358.3,15253,2)
 ;;=^5032987
 ;;^UTILITY(U,$J,358.3,15254,0)
 ;;=S61.310A^^85^813^49
 ;;^UTILITY(U,$J,358.3,15254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15254,1,3,0)
 ;;=3^Laceration w/o FB of Right Index Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15254,1,4,0)
 ;;=4^S61.310A
 ;;^UTILITY(U,$J,358.3,15254,2)
 ;;=^5032906
 ;;^UTILITY(U,$J,358.3,15255,0)
 ;;=S61.210A^^85^813^50
 ;;^UTILITY(U,$J,358.3,15255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15255,1,3,0)
 ;;=3^Laceration w/o FB of Right Index Finger w/o Nail Damage,Init Encntr
