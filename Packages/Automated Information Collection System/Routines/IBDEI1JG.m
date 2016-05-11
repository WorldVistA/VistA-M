IBDEI1JG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26108,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,26108,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,26109,0)
 ;;=Z63.0^^98^1231^5
 ;;^UTILITY(U,$J,358.3,26109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26109,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,26109,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,26109,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,26110,0)
 ;;=Z63.5^^98^1231^2
 ;;^UTILITY(U,$J,358.3,26110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26110,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,26110,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,26110,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,26111,0)
 ;;=Z63.8^^98^1231^3
 ;;^UTILITY(U,$J,358.3,26111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26111,1,3,0)
 ;;=3^High Exporessed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,26111,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,26111,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,26112,0)
 ;;=Z63.4^^98^1231^7
 ;;^UTILITY(U,$J,358.3,26112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26112,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,26112,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,26112,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,26113,0)
 ;;=F20.9^^98^1232^5
 ;;^UTILITY(U,$J,358.3,26113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26113,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,26113,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,26113,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,26114,0)
 ;;=F20.81^^98^1232^8
 ;;^UTILITY(U,$J,358.3,26114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26114,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,26114,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,26114,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,26115,0)
 ;;=F22.^^98^1232^2
 ;;^UTILITY(U,$J,358.3,26115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26115,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,26115,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,26115,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,26116,0)
 ;;=F23.^^98^1232^1
 ;;^UTILITY(U,$J,358.3,26116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26116,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,26116,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,26116,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,26117,0)
 ;;=F25.0^^98^1232^3
 ;;^UTILITY(U,$J,358.3,26117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26117,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,26117,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,26117,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,26118,0)
 ;;=F25.1^^98^1232^4
 ;;^UTILITY(U,$J,358.3,26118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26118,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,26118,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,26118,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,26119,0)
 ;;=F28.^^98^1232^7
 ;;^UTILITY(U,$J,358.3,26119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26119,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,26119,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,26119,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,26120,0)
 ;;=F29.^^98^1232^6
 ;;^UTILITY(U,$J,358.3,26120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26120,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26120,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,26120,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,26121,0)
 ;;=F52.32^^98^1233^1
 ;;^UTILITY(U,$J,358.3,26121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26121,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,26121,1,4,0)
 ;;=4^F52.32
