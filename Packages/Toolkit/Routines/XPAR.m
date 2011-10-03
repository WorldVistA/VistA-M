XPAR ; SLC/KCM - Parameters File Calls ;11/03/2003  16:17
 ;;7.3;TOOLKIT;**26,60,63,79,82**;Apr 25, 1995
 ;
 ; (Need to add proper locking)
 ;
 ; Calls to Add/Change/Delete Parameters
 ;  ENT: entity, required (internal or external form)
 ;  PAR: parameter, required (internal or external form)
 ; INST: instance, defaults to 1 (external or `internal)
 ;  VAL: value, defaults to "" (external or 'internal)
 ; .ERR: returns error (0 if none, otherwise "1^error text")
 ;
ADD(ENT,PAR,INST,VAL,ERR) ; add new parameter instance
 N TYP S TYP="A"
 D UPD
 Q
CHG(ENT,PAR,INST,VAL,ERR) ; change parameter value for a given instance
 N TYP S TYP="C"
 D UPD
 Q
DEL(ENT,PAR,INST,ERR) ; delete a parameter instance
 N TYP,VAL S TYP="D"
 D UPD
 Q
REP(ENT,PAR,INST,NEWINST,ERR) ; replace existing instance value
 N TYP,VAL S TYP="R"
 D UPD
 Q
PUT(ENT,PAR,INST,VAL,ERR) ; add/update, bypassing input transforms
PUT1 ;                       ; called here from old entry point EN^ORXP
 N TYP,XPARCHK           ; XPARVCHK undefined to bypass validation
 D UPD1
 Q
EN(ENT,PAR,INST,VAL,ERR) ; add/change/delete parameters
 N TYP
UPD ;                       ; enter here if transaction type known
 N XPARCHK S XPARCHK=""
UPD1 ;                       ; enter here if data already validated
 S ERR=0,INST=$G(INST,1),VAL=$G(VAL)
 I ($L(ENT,"^")>1)!(ENT["ALL") S ERR=$$ERR^XPARDD(89895007) Q  ;no lists
 D INTERN^XPAR1 Q:ERR
 I '$D(TYP) S TYP=$S(VAL="@":"D",+$O(^XTV(8989.5,"AC",PAR,ENT,INST,0)):"C",1:"A")
 I TYP="A" G DOADD^XPAR2 ; use GO to emulate case statement
 I TYP="C" G DOCHG^XPAR2
 I TYP="D" G DODEL^XPAR2
 I TYP="R" G DOREP^XPAR2
 Q
NDEL(ENT,PAR,ERR) ; Delete all instances of a parameter for an entity
 N INST,DA
 I ($L(ENT,"^")>1)!(ENT["ALL") S ERR=$$ERR^XPARDD(89895007) Q
 S ERR=0 D INTERN^XPAR1 Q:ERR
 S INST="",DIK="^XTV(8989.5,"
 F  S INST=$O(^XTV(8989.5,"AC",PAR,ENT,INST)) Q:INST=""  D
 . S DA=$O(^XTV(8989.5,"AC",PAR,ENT,INST,0))
 . D ^DIK
 Q
 ;
 ;  Calls to Retrieve Values for Parameters --------------------------
 ;  ENT: entity, required, may take on several forms -
 ;           internal vptr: ien;GLO(FN,
 ;           external vptr: prefix.entryname
 ;      'use current' form: prefix
 ;            chained list: use any of above, ^ delimited, or 'ALL'
 ;  PAR: parameter, required (internal or external form)
 ; .ERR: returns error (0 if none, otherwise "error number^text")
 ;
GET(ENT,PAR,INST,FMT) ; function - returns a parameter value
 ; INST: instance, defaults to 1 (external or `internal)
 ;  FMT: format of returned data, defaults to "Q" (internal values)
 ;       "Q" - quick, returns internal value
 ;       "I" - internal, returns internal value, inst must be internal
 ;       "E" - external, returns external value
 ;       "B" - both, returns internal value^external value
 N ERR,XPARCHK,XPARGET
 S ERR=0,FMT=$G(FMT,"Q"),INST=$G(INST,1),XPARGET="" S:FMT'="I" XPARCHK=""
 D INTERN^XPAR1 I ERR Q ""
 N VAL S VAL=$G(^XTV(8989.5,"AC",PAR,ENT,INST))
 I FMT="I"!(FMT="Q") Q VAL
 I FMT="E",$L(VAL) Q $$EXT^XPARDD(VAL,PAR)
 I FMT="B",$L(VAL) Q VAL_"^"_$$EXT^XPARDD(VAL,PAR)
 Q ""
