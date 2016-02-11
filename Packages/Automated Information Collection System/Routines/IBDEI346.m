IBDEI346 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52270,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,52271,0)
 ;;=T76.01XD^^237^2588^19
 ;;^UTILITY(U,$J,358.3,52271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52271,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,52271,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,52271,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,52272,0)
 ;;=Z91.412^^237^2588^7
 ;;^UTILITY(U,$J,358.3,52272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52272,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,52272,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,52272,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,52273,0)
 ;;=T74.31XA^^237^2588^20
 ;;^UTILITY(U,$J,358.3,52273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52273,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,52273,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,52273,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,52274,0)
 ;;=T74.31XD^^237^2588^21
 ;;^UTILITY(U,$J,358.3,52274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52274,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,52274,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,52274,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,52275,0)
 ;;=T76.31XA^^237^2588^22
 ;;^UTILITY(U,$J,358.3,52275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52275,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Initial Encnter
 ;;^UTILITY(U,$J,358.3,52275,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,52275,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,52276,0)
 ;;=T76.31XD^^237^2588^23
 ;;^UTILITY(U,$J,358.3,52276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52276,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,52276,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,52276,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,52277,0)
 ;;=Z91.411^^237^2588^6
 ;;^UTILITY(U,$J,358.3,52277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52277,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,52277,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,52277,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,52278,0)
 ;;=F06.4^^237^2589^6
 ;;^UTILITY(U,$J,358.3,52278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52278,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,52278,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,52278,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,52279,0)
 ;;=F41.0^^237^2589^14
 ;;^UTILITY(U,$J,358.3,52279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52279,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,52279,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,52279,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,52280,0)
 ;;=F41.1^^237^2589^12
 ;;^UTILITY(U,$J,358.3,52280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52280,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,52280,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,52280,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,52281,0)
 ;;=F41.9^^237^2589^5
 ;;^UTILITY(U,$J,358.3,52281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52281,1,3,0)
 ;;=3^Anxiety Disorder NOS
 ;;^UTILITY(U,$J,358.3,52281,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,52281,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,52282,0)
 ;;=F40.02^^237^2589^2
 ;;^UTILITY(U,$J,358.3,52282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52282,1,3,0)
 ;;=3^Agoraphobia
 ;;^UTILITY(U,$J,358.3,52282,1,4,0)
 ;;=4^F40.02
