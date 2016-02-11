IBDEI15E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19176,0)
 ;;=J01.91^^94^918^76
 ;;^UTILITY(U,$J,358.3,19176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19176,1,3,0)
 ;;=3^Sinusitis,Acute Recurrent Unspec
 ;;^UTILITY(U,$J,358.3,19176,1,4,0)
 ;;=4^J01.91
 ;;^UTILITY(U,$J,358.3,19176,2)
 ;;=^5008128
 ;;^UTILITY(U,$J,358.3,19177,0)
 ;;=J03.90^^94^918^81
 ;;^UTILITY(U,$J,358.3,19177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19177,1,3,0)
 ;;=3^Tonsillitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,19177,1,4,0)
 ;;=4^J03.90
 ;;^UTILITY(U,$J,358.3,19177,2)
 ;;=^5008135
 ;;^UTILITY(U,$J,358.3,19178,0)
 ;;=J01.90^^94^918^77
 ;;^UTILITY(U,$J,358.3,19178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19178,1,3,0)
 ;;=3^Sinusitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,19178,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,19178,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,19179,0)
 ;;=J20.1^^94^918^10
 ;;^UTILITY(U,$J,358.3,19179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19179,1,3,0)
 ;;=3^Bronchitis,Acute d/t Hemophilus Influenza
 ;;^UTILITY(U,$J,358.3,19179,1,4,0)
 ;;=4^J20.1
 ;;^UTILITY(U,$J,358.3,19179,2)
 ;;=^5008187
 ;;^UTILITY(U,$J,358.3,19180,0)
 ;;=J20.0^^94^918^11
 ;;^UTILITY(U,$J,358.3,19180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19180,1,3,0)
 ;;=3^Bronchitis,Acute d/t Mycoplasma Pneumonia
 ;;^UTILITY(U,$J,358.3,19180,1,4,0)
 ;;=4^J20.0
 ;;^UTILITY(U,$J,358.3,19180,2)
 ;;=^5008186
 ;;^UTILITY(U,$J,358.3,19181,0)
 ;;=J20.2^^94^918^6
 ;;^UTILITY(U,$J,358.3,19181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19181,1,3,0)
 ;;=3^Bonchitis,Acute d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,19181,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,19181,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,19182,0)
 ;;=J20.4^^94^918^13
 ;;^UTILITY(U,$J,358.3,19182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19182,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,19182,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,19182,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,19183,0)
 ;;=J20.3^^94^918^8
 ;;^UTILITY(U,$J,358.3,19183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19183,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,19183,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,19183,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,19184,0)
 ;;=J20.9^^94^918^7
 ;;^UTILITY(U,$J,358.3,19184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19184,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,19184,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,19184,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,19185,0)
 ;;=J20.8^^94^918^12
 ;;^UTILITY(U,$J,358.3,19185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19185,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,19185,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,19185,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,19186,0)
 ;;=J20.5^^94^918^14
 ;;^UTILITY(U,$J,358.3,19186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19186,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,19186,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,19186,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,19187,0)
 ;;=J20.7^^94^918^9
 ;;^UTILITY(U,$J,358.3,19187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19187,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,19187,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,19187,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,19188,0)
 ;;=J20.6^^94^918^15
 ;;^UTILITY(U,$J,358.3,19188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19188,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,19188,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,19188,2)
 ;;=^5008192
