IBDEI11F ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16867,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,16867,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,16867,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,16868,0)
 ;;=J20.7^^61^777^9
 ;;^UTILITY(U,$J,358.3,16868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16868,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,16868,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,16868,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,16869,0)
 ;;=J20.6^^61^777^15
 ;;^UTILITY(U,$J,358.3,16869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16869,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,16869,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,16869,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,16870,0)
 ;;=J18.9^^61^777^71
 ;;^UTILITY(U,$J,358.3,16870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16870,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,16870,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,16870,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,16871,0)
 ;;=J18.8^^61^777^72
 ;;^UTILITY(U,$J,358.3,16871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16871,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,16871,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,16871,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,16872,0)
 ;;=J11.00^^61^777^31
 ;;^UTILITY(U,$J,358.3,16872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16872,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,16872,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,16872,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,16873,0)
 ;;=J12.9^^61^777^73
 ;;^UTILITY(U,$J,358.3,16873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16873,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,16873,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,16873,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,16874,0)
 ;;=J10.08^^61^777^44
 ;;^UTILITY(U,$J,358.3,16874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16874,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,16874,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,16874,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,16875,0)
 ;;=J10.00^^61^777^43
 ;;^UTILITY(U,$J,358.3,16875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16875,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,16875,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,16875,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,16876,0)
 ;;=J11.08^^61^777^46
 ;;^UTILITY(U,$J,358.3,16876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16876,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,16876,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,16876,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,16877,0)
 ;;=J10.1^^61^777^45
 ;;^UTILITY(U,$J,358.3,16877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16877,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,16877,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,16877,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,16878,0)
 ;;=J10.01^^61^777^42
 ;;^UTILITY(U,$J,358.3,16878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16878,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,16878,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,16878,2)
 ;;=^5008149
