DDEG ;SPFO/RAM,MKB - Entity GET Extract ; AUG 1, 2018  12:37
 ;;22.2;VA FileMan;**9,16,17,18,20,21**;Jan 05, 2016;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; $$EN1 called from ^DDEGET, assumes validated input parameters:
 ;   DIENTY = Entity file #1.5 ien
 ;   DIEN   = ID of entity instance to return
 ;   NOTAG  = 1 if entity is a list item (omit tags)
 ;   ERROR  = returns '-1^message' if error, else ""
 ;   DFORM  = format for results (0, 1, 2); default is 0=JSON
 ;
EN1(DIENTY,DIEN,NOTAG,ERROR) ; -- return a single Entity (expects DFORM=0/1/2)
 N DIFN,DNAME,DDEOUT,DAC,DSEQ,DITM,DRES,X
 S DFORM=+$G(DFORM),(DRES,ERROR)=""
 S DIENTY=+$G(DIENTY),DIEN=$G(DIEN)
 S DIFN=$P($G(^DDE(DIENTY,0)),U,2)
 S DNAME=$G(^DDE(DIENTY,.1)) S:DNAME="" DNAME=$P($G(^(0)),U)
 ;
 D IENPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT G ENQ
 I $G(DIEN)="" S ERROR="-1^Record "_$G(DIEN)_" not found" G ENQ
 ;
 S DAC=$P($G(^DDE(+DIENTY,"DAC")),U,1) I DAC D  G:ERROR ENQ  ;p20
 . N DDETXT,DDERR
 . S DAC=$$CANDO^DIAC1(DIFN,DIEN,DAC,DUZ,,,"DDETXT","DDERR")
 . S ERROR=$S(DAC<0:"-1^"_$G(DDERR(1)),'DAC:"-1^"_$G(DDETXT(1)),1:0)
 ;
 ; loop through items
 S DSEQ=0 F  S DSEQ=$O(^DDE(DIENTY,1,"SEQ",DSEQ)) Q:'DSEQ  D  Q:ERROR!$G(DDEQUIT)
 . S DITM=0 F  S DITM=$O(^DDE(DIENTY,1,"SEQ",DSEQ,DITM)) Q:'DITM  D  Q:ERROR!$G(DDEQUIT)
 .. S X=$$VALUE(DITM) I X=""!ERROR!$G(DDEQUIT) Q
 .. S DRES=$$ADD(DRES,X,DSEQ)
 ;
 I $L(DRES),'$G(DDEQUIT) D
 . S:'DFORM DRES="{"_DRES_"}"
 . Q:$G(NOTAG)  ;for embedded items
 . S DRES=$$ELEMENT("",DNAME,DRES,,,"C")
ENQ ;
 S:$G(DDEQUIT) DRES=""
 Q DRES
 ;
VALUE(ITM,NOTAG) ; -- build a complete ITEM value
 N ITM0,TAG,ITEM,TYPE,FILE,FIELD,IEN
 ;
 S ITM0=$G(^DDE(+DIENTY,1,+ITM,0)),IEN=$G(DIEN)
 S TAG=$P(ITM0,U),FILE=$P(ITM0,U,4),FIELD=$P(ITM0,U,5)
 S:'FILE FILE=DIFN ;default file#
 S TYPE=$P($$GET1^DIQ(1.51,(+ITM_","_+DIENTY_","),.03)," ")
 ;
 S ITEM="" I $L(TYPE),$L($T(@TYPE)) D @TYPE G VQ ;build ITEM
 D SIMPLE
VQ ;
 Q ITEM
 ;
SIMPLE ; -- retrieve simple ITEM (from $$VALUE)
 N VALUE,LKUP,FMT,XFRM
 S VALUE="",XFRM=$G(^DDE(+DIENTY,1,+ITM,4))
 ;
 ; get VALUE via code or field
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 I VALUE="",$G(FIELD) D  Q:VALUE=""
 . S LKUP=$P(ITM0,U,6) S:LKUP'="" FIELD=FIELD_":"_LKUP
 . S FMT=$S(+$P(ITM0,U,7):"I",1:"E")
 . S VALUE=$$GET1^DIQ(FILE,IEN_",",FIELD,FMT)
 ;
 ; apply output transform
 I $L(VALUE),$L(XFRM) X XFRM
 ;
 I $$VALID(VALUE) D  ;add tags
 . S VALUE=$$ESC(VALUE)
 . I 'DFORM,$G(NOTAG) S ITEM=VALUE Q  ;for List items
 . S ITEM=$$ELEMENT("",TAG,VALUE)
 Q
 ;
FIXED ; -- build one FIXED item (from $$VALUE)
 N VALUE S VALUE=""
 ;
 ; get VALUE via code or string
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 S:VALUE="" VALUE=$G(^DDE(+DIENTY,1,+ITM,2)) ;Fixed Response
 ;
 I $$VALID(VALUE) D  ;add tags
 . S VALUE=$$ESC(VALUE)
 . I 'DFORM,$G(NOTAG) S ITEM=VALUE Q  ;for List items
 . S ITEM=$$ELEMENT("",TAG,VALUE)
 Q
 ;
ID ; -- build one ID item (from $$VALUE)
 N VALUE,XFRM
 S VALUE="",XFRM=$G(^DDE(+DIENTY,1,+ITM,4))
 ;
 ; get VALUE via code or IEN
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 S:VALUE="" VALUE=IEN
 ;
 ; apply output transform
 I $L(VALUE),$L(XFRM) X XFRM
 ;
 I $$VALID(VALUE) D  ;add tags
 . S VALUE=$$ESC(VALUE)
 . I 'DFORM,$G(NOTAG) S ITEM=VALUE Q  ;for List items
 . S ITEM=$$ELEMENT("",TAG,VALUE)
 Q
 ;
WORD ; -- build one WP ITEM (from $$VALUE)
 N WP,LKUP,CRLF,I,X,VALUE S VALUE="",I=0
 ;
 ; get WP(n) or WP(n,0) via code or field
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 I '$D(WP),$G(FIELD) D  Q:'$D(WP)
 . S LKUP=$P(ITM0,U,6) S:LKUP'="" FIELD=FIELD_":"_LKUP
 . S I=$$GET1^DIQ(FILE,IEN_",",FIELD,,"WP")
 ;
 S CRLF='$P(ITM0,U,9)
 S I=+$O(WP(0)),X=$S($D(WP(I,0)):WP(I,0),1:$G(WP(I)))
 S VALUE=X
 F  S I=$O(WP(I)) Q:I<1  D
 . S X=$S($D(WP(I,0)):WP(I,0),1:WP(I))
 . I $E(X)=" " S VALUE=VALUE_$C(13,10)_X Q
 . I CRLF S VALUE=VALUE_$C(13,10)_X Q
 . S VALUE=VALUE_$S($E(VALUE,$L(VALUE))=" ":"",1:" ")_X
 ;
 I $$VALID(VALUE) D  Q  ;add tags
 . I $P(ITM0,U,10) D  ;p20
 .. Q:$L(VALUE)'>$P(ITM0,U,10)
 .. S VALUE=$S($P(ITM0,U,11)]"":$P(ITM0,U,11),1:"Text exceeds "_$P(ITM0,U,10)_" limit and could not be saved. Please contact the site for full original text.")
 . E  I $L(VALUE)>2999999 S VALUE="Text exceeds 3 megabyte limit and could not be saved. Please contact the site for full original text." ;p16
 . S VALUE=$$ESC(VALUE)
 . I 'DFORM,$G(NOTAG) S ITEM=VALUE Q  ;for List items
 . S ITEM=$$ELEMENT("",TAG,VALUE)
 Q
 ;
