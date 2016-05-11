IBDEI1YB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33123,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,33123,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,33123,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,33124,0)
 ;;=I25.701^^131^1666^9
 ;;^UTILITY(U,$J,358.3,33124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33124,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,33124,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,33124,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,33125,0)
 ;;=I25.708^^131^1666^10
 ;;^UTILITY(U,$J,358.3,33125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33125,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,33125,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,33125,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,33126,0)
 ;;=I20.9^^131^1666^3
 ;;^UTILITY(U,$J,358.3,33126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33126,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,33126,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,33126,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,33127,0)
 ;;=I25.729^^131^1666^4
 ;;^UTILITY(U,$J,358.3,33127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33127,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,33127,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,33127,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,33128,0)
 ;;=I25.709^^131^1666^11
 ;;^UTILITY(U,$J,358.3,33128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33128,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,33128,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,33128,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,33129,0)
 ;;=I25.10^^131^1666^6
 ;;^UTILITY(U,$J,358.3,33129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33129,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,33129,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,33129,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,33130,0)
 ;;=I25.810^^131^1666^8
 ;;^UTILITY(U,$J,358.3,33130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33130,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,33130,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,33130,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,33131,0)
 ;;=I65.29^^131^1667^18
 ;;^UTILITY(U,$J,358.3,33131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33131,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,33131,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,33131,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,33132,0)
 ;;=I65.22^^131^1667^16
 ;;^UTILITY(U,$J,358.3,33132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33132,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,33132,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,33132,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,33133,0)
 ;;=I65.23^^131^1667^15
 ;;^UTILITY(U,$J,358.3,33133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33133,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,33133,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,33133,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,33134,0)
 ;;=I65.21^^131^1667^17
 ;;^UTILITY(U,$J,358.3,33134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33134,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,33134,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,33134,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,33135,0)
 ;;=I70.219^^131^1667^3
 ;;^UTILITY(U,$J,358.3,33135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33135,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
