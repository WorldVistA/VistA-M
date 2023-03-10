GMPLX ; ISL/MKB,AJB,JER,TC,PKR -- Problem List Problem Utilities ;03/30/2020
 ;;2.0;Problem List;**7,23,26,28,27,36,42,40,49,53**;Aug 25, 1994;Build 159
 ;
 ; External References
 ;  DBIA   446 ^AUTNPOV(
 ;   ICR  5679 $$IMPDATE^LEXU
 ;   ICR  5747 $$CSI/SAB^ICDEX
 ;   ICR  6953 $$PROVNARR^PXAPI
 ;  DBIA 10060 ^VA(200
 ;  DBIA 10006 ^DIC
 ;  DBIA 10009 FILE^DICN
 ;  DBIA 10013 EN^DIK
 ;  DBIA 10013 IX1^DIK
 ;  DBIA 10026 ^DIR
 ;  DBIA  1609 CONFIG^LEXSET
 ;  DBIA 10103 $$FMTE^XLFDT
 ;  DBIA 10104 $$UP^XLFSTR
 ;  DBIA  2742 GMPLX
 ;
SEARCH(X,Y,PROMPT,UNRES,VIEW) ; Search Lexicon for Problem X
 N DIC S:'$L($G(VIEW)) VIEW="CLF" D CONFIG^LEXSET("GMPX",VIEW,DT)
 S DIC("A")=$S($L($G(PROMPT)):PROMPT,1:"Select PROBLEM: ")
 S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"A",1:"")_"EQM"
 S:'$G(UNRES) LEXUN=0 D ^DIC
 I +Y>1 D
 .N CODE,SRC
 .S X=$P(Y,U,2)
 .D EXP2CODE(+Y,.SRC,.CODE)
 .I (SRC["SNOMED")!(SRC["VHAT") S (X,$P(Y,U,2))=X_" ("_$S(SRC["SNOMED":"SCT",1:"VHAT")_" "_CODE_")",Y(1)=$$GETDX(CODE,SRC)
 Q
 ;
PROVNARR(X,CL) ; Returns IFN^Text of Narrative (#9999999.27)
 N RESULT
 S RESULT=$$PROVNARR^PXAPI(X,9000011,CL)
 I $P(RESULT,U,1)=-1 S RESULT=$$PROVNARR^PXAPI("Invalid narrative passed",9000011)
 Q $P(RESULT,U,1)
 ;
PROBTEXT(IFN) ; Returns Display Text
 N X,Y,ICD,SCTC,GMPL0,GMPL800,GMPL802,GMPLEXP,GMPLPOV,GMPLSO,GMPLTXT,GMPLDT,GMPLCSYS,GMPLILBL
 S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL800=$G(^(800)),GMPL802=$G(^(802))
 I '$L(GMPL0) S X="" G PROBTX
 S GMPLDT=$S(+$P(GMPL802,U,1):$P(GMPL802,U,1),1:$P(GMPL0,U,8))
 S GMPLCSYS=$S($P(GMPL802,U,2)]"":$P(GMPL802,U,2),1:$$SAB^ICDEX($$CSI^ICDEX(80,+GMPL0),GMPLDT))
 S GMPLILBL=$S(GMPLCSYS="10D":"ICD-10-CM ",1:"ICD-9-CM ")
 S ICD=$$CODEC^ICDEX(80,+GMPL0)
 S SCTC=$P(GMPL800,U,1)
 S Y=$P($G(^AUPNPROB(+IFN,0)),U,5),X=$P($G(^AUTNPOV(+Y,0)),U)
 S GMPLEXP=$$EP(IFN),GMPLSO=$$CS(X),GMPLPOV=$$PT(X,GMPLSO)
 S GMPLTXT=GMPLPOV S:$L(GMPLEXP) GMPLTXT=GMPLTXT_" ("_GMPLEXP_")"
 S:GMPLTXT["*" GMPLTXT=$TR(GMPLTXT,"*","")
 S:$L(GMPLTXT) GMPLTXT=GMPLTXT_$S($L($G(ICD))&('$L($G(SCTC))):" ("_GMPLILBL_$G(ICD)_")",$L($G(SCTC)):" (SCT "_$G(SCTC)_")",1:"")
 S:$L(GMPLTXT) X=GMPLTXT
PROBTX Q X
PROBNARR(IFN) ; Returns Provider Narrative
 N X,Y S Y=$P($G(^AUPNPROB(+IFN,0)),U,5),X=$P($G(^AUTNPOV(+Y,0)),U)
 Q X
CS(X) ; Problem Codes
 N GMPLSAB,GMPLSO S GMPLSO="" S X=$G(X) Q:X'["(" ""
 F GMPLSAB="ICD-","CPT-","DSM-","HCPCS","NANDA","NIC","NOC","LOINC","SNOMED","OMAHA","SCT" S:$G(X)[("("_GMPLSAB) GMPLSO="("_GMPLSAB_$P(X,("("_GMPLSAB),2,299) Q:$L(GMPLSO)
 I $L(GMPLSO) S X=GMPLSO Q X
 F GMPLSAB="ACR","AI/RHEUM","CONGRESS","COSTAR","COSTART","CRISP","DODFAC" S:$G(X)[("("_GMPLSAB) GMPLSO="("_GMPLSAB_$P(X,("("_GMPLSAB),2,299) Q:$L(GMPLSO)
 I $L(GMPLSO) S X=GMPLSO Q X
 F GMPLSAB="DORLAND","DXPLAIN","HHCC","MCMASTER","META","MTF","MeSH","RVC","TITLE 38","UMDNS","UWA" S:$G(X)[("("_GMPLSAB) GMPLSO="("_GMPLSAB_$P(X,("("_GMPLSAB),2,299) Q:$L(GMPLSO)
 I $L(GMPLSO) S X=GMPLSO Q X
 Q ""
EP(X) ; Exposures
 N GMPLSC S X=+($G(X)) D SCS^GMPLX1(+X,.GMPLSC) S X=$G(GMPLSC(1)) Q X
PT(X,C) ; Problem Text (only)
 N GMPLTERM,GMPLSO S GMPLTERM=$G(X),GMPLSO=$G(C)
 S:$L(GMPLSO)&(GMPLTERM[GMPLSO) GMPLTERM=$P(GMPLTERM,GMPLSO,1) S GMPLTERM=$$TRIM(GMPLTERM)
 S:$L(GMPLTERM) X=GMPLTERM Q X
TRIM(X) ; Trim Spaces and "*"
 S X=$G(X) F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 F  Q:$E(X,$L(X))'="*"  S X=$E(X,1,($L(X)-1))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 Q X
WRAP(PROB,MAX,TEXT) ; Splits Text into TEXT array
 N I,J S J=0 K TEXT I $L(PROB)'>MAX S J=J+1,TEXT(J)=PROB G WRQ
WR0 ;   Loop for Remaining Text
 S I=$F(PROB," ") I ('I)!(I>(MAX+2)) S J=J+1,TEXT(J)=$E(PROB,1,MAX),PROB=$E(PROB,MAX+1,999)
 I $L(PROB)>MAX F I=(MAX+1):-1:1 I $E(PROB,I)=" " S J=J+1,TEXT(J)=$E(PROB,1,I-1),PROB=$E(PROB,I+1,999) Q
 G:$L(PROB)>MAX WR0
 S:$L(PROB) J=J+1,TEXT(J)=PROB
WRQ ;   Quit Wrap
 S TEXT=J
 Q
 ;
NOS(GMPLCSYS,GMPLDT) ; Return PTR^799.9 or PTR^R69 ICD code
 N CODE
 S:'$D(GMPLDT) GMPLDT=DT
 S:'$D(GMPLCSYS) GMPLCSYS=$S(GMPLDT<3151001:"ICD",1:"10D")
 S CODE=$S(GMPLCSYS="10D":"R69.",1:"799.9")
 Q +$$CODEN^ICDEX(CODE,80)_U_CODE
 ;
SEL(HELP) ; Select List of Problems
 N X,Y,DIR,MAX,DTOUT S MAX=+$G(^TMP("GMPL",$J,0)) I MAX'>0 Q "^"
 S DIR(0)="LAO^1:"_MAX,DIR("A")="Select Problem(s)"
 S:MAX>1 DIR("A")=DIR("A")_" (1-"_MAX_"): "
 S:MAX'>1 DIR("A")=DIR("A")_": ",DIR("B")=1
 S DIR("?")="Enter the problems you wish to "
 S DIR("?")=DIR("?")_$S($L(HELP):HELP,1:"act on")_", as a range or list of numbers"
 D ^DIR I $D(DTOUT)!(X="") S Y="^"
 Q Y
 ;
SEL1(HELP) ; Select 1 Problem
 N X,Y,DIR,MAX,DTOUT S MAX=+$G(^TMP("GMPL",$J,0)) I MAX'>0 Q "^"
 S DIR(0)="NAO^1:"_MAX_":0",DIR("A")="Select Problem"
 S:MAX>1 DIR("A")=DIR("A")_" (1-"_MAX_"): "
 S:MAX'>1 DIR("A")=DIR("A")_": ",DIR("B")=1
 S DIR("?")="Enter the number of the problem you wish to "
 S DIR("?")=DIR("?")_$S($L(HELP):HELP,1:"act on")
 D ^DIR I $D(DTOUT)!(X="") S Y="^"
 Q Y
 ;
DUPL(DFN,TERM,TEXT) ; Check for Duplicates
 I '$D(^AUPNPROB("AC",DFN)) Q 0
 N CODE,CMAPL,ECODE,IND,MATCHIEN,MCODE,PROBIEN,RESULT
 N SCTCODE,SECCODE,SECMATCH,SOURCE,TEMP
 ;The rules for determining if there is a match are:
 ;
 ;1. For SCT problems mapped to multiple ICD diagnoses: 
 ; If the SCT concept code, primary ICD diagnosis code, and secondary ICD
 ; diagnosis codes match that of a pre-existing problem, it's a
 ; duplicate.
 ;
 ;2. For SCT problems mapped to an unspecified ICD diagnosis (799.9 or
 ;R69) code:
 ; If the SCT concept code matches that of a pre-existing problem, it's
 ; a duplicate.
 ;
 ;3. For all other SCT problems, those mapped to a single primary ICD
 ;diagnosis:
 ; If the SCT concept code and primary ICD diagnosis code matches that
 ; of a pre-existing problem, it's a duplicate.
 ;
 S (MATCHIEN,PROBIEN)=0
 F  Q:MATCHIEN>0  S PROBIEN=+$O(^AUPNPROB("AC",DFN,PROBIEN)) Q:PROBIEN=0  D
 . S SCTCODE=$P($G(^AUPNPROB(PROBIEN,800)),U,1)
 . I SCTCODE="" Q
 .;Skip Hidden Problems
 .;If there is no SCT code it is a legacy problem.
 . I $P(^AUPNPROB(PROBIEN,1),U,2)="H" Q
 .;
 .;SCT-ICD entry
 . D EXP2CODE(TERM,.SOURCE,.ECODE)
 . I SOURCE'="SNOMED CT" Q
 . I ECODE'=SCTCODE Q
 . K CMAPL
 . S RESULT=$$GETASSN^LEXTRAN1(SCTCODE,"SCT210D",DT,"CMAPL")
 .;No mapped code, so the match is because ECODE=SCTCODE
 . I +RESULT=0 S MATCHIEN=PROBIEN Q
 .;The primary code must match.
 . S MCODE=$O(CMAPL(1,""))
 . I MCODE="R69." S MATCHIEN=PROBIEN Q
 . S TEMP=^AUPNPROB(PROBIEN,0)
 . S CODE=$$CODEC^ICDEX(80,$P(TEMP,U,1))
 . I CODE'=MCODE Q
 .;All secondary codes must match.
 . S SECMATCH=1
 . F IND=2:1:CMAPL D
 .. S SECCODE=$O(CMAPL(2,""))
 .. I '$D(^AUPNPROB(PROBIEN,803,"B",SECCODE)) S SECMATCH=0
 . I SECMATCH S MATCHIEN=PROBIEN
 Q MATCHIEN
 ;
DUPLOK(IFN) ; Ask if Dup OK
 N DIR,X,Y,GMPL0,GMPL1,DATE,PROV S DIR(0)="YA",GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1))
 S DIR("A")="Are you sure you want to continue? ",DIR("B")="NO"
 S DIR("?",1)="Enter YES if you want to duplicate this problem on this patient's list;",DIR("?")="press <return> to re-enter the problem name."
 W $C(7),!!,">>>  "_$$PROBTEXT(IFN),!?5,"is already an "
 W $S($P(GMPL0,U,12)="I":"IN",1:"")_"ACTIVE problem on this patient's list!",!
 S PROV=+$P(GMPL1,U,5) W:PROV !?5,"Provider: "_$P($G(^VA(200,PROV,0)),U)_" ("_$P($$SERVICE^GMPLX1(PROV),U,2)_")"
 I $P(GMPL0,U,12)="A" W !?8,"Onset: " S DATE=$P(GMPL0,U,13)
 I $P(GMPL0,U,12)="I" W !?5,"Resolved: " S DATE=$P(GMPL1,U,7)
 W $S(DATE>0:$$FMTE^XLFDT(DATE),1:"unspecified"),!
 D ^DIR W !
 Q +Y
 ;
LOCKED() ; Return Lock Msg
 Q "This problem is currently being edited by another user!"
 ;
SURE() ; Ask to Delete
 ;   Returns 1 if YES, else 0
 N DIR,X,Y S DIR(0)="YA",DIR("B")="NO"
 S DIR("?")="Enter YES to remove this value or NO to leave it unchanged."
 S DIR("A")="Are you sure you want to remove this value? " D ^DIR
 Q +Y
 ;
EXTDT(DATE) ; Format Date as MM/DD/YY
 N X,MM,DD,YY,YYY S X="",DATE=$P(DATE,".") Q:'DATE ""
 S MM=+$E(DATE,4,5),DD=+$E(DATE,6,7),YY=$E(DATE,2,3),YYY=$E(DATE,1,3)
 S:MM X=MM_"/" S:DD X=X_DD_"/" S X=$S($L(X):X_YY,1:1700+YYY)
 Q X
 ;
AUDIT(DATA,OLD) ; Make Entry in Audit File
 ; DATA = string for 0-node
 ; OLD  = string for 1-node
 ;      = 0-node from reform/react problem
 N DA,DD,DO,DIC,X,Y,DIK,DLAYGO
 S DIC="^GMPL(125.8,",DIC(0)="L",X=$P(DATA,U),DLAYGO=125.8
 D FILE^DICN Q:+Y'>0  S DA=+Y,DIK="^GMPL(125.8,"
 S ^GMPL(125.8,DA,0)=DATA D IX1^DIK
 S:$L(OLD) ^GMPL(125.8,DA,1)=OLD
 Q
 ;
DTMOD(DA) ; Update Date Modified
 N DIE,DR
 S DR=".03///TODAY",DIE="^AUPNPROB("
 D ^DIE
 ; broadcast problem change events
 N GMPIFN,DFN,X
 S GMPIFN=DA,DFN=+$P($G(^AUPNPROB(DA,0)),U,2)
 S X=+$O(^ORD(101,"B","GMPL EVENT",0))_";ORD(101," D:X EN1^XQOR
 Q
 ;
MSG() ; List Manager Msg Bar
 Q "+ Next Screen  - Prev Screen  ?? More actions"
 ;
KILL ; Clean-Up variables
 K X,Y,DIC,DIE,DR,DA,DUOUT,DTOUT,GMPQUIT,GMPRT,GMPSAVED,GMPIFN,GMPLNO,GMPLNUM,GMPLSEL,GMPREBLD,GMPI,GMPLSLST,GMPLJUMP
 Q
 ;
CODESTS(PROB,ADATE) ;check status of ICD
 ; Input:
 ;  PROB  = pointer to the PROBLEM (#9000011) file
 ;  ADATE = FM date on which to check the status (opt.)
 ;
 ; Output:
 ;  1 = ACTIVE on the date passed or current date
 ;  0 = INACTIVE on the date passed or current date
 ;
 I '$G(ADATE) S ADATE=DT
 I '$D(^AUPNPROB(PROB,0)) Q 0
 N GMPLCPTR,GMPLSTAT
 S GMPLCPTR=$P(^AUPNPROB(PROB,0),U,1)
 S GMPLSTAT=+$$SAI^ICDEX(80,GMPLCPTR,ADATE)
 Q GMPLSTAT
 ;
EXP2CODE(X,GMPSRC,GMPCODE) ; Resolve SOURCE,CODE and EXPRESSION
 ;from the Expressions file.
 N IND,GMI,LEX,SRCCODE
 S GMI=0,(GMPSRC,GMPCODE)=""
 D INFO^LEXA(X,DT)
 F  S GMI=$O(LEX("SEL","SRC",GMI)) Q:+GMI'>0  D  Q:($G(GMPSRC)]"")
 . S SRCCODE=$P($G(LEX("SEL","SRC",GMI)),U,1,2)
 . I $P(SRCCODE,U)["SNOMED CT"!($P(SRCCODE,U)["VHAT")!($P(SRCCODE,U)["ICD") S GMPSRC=$P(SRCCODE,U),GMPCODE=$P(SRCCODE,U,2)
 Q
 ;
GETDX(CODE,CODESYS,GMPDT) ; Get ICD associated with SCT or VHAT Code
 N LEX,GMPI,GMPY,GMPMPDEF,GMPIMPDT S GMPDT=$G(GMPDT,$$DT^XLFDT)
 S GMPY=0,GMPIMPDT=$$IMPDATE^LEXU("10D")
 S GMPMPDEF=$S(GMPDT<GMPIMPDT:"SCT2ICD",1:"SCT210D")
 I CODESYS["VHAT" S GMPY=$$GETASSN^LEXTRAN1(CODE,"VHAT2ICD",GMPDT) I 1
 E  S GMPY=$$GETASSN^LEXTRAN1(CODE,GMPMPDEF,GMPDT)
 I $S(+GMPY'>0:1,+$P(GMPY,U,2)'>0:1,+LEX'>0:1,1:0) S GMPY=$S(GMPDT<GMPIMPDT:"799.9",1:"R69.") G GETDXX
 S (GMPI,GMPY)=0
 F  S GMPI=$O(LEX(GMPI)) Q:+GMPI'>0  D
 .N ICD
 .S ICD=$O(LEX(GMPI,""))
 .I ICD]"" S GMPY=$S(GMPY'=0:GMPY_"/",1:"")_ICD
 I GMPY'["." S GMPY=GMPY_"."
GETDXX Q GMPY
 ;
PAD(GMPX,GMPL) ; Pads string to specified length
 N GMPY
 S GMPY="",$P(GMPY," ",(GMPL-$L(GMPX))+1)=""
 Q GMPY
 ;
GETEXIEN(GMPLSCTC,GMPLSCTD) ; Get Lexicon Expression IEN for SNOMED term
 N GMPLSYN,GMPLDT,GMPLRSLT,GMPLIEN,GMPLTYP,GMPLQT,GMPLNUM
 I '$D(GMPLSCTC)!('$D(GMPLSCTD)) S GMPLIEN="-1^Missing "_$S('$D(GMPLSCTC):"SNOMED CT Concept ID",1:"SNOMED CT Designation ID") G GETEXQT
 S GMPLDT=$$DT^XLFDT,(GMPLTYP,GMPLNUM,GMPLQT)=""
 S GMPLRSLT=$$GETSYN^LEXTRAN1("SCT",GMPLSCTC,GMPLDT,"GMPLSYN",1,1)
 I +GMPLRSLT<0 S GMPLIEN=GMPLRSLT G GETEXQT
 F  S GMPLTYP=$O(GMPLSYN(GMPLTYP)) Q:GMPLTYP=""!(GMPLQT)  D
 . I GMPLTYP="S" D
 . . F  S GMPLNUM=$O(GMPLSYN(GMPLTYP,GMPLNUM)) Q:GMPLNUM=""!(GMPLQT)  D
 . . . I $P(GMPLSYN(GMPLTYP,GMPLNUM),U,3)=GMPLSCTD S GMPLIEN=$P(GMPLSYN(GMPLTYP,GMPLNUM),U,2),GMPLQT=1 Q
 . . Q:GMPLQT
 . E  I $P(GMPLSYN(GMPLTYP),U,3)=GMPLSCTD S GMPLIEN=$P(GMPLSYN(GMPLTYP),U,2),GMPLQT=1 Q
 I GMPLQT="" S GMPLIEN="-1^Cannot find Expression IEN"
GETEXQT Q GMPLIEN
 ;
STRIPSPC(GMPLTXT) ; Strip string of spaces and convert to all uppercase for comparison
 N GMPLSTR,GMPLCHAR S GMPLCHAR=" "
 S GMPLSTR=$$UP^XLFSTR($$STRIP^XLFSTR(GMPLTXT,GMPLCHAR))
 Q GMPLSTR
 ;
MIXLOWCS(GMPLTXT) ; Check for mix/lower case
 N GMPLRSLT,GMPLPUNC S GMPLRSLT=0
 S GMPLPUNC=" ,!,"",#,$,%,&,',(,),*,+,-,,,_,.,/,\,:,;,<,=,>,?,@,[,],^,`,~,|,{,}"
 S GMPLTXT=$$STRIP^XLFSTR($TR(GMPLTXT,GMPLPUNC," ")," ")
 I GMPLTXT?.L1.(1.U1.L)!(GMPLTXT?1.L) S GMPLRSLT=1
 Q GMPLRSLT
 ;
PAUSE ; Pause for user to process info
 I $E(IOST,1,2)="C-" D
 . N DIR,DTOUT,DIRUT,DUOUT,X,Y
 . S DIR(0)="E" D ^DIR
 Q
 ;
