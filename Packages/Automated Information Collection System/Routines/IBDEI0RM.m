IBDEI0RM ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36489,1,4,0)
 ;;=4^H60.01
 ;;^UTILITY(U,$J,358.3,36489,2)
 ;;=^5006436
 ;;^UTILITY(U,$J,358.3,36490,0)
 ;;=H60.13^^103^1551^5
 ;;^UTILITY(U,$J,358.3,36490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36490,1,3,0)
 ;;=3^Cellulitis Bilateral External Ear
 ;;^UTILITY(U,$J,358.3,36490,1,4,0)
 ;;=4^H60.13
 ;;^UTILITY(U,$J,358.3,36490,2)
 ;;=^5006442
 ;;^UTILITY(U,$J,358.3,36491,0)
 ;;=H60.12^^103^1551^6
 ;;^UTILITY(U,$J,358.3,36491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36491,1,3,0)
 ;;=3^Cellulitis Left External Ear
 ;;^UTILITY(U,$J,358.3,36491,1,4,0)
 ;;=4^H60.12
 ;;^UTILITY(U,$J,358.3,36491,2)
 ;;=^5006441
 ;;^UTILITY(U,$J,358.3,36492,0)
 ;;=H60.11^^103^1551^7
 ;;^UTILITY(U,$J,358.3,36492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36492,1,3,0)
 ;;=3^Cellulitis Right External Ear
 ;;^UTILITY(U,$J,358.3,36492,1,4,0)
 ;;=4^H60.11
 ;;^UTILITY(U,$J,358.3,36492,2)
 ;;=^5006440
 ;;^UTILITY(U,$J,358.3,36493,0)
 ;;=H60.323^^103^1551^8
 ;;^UTILITY(U,$J,358.3,36493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36493,1,3,0)
 ;;=3^Hemorrhagic Bilateral Otitis Externa
 ;;^UTILITY(U,$J,358.3,36493,1,4,0)
 ;;=4^H60.323
 ;;^UTILITY(U,$J,358.3,36493,2)
 ;;=^5006453
 ;;^UTILITY(U,$J,358.3,36494,0)
 ;;=H60.322^^103^1551^9
 ;;^UTILITY(U,$J,358.3,36494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36494,1,3,0)
 ;;=3^Hemorrhagic Left Otitis Externa
 ;;^UTILITY(U,$J,358.3,36494,1,4,0)
 ;;=4^H60.322
 ;;^UTILITY(U,$J,358.3,36494,2)
 ;;=^5006452
 ;;^UTILITY(U,$J,358.3,36495,0)
 ;;=H60.321^^103^1551^10
 ;;^UTILITY(U,$J,358.3,36495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36495,1,3,0)
 ;;=3^Hemorrhagic Right Otitis Externa
 ;;^UTILITY(U,$J,358.3,36495,1,4,0)
 ;;=4^H60.321
 ;;^UTILITY(U,$J,358.3,36495,2)
 ;;=^5006451
 ;;^UTILITY(U,$J,358.3,36496,0)
 ;;=H60.393^^103^1551^11
 ;;^UTILITY(U,$J,358.3,36496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36496,1,3,0)
 ;;=3^Infective Bilateral Otitis Externa NEC
 ;;^UTILITY(U,$J,358.3,36496,1,4,0)
 ;;=4^H60.393
 ;;^UTILITY(U,$J,358.3,36496,2)
 ;;=^5006461
 ;;^UTILITY(U,$J,358.3,36497,0)
 ;;=H60.392^^103^1551^12
 ;;^UTILITY(U,$J,358.3,36497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36497,1,3,0)
 ;;=3^Infective Left Otitis Externa
 ;;^UTILITY(U,$J,358.3,36497,1,4,0)
 ;;=4^H60.392
 ;;^UTILITY(U,$J,358.3,36497,2)
 ;;=^5006460
 ;;^UTILITY(U,$J,358.3,36498,0)
 ;;=H60.391^^103^1551^13
 ;;^UTILITY(U,$J,358.3,36498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36498,1,3,0)
 ;;=3^Infective Right Otitis Externa
 ;;^UTILITY(U,$J,358.3,36498,1,4,0)
 ;;=4^H60.391
 ;;^UTILITY(U,$J,358.3,36498,2)
 ;;=^5006459
 ;;^UTILITY(U,$J,358.3,36499,0)
 ;;=H66.93^^103^1551^17
 ;;^UTILITY(U,$J,358.3,36499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36499,1,3,0)
 ;;=3^Otitis Media Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,36499,1,4,0)
 ;;=4^H66.93
 ;;^UTILITY(U,$J,358.3,36499,2)
 ;;=^5006642
 ;;^UTILITY(U,$J,358.3,36500,0)
 ;;=H66.92^^103^1551^18
 ;;^UTILITY(U,$J,358.3,36500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36500,1,3,0)
 ;;=3^Otitis Media Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,36500,1,4,0)
 ;;=4^H66.92
 ;;^UTILITY(U,$J,358.3,36500,2)
 ;;=^5006641
 ;;^UTILITY(U,$J,358.3,36501,0)
 ;;=H66.91^^103^1551^19
 ;;^UTILITY(U,$J,358.3,36501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36501,1,3,0)
 ;;=3^Otitis Media Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,36501,1,4,0)
 ;;=4^H66.91
 ;;^UTILITY(U,$J,358.3,36501,2)
 ;;=^5006640
 ;;^UTILITY(U,$J,358.3,36502,0)
 ;;=H60.93^^103^1551^14
 ;;^UTILITY(U,$J,358.3,36502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36502,1,3,0)
 ;;=3^Otitis Externa Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,36502,1,4,0)
 ;;=4^H60.93
 ;;^UTILITY(U,$J,358.3,36502,2)
 ;;=^5006498
 ;;^UTILITY(U,$J,358.3,36503,0)
 ;;=H60.92^^103^1551^15
 ;;^UTILITY(U,$J,358.3,36503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36503,1,3,0)
 ;;=3^Otitis Externa Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,36503,1,4,0)
 ;;=4^H60.92
 ;;^UTILITY(U,$J,358.3,36503,2)
 ;;=^5133525
 ;;^UTILITY(U,$J,358.3,36504,0)
 ;;=H60.91^^103^1551^16
 ;;^UTILITY(U,$J,358.3,36504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36504,1,3,0)
 ;;=3^Otitis Externa Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,36504,1,4,0)
 ;;=4^H60.91
 ;;^UTILITY(U,$J,358.3,36504,2)
 ;;=^5133524
 ;;^UTILITY(U,$J,358.3,36505,0)
 ;;=J30.9^^103^1551^4
 ;;^UTILITY(U,$J,358.3,36505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36505,1,3,0)
 ;;=3^Allergic Rhinitis,Unspec
 ;;^UTILITY(U,$J,358.3,36505,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,36505,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,36506,0)
 ;;=J38.00^^103^1551^20
 ;;^UTILITY(U,$J,358.3,36506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36506,1,3,0)
 ;;=3^Paralysis of Vocal Cords/Larynx,Unspec
 ;;^UTILITY(U,$J,358.3,36506,1,4,0)
 ;;=4^J38.00
 ;;^UTILITY(U,$J,358.3,36506,2)
 ;;=^5008219
 ;;^UTILITY(U,$J,358.3,36507,0)
 ;;=K92.2^^103^1552^2
 ;;^UTILITY(U,$J,358.3,36507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36507,1,3,0)
 ;;=3^Gastrointestinal Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,36507,1,4,0)
 ;;=4^K92.2
 ;;^UTILITY(U,$J,358.3,36507,2)
 ;;=^5008915
 ;;^UTILITY(U,$J,358.3,36508,0)
 ;;=K27.9^^103^1552^3
 ;;^UTILITY(U,$J,358.3,36508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36508,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec Site
 ;;^UTILITY(U,$J,358.3,36508,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,36508,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,36509,0)
 ;;=K46.9^^103^1552^1
 ;;^UTILITY(U,$J,358.3,36509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36509,1,3,0)
 ;;=3^Abdominal Hernia w/o Obstruction/Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,36509,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,36509,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,36510,0)
 ;;=N14.0^^103^1553^1
 ;;^UTILITY(U,$J,358.3,36510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36510,1,3,0)
 ;;=3^Analgesic Nephropathy
 ;;^UTILITY(U,$J,358.3,36510,1,4,0)
 ;;=4^N14.0
 ;;^UTILITY(U,$J,358.3,36510,2)
 ;;=^5015590
 ;;^UTILITY(U,$J,358.3,36511,0)
 ;;=N15.0^^103^1553^2
 ;;^UTILITY(U,$J,358.3,36511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36511,1,3,0)
 ;;=3^Balkan Nephropathy
 ;;^UTILITY(U,$J,358.3,36511,1,4,0)
 ;;=4^N15.0
 ;;^UTILITY(U,$J,358.3,36511,2)
 ;;=^12543
 ;;^UTILITY(U,$J,358.3,36512,0)
 ;;=N18.9^^103^1553^3
 ;;^UTILITY(U,$J,358.3,36512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36512,1,3,0)
 ;;=3^Chr Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,36512,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,36512,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,36513,0)
 ;;=N28.9^^103^1553^17
 ;;^UTILITY(U,$J,358.3,36513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36513,1,3,0)
 ;;=3^Kidney/Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,36513,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,36513,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,36514,0)
 ;;=N40.0^^103^1553^4
 ;;^UTILITY(U,$J,358.3,36514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36514,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,36514,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,36514,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,36515,0)
 ;;=N07.6^^103^1553^5
 ;;^UTILITY(U,$J,358.3,36515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36515,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Dense Deposit Disease NEC
 ;;^UTILITY(U,$J,358.3,36515,1,4,0)
 ;;=4^N07.6
 ;;^UTILITY(U,$J,358.3,36515,2)
 ;;=^5015565
 ;;^UTILITY(U,$J,358.3,36516,0)
 ;;=N07.7^^103^1553^6
 ;;^UTILITY(U,$J,358.3,36516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36516,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Diffuse Crescentic Glomerular NEC
 ;;^UTILITY(U,$J,358.3,36516,1,4,0)
 ;;=4^N07.7
 ;;^UTILITY(U,$J,358.3,36516,2)
 ;;=^5015566
 ;;^UTILITY(U,$J,358.3,36517,0)
 ;;=N07.1^^103^1553^7
 ;;^UTILITY(U,$J,358.3,36517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36517,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Focal/Segmental Glomerular Lesions NEC
 ;;^UTILITY(U,$J,358.3,36517,1,4,0)
 ;;=4^N07.1
 ;;^UTILITY(U,$J,358.3,36517,2)
 ;;=^5015560
 ;;^UTILITY(U,$J,358.3,36518,0)
 ;;=N07.0^^103^1553^8
 ;;^UTILITY(U,$J,358.3,36518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36518,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Minor Glomerular Abnormality NEC
 ;;^UTILITY(U,$J,358.3,36518,1,4,0)
 ;;=4^N07.0
 ;;^UTILITY(U,$J,358.3,36518,2)
 ;;=^5015559
 ;;^UTILITY(U,$J,358.3,36519,0)
 ;;=N07.8^^103^1553^9
 ;;^UTILITY(U,$J,358.3,36519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36519,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Morphologic Lesions NEC
 ;;^UTILITY(U,$J,358.3,36519,1,4,0)
 ;;=4^N07.8
 ;;^UTILITY(U,$J,358.3,36519,2)
 ;;=^5015567
 ;;^UTILITY(U,$J,358.3,36520,0)
 ;;=N41.9^^103^1553^10
 ;;^UTILITY(U,$J,358.3,36520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36520,1,3,0)
 ;;=3^Inflammatory Prostate Disease,Unspec
 ;;^UTILITY(U,$J,358.3,36520,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,36520,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,36521,0)
 ;;=N06.6^^103^1553^11
 ;;^UTILITY(U,$J,358.3,36521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36521,1,3,0)
 ;;=3^Isolated Proteinuria w/ Dense Deposit Disease
 ;;^UTILITY(U,$J,358.3,36521,1,4,0)
 ;;=4^N06.6
 ;;^UTILITY(U,$J,358.3,36521,2)
 ;;=^5015555
 ;;^UTILITY(U,$J,358.3,36522,0)
 ;;=N06.7^^103^1553^12
 ;;^UTILITY(U,$J,358.3,36522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36522,1,3,0)
 ;;=3^Isolated Proteinuria w/ Diffuse Crescentic Glomerulonephritis
 ;;^UTILITY(U,$J,358.3,36522,1,4,0)
 ;;=4^N06.7
 ;;^UTILITY(U,$J,358.3,36522,2)
 ;;=^5015556
 ;;^UTILITY(U,$J,358.3,36523,0)
 ;;=N06.1^^103^1553^13
 ;;^UTILITY(U,$J,358.3,36523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36523,1,3,0)
 ;;=3^Isolated Proteinuria w/ Focal/Segmental Glomerular Lesions
 ;;^UTILITY(U,$J,358.3,36523,1,4,0)
 ;;=4^N06.1
 ;;^UTILITY(U,$J,358.3,36523,2)
 ;;=^5015550
 ;;^UTILITY(U,$J,358.3,36524,0)
 ;;=N06.0^^103^1553^14
 ;;^UTILITY(U,$J,358.3,36524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36524,1,3,0)
 ;;=3^Isolated Proteinuria w/ Minor Glomerular Abnormality
