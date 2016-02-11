IBDEI0KG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9242,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,9242,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,9243,0)
 ;;=G47.9^^58^580^6
 ;;^UTILITY(U,$J,358.3,9243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9243,1,3,0)
 ;;=3^Sleep Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,9243,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,9243,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,9244,0)
 ;;=G47.10^^58^580^1
 ;;^UTILITY(U,$J,358.3,9244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9244,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,9244,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,9244,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,9245,0)
 ;;=G47.30^^58^580^5
 ;;^UTILITY(U,$J,358.3,9245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9245,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,9245,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,9245,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,9246,0)
 ;;=G47.8^^58^580^7
 ;;^UTILITY(U,$J,358.3,9246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9246,1,3,0)
 ;;=3^Sleep Disorders,Other
 ;;^UTILITY(U,$J,358.3,9246,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,9246,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,9247,0)
 ;;=Z13.850^^58^581^2
 ;;^UTILITY(U,$J,358.3,9247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9247,1,3,0)
 ;;=3^Traumatic Brain Injury Screening
 ;;^UTILITY(U,$J,358.3,9247,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,9247,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,9248,0)
 ;;=Z13.858^^58^581^1
 ;;^UTILITY(U,$J,358.3,9248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9248,1,3,0)
 ;;=3^Nervous System Disorder Screening
 ;;^UTILITY(U,$J,358.3,9248,1,4,0)
 ;;=4^Z13.858
 ;;^UTILITY(U,$J,358.3,9248,2)
 ;;=^5062718
 ;;^UTILITY(U,$J,358.3,9249,0)
 ;;=E53.8^^58^582^5
 ;;^UTILITY(U,$J,358.3,9249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9249,1,3,0)
 ;;=3^Deficiency of Vitamin B Group,Other Spec
 ;;^UTILITY(U,$J,358.3,9249,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,9249,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,9250,0)
 ;;=F44.4^^58^582^3
 ;;^UTILITY(U,$J,358.3,9250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9250,1,3,0)
 ;;=3^Conversion Disorder w/ Motor Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,9250,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,9250,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,9251,0)
 ;;=F44.6^^58^582^4
 ;;^UTILITY(U,$J,358.3,9251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9251,1,3,0)
 ;;=3^Conversion Disorder w/ Sensory Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,9251,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,9251,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,9252,0)
 ;;=F10.20^^58^582^1
 ;;^UTILITY(U,$J,358.3,9252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9252,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,9252,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,9252,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,9253,0)
 ;;=F51.8^^58^582^12
 ;;^UTILITY(U,$J,358.3,9253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9253,1,3,0)
 ;;=3^Sleep Disorder Not d/t Substance/Physiological Condition
 ;;^UTILITY(U,$J,358.3,9253,1,4,0)
 ;;=4^F51.8
 ;;^UTILITY(U,$J,358.3,9253,2)
 ;;=^5003616
 ;;^UTILITY(U,$J,358.3,9254,0)
 ;;=F32.9^^58^582^8
 ;;^UTILITY(U,$J,358.3,9254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9254,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,9254,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,9254,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,9255,0)
 ;;=G91.1^^58^582^9
 ;;^UTILITY(U,$J,358.3,9255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9255,1,3,0)
 ;;=3^Obstructive Hydrocephalus
 ;;^UTILITY(U,$J,358.3,9255,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,9255,2)
 ;;=^84947
