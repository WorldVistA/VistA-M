LRSCTF ;DAL01/JMC - STORE STS MAPPING IN PARENT FILE ;02/08/12  15:25
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 Q
 ;
LD(LRINST,LROVER) ;  Load STS mapping into SCT encoded files
 ; Call with LRINST = #4 IEN
 ;           LROVER<opt> Its a do-over
 ;
 N LRABORT,LRCNT,LRFDA,LRFIEN,LRFILE,LRFLD,LRHIER,LRHIERX,LRI,LRIEN,LRJ,LRNOW,LRNODE,LROK,LRRECORDFORMAT,LRQUIET,LRSCT,LRSFILE,LRSN,LRSTATUS,LRSTR,LRSTRF,LRTX,LRTXT,LRTXTY,LRX,LRY
 N CNT,DIQUIET,I,TMPNM,X,Y
 ;
 ; Prevent FileMan from issuing any unwanted WRITE(s).
 S (DIQUIET,LRQUIET)=1
 ; Insure DT and DILOCKTM is defined
 D DT^DICRW
 ;
 I $G(LRINST)<1 Q
 ;
 S X=$$NS^XUAF4(LRINST),LRINST(1)=$P(X,"^",1),LRINST(2)=$P(X,"^",2)
 S LROVER=+$G(LROVER)
 S LRNOW=$$HTFM^XLFDT($H),LRABORT=0
 ;
 D BMES($S($G(LROVER):"RELOADING",1:"Loading")_" files with National SNOMED CT Codes")
 ;
 S TMPNM="LRSCTF-ERR"
 K ^XTMP(TMPNM)
 S ^XTMP(TMPNM,0)=$$HTFM^XLFDT($H+180,1)_U_DT_U_$S(LROVER:"OVERLAY ",1:"")_"LAB SCT MAPPING ERRORS"_U_$$FMTE^XLFDT($$NOW^XLFDT(),"1Z")
 ;
 I '$D(^LAHM(95.4,"AC",LRINST)) D  Q
 . S X="No data for "_LRINST(1)_" found in transport file"
 . W ! D BMES(X)
 . S ^XTMP(TMPNM,1)=X
 ;
 D GET954
 I LRABORT Q
 ;
 ; Purge those entries that were successfully processed.
 D PURGE^LRSRVR5(1)
 ;
 Q
 ;
 ;
