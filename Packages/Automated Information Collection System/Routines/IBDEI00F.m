IBDEI00F ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,373,1,4,0)
 ;;=4^G21.8
 ;;^UTILITY(U,$J,358.3,373,2)
 ;;=^5003777
 ;;^UTILITY(U,$J,358.3,374,0)
 ;;=G25.0^^7^47^6
 ;;^UTILITY(U,$J,358.3,374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,374,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,374,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,374,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,375,0)
 ;;=G25.1^^7^47^5
 ;;^UTILITY(U,$J,358.3,375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,375,1,3,0)
 ;;=3^Drug-Induced Tremor
 ;;^UTILITY(U,$J,358.3,375,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,375,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,376,0)
 ;;=G25.2^^7^47^14
 ;;^UTILITY(U,$J,358.3,376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,376,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,376,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,376,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,377,0)
 ;;=G25.3^^7^47^8
 ;;^UTILITY(U,$J,358.3,377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,377,1,3,0)
 ;;=3^Myoclonus
 ;;^UTILITY(U,$J,358.3,377,1,4,0)
 ;;=4^G25.3
 ;;^UTILITY(U,$J,358.3,377,2)
 ;;=^80620
 ;;^UTILITY(U,$J,358.3,378,0)
 ;;=G25.69^^7^47^13
 ;;^UTILITY(U,$J,358.3,378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,378,1,3,0)
 ;;=3^Tics,Organic Origin,Other
 ;;^UTILITY(U,$J,358.3,378,1,4,0)
 ;;=4^G25.69
 ;;^UTILITY(U,$J,358.3,378,2)
 ;;=^5003797
 ;;^UTILITY(U,$J,358.3,379,0)
 ;;=G25.61^^7^47^4
 ;;^UTILITY(U,$J,358.3,379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,379,1,3,0)
 ;;=3^Drug-Induced Tics
 ;;^UTILITY(U,$J,358.3,379,1,4,0)
 ;;=4^G25.61
 ;;^UTILITY(U,$J,358.3,379,2)
 ;;=^5003796
 ;;^UTILITY(U,$J,358.3,380,0)
 ;;=G25.9^^7^47^7
 ;;^UTILITY(U,$J,358.3,380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,380,1,3,0)
 ;;=3^Extrapyramidal & Movement Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,380,1,4,0)
 ;;=4^G25.9
 ;;^UTILITY(U,$J,358.3,380,2)
 ;;=^5003803
 ;;^UTILITY(U,$J,358.3,381,0)
 ;;=G25.82^^7^47^12
 ;;^UTILITY(U,$J,358.3,381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,381,1,3,0)
 ;;=3^Stiff-Man Syndrome
 ;;^UTILITY(U,$J,358.3,381,1,4,0)
 ;;=4^G25.82
 ;;^UTILITY(U,$J,358.3,381,2)
 ;;=^185540
 ;;^UTILITY(U,$J,358.3,382,0)
 ;;=G25.81^^7^47^10
 ;;^UTILITY(U,$J,358.3,382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,382,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,382,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,382,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,383,0)
 ;;=R27.0^^7^47^1
 ;;^UTILITY(U,$J,358.3,383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,383,1,3,0)
 ;;=3^Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,383,1,4,0)
 ;;=4^R27.0
 ;;^UTILITY(U,$J,358.3,383,2)
 ;;=^5019310
 ;;^UTILITY(U,$J,358.3,384,0)
 ;;=G31.83^^7^47^3
 ;;^UTILITY(U,$J,358.3,384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,384,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,384,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,384,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,385,0)
 ;;=G31.84^^7^47^2
 ;;^UTILITY(U,$J,358.3,385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,385,1,3,0)
 ;;=3^Cognitive Impairment,Mild,So Stated
 ;;^UTILITY(U,$J,358.3,385,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,385,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,386,0)
 ;;=C71.9^^7^48^3
 ;;^UTILITY(U,$J,358.3,386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,386,1,3,0)
 ;;=3^Malig Neop Brain,Unspec
 ;;^UTILITY(U,$J,358.3,386,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,386,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,387,0)
 ;;=C72.0^^7^48^5
 ;;^UTILITY(U,$J,358.3,387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,387,1,3,0)
 ;;=3^Malig Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,387,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,387,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,388,0)
 ;;=C72.1^^7^48^4
 ;;^UTILITY(U,$J,358.3,388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,388,1,3,0)
 ;;=3^Malig Neop Cauda Equina
 ;;^UTILITY(U,$J,358.3,388,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,388,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,389,0)
 ;;=C79.31^^7^48^6
 ;;^UTILITY(U,$J,358.3,389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,389,1,3,0)
 ;;=3^Secondary Malig Neop Brain
 ;;^UTILITY(U,$J,358.3,389,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,389,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,390,0)
 ;;=D32.0^^7^48^1
 ;;^UTILITY(U,$J,358.3,390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,390,1,3,0)
 ;;=3^Benign Neop Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,390,1,4,0)
 ;;=4^D32.0
 ;;^UTILITY(U,$J,358.3,390,2)
 ;;=^267681
 ;;^UTILITY(U,$J,358.3,391,0)
 ;;=D33.4^^7^48^2
 ;;^UTILITY(U,$J,358.3,391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,391,1,3,0)
 ;;=3^Benign Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,391,1,4,0)
 ;;=4^D33.4
 ;;^UTILITY(U,$J,358.3,391,2)
 ;;=^267682
 ;;^UTILITY(U,$J,358.3,392,0)
 ;;=F03.90^^7^49^8
 ;;^UTILITY(U,$J,358.3,392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,392,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,392,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,392,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,393,0)
 ;;=G30.9^^7^49^4
 ;;^UTILITY(U,$J,358.3,393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,393,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,393,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,393,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,394,0)
 ;;=R41.3^^7^49^5
 ;;^UTILITY(U,$J,358.3,394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,394,1,3,0)
 ;;=3^Amnesia,Other
 ;;^UTILITY(U,$J,358.3,394,1,4,0)
 ;;=4^R41.3
 ;;^UTILITY(U,$J,358.3,394,2)
 ;;=^5019439
 ;;^UTILITY(U,$J,358.3,395,0)
 ;;=G30.0^^7^49^1
 ;;^UTILITY(U,$J,358.3,395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,395,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,395,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,395,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,396,0)
 ;;=G30.1^^7^49^2
 ;;^UTILITY(U,$J,358.3,396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,396,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,396,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,396,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,397,0)
 ;;=G30.8^^7^49^3
 ;;^UTILITY(U,$J,358.3,397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,397,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,397,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,397,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,398,0)
 ;;=F02.80^^7^49^6
 ;;^UTILITY(U,$J,358.3,398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,398,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,398,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,398,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,399,0)
 ;;=F02.81^^7^49^7
 ;;^UTILITY(U,$J,358.3,399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,399,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,399,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,399,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,400,0)
 ;;=G47.61^^7^50^3
 ;;^UTILITY(U,$J,358.3,400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,400,1,3,0)
 ;;=3^Periodic Limb Movement Disorder
 ;;^UTILITY(U,$J,358.3,400,1,4,0)
 ;;=4^G47.61
 ;;^UTILITY(U,$J,358.3,400,2)
 ;;=^5003987
 ;;^UTILITY(U,$J,358.3,401,0)
 ;;=G25.81^^7^50^4
 ;;^UTILITY(U,$J,358.3,401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,401,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,401,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,401,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,402,0)
 ;;=G47.419^^7^50^2
 ;;^UTILITY(U,$J,358.3,402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,402,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy
 ;;^UTILITY(U,$J,358.3,402,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,402,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,403,0)
 ;;=G47.9^^7^50^6
 ;;^UTILITY(U,$J,358.3,403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,403,1,3,0)
 ;;=3^Sleep Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,403,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,403,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,404,0)
 ;;=G47.10^^7^50^1
 ;;^UTILITY(U,$J,358.3,404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,404,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,404,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,404,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,405,0)
 ;;=G47.30^^7^50^5
 ;;^UTILITY(U,$J,358.3,405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,405,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,405,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,405,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,406,0)
 ;;=G47.8^^7^50^7
 ;;^UTILITY(U,$J,358.3,406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,406,1,3,0)
 ;;=3^Sleep Disorders,Other
 ;;^UTILITY(U,$J,358.3,406,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,406,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,407,0)
 ;;=Z13.850^^7^51^2
 ;;^UTILITY(U,$J,358.3,407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,407,1,3,0)
 ;;=3^Traumatic Brain Injury Screening
 ;;^UTILITY(U,$J,358.3,407,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,407,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,408,0)
 ;;=Z13.858^^7^51^1
 ;;^UTILITY(U,$J,358.3,408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,408,1,3,0)
 ;;=3^Nervous System Disorder Screening
 ;;^UTILITY(U,$J,358.3,408,1,4,0)
 ;;=4^Z13.858
 ;;^UTILITY(U,$J,358.3,408,2)
 ;;=^5062718
 ;;^UTILITY(U,$J,358.3,409,0)
 ;;=E53.8^^7^52^5
 ;;^UTILITY(U,$J,358.3,409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,409,1,3,0)
 ;;=3^Deficiency of Vitamin B Group,Other Spec
 ;;^UTILITY(U,$J,358.3,409,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,409,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,410,0)
 ;;=F44.4^^7^52^3
 ;;^UTILITY(U,$J,358.3,410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,410,1,3,0)
 ;;=3^Conversion Disorder w/ Motor Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,410,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,410,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,411,0)
 ;;=F44.6^^7^52^4
 ;;^UTILITY(U,$J,358.3,411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,411,1,3,0)
 ;;=3^Conversion Disorder w/ Sensory Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,411,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,411,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,412,0)
 ;;=F10.20^^7^52^1
 ;;^UTILITY(U,$J,358.3,412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,412,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,412,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,412,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,413,0)
 ;;=F51.8^^7^52^12
 ;;^UTILITY(U,$J,358.3,413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,413,1,3,0)
 ;;=3^Sleep Disorder Not d/t Substance/Physiological Condition
 ;;^UTILITY(U,$J,358.3,413,1,4,0)
 ;;=4^F51.8
 ;;^UTILITY(U,$J,358.3,413,2)
 ;;=^5003616
 ;;^UTILITY(U,$J,358.3,414,0)
 ;;=F32.9^^7^52^8
 ;;^UTILITY(U,$J,358.3,414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,414,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,414,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,414,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,415,0)
 ;;=G91.1^^7^52^9
 ;;^UTILITY(U,$J,358.3,415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,415,1,3,0)
 ;;=3^Obstructive Hydrocephalus
 ;;^UTILITY(U,$J,358.3,415,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,415,2)
 ;;=^84947
 ;;^UTILITY(U,$J,358.3,416,0)
 ;;=I95.1^^7^52^10
 ;;^UTILITY(U,$J,358.3,416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,416,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,416,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,416,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,417,0)
 ;;=I95.89^^7^52^7
 ;;^UTILITY(U,$J,358.3,417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,417,1,3,0)
 ;;=3^Hypotension,Other
 ;;^UTILITY(U,$J,358.3,417,1,4,0)
 ;;=4^I95.89
 ;;^UTILITY(U,$J,358.3,417,2)
 ;;=^5008079
 ;;^UTILITY(U,$J,358.3,418,0)
 ;;=R55.^^7^52^13
 ;;^UTILITY(U,$J,358.3,418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,418,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,418,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,418,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,419,0)
 ;;=G47.10^^7^52^6
 ;;^UTILITY(U,$J,358.3,419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,419,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,419,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,419,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,420,0)
 ;;=G47.30^^7^52^11
 ;;^UTILITY(U,$J,358.3,420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,420,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,420,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,420,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,421,0)
 ;;=R20.0^^7^52^2
 ;;^UTILITY(U,$J,358.3,421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,421,1,3,0)
 ;;=3^Anesthesia of Skin
 ;;^UTILITY(U,$J,358.3,421,1,4,0)
 ;;=4^R20.0
 ;;^UTILITY(U,$J,358.3,421,2)
 ;;=^5019278
 ;;^UTILITY(U,$J,358.3,422,0)
 ;;=99441^^8^53^1^^^^1
 ;;^UTILITY(U,$J,358.3,422,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,422,1,1,0)
 ;;=1^99441
 ;;^UTILITY(U,$J,358.3,422,1,2,0)
 ;;=2^PHONE E/M BY PHYS 5-10 MIN
 ;;^UTILITY(U,$J,358.3,423,0)
 ;;=99443^^8^53^3^^^^1
 ;;^UTILITY(U,$J,358.3,423,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,423,1,1,0)
 ;;=1^99443
 ;;^UTILITY(U,$J,358.3,423,1,2,0)
 ;;=2^PHONE E/M BY PHYS 21-30 MIN
 ;;^UTILITY(U,$J,358.3,424,0)
 ;;=99442^^8^53^2^^^^1
 ;;^UTILITY(U,$J,358.3,424,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,424,1,1,0)
 ;;=1^99442
 ;;^UTILITY(U,$J,358.3,424,1,2,0)
 ;;=2^PHONE E/M BY PHYS 11-20 MIN
 ;;^UTILITY(U,$J,358.3,425,0)
 ;;=98966^^8^54^1^^^^1
 ;;^UTILITY(U,$J,358.3,425,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,425,1,1,0)
 ;;=1^98966
 ;;^UTILITY(U,$J,358.3,425,1,2,0)
 ;;=2^HC PRO PHONE CALL 5-10 MIN
 ;;^UTILITY(U,$J,358.3,426,0)
 ;;=98967^^8^54^2^^^^1
 ;;^UTILITY(U,$J,358.3,426,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,426,1,1,0)
 ;;=1^98967
 ;;^UTILITY(U,$J,358.3,426,1,2,0)
 ;;=2^HC PRO PHONE CALL 11-20 MIN
 ;;^UTILITY(U,$J,358.3,427,0)
 ;;=98968^^8^54^3^^^^1
 ;;^UTILITY(U,$J,358.3,427,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,427,1,1,0)
 ;;=1^98968
 ;;^UTILITY(U,$J,358.3,427,1,2,0)
 ;;=2^HC PRO PHONE CALL 21-30 MIN
 ;;^UTILITY(U,$J,358.3,428,0)
 ;;=99446^^8^55^1^^^^1
 ;;^UTILITY(U,$J,358.3,428,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,428,1,1,0)
 ;;=1^99446
 ;;^UTILITY(U,$J,358.3,428,1,2,0)
 ;;=2^INTERPROF PHONE/ONLINE 5-10 MIN
 ;;^UTILITY(U,$J,358.3,429,0)
 ;;=99447^^8^55^2^^^^1
 ;;^UTILITY(U,$J,358.3,429,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,429,1,1,0)
 ;;=1^99447
 ;;^UTILITY(U,$J,358.3,429,1,2,0)
 ;;=2^INTERPROF PHONE/ONLINE 11-20 MIN
 ;;^UTILITY(U,$J,358.3,430,0)
 ;;=99448^^8^55^3^^^^1
 ;;^UTILITY(U,$J,358.3,430,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,430,1,1,0)
 ;;=1^99448
 ;;^UTILITY(U,$J,358.3,430,1,2,0)
 ;;=2^INTERPROF PHONE/ONLINE 21-30 MIN
 ;;^UTILITY(U,$J,358.3,431,0)
 ;;=99449^^8^55^4^^^^1
 ;;^UTILITY(U,$J,358.3,431,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,431,1,1,0)
 ;;=1^99449
 ;;^UTILITY(U,$J,358.3,431,1,2,0)
 ;;=2^INTERPROF PHONE/ONLINE > 30 MIN
 ;;^UTILITY(U,$J,358.3,432,0)
 ;;=G40.A01^^9^56^3
 ;;^UTILITY(U,$J,358.3,432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,432,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,432,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,432,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,433,0)
 ;;=G40.A09^^9^56^4
 ;;^UTILITY(U,$J,358.3,433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,433,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,433,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,433,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,434,0)
 ;;=G40.A11^^9^56^1
 ;;^UTILITY(U,$J,358.3,434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,434,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,434,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,434,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,435,0)
 ;;=G40.A19^^9^56^2
 ;;^UTILITY(U,$J,358.3,435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,435,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,435,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,435,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,436,0)
 ;;=G40.309^^9^56^16
 ;;^UTILITY(U,$J,358.3,436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,436,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,436,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,436,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,437,0)
 ;;=G40.311^^9^56^14
 ;;^UTILITY(U,$J,358.3,437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,437,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,437,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,437,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,438,0)
 ;;=G40.319^^9^56^15
 ;;^UTILITY(U,$J,358.3,438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,438,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,438,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,438,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,439,0)
 ;;=G40.409^^9^56^19
 ;;^UTILITY(U,$J,358.3,439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,439,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,439,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,439,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,440,0)
 ;;=G40.411^^9^56^17
 ;;^UTILITY(U,$J,358.3,440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,440,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,440,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,440,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,441,0)
 ;;=G40.419^^9^56^18
 ;;^UTILITY(U,$J,358.3,441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,441,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,441,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,441,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,442,0)
 ;;=G40.209^^9^56^7
 ;;^UTILITY(U,$J,358.3,442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,442,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,442,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,442,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,443,0)
 ;;=G40.211^^9^56^5
 ;;^UTILITY(U,$J,358.3,443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,443,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,443,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,443,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,444,0)
 ;;=G40.219^^9^56^6
 ;;^UTILITY(U,$J,358.3,444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,444,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,444,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,444,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,445,0)
 ;;=G40.109^^9^56^27
 ;;^UTILITY(U,$J,358.3,445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,445,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,445,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,445,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,446,0)
 ;;=G40.111^^9^56^25
 ;;^UTILITY(U,$J,358.3,446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,446,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
