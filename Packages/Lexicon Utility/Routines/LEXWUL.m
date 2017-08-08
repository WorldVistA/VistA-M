LEXWUL ;ISL/KER - Lexicon Keywords - Update (Lexicon) ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757            SACC 1.3
 ;    ^LEX(757.01         SACC 1.3
 ;    ^LEX(757.02         SACC 1.3
 ;    ^TMP("LEXWU",$J)    SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    IX1^DIK             ICR  10013
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10011
 ;               
 ; Local Variables NEWed or KILLed Elsewhere (LEXWUS)
 ;    Control
 ;      LEXEXC            Exclude String
 ;      LEXINC            Include String
 ;      LEXCHK            Index node being checked
 ;      LEXKEY            Keyword being processed
 ;      LEXQUIET          Suppress Display
 ;      LEXTEST           Test Flag
 ;      LEXCOM            Commit Flag
 ;    Counters
 ;      LEXL01C           ICD-9 Diagnosis Counter
 ;      LEXL02C           ICD-9 Procedure Counter
 ;      LEXL03C           CPT-4 Procedure Counter
 ;      LEXL04C           HCPCS Procedure Counter
 ;      LEXL17C           Title 38 Counter
 ;      LEXL30C           ICD-10 Diagnosis Counter
 ;      LEXL31C           ICD-10 Procedure Counter
 ;      LEXL56C           SNOMED CT Counter
 ;               
 Q
LEX ; Lexicon Expressions
 Q:'$L($G(LEXKEY))  Q:'$L($G(LEXCHK))  Q:'$L($G(LEXINC))  Q:'$L(LEXKEY)  K ^LEX("LEXWU",$J,"IEN"),^LEX("LEXWU",$J,"OUT")
 N LEXSRC,LEXSAB,LEXPRI,LEXALT S LEXPRI=$G(LEXCHK),LEXALT="" D SPC K:$D(LEXTEST) LEXCOM I $L(LEXPRI) D
 . N LEXCHK F LEXCHK=LEXPRI,LEXALT D:$L($G(LEXCHK)) LCHK
 Q
LCHK ;   Lexicon Check
 Q:'$L(LEXCHK)  N LEXCIEN,LEXEIEN,LEXCCTR,LEXICTR,LEXSRCA,LEXIENA S (LEXCCTR,LEXICTR,LEXCIEN)=0 K LEXIENA
 F  S LEXCIEN=$O(^LEX(757.01,"AWRD",LEXCHK,LEXCIEN)) Q:+LEXCIEN'>0  D
 . S LEXIENA(+LEXCIEN)="" N LEXIIEN S LEXIIEN=0
 . F  S LEXIIEN=$O(^LEX(757.01,"AWRD",LEXCHK,LEXCIEN,LEXIIEN)) Q:+LEXIIEN'>0  S LEXIENA(+LEXIIEN)=""
 S LEXEIEN=0 F  S LEXEIEN=$O(LEXIENA(LEXEIEN)) Q:+LEXEIEN'>0  D LEXP
 Q
LEXP ;   Lexicon Expression
 Q:+($G(LEXEIEN))'>0  N LEXCIEN,LEXCT,LEXEXP,LEXI,LEXIN,LEXND,LEXS,LEXSIEN,LEXSRC,LEXSRCA,LEXTMP,LEXTIEN K LEXSRCA
 S LEXCIEN=LEXEIEN Q:'$D(^LEX(757.01,+LEXCIEN,0))  Q:$P($G(^LEX(757.01,+LEXCIEN,1)),"^",5)>0
 Q:$D(^LEX(757.01,+LEXCIEN,5,"B",LEXKEY))  Q:$D(^LEX("LEXWU",$J,"IEN",+LEXCIEN))  S ^LEX("LEXWU",$J,"IEN",+LEXCIEN)=""
 S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"B",+LEXCIEN,LEXSIEN)) Q:+LEXSIEN'>0  D
 . N LEXS,LEXND,LEXSRC S LEXND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXND,"^",5)'>0
 . F LEXSRC=1,2,3,4,17,30,31,56 S:$P(LEXND,"^",3)=LEXSRC LEXSRCA(LEXSRC)=""
 Q:'$D(LEXSRCA)  Q:$O(LEXSRCA(0))'>0  S LEXEIEN=LEXCIEN,LEXEXP=$$UP^XLFSTR($G(^LEX(757.01,+LEXEIEN,0))) Q:'$L(LEXEXP)
 ;     Term contains ALL Includes
 S (LEXCT,LEXIN)=0 D  Q:LEXIN'>0  Q:LEXCT'=LEXIN
 . F LEXI=1:1 S LEXTMP=$$TM($P(LEXINC,";",LEXI)) Q:'$L(LEXTMP)  S LEXCT=LEXCT+1 S:$$IN(LEXTMP,LEXEXP)>0 LEXIN=LEXIN+1
 ;     Term contains Excludes
 I $L($G(LEXEXC)) S LEXIN=0 D  Q:LEXIN>0
 . S LEXIN=0 I $L($G(LEXEXC)) F LEXI=1:1 S LEXTMP=$P(LEXEXC,";",LEXI) Q:'$L(LEXTMP)  S:LEXEXP[LEXTMP LEXIN=1
 D LSET
 Q
