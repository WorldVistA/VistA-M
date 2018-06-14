LEXQIPA ;ISL/KER - Query - ICD Procedure - Ask ;10/10/2017
 ;;2.0;LEXICON UTILITY;**62,80,103,114**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$CSI^ICDEX         ICR   5747
 ;    $$ICDOP^ICDEX       ICR   5747
 ;    $$ROOT^ICDEX        ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed in LEXQIP
 ;     LEXCDT,LEXEXIT
 ;               
 Q
ICP(X)   ; ICD PR Code
 Q:+($G(LEXEXIT))>0 "^^"  N DIC,DICB,DTOUT,DUOUT,LEXDX,LEXSO,LEXDTXT,LEXVTXT,LEXVDT,Y,ICDVDT,ICDSYS,ICDFMT
 S DICB=$G(X),ICDFMT=2 S:$P($G(LEXCDT),"^",2)?7N (LEXVDT,ICDVDT)=$P($G(LEXCDT),"^",2)
 S:'$L($G(LEXVDT))&($P($G(LEXCDT),"^",1)?7N) (LEXVDT,ICDVDT)=$P($G(LEXCDT),"^",1)
 S DIC(0)="AEQMZ",DIC=$$ROOT^ICDEX(80.1) S:$D(LEXQUIET) DIC(0)="MZ" I $L(DIC) D
 . N ICDVDT,VDT S VDT=$O(^LEX(757.02,"AUPD","10P"," "),-1)
 . S:VDT?7N VDT=$$FMADD^XLFDT(VDT,740) S:VDT?7N ICDVDT=VDT
 . S DIC("A")=" Select an ICD Procedure code:  " S:$L($G(DICB)) DIC("B")=$G(DICB) W ! D ^DIC
 S X=$G(X),Y=$G(Y) S:$G(X)["^^"!($D(DTOUT)) LEXEXIT=1 Q:$G(X)["^^"!(+($G(LEXEXIT))>0) "^^"
 Q:$G(X)="^" "^"  Q:$G(X)["^^" "^^"  Q:$D(DTOUT)!($D(DUOUT)) "^"  S LEXSO=$P($G(Y),"^",2) S X="" I +Y>0,$L(LEXSO) D
 . N LEXSYS S LEXSYS=$$CSI^ICDEX(80.1,+Y),LEXVDT=$G(LEXCDT) S:LEXVDT'?7N LEXVDT=$$DT^XLFDT S X=Y,LEXDTXT=$P($G(Y(0)),"^",2)
 . S LEXDX=$$ICDOP^ICDEX(LEXSO,LEXVDT,LEXSYS,"E") S:$L($G(LEXDTXT)) LEXDTXT=LEXDTXT_" (Text not Versioned)"
 . S LEXVTXT=$P(LEXDX,"^",5) S:'$L(LEXVTXT) LEXVTXT=LEXDTXT
 . S X=+Y_"^"_LEXSO S:$L(LEXVTXT) X=X_"^"_LEXVTXT
 S X=$$UP^XLFSTR(X) Q:'$L(X) "^"
 Q X
