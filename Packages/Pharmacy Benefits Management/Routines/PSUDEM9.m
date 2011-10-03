PSUDEM9 ;BIR/DAM - CPT Codes for Inpatient PTF Record Extract ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA's
 ; Reference to file 45 supported by DBIA 3511
 ; Reference to file 80.1 supported by DBIA 10083
 ;
EN ;EN      Called from PSUDEM8
 D CPTP
 D P
 D AO
 D FIN
 ;
 Q
 ;
CPTP ;Find CPT pointers for the ^DGPT(D0,"401P" node by $ ordering
 ;through the ^DGPT(D0,"AP",Pointer) cross reference
 ;
 S I=17
 S PSUAP=0
 F  S PSUAP=$O(^DGPT(PSUC,"AP",PSUAP)) Q:'PSUAP  D
 .N PSUCPT
 .S PSUCPT=$P($G(^ICD0(PSUAP,0)),U)     ;CPT code
 .I $G(PSUCPT) S ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT)=""    ;Set temp global
 .S I=I+1
 Q
 ;
P ;Find CPT pointers for the ^DGPT(D0,"P" node by $O through
 ;the ^DGPT(D0,"P","AP6",pointer,D1) cross reference
 ;
 S I=22
 S PSUP=0
 F  S PSUP=$O(^DGPT(PSUC,"P","AP6",PSUP)) Q:'PSUP  D
 .N PSUCPT
 .S PSUCPT=$P($G(^ICD0(PSUP,0)),U)      ;CPT code
 .I $G(PSUCPT) S ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT)=""    ;Set temp global
 .D DEL
 .S I=I+1
 Q
 ;
DEL ;Delete duplicates
 ;
 F N=17:1:21 I $D(^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,N,PSUCPT)) D
 .K ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT)
 Q
 ;
AO ;Find CPT pointers for the ^DGPT(D0,"P" node by $O through
 ;the ^DGPT(D0,"S","AO",pointer,D1) cross reference.
 ;
 S I=27
 S PSUBP=0
 F  S PSUBP=$O(^DGPT(PSUC,"S","AO",PSUBP)) Q:'PSUBP  D
 .N PSUCPT
 .S PSUCPT=$P($G(^ICD0(PSUBP,0)),U)      ;CPT code
 .I $G(PSUCPT) S ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT)=""    ;Set temp global
 .D DEL1
 .S I=I+1
 Q
 ;
DEL1 ;Delete duplicates
 ;
 F N=17:1:26 I $D(^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,N,PSUCPT)) D
 .K ^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,I,PSUCPT)
 Q
 ;
FIN ;$O through temp global, and set codes into the Inpatient Record
 ;global, ^XTMP("PSU_"_PSUJOB,"PSUIPV"
 ;
 S T=0,N=29
 F  S T=$O(^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,T)) Q:'T  Q:N=44  D
 .S PSUIDF=0
 .F  S PSUIDF=$O(^XTMP("PSU_"_PSUJOB,"PSUTMP3",PSUC,T,PSUIDF)) Q:'PSUIDF  D
 ..S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U,N)=PSUIDF
 ..S N=N+1
 ;
 F N=29:1:44 I '$P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U,N) D
 .S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U,N)=""    ;Set unfilled pieces to null
 S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUC),U,44)=""    ;Place "^" at end of record
 Q
