IBDEI0KP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9364,0)
 ;;=F44.6^^61^598^4
 ;;^UTILITY(U,$J,358.3,9364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9364,1,3,0)
 ;;=3^Conversion Disorder w/ Sensory Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,9364,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,9364,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,9365,0)
 ;;=F10.20^^61^598^1
 ;;^UTILITY(U,$J,358.3,9365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9365,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,9365,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,9365,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,9366,0)
 ;;=F51.8^^61^598^12
 ;;^UTILITY(U,$J,358.3,9366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9366,1,3,0)
 ;;=3^Sleep Disorder Not d/t Substance/Physiological Condition
 ;;^UTILITY(U,$J,358.3,9366,1,4,0)
 ;;=4^F51.8
 ;;^UTILITY(U,$J,358.3,9366,2)
 ;;=^5003616
 ;;^UTILITY(U,$J,358.3,9367,0)
 ;;=F32.9^^61^598^8
 ;;^UTILITY(U,$J,358.3,9367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9367,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,9367,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,9367,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,9368,0)
 ;;=G91.1^^61^598^9
 ;;^UTILITY(U,$J,358.3,9368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9368,1,3,0)
 ;;=3^Obstructive Hydrocephalus
 ;;^UTILITY(U,$J,358.3,9368,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,9368,2)
 ;;=^84947
 ;;^UTILITY(U,$J,358.3,9369,0)
 ;;=I95.1^^61^598^10
 ;;^UTILITY(U,$J,358.3,9369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9369,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,9369,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,9369,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,9370,0)
 ;;=I95.89^^61^598^7
 ;;^UTILITY(U,$J,358.3,9370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9370,1,3,0)
 ;;=3^Hypotension,Other
 ;;^UTILITY(U,$J,358.3,9370,1,4,0)
 ;;=4^I95.89
 ;;^UTILITY(U,$J,358.3,9370,2)
 ;;=^5008079
 ;;^UTILITY(U,$J,358.3,9371,0)
 ;;=R55.^^61^598^13
 ;;^UTILITY(U,$J,358.3,9371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9371,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,9371,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,9371,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,9372,0)
 ;;=G47.10^^61^598^6
 ;;^UTILITY(U,$J,358.3,9372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9372,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,9372,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,9372,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,9373,0)
 ;;=G47.30^^61^598^11
 ;;^UTILITY(U,$J,358.3,9373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9373,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,9373,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,9373,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,9374,0)
 ;;=R20.0^^61^598^2
 ;;^UTILITY(U,$J,358.3,9374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9374,1,3,0)
 ;;=3^Anesthesia of Skin
 ;;^UTILITY(U,$J,358.3,9374,1,4,0)
 ;;=4^R20.0
 ;;^UTILITY(U,$J,358.3,9374,2)
 ;;=^5019278
 ;;^UTILITY(U,$J,358.3,9375,0)
 ;;=95953^^62^599^6^^^^1
 ;;^UTILITY(U,$J,358.3,9375,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9375,1,2,0)
 ;;=2^EEG Portable Monitoring,Unattend,12-24hrs
 ;;^UTILITY(U,$J,358.3,9375,1,3,0)
 ;;=3^95953
 ;;^UTILITY(U,$J,358.3,9376,0)
 ;;=95950^^62^599^1^^^^1
 ;;^UTILITY(U,$J,358.3,9376,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9376,1,2,0)
 ;;=2^Ambulatory EEG,12-24hrs
 ;;^UTILITY(U,$J,358.3,9376,1,3,0)
 ;;=3^95950
 ;;^UTILITY(U,$J,358.3,9377,0)
 ;;=95956^^62^599^4^^^^1
 ;;^UTILITY(U,$J,358.3,9377,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9377,1,2,0)
 ;;=2^EEG Monitoring,Nurs/Tech Attend,12-24hrs
 ;;^UTILITY(U,$J,358.3,9377,1,3,0)
 ;;=3^95956
