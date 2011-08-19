DG53285 ;ALB/PAK-DG*5.3*285 POST-INSTALL TO CLEAN MEANS TEST ;4/24/2000
 ;;5.3;Registration;**285**;Aug 13, 1993
 ;
 ; This routine is the post installation for patch DG*5.3*285
 ;
 ; The clean up is required as there is a number of redundant entries
 ; with a STATUS (#.03) of 'NO LONGER REQUIRED' in the Annual Means
 ; Test file (408.31). These were created due to the presence of a
 ; REQUIRED test which was primary for the current income year at the
 ; time the means test was uploaded.
 ;
 ; In addition, if there is a REQUIRED test present within 365 days of
 ; the means test under review which is primary then this is set to
 ; NON primary.
 ;
 ; Finally, the DG MEANS TEST DRIVER protocol is called.
 ;  
 ;
 ; ^XTMP("DG-MTIY",MTIY) track number of records processed:
 ; ^XTMP("DG-MTERR") contains error messages returned from FM DBS calls:
 ;   ^XTMP("DG-MTERR",file#,record#,field#,n)=error message
 ;
POST ;
 ; post-install set up checkpoints and tracking global...
 N %,I,X,X1,X2
 I $D(XPDNM) D
 .; checkpoints
 .I $$VERCP^XPDUTL("DGMTIDT")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGMTIDT","","-9999999")
 .I $$VERCP^XPDUTL("DGDFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGDFN","",0)
 .;
 ;
 ; initialize tracking global (see text above for description)...
 F I="MTIY","MTERR" D
 .I $D(^XTMP(I)) Q
 .S X1=DT
 .S X2=30
 .D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_"^"_$$DT^XLFDT_"^DG*5.3*285 POST-INSTALL "_$S(I="MTIY":"record count",1:"filing errors")
 ;
EN ; begin processing...
 N %
 ; check status and if root checkpoint has not completed start clean up
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DGMTIDT")
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
 N DGMTIDT,DGDFN,STA,YR,FILERR,MTIEN
 ;
 I '$D(XPDNM) S DGMTIDT=-99999999
 I $D(XPDNM) S DGMTIDT=$$PARCP^XPDUTL("DGMTIDT"),DGDFN=$$PARCP^XPDUTL("DGDFN")
 S STA=$P($$SITE^VASITE,"^",3)
 F  S DGMTIDT=$O(^DGMT(408.31,"AS",1,3,DGMTIDT)) Q:'DGMTIDT!(DGMTIDT>-2980101)  D
 . S:'$D(DGDFN) DGDFN=0
 . S YR=$E(DGMTIDT,2,4)  ; get current mean test year
 . F  S DGDFN=$O(^DGMT(408.31,"AS",1,3,DGMTIDT,DGDFN)) Q:DGDFN=""  D
 . . N FILERR
 . . ;
 . . ; get primary means test for this year
 . . S NODE=$$LST^DGMTU(DGDFN,YR_"1231")
 . . ;
 . . ; - if primary means test has a STATUS of 'No Longer Required' and
 . . ; it has the same MEANS TEST DATE as the current test then delete
 . . ; all 'No Longer Required' tests for this date except the primary
 . . ; test.
 . . ; - otherwise, delete all 'No Longer Required' means test for this
 . . ; date except the last entry.
 . . I $P(NODE,U,4)="N",($P(NODE,U,2)=-DGMTIDT) S MTIEN=+NODE
 . . E  S MTIEN=$O(^DGMT(408.31,"AS",1,3,DGMTIDT,DGDFN,""),-1)
 . . D DELMT(DGMTIDT,DGDFN,MTIEN,.FILERR)
 . . ;
 . . ; If 'No Longer Required' test then change 'Required' 
 . . ; primary test for next Means Test year to Non-Primary and update
 . . ; STATUS of means test for current date 
 . . D RQ2NPRM(-DGMTIDT,DGDFN,STA,YR,NODE,.FILERR)
 . . ;
 . . ; if error then update temporary store
 . . I $G(FILERR) M ^XTMP("DG-MTERR")=FILERR
 . . ; update check point with patient ID
 . . I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDFN",DGDFN)
 . ; update check point with means test inverse date
 . I $D(XPDNM) S %=$$UPCP^XPDUTL("DGMTIDT",DGMTIDT)
 ;
 ; send mailman msg to user/HEC with results
 D MAIL^DG53285M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("DGMTIDT")
 D MES^XPDUTL(" >>purge process completed "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
 ;
DELMT(MTIDT,DFN,ENTR,ERRS) ;
 ; Input:
 ;   MTIDT   - Inverse Means Tets Date
 ;   DFN     - Patient identifier
 ;   ENTR    - Entry # to ignore
 ;   ERRS    - DBS file error {by reference}
 ;
 N IEN,ERR
 ;
 S IEN=0
 F  S IEN=$O(^DGMT(408.31,"AS",1,3,MTIDT,DFN,IEN)) Q:IEN=""  D
 . Q:IEN=ENTR
 . I '$$EN^IVMCMD(IEN) S ERRS(408.31,IEN,"ALL")="Unable to delete means test" Q
 . ; increment purged count for income year
 . D COUNT(MTIDT)
 Q
 ;
RQ2NPRM(IDT,DFN,STA,YR,NODE,ERRS) ; change Required test to NON primary
 ;
 ; Input:
 ;   IDT     - Means Test Date
 ;   DFN     - Patient identifier
 ;   ERRS    - DBS file error {by reference}
 ;   STA     - Station number
 ;   YR      - Means Test year
 ;   NODE    - Last Primary test prior to end of Means Test year (YR)
 ;
 N NODE1,NODE2,DATA,REC31,ERR,DGADDF,DGREQF
 ;
 ; get primary test for next year
 S NODE1=$$LST^DGMTU(DFN,YR+1_"1231")
 ;
 ; 1. if there is no Primary test for the year in which the 
 ;    remaining 'No Longer Required' test began then make it
 ;    primary. 
 ; 2. if primary means test for for subsequent year is Required,
 ;    is within 365 days of current means test date and this site
 ;    conducted test then make primary means test NON primary.
 ; 3. if this site conducted test then change check if test
 ;    is required. If it is required then the STATUS of the
 ;    single remaining No Longer Required means test for this date
 ;    will equal the value of the TEST-DETERMINED STATUS.
 ;
 ; (1) determine is 'No Longer Required' test should be primary
 S REC31=$O(^DGMT(408.31,"AS",1,3,-IDT,DFN,""))
 I +REC31,(+$E($P(NODE,U,2),1,3)<$E($P(^DGMT(408.31,REC31,0),U),1,3)) D
 . S DATA(2)=1
 . I '$$UPD^DGENDBS(408.31,REC31,.DATA,.ERR) S:$D(ERR) ERRS(408.31,REC31,2)=ERR
 .
 ; (2) determine if subsequent year test should be Non primary
 I $P(NODE1,U,2)>(YR_1231),($P(NODE1,U,4)="R"),$$SCOPE($P(NODE1,U,2),IDT) D
 . ; set REQUIRED test to NON primary
 . S DATA(2)=0
 . I '$$UPD^DGENDBS(408.31,+NODE1,.DATA,.ERR) S:$D(ERR) ERRS(408.31,+NODE1,2)=ERR Q
 ;
 ; (3) Check if remaining No Longer Required test for this date is 
 ; Required
 Q:REC31=""
 S NODE2=$G(^DGMT(408.31,REC31,2))
 Q:$P(NODE2,U,5)'=STA
 D REQ(DFN,REC31,3,IDT)
 Q
 ;
SCOPE(X1,X2) ; Check if dates within 365 days of one another
 D ^%DTC
 I X>365 Q 0
 E  Q 1
 Q
 ;
COUNT(DATE) ; update process tracking mechanisms...
 ; Input:
 ;   DATE = inverse date from "AS" x-ref in 408.31
 ;
 N %,IY
 S IY=$E(DATE,2,4)-1
 S ^XTMP("DG-MTIY",IY)=+$G(^XTMP("DG-MTIY",IY))+1
 Q
 ;
REQ(DFN,DGMTI,DGCS,IDT) ; Determine if test is Required
 ;
 ; ** amended copy of EN^DGMTR as check for latest Primary **
 ; ** test is not valid for this cleanup.                  **
 ;
 ; Input:
 ;  DFN     - Patient ID
 ;  DGMTI   - Annual Means Test IEN
 ;  DGCS    - Annual Means Test Status
 ;  IDT     - Means Test Date
 ;
 ; Output:
 ;  DGREQF  - Means Test Require Flag
 ;                   (1 if required and 0 if not required)
 ;  DGDOM1  -  DOM Patient Flag (defined and set to 1 if
 ;                               patient currently on a DOM ward)
 ;
 N DGDOM,DGMT0,DGMTYPT,OLD,DGRGAUTO,DGQSENT,DGMSGF
 ;
 S (DGMSGF,DGQSENT,DGREQF)=0,(OLD,DGMTYPT)=1
 I $D(^DPT(DFN,.36)) S X=^(.36) D
 . I $P($G(^DIC(8,+X,0)),"^",9)=5!($$SC^DGMTR(DFN)) S DGREQF=1
 . I $P(X,"^",2),$P(X,"^",2)<3 S DGREQF=0
 I DGREQF S:$G(^DPT(DFN,.38)) DGREQF=0
 I DGREQF D DOM^DGMTR S:$G(DGDOM) DGREQF=0
 S DGMT0=$G(^DGMT(408.31,DGMTI,0))
 I DGCS S OLD=$$OLD^DGMTU4(IDT)
 ;
 D
 .I DGREQF,DGCS=3,'OLD D REQ^DGMTR Q
 .I DGREQF,'$G(DGADDF),(('DGCS)!(OLD)) D ADD^DGMTR Q
 .I 'DGREQF,DGCS,DGCS'=3,'$G(DGDOM) D NOL^DGMTR Q
 ;
 ;be sure to check whether or not patient is subject to RX copay!
 ;
 D EN^DGMTCOR
 Q