LSET ;   Lexicon Set Keyword
 Q:+($G(LEXEIEN))'>0  Q:'$D(^LEX(757.01,+($G(LEXEIEN)),0))  Q:'$L(LEXEXP)  Q:'$L(LEXKEY)  Q:'$D(LEXSRCA)
 N DA,DIK,LEXCT,LEXI,LEXIEN,LEXIN,LEXP3,LEXP4,LEXSYS
 S:$D(LEXSRCA(1)) LEXL01C=+($G(LEXL01C))+1,LEXSYS=$$SYS(1) S:$D(LEXSRCA(2)) LEXL02C=+($G(LEXL02C))+1,LEXSYS=$$SYS(2)
 S:$D(LEXSRCA(3)) LEXL03C=+($G(LEXL03C))+1,LEXSYS=$$SYS(3) S:$D(LEXSRCA(4)) LEXL04C=+($G(LEXL04C))+1,LEXSYS=$$SYS(4)
 S:$D(LEXSRCA(17)) LEXL17C=+($G(LEXL17C))+1,LEXSYS=$$SYS(17) S:$D(LEXSRCA(30)) LEXL30C=+($G(LEXL30C))+1,LEXSYS=$$SYS(30)
 S:$D(LEXSRCA(31)) LEXL31C=+($G(LEXL31C))+1,LEXSYS=$$SYS(31) S:$D(LEXSRCA(56)) LEXL56C=+($G(LEXL56C))+1,LEXSYS=$$SYS(56)
 D DEXP I $D(LEXCOM) D
 . N DA,DIK,LEXIEN,LEXP3,LEXP4 S LEXIEN=$O(^LEX(757.01,+LEXEIEN,5," "),-1)+1,^LEX(757.01,+LEXEIEN,5,LEXIEN,0)=LEXKEY
 . S DA=LEXIEN,DA(1)=LEXEIEN,DIK="^LEX(757.01,"_DA(1)_",5," D IX1^DIK
 . S LEXP3="",(LEXP4,LEXI)=0 F  S LEXI=$O(^LEX(757.01,LEXEIEN,5,LEXI)) Q:+LEXI'>0  D
 . . S LEXP3=LEXI,LEXP4=LEXP4+1 N DA,DIK S DA(1)=LEXEIEN,DA=LEXI,DIK="^LEX(757.01,"_DA(1)_",5," D IX1^DIK
 . S:+LEXP3'>0 LEXP3="" S ^LEX(757.01,+LEXEIEN,5,0)="^757.18^"_+LEXP3_"^"_+LEXP4
 Q
 ;
 ; Miscellaneous
DEXP ;   Display Expression
 Q:$D(LEXQUIET)  Q:$D(ZTQUEUED)  Q:'$L(LEXEXP)  Q:'$L(LEXINC)  Q:'$L(LEXKEY)
 W !,"Type:            Lexicon Expression (757.01)" W:$D(LEXSYS) !,"System:          ",$G(LEXSYS)
 W !,"Expression:      ",$G(LEXEXP),!,"Include/Keyword: ",$G(LEXINC),"/",$G(LEXKEY)
 I +($G(LEXEIEN))>0 W !,"IEN:             ^LEX(757.01,",+($G(LEXEIEN)),","
 W !
 Q
CIEN(X) ;   Concept IEN
 N LEXEIEN,LEXMIEN,LEXCIEN
 S LEXEIEN=+($G(X)),LEXMIEN=+($G(^LEX(757.01,+LEXEIEN,1))),LEXCIEN=+($G(^LEX(757,+LEXMIEN,0))) S X=LEXCIEN
 Q X
IN(X,Y) ;   Is X in Y
 N LEXC,LEXE,LEXP,LEXO S LEXO=0 S LEXC=$G(X),LEXE=$G(Y) Q:$E(LEXE,1,$L(LEXC))=LEXC 1
 F LEXP=" ","-","[","(","&","+","/","," S:LEXE[(LEXP_LEXC) LEXO=1
 S X=LEXO
 Q X
SPC ;   Special Cases
 S LEXALT="" S:LEXKEY="XRAY" LEXALT=LEXKEY S:LEXKEY="ECOLI" LEXALT=LEXKEY
 Q
SYS(X) ;   System
 N LEXSRC S LEXSRC=$G(X) S X="" S:LEXSRC=1 X="ICD-9-CM" S:LEXSRC=2 X="ICD-9 Proc"
 S:LEXSRC=30 X="ICD-10-CM" S:LEXSRC=31 X="ICD-10-PCS"
 S:LEXSRC=3 X="CPT-4" S:LEXSRC=4 X="HCPCS"
 S:LEXSRC=17 X="Title 38" S:LEXSRC=56 X="SNOMED CT"
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
ABT(X) ;   Abort
 Q:$D(^TMP("LEXWU",$J,"STOP")) 1
 Q 0
ENV(X) ;   Environment
 D HOME^%ZIS S U="^",DT=$$DT^XLFDT,DTIME=300 K POP
 N LEXNM,ZTQUEUED,ZTREQ S LEXNM=$$GET1^DIQ(200,(DUZ_","),.01)
 I '$L(LEXNM) W !!,?5,"Invalid/Missing DUZ" Q 0
 Q 1
