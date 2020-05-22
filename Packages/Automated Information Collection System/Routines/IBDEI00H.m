IBDEI00H ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,518,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,519,0)
 ;;=F02.80^^9^63^6
 ;;^UTILITY(U,$J,358.3,519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,519,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,519,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,519,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,520,0)
 ;;=F02.81^^9^63^7
 ;;^UTILITY(U,$J,358.3,520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,520,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,520,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,520,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,521,0)
 ;;=G47.61^^9^64^3
 ;;^UTILITY(U,$J,358.3,521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,521,1,3,0)
 ;;=3^Periodic Limb Movement Disorder
 ;;^UTILITY(U,$J,358.3,521,1,4,0)
 ;;=4^G47.61
 ;;^UTILITY(U,$J,358.3,521,2)
 ;;=^5003987
 ;;^UTILITY(U,$J,358.3,522,0)
 ;;=G25.81^^9^64^4
 ;;^UTILITY(U,$J,358.3,522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,522,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,522,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,522,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,523,0)
 ;;=G47.419^^9^64^2
 ;;^UTILITY(U,$J,358.3,523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,523,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy
 ;;^UTILITY(U,$J,358.3,523,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,523,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,524,0)
 ;;=G47.9^^9^64^6
 ;;^UTILITY(U,$J,358.3,524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,524,1,3,0)
 ;;=3^Sleep Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,524,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,524,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,525,0)
 ;;=G47.10^^9^64^1
 ;;^UTILITY(U,$J,358.3,525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,525,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,525,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,525,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,526,0)
 ;;=G47.30^^9^64^5
 ;;^UTILITY(U,$J,358.3,526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,526,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,526,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,526,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,527,0)
 ;;=G47.8^^9^64^7
 ;;^UTILITY(U,$J,358.3,527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,527,1,3,0)
 ;;=3^Sleep Disorders,Other
 ;;^UTILITY(U,$J,358.3,527,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,527,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,528,0)
 ;;=Z13.850^^9^65^2
 ;;^UTILITY(U,$J,358.3,528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,528,1,3,0)
 ;;=3^Traumatic Brain Injury Screening
 ;;^UTILITY(U,$J,358.3,528,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,528,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,529,0)
 ;;=Z13.858^^9^65^1
 ;;^UTILITY(U,$J,358.3,529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,529,1,3,0)
 ;;=3^Nervous System Disorder Screening
 ;;^UTILITY(U,$J,358.3,529,1,4,0)
 ;;=4^Z13.858
 ;;^UTILITY(U,$J,358.3,529,2)
 ;;=^5062718
 ;;^UTILITY(U,$J,358.3,530,0)
 ;;=E53.8^^9^66^5
 ;;^UTILITY(U,$J,358.3,530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,530,1,3,0)
 ;;=3^Deficiency of Vitamin B Group,Other Spec
 ;;^UTILITY(U,$J,358.3,530,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,530,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,531,0)
 ;;=F44.4^^9^66^3
 ;;^UTILITY(U,$J,358.3,531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,531,1,3,0)
 ;;=3^Conversion Disorder w/ Motor Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,531,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,531,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,532,0)
 ;;=F44.6^^9^66^4
 ;;^UTILITY(U,$J,358.3,532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,532,1,3,0)
 ;;=3^Conversion Disorder w/ Sensory Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,532,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,532,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,533,0)
 ;;=F10.20^^9^66^1
 ;;^UTILITY(U,$J,358.3,533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,533,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,533,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,533,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,534,0)
 ;;=F51.8^^9^66^12
 ;;^UTILITY(U,$J,358.3,534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,534,1,3,0)
 ;;=3^Sleep Disorder Not d/t Substance/Physiological Condition
 ;;^UTILITY(U,$J,358.3,534,1,4,0)
 ;;=4^F51.8
 ;;^UTILITY(U,$J,358.3,534,2)
 ;;=^5003616
 ;;^UTILITY(U,$J,358.3,535,0)
 ;;=F32.9^^9^66^8
 ;;^UTILITY(U,$J,358.3,535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,535,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,535,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,535,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,536,0)
 ;;=G91.1^^9^66^9
 ;;^UTILITY(U,$J,358.3,536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,536,1,3,0)
 ;;=3^Obstructive Hydrocephalus
 ;;^UTILITY(U,$J,358.3,536,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,536,2)
 ;;=^84947
 ;;^UTILITY(U,$J,358.3,537,0)
 ;;=I95.1^^9^66^10
 ;;^UTILITY(U,$J,358.3,537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,537,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,537,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,537,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,538,0)
 ;;=I95.89^^9^66^7
 ;;^UTILITY(U,$J,358.3,538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,538,1,3,0)
 ;;=3^Hypotension,Other
 ;;^UTILITY(U,$J,358.3,538,1,4,0)
 ;;=4^I95.89
 ;;^UTILITY(U,$J,358.3,538,2)
 ;;=^5008079
 ;;^UTILITY(U,$J,358.3,539,0)
 ;;=R55.^^9^66^13
 ;;^UTILITY(U,$J,358.3,539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,539,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,539,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,539,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,540,0)
 ;;=G47.10^^9^66^6
 ;;^UTILITY(U,$J,358.3,540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,540,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,540,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,540,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,541,0)
 ;;=G47.30^^9^66^11
 ;;^UTILITY(U,$J,358.3,541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,541,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,541,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,541,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,542,0)
 ;;=R20.0^^9^66^2
 ;;^UTILITY(U,$J,358.3,542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,542,1,3,0)
 ;;=3^Anesthesia of Skin
 ;;^UTILITY(U,$J,358.3,542,1,4,0)
 ;;=4^R20.0
 ;;^UTILITY(U,$J,358.3,542,2)
 ;;=^5019278
 ;;^UTILITY(U,$J,358.3,543,0)
 ;;=A4220^^10^67^1^^^^1
 ;;^UTILITY(U,$J,358.3,543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,543,1,1,0)
 ;;=1^A4220
 ;;^UTILITY(U,$J,358.3,543,1,3,0)
 ;;=3^Infusion Pump Refill Kit
 ;;^UTILITY(U,$J,358.3,544,0)
 ;;=99195^^10^68^1^^^^1
 ;;^UTILITY(U,$J,358.3,544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,544,1,1,0)
 ;;=1^99195
 ;;^UTILITY(U,$J,358.3,544,1,3,0)
 ;;=3^Phlebotomy
 ;;^UTILITY(U,$J,358.3,545,0)
 ;;=20220^^10^69^2^^^^1
 ;;^UTILITY(U,$J,358.3,545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,545,1,1,0)
 ;;=1^20220
 ;;^UTILITY(U,$J,358.3,545,1,3,0)
 ;;=3^Bone Biopsy, Trocar/Needle
 ;;^UTILITY(U,$J,358.3,546,0)
 ;;=62270^^10^69^9^^^^1
 ;;^UTILITY(U,$J,358.3,546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,546,1,1,0)
 ;;=1^62270
 ;;^UTILITY(U,$J,358.3,546,1,3,0)
 ;;=3^Lumbar Puncture
 ;;^UTILITY(U,$J,358.3,547,0)
 ;;=45300^^10^69^11^^^^1
 ;;^UTILITY(U,$J,358.3,547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,547,1,1,0)
 ;;=1^45300
 ;;^UTILITY(U,$J,358.3,547,1,3,0)
 ;;=3^Proctosigmoidoscopy
 ;;^UTILITY(U,$J,358.3,548,0)
 ;;=31575^^10^69^8^^^^1
 ;;^UTILITY(U,$J,358.3,548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,548,1,1,0)
 ;;=1^31575
 ;;^UTILITY(U,$J,358.3,548,1,3,0)
 ;;=3^Laryngoscopy,flex fibroptic,diag
 ;;^UTILITY(U,$J,358.3,549,0)
 ;;=38220^^10^69^3^^^^1
 ;;^UTILITY(U,$J,358.3,549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,549,1,1,0)
 ;;=1^38220
 ;;^UTILITY(U,$J,358.3,549,1,3,0)
 ;;=3^Bone Marrow Aspiration
 ;;^UTILITY(U,$J,358.3,550,0)
 ;;=38221^^10^69^4^^^^1
 ;;^UTILITY(U,$J,358.3,550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,550,1,1,0)
 ;;=1^38221
 ;;^UTILITY(U,$J,358.3,550,1,3,0)
 ;;=3^Bone Marrow Biopsy, Needle/Trocar
 ;;^UTILITY(U,$J,358.3,551,0)
 ;;=36589^^10^69^5^^^^1
 ;;^UTILITY(U,$J,358.3,551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,551,1,1,0)
 ;;=1^36589
 ;;^UTILITY(U,$J,358.3,551,1,3,0)
 ;;=3^Hickman Cath Removal
 ;;^UTILITY(U,$J,358.3,552,0)
 ;;=49082^^10^69^10^^^^1
 ;;^UTILITY(U,$J,358.3,552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,552,1,1,0)
 ;;=1^49082
 ;;^UTILITY(U,$J,358.3,552,1,3,0)
 ;;=3^Paracentesis (Abdominal)
 ;;^UTILITY(U,$J,358.3,553,0)
 ;;=32554^^10^69^12^^^^1
 ;;^UTILITY(U,$J,358.3,553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,553,1,1,0)
 ;;=1^32554
 ;;^UTILITY(U,$J,358.3,553,1,3,0)
 ;;=3^Thoracentesis
 ;;^UTILITY(U,$J,358.3,554,0)
 ;;=31505^^10^69^6^^^^1
 ;;^UTILITY(U,$J,358.3,554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,554,1,1,0)
 ;;=1^31505
 ;;^UTILITY(U,$J,358.3,554,1,3,0)
 ;;=3^Indirect Laryngoscopy
 ;;^UTILITY(U,$J,358.3,555,0)
 ;;=31510^^10^69^7^^^^1
 ;;^UTILITY(U,$J,358.3,555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,555,1,1,0)
 ;;=1^31510
 ;;^UTILITY(U,$J,358.3,555,1,3,0)
 ;;=3^Indirect Laryngoscopy w/Biopsy
 ;;^UTILITY(U,$J,358.3,556,0)
 ;;=36430^^10^69^1^^^^1
 ;;^UTILITY(U,$J,358.3,556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,556,1,1,0)
 ;;=1^36430
 ;;^UTILITY(U,$J,358.3,556,1,3,0)
 ;;=3^Blood Transfusion
 ;;^UTILITY(U,$J,358.3,557,0)
 ;;=90732^^10^70^2^^^^1
 ;;^UTILITY(U,$J,358.3,557,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,557,1,1,0)
 ;;=1^90732
 ;;^UTILITY(U,$J,358.3,557,1,3,0)
 ;;=3^Pneumococcal Vaccine
 ;;^UTILITY(U,$J,358.3,558,0)
 ;;=90658^^10^70^1^^^^1
 ;;^UTILITY(U,$J,358.3,558,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,558,1,1,0)
 ;;=1^90658
 ;;^UTILITY(U,$J,358.3,558,1,3,0)
 ;;=3^Flu Vaccine IM (Flulaval)
 ;;^UTILITY(U,$J,358.3,559,0)
 ;;=99195^^10^71^21^^^^1
 ;;^UTILITY(U,$J,358.3,559,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,559,1,1,0)
 ;;=1^99195
 ;;^UTILITY(U,$J,358.3,559,1,3,0)
 ;;=3^Phlebotomy
 ;;^UTILITY(U,$J,358.3,560,0)
 ;;=96450^^10^71^17^^^^1
 ;;^UTILITY(U,$J,358.3,560,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,560,1,1,0)
 ;;=1^96450
 ;;^UTILITY(U,$J,358.3,560,1,3,0)
 ;;=3^Chemotherapy, Into CNS
 ;;^UTILITY(U,$J,358.3,561,0)
 ;;=96420^^10^71^9^^^^1
 ;;^UTILITY(U,$J,358.3,561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,561,1,1,0)
 ;;=1^96420
 ;;^UTILITY(U,$J,358.3,561,1,3,0)
 ;;=3^Chemo, IA push
 ;;^UTILITY(U,$J,358.3,562,0)
 ;;=96422^^10^71^8^^^^1
 ;;^UTILITY(U,$J,358.3,562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,562,1,1,0)
 ;;=1^96422
 ;;^UTILITY(U,$J,358.3,562,1,3,0)
 ;;=3^Chemo, IA infusion,Init hr
 ;;^UTILITY(U,$J,358.3,563,0)
 ;;=96405^^10^71^2^^^^1
 ;;^UTILITY(U,$J,358.3,563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,563,1,1,0)
 ;;=1^96405
 ;;^UTILITY(U,$J,358.3,563,1,3,0)
 ;;=3^Chemo Admin Intralesional
 ;;^UTILITY(U,$J,358.3,564,0)
 ;;=96440^^10^71^3^^^^1
 ;;^UTILITY(U,$J,358.3,564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,564,1,1,0)
 ;;=1^96440
 ;;^UTILITY(U,$J,358.3,564,1,3,0)
 ;;=3^Chemo Admin, Pleural Cavity
 ;;^UTILITY(U,$J,358.3,565,0)
 ;;=96542^^10^71^7^^^^1
 ;;^UTILITY(U,$J,358.3,565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,565,1,1,0)
 ;;=1^96542
 ;;^UTILITY(U,$J,358.3,565,1,3,0)
 ;;=3^Chemo Inj Via Reservoir
 ;;^UTILITY(U,$J,358.3,566,0)
 ;;=51720^^10^71^1^^^^1
 ;;^UTILITY(U,$J,358.3,566,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,566,1,1,0)
 ;;=1^51720
 ;;^UTILITY(U,$J,358.3,566,1,3,0)
 ;;=3^Bladder Instill,anticarcinogenic
 ;;^UTILITY(U,$J,358.3,567,0)
 ;;=96402^^10^71^18^^^^1
 ;;^UTILITY(U,$J,358.3,567,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,567,1,1,0)
 ;;=1^96402
 ;;^UTILITY(U,$J,358.3,567,1,3,0)
 ;;=3^Chemotherapy,IM/SQ inj,Hormone
 ;;^UTILITY(U,$J,358.3,568,0)
 ;;=96401^^10^71^12^^^^1
 ;;^UTILITY(U,$J,358.3,568,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,568,1,1,0)
 ;;=1^96401
 ;;^UTILITY(U,$J,358.3,568,1,3,0)
 ;;=3^Chemo,IM/SQ inj,non-hormonal
 ;;^UTILITY(U,$J,358.3,569,0)
 ;;=96409^^10^71^15^^^^1
 ;;^UTILITY(U,$J,358.3,569,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,569,1,1,0)
 ;;=1^96409
 ;;^UTILITY(U,$J,358.3,569,1,3,0)
 ;;=3^Chemo,IV push,Init
 ;;^UTILITY(U,$J,358.3,570,0)
 ;;=96411^^10^71^14^^^^1
 ;;^UTILITY(U,$J,358.3,570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,570,1,1,0)
 ;;=1^96411
 ;;^UTILITY(U,$J,358.3,570,1,3,0)
 ;;=3^Chemo,IV push, addl drug
 ;;^UTILITY(U,$J,358.3,571,0)
 ;;=96413^^10^71^13^^^^1
 ;;^UTILITY(U,$J,358.3,571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,571,1,1,0)
 ;;=1^96413
 ;;^UTILITY(U,$J,358.3,571,1,3,0)
 ;;=3^Chemo,IV Infusn,Init Hr
 ;;^UTILITY(U,$J,358.3,572,0)
 ;;=96417^^10^71^16^^^^1
 ;;^UTILITY(U,$J,358.3,572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,572,1,1,0)
 ;;=1^96417
 ;;^UTILITY(U,$J,358.3,572,1,3,0)
 ;;=3^Chemo,Infusn,ea add seql drug
 ;;^UTILITY(U,$J,358.3,573,0)
 ;;=96415^^10^71^10^^^^1
 ;;^UTILITY(U,$J,358.3,573,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,573,1,1,0)
 ;;=1^96415
 ;;^UTILITY(U,$J,358.3,573,1,3,0)
 ;;=3^Chemo, IV Infusn,Ea add hr
 ;;^UTILITY(U,$J,358.3,574,0)
 ;;=96416^^10^71^6^^^^1
 ;;^UTILITY(U,$J,358.3,574,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,574,1,1,0)
 ;;=1^96416
 ;;^UTILITY(U,$J,358.3,574,1,3,0)
 ;;=3^Chemo Infusn Pump,Init >8hr
 ;;^UTILITY(U,$J,358.3,575,0)
 ;;=96423^^10^71^5^^^^1
 ;;^UTILITY(U,$J,358.3,575,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,575,1,1,0)
 ;;=1^96423
 ;;^UTILITY(U,$J,358.3,575,1,3,0)
 ;;=3^Chemo IA Infuse Each Addl Hr
 ;;^UTILITY(U,$J,358.3,576,0)
 ;;=96425^^10^71^11^^^^1
 ;;^UTILITY(U,$J,358.3,576,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,576,1,1,0)
 ;;=1^96425
 ;;^UTILITY(U,$J,358.3,576,1,3,0)
 ;;=3^Chemo,IA,Init pump >8hr
 ;;^UTILITY(U,$J,358.3,577,0)
 ;;=96360^^10^71^19^^^^1
 ;;^UTILITY(U,$J,358.3,577,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,577,1,1,0)
 ;;=1^96360
 ;;^UTILITY(U,$J,358.3,577,1,3,0)
 ;;=3^Hydration IV Infusn,Init hr
 ;;^UTILITY(U,$J,358.3,578,0)
 ;;=96361^^10^71^20^^^^1
 ;;^UTILITY(U,$J,358.3,578,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,578,1,1,0)
 ;;=1^96361
 ;;^UTILITY(U,$J,358.3,578,1,3,0)
 ;;=3^Hydration IV Infusn Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,579,0)
 ;;=96365^^10^71^26^^^^1
 ;;^UTILITY(U,$J,358.3,579,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,579,1,1,0)
 ;;=1^96365
 ;;^UTILITY(U,$J,358.3,579,1,3,0)
 ;;=3^Ther/Diag/Proph,IV Infusn,Init hr
 ;;^UTILITY(U,$J,358.3,580,0)
 ;;=96366^^10^71^27^^^^1
 ;;^UTILITY(U,$J,358.3,580,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,580,1,1,0)
 ;;=1^96366
 ;;^UTILITY(U,$J,358.3,580,1,3,0)
 ;;=3^Ther/Diag/Proph, IV Infusn,Ea Add Hr
 ;;^UTILITY(U,$J,358.3,581,0)
 ;;=96372^^10^71^22^^^^1
 ;;^UTILITY(U,$J,358.3,581,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,581,1,1,0)
 ;;=1^96372
 ;;^UTILITY(U,$J,358.3,581,1,3,0)
 ;;=3^Ther/Diag/Proph IM/SQ injection
 ;;^UTILITY(U,$J,358.3,582,0)
 ;;=96374^^10^71^25^^^^1
 ;;^UTILITY(U,$J,358.3,582,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,582,1,1,0)
 ;;=1^96374
 ;;^UTILITY(U,$J,358.3,582,1,3,0)
 ;;=3^Ther/Diag/Proph IV push, Init
 ;;^UTILITY(U,$J,358.3,583,0)
 ;;=96375^^10^71^24^^^^1
 ;;^UTILITY(U,$J,358.3,583,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,583,1,1,0)
 ;;=1^96375
 ;;^UTILITY(U,$J,358.3,583,1,3,0)
 ;;=3^Ther/Diag/Proph IV push ea add seql,new drug
 ;;^UTILITY(U,$J,358.3,584,0)
 ;;=96367^^10^71^28^^^^1
 ;;^UTILITY(U,$J,358.3,584,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,584,1,1,0)
 ;;=1^96367
 ;;^UTILITY(U,$J,358.3,584,1,3,0)
 ;;=3^Ther/Diag/Proph,IV Infusn,Ea add hr seql
 ;;^UTILITY(U,$J,358.3,585,0)
 ;;=96368^^10^71^23^^^^1
 ;;^UTILITY(U,$J,358.3,585,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,585,1,1,0)
 ;;=1^96368
 ;;^UTILITY(U,$J,358.3,585,1,3,0)
 ;;=3^Ther/Diag/Proph IV Infusn, Concurrent
 ;;^UTILITY(U,$J,358.3,586,0)
 ;;=96446^^10^71^4^^^^1
 ;;^UTILITY(U,$J,358.3,586,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,586,1,1,0)
 ;;=1^96446
 ;;^UTILITY(U,$J,358.3,586,1,3,0)
 ;;=3^Chemo Admn, Peritoneal Cavity
 ;;^UTILITY(U,$J,358.3,587,0)
 ;;=J9000^^10^72^9^^^^1
 ;;^UTILITY(U,$J,358.3,587,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,587,1,1,0)
 ;;=1^J9000
 ;;^UTILITY(U,$J,358.3,587,1,3,0)
 ;;=3^Doxorubicin 10mg
 ;;^UTILITY(U,$J,358.3,588,0)
 ;;=J9040^^10^72^2^^^^1
 ;;^UTILITY(U,$J,358.3,588,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,588,1,1,0)
 ;;=1^J9040
 ;;^UTILITY(U,$J,358.3,588,1,3,0)
 ;;=3^Bleomycin Sulfate Inj 15U
 ;;^UTILITY(U,$J,358.3,589,0)
 ;;=J9045^^10^72^4^^^^1
 ;;^UTILITY(U,$J,358.3,589,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,589,1,1,0)
 ;;=1^J9045
 ;;^UTILITY(U,$J,358.3,589,1,3,0)
 ;;=3^Carboplatin 50mg
 ;;^UTILITY(U,$J,358.3,590,0)
 ;;=J9060^^10^72^5^^^^1
 ;;^UTILITY(U,$J,358.3,590,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,590,1,1,0)
 ;;=1^J9060
 ;;^UTILITY(U,$J,358.3,590,1,3,0)
 ;;=3^Cisplatin 10 MG injection
 ;;^UTILITY(U,$J,358.3,591,0)
 ;;=J9100^^10^72^7^^^^1
 ;;^UTILITY(U,$J,358.3,591,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,591,1,1,0)
 ;;=1^J9100
 ;;^UTILITY(U,$J,358.3,591,1,3,0)
 ;;=3^Cytarabine (arac) 100mg
 ;;^UTILITY(U,$J,358.3,592,0)
 ;;=J9181^^10^72^11^^^^1
 ;;^UTILITY(U,$J,358.3,592,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,592,1,1,0)
 ;;=1^J9181
 ;;^UTILITY(U,$J,358.3,592,1,3,0)
 ;;=3^Etoposide (VP 16) 10mg
 ;;^UTILITY(U,$J,358.3,593,0)
 ;;=J9185^^10^72^12^^^^1
 ;;^UTILITY(U,$J,358.3,593,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,593,1,1,0)
 ;;=1^J9185
 ;;^UTILITY(U,$J,358.3,593,1,3,0)
 ;;=3^Fludarabine 50mg
 ;;^UTILITY(U,$J,358.3,594,0)
 ;;=J9190^^10^72^13^^^^1
 ;;^UTILITY(U,$J,358.3,594,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,594,1,1,0)
 ;;=1^J9190
 ;;^UTILITY(U,$J,358.3,594,1,3,0)
 ;;=3^Fluorouracil 500mg
 ;;^UTILITY(U,$J,358.3,595,0)
 ;;=J9201^^10^72^14^^^^1
 ;;^UTILITY(U,$J,358.3,595,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,595,1,1,0)
 ;;=1^J9201
 ;;^UTILITY(U,$J,358.3,595,1,3,0)
 ;;=3^Gemcitabine 200mg
 ;;^UTILITY(U,$J,358.3,596,0)
 ;;=J9202^^10^72^15^^^^1
 ;;^UTILITY(U,$J,358.3,596,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,596,1,1,0)
 ;;=1^J9202
 ;;^UTILITY(U,$J,358.3,596,1,3,0)
 ;;=3^Goserelin, per 3.6mg
 ;;^UTILITY(U,$J,358.3,597,0)
 ;;=J9206^^10^72^3^^^^1
 ;;^UTILITY(U,$J,358.3,597,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,597,1,1,0)
 ;;=1^J9206
 ;;^UTILITY(U,$J,358.3,597,1,3,0)
 ;;=3^Camptosar 20mg
 ;;^UTILITY(U,$J,358.3,598,0)
 ;;=J9208^^10^72^16^^^^1
 ;;^UTILITY(U,$J,358.3,598,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,598,1,1,0)
 ;;=1^J9208
 ;;^UTILITY(U,$J,358.3,598,1,3,0)
 ;;=3^Ifosfamide (IFEX) 1gr
 ;;^UTILITY(U,$J,358.3,599,0)
 ;;=J9209^^10^72^21^^^^1
 ;;^UTILITY(U,$J,358.3,599,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,599,1,1,0)
 ;;=1^J9209
 ;;^UTILITY(U,$J,358.3,599,1,3,0)
 ;;=3^Mesna 200mgs
 ;;^UTILITY(U,$J,358.3,600,0)
 ;;=J9213^^10^72^18^^^^1
 ;;^UTILITY(U,$J,358.3,600,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,600,1,1,0)
 ;;=1^J9213
 ;;^UTILITY(U,$J,358.3,600,1,3,0)
 ;;=3^Interferon alfa, 3 mil u
 ;;^UTILITY(U,$J,358.3,601,0)
 ;;=J9214^^10^72^17^^^^1
