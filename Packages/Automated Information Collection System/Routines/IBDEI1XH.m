IBDEI1XH ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32282,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,32282,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,32283,0)
 ;;=T74.01XD^^143^1517^17
 ;;^UTILITY(U,$J,358.3,32283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32283,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,32283,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,32283,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,32284,0)
 ;;=T76.01XA^^143^1517^18
 ;;^UTILITY(U,$J,358.3,32284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32284,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,32284,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,32284,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,32285,0)
 ;;=T76.01XD^^143^1517^19
 ;;^UTILITY(U,$J,358.3,32285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32285,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,32285,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,32285,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,32286,0)
 ;;=Z91.412^^143^1517^7
 ;;^UTILITY(U,$J,358.3,32286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32286,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,32286,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,32286,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,32287,0)
 ;;=T74.31XA^^143^1517^20
 ;;^UTILITY(U,$J,358.3,32287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32287,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,32287,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,32287,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,32288,0)
 ;;=T74.31XD^^143^1517^21
 ;;^UTILITY(U,$J,358.3,32288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32288,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,32288,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,32288,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,32289,0)
 ;;=T76.31XA^^143^1517^22
 ;;^UTILITY(U,$J,358.3,32289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32289,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Initial Encnter
 ;;^UTILITY(U,$J,358.3,32289,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,32289,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,32290,0)
 ;;=T76.31XD^^143^1517^23
 ;;^UTILITY(U,$J,358.3,32290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32290,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,32290,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,32290,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,32291,0)
 ;;=Z91.411^^143^1517^6
 ;;^UTILITY(U,$J,358.3,32291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32291,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,32291,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,32291,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,32292,0)
 ;;=F06.4^^143^1518^6
 ;;^UTILITY(U,$J,358.3,32292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32292,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,32292,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,32292,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,32293,0)
 ;;=F41.0^^143^1518^14
 ;;^UTILITY(U,$J,358.3,32293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32293,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,32293,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,32293,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,32294,0)
 ;;=F41.1^^143^1518^12
