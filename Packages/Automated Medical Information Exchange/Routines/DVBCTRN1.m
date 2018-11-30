DVBCTRN1 ;ALB/JLU;AMIE link routine;12/21/92
 ;;2.7;AMIE;**12**;Apr 10, 1995
NSFT K DVBCHK
 I $S('$D(DVBCDFN):1,DVBCDFN']"":1,1:0) S DVBCHK="-1^Patient's DFN not defined OR is null" Q
 I $S('$D(DVBCXM):1,DVBCXM']"":1,1:0) S DVBCHK="-2^Exam not defined OR is null" Q
 S DVBCDFN1=$O(^DVB(396.3,"B",DVBCDFN,0))
 I 'DVBCDFN1 S DVBCHK="-3^No 2507 request for this patient" Q
 ;for loop to handle multiple exams with same name
 N FOUND,STOP,TOXM
 S (DVBCXM1,FOUND,STOP)=0
 F  S DVBCXM1=$O(^DVB(396.6,"B",$E(DVBCXM,1,30),DVBCXM1)) Q:(DVBCXM1="")!(+$G(DVBCHK)<0)  D
 .Q:($P(^DVB(396.6,DVBCXM1,0),"^"))'=DVBCXM
 .S FOUND=1 ;an entry does exist for exam passed in DVBCXM
 .S DVBCOXM=$O(^DVB(396.4,"APS",DVBCDFN,DVBCXM1,"O",0))
 .I STOP,DVBCOXM'="" S DVBCHK="-8^More than one open exam" Q
 .I STOP,DVBCOXM="" Q
 .; ^ multiple exams with same name but different pointer values.
 .I $O(^DVB(396.4,"APS",DVBCDFN,DVBCXM1,"O",DVBCOXM)) S DVBCHK="-8^More than one open exam" Q
 .I DVBCOXM'="" S STOP=1,TOXM=DVBCOXM
 .; ^open exam found
 I +$G(DVBCHK)<0 Q
 I 'FOUND S DVBCHK="-4^No Exam by that name in the 2507 Exam file" Q
 I 'STOP S DVBCHK="-6^No open Exam for data given" Q
 S DVBCOXM=TOXM
 I '$D(^DVB(396.4,DVBCOXM,0)) S DVBCHK="-7^Exam cross reference is bad" Q
 S DVBCX=$P(^DVB(396.4,DVBCOXM,0),U,2)
 I '$$OREQ($P(^DVB(396.3,DVBCX,0),"^",18)) S DVBCHK="-5^No open requests for data given" Q
 S DVBCHK="396.3:"_DVBCX_":"_396.4_":"_DVBCOXM_";^Soft Link entry"
 Q
 ;
OREQ(DVBX) ;
 ;This function will check to see if there is an open request.
 ;DVBCX should contain the REQUEST STATUS.
 ;
 I $S(DVBX'="P"&(DVBX'="S")&(DVBX'="T")&(DVBX'="NT"):1,1:0) Q 0
 Q 1
