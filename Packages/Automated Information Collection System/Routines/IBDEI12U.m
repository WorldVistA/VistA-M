IBDEI12U ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18305,0)
 ;;=Z48.01^^79^876^1
 ;;^UTILITY(U,$J,358.3,18305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18305,1,3,0)
 ;;=3^Change/Removal of Surgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,18305,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,18305,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,18306,0)
 ;;=Z48.02^^79^876^3
 ;;^UTILITY(U,$J,358.3,18306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18306,1,3,0)
 ;;=3^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,18306,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,18306,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,18307,0)
 ;;=Z48.812^^79^876^4
 ;;^UTILITY(U,$J,358.3,18307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18307,1,3,0)
 ;;=3^Surgical Aftercare Following Surgery on Circulatory System
 ;;^UTILITY(U,$J,358.3,18307,1,4,0)
 ;;=4^Z48.812
 ;;^UTILITY(U,$J,358.3,18307,2)
 ;;=^5063049
 ;;^UTILITY(U,$J,358.3,18308,0)
 ;;=Z09.^^79^876^2
 ;;^UTILITY(U,$J,358.3,18308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18308,1,3,0)
 ;;=3^F/U Exam After Treatment for Condition Other Than Malig Neop
 ;;^UTILITY(U,$J,358.3,18308,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,18308,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,18309,0)
 ;;=I25.10^^79^877^5
 ;;^UTILITY(U,$J,358.3,18309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18309,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,18309,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,18309,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,18310,0)
 ;;=I50.9^^79^877^9
 ;;^UTILITY(U,$J,358.3,18310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18310,1,3,0)
 ;;=3^Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,18310,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,18310,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,18311,0)
 ;;=I65.21^^79^877^16
 ;;^UTILITY(U,$J,358.3,18311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18311,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,18311,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,18311,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,18312,0)
 ;;=I65.22^^79^877^14
 ;;^UTILITY(U,$J,358.3,18312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18312,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,18312,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,18312,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,18313,0)
 ;;=I65.23^^79^877^13
 ;;^UTILITY(U,$J,358.3,18313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18313,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,18313,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,18313,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,18314,0)
 ;;=I65.8^^79^877^15
 ;;^UTILITY(U,$J,358.3,18314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18314,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,18314,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,18314,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,18315,0)
 ;;=I70.211^^79^877^8
 ;;^UTILITY(U,$J,358.3,18315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18315,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,18315,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,18315,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,18316,0)
 ;;=I70.212^^79^877^7
 ;;^UTILITY(U,$J,358.3,18316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18316,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,18316,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,18316,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,18317,0)
 ;;=I70.213^^79^877^6
 ;;^UTILITY(U,$J,358.3,18317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18317,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
