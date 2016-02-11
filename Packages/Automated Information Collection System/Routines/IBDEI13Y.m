IBDEI13Y ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18498,1,4,0)
 ;;=4^J30.1
 ;;^UTILITY(U,$J,358.3,18498,2)
 ;;=^269906
 ;;^UTILITY(U,$J,358.3,18499,0)
 ;;=R09.81^^94^907^18
 ;;^UTILITY(U,$J,358.3,18499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18499,1,3,0)
 ;;=3^Nasal Congestion
 ;;^UTILITY(U,$J,358.3,18499,1,4,0)
 ;;=4^R09.81
 ;;^UTILITY(U,$J,358.3,18499,2)
 ;;=^5019203
 ;;^UTILITY(U,$J,358.3,18500,0)
 ;;=E04.0^^94^908^39
 ;;^UTILITY(U,$J,358.3,18500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18500,1,3,0)
 ;;=3^Nontoxic Diffuse Goiter
 ;;^UTILITY(U,$J,358.3,18500,1,4,0)
 ;;=4^E04.0
 ;;^UTILITY(U,$J,358.3,18500,2)
 ;;=^5002477
 ;;^UTILITY(U,$J,358.3,18501,0)
 ;;=E04.1^^94^908^41
 ;;^UTILITY(U,$J,358.3,18501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18501,1,3,0)
 ;;=3^Nontoxic Single Thyroid Nodule
 ;;^UTILITY(U,$J,358.3,18501,1,4,0)
 ;;=4^E04.1
 ;;^UTILITY(U,$J,358.3,18501,2)
 ;;=^5002478
 ;;^UTILITY(U,$J,358.3,18502,0)
 ;;=E04.2^^94^908^40
 ;;^UTILITY(U,$J,358.3,18502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18502,1,3,0)
 ;;=3^Nontoxic Multinodular Goiter
 ;;^UTILITY(U,$J,358.3,18502,1,4,0)
 ;;=4^E04.2
 ;;^UTILITY(U,$J,358.3,18502,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,18503,0)
 ;;=E01.1^^94^908^36
 ;;^UTILITY(U,$J,358.3,18503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18503,1,3,0)
 ;;=3^Iodine-Deficiency Related Multinodular (Endemic) Goiter
 ;;^UTILITY(U,$J,358.3,18503,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,18503,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,18504,0)
 ;;=E05.00^^94^908^56
 ;;^UTILITY(U,$J,358.3,18504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18504,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,18504,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,18504,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,18505,0)
 ;;=E05.01^^94^908^55
 ;;^UTILITY(U,$J,358.3,18505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18505,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,18505,1,4,0)
 ;;=4^E05.01
 ;;^UTILITY(U,$J,358.3,18505,2)
 ;;=^5002482
 ;;^UTILITY(U,$J,358.3,18506,0)
 ;;=E05.90^^94^908^58
 ;;^UTILITY(U,$J,358.3,18506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18506,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,18506,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,18506,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,18507,0)
 ;;=E05.91^^94^908^57
 ;;^UTILITY(U,$J,358.3,18507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18507,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,18507,1,4,0)
 ;;=4^E05.91
 ;;^UTILITY(U,$J,358.3,18507,2)
 ;;=^5002493
 ;;^UTILITY(U,$J,358.3,18508,0)
 ;;=E89.0^^94^908^50
 ;;^UTILITY(U,$J,358.3,18508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18508,1,3,0)
 ;;=3^Postprocedural Hypothyroidism
 ;;^UTILITY(U,$J,358.3,18508,1,4,0)
 ;;=4^E89.0
 ;;^UTILITY(U,$J,358.3,18508,2)
 ;;=^5003035
 ;;^UTILITY(U,$J,358.3,18509,0)
 ;;=E03.2^^94^908^32
 ;;^UTILITY(U,$J,358.3,18509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18509,1,3,0)
 ;;=3^Hypothyroidism d/t Meds/Oth Exogenous Substances
 ;;^UTILITY(U,$J,358.3,18509,1,4,0)
 ;;=4^E03.2
 ;;^UTILITY(U,$J,358.3,18509,2)
 ;;=^5002471
 ;;^UTILITY(U,$J,358.3,18510,0)
 ;;=E03.9^^94^908^33
 ;;^UTILITY(U,$J,358.3,18510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18510,1,3,0)
 ;;=3^Hypothyroidism,Unspec
 ;;^UTILITY(U,$J,358.3,18510,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,18510,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,18511,0)
 ;;=E06.0^^94^908^53
 ;;^UTILITY(U,$J,358.3,18511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18511,1,3,0)
 ;;=3^Thyroiditis,Acute
