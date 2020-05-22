IBDEI00D ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,224,2)
 ;;=^5003796
 ;;^UTILITY(U,$J,358.3,225,0)
 ;;=G25.9^^5^30^7
 ;;^UTILITY(U,$J,358.3,225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,225,1,3,0)
 ;;=3^Extrapyramidal & Movement Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,225,1,4,0)
 ;;=4^G25.9
 ;;^UTILITY(U,$J,358.3,225,2)
 ;;=^5003803
 ;;^UTILITY(U,$J,358.3,226,0)
 ;;=G25.82^^5^30^12
 ;;^UTILITY(U,$J,358.3,226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,226,1,3,0)
 ;;=3^Stiff-Man Syndrome
 ;;^UTILITY(U,$J,358.3,226,1,4,0)
 ;;=4^G25.82
 ;;^UTILITY(U,$J,358.3,226,2)
 ;;=^185540
 ;;^UTILITY(U,$J,358.3,227,0)
 ;;=G25.81^^5^30^10
 ;;^UTILITY(U,$J,358.3,227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,227,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,227,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,227,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,228,0)
 ;;=R27.0^^5^30^1
 ;;^UTILITY(U,$J,358.3,228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,228,1,3,0)
 ;;=3^Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,228,1,4,0)
 ;;=4^R27.0
 ;;^UTILITY(U,$J,358.3,228,2)
 ;;=^5019310
 ;;^UTILITY(U,$J,358.3,229,0)
 ;;=G31.83^^5^30^3
 ;;^UTILITY(U,$J,358.3,229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,229,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,229,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,229,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,230,0)
 ;;=G31.84^^5^30^2
 ;;^UTILITY(U,$J,358.3,230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,230,1,3,0)
 ;;=3^Cognitive Impairment,Mild,So Stated
 ;;^UTILITY(U,$J,358.3,230,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,230,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,231,0)
 ;;=C71.9^^5^31^3
 ;;^UTILITY(U,$J,358.3,231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,231,1,3,0)
 ;;=3^Malig Neop Brain,Unspec
 ;;^UTILITY(U,$J,358.3,231,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,231,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,232,0)
 ;;=C72.0^^5^31^5
 ;;^UTILITY(U,$J,358.3,232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,232,1,3,0)
 ;;=3^Malig Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,232,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,232,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,233,0)
 ;;=C72.1^^5^31^4
 ;;^UTILITY(U,$J,358.3,233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,233,1,3,0)
 ;;=3^Malig Neop Cauda Equina
 ;;^UTILITY(U,$J,358.3,233,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,233,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,234,0)
 ;;=C79.31^^5^31^6
 ;;^UTILITY(U,$J,358.3,234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,234,1,3,0)
 ;;=3^Secondary Malig Neop Brain
 ;;^UTILITY(U,$J,358.3,234,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,234,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,235,0)
 ;;=D32.0^^5^31^1
 ;;^UTILITY(U,$J,358.3,235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,235,1,3,0)
 ;;=3^Benign Neop Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,235,1,4,0)
 ;;=4^D32.0
 ;;^UTILITY(U,$J,358.3,235,2)
 ;;=^267681
 ;;^UTILITY(U,$J,358.3,236,0)
 ;;=D33.4^^5^31^2
 ;;^UTILITY(U,$J,358.3,236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,236,1,3,0)
 ;;=3^Benign Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,236,1,4,0)
 ;;=4^D33.4
 ;;^UTILITY(U,$J,358.3,236,2)
 ;;=^267682
 ;;^UTILITY(U,$J,358.3,237,0)
 ;;=F03.90^^5^32^8
 ;;^UTILITY(U,$J,358.3,237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,237,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,237,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,237,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,238,0)
 ;;=G30.9^^5^32^4
 ;;^UTILITY(U,$J,358.3,238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,238,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,238,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,238,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,239,0)
 ;;=R41.3^^5^32^5
 ;;^UTILITY(U,$J,358.3,239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,239,1,3,0)
 ;;=3^Amnesia,Other
 ;;^UTILITY(U,$J,358.3,239,1,4,0)
 ;;=4^R41.3
 ;;^UTILITY(U,$J,358.3,239,2)
 ;;=^5019439
 ;;^UTILITY(U,$J,358.3,240,0)
 ;;=G30.0^^5^32^1
 ;;^UTILITY(U,$J,358.3,240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,240,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,240,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,240,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,241,0)
 ;;=G30.1^^5^32^2
 ;;^UTILITY(U,$J,358.3,241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,241,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,241,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,241,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,242,0)
 ;;=G30.8^^5^32^3
 ;;^UTILITY(U,$J,358.3,242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,242,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,242,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,242,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,243,0)
 ;;=F02.80^^5^32^6
 ;;^UTILITY(U,$J,358.3,243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,243,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,243,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,243,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,244,0)
 ;;=F02.81^^5^32^7
 ;;^UTILITY(U,$J,358.3,244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,244,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,244,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,244,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,245,0)
 ;;=G47.61^^5^33^3
 ;;^UTILITY(U,$J,358.3,245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,245,1,3,0)
 ;;=3^Periodic Limb Movement Disorder
 ;;^UTILITY(U,$J,358.3,245,1,4,0)
 ;;=4^G47.61
 ;;^UTILITY(U,$J,358.3,245,2)
 ;;=^5003987
 ;;^UTILITY(U,$J,358.3,246,0)
 ;;=G25.81^^5^33^4
 ;;^UTILITY(U,$J,358.3,246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,246,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,246,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,246,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,247,0)
 ;;=G47.419^^5^33^2
 ;;^UTILITY(U,$J,358.3,247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,247,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy
 ;;^UTILITY(U,$J,358.3,247,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,247,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,248,0)
 ;;=G47.9^^5^33^6
 ;;^UTILITY(U,$J,358.3,248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,248,1,3,0)
 ;;=3^Sleep Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,248,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,248,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,249,0)
 ;;=G47.10^^5^33^1
 ;;^UTILITY(U,$J,358.3,249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,249,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,249,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,249,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,250,0)
 ;;=G47.30^^5^33^5
 ;;^UTILITY(U,$J,358.3,250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,250,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,250,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,250,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,251,0)
 ;;=G47.8^^5^33^7
 ;;^UTILITY(U,$J,358.3,251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,251,1,3,0)
 ;;=3^Sleep Disorders,Other
 ;;^UTILITY(U,$J,358.3,251,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,251,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,252,0)
 ;;=Z13.850^^5^34^2
 ;;^UTILITY(U,$J,358.3,252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,252,1,3,0)
 ;;=3^Traumatic Brain Injury Screening
 ;;^UTILITY(U,$J,358.3,252,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,252,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,253,0)
 ;;=Z13.858^^5^34^1
 ;;^UTILITY(U,$J,358.3,253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,253,1,3,0)
 ;;=3^Nervous System Disorder Screening
 ;;^UTILITY(U,$J,358.3,253,1,4,0)
 ;;=4^Z13.858
 ;;^UTILITY(U,$J,358.3,253,2)
 ;;=^5062718
 ;;^UTILITY(U,$J,358.3,254,0)
 ;;=E53.8^^5^35^5
 ;;^UTILITY(U,$J,358.3,254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,254,1,3,0)
 ;;=3^Deficiency of Vitamin B Group,Other Spec
 ;;^UTILITY(U,$J,358.3,254,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,254,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,255,0)
 ;;=F44.4^^5^35^3
 ;;^UTILITY(U,$J,358.3,255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,255,1,3,0)
 ;;=3^Conversion Disorder w/ Motor Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,255,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,255,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,256,0)
 ;;=F44.6^^5^35^4
 ;;^UTILITY(U,$J,358.3,256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,256,1,3,0)
 ;;=3^Conversion Disorder w/ Sensory Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,256,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,256,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,257,0)
 ;;=F10.20^^5^35^1
 ;;^UTILITY(U,$J,358.3,257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,257,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,257,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,257,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,258,0)
 ;;=F51.8^^5^35^12
 ;;^UTILITY(U,$J,358.3,258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,258,1,3,0)
 ;;=3^Sleep Disorder Not d/t Substance/Physiological Condition
 ;;^UTILITY(U,$J,358.3,258,1,4,0)
 ;;=4^F51.8
 ;;^UTILITY(U,$J,358.3,258,2)
 ;;=^5003616
 ;;^UTILITY(U,$J,358.3,259,0)
 ;;=F32.9^^5^35^8
 ;;^UTILITY(U,$J,358.3,259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,259,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,259,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,259,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,260,0)
 ;;=G91.1^^5^35^9
 ;;^UTILITY(U,$J,358.3,260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,260,1,3,0)
 ;;=3^Obstructive Hydrocephalus
 ;;^UTILITY(U,$J,358.3,260,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,260,2)
 ;;=^84947
 ;;^UTILITY(U,$J,358.3,261,0)
 ;;=I95.1^^5^35^10
 ;;^UTILITY(U,$J,358.3,261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,261,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,261,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,261,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,262,0)
 ;;=I95.89^^5^35^7
 ;;^UTILITY(U,$J,358.3,262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,262,1,3,0)
 ;;=3^Hypotension,Other
 ;;^UTILITY(U,$J,358.3,262,1,4,0)
 ;;=4^I95.89
 ;;^UTILITY(U,$J,358.3,262,2)
 ;;=^5008079
 ;;^UTILITY(U,$J,358.3,263,0)
 ;;=R55.^^5^35^13
 ;;^UTILITY(U,$J,358.3,263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,263,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,263,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,263,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,264,0)
 ;;=G47.10^^5^35^6
 ;;^UTILITY(U,$J,358.3,264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,264,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,264,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,264,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,265,0)
 ;;=G47.30^^5^35^11
 ;;^UTILITY(U,$J,358.3,265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,265,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,265,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,265,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,266,0)
 ;;=R20.0^^5^35^2
 ;;^UTILITY(U,$J,358.3,266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,266,1,3,0)
 ;;=3^Anesthesia of Skin
 ;;^UTILITY(U,$J,358.3,266,1,4,0)
 ;;=4^R20.0
 ;;^UTILITY(U,$J,358.3,266,2)
 ;;=^5019278
 ;;^UTILITY(U,$J,358.3,267,0)
 ;;=95830^^6^36^10^^^^1
 ;;^UTILITY(U,$J,358.3,267,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,267,1,2,0)
 ;;=2^Insert Sphenoidal Electrodes
 ;;^UTILITY(U,$J,358.3,267,1,3,0)
 ;;=3^95830
 ;;^UTILITY(U,$J,358.3,268,0)
 ;;=95957^^6^36^3^^^^1
 ;;^UTILITY(U,$J,358.3,268,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,268,1,2,0)
 ;;=2^Digital Analysis of EEG
 ;;^UTILITY(U,$J,358.3,268,1,3,0)
 ;;=3^95957
 ;;^UTILITY(U,$J,358.3,269,0)
 ;;=95954^^6^37^5^^^^1
 ;;^UTILITY(U,$J,358.3,269,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,269,1,2,0)
 ;;=2^Med Admin during EEG
 ;;^UTILITY(U,$J,358.3,269,1,3,0)
 ;;=3^95954
 ;;^UTILITY(U,$J,358.3,270,0)
 ;;=95958^^6^37^6^^^^1
 ;;^UTILITY(U,$J,358.3,270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,270,1,2,0)
 ;;=2^Wada Activation Test for Hemispheric Function
 ;;^UTILITY(U,$J,358.3,270,1,3,0)
 ;;=3^95958
 ;;^UTILITY(U,$J,358.3,271,0)
 ;;=95829^^6^37^2^^^^1
 ;;^UTILITY(U,$J,358.3,271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,271,1,2,0)
 ;;=2^Electrocorticography during Surgery
 ;;^UTILITY(U,$J,358.3,271,1,3,0)
 ;;=3^95829
 ;;^UTILITY(U,$J,358.3,272,0)
 ;;=95955^^6^37^1^^^^1
 ;;^UTILITY(U,$J,358.3,272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,272,1,2,0)
 ;;=2^EEG during Non-Intracran Surgery
 ;;^UTILITY(U,$J,358.3,272,1,3,0)
 ;;=3^95955
 ;;^UTILITY(U,$J,358.3,273,0)
 ;;=95961^^6^37^3^^^^1
 ;;^UTILITY(U,$J,358.3,273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,273,1,2,0)
 ;;=2^Functional Cortical Mapping,1st Hr
 ;;^UTILITY(U,$J,358.3,273,1,3,0)
 ;;=3^95961
 ;;^UTILITY(U,$J,358.3,274,0)
 ;;=95962^^6^37^4^^^^1
 ;;^UTILITY(U,$J,358.3,274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,274,1,2,0)
 ;;=2^Functional Cortical Mapping,Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,274,1,3,0)
 ;;=3^95962
 ;;^UTILITY(U,$J,358.3,275,0)
 ;;=95812^^6^38^1^^^^1
 ;;^UTILITY(U,$J,358.3,275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,275,1,2,0)
 ;;=2^EEG,41-60 minutes
 ;;^UTILITY(U,$J,358.3,275,1,3,0)
 ;;=3^95812
 ;;^UTILITY(U,$J,358.3,276,0)
 ;;=95813^^6^38^2^^^^1
 ;;^UTILITY(U,$J,358.3,276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,276,1,2,0)
 ;;=2^EEG,61-119 minutes
 ;;^UTILITY(U,$J,358.3,276,1,3,0)
 ;;=3^95813
 ;;^UTILITY(U,$J,358.3,277,0)
 ;;=95816^^6^38^3^^^^1
 ;;^UTILITY(U,$J,358.3,277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,277,1,2,0)
 ;;=2^EEG,Awake and Drowsy
 ;;^UTILITY(U,$J,358.3,277,1,3,0)
 ;;=3^95816
 ;;^UTILITY(U,$J,358.3,278,0)
 ;;=95819^^6^38^4^^^^1
 ;;^UTILITY(U,$J,358.3,278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,278,1,2,0)
 ;;=2^EEG,Awake and Asleep
 ;;^UTILITY(U,$J,358.3,278,1,3,0)
 ;;=3^95819
 ;;^UTILITY(U,$J,358.3,279,0)
 ;;=95822^^6^38^5^^^^1
 ;;^UTILITY(U,$J,358.3,279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,279,1,2,0)
 ;;=2^EEG,Sleep or Coma Only
 ;;^UTILITY(U,$J,358.3,279,1,3,0)
 ;;=3^95822
 ;;^UTILITY(U,$J,358.3,280,0)
 ;;=3650F^^6^38^6^^^^1
 ;;^UTILITY(U,$J,358.3,280,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,280,1,2,0)
 ;;=2^EEG Store and Forward (Ordered/Reviewed/Requested)
 ;;^UTILITY(U,$J,358.3,280,1,3,0)
 ;;=3^3650F
 ;;^UTILITY(U,$J,358.3,281,0)
 ;;=95926^^6^39^4^^^^1
 ;;^UTILITY(U,$J,358.3,281,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,281,1,2,0)
 ;;=2^Short Latency SSEP,Periph Nerve,Lower
 ;;^UTILITY(U,$J,358.3,281,1,3,0)
 ;;=3^95926
 ;;^UTILITY(U,$J,358.3,282,0)
 ;;=95925^^6^39^5^^^^1
 ;;^UTILITY(U,$J,358.3,282,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,282,1,2,0)
 ;;=2^Short Latency SSEP,Periph Nerve,Upper
 ;;^UTILITY(U,$J,358.3,282,1,3,0)
 ;;=3^95925
 ;;^UTILITY(U,$J,358.3,283,0)
 ;;=95938^^6^39^6^^^^1
 ;;^UTILITY(U,$J,358.3,283,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,283,1,2,0)
 ;;=2^Short Latency SSEP,Periph Nerve,Uppr&Lwr
 ;;^UTILITY(U,$J,358.3,283,1,3,0)
 ;;=3^95938
 ;;^UTILITY(U,$J,358.3,284,0)
 ;;=95928^^6^39^2^^^^1
 ;;^UTILITY(U,$J,358.3,284,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,284,1,2,0)
 ;;=2^C Motor Evoked Upper Limbs
 ;;^UTILITY(U,$J,358.3,284,1,3,0)
 ;;=3^95928
 ;;^UTILITY(U,$J,358.3,285,0)
 ;;=95929^^6^39^1^^^^1
 ;;^UTILITY(U,$J,358.3,285,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,285,1,2,0)
 ;;=2^C Motor Evoked Lower Limbs
 ;;^UTILITY(U,$J,358.3,285,1,3,0)
 ;;=3^95929
 ;;^UTILITY(U,$J,358.3,286,0)
 ;;=95939^^6^39^3^^^^1
 ;;^UTILITY(U,$J,358.3,286,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,286,1,2,0)
 ;;=2^C Motor Evoked Uppr&Lwr Limbs
 ;;^UTILITY(U,$J,358.3,286,1,3,0)
 ;;=3^95939
 ;;^UTILITY(U,$J,358.3,287,0)
 ;;=95976^^6^40^1^^^^1
 ;;^UTILITY(U,$J,358.3,287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,287,1,2,0)
 ;;=2^Analysis NPGT Prgrmg,Simple 
 ;;^UTILITY(U,$J,358.3,287,1,3,0)
 ;;=3^95976
 ;;^UTILITY(U,$J,358.3,288,0)
 ;;=95977^^6^40^2^^^^1
 ;;^UTILITY(U,$J,358.3,288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,288,1,2,0)
 ;;=2^Analysis NPGT Prgrmg,Complex
 ;;^UTILITY(U,$J,358.3,288,1,3,0)
 ;;=3^95977
 ;;^UTILITY(U,$J,358.3,289,0)
 ;;=95705^^6^41^15^^^^1
 ;;^UTILITY(U,$J,358.3,289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,289,1,2,0)
 ;;=2^EEG w/o Video,2-12 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,289,1,3,0)
 ;;=3^95705
 ;;^UTILITY(U,$J,358.3,290,0)
 ;;=95706^^6^41^13^^^^1
 ;;^UTILITY(U,$J,358.3,290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,290,1,2,0)
 ;;=2^EEG w/o Video w/ Intmt Mntr,2-12 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,290,1,3,0)
 ;;=3^95706
 ;;^UTILITY(U,$J,358.3,291,0)
 ;;=95707^^6^41^19^^^^1
 ;;^UTILITY(U,$J,358.3,291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,291,1,2,0)
 ;;=2^EEG w/o Video,Cont Mntr,2-12 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,291,1,3,0)
 ;;=3^95707
 ;;^UTILITY(U,$J,358.3,292,0)
 ;;=95708^^6^41^14^^^^1
 ;;^UTILITY(U,$J,358.3,292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,292,1,2,0)
 ;;=2^EEG w/o Video,12-16 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,292,1,3,0)
 ;;=3^95708
 ;;^UTILITY(U,$J,358.3,293,0)
 ;;=95709^^6^41^12^^^^1
 ;;^UTILITY(U,$J,358.3,293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,293,1,2,0)
 ;;=2^EEG w/o Video w/ Intmt Mntr,12-16 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,293,1,3,0)
 ;;=3^95709
 ;;^UTILITY(U,$J,358.3,294,0)
 ;;=95710^^6^41^16^^^^1
 ;;^UTILITY(U,$J,358.3,294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,294,1,2,0)
 ;;=2^EEG w/o Video,Cont Mntr,12-16 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,294,1,3,0)
 ;;=3^95710
 ;;^UTILITY(U,$J,358.3,295,0)
 ;;=95711^^6^41^4^^^^1
 ;;^UTILITY(U,$J,358.3,295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,295,1,2,0)
 ;;=2^EEG w/ Video,2-12 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,295,1,3,0)
 ;;=3^95711
 ;;^UTILITY(U,$J,358.3,296,0)
 ;;=95712^^6^41^2^^^^1
 ;;^UTILITY(U,$J,358.3,296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,296,1,2,0)
 ;;=2^EEG w/ Video w/ Intmt Mntr,2-12 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,296,1,3,0)
 ;;=3^95712
 ;;^UTILITY(U,$J,358.3,297,0)
 ;;=95713^^6^41^8^^^^1
 ;;^UTILITY(U,$J,358.3,297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,297,1,2,0)
 ;;=2^EEG w/ Video,Cont Mntr,2-12 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,297,1,3,0)
 ;;=3^95713
 ;;^UTILITY(U,$J,358.3,298,0)
 ;;=95714^^6^41^3^^^^1
 ;;^UTILITY(U,$J,358.3,298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,298,1,2,0)
 ;;=2^EEG w/ Video,12-16 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,298,1,3,0)
 ;;=3^95714
 ;;^UTILITY(U,$J,358.3,299,0)
 ;;=95715^^6^41^1^^^^1
 ;;^UTILITY(U,$J,358.3,299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,299,1,2,0)
 ;;=2^EEG w/ Video w/ Intmt Mntr,12-16 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,299,1,3,0)
 ;;=3^95715
 ;;^UTILITY(U,$J,358.3,300,0)
 ;;=95716^^6^41^5^^^^1
 ;;^UTILITY(U,$J,358.3,300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,300,1,2,0)
 ;;=2^EEG w/ Video,Cont Mntr,12-16 Hrs,Tech
 ;;^UTILITY(U,$J,358.3,300,1,3,0)
 ;;=3^95716
 ;;^UTILITY(U,$J,358.3,301,0)
 ;;=95717^^6^41^18^^^^1
 ;;^UTILITY(U,$J,358.3,301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,301,1,2,0)
 ;;=2^EEG w/o Video,Cont Mntr,2-12 Hrs,Phys
 ;;^UTILITY(U,$J,358.3,301,1,3,0)
 ;;=3^95717
 ;;^UTILITY(U,$J,358.3,302,0)
 ;;=95718^^6^41^7^^^^1
 ;;^UTILITY(U,$J,358.3,302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,302,1,2,0)
 ;;=2^EEG w/ Video,Cont Mntr,2-12 Hrs,Phys
