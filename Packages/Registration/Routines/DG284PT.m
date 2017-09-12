DG284PT ;ALB/SEK-DG*5.3*284 POST-INSTALL TO PURGE IVM DATA ;4/20/2000
 ;;5.3;Registration;**284**;Aug 13, 1993
 ;
 ; This routine is the post-installation for patch DG*5.3*284.
 ;
 ; The purge process completed by this routine is required by the
 ; sharing agreement between VHA, Internal Revenue Service and the
 ; Social Security Administration.  The specific criteria for a
 ; record to be purged of income data is:
 ;
 ;    All Income years
 ;    Status of test = ALL STATUSES
 ;    Source of Income Test = IVM
 ;
 ; Data will be "purged" by setting the values of specific fields
 ; equal to null.  The list of fields can be found at the end of
 ; the routine ^DG284PT1.
 ;
 ; record number variables:
 ;    DGMTIE21 = record number in 408.21 (INDIVIDUAL ANNUAL INCOME)
 ;    DGMTIE22 = record number in 408.22 (INCOME RELATION)
 ;    DGMTIE31 = record number in 408.31 (ANNUAL MEANS TEST)
 ;
 ; ^XTMP("DGMTPAT",income year) tracks the number of records processed:
 ;   $P(^(income year),U,1)=records during purge process
 ;   $P(^(income year),U,2)=records during close process
 ; ^XTMP("DGMTPERR") contains error messages returned from FM DBS calls:
 ;   ^XTMP("DGMTPERR",file#,record#,field#,n)=error message
 ;
POST ;
 ;
 ; post-install set up checkpoints and tracking global...
 N %,I,X,X1,X2
 I $D(XPDNM) D
 .; checkpoints
 .I $$VERCP^XPDUTL("DGMTIDT")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGMTIDT","","-9999999")
 .I $$VERCP^XPDUTL("DGMTDFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGMTDFN","",0)
 .;
 ;
 ; initialize tracking global (see text above for description)...
 F I="DGMTPAT","DGMTPERR" D
 .I $D(^XTMP(I)) Q
 .S X1=DT
 .S X2=30
 .D C^%DTC
 .S ^XTMP(I,0)=X_"^"_$$DT^XLFDT_"^DG*5.3*284 POST-INSTALL "_$S(I="DGMTPAT":"record count",1:"filing errors")
 I '$D(^XTMP("DGMTPAT",292)) F I=292:1:296 S ^XTMP("DGMTPAT",I)=0
 ;
EN ; begin processing...
 N %
 ; check status
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DGMTDFN")
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
 ;
EN1 ; begin purge...
 D BMES^XPDUTL("POST INSTALLATION PROCESSING")
 D BMES^XPDUTL("Statistics for each income year will be kept")
 D MES^XPDUTL("during this purge.")
 D MES^XPDUTL("Once the post-install is completed, a mail message will")
 D MES^XPDUTL("be sent that will report the count of records, by income")
 D MES^XPDUTL("year, from which data was purged.")
 D MES^XPDUTL("Additionally, the report will contain notes")
 D MES^XPDUTL("about any errors encountered during the post-installation.")
 D BMES^XPDUTL("Beginning data purge process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 I '$D(XPDNM) S DGMTDFN=0
 I $D(XPDNM) S DGMTIDT=$$PARCP^XPDUTL("DGMTIDT"),DGMTDFN=$$PARCP^XPDUTL("DGMTDFN")
 F  S DGMTDFN=$O(^DGMT(408.31,"AID",1,DGMTDFN)) Q:'DGMTDFN  D
 .S:'$D(DGMTIDT) DGMTIDT="-9999999"
 .F  S DGMTIDT=$O(^DGMT(408.31,"AID",1,DGMTDFN,DGMTIDT)) Q:DGMTIDT=""  D
 ..S DGMTIE31=0
 ..F  S DGMTIE31=$O(^DGMT(408.31,"AID",1,DGMTDFN,DGMTIDT,DGMTIE31)) Q:'DGMTIE31  D
 ...;
 ...; quit if already purged...
 ...I $G(^DGMT(408.31,DGMTIE31,"PURGE"))'="" Q
 ...;
 ...; source of income test must be IVM...
 ...S DGMTDATA=$G(^DGMT(408.31,DGMTIE31,0))
 ...I $$SRCE^DG284PT1(+$P(DGMTDATA,U,23))'="IVM" K DGMTDATA Q
 ...K DGMTDATA
 ...;
 ...; edit this record in file 408.31...
 ...S DGFILERR=0
 ...D EDIT^DG284PT1("408.31",DGMTIE31,.DGFILERR)
 ...;
 ...; go to file 408.22...
 ...S DGMTIE21=0
 ...F  S DGMTIE21=$O(^DGMT(408.22,"AMT",DGMTIE31,DGMTDFN,DGMTIE21)) Q:'DGMTIE21  D
 ....S DGMTIE22=0
 ....F  S DGMTIE22=$O(^DGMT(408.22,"AMT",DGMTIE31,DGMTDFN,DGMTIE21,DGMTIE22)) Q:'DGMTIE22  D
 .....;
 .....; edit the record in 408.22...
 .....S DGFILERR=0
 .....D EDIT^DG284PT1("408.22",DGMTIE22,.DGFILERR)
 .....;
 .....; use pointer from 408.22 to 408.21 and edit the
 .....; record over there...
 .....S DGFILERR=0
 .....D EDIT^DG284PT1("408.21",DGMTIE21,.DGFILERR)
 ....K DGMTIE22
 ...K DGMTIE21
 ...I '$G(DGFILERR) D COUNT^DG284PT1(DGMTIDT)
 ..I $D(XPDNM) S %=$$UPCP^XPDUTL("DGMTIDT",DGMTIDT)
 ..K DGMTIE31
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGMTDFN",DGMTDFN)
 .K DGMTIDT,DGFILERR
 K DGMTDFN
 ;
 ; send mailman msg to user/HEC with results
 D MAIL^DG284PT2
 I $D(XPDNM) S %=$$COMCP^XPDUTL("DGMTDFN")
 D MES^XPDUTL(" >>purge process completed "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
