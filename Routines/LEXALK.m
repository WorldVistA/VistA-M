LEXALK ; ISL/KER Look-up by Words ; 05/14/2003
 ;;2.0;LEXICON UTILITY;**2,3,6,25**;Sep 23, 1996
 ;
 ; External References
 ;   DBIA 10103  $$DT^XLFDT
 ;   DBIA  1571  ^LEX(
 ;                    
 ; Special Lookup variables
 ;                    
 ;   LEXSUB      Vocabulary
 ;   LEXSHCT     Shortcuts
 ;   LEXDICS     Screen - DIC("S") Format
 ;   LEXSHOW     Displayable codes
 ;   LEXLKFL     File Number
 ;   LEXLKGL     Global Root
 ;   LEXLKMD     Use Modifiers
 ;   LEXLKIX     Index to use during lookup
 ;   LEXLKSH     User Input (Search String)
 ;   LEXTKN(     Tolkens in order of frequency of use
 ;   LEXTKNS(    Tolkens in order of entry
 ;                    
EN ; Look-up user input
 N LEXSUB,LEXSHCT,LEXDICS,LEXSHOW,LEXLKFL,LEXLKGL,LEXLKMD
 N LEXLKIX,LEXLKSH,LEXVDT S LEXVDT=$$DT^XLFDT
 S LEXLKSH=$G(^TMP("LEXSCH",$J,"SCH",0)) I $L(LEXLKSH)<2 D  Q
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1,LEX("ERR",LEX("ERR",0))="User input missing or invalid"
 S LEXSUB=$G(^TMP("LEXSCH",$J,"VOC",0)) S:LEXSUB="" LEXSUB="WRD"
 S LEXLKMD=+($G(^TMP("LEXSCH",$J,"MOD",0)))
 S LEXLKIX=$G(^TMP("LEXSCH",$J,"IDX",0)) S:LEXLKIX="" LEXLKIX="AWRD"
 S LEXLKFL=$G(^TMP("LEXSCH",$J,"FLN",0)) I LEXLKFL'["757." D  Q
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1,LEX("ERR",LEX("ERR",0))="File number missing or invalid"
 S LEXLKGL=$G(^TMP("LEXSCH",$J,"GBL",0)) I LEXLKGL'["LEX(757." D  Q
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1,LEX("ERR",LEX("ERR",0))="Global location missing or invalid"
 S LEXSHOW=$G(^TMP("LEXSCH",$J,"DIS",0))
 D TOLKEN^LEXAM(LEXLKSH)
 N LEXOK,LEXDES,LEXDSP,LEXT,LEXO,LEXI,LEXE,LEXM,LEXME
 N LEXSS Q:$G(LEXLKFL)'["757."
 S LEXSS="" I $D(LEXTKNS(0)) D
 . N LEXI F LEXI=1:1:LEXTKNS(0) S LEXSS=LEXSS_" "_LEXTKNS(LEXI)
 . S LEXSS=$E(LEXSS,2,$L(LEXSS))
 S ^TMP("LEXSCH",$J,"SCH",0)=$G(LEXSS)
 S LEXT=$G(LEXTKN(1)),LEXO=$$SCH(LEXT)
 I $G(LEXSHCT)="",$G(LEXTKN(0))=1,$D(^LEX(LEXLKFL,LEXLKIX,LEXT)) D  G END
 . D EXACT
 . I +($O(^LEX(757.01,"ASL",LEXT,0)))>500 Q
 . D TOLKEN
 D TOLKEN
END ; End look-up by word
 I $D(^TMP("LEXFND",$J)) D BEG^LEXAL
 I '$D(^TMP("LEXFND",$J)) D
 . K LEX,^TMP("LEXFND",$J),^TMP("LEXHIT",$J) S LEX=0
 S:+($G(^TMP("LEXSCH",$J,"UNR",0)))>0&($L($G(^TMP("LEXSCH",$J,"NAR",0)))) LEX("NAR")=$G(^TMP("LEXSCH",$J,"NAR",0))
 Q
EXACT ; Main loop throuth TOLKENS that equal LEXT
 F  S LEXO=$O(^LEX(LEXLKFL,LEXLKIX,LEXO)) Q:LEXO'=LEXT  D IEN
 Q
TOLKEN ; Main loop though TOLKENS containing LEXT
 F  S LEXO=$O(^LEX(LEXLKFL,LEXLKIX,LEXO)) Q:LEXO'[LEXT!(LEXO="")  D IEN
 Q
IEN ; Loop throuth Internal Entry Numbers
 S LEXI=0
 F  S LEXI=$O(^LEX(LEXLKFL,LEXLKIX,LEXO,LEXI)) Q:+LEXI=0  D CHK
 Q
CHK ; Check each tolken
 N LEXOK,LEXO S LEXE=LEXI,LEXOK=1
 S:LEXLKGL'["757.01" LEXE=+($G(^LEX(LEXLKFL,LEXI,0))) Q:LEXE=0
 ; Filter
 S LEXFILR=$$EN^LEXAFIL($G(LEXFIL),LEXE) Q:LEXFILR=0
 ; Deactivated
 Q:+($P($G(^LEX(757.01,LEXE,1)),"^",5))=1
 ; Expression has Modifiers
 N LEXEMOD S LEXEMOD=+($P($G(^LEX(757.01,LEXE,1)),"^",6))
 S LEXM=+($G(^LEX(757.01,LEXE,1)))
 S LEXME=+($G(^LEX(757,LEXM,0)))
 ; Check not exact match
 I $L($G(^TMP("LEXSCH",$J,"EXM",0))),+(^TMP("LEXSCH",$J,"EXM",0))=LEXE Q
 I $L($G(^TMP("LEXSCH",$J,"EXC",0))),+(^TMP("LEXSCH",$J,"EXC",0))=LEXE Q
 ; Check tolkens
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
CHKTKNS(LEXE) ; Check tolkens
 N LEXM S LEXM=+($G(^LEX(757.01,LEXE,1))) Q:LEXM=0
 N LEXI,LEXOE,LEXC S LEXOE=LEXE,LEXI=1
 F  S LEXI=$O(LEXTKN(LEXI)) Q:+LEXI=0!('LEXOK)  D  Q:'LEXOK
 . N LEXT,LEXE S LEXT=LEXTKN(LEXI),LEXE=0,LEXOK=0
 . S LEXC=$$UP(^LEX(757.01,LEXOE,0))
 . I LEXC[(" "_LEXT) S LEXOK=1 Q
 . I LEXC[("-"_LEXT) S LEXOK=1 Q
 . I LEXC[("("_LEXT) S LEXOK=1 Q
 . I LEXC[("/"_LEXT) S LEXOK=1 Q
 . I $E(LEXC,1,$L(LEXT))=LEXT S LEXOK=1 Q
 . I $L(LEXT),$D(^LEX(757.01,LEXOE,5,"B",LEXT)) S LEXOK=1 Q
 . I $L(LEXT),$E($O(^LEX(757.01,LEXOE,5,"B",($E(LEXT,1,($L(LEXT)-1))_$C($A($E(LEXT,$L(LEXT)))-1)_"~"))),1,$L(LEXT))=LEXT S LEXOK=1 Q
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
 S LEXX=$E(LEXX,1,($L(LEXX)-1))_$C($A($E(LEXX,$L(LEXX)))-1)_"~" Q LEXX
 Q
UP(X) ; Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
