PSUDEM9 ;BIR/DAM - CPT Codes for Inpatient PTF Record Extract ;20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**19**;MARCH, 2005;Build 28
 ;
 ;DBIA's
 ; Reference to file 45         supported by DBIA 3511
 ; Reference to ICDEX           supported by DBIA 5747
 ;
EN ;EN      Called from PSUDEM8
 K PSUCSYS,SCOUNT S SCOUNT=0   ; code system marker  "9","10",or "U"
 D CPTP
 D P
 D AO
 D FIN
 K PSUCSYS,SCOUNT
 ;
 Q
 ;
CPTP ;Find CPT pointers for the ^DGPT(D0,"401P" node by $ ordering
 ;through the ^DGPT(D0,"AP",Pointer) cross reference
 ;
 S I=17
 S PSUAP=0
 F  S PSUAP=$O(^DGPT(PSUC,"AP",PSUAP)) Q:PSUAP=""  Q:SCOUNT>15  D
 .N PSUCPT
 .S PSUCPT=$$ICDOP^ICDEX(PSUAP,,,"I")
 .S:+PSUCPT>0 PSUCSYS(PSUC,$P(PSUCPT,U,15))="",PSUCPT=$P(PSUCPT,U,2)   ;Set code system per CPT also
 .I $G(PSUCPT)]"" S ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT)=""    ;Set temp global
 .S I=I+1,SCOUNT=SCOUNT+1
 Q
 ;
P ;Find CPT pointers for the ^DGPT(D0,"P" node by $O through
 ;the ^DGPT(D0,"P","AP6",pointer,D1) cross reference.   ANY NUMBER
 ;
 S I=22
 S PSUP=0
 F  S PSUP=$O(^DGPT(PSUC,"P","AP6",PSUP)) Q:PSUP=""  Q:SCOUNT>15  D
 .N PSUCPT
 .S PSUCPT=$$ICDOP^ICDEX(PSUP,,,"I")
 .S:+PSUCPT>0 PSUCSYS(PSUC,$P(PSUCPT,U,15))="",PSUCPT=$P(PSUCPT,U,2)
 .I $G(PSUCPT)]"" S ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT)=""    ;Set temp global
 .D DEL
 .S I=I+1,SCOUNT=SCOUNT+1
 Q
 ;
DEL ;Delete duplicates
 ;
 F N=17:1:21 I $D(^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,N,PSUCPT)) D
 .K ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT) S SCOUNT=SCOUNT-1
 Q
 ;
AO ;Find CPT pointers for the ^DGPT(D0,"P" node by $O through
 ;the ^DGPT(D0,"S","AO",pointer,D1) cross reference.   ANY NUMBER
 ;
 S I=27
 S PSUBP=0
 F  S PSUBP=$O(^DGPT(PSUC,"S","AO",PSUBP)) Q:PSUBP=""  Q:SCOUNT>15  D
 .N PSUCPT
 .S PSUCPT=$$ICDOP^ICDEX(PSUBP,,,"I")
 .S:+PSUCPT>0 PSUCSYS(PSUC,$P(PSUCPT,U,15))="",PSUCPT=$P(PSUCPT,U,2)
 .I $G(PSUCPT)]"" S ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT)=""    ;Set temp global
 .D DEL1
 .S I=I+1,SCOUNT=SCOUNT+1
 Q
 ;
DEL1 ;Delete duplicates
 ;
 F N=17:1:26 I $D(^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,N,PSUCPT)) D
 .K ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT) S SCOUNT=SCOUNT-1
 Q
 ;
FIN ;$O through temp global, and set codes into the Inpatient Record
 ;global, ^XTMP("PSU_"_PSUJOB,"PSUIPV"
 ;
 S T=0,N=28
 F  S T=$O(^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,T)) Q:'T  Q:N=44  D
 .S PSUIDF=0
 .F  S PSUIDF=$O(^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,T,PSUIDF)) Q:'(PSUIDF]"")  D
 ..S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U,N)=PSUIDF
 ..S N=N+1
 ;
 F N=28:1:44 I '($P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U,N)]"") D
 .S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U,N)=""    ;Set unfilled pieces to null
 S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U,44)=""    ;Place "^" at end of record
 ;
 ; Place code system per record in  LAST "^"piece  =    "9","10","U"(both)
 ;
 S PSUCSYS=$G(PSUCSYS1,"")
 I $D(PSUCSYS(PSUC,2)),$D(PSUCSYS(PSUC,31)) S PSUCSYS="U"
 I $D(PSUCSYS(PSUC,2)),($G(PSUCSYS,"")'["U") S PSUCSYS=$S(+PSUCSYS=10:"U",1:"9")
 I $D(PSUCSYS(PSUC,31)),($G(PSUCSYS,"")'["U") S PSUCSYS=$S(+PSUCSYS=9:"U",1:"10")
 S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U,$L(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U))=PSUCSYS
 K PSUCSYS1
 Q
