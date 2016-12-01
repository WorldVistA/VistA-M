IBDEI03P ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4396,0)
 ;;=C67.9^^20^282^24
 ;;^UTILITY(U,$J,358.3,4396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4396,1,3,0)
 ;;=3^Malig Neop of Bladder,Unspec
 ;;^UTILITY(U,$J,358.3,4396,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,4396,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,4397,0)
 ;;=C64.1^^20^282^27
 ;;^UTILITY(U,$J,358.3,4397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4397,1,3,0)
 ;;=3^Malig Neop of Right Kidney
 ;;^UTILITY(U,$J,358.3,4397,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,4397,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,4398,0)
 ;;=C64.2^^20^282^25
 ;;^UTILITY(U,$J,358.3,4398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4398,1,3,0)
 ;;=3^Malig Neop of Left Kidney
 ;;^UTILITY(U,$J,358.3,4398,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,4398,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,4399,0)
 ;;=D17.6^^20^282^2
 ;;^UTILITY(U,$J,358.3,4399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4399,1,3,0)
 ;;=3^Benign Lipomatous Neop of Spermatic Cord
 ;;^UTILITY(U,$J,358.3,4399,1,4,0)
 ;;=4^D17.6
 ;;^UTILITY(U,$J,358.3,4399,2)
 ;;=^5002016
 ;;^UTILITY(U,$J,358.3,4400,0)
 ;;=N20.0^^20^282^4
 ;;^UTILITY(U,$J,358.3,4400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4400,1,3,0)
 ;;=3^Calculus of Kidney
 ;;^UTILITY(U,$J,358.3,4400,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,4400,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,4401,0)
 ;;=N20.2^^20^282^5
 ;;^UTILITY(U,$J,358.3,4401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4401,1,3,0)
 ;;=3^Calculus of Kidney w/ Calculus of Ureter
 ;;^UTILITY(U,$J,358.3,4401,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,4401,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,4402,0)
 ;;=N32.0^^20^282^3
 ;;^UTILITY(U,$J,358.3,4402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4402,1,3,0)
 ;;=3^Bladder-Neck Obstruction
 ;;^UTILITY(U,$J,358.3,4402,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,4402,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,4403,0)
 ;;=N31.1^^20^282^33
 ;;^UTILITY(U,$J,358.3,4403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4403,1,3,0)
 ;;=3^Reflex Neuropathic Bladder NEC
 ;;^UTILITY(U,$J,358.3,4403,1,4,0)
 ;;=4^N31.1
 ;;^UTILITY(U,$J,358.3,4403,2)
 ;;=^5015645
 ;;^UTILITY(U,$J,358.3,4404,0)
 ;;=N31.9^^20^282^29
 ;;^UTILITY(U,$J,358.3,4404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4404,1,3,0)
 ;;=3^Neuromuscular Dysfunction of Bladder,Unspec
 ;;^UTILITY(U,$J,358.3,4404,1,4,0)
 ;;=4^N31.9
 ;;^UTILITY(U,$J,358.3,4404,2)
 ;;=^5015648
 ;;^UTILITY(U,$J,358.3,4405,0)
 ;;=N31.0^^20^282^36
 ;;^UTILITY(U,$J,358.3,4405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4405,1,3,0)
 ;;=3^Uninhibited Neuropathic Bladder NEC
 ;;^UTILITY(U,$J,358.3,4405,1,4,0)
 ;;=4^N31.0
 ;;^UTILITY(U,$J,358.3,4405,2)
 ;;=^5015644
 ;;^UTILITY(U,$J,358.3,4406,0)
 ;;=N35.9^^20^282^37
 ;;^UTILITY(U,$J,358.3,4406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4406,1,3,0)
 ;;=3^Urethral Stricture,Unspec
 ;;^UTILITY(U,$J,358.3,4406,1,4,0)
 ;;=4^N35.9
 ;;^UTILITY(U,$J,358.3,4406,2)
 ;;=^5015671
 ;;^UTILITY(U,$J,358.3,4407,0)
 ;;=N39.0^^20^282^35
 ;;^UTILITY(U,$J,358.3,4407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4407,1,3,0)
 ;;=3^UTI,Unspec Site
 ;;^UTILITY(U,$J,358.3,4407,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,4407,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,4408,0)
 ;;=R31.9^^20^282^21
 ;;^UTILITY(U,$J,358.3,4408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4408,1,3,0)
 ;;=3^Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,4408,1,4,0)
 ;;=4^R31.9
 ;;^UTILITY(U,$J,358.3,4408,2)
 ;;=^5019328
 ;;^UTILITY(U,$J,358.3,4409,0)
 ;;=R31.0^^20^282^20
 ;;^UTILITY(U,$J,358.3,4409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4409,1,3,0)
 ;;=3^Gross Hematuria
 ;;^UTILITY(U,$J,358.3,4409,1,4,0)
 ;;=4^R31.0
 ;;^UTILITY(U,$J,358.3,4409,2)
 ;;=^5019325
 ;;^UTILITY(U,$J,358.3,4410,0)
 ;;=R31.1^^20^282^1
 ;;^UTILITY(U,$J,358.3,4410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4410,1,3,0)
 ;;=3^Benign Essential Microscopic Hematuria
 ;;^UTILITY(U,$J,358.3,4410,1,4,0)
 ;;=4^R31.1
 ;;^UTILITY(U,$J,358.3,4410,2)
 ;;=^5019326
 ;;^UTILITY(U,$J,358.3,4411,0)
 ;;=R31.2^^20^282^28
 ;;^UTILITY(U,$J,358.3,4411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4411,1,3,0)
 ;;=3^Microscopic Hematuria NEC
 ;;^UTILITY(U,$J,358.3,4411,1,4,0)
 ;;=4^R31.2
 ;;^UTILITY(U,$J,358.3,4411,2)
 ;;=^5019327
 ;;^UTILITY(U,$J,358.3,4412,0)
 ;;=N40.0^^20^282^6
 ;;^UTILITY(U,$J,358.3,4412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4412,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,4412,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,4412,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,4413,0)
 ;;=N42.89^^20^282^32
 ;;^UTILITY(U,$J,358.3,4413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4413,1,3,0)
 ;;=3^Prostate Disorders NEC
 ;;^UTILITY(U,$J,358.3,4413,1,4,0)
 ;;=4^N42.89
 ;;^UTILITY(U,$J,358.3,4413,2)
 ;;=^270425
 ;;^UTILITY(U,$J,358.3,4414,0)
 ;;=N41.9^^20^282^23
 ;;^UTILITY(U,$J,358.3,4414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4414,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
 ;;^UTILITY(U,$J,358.3,4414,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,4414,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,4415,0)
 ;;=N43.3^^20^282^22
 ;;^UTILITY(U,$J,358.3,4415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4415,1,3,0)
 ;;=3^Hydrocele,Unspec
 ;;^UTILITY(U,$J,358.3,4415,1,4,0)
 ;;=4^N43.3
 ;;^UTILITY(U,$J,358.3,4415,2)
 ;;=^5015700
 ;;^UTILITY(U,$J,358.3,4416,0)
 ;;=N47.1^^20^282^31
 ;;^UTILITY(U,$J,358.3,4416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4416,1,3,0)
 ;;=3^Phimosis
 ;;^UTILITY(U,$J,358.3,4416,1,4,0)
 ;;=4^N47.1
 ;;^UTILITY(U,$J,358.3,4416,2)
 ;;=^93340
 ;;^UTILITY(U,$J,358.3,4417,0)
 ;;=N47.2^^20^282^30
 ;;^UTILITY(U,$J,358.3,4417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4417,1,3,0)
 ;;=3^Paraphimosis
 ;;^UTILITY(U,$J,358.3,4417,1,4,0)
 ;;=4^N47.2
 ;;^UTILITY(U,$J,358.3,4417,2)
 ;;=^90023
 ;;^UTILITY(U,$J,358.3,4418,0)
 ;;=N52.9^^20^282^16
 ;;^UTILITY(U,$J,358.3,4418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4418,1,3,0)
 ;;=3^Erectile Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,4418,1,4,0)
 ;;=4^N52.9
 ;;^UTILITY(U,$J,358.3,4418,2)
 ;;=^5015763
 ;;^UTILITY(U,$J,358.3,4419,0)
 ;;=N52.8^^20^282^11
 ;;^UTILITY(U,$J,358.3,4419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4419,1,3,0)
 ;;=3^Erectile Dysfunction NEC
 ;;^UTILITY(U,$J,358.3,4419,1,4,0)
 ;;=4^N52.8
 ;;^UTILITY(U,$J,358.3,4419,2)
 ;;=^5015762
 ;;^UTILITY(U,$J,358.3,4420,0)
 ;;=N52.39^^20^282^15
 ;;^UTILITY(U,$J,358.3,4420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4420,1,3,0)
 ;;=3^Erectile Dysfunction,Post-Surgical NEC
 ;;^UTILITY(U,$J,358.3,4420,1,4,0)
 ;;=4^N52.39
 ;;^UTILITY(U,$J,358.3,4420,2)
 ;;=^5015761
 ;;^UTILITY(U,$J,358.3,4421,0)
 ;;=N52.34^^20^282^9
 ;;^UTILITY(U,$J,358.3,4421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4421,1,3,0)
 ;;=3^Erectile Dysfunction Following Simple Prostatectomy
 ;;^UTILITY(U,$J,358.3,4421,1,4,0)
 ;;=4^N52.34
 ;;^UTILITY(U,$J,358.3,4421,2)
 ;;=^5015760
 ;;^UTILITY(U,$J,358.3,4422,0)
 ;;=N52.33^^20^282^10
 ;;^UTILITY(U,$J,358.3,4422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4422,1,3,0)
 ;;=3^Erectile Dysfunction Following Urethral Surgery
 ;;^UTILITY(U,$J,358.3,4422,1,4,0)
 ;;=4^N52.33
 ;;^UTILITY(U,$J,358.3,4422,2)
 ;;=^5015759
 ;;^UTILITY(U,$J,358.3,4423,0)
 ;;=N52.32^^20^282^7
 ;;^UTILITY(U,$J,358.3,4423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4423,1,3,0)
 ;;=3^Erectile Dysfunction Following Radical Cystectomy
 ;;^UTILITY(U,$J,358.3,4423,1,4,0)
 ;;=4^N52.32
 ;;^UTILITY(U,$J,358.3,4423,2)
 ;;=^5015758
 ;;^UTILITY(U,$J,358.3,4424,0)
 ;;=N52.31^^20^282^8
 ;;^UTILITY(U,$J,358.3,4424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4424,1,3,0)
 ;;=3^Erectile Dysfunction Following Radical Prostatectomy
 ;;^UTILITY(U,$J,358.3,4424,1,4,0)
 ;;=4^N52.31
 ;;^UTILITY(U,$J,358.3,4424,2)
 ;;=^5015757
 ;;^UTILITY(U,$J,358.3,4425,0)
 ;;=N52.2^^20^282^14
 ;;^UTILITY(U,$J,358.3,4425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4425,1,3,0)
 ;;=3^Erectile Dysfunction,Drug-Induced
 ;;^UTILITY(U,$J,358.3,4425,1,4,0)
 ;;=4^N52.2
 ;;^UTILITY(U,$J,358.3,4425,2)
 ;;=^5015756
 ;;^UTILITY(U,$J,358.3,4426,0)
 ;;=N52.02^^20^282^13
 ;;^UTILITY(U,$J,358.3,4426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4426,1,3,0)
 ;;=3^Erectile Dysfunction,Corporo-Venous Occlusive
 ;;^UTILITY(U,$J,358.3,4426,1,4,0)
 ;;=4^N52.02
 ;;^UTILITY(U,$J,358.3,4426,2)
 ;;=^5015753
 ;;^UTILITY(U,$J,358.3,4427,0)
 ;;=N52.03^^20^282^12
 ;;^UTILITY(U,$J,358.3,4427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4427,1,3,0)
 ;;=3^Erectile Dysfunction,Artrl Insuff/Corporo-Venous Occlusive
 ;;^UTILITY(U,$J,358.3,4427,1,4,0)
 ;;=4^N52.03
 ;;^UTILITY(U,$J,358.3,4427,2)
 ;;=^5015754
 ;;^UTILITY(U,$J,358.3,4428,0)
 ;;=N52.1^^20^282^18
 ;;^UTILITY(U,$J,358.3,4428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4428,1,3,0)
 ;;=3^Eriectile Dysfunction d/t Oth Diseases
 ;;^UTILITY(U,$J,358.3,4428,1,4,0)
 ;;=4^N52.1
 ;;^UTILITY(U,$J,358.3,4428,2)
 ;;=^5015755
 ;;^UTILITY(U,$J,358.3,4429,0)
 ;;=N52.01^^20^282^17
 ;;^UTILITY(U,$J,358.3,4429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4429,1,3,0)
 ;;=3^Eriectile Dysfunction d/t Arterial Insufficiency
 ;;^UTILITY(U,$J,358.3,4429,1,4,0)
 ;;=4^N52.01
 ;;^UTILITY(U,$J,358.3,4429,2)
 ;;=^5015752
 ;;^UTILITY(U,$J,358.3,4430,0)
 ;;=R33.9^^20^282^34
 ;;^UTILITY(U,$J,358.3,4430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4430,1,3,0)
 ;;=3^Retention of Urine,Unspec
 ;;^UTILITY(U,$J,358.3,4430,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,4430,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,4431,0)
 ;;=R32.^^20^282^38
 ;;^UTILITY(U,$J,358.3,4431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4431,1,3,0)
 ;;=3^Urinary Incontinence,Unspec
 ;;^UTILITY(U,$J,358.3,4431,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,4431,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,4432,0)
 ;;=R35.0^^20^282^19
 ;;^UTILITY(U,$J,358.3,4432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4432,1,3,0)
 ;;=3^Frequency of Micturition
