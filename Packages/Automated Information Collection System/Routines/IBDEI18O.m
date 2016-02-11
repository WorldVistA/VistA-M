IBDEI18O ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20721,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,20722,0)
 ;;=Z91.412^^99^981^7
 ;;^UTILITY(U,$J,358.3,20722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20722,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,20722,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,20722,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,20723,0)
 ;;=T74.31XA^^99^981^20
 ;;^UTILITY(U,$J,358.3,20723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20723,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,20723,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,20723,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,20724,0)
 ;;=T74.31XD^^99^981^21
 ;;^UTILITY(U,$J,358.3,20724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20724,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,20724,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,20724,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,20725,0)
 ;;=T76.31XA^^99^981^22
 ;;^UTILITY(U,$J,358.3,20725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20725,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Initial Encnter
 ;;^UTILITY(U,$J,358.3,20725,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,20725,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,20726,0)
 ;;=T76.31XD^^99^981^23
 ;;^UTILITY(U,$J,358.3,20726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20726,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,20726,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,20726,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,20727,0)
 ;;=Z91.411^^99^981^6
 ;;^UTILITY(U,$J,358.3,20727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20727,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,20727,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,20727,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,20728,0)
 ;;=F06.4^^99^982^6
 ;;^UTILITY(U,$J,358.3,20728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20728,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,20728,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,20728,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,20729,0)
 ;;=F41.0^^99^982^14
 ;;^UTILITY(U,$J,358.3,20729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20729,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,20729,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,20729,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,20730,0)
 ;;=F41.1^^99^982^12
 ;;^UTILITY(U,$J,358.3,20730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20730,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,20730,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,20730,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,20731,0)
 ;;=F41.9^^99^982^5
 ;;^UTILITY(U,$J,358.3,20731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20731,1,3,0)
 ;;=3^Anxiety Disorder NOS
 ;;^UTILITY(U,$J,358.3,20731,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,20731,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,20732,0)
 ;;=F40.02^^99^982^2
 ;;^UTILITY(U,$J,358.3,20732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20732,1,3,0)
 ;;=3^Agoraphobia
 ;;^UTILITY(U,$J,358.3,20732,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,20732,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,20733,0)
 ;;=F40.10^^99^982^16
 ;;^UTILITY(U,$J,358.3,20733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20733,1,3,0)
 ;;=3^Social Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,20733,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,20733,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,20734,0)
 ;;=F40.218^^99^982^4
