HMPXGDPT ; ASMR/PB - Patient File Utilities;Nov 03, 2015 18:23:03
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;November 30,2015;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References
 ; -------------------
 ; Patient File - IA 10035
 ; DBIA3327
 ;
 Q
 ;
TOP(HMPARRAY,HMPDFN,HMPFLDS,HMPFLG) ; returns data based on the DFN and the list of fields supplied.
 ;This API only returns fields that are at the top level of the record.
 ;It will not return data from multiples, use the LOWER API to return fields from a multiple in the Patient file.
 ;Data is returned in the array passed in the ARRAY parameter. Data is returned for both internal and external values.
 ;
 ; HMPARRAY - result array, passed by reference
 ; HMPDFN - IEN of the Patient, required
 ; HMPFLDS - FileMan field list (optional), if not passed all fields returned 
 ; HMPFLG - FileMan data flag (optional)
 ; 
 N DA,DR,DIQ,DIC,FLAGS
 Q:$G(HMPDFN)=""  ;DFN must be defined
 Q:$G(HMPFLDS)=""  ;FLDS must have a least one field defined. Fields are listed by field number and separated by a semi colon
 S:'$G(HMPFLG) FLAGS="IE"
 S DIC=2,DR=HMPFLDS,DA=HMPDFN,DIQ=HMPARRAY,DIQ(0)=$G(HMPFLG)
 D EN^DIQ1
 Q
 ;
INOUT(HMPDFN) ; Boolean function, 1 for inpatient, else zero
 N LOC S LOC=$G(^DPT(+$G(HMPDFN),.1)) Q $S($L(LOC):1,1:0)  ;ICR 10035, (#.1) WARD LOCATION [E1,30F]
 ;
