LEXA1 ;ISL/KER - Lexicon Look-up (Loud) ;12/19/2014
 ;;2.0;LEXICON UTILITY;**3,4,6,11,15,38,55,73,80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^DISV(              ICR    510
 ;    ^TMP("LEXFND"       SACC 2.3.2.5.1
 ;    ^TMP("LEXHIT"       SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH"       SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIR                ICR  10026
 ;    $$DT^XLFDT          ICR  10103
 ;               
 ; Local Variables NEWed or KILLed by calling application
 ; 
 ;     DIC,DTOUT,DUOUT,LEXCAT,LEXQUIET,LEXSRC
 ;     
EN ; Fileman Special Lookup
 ; 
 ; ^LEXA1 is the Lexicon's special lookup routine
 ; 
 ;   ^DD(757.01,0,"DIC")=LEXA1
 ; 
 ; Input    All input variables are optional
 ; 
 ;    X     User's input, if X does not exist the user
 ;          will be prompted
 ; 
 ;    Fileman Variables used:
 ; 
 ;          DIC       Global Root (default ^LEX(757.01,)
 ;          DIC(0)    DIC response string (default AEQM)
 ;          DIC("A")  Prompt (default "Enter Term/Concept:")
 ;          DIC("B")  Default lookup value
 ;          DIC("S")  Screen
 ;          DIC("W")  Output string
 ; 
 ;    Special Input Variables:
 ; 
 ;          LEXVDT    Versioning Date - This is a date in
 ;                    Fileman format.  If set it will force
 ;                    the lookup to be date sensitive, 
 ;                    inactive and pending codes and terms 
 ;                    will not display on the selection 
 ;                    list. 
 ; 
 ;     Developer Input Variables
 ; 
 ;          LEXIGN    Ignore - This flag, if set will ignore
 ;                    deactivation flags. 
 ; 
 ;          LEXDISP   Display - Force overwrite of display default
 ;                    parameter.
 ; 
 ; Output
 ; 
 ;    Fileman
 ; 
 ;       Y       2 piece string containing IEN and 
 ;               expression or -1 if not found
 ;               or selection not made
 ; 
 ;       Y(0)    If DIC(0) contains a Z this variable 
 ;               will be equal to the entire zero node
 ;               of the entry that was selected
 ; 
 ;       Y(0,0)  If DIC(0) contains a Z this variable 
 ;               will be equal to the external form of
 ;               the .01 field of the entry that was
 ;               selected
 ; 
 ;    Non-Fileman
 ; 
 ;       Y(1)    This is the external form of the ICD-9
 ;               diagnosis code when found
 ; 
 ;       Y(2)    This is the external form of the ICD-9
 ;               procedure code when found
 ; 
 ;       Y(30)   This is the external form of the ICD-10
 ;               diagnosis code when found
 ; 
 ;       Y(31)   This is the external form of the ICD-10
 ;               procedure code when found
 ; 
 ;       Y(81)   This is the external form of the CPT-4
 ;               or HCPCS code when found
 ; 
 I '$D(DIC(0))!($G(DIC(0))["A") K X
 ; Date Check
 N LEXTD,LEXQ,LEXXVDT,LEXASKC S LEXXVDT=$S($G(LEXVDT)?7N:1,1:0) S LEXQ=0 D VDT^LEXU
 ;
 ; LEXSUB  Specifies the vocabulary subset to use during the search.  
 ;         It is a three character mnemonic taken from file 757.2.
 ;         The default is "WRD"
 S:'$L($G(LEXSUB)) LEXSUB="WRD"
 ;
 ; LEXAP   Specifies the application using the Lexicon.  It is a pointer
 ;         to file 757.2.  The default is 1 (Lexicon)
 S:'$L($G(LEXAP))&($L($G(^TMP("LEXSCH",$J,"APP",0)))) LEXAP=^TMP("LEXSCH",$J,"APP",0)
 S:'$L($G(LEXAP)) LEXAP=1
 ;
 ; LEXLL   Specifies the displayable list length that the user selects
 ;         from. Default is 5.
 S:'$L($G(LEXLL)) LEXLL=5
 ;
 ; LEXSRC  Specifies the source of the vocabulary to use during the search.
 ;         It is a pointer to file #757.14.
 N LEXXSR S:$L($G(LEXSRC)) LEXXSR=$G(LEXSRC)
 ;         
 ; LEXCAT  Specifies the source category of the vocabulary to use during 
 ;         the search.  It is a pointer to file #757.13.
 N LEXXCT S:$L($G(LEXCAT)) LEXXCT=$G(LEXCAT)
 ;         
 ; Check the DIC variables new LEXUR "user response"
 N LEXDICA,LEXDICB,LEXO,XTLKGBL,XTLKHLP,XTLKKSCH,XTLKSAY  D CHK N LEXUR
 ;
 ; Save the value of X if "Ask" is not specified in DIC(0)
 I DIC(0)'["A",$L($G(X)) S LEXSAVE=X K X
 ;
 ; Save the prompt
 I $L($G(DIC("A"))) S LEXDICA=DIC("A")
 ;
 ; Continue to lookup until the dialog with the application 
 ; ends.  If there is nothing to lookup (X="") or an uparrow
 ; is detected, the Lexicon shuts down killing LEX.
 ;
 S LEXASKC=0 F  D LK Q:'$D(LEX)!($D(LEX("SEL")))
 G EXIT
LK ; Start Look-up
 ; X not provided
 K DTOUT,DUOUT S LEXASKC=+($G(LEXASKC))+1 W:+($G(LEXASKC))>1 !
 D:'$D(LEXSAVE) ASK I $D(DTOUT)!($D(DUOUT)) K LEX Q
 ; X provided
 S:$D(LEXSAVE) X=LEXSAVE K LEXSAVE
 ; X was null with a default provided
 S:$D(DIC("B"))&($G(X)="") X=DIC("B")
 ; Lookup X - LOOK(LEXX,LEXAP,LEXLL,LEXSUB,LEXVDT,LEXXSR,LEXXCT)
 I '$L($G(X)) K LEX Q
 D LOOK^LEXA(X,$G(LEXAP),$G(LEXLL),,$G(LEXVDT),$G(LEXXSR),$G(LEXXCT))
 K DIC("B")
 ;
NOTFND ; If X was not found
 ;
 ;    Write "??"
 ;
 ;    Calling application uses Unresolved Narratives
 ;      Prompt to "accept or reject" the narrative
 ;      
 ;    Calling application does not use Unresolved Narratives
 ;      Display help, Re-prompt and Continue search
 ;
 I '$D(LEX("LIST")),+($G(LEX))=0,$L(X),X'["^",$E(X,1)'=" " D  K LEX S LEX=0 Q
 . K DIC("B"),LEX("SEL")
 . I +($G(^TMP("LEXSCH",$J,"UNR",0)))=0 I +($G(X))'=757.01 W "  ??" D:$D(LEX("HLP")) DH^LEXA3 W ! Q
 . I +($G(^TMP("LEXSCH",$J,"UNR",0)))=1 W "  ??" D EN^LEXA4 W !
FOUND ; If X was found
 ;
 ;    Begin user selection.  Continue to display the list
 ;    until the dialog with the user is terminated.  The
 ;    dialog is considered to be terminated if:
 ;
 ;      The selection list does not exist  '$D(LEX("LIST"))
 ;      The user has made a selection       $D(LEX("SEL")
 ; 
 I $D(LEX("LIST")) F  Q:+($G(LEX))=0  D SELECT^LEXA2
 Q:$D(LEX("SEL"))
 I '$L($G(LEX)) K LEX Q
 I $L($G(LEX)),'$D(LEX("SEL")),$D(^TMP("LEXSCH",$J)) D
 . D EN^LEXA4 S:'$D(LEX("SEL")) LEX=0
 Q
EXIT ; Set/Kill variables Y, Y(0,0)
 S:$L($G(LEX("NAR"))) X=$G(LEX("NAR"))
 S:$L($G(LEXDICA)) DIC("A")=LEXDICA S:$L($G(LEXDICB)) DIC("B")=LEXDICB K Y K:+($G(LEXXVDT))'>0 LEXVDT
 I '$D(LEX("SEL","EXP",1)) K Y S Y=-1 D CL Q
 I $D(LEX("SEL","EXP",1)) S Y=LEX("SEL","EXP",1) D
 . D Y1,SSBR I DIC(0)["Z" D
 . . S Y(0)=^LEX(757.01,+(LEX("SEL","EXP",1)),0)
 . . S Y(0,0)=$P(^LEX(757.01,+(LEX("SEL","EXP",1)),0),"^",1)
 D CL
 Q
CL ; Clear Variables
 K LEX,LEXSUB,LEXAP,LEXLL D CLR
 Q
CLR ; Clear ^TMP Global
 K ^TMP("LEXSCH",$J),^TMP("LEXHIT",$J),^TMP("LEXFND",$J)
 Q
Y1 ; ICD-9 DX in Y(1), ICD-10 DX in Y(30)
 N LEXCT,LEXLC,LEXLDR,LEXSY,LEXB,LEXN S LEXB=$G(IOINHI),LEXN=$G(IOINORM)
 S LEXLC=0,LEXLDR=" >>>  " I '$D(LEXQUIET) F LEXSY=1,2,30,31 D
 . N LEXI S (LEXCT,LEXI)=0 F  S LEXI=$O(LEX("SEL","VAS","I",LEXSY,LEXI)) Q:+LEXI'>0  D
 . . N LEXD,LEXC,LEXS,LEXT S LEXD=$G(LEX("SEL","VAS",LEXI)),LEXC=$P(LEXD,"^",3),LEXS=$P(LEXD,"^",6)
 . . Q:'$L(LEXD)  Q:'$L(LEXS)  S LEXT=LEXLDR_LEXS_" Code:"
 . . S LEXT=LEXT_$J(" ",(23-$L(LEXT)))_$G(LEXB)_LEXC_$G(LEXN)
 . . S LEXCT=LEXCT+1,LEXLC=LEXLC+1 S:LEXLC>1 LEXLDR="      "
 . . Q:LEXCT>1  W:LEXCT=1 ! W !,LEXT
 . . S:'$L($G(Y(+LEXSY))) Y(+LEXSY)=LEXC
 N IOINHI,IOINORM
 Q
ASK ; Get user input
 N DIR,DIRUT,DIROUT S:$L($G(LEXDICA)) DIC("A")=LEXDICA
 S DIR("A")=DIC("A") W:'$L($G(X))&('$L($G(LEXDICB))) !
 I '$L($G(X)),$L($G(LEXDICB)) S DIR("B")=LEXDICB
 S DIR("?")="      "_$$SQ^LEXHLP
 S DIR("??")="^D INPHLP^LEXA1",DIR("?")=$G(DIR("??"))
 N Y S DIR(0)="FAO^0:245" K X
 D ^DIR
 K DIC("B") D:$E(X,1)=" " RSBR
 W:$E(X,1)'=" " !
 F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 W:$D(DTOUT) !,"Try later.",!
 I $D(DTOUT)!(X="^") S X=""
 S:X[U DUOUT=1 K DIRUT,DIROUT Q
INPHLP ; Look-up help
 N IMP,CUR,CUT,FLG,LEXD,LEXCAT,LEXQUIET,LEXSRC S IMP=$$IMPDATE^LEXU(30)
 S CUR=$G(LEXVDT) S:CUR'?7N CUR=$$DT^XLFDT S FLG=$S(CUR<IMP:0,1:1)
 S LEXD=$G(^TMP("LEXSCH",$J,"FIL",0))
 I $G(X)["??",$L(LEXD),LEXD["LEXU(Y,""DS4""," K LEX("HLP") D  Q
 . D QMH^LEXAR3(X) N LEXI S LEXI=0
 . F  S LEXI=$O(LEX("HLP",LEXI)) Q:+LEXI'>0  W !,$G(LEX("HLP",LEXI))
 . K LEX("HLP")
 W !,"      Enter a ""free text"" term.  Best results occur using one to "
 W !,"      three full or partial words without a suffix"
 W:$G(X)'["??" "."
 W:$G(X)["??" " (i.e., ""DIABETES"","
 W:$G(X)["??" !,"      ""DIAB MELL"",""DIAB MELL "_$S(FLG:"NEO",1:"INSUL")_")"
 W !,"  or  "
 W !,"      Enter a classification code (ICD/DSM/CPT etc) to find the single "
 W !,"      term associated with the code."
 W:$G(X)["??" "  Example, a lookup of code "_$S(FLG:"P70.2",1:"239.0")_" "
 W:$G(X)["??" !,"      returns one and only one term, that is the preferred term for"
 W:$G(X)["??" !,"      the code "_$S(FLG:"P70.2",1:"239.0")_", "
 W:$G(X)["??"&(FLG) """Neonatal Diabetes Mellitus"""
 W:$G(X)["??"&('FLG) """Neoplasm of unspecified nature",!,"      of digestive system"""
 Q:FLG
 W !,"  or  "
 W !,"      Enter a classification code (ICD/DSM/CPT etc) followed by a plus"
 W !,"      sign (+) to retrieve all terms associated with the code."
 W:$G(X)["??" "  Example,"
 W:$G(X)["??" !,"      a lookup of 239.0+ returns all terms that are linked to the "
 W:$G(X)["??" !,"      code 239.0."
 Q
CHK ; Check Fileman look-up variables
 K DIC("DR"),DIC("P"),DIC("V"),DLAYGO,DINUM
 S:$L($G(X)) LEXSAVE=X S:$L($G(DIC("B"))) LEXDICB=DIC("B") K DIC("B")
 I $L($G(DIC(0))) D
 . F  Q:DIC(0)'["L"  S DIC(0)=$P(DIC(0),"L",1)_$P(DIC(0),"L",2)
 . F  Q:DIC(0)'["I"  S DIC(0)=$P(DIC(0),"I",1)_$P(DIC(0),"I",2)
 S:'$L($G(DIC(0))) DIC(0)="QEAMF" S:'$L($G(DIC)) DIC="^LEX(757.01,"
 S:DIC(0)'["F" DIC(0)=DIC(0)_"F" S:'$L($G(DIC("A"))) DIC("A")="Enter Term/Concept:  "
 S LEXDICA=DIC("A")
 Q
SSBR ; Store data for Space Bar Return
 Q:'$L($G(DUZ))  Q:+($G(DUZ))=0  Q:'$L($G(DIC))  Q:$G(DIC)'["757.01,"
 Q:$G(DIC(0))'["F"  Q:+($G(Y))'>2  Q:$E($G(X),1)=" "  S ^DISV(DUZ,DIC)=+($G(Y))
 Q
RSBR ; Retrieve onSpace Bar Return
 Q:'$L($G(DUZ))  Q:$G(DIC)'="^LEX(757.01,"  Q:$G(DIC(0))'["F"
 Q:$E($G(X),1)'=" "  S:+($G(^DISV(DUZ,DIC)))>2 X=@(DIC_+($G(^DISV(DUZ,DIC)))_",0)")
 Q