ENTITY ; -- build an entity ITEM (from $$VALUE)
 N ENTITY,ERR,VALUE,DATA,LKUP,FMT,XFRM,ID
 S ENTITY=$P(ITM0,U,8) Q:ENTITY=""
 S (VALUE,ERR)="",XFRM=$G(^DDE(+DIENTY,1,+ITM,4))
 ;
 ; get VALUE via code or field, for Entity ID
 ; DATA can also be defined here, to pass to Entity
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 I VALUE="",$G(FIELD) D  Q:VALUE=""
 . S LKUP=$P(ITM0,U,6) S:LKUP'="" FIELD=FIELD_":"_LKUP
 . S FMT=$S(+$P(ITM0,U,7):"I",1:"E")
 . S VALUE=$$GET1^DIQ(FILE,IEN_",",FIELD,FMT)
 I $L(VALUE),$L(XFRM) X XFRM
 Q:VALUE=""  S ID=VALUE
 ;
 D PREPROC(+ENTITY) ;Pre-Processing
 S VALUE=$$EN1^DDEG(+ENTITY,ID,1)
 D POST(+ENTITY)    ;Post-Processing
 ;
 I $L(VALUE) D  Q   ;add tags
 . I VALUE<0 S ERROR=VALUE Q
 . I $G(NOTAG) S ITEM=VALUE Q  ;for embedded or list items
 . S ITEM=$$ELEMENT("",TAG,VALUE,,,"C")
 Q
 ;
