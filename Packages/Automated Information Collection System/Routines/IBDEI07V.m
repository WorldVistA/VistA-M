IBDEI07V ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7794,0)
 ;;=J01.91^^42^500^80
 ;;^UTILITY(U,$J,358.3,7794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7794,1,3,0)
 ;;=3^Sinusitis,Acute Recurrent Unspec
 ;;^UTILITY(U,$J,358.3,7794,1,4,0)
 ;;=4^J01.91
 ;;^UTILITY(U,$J,358.3,7794,2)
 ;;=^5008128
 ;;^UTILITY(U,$J,358.3,7795,0)
 ;;=J03.90^^42^500^85
 ;;^UTILITY(U,$J,358.3,7795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7795,1,3,0)
 ;;=3^Tonsillitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,7795,1,4,0)
 ;;=4^J03.90
 ;;^UTILITY(U,$J,358.3,7795,2)
 ;;=^5008135
 ;;^UTILITY(U,$J,358.3,7796,0)
 ;;=J01.90^^42^500^81
 ;;^UTILITY(U,$J,358.3,7796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7796,1,3,0)
 ;;=3^Sinusitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,7796,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,7796,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,7797,0)
 ;;=J20.1^^42^500^11
 ;;^UTILITY(U,$J,358.3,7797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7797,1,3,0)
 ;;=3^Bronchitis,Acute d/t Hemophilus Influenza
 ;;^UTILITY(U,$J,358.3,7797,1,4,0)
 ;;=4^J20.1
 ;;^UTILITY(U,$J,358.3,7797,2)
 ;;=^5008187
 ;;^UTILITY(U,$J,358.3,7798,0)
 ;;=J20.0^^42^500^12
 ;;^UTILITY(U,$J,358.3,7798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7798,1,3,0)
 ;;=3^Bronchitis,Acute d/t Mycoplasma Pneumonia
 ;;^UTILITY(U,$J,358.3,7798,1,4,0)
 ;;=4^J20.0
 ;;^UTILITY(U,$J,358.3,7798,2)
 ;;=^5008186
 ;;^UTILITY(U,$J,358.3,7799,0)
 ;;=J20.2^^42^500^7
 ;;^UTILITY(U,$J,358.3,7799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7799,1,3,0)
 ;;=3^Bonchitis,Acute d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,7799,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,7799,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,7800,0)
 ;;=J20.4^^42^500^14
 ;;^UTILITY(U,$J,358.3,7800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7800,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,7800,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,7800,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,7801,0)
 ;;=J20.3^^42^500^9
 ;;^UTILITY(U,$J,358.3,7801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7801,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,7801,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,7801,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,7802,0)
 ;;=J20.9^^42^500^8
 ;;^UTILITY(U,$J,358.3,7802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7802,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,7802,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,7802,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,7803,0)
 ;;=J20.8^^42^500^13
 ;;^UTILITY(U,$J,358.3,7803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7803,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,7803,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,7803,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,7804,0)
 ;;=J20.5^^42^500^15
 ;;^UTILITY(U,$J,358.3,7804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7804,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,7804,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,7804,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,7805,0)
 ;;=J20.7^^42^500^10
 ;;^UTILITY(U,$J,358.3,7805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7805,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,7805,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,7805,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,7806,0)
 ;;=J20.6^^42^500^16
 ;;^UTILITY(U,$J,358.3,7806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7806,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,7806,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,7806,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,7807,0)
 ;;=J18.9^^42^500^71
 ;;^UTILITY(U,$J,358.3,7807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7807,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,7807,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,7807,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,7808,0)
 ;;=J18.8^^42^500^72
 ;;^UTILITY(U,$J,358.3,7808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7808,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,7808,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,7808,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,7809,0)
 ;;=J11.00^^42^500^29
 ;;^UTILITY(U,$J,358.3,7809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7809,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,7809,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,7809,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,7810,0)
 ;;=J12.9^^42^500^73
 ;;^UTILITY(U,$J,358.3,7810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7810,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,7810,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,7810,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,7811,0)
 ;;=J10.08^^42^500^42
 ;;^UTILITY(U,$J,358.3,7811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7811,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,7811,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,7811,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,7812,0)
 ;;=J10.00^^42^500^41
 ;;^UTILITY(U,$J,358.3,7812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7812,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,7812,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,7812,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,7813,0)
 ;;=J11.08^^42^500^44
 ;;^UTILITY(U,$J,358.3,7813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7813,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,7813,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,7813,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,7814,0)
 ;;=J10.1^^42^500^43
 ;;^UTILITY(U,$J,358.3,7814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7814,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,7814,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,7814,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,7815,0)
 ;;=J10.01^^42^500^40
 ;;^UTILITY(U,$J,358.3,7815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7815,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,7815,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,7815,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,7816,0)
 ;;=J11.1^^42^500^45
 ;;^UTILITY(U,$J,358.3,7816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7816,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,7816,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,7816,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,7817,0)
 ;;=N12.^^42^500^89
 ;;^UTILITY(U,$J,358.3,7817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7817,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,7817,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,7817,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,7818,0)
 ;;=N11.9^^42^500^90
 ;;^UTILITY(U,$J,358.3,7818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7818,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,7818,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,7818,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,7819,0)
 ;;=N13.6^^42^500^77
 ;;^UTILITY(U,$J,358.3,7819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7819,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,7819,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,7819,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,7820,0)
 ;;=N30.91^^42^500^20
 ;;^UTILITY(U,$J,358.3,7820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7820,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,7820,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,7820,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,7821,0)
 ;;=N30.90^^42^500^21
 ;;^UTILITY(U,$J,358.3,7821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7821,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,7821,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,7821,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,7822,0)
 ;;=N41.9^^42^500^39
