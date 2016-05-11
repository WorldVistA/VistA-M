IBDEI1AO ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22012,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,22012,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,22013,0)
 ;;=E05.00^^87^973^56
 ;;^UTILITY(U,$J,358.3,22013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22013,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,22013,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,22013,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,22014,0)
 ;;=E05.01^^87^973^55
 ;;^UTILITY(U,$J,358.3,22014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22014,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,22014,1,4,0)
 ;;=4^E05.01
 ;;^UTILITY(U,$J,358.3,22014,2)
 ;;=^5002482
 ;;^UTILITY(U,$J,358.3,22015,0)
 ;;=E05.90^^87^973^58
 ;;^UTILITY(U,$J,358.3,22015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22015,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,22015,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,22015,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,22016,0)
 ;;=E05.91^^87^973^57
 ;;^UTILITY(U,$J,358.3,22016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22016,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,22016,1,4,0)
 ;;=4^E05.91
 ;;^UTILITY(U,$J,358.3,22016,2)
 ;;=^5002493
 ;;^UTILITY(U,$J,358.3,22017,0)
 ;;=E89.0^^87^973^50
 ;;^UTILITY(U,$J,358.3,22017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22017,1,3,0)
 ;;=3^Postprocedural Hypothyroidism
 ;;^UTILITY(U,$J,358.3,22017,1,4,0)
 ;;=4^E89.0
 ;;^UTILITY(U,$J,358.3,22017,2)
 ;;=^5003035
 ;;^UTILITY(U,$J,358.3,22018,0)
 ;;=E03.2^^87^973^32
 ;;^UTILITY(U,$J,358.3,22018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22018,1,3,0)
 ;;=3^Hypothyroidism d/t Meds/Oth Exogenous Substances
 ;;^UTILITY(U,$J,358.3,22018,1,4,0)
 ;;=4^E03.2
 ;;^UTILITY(U,$J,358.3,22018,2)
 ;;=^5002471
 ;;^UTILITY(U,$J,358.3,22019,0)
 ;;=E03.9^^87^973^33
 ;;^UTILITY(U,$J,358.3,22019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22019,1,3,0)
 ;;=3^Hypothyroidism,Unspec
 ;;^UTILITY(U,$J,358.3,22019,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,22019,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,22020,0)
 ;;=E06.0^^87^973^53
 ;;^UTILITY(U,$J,358.3,22020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22020,1,3,0)
 ;;=3^Thyroiditis,Acute
 ;;^UTILITY(U,$J,358.3,22020,1,4,0)
 ;;=4^E06.0
 ;;^UTILITY(U,$J,358.3,22020,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,22021,0)
 ;;=E06.1^^87^973^54
 ;;^UTILITY(U,$J,358.3,22021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22021,1,3,0)
 ;;=3^Thyroiditis,Subacute
 ;;^UTILITY(U,$J,358.3,22021,1,4,0)
 ;;=4^E06.1
 ;;^UTILITY(U,$J,358.3,22021,2)
 ;;=^119376
 ;;^UTILITY(U,$J,358.3,22022,0)
 ;;=C73.^^87^973^37
 ;;^UTILITY(U,$J,358.3,22022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22022,1,3,0)
 ;;=3^Malig Neop of Thyroid Gland
 ;;^UTILITY(U,$J,358.3,22022,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,22022,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,22023,0)
 ;;=E10.21^^87^973^8
 ;;^UTILITY(U,$J,358.3,22023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22023,1,3,0)
 ;;=3^DM Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,22023,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,22023,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,22024,0)
 ;;=E10.9^^87^973^12
 ;;^UTILITY(U,$J,358.3,22024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22024,1,3,0)
 ;;=3^DM Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,22024,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,22024,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,22025,0)
 ;;=E11.21^^87^973^17
 ;;^UTILITY(U,$J,358.3,22025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22025,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Nephropathy