COMPLEX ; -- build a complex ITEM (from $$VALUE)
 N SEQ,IDX1,TAG1,IDX0,VALUE
 ;
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 ;
 S SEQ=0 F  S SEQ=$O(^DDE(DIENTY,1,ITM,3,"B",SEQ)) Q:'SEQ  D  Q:$G(ERROR)!$G(DDEQUIT)
 . S IDX1=$O(^DDE(DIENTY,1,ITM,3,"B",SEQ,0))
 . S TAG1=$P(^DDE(DIENTY,1,ITM,3,IDX1,0),U,2) Q:TAG1=""
 . S IDX0=+$O(^DDE(DIENTY,1,"B",TAG1,0))
 . I IDX0<1!'$D(^DDE(DIENTY,1,IDX0,0)) Q
 . ;
 . S VALUE=$$VALUE(IDX0) Q:$G(ERROR)!$G(DDEQUIT)
 . S:VALUE'="" ITEM=$$ADD(ITEM,VALUE,SEQ)
 ;
 Q:$G(ERROR)  I $L(ITEM) D  ;add tags
 . S:'DFORM ITEM="{"_ITEM_"}" Q:$G(NOTAG)  ;for List items
 . S ITEM=$$ELEMENT("",TAG,ITEM,,,"C")
 Q
 ;
LIST ; -- build an array of values in ITEM (from $$VALUE)
 N ITM1 S ITM1=$G(^DDE(+DIENTY,1,+ITM,1))
 ;
 D @("LIST"_+ITM1) ;LIST_type#
 ;
 Q:$G(ERROR)!$G(DDEQUIT)
 I $L(ITEM) D  ;add tags
 . S:'DFORM ITEM="["_ITEM_"]" Q:$G(NOTAG)  ;for List items
 . S ITEM=$$ELEMENT("",TAG,ITEM,,,"L")
 Q
 ;
LIST1 ; -- list of values in FILE (from LIST)
 N C,TAG,XREF,FILTER,SCREEN,FMT,XFRM,ENTITY,QUERY,DDELIST,DLIST,SEQ,IEN1,VALUE,ERR
 S C=","
 S TAG=$P(ITM1,U,2),XREF=$P(ITM1,U,3),FILTER=$P(ITM1,U,4)
 S SCREEN=$G(^DDE(+DIENTY,1,+ITM,1.1))
 ;
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 ;
 ; set up for results: single FIELD or multi-field (record) ENTITY
 I FIELD S FMT=$S(+$P(ITM0,U,7):"I",1:"E"),XFRM=$G(^DDE(+DIENTY,1,+ITM,4))
 E  D  Q:'ENTITY
 . S ENTITY=+$P(ITM0,U,8) Q:'ENTITY
 . N X0 S X0=$G(^DDE(ENTITY,0)) S:'$L(TAG) TAG=$G(^(.1))
 . ; get defaults from Entity if not defined in Item
 . S:'$L(XREF) XREF=$P(X0,U,3)
 . S:'$L(FILTER) FILTER=$P(X0,U,4)
 . S:'$L(SCREEN) SCREEN=$G(^DDE(ENTITY,5.1))
 . S QUERY=$G(^DDE(ENTITY,5))
 . D PREPROC(ENTITY)
 I $L(FILTER) S FILTER=$S($D(@FILTER):@FILTER,1:FILTER)
 S:TAG="" TAG=$P(ITM0,U)
 ;
