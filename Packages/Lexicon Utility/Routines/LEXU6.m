LEXU6 ;ISL/KER - Miscellaneous Lexicon Utilities ;12/19/2014
 ;;2.0;LEXICON UTILITY;**80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.001)       N/A
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;    ^TMP("LEXTKN")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIC                ICR  10006
 ;               
SC(LEX,LEXS,LEXVDT) ; Filter by Semantic Class
 ;
 ; Input
 ;
 ;    LEX      IEN of file 757.01
 ;    LEXS     Filter
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$SC     1/0
 ;
 N LEXINC,LEXEXC,LEXIC,LEXEC,LEXRREC,X D VDT^LEXU
 S LEXRREC=LEX Q:'$D(^LEX(757.01,LEXRREC,0)) 0
 I $L(LEXS,";")=3,$P(LEXS,";",3)'="" D  Q:+LEXINC>0 LEXINC
 . S LEXINC=0 S LEXINC=$$SO(LEXRREC,$P(LEXS,";",3),$G(LEXVDT))
 S LEXRREC=$P(^LEX(757.01,LEXRREC,1),U,1)
 S LEXINC=0 F LEXIC=1:1:$L($P(LEXS,";",1),"/") D
 . N LEXP,LEX1,LEX2 S LEXP=$P($P(LEXS,";",1),"/",LEXIC)
 . S LEX1=$D(^LEX(757.1,"AMCC",LEXRREC,LEXP))
 . S LEX2=$D(^LEX(757.1,"AMCT",LEXRREC,LEXP))
 . I LEX1!(LEX2) D
 . . S LEXINC=1,LEXIC=$L($P(LEXS,";",1),"/")+1
 I LEXINC=0!($P(LEXS,";",2)="") K LEXIC,LEXS,LEXEC Q LEXINC
 S LEXEXC=0 F LEXEC=1:1:$L($P(LEXS,";",2),"/") D
 . N LEXP,LEX1,LEX2 S LEXP=$P($P(LEXS,";",2),"/",LEXEC)
 . S LEX1=$D(^LEX(757.1,"AMCC",LEXRREC,LEXP))
 . S LEX2=$D(^LEX(757.1,"AMCT",LEXRREC,LEXP))
 . I LEX1!(LEX2) D
 . . S LEXEXC=1,LEXEC=$L($P(LEXS,";",2),"/")+1
 I LEXINC,'LEXEXC K LEXIC,LEXS,LEXEC Q 1
 K LEXIC,LEXS,LEXEC
 Q 0
SO(LEX,LEXS,LEXVDT) ; Filter by Source
 ;
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXS     Filter
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$SO     1/0
 ;
 N LEXABR,LEXCR,LEXF,LEXMC,LEXMCE,LEXN0,LEXSAB,LEXSO,LEXSR,LEXSTA,LEXTR
 S LEXTR=+LEX,LEXF=0 Q:'$D(^LEX(757.01,LEXTR,0)) LEXF
 Q:'$D(^LEX(757.01,LEXTR)) LEXF
 S LEXMC=$P(^LEX(757.01,LEXTR,1),U,1)
 S LEXMCE=+(^LEX(757,+($P(^LEX(757.01,LEXTR,1),U,1)),0))
 D VDT^LEXU I LEXTR>0,LEXMCE>0,LEXTR=LEXMCE D  G SOQ
 . S LEXF=0 F LEXSR=1:1:$L(LEXS,"/") D  Q:LEXF>0
 . . S LEXABR=$P(LEXS,"/",LEXSR),LEXCR=0
 . . F  S LEXCR=$O(^LEX(757.02,"AMC",LEXMC,LEXCR)) Q:+LEXCR=0  D  Q:LEXF>0
 . . . N LEXN0,LEXSAB,LEXQ S LEXQ=0
 . . . S LEXN0=$G(^LEX(757.02,LEXCR,0))
 . . . S LEXSAB=+($P(LEXN0,U,3)),LEXSO=$P(LEXN0,U,2)
 . . . I $G(LEXLKT)["BC" D  Q:LEXQ
 . . . . N LEXNAR S LEXNAR=$G(^TMP("LEXSCH",$J,"NAR",0))
 . . . . I $L($G(LEXNAR)) S:$E(LEXSO,1,$L($G(LEXNAR)))'=$G(LEXNAR) LEXQ=1
 . . . S LEXSTA=$$STATCHK^LEXSRC2(LEXSO,$G(LEXVDT),,LEXSAB)
 . . . Q:+LEXSTA'>0  Q:$P(LEXSTA,U,2)'=LEXCR
 . . . Q:'$D(^LEX(757.03,LEXSAB,0))
 . . . S LEXSAB=$E(^LEX(757.03,LEXSAB,0),1,3)
 . . . I LEXSAB=LEXABR S LEXF=1
SOQ ; Quit Source Filter
 K LEXCR,LEXMC,LEXMCE,LEXN0,LEXSAB,LEXABR,LEXSO,LEXSR,LEXSTA,LEXTR
 Q LEXF
