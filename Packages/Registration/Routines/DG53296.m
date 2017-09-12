DG53296 ;ALB/JAT DG*5.3*296 POST-INSTALL TO MAILMAN MSG;01 JUNE 2000
 ;;5.3;Registration;**296**;JUNE 1 2000
 ;
 ; This routine is the post-installation for patch DG*5.3*296
 ;
 ; This clean up is required as there is a number of redundant entries
 ; in the Annual Means Test file for patients on a single date.  These
 ; were created due to the MTS's previous ability to order multiple
 ; income test per patient per day.
 ;
 ; A modified version of the DG MEANS TEST DRIVER protocol is called.
 ;
 ;  Calls:
 ;       DG53296M
 ;       DG53296D
 ;       XPDUTL
 ;
 ; ^XTMP("DG-AMTIY",AMTIY) track number of records processed:
 ; ^XTMP("DG-AMTERR") contains error messages returned from FM DBS calls:
 ; ^XTMP("DG-AMTERR",file#,record#,field#,n)=error message
 ;
POST ;
 ; post-install set up checkpoints and tracking global...
 N %,I,X,X1,X2,DGCNT,DGPCT,DGPRIM,DGSRC,IEN,SRC
 I $D(XPDNM) D
 .; checkpoints
 .I $$VERCP^XPDUTL("DGDFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGDFN","",0)
 .I $$VERCP^XPDUTL("DGDTE")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGDTE","",0)
 .;
 ;
 ; initialize tracking global (see text above for description)...
 F I="AMTIY","AMTERR" D
 .I $D(^XTMP(I)) Q
 .S X1=DT
 .S X2=30
 .D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_U_$$DT^XLFDT_"^DG*5.3*296 POST-INSTALL "
 .S ^XTMP("DG-"_I,0)=^XTMP("DG-"_I,0)_$S(I="AMTIY":"record count",1:"filing errors")
 ;
EN ; begin processing...
 N %
 ; check status and if root checkpoint has not completed start clean up
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DGDFN")
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
 ;
EN1 ; begin purge...
 ; write message to installation device and to INSTALL file (#9.7)
 D BMES^XPDUTL("POST INSTALLATION PROCESSING")
 D MES^XPDUTL("Once the post-install is completed, a mail message will")
 D MES^XPDUTL("be sent that will report the count of records, by income")
 D MES^XPDUTL("year, from which means test entries were purged.")
 D MES^XPDUTL("Additionally, the report will contain notes")
 D MES^XPDUTL("about any errors encountered during the post-installation.")
 D BMES^XPDUTL("Beginning purge process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 ; process control body
 N DGDFN,DGIEN,DGDTE,MTIEN,ERRS
 ;
 I '$D(XPDNM) S DGDFN=""
 E  S DGDFN=$$PARCP^XPDUTL("DGDFN"),DGDTE=$$PARCP^XPDUTL("DGDTE")
 ;
 ;Begin loop search by patient.
 F  S DGDFN=$O(^DGMT(408.31,"AD",1,DGDFN)) Q:'DGDFN  D
 .;Now loop through dates
 .N ERRS
 .D DGDTE
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDFN",DGDFN)
 ; send mailman msg to user/HEC with results
 D MAIL^DG53296M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("DGDTE")
 D MES^XPDUTL(" >>purge process completed "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
 ;
DGDTE ;Loop through dates by patient.
 S:'$D(DGDTE) DGDTE=""
 F  S DGDTE=$O(^DGMT(408.31,"AD",1,DGDFN,DGDTE)) Q:'DGDTE  D
 .;Now search for IEN by patient and date
 .D DGIEN
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDTE",DGDTE)
 Q
 ;
DGIEN ;Loop through IEN numbers by patient and date.
 S (DGPCT,DGCNT)=0,DGIEN=""
 F  S DGIEN=$O(^DGMT(408.31,"AD",1,DGDFN,DGDTE,DGIEN)) Q:DGIEN=""  D
 .;Quit if only 1 IEN number for this date
 .Q:'$O(^DGMT(408.31,"AD",1,DGDFN,DGDTE,DGIEN))&(DGCNT=0)
 .;Validate records to delete
 .D PREDEL
 Q
 ;
PREDEL ;Validate records to delete
 ;Is test Primary? What is the source?
 S DGPRIM=$G(^DGMT(408.31,DGIEN,"PRIM"),0),DGSRC=$P($G(^DGMT(408.31,DGIEN,0)),U,23)
 ;Quit if non-primary test doesn't have a source of DCD or Other Facility
 D:(DGPRIM&DGSRC)!("^3^4^"[("^"_DGSRC_"^"))
 .;Increment counter
 .S DGCNT=DGCNT+1
 .;Build array for IEN with same patient and date.
 .S TMP(DGSRC,DGIEN)=DGPRIM
 .;Keep count of primary test
 .S DGPCT=DGPCT+TMP(DGSRC,DGIEN)
 ;Quit if there are more IEN's for this patient and date
 Q:$O(^DGMT(408.31,"AD",1,DGDFN,DGDTE,DGIEN))
 ;Remove the last record from array by source if no primary for date
 I DGPCT=0 F SRC=3,4 D:$D(TMP(SRC))
 .S IEN=""
 .S IEN=$O(TMP(SRC,IEN),-1) K TMP(SRC,IEN) Q
 ;Delete if test is Non-Primary
 F SRC=3,4 D:$D(TMP(SRC))
 .S IEN=""
 .F  S IEN=$O(TMP(SRC,IEN)) Q:IEN=""  D:'TMP(SRC,IEN) DELETE(IEN)
 .;If error then update temporary store
 .I $G(ERRS) M ^XTMP("DG-AMTERR")=ERRS
 ;Record delete complete, Kill array and quit
 K TMP
 Q
 ;
DELETE(IEN1) ;Delete non-primary test with source of DCD or Other Facility.
 ; Input:
 ;       IEN1 = Internal Entry Number from 408.31
 I '$$EN^DG53296D(IEN1) D
 .S ERRS(408.31,IEN1,"ALL")="Unable to delete means test" Q
 ; increment purged count for income year.
 D COUNT(DGDTE)
 Q
 ;
COUNT(DATE) ; update process tracking mechanisms
 ; Input:
 ;       DATE = inverse date from 408.31
 ;
 N %,IY
 S IY=$E(DATE,1,3)-1
 S ^XTMP("DG-AMTIY",IY)=+$G(^XTMP("DG-AMTIY",IY))+1
 Q