L1 ; find appropriate records and process
 I $L(QUERY)>1,$L($T(@($P(QUERY,"(")))) D @QUERY I 1
 E  D FIND^DIC(FILE,,"@","Q",.FILTER,,XREF,SCREEN,,"DDELIST") M DLIST=DDELIST("DILIST",2)
 S SEQ=0 F  S SEQ=$O(DLIST(SEQ)) Q:'SEQ  D
 . S IEN1=$G(DLIST(SEQ))
 . S (VALUE,ERR)=""
 . I FIELD D
 .. S VALUE=$$GET1^DIQ(FILE,(IEN1_C),FIELD,FMT)
 .. I $L(VALUE),$L(XFRM) X XFRM ;output transform
 .. S:'$$VALID(VALUE) VALUE=""
 . I 'FIELD,ENTITY S VALUE=$$EN1^DDEG(ENTITY,IEN1,1,.ERR)
 . ;
 . I VALUE=""!$G(ERR)!$G(DDEQUIT) Q
 . S ITEM=$$ELEMENT(ITEM,TAG,VALUE,SEQ,"addList")
 ;
 D:ENTITY POST(ENTITY)
 Q
 ;
LIST2 ; -- list of values in SUBFILE (from LIST)
 N IENS,C,TAG,SCREEN,FMT,XFRM,ENTITY,DLIST,SEQ,IEN1,VALUE,ERR
 S IENS=","_IEN,C=",",ENTITY="" ;p21 initialize ENTITY
 S TAG=$P(ITM1,U,2),SCREEN=$G(^DDE(+DIENTY,1,+ITM,1.1))
 ;
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 ;
 ; set up for results: single FIELD or multi-field ENTITY
 I FIELD S FMT=$S(+$P(ITM0,U,7):"I",1:"E"),XFRM=$G(^DDE(+DIENTY,1,+ITM,4))
 E  D  Q:'ENTITY
 . S ENTITY=$P(ITM0,U,8) Q:'ENTITY
 . S:'$L(TAG) TAG=$G(^DDE(ENTITY,.1)) ;defaults
 . S:'$L(SCREEN) SCREEN=$G(^DDE(ENTITY,5.1))
 . D PREPROC(ENTITY)
 S:TAG="" TAG=$P(ITM0,U)
 ;
L2 ; find appropriate records and process
 D LIST^DIC(FILE,IENS_C,"@","Q",,,,,SCREEN,,"DLIST")
 S SEQ=0 F  S SEQ=$O(DLIST("DILIST",2,SEQ)) Q:'SEQ  D  Q:$G(ERR)
 . S IEN1=$G(DLIST("DILIST",2,SEQ))_IENS
 . S (VALUE,ERR)=""
 . I FIELD D
 .. S VALUE=$$GET1^DIQ(FILE,(IEN1_C),FIELD,FMT)
 .. I $L(VALUE),$L(XFRM) X XFRM ;output transform
 .. S:'$$VALID(VALUE) VALUE=""
 . I 'FIELD,ENTITY S VALUE=$$EN1^DDEG(ENTITY,IEN1,1,.ERR)
 . ;
 . I VALUE=""!$G(ERR)!$G(DDEQUIT) Q
 . S ITEM=$$ELEMENT(ITEM,TAG,VALUE,SEQ,"addList")
 ;
 D:ENTITY POST(ENTITY)
 Q
 ;
