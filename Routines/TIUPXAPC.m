TIUPXAPC ; SLC/JER - Get CPT stuff ;5/8/03@10:27
 ;;1.0;TEXT INTEGRATION UTILITIES;**15,24,62,82,161**;Jun 20, 1997
TEST ; Check it out
 N TIULOC,CPTARR,CPT,TIUI
 S TIULOC=+$$SELLOC^TIUVSIT,TIUI=0
 D GETCPT(TIULOC,.CPTARR)
 D CPT(.CPT,.CPTARR)
 W ! F  S TIUI=$O(CPT(TIUI)) Q:+TIUI'>0  D
 . W !,"CPT(",TIUI,")=",CPT(TIUI),!,"CPT(",TIUI,",""QTY"")="
 . W CPT(TIUI,"QTY")
 Q
 ; Pass encounter date from TIUPXAPI to IBDF18A **161**
GETCPT(TIULOC,CPTARR,TIUVDT) ; Get CPT codes for clinic
 N TIUI,TIUROW,TIUCOL,ARRY2,TIUITM,TIUPAGE,EMARRY,TIUCAT S TIUCAT=""
 ; Pass encounter date as 5th parameter to IBDF18A **161**
 D GETLST^IBDF18A(+TIULOC,"DG SELECT VISIT TYPE CPT PROCEDURES","EMARRY",,,1,TIUVDT)
 D GETLST^IBDF18A(+TIULOC,"DG SELECT CPT PROCEDURE CODES","ARRY2",,,1,TIUVDT)
 I $D(EMARRY)>9 D CMBLST^TIUPXAP2(.EMARRY,.ARRY2) K EMARRY
 S (TIUI,TIUROW,TIUITM)=0,(TIUCOL,TIUPAGE)=1
 F  S TIUI=$O(ARRY2(TIUI)) Q:+TIUI'>0  D
 . I $P(ARRY2(TIUI),U)]"" D  I 1
 . . S TIUROW=+$G(TIUROW)+1,TIUITM=+$G(TIUITM)+1
 . . ;Set CPT Display Array: Item #^CPT Code^Description^Group
 . . S CPTARR(TIUROW,TIUCOL)=TIUITM_U_$P($G(ARRY2(TIUI)),U,1,2)_U_TIUCAT
 . . S CPTARR("INDEX",TIUITM)=$P($G(ARRY2(TIUI)),U,1,2)_U_TIUCAT
 . . ;If pre-selected CPT Modifiers are defined, add them to CPT Display Array
 . . ;Pass encounter date to ADDMOD call to pass to ICPTMOD for CSV *161
 . . I +$G(ARRY2(TIUI,"MODIFIER",0))>0 D ADDMOD(TIUITM,TIUI,.CPTARR,.ARRY2,.TIUROW,.TIUCOL,.TIUPAGE,TIUVDT)
 . . K ARRY2(TIUI)
 . E  D
 . . S TIUROW=+$G(TIUROW)+1
 . . S TIUCAT=$$UP^XLFSTR($P($G(ARRY2(TIUI)),U,2))
 . . S CPTARR(TIUROW,TIUCOL)=U_U_TIUCAT
 . . K ARRY2(TIUI)
 . ;Update counters for CPT Display Array
 . D UPDCNT(.TIUROW,.TIUCOL,.TIUPAGE)
 I +$G(ARRY2(0))>0 D
 . S TIUROW=+$G(TIUROW)+1,TIUITM=TIUITM+1
 . S CPTARR(TIUROW,TIUCOL)=TIUITM_"^OTHER CPT^OTHER Procedure"
 . S CPTARR("INDEX",TIUITM)="OTHER CPT^OTHER Procedure"
 . S CPTARR(0)=+$G(ARRY2(0))_U_+$G(TIUROW)_U_+$G(TIUPAGE)
 . ;Update counters for CPT Display Array
 . D UPDCNT(.TIUROW,.TIUCOL,.TIUPAGE)
 Q
 ;
UPDCNT(TIUROW,TIUCOL,TIUPAGE) ;Update Counters for CPT Display Array
 ; Input  -- TIUROW   Row Counter
 ;           TIUCOL   Column Counter
 ;           TIUPAGE  Page Counter
 ; Output -- Counters:
 ;           TIUROW   Row Counter
 ;           TIUCOL   Column Counter
 ;           TIUPAGE  Page Counter
 I TIUROW#20'>0 D
 . S:TIUCOL=3 TIUPAGE=TIUPAGE+1
 . S TIUCOL=$S(TIUCOL=3:1,1:TIUCOL+1)
 . S TIUROW=20*(TIUPAGE-1)
 Q
 ;
 ;Pass in encounter date to pass to ICPTMOD,TIUPXAPM for CSV **161**
