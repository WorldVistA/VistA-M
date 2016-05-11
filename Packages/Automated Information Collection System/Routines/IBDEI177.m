IBDEI177 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20371,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,20372,0)
 ;;=J20.4^^84^931^13
 ;;^UTILITY(U,$J,358.3,20372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20372,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,20372,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,20372,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,20373,0)
 ;;=J20.3^^84^931^8
 ;;^UTILITY(U,$J,358.3,20373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20373,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,20373,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,20373,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,20374,0)
 ;;=J20.9^^84^931^7
 ;;^UTILITY(U,$J,358.3,20374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20374,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,20374,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,20374,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,20375,0)
 ;;=J20.8^^84^931^12
 ;;^UTILITY(U,$J,358.3,20375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20375,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,20375,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,20375,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,20376,0)
 ;;=J20.5^^84^931^14
 ;;^UTILITY(U,$J,358.3,20376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20376,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,20376,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,20376,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,20377,0)
 ;;=J20.7^^84^931^9
 ;;^UTILITY(U,$J,358.3,20377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20377,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,20377,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,20377,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,20378,0)
 ;;=J20.6^^84^931^15
 ;;^UTILITY(U,$J,358.3,20378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20378,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,20378,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,20378,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,20379,0)
 ;;=J18.9^^84^931^67
 ;;^UTILITY(U,$J,358.3,20379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20379,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,20379,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,20379,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,20380,0)
 ;;=J18.8^^84^931^68
 ;;^UTILITY(U,$J,358.3,20380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20380,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,20380,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,20380,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,20381,0)
 ;;=J11.00^^84^931^28
 ;;^UTILITY(U,$J,358.3,20381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20381,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,20381,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,20381,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,20382,0)
 ;;=J12.9^^84^931^69
 ;;^UTILITY(U,$J,358.3,20382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20382,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,20382,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,20382,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,20383,0)
 ;;=J10.08^^84^931^41
 ;;^UTILITY(U,$J,358.3,20383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20383,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,20383,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,20383,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,20384,0)
 ;;=J10.00^^84^931^40
 ;;^UTILITY(U,$J,358.3,20384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20384,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
