IBDEI08G ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10669,1,3,0)
 ;;=3^Intraoperative Cerebrovascular Infarction During Surgery
 ;;^UTILITY(U,$J,358.3,10669,1,4,0)
 ;;=4^I97.811
 ;;^UTILITY(U,$J,358.3,10669,2)
 ;;=^5008108
 ;;^UTILITY(U,$J,358.3,10670,0)
 ;;=S31.154A^^37^559^3
 ;;^UTILITY(U,$J,358.3,10670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10670,1,3,0)
 ;;=3^Open Bite of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,10670,1,4,0)
 ;;=4^S31.154A
 ;;^UTILITY(U,$J,358.3,10670,2)
 ;;=^5134487
 ;;^UTILITY(U,$J,358.3,10671,0)
 ;;=S31.151A^^37^559^4
 ;;^UTILITY(U,$J,358.3,10671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10671,1,3,0)
 ;;=3^Open Bite of LUQ of Abd Wall w/o Penet Perit Cav,Init Cav
 ;;^UTILITY(U,$J,358.3,10671,1,4,0)
 ;;=4^S31.151A
 ;;^UTILITY(U,$J,358.3,10671,2)
 ;;=^5024104
 ;;^UTILITY(U,$J,358.3,10672,0)
 ;;=S31.153A^^37^559^35
 ;;^UTILITY(U,$J,358.3,10672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10672,1,3,0)
 ;;=3^Open Bite of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,10672,1,4,0)
 ;;=4^S31.153A
 ;;^UTILITY(U,$J,358.3,10672,2)
 ;;=^5024110
 ;;^UTILITY(U,$J,358.3,10673,0)
 ;;=S31.150A^^37^559^36
 ;;^UTILITY(U,$J,358.3,10673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10673,1,3,0)
 ;;=3^Open Bite of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,10673,1,4,0)
 ;;=4^S31.150A
 ;;^UTILITY(U,$J,358.3,10673,2)
 ;;=^5024101
 ;;^UTILITY(U,$J,358.3,10674,0)
 ;;=S91.052A^^37^559^5
 ;;^UTILITY(U,$J,358.3,10674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10674,1,3,0)
 ;;=3^Open Bite of Left Ankle,Init Encntr
 ;;^UTILITY(U,$J,358.3,10674,1,4,0)
 ;;=4^S91.052A
 ;;^UTILITY(U,$J,358.3,10674,2)
 ;;=^5044162
 ;;^UTILITY(U,$J,358.3,10675,0)
 ;;=S31.825A^^37^559^6
 ;;^UTILITY(U,$J,358.3,10675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10675,1,3,0)
 ;;=3^Open Bite of Left Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,10675,1,4,0)
 ;;=4^S31.825A
 ;;^UTILITY(U,$J,358.3,10675,2)
 ;;=^5024317
 ;;^UTILITY(U,$J,358.3,10676,0)
 ;;=S01.452A^^37^559^7
 ;;^UTILITY(U,$J,358.3,10676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10676,1,3,0)
 ;;=3^Open Bite of Left Cheek/Temporomandibular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,10676,1,4,0)
 ;;=4^S01.452A
 ;;^UTILITY(U,$J,358.3,10676,2)
 ;;=^5020180
 ;;^UTILITY(U,$J,358.3,10677,0)
 ;;=S01.352A^^37^559^8
 ;;^UTILITY(U,$J,358.3,10677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10677,1,3,0)
 ;;=3^Open Bite of Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,10677,1,4,0)
 ;;=4^S01.352A
 ;;^UTILITY(U,$J,358.3,10677,2)
 ;;=^5020141
 ;;^UTILITY(U,$J,358.3,10678,0)
 ;;=S51.052A^^37^559^9
 ;;^UTILITY(U,$J,358.3,10678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10678,1,3,0)
 ;;=3^Open Bite of Left Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,10678,1,4,0)
 ;;=4^S51.052A
 ;;^UTILITY(U,$J,358.3,10678,2)
 ;;=^5028653
 ;;^UTILITY(U,$J,358.3,10679,0)
 ;;=S91.352A^^37^559^10
 ;;^UTILITY(U,$J,358.3,10679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10679,1,3,0)
 ;;=3^Open Bite of Left Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,10679,1,4,0)
 ;;=4^S91.352A
 ;;^UTILITY(U,$J,358.3,10679,2)
 ;;=^5044347
 ;;^UTILITY(U,$J,358.3,10680,0)
 ;;=S91.252A^^37^559^11
 ;;^UTILITY(U,$J,358.3,10680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10680,1,3,0)
 ;;=3^Open Bite of Left Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10680,1,4,0)
 ;;=4^S91.252A
 ;;^UTILITY(U,$J,358.3,10680,2)
 ;;=^5137508
 ;;^UTILITY(U,$J,358.3,10681,0)
 ;;=S91.152A^^37^559^12
 ;;^UTILITY(U,$J,358.3,10681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10681,1,3,0)
 ;;=3^Open Bite of Left Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10681,1,4,0)
 ;;=4^S91.152A
 ;;^UTILITY(U,$J,358.3,10681,2)
 ;;=^5044246
 ;;^UTILITY(U,$J,358.3,10682,0)
 ;;=S61.452A^^37^559^13
 ;;^UTILITY(U,$J,358.3,10682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10682,1,3,0)
 ;;=3^Open Bite of Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,10682,1,4,0)
 ;;=4^S61.452A
 ;;^UTILITY(U,$J,358.3,10682,2)
 ;;=^5033014
 ;;^UTILITY(U,$J,358.3,10683,0)
 ;;=S71.052A^^37^559^14
 ;;^UTILITY(U,$J,358.3,10683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10683,1,3,0)
 ;;=3^Open Bite of Left Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,10683,1,4,0)
 ;;=4^S71.052A
 ;;^UTILITY(U,$J,358.3,10683,2)
 ;;=^5037002
 ;;^UTILITY(U,$J,358.3,10684,0)
 ;;=S61.351A^^37^559^16
 ;;^UTILITY(U,$J,358.3,10684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10684,1,3,0)
 ;;=3^Open Bite of Left Index finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10684,1,4,0)
 ;;=4^S61.351A
 ;;^UTILITY(U,$J,358.3,10684,2)
 ;;=^5135828
 ;;^UTILITY(U,$J,358.3,10685,0)
 ;;=S61.251A^^37^559^15
 ;;^UTILITY(U,$J,358.3,10685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10685,1,3,0)
 ;;=3^Open Bite of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10685,1,4,0)
 ;;=4^S61.251A
 ;;^UTILITY(U,$J,358.3,10685,2)
 ;;=^5032864
 ;;^UTILITY(U,$J,358.3,10686,0)
 ;;=S81.052A^^37^559^17
 ;;^UTILITY(U,$J,358.3,10686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10686,1,3,0)
 ;;=3^Open Bite of Left Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,10686,1,4,0)
 ;;=4^S81.052A
 ;;^UTILITY(U,$J,358.3,10686,2)
 ;;=^5040059
 ;;^UTILITY(U,$J,358.3,10687,0)
 ;;=S91.255A^^37^559^18
 ;;^UTILITY(U,$J,358.3,10687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10687,1,3,0)
 ;;=3^Open Bite of Left Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10687,1,4,0)
 ;;=4^S91.255A
 ;;^UTILITY(U,$J,358.3,10687,2)
 ;;=^5137514
 ;;^UTILITY(U,$J,358.3,10688,0)
 ;;=S91.155A^^37^559^19
 ;;^UTILITY(U,$J,358.3,10688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10688,1,3,0)
 ;;=3^Open Bite of Left Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10688,1,4,0)
 ;;=4^S91.155A
 ;;^UTILITY(U,$J,358.3,10688,2)
 ;;=^5044255
 ;;^UTILITY(U,$J,358.3,10689,0)
 ;;=S61.357A^^37^559^20
 ;;^UTILITY(U,$J,358.3,10689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10689,1,3,0)
 ;;=3^Open Bite of Left Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10689,1,4,0)
 ;;=4^S61.357A
 ;;^UTILITY(U,$J,358.3,10689,2)
 ;;=^5135837
 ;;^UTILITY(U,$J,358.3,10690,0)
 ;;=S61.257A^^37^559^21
 ;;^UTILITY(U,$J,358.3,10690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10690,1,3,0)
 ;;=3^Open Bite of Left Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10690,1,4,0)
 ;;=4^S61.257A
 ;;^UTILITY(U,$J,358.3,10690,2)
 ;;=^5032882
 ;;^UTILITY(U,$J,358.3,10691,0)
 ;;=S81.852A^^37^559^22
 ;;^UTILITY(U,$J,358.3,10691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10691,1,3,0)
 ;;=3^Open Bite of Left Lower Leg,Init Encntr
 ;;^UTILITY(U,$J,358.3,10691,1,4,0)
 ;;=4^S81.852A
 ;;^UTILITY(U,$J,358.3,10691,2)
 ;;=^5040098
 ;;^UTILITY(U,$J,358.3,10692,0)
 ;;=S61.353A^^37^559^23
 ;;^UTILITY(U,$J,358.3,10692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10692,1,3,0)
 ;;=3^Open Bite of Left Middle Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10692,1,4,0)
 ;;=4^S61.353A
 ;;^UTILITY(U,$J,358.3,10692,2)
 ;;=^5135831
 ;;^UTILITY(U,$J,358.3,10693,0)
 ;;=S61.253A^^37^559^24
 ;;^UTILITY(U,$J,358.3,10693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10693,1,3,0)
 ;;=3^Open Bite of Left Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10693,1,4,0)
 ;;=4^S61.253A
 ;;^UTILITY(U,$J,358.3,10693,2)
 ;;=^5032870
 ;;^UTILITY(U,$J,358.3,10694,0)
 ;;=S61.355A^^37^559^25
 ;;^UTILITY(U,$J,358.3,10694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10694,1,3,0)
 ;;=3^Open Bite of Left Ring Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10694,1,4,0)
 ;;=4^S61.355A
 ;;^UTILITY(U,$J,358.3,10694,2)
 ;;=^5135834
 ;;^UTILITY(U,$J,358.3,10695,0)
 ;;=S61.255A^^37^559^26
 ;;^UTILITY(U,$J,358.3,10695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10695,1,3,0)
 ;;=3^Open Bite of Left Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10695,1,4,0)
 ;;=4^S61.255A
 ;;^UTILITY(U,$J,358.3,10695,2)
 ;;=^5032876
 ;;^UTILITY(U,$J,358.3,10696,0)
 ;;=S41.052A^^37^559^27
 ;;^UTILITY(U,$J,358.3,10696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10696,1,3,0)
 ;;=3^Open Bite of Left Shoulder,Init Encntr
 ;;^UTILITY(U,$J,358.3,10696,1,4,0)
 ;;=4^S41.052A
 ;;^UTILITY(U,$J,358.3,10696,2)
 ;;=^5026324
 ;;^UTILITY(U,$J,358.3,10697,0)
 ;;=S71.152A^^37^559^28
 ;;^UTILITY(U,$J,358.3,10697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10697,1,3,0)
 ;;=3^Open Bite of Left Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,10697,1,4,0)
 ;;=4^S71.152A
 ;;^UTILITY(U,$J,358.3,10697,2)
 ;;=^5037041
 ;;^UTILITY(U,$J,358.3,10698,0)
 ;;=S61.152A^^37^559^29
 ;;^UTILITY(U,$J,358.3,10698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10698,1,3,0)
 ;;=3^Open Bite of Left Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10698,1,4,0)
 ;;=4^S61.152A
 ;;^UTILITY(U,$J,358.3,10698,2)
 ;;=^5135729
 ;;^UTILITY(U,$J,358.3,10699,0)
 ;;=S61.052A^^37^559^30
 ;;^UTILITY(U,$J,358.3,10699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10699,1,3,0)
 ;;=3^Open Bite of Left Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,10699,1,4,0)
 ;;=4^S61.052A
 ;;^UTILITY(U,$J,358.3,10699,2)
 ;;=^5032717
 ;;^UTILITY(U,$J,358.3,10700,0)
 ;;=S61.552A^^37^559^31
 ;;^UTILITY(U,$J,358.3,10700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10700,1,3,0)
 ;;=3^Open Bite of Left Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,10700,1,4,0)
 ;;=4^S61.552A
 ;;^UTILITY(U,$J,358.3,10700,2)
 ;;=^5033053
 ;;^UTILITY(U,$J,358.3,10701,0)
 ;;=S01.25XA^^37^559^34
 ;;^UTILITY(U,$J,358.3,10701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10701,1,3,0)
 ;;=3^Open Bite of Nose,Init Encntr
 ;;^UTILITY(U,$J,358.3,10701,1,4,0)
 ;;=4^S01.25XA
 ;;^UTILITY(U,$J,358.3,10701,2)
 ;;=^5020105
 ;;^UTILITY(U,$J,358.3,10702,0)
 ;;=S01.85XA^^37^559^1
 ;;^UTILITY(U,$J,358.3,10702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10702,1,3,0)
 ;;=3^Open Bite of Head,Oth Part,Init Encntr
