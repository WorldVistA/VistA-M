IBDEI0DF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6159,0)
 ;;=H66.92^^30^387^25
 ;;^UTILITY(U,$J,358.3,6159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6159,1,3,0)
 ;;=3^Otitis Media,Unspec,Left Ear
 ;;^UTILITY(U,$J,358.3,6159,1,4,0)
 ;;=4^H66.92
 ;;^UTILITY(U,$J,358.3,6159,2)
 ;;=^5006641
 ;;^UTILITY(U,$J,358.3,6160,0)
 ;;=E04.0^^30^388^39
 ;;^UTILITY(U,$J,358.3,6160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6160,1,3,0)
 ;;=3^Nontoxic Diffuse Goiter
 ;;^UTILITY(U,$J,358.3,6160,1,4,0)
 ;;=4^E04.0
 ;;^UTILITY(U,$J,358.3,6160,2)
 ;;=^5002477
 ;;^UTILITY(U,$J,358.3,6161,0)
 ;;=E04.1^^30^388^41
 ;;^UTILITY(U,$J,358.3,6161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6161,1,3,0)
 ;;=3^Nontoxic Single Thyroid Nodule
 ;;^UTILITY(U,$J,358.3,6161,1,4,0)
 ;;=4^E04.1
 ;;^UTILITY(U,$J,358.3,6161,2)
 ;;=^5002478
 ;;^UTILITY(U,$J,358.3,6162,0)
 ;;=E04.2^^30^388^40
 ;;^UTILITY(U,$J,358.3,6162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6162,1,3,0)
 ;;=3^Nontoxic Multinodular Goiter
 ;;^UTILITY(U,$J,358.3,6162,1,4,0)
 ;;=4^E04.2
 ;;^UTILITY(U,$J,358.3,6162,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,6163,0)
 ;;=E01.1^^30^388^36
 ;;^UTILITY(U,$J,358.3,6163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6163,1,3,0)
 ;;=3^Iodine-Deficiency Related Multinodular (Endemic) Goiter
 ;;^UTILITY(U,$J,358.3,6163,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,6163,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,6164,0)
 ;;=E05.00^^30^388^56
 ;;^UTILITY(U,$J,358.3,6164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6164,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,6164,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,6164,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,6165,0)
 ;;=E05.01^^30^388^55
 ;;^UTILITY(U,$J,358.3,6165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6165,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,6165,1,4,0)
 ;;=4^E05.01
 ;;^UTILITY(U,$J,358.3,6165,2)
 ;;=^5002482
 ;;^UTILITY(U,$J,358.3,6166,0)
 ;;=E05.90^^30^388^58
 ;;^UTILITY(U,$J,358.3,6166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6166,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,6166,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,6166,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,6167,0)
 ;;=E05.91^^30^388^57
 ;;^UTILITY(U,$J,358.3,6167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6167,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,6167,1,4,0)
 ;;=4^E05.91
 ;;^UTILITY(U,$J,358.3,6167,2)
 ;;=^5002493
 ;;^UTILITY(U,$J,358.3,6168,0)
 ;;=E89.0^^30^388^50
 ;;^UTILITY(U,$J,358.3,6168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6168,1,3,0)
 ;;=3^Postprocedural Hypothyroidism
 ;;^UTILITY(U,$J,358.3,6168,1,4,0)
 ;;=4^E89.0
 ;;^UTILITY(U,$J,358.3,6168,2)
 ;;=^5003035
 ;;^UTILITY(U,$J,358.3,6169,0)
 ;;=E03.2^^30^388^32
 ;;^UTILITY(U,$J,358.3,6169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6169,1,3,0)
 ;;=3^Hypothyroidism d/t Meds/Oth Exogenous Substances
 ;;^UTILITY(U,$J,358.3,6169,1,4,0)
 ;;=4^E03.2
 ;;^UTILITY(U,$J,358.3,6169,2)
 ;;=^5002471
 ;;^UTILITY(U,$J,358.3,6170,0)
 ;;=E03.9^^30^388^33
 ;;^UTILITY(U,$J,358.3,6170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6170,1,3,0)
 ;;=3^Hypothyroidism,Unspec
 ;;^UTILITY(U,$J,358.3,6170,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,6170,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,6171,0)
 ;;=E06.0^^30^388^53
 ;;^UTILITY(U,$J,358.3,6171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6171,1,3,0)
 ;;=3^Thyroiditis,Acute
 ;;^UTILITY(U,$J,358.3,6171,1,4,0)
 ;;=4^E06.0
 ;;^UTILITY(U,$J,358.3,6171,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,6172,0)
 ;;=E06.1^^30^388^54
