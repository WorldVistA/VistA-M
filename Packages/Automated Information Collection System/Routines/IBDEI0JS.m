IBDEI0JS ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8901,1,4,0)
 ;;=4^J20.0
 ;;^UTILITY(U,$J,358.3,8901,2)
 ;;=^5008186
 ;;^UTILITY(U,$J,358.3,8902,0)
 ;;=J20.2^^39^403^6
 ;;^UTILITY(U,$J,358.3,8902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8902,1,3,0)
 ;;=3^Bonchitis,Acute d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,8902,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,8902,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,8903,0)
 ;;=J20.4^^39^403^13
 ;;^UTILITY(U,$J,358.3,8903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8903,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,8903,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,8903,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,8904,0)
 ;;=J20.3^^39^403^8
 ;;^UTILITY(U,$J,358.3,8904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8904,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,8904,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,8904,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,8905,0)
 ;;=J20.9^^39^403^7
 ;;^UTILITY(U,$J,358.3,8905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8905,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,8905,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,8905,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,8906,0)
 ;;=J20.8^^39^403^12
 ;;^UTILITY(U,$J,358.3,8906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8906,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,8906,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,8906,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,8907,0)
 ;;=J20.5^^39^403^14
 ;;^UTILITY(U,$J,358.3,8907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8907,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,8907,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,8907,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,8908,0)
 ;;=J20.7^^39^403^9
 ;;^UTILITY(U,$J,358.3,8908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8908,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,8908,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,8908,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,8909,0)
 ;;=J20.6^^39^403^15
 ;;^UTILITY(U,$J,358.3,8909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8909,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,8909,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,8909,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,8910,0)
 ;;=J18.9^^39^403^71
 ;;^UTILITY(U,$J,358.3,8910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8910,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,8910,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,8910,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,8911,0)
 ;;=J18.8^^39^403^72
 ;;^UTILITY(U,$J,358.3,8911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8911,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,8911,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,8911,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,8912,0)
 ;;=J11.00^^39^403^31
 ;;^UTILITY(U,$J,358.3,8912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8912,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,8912,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,8912,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,8913,0)
 ;;=J12.9^^39^403^73
 ;;^UTILITY(U,$J,358.3,8913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8913,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,8913,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,8913,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,8914,0)
 ;;=J10.08^^39^403^44
