IBDEI1FA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24186,0)
 ;;=Z62.898^^90^1057^1
 ;;^UTILITY(U,$J,358.3,24186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24186,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,24186,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,24186,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,24187,0)
 ;;=Z63.0^^90^1057^5
 ;;^UTILITY(U,$J,358.3,24187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24187,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,24187,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,24187,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,24188,0)
 ;;=Z63.5^^90^1057^2
 ;;^UTILITY(U,$J,358.3,24188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24188,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,24188,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,24188,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,24189,0)
 ;;=Z63.8^^90^1057^3
 ;;^UTILITY(U,$J,358.3,24189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24189,1,3,0)
 ;;=3^High Exporessed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,24189,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,24189,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,24190,0)
 ;;=Z63.4^^90^1057^7
 ;;^UTILITY(U,$J,358.3,24190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24190,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,24190,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,24190,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,24191,0)
 ;;=F20.9^^90^1058^5
 ;;^UTILITY(U,$J,358.3,24191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24191,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,24191,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,24191,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,24192,0)
 ;;=F20.81^^90^1058^8
 ;;^UTILITY(U,$J,358.3,24192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24192,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,24192,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,24192,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,24193,0)
 ;;=F22.^^90^1058^2
 ;;^UTILITY(U,$J,358.3,24193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24193,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,24193,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,24193,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,24194,0)
 ;;=F23.^^90^1058^1
 ;;^UTILITY(U,$J,358.3,24194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24194,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,24194,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,24194,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,24195,0)
 ;;=F25.0^^90^1058^3
 ;;^UTILITY(U,$J,358.3,24195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24195,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,24195,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,24195,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,24196,0)
 ;;=F25.1^^90^1058^4
 ;;^UTILITY(U,$J,358.3,24196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24196,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,24196,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,24196,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,24197,0)
 ;;=F28.^^90^1058^7
 ;;^UTILITY(U,$J,358.3,24197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24197,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,24197,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,24197,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,24198,0)
 ;;=F29.^^90^1058^6
 ;;^UTILITY(U,$J,358.3,24198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24198,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24198,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,24198,2)
 ;;=^5003484
