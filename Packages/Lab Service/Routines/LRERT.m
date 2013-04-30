LRERT ;DALOI/JDB - STS TEAM UTILITIES ;06/10/09  14:44
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
BLDERTX(LRFILE,LRFIEN,LRDELIM,LRERT,LRTYPE,LRFLAGS) ;
 ; Constructs a string or array used for the ERT data extract
 ; FileMan safe
 ; Called by NOTIFY^LRSCTX1
 ; Inputs
 ;   LRFILE: File #
 ;   LRFIEN: Entry's IEN
 ;  LRDELIM: Delimiter to use <dflt=|>
 ;    LRERT:<byref>  See Outputs
 ;   LRTYPE: Return the string or the array elements
 ;         :  1=String  2=Array <dflt=2>
 ;         : Return data can be big so need to limit in order
 ;         : to watch symbol table use.
 ;  LRFLAGS: Controls behavior of the API
 ;         : S=Populate SCT text with text from Lexicon
 ; Outputs
 ;   The ERT extract string.
 ;   The ERT array:  ERT(1)=id  ERT(2)=Entry name, etc..
 ; ERT extract format (from ^LRSRVR6)
 ; Station #-File #-IEN|Entry Name|SNOMED I|VUID|SNOMED CT|SNOMED CT TERM|Mapping Exception|Related Specimen|Related Specimen ID|Extract Ver|Term Status|
 ;
 N LRCNT,LRDATA,LRDATA2,LRDSUB,LRI,LRMSG,LRSCT,LRSITE,LRT,LRX,LRY
 N DA,DIC,DIE,DIERR,DIR,DR,X,X1,X2,Y
 S LRT=$T ;preserve $T
 S LRDELIM=$G(LRDELIM),LRTYPE=$G(LRTYPE,2)
 S LRFLAGS=$G(LRFLAGS)_" " ;so LRFLAGS'="" for [ operations
 I LRDELIM="" S LRDELIM="|"
 S LRDSUB=LRDELIM
 I LRDELIM="|" S LRDSUB="!" ;used for DELIM $TR
 I LRDELIM="^" S LRDSUB="~"
 ;
 ; Initialize LRERT array. STS expects all elements to be defined or null
 K LRERT
 F LRI=1:1:11 S LRERT(LRI)=""
 ;
 S LRX=$$KSP^XUPARAM("INST")
 S LRX=$$NS^XUAF4(LRX)
 S LRSITE=$P(LRX,"^",2)
 S LRX=LRSITE_"-"_LRFILE_"-"_LRFIEN
 S LRERT(1)=LRX
 D GETS^DIQ(LRFILE,LRFIEN_",","@;.01;2;20;21","EI","LRDATA","LRMSG")
 M LRDATA2=LRDATA(LRFILE,LRFIEN_",")
 K LRDATA
 S LRCNT=1
 F LRI=.01,2,0,20 D  ;  0=dummy placeholder for unused VUID field
 . S LRCNT=LRCNT+1
 . I LRI=0 Q
 . S LRX=$G(LRDATA2(LRI,"E"))
 . I LRI=2,LRX'="" D
 . . I LRFILE=62 S LRX="" Q  ;fld #2 not used in #62
 . . I LRFILE>60.9,LRFILE<61.61 S LRY=((LRFILE*10)#610)+1,LRX=$E("TMEFDPJ",LRY)_"-"_LRX
 . I LRX'="" S LRERT(LRCNT)=$TR(LRX,LRDELIM,LRDSUB)
 ;
 ; Send SCT term name if code and flag to send
 S LRSCT=$G(LRDATA2(20,"E"))
 I LRSCT'="",LRFLAGS["S" D
 . K LRDATA
 . S LRX=$$CODE^LRSCT(LRSCT,"SCT",,"LRDATA")
 . Q:LRX<1
 . S LRX=$G(LRDATA("F"))
 . I LRX="" S LRX=$G(LRDATA("P"))
 . I LRX'="" S LRERT(6)=$TR(LRX,LRDELIM,LRDSUB)
 ;
 ; If COLLECTION SAMPLE (#62) then send related specimen and specimen id
 I LRFILE=62 D
 . N LR61
 . S LR61=$P($G(^LAB(LRFILE,LRFIEN,0)),"^",2) Q:LR61<1
 . S LRERT(8)=$P($G(^LAB(61,LR61,0)),"^")
 . S LRERT(9)=LRSITE_"-61-"_LR61
 ;
 S LRERT(10)=$$VER^LRSRVR6
 S LRERT(11)=$G(LRDATA2(21,"I"))
 ;
 I LRTYPE=1 D
 . S LRI=0
 . F  S LRI=$O(LRERT(LRI)) Q:LRI<1  S $P(LRERT,LRDELIM,LRI)=LRERT(LRI) K LRERT(LRI)
 ;
 I LRT ;restore $T
 Q $S(LRTYPE=1:LRERT,1:"")
 ;
 ;
TNUM(FILE,IEN,NOW,EXCTYP) ;
 ; Construct transaction number
 ; Inputs
 ;   FILE: File #
 ;    IEN: IEN of entry
 ;    NOW: Date/Time of process <dflt=Now>
 ; EXCTYP: ERT Exception Type (1=load, 2=ref lab, 3=local edit)
 ; Returns Transaction number string
 N TNUM,X
 S FILE=$G(FILE)
 S IEN=$G(IEN)
 S NOW=$G(NOW)
 S EXCTYP=$G(EXCTYP)
 I NOW="" S NOW=$$NOW^XLFDT()
 I EXCTYP'>0 Q ""
 S X=$$KSP^XUPARAM("INST")
 S X=$$NS^XUAF4(X)
 S X=$P(X,"^",2)
 ; transaction #: Site-Exc Type-NOW-File#:IEN
 S TNUM=X_"-"_EXCTYP_"-"_NOW_"-"_FILE_":"_IEN ;transaction #
 S TNUM=$$UP^XLFSTR(TNUM)
 Q TNUM
 ;
 ;
LOGIT(TEXT,IN,TMPNM) ;
 ; FileMan safe
 ; Adds data to the ^XTMP gobal.
 ; Inputs
 ;  TEXT:<byref> Save symtbl space (dont manipulate)
 ;  IN: <byref>
 ;           IN("TNUM") - Transaction Number <req>
 ;           IN("TDT") - Transaction date/time <opt>
 ;           IN("FILE") targ file <req>
 ;           IN("FIEN") ;targ file IEN <req>
 ;           IN("SCT") ;SCT code <opt>
 ;           IN("R6247") ;#62.49 IEN <opt>
 ;           IN("STSEXC") ;STS exception type <req>
 ;           IN("HDIERR") ;STS error flag <opt> 0 or 1
 ;           IN("PREV","SCT")
 ;           IN("PREV","TEXT")
 ; TMPNM:<opt> XTMP subscript <dflt=LRSCTX-STS>
 ; Outputs
 ;  Record # or "0^err #^err msg"
 N FILE,FIEN,LRLCK,REC,TEXT2,SCTCHNG,STR,STSEXC,TDT,TNUM,X
 ;
 S TMPNM=$G(TMPNM)
 I TMPNM="" S TMPNM="LRSCTX-STS"
 ;
 ; Update ^XTMP
 S ^XTMP(TMPNM,0)=$$FMADD^XLFDT(DT,365)_U_$$NOW^XLFDT()_U_"STS Term/SCT Alerts"
 S STR=$$TRIM^XLFSTR(TEXT)
 S LRLCK=$NA(^XTMP(TMPNM))
 S X=$$GETLOCK^LRUTIL(LRLCK,60)
 I 'X Q "0^1^Failed to acquire lock."
 S FILE=+$G(IN("FILE")),FIEN=+$G(IN("FIEN")),TNUM=$G(IN("TNUM"))
 S TDT=$G(IN("TDT"))
 I TDT="" S TDT=$$NOW^XLFDT()
 S STSEXC=$G(IN("STSEXC"))
 S:STSEXC="" STSEXC=0
 I TNUM="" S TNUM=$$TNUM(FILE,FIEN,TDT,STSEXC) S LRERT("TNUM")=TNUM
 ;
 S REC=+$O(^XTMP(TMPNM,"A"),-1)+1
 S ^XTMP(TMPNM,REC,0)=$E(STR,1,200)
 S ^XTMP(TMPNM,REC,1)=$E(STR,201,$L(STR))
 S $P(^XTMP(TMPNM,REC,2),U,1)=TNUM ;transaction #
 S $P(^XTMP(TMPNM,REC,2),U,2)=TDT ;transaction date/time
 S $P(^XTMP(TMPNM,REC,2),U,3)=FILE ;targ file
 S $P(^XTMP(TMPNM,REC,2),U,4)=FIEN ;targ file IEN
 S $P(^XTMP(TMPNM,REC,2),U,5)=$G(IN("SCT")) ;SCT code
 S $P(^XTMP(TMPNM,REC,2),U,6)=$G(IN("R6247")) ;#62.49 IEN
 S $P(^XTMP(TMPNM,REC,2),U,7)=DUZ
 S $P(^XTMP(TMPNM,REC,2),U,8)=STSEXC ;STS exception type
 S X=""
 I $G(IN("HDIERR"))'="" S X=IN("HDIERR")
 I X="" I $D(IN("HDIERR")) S X=$S($D(IN("HDIERR")):1,1:0)
 S $P(^XTMP(TMPNM,REC,2),U,9)=X ;STS error
 S ^XTMP(TMPNM,REC,10)=$G(IN("PREV","SCT")) ;previous SCT code
 S ^XTMP(TMPNM,REC,20)=$E($G(IN("PREV","TEXT")),1,200)
 S ^XTMP(TMPNM,REC,21)=$E($G(IN("PREV","TEXT")),201,400)
 S ^XTMP(TMPNM,REC,22)="" ;previous SCT FSN text
 S ^XTMP(TMPNM,REC,23)="" ;SCT FSN text overflow
 S ^XTMP(TMPNM,"B",$$UP^XLFSTR($E(STR,1,200)),REC)=""
 S ^XTMP(TMPNM,"C",TNUM,REC)=""
 S ^XTMP(TMPNM,"D",TDT,REC)=""
 S ^XTMP(TMPNM,"E",+FILE,+FIEN,REC)=""
 S ^XTMP(TMPNM,"F",STSEXC,REC)="" ;exception type xref
 L -@LRLCK
 Q REC
 ;
 ;
OK2LOG(TEXT,IN,TMPNM) ;
 ; FileMan safe
 ; Checks if this change needs to be logged.
 ; Inputs
 ;   TEXT:<byref> Not manipulated (minimize symtbl use)
 ;     IN:<byref>
 ;            IN("FILE") <req>
 ;            IN("SCT") <opt>
 ;            IN("PREV","SCT") <opt>
 ; Outputs
 ;  1=OK to log  or 0 with error code^error msg
 ;  If "0^2^SCT changed"  then this should still generate an alert
 N X,I,STOP,STR,REC,TEXT2,STATUS,FILE
 S TMPNM=$G(TMPNM)
 I TMPNM="" S TMPNM="LRSCTX-STS"
 S TEXT=$G(TEXT),FILE=$G(IN("FILE")),STATUS=1
 S TEXT2=$$TRIM^XLFSTR(TEXT),TEXT2=$$UP^XLFSTR(TEXT2)
 S STR=$E(TEXT2,1,200) ;some terms can be long and wont fit in a node
 ; check if this term has been sent already.
 S I=0,STOP=0
 F  S I=$O(^XTMP(TMPNM,"B",STR,I)) Q:'I  D  Q:STOP
 . I STR_$$UP^XLFSTR($G(^XTMP(TMPNM,I,1)))'=TEXT2 Q
 . S DATA=$G(^XTMP(TMPNM,I,2))
 . I $P(DATA,U,3)'=FILE Q
 . S STOP=1
 ;
 I STOP S STATUS="0^1^Alert already sent."
 ; did SCT change?
 I STOP,$G(IN("PREV","SCT"))'=$G(IN("SCT")) S STATUS="0^2^SCT changed.",STOP=0
 Q STATUS
