DG53289 ;ALB/RMM - Means Test Workload Cleanup Utility ; 23 Aug 2000  7:00 AM
 ;;5.3;Registration;**289**;Aug 23, 2000
 ;
 ; This is a cleanup program for the MT Workload Cleanup
 ; corected with Patch #DG*5.3*267.
 ;
 ; The clean up is required as there is a number of entries in the
 ; Annual Means Test file (408.31) that have no records set as primary.
 ;  
 ;
 ; ^XTMP("DG-MT-IY",MTIY) track number of records processed:
 ; ^XTMP("DG-MT-ERR") contains error messages returned from FM DBS calls:
 ;        ^XTMP("DG-MT-ERR",file#,record#,field#,n)=error message
 ;
PRE ;
 ; Pre-install set up checkpoint and tracking global...
 N %,I,X,X1,X2
 I $D(XPDNM) D
 .; Checkpoint
 .I $$VERCP^XPDUTL("DGDFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGDFN","",0)
 ;
 ; Initialize tracking global (See text above for description)
 F I="MT-IY","MT-ERR" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT
 .S X2=30
 .D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_"^"_$$DT^XLFDT_"^DG*5.3*289 MT WORKLOAD CLEANUP "_$S(I="MT-IY":"record count",1:"filing errors")
 ;
EN ; Begin Processing...
 N %
 ; check status and if root checkpoint has not completed start clean up
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DGDFN")
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
 ;
EN1 ; Begin processing
 ; Write message to installation device and to INSTALL file (#9.7)
 D BMES^XPDUTL("MT Workload Clean-Up Processing")
 D MES^XPDUTL("Once the MT Workload Clean-Up has completed, a mail ")
 D MES^XPDUTL("message will be sent that will report the number of")
 D MES^XPDUTL("records, by income year, that were changed.")
 D MES^XPDUTL("Additionally, the report will contain notes about any")
 D MES^XPDUTL("errors encountered during the MT Workload Clean-Up.")
 D BMES^XPDUTL("Beginning clean-up process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
RECCHK ; Process Control Body
 N DGMTIDT,DGDFN,STA,YR,FILERR,MTIEN,MTSTAT,ARR,ERRS,LSTMT
 ;
 ; Only look at records where the Income Year is 1998 or 1999
 ;
 I '$D(XPDNM) S DGDFN=""
 I $D(XPDNM) S DGDFN=$$PARCP^XPDUTL("DGDFN")
 S STA=$P($$SITE^VASITE,"^",3)
 ;
 F  S DGDFN=$O(^DGMT(408.31,"AID",1,DGDFN)) Q:DGDFN=""  D
 .S DGMTIDT=-DT
 .K ARR
 .F  S DGMTIDT=$O(^DGMT(408.31,"AID",1,DGDFN,DGMTIDT)) Q:DGMTIDT=""!(DGMTIDT>-2990101)  D
 ..; If there is a Primary in this year, skip the rest of this year.
 ..S LSTMT="",LSTMT=$$LST^DGMTU(DGDFN,$E(DGMTIDT,2,4)_"1231")
 ..I $E($P(LSTMT,U,2),2,3)=$E(DGMTIDT,3,4) S DGMTIDT=$E(DGMTIDT,1,4)_"0101" Q
 ..S (MTSTAT,MTIEN)=""
 ..F  S MTIEN=$O(^DGMT(408.31,"AID",1,DGDFN,DGMTIDT,MTIEN)) Q:MTIEN=""  D
 ...; If the MT Status is not CAT A or CAT C, Quit.
 ...S MTSTAT=$P($G(^DGMT(408.31,MTIEN,0)),U,3)
 ...I MTSTAT'=4,MTSTAT'=6 Q
 ...; Setup an array with Patient's Means Test info
 ...D SETARR
 .S FILERR=0
 .D CHKREC(DGDFN)
 ;
 ; Send a mailman msg to the user with the results
 D MAIL^DG53289M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("DGDFN")
 D MES^XPDUTL(" >>clean-up process completed "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
 ;
SETARR ; Setup an array with Means Test info
 N IYR
 ; If the data was purged, don't use the record.
 I $D(^DGMT(408.31,MTIEN,"PURGE")) Q
 ;
 S IYR=$E(DGMTIDT,2,4)
 S:'$D(ARR(DGDFN,IYR)) ARR(DGDFN,IYR)=0
 S ARR(DGDFN,IYR,MTIEN,-DGMTIDT)=""
 S ARR(DGDFN,IYR)=ARR(DGDFN,IYR)+1
 ; Identify records where HEC is the source of the Income Test
 I $P(^DGMT(408.31,MTIEN,0),U,23)=2 S ARR(DGDFN,IYR,"IVM")=MTIEN
 Q
 ; 
CHKREC(DGDFN) ; Validate each year by the earliest record
 N INCYR,REC31
 S INCYR=""
 F  S INCYR=$O(ARR(DGDFN,INCYR)) Q:INCYR=""  D
 .S REC31=""
 .I ARR(DGDFN,INCYR)=1 S REC31=$O(ARR(DGDFN,INCYR,""))
 .I ARR(DGDFN,INCYR)>1 D
 ..I $D(ARR(DGDFN,INCYR,"IVM")) S REC31=ARR(DGDFN,INCYR,"IVM")
 ..I '$D(ARR(DGDFN,INCYR,"IVM")) S REC31=$O(ARR(DGDFN,INCYR,""))
 .; Only set the records that meet all the criteria
 .D:REC31 SETREC(INCYR,REC31,.ERRS)
 .; If there was an error, update temp global
 .I FILERR M ^XTMP("DG-MT-ERR")=ERRS K ERRS
 .; Update check point with Patient ID
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDFN",DGDFN)
 .; Cleanup the array when finished 
 .K ARR(DGDFN,INCYR)
 Q
 ;
SETREC(IY,REC31,ERRS) ; The record met all criteria, now set the PRIMARY
 ;
 N DATA,ERROR
 ; Increment Processed Record Count for Income Year
 D COUNT(IY)
 S DATA(2)=1
 I '$$UPD^DGENDBS(408.31,.REC31,.DATA,.ERROR) D
 .S ERRS(408.31,REC31,"PRIM")="Unable to process record",FILERR=1 Q
 Q
 ;
COUNT(DATE) ; Update process tracking counter
 ; Input:
 ;   DATE = inverse of the date from "AID" x-ref in 408.31
 ;
 S IY=DATE-1
 S ^XTMP("DG-MT-IY",IY)=+$G(^XTMP("DG-MT-IY",IY))+1
 ;
 Q
