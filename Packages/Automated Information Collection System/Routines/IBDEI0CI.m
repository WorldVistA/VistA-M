IBDEI0CI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5727,1,3,0)
 ;;=3^PTSD,Unspec
 ;;^UTILITY(U,$J,358.3,5727,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,5727,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,5728,0)
 ;;=F43.11^^30^380^46
 ;;^UTILITY(U,$J,358.3,5728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5728,1,3,0)
 ;;=3^PTSD,Acute
 ;;^UTILITY(U,$J,358.3,5728,1,4,0)
 ;;=4^F43.11
 ;;^UTILITY(U,$J,358.3,5728,2)
 ;;=^5003571
 ;;^UTILITY(U,$J,358.3,5729,0)
 ;;=F43.12^^30^380^47
 ;;^UTILITY(U,$J,358.3,5729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5729,1,3,0)
 ;;=3^PTSD,Chronic
 ;;^UTILITY(U,$J,358.3,5729,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,5729,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,5730,0)
 ;;=I25.119^^30^380^5
 ;;^UTILITY(U,$J,358.3,5730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5730,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,5730,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,5730,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,5731,0)
 ;;=I25.10^^30^380^7
 ;;^UTILITY(U,$J,358.3,5731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5731,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,5731,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,5731,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,5732,0)
 ;;=I25.110^^30^380^6
 ;;^UTILITY(U,$J,358.3,5732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5732,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,5732,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,5732,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,5733,0)
 ;;=F17.219^^30^380^40
 ;;^UTILITY(U,$J,358.3,5733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5733,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes
 ;;^UTILITY(U,$J,358.3,5733,1,4,0)
 ;;=4^F17.219
 ;;^UTILITY(U,$J,358.3,5733,2)
 ;;=^5003369
 ;;^UTILITY(U,$J,358.3,5734,0)
 ;;=F17.299^^30^380^41
 ;;^UTILITY(U,$J,358.3,5734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5734,1,3,0)
 ;;=3^Nicotine Dependence,E-Cigarettes
 ;;^UTILITY(U,$J,358.3,5734,1,4,0)
 ;;=4^F17.299
 ;;^UTILITY(U,$J,358.3,5734,2)
 ;;=^5003379
 ;;^UTILITY(U,$J,358.3,5735,0)
 ;;=I25.810^^30^380^8
 ;;^UTILITY(U,$J,358.3,5735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5735,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5735,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,5735,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,5736,0)
 ;;=Z51.81^^30^381^17
 ;;^UTILITY(U,$J,358.3,5736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5736,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,5736,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,5736,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,5737,0)
 ;;=Z02.79^^30^381^11
 ;;^UTILITY(U,$J,358.3,5737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5737,1,3,0)
 ;;=3^Issue of Medical Certificate NEC
 ;;^UTILITY(U,$J,358.3,5737,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,5737,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,5738,0)
 ;;=Z76.0^^30^381^12
 ;;^UTILITY(U,$J,358.3,5738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5738,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,5738,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,5738,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,5739,0)
 ;;=Z04.9^^30^381^3
 ;;^UTILITY(U,$J,358.3,5739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5739,1,3,0)
 ;;=3^Exam & Observation for Unsp Reason
 ;;^UTILITY(U,$J,358.3,5739,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,5739,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,5740,0)
 ;;=Z02.2^^30^381^4
 ;;^UTILITY(U,$J,358.3,5740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5740,1,3,0)
 ;;=3^Exam for Admission to Residential Institution
