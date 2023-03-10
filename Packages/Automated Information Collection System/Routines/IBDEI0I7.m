IBDEI0I7 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8189,2)
 ;;=^269484
 ;;^UTILITY(U,$J,358.3,8190,0)
 ;;=E04.0^^39^394^21
 ;;^UTILITY(U,$J,358.3,8190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8190,1,3,0)
 ;;=3^Nontoxic Diffuse Goiter
 ;;^UTILITY(U,$J,358.3,8190,1,4,0)
 ;;=4^E04.0
 ;;^UTILITY(U,$J,358.3,8190,2)
 ;;=^5002477
 ;;^UTILITY(U,$J,358.3,8191,0)
 ;;=E04.1^^39^394^23
 ;;^UTILITY(U,$J,358.3,8191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8191,1,3,0)
 ;;=3^Nontoxic Single Thyroid Nodule
 ;;^UTILITY(U,$J,358.3,8191,1,4,0)
 ;;=4^E04.1
 ;;^UTILITY(U,$J,358.3,8191,2)
 ;;=^5002478
 ;;^UTILITY(U,$J,358.3,8192,0)
 ;;=E04.2^^39^394^22
 ;;^UTILITY(U,$J,358.3,8192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8192,1,3,0)
 ;;=3^Nontoxic Multinodular Goiter
 ;;^UTILITY(U,$J,358.3,8192,1,4,0)
 ;;=4^E04.2
 ;;^UTILITY(U,$J,358.3,8192,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,8193,0)
 ;;=E01.1^^39^394^17
 ;;^UTILITY(U,$J,358.3,8193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8193,1,3,0)
 ;;=3^Iodine-Deficiency Related Multinodular (Endemic) Goiter
 ;;^UTILITY(U,$J,358.3,8193,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,8193,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,8194,0)
 ;;=E05.00^^39^394^39
 ;;^UTILITY(U,$J,358.3,8194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8194,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,8194,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,8194,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,8195,0)
 ;;=E05.01^^39^394^38
 ;;^UTILITY(U,$J,358.3,8195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8195,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,8195,1,4,0)
 ;;=4^E05.01
 ;;^UTILITY(U,$J,358.3,8195,2)
 ;;=^5002482
 ;;^UTILITY(U,$J,358.3,8196,0)
 ;;=E05.90^^39^394^41
 ;;^UTILITY(U,$J,358.3,8196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8196,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,8196,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,8196,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,8197,0)
 ;;=E05.91^^39^394^40
 ;;^UTILITY(U,$J,358.3,8197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8197,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,8197,1,4,0)
 ;;=4^E05.91
 ;;^UTILITY(U,$J,358.3,8197,2)
 ;;=^5002493
 ;;^UTILITY(U,$J,358.3,8198,0)
 ;;=E89.0^^39^394^32
 ;;^UTILITY(U,$J,358.3,8198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8198,1,3,0)
 ;;=3^Postprocedural Hypothyroidism
 ;;^UTILITY(U,$J,358.3,8198,1,4,0)
 ;;=4^E89.0
 ;;^UTILITY(U,$J,358.3,8198,2)
 ;;=^5003035
 ;;^UTILITY(U,$J,358.3,8199,0)
 ;;=E03.2^^39^394^13
 ;;^UTILITY(U,$J,358.3,8199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8199,1,3,0)
 ;;=3^Hypothyroidism d/t Meds/Oth Exogenous Substances
 ;;^UTILITY(U,$J,358.3,8199,1,4,0)
 ;;=4^E03.2
 ;;^UTILITY(U,$J,358.3,8199,2)
 ;;=^5002471
 ;;^UTILITY(U,$J,358.3,8200,0)
 ;;=E03.9^^39^394^14
 ;;^UTILITY(U,$J,358.3,8200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8200,1,3,0)
 ;;=3^Hypothyroidism,Unspec
 ;;^UTILITY(U,$J,358.3,8200,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,8200,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,8201,0)
 ;;=E06.0^^39^394^36
 ;;^UTILITY(U,$J,358.3,8201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8201,1,3,0)
 ;;=3^Thyroiditis,Acute
 ;;^UTILITY(U,$J,358.3,8201,1,4,0)
 ;;=4^E06.0
 ;;^UTILITY(U,$J,358.3,8201,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,8202,0)
 ;;=E06.1^^39^394^37
