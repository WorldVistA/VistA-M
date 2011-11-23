DVBCPWC4 ;ALB ISC/THM-POW PROTOCOL EXAM, PART 3 ; 5/6/91  9:39 AM
 ;;2.7;AMIE;;Apr 10, 1995
 G EN
 ;
L I $Y>55 D HD2^DVBCPWCK
 Q
 ;
EN S CNT=0 F I="cranial nerves","gait disturbance","biceps reflex","triceps reflex","patellar reflex","Achilles reflex","plantar response","peripheral nerves","sensory change" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 F I="seizures","loss of consciousness","paralysis","tremor","headaches" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"m. Psychiatric:",!!
 S CNT=0 F I="orientation","memory change","mood","trouble with decisions","sleep disturbance","crying spells","thoughts of suicide","difficulty with work","fatigue" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 F I="loss of appetite","trouble with sex life","social withdrawal","hallucinations","improbable beliefs","anxiety","depression" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W !!!!!,"C. Summary of findings:",!!!!!!!!!!,"D. Diagnoses:",!!!!!!!!!!,"E. Recommendations:",!!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 G ^DVBCPWC2
