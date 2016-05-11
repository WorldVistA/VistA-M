IBDEI1GM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24797,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,24797,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,24798,0)
 ;;=Z64.1^^93^1111^3
 ;;^UTILITY(U,$J,358.3,24798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24798,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,24798,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,24798,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,24799,0)
 ;;=Z64.4^^93^1111^1
 ;;^UTILITY(U,$J,358.3,24799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24799,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,24799,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,24799,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,24800,0)
 ;;=Z65.5^^93^1111^2
 ;;^UTILITY(U,$J,358.3,24800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24800,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,24800,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,24800,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,24801,0)
 ;;=Z62.820^^93^1112^4
 ;;^UTILITY(U,$J,358.3,24801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24801,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,24801,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,24801,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,24802,0)
 ;;=Z62.891^^93^1112^6
 ;;^UTILITY(U,$J,358.3,24802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24802,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,24802,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,24802,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,24803,0)
 ;;=Z62.898^^93^1112^1
 ;;^UTILITY(U,$J,358.3,24803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24803,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,24803,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,24803,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,24804,0)
 ;;=Z63.0^^93^1112^5
 ;;^UTILITY(U,$J,358.3,24804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24804,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,24804,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,24804,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,24805,0)
 ;;=Z63.5^^93^1112^2
 ;;^UTILITY(U,$J,358.3,24805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24805,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,24805,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,24805,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,24806,0)
 ;;=Z63.8^^93^1112^3
 ;;^UTILITY(U,$J,358.3,24806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24806,1,3,0)
 ;;=3^High Exporessed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,24806,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,24806,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,24807,0)
 ;;=Z63.4^^93^1112^7
 ;;^UTILITY(U,$J,358.3,24807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24807,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,24807,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,24807,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,24808,0)
 ;;=F20.9^^93^1113^5
 ;;^UTILITY(U,$J,358.3,24808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24808,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,24808,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,24808,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,24809,0)
 ;;=F20.81^^93^1113^8
 ;;^UTILITY(U,$J,358.3,24809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24809,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,24809,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,24809,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,24810,0)
 ;;=F22.^^93^1113^2
 ;;^UTILITY(U,$J,358.3,24810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24810,1,3,0)
 ;;=3^Delusional Disorder
