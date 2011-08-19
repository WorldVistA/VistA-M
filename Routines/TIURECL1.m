TIURECL1 ; SLC/PKR,JER - Expand/collapse LM views ;5/8/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,113**;Jun 20, 1997
 ; 7/6 Split TIURECL into TIURECL & TIURECL1, move RESOLVE to TIURECL1
 ; 7/10 Move INSID, INSADD, VEXREQ, ISSUB to TIURECL1
 ; 9/7 Move INSKIDS, INSADD, & associated modules to TIURECL2
 ;=======================================================================
ISSUB(CLASS1,CLASS2,LEVEL) ;Return true if CLASS2 is sub to CLASS1.
 N IND,ISSUB
 I LEVEL(CLASS1)'<LEVEL(CLASS2) Q 0
 ;Check sublevel links between class1 and class2
 S ISSUB=1
 F IND=(CLASS1+1):1:(CLASS2-1) D
 . I LEVEL(IND)=1 D  Q
 .. S ISSUB=0
 Q ISSUB
 ;
 ;======================================================================
VEXREQ(VALMY) ;Check for valid expand/contract requests.
 ; A list of documents to expand/contract is invalid if any docmt
 ;is a sub docmt of another docmt on the list.
 N END,START
 S START=$O(VALMY(""))
 S END=$O(VALMY(""),-1)
 I START=END Q 1
 ;
 N ACTION,ACTIND,ACTJND,CIND,CN,IND,JND,LEVEL,MSG,TEXT,VALID
 ;Build the level list.
 F IND=START:1:END D
 . S LEVEL(IND)=$L(@VALMAR@(IND,0),"|")
 S VALID=1
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:+IND'>0  D
 . S TEXT(IND)=$G(@VALMAR@(IND,0))
 . S ACTIND=$S(TEXT(IND)["+":"+ ",TEXT(IND)["-":"-",1:"")
 . I ACTIND="" Q
 . S ACTION(IND)=$S(TEXT(IND)["+":"expand ",TEXT(IND)["-":"collapse ",1:"")
 . S JND=IND
 . F  S JND=$O(VALMY(JND)) Q:+JND'>0  D
 .. S TEXT(JND)=$G(@VALMAR@(JND,0))
 .. S ACTJND=$S(TEXT(JND)["+":"+",TEXT(JND)["-":"-",1:"")
 .. I ACTJND="" Q
 .. S ACTION(JND)=$S(TEXT(JND)["+":"expand ",TEXT(JND)["-":"collapse ",1:"")
 .. I $$ISSUB(IND,JND,.LEVEL) D
 ... I ACTION(IND)'=ACTION(JND) D  Q
 .... S CIND(IND)=$P(^TMP("TIURIDX",$J,IND),U,2)
 .... S CN(IND)=$P(^TIU(8925,CIND(IND),0),U,1)
 .... S CIND(JND)=$P(^TMP("TIURIDX",$J,JND),U,2)
 .... S CN(JND)=$P(^TIU(8925,CIND(JND),0),U,1)
 .... I '+$G(HUSH) D
 ..... S MSG="You cannot "_ACTION(IND)_CN(IND)_" and "_ACTION(JND)_CN(JND)
 ..... D MSG^VALM10(MSG)
 ..... H 4
 .... S VALID=0
 Q VALID
 ;======================================================================
IDDATA(TIUDA,TIUD0,TIUD21) ; Return TIUGDATA:
 ; TIUGDATA = 0 or
 ;        = TIUDA^haskid^IDparent^prmsort, where
 ;           TIUDA = note DA
 ;          haskid = 1 if note has ID kid, else 0
 ;        IDparent = parent DA if note has ID parent, else 0
 ;         prmsort = 'TITLE' if entries ordered by title, else 'REFDT'
 ;Note: TIUGDATA is nonzero if note is POSSIBLE DAD, or dad, or kid.
 ; Requires TIUDA; TIUD0 & TIUD21 are optional
 N HASIDKID,POSSPRNT,TIUDPRM,PRMSORT,TIUGDATA
 I '$G(TIUD0) S TIUD0=^TIU(8925,TIUDA,0)
 I '$D(TIUD21) S TIUD21=+$G(^TIU(8925,TIUDA,21))
 S (TIUGDATA,POSSPRNT)=0
 S HASIDKID=$$HASIDKID^TIUGBR(TIUDA)
 I 'TIUD21,'HASIDKID S POSSPRNT=$$POSSPRNT^TIULP(+TIUD0) ;has bus rules
 I TIUD21!HASIDKID!POSSPRNT D
 . I 'TIUD21 D  I 1
 . . D DOCPRM^TIULC1(+TIUD0,.TIUDPRM)
 . . S PRMSORT=$S($P($G(TIUDPRM(0)),U,18):"TITLE",1:"REFDT")
 . E  S PRMSORT=""
 . S TIUGDATA=TIUDA_U_HASIDKID_U_TIUD21_U_PRMSORT
 Q TIUGDATA
 ;
RESOLVE(DA,TSTART,FIRSTPFX,XIDDATA) ; Get document data for insertion
 ;  Receives DA, TSTART, FIRSTPFX
 ;    FIRSTPFX = $$INSPFIX of parent of inserted document.
 ;  Returns line TSTART.
 ;  Receives XIDDATA by ref, finds it, and passes it back.
 N DIC,DIQ,DR,TIUR,PT,MOM,ADT,DDT,LCT,AUT,AMD,EDT,SDT,XDT,RMD,TIULST4
 N TIUP,TIUD0,TIUD12,TIUD13,TIUD15,TIULI,STATX,DOC,TIUY,TIUI,TIUFLDS
 N PREFIX,GETTL,GETPT,TIUD21,INSTA,TIUSTN
 I '$D(^TIU(8925,DA,0)) S TIUY="Record #"_DA_" is missing." G RESOLVEX
 S TIUD0=$G(^TIU(8925,+DA,0)),TIUD12=$G(^TIU(8925,+DA,12))
 S TIUD13=$G(^TIU(8925,+DA,13)),TIUD15=$G(^TIU(8925,+DA,15))
 S TIUD21=$G(^TIU(8925,+DA,21))
 S XIDDATA=$$IDDATA(DA,TIUD0,TIUD21)
 S PREFIX=$$PREFIX^TIULA2(DA),PREFIX=FIRSTPFX_PREFIX
 S GETTL=$$GETTL(TIUD0,PREFIX)
 ; Most screens have docmt title in 1st column, but some have pat nm:
 S DOC=$S($D(VALMDDF("PATIENT NAME")):$P(GETTL,U),1:$P(GETTL,U,2)_$P(GETTL,U))
 S TIUFLDS("DOCUMENT TYPE")="DOC"
 S TIUFLDS("TITLE")="DOC"
 S GETPT=$$GETPT(TIUD0,PREFIX)
 S TIULI=$E(GETPT)
 S PT=$P(GETPT,U,2)_$P(GETPT,U)
 S TIUFLDS("PATIENT NAME")="PT"
 S TIULST4=$E($P($G(^DPT(+$P(TIUD0,U,2),0)),U,9),6,9)
 S TIULST4="("_TIULI_TIULST4_")"
 S TIUFLDS("LAST I/LAST 4")="TIULST4"
 S ADT=$$DATE^TIULS($P(TIUD0,U,7),"MM/DD/YY")
 S TIUFLDS("ADMISSION DATE")="ADT"
 S DDT=$$DATE^TIULS($P(TIUD0,U,8),"MM/DD/YY"),LCT=$P(TIUD0,U,10)
 S TIUFLDS("DISCH DATE")="DDT"
 S TIUFLDS("LINE COUNT")="AMD"
 S AMD=$$PERSNAME^TIULC1($P(TIUD12,U,8)) S:AMD="UNKNOWN" AMD=""
 S AUT=$$PERSNAME^TIULC1($P(TIUD12,U,2)) S:AUT="UNKNOWN" AUT=""
 S AMD=$$NAME^TIULS(AMD,"LAST, FI MI")
 S TIUFLDS("ATTENDING")="AMD"
 S TIUFLDS("COSIGNER")="AMD"
 I $D(^TMP("TIUR",$J,"CTXT")) S AUT=$$NAME^TIULS(AUT,"LAST,FI") I 1
 E  S AUT=$$NAME^TIULS(AUT,"LAST, FI MI")
 S TIUFLDS("AUTHOR")="AUT"
 I $D(^TMP("TIUR",$J,"CTXT")) S EDT=$$DATE^TIULS($P(TIUD13,U),"MM/DD/YY HR:MIN") I 1
 E  S EDT=$$DATE^TIULS($P(TIUD13,U),"MM/DD/YY")
 S TIUFLDS("REF DATE")="EDT"
 S XDT=$$DATE^TIULS($P(TIUD13,U,7),"MM/DD/YY")
 S TIUFLDS("DICT DATE")="XDT"
 S SDT=$S(+$P(TIUD15,U,7):+$P(TIUD15,U,7),+$P(TIUD0,U,5)'<7:+$P(TIUD15,U),1:"")
 S SDT=$$DATE^TIULS(SDT,"MM/DD/YY")
 S TIUFLDS("SIG DATE")="SDT"
 S STATX=$$LOW^XLFSTR($P($G(^TIU(8925.6,+$P(TIUD0,U,5),0)),U))
 S TIUFLDS("STATUS")="STATX"
 S INSTA=""
 I +$P(TIUD12,U,12)>0 D
 . S TIUSTN=$$NS^XUAF4($P(TIUD12,U,12))
 . I $P(TIUSTN,U,2)]"" S INSTA=$P(TIUSTN,U,2)
 S INSTA=$E(INSTA,1,8)
 S TIUFLDS("DIVISION")="INSTA"
 S (TIUI,TIUY)=""
 S TIUY=$$SETFLD^VALM1(TSTART,TIUY,"NUMBER")
 F  S TIUI=$O(TIUFLDS(TIUI)) Q:TIUI=""  D
 . S:$D(VALMDDF(TIUI)) TIUY=$$SETFLD^VALM1(@TIUFLDS(TIUI),TIUY,TIUI)
RESOLVEX Q TIUY
 ;
GETPT(TIUD0,PREFIX) ; Get patient column data; put updated prefix data
 ;in second ^ piece
 ;  Receives TIUDO, PREFIX.
 ;  Returns (patient col data)^PREFIX
 N TIUY
 S TIUY=$$NAME^TIULS($$PTNAME^TIULC1($P(TIUD0,U,2)),"LAST,FI MI")
 I $D(PREFIX) S TIUY=TIUY_U_PREFIX
 Q TIUY
 ;
GETTL(TIUD0,PREFIX) ; Get title column data; put updated prefix
 ;data in second ^ piece.
 ;  Receives TIUDO, PREFIX.
 ;  Returns (title col data)^PREFIX
 N TIUY
 S TIUY=$$PNAME^TIULC1(+TIUD0)
 I TIUY="Addendum" S TIUY="Addendum to "_$$PNAME^TIULC1(+$G(^TIU(8925,+$P(TIUD0,U,6),0)))
 I $D(PREFIX) S TIUY=TIUY_U_PREFIX
 Q TIUY
 ;
SETTLPT(STRING,DA,PREFIX) ; Set field TITLE or PATIENT into string,
 ;with prefix as first chars of string.
 ;  Receives STRING, DA, PREFIX:
 ;    PREFIX = beginning chars of title/pt column, up to but not
 ;             including title/pt itself.
 ;  Returns STRING.
 N PT,DOC,TIUD0
 S TIUD0=^TIU(8925,DA,0)
 I $D(VALMDDF("PATIENT NAME")) D  I 1
 . S PT=$$GETPT(TIUD0,PREFIX)
 . S PT=$P(PT,U,2)_$P(PT,U)
 . S STRING=$$SETFLD^VALM1(PT,STRING,"PATIENT NAME")
 E  D
 . S DOC=$$GETTL(TIUD0,PREFIX)
 . S DOC=$P(DOC,U,2)_$P(DOC,U)
 . S STRING=$$SETFLD^VALM1(DOC,STRING,"TITLE")
 Q STRING