LIST3 ; -- list of values in COMPLEX FIELDS (from LIST)
 N TAG,SEQ,IDX1,NM1,IDX0,VALUE
 S TAG=$P(ITM1,U,2) S:TAG="" TAG=$P(ITM0,U)
 ;
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 ;
 ; process list Items
 S SEQ=0 F  S SEQ=$O(^DDE(DIENTY,1,ITM,3,"B",SEQ)) Q:'SEQ  D  Q:$G(ERROR)
 . S IDX1=$O(^DDE(DIENTY,1,ITM,3,"B",SEQ,0))
 . S NM1=$P(^DDE(DIENTY,1,ITM,3,IDX1,0),U,2) Q:NM1=""
 . S IDX0=+$O(^DDE(DIENTY,1,"B",NM1,0))
 . I IDX0<1!'$D(^DDE(DIENTY,1,IDX0,0)) Q
 . ;
 . S VALUE=$$VALUE(IDX0,1)
 . ;
 . I VALUE=""!$G(ERR)!$G(DDEQUIT) Q
 . S ITEM=$$ELEMENT(ITEM,TAG,VALUE,SEQ,"addList")
 Q
 ;
LIST4 ; -- list of values in DLIST()
 N DLIST,TAG,ENTITY,SEQ,X,VALUE,ERR
 S TAG=$P(ITM1,U,2)
 ;
 ;create DLIST()=data value or ID for Entity
 D ITMPROC I $G(DDEOUT)!$G(DDEQUIT) K DDEOUT Q
 ;
 ; set up for results: single FIELD or multi-field ENTITY
 S ENTITY=$P(ITM0,U,8) I ENTITY D
 . S:'$L(TAG) TAG=$G(^DDE(ENTITY,.1))
 . D PREPROC(ENTITY)
 I TAG="" S TAG=$P(ITM0,U)
 ;
 ; process list items
 S SEQ=0 F  S SEQ=$O(DLIST(SEQ)) Q:'SEQ  D  Q:$G(ERR)
 . S X=$G(DLIST(SEQ))
 . S (VALUE,ERR)=""
 . I 'ENTITY,$$VALID(X) S VALUE=X
 . E  S VALUE=$$EN1^DDEG(ENTITY,X,1,.ERR)
 . ;
 . I VALUE=""!$G(ERR)!$G(DDEQUIT) Q
 . S ITEM=$$ELEMENT(ITEM,TAG,VALUE,SEQ,"addList")
 ;
 D:ENTITY POST(ENTITY)
 Q
 ;
ADD(STRING,ELEMENT,SEQ) ; -- add ELEMENT to result STRING
 Q:$G(ELEMENT)="" STRING
 ;
 ; JSON:0  XML:1  TEXT:2
 S DFORM=+$G(DFORM),SEQ=+$G(SEQ)
 ;
 N RES S RES=$G(STRING)
 I DFORM=0 S RES=RES_$S($L($G(STRING)):", ",1:"")_ELEMENT ;SEQ>1
 I DFORM=1 S RES=RES_ELEMENT
 I DFORM=2 S RES=RES_$S($L($G(STRING)):U,1:"")_ELEMENT ;SEQ>1
 Q RES
 ;
