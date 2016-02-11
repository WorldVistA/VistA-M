IBDEI1F0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23620,1,3,0)
 ;;=3^Cannabis dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,23620,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,23620,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,23621,0)
 ;;=F14.10^^113^1142^6
 ;;^UTILITY(U,$J,358.3,23621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23621,1,3,0)
 ;;=3^Cocaine abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,23621,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,23621,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,23622,0)
 ;;=F14.20^^113^1142^7
 ;;^UTILITY(U,$J,358.3,23622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23622,1,3,0)
 ;;=3^Cocaine dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,23622,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,23622,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,23623,0)
 ;;=F16.10^^113^1142^8
 ;;^UTILITY(U,$J,358.3,23623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23623,1,3,0)
 ;;=3^Hallucinogen abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,23623,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,23623,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,23624,0)
 ;;=F16.20^^113^1142^9
 ;;^UTILITY(U,$J,358.3,23624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23624,1,3,0)
 ;;=3^Hallucinogen dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,23624,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,23624,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,23625,0)
 ;;=F18.10^^113^1142^10
 ;;^UTILITY(U,$J,358.3,23625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23625,1,3,0)
 ;;=3^Inhalant abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,23625,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,23625,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,23626,0)
 ;;=F17.200^^113^1142^11
 ;;^UTILITY(U,$J,358.3,23626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23626,1,3,0)
 ;;=3^Nicotine dependence, unspec, uncomp
 ;;^UTILITY(U,$J,358.3,23626,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,23626,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,23627,0)
 ;;=F11.10^^113^1142^12
 ;;^UTILITY(U,$J,358.3,23627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23627,1,3,0)
 ;;=3^Opioid abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,23627,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,23627,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,23628,0)
 ;;=F11.20^^113^1142^13
 ;;^UTILITY(U,$J,358.3,23628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23628,1,3,0)
 ;;=3^Opioid dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,23628,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,23628,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,23629,0)
 ;;=F13.10^^113^1142^16
 ;;^UTILITY(U,$J,358.3,23629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23629,1,3,0)
 ;;=3^Sedative, hypnotic or anxiolytic abuse, uncomp
 ;;^UTILITY(U,$J,358.3,23629,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,23629,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,23630,0)
 ;;=F13.20^^113^1142^17
 ;;^UTILITY(U,$J,358.3,23630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23630,1,3,0)
 ;;=3^Sedative, hypnotic or anxiolytic dependence, uncomp
 ;;^UTILITY(U,$J,358.3,23630,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,23630,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,23631,0)
 ;;=F19.20^^113^1142^15
 ;;^UTILITY(U,$J,358.3,23631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23631,1,3,0)
 ;;=3^Psychoactive Substance Dependence,Uncomp
 ;;^UTILITY(U,$J,358.3,23631,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,23631,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,23632,0)
 ;;=F15.10^^113^1142^18
 ;;^UTILITY(U,$J,358.3,23632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23632,1,3,0)
 ;;=3^Stimulant Abuse,Uncomp
 ;;^UTILITY(U,$J,358.3,23632,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,23632,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,23633,0)
 ;;=F15.20^^113^1142^19
