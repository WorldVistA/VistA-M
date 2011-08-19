SCRPBK2 ;MJK/ALB - RPC Broker Utilities ; 27 FEB 96
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;
SAVE(SCDATA,SCQDEF) ; -- save query definition
 ;
 ; -- SCDATA(0) -> <1 - success> ^ <new query ien> ^ <reload client>
 ;              -> <0 - errors found> ^ <number of errors>
 ;      (1...n) -> error text
 ;
 ; -- SEE BOTTOM OF SCRPBK FOR VARIABLE DEFINITIONS
 ;
 ; Related RPC: SCRP QUERY SAVE
 ;
 N SCQREC,SCERR,SCIENS,SCSTAT,SCVM,SCLOG,SCERS,DIERR,SCPROC
 S SCPROC="Save Template"
 D PARSE^SCRPBK5(.SCQDEF,.SCQREC)
 ;
 ; -- do full validation mode(SCVM) check
 S SCVM="FULL",SCLOG="SCDATA"
 D VALCHK^SCRPBK4(SCLOG,.SCQREC,SCVM)
 IF $G(DIERR) D  G SAVEQ
 . D HDREC^SCUTBK3(.SCDATA,DIERR,"Save Template Validation Check")
 ;
 ; -- try to save record and get status of save
 S SCSTAT=$$SAVEREC(.SCQREC,.SCIENS,.SCERR)
 IF SCSTAT D
 . S SCDATA(0)=1_U_$S(SCQREC("QUERYID")="+1":+$G(SCIENS(1)),1:"")_U_$P(SCSTAT,U,2)
 ELSE  D
 . D ERRCHK^SCUTBK3(.SCDATA,.SCERR,SCPROC)
SAVEQ Q
 ;
SAVEREC(SCQREC,SCIENS,SCERR) ; -- actual save process
 N SCFILE,SCFDA,SCDFDA,SCQRY,SCNEW,SCMOD
 S SCFILE=404.95
 S SCFDA="SCFDA",SCDFDA="SCDFDA",SCERR="SCERR",SCIENS="SCIENS"
 S SCQRY=SCQREC("QUERYID")
 ;
 ; -- strip out data not needed
 ;    SCMOD = 1 means some stripping occurred and query needs to reload
 S SCMOD=$$STRIP(.SCQREC)
 ;
 D FDA^DILF(SCFILE,SCQRY_",",.01,"",SCQREC("NAME"),SCFDA,SCERR)
 D FDA^DILF(SCFILE,SCQRY_",",.02,"",SCQREC("CREATORID"),SCFDA,SCERR)
 D FDA^DILF(SCFILE,SCQRY_",",.03,"",SCQREC("ACCESSID"),SCFDA,SCERR)
 D FDA^DILF(SCFILE,SCQRY_",",.04,"",SCQREC("REPORTID"),SCFDA,SCERR)
 D FDA^DILF(SCFILE,SCQRY_",",.05,"",$$NOW^XLFDT(),SCFDA,SCERR)
 IF $D(SCQREC("DESCRIPTION")) D
 . D FDA^DILF(SCFILE,SCQRY_",",10,"",$NA(SCQREC("DESCRIPTION")),SCFDA,SCERR)
 ; -- is this a new record?
 S SCNEW=$S(SCQRY="+1":1,1:0)
 D SAVFLD(.SCQREC,.SCFDA,.SCDFDA,.SCERR,.SCNEW)
 D SAVSEL(.SCQREC,.SCFDA,.SCDFDA,.SCERR,.SCNEW)
 ;
 ; -- process any deletions (SCDFDA array holds deletion FDA)
 IF $D(SCDFDA)>10 D
 . D FILE^DIE("K",SCDFDA,SCERR)
 ;
 ; -- process new items and changes
 IF SCNEW D
 . D UPDATE^DIE("",SCFDA,SCIENS,SCERR)
 ELSE  D
 . D FILE^DIE("K",SCFDA,SCERR)
 ;
 ; -- ret := <success 0/1> ^ <unneeded data automatically stripped out>
SAVERECQ Q '$G(SCERR("DIERR"))_U_SCMOD
 ;
