LEXALK ;ISL/KER - Look-up by Words ;04/21/2014
 ;;2.0;LEXICON UTILITY;**2,3,6,25,51,80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(               N/A
 ;    ^TMP("LEXFND")      SACC 2.3.2.5.1
 ;    ^TMP("LEXHIT")      SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    ^LEX(               ICR   1571
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXFIL      NEWed in LEXA
 ;    LEXFILR     NEWed in LEXA
 ;    LEXTKN      KILLed in LEXA
 ;    LEXTKNS     KILLed in LEXA
 ;    LEXVDT      NEWed in LEXA
 ;               
 ; Special Lookup variables
 ;                    
 ;    LEXSUB      Vocabulary
 ;    LEXSHCT     Shortcuts
 ;    LEXDICS     Screen - DIC("S") Format
 ;    LEXSHOW     Displayable codes
 ;    LEXLKFL     File Number
 ;    LEXLKGL     Global Root
 ;    LEXLKMD     Use Modifiers
 ;    LEXLKIX     Index to use during lookup
 ;    LEXLKSH     User Input (Search String)
 ;    LEXTKN(     Tokens in order of frequency of use
 ;    LEXTKNS(    Tokens in order of entry
 ;                    
EN ; Look-up user input
 N LEXSUB,LEXSHCT,LEXDICS,LEXSHOW,LEXLKFL,LEXLKGL,LEXLKMD,LEXLKIX,LEXLKSH
 D VDT^LEXU S LEXLKSH=$G(^TMP("LEXSCH",$J,"SCH",0)) I $L(LEXLKSH)<2 D  Q
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1,LEX("ERR",LEX("ERR",0))="User input missing or invalid"
 S LEXSUB=$G(^TMP("LEXSCH",$J,"VOC",0)) S:LEXSUB="" LEXSUB="WRD"
 S LEXLKMD=+($G(^TMP("LEXSCH",$J,"MOD",0)))
 S LEXLKIX=$G(^TMP("LEXSCH",$J,"IDX",0)) S:LEXLKIX="" LEXLKIX="AWRD"
 S LEXLKFL=$G(^TMP("LEXSCH",$J,"FLN",0)) I LEXLKFL'["757." D  Q
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1,LEX("ERR",LEX("ERR",0))="File number missing or invalid"
 S LEXLKGL=$G(^TMP("LEXSCH",$J,"GBL",0)) I LEXLKGL'["LEX(757." D  Q
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1,LEX("ERR",LEX("ERR",0))="Global location missing or invalid"
 S LEXSHOW=$G(^TMP("LEXSCH",$J,"DIS",0))
 D TOKEN^LEXAM(LEXLKSH)
 N LEXOK,LEXDES,LEXDSP,LEXT,LEXO,LEXI,LEXE,LEXM,LEXME
 N LEXSS Q:$G(LEXLKFL)'["757."
 S LEXSS="" I $D(LEXTKNS(0)) D
 . N LEXI F LEXI=1:1:LEXTKNS(0) S LEXSS=LEXSS_" "_LEXTKNS(LEXI)
 . S LEXSS=$E(LEXSS,2,$L(LEXSS))
 S ^TMP("LEXSCH",$J,"SCH",0)=$G(LEXSS)
 S LEXT=$G(LEXTKN(1)),LEXO=$$SCH(LEXT)
 I $G(LEXSHCT)="",$G(LEXTKN(0))=1,$D(^LEX(LEXLKFL,LEXLKIX,LEXT)) D EXACT
 I $G(LEXSHCT)="",$G(LEXTKN(0))=1,$D(^LEX(LEXLKFL,LEXLKIX,LEXT)) D  G END
 . D EXACT
 . I +($O(^LEX(757.01,"ASL",LEXT,0)))>6000 Q
 . D TOKEN
 D TOKEN
END ; End look-up by word
 I $D(^TMP("LEXFND",$J)) D BEG^LEXAL
 I '$D(^TMP("LEXFND",$J)) D
 . K LEX,^TMP("LEXFND",$J),^TMP("LEXHIT",$J) S LEX=0
 S:+($G(^TMP("LEXSCH",$J,"UNR",0)))>0&($L($G(^TMP("LEXSCH",$J,"NAR",0)))) LEX("NAR")=$G(^TMP("LEXSCH",$J,"NAR",0))
 Q
EXACT ; Main loop throuth TOKENS that equal LEXT
 S LEXO=$$SCH(LEXT) F  S LEXO=$O(^LEX(LEXLKFL,LEXLKIX,LEXO)) Q:LEXO'=LEXT  D IEN
 Q
TOKEN ; Main loop though TOKENS containing LEXT
 S LEXO=$$SCH(LEXT) F  S LEXO=$O(^LEX(LEXLKFL,LEXLKIX,LEXO)) Q:LEXO'[LEXT!(LEXO="")  D IEN
 Q
IEN ; Loop throuth Internal Entry Numbers
 S LEXI=0 F  S LEXI=$O(^LEX(LEXLKFL,LEXLKIX,LEXO,LEXI)) Q:+LEXI=0  D
 . I +($G(LEXNOKEY))>0 N LEXK S LEXK=$$KWO($G(LEXO),$G(LEXI)) Q:LEXK>0
 . D CHK
 Q
CHK ; Check each token
 N LEXOK,LEXO,LEXLKT S LEXLKT="ALK",LEXE=LEXI,LEXOK=1
 S:LEXLKGL'["757.01" LEXE=+$G(^LEX(LEXLKFL,LEXI,0)) Q:LEXE=0
 ; Filter
 S LEXFILR=$$EN^LEXAFIL($G(LEXFIL),LEXE) Q:LEXFILR=0
 ; Deactivated
 Q:'$D(LEXIGN)&(+($P($G(^LEX(757.01,LEXE,1)),"^",5))=1)
 ; Expression has Modifiers
 N LEXEMOD S LEXEMOD=+($P($G(^LEX(757.01,LEXE,1)),"^",6))
 S LEXM=+($G(^LEX(757.01,LEXE,1)))
 S LEXME=+($G(^LEX(757,LEXM,0)))
 ; Check not exact match
 I $L($G(^TMP("LEXSCH",$J,"EXM",0))),+(^TMP("LEXSCH",$J,"EXM",0))=LEXE Q
 I $L($G(^TMP("LEXSCH",$J,"EXC",0))),+(^TMP("LEXSCH",$J,"EXC",0))=LEXE Q
 ; Check tokens
 S LEXOK=1 D CHKTKNS(LEXE)
 ; If the expression failed the search, and the expression has 
 ; modifiers then check the modifiers
 D:+LEXOK=0&(+($G(LEXEMOD))>0)&(+($G(LEXTKN(0)))>1) CHKMOD^LEXAMD2
 Q:'LEXOK
 ; Description (*)
 S LEXDES=$$DES^LEXASC(LEXE)
 ; Display of codes
 S LEXDSP=$$SO^LEXASO(LEXE,$G(LEXSHOW),1,$G(LEXVDT))
 D ADDL^LEXAL(LEXE,LEXDES,LEXDSP)
 Q
CHKTKNS(LEXE) ; Check tokens
 N LEXM,LEXNOKEY S LEXM=+($G(^LEX(757.01,LEXE,1))) Q:LEXM=0
 N LEXI,LEXOE,LEXC S LEXOE=LEXE,LEXI=1
 F  S LEXI=$O(LEXTKN(LEXI)) Q:+LEXI=0!('LEXOK)  D  Q:'LEXOK
 . N LEXT,LEXE,LEXORD S LEXT=LEXTKN(LEXI),LEXE=0,LEXOK=0
 . S LEXC=$$UP(^LEX(757.01,LEXOE,0))
 . I LEXC[(" "_LEXT) S LEXOK=1 Q
 . I LEXC[("-"_LEXT) S LEXOK=1 Q
 . I LEXC[("("_LEXT) S LEXOK=1 Q
 . I LEXC[("/"_LEXT) S LEXOK=1 Q
 . I $E(LEXC,1,$L(LEXT))=LEXT S LEXOK=1 Q
 . S LEXORD=$$SCH(LEXT)
 . I $L(LEXT),$D(^LEX(757.01,LEXOE,5,"B",LEXT)) S LEXOK=1 Q
 . I $L(LEXT),$E($O(^LEX(757.01,LEXOE,5,"B",($E(LEXT,1,($L(LEXT)-1))_$C($A($E(LEXT,$L(LEXT)))-1)_"~"))),1,$L(LEXT))=LEXT S LEXOK=1 Q
 . I $L(LEXT),$L(LEXORD) D  I $E(LEXORD,1,$L(LEXT))=LEXT S LEXOK=1 Q
 . . S LEXORD=$O(^LEX(757.01,LEXOE,5,"B",LEXORD))
 . F  S LEXE=$O(^LEX(757.01,"AMC",LEXM,LEXE)) Q:+LEXE=0!(LEXOK)  D  Q:LEXOK
 . . Q:+($P($G(^LEX(757.01,LEXE,1)),"^",2))>3
 . . S LEXC=$$UP(^LEX(757.01,LEXE,0))
 . . I LEXC[(" "_LEXT) S LEXOK=1 Q
 . . I LEXC[("-"_LEXT) S LEXOK=1 Q
 . . I LEXC[("("_LEXT) S LEXOK=1 Q
 . . I LEXC[("/"_LEXT) S LEXOK=1 Q
 . . I $E(LEXC,1,$L(LEXT))=LEXT S LEXOK=1 Q
 Q
DES(LEXX) ; Get description flag
 N LEXDES,LEXE,LEXM S LEXDES="",LEXE=+LEXX
 S LEXM=$P($G(^LEX(757.01,+($G(LEXX)),1)),"^",1)
 S LEXM=+($G(^LEX(757,+($G(LEXM)),0)))
 S:$D(^LEX(757.01,LEXM,3)) LEXDES="*"
 S LEXX=$G(LEXDES) Q LEXX
SCH(LEXX) ; Search for LEXX a $Orderable variable
 S:$G(LEXX)'?1N.N LEXX=$E(LEXX,1,($L(LEXX)-1))_$C($A($E(LEXX,$L(LEXX)))-1)_"~"
 S:$G(LEXX)?1N.N LEXX=LEXX-.0000000000000009 N LEXIGN
 Q LEXX
 Q
KWO(X,Y) ; Keyword only (SW)
 N LEXS,LEXI,LEXE,LEXK,LEXEC,LEXKC S LEXS=$G(X) Q:$L(LEXS)<6 -1
 Q:'$D(^LEX(757.01,"AWRD",LEXS)) -2
 S LEXI=+($G(Y)) Q:+LEXI'>0 -3
 Q:'$D(^LEX(757.01,"AWRD",LEXS,LEXI)) -4
 Q:"^757.01^"'[("^"_$G(LEXLKFL)_"^") -5
 S (LEXEC,LEXKC,LEXE)=0 F  S LEXE=$O(^LEX(757.01,"AWRD",LEXS,LEXI,LEXE)) Q:+LEXE=0  D
 . N LEXD S LEXD=$D(^LEX(757.01,"AWRD",LEXS,LEXI,LEXE))
 . S:LEXD#10>0 LEXEC=+($G(LEXEC))+1 Q:LEXD=1
 . S LEXK="" F  S LEXK=$O(^LEX(757.01,"AWRD",LEXS,LEXI,LEXE,LEXK)) Q:'$L(LEXK)  D
 . . S LEXEC=+($G(LEXEC))+1 S:LEXK?1N.N LEXKC=+($G(LEXKC))+1
 Q:+($G(LEXKC))>0&($G(LEXKC)=$G(LEXEC)) 1
 Q 0
UP(X) ; Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
