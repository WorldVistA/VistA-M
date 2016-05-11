IBDEI0X7 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15578,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,15578,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,15579,0)
 ;;=Z64.4^^58^679^1
 ;;^UTILITY(U,$J,358.3,15579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15579,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,15579,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,15579,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,15580,0)
 ;;=Z65.5^^58^679^2
 ;;^UTILITY(U,$J,358.3,15580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15580,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,15580,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,15580,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,15581,0)
 ;;=Z62.820^^58^680^4
 ;;^UTILITY(U,$J,358.3,15581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15581,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,15581,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,15581,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,15582,0)
 ;;=Z62.891^^58^680^6
 ;;^UTILITY(U,$J,358.3,15582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15582,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,15582,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,15582,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,15583,0)
 ;;=Z62.898^^58^680^1
 ;;^UTILITY(U,$J,358.3,15583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15583,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,15583,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,15583,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,15584,0)
 ;;=Z63.0^^58^680^5
 ;;^UTILITY(U,$J,358.3,15584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15584,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,15584,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,15584,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,15585,0)
 ;;=Z63.5^^58^680^2
 ;;^UTILITY(U,$J,358.3,15585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15585,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,15585,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,15585,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,15586,0)
 ;;=Z63.8^^58^680^3
 ;;^UTILITY(U,$J,358.3,15586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15586,1,3,0)
 ;;=3^High Exporessed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,15586,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,15586,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,15587,0)
 ;;=Z63.4^^58^680^7
 ;;^UTILITY(U,$J,358.3,15587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15587,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,15587,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,15587,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,15588,0)
 ;;=F20.9^^58^681^5
 ;;^UTILITY(U,$J,358.3,15588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15588,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,15588,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,15588,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,15589,0)
 ;;=F20.81^^58^681^8
 ;;^UTILITY(U,$J,358.3,15589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15589,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,15589,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,15589,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,15590,0)
 ;;=F22.^^58^681^2
 ;;^UTILITY(U,$J,358.3,15590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15590,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,15590,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,15590,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,15591,0)
 ;;=F23.^^58^681^1
 ;;^UTILITY(U,$J,358.3,15591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15591,1,3,0)
 ;;=3^Brief Psychotic Disorder
