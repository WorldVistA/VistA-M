IBDEI0EB ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18073,0)
 ;;=C85.80^^53^754^60
 ;;^UTILITY(U,$J,358.3,18073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18073,1,3,0)
 ;;=3^Non-Hodgkin Lymphoma,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,18073,1,4,0)
 ;;=4^C85.80
 ;;^UTILITY(U,$J,358.3,18073,2)
 ;;=^5001721
 ;;^UTILITY(U,$J,358.3,18074,0)
 ;;=C85.89^^53^754^59
 ;;^UTILITY(U,$J,358.3,18074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18074,1,3,0)
 ;;=3^Non-Hodgkin Lymphoma,Extranodal/Solid Organ Sites NEC
 ;;^UTILITY(U,$J,358.3,18074,1,4,0)
 ;;=4^C85.89
 ;;^UTILITY(U,$J,358.3,18074,2)
 ;;=^5001730
 ;;^UTILITY(U,$J,358.3,18075,0)
 ;;=C90.01^^53^754^57
 ;;^UTILITY(U,$J,358.3,18075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18075,1,3,0)
 ;;=3^Multiple Myeloma in Remission
 ;;^UTILITY(U,$J,358.3,18075,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,18075,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,18076,0)
 ;;=C91.90^^53^754^24
 ;;^UTILITY(U,$J,358.3,18076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18076,1,3,0)
 ;;=3^Lymphoid Leukemia,Unspec
 ;;^UTILITY(U,$J,358.3,18076,1,4,0)
 ;;=4^C91.90
 ;;^UTILITY(U,$J,358.3,18076,2)
 ;;=^5001780
 ;;^UTILITY(U,$J,358.3,18077,0)
 ;;=C92.90^^53^754^58
 ;;^UTILITY(U,$J,358.3,18077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18077,1,3,0)
 ;;=3^Myeloid Leukemia,Unspec
 ;;^UTILITY(U,$J,358.3,18077,1,4,0)
 ;;=4^C92.90
 ;;^UTILITY(U,$J,358.3,18077,2)
 ;;=^5001810
 ;;^UTILITY(U,$J,358.3,18078,0)
 ;;=D04.9^^53^754^9
 ;;^UTILITY(U,$J,358.3,18078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18078,1,3,0)
 ;;=3^Carcinoma in Situ of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,18078,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,18078,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,18079,0)
 ;;=D05.91^^53^754^5
 ;;^UTILITY(U,$J,358.3,18079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18079,1,3,0)
 ;;=3^Carcinoma in Situ of Breast,Right,Unspec
 ;;^UTILITY(U,$J,358.3,18079,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,18079,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,18080,0)
 ;;=D05.92^^53^754^3
 ;;^UTILITY(U,$J,358.3,18080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18080,1,3,0)
 ;;=3^Carcinoma in Situ of Breast,Left,Unspec
 ;;^UTILITY(U,$J,358.3,18080,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,18080,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,18081,0)
 ;;=D05.01^^53^754^21
 ;;^UTILITY(U,$J,358.3,18081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18081,1,3,0)
 ;;=3^Lobular Carcinoma in Situ of Breast,Right
 ;;^UTILITY(U,$J,358.3,18081,1,4,0)
 ;;=4^D05.01
 ;;^UTILITY(U,$J,358.3,18081,2)
 ;;=^5001927
 ;;^UTILITY(U,$J,358.3,18082,0)
 ;;=D05.02^^53^754^20
 ;;^UTILITY(U,$J,358.3,18082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18082,1,3,0)
 ;;=3^Lobular Carcinoma in Situ of Breast,Left
 ;;^UTILITY(U,$J,358.3,18082,1,4,0)
 ;;=4^D05.02
 ;;^UTILITY(U,$J,358.3,18082,2)
 ;;=^5001928
 ;;^UTILITY(U,$J,358.3,18083,0)
 ;;=D05.11^^53^754^15
 ;;^UTILITY(U,$J,358.3,18083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18083,1,3,0)
 ;;=3^Intraductal Carcinoma in Situ of Breast,Right
 ;;^UTILITY(U,$J,358.3,18083,1,4,0)
 ;;=4^D05.11
 ;;^UTILITY(U,$J,358.3,18083,2)
 ;;=^5001930
 ;;^UTILITY(U,$J,358.3,18084,0)
 ;;=D05.12^^53^754^16
 ;;^UTILITY(U,$J,358.3,18084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18084,1,3,0)
 ;;=3^Intraductal Carcinoma in Situ of Breast,Left
 ;;^UTILITY(U,$J,358.3,18084,1,4,0)
 ;;=4^D05.12
 ;;^UTILITY(U,$J,358.3,18084,2)
 ;;=^5001931
 ;;^UTILITY(U,$J,358.3,18085,0)
 ;;=D05.81^^53^754^4
 ;;^UTILITY(U,$J,358.3,18085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18085,1,3,0)
 ;;=3^Carcinoma in Situ of Breast,Right NEC
 ;;^UTILITY(U,$J,358.3,18085,1,4,0)
 ;;=4^D05.81
 ;;^UTILITY(U,$J,358.3,18085,2)
 ;;=^5001933
 ;;^UTILITY(U,$J,358.3,18086,0)
 ;;=D05.82^^53^754^2
 ;;^UTILITY(U,$J,358.3,18086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18086,1,3,0)
 ;;=3^Carcinoma in Situ of Breast,Left NEC
 ;;^UTILITY(U,$J,358.3,18086,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,18086,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,18087,0)
 ;;=D06.9^^53^754^6
 ;;^UTILITY(U,$J,358.3,18087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18087,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Unspec
 ;;^UTILITY(U,$J,358.3,18087,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,18087,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,18088,0)
 ;;=D06.0^^53^754^7
 ;;^UTILITY(U,$J,358.3,18088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18088,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,18088,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,18088,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,18089,0)
 ;;=D06.1^^53^754^8
 ;;^UTILITY(U,$J,358.3,18089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18089,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,18089,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,18089,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,18090,0)
 ;;=D09.0^^53^754^1
 ;;^UTILITY(U,$J,358.3,18090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18090,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,18090,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,18090,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,18091,0)
 ;;=C90.30^^53^754^88
 ;;^UTILITY(U,$J,358.3,18091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18091,1,3,0)
 ;;=3^Solitary Plasmacytoma,Not in Remission
 ;;^UTILITY(U,$J,358.3,18091,1,4,0)
 ;;=4^C90.30
 ;;^UTILITY(U,$J,358.3,18091,2)
 ;;=^5001759
 ;;^UTILITY(U,$J,358.3,18092,0)
 ;;=Z85.818^^53^754^71
 ;;^UTILITY(U,$J,358.3,18092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18092,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lip/Oral Cavity/Pharynx
 ;;^UTILITY(U,$J,358.3,18092,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,18092,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,18093,0)
 ;;=Z85.01^^53^754^67
 ;;^UTILITY(U,$J,358.3,18093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18093,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Esophagus
 ;;^UTILITY(U,$J,358.3,18093,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,18093,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,18094,0)
 ;;=Z85.028^^53^754^77
 ;;^UTILITY(U,$J,358.3,18094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18094,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Stomach
 ;;^UTILITY(U,$J,358.3,18094,1,4,0)
 ;;=4^Z85.028
 ;;^UTILITY(U,$J,358.3,18094,2)
 ;;=^5063397
 ;;^UTILITY(U,$J,358.3,18095,0)
 ;;=Z85.038^^53^754^69
 ;;^UTILITY(U,$J,358.3,18095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18095,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Large Intestine
 ;;^UTILITY(U,$J,358.3,18095,1,4,0)
 ;;=4^Z85.038
 ;;^UTILITY(U,$J,358.3,18095,2)
 ;;=^5063399
 ;;^UTILITY(U,$J,358.3,18096,0)
 ;;=Z85.048^^53^754^75
 ;;^UTILITY(U,$J,358.3,18096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18096,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Rectum/Rectosig Junct/Anus
 ;;^UTILITY(U,$J,358.3,18096,1,4,0)
 ;;=4^Z85.048
 ;;^UTILITY(U,$J,358.3,18096,2)
 ;;=^5063401
 ;;^UTILITY(U,$J,358.3,18097,0)
 ;;=Z85.118^^53^754^65
 ;;^UTILITY(U,$J,358.3,18097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18097,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,18097,1,4,0)
 ;;=4^Z85.118
 ;;^UTILITY(U,$J,358.3,18097,2)
 ;;=^5063408
 ;;^UTILITY(U,$J,358.3,18098,0)
 ;;=Z85.21^^53^754^70
 ;;^UTILITY(U,$J,358.3,18098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18098,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Larynx
 ;;^UTILITY(U,$J,358.3,18098,1,4,0)
 ;;=4^Z85.21
 ;;^UTILITY(U,$J,358.3,18098,2)
 ;;=^5063411
 ;;^UTILITY(U,$J,358.3,18099,0)
 ;;=Z85.3^^53^754^64
 ;;^UTILITY(U,$J,358.3,18099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18099,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,18099,1,4,0)
 ;;=4^Z85.3
 ;;^UTILITY(U,$J,358.3,18099,2)
 ;;=^5063416
 ;;^UTILITY(U,$J,358.3,18100,0)
 ;;=Z85.41^^53^754^66
 ;;^UTILITY(U,$J,358.3,18100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18100,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Cervix Uteri
 ;;^UTILITY(U,$J,358.3,18100,1,4,0)
 ;;=4^Z85.41
 ;;^UTILITY(U,$J,358.3,18100,2)
 ;;=^5063418
 ;;^UTILITY(U,$J,358.3,18101,0)
 ;;=Z85.43^^53^754^73
 ;;^UTILITY(U,$J,358.3,18101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18101,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Ovary
 ;;^UTILITY(U,$J,358.3,18101,1,4,0)
 ;;=4^Z85.43
 ;;^UTILITY(U,$J,358.3,18101,2)
 ;;=^5063420
 ;;^UTILITY(U,$J,358.3,18102,0)
 ;;=Z85.46^^53^754^74
 ;;^UTILITY(U,$J,358.3,18102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18102,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,18102,1,4,0)
 ;;=4^Z85.46
 ;;^UTILITY(U,$J,358.3,18102,2)
 ;;=^5063423
 ;;^UTILITY(U,$J,358.3,18103,0)
 ;;=Z85.47^^53^754^78
 ;;^UTILITY(U,$J,358.3,18103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18103,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Testis
 ;;^UTILITY(U,$J,358.3,18103,1,4,0)
 ;;=4^Z85.47
 ;;^UTILITY(U,$J,358.3,18103,2)
 ;;=^5063424
 ;;^UTILITY(U,$J,358.3,18104,0)
 ;;=Z85.51^^53^754^63
 ;;^UTILITY(U,$J,358.3,18104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18104,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Bladder
 ;;^UTILITY(U,$J,358.3,18104,1,4,0)
 ;;=4^Z85.51
 ;;^UTILITY(U,$J,358.3,18104,2)
 ;;=^5063428
 ;;^UTILITY(U,$J,358.3,18105,0)
 ;;=Z85.528^^53^754^68
 ;;^UTILITY(U,$J,358.3,18105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18105,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Kidney
 ;;^UTILITY(U,$J,358.3,18105,1,4,0)
 ;;=4^Z85.528
 ;;^UTILITY(U,$J,358.3,18105,2)
 ;;=^5063430
 ;;^UTILITY(U,$J,358.3,18106,0)
 ;;=Z85.6^^53^754^61
 ;;^UTILITY(U,$J,358.3,18106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18106,1,3,0)
 ;;=3^Personal Hx of Leukemia
 ;;^UTILITY(U,$J,358.3,18106,1,4,0)
 ;;=4^Z85.6
 ;;^UTILITY(U,$J,358.3,18106,2)
 ;;=^5063434
 ;;^UTILITY(U,$J,358.3,18107,0)
 ;;=Z85.79^^53^754^72
 ;;^UTILITY(U,$J,358.3,18107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18107,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lymphoid/Hematpoetc/Related Tissues
 ;;^UTILITY(U,$J,358.3,18107,1,4,0)
 ;;=4^Z85.79
 ;;^UTILITY(U,$J,358.3,18107,2)
 ;;=^5063437
