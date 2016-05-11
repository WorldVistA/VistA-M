IBDEI01V ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,382,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,383,0)
 ;;=Z63.0^^3^45^5
 ;;^UTILITY(U,$J,358.3,383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,383,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,383,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,383,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,384,0)
 ;;=Z63.5^^3^45^2
 ;;^UTILITY(U,$J,358.3,384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,384,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,384,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,384,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,385,0)
 ;;=Z63.8^^3^45^3
 ;;^UTILITY(U,$J,358.3,385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,385,1,3,0)
 ;;=3^High Exporessed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,385,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,385,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,386,0)
 ;;=Z63.4^^3^45^7
 ;;^UTILITY(U,$J,358.3,386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,386,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,386,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,386,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,387,0)
 ;;=F20.9^^3^46^5
 ;;^UTILITY(U,$J,358.3,387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,387,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,387,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,387,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,388,0)
 ;;=F20.81^^3^46^8
 ;;^UTILITY(U,$J,358.3,388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,388,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,388,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,388,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,389,0)
 ;;=F22.^^3^46^2
 ;;^UTILITY(U,$J,358.3,389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,389,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,389,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,389,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,390,0)
 ;;=F23.^^3^46^1
 ;;^UTILITY(U,$J,358.3,390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,390,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,390,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,390,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,391,0)
 ;;=F25.0^^3^46^3
 ;;^UTILITY(U,$J,358.3,391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,391,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,391,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,391,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,392,0)
 ;;=F25.1^^3^46^4
 ;;^UTILITY(U,$J,358.3,392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,392,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,392,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,392,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,393,0)
 ;;=F28.^^3^46^7
 ;;^UTILITY(U,$J,358.3,393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,393,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,393,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,393,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,394,0)
 ;;=F29.^^3^46^6
 ;;^UTILITY(U,$J,358.3,394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,394,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,394,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,394,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,395,0)
 ;;=F52.32^^3^47^1
 ;;^UTILITY(U,$J,358.3,395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,395,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,395,1,4,0)
 ;;=4^F52.32
 ;;^UTILITY(U,$J,358.3,395,2)
 ;;=^331927
 ;;^UTILITY(U,$J,358.3,396,0)
 ;;=F52.21^^3^47^2
 ;;^UTILITY(U,$J,358.3,396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,396,1,3,0)
 ;;=3^Erectile Disorder
