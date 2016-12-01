IBDEI03R ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4466,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Left Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,4466,1,4,0)
 ;;=4^H59.122
 ;;^UTILITY(U,$J,358.3,4466,2)
 ;;=^5006406
 ;;^UTILITY(U,$J,358.3,4467,0)
 ;;=H59.123^^20^284^24
 ;;^UTILITY(U,$J,358.3,4467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4467,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Bilateral Eyes/Adnexa
 ;;^UTILITY(U,$J,358.3,4467,1,4,0)
 ;;=4^H59.123
 ;;^UTILITY(U,$J,358.3,4467,2)
 ;;=^5006407
 ;;^UTILITY(U,$J,358.3,4468,0)
 ;;=N99.62^^20^284^32
 ;;^UTILITY(U,$J,358.3,4468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4468,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of GU System
 ;;^UTILITY(U,$J,358.3,4468,1,4,0)
 ;;=4^N99.62
 ;;^UTILITY(U,$J,358.3,4468,2)
 ;;=^5015964
 ;;^UTILITY(U,$J,358.3,4469,0)
 ;;=M96.811^^20^284^34
 ;;^UTILITY(U,$J,358.3,4469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4469,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Musculoskeletal System
 ;;^UTILITY(U,$J,358.3,4469,1,4,0)
 ;;=4^M96.811
 ;;^UTILITY(U,$J,358.3,4469,2)
 ;;=^5015394
 ;;^UTILITY(U,$J,358.3,4470,0)
 ;;=J95.62^^20^284^37
 ;;^UTILITY(U,$J,358.3,4470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4470,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Respiratory System
 ;;^UTILITY(U,$J,358.3,4470,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,4470,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,4471,0)
 ;;=K91.72^^20^284^1
 ;;^UTILITY(U,$J,358.3,4471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4471,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Digestive System During Surgery
 ;;^UTILITY(U,$J,358.3,4471,1,4,0)
 ;;=4^K91.72
 ;;^UTILITY(U,$J,358.3,4471,2)
 ;;=^5008906
 ;;^UTILITY(U,$J,358.3,4472,0)
 ;;=E36.12^^20^284^2
 ;;^UTILITY(U,$J,358.3,4472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4472,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Endocrine System During Surgery
 ;;^UTILITY(U,$J,358.3,4472,1,4,0)
 ;;=4^E36.12
 ;;^UTILITY(U,$J,358.3,4472,2)
 ;;=^5002782
 ;;^UTILITY(U,$J,358.3,4473,0)
 ;;=H59.221^^20^284^9
 ;;^UTILITY(U,$J,358.3,4473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4473,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Right Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,4473,1,4,0)
 ;;=4^H59.221
 ;;^UTILITY(U,$J,358.3,4473,2)
 ;;=^5006413
 ;;^UTILITY(U,$J,358.3,4474,0)
 ;;=H59.222^^20^284^5
 ;;^UTILITY(U,$J,358.3,4474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4474,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Left Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,4474,1,4,0)
 ;;=4^H59.222
 ;;^UTILITY(U,$J,358.3,4474,2)
 ;;=^5006414
 ;;^UTILITY(U,$J,358.3,4475,0)
 ;;=N99.72^^20^284^4
 ;;^UTILITY(U,$J,358.3,4475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4475,1,3,0)
 ;;=3^Accidental Puncture/Laceration of GU System
 ;;^UTILITY(U,$J,358.3,4475,1,4,0)
 ;;=4^N99.72
 ;;^UTILITY(U,$J,358.3,4475,2)
 ;;=^5015966
 ;;^UTILITY(U,$J,358.3,4476,0)
 ;;=M96.821^^20^284^6
 ;;^UTILITY(U,$J,358.3,4476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4476,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Musculoskeletal System
 ;;^UTILITY(U,$J,358.3,4476,1,4,0)
 ;;=4^M96.821
 ;;^UTILITY(U,$J,358.3,4476,2)
 ;;=^5015396
 ;;^UTILITY(U,$J,358.3,4477,0)
 ;;=G97.49^^20^284^7
 ;;^UTILITY(U,$J,358.3,4477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4477,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Nervous System During Surgery
 ;;^UTILITY(U,$J,358.3,4477,1,4,0)
 ;;=4^G97.49
 ;;^UTILITY(U,$J,358.3,4477,2)
 ;;=^5004208
 ;;^UTILITY(U,$J,358.3,4478,0)
 ;;=J95.72^^20^284^8
 ;;^UTILITY(U,$J,358.3,4478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4478,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Respiratory System During Surgery
 ;;^UTILITY(U,$J,358.3,4478,1,4,0)
 ;;=4^J95.72
 ;;^UTILITY(U,$J,358.3,4478,2)
 ;;=^5008335
 ;;^UTILITY(U,$J,358.3,4479,0)
 ;;=L76.12^^20^284^10
 ;;^UTILITY(U,$J,358.3,4479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4479,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Skin During Surgery
 ;;^UTILITY(U,$J,358.3,4479,1,4,0)
 ;;=4^L76.12
 ;;^UTILITY(U,$J,358.3,4479,2)
 ;;=^5009305
 ;;^UTILITY(U,$J,358.3,4480,0)
 ;;=I97.88^^20^284^15
 ;;^UTILITY(U,$J,358.3,4480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4480,1,3,0)
 ;;=3^Intraoperative Complication of the Circulatory System NEC
 ;;^UTILITY(U,$J,358.3,4480,1,4,0)
 ;;=4^I97.88
 ;;^UTILITY(U,$J,358.3,4480,2)
 ;;=^5008111
 ;;^UTILITY(U,$J,358.3,4481,0)
 ;;=K91.81^^20^284^16
 ;;^UTILITY(U,$J,358.3,4481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4481,1,3,0)
 ;;=3^Intraoperative Complication of the Digestive System NEC
 ;;^UTILITY(U,$J,358.3,4481,1,4,0)
 ;;=4^K91.81
 ;;^UTILITY(U,$J,358.3,4481,2)
 ;;=^5008907
 ;;^UTILITY(U,$J,358.3,4482,0)
 ;;=H95.88^^20^284^17
 ;;^UTILITY(U,$J,358.3,4482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4482,1,3,0)
 ;;=3^Intraoperative Complication of the Ear/Mastoid NEC
 ;;^UTILITY(U,$J,358.3,4482,1,4,0)
 ;;=4^H95.88
 ;;^UTILITY(U,$J,358.3,4482,2)
 ;;=^5007036
 ;;^UTILITY(U,$J,358.3,4483,0)
 ;;=N99.81^^20^284^18
 ;;^UTILITY(U,$J,358.3,4483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4483,1,3,0)
 ;;=3^Intraoperative Complication of the GU System NEC
 ;;^UTILITY(U,$J,358.3,4483,1,4,0)
 ;;=4^N99.81
 ;;^UTILITY(U,$J,358.3,4483,2)
 ;;=^5015967
 ;;^UTILITY(U,$J,358.3,4484,0)
 ;;=M96.89^^20^284^19
 ;;^UTILITY(U,$J,358.3,4484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4484,1,3,0)
 ;;=3^Intraoperative Complication of the Musculoskeletal System NEC
 ;;^UTILITY(U,$J,358.3,4484,1,4,0)
 ;;=4^M96.89
 ;;^UTILITY(U,$J,358.3,4484,2)
 ;;=^5015399
 ;;^UTILITY(U,$J,358.3,4485,0)
 ;;=G97.81^^20^284^20
 ;;^UTILITY(U,$J,358.3,4485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4485,1,3,0)
 ;;=3^Intraoperative Complication of the Nervous System
 ;;^UTILITY(U,$J,358.3,4485,1,4,0)
 ;;=4^G97.81
 ;;^UTILITY(U,$J,358.3,4485,2)
 ;;=^5004211
 ;;^UTILITY(U,$J,358.3,4486,0)
 ;;=J95.88^^20^284^21
 ;;^UTILITY(U,$J,358.3,4486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4486,1,3,0)
 ;;=3^Intraoperative Complication of the Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,4486,1,4,0)
 ;;=4^J95.88
 ;;^UTILITY(U,$J,358.3,4486,2)
 ;;=^5008345
 ;;^UTILITY(U,$J,358.3,4487,0)
 ;;=L76.81^^20^284^22
 ;;^UTILITY(U,$J,358.3,4487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4487,1,3,0)
 ;;=3^Intraoperative Complication of the Skin NEC
 ;;^UTILITY(U,$J,358.3,4487,1,4,0)
 ;;=4^L76.81
 ;;^UTILITY(U,$J,358.3,4487,2)
 ;;=^5009308
 ;;^UTILITY(U,$J,358.3,4488,0)
 ;;=D78.81^^20^284^23
 ;;^UTILITY(U,$J,358.3,4488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4488,1,3,0)
 ;;=3^Intraoperative Complication of the Spleen
 ;;^UTILITY(U,$J,358.3,4488,1,4,0)
 ;;=4^D78.81
 ;;^UTILITY(U,$J,358.3,4488,2)
 ;;=^5002403
 ;;^UTILITY(U,$J,358.3,4489,0)
 ;;=H59.229^^20^284^3
 ;;^UTILITY(U,$J,358.3,4489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4489,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Eye/Adnexa,Unspec,During Surgery
 ;;^UTILITY(U,$J,358.3,4489,1,4,0)
 ;;=4^H59.229
 ;;^UTILITY(U,$J,358.3,4489,2)
 ;;=^5006416
 ;;^UTILITY(U,$J,358.3,4490,0)
 ;;=D78.12^^20^284^11
 ;;^UTILITY(U,$J,358.3,4490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4490,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Spleen During Surgery
 ;;^UTILITY(U,$J,358.3,4490,1,4,0)
 ;;=4^D78.12
 ;;^UTILITY(U,$J,358.3,4490,2)
 ;;=^5002400
 ;;^UTILITY(U,$J,358.3,4491,0)
 ;;=I97.811^^20^284^14
 ;;^UTILITY(U,$J,358.3,4491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4491,1,3,0)
 ;;=3^Intraoperative Cerebrovascular Infarction During Surgery
 ;;^UTILITY(U,$J,358.3,4491,1,4,0)
 ;;=4^I97.811
 ;;^UTILITY(U,$J,358.3,4491,2)
 ;;=^5008108
 ;;^UTILITY(U,$J,358.3,4492,0)
 ;;=S31.154A^^20^285^3
 ;;^UTILITY(U,$J,358.3,4492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4492,1,3,0)
 ;;=3^Open Bite of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,4492,1,4,0)
 ;;=4^S31.154A
 ;;^UTILITY(U,$J,358.3,4492,2)
 ;;=^5134487
 ;;^UTILITY(U,$J,358.3,4493,0)
 ;;=S31.151A^^20^285^4
 ;;^UTILITY(U,$J,358.3,4493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4493,1,3,0)
 ;;=3^Open Bite of LUQ of Abd Wall w/o Penet Perit Cav,Init Cav
 ;;^UTILITY(U,$J,358.3,4493,1,4,0)
 ;;=4^S31.151A
 ;;^UTILITY(U,$J,358.3,4493,2)
 ;;=^5024104
 ;;^UTILITY(U,$J,358.3,4494,0)
 ;;=S31.153A^^20^285^35
 ;;^UTILITY(U,$J,358.3,4494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4494,1,3,0)
 ;;=3^Open Bite of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,4494,1,4,0)
 ;;=4^S31.153A
 ;;^UTILITY(U,$J,358.3,4494,2)
 ;;=^5024110
 ;;^UTILITY(U,$J,358.3,4495,0)
 ;;=S31.150A^^20^285^36
 ;;^UTILITY(U,$J,358.3,4495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4495,1,3,0)
 ;;=3^Open Bite of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,4495,1,4,0)
 ;;=4^S31.150A
 ;;^UTILITY(U,$J,358.3,4495,2)
 ;;=^5024101
 ;;^UTILITY(U,$J,358.3,4496,0)
 ;;=S91.052A^^20^285^5
 ;;^UTILITY(U,$J,358.3,4496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4496,1,3,0)
 ;;=3^Open Bite of Left Ankle,Init Encntr
 ;;^UTILITY(U,$J,358.3,4496,1,4,0)
 ;;=4^S91.052A
 ;;^UTILITY(U,$J,358.3,4496,2)
 ;;=^5044162
 ;;^UTILITY(U,$J,358.3,4497,0)
 ;;=S31.825A^^20^285^6
 ;;^UTILITY(U,$J,358.3,4497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4497,1,3,0)
 ;;=3^Open Bite of Left Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,4497,1,4,0)
 ;;=4^S31.825A
 ;;^UTILITY(U,$J,358.3,4497,2)
 ;;=^5024317
 ;;^UTILITY(U,$J,358.3,4498,0)
 ;;=S01.452A^^20^285^7
 ;;^UTILITY(U,$J,358.3,4498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4498,1,3,0)
 ;;=3^Open Bite of Left Cheek/Temporomandibular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,4498,1,4,0)
 ;;=4^S01.452A
 ;;^UTILITY(U,$J,358.3,4498,2)
 ;;=^5020180
 ;;^UTILITY(U,$J,358.3,4499,0)
 ;;=S01.352A^^20^285^8
 ;;^UTILITY(U,$J,358.3,4499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4499,1,3,0)
 ;;=3^Open Bite of Left Ear,Init Encntr
