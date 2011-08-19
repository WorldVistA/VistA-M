LEXQIPA ;ISL/KER - Query - ICD Procedure - Ask ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$ICDOP^ICDCODE     ICR   3990
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXEXIT             Exit Flag
 ;    LEXCDT              Code Set Date
 ;               
 Q
ICP(X) ; ICD DX Code
 Q:+($G(LEXEXIT))>0 "^^"  N DIC,DTOUT,DUOUT,LEXDX,LEXSO,LEXDTXT,LEXVTXT,LEXVDT,Y,ICDVDT S:$G(LEXCDT)?7N ICDVDT=$G(LEXCDT)
 S DIC(0)="AEQMZ",DIC="^ICD0(",DIC("A")=" Select an ICD Procedure code:  " W !
 D ^DIC  S:$G(X)["^^"!($D(DTOUT)) LEXEXIT=1 Q:$G(X)["^^"!(+($G(LEXEXIT))>0) "^^"
 Q:$G(X)="^" "^"  Q:$G(X)["^^" "^^"  Q:$D(DTOUT)!($D(DUOUT)) "^"  S LEXSO=$P($G(Y),"^",2) S X="" I +Y>0,$L(LEXSO) D
 . S LEXVDT=$G(LEXCDT) S:LEXVDT'?7N LEXVDT=$$DT^XLFDT S X=Y,LEXDTXT=$P($G(Y(0)),"^",2),LEXDX=$$ICDOP^ICDCODE(LEXSO,LEXVDT)
 . S:$L($G(LEXDTXT)) LEXDTXT=LEXDTXT_" (Text not Versioned)" S LEXVTXT=$P(LEXDX,"^",5) S:'$L(LEXVTXT) LEXVTXT=LEXDTXT
 . S X=+Y_"^"_LEXSO S:$L(LEXVTXT) X=X_"^"_LEXVTXT
 S X=$$UP^XLFSTR(X) Q:'$L(X) "^"
 Q X
CLR ; Clear
 N LEXCDT,LEXEXIT
 Q
