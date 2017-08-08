LEXQSCA ;ISL/KER - Query - SNOMED CT - Ask ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.01,        SACC 1.3
 ;    ^LEX(757.02,        SACC 1.3
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;               
 Q
SCT(X) ; SNOMED CT Code Selection
 ;   
 ; Output  7 piece "^" delimited String
 ; 
 ;         1  Code IEN file 757.02
 ;         2  Code
 ;         3  Status (1/0)
 ;         4  Effective date of Status
 ;         5  Initial Activation Date
 ;         6  Expression IEN file 757.01
 ;         7  Expression
 ;         
 Q:+($G(LEXEXIT))>0 "^^"
 N DIC,DTOUT,DUOUT,LEXCP,LEXSO,LEXSAB,LEXSRC,LEXIEN,LEXND,LEXEIEN,LEXETXT,LEXVTXT
 N LEXVDT,Y S U="^",DIC(0)="AEQMZ",DIC="^LEX(757.02,",DIC("A")=" Select a SNOMED CT code:  "
 S DIC("S")="I $P($G(^LEX(757.02,+Y,0)),U,3)=56&($P($G(^LEX(757.02,+Y,0)),U,5)>0)"
 S DIC("W")="W $$CODEW^LEXQSCA(+Y)" W ! D ^DIC
 S:$G(X)["^^"!($D(DTOUT)) LEXEXIT=1 Q:$G(X)["^^"!(+($G(LEXEXIT))>0) "^^"
 Q:'$L($G(X))!($G(X)="^") "^"  Q:$G(X)["^^" "^^"  Q:$D(DTOUT)!($D(DUOUT)) "^"
 S LEXIEN=+Y,LEXND=$G(^LEX(757.02,+LEXIEN,0)),LEXEIEN=+LEXND
 S LEXSO=$P($G(LEXND),U,2),LEXSRC=$P($G(LEXND),U,3),LEXSAB=$P($G(^LEX(757.03,+LEXSRC,0)),U,1)
 S X="" I $L(LEXSO),$L(LEXSAB) S X=$$CODEDAT(LEXSO,$G(LEXCDT),LEXSAB)
 Q X
CODEW(X) ; SNOMED CT Code Write
 Q:$G(DIC)'="^LEX(757.02," "" N IEN,COD,EFF,HIS,STA,ACT,EXP,PRE,PRI,NOD,QUA,STR S IEN=+($G(X)),(ACT,PRE,PRI,QUA)=""
 S NOD=$G(^LEX(757.02,+IEN,0)),EXP=$G(^LEX(757.01,+NOD,0)),EFF=$O(^LEX(757.02,+IEN,4,"B"," "),-1)
 S HIS=$O(^LEX(757.02,+IEN,4,"B",+EFF," "),-1),STA=$P($G(^LEX(757.02,+IEN,4,+HIS,0)),"^",2) S COD=$P(NOD,"^",2)
 S:STA="0" ACT="Inactive" S:$P(NOD,"^",5)>0 PRE="Preferred" S:$P(NOD,"^",7)>0 PRI="Primary"
 S:$L(ACT) QUA=QUA_", "_ACT S:$L(PRE) QUA=QUA_", "_PRE S:$L(PRI) QUA=QUA_", "_PRI
 F  Q:$E(QUA,1)'=","&($E(QUA,1)'=" ")  S QUA=$E(QUA,2,$L(QUA))
 S:$L(QUA) QUA="("_QUA_")" S STR="  "_COD_"  (SCT)" S:$L(QUA) STR=STR_"  "_QUA S X=STR
 Q X
CODEDAT(X,Y,Z) ;
 ;
 ; Input
 ; 
 ;     X   Code
 ;     Y   Versioning date
 ;     Z   Source Abbreviation (SAB)
 ;     
 ; Output
 ; 
 ;     X   7 Piece "^" delimited string
 ;           1   Code IEN file 757.02
 ;           2   Code
 ;           3   Status (internal)
 ;           4   Effective date (internal)
 ;           5   Initial date (internal)
 ;           6   Expression IEN
 ;           7   Expression
 ;           
 N LEXCD,LEXEF,LEXEN,LEXIA,LEXND,LEXSAB,LEXSN,LEXSO,LEXSRC,LEXST,LEXSTAT,LEXTX,LEXVDT
 S LEXSO=$G(X) Q:'$L(LEXSO) "1"  S LEXVDT=$G(Y),LEXSAB=$$UP^XLFSTR($G(Z)) Q:$L(LEXSAB)'=3 "2"
 S LEXSRC=$O(^LEX(757.03,"ASAB",LEXSAB,0)) Q:+LEXSRC'>0 "3"  S:LEXVDT'?7N LEXVDT=$$DT^XLFDT
 S LEXSTAT=$$STATCHK^LEXSRC2(LEXSO,LEXVDT,,LEXSAB)
 S LEXST=$P(LEXSTAT,U,1) Q:"^0^1^"'[("^"_LEXST_"^") "4"
 S LEXSN=$P($G(LEXSTAT),U,2) Q:+LEXSN'>0 "5"  Q:$P($G(^LEX(757.02,+LEXSN,0)),U,3)'=LEXSRC "6"
 S LEXND=$G(^LEX(757.02,+LEXSN,0)) Q:'$L(LEXND) "7"
 S LEXEN=+$P(LEXND,U,1) Q:+LEXEN'>0 "8"
 S LEXCD=$P(LEXND,U,2) Q:'$L(LEXCD) "9"  Q:LEXCD'=$G(LEXSO) "A"
 S LEXEF=$P($G(LEXSTAT),U,3) S:LEXEF'?7N LEXEF="Pending"
 S LEXIA=$P($G(LEXSTAT),U,4)
 S LEXTX=$P($G(^LEX(757.01,+LEXEN,0)),U,1) Q:'$L(LEXTX) "B"
 S X=LEXSN_U_LEXCD_U_LEXST_U_LEXEF_U_LEXIA_U_LEXEN_U_LEXTX
 Q X
SD(X) ; Short Date
 Q $TR($$FMTE^XLFDT(+($G(X)),"5DZ"),"@"," ")
CLR ; Clear
 N LEXCDT,LEXCPT,LEXEXIT
 Q
