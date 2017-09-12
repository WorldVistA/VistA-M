DG272PT ;alb/maw-DG*5.3*272 POST-INSTALL TO PURGE IVM DATA ;2/1/2000
 ;;5.3;Registration;**272**;Aug 13, 1993
 ;
 ; This routine is the post-installation for patch DG*5.3*272.
 ;
 ; The purge process completed by this routine is required by the
 ; sharing agreement between VHA, Internal Revenue Service and the
 ; Social Security Administration.  The specific criteria for a
 ; record to be purged of income data is:
 ;
 ;    Income years 1992 through 1996
 ;    Date range = 1/1/93 through 12/31/97
 ;    Status of test = Category C
 ;    Source of Income Test = IVM
 ;
 ; Data will be "purged" by setting the values of specific fields
 ; equal to null.  The list of fields can be found at the end of
 ; the routine ^DG272PT1.
 ;
 ; record number variables:
 ;    DGMTIE21 = record number in 408.21 (INDIVIDUAL ANNUAL INCOME)
 ;    DGMTIE22 = record number in 408.22 (INCOME RELATION)
 ;    DGMTIE31 = record number in 408.31 (ANNUAL MEANS TEST)
 ;
 ; ^XTMP("DGMTPCT",income year) tracks the number of records processed:
 ;   $P(^(income year),U,1)=records during purge process
 ;   $P(^(income year),U,2)=records during close process
 ; ^XTMP("DGMTPERR") contains error messages returned from FM DBS calls:
 ;   ^XTMP("DGMTPERR",file#,record#,field#,n)=error message
 ;
POST ;
 ; add entry to the IVM CASE CLOSURE REASON file (#301.93)
 D CLOSER
 ;
 ; post-install set up checkpoints and tracking global...
 N %,I,X,X1,X2
 I $D(XPDNM) D
 .; checkpoints for part 1...
 .I $$VERCP^XPDUTL("DGMTIDT")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGMTIDT","","-2980101")
 .I $$VERCP^XPDUTL("DGMTDFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGMTDFN","",0)
 .;
 .; checkpoints for part 2...
 .I $$VERCP^XPDUTL("DGDATE")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGDATE","","2910000")
 .I $$VERCP^XPDUTL("DGDFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGDFN","",0)
 ;
 ; initialize tracking global (see text above for description)...
 F I="DGMTPCT","DGMTPERR" D
 .I $D(^XTMP(I)) Q
 .S X1=DT
 .S X2=30
 .D C^%DTC
 .S ^XTMP(I,0)=X_"^"_$$DT^XLFDT_"^DG*5.3*272 POST-INSTALL "_$S(I="DGMTPCT":"record count",1:"filing errors")
 I '$D(^XTMP("DGMTPCT",292)) F I=292:1:296 S ^XTMP("DGMTPCT",I)="0^0"
 ;
EN ; begin processing...
 N %
 ; check status of part 1 (purge data)...
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DGMTIDT")
 I $G(%)="" S %=0
 I %=0 D EN1
 ;
 ; check status of part 2 (close cases)...
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DGDATE")
 I $G(%)="" S %=0
 I %=0 D EN^DG272PT2
 Q
 ;
EN1 ; begin purge...
 D BMES^XPDUTL("POST INSTALLATION PROCESSING")
 D BMES^XPDUTL("Statistics for each income year 1992-1996 will be kept")
 D MES^XPDUTL("during this purge, and during the case closure process.")
 D MES^XPDUTL("Once the post-install is completed, a mail message will")
 D MES^XPDUTL("be sent that will report the count of records, by income")
 D MES^XPDUTL("year, from which data was purged and the number of records")
 D MES^XPDUTL("closed.  Additionally, the report will contain notes")
 D MES^XPDUTL("about any errors encountered during the post-installation.")
 D BMES^XPDUTL("Beginning data purge process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 I '$D(XPDNM) S DGMTIDT="-2980101"
 I $D(XPDNM) S DGMTIDT=$$PARCP^XPDUTL("DGMTIDT"),DGMTDFN=$$PARCP^XPDUTL("DGMTDFN")
 F  S DGMTIDT=$O(^DGMT(408.31,"AS",1,6,DGMTIDT)) Q:DGMTIDT=""!($E(DGMTIDT,2,8)<2930101)  D
 .S:'$D(DGMTDFN) DGMTDFN=0
 .F  S DGMTDFN=$O(^DGMT(408.31,"AS",1,6,DGMTIDT,DGMTDFN)) Q:'DGMTDFN  D
 ..S DGMTIE31=0
 ..F  S DGMTIE31=$O(^DGMT(408.31,"AS",1,6,DGMTIDT,DGMTDFN,DGMTIE31)) Q:'DGMTIE31  D
 ...;
 ...; quit if already purged...
 ...I $G(^DGMT(408.31,DGMTIE31,"PURGE"))'="" Q
 ...;
 ...; source of income test must be IVM...
 ...S DGMTDATA=$G(^DGMT(408.31,DGMTIE31,0))
 ...I $$SRCE^DG272PT1(+$P(DGMTDATA,U,23))'="IVM" K DGMTDATA Q
 ...K DGMTDATA
 ...;
 ...; edit this record in file 408.31...
 ...S DGFILERR=0
 ...D EDIT^DG272PT1("408.31",DGMTIE31,.DGFILERR)
 ...;
 ...; go to file 408.22...
 ...S DGMTIE21=0
 ...F  S DGMTIE21=$O(^DGMT(408.22,"AMT",DGMTIE31,DGMTDFN,DGMTIE21)) Q:'DGMTIE21  D
 ....S DGMTIE22=0
 ....F  S DGMTIE22=$O(^DGMT(408.22,"AMT",DGMTIE31,DGMTDFN,DGMTIE21,DGMTIE22)) Q:'DGMTIE22  D
 .....;
 .....; edit the record in 408.22...
 .....S DGFILERR=0
 .....D EDIT^DG272PT1("408.22",DGMTIE22,.DGFILERR)
 .....;
 .....; use pointer from 408.22 to 408.21 and edit the
 .....; record over there...
 .....S DGFILERR=0
 .....D EDIT^DG272PT1("408.21",DGMTIE21,.DGFILERR)
 ....K DGMTIE22
 ...K DGMTIE21
 ...I '$G(DGFILERR) D COUNT^DG272PT1(DGMTIDT)
 ..I $D(XPDNM) S %=$$UPCP^XPDUTL("DGMTDFN",DGMTDFN)
 ..K DGMTIE31
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGMTIDT",DGMTIDT)
 .K DGMTDFN,DGFILERR
 K DGMTIDT
 ;
 ; clean up and finish...
 I $D(XPDNM) S %=$$COMCP^XPDUTL("DGMTIDT")
 D MES^XPDUTL(" >>purge process completed "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
 ;
 ;
CLOSER ; Add entries to the IVM CASE CLOSURE REASON (#301.93) file
 D BMES^XPDUTL(">>> Adding new entry to IVM CASE CLOSURE REASON (#301.93) file")
 ;
 ; - if entry already there, display msg and quit
 I $O(^IMV(301.93,"B","OLD CASE NO ACTION",0)) D  Q
 .D MES^XPDUTL("     *** Entry already on file - current values not overwritten ***")
 ;
 ; - add new entry to (#301.93) file
 F IVMX="OLD CASE NO ACTION" D
 .Q:$O(^IVM(301.93,"B",IVMX,0))
 .S DIC="^IVM(301.93,",DIC(0)="",DLAYGO=301.93,X=IVMX
 .K DD,DO D FILE^DICN
 ;
 D MES^XPDUTL("     Entry has been added")
 ;
CLOSERQ K DIC,DLAYGO,IVMX,X,Y
 Q
