IBDEI0SW ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13290,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,13291,0)
 ;;=E10.319^^80^758^12
 ;;^UTILITY(U,$J,358.3,13291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13291,1,3,0)
 ;;=3^DM Type 1 w/ Unspec Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13291,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,13291,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,13292,0)
 ;;=E10.36^^80^758^1
 ;;^UTILITY(U,$J,358.3,13292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13292,1,3,0)
 ;;=3^DM Type 1 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,13292,1,4,0)
 ;;=4^E10.36
 ;;^UTILITY(U,$J,358.3,13292,2)
 ;;=^5002602
 ;;^UTILITY(U,$J,358.3,13293,0)
 ;;=E10.39^^80^758^2
 ;;^UTILITY(U,$J,358.3,13293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13293,1,3,0)
 ;;=3^DM Type 1 w/ Diabetic Ophthalmic Complication
 ;;^UTILITY(U,$J,358.3,13293,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,13293,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,13294,0)
 ;;=E10.321^^80^758^3
 ;;^UTILITY(U,$J,358.3,13294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13294,1,3,0)
 ;;=3^DM Type 1 w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13294,1,4,0)
 ;;=4^E10.321
 ;;^UTILITY(U,$J,358.3,13294,2)
 ;;=^5002594
 ;;^UTILITY(U,$J,358.3,13295,0)
 ;;=E10.329^^80^758^4
 ;;^UTILITY(U,$J,358.3,13295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13295,1,3,0)
 ;;=3^DM Type 1 w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13295,1,4,0)
 ;;=4^E10.329
 ;;^UTILITY(U,$J,358.3,13295,2)
 ;;=^5002595
 ;;^UTILITY(U,$J,358.3,13296,0)
 ;;=E10.331^^80^758^5
 ;;^UTILITY(U,$J,358.3,13296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13296,1,3,0)
 ;;=3^DM Type 1 w/ Moderate Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13296,1,4,0)
 ;;=4^E10.331
 ;;^UTILITY(U,$J,358.3,13296,2)
 ;;=^5002596
 ;;^UTILITY(U,$J,358.3,13297,0)
 ;;=E10.339^^80^758^6
 ;;^UTILITY(U,$J,358.3,13297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13297,1,3,0)
 ;;=3^DM Type 1 w/ Moderate Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13297,1,4,0)
 ;;=4^E10.339
 ;;^UTILITY(U,$J,358.3,13297,2)
 ;;=^5002597
 ;;^UTILITY(U,$J,358.3,13298,0)
 ;;=E10.341^^80^758^9
 ;;^UTILITY(U,$J,358.3,13298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13298,1,3,0)
 ;;=3^DM Type 1 w/ Severe Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13298,1,4,0)
 ;;=4^E10.341
 ;;^UTILITY(U,$J,358.3,13298,2)
 ;;=^5002598
 ;;^UTILITY(U,$J,358.3,13299,0)
 ;;=E10.349^^80^758^10
 ;;^UTILITY(U,$J,358.3,13299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13299,1,3,0)
 ;;=3^DM Type 1 w/ Severe Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13299,1,4,0)
 ;;=4^E10.349
 ;;^UTILITY(U,$J,358.3,13299,2)
 ;;=^5002599
 ;;^UTILITY(U,$J,358.3,13300,0)
 ;;=E10.351^^80^758^7
 ;;^UTILITY(U,$J,358.3,13300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13300,1,3,0)
 ;;=3^DM Type 1 w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13300,1,4,0)
 ;;=4^E10.351
 ;;^UTILITY(U,$J,358.3,13300,2)
 ;;=^5002600
 ;;^UTILITY(U,$J,358.3,13301,0)
 ;;=E10.359^^80^758^8
 ;;^UTILITY(U,$J,358.3,13301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13301,1,3,0)
 ;;=3^DM Type 1 w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13301,1,4,0)
 ;;=4^E10.359
 ;;^UTILITY(U,$J,358.3,13301,2)
 ;;=^5002601
 ;;^UTILITY(U,$J,358.3,13302,0)
 ;;=E08.311^^80^758^33
 ;;^UTILITY(U,$J,358.3,13302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13302,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13302,1,4,0)
 ;;=4^E08.311
