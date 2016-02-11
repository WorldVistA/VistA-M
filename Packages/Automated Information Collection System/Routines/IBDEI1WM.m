IBDEI1WM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31889,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,31889,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,31890,0)
 ;;=T76.01XA^^141^1474^18
 ;;^UTILITY(U,$J,358.3,31890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31890,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,31890,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,31890,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,31891,0)
 ;;=T76.01XD^^141^1474^19
 ;;^UTILITY(U,$J,358.3,31891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31891,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,31891,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,31891,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,31892,0)
 ;;=Z91.412^^141^1474^7
 ;;^UTILITY(U,$J,358.3,31892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31892,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,31892,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,31892,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,31893,0)
 ;;=T74.31XA^^141^1474^20
 ;;^UTILITY(U,$J,358.3,31893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31893,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,31893,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,31893,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,31894,0)
 ;;=T74.31XD^^141^1474^21
 ;;^UTILITY(U,$J,358.3,31894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31894,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,31894,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,31894,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,31895,0)
 ;;=T76.31XA^^141^1474^22
 ;;^UTILITY(U,$J,358.3,31895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31895,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Initial Encnter
 ;;^UTILITY(U,$J,358.3,31895,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,31895,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,31896,0)
 ;;=T76.31XD^^141^1474^23
 ;;^UTILITY(U,$J,358.3,31896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31896,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,31896,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,31896,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,31897,0)
 ;;=Z91.411^^141^1474^6
 ;;^UTILITY(U,$J,358.3,31897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31897,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,31897,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,31897,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,31898,0)
 ;;=F06.4^^141^1475^6
 ;;^UTILITY(U,$J,358.3,31898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31898,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,31898,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,31898,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,31899,0)
 ;;=F41.0^^141^1475^14
 ;;^UTILITY(U,$J,358.3,31899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31899,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,31899,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,31899,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,31900,0)
 ;;=F41.1^^141^1475^12
 ;;^UTILITY(U,$J,358.3,31900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31900,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,31900,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,31900,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,31901,0)
 ;;=F41.9^^141^1475^5
 ;;^UTILITY(U,$J,358.3,31901,1,0)
 ;;=^358.31IA^4^2
