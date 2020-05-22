IBDEI0Z3 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15658,1,3,0)
 ;;=3^Preprocedural Exam NEC
 ;;^UTILITY(U,$J,358.3,15658,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,15658,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,15659,0)
 ;;=Z71.0^^88^865^9
 ;;^UTILITY(U,$J,358.3,15659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15659,1,3,0)
 ;;=3^Hlth Service to Consult on Behalf of Another
 ;;^UTILITY(U,$J,358.3,15659,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,15659,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,15660,0)
 ;;=Z59.8^^88^865^10
 ;;^UTILITY(U,$J,358.3,15660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15660,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems
 ;;^UTILITY(U,$J,358.3,15660,1,4,0)
 ;;=4^Z59.8
 ;;^UTILITY(U,$J,358.3,15660,2)
 ;;=^5063137
 ;;^UTILITY(U,$J,358.3,15661,0)
 ;;=I20.0^^88^866^5
 ;;^UTILITY(U,$J,358.3,15661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15661,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,15661,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,15661,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,15662,0)
 ;;=I25.2^^88^866^4
 ;;^UTILITY(U,$J,358.3,15662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15662,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,15662,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,15662,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,15663,0)
 ;;=I20.8^^88^866^2
 ;;^UTILITY(U,$J,358.3,15663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15663,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,15663,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,15663,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,15664,0)
 ;;=I20.1^^88^866^1
 ;;^UTILITY(U,$J,358.3,15664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15664,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,15664,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,15664,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,15665,0)
 ;;=I20.9^^88^866^3
 ;;^UTILITY(U,$J,358.3,15665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15665,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,15665,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,15665,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,15666,0)
 ;;=I65.29^^88^867^31
 ;;^UTILITY(U,$J,358.3,15666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15666,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,15666,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,15666,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,15667,0)
 ;;=I65.22^^88^867^29
 ;;^UTILITY(U,$J,358.3,15667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15667,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,15667,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,15667,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,15668,0)
 ;;=I65.23^^88^867^28
 ;;^UTILITY(U,$J,358.3,15668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15668,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,15668,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,15668,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,15669,0)
 ;;=I65.21^^88^867^30
 ;;^UTILITY(U,$J,358.3,15669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15669,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,15669,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,15669,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,15670,0)
 ;;=I70.219^^88^867^7
 ;;^UTILITY(U,$J,358.3,15670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15670,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