ELEMENT(STRING,NAME,VALUE,SEQ,OPTION,DTYPE) ; -- build an element STRING
 ; STRING=SERIALIZED RESPONSE
 S STRING=$G(STRING) Q:$G(NAME)="" STRING
 S:NAME["." NAME=$P(NAME,".",2)
 S VALUE=$G(VALUE)
 S SEQ=+$G(SEQ),OPTION=$G(OPTION,"addTags")
 ;
 ; does DataTYPE not require quotes?
 S DTYPE=$S($G(DTYPE)="C":1,$G(DTYPE)="L":1,"[{"[$E(VALUE):1,VALUE?1.N1"E"1N.E:0,VALUE?1.N1"e"1N.E:0,+VALUE=VALUE:1,1:0)
 N X,Y S X="""",Y=$S(DTYPE:"",1:"""")
 ;
 S DFORM=+$G(DFORM) ; JSON:0  XML:1  TEXT:2
 I OPTION="addTags" D  Q STRING
 . S:DFORM=0 STRING=X_NAME_X_":"_Y_VALUE_Y
 . S:DFORM=1 STRING="<"_NAME_">"_VALUE_"</"_NAME_">"
 . S:DFORM=2 STRING=VALUE
 ;
 I OPTION="addList" D  Q STRING
 . S:DFORM=0 STRING=STRING_$S($L(STRING):", ",1:"")_Y_VALUE_Y ;SEQ>1
 . S:DFORM=1 STRING=STRING_"<"_NAME_">"_VALUE_"</"_NAME_">"
 . S:DFORM=2 STRING=STRING_$S($L(STRING):"~",1:"")_Y_VALUE_Y ;SEQ>1
 ;
 Q STRING
 ;
VALID(X) ; -- return 1 or 0, if X is a valid string
 ; Cannot be null or only white space
 S X=$G(X)
 I X="" Q 0
 I X?." " Q 0
 ;I X?.P Q 0
 Q 1
 ;
ESC(X) ; -- convert key characters for outgoing XML/JSON
 Q:DFORM=2 X
 I DFORM=0 Q $$ESC^XLFJSON(X)
 ; DFORM=1 XML
 N I,Y,QOT S QOT=""""
 ; strip control characters ;p16 add $C(0)
 F I=0:1:8,11,12,14:1:31 I X[$C(I) S X=$TR(X,$C(I))
 ; p17 strip non-printable characters
 F I=127:1:159 I X[$C(I) S X=$TR(X,$C(I))
 ; handle special characters:
 ;  DDESC = 1 ('&' only), 2 ('&' + CDATA), or
 ;  default (0/null/undefined) = CDATA only
 I (X["&")!(X["<")!(X[">")!(X["'")!(X[QOT) D  Q Y
 . I $G(DDESC) D  Q:DDESC=1  S X=Y
 .. S Y=$P(X,"&") F I=2:1:$L(X,"&") S Y=Y_"&amp;"_$P(X,"&",I)
 .. S X=Y,Y=$P(X,"<") F I=2:1:$L(X,"<") S Y=Y_"&lt;"_$P(X,"<",I)
 .. S X=Y,Y=$P(X,">") F I=2:1:$L(X,">") S Y=Y_"&gt;"_$P(X,">",I)
 .. S X=Y,Y=$P(X,"'") F I=2:1:$L(X,"'") S Y=Y_"&apos;"_$P(X,"'",I)
 .. S X=Y,Y=$P(X,QOT) F I=2:1:$L(X,QOT) S Y=Y_"&quot;"_$P(X,QOT,I)
 . I X["]]>" D  S X=Y ;p16 strip end brackets from transcription upload
 .. S Y=$P(X,"]]>") F I=2:1:$L(X,"]]>") S Y=Y_$P(X,"]]>",I)
 . S Y="<![CDATA["_X_"]]>"
 Q X
 ;
PREPROC(DIENTY) ; -- pre-processing logic
 N X
 S X=$G(^DDE(+DIENTY,2)) X:X'="" X
 Q
 ;
IENPROC ; -- IEN processing logic
 ; setting DDEOUT will cause this record (IEN) to not be returned
 N X
 S X=$G(^DDE(+DIENTY,4)) X:X'="" X
 Q
 ;
ITMPROC ; -- ITEM processing logic
 ; setting DDEOUT will cause this item to not be returned
 N X
 S X=$G(^DDE(+DIENTY,1,+ITM,6)) X:X'="" X
 Q
 ;
POST(DIENTY) ; -- post-processing logic
 N X
 S X=$G(^DDE(+DIENTY,3)) X:X'="" X
 Q
