IBDEI0EV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6848,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,6849,0)
 ;;=J20.1^^30^398^11
 ;;^UTILITY(U,$J,358.3,6849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6849,1,3,0)
 ;;=3^Bronchitis,Acute d/t Hemophilus Influenza
 ;;^UTILITY(U,$J,358.3,6849,1,4,0)
 ;;=4^J20.1
 ;;^UTILITY(U,$J,358.3,6849,2)
 ;;=^5008187
 ;;^UTILITY(U,$J,358.3,6850,0)
 ;;=J20.0^^30^398^12
 ;;^UTILITY(U,$J,358.3,6850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6850,1,3,0)
 ;;=3^Bronchitis,Acute d/t Mycoplasma Pneumonia
 ;;^UTILITY(U,$J,358.3,6850,1,4,0)
 ;;=4^J20.0
 ;;^UTILITY(U,$J,358.3,6850,2)
 ;;=^5008186
 ;;^UTILITY(U,$J,358.3,6851,0)
 ;;=J20.2^^30^398^7
 ;;^UTILITY(U,$J,358.3,6851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6851,1,3,0)
 ;;=3^Bonchitis,Acute d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,6851,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,6851,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,6852,0)
 ;;=J20.4^^30^398^14
 ;;^UTILITY(U,$J,358.3,6852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6852,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,6852,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,6852,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,6853,0)
 ;;=J20.3^^30^398^9
 ;;^UTILITY(U,$J,358.3,6853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6853,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,6853,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,6853,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,6854,0)
 ;;=J20.9^^30^398^8
 ;;^UTILITY(U,$J,358.3,6854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6854,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,6854,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,6854,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,6855,0)
 ;;=J20.8^^30^398^13
 ;;^UTILITY(U,$J,358.3,6855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6855,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,6855,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,6855,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,6856,0)
 ;;=J20.5^^30^398^15
 ;;^UTILITY(U,$J,358.3,6856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6856,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,6856,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,6856,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,6857,0)
 ;;=J20.7^^30^398^10
 ;;^UTILITY(U,$J,358.3,6857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6857,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,6857,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,6857,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,6858,0)
 ;;=J20.6^^30^398^16
 ;;^UTILITY(U,$J,358.3,6858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6858,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,6858,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,6858,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,6859,0)
 ;;=J18.9^^30^398^71
 ;;^UTILITY(U,$J,358.3,6859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6859,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,6859,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,6859,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,6860,0)
 ;;=J18.8^^30^398^72
 ;;^UTILITY(U,$J,358.3,6860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6860,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,6860,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,6860,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,6861,0)
 ;;=J11.00^^30^398^29
 ;;^UTILITY(U,$J,358.3,6861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6861,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,6861,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,6861,2)
 ;;=^5008156
