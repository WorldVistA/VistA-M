TIULX ; SLC/JER - Cross-reference library functions ;6/21/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**1,28,79,100,136,219**;Jun 20, 1997;Build 11
 ; File 200 - IA 10060
 ; ^ORD(101 - IA 872
 ; ^DISV    - IA 510
ALOCP(DA) ; Should record be included in daily print queue by location?
 ; Receives DA = record # in 8925
 Q +$$ISPN(+$G(^TIU(8925,+DA,0)))
APTP(DA) ; Should record be included in daily print queue by patient?
 ; Receives DA = record # in 8925
 Q +$$ISPN(+$G(^TIU(8925,+DA,0)))
AAUP(DA) ; Should record be included in daily print queue by author?
 ; Receives DA = record # in 8925
 Q +$$ISPN(+$G(^TIU(8925,+DA,0)))
BELONGS(TIUDA,CLASS) ; Evaluate whether a given document belongs to a
 ;                 particular document class
 N TIUY
 I +$$ISADDNDM^TIULC1(TIUDA) S TIUDA=+$P($G(^TIU(8925,+TIUDA,0)),U,6)
 S TIUY=+$$ISA(+$G(^TIU(8925,+TIUDA,0)),CLASS)
 Q TIUY
ISA(DA,CLASS) ; Evaluate whether a given document type is a member of a
 ;         particular document class
 ; Receives DA = record # in 8925.1, and
 ;       CLASS = record # of class in 8925.1
 N TIUI,TIUY S (TIUI,TIUY)=0
 F  S TIUI=$O(^TIU(8925.1,"AD",DA,TIUI)) Q:+TIUI'>0!(TIUY=1)  D
 . I TIUI=CLASS S TIUY=1 Q
 . S TIUY=$$ISA(TIUI,CLASS)
 Q TIUY
ISPN(DA) ; Evaluate whether a given document is a Progress Note
 ; Receives DA = record # in 8925.1
 N TIUI,TIUY S (TIUI,TIUY)=0
 F  S TIUI=$O(^TIU(8925.1,"AD",DA,TIUI)) Q:+TIUI'>0!(TIUY=1)  D
 . I TIUI=3 S TIUY=1 Q
 . S TIUY=$$ISPN(TIUI)
 Q TIUY
ISCWAD(DA) ; Evaluate whether a given title is a CWAD
 ;Is the given title in a CWAD document class?
 ;New for ID notes
 ; Receives DA = record # in 8925.1
 Q $S($$ISA(DA,25):1,$$ISA(DA,27):1,$$ISA(DA,30):1,$$ISA(DA,31):1,1:0)
ISDS(DA) ; Evaluate whether a given document is a Discharge Summary
 ; Receives DA = record # in 8925.1
 N TIUI,TIUY S (TIUI,TIUY)=0
 F  S TIUI=$O(^TIU(8925.1,"AD",DA,TIUI)) Q:+TIUI'>0!(TIUY=1)  D
 . I TIUI=244 S TIUY=1 Q
 . S TIUY=$$ISDS(TIUI)
 Q TIUY
TRNSFRM(RTYPE,FLD,X) ; Executes Transform code for a given header field
 N XFORM
 S FLD=$O(^TIU(8925.1,+RTYPE("TYPE"),"HEAD","D",+FLD,0))
 I +FLD'>0 G TRNSFRMX
 S XFORM=$G(^TIU(8925.1,+RTYPE("TYPE"),"HEAD",+FLD,1))
 I XFORM']"" G TRNSFRMX
 X XFORM
TRNSFRMX Q X
MENUS ; Evaluate/enforce user's menu display preference
 N TIUI,TIUPREF S TIUPREF=$$PERSPRF^TIULE(DUZ),TIUI=0
 F  S TIUI=$O(^DISV(DUZ,"VALMMENU",TIUI)) Q:+TIUI'>0  D
 . I $P($G(^ORD(101,+TIUI,0)),U)["TIU" S ^DISV(DUZ,"VALMMENU",TIUI)=$S($P(TIUPREF,U,5)=0:0,1:1)
 Q
XTRASIGN(TIUY,TIUDA) ; Get list of extra signers for a document
 N TIUI,TIUJ,TIUL,DA,DR,DIC,DIQ,TIUXTRA S (TIUI,TIUJ,TIUL)=0
 S DIC="^TIU(8925.7,",DIQ="TIUXTRA"
 F  S TIUI=$O(^TIU(8925.7,"B",TIUDA,TIUI)) Q:+TIUI'>0  D
 . N TIUX,TIUSGNR
 . S DA=TIUI,DR=".03;.04" D EN^DIQ1 Q:+$D(TIUXTRA)'>9
 . I $L($G(TIUXTRA(8925.7,DA,.04))) Q
 . S TIUJ=+$G(TIUJ)+1,TIUL=+$G(TIUL)+1
 . S TIUSGNR=$G(TIUXTRA(8925.7,DA,.03))
 . S TIUX=$$SETSTR^VALM1($G(TIUJ)_")  "_TIUSGNR,$G(TIUX),1,39)
 . S TIUY(TIUL)=DA_U_TIUX
 Q
ASKSIGN(TIUY) ; Identify which Signature to edit
 N I,L,Y
 W !!,"Please Indicate Which Expected Signer to Change:",!
 S (I,L,Y)=0 F  S I=$O(TIUY(I)) Q:+I'>0!+Y  D
 . W:$P(TIUY(I),U)]"" !,$P(TIUY(I),U,2)
 . I I#20=0 S Y=$P($$PICK(1,I,"Select Signer","NO"),U)
 . S L=I
 I L#20,'+Y S Y=$P($$PICK(1,L,"Select Signer","NO"),U)
 I +Y,+$G(TIUY(+Y)) S Y=+$G(TIUY(+Y))
 Q Y
PICK(LOW,HIGH,PROMPT,TYPE) ; List selection
 N X,Y S PROMPT=$G(PROMPT,"Select Item"),TYPE=$G(TYPE,"LO")
 W !
 S Y=$$READ^TIUU(TYPE_U_LOW_":"_HIGH,PROMPT)
 W !
 Q Y
CWAD ; Entry action for CWAD protocol
 N GMRPALG,GMRPCWAD,GMRPDFN,GMRPOPT,GMRPEN,GMRPAGE,GMRPCWAD,GMRPDOB
 N GMRPLOC,GMRPRB,GMRPSSN,GMRPQT
 I $G(TIUGLINK) W !,"Please finish attaching the interdisciplinay note before displaying alerts.",! H 3 Q
 D FULL^VALM1
 I '+$G(DFN),'+$G(ORVP) D  Q
 . W !!,"No Patient Selected...",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . S VALMBCK="R"
 D PAT^GMRPNOR1 I $D(GMRPQT) S VALMBCK="R" Q
 S Y=GMRPDFN,GMRPOPT=1,GMRPEN=1 W !!,"** Current Patient:  "_$P(Y,U,2)
 D ENPAT^GMRPNCW S VALMBCK="R"
 Q
IDSIGNRS(TIUY,TIUDA,TIULIST) ; Add list of Add'l Signers for a TIU Document
 ; TIULIST(TIUI) [By Ref] = array of users to add/remove as signers
 ; TIUDA                  = IEN in ^TIU(8925,
 N TIUI S TIUI=0
 F  S TIUI=$O(TIULIST(TIUI)) Q:+TIUI'>0  D
 . N DA,DIC,DLAYGO,DIE,DR,X,Y
 . ; if current user is already an additional signer, and current user
 . ; is NOT being removed as an additional signer, then QUIT
 . I +$O(^TIU(8925.7,"AE",TIUDA,+TIULIST(TIUI),0)),($P(TIULIST(TIUI),U,3)'="REMOVE") Q
 . ; if current user is being removed as a cosigner, then remove him
 . I $P(TIULIST(TIUI),U,3)="REMOVE" D REMSIGNR(TIUDA,+TIULIST(TIUI)) Q
 . ; otherwise, add the current user as an additional signer
 . S X=""""_"`"_TIUDA_"""",(DIC,DLAYGO)=8925.7,DIC(0)="LX" D ^DIC Q:+Y'>0
 . S DIE=DIC,TIUY=$G(TIUY)_$S($G(TIUY)]"":U,1:"")_+TIULIST(TIUI)
 . S DR=".02////"_0_";.03////"_+$G(TIULIST(TIUI))
 . D ^DIE
 . D SEND^TIUALRT(TIUDA)
 Q
REMSIGNR(TIUDA,TIUDUZ) ; Remove user from additional signer list
 N DA,DIE,DR,DIDEL
 S DA=+$O(^TIU(8925.7,"AE",TIUDA,TIUDUZ,0)) Q:+DA'>0
 S (DIDEL,DIE)=8925.7,DR=".01///@" D ^DIE
 D SEND^TIUALRT(TIUDA)
 Q
GETSIGNR(TIUY,TIUDA) ; RPC to Get list of extra signers for a document
 N TIUI,DA,DR,DIC,DIQ,TIUXTRA,TIUD12,TIUAU,TIUEC S (DA,TIUI)=0
 S DIC="^TIU(8925.7,",DIQ="TIUXTRA"
 F  S DA=$O(^TIU(8925.7,"B",TIUDA,DA)) Q:+DA'>0  D
 . N TIUX,TIUSGNR
 . S DR=".03;.04",DIQ(0)="IE" D EN^DIQ1 Q:+$D(TIUXTRA)'>9
 . I +$G(TIUXTRA(8925.7,DA,.04,"I")) Q
 . S TIUI=+$G(TIUI)+1
 . S TIUY(TIUI)=$G(TIUXTRA(8925.7,DA,.03,"I"))_U_$G(TIUXTRA(8925.7,DA,.03,"E"))
 S TIUD12=$G(^TIU(8925,TIUDA,12))
 S TIUAU=$P(TIUD12,U,4),TIUEC=$P(TIUD12,U,8)
 S TIUI=+$G(TIUI)+1,TIUY(TIUI)=TIUAU_U_$$PERSNAME^TIULC1(TIUAU)_U_"AUTHOR"
 I +TIUEC'>0 Q
 I '$$FIND1^DIC(200,"","","`"_+TIUEC) D CLEAN^DILF Q
 S TIUI=+$G(TIUI)+1,TIUY(TIUI)=TIUEC_U_$$PERSNAME^TIULC1(TIUEC)_U_"EXPECTED COSIGNER"
 Q
HASDS(DFN,VSTR) ; Does an admission have a Discharge Summary?
 N TITLE,TIUDA S (TIUDA,TITLE)=0
 F  S TITLE=$O(^TIU(8925,"APTLD",DFN,TITLE)) Q:+TITLE'>0  D  Q:+TIUDA>0
 . N STATUS,CONTEXT S TIUDA=0
 . I '+$$ISDS(TITLE) S TIUDA=0_U_0 Q
 . F  S TIUDA=$O(^TIU(8925,"APTLD",DFN,TITLE,VSTR,+TIUDA)) Q:+TIUDA'>0  D  Q:+$P(TIUDA,U,2)
 . . S STATUS=+$P($G(^TIU(8925,+TIUDA,0)),U,5)
 . . S CONTEXT=$S(STATUS=0:0,STATUS>13:0,STATUS'>5:2,1:1)
 . . S TIUDA=TIUDA_U_CONTEXT
 I '+TIUDA,($L(TIUDA,U)<2) S TIUDA=TIUDA_U_0
 Q TIUDA
NEEDSIG(TIUY,USER,CLASS)        ; Get list of documents for which USER is an additional signer
 N TIUDA,TIUI,TIUJ S (TIUDA,TIUJ)=0
 S USER=$G(USER,DUZ),CLASS=$G(CLASS,38),TIUY=$NA(^TMP("TIUSIGN",$J))
 K @TIUY ; Clear out return array before query
 F  S TIUDA=$O(^TIU(8925.7,"AES",USER,TIUDA)) Q:+TIUDA'>0  D
 . S TIUI=0 F  S TIUI=$O(^TIU(8925.7,"AES",USER,TIUDA,TIUI)) Q:+TIUI'>0  D
 . . N TIUD0 S TIUD0=$G(^TIU(8925.7,TIUI,0)) Q:+$P(TIUD0,U,4)
 . . Q:'+$$ISA(+$G(^TIU(8925,TIUDA,0)),CLASS)
 . . S TIUJ=+$G(TIUJ)+1,@TIUY@(TIUJ)=TIUDA
 Q
TITLIENS ; Get IENs of DDEF entries that have type Title
 ; in Document Definition file 8925.1
 ;Creates array ^TMP("TIUTLS,$J,TLIEN)=  
 ;Caller must kill ^TMP("TIUTLS",$J) when finished with the global.
 N TIUIDX S TIUIDX=0 K ^TMP("TIUTLS",$J)
 F  S TIUIDX=$O(^TIU(8925.1,"AT","DOC",TIUIDX)) Q:TIUIDX'>0  D
 . S ^TMP("TIUTLS",$J,TIUIDX)=""
 Q
HASDOCMT(DFN) ;Does patient have ANY entries in TIU DOCUMENT file 8925?
 ;Any entries includes original documents, addenda, components
 ;(like S in SOAP notes), "deleted"  documents, retracted documents, etc!
 Q $O(^TIU(8925,"C",+$G(DFN),0))>0
         
