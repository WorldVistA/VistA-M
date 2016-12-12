ORQQPL1 ; ALB/PDR,REV,ISL/JER/TC - PROBLEM LIST FOR CPRS GUI ;08/26/14  09:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,148,173,203,206,249,243,280,306,361,385,350**;Dec 17, 1997;Build 77
 ;
 ;------------------------- GET PROBLEM FROM LEXICON -------------------
 ;
LEXSRCH(LIST,FROM,N,VIEW,ORDATE) ; Get candidate Problems from LEX file
 N LEX,VAL,VAL1,COD,CIEN,SYS,MAX,NAME,ORIMPDT,ICDCSYS,ICDCODE
 S ORIMPDT=$$IMPDATE^LEXU("10D")
 S:'+$G(ORDATE) ORDATE=DT
 S:'$G(N) N=100
 S:'$L($G(VIEW)) VIEW="PL1"
 D CONFIG^LEXSET("GMPL",VIEW,ORDATE)
 D LOOK^LEXA(FROM,"GMPL",N,"",ORDATE)
 S S=0
 F  S S=$O(LEX("LIST",S)) Q:S<1  D
 . S VAL1=LEX("LIST",S)
 . S COD="",CIEN="",SYS="",NAME="",ICDCODE=""
 . S ICDCSYS=$S(ORDATE<ORIMPDT:"ICD",1:"10D")
 . I $L(VAL1,"CPT-4 ")>1 D
 .. S SYS=$S(ORDATE<ORIMPDT:"ICD-9-CM ",1:"ICD-10-CM ")
 .. S COD=$S(ORDATE<ORIMPDT:"799.9",1:"R69")
 .. S CIEN=""
 .. S NAME=$P(VAL1," (CPT-4")
 . I $L(VAL1,"DSM-IV ")>1 D
 .. S SYS="DSM-IV "
 .. S COD=$P($P(VAL1,SYS,2),")")
 .. S:COD["/" COD=$P(COD,"/",1)
 .. S ICDCODE=$$ONE^LEXU($P(VAL1,U,1),ORDATE,ICDCSYS)
 .. S ICDCODE=$S(ICDCODE["":COD,1:ICDCODE)
 .. S CIEN=+$$ICDDATA^ICDXCODE(ICDCSYS,$G(ICDCODE),ORDATE,"E")
 .. S NAME=$P(VAL1," (DSM-IV")
 .. ;
 . I $L(VAL1,"(TITLE 38 ")>1 D
 .. S SYS="TITLE 38 "
 .. S COD=$P($P(VAL1,SYS,2),")")
 .. S:COD["/" COD=$P(COD,"/",1)
 .. S ICDCODE=$$ONE^LEXU($P(VAL1,U,1),ORDATE,ICDCSYS)
 .. S ICDCODE=$S(ICDCODE["":COD,1:ICDCODE)
 .. S CIEN=+$$ICDDATA^ICDXCODE(ICDCSYS,$G(ICDCODE),ORDATE,"E")
 .. S NAME=$P(VAL1,"(TITLE 38 ")
 .. ;
 . I $L(VAL1,"ICD-9-CM ")>1 D
 .. S SYS="ICD-9-CM "
 .. S COD=$P($P(VAL1,SYS,2),")")
 .. S:COD["/" COD=$P(COD,"/",1)
 .. S CIEN=+$$ICDDATA^ICDXCODE("DIAG",$G(COD),ORDATE,"E")
 .. S NAME=$P(VAL1," (ICD-9-CM")
 .. ;
 . I $L(VAL1,"ICD-10-CM ")>1 D
 .. S SYS="ICD-10-CM "
 .. S COD=$P($P(VAL1,SYS,2),")")
 .. S:COD["/" COD=$P(COD,"/",1)
 .. S CIEN=+$$ICDDATA^ICDXCODE("DIAG",$G(COD),ORDATE,"E")
 .. S NAME=$P(VAL1," (ICD-10-CM")
 . I $L(NAME)=0 S NAME=$P($P(VAL1," (")," *")
 . ;
 . ; jeh Clean left over codes
 . S NAME=$P(NAME," (CPT-4")
 . S NAME=$P(NAME," (DSM-IV")
 . S NAME=$P(NAME,"(TITLE 38 ")
 . S NAME=$P(NAME," (ICD-9-CM")
 . S NAME=$P(NAME," (ICD-10-CM")
 . ;
 . S VAL=NAME_U_COD_U_CIEN_U_SYS ; ien^.01^icd^icdifn^system
 . S LIST(S)=VAL
 . S MAX=S
 I $G(MAX)'="" S LIST(MAX+1)=$G(LEX("MAT"))
 K ^TMP("LEXSCH",$J)
 Q
 ;
SORT(LEX) ; Sort terms alphabetically
 N ORI S ORI=0
 F  S ORI=$O(LEX("LIST",ORI)) Q:+ORI'>0  S LEX("ALPHA",$E($P(LEX("LIST",ORI),U,2),1,255),ORI)=""
 Q
 ;
ICDREC(COD) ;
 N CODIEN,ICDCSYS
 I COD="" Q ""
 S COD=$P($P(COD,U),"/")
 S ICDCSYS=$$SAB^ICDEX(+$$CODECS^ICDEX($G(COD),80,DT),DT) ;ICR #5747
 S CODIEN=+$$ICDDATA^ICDXCODE(ICDCSYS,$G(COD),DT,"E") ;ICR #5699
 Q CODIEN
 ;
CPTREC(COD) ;
 I COD="" Q ""
 Q $$CODEN^ICPTCOD(COD) ;ICR #1995
 ;
EDLOAD(RETURN,DA) ; LOAD  EDIT ARRAYS
 ; DA=problem IFN
 N I,GMPFLD,GMPORIG,GMPL
 D GETFLDS^GMPLEDT3(DA)
 S I=0
 D LOADFLDS(.RETURN,"GMPFLD","NEW",.I)
 D LOADFLDS(.RETURN,"GMPORIG","ORG",.I)
 K GMPFLD,GMPORIG,GMPL  ; should not have to do this
 Q
 ;
LOADFLDS(RETURN,NAM,TYP,I) ; LOAD FIELDS FOR TYPE OF ARRAY
 N S,V,CVP,PN,PID
 S S="",V=$C(254)
 F  S S=$O(@NAM@(S)) Q:S=10  D
 . S RETURN(I)=TYP_V_S_V_@NAM@(S)
 . S I=I+1
 S S=""
 F  S S=$O(@NAM@(10,S)) Q:S=""  D
 . S CVP=@NAM@(10,S)
 . S PN="" ; provider name
 . S PID=$P(CVP,U,6) ; provider id
 . I PID'=""  S PN=$$GET1^DIQ(200,PID,.01) ; get provider name
 . S RETURN(I)=TYP_V_"10,"_S_V_CVP_U_PN
 . S I=I+1
 S S=80000
 F  S S=$O(@NAM@(S)) Q:S=""  D
 . S RETURN(I)=TYP_V_S_V_@NAM@(S)
 . S I=I+1
 Q
 ;
EDSAVE(RETURN,GMPIFN,GMPROV,GMPVAMC,UT,EDARRAY,GMPSRCH) ; SAVE EDITED RES
 ; RETURN - boolean, 1 success, 0 failure
 ; EDARRAY - array used for indirect sets of GMPORIG() and GMPFLDS()
 ;
 N GMPFLD,GMPORIG,S,GMPLUSER
 S GMPSRCH=$G(GMPSRCH)
 S RETURN=1 ; initialize for success
 I UT S GMPLUSER=1
 ;
 S S=""
 F  S S=$O(EDARRAY(S)) Q:S=""  D
 . S @EDARRAY(S)
 I $D(GMPFLD(10,"NEW"))>9 D  I 'RETURN Q  ; Bail Out if no lock
 . L +^AUPNPROB(GMPIFN,11):10  ; given bogus nature of this lock, should be able to get
 . I '$T S RETURN=0
 ;
 D EN^GMPLSAVE  ; save the data
 K GMPFLD,GMPORIG
 ;
 L -^AUPNPROB(GMPIFN,11)  ; free this instance of lock (in case it was set)
 S RETURN=1
 Q
 ;
UPDATE(ORRETURN,UPDARRAY) ; UPDATE A PROBLEM RECORD
 ; Does essentially same job as EDSAVE above, however does not handle edits to comments
 ; or addition of multiple comments.
 ; Use initially just for status updates.
 ;
 N S,GMPL,GMPORIG,ORARRAY ; last 2 vars created in nested call
 S S=""
 F  S S=$O(UPDARRAY(S)) Q:S=""  D
 . S @UPDARRAY(S)
 D UPDATE^GMPLUTL(.ORARRAY,.ORRETURN)
 ; broker wont pick up root node RETURN
 S ORRETURN(1)=ORRETURN(0) ; error text
 S ORRETURN(0)=ORRETURN ; gmpdfn
 I ORRETURN(0)=""  S ORRETURN=1 ; insurance ? need
 Q
 ;
ADDSAVE(RETURN,GMPDFN,GMPROV,GMPVAMC,ADDARRAY,GMPSRCH) ; SAVE NEW RECORD
 ; RETURN - Problem IFN if success, 0 otherwise
 ; ADDARRAY - array used for indirect sets of  GMPFLDS()
 ;
 N DA,GMPFLD,GMPORIG,S
 S GMPSRCH=$G(GMPSRCH)
 S RETURN=0 ;
 L +^AUPNPROB(0):10
 Q:'$T  ; bail out if no lock
 ;
 S S=""
 F  S S=$O(ADDARRAY(S)) Q:S=""  D
 . S @ADDARRAY(S)
 ;
 D NEW^GMPLSAVE
 ;
 S RETURN=DA
 ;
 L -^AUPNPROB(0)
 S RETURN=1
 Q
 ;
INITUSER(RETURN,ORDUZ) ; INITIALIZE FOR NEW USER
 ; taken from INIT^GMPLMGR
 ; leave GMPLUSER on symbol table - is evaluated in EDITSAVE
 ;
 N X,PV,CTXT,GMPLPROV,ORENT
 S ORDUZ=$G(ORDUZ,DUZ)
 S GMPLUSER=$$CLINUSER(ORDUZ)
 S CTXT=$$GET^XPAR("ALL","ORCH CONTEXT PROBLEMS",1)
 S X=$G(^GMPL(125.99,1,0)) ; IN1+6^GMPLMGR
 S RETURN(0)=GMPLUSER ;  problem list user, or other user
 S RETURN(1)=$$VIEW^GMPLX1(ORDUZ) ; GMPLVIEW("VIEW") - users default view
 S RETURN(2)=+$P(X,U,2) ; verify transcribed problems
 S RETURN(3)=+$P(X,U,3) ; prompt for chart copy
 S RETURN(4)=+$P(X,U,4) ; use lexicon
 S RETURN(5)=$S($P(X,U,5)="R":1,1:0) ; chron or reverse chron listing
 S RETURN(6)=$S($P($G(CTXT),";",3)'="":$P($G(CTXT),";",3),1:"A")
 S GMPLPROV=$P($G(CTXT),";",5)
 I +GMPLPROV>0,$D(^VA(200,GMPLPROV)) D
 . S RETURN(7)=GMPLPROV_U_$P(^VA(200,GMPLPROV,0),U)
 E  S RETURN(7)="0^All"
 S RETURN(8)=$$SERVICE^GMPLX1(ORDUZ) ; user's service/section
 ; Guessing from what I see in the data that $$VIEW^GMPLX1 actually returns a composite
 ; of default view (in/out patient)/(c1/c2... if out patient i.e. GMPLVIEW("CLIN")) or
 ;                                                      /(s1/s2... if in patient i.e. GMPLVIEW("SERV"))
 ; Going with this assumption for now:
 I $L(RETURN(1),"/")>1 D
 . S PV=RETURN(1)
 . S RETURN(1)=$P(PV,"/")
 . I RETURN(1)="C" S GMPLVIEW("CLIN")=$P(PV,"/",2,99)
 . I RETURN(1)="S" S GMPLVIEW("SERV")=$P(PV,"/",2,99)
 S RETURN(9)=$G(GMPLVIEW("SERV")) ; ??? Where from - see tech doc
 S RETURN(10)=$G(GMPLVIEW("CLIN")) ; ??? Where from - see tech doc
 S RETURN(11)=""
 S RETURN(12)=+$P($G(CTXT),";",4)    ; should comments display?
 S ORENT="ALL^SRV.`"_+$$SERVICE^GMPLX1(ORDUZ,1)
 S RETURN(13)=+$$GET^XPAR(ORENT,"ORQQPL SUPPRESS CODES",1) ; suppress codes?
 K GMPLVIEW
 Q
 ;
CLINUSER(ORDUZ) ;is this a clinical user?
 N ORUSER
 S ORUSER=0
 I $D(^XUSEC("ORES",ORDUZ)) S ORUSER=1
 I $D(^XUSEC("ORELSE",ORDUZ)) S ORUSER=1
 I $D(^XUSEC("PROVIDER",ORDUZ)) S ORUSER=1
 Q ORUSER
 ;
INITPT(RETURN,DFN) ; GET PATIENT PARAMETERS
 Q:+$G(DFN)=0
 N GMPSC,GMPAGTOR,GMPION,GMPGULF,GMPHNC,GMPMST,GMPCV,GMPSHD
 ;
 S RETURN(0)=DUZ(2) ; facility #
 D DEM^VADPT ; get death indicator
 S RETURN(1)=$G(VADM(6)) ; death indicator
 D VADPT^GMPLX1(DFN) ; get eligibilities
 S RETURN(2)=$P(GMPSC,U) ; service connected
 S RETURN(3)=$G(GMPAGTOR) ; agent orange exposure
 S RETURN(4)=$G(GMPION) ; ionizing radiation exposure
 S RETURN(5)=$G(GMPGULF) ; gulf war exposure
 S RETURN(6)=VA("BID") ; need this to reconstitute GMPDFN on return
 S RETURN(7)=$G(GMPHNC) ; head/neck cancer
 S RETURN(8)=$G(GMPMST) ; MST
 S RETURN(9)=$G(GMPCV) ; CV
 S RETURN(10)=$G(GMPSHD) ; SHAD
 Q
 ;
PROVSRCH(LST,FLAG,N,FROM,PART) ; Get candidate Rroviders from person file
 N LV,NS,RV,IEN
 S RV=$NAME(LV("DILIST","ID"))
 IF +$G(N)=0 S N=50
 S FLAG=$G(FLAG),N=$G(N),FROM=$G(FROM),PART=$G(PART)
 D LIST^DIC(200,"",".01;1",FLAG,N,FROM,PART,"","","","LV")
 S NS=""
 F  S NS=$O(LV("DILIST",1,NS)) Q:NS=""  D
 . S IEN=""
 . S IEN=$O(^VA(200,"B",@RV@(NS,.01),IEN)) ; compliments of PROV^ORQPTQ
 . S LST(NS)=IEN_U_@RV@(NS,.01)  ; initials_U_@RV@(NS,1)
 Q
 ;
CLINSRCH(Y,X) ; Get LIST OF CLINICS
 ; Note: This comes from CLIN^ORQPTQ2, where it was commented out in place of
 ; a call to ^XPAR. I would have just used CLIN^ORQPTQ2, but it didn't work - at
 ; least on SLC OEX directory.
 ; X has no purpose other than to satisfy apparent rpc and tcallv requirement for args
 N I,NAME,IEN
 S I=1,IEN=0,NAME=""
 ;access to SC global granted under DBIA #518:
 F  S NAME=$O(^SC("B",NAME)) Q:NAME=""  S IEN=$O(^(NAME,0)) D
 . I $P(^SC(IEN,0),"^",3)="C" S Y(I)=IEN_"^"_NAME,I=I+1
 Q
 ;
SRVCSRCH(Y,FROM,DIR,ALL) ; GET LIST OF SERVICES
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I=CNT  S FROM=$O(^DIC(49,"B",FROM),DIR) Q:FROM=""  D
 . S IEN=$O(^DIC(49,"B",FROM,0)) I '$G(ALL),$P(^DIC(49,IEN,0),U,9)'="C" Q
 . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
 ;
DUP(Y,DFN,TERM,TEXT) ;Check for duplicate problem
 S Y=$$DUPL^GMPLX(DFN,TERM,TEXT) Q:+Y=0
 I $P(^AUPNPROB(Y,1),U,2)="H" S Y=0 Q
 S Y=Y_U_$P(^AUPNPROB(Y,0),U,12)
 Q
GETDX(CODE,SYS,ORIDT) ; Get ICD associated with SNOMED CT or VHAT Code
 N LEX,ORI,ORY,ORUH,IMPLDT,ORCSYSPR
 S ORIDT=$G(ORIDT,DT)
 S ORY=0,IMPLDT=$$IMPDATE^LEXU("10D")
 S ORUH=$S(ORIDT<IMPLDT:"799.9",1:"R69.")
 S ORCSYSPR=$S(ORIDT<IMPLDT:1,1:30)
 I SYS["VHAT" D  I 1
 . I ORIDT<IMPLDT S ORY=$$GETASSN^LEXTRAN1(CODE,"VHAT2ICD") I 1
 . E  S ORY=0
 E  D
 . I ORIDT<IMPLDT S ORY=$$GETASSN^LEXTRAN1(CODE,"SCT2ICD") I 1
 . E  S ORY=0
 I $S(+ORY'>0:1,+$P(ORY,U,2)'>0:1,+LEX'>0:1,1:0) S ORY=ORUH G GETDXX
 S ORI=0,ORY=""
 F  S ORI=$O(LEX(ORI)) Q:+ORI'>0  D
 . N ICD
 . S ICD=$O(LEX(ORI,""))
 . S:'+$$STATCHK^ICDXCODE(ORCSYSPR,ICD,ORIDT) ICD=""
 . I ICD]"" S ORY=$S(ORY'="":ORY_"/",1:"")_ICD
 I (ORY]""),(ORY'[".") S ORY=ORY_"."
GETDXX Q ORY
TEST ; test invocation
 N LIST,I S I=""
 D LEXSRCH(.LIST,"diabetes with neuro",10,"GMPL",DT)
 F  S I=$O(LIST(I)) Q:+I'>0  W !,LIST(I)
 Q