ADDMOD(TIUITM,TIUI,CPTARR,ARRY2,TIUROW,TIUCOL,TIUPAGE,TIUVDT) ;Add Pre-selected CPT Modifiers from AICS to CPT Display Array
 ; Input  -- TIUITM   Item Number in CPT Display Array
 ;           TIUI     Item Number in Combined AICS Selection List Array
 ;           CPTARR   CPT Display Array
 ;           ARRY2    Combined AICS Selection List Array
 ;           TIUROW   Row Counter
 ;           TIUCOL   Column Counter
 ;           TIUPAGE  Page Counter
 ; Output -- CPTARR   CPT Display Array
 ;                 (TIUROW,TIUCOL)=
 ;                    ^^^^CPT Modifier^CPT Modifier Name
 ;                 ("INDEX",TIUITM,"MODIFIER",MODCNT)=
 ;                    CPT Modifier IEN^CPT Modifier^CPT Modifier Name
 ;           TIUROW   Row Counter
 ;           TIUCOL   Column Counter
 ;           TIUPAGE  Page Counter
 ;    TIUVDT   Encounter Date
 N MODCNT,MODIFIER,MODINFO
 ;
 ;Loop through pre-selected CPT Modifiers
 S MODCNT=0
 F  S MODCNT=$O(ARRY2(TIUI,"MODIFIER",MODCNT)) Q:'MODCNT  D
 . S MODIFIER=$P(ARRY2(TIUI,"MODIFIER",MODCNT),U) Q:MODIFIER=""
 . ;Invoke API to get CPT Modifier information
 . ;Pass encounter date to ICPTMOD for CSV **161**
 . S MODINFO=$$MOD^ICPTMOD(MODIFIER,,TIUVDT)
 . I +MODINFO>0 D
 . . S TIUROW=TIUROW+1
 . . ;Set CPT Modifier and CPT Modifier Name into CPT Display Array
 . . S CPTARR(TIUROW,TIUCOL)=U_U_U_U_$P(MODINFO,U,2,3)
 . . ;Set CPT Modifier IEN, CPT Modifier and CPT Modifier Name into Index for CPT Display Array
 . . S CPTARR("INDEX",TIUITM,"MODIFIER",MODCNT)=$P(MODINFO,U,1,3)
 Q
 ;
 ;Pass encounter date to CPT to pass to ICPTCOD
CPT(CPT,CPTARR,TIUVDT) ; Select Procedures
 N I,J,L,Y,TIUCPT,TIUICNT,TIUPGS,TIUPG,TIUITM,TIULITM,TIUPNM
 S TIUPNM=$S($L($G(TIU("PNM"))):$G(TIU("PNM")),+$G(DFN):$$PTNAME^TIULC1(DFN),1:"the Patient")
 W !!,"Please Indicate the Procedure(s) Performed on "_TIUPNM_":"
 W:+$O(CPTARR(0)) !
 S TIUICNT=+$G(CPTARR(0)),TIUPGS=$P($G(CPTARR(0)),U,3)
 S (I,J,L,Y)=0 I +TIUICNT S TIUPG=1
 F  S I=$O(CPTARR(I)) Q:+I'>0  D
 . S J=0 W ! F  S J=$O(CPTARR(I,J)) Q:+J'>0  D
 . . W ?((J-1)*25) W:+$P(CPTARR(I,J),U) $J($P(CPTARR(I,J),U),2)_" " W $E($P(CPTARR(I,J),U,3),1,20)
 . . ;Display pre-selected CPT Modifier
 . . W:$P(CPTARR(I,J),U,5)'="" " -"_$P(CPTARR(I,J),U,5)_" "_$E($P(CPTARR(I,J),U,6),1,14)
 . . S TIUITM=$S(+$G(CPTARR(I,J)):+$G(CPTARR(I,J)),1:$G(TIUITM))
 . . S:TIUITM>+$G(TIULITM) TIULITM=TIUITM
 . I I#20=0 S Y=$S(+Y:Y,1:"")_$P($$PICK^TIUPXAP2(1,+$G(TIULITM),"Select Procedures"_$S(+$G(TIUPG)<TIUPGS:" (<RETURN> to see next page of choices)",1:"")),U),TIUPG=+$G(TIUPG)+1 W !
 . S L=I S:TIUITM>+$G(TIULITM) TIULITM=TIUITM
 I L#20 S Y=$S(+Y:Y,1:"")_$P($$PICK^TIUPXAP2(1,TIULITM,"Select Procedures"),U)
 I +Y,$P(CPTARR("INDEX",+Y),U)'="OTHER CPT" D  I 1
 . N I,ITEM F I=1:1:($L(Y,",")-1) D
 . . S ITEM=$P(Y,",",I)
 . . I $P(CPTARR("INDEX",+ITEM),U)'="OTHER CPT" D  I 1
 . . . S CPT(I)=$G(CPTARR("INDEX",+ITEM))
 . . . S $P(CPT(I),U,4)=$P(CPT(I),U)
 . . . ;Pass encounter date to CPT to pass to ICDTCOD for CSV **161**
 . . . S $P(CPT(I),U)=+$$CPT^ICPTCOD($P(CPT(I),U),TIUVDT)
 . . . I +CPT(I)'>0 D
 . . . . K CPT(I)
 . . . ELSE  D
 . . . . ;Merge pre-selected CPT Modifiers from CPT Display Array into CPT Selection Array
 . . . . M CPT(I,"MOD")=CPTARR("INDEX",ITEM,"MODIFIER")
 . . ;Pass encounter date to CPTOUT for CSV **161**
 . . E  D CPTOUT(.CPT,.I,TIUVDT)
 E  D CPTOUT(.CPT,,TIUVDT)
 I +$O(CPT(1)) D  I 1
 . N TIUI S TIUI=0
 . F  S TIUI=$O(CPT(TIUI)) Q:+TIUI'>0  D
 . . S CPT(TIUI,"QTY")=+$$QTY(.CPT,TIUI)
 . . K:CPT(TIUI,"QTY")'>0 CPT(TIUI)
 . . ;Select CPT Modifiers
 . . ;Pass encounter date to TIUPXAPM to pass to ICPTCOD for CVS **161**
 . . I $D(CPT(TIUI)) D MOD^TIUPXAPM(.CPT,TIUI,TIUVDT)
 E  I $D(CPT(1)) D
 . S CPT(1,"QTY")=+$$QTY(.CPT,1)
 . K:CPT(1,"QTY")'>0 CPT(1)
 . ;Select CPT Modifiers
 . ;Pass encounter date to TIUPXAPM to pass to ICPTCOD for CSV **161**
 . I $D(CPT(1)) D MOD^TIUPXAPM(.CPT,1,TIUVDT)
 Q
