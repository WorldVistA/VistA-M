LEXSET4 ; ISL Setup Functions                      ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
NS(LEX) ; Look-up application namespace
 N D,DIC,DTOUT,DUOUT D:'$D(LEXSAVE) SAVE K DIC S DIC("A")="Select APPLICATION:  "
 S DIC("W")="W ?35,$P($G(^LEXT(757.2,+Y,5)),U,5)"
 S DIC="^LEXT(757.2,",DIC(0)="AEQM",D="AN"
 S DIC("S")="I $L($P($G(^LEXT(757.2,Y,5)),U,5))"
 D ^DIC S LEX="" S:+Y>0 LEX=$P($G(^LEXT(757.2,+Y,5)),U,5)
 S:LEX="" LEX="LEX" K DIC,X,Y D:$D(LEXSAVE) RESTORE Q LEX
SS(LEX) ; Look-up subset (vocabulary)
 D:'$D(LEXSAVE) SAVE
 S:'$D(DIC("B")) DIC("B")="Lexicon" S DIC("A")="Select VOCABULARY:  "
 S DIC="^LEXT(757.2,",DIC(0)="AEQM",D="AA"
 S DIC("S")="I $L($P($G(^LEXT(757.2,Y,0)),U,2))"
 D ^DIC S LEX="" S:+Y>0 LEX=$P($G(^LEXT(757.2,+Y,0)),U,2)
 S:LEX="" LEX="WRD" K DIC,X,Y D:$D(LEXSAVE) RESTORE Q LEX
SAVE ; Save look-up variables
 S LEXSAVE="" S:$L($G(X)) LEXDX=X S:$L($G(DIC("A"))) LEXDA=DIC("A")
 S:$L($G(DIC("B"))) LEXDB=DIC("B") S:$L($G(DIC("W"))) LEXDW=DIC("W") S:$L($G(DIC(0))) LEXD0=DIC(0)
 Q
RESTORE ; Restore look-up variables
 S:$L($G(LEXDX)) X=LEXDX K:'$L($G(LEXDX)) X S:$L($G(LEXD0)) DIC(0)=LEXD0 S:$L($G(LEXDA)) DIC("A")=LEXDA
 S:$L($G(LEXDB)) DIC("B")=LEXDB S:$L($G(LEXDW)) DIC("W")=LEXDW K LEXDA,LEXD0,LEXDX,LEXDB,LEXDW,LEXSAVE
 Q
