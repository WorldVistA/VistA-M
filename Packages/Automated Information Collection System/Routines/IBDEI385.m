IBDEI385 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,54195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54195,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,54195,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,54195,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,54196,0)
 ;;=I25.701^^256^2761^9
 ;;^UTILITY(U,$J,358.3,54196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54196,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,54196,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,54196,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,54197,0)
 ;;=I25.708^^256^2761^10
 ;;^UTILITY(U,$J,358.3,54197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54197,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,54197,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,54197,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,54198,0)
 ;;=I20.9^^256^2761^3
 ;;^UTILITY(U,$J,358.3,54198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54198,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,54198,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,54198,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,54199,0)
 ;;=I25.729^^256^2761^4
 ;;^UTILITY(U,$J,358.3,54199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54199,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,54199,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,54199,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,54200,0)
 ;;=I25.709^^256^2761^11
 ;;^UTILITY(U,$J,358.3,54200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54200,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,54200,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,54200,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,54201,0)
 ;;=I25.10^^256^2761^6
 ;;^UTILITY(U,$J,358.3,54201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54201,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,54201,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,54201,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,54202,0)
 ;;=I25.810^^256^2761^8
 ;;^UTILITY(U,$J,358.3,54202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54202,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,54202,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,54202,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,54203,0)
 ;;=I65.29^^256^2762^18
 ;;^UTILITY(U,$J,358.3,54203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54203,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,54203,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,54203,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,54204,0)
 ;;=I65.22^^256^2762^16
 ;;^UTILITY(U,$J,358.3,54204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54204,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,54204,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,54204,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,54205,0)
 ;;=I65.23^^256^2762^15
 ;;^UTILITY(U,$J,358.3,54205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54205,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,54205,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,54205,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,54206,0)
 ;;=I65.21^^256^2762^17
 ;;^UTILITY(U,$J,358.3,54206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54206,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,54206,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,54206,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,54207,0)
 ;;=I70.219^^256^2762^3
 ;;^UTILITY(U,$J,358.3,54207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54207,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