GET954 ; Search cross reference of institution entries
 ;
 ;ZEXCEPT: LRABORT,LRCNT,LRIEN,LRINST,LRNODE,LROK,LROVER,LRSFILE,ZTQUEUED
 ;
 ; Get and lock file while processing.
 L +^LAHM(95.4,0):DILOCKTM+15
 I '$T S LRABORT=1 Q
 ;
 S (LRCNT,LRIEN)=0,LRSFILE=""
 F  S LRIEN=$O(^LAHM(95.4,"AF","SCT",LRIEN)) Q:LRIEN<1  D
 . S LRCNT=LRCNT+1
 . I '(LRCNT#100) H 1 ; take a "rest" - allow OS to swap out process
 . I '$D(ZTQUEUED) W:'(LRCNT#50) "."
 . K LRNODE
 . S LRNODE(0)=$G(^LAHM(95.4,LRIEN,0))
 . I LRNODE(0)="" Q
 . I '$G(LROVER),$P(LRNODE(0),"^",4)>0 Q
 . I DUZ("AG")="V",$P(LRNODE(0),"-",1)'=LRINST(2) Q
 . D LDPARS
 . I $G(LROK) D LEX
 ;
 ; Unlock transport global.
 L -^LAHM(95.4,0)
 Q
 ;
 ;
LDPARS ;
 ; Parse the data
 ;
 ;ZEXCEPT: LRFIEN,LRFILE,LRFLD,LRNODE,LROK,LRRECORDFORMAT,LRSCT,LRSFILE,LRSN,LRTXTY
 ;
 N LRFNAME,LRMSG
 S LROK=0
 S LRFILE=$P($P(LRNODE(0),U),"-",2) ;^LAB(FILE
 S LRFNAME=$$GET1^DID(LRFILE,"","","NAME","","LRMSG")
 I LRFILE'=LRSFILE D
 . D BMES(" "),BMES("*************************************************")
 . D BMES("Loading file #"_LRFILE_" [ "_LRFNAME_" ]")
 . D BMES("*************************************************")
 . S LRSFILE=LRFILE
 K LRFIEN
 S LRFIEN=$P($P(LRNODE(0),U),"-",3) ; IEN
 D RETRIEVE
 ; Entry name
 S LRTXTY=LRFLD(2)
 ;
 ; Legacy SNOMED I Code
 I LRFLD(3)?1U1"-"1.AN S LRSN=$P(LRFLD(3),"-",2)
 E  S LRSN=LRFLD(3)
 ;
 ; SNOMED CT code
 S LRSCT=""
 I LRRECORDFORMAT=1 S LRSCT=LRFLD(5)
 I LRRECORDFORMAT=2 S LRSCT=LRFLD(4)
 ;
 I LRFILE,LRFIEN,LRTXTY'="" S LROK=1
 Q
 ;
 ;
LEX ; Validate SCT code, get concept and term
 ; Only check those SCT codes if STS has mapped the term to SCT
 ;
 ;ZEXCEPT: LRFIEN,LRFILE,LRHIER,LRHIERX,LRSCT,LRSTATUS,LRTXTY
 ;
 N LRFS,LRERR,LRSTRF,LRY,LRX
 K LRSTATUS
 S (LRSTATUS,LRHIERX)=""
 S LRFS=3,LRX=0
 ;
 S LRSTRF=$G(^LAB(LRFILE,LRFIEN,0)),LRSTRF("SCT")=$G(^LAB(LRFILE,LRFIEN,"SCT"))
 I LRSTRF="" D  Q
 . D LDERR("No such entry: File #"_LRFILE_" IEN:"_LRFIEN)
 . D LD954
 ;
 I LRSCT S LRX=$$CODE^LRSCT(LRSCT,"SCT",DT,"LRY")
 ; If new term store SCT code only and change status to new code awaiting Lexcion update
 ; Otherwise if not new term then log error.
 I LRSCT,LRX<0 D
 . S LRSTATUS("ERR")=$P(LRX,"^",2),LRFS=2
 . N LRZ
 . S LRZ="SNOMED CT code "_LRSCT_" not on file"
 . I LRSTATUS("ERR")=LRZ S LRSTATUS="LN" Q
 . D LD954,LDERR("Lexicon SCT lookup error") S LRSTATUS="E"
 ;
 I LRSCT,LRX>0 D
 . S LRHIER="SCT "_$$UP^XLFSTR($P(LRY(0),U,2))
 . S LRHIERX=$$FIND1^DIC(64.061,,"X",LRHIER,"C",,"LRERR")
 . S LRSTATUS="L" ; Default [L] = The spelling is not standard
 . I LRTXTY=$$UP^XLFSTR($G(LRY("P"))) S LRSTATUS="P" ; preferred term
 . I LRSTATUS'="P",$O(LRY("S",0)) D  ; Check to see if term in a synonym
 . . N I
 . . S I=0
 . . F  S I=$O(LRY("S",I)) Q:I<1  I LRTXTY=$$UP^XLFSTR(LRY("S",I)) S LRSTATUS="S" Q
 ;
 D LDCK
 Q
 ;
 ;
LDCK ; Check target file to determine if mapping is correct
 ;
 ;ZEXCEPT: LRFS,LRSN,LRSTRF,LRTX,LRTXTY
 ;
 N LRMAPERR
 ;
 I LRSN'="",$P(LRSTRF,"^",2)'=LRSN S LRMAPERR="SNOMED I code does not match"
 ;
 S LRTX=$$TRIM^XLFSTR($P(LRSTRF,"^"),"LR"," ")
 I $$UP^XLFSTR(LRTXTY)'=$$UP^XLFSTR(LRTX) S LRMAPERR="Names do not match: ["_LRTX_" < - > "_LRTXTY_"]"
 ;
 I $G(LRMAPERR)'="" D  Q
 . S LRFS=3
 . D LDERR(LRMAPERR)
 . D SCTUPD ; ccr_7218n - Update SCT STATUS DATE multiple
 . D LD954
 ;
 ; Do file update
 D LDFILE
 Q
 ;
 ;
LDERR(LRERR) ;
 ; Populate error message text file ^XTMP("LRSCT-ERR"
 ; Send STS alert if needed.
 ;
 ;ZEXCEPT: LRFIEN,LRFILE,LRFLD,LRFS,LRIEN,LRSCT,LRTXTY,TMPNM
 ;
 N DATA,ERCNT,EXCDATA,I,LRX,TNUM,X
 D BMES(" "),BMES(LRERR)
 S ERCNT=$O(^XTMP(TMPNM,"A"),-1)+1
 S ^XTMP(TMPNM,ERCNT,0)=LRIEN_U_LRERR_U_LRFS
 S ^XTMP(TMPNM,ERCNT,1)=$G(^LAHM(95.4,LRIEN,0))
 S ^XTMP(TMPNM,ERCNT,2)=LRFLD(1)_"^"_LRFLD(2)_"^"_LRFLD(3)_"^"_LRFLD(4)_"^"_LRFLD(5)
 ; LRFILE -- File #
 ; LRFIEN -- Entry IEN
 ;
 S I=0
 F  S I=$O(LRFLD(I)) Q:I<1  S EXCDATA("RD",I)=$G(LRFLD(I))
 ;
 ; Existing entry extract record
 S X=$$BLDERTX^LRERT(LRFILE,LRFIEN,"|",.DATA,2,"S")
 M EXCDATA("SA")=DATA
 ;
 ; Lab mapping exception
 S EXCDATA("TXT")=LRERR
 ;
 S X=$$NOTIFY^LRSCTF1(LRTXTY,LRFILE,LRFIEN,LRSCT,.EXCDATA)
 S TNUM=$G(EXCDATA("TNUM"))
 S ^XTMP(TMPNM,ERCNT,10)=TNUM
 I X D BMES("STS alert sent.")
 I 'X  D
 . S X=$P(X,"^",3)
 . D BMES("STS failure: "_X)
 . S ^XTMP(TMPNM,ERCNT,10,1)=X
 ;
 Q
 ;
 ;
BMES(MSG) ; Display message on screen and if during KIDS install store with install
 ;
 ;ZEXCEPT: XPDA,ZTQUEUED
 ;
 I $G(XPDA)>0 D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM)) Q
 I '$D(ZTQUEUED) W !,MSG
 Q
 ;
 ;
LDFILE ; Update target file
 ;
 ;ZEXCEPT: LRFIEN,LRFILE,LRFLD,LRFS,LRHIERX,LRNOW,LRRECORDFORMAT,LRSCT,LRSTATUS
 ;
 N LRFDA,LRERR,LRFMERTS,LRMAPERR,LRSUBFILE,LRX
 ;
 ; Lock file entry prior to updating
 F  L +^LAB(LRFILE,LRFIEN):DILOCKTM+15 Q:$T
 ;
 ; Stop AERT xref from triggering alert (from ^LRERT1)
 S LRFMERTS=1
 S LRFMERTS("STS","STAT")="OK"
 S LRFMERTS("STS","PROC")="LOAD"
 ;
 ; Check status if returned from STS and store in target file.
 I LRSTATUS="" D
 . I LRRECORDFORMAT=2 S LRSTATUS=$G(LRFLD(5)) Q
 . I LRRECORDFORMAT=1 S LRSTATUS=$G(LRFLD(4))
 ;
 ; Load new mapping/purge previous data
 S LRFDA(1,LRFILE,LRFIEN_",",20)=LRSCT
 S LRFDA(1,LRFILE,LRFIEN_",",21)=LRSTATUS
 S LRFDA(1,LRFILE,LRFIEN_",",22)=LRHIERX
 D FILE^DIE("","LRFDA(1)","LRERR(1)")
 I $D(LRERR(1)) D
 . D LDERR("Unable to file entry")
 . S LRMAPERR="FileMan FILE~DIE call failed: "_$G(LRERR(1,"DIERR",1))
 S LRFS=$S($D(LRERR):3,1:1)
 ;
 ; Update SCT STATUS DATE multiple
 D SCTUPD
 ;
 L -^LAB(LRFILE,LRFIEN)
 ;
 D LD954
 ;
 Q
 ;
 ;
RETRIEVE ; Retrieve mapping data from file #95.4
 ;
 ;ZEXCEPT: LRFLD,LRI,LRIEN,LRJ,LRNODE,LRRECORDFORMAT
 ;
 ; Record format 1
 ; Station #-File #-IEN|Entry Name|SNOMED I|STS_FURTHER_ACTION|STS_SCT_ID|STS_TYPE_OF_MATCH
 ; LRFIELDLABEL(1)="1:IDENTIFIER"
 ; LRFIELDLABEL(2)="2:ENTRY NAME"
 ; LRFIELDLABEL(3)="3:SNOMED I"
 ; LRFIELDLABEL(4)="4:STS_FURTHER_ACTION"
 ; LRFIELDLABEL(5)="5:STS_SCT_CODE"
 ; LRFIELDLABEL(6)="6:STS_TYPE_OF_MATCH"
 ;
 ; Record format 2
 ; Station #-File #-IEN|Entry Name|SNOMED I|SNOMED CT|STS_EXCEPTION|STS_EXCEPTION_REASON|TRANSACTION NUMBER
 ; LRFIELDLABEL(1)="1:IDENTIFIER"
 ; LRFIELDLABEL(2)="2:ENTRY NAME"
 ; LRFIELDLABEL(3)="3:SNOMED I"
 ; LRFIELDLABEL(4)="4:SNOMED CT"
 ; LRFIELDLABEL(5)="5:STS_EXCEPTION"
 ; LRFIELDLABEL(6)="6:STS_EXCEPTION_REASON"
 ; LRFIELDLABEL(7)="7:TRANSACTION NUMBER"
 ;
 N LRFIELDLABEL,LRX
 ;
 K LRFLD,LRI,LRJ
 S LRFLD(1)=$P(LRNODE(0),"^")
 F LRI=2:1:7 S LRFLD(LRI)="",LRFIELDLABEL(LRI)=""
 ;
 S LRI=0
 F  S LRI=$O(^LAHM(95.4,LRIEN,100,LRI)) Q:'LRI  D
 . S LRX=^LAHM(95.4,LRIEN,100,LRI,0)
 . S LRJ=$P($P(LRX,"^"),":")
 . S LRFIELDLABEL(LRJ)=$P(LRX,"^")
 . S LRFLD(LRJ)=^LAHM(95.4,LRIEN,100,LRI,100,1,0)
 ;
 ; Determine SCT record format
 ;    - check various fields since any one may not be sent.
 S LRRECORDFORMAT=2
 I LRFIELDLABEL(4)="4:SNOMED CT" Q
 I LRFIELDLABEL(5)="5:STS_EXCEPTION" Q
 I LRFIELDLABEL(6)="6:STS_EXCEPTION_REASON" Q
 I LRFIELDLABEL(7)="7:TRANSACTION NUMBER" Q
 ;
 ; Othewise set to old orignal format
 S LRRECORDFORMAT=1
 I LRFIELDLABEL(4)="4:STS_FURTHER_ACTION" Q
 I LRFIELDLABEL(5)="5:STS_SCT_CODE" Q
 I LRFIELDLABEL(6)="6:STS_TYPE_OF_MATCH" Q
 ;
 S LRRECORDFORMAT=0
 ;
 Q
 ;
 ;
LD954 ;
 ; Update transport file with status
 ;
 ;ZEXCEPT: LRFS,LRIEN,LRNOW
 ;
 N LRERR,LRFDA
 S LRFDA(2,95.4,LRIEN_",",4)=$S(LRFS=1:1,1:.7)
 S LRFDA(2,95.4,LRIEN_",",5)=$S(LRFS=0:"NOT LOADED",LRFS=1:"LOADED",LRFS=2:"LEXICON ERROR",LRFS=3:"MAPPING ERROR",1:"")
 S LRFDA(2,95.4,LRIEN_",",6)=LRNOW
 D FILE^DIE("","LRFDA(2)","LRERR")
 Q
 ;
 ;
SCTUPD ; Update SCT STATUS DATE multiple
 ;
 ;ZEXCEPT: LRDUZ,LRFILE,LRFIEN,LRFLD,LRMAPERR,LRNOW,LRRECORDFORMAT,LRSTATUS
 ;
 N LRERR,LRFDA,LRSUBFILE,LRWP
 ;
 S LRSUBFILE=$S(LRFILE=61:61.023,LRFILE=61.2:61.223,LRFILE=62:62.023,1:"")
 I LRSUBFILE="" Q
 ;
 ; Store date/time, user and new status
 S LRFDA(2,LRSUBFILE,"+2,"_LRFIEN_",",.01)=LRNOW
 S LRFDA(2,LRSUBFILE,"+2,"_LRFIEN_",",1)=LRSTATUS
 S LRFDA(2,LRSUBFILE,"+2,"_LRFIEN_",",3)=$S($G(LRDUZ):LRDUZ,1:DUZ)
 ;
 ; Store transaction number if any
 I LRRECORDFORMAT=2,$G(LRFLD(7))'="" S LRFDA(2,LRSUBFILE,"+2,"_LRFIEN_",",2)=LRFLD(7)
 ;
 D UPDATE^DIE("","LRFDA(2)","LRFIEN","LRERR(2)")
 ;
 ; Store execption text in WP field
 I LRRECORDFORMAT=1,$G(LRFLD(4))'="" S LRWP(1)="STS Exception: "_LRFLD(4)
 I LRRECORDFORMAT=2,$G(LRFLD(6))'="" S LRWP(1)="STS Exception: "_LRFLD(6)
 ;
 ; Record any reported Lexicon API error
 I $G(LRSTATUS("ERR"))'="" D
 . N LRCNT
 . S LRCNT=$O(LRWP(""),-1)+1
 . I LRCNT>1 S LRWP(LRCNT)=" ",LRCNT=LRCNT+1
 . S LRWP(LRCNT)="Lexicon API: "_LRSTATUS("ERR")
 ;
 I $G(LRMAPERR)'="" D  ; ccr_7218n
 . N LRCNT
 . S LRCNT=$O(LRWP(""),-1)+1
 . I LRCNT>1 S LRWP(LRCNT)=" ",LRCNT=LRCNT+1
 . S LRWP(LRCNT)="Mapping was not applied: "_LRMAPERR
 ;
 I $G(LRFLD(10000))'="" D
 . N LRCNT
 . S LRCNT=$O(LRWP(""),-1)+1
 . I LRCNT>1 S LRWP(LRCNT)=" ",LRCNT=LRCNT+1
 . S LRWP(LRCNT)="File used to apply mapping and/or disposition: "_LRFLD(10000)
 ;
 I $D(LRWP) D WP^DIE(LRSUBFILE,LRFIEN(2)_","_LRFIEN_",",4,"A","LRWP","LRERR(3)")
 ;
 Q
