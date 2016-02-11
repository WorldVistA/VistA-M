IBDEI22F ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34633,2)
 ;;=^5020716
 ;;^UTILITY(U,$J,358.3,34634,0)
 ;;=S06.1X7A^^160^1761^59
 ;;^UTILITY(U,$J,358.3,34634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34634,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,34634,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,34634,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,34635,0)
 ;;=S06.1X7D^^160^1761^60
 ;;^UTILITY(U,$J,358.3,34635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34635,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t brain inj bf consc, subs
 ;;^UTILITY(U,$J,358.3,34635,1,4,0)
 ;;=4^S06.1X7D
 ;;^UTILITY(U,$J,358.3,34635,2)
 ;;=^5020718
 ;;^UTILITY(U,$J,358.3,34636,0)
 ;;=S06.1X7S^^160^1761^61
 ;;^UTILITY(U,$J,358.3,34636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34636,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t brain inj bf consc, sqla
 ;;^UTILITY(U,$J,358.3,34636,1,4,0)
 ;;=4^S06.1X7S
 ;;^UTILITY(U,$J,358.3,34636,2)
 ;;=^5020719
 ;;^UTILITY(U,$J,358.3,34637,0)
 ;;=S06.1X8A^^160^1761^62
 ;;^UTILITY(U,$J,358.3,34637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34637,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,34637,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,34637,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,34638,0)
 ;;=S06.1X8D^^160^1761^63
 ;;^UTILITY(U,$J,358.3,34638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34638,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t oth cause bf consc, subs
 ;;^UTILITY(U,$J,358.3,34638,1,4,0)
 ;;=4^S06.1X8D
 ;;^UTILITY(U,$J,358.3,34638,2)
 ;;=^5020721
 ;;^UTILITY(U,$J,358.3,34639,0)
 ;;=S06.1X8S^^160^1761^64
 ;;^UTILITY(U,$J,358.3,34639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34639,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t oth cause bf consc, sqla
 ;;^UTILITY(U,$J,358.3,34639,1,4,0)
 ;;=4^S06.1X8S
 ;;^UTILITY(U,$J,358.3,34639,2)
 ;;=^5020722
 ;;^UTILITY(U,$J,358.3,34640,0)
 ;;=S06.1X9A^^160^1761^56
 ;;^UTILITY(U,$J,358.3,34640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34640,1,3,0)
 ;;=3^Traum cereb edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,34640,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,34640,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,34641,0)
 ;;=S06.1X9D^^160^1761^57
 ;;^UTILITY(U,$J,358.3,34641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34641,1,3,0)
 ;;=3^Traum cereb edema w LOC of unsp duration, subs
 ;;^UTILITY(U,$J,358.3,34641,1,4,0)
 ;;=4^S06.1X9D
 ;;^UTILITY(U,$J,358.3,34641,2)
 ;;=^5020724
 ;;^UTILITY(U,$J,358.3,34642,0)
 ;;=S06.1X9S^^160^1761^58
 ;;^UTILITY(U,$J,358.3,34642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34642,1,3,0)
 ;;=3^Traum cereb edema w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,34642,1,4,0)
 ;;=4^S06.1X9S
 ;;^UTILITY(U,$J,358.3,34642,2)
 ;;=^5020725
 ;;^UTILITY(U,$J,358.3,34643,0)
 ;;=M54.2^^160^1762^4
 ;;^UTILITY(U,$J,358.3,34643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34643,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,34643,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,34643,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,34644,0)
 ;;=I65.21^^160^1762^9
 ;;^UTILITY(U,$J,358.3,34644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34644,1,3,0)
 ;;=3^Occlusion and stenosis of right carotid artery
 ;;^UTILITY(U,$J,358.3,34644,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,34644,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,34645,0)
 ;;=I65.22^^160^1762^8
 ;;^UTILITY(U,$J,358.3,34645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34645,1,3,0)
 ;;=3^Occlusion and stenosis of left carotid artery
 ;;^UTILITY(U,$J,358.3,34645,1,4,0)
 ;;=4^I65.22