QTY(CPT,TIUI) ; How many times was the procedure performed?
 N PROMPT,HELP
 S PROMPT="How many times was the procedure performed? "
 S HELP="^D QTYHLP^TIUPXAPC"
 W !!!,$$UP^XLFSTR($P(CPT(TIUI),U,2)),":",!
 Q +$$READ^TIUU("NA^1:99",PROMPT,1,HELP)
QTYHLP ; Help for QTY read
 W !,"Please specify the number of repetitions for this procedure"
 W !,"performed during this visit with the patient (1-99)."
 Q
 ; Pass in encounter date to pass to LEXSET for CSV **161**
CPTOUT(CPT,TIUI,TIUVDT) ; Go off-list for Procedure(s)
 N DIC,X,Y,TIUOUT
 F  D  Q:+$G(TIUOUT)
 . I $L($T(CONFIG^LEXSET)) D  I 1
 . .; Pass encounter date to LEXSET for CSV **161**
 . . D CONFIG^LEXSET("CHP","CHP",TIUVDT)  ; PCH 24
 . E  S DIC="^ICPT("
 . S DIC(0)="AEMQ"
 . S DIC("A")="Select "_$S(+$G(CPTARR(0))'>0:"Procedure: ",1:"Another Procedure"_$S($D(CPTARR):" (NOT from Above List)",1:"")_": ")
 . N X
 . D ^DIC
 . I +$D(DTOUT)!+$D(DUOUT)!(X="") S TIUOUT=1 Q
 . I +Y>0 D  Q
 . . ; Pass encounter date to LEXC to LEXSET for CSV **161**
 . . I DIC="^LEX(757.01," S Y=$$LEXC(Y,TIUVDT)  ; PCH 24
 . . S:$S(+$G(TIUI)'>0:1,$D(CPT(+$G(TIUI))):1,1:0) TIUI=$G(TIUI)+1
 . . S CPT(TIUI)=Y
 . W $C(7),!!,"Nothing found for ",X,"..."
 . F  D  Q:(+Y>0)!+$G(TIUOUT)
 . . N X
 . . I $L($T(CONFIG^LEXSET)) D  I 1
 . . .; Pass encounter date for CSV **161**
 . . . D CONFIG^LEXSET("CHP","CHP",TIUVDT)  ; PCH 24
 . . E  S DIC="^ICPT("
 . . S DIC("A")="Please try another expression, or RETURN to continue: "
 . . D ^DIC
 . . I +$D(DTOUT)!+$D(DUOUT)!(X="") S TIUOUT=1 Q
 . . I +Y>0 D  Q
 . . . ; Pass encounter date to LEXC for CSV **161**
 . . . I DIC="^LEX(757.01," S Y=$$LEXC(Y,TIUVDT)  ; PCH 24
 . . . S:$S(+$G(TIUI)'>0:1,$D(CPT(+$G(TIUI))):1,1:0) TIUI=$G(TIUI)+1
 . . . S CPT(TIUI)=Y
 . . W $C(7),!!,"Nothing found for ",X,"..."
 Q
 ; Pass in encounter date for CSV **161**
LEXC(Y,TIUVDT) ; Get CPT IEN from Lexicon returned code PCH 24
 N TIUC,TIUCODE S Y=$G(Y)
 ; Pass encounter date for CSV **161**
 S TIUC=$$CPTONE^LEXU(+Y,TIUVDT) S:'$L(TIUC) TIUC=$$CPCONE^LEXU(+Y,TIUVDT)
 I '$L(TIUC) S Y="-1"_U_$P(Y,U,2) Q Y
 S TIUCODE=TIUC
 ; Pass encounter date instead of current date to ICPTCOD for CSV **161**
 S TIUC=+$$CPT^ICPTCOD(TIUCODE,TIUVDT) S Y=TIUC_U_$P(Y,U,2)
 S Y=Y_"^^"_TIUCODE
 Q Y