SAVFLD(SCQREC,SCFDA,SCDFDA,SCERR,SCNEW) ;
 ; -- determine which fields were changed or deleted
 ;
 N SCUR,SCAN,SCQRY,SCI,SCFLD
 S SCQRY=SCQREC("QUERYID")
 ;
 ; -- scan fields multiple and build array
 S SCI=0
 F  S SCI=$O(^SD(404.95,SCQRY,"FIELDS",SCI)) Q:'SCI  S X=$G(^(SCI,0)) D
 . IF $D(^SD(404.93,+X,0)) S SCAN($P(^(0),U,2))=SCI_U_$P(X,U,2)
 ;
 ; -- delete fields not passed down and set delete fda
 S SCFLD=""
 F  S SCFLD=$O(SCAN(SCFLD)) Q:SCFLD=""  IF '$D(SCQREC("FIELDS",SCFLD)) D
 . D FDA^DILF(404.9502,+SCAN(SCFLD)_","_SCQRY_",",.01,"","@",SCDFDA,SCERR)
 ;
 ; -- set fda for changes
 S SCFLD=""
 F  S SCFLD=$O(SCQREC("FIELDS",SCFLD)) Q:SCFLD=""  D
 . N SCVAL,SCFLDI,SCIEN,SCUR
 . S SCVAL=SCQREC("FIELDS",SCFLD)
 . S SCFLDI=+$O(^SD(404.93,"C",SCFLD,0))
 . S SCUR=$G(SCAN(SCFLD))
 . S SCIEN=+SCUR IF 'SCIEN S SCNEW=SCNEW+1,SCIEN="+"_SCNEW
 . IF SCIEN="+1"!($P(SCUR,U,2)'=SCVAL) D
 . . D FDA^DILF(404.9502,SCIEN_","_SCQRY_",",.01,"",SCFLDI,SCFDA,SCERR)
 . . D FDA^DILF(404.9502,SCIEN_","_SCQRY_",",.02,"",SCVAL,SCFDA,SCERR)
 Q
 ;
SAVSEL(SCQREC,SCFDA,SCDFDA,SCERR,SCNEW) ;
 ;  -- determine which file selections were changed or deleted
 ;
 N SCUR,SCAN,SCQRY,SCI,SCSEL,SCTYPE,SCHIT
 S SCQRY=SCQREC("QUERYID")
 ; -- scan fields and build array
 S SCI=0
 F  S SCI=$O(^SD(404.95,SCQRY,"FILES",SCI)) Q:'SCI  S X=$G(^(SCI,0)) D
 . S SCAN($P(^(0),U))=SCI
 ;
 ; -- delete fields not passed down
 S SCSEL=""
 F  S SCSEL=$O(SCAN(SCSEL)) Q:SCSEL=""  D
 . S SCTYPE="",SCHIT=0
 . F  S SCTYPE=$O(SCQREC("SELECTIONS",SCTYPE)) Q:SCTYPE=""  IF $D(SCQREC("SELECTIONS",SCTYPE,SCSEL)) S SCHIT=1 Q
 . D:'SCHIT FDA^DILF(404.9503,+SCAN(SCSEL)_","_SCQRY_",",.01,"","@",SCDFDA,SCERR)
 ;
 ; -- set fda
 S SCTYPE=""
 F  S SCTYPE=$O(SCQREC("SELECTIONS",SCTYPE)) Q:SCTYPE=""  D
 . S SCSEL=""
 . F  S SCSEL=$O(SCQREC("SELECTIONS",SCTYPE,SCSEL)) Q:SCSEL=""  IF '$D(SCAN(SCSEL)) D
 . . S SCNEW=SCNEW+1,SCIEN="+"_SCNEW
 . . D FDA^DILF(404.9503,SCIEN_","_SCQRY_",",.01,"",SCSEL,SCFDA,SCERR)
 Q
 ;
DELETE(SCDATA,SCQDEF) ; -- delete a query record
 ;
 ; -- SCDATA(0) -> <1 - success> ^
 ;              -> <0 - errors found> ^ <number of errors>
 ;      (1...n) -> error text
 ;
 ; -- SEE BOTTOM OF SCRPBK FOR VARIABLE DEFINITIONS
 ;
 ; Related RPC: SCRP QUERY DELETE
 ;
 N SCQREC,DIERR,SCLOG
 S SCLOG="SCDATA"
 D PARSE^SCRPBK5(.SCQDEF,.SCQREC)
 D DELCHK(SCLOG,.SCQREC)
 D HDREC^SCUTBK3(.SCDATA,$G(DIERR),"Template Deletion")
 IF SCDATA(0) D DELREC(.SCQREC)
 Q
 ;
DELCHK(SCLOG,SCQREC) ; -- check to see if query can be deleted
 ; -- is the query being used as a default by any user?
 ;
 N SCQRY,PARAM
 S SCQRY=SCQREC("QUERYID")
 IF SCQRY=+SCQRY,'$D(^SCRS(403.35,"AC",SCQRY)) D  G DELCHKQ
 . Q
 ELSE  D
 . S SCPARM("QUERY NAME")=SCQREC("NAME")
 . D BLD^DIALOG(4035002.001,.SCPARM,"",SCLOG,"S")
DELCHKQ Q
 ;
DELREC(SCQREC) ; -- actually delete query record
 N DIK,DA,X
 S DIK="^SD(404.95,",DA=SCQREC("QUERYID") D ^DIK
 Q
 ;
NAME(SCDATA,SCQNAME,SCUSER) ;
 ; -- check to see if user has a query with same name
 ; 
 ; input: SCQNAME -> query name
 ;        SCUSER  -> user id (DUZ)
 ;output: SCDATA(1) -> 0 means no query with that name found
 ;                  -> <n> means query with that name found has this ien
 ; -- SEE BOTTOM OF SCRPBK FOR VARIABLE DEFINITIONS
 ;
 ; Related RPC: SCRP QUERY CHECK NAME
 ;
 N SCERR,SCDUP
 IF $$NAMECHK(.SCQNAME,.SCUSER,.SCERR,.SCDUP) D
 . S SCDATA(1)=0
 ELSE  D
 . S SCDATA(1)=SCDUP
 Q
 ;
NAMECHK(SCQNAME,SCUSER,SCERR,SCDUP) ; -- actuallt scan xref for query name
 N SCOK,SDI
 S SCOK=1,SCI=0
 F  S SCI=$O(^SD(404.95,"AC",SCUSER,SCI)) Q:'SCI  D  Q:'SCOK
 . IF SCQNAME=$P($G(^SD(404.95,SCI,0)),U) S SCOK=0,SCDUP=SCI
 Q SCOK
 ;
STRIP(SCQREC) ; -- strip out inappropriate data for report type
 N I,X,SCAN,SCFLD,SCMOD
 S SCMOD=0
 D GETFLDS(+SCQREC("REPORTID"),.SCAN)
 S SCFLD=""
 F  S SCFLD=$O(SCQREC("FIELDS",SCFLD)) Q:SCFLD=""  D
 . IF '$D(SCAN(SCFLD)) K SCQREC("FIELDS",SCFLD) S SCMOD=1
 ;
 K SCAN
 D GETYPE(+SCQREC("REPORTID"),.SCAN)
 S SCTYPE=""
 F  S SCTYPE=$O(SCQREC("SELECTIONS",SCTYPE)) Q:SCTYPE=""  D
 . IF '$D(SCAN(SCTYPE)) K SCQREC("SELECTIONS",SCTYPE) S SCMOD=1
 Q SCMOD
 ;
GETFLDS(RPTID,SCAN) ; -- build array of fields used/needed by report
 N SCI,SCX
 S SCI=0
 F  S SCI=$O(^SD(404.92,RPTID,"FIELDS",SCI)) Q:'SCI  S SCX=$G(^(SCI,0)) D
 . IF $D(^SD(404.93,+SCX,0)) S SCAN($P(^(0),U,2))=SCX
 Q
 ;
GETYPE(RPTID,SCAN) ; -- build array of files used/needed by report
 N SCI,SCX
 S SCI=0
 F  S SCI=$O(^SD(404.92,RPTID,"FILES",SCI)) Q:'SCI  S SCX=$G(^(SCI,0)) D
 . S SCTYPE=$$TYPE^SCRPBK(+SCX)
 . IF $$CHKTYPE(SCTYPE) S SCAN(SCTYPE)=SCX
 Q
 ;
CHKTYPE(SCTYPE) ; -- special checks to see if file type is ok to use
 N SCOK S SCOK=1
 IF SCTYPE="" S SCOK=0
 ;
 ; -- is site using user class relationship in PCMM?
 IF SCTYPE="USERCLASS",'$P($G(^SD(404.91,1,"PCMM")),U) S SCOK=0
 Q SCOK
 ;
