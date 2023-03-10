IBDEI0H5 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7723,1,3,0)
 ;;=3^Respiratory Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,7723,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,7723,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,7724,0)
 ;;=Z01.812^^39^387^13
 ;;^UTILITY(U,$J,358.3,7724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7724,1,3,0)
 ;;=3^Lab Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,7724,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,7724,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,7725,0)
 ;;=Z01.818^^39^387^15
 ;;^UTILITY(U,$J,358.3,7725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7725,1,3,0)
 ;;=3^Preprocedural Exam NEC
 ;;^UTILITY(U,$J,358.3,7725,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,7725,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,7726,0)
 ;;=Z71.0^^39^387^9
 ;;^UTILITY(U,$J,358.3,7726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7726,1,3,0)
 ;;=3^Hlth Service to Consult on Behalf of Another
 ;;^UTILITY(U,$J,358.3,7726,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,7726,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,7727,0)
 ;;=Z59.89^^39^387^10
 ;;^UTILITY(U,$J,358.3,7727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7727,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems,Other
 ;;^UTILITY(U,$J,358.3,7727,1,4,0)
 ;;=4^Z59.89
 ;;^UTILITY(U,$J,358.3,7727,2)
 ;;=^5161312
 ;;^UTILITY(U,$J,358.3,7728,0)
 ;;=I20.0^^39^388^5
 ;;^UTILITY(U,$J,358.3,7728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7728,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,7728,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,7728,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,7729,0)
 ;;=I25.2^^39^388^4
 ;;^UTILITY(U,$J,358.3,7729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7729,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,7729,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,7729,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,7730,0)
 ;;=I20.8^^39^388^2
 ;;^UTILITY(U,$J,358.3,7730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7730,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,7730,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,7730,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,7731,0)
 ;;=I20.1^^39^388^1
 ;;^UTILITY(U,$J,358.3,7731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7731,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,7731,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,7731,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,7732,0)
 ;;=I20.9^^39^388^3
 ;;^UTILITY(U,$J,358.3,7732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7732,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,7732,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,7732,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,7733,0)
 ;;=I65.29^^39^389^31
 ;;^UTILITY(U,$J,358.3,7733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7733,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,7733,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,7733,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,7734,0)
 ;;=I65.22^^39^389^29
 ;;^UTILITY(U,$J,358.3,7734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7734,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,7734,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,7734,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,7735,0)
 ;;=I65.23^^39^389^28
 ;;^UTILITY(U,$J,358.3,7735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7735,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,7735,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,7735,2)
 ;;=^5007362
