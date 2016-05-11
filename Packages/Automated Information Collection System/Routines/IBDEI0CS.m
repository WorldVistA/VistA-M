IBDEI0CS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5856,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,5856,1,4,0)
 ;;=4^I70.642
 ;;^UTILITY(U,$J,358.3,5856,2)
 ;;=^5007748
 ;;^UTILITY(U,$J,358.3,5857,0)
 ;;=I70.643^^30^385^67
 ;;^UTILITY(U,$J,358.3,5857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5857,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,5857,1,4,0)
 ;;=4^I70.643
 ;;^UTILITY(U,$J,358.3,5857,2)
 ;;=^5007749
 ;;^UTILITY(U,$J,358.3,5858,0)
 ;;=I70.644^^30^385^68
 ;;^UTILITY(U,$J,358.3,5858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5858,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,5858,1,4,0)
 ;;=4^I70.644
 ;;^UTILITY(U,$J,358.3,5858,2)
 ;;=^5007750
 ;;^UTILITY(U,$J,358.3,5859,0)
 ;;=I70.645^^30^385^69
 ;;^UTILITY(U,$J,358.3,5859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5859,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,5859,1,4,0)
 ;;=4^I70.645
 ;;^UTILITY(U,$J,358.3,5859,2)
 ;;=^5007751
 ;;^UTILITY(U,$J,358.3,5860,0)
 ;;=K12.0^^30^385^258
 ;;^UTILITY(U,$J,358.3,5860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5860,1,3,0)
 ;;=3^Recurrent Oral Aphthae
 ;;^UTILITY(U,$J,358.3,5860,1,4,0)
 ;;=4^K12.0
 ;;^UTILITY(U,$J,358.3,5860,2)
 ;;=^5008483
 ;;^UTILITY(U,$J,358.3,5861,0)
 ;;=K12.1^^30^385^271
 ;;^UTILITY(U,$J,358.3,5861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5861,1,3,0)
 ;;=3^Stomatitis NEC
 ;;^UTILITY(U,$J,358.3,5861,1,4,0)
 ;;=4^K12.1
 ;;^UTILITY(U,$J,358.3,5861,2)
 ;;=^5008484
 ;;^UTILITY(U,$J,358.3,5862,0)
 ;;=K12.2^^30^385^94
 ;;^UTILITY(U,$J,358.3,5862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5862,1,3,0)
 ;;=3^Cellulitis & Abscess of Mouth
 ;;^UTILITY(U,$J,358.3,5862,1,4,0)
 ;;=4^K12.2
 ;;^UTILITY(U,$J,358.3,5862,2)
 ;;=^5008485
 ;;^UTILITY(U,$J,358.3,5863,0)
 ;;=L02.01^^30^385^120
 ;;^UTILITY(U,$J,358.3,5863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5863,1,3,0)
 ;;=3^Cutaneous Abscess of Face
 ;;^UTILITY(U,$J,358.3,5863,1,4,0)
 ;;=4^L02.01
 ;;^UTILITY(U,$J,358.3,5863,2)
 ;;=^5008944
 ;;^UTILITY(U,$J,358.3,5864,0)
 ;;=L02.11^^30^385^125
 ;;^UTILITY(U,$J,358.3,5864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5864,1,3,0)
 ;;=3^Cutaneous Abscess of Neck
 ;;^UTILITY(U,$J,358.3,5864,1,4,0)
 ;;=4^L02.11
 ;;^UTILITY(U,$J,358.3,5864,2)
 ;;=^5008947
 ;;^UTILITY(U,$J,358.3,5865,0)
 ;;=L02.211^^30^385^117
 ;;^UTILITY(U,$J,358.3,5865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5865,1,3,0)
 ;;=3^Cutaneous Abscess of Abdominal Wall
 ;;^UTILITY(U,$J,358.3,5865,1,4,0)
 ;;=4^L02.211
 ;;^UTILITY(U,$J,358.3,5865,2)
 ;;=^5008950
 ;;^UTILITY(U,$J,358.3,5866,0)
 ;;=L02.212^^30^385^118
 ;;^UTILITY(U,$J,358.3,5866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5866,1,3,0)
 ;;=3^Cutaneous Abscess of Back
 ;;^UTILITY(U,$J,358.3,5866,1,4,0)
 ;;=4^L02.212
 ;;^UTILITY(U,$J,358.3,5866,2)
 ;;=^5008951
 ;;^UTILITY(U,$J,358.3,5867,0)
 ;;=L02.213^^30^385^119
 ;;^UTILITY(U,$J,358.3,5867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5867,1,3,0)
 ;;=3^Cutaneous Abscess of Chest Wall
 ;;^UTILITY(U,$J,358.3,5867,1,4,0)
 ;;=4^L02.213
 ;;^UTILITY(U,$J,358.3,5867,2)
 ;;=^5008952
 ;;^UTILITY(U,$J,358.3,5868,0)
 ;;=L02.214^^30^385^121
 ;;^UTILITY(U,$J,358.3,5868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5868,1,3,0)
 ;;=3^Cutaneous Abscess of Groin
 ;;^UTILITY(U,$J,358.3,5868,1,4,0)
 ;;=4^L02.214
 ;;^UTILITY(U,$J,358.3,5868,2)
 ;;=^5008953
 ;;^UTILITY(U,$J,358.3,5869,0)
 ;;=L02.215^^30^385^126
 ;;^UTILITY(U,$J,358.3,5869,1,0)
 ;;=^358.31IA^4^2
