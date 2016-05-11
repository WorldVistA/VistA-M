IBDEI2GC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41587,1,3,0)
 ;;=3^Bronchitis,Acute d/t Hemophilus Influenza
 ;;^UTILITY(U,$J,358.3,41587,1,4,0)
 ;;=4^J20.1
 ;;^UTILITY(U,$J,358.3,41587,2)
 ;;=^5008187
 ;;^UTILITY(U,$J,358.3,41588,0)
 ;;=J20.0^^159^2006^11
 ;;^UTILITY(U,$J,358.3,41588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41588,1,3,0)
 ;;=3^Bronchitis,Acute d/t Mycoplasma Pneumonia
 ;;^UTILITY(U,$J,358.3,41588,1,4,0)
 ;;=4^J20.0
 ;;^UTILITY(U,$J,358.3,41588,2)
 ;;=^5008186
 ;;^UTILITY(U,$J,358.3,41589,0)
 ;;=J20.2^^159^2006^6
 ;;^UTILITY(U,$J,358.3,41589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41589,1,3,0)
 ;;=3^Bonchitis,Acute d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,41589,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,41589,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,41590,0)
 ;;=J20.4^^159^2006^13
 ;;^UTILITY(U,$J,358.3,41590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41590,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,41590,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,41590,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,41591,0)
 ;;=J20.3^^159^2006^8
 ;;^UTILITY(U,$J,358.3,41591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41591,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,41591,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,41591,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,41592,0)
 ;;=J20.9^^159^2006^7
 ;;^UTILITY(U,$J,358.3,41592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41592,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,41592,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,41592,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,41593,0)
 ;;=J20.8^^159^2006^12
 ;;^UTILITY(U,$J,358.3,41593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41593,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,41593,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,41593,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,41594,0)
 ;;=J20.5^^159^2006^14
 ;;^UTILITY(U,$J,358.3,41594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41594,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,41594,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,41594,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,41595,0)
 ;;=J20.7^^159^2006^9
 ;;^UTILITY(U,$J,358.3,41595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41595,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,41595,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,41595,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,41596,0)
 ;;=J20.6^^159^2006^15
 ;;^UTILITY(U,$J,358.3,41596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41596,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,41596,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,41596,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,41597,0)
 ;;=J18.9^^159^2006^67
 ;;^UTILITY(U,$J,358.3,41597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41597,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,41597,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,41597,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,41598,0)
 ;;=J18.8^^159^2006^68
 ;;^UTILITY(U,$J,358.3,41598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41598,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,41598,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,41598,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,41599,0)
 ;;=J11.00^^159^2006^28
 ;;^UTILITY(U,$J,358.3,41599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41599,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,41599,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,41599,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,41600,0)
 ;;=J12.9^^159^2006^69
