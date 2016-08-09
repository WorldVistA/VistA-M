IBDEI03Q ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3416,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,3416,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,3417,0)
 ;;=R07.82^^27^257^4
 ;;^UTILITY(U,$J,358.3,3417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3417,1,3,0)
 ;;=3^Intercostal Pain
 ;;^UTILITY(U,$J,358.3,3417,1,4,0)
 ;;=4^R07.82
 ;;^UTILITY(U,$J,358.3,3417,2)
 ;;=^5019199
 ;;^UTILITY(U,$J,358.3,3418,0)
 ;;=R07.89^^27^257^2
 ;;^UTILITY(U,$J,358.3,3418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3418,1,3,0)
 ;;=3^Chest Pain,Other
 ;;^UTILITY(U,$J,358.3,3418,1,4,0)
 ;;=4^R07.89
 ;;^UTILITY(U,$J,358.3,3418,2)
 ;;=^5019200
 ;;^UTILITY(U,$J,358.3,3419,0)
 ;;=C34.11^^27^257^10
 ;;^UTILITY(U,$J,358.3,3419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3419,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Upper Lobe
 ;;^UTILITY(U,$J,358.3,3419,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,3419,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,3420,0)
 ;;=C34.12^^27^257^7
 ;;^UTILITY(U,$J,358.3,3420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3420,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Upper Lobe
 ;;^UTILITY(U,$J,358.3,3420,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,3420,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,3421,0)
 ;;=C34.31^^27^257^9
 ;;^UTILITY(U,$J,358.3,3421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3421,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Lower Lobe
 ;;^UTILITY(U,$J,358.3,3421,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,3421,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,3422,0)
 ;;=C34.32^^27^257^6
 ;;^UTILITY(U,$J,358.3,3422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3422,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Lower Lobe
 ;;^UTILITY(U,$J,358.3,3422,1,4,0)
 ;;=4^C34.32
 ;;^UTILITY(U,$J,358.3,3422,2)
 ;;=^5133322
 ;;^UTILITY(U,$J,358.3,3423,0)
 ;;=M47.12^^27^258^6
 ;;^UTILITY(U,$J,358.3,3423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3423,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,3423,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,3423,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,3424,0)
 ;;=M48.06^^27^258^5
 ;;^UTILITY(U,$J,358.3,3424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3424,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,3424,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,3424,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,3425,0)
 ;;=M48.02^^27^258^4
 ;;^UTILITY(U,$J,358.3,3425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3425,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,3425,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,3425,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,3426,0)
 ;;=M17.0^^27^258^1
 ;;^UTILITY(U,$J,358.3,3426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3426,1,3,0)
 ;;=3^Osteoarthritis of Knee,Primary Bilateral
 ;;^UTILITY(U,$J,358.3,3426,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,3426,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,3427,0)
 ;;=M17.11^^27^258^3
 ;;^UTILITY(U,$J,358.3,3427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3427,1,3,0)
 ;;=3^Osteoarthritis of Knee,Primary Right
 ;;^UTILITY(U,$J,358.3,3427,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,3427,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,3428,0)
 ;;=M17.12^^27^258^2
 ;;^UTILITY(U,$J,358.3,3428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3428,1,3,0)
 ;;=3^Osteoarthritis of Knee,Primary Left
 ;;^UTILITY(U,$J,358.3,3428,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,3428,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,3429,0)
 ;;=E87.5^^27^259^11
 ;;^UTILITY(U,$J,358.3,3429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3429,1,3,0)
 ;;=3^Hyperkalemia
 ;;^UTILITY(U,$J,358.3,3429,1,4,0)
 ;;=4^E87.5
 ;;^UTILITY(U,$J,358.3,3429,2)
 ;;=^60041
 ;;^UTILITY(U,$J,358.3,3430,0)
 ;;=E87.1^^27^259^12
 ;;^UTILITY(U,$J,358.3,3430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3430,1,3,0)
 ;;=3^Hypo-osmolality and Hyponatremia
 ;;^UTILITY(U,$J,358.3,3430,1,4,0)
 ;;=4^E87.1
 ;;^UTILITY(U,$J,358.3,3430,2)
 ;;=^5003019
 ;;^UTILITY(U,$J,358.3,3431,0)
 ;;=R42.^^27^259^7
 ;;^UTILITY(U,$J,358.3,3431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3431,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,3431,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,3431,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,3432,0)
 ;;=R41.82^^27^259^3
 ;;^UTILITY(U,$J,358.3,3432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3432,1,3,0)
 ;;=3^Altered Mental Status,Unspec
 ;;^UTILITY(U,$J,358.3,3432,1,4,0)
 ;;=4^R41.82
 ;;^UTILITY(U,$J,358.3,3432,2)
 ;;=^5019441
 ;;^UTILITY(U,$J,358.3,3433,0)
 ;;=T78.3XXA^^27^259^4
 ;;^UTILITY(U,$J,358.3,3433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3433,1,3,0)
 ;;=3^Angioneurotic Edema,Init Encntr
 ;;^UTILITY(U,$J,358.3,3433,1,4,0)
 ;;=4^T78.3XXA
 ;;^UTILITY(U,$J,358.3,3433,2)
 ;;=^5054281
 ;;^UTILITY(U,$J,358.3,3434,0)
 ;;=E11.69^^27^259^6
 ;;^UTILITY(U,$J,358.3,3434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3434,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oth Spec Complications
 ;;^UTILITY(U,$J,358.3,3434,1,4,0)
 ;;=4^E11.69
 ;;^UTILITY(U,$J,358.3,3434,2)
 ;;=^5002664
 ;;^UTILITY(U,$J,358.3,3435,0)
 ;;=R55.^^27^259^15
 ;;^UTILITY(U,$J,358.3,3435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3435,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,3435,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,3435,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,3436,0)
 ;;=E87.70^^27^259^9
 ;;^UTILITY(U,$J,358.3,3436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3436,1,3,0)
 ;;=3^Fluid Overload,Unspec
 ;;^UTILITY(U,$J,358.3,3436,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,3436,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,3437,0)
 ;;=E87.79^^27^259^8
 ;;^UTILITY(U,$J,358.3,3437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3437,1,3,0)
 ;;=3^Fluid Overload,Other
 ;;^UTILITY(U,$J,358.3,3437,1,4,0)
 ;;=4^E87.79
 ;;^UTILITY(U,$J,358.3,3437,2)
 ;;=^5003025
 ;;^UTILITY(U,$J,358.3,3438,0)
 ;;=R73.09^^27^259^1
 ;;^UTILITY(U,$J,358.3,3438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3438,1,3,0)
 ;;=3^Abnormal Glucose
 ;;^UTILITY(U,$J,358.3,3438,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,3438,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,3439,0)
 ;;=D62.^^27^259^2
 ;;^UTILITY(U,$J,358.3,3439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3439,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,3439,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,3439,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,3440,0)
 ;;=F06.8^^27^259^13
 ;;^UTILITY(U,$J,358.3,3440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3440,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition NEC
 ;;^UTILITY(U,$J,358.3,3440,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,3440,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,3441,0)
 ;;=F05.^^27^259^5
 ;;^UTILITY(U,$J,358.3,3441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3441,1,3,0)
 ;;=3^Delirium d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,3441,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,3441,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,3442,0)
 ;;=R73.9^^27^259^10
 ;;^UTILITY(U,$J,358.3,3442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3442,1,3,0)
 ;;=3^Hyperglycemia,Unspec
 ;;^UTILITY(U,$J,358.3,3442,1,4,0)
 ;;=4^R73.9
 ;;^UTILITY(U,$J,358.3,3442,2)
 ;;=^5019564
 ;;^UTILITY(U,$J,358.3,3443,0)
 ;;=K56.0^^27^259^14
 ;;^UTILITY(U,$J,358.3,3443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3443,1,3,0)
 ;;=3^Paralytic Ileus
 ;;^UTILITY(U,$J,358.3,3443,1,4,0)
 ;;=4^K56.0
 ;;^UTILITY(U,$J,358.3,3443,2)
 ;;=^89879
 ;;^UTILITY(U,$J,358.3,3444,0)
 ;;=I97.710^^27^260^17
 ;;^UTILITY(U,$J,358.3,3444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3444,1,3,0)
 ;;=3^Intraoperative Cardiac Arrest During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,3444,1,4,0)
 ;;=4^I97.710
 ;;^UTILITY(U,$J,358.3,3444,2)
 ;;=^5008103
 ;;^UTILITY(U,$J,358.3,3445,0)
 ;;=I97.790^^27^260^18
 ;;^UTILITY(U,$J,358.3,3445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3445,1,3,0)
 ;;=3^Intraoperative Cardiac Function Disturbance During Cardiac Surgery
