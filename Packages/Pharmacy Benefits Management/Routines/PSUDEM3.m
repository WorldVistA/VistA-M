PSUDEM3 ;BIR/DAM - ICD9 codes for Outpatient Encounter Extract ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA's
 ; Reference to file 80         supported by DBIA 10082
 ; Reference to file 9000010.18 supported by DBIA 3560
 ;
EN ;EN   Called from PSUDEM2
 D ICD
 D CLEAN
 Q
 ;
ICD ;Find all ICD9 pointers  associated with Patient pointer
 ;
 N PSUICD
 S PSUC1=0
 F  S PSUC1=$O(^AUPNVCPT("C",PSUPT,PSUC1)) Q:PSUC1=""  D    ;V CPT IEN
 .I $P($G(^AUPNVCPT(PSUC1,0)),U,3)=$G(PSUVIEN) D  ;V CPT IEN=Visit IEN
 ..S PSUICD=$P($G(^AUPNVCPT(PSUC1,0)),U,5) D ICD1           ;ICD9 Ptr
 ..S PSUCPT=$P($G(^AUPNVCPT(PSUC1,0)),U,1) D EN^PSUDEM6  ;grab CPT codes
 I '$D(^AUPNVCPT("C",PSUPT)) S PSUCPT="" D EN^PSUDEM6
 D FIN
 Q
 ;
ICD1 ;Find ICD9 codes from pointers and place in an array 
 ;
 ;
 N PSUID2
 I PSUICD S PSUID2=$P($G(^ICD9(PSUICD,0)),U) D
 .I $D(PSUID2) S ^XTMP("PSU_"_PSUJOB,"PSUTMP1",PSUVIEN,PSUID2)=""  ;ICD9 codes set into array 
 ;
 Q
 ;
FIN ;$O through array, and set codes into the Outpatient Visit
 ;Encounter global, ^XTMP("PSU_"_PSUJOB,"PSUOPV"
 ;
 ;
 S PSUIDF=0
 S I=8
 F  S PSUIDF=$O(^XTMP("PSU_"_PSUJOB,"PSUTMP1",PSUVIEN,PSUIDF)) Q:'PSUIDF  Q:I=17  D
 .S $P(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUVIEN),U,I)=PSUIDF
 .S I=I+1
 ;
 F N=8:1:16 I '$P($G(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUVIEN)),U,N) D
 .S $P(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUVIEN),U,N)=""
 Q
 ;
CLEAN ;Delete all ^XTMP("PSU_"_PSUJOB,"PSUOPV" entries that do not have associated
 ;ICD9 or CPT codes.
 ;
 S PSUCL=0
 F  S PSUCL=$O(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUCL)) Q:'PSUCL  D
 .I $P(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUCL),U,7)="" D
 ..I $P(^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUCL),U,17)="" K ^XTMP("PSU_"_PSUJOB,"PSUOPV",PSUCL)
 Q
