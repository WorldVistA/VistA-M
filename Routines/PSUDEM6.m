PSUDEM6 ;BIR/DAM - CPT Codes for Outpatient Visits Extract ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA's
 ; Reference to file 81 supported by DBIA 2815
 ;
EN ;EN  Called from PSUDEM3
 D CPT
 D FIN
 ;
 Q
 ;
CPT ;Find CPT codes and place into temp global
 ;
 N PSUCPT1
 I $G(PSUCPT) S PSUCPT1=$P($G(^ICPT(PSUCPT,0)),U)
 I '$G(PSUCPT) S PSUCPT1="NULL"
 I (PSUVIEN'="")&(PSUCPT1'="") D
 .S ^XTMP("PSU_"_PSUJOB,"PSUTMP2",PSUVIEN,PSUCPT1)=""
 Q 
 ;
FIN ;$O through temp global, and set codes into the Outpatient Visit
 ;Encounter global, ^XTMP("PSU_"_PSUJOB,"PSUOPV"
 ;
 S PSUIDF=0
 S I=17
 F  S PSUIDF=$O(^XTMP("PSU_"_PSUJOB,"PSUTMP2",PSUVIEN,PSUIDF)) Q:'PSUIDF  Q:I=27  D
 .I PSUIDF="NULL" S $P(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUVIEN),U,I)=""
 .I PSUIDF'="NULL" S $P(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUVIEN),U,I)=PSUIDF
 .S I=I+1
 ;
 F N=27:1:26 I $P($G(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUVIEN)),U,N)="" D
 .S $P(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUVIEN),U,N)=""
 S $P(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUVIEN),U,27)=""   ;set closing "^"
 Q
