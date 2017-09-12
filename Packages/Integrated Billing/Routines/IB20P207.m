IB20P207 ;BP/TJH; ENVIRONMENT CHECK WITH PRE-INIT CODE ; 01/03/2003
 ;;2.0;INTEGRATED BILLING;**207**;21-MAR-94
 ;
ENV ; environment check
 ; No special environment check at this time.
PRE ; set up check points for pre-init
 N %
 S %=$$NEWCP^XPDUTL("R28","R28^IB20P207")
 S %=$$NEWCP^XPDUTL("R900","R900^IB20P207")
 Q
 ;
R28 ; set new value into record 28 of file 364.7, re: WAS-0902-20562
 ; change the Format Code
 D BMES^XPDUTL("Updating format code for Admit Date.")
 N IBWPA,IBERRM,DA,DR,DIE,FILE,IENS,FIELD,FLAGS
 S DA=28,DR="1////"_$P($T(TEXT1),";",3),DIE="^IBA(364.7," D ^DIE
 ; change the Format Code Description
 D BMES^XPDUTL("Updating format code description for Admit Date.")
 S IBWPA(1)="Extract only date from date/time retrieved from IBXSAVE array previously"
 S IBWPA(2)="extracted.  For an outpatient claim not related to an inpatient episode,"
 S IBWPA(3)="output the statement 'To Date'.  Format date in CCYYMMDD format."
 S IBWPA(4)="If data element's value is null, do not output."
 S FILE=364.7,IENS="28,",FIELD=3,FLAGS=""
 D WP^DIE(FILE,IENS,FIELD,FLAGS,"IBWPA","IBERRM")
 D COMPLETE
 Q
 ;
R900 ; set new values into record 900 of file 364.7, re: CTX-1002-70456
 ; change the Data Element from 234 to 236
 D BMES^XPDUTL("For IEN 900, file 364.7: changing data element from")
 D MES^XPDUTL("N-OTHER INSURANCE CO TYPES to N-OTH INS POL TYPES.")
 N IBELE,IBWPA,IBERRM,DA,DR,DIE,FILE,IENS,FIELD,FLAGS
 S IBELE=+$O(^IBA(364.5,"B","N-OTH INS POL TYPES",0))
 S:'IBELE IBELE=236
 S DA=900,DR=".03////"_IBELE,DIE="^IBA(364.7," D ^DIE
 ; change the Format Code
 D BMES^XPDUTL("Updating format code for N-OTH INS POL TYPES.")
 S DA=900,DR="1////"_$P($T(TEXT2),";",3),DIE="^IBA(364.7," D ^DIE
 ; change the Format Code Description
 D BMES^XPDUTL("Updating format code description for N-OTH INS POL TYPES.")
 S IBWPA(1)="If any 'other' insurance company data is found, the data is formatted"
 S IBWPA(2)="from the electronic type of plan of the insurance company policy in X12"
 S IBWPA(3)="format.  Refer to the 837 V4010 (professional) field 2330/REF(3)/01"
 S IBWPA(4)="for details."
 S FILE=364.7,IENS="900,",FIELD=3,FLAGS=""
 D WP^DIE(FILE,IENS,FIELD,FLAGS,"IBWPA","IBERRM")
 D COMPLETE
 Q
 ;
COMPLETE ; display message that step has completed successfully
 D BMES^XPDUTL("Step complete.")
 Q
 ;
END ; display message that pre-init has completed successfully
 D BMES^XPDUTL("Pre-init complete")
 Q
 ;
TEXT ;Storage area for long strings of text
TEXT1 ;;S IBXDATA=$G(IBXSAVE("DISDT")) D:$S(IBXDATA="":'$$INPAT^IBCEF(IBXIEN,1),1:0) F^IBCEF("N-STATEMENT COVERS TO DATE",,,IBXIEN) I IBXDATA S IBXDATA=$$DT^IBCEFG1(IBXDATA\1,"","D8")
TEXT2 ;;N A,Z,Q S Q=IBXDATA K IBXDATA F Z=1,2 S A=$P(Q,U,Z) I $D(^DGCR(399,IBXIEN,"I"_(Z+1))) S IBXDATA(Z)=$S(A="":"G2","MAMB16"[A:"1C",A="TV"!(A="MC"):"1D",A="CH":"1H",A="BL":$S($$FT^IBCEF(IBXIEN)=2:"1B",1:"1A"),1:"G2")
