IBDEI03G ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4318,1,4,0)
 ;;=4^364.77
 ;;^UTILITY(U,$J,358.3,4318,2)
 ;;=Angle Recession w/o Glauc^268743
 ;;^UTILITY(U,$J,358.3,4319,0)
 ;;=368.40^^39^301^35
 ;;^UTILITY(U,$J,358.3,4319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4319,1,3,0)
 ;;=3^Visual Field Defect
 ;;^UTILITY(U,$J,358.3,4319,1,4,0)
 ;;=4^368.40
 ;;^UTILITY(U,$J,358.3,4319,2)
 ;;=Visual Field Defect^126859
 ;;^UTILITY(U,$J,358.3,4320,0)
 ;;=363.70^^39^301^3
 ;;^UTILITY(U,$J,358.3,4320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4320,1,3,0)
 ;;=3^Choroidal Detachment NOS
 ;;^UTILITY(U,$J,358.3,4320,1,4,0)
 ;;=4^363.70
 ;;^UTILITY(U,$J,358.3,4320,2)
 ;;=^276841
 ;;^UTILITY(U,$J,358.3,4321,0)
 ;;=365.24^^39^301^26
 ;;^UTILITY(U,$J,358.3,4321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4321,1,3,0)
 ;;=3^Residual Angle-Closure Glaucoma
 ;;^UTILITY(U,$J,358.3,4321,1,4,0)
 ;;=4^365.24
 ;;^UTILITY(U,$J,358.3,4321,2)
 ;;=^268758
 ;;^UTILITY(U,$J,358.3,4322,0)
 ;;=365.65^^39^301^33
 ;;^UTILITY(U,$J,358.3,4322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4322,1,3,0)
 ;;=3^Traumatic Glaucoma
 ;;^UTILITY(U,$J,358.3,4322,1,4,0)
 ;;=4^365.65
 ;;^UTILITY(U,$J,358.3,4322,2)
 ;;=^268780
 ;;^UTILITY(U,$J,358.3,4323,0)
 ;;=365.89^^39^301^34
 ;;^UTILITY(U,$J,358.3,4323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4323,1,3,0)
 ;;=3^Uveitic Glaucoma
 ;;^UTILITY(U,$J,358.3,4323,1,4,0)
 ;;=4^365.89
 ;;^UTILITY(U,$J,358.3,4323,2)
 ;;=^88069
 ;;^UTILITY(U,$J,358.3,4324,0)
 ;;=365.05^^39^301^18
 ;;^UTILITY(U,$J,358.3,4324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4324,1,3,0)
 ;;=3^Opn Ang w/ brdrlne fnd-Hi Risk
 ;;^UTILITY(U,$J,358.3,4324,1,4,0)
 ;;=4^365.05
 ;;^UTILITY(U,$J,358.3,4324,2)
 ;;=^340511
 ;;^UTILITY(U,$J,358.3,4325,0)
 ;;=365.06^^39^301^22
 ;;^UTILITY(U,$J,358.3,4325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4325,1,3,0)
 ;;=3^Prim Ang Clos w/o Glauc Dmg
 ;;^UTILITY(U,$J,358.3,4325,1,4,0)
 ;;=4^365.06
 ;;^UTILITY(U,$J,358.3,4325,2)
 ;;=^340512
 ;;^UTILITY(U,$J,358.3,4326,0)
 ;;=365.70^^39^301^7
 ;;^UTILITY(U,$J,358.3,4326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4326,1,3,0)
 ;;=3^Glaucoma Stage NOS
 ;;^UTILITY(U,$J,358.3,4326,1,4,0)
 ;;=4^365.70
 ;;^UTILITY(U,$J,358.3,4326,2)
 ;;=^340609
 ;;^UTILITY(U,$J,358.3,4327,0)
 ;;=365.71^^39^301^11
 ;;^UTILITY(U,$J,358.3,4327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4327,1,3,0)
 ;;=3^Mild Stage Glaucoma
 ;;^UTILITY(U,$J,358.3,4327,1,4,0)
 ;;=4^365.71
 ;;^UTILITY(U,$J,358.3,4327,2)
 ;;=^340513
 ;;^UTILITY(U,$J,358.3,4328,0)
 ;;=365.72^^39^301^12
 ;;^UTILITY(U,$J,358.3,4328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4328,1,3,0)
 ;;=3^Moderate Stage Glaucoma
 ;;^UTILITY(U,$J,358.3,4328,1,4,0)
 ;;=4^365.72
 ;;^UTILITY(U,$J,358.3,4328,2)
 ;;=^340514
 ;;^UTILITY(U,$J,358.3,4329,0)
 ;;=365.73^^39^301^30
 ;;^UTILITY(U,$J,358.3,4329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4329,1,3,0)
 ;;=3^Severe Stage Glaucoma
 ;;^UTILITY(U,$J,358.3,4329,1,4,0)
 ;;=4^365.73
 ;;^UTILITY(U,$J,358.3,4329,2)
 ;;=^340515
 ;;^UTILITY(U,$J,358.3,4330,0)
 ;;=365.74^^39^301^9
 ;;^UTILITY(U,$J,358.3,4330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4330,1,3,0)
 ;;=3^Indeterm Stage Glaucoma
 ;;^UTILITY(U,$J,358.3,4330,1,4,0)
 ;;=4^365.74
 ;;^UTILITY(U,$J,358.3,4330,2)
 ;;=^340516
 ;;^UTILITY(U,$J,358.3,4331,0)
 ;;=V19.11^^39^301^5
 ;;^UTILITY(U,$J,358.3,4331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4331,1,3,0)
 ;;=3^Family Hx Glaucoma
 ;;^UTILITY(U,$J,358.3,4331,1,4,0)
 ;;=4^V19.11
 ;;^UTILITY(U,$J,358.3,4331,2)
 ;;=^340617
 ;;^UTILITY(U,$J,358.3,4332,0)
 ;;=V19.19^^39^301^6
 ;;^UTILITY(U,$J,358.3,4332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4332,1,3,0)
 ;;=3^Family Hx Oth Spec Eye Disord
 ;;^UTILITY(U,$J,358.3,4332,1,4,0)
 ;;=4^V19.19
 ;;^UTILITY(U,$J,358.3,4332,2)
 ;;=^340618
 ;;^UTILITY(U,$J,358.3,4333,0)
 ;;=378.83^^39^302^2
 ;;^UTILITY(U,$J,358.3,4333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4333,1,3,0)
 ;;=3^Convergence Insufficiency
 ;;^UTILITY(U,$J,358.3,4333,1,4,0)
 ;;=4^378.83
 ;;^UTILITY(U,$J,358.3,4333,2)
 ;;=Convergence Insufficiency^269277
 ;;^UTILITY(U,$J,358.3,4334,0)
 ;;=378.00^^39^302^4
 ;;^UTILITY(U,$J,358.3,4334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4334,1,3,0)
 ;;=3^Esotropia
 ;;^UTILITY(U,$J,358.3,4334,1,4,0)
 ;;=4^378.00
 ;;^UTILITY(U,$J,358.3,4334,2)
 ;;=Esotropia^42597
 ;;^UTILITY(U,$J,358.3,4335,0)
 ;;=378.10^^39^302^6
 ;;^UTILITY(U,$J,358.3,4335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4335,1,3,0)
 ;;=3^Exotropia
 ;;^UTILITY(U,$J,358.3,4335,1,4,0)
 ;;=4^378.10
 ;;^UTILITY(U,$J,358.3,4335,2)
 ;;=Exotropia^43741
 ;;^UTILITY(U,$J,358.3,4336,0)
 ;;=378.41^^39^302^3
 ;;^UTILITY(U,$J,358.3,4336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4336,1,3,0)
 ;;=3^Esophoria
 ;;^UTILITY(U,$J,358.3,4336,1,4,0)
 ;;=4^378.41
 ;;^UTILITY(U,$J,358.3,4336,2)
 ;;=Esophoria^265435
 ;;^UTILITY(U,$J,358.3,4337,0)
 ;;=378.42^^39^302^5
 ;;^UTILITY(U,$J,358.3,4337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4337,1,3,0)
 ;;=3^Exophoria
 ;;^UTILITY(U,$J,358.3,4337,1,4,0)
 ;;=4^378.42
 ;;^UTILITY(U,$J,358.3,4337,2)
 ;;=Exophoria^265436
 ;;^UTILITY(U,$J,358.3,4338,0)
 ;;=378.50^^39^302^11
 ;;^UTILITY(U,$J,358.3,4338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4338,1,3,0)
 ;;=3^Strabismus, Paralytic
 ;;^UTILITY(U,$J,358.3,4338,1,4,0)
 ;;=4^378.50
 ;;^UTILITY(U,$J,358.3,4338,2)
 ;;=Strabismus, Paralytic^265442
 ;;^UTILITY(U,$J,358.3,4339,0)
 ;;=378.40^^39^302^7
 ;;^UTILITY(U,$J,358.3,4339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4339,1,3,0)
 ;;=3^Heterophoria
 ;;^UTILITY(U,$J,358.3,4339,1,4,0)
 ;;=4^378.40
 ;;^UTILITY(U,$J,358.3,4339,2)
 ;;=Heterophoria^265433
 ;;^UTILITY(U,$J,358.3,4340,0)
 ;;=378.30^^39^302^8
 ;;^UTILITY(U,$J,358.3,4340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4340,1,3,0)
 ;;=3^Heterotropia
 ;;^UTILITY(U,$J,358.3,4340,1,4,0)
 ;;=4^378.30
 ;;^UTILITY(U,$J,358.3,4340,2)
 ;;=Heterotropia^265406
 ;;^UTILITY(U,$J,358.3,4341,0)
 ;;=378.60^^39^302^10
 ;;^UTILITY(U,$J,358.3,4341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4341,1,3,0)
 ;;=3^Strabismus, Mechanical
 ;;^UTILITY(U,$J,358.3,4341,1,4,0)
 ;;=4^378.60
 ;;^UTILITY(U,$J,358.3,4341,2)
 ;;=Strabismus, Mechanical^265445
 ;;^UTILITY(U,$J,358.3,4342,0)
 ;;=378.9^^39^302^12
 ;;^UTILITY(U,$J,358.3,4342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4342,1,3,0)
 ;;=3^Strabismus, Unspecified
 ;;^UTILITY(U,$J,358.3,4342,1,4,0)
 ;;=4^378.9
 ;;^UTILITY(U,$J,358.3,4342,2)
 ;;=Ophthalmoplegia, Unspec^123833
 ;;^UTILITY(U,$J,358.3,4343,0)
 ;;=368.00^^39^302^1
 ;;^UTILITY(U,$J,358.3,4343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4343,1,3,0)
 ;;=3^Amblyopia
 ;;^UTILITY(U,$J,358.3,4343,1,4,0)
 ;;=4^368.00
 ;;^UTILITY(U,$J,358.3,4343,2)
 ;;=^5731
 ;;^UTILITY(U,$J,358.3,4344,0)
 ;;=378.73^^39^302^9
 ;;^UTILITY(U,$J,358.3,4344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4344,1,3,0)
 ;;=3^Ocular Myasthenia Gravis
 ;;^UTILITY(U,$J,358.3,4344,1,4,0)
 ;;=4^378.73
 ;;^UTILITY(U,$J,358.3,4344,2)
 ;;=Ocular Myasthenia Gravis^269274
 ;;^UTILITY(U,$J,358.3,4345,0)
 ;;=360.01^^39^303^6
 ;;^UTILITY(U,$J,358.3,4345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4345,1,3,0)
 ;;=3^Endophalmitis
 ;;^UTILITY(U,$J,358.3,4345,1,4,0)
 ;;=4^360.01
 ;;^UTILITY(U,$J,358.3,4345,2)
 ;;=Endophalmitis^268545
 ;;^UTILITY(U,$J,358.3,4346,0)
 ;;=V08.^^39^303^8
 ;;^UTILITY(U,$J,358.3,4346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4346,1,3,0)
 ;;=3^HIV Status
 ;;^UTILITY(U,$J,358.3,4346,1,4,0)
 ;;=4^V08.
 ;;^UTILITY(U,$J,358.3,4346,2)
 ;;=HIV Status^303392
 ;;^UTILITY(U,$J,358.3,4347,0)
 ;;=078.5^^39^303^2
 ;;^UTILITY(U,$J,358.3,4347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4347,1,3,0)
 ;;=3^CMV Retinitis
 ;;^UTILITY(U,$J,358.3,4347,1,4,0)
 ;;=4^078.5
 ;;^UTILITY(U,$J,358.3,4347,2)
 ;;=CMV Retinitis^30676^366.20
 ;;^UTILITY(U,$J,358.3,4348,0)
 ;;=115.92^^39^303^9
 ;;^UTILITY(U,$J,358.3,4348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4348,1,3,0)
 ;;=3^Histoplasmosis (POHS)
 ;;^UTILITY(U,$J,358.3,4348,1,4,0)
 ;;=4^115.92
 ;;^UTILITY(U,$J,358.3,4348,2)
 ;;=Histoplasmosis Retinitis^266905
 ;;^UTILITY(U,$J,358.3,4349,0)
 ;;=130.2^^39^303^16
 ;;^UTILITY(U,$J,358.3,4349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4349,1,3,0)
 ;;=3^Toxoplasmosis Retinitis
 ;;^UTILITY(U,$J,358.3,4349,1,4,0)
 ;;=4^130.2
 ;;^UTILITY(U,$J,358.3,4349,2)
 ;;=Toxoplasmosis Retinitis^266947
 ;;^UTILITY(U,$J,358.3,4350,0)
 ;;=128.0^^39^303^15
 ;;^UTILITY(U,$J,358.3,4350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4350,1,3,0)
 ;;=3^Toxocariasis
 ;;^UTILITY(U,$J,358.3,4350,1,4,0)
 ;;=4^128.0
 ;;^UTILITY(U,$J,358.3,4350,2)
 ;;=Toxocariasis^120683
 ;;^UTILITY(U,$J,358.3,4351,0)
 ;;=053.20^^39^303^24
 ;;^UTILITY(U,$J,358.3,4351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4351,1,3,0)
 ;;=3^Herpes Zoster of Eyelid
 ;;^UTILITY(U,$J,358.3,4351,1,4,0)
 ;;=4^053.20
 ;;^UTILITY(U,$J,358.3,4351,2)
 ;;=Herpes Zoster of Eyelid^56937
 ;;^UTILITY(U,$J,358.3,4352,0)
 ;;=053.21^^39^303^20
 ;;^UTILITY(U,$J,358.3,4352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4352,1,3,0)
 ;;=3^Herp Zost Keratoconjunctivitis
 ;;^UTILITY(U,$J,358.3,4352,1,4,0)
 ;;=4^053.21
 ;;^UTILITY(U,$J,358.3,4352,2)
 ;;=Herp Zost Keratoconjunctivitis^266553
 ;;^UTILITY(U,$J,358.3,4353,0)
 ;;=053.22^^39^303^23
 ;;^UTILITY(U,$J,358.3,4353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4353,1,3,0)
 ;;=3^Herpes Zoster Iridocyclitis
 ;;^UTILITY(U,$J,358.3,4353,1,4,0)
 ;;=4^053.22
 ;;^UTILITY(U,$J,358.3,4353,2)
 ;;=Herpes Zoster Iridocyclitis^266554
 ;;^UTILITY(U,$J,358.3,4354,0)
 ;;=054.41^^39^303^22
 ;;^UTILITY(U,$J,358.3,4354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4354,1,3,0)
 ;;=3^Herpes Simplex of Eyelid
 ;;^UTILITY(U,$J,358.3,4354,1,4,0)
 ;;=4^054.41
 ;;^UTILITY(U,$J,358.3,4354,2)
 ;;=Herpes Simplex ofEyelid^266563
 ;;^UTILITY(U,$J,358.3,4355,0)
 ;;=054.42^^39^303^18
 ;;^UTILITY(U,$J,358.3,4355,1,0)
 ;;=^358.31IA^4^2
