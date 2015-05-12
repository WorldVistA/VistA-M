IBDEI049 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5196,1,4,0)
 ;;=4^L91.0
 ;;^UTILITY(U,$J,358.3,5196,2)
 ;;=^5009459
 ;;^UTILITY(U,$J,358.3,5197,0)
 ;;=C80.0^^22^226^4
 ;;^UTILITY(U,$J,358.3,5197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5197,1,3,0)
 ;;=3^Disseminated Malig Neop,Unspec
 ;;^UTILITY(U,$J,358.3,5197,1,4,0)
 ;;=4^C80.0
 ;;^UTILITY(U,$J,358.3,5197,2)
 ;;=^5001388
 ;;^UTILITY(U,$J,358.3,5198,0)
 ;;=C80.1^^22^226^9
 ;;^UTILITY(U,$J,358.3,5198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5198,1,3,0)
 ;;=3^Malig Neop,Unspec
 ;;^UTILITY(U,$J,358.3,5198,1,4,0)
 ;;=4^C80.1
 ;;^UTILITY(U,$J,358.3,5198,2)
 ;;=^5001389
 ;;^UTILITY(U,$J,358.3,5199,0)
 ;;=C80.2^^22^226^8
 ;;^UTILITY(U,$J,358.3,5199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5199,1,3,0)
 ;;=3^Malig Neop Associated w/ Transplanted Organ
 ;;^UTILITY(U,$J,358.3,5199,1,4,0)
 ;;=4^C80.2
 ;;^UTILITY(U,$J,358.3,5199,2)
 ;;=^5001390
 ;;^UTILITY(U,$J,358.3,5200,0)
 ;;=Z85.030^^22^227^1
 ;;^UTILITY(U,$J,358.3,5200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5200,1,3,0)
 ;;=3^Personal Hx of Malig Carcinoid Tumor of Large Intestine
 ;;^UTILITY(U,$J,358.3,5200,1,4,0)
 ;;=4^Z85.030
 ;;^UTILITY(U,$J,358.3,5200,2)
 ;;=^5063398
 ;;^UTILITY(U,$J,358.3,5201,0)
 ;;=Z85.040^^22^227^2
 ;;^UTILITY(U,$J,358.3,5201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5201,1,3,0)
 ;;=3^Personal Hx of Malig Carcinoid Tumor of Rectum
 ;;^UTILITY(U,$J,358.3,5201,1,4,0)
 ;;=4^Z85.040
 ;;^UTILITY(U,$J,358.3,5201,2)
 ;;=^5063400
 ;;^UTILITY(U,$J,358.3,5202,0)
 ;;=Z85.060^^22^227^3
 ;;^UTILITY(U,$J,358.3,5202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5202,1,3,0)
 ;;=3^Personal Hx of Malig Carcinoid Tumor of Small Intestine
 ;;^UTILITY(U,$J,358.3,5202,1,4,0)
 ;;=4^Z85.060
 ;;^UTILITY(U,$J,358.3,5202,2)
 ;;=^5063403
 ;;^UTILITY(U,$J,358.3,5203,0)
 ;;=Z85.110^^22^227^4
 ;;^UTILITY(U,$J,358.3,5203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5203,1,3,0)
 ;;=3^Personal Hx of Malig Carcinoid Tumor of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,5203,1,4,0)
 ;;=4^Z85.110
 ;;^UTILITY(U,$J,358.3,5203,2)
 ;;=^5063407
 ;;^UTILITY(U,$J,358.3,5204,0)
 ;;=Z85.820^^22^227^5
 ;;^UTILITY(U,$J,358.3,5204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5204,1,3,0)
 ;;=3^Personal Hx of Malig Melanoma of Skin
 ;;^UTILITY(U,$J,358.3,5204,1,4,0)
 ;;=4^Z85.820
 ;;^UTILITY(U,$J,358.3,5204,2)
 ;;=^5063441
 ;;^UTILITY(U,$J,358.3,5205,0)
 ;;=Z85.51^^22^227^6
 ;;^UTILITY(U,$J,358.3,5205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5205,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Bladder
 ;;^UTILITY(U,$J,358.3,5205,1,4,0)
 ;;=4^Z85.51
 ;;^UTILITY(U,$J,358.3,5205,2)
 ;;=^5063428
 ;;^UTILITY(U,$J,358.3,5206,0)
 ;;=Z85.830^^22^227^7
 ;;^UTILITY(U,$J,358.3,5206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5206,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Bone
 ;;^UTILITY(U,$J,358.3,5206,1,4,0)
 ;;=4^Z85.830
 ;;^UTILITY(U,$J,358.3,5206,2)
 ;;=^5063444
 ;;^UTILITY(U,$J,358.3,5207,0)
 ;;=Z85.3^^22^227^8
 ;;^UTILITY(U,$J,358.3,5207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5207,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Breast
 ;;^UTILITY(U,$J,358.3,5207,1,4,0)
 ;;=4^Z85.3
 ;;^UTILITY(U,$J,358.3,5207,2)
 ;;=^5063416
 ;;^UTILITY(U,$J,358.3,5208,0)
 ;;=Z85.118^^22^227^9
 ;;^UTILITY(U,$J,358.3,5208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5208,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,5208,1,4,0)
 ;;=4^Z85.118
 ;;^UTILITY(U,$J,358.3,5208,2)
 ;;=^5063408
 ;;^UTILITY(U,$J,358.3,5209,0)
 ;;=Z85.09^^22^227^10
 ;;^UTILITY(U,$J,358.3,5209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5209,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Digestive Organs
 ;;^UTILITY(U,$J,358.3,5209,1,4,0)
 ;;=4^Z85.09
 ;;^UTILITY(U,$J,358.3,5209,2)
 ;;=^5063406
 ;;^UTILITY(U,$J,358.3,5210,0)
 ;;=Z85.01^^22^227^11
 ;;^UTILITY(U,$J,358.3,5210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5210,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Esophagus
 ;;^UTILITY(U,$J,358.3,5210,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,5210,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,5211,0)
 ;;=Z85.528^^22^227^12
 ;;^UTILITY(U,$J,358.3,5211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5211,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Kidney
 ;;^UTILITY(U,$J,358.3,5211,1,4,0)
 ;;=4^Z85.528
 ;;^UTILITY(U,$J,358.3,5211,2)
 ;;=^5063430
 ;;^UTILITY(U,$J,358.3,5212,0)
 ;;=Z85.038^^22^227^13
 ;;^UTILITY(U,$J,358.3,5212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5212,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Large Intestine
 ;;^UTILITY(U,$J,358.3,5212,1,4,0)
 ;;=4^Z85.038
 ;;^UTILITY(U,$J,358.3,5212,2)
 ;;=^5063399
 ;;^UTILITY(U,$J,358.3,5213,0)
 ;;=Z85.21^^22^227^14
 ;;^UTILITY(U,$J,358.3,5213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5213,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Larynx
 ;;^UTILITY(U,$J,358.3,5213,1,4,0)
 ;;=4^Z85.21
 ;;^UTILITY(U,$J,358.3,5213,2)
 ;;=^5063411
 ;;^UTILITY(U,$J,358.3,5214,0)
 ;;=Z85.819^^22^227^15
 ;;^UTILITY(U,$J,358.3,5214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5214,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Lip.Oral Cavity/Pharynx,Unspec
 ;;^UTILITY(U,$J,358.3,5214,1,4,0)
 ;;=4^Z85.819
 ;;^UTILITY(U,$J,358.3,5214,2)
 ;;=^5063440
 ;;^UTILITY(U,$J,358.3,5215,0)
 ;;=Z85.05^^22^227^16
 ;;^UTILITY(U,$J,358.3,5215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5215,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Liver
 ;;^UTILITY(U,$J,358.3,5215,1,4,0)
 ;;=4^Z85.05
 ;;^UTILITY(U,$J,358.3,5215,2)
 ;;=^5063402
 ;;^UTILITY(U,$J,358.3,5216,0)
 ;;=Z85.79^^22^227^17
 ;;^UTILITY(U,$J,358.3,5216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5216,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Lymphoid/Hematpoetc/Rel Tiss
 ;;^UTILITY(U,$J,358.3,5216,1,4,0)
 ;;=4^Z85.79
 ;;^UTILITY(U,$J,358.3,5216,2)
 ;;=^5063437
 ;;^UTILITY(U,$J,358.3,5217,0)
 ;;=Z85.22^^22^227^18
 ;;^UTILITY(U,$J,358.3,5217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5217,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Nasal Cavity/Med Ear/Acces Sinus
 ;;^UTILITY(U,$J,358.3,5217,1,4,0)
 ;;=4^Z85.22
 ;;^UTILITY(U,$J,358.3,5217,2)
 ;;=^5063412
 ;;^UTILITY(U,$J,358.3,5218,0)
 ;;=Z85.07^^22^227^19
 ;;^UTILITY(U,$J,358.3,5218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5218,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Pancreas
 ;;^UTILITY(U,$J,358.3,5218,1,4,0)
 ;;=4^Z85.07
 ;;^UTILITY(U,$J,358.3,5218,2)
 ;;=^5063405
 ;;^UTILITY(U,$J,358.3,5219,0)
 ;;=Z85.46^^22^227^20
 ;;^UTILITY(U,$J,358.3,5219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5219,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Prostate
 ;;^UTILITY(U,$J,358.3,5219,1,4,0)
 ;;=4^Z85.46
 ;;^UTILITY(U,$J,358.3,5219,2)
 ;;=^5063423
 ;;^UTILITY(U,$J,358.3,5220,0)
 ;;=Z85.048^^22^227^21
 ;;^UTILITY(U,$J,358.3,5220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5220,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Rectum/Rectosig Junct/Anus
 ;;^UTILITY(U,$J,358.3,5220,1,4,0)
 ;;=4^Z85.048
 ;;^UTILITY(U,$J,358.3,5220,2)
 ;;=^5063401
 ;;^UTILITY(U,$J,358.3,5221,0)
 ;;=Z85.29^^22^227^22
 ;;^UTILITY(U,$J,358.3,5221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5221,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Resp/Intrathoracic Organs
 ;;^UTILITY(U,$J,358.3,5221,1,4,0)
 ;;=4^Z85.29
 ;;^UTILITY(U,$J,358.3,5221,2)
 ;;=^5063415
 ;;^UTILITY(U,$J,358.3,5222,0)
 ;;=Z85.068^^22^227^23
 ;;^UTILITY(U,$J,358.3,5222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5222,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Small Intestine
 ;;^UTILITY(U,$J,358.3,5222,1,4,0)
 ;;=4^Z85.068
 ;;^UTILITY(U,$J,358.3,5222,2)
 ;;=^5063404
 ;;^UTILITY(U,$J,358.3,5223,0)
 ;;=Z85.831^^22^227^24
 ;;^UTILITY(U,$J,358.3,5223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5223,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Soft Tissue
 ;;^UTILITY(U,$J,358.3,5223,1,4,0)
 ;;=4^Z85.831
 ;;^UTILITY(U,$J,358.3,5223,2)
 ;;=^5063445
 ;;^UTILITY(U,$J,358.3,5224,0)
 ;;=Z85.028^^22^227^25
 ;;^UTILITY(U,$J,358.3,5224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5224,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Stomach
 ;;^UTILITY(U,$J,358.3,5224,1,4,0)
 ;;=4^Z85.028
 ;;^UTILITY(U,$J,358.3,5224,2)
 ;;=^5063397
 ;;^UTILITY(U,$J,358.3,5225,0)
 ;;=Z85.47^^22^227^26
 ;;^UTILITY(U,$J,358.3,5225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5225,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Testis
 ;;^UTILITY(U,$J,358.3,5225,1,4,0)
 ;;=4^Z85.47
 ;;^UTILITY(U,$J,358.3,5225,2)
 ;;=^5063424
 ;;^UTILITY(U,$J,358.3,5226,0)
 ;;=Z85.810^^22^227^27
 ;;^UTILITY(U,$J,358.3,5226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5226,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Tongue
 ;;^UTILITY(U,$J,358.3,5226,1,4,0)
 ;;=4^Z85.810
 ;;^UTILITY(U,$J,358.3,5226,2)
 ;;=^5063438
 ;;^UTILITY(U,$J,358.3,5227,0)
 ;;=Z85.12^^22^227^28
 ;;^UTILITY(U,$J,358.3,5227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5227,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Trachea
 ;;^UTILITY(U,$J,358.3,5227,1,4,0)
 ;;=4^Z85.12
 ;;^UTILITY(U,$J,358.3,5227,2)
 ;;=^5063409
 ;;^UTILITY(U,$J,358.3,5228,0)
 ;;=Z85.821^^22^227^29
 ;;^UTILITY(U,$J,358.3,5228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5228,1,3,0)
 ;;=3^Personal Hx of Merkel Cell Carcinoma
 ;;^UTILITY(U,$J,358.3,5228,1,4,0)
 ;;=4^Z85.821
 ;;^UTILITY(U,$J,358.3,5228,2)
 ;;=^5063442
 ;;^UTILITY(U,$J,358.3,5229,0)
 ;;=C4A.0^^22^228^9
 ;;^UTILITY(U,$J,358.3,5229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5229,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Lip
 ;;^UTILITY(U,$J,358.3,5229,1,4,0)
 ;;=4^C4A.0
 ;;^UTILITY(U,$J,358.3,5229,2)
 ;;=^5001137
 ;;^UTILITY(U,$J,358.3,5230,0)
 ;;=C4A.11^^22^228^12
 ;;^UTILITY(U,$J,358.3,5230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5230,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Right Eyelid
 ;;^UTILITY(U,$J,358.3,5230,1,4,0)
 ;;=4^C4A.11
 ;;^UTILITY(U,$J,358.3,5230,2)
 ;;=^5001139
 ;;^UTILITY(U,$J,358.3,5231,0)
 ;;=C4A.12^^22^228^6
 ;;^UTILITY(U,$J,358.3,5231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5231,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Left Eyelid
 ;;^UTILITY(U,$J,358.3,5231,1,4,0)
 ;;=4^C4A.12
