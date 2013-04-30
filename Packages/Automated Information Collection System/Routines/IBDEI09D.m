IBDEI09D ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12428,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,12428,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,12429,0)
 ;;=459.10^^105^835^69
 ;;^UTILITY(U,$J,358.3,12429,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12429,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,12429,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,12429,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,12430,0)
 ;;=428.20^^105^835^47
 ;;^UTILITY(U,$J,358.3,12430,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12430,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,12430,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,12430,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,12431,0)
 ;;=428.21^^105^835^41
 ;;^UTILITY(U,$J,358.3,12431,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12431,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,12431,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,12431,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,12432,0)
 ;;=428.22^^105^835^43
 ;;^UTILITY(U,$J,358.3,12432,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12432,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,12432,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,12432,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,12433,0)
 ;;=428.23^^105^835^51
 ;;^UTILITY(U,$J,358.3,12433,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12433,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,12433,1,5,0)
 ;;=5^Heart Failure,Systolic,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,12433,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,12434,0)
 ;;=428.30^^105^835^44
 ;;^UTILITY(U,$J,358.3,12434,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12434,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,12434,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,12434,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,12435,0)
 ;;=428.31^^105^835^40
 ;;^UTILITY(U,$J,358.3,12435,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12435,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,12435,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,12435,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,12436,0)
 ;;=428.32^^105^835^42
 ;;^UTILITY(U,$J,358.3,12436,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12436,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,12436,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,12436,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,12437,0)
 ;;=428.33^^105^835^46
 ;;^UTILITY(U,$J,358.3,12437,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12437,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,12437,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,12437,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,12438,0)
 ;;=428.40^^105^835^45
 ;;^UTILITY(U,$J,358.3,12438,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12438,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,12438,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,12438,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,12439,0)
 ;;=428.41^^105^835^49
 ;;^UTILITY(U,$J,358.3,12439,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12439,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,12439,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastol,Acute
 ;;^UTILITY(U,$J,358.3,12439,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,12440,0)
 ;;=428.42^^105^835^50
 ;;^UTILITY(U,$J,358.3,12440,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12440,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,12440,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastol,Chr
 ;;^UTILITY(U,$J,358.3,12440,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,12441,0)
 ;;=428.43^^105^835^48
 ;;^UTILITY(U,$J,358.3,12441,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12441,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,12441,1,5,0)
 ;;=5^Heart Failure,Syst&Diastol Act on Chr
 ;;^UTILITY(U,$J,358.3,12441,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,12442,0)
 ;;=396.3^^105^835^10
 ;;^UTILITY(U,$J,358.3,12442,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12442,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,12442,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,12442,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,12443,0)
 ;;=429.9^^105^835^26
 ;;^UTILITY(U,$J,358.3,12443,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12443,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,12443,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,12443,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,12444,0)
 ;;=453.79^^105^835^25
 ;;^UTILITY(U,$J,358.3,12444,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12444,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,12444,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,12444,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,12445,0)
 ;;=453.89^^105^835^1
 ;;^UTILITY(U,$J,358.3,12445,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12445,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,12445,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,12445,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,12446,0)
 ;;=454.0^^105^835^78
 ;;^UTILITY(U,$J,358.3,12446,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12446,1,4,0)
 ;;=4^454.0
 ;;^UTILITY(U,$J,358.3,12446,1,5,0)
 ;;=5^Varicose Veins w/ Ulcer
 ;;^UTILITY(U,$J,358.3,12446,2)
 ;;=^125410
 ;;^UTILITY(U,$J,358.3,12447,0)
 ;;=454.2^^105^835^79
 ;;^UTILITY(U,$J,358.3,12447,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12447,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,12447,1,5,0)
 ;;=5^Varicose Veins w/Ulcer&Inflam
 ;;^UTILITY(U,$J,358.3,12447,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,12448,0)
 ;;=403.10^^105^835^32
 ;;^UTILITY(U,$J,358.3,12448,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12448,1,4,0)
 ;;=4^403.10
 ;;^UTILITY(U,$J,358.3,12448,1,5,0)
 ;;=5^HTN w/ Renal Failure I-IV/Unspec
 ;;^UTILITY(U,$J,358.3,12448,2)
 ;;=^334271
 ;;^UTILITY(U,$J,358.3,12449,0)
 ;;=271.3^^105^836^10
 ;;^UTILITY(U,$J,358.3,12449,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12449,1,4,0)
 ;;=4^271.3
 ;;^UTILITY(U,$J,358.3,12449,1,5,0)
 ;;=5^Glucose Intolerance
 ;;^UTILITY(U,$J,358.3,12449,2)
 ;;=^64790
 ;;^UTILITY(U,$J,358.3,12450,0)
 ;;=611.1^^105^836^15
 ;;^UTILITY(U,$J,358.3,12450,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12450,1,4,0)
 ;;=4^611.1
 ;;^UTILITY(U,$J,358.3,12450,1,5,0)
 ;;=5^Gynecomastia
 ;;^UTILITY(U,$J,358.3,12450,2)
 ;;=^60454
 ;;^UTILITY(U,$J,358.3,12451,0)
 ;;=704.1^^105^836^16
 ;;^UTILITY(U,$J,358.3,12451,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12451,1,4,0)
 ;;=4^704.1
 ;;^UTILITY(U,$J,358.3,12451,1,5,0)
 ;;=5^Hirsutism
 ;;^UTILITY(U,$J,358.3,12451,2)
 ;;=^57407
 ;;^UTILITY(U,$J,358.3,12452,0)
 ;;=251.2^^105^836^27
 ;;^UTILITY(U,$J,358.3,12452,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12452,1,4,0)
 ;;=4^251.2
 ;;^UTILITY(U,$J,358.3,12452,1,5,0)
 ;;=5^Hypoglycemia Nos
 ;;^UTILITY(U,$J,358.3,12452,2)
 ;;=^60580
 ;;^UTILITY(U,$J,358.3,12453,0)
 ;;=257.2^^105^836^28
 ;;^UTILITY(U,$J,358.3,12453,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12453,1,4,0)
 ;;=4^257.2
 ;;^UTILITY(U,$J,358.3,12453,1,5,0)
 ;;=5^Hypogonadism,Male
 ;;^UTILITY(U,$J,358.3,12453,2)
 ;;=^88213
 ;;^UTILITY(U,$J,358.3,12454,0)
 ;;=253.2^^105^836^31
 ;;^UTILITY(U,$J,358.3,12454,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12454,1,4,0)
 ;;=4^253.2
 ;;^UTILITY(U,$J,358.3,12454,1,5,0)
 ;;=5^Hypopituitarism
 ;;^UTILITY(U,$J,358.3,12454,2)
 ;;=^60686
 ;;^UTILITY(U,$J,358.3,12455,0)
 ;;=733.00^^105^836^40
 ;;^UTILITY(U,$J,358.3,12455,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12455,1,4,0)
 ;;=4^733.00
 ;;^UTILITY(U,$J,358.3,12455,1,5,0)
 ;;=5^Osteoporosis Nos
 ;;^UTILITY(U,$J,358.3,12455,2)
 ;;=^87159
 ;;^UTILITY(U,$J,358.3,12456,0)
 ;;=278.00^^105^836^37
 ;;^UTILITY(U,$J,358.3,12456,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12456,1,4,0)
 ;;=4^278.00
 ;;^UTILITY(U,$J,358.3,12456,1,5,0)
 ;;=5^Obesity (2nd dx only)
 ;;^UTILITY(U,$J,358.3,12456,2)
 ;;=^84823
 ;;^UTILITY(U,$J,358.3,12457,0)
 ;;=278.01^^105^836^36
 ;;^UTILITY(U,$J,358.3,12457,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12457,1,4,0)
 ;;=4^278.01
 ;;^UTILITY(U,$J,358.3,12457,1,5,0)
 ;;=5^Morbid Obesity
 ;;^UTILITY(U,$J,358.3,12457,2)
 ;;=^84844
 ;;^UTILITY(U,$J,358.3,12458,0)
 ;;=250.80^^105^836^9
 ;;^UTILITY(U,$J,358.3,12458,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12458,1,4,0)
 ;;=4^250.80
 ;;^UTILITY(U,$J,358.3,12458,1,5,0)
 ;;=5^DM Type II with LE Ulcer
 ;;^UTILITY(U,$J,358.3,12458,2)
 ;;=DM Type II with LE Ulcer^267846^707.10
 ;;^UTILITY(U,$J,358.3,12459,0)
 ;;=250.00^^105^836^4
 ;;^UTILITY(U,$J,358.3,12459,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12459,1,4,0)
 ;;=4^250.00
 ;;^UTILITY(U,$J,358.3,12459,1,5,0)
 ;;=5^DM Type II Dm W/O Complications
 ;;^UTILITY(U,$J,358.3,12459,2)
 ;;=^33605
 ;;^UTILITY(U,$J,358.3,12460,0)
 ;;=250.40^^105^836^5
 ;;^UTILITY(U,$J,358.3,12460,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12460,1,4,0)
 ;;=4^250.40
 ;;^UTILITY(U,$J,358.3,12460,1,5,0)
 ;;=5^DM Type II Dm with Nephropathy
 ;;^UTILITY(U,$J,358.3,12460,2)
 ;;=^267837^583.81
 ;;^UTILITY(U,$J,358.3,12461,0)
 ;;=250.50^^105^836^8
 ;;^UTILITY(U,$J,358.3,12461,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12461,1,4,0)
 ;;=4^250.50
 ;;^UTILITY(U,$J,358.3,12461,1,5,0)
 ;;=5^DM Type II w/ Ophthal Manifest
 ;;^UTILITY(U,$J,358.3,12461,2)
 ;;=DM Type II w/ Ophthal Manifest^267839^362.02
 ;;^UTILITY(U,$J,358.3,12462,0)
 ;;=250.60^^105^836^6
 ;;^UTILITY(U,$J,358.3,12462,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12462,1,4,0)
 ;;=4^250.60
 ;;^UTILITY(U,$J,358.3,12462,1,5,0)
 ;;=5^DM Type II Dm with Neuropathy
 ;;^UTILITY(U,$J,358.3,12462,2)
 ;;=^267841^357.2
 ;;^UTILITY(U,$J,358.3,12463,0)
 ;;=250.70^^105^836^7
