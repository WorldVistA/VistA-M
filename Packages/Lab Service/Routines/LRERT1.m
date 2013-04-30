LRERT1 ;DALOI/JDB - STS TEAM UTILITIES ;04/10/12  15:38
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Reference to LABXCPT^HDISVAP1 supported by DBIA #5026
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 Q
 ;
TASK(LRFN,LRIEN) ;
 ; Tasks the STS/HDI alert process to ensure FileMan safety.
 ; Expects X1 and X2 FileMan arrays from Record based xref.
 ; Inputs
 ;   LRFN: File number
 ;  LRIEN: IEN
 ;
 ;ZEXCEPT: X1,X2
 ;
 N LRTN,LRVARS,LRX,LRVARS,LRX1,LRX2
 M LRX1=X1
 M LRX2=X2
 S LRTN="AERT^LRERT1("_LRFN_","_LRIEN_")"
 S LRVARS("LRX1(")="" ;Old values
 S LRVARS("LRX2(")="" ;New values
 S LRX=$$TASK^LRUTIL(LRTN,"Generate STS alert from xref",.LRVARS,1,$H,"")
 Q
 ;
 ;
AERT(LRFN,LRIEN) ;
 ; "AERT" new style xref handler (file #61, 61.2, 62)
 ; FileMan safe
 ; New style, MUMPS Action, Activity:null, Execution:Record
 ; Sequence 1 = .01  Sequence 2 = SNOMED CT
 ;PATCH^XPDUTL/10141
 ; Inputs
 ;   LRFN: File number
 ;  LRIEN: IEN
 ; To be 100% FileMan safe, this process should be queued.
 ; If this term is already in the alert file ^XTMP("LRSCTX-STS" and the SCT code has not changed, no alert is sent.
 ;
 ;ZEXCEPT: LRX1,LRX2,ZTQUEUED,ZTREQ
 ;
 ; Not being added/changed by user so quit
 Q:$D(LRFMERTS)
 ;
 N LRERT,LRNOW,LRTXT
 S LRFN=$G(LRFN),LRIEN=$G(LRIEN)
 I 'LRFN!('LRIEN) Q
 S LRTXT=$G(LRX2(1))
 S LRNOW=$$NOW^XLFDT()
 S LRERT("FILE")=LRFN
 S LRERT("FIEN")=LRIEN
 S LRERT("TNUM")=$$TNUM^LRERT(LRFN,LRIEN,LRNOW,3) ;3=local change
 S LRERT("SCT")=$G(LRX2(2))
 S LRERT("TDT")=LRNOW
 S LRERT("STSEXC")=3 ;local change
 S LRERT("PREV","TEXT")=$G(LRX1(1))
 S LRERT("PREV","SCT")=$G(LRX1(2))
 D  ;
 . N X,X1,X2,Y,DA,DIE,DIC,DIR,D0,DIU,LRX
 . S LRX=$$OK2LOG^LRERT(.LRTXT,.LRERT,"LRSCTX-ERT")
 . I 'LRX I $P(LRX,"^",2)'=2 Q  ;continue if SCT changed
 . S LRX=$$LOGIT^LRERT(.LRTXT,.LRERT,"LRSCTX-STS")
 . S LRX=$$NOTIFY(.LRTXT,.LRERT)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ;
NOTIFY(LRTXT,LRERT) ;
 ;
 ; Private helper method
 ; FileMan safe
 ; Handles STS/Local notification for "local edit" new terms.
 ; If a new term has been added and not in ^XTMP:
 ;  1) alert STS  2) Add entry to ^XTMP  3) Email LAB MAPPING group
 ; Inputs
 ;   LRTXT: Term
 ;   LRERT:<byref>
 ; Outputs
 ;  String indicating success or error: Status^Error code^text
 ;     Status: 1=success  0=error
 ;  ie  "0^1^Term is null"  "0^4^"STS & MailMan error"
 ;
 ;ZEXCEPT: LRFIEN,LRFILE,LRSCT,NODE
 ;
 N DATA,DATA2,LRLCK,STOP,STR,STR2,NOTIFY,SITE
 N TNUM,TMPNM,TEXT,I,II,X,Y,LRHDI,LRHDIERR,TSTAT,TDT
 N DA,DR,DIE,DIR,DIC,X,X1,X2,Y,DIERR
 S LRTXT=$G(LRTXT)
 I $TR(LRTXT," ","")="" Q "0^1^Term is null"
 S LRFILE=$G(LRERT("FILE")),LRFIEN=$G(LRERT("FIEN")),LRSCT=$G(LRERT("SCT"))
 S NOTIFY=1 ;status of this process
 S TMPNM="LRSCTX-STS"
 S TDT=$G(LRERT("TDT"))
 I TDT="" S TDT=$$NOW^XLFDT() S LRERT("TDT")=TDT
 ; TSTAT  0=New record  1=Text changed  2=Text same
 S TSTAT=$G(LRERT("PREV","TEXT"))'=""
 I TSTAT I $G(LRERT("PREV","TEXT"))=LRTXT S TSTAT=2
 S TNUM=$G(LRERT("TNUM"))
 ;
 ; STS Reporting Array
 K DATA,LRHDI
 S LRHDI(3,1)=TNUM_"^"_TDT
 S X=$$BLDERTX^LRERT(LRFILE,LRFIEN,"|",.DATA,2,"S") ;new data
 M LRHDI(3,1,"SA")=DATA
 ;
 ; build a pseudo "before" data
 I TSTAT D
 . M LRHDI(3,1,"SB")=DATA
 . S LRHDI(3,1,"SB",2)=$G(LRERT("PREV","TEXT"))
 . S LRHDI(3,1,"SB",5)=$G(LRERT("PREV","SCT"))
 . S LRHDI(3,1,"SB",6)="" ;SCT text
 . S X=$G(LRERT("PREV","SCT"))
 . I X'="" D  ;
 . . K DATA
 . . S X=$$CODE^LRSCT(X,"SCT","","DATA")
 . . S LRHDI(3,1,"SB",6)=$G(DATA("F"))
 ;
 K DATA
 ;
 S X=$S(TSTAT:"modified in",1:"added to")
 S LRHDI(3,1,"TXT")="Term "_X_" file #"_LRFILE_" (entry #"_LRFIEN_")"
 ;
 D LABXCPT^HDISVAP1("LRHDI")
 ; check LRHDI("ERROR") and add error to local email
 K LRHDIERR
 M LRHDIERR("ERROR")=LRHDI("ERROR")
 K LRHDI
 I $D(LRHDIERR) S NOTIFY="0^2^HDI error"
 ;
 ; Update ^XTMP
 S LRERT("HDIERR")=$S($D(LRHDIERR):1,1:0)
 S X=$$LOGIT^LRERT(LRTXT,.LRERT)
 ;
 ; Notify local staff of event (G.LAB MAPPING)
 N DA,DIE,DIC,DIR,D0,DIFROM,LRMTXT,X,X1,X2,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,XMMG
 ;
 S XMSUB="Local modification to file (#"_LRFILE_":"_LRFIEN_")"
 S X=$S(TSTAT:"modified in",1:"added to")
 S LRMTXT(1,0)="Term "_X_" file #"_LRFILE_" (entry #"_LRFIEN_")"
 S LRMTXT(2,0)=" "
 I TSTAT=1 S LRMTXT(3,0)="Previous Text: "_$G(LRERT("PREV","TEXT"))
 S LRMTXT(4,0)=$S('TSTAT:"New Text",1:"Term")_": "_LRTXT
 S X=$S(TSTAT:"Modified",1:"Added")
 S LRMTXT(5,0)=X_" by: "_$$UP^XLFSTR($$NAME^XUSER(DUZ,"F"))
 S LRMTXT(6,0)=" "
 S LRMTXT(7,0)="Tracking information below:"
 S LRMTXT(8,0)="Transaction date: "_$$FMTE^XLFDT(TDT)
 S LRMTXT(9,0)="Transaction number: "_TNUM
 S LRMTXT(10,0)="SNOMED CT code: "_$S(LRSCT'="":LRSCT,1:"n/a")
 I $G(LRERT("PREV","SCT"))'="" D  ;
 . S X=LRERT("PREV","SCT")
 . I X'=$G(LRERT("SCT")) S LRMTXT(11,0)="Previous SNOMED CT code: "_X
 ;
 I $D(LRHDIERR) D  ;
 . S LRMTXT(20,0)=" "
 . S LRMTXT(21,0)="An error occurred when notifying STS:"
 . S NODE="LRHDIERR(0)"
 . S I=$O(LRMTXT("A"),-1)
 . F  S NODE=$Q(@NODE) Q:NODE=""  S I=I+1,LRMTXT(I,0)="    "_NODE
 ;
 I $$GOTLOCAL^XMXAPIG("LAB MAPPING") S XMY("I:G.LAB MAPPING")=""
 E  S XMY("I:G.LMI")=""
 ;
 S XMTEXT="LRMTXT("
 D ^XMD
 I $D(XMMG)!'$G(XMZ) D  ;
 . I $D(LRHDIERR) S NOTIFY="0^4^STS & Mailman error" Q
 . S NOTIFY="0^3^MailMan error"
 ;
 ; Update and store this transaction info in the target file.
 D SCTUPD
 ;
 Q NOTIFY
 ;
 ;
SCTUPD ; Update SCT STATUS DATE multiple
 ;
 ;ZEXCEPT: LRDUZ,LRFILE,LRFIEN,TDT,TNUM
 ;.
 N LRERR,LRFDA,LRFLD,LRSUBFILE,LRSTATUS
 ;
 S LRSUBFILE=$S(LRFILE=61:61.023,LRFILE=61.2:61.223,LRFILE=62:62.023,1:"")
 I LRSUBFILE="" Q
 ;
 ; Store date/time, user and new status
 S LRFDA(2,LRSUBFILE,"+2,"_LRFIEN_",",.01)=TDT
 S LRSTATUS=$$GET1^DIQ(LRFILE,LRFIEN_",",21,"I")
 S LRFDA(2,LRSUBFILE,"+2,"_LRFIEN_",",1)=$S(LRSTATUS'="":LRSTATUS,1:"R")
 S LRFDA(2,LRSUBFILE,"+2,"_LRFIEN_",",3)=$S($G(LRDUZ):LRDUZ,1:DUZ)
 ;
 ; Store transaction number
 S LRFDA(2,LRSUBFILE,"+2,"_LRFIEN_",",2)=TNUM
 ;
 D UPDATE^DIE("","LRFDA(2)","LRFIEN","LRERR(2)")
 ;
 ; Store execption text in WP field
 D WP^DIE(LRSUBFILE,LRFIEN(2)_","_LRFIEN_",",4,"A","LRMTXT","LRERR(3)")
 ;
 Q
