IBDEI1U7 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32354,1,3,0)
 ;;=3^Iodine-Deficiency Related Multinodular (Endemic) Goiter
 ;;^UTILITY(U,$J,358.3,32354,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,32354,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,32355,0)
 ;;=E05.00^^182^1984^53
 ;;^UTILITY(U,$J,358.3,32355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32355,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,32355,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,32355,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,32356,0)
 ;;=E05.01^^182^1984^52
 ;;^UTILITY(U,$J,358.3,32356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32356,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,32356,1,4,0)
 ;;=4^E05.01
 ;;^UTILITY(U,$J,358.3,32356,2)
 ;;=^5002482
 ;;^UTILITY(U,$J,358.3,32357,0)
 ;;=E05.90^^182^1984^55
 ;;^UTILITY(U,$J,358.3,32357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32357,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,32357,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,32357,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,32358,0)
 ;;=E05.91^^182^1984^54
 ;;^UTILITY(U,$J,358.3,32358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32358,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,32358,1,4,0)
 ;;=4^E05.91
 ;;^UTILITY(U,$J,358.3,32358,2)
 ;;=^5002493
 ;;^UTILITY(U,$J,358.3,32359,0)
 ;;=E89.0^^182^1984^47
 ;;^UTILITY(U,$J,358.3,32359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32359,1,3,0)
 ;;=3^Postprocedural Hypothyroidism
 ;;^UTILITY(U,$J,358.3,32359,1,4,0)
 ;;=4^E89.0
 ;;^UTILITY(U,$J,358.3,32359,2)
 ;;=^5003035
 ;;^UTILITY(U,$J,358.3,32360,0)
 ;;=E03.2^^182^1984^31
 ;;^UTILITY(U,$J,358.3,32360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32360,1,3,0)
 ;;=3^Hypothyroidism d/t Meds/Oth Exogenous Substances
 ;;^UTILITY(U,$J,358.3,32360,1,4,0)
 ;;=4^E03.2
 ;;^UTILITY(U,$J,358.3,32360,2)
 ;;=^5002471
 ;;^UTILITY(U,$J,358.3,32361,0)
 ;;=E03.9^^182^1984^32
 ;;^UTILITY(U,$J,358.3,32361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32361,1,3,0)
 ;;=3^Hypothyroidism,Unspec
 ;;^UTILITY(U,$J,358.3,32361,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,32361,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,32362,0)
 ;;=E06.0^^182^1984^50
 ;;^UTILITY(U,$J,358.3,32362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32362,1,3,0)
 ;;=3^Thyroiditis,Acute
 ;;^UTILITY(U,$J,358.3,32362,1,4,0)
 ;;=4^E06.0
 ;;^UTILITY(U,$J,358.3,32362,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,32363,0)
 ;;=E06.1^^182^1984^51
 ;;^UTILITY(U,$J,358.3,32363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32363,1,3,0)
 ;;=3^Thyroiditis,Subacute
 ;;^UTILITY(U,$J,358.3,32363,1,4,0)
 ;;=4^E06.1
 ;;^UTILITY(U,$J,358.3,32363,2)
 ;;=^119376
 ;;^UTILITY(U,$J,358.3,32364,0)
 ;;=C73.^^182^1984^36
 ;;^UTILITY(U,$J,358.3,32364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32364,1,3,0)
 ;;=3^Malig Neop of Thyroid Gland
 ;;^UTILITY(U,$J,358.3,32364,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,32364,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,32365,0)
 ;;=E10.21^^182^1984^9
 ;;^UTILITY(U,$J,358.3,32365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32365,1,3,0)
 ;;=3^DM Type 1 w/ Nephropathy
 ;;^UTILITY(U,$J,358.3,32365,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,32365,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,32366,0)
 ;;=E10.9^^182^1984^11
 ;;^UTILITY(U,$J,358.3,32366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32366,1,3,0)
 ;;=3^DM Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,32366,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,32366,2)
 ;;=^5002626
