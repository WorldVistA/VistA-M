IBDEI052 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4797,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Respiratory System
 ;;^UTILITY(U,$J,358.3,4797,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,4797,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,4798,0)
 ;;=K91.72^^30^324^1
 ;;^UTILITY(U,$J,358.3,4798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4798,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Digestive System During Surgery
 ;;^UTILITY(U,$J,358.3,4798,1,4,0)
 ;;=4^K91.72
 ;;^UTILITY(U,$J,358.3,4798,2)
 ;;=^5008906
 ;;^UTILITY(U,$J,358.3,4799,0)
 ;;=E36.12^^30^324^2
 ;;^UTILITY(U,$J,358.3,4799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4799,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Endocrine System During Surgery
 ;;^UTILITY(U,$J,358.3,4799,1,4,0)
 ;;=4^E36.12
 ;;^UTILITY(U,$J,358.3,4799,2)
 ;;=^5002782
 ;;^UTILITY(U,$J,358.3,4800,0)
 ;;=H59.221^^30^324^9
 ;;^UTILITY(U,$J,358.3,4800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4800,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Right Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,4800,1,4,0)
 ;;=4^H59.221
 ;;^UTILITY(U,$J,358.3,4800,2)
 ;;=^5006413
 ;;^UTILITY(U,$J,358.3,4801,0)
 ;;=H59.222^^30^324^5
 ;;^UTILITY(U,$J,358.3,4801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4801,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Left Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,4801,1,4,0)
 ;;=4^H59.222
 ;;^UTILITY(U,$J,358.3,4801,2)
 ;;=^5006414
 ;;^UTILITY(U,$J,358.3,4802,0)
 ;;=N99.72^^30^324^4
 ;;^UTILITY(U,$J,358.3,4802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4802,1,3,0)
 ;;=3^Accidental Puncture/Laceration of GU System
 ;;^UTILITY(U,$J,358.3,4802,1,4,0)
 ;;=4^N99.72
 ;;^UTILITY(U,$J,358.3,4802,2)
 ;;=^5015966
 ;;^UTILITY(U,$J,358.3,4803,0)
 ;;=M96.821^^30^324^6
 ;;^UTILITY(U,$J,358.3,4803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4803,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Musculoskeletal System
 ;;^UTILITY(U,$J,358.3,4803,1,4,0)
 ;;=4^M96.821
 ;;^UTILITY(U,$J,358.3,4803,2)
 ;;=^5015396
 ;;^UTILITY(U,$J,358.3,4804,0)
 ;;=G97.49^^30^324^7
 ;;^UTILITY(U,$J,358.3,4804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4804,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Nervous System During Surgery
 ;;^UTILITY(U,$J,358.3,4804,1,4,0)
 ;;=4^G97.49
 ;;^UTILITY(U,$J,358.3,4804,2)
 ;;=^5004208
 ;;^UTILITY(U,$J,358.3,4805,0)
 ;;=J95.72^^30^324^8
 ;;^UTILITY(U,$J,358.3,4805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4805,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Respiratory System During Surgery
 ;;^UTILITY(U,$J,358.3,4805,1,4,0)
 ;;=4^J95.72
 ;;^UTILITY(U,$J,358.3,4805,2)
 ;;=^5008335
 ;;^UTILITY(U,$J,358.3,4806,0)
 ;;=L76.12^^30^324^10
 ;;^UTILITY(U,$J,358.3,4806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4806,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Skin During Surgery
 ;;^UTILITY(U,$J,358.3,4806,1,4,0)
 ;;=4^L76.12
 ;;^UTILITY(U,$J,358.3,4806,2)
 ;;=^5009305
 ;;^UTILITY(U,$J,358.3,4807,0)
 ;;=I97.88^^30^324^15
 ;;^UTILITY(U,$J,358.3,4807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4807,1,3,0)
 ;;=3^Intraoperative Complication of the Circulatory System NEC
 ;;^UTILITY(U,$J,358.3,4807,1,4,0)
 ;;=4^I97.88
 ;;^UTILITY(U,$J,358.3,4807,2)
 ;;=^5008111
 ;;^UTILITY(U,$J,358.3,4808,0)
 ;;=K91.81^^30^324^16
 ;;^UTILITY(U,$J,358.3,4808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4808,1,3,0)
 ;;=3^Intraoperative Complication of the Digestive System NEC
 ;;^UTILITY(U,$J,358.3,4808,1,4,0)
 ;;=4^K91.81
 ;;^UTILITY(U,$J,358.3,4808,2)
 ;;=^5008907
 ;;^UTILITY(U,$J,358.3,4809,0)
 ;;=H95.88^^30^324^17
 ;;^UTILITY(U,$J,358.3,4809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4809,1,3,0)
 ;;=3^Intraoperative Complication of the Ear/Mastoid NEC
 ;;^UTILITY(U,$J,358.3,4809,1,4,0)
 ;;=4^H95.88
 ;;^UTILITY(U,$J,358.3,4809,2)
 ;;=^5007036
 ;;^UTILITY(U,$J,358.3,4810,0)
 ;;=N99.81^^30^324^18
 ;;^UTILITY(U,$J,358.3,4810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4810,1,3,0)
 ;;=3^Intraoperative Complication of the GU System NEC
 ;;^UTILITY(U,$J,358.3,4810,1,4,0)
 ;;=4^N99.81
 ;;^UTILITY(U,$J,358.3,4810,2)
 ;;=^5015967
 ;;^UTILITY(U,$J,358.3,4811,0)
 ;;=M96.89^^30^324^19
 ;;^UTILITY(U,$J,358.3,4811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4811,1,3,0)
 ;;=3^Intraoperative Complication of the Musculoskeletal System NEC
 ;;^UTILITY(U,$J,358.3,4811,1,4,0)
 ;;=4^M96.89
 ;;^UTILITY(U,$J,358.3,4811,2)
 ;;=^5015399
 ;;^UTILITY(U,$J,358.3,4812,0)
 ;;=G97.81^^30^324^20
 ;;^UTILITY(U,$J,358.3,4812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4812,1,3,0)
 ;;=3^Intraoperative Complication of the Nervous System
 ;;^UTILITY(U,$J,358.3,4812,1,4,0)
 ;;=4^G97.81
 ;;^UTILITY(U,$J,358.3,4812,2)
 ;;=^5004211
 ;;^UTILITY(U,$J,358.3,4813,0)
 ;;=J95.88^^30^324^21
 ;;^UTILITY(U,$J,358.3,4813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4813,1,3,0)
 ;;=3^Intraoperative Complication of the Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,4813,1,4,0)
 ;;=4^J95.88
 ;;^UTILITY(U,$J,358.3,4813,2)
 ;;=^5008345
 ;;^UTILITY(U,$J,358.3,4814,0)
 ;;=L76.81^^30^324^22
 ;;^UTILITY(U,$J,358.3,4814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4814,1,3,0)
 ;;=3^Intraoperative Complication of the Skin NEC
 ;;^UTILITY(U,$J,358.3,4814,1,4,0)
 ;;=4^L76.81
 ;;^UTILITY(U,$J,358.3,4814,2)
 ;;=^5009308
 ;;^UTILITY(U,$J,358.3,4815,0)
 ;;=D78.81^^30^324^23
 ;;^UTILITY(U,$J,358.3,4815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4815,1,3,0)
 ;;=3^Intraoperative Complication of the Spleen
 ;;^UTILITY(U,$J,358.3,4815,1,4,0)
 ;;=4^D78.81
 ;;^UTILITY(U,$J,358.3,4815,2)
 ;;=^5002403
 ;;^UTILITY(U,$J,358.3,4816,0)
 ;;=H59.229^^30^324^3
 ;;^UTILITY(U,$J,358.3,4816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4816,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Eye/Adnexa,Unspec,During Surgery
 ;;^UTILITY(U,$J,358.3,4816,1,4,0)
 ;;=4^H59.229
 ;;^UTILITY(U,$J,358.3,4816,2)
 ;;=^5006416
 ;;^UTILITY(U,$J,358.3,4817,0)
 ;;=D78.12^^30^324^11
 ;;^UTILITY(U,$J,358.3,4817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4817,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Spleen During Surgery
 ;;^UTILITY(U,$J,358.3,4817,1,4,0)
 ;;=4^D78.12
 ;;^UTILITY(U,$J,358.3,4817,2)
 ;;=^5002400
 ;;^UTILITY(U,$J,358.3,4818,0)
 ;;=I97.811^^30^324^14
 ;;^UTILITY(U,$J,358.3,4818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4818,1,3,0)
 ;;=3^Intraoperative Cerebrovascular Infarction During Surgery
 ;;^UTILITY(U,$J,358.3,4818,1,4,0)
 ;;=4^I97.811
 ;;^UTILITY(U,$J,358.3,4818,2)
 ;;=^5008108
 ;;^UTILITY(U,$J,358.3,4819,0)
 ;;=S31.154A^^30^325^3
 ;;^UTILITY(U,$J,358.3,4819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4819,1,3,0)
 ;;=3^Open Bite of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,4819,1,4,0)
 ;;=4^S31.154A
 ;;^UTILITY(U,$J,358.3,4819,2)
 ;;=^5134487
 ;;^UTILITY(U,$J,358.3,4820,0)
 ;;=S31.151A^^30^325^4
 ;;^UTILITY(U,$J,358.3,4820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4820,1,3,0)
 ;;=3^Open Bite of LUQ of Abd Wall w/o Penet Perit Cav,Init Cav
 ;;^UTILITY(U,$J,358.3,4820,1,4,0)
 ;;=4^S31.151A
 ;;^UTILITY(U,$J,358.3,4820,2)
 ;;=^5024104
 ;;^UTILITY(U,$J,358.3,4821,0)
 ;;=S31.153A^^30^325^35
 ;;^UTILITY(U,$J,358.3,4821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4821,1,3,0)
 ;;=3^Open Bite of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,4821,1,4,0)
 ;;=4^S31.153A
 ;;^UTILITY(U,$J,358.3,4821,2)
 ;;=^5024110
 ;;^UTILITY(U,$J,358.3,4822,0)
 ;;=S31.150A^^30^325^36
 ;;^UTILITY(U,$J,358.3,4822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4822,1,3,0)
 ;;=3^Open Bite of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,4822,1,4,0)
 ;;=4^S31.150A
 ;;^UTILITY(U,$J,358.3,4822,2)
 ;;=^5024101
 ;;^UTILITY(U,$J,358.3,4823,0)
 ;;=S91.052A^^30^325^5
 ;;^UTILITY(U,$J,358.3,4823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4823,1,3,0)
 ;;=3^Open Bite of Left Ankle,Init Encntr
