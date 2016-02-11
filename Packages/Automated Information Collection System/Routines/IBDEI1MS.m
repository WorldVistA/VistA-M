IBDEI1MS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27289,0)
 ;;=E01.1^^132^1312^36
 ;;^UTILITY(U,$J,358.3,27289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27289,1,3,0)
 ;;=3^Iodine-Deficiency Related Multinodular (Endemic) Goiter
 ;;^UTILITY(U,$J,358.3,27289,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,27289,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,27290,0)
 ;;=E05.00^^132^1312^56
 ;;^UTILITY(U,$J,358.3,27290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27290,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,27290,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,27290,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,27291,0)
 ;;=E05.01^^132^1312^55
 ;;^UTILITY(U,$J,358.3,27291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27291,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,27291,1,4,0)
 ;;=4^E05.01
 ;;^UTILITY(U,$J,358.3,27291,2)
 ;;=^5002482
 ;;^UTILITY(U,$J,358.3,27292,0)
 ;;=E05.90^^132^1312^58
 ;;^UTILITY(U,$J,358.3,27292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27292,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,27292,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,27292,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,27293,0)
 ;;=E05.91^^132^1312^57
 ;;^UTILITY(U,$J,358.3,27293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27293,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,27293,1,4,0)
 ;;=4^E05.91
 ;;^UTILITY(U,$J,358.3,27293,2)
 ;;=^5002493
 ;;^UTILITY(U,$J,358.3,27294,0)
 ;;=E89.0^^132^1312^50
 ;;^UTILITY(U,$J,358.3,27294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27294,1,3,0)
 ;;=3^Postprocedural Hypothyroidism
 ;;^UTILITY(U,$J,358.3,27294,1,4,0)
 ;;=4^E89.0
 ;;^UTILITY(U,$J,358.3,27294,2)
 ;;=^5003035
 ;;^UTILITY(U,$J,358.3,27295,0)
 ;;=E03.2^^132^1312^32
 ;;^UTILITY(U,$J,358.3,27295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27295,1,3,0)
 ;;=3^Hypothyroidism d/t Meds/Oth Exogenous Substances
 ;;^UTILITY(U,$J,358.3,27295,1,4,0)
 ;;=4^E03.2
 ;;^UTILITY(U,$J,358.3,27295,2)
 ;;=^5002471
 ;;^UTILITY(U,$J,358.3,27296,0)
 ;;=E03.9^^132^1312^33
 ;;^UTILITY(U,$J,358.3,27296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27296,1,3,0)
 ;;=3^Hypothyroidism,Unspec
 ;;^UTILITY(U,$J,358.3,27296,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,27296,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,27297,0)
 ;;=E06.0^^132^1312^53
 ;;^UTILITY(U,$J,358.3,27297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27297,1,3,0)
 ;;=3^Thyroiditis,Acute
 ;;^UTILITY(U,$J,358.3,27297,1,4,0)
 ;;=4^E06.0
 ;;^UTILITY(U,$J,358.3,27297,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,27298,0)
 ;;=E06.1^^132^1312^54
 ;;^UTILITY(U,$J,358.3,27298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27298,1,3,0)
 ;;=3^Thyroiditis,Subacute
 ;;^UTILITY(U,$J,358.3,27298,1,4,0)
 ;;=4^E06.1
 ;;^UTILITY(U,$J,358.3,27298,2)
 ;;=^119376
 ;;^UTILITY(U,$J,358.3,27299,0)
 ;;=C73.^^132^1312^37
 ;;^UTILITY(U,$J,358.3,27299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27299,1,3,0)
 ;;=3^Malig Neop of Thyroid Gland
 ;;^UTILITY(U,$J,358.3,27299,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,27299,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,27300,0)
 ;;=E10.21^^132^1312^8
 ;;^UTILITY(U,$J,358.3,27300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27300,1,3,0)
 ;;=3^DM Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,27300,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,27300,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,27301,0)
 ;;=E10.9^^132^1312^12
 ;;^UTILITY(U,$J,358.3,27301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27301,1,3,0)
 ;;=3^DM Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,27301,1,4,0)
 ;;=4^E10.9
