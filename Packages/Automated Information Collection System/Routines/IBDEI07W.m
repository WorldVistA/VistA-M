IBDEI07W ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9986,1,3,0)
 ;;=3^Malig Neop Cervix Uteri
 ;;^UTILITY(U,$J,358.3,9986,1,4,0)
 ;;=4^C53.9
 ;;^UTILITY(U,$J,358.3,9986,2)
 ;;=^5001204
 ;;^UTILITY(U,$J,358.3,9987,0)
 ;;=C56.9^^37^540^14
 ;;^UTILITY(U,$J,358.3,9987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9987,1,3,0)
 ;;=3^Malig Neop Ovary,Unspec
 ;;^UTILITY(U,$J,358.3,9987,1,4,0)
 ;;=4^C56.9
 ;;^UTILITY(U,$J,358.3,9987,2)
 ;;=^5001214
 ;;^UTILITY(U,$J,358.3,9988,0)
 ;;=K64.8^^37^541^6
 ;;^UTILITY(U,$J,358.3,9988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9988,1,3,0)
 ;;=3^Hemorrhoids,Internal
 ;;^UTILITY(U,$J,358.3,9988,1,4,0)
 ;;=4^K64.8
 ;;^UTILITY(U,$J,358.3,9988,2)
 ;;=^5008774
 ;;^UTILITY(U,$J,358.3,9989,0)
 ;;=K64.9^^37^541^7
 ;;^UTILITY(U,$J,358.3,9989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9989,1,3,0)
 ;;=3^Hemorrhoids,Unspec
 ;;^UTILITY(U,$J,358.3,9989,1,4,0)
 ;;=4^K64.9
 ;;^UTILITY(U,$J,358.3,9989,2)
 ;;=^5008775
 ;;^UTILITY(U,$J,358.3,9990,0)
 ;;=K64.0^^37^541^1
 ;;^UTILITY(U,$J,358.3,9990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9990,1,3,0)
 ;;=3^First Degree Hemorrhoids
 ;;^UTILITY(U,$J,358.3,9990,1,4,0)
 ;;=4^K64.0
 ;;^UTILITY(U,$J,358.3,9990,2)
 ;;=^5008769
 ;;^UTILITY(U,$J,358.3,9991,0)
 ;;=K64.1^^37^541^2
 ;;^UTILITY(U,$J,358.3,9991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9991,1,3,0)
 ;;=3^Second Degree Hemorrhoids
 ;;^UTILITY(U,$J,358.3,9991,1,4,0)
 ;;=4^K64.1
 ;;^UTILITY(U,$J,358.3,9991,2)
 ;;=^5008770
 ;;^UTILITY(U,$J,358.3,9992,0)
 ;;=K64.2^^37^541^3
 ;;^UTILITY(U,$J,358.3,9992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9992,1,3,0)
 ;;=3^Third Degree Hemorrhoids
 ;;^UTILITY(U,$J,358.3,9992,1,4,0)
 ;;=4^K64.2
 ;;^UTILITY(U,$J,358.3,9992,2)
 ;;=^5008771
 ;;^UTILITY(U,$J,358.3,9993,0)
 ;;=K64.3^^37^541^4
 ;;^UTILITY(U,$J,358.3,9993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9993,1,3,0)
 ;;=3^Fourth Degree Hemorrhoids
 ;;^UTILITY(U,$J,358.3,9993,1,4,0)
 ;;=4^K64.3
 ;;^UTILITY(U,$J,358.3,9993,2)
 ;;=^5008772
 ;;^UTILITY(U,$J,358.3,9994,0)
 ;;=K64.4^^37^541^5
 ;;^UTILITY(U,$J,358.3,9994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9994,1,3,0)
 ;;=3^Hemorrhoids,External
 ;;^UTILITY(U,$J,358.3,9994,1,4,0)
 ;;=4^K64.4
 ;;^UTILITY(U,$J,358.3,9994,2)
 ;;=^269834
 ;;^UTILITY(U,$J,358.3,9995,0)
 ;;=K64.5^^37^541^8
 ;;^UTILITY(U,$J,358.3,9995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9995,1,3,0)
 ;;=3^Perianal venous thrombosis
 ;;^UTILITY(U,$J,358.3,9995,1,4,0)
 ;;=4^K64.5
 ;;^UTILITY(U,$J,358.3,9995,2)
 ;;=^5008773
 ;;^UTILITY(U,$J,358.3,9996,0)
 ;;=K61.0^^37^542^1
 ;;^UTILITY(U,$J,358.3,9996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9996,1,3,0)
 ;;=3^Anal Abscess
 ;;^UTILITY(U,$J,358.3,9996,1,4,0)
 ;;=4^K61.0
 ;;^UTILITY(U,$J,358.3,9996,2)
 ;;=^5008749
 ;;^UTILITY(U,$J,358.3,9997,0)
 ;;=K61.1^^37^542^5
 ;;^UTILITY(U,$J,358.3,9997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9997,1,3,0)
 ;;=3^Rectal Abscess
 ;;^UTILITY(U,$J,358.3,9997,1,4,0)
 ;;=4^K61.1
 ;;^UTILITY(U,$J,358.3,9997,2)
 ;;=^259588
 ;;^UTILITY(U,$J,358.3,9998,0)
 ;;=K61.3^^37^542^4
 ;;^UTILITY(U,$J,358.3,9998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9998,1,3,0)
 ;;=3^Ischiorectal Abscess
 ;;^UTILITY(U,$J,358.3,9998,1,4,0)
 ;;=4^K61.3
 ;;^UTILITY(U,$J,358.3,9998,2)
 ;;=^5008751
 ;;^UTILITY(U,$J,358.3,9999,0)
 ;;=K61.4^^37^542^3
 ;;^UTILITY(U,$J,358.3,9999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9999,1,3,0)
 ;;=3^Intrasphincteric Abscess
 ;;^UTILITY(U,$J,358.3,9999,1,4,0)
 ;;=4^K61.4
 ;;^UTILITY(U,$J,358.3,9999,2)
 ;;=^5008752
 ;;^UTILITY(U,$J,358.3,10000,0)
 ;;=K61.2^^37^542^2
 ;;^UTILITY(U,$J,358.3,10000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10000,1,3,0)
 ;;=3^Anorectal Abscess
 ;;^UTILITY(U,$J,358.3,10000,1,4,0)
 ;;=4^K61.2
 ;;^UTILITY(U,$J,358.3,10000,2)
 ;;=^5008750
 ;;^UTILITY(U,$J,358.3,10001,0)
 ;;=S09.12XA^^37^543^2
 ;;^UTILITY(U,$J,358.3,10001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10001,1,3,0)
 ;;=3^Laceration of Muscle/Tendon of Head,Init Encntr
 ;;^UTILITY(U,$J,358.3,10001,1,4,0)
 ;;=4^S09.12XA
 ;;^UTILITY(U,$J,358.3,10001,2)
 ;;=^5021287
 ;;^UTILITY(U,$J,358.3,10002,0)
 ;;=S16.2XXA^^37^543^1
 ;;^UTILITY(U,$J,358.3,10002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10002,1,3,0)
 ;;=3^Laceration of Muscle/Fascia/Tendon at Neck Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,10002,1,4,0)
 ;;=4^S16.2XXA
 ;;^UTILITY(U,$J,358.3,10002,2)
 ;;=^5022361
 ;;^UTILITY(U,$J,358.3,10003,0)
 ;;=S31.114A^^37^543^5
 ;;^UTILITY(U,$J,358.3,10003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10003,1,3,0)
 ;;=3^Laceration w/o FB of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,10003,1,4,0)
 ;;=4^S31.114A
 ;;^UTILITY(U,$J,358.3,10003,2)
 ;;=^5134427
 ;;^UTILITY(U,$J,358.3,10004,0)
 ;;=S31.111A^^37^543^6
 ;;^UTILITY(U,$J,358.3,10004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10004,1,3,0)
 ;;=3^Laceration w/o FB of LUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,10004,1,4,0)
 ;;=4^S31.111A
 ;;^UTILITY(U,$J,358.3,10004,2)
 ;;=^5024044
 ;;^UTILITY(U,$J,358.3,10005,0)
 ;;=S31.113A^^37^543^37
 ;;^UTILITY(U,$J,358.3,10005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10005,1,3,0)
 ;;=3^Laceration w/o FB of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,10005,1,4,0)
 ;;=4^S31.113A
 ;;^UTILITY(U,$J,358.3,10005,2)
 ;;=^5024050
 ;;^UTILITY(U,$J,358.3,10006,0)
 ;;=S31.110A^^37^543^38
 ;;^UTILITY(U,$J,358.3,10006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10006,1,3,0)
 ;;=3^Laceration w/o FB of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,10006,1,4,0)
 ;;=4^S31.110A
 ;;^UTILITY(U,$J,358.3,10006,2)
 ;;=^5024041
 ;;^UTILITY(U,$J,358.3,10007,0)
 ;;=S31.821A^^37^543^8
 ;;^UTILITY(U,$J,358.3,10007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10007,1,3,0)
 ;;=3^Laceration w/o FB of Left Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,10007,1,4,0)
 ;;=4^S31.821A
 ;;^UTILITY(U,$J,358.3,10007,2)
 ;;=^5024311
 ;;^UTILITY(U,$J,358.3,10008,0)
 ;;=S01.412A^^37^543^9
 ;;^UTILITY(U,$J,358.3,10008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10008,1,3,0)
 ;;=3^Laceration w/o FB of Left Cheek/TMJ Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,10008,1,4,0)
 ;;=4^S01.412A
 ;;^UTILITY(U,$J,358.3,10008,2)
 ;;=^5020156
 ;;^UTILITY(U,$J,358.3,10009,0)
 ;;=S01.312A^^37^543^10
 ;;^UTILITY(U,$J,358.3,10009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10009,1,3,0)
 ;;=3^Laceration w/o FB of Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,10009,1,4,0)
 ;;=4^S01.312A
 ;;^UTILITY(U,$J,358.3,10009,2)
 ;;=^5020117
 ;;^UTILITY(U,$J,358.3,10010,0)
 ;;=S51.012A^^37^543^11
 ;;^UTILITY(U,$J,358.3,10010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10010,1,3,0)
 ;;=3^Laceration w/o FB of Left Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,10010,1,4,0)
 ;;=4^S51.012A
 ;;^UTILITY(U,$J,358.3,10010,2)
 ;;=^5028629
 ;;^UTILITY(U,$J,358.3,10011,0)
 ;;=S91.212A^^37^543^13
 ;;^UTILITY(U,$J,358.3,10011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10011,1,3,0)
 ;;=3^Laceration w/o FB of Left Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10011,1,4,0)
 ;;=4^S91.212A
 ;;^UTILITY(U,$J,358.3,10011,2)
 ;;=^5044276
 ;;^UTILITY(U,$J,358.3,10012,0)
 ;;=S91.112A^^37^543^14
 ;;^UTILITY(U,$J,358.3,10012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10012,1,3,0)
 ;;=3^Laceration w/o FB of Left Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10012,1,4,0)
 ;;=4^S91.112A
 ;;^UTILITY(U,$J,358.3,10012,2)
 ;;=^5044186
 ;;^UTILITY(U,$J,358.3,10013,0)
 ;;=S61.412A^^37^543^15
 ;;^UTILITY(U,$J,358.3,10013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10013,1,3,0)
 ;;=3^Laceration w/o FB of Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,10013,1,4,0)
 ;;=4^S61.412A
 ;;^UTILITY(U,$J,358.3,10013,2)
 ;;=^5032990
 ;;^UTILITY(U,$J,358.3,10014,0)
 ;;=S61.311A^^37^543^17
 ;;^UTILITY(U,$J,358.3,10014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10014,1,3,0)
 ;;=3^Laceration w/o FB of Left Index Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10014,1,4,0)
 ;;=4^S61.311A
 ;;^UTILITY(U,$J,358.3,10014,2)
 ;;=^5032909
 ;;^UTILITY(U,$J,358.3,10015,0)
 ;;=S61.211A^^37^543^18
 ;;^UTILITY(U,$J,358.3,10015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10015,1,3,0)
 ;;=3^Laceration w/o FB of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10015,1,4,0)
 ;;=4^S61.211A
 ;;^UTILITY(U,$J,358.3,10015,2)
 ;;=^5032774
 ;;^UTILITY(U,$J,358.3,10016,0)
 ;;=S91.215A^^37^543^20
 ;;^UTILITY(U,$J,358.3,10016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10016,1,3,0)
 ;;=3^Laceration w/o FB of Left Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10016,1,4,0)
 ;;=4^S91.215A
 ;;^UTILITY(U,$J,358.3,10016,2)
 ;;=^5044282
 ;;^UTILITY(U,$J,358.3,10017,0)
 ;;=S91.115A^^37^543^21
 ;;^UTILITY(U,$J,358.3,10017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10017,1,3,0)
 ;;=3^Laceration w/o FB of Left Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10017,1,4,0)
 ;;=4^S91.115A
 ;;^UTILITY(U,$J,358.3,10017,2)
 ;;=^5044195
 ;;^UTILITY(U,$J,358.3,10018,0)
 ;;=S61.317A^^37^543^22
 ;;^UTILITY(U,$J,358.3,10018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10018,1,3,0)
 ;;=3^Laceration w/o FB of Left Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10018,1,4,0)
 ;;=4^S61.317A
 ;;^UTILITY(U,$J,358.3,10018,2)
 ;;=^5032927
 ;;^UTILITY(U,$J,358.3,10019,0)
 ;;=S61.217A^^37^543^23
 ;;^UTILITY(U,$J,358.3,10019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10019,1,3,0)
 ;;=3^Laceration w/o FB of Left Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10019,1,4,0)
 ;;=4^S61.217A
 ;;^UTILITY(U,$J,358.3,10019,2)
 ;;=^5032792
 ;;^UTILITY(U,$J,358.3,10020,0)
 ;;=S61.313A^^37^543^25
 ;;^UTILITY(U,$J,358.3,10020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10020,1,3,0)
 ;;=3^Laceration w/o FB of Left Middle Finger w/ Nail Damage,Init Encntr
