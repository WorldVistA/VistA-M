IBDEI07F ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9757,1,3,0)
 ;;=3^Severe Stage Glaucoma
 ;;^UTILITY(U,$J,358.3,9757,1,4,0)
 ;;=4^365.73
 ;;^UTILITY(U,$J,358.3,9757,2)
 ;;=^340515
 ;;^UTILITY(U,$J,358.3,9758,0)
 ;;=365.74^^77^662^9
 ;;^UTILITY(U,$J,358.3,9758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9758,1,3,0)
 ;;=3^Indeterm Stage Glaucoma
 ;;^UTILITY(U,$J,358.3,9758,1,4,0)
 ;;=4^365.74
 ;;^UTILITY(U,$J,358.3,9758,2)
 ;;=^340516
 ;;^UTILITY(U,$J,358.3,9759,0)
 ;;=V19.11^^77^662^5
 ;;^UTILITY(U,$J,358.3,9759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9759,1,3,0)
 ;;=3^Family Hx Glaucoma
 ;;^UTILITY(U,$J,358.3,9759,1,4,0)
 ;;=4^V19.11
 ;;^UTILITY(U,$J,358.3,9759,2)
 ;;=^340617
 ;;^UTILITY(U,$J,358.3,9760,0)
 ;;=V19.19^^77^662^6
 ;;^UTILITY(U,$J,358.3,9760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9760,1,3,0)
 ;;=3^Family Hx Oth Spec Eye Disord
 ;;^UTILITY(U,$J,358.3,9760,1,4,0)
 ;;=4^V19.19
 ;;^UTILITY(U,$J,358.3,9760,2)
 ;;=^340618
 ;;^UTILITY(U,$J,358.3,9761,0)
 ;;=378.83^^77^663^2
 ;;^UTILITY(U,$J,358.3,9761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9761,1,3,0)
 ;;=3^Convergence Insufficiency
 ;;^UTILITY(U,$J,358.3,9761,1,4,0)
 ;;=4^378.83
 ;;^UTILITY(U,$J,358.3,9761,2)
 ;;=Convergence Insufficiency^269277
 ;;^UTILITY(U,$J,358.3,9762,0)
 ;;=378.00^^77^663^4
 ;;^UTILITY(U,$J,358.3,9762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9762,1,3,0)
 ;;=3^Esotropia
 ;;^UTILITY(U,$J,358.3,9762,1,4,0)
 ;;=4^378.00
 ;;^UTILITY(U,$J,358.3,9762,2)
 ;;=Esotropia^42597
 ;;^UTILITY(U,$J,358.3,9763,0)
 ;;=378.10^^77^663^6
 ;;^UTILITY(U,$J,358.3,9763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9763,1,3,0)
 ;;=3^Exotropia
 ;;^UTILITY(U,$J,358.3,9763,1,4,0)
 ;;=4^378.10
 ;;^UTILITY(U,$J,358.3,9763,2)
 ;;=Exotropia^43741
 ;;^UTILITY(U,$J,358.3,9764,0)
 ;;=378.41^^77^663^3
 ;;^UTILITY(U,$J,358.3,9764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9764,1,3,0)
 ;;=3^Esophoria
 ;;^UTILITY(U,$J,358.3,9764,1,4,0)
 ;;=4^378.41
 ;;^UTILITY(U,$J,358.3,9764,2)
 ;;=Esophoria^265435
 ;;^UTILITY(U,$J,358.3,9765,0)
 ;;=378.42^^77^663^5
 ;;^UTILITY(U,$J,358.3,9765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9765,1,3,0)
 ;;=3^Exophoria
 ;;^UTILITY(U,$J,358.3,9765,1,4,0)
 ;;=4^378.42
 ;;^UTILITY(U,$J,358.3,9765,2)
 ;;=Exophoria^265436
 ;;^UTILITY(U,$J,358.3,9766,0)
 ;;=378.50^^77^663^11
 ;;^UTILITY(U,$J,358.3,9766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9766,1,3,0)
 ;;=3^Strabismus, Paralytic
 ;;^UTILITY(U,$J,358.3,9766,1,4,0)
 ;;=4^378.50
 ;;^UTILITY(U,$J,358.3,9766,2)
 ;;=Strabismus, Paralytic^265442
 ;;^UTILITY(U,$J,358.3,9767,0)
 ;;=378.40^^77^663^7
 ;;^UTILITY(U,$J,358.3,9767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9767,1,3,0)
 ;;=3^Heterophoria
 ;;^UTILITY(U,$J,358.3,9767,1,4,0)
 ;;=4^378.40
 ;;^UTILITY(U,$J,358.3,9767,2)
 ;;=Heterophoria^265433
 ;;^UTILITY(U,$J,358.3,9768,0)
 ;;=378.30^^77^663^8
 ;;^UTILITY(U,$J,358.3,9768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9768,1,3,0)
 ;;=3^Heterotropia
 ;;^UTILITY(U,$J,358.3,9768,1,4,0)
 ;;=4^378.30
 ;;^UTILITY(U,$J,358.3,9768,2)
 ;;=Heterotropia^265406
 ;;^UTILITY(U,$J,358.3,9769,0)
 ;;=378.60^^77^663^10
 ;;^UTILITY(U,$J,358.3,9769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9769,1,3,0)
 ;;=3^Strabismus, Mechanical
 ;;^UTILITY(U,$J,358.3,9769,1,4,0)
 ;;=4^378.60
 ;;^UTILITY(U,$J,358.3,9769,2)
 ;;=Strabismus, Mechanical^265445
 ;;^UTILITY(U,$J,358.3,9770,0)
 ;;=378.9^^77^663^12
 ;;^UTILITY(U,$J,358.3,9770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9770,1,3,0)
 ;;=3^Strabismus, Unspecified
 ;;^UTILITY(U,$J,358.3,9770,1,4,0)
 ;;=4^378.9
 ;;^UTILITY(U,$J,358.3,9770,2)
 ;;=Ophthalmoplegia, Unspec^123833
 ;;^UTILITY(U,$J,358.3,9771,0)
 ;;=368.00^^77^663^1
 ;;^UTILITY(U,$J,358.3,9771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9771,1,3,0)
 ;;=3^Amblyopia
 ;;^UTILITY(U,$J,358.3,9771,1,4,0)
 ;;=4^368.00
 ;;^UTILITY(U,$J,358.3,9771,2)
 ;;=^5731
 ;;^UTILITY(U,$J,358.3,9772,0)
 ;;=378.73^^77^663^9
 ;;^UTILITY(U,$J,358.3,9772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9772,1,3,0)
 ;;=3^Ocular Myasthenia Gravis
 ;;^UTILITY(U,$J,358.3,9772,1,4,0)
 ;;=4^378.73
 ;;^UTILITY(U,$J,358.3,9772,2)
 ;;=Ocular Myasthenia Gravis^269274
 ;;^UTILITY(U,$J,358.3,9773,0)
 ;;=360.01^^77^664^6
 ;;^UTILITY(U,$J,358.3,9773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9773,1,3,0)
 ;;=3^Endophalmitis
 ;;^UTILITY(U,$J,358.3,9773,1,4,0)
 ;;=4^360.01
 ;;^UTILITY(U,$J,358.3,9773,2)
 ;;=Endophalmitis^268545
 ;;^UTILITY(U,$J,358.3,9774,0)
 ;;=V08.^^77^664^8
 ;;^UTILITY(U,$J,358.3,9774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9774,1,3,0)
 ;;=3^HIV Status
 ;;^UTILITY(U,$J,358.3,9774,1,4,0)
 ;;=4^V08.
 ;;^UTILITY(U,$J,358.3,9774,2)
 ;;=HIV Status^303392
 ;;^UTILITY(U,$J,358.3,9775,0)
 ;;=078.5^^77^664^2
 ;;^UTILITY(U,$J,358.3,9775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9775,1,3,0)
 ;;=3^CMV Retinitis
 ;;^UTILITY(U,$J,358.3,9775,1,4,0)
 ;;=4^078.5
 ;;^UTILITY(U,$J,358.3,9775,2)
 ;;=CMV Retinitis^30676^366.20
 ;;^UTILITY(U,$J,358.3,9776,0)
 ;;=115.92^^77^664^9
 ;;^UTILITY(U,$J,358.3,9776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9776,1,3,0)
 ;;=3^Histoplasmosis (POHS)
 ;;^UTILITY(U,$J,358.3,9776,1,4,0)
 ;;=4^115.92
 ;;^UTILITY(U,$J,358.3,9776,2)
 ;;=Histoplasmosis Retinitis^266905
 ;;^UTILITY(U,$J,358.3,9777,0)
 ;;=130.2^^77^664^16
 ;;^UTILITY(U,$J,358.3,9777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9777,1,3,0)
 ;;=3^Toxoplasmosis Retinitis
 ;;^UTILITY(U,$J,358.3,9777,1,4,0)
 ;;=4^130.2
 ;;^UTILITY(U,$J,358.3,9777,2)
 ;;=Toxoplasmosis Retinitis^266947
 ;;^UTILITY(U,$J,358.3,9778,0)
 ;;=128.0^^77^664^15
 ;;^UTILITY(U,$J,358.3,9778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9778,1,3,0)
 ;;=3^Toxocariasis
 ;;^UTILITY(U,$J,358.3,9778,1,4,0)
 ;;=4^128.0
 ;;^UTILITY(U,$J,358.3,9778,2)
 ;;=Toxocariasis^120683
 ;;^UTILITY(U,$J,358.3,9779,0)
 ;;=053.20^^77^664^24
 ;;^UTILITY(U,$J,358.3,9779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9779,1,3,0)
 ;;=3^Herpes Zoster of Eyelid
 ;;^UTILITY(U,$J,358.3,9779,1,4,0)
 ;;=4^053.20
 ;;^UTILITY(U,$J,358.3,9779,2)
 ;;=Herpes Zoster of Eyelid^56937
 ;;^UTILITY(U,$J,358.3,9780,0)
 ;;=053.21^^77^664^20
 ;;^UTILITY(U,$J,358.3,9780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9780,1,3,0)
 ;;=3^Herp Zost Keratoconjunctivitis
 ;;^UTILITY(U,$J,358.3,9780,1,4,0)
 ;;=4^053.21
 ;;^UTILITY(U,$J,358.3,9780,2)
 ;;=Herp Zost Keratoconjunctivitis^266553
 ;;^UTILITY(U,$J,358.3,9781,0)
 ;;=053.22^^77^664^23
 ;;^UTILITY(U,$J,358.3,9781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9781,1,3,0)
 ;;=3^Herpes Zoster Iridocyclitis
 ;;^UTILITY(U,$J,358.3,9781,1,4,0)
 ;;=4^053.22
 ;;^UTILITY(U,$J,358.3,9781,2)
 ;;=Herpes Zoster Iridocyclitis^266554
 ;;^UTILITY(U,$J,358.3,9782,0)
 ;;=054.41^^77^664^22
 ;;^UTILITY(U,$J,358.3,9782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9782,1,3,0)
 ;;=3^Herpes Simplex of Eyelid
 ;;^UTILITY(U,$J,358.3,9782,1,4,0)
 ;;=4^054.41
 ;;^UTILITY(U,$J,358.3,9782,2)
 ;;=Herpes Simplex ofEyelid^266563
 ;;^UTILITY(U,$J,358.3,9783,0)
 ;;=054.42^^77^664^18
 ;;^UTILITY(U,$J,358.3,9783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9783,1,3,0)
 ;;=3^Dendritic Keratitis
 ;;^UTILITY(U,$J,358.3,9783,1,4,0)
 ;;=4^054.42
 ;;^UTILITY(U,$J,358.3,9783,2)
 ;;=Dendritic Keratitis^66763
 ;;^UTILITY(U,$J,358.3,9784,0)
 ;;=054.43^^77^664^19
 ;;^UTILITY(U,$J,358.3,9784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9784,1,3,0)
 ;;=3^Herp Simp Disciform Keratitis
 ;;^UTILITY(U,$J,358.3,9784,1,4,0)
 ;;=4^054.43
 ;;^UTILITY(U,$J,358.3,9784,2)
 ;;=Herp Simp Disciform Keratitis^266564
 ;;^UTILITY(U,$J,358.3,9785,0)
 ;;=054.44^^77^664^21
 ;;^UTILITY(U,$J,358.3,9785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9785,1,3,0)
 ;;=3^Herpes Simplex Iridocyclitis
 ;;^UTILITY(U,$J,358.3,9785,1,4,0)
 ;;=4^054.44
 ;;^UTILITY(U,$J,358.3,9785,2)
 ;;=Herpes Simplex Iridocyclitis^266565
 ;;^UTILITY(U,$J,358.3,9786,0)
 ;;=370.50^^77^664^10
 ;;^UTILITY(U,$J,358.3,9786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9786,1,3,0)
 ;;=3^Interstitial Keratitis
 ;;^UTILITY(U,$J,358.3,9786,1,4,0)
 ;;=4^370.50
 ;;^UTILITY(U,$J,358.3,9786,2)
 ;;=Interstitial Keratitis^268939
 ;;^UTILITY(U,$J,358.3,9787,0)
 ;;=370.01^^77^664^11
 ;;^UTILITY(U,$J,358.3,9787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9787,1,3,0)
 ;;=3^Marginal Corneal Ulcer
 ;;^UTILITY(U,$J,358.3,9787,1,4,0)
 ;;=4^370.01
 ;;^UTILITY(U,$J,358.3,9787,2)
 ;;=Marginal Corneal Ulcer^268908
 ;;^UTILITY(U,$J,358.3,9788,0)
 ;;=370.03^^77^664^4
 ;;^UTILITY(U,$J,358.3,9788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9788,1,3,0)
 ;;=3^Corneal Ulcer, Central
 ;;^UTILITY(U,$J,358.3,9788,1,4,0)
 ;;=4^370.03
 ;;^UTILITY(U,$J,358.3,9788,2)
 ;;=Corneal Ulcer, Central^268910
 ;;^UTILITY(U,$J,358.3,9789,0)
 ;;=370.05^^77^664^12
 ;;^UTILITY(U,$J,358.3,9789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9789,1,3,0)
 ;;=3^Mycotic Corneal Ulcer
 ;;^UTILITY(U,$J,358.3,9789,1,4,0)
 ;;=4^370.05
 ;;^UTILITY(U,$J,358.3,9789,2)
 ;;=Mycotic Corneal Ulcer^268914
 ;;^UTILITY(U,$J,358.3,9790,0)
 ;;=372.00^^77^664^1
 ;;^UTILITY(U,$J,358.3,9790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9790,1,3,0)
 ;;=3^Acute Conjunctivitis
 ;;^UTILITY(U,$J,358.3,9790,1,4,0)
 ;;=4^372.00
 ;;^UTILITY(U,$J,358.3,9790,2)
 ;;=Acute Conjunctivitis^269000
 ;;^UTILITY(U,$J,358.3,9791,0)
 ;;=375.30^^77^664^5
 ;;^UTILITY(U,$J,358.3,9791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9791,1,3,0)
 ;;=3^Dacrocystitis
 ;;^UTILITY(U,$J,358.3,9791,1,4,0)
 ;;=4^375.30
 ;;^UTILITY(U,$J,358.3,9791,2)
 ;;=Dacrocystitis^30880
 ;;^UTILITY(U,$J,358.3,9792,0)
 ;;=376.01^^77^664^13
 ;;^UTILITY(U,$J,358.3,9792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9792,1,3,0)
 ;;=3^Orbital Cellulitis
 ;;^UTILITY(U,$J,358.3,9792,1,4,0)
 ;;=4^376.01
 ;;^UTILITY(U,$J,358.3,9792,2)
 ;;=Orbital Cellulitis^259068
 ;;^UTILITY(U,$J,358.3,9793,0)
 ;;=682.0^^77^664^3
 ;;^UTILITY(U,$J,358.3,9793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9793,1,3,0)
 ;;=3^Cellulitis of Face
