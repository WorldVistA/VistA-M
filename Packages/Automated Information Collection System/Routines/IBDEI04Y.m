IBDEI04Y ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6098,1,3,0)
 ;;=3^Epistaxis
 ;;^UTILITY(U,$J,358.3,6098,1,4,0)
 ;;=4^R04.0
 ;;^UTILITY(U,$J,358.3,6098,2)
 ;;=^5019173
 ;;^UTILITY(U,$J,358.3,6099,0)
 ;;=R09.82^^26^393^27
 ;;^UTILITY(U,$J,358.3,6099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6099,1,3,0)
 ;;=3^Postnasal Drip
 ;;^UTILITY(U,$J,358.3,6099,1,4,0)
 ;;=4^R09.82
 ;;^UTILITY(U,$J,358.3,6099,2)
 ;;=^97058
 ;;^UTILITY(U,$J,358.3,6100,0)
 ;;=K12.30^^26^393^20
 ;;^UTILITY(U,$J,358.3,6100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6100,1,3,0)
 ;;=3^Oral Mucositis,Unspec
 ;;^UTILITY(U,$J,358.3,6100,1,4,0)
 ;;=4^K12.30
 ;;^UTILITY(U,$J,358.3,6100,2)
 ;;=^5008486
 ;;^UTILITY(U,$J,358.3,6101,0)
 ;;=J30.1^^26^393^10
 ;;^UTILITY(U,$J,358.3,6101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6101,1,3,0)
 ;;=3^Allergic Rhinitis d/t Pollen
 ;;^UTILITY(U,$J,358.3,6101,1,4,0)
 ;;=4^J30.1
 ;;^UTILITY(U,$J,358.3,6101,2)
 ;;=^269906
 ;;^UTILITY(U,$J,358.3,6102,0)
 ;;=R09.81^^26^393^18
 ;;^UTILITY(U,$J,358.3,6102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6102,1,3,0)
 ;;=3^Nasal Congestion
 ;;^UTILITY(U,$J,358.3,6102,1,4,0)
 ;;=4^R09.81
 ;;^UTILITY(U,$J,358.3,6102,2)
 ;;=^5019203
 ;;^UTILITY(U,$J,358.3,6103,0)
 ;;=H60.93^^26^393^21
 ;;^UTILITY(U,$J,358.3,6103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6103,1,3,0)
 ;;=3^Otitis Externa,Unspec,Bilateral
 ;;^UTILITY(U,$J,358.3,6103,1,4,0)
 ;;=4^H60.93
 ;;^UTILITY(U,$J,358.3,6103,2)
 ;;=^5006498
 ;;^UTILITY(U,$J,358.3,6104,0)
 ;;=H60.92^^26^393^22
 ;;^UTILITY(U,$J,358.3,6104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6104,1,3,0)
 ;;=3^Otitis Externa,Unspec,Left Ear
 ;;^UTILITY(U,$J,358.3,6104,1,4,0)
 ;;=4^H60.92
 ;;^UTILITY(U,$J,358.3,6104,2)
 ;;=^5133525
 ;;^UTILITY(U,$J,358.3,6105,0)
 ;;=H60.91^^26^393^23
 ;;^UTILITY(U,$J,358.3,6105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6105,1,3,0)
 ;;=3^Otitis Externa,Unspec,Right Ear
 ;;^UTILITY(U,$J,358.3,6105,1,4,0)
 ;;=4^H60.91
 ;;^UTILITY(U,$J,358.3,6105,2)
 ;;=^5133524
 ;;^UTILITY(U,$J,358.3,6106,0)
 ;;=H66.93^^26^393^24
 ;;^UTILITY(U,$J,358.3,6106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6106,1,3,0)
 ;;=3^Otitis Media,Unspec,Bilateral
 ;;^UTILITY(U,$J,358.3,6106,1,4,0)
 ;;=4^H66.93
 ;;^UTILITY(U,$J,358.3,6106,2)
 ;;=^5006642
 ;;^UTILITY(U,$J,358.3,6107,0)
 ;;=H66.91^^26^393^26
 ;;^UTILITY(U,$J,358.3,6107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6107,1,3,0)
 ;;=3^Otitis Media,Unspec,Right Ear
 ;;^UTILITY(U,$J,358.3,6107,1,4,0)
 ;;=4^H66.91
 ;;^UTILITY(U,$J,358.3,6107,2)
 ;;=^5006640
 ;;^UTILITY(U,$J,358.3,6108,0)
 ;;=H66.92^^26^393^25
 ;;^UTILITY(U,$J,358.3,6108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6108,1,3,0)
 ;;=3^Otitis Media,Unspec,Left Ear
 ;;^UTILITY(U,$J,358.3,6108,1,4,0)
 ;;=4^H66.92
 ;;^UTILITY(U,$J,358.3,6108,2)
 ;;=^5006641
 ;;^UTILITY(U,$J,358.3,6109,0)
 ;;=E04.0^^26^394^39
 ;;^UTILITY(U,$J,358.3,6109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6109,1,3,0)
 ;;=3^Nontoxic Diffuse Goiter
 ;;^UTILITY(U,$J,358.3,6109,1,4,0)
 ;;=4^E04.0
 ;;^UTILITY(U,$J,358.3,6109,2)
 ;;=^5002477
 ;;^UTILITY(U,$J,358.3,6110,0)
 ;;=E04.1^^26^394^41
 ;;^UTILITY(U,$J,358.3,6110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6110,1,3,0)
 ;;=3^Nontoxic Single Thyroid Nodule
 ;;^UTILITY(U,$J,358.3,6110,1,4,0)
 ;;=4^E04.1
 ;;^UTILITY(U,$J,358.3,6110,2)
 ;;=^5002478
 ;;^UTILITY(U,$J,358.3,6111,0)
 ;;=E04.2^^26^394^40
 ;;^UTILITY(U,$J,358.3,6111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6111,1,3,0)
 ;;=3^Nontoxic Multinodular Goiter
 ;;^UTILITY(U,$J,358.3,6111,1,4,0)
 ;;=4^E04.2
 ;;^UTILITY(U,$J,358.3,6111,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,6112,0)
 ;;=E01.1^^26^394^36
 ;;^UTILITY(U,$J,358.3,6112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6112,1,3,0)
 ;;=3^Iodine-Deficiency Related Multinodular (Endemic) Goiter
 ;;^UTILITY(U,$J,358.3,6112,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,6112,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,6113,0)
 ;;=E05.00^^26^394^56
 ;;^UTILITY(U,$J,358.3,6113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6113,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,6113,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,6113,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,6114,0)
 ;;=E05.01^^26^394^55
 ;;^UTILITY(U,$J,358.3,6114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6114,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,6114,1,4,0)
 ;;=4^E05.01
 ;;^UTILITY(U,$J,358.3,6114,2)
 ;;=^5002482
 ;;^UTILITY(U,$J,358.3,6115,0)
 ;;=E05.90^^26^394^58
 ;;^UTILITY(U,$J,358.3,6115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6115,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,6115,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,6115,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,6116,0)
 ;;=E05.91^^26^394^57
 ;;^UTILITY(U,$J,358.3,6116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6116,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,6116,1,4,0)
 ;;=4^E05.91
 ;;^UTILITY(U,$J,358.3,6116,2)
 ;;=^5002493
 ;;^UTILITY(U,$J,358.3,6117,0)
 ;;=E89.0^^26^394^50
 ;;^UTILITY(U,$J,358.3,6117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6117,1,3,0)
 ;;=3^Postprocedural Hypothyroidism
 ;;^UTILITY(U,$J,358.3,6117,1,4,0)
 ;;=4^E89.0
 ;;^UTILITY(U,$J,358.3,6117,2)
 ;;=^5003035
 ;;^UTILITY(U,$J,358.3,6118,0)
 ;;=E03.2^^26^394^32
 ;;^UTILITY(U,$J,358.3,6118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6118,1,3,0)
 ;;=3^Hypothyroidism d/t Meds/Oth Exogenous Substances
 ;;^UTILITY(U,$J,358.3,6118,1,4,0)
 ;;=4^E03.2
 ;;^UTILITY(U,$J,358.3,6118,2)
 ;;=^5002471
 ;;^UTILITY(U,$J,358.3,6119,0)
 ;;=E03.9^^26^394^33
 ;;^UTILITY(U,$J,358.3,6119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6119,1,3,0)
 ;;=3^Hypothyroidism,Unspec
 ;;^UTILITY(U,$J,358.3,6119,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,6119,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,6120,0)
 ;;=E06.0^^26^394^53
 ;;^UTILITY(U,$J,358.3,6120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6120,1,3,0)
 ;;=3^Thyroiditis,Acute
 ;;^UTILITY(U,$J,358.3,6120,1,4,0)
 ;;=4^E06.0
 ;;^UTILITY(U,$J,358.3,6120,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,6121,0)
 ;;=E06.1^^26^394^54
 ;;^UTILITY(U,$J,358.3,6121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6121,1,3,0)
 ;;=3^Thyroiditis,Subacute
 ;;^UTILITY(U,$J,358.3,6121,1,4,0)
 ;;=4^E06.1
 ;;^UTILITY(U,$J,358.3,6121,2)
 ;;=^119376
 ;;^UTILITY(U,$J,358.3,6122,0)
 ;;=C73.^^26^394^37
 ;;^UTILITY(U,$J,358.3,6122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6122,1,3,0)
 ;;=3^Malig Neop of Thyroid Gland
 ;;^UTILITY(U,$J,358.3,6122,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,6122,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,6123,0)
 ;;=E10.21^^26^394^8
 ;;^UTILITY(U,$J,358.3,6123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6123,1,3,0)
 ;;=3^DM Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,6123,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,6123,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,6124,0)
 ;;=E10.9^^26^394^12
 ;;^UTILITY(U,$J,358.3,6124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6124,1,3,0)
 ;;=3^DM Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,6124,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,6124,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,6125,0)
 ;;=E11.21^^26^394^17
 ;;^UTILITY(U,$J,358.3,6125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6125,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,6125,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,6125,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,6126,0)
 ;;=E11.39^^26^394^18
 ;;^UTILITY(U,$J,358.3,6126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6126,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Ophthalmic Complication NEC
 ;;^UTILITY(U,$J,358.3,6126,1,4,0)
 ;;=4^E11.39
 ;;^UTILITY(U,$J,358.3,6126,2)
 ;;=^5002643
 ;;^UTILITY(U,$J,358.3,6127,0)
 ;;=E11.43^^26^394^15
 ;;^UTILITY(U,$J,358.3,6127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6127,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Autonomic Neuropathy
 ;;^UTILITY(U,$J,358.3,6127,1,4,0)
 ;;=4^E11.43
 ;;^UTILITY(U,$J,358.3,6127,2)
 ;;=^5002647
 ;;^UTILITY(U,$J,358.3,6128,0)
 ;;=E11.59^^26^394^13
 ;;^UTILITY(U,$J,358.3,6128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6128,1,3,0)
 ;;=3^DM Type 2 w/ Circulatory Complications NEC
 ;;^UTILITY(U,$J,358.3,6128,1,4,0)
 ;;=4^E11.59
 ;;^UTILITY(U,$J,358.3,6128,2)
 ;;=^5002652
 ;;^UTILITY(U,$J,358.3,6129,0)
 ;;=E11.618^^26^394^14
 ;;^UTILITY(U,$J,358.3,6129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6129,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Arthropathy NEC
 ;;^UTILITY(U,$J,358.3,6129,1,4,0)
 ;;=4^E11.618
 ;;^UTILITY(U,$J,358.3,6129,2)
 ;;=^5002654
 ;;^UTILITY(U,$J,358.3,6130,0)
 ;;=E11.621^^26^394^16
 ;;^UTILITY(U,$J,358.3,6130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6130,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Foot Ulcer
 ;;^UTILITY(U,$J,358.3,6130,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,6130,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,6131,0)
 ;;=E11.622^^26^394^20
 ;;^UTILITY(U,$J,358.3,6131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6131,1,3,0)
 ;;=3^DM Type 2 w/ Skin Ulcer NEC
 ;;^UTILITY(U,$J,358.3,6131,1,4,0)
 ;;=4^E11.622
 ;;^UTILITY(U,$J,358.3,6131,2)
 ;;=^5002657
 ;;^UTILITY(U,$J,358.3,6132,0)
 ;;=E11.65^^26^394^19
 ;;^UTILITY(U,$J,358.3,6132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6132,1,3,0)
 ;;=3^DM Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,6132,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,6132,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,6133,0)
 ;;=E11.9^^26^394^21
 ;;^UTILITY(U,$J,358.3,6133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6133,1,3,0)
 ;;=3^DM Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,6133,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,6133,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,6134,0)
 ;;=E13.9^^26^394^22
 ;;^UTILITY(U,$J,358.3,6134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6134,1,3,0)
 ;;=3^Diabetes Mellitus (Secondary) w/o Complications NEC
