IBDEI1ZI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33232,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,33232,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,33233,0)
 ;;=T76.01XA^^148^1631^18
 ;;^UTILITY(U,$J,358.3,33233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33233,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,33233,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,33233,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,33234,0)
 ;;=T76.01XD^^148^1631^19
 ;;^UTILITY(U,$J,358.3,33234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33234,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,33234,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,33234,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,33235,0)
 ;;=Z91.412^^148^1631^7
 ;;^UTILITY(U,$J,358.3,33235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33235,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,33235,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,33235,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,33236,0)
 ;;=T74.31XA^^148^1631^20
 ;;^UTILITY(U,$J,358.3,33236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33236,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,33236,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,33236,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,33237,0)
 ;;=T74.31XD^^148^1631^21
 ;;^UTILITY(U,$J,358.3,33237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33237,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,33237,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,33237,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,33238,0)
 ;;=T76.31XA^^148^1631^22
 ;;^UTILITY(U,$J,358.3,33238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33238,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Initial Encnter
 ;;^UTILITY(U,$J,358.3,33238,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,33238,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,33239,0)
 ;;=T76.31XD^^148^1631^23
 ;;^UTILITY(U,$J,358.3,33239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33239,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,33239,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,33239,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,33240,0)
 ;;=Z91.411^^148^1631^6
 ;;^UTILITY(U,$J,358.3,33240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33240,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,33240,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,33240,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,33241,0)
 ;;=F06.4^^148^1632^6
 ;;^UTILITY(U,$J,358.3,33241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33241,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,33241,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,33241,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,33242,0)
 ;;=F41.0^^148^1632^14
 ;;^UTILITY(U,$J,358.3,33242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33242,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,33242,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,33242,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,33243,0)
 ;;=F41.1^^148^1632^12
 ;;^UTILITY(U,$J,358.3,33243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33243,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,33243,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,33243,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,33244,0)
 ;;=F41.9^^148^1632^5
 ;;^UTILITY(U,$J,358.3,33244,1,0)
 ;;=^358.31IA^4^2
