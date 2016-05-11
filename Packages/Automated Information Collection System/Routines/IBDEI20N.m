IBDEI20N ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34203,1,3,0)
 ;;=3^Bronchitis,Acute d/t Hemophilus Influenza
 ;;^UTILITY(U,$J,358.3,34203,1,4,0)
 ;;=4^J20.1
 ;;^UTILITY(U,$J,358.3,34203,2)
 ;;=^5008187
 ;;^UTILITY(U,$J,358.3,34204,0)
 ;;=J20.0^^131^1682^11
 ;;^UTILITY(U,$J,358.3,34204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34204,1,3,0)
 ;;=3^Bronchitis,Acute d/t Mycoplasma Pneumonia
 ;;^UTILITY(U,$J,358.3,34204,1,4,0)
 ;;=4^J20.0
 ;;^UTILITY(U,$J,358.3,34204,2)
 ;;=^5008186
 ;;^UTILITY(U,$J,358.3,34205,0)
 ;;=J20.2^^131^1682^6
 ;;^UTILITY(U,$J,358.3,34205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34205,1,3,0)
 ;;=3^Bonchitis,Acute d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,34205,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,34205,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,34206,0)
 ;;=J20.4^^131^1682^13
 ;;^UTILITY(U,$J,358.3,34206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34206,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,34206,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,34206,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,34207,0)
 ;;=J20.3^^131^1682^8
 ;;^UTILITY(U,$J,358.3,34207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34207,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,34207,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,34207,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,34208,0)
 ;;=J20.9^^131^1682^7
 ;;^UTILITY(U,$J,358.3,34208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34208,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,34208,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,34208,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,34209,0)
 ;;=J20.8^^131^1682^12
 ;;^UTILITY(U,$J,358.3,34209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34209,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,34209,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,34209,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,34210,0)
 ;;=J20.5^^131^1682^14
 ;;^UTILITY(U,$J,358.3,34210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34210,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,34210,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,34210,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,34211,0)
 ;;=J20.7^^131^1682^9
 ;;^UTILITY(U,$J,358.3,34211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34211,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,34211,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,34211,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,34212,0)
 ;;=J20.6^^131^1682^15
 ;;^UTILITY(U,$J,358.3,34212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34212,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,34212,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,34212,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,34213,0)
 ;;=J18.9^^131^1682^67
 ;;^UTILITY(U,$J,358.3,34213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34213,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,34213,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,34213,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,34214,0)
 ;;=J18.8^^131^1682^68
 ;;^UTILITY(U,$J,358.3,34214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34214,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,34214,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,34214,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,34215,0)
 ;;=J11.00^^131^1682^28
 ;;^UTILITY(U,$J,358.3,34215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34215,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,34215,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,34215,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,34216,0)
 ;;=J12.9^^131^1682^69
