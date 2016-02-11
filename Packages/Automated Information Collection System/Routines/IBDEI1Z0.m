IBDEI1Z0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32997,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,32997,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,32998,0)
 ;;=F60.6^^146^1600^2
 ;;^UTILITY(U,$J,358.3,32998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32998,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,32998,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,32998,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,32999,0)
 ;;=F60.3^^146^1600^3
 ;;^UTILITY(U,$J,358.3,32999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32999,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,32999,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,32999,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,33000,0)
 ;;=F60.89^^146^1600^9
 ;;^UTILITY(U,$J,358.3,33000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33000,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,33000,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,33000,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,33001,0)
 ;;=F60.9^^146^1600^10
 ;;^UTILITY(U,$J,358.3,33001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33001,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33001,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,33001,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,33002,0)
 ;;=Z65.4^^146^1601^4
 ;;^UTILITY(U,$J,358.3,33002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33002,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,33002,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,33002,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,33003,0)
 ;;=Z65.0^^146^1601^1
 ;;^UTILITY(U,$J,358.3,33003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33003,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,33003,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,33003,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,33004,0)
 ;;=Z65.2^^146^1601^3
 ;;^UTILITY(U,$J,358.3,33004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33004,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,33004,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,33004,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,33005,0)
 ;;=Z65.3^^146^1601^2
 ;;^UTILITY(U,$J,358.3,33005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33005,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,33005,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,33005,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,33006,0)
 ;;=Z65.8^^146^1602^5
 ;;^UTILITY(U,$J,358.3,33006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33006,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,33006,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,33006,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,33007,0)
 ;;=Z64.0^^146^1602^4
 ;;^UTILITY(U,$J,358.3,33007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33007,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,33007,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,33007,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,33008,0)
 ;;=Z64.1^^146^1602^3
 ;;^UTILITY(U,$J,358.3,33008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33008,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,33008,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,33008,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,33009,0)
 ;;=Z64.4^^146^1602^1
 ;;^UTILITY(U,$J,358.3,33009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33009,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,33009,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,33009,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,33010,0)
 ;;=Z65.5^^146^1602^2