GETWP(WPTEXT,ENT,PAR,INST,ERR) ; get value of word processing type
 ; .WPTEXT: array in which the word processing text is returned
 ;          WPTEXT      contains the title (VALUE field)
 ;          WPTEXT(n,0) contains the actual text
 ;    INST: instance, defaults to 1 (internal only - XPARCHK not defined)
 N IEN,I,XPARGET,XPARCHK K WPTEXT
 S ERR=0,INST=$G(INST,1),XPARGET=""
 D INTERN^XPAR1 Q:ERR
 S IEN=$O(^XTV(8989.5,"AC",PAR,ENT,INST,0)) Q:'IEN
 M WPTEXT=^XTV(8989.5,IEN,2) S WPTEXT=^(1) K WPTEXT(0)
 Q
GETLST(LIST,ENT,PAR,FMT,ERR,GBL) ; return all parameter instances for an entity
 ; .LIST: array in which instances are returned
 ;   FMT: format of returned data, defaults to "Q" (internal values)
 ;        "I" - internal  instance)=internal value
 ;        "Q" - quick,    #)=internal instance^internal value
 ;        "E" - external, #)=external instance^external value
 ;        "B" - both,     #,"N")=internal instance^external instance
 ;                        #,"V")=internal value^external value
 ;        "N" - external instance)=internal value^external value
 ;   GBL: Set to 1 if LIST holds a Closed Global root
 N INST,EINST,VAL,XPARGET,XPARCHK,ROOT ;leave XPARCHK undefined
 S ERR=0,INST="",FMT=$G(FMT,"Q"),XPARGET=""
 ;Setup ROOT
 I '$G(GBL) K LIST S ROOT=$NA(LIST)
 I $G(GBL) D  Q:ERR
 . I $E($G(LIST),1)'="^" S ERR=$$ERR^XPARDD(89895015) Q
 . S ROOT=LIST
 . Q
 ;
 S @ROOT=0
 D INTERN^XPAR1 Q:ERR
 F  S INST=$O(^XTV(8989.5,"AC",PAR,ENT,INST)) Q:INST=""  D
 . S @ROOT=@ROOT+1,VAL=^XTV(8989.5,"AC",PAR,ENT,INST)
 . I FMT="I" S @ROOT@(INST)=VAL Q
 . I FMT="Q" S @ROOT@(@ROOT)=INST_U_VAL Q
 . S VAL=VAL_U_$$EXT^XPARDD(VAL,PAR)
 . S EINST=INST_U_$$EXT^XPARDD(INST,PAR,"I")
 . I FMT="E" S @ROOT@(@ROOT)=$P(EINST,"^",2)_U_$P(VAL,"^",2) Q
 . I FMT="B" S @ROOT@(@ROOT,"N")=EINST,@ROOT@(@ROOT,"V")=VAL Q
 . I FMT="N" S @ROOT@($P(EINST,"^",2))=VAL Q
 Q
ENVAL(LIST,PAR,INST,ERR,GBL) ; return all parameter instances
 ; .LIST: array of returned entity/instance/values in the format:
 ;        LIST(entity,instance)=value  (LIST = # of array elements)
 ;        or a Closed Global root  ($NA(^TMP($J)))
 ;   PAR: parameter in external or internal format
 ;  INST: instance (optional) in external or internal format
 ;   ERR: error (0 if no error found)
 ;   GBL: Set to 1 if LIST holds a Closed Global root
 N ENT,VAL,XPARGET,ROOT
 S ENT="",VAL="",ERR=0,XPARGET=""
 ;Setup ROOT
 I '$G(GBL) K LIST S ROOT=$NA(LIST)
 I $G(GBL) D  Q:ERR
 . I $E($G(LIST),1)'="^" S ERR=$$ERR^XPARDD(89895015) Q
 . S ROOT=LIST
 . Q
 ;
 S @ROOT=0
 ; -- parameter to internal format:
 I PAR'?1.N S PAR=+$O(^XTV(8989.51,"B",PAR,0))
 I '$D(^XTV(8989.51,PAR,0)) S ERR=$$ERR^XPARDD(89895001) Q  ;missing par
 ; -- instance
 I $L($G(INST)) D VALID^XPARDD(PAR,.INST,"I",.ERR) Q:ERR
 F  S ENT=$O(^XTV(8989.5,"AC",PAR,ENT)) Q:ENT=""  D
 . I $L($G(INST)) D
 .. S VAL=$G(^XTV(8989.5,"AC",PAR,ENT,INST))
 .. S:$L($G(VAL)) @ROOT@(ENT,INST)=VAL,@ROOT=@ROOT+1
 . I '$L($G(INST)) D
 .. S INST="" F  S INST=$O(^XTV(8989.5,"AC",PAR,ENT,INST)) Q:INST=""  D
 ... S VAL=$G(^XTV(8989.5,"AC",PAR,ENT,INST))
 ... S:$L($G(VAL)) @ROOT@(ENT,INST)=VAL,@ROOT=@ROOT+1
 Q
