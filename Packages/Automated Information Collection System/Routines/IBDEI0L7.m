IBDEI0L7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9608,0)
 ;;=F44.6^^65^627^4
 ;;^UTILITY(U,$J,358.3,9608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9608,1,3,0)
 ;;=3^Conversion Disorder w/ Sensory Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,9608,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,9608,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,9609,0)
 ;;=F10.20^^65^627^1
 ;;^UTILITY(U,$J,358.3,9609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9609,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,9609,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,9609,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,9610,0)
 ;;=F51.8^^65^627^12
 ;;^UTILITY(U,$J,358.3,9610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9610,1,3,0)
 ;;=3^Sleep Disorder Not d/t Substance/Physiological Condition
 ;;^UTILITY(U,$J,358.3,9610,1,4,0)
 ;;=4^F51.8
 ;;^UTILITY(U,$J,358.3,9610,2)
 ;;=^5003616
 ;;^UTILITY(U,$J,358.3,9611,0)
 ;;=F32.9^^65^627^8
 ;;^UTILITY(U,$J,358.3,9611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9611,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,9611,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,9611,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,9612,0)
 ;;=G91.1^^65^627^9
 ;;^UTILITY(U,$J,358.3,9612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9612,1,3,0)
 ;;=3^Obstructive Hydrocephalus
 ;;^UTILITY(U,$J,358.3,9612,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,9612,2)
 ;;=^84947
 ;;^UTILITY(U,$J,358.3,9613,0)
 ;;=I95.1^^65^627^10
 ;;^UTILITY(U,$J,358.3,9613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9613,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,9613,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,9613,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,9614,0)
 ;;=I95.89^^65^627^7
 ;;^UTILITY(U,$J,358.3,9614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9614,1,3,0)
 ;;=3^Hypotension,Other
 ;;^UTILITY(U,$J,358.3,9614,1,4,0)
 ;;=4^I95.89
 ;;^UTILITY(U,$J,358.3,9614,2)
 ;;=^5008079
 ;;^UTILITY(U,$J,358.3,9615,0)
 ;;=R55.^^65^627^13
 ;;^UTILITY(U,$J,358.3,9615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9615,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,9615,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,9615,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,9616,0)
 ;;=G47.10^^65^627^6
 ;;^UTILITY(U,$J,358.3,9616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9616,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,9616,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,9616,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,9617,0)
 ;;=G47.30^^65^627^11
 ;;^UTILITY(U,$J,358.3,9617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9617,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,9617,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,9617,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,9618,0)
 ;;=R20.0^^65^627^2
 ;;^UTILITY(U,$J,358.3,9618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9618,1,3,0)
 ;;=3^Anesthesia of Skin
 ;;^UTILITY(U,$J,358.3,9618,1,4,0)
 ;;=4^R20.0
 ;;^UTILITY(U,$J,358.3,9618,2)
 ;;=^5019278
 ;;^UTILITY(U,$J,358.3,9619,0)
 ;;=90471^^66^628^1^^^^1
 ;;^UTILITY(U,$J,358.3,9619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9619,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,9619,1,3,0)
 ;;=3^Immunization Administration (use w/ Vacs below)
 ;;^UTILITY(U,$J,358.3,9620,0)
 ;;=90472^^66^628^1.5^^^^1
 ;;^UTILITY(U,$J,358.3,9620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9620,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,9620,1,3,0)
 ;;=3^2 or more Immunization Administration (use w/ Vacs below)
 ;;^UTILITY(U,$J,358.3,9621,0)
 ;;=90632^^66^628^5^^^^1
 ;;^UTILITY(U,$J,358.3,9621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9621,1,2,0)
 ;;=2^90632
 ;;^UTILITY(U,$J,358.3,9621,1,3,0)
 ;;=3^Hepatitis A Vaccine
