IBDEI1XY ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32499,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,32499,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,32500,0)
 ;;=F60.9^^143^1536^10
 ;;^UTILITY(U,$J,358.3,32500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32500,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32500,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,32500,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,32501,0)
 ;;=Z65.4^^143^1537^4
 ;;^UTILITY(U,$J,358.3,32501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32501,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,32501,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,32501,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,32502,0)
 ;;=Z65.0^^143^1537^1
 ;;^UTILITY(U,$J,358.3,32502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32502,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,32502,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,32502,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,32503,0)
 ;;=Z65.2^^143^1537^3
 ;;^UTILITY(U,$J,358.3,32503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32503,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,32503,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,32503,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,32504,0)
 ;;=Z65.3^^143^1537^2
 ;;^UTILITY(U,$J,358.3,32504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32504,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,32504,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,32504,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,32505,0)
 ;;=Z65.8^^143^1538^5
 ;;^UTILITY(U,$J,358.3,32505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32505,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,32505,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,32505,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,32506,0)
 ;;=Z64.0^^143^1538^4
 ;;^UTILITY(U,$J,358.3,32506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32506,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,32506,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,32506,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,32507,0)
 ;;=Z64.1^^143^1538^3
 ;;^UTILITY(U,$J,358.3,32507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32507,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,32507,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,32507,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,32508,0)
 ;;=Z64.4^^143^1538^1
 ;;^UTILITY(U,$J,358.3,32508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32508,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,32508,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,32508,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,32509,0)
 ;;=Z65.5^^143^1538^2
 ;;^UTILITY(U,$J,358.3,32509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32509,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,32509,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,32509,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,32510,0)
 ;;=Z62.820^^143^1539^4
 ;;^UTILITY(U,$J,358.3,32510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32510,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,32510,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,32510,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,32511,0)
 ;;=Z62.891^^143^1539^6
 ;;^UTILITY(U,$J,358.3,32511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32511,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,32511,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,32511,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,32512,0)
 ;;=Z62.898^^143^1539^1
