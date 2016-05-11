IBDEI1HX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25391,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,25391,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,25391,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,25392,0)
 ;;=Z62.898^^95^1161^1
 ;;^UTILITY(U,$J,358.3,25392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25392,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,25392,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,25392,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,25393,0)
 ;;=Z63.0^^95^1161^5
 ;;^UTILITY(U,$J,358.3,25393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25393,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,25393,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,25393,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,25394,0)
 ;;=Z63.5^^95^1161^2
 ;;^UTILITY(U,$J,358.3,25394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25394,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,25394,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,25394,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,25395,0)
 ;;=Z63.8^^95^1161^3
 ;;^UTILITY(U,$J,358.3,25395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25395,1,3,0)
 ;;=3^High Exporessed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,25395,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,25395,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,25396,0)
 ;;=Z63.4^^95^1161^7
 ;;^UTILITY(U,$J,358.3,25396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25396,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,25396,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,25396,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,25397,0)
 ;;=F20.9^^95^1162^5
 ;;^UTILITY(U,$J,358.3,25397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25397,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,25397,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,25397,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,25398,0)
 ;;=F20.81^^95^1162^8
 ;;^UTILITY(U,$J,358.3,25398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25398,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,25398,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,25398,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,25399,0)
 ;;=F22.^^95^1162^2
 ;;^UTILITY(U,$J,358.3,25399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25399,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,25399,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,25399,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,25400,0)
 ;;=F23.^^95^1162^1
 ;;^UTILITY(U,$J,358.3,25400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25400,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,25400,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,25400,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,25401,0)
 ;;=F25.0^^95^1162^3
 ;;^UTILITY(U,$J,358.3,25401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25401,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,25401,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,25401,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,25402,0)
 ;;=F25.1^^95^1162^4
 ;;^UTILITY(U,$J,358.3,25402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25402,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,25402,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,25402,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,25403,0)
 ;;=F28.^^95^1162^7
 ;;^UTILITY(U,$J,358.3,25403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25403,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25403,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,25403,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,25404,0)
 ;;=F29.^^95^1162^6
