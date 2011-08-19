LEXU ;ISL/KER - Miscellaneous Lexicon Utilities ;01/03/2011
 ;;2.0;LEXICON UTILITY;**2,6,9,15,25,36,73**;Sep 23, 1996;Build 10
 ;
 ; External References
 ;   DBIA 10103  $$DT^XLFDT
 ;   DBIA  3990  $$ICDDX^ICDCODE
 ;   DBIA  1995  $$CPT^ICPTCOD
 ;                         
SC(LEX,LEXS,LEXVDT) ; Filter by Semantic Class
 ;    LEX      IEN of file 757.01
 ;    LEXS     Filter
 ;    LEXVDT   Date to use for screening by codes
 N LEXINC,LEXEXC,LEXIC,LEXEC,LEXRREC
 S LEXRREC=LEX Q:'$D(^LEX(757.01,LEXRREC,0)) 0
 I $L(LEXS,";")=3,$P(LEXS,";",3)'="" D  I LEXINC K LEXIC,LEXEXC,LEXS,LEXEC Q LEXINC
 . S LEXINC=0 S LEXINC=$$SO(LEXRREC,$P(LEXS,";",3),$G(LEXVDT))
 S LEXRREC=$P(^LEX(757.01,LEXRREC,1),U,1)
 S LEXINC=0 F LEXIC=1:1:$L($P(LEXS,";",1),"/") D
 . I $D(^LEX(757.1,"AMCC",LEXRREC,$P($P(LEXS,";",1),"/",LEXIC)))!($D(^LEX(757.1,"AMCT",LEXRREC,$P($P(LEXS,";",1),"/",LEXIC)))) S LEXINC=1,LEXIC=$L($P(LEXS,";",1),"/")+1
 I LEXINC=0!($P(LEXS,";",2)="") K LEXIC,LEXS,LEXEC Q LEXINC
 S LEXEXC=0 F LEXEC=1:1:$L($P(LEXS,";",2),"/") D
 . I $D(^LEX(757.1,"AMCC",LEXRREC,$P($P(LEXS,";",2),"/",LEXEC)))!($D(^LEX(757.1,"AMCT",LEXRREC,$P($P(LEXS,";",2),"/",LEXEC)))) S LEXEXC=1,LEXEC=$L($P(LEXS,";",2),"/")+1
 I LEXINC,'LEXEXC K LEXIC,LEXS,LEXEC Q 1
 K LEXIC,LEXS,LEXEC Q 0
SO(LEX,LEXS,LEXVDT) ; Filter by Source
 ;    LEX      IEN of file 757.01
 ;    LEXS     Filter
 ;    LEXVDT   Date to use for screening by codes
 N LEXTREC S LEXTREC=+LEX Q:'$D(^LEX(757.01,LEXTREC,0)) 0
 N LEXFND S LEXFND=0,LEXTREC=+LEXTREC Q:'$D(^LEX(757.01,LEXTREC)) LEXFND
 N LEXCODE,LEXSOID,LEXCREC,LEXSAB,LEXMC,LEXN0,LEXSO,LEXSTA
 S LEXMC=$P(^LEX(757.01,LEXTREC,1),U,1)
 S LEXMCE=+(^LEX(757,+($P(^LEX(757.01,LEXTREC,1),U,1)),0))
 I LEXTREC=LEXMCE D  G SOQ
 . S LEXFND=0 F LEXSOID=1:1:$L(LEXS,"/") Q:LEXFND  D
 . . S LEXCODE=$P(LEXS,"/",LEXSOID),LEXCREC=0
 . . F  S LEXCREC=$O(^LEX(757.02,"AMC",LEXMC,LEXCREC)) Q:+LEXCREC=0!(LEXFND)  D
 . . . S LEXN0=$G(^LEX(757.02,LEXCREC,0))
 . . . S LEXSAB=+($P(LEXN0,U,3)),LEXSO=$P(LEXN0,U,2)
 . . . S LEXSTA=$$STATCHK^LEXSRC2(LEXSO,$G(LEXVDT),,LEXSAB) Q:+LEXSTA'>0
 . . . Q:'$D(^LEX(757.03,LEXSAB,0))
 . . . S LEXSAB=$E(^LEX(757.03,LEXSAB,0),1,3)
 . . . I LEXSAB=LEXCODE S LEXFND=1
SOQ ; Quit Source Filter
 K LEX,LEXTREC,LEXMC,LEXS,LEXCODE,LEXMCE,LEXSOID Q LEXFND
SRC(LEX,LEXS) ; Filter by Expression Source
 ;    LEX      IEN of file 757.01
 ;    LEXS     Filter
 S LEX=+($G(LEX)),LEXS=+($G(LEXS))
 Q:LEX=0 0 Q:LEXS=0 0 Q:'$D(^LEX(757.01,LEX,0)) 0 Q:'$D(^LEX(757.14,LEXS,0)) 0
 S LEXSR=$P($G(^LEX(757.01,LEX,1)),U,12) Q:LEXSR=LEXS 1
 N LEXSR,LEXMC,LEXMCE S LEXMC=+($G(^LEX(757.01,LEX,1))),LEXMCE=+($G(^LEX(757,+LEXMC,0)))
 S LEXSR=$P($G(^LEX(757.01,LEXMCE,1)),U,12) Q:LEXSR=LEXS 1
 Q 0
DEF(LEX) ; Display expression definition
 ;    LEX      IEN of file 757.01
 I $D(^LEX(757.01,LEX,3,0)) D
 . N LEXLN F LEXLN=1:1:$P(^LEX(757.01,LEX,3,0),U,4) D
 . . I $D(^LEX(757.01,LEX,3,LEXLN,0)) W !,?2,^LEX(757.01,LEX,3,LEXLN,0)
 . K LEX,LEXLN W !
 Q
ID(LEX) ; ICD Diagnosis retained - ICD procedures ignored
 ;    LEX      Code
 Q:'$L($G(LEX)) "" Q:$L($P(LEX,".",1))<3 "" Q:'$D(^LEX(757.02,"AVA",(LEX_" "))) ""
 N LEXO,LEXR S (LEXO,LEXR)=0 F  S LEXR=$O(^LEX(757.02,"AVA",(LEX_" "),LEXR)) Q:+LEXR=0  D  Q:LEXO=1
 . I $D(^LEX(757.02,"AVA",(LEX_" "),LEXR,"ICD")) S LEXO=1
 Q:'LEXO "" Q LEX
ICDONE(LEX,LEXVDT) ; Return one ICD code for an expression
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 N LEXICD
 S LEXVDT=$S(+$G(LEXVDT)>0:LEXVDT,1:$$DT^XLFDT)
 S LEX=$$ONE^LEXSRC(LEX,"ICD",LEXVDT) Q:LEX="" ""
 S LEXICD=$$ICDDX^ICDCODE(LEX,LEXVDT)
 Q:$P(LEXICD,"^",2)="INVALID CODE" ""
 Q LEX
ICD(LEX,LEXVDT) ; Return all ICD codes for an expression
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 S LEXVDT=$S(+$G(LEXVDT)>0:LEXVDT,1:$$DT^XLFDT)
 N LEXSRC,LEXICD
 D ALL^LEXSRC(LEX,"ICD",LEXVDT) Q:+$G(LEXSRC(0))'>0 ""
 N LEXI,LEXT,LEXS S LEXI=0,LEXT=""
 F  S LEXI=$O(LEXSRC(LEXI)) Q:+LEXI=0  D
 . S LEXS=LEXSRC(LEXI)
 . S LEXICD=$$ICDDX^ICDCODE(LEXS,LEXVDT)
 . Q:$P(LEXICD,"^",2)="INVALID CODE"
 . Q:(LEXT_";")[(";"_LEXS_";")  S LEXT=LEXT_";"_LEXS
 S:$E(LEXT,1)=";" LEXT=$E(LEXT,2,$L(LEXT)) S LEX=LEXT Q LEX
CPTONE(LEX,LEXVDT) ; Return one CPT code for an expression
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 S LEXVDT=$S(+$G(LEXVDT)>0:LEXVDT,1:$$DT^XLFDT)
 N LEXCPT
 S LEX=$$ONE^LEXSRC(LEX,"CPT",LEXVDT)
 Q:LEX="" ""
 S LEXCPT=$$CPT^ICPTCOD(LEX,LEXVDT)
 Q:$P(LEXCPT,"^",2)="NO SUCH ENTRY" ""
 I +$P(LEXCPT,"^",7)=0 S LEX=""
 Q LEX
CPCONE(LEX,LEXVDT) ; Return one HCPCS code for an expression
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 S LEXVDT=$S(+$G(LEXVDT)>0:LEXVDT,1:$$DT^XLFDT)
 N LEXCPT
 S LEX=$$ONE^LEXSRC(LEX,"CPC",LEXVDT)
 Q:LEX="" ""
 S LEXCPT=$$CPT^ICPTCOD(LEX,LEXVDT)
 Q:$P(LEXCPT,"^",2)="NO SUCH ENTRY" ""
 I +$P(LEXCPT,"^",7)=0 S LEX=""
 I LEX'?1U.4N S LEX=""
 Q LEX
DSMONE(LEX) ; Return one DSM code for an expression
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ; Check for DSM-IV first
 S LEX=$$ONE^LEXSRC(LEX,"DS4") I LEX'="" Q LEX
 ; If not DSM-IV, then check for DSM-III
 S LEX=$$ONE^LEXSRC(LEX,"DS3") Q LEX
ADR(LEX) ; Mailing Address
 N DIC,DTOUT,DUOUT,X,Y S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="FO-SLC.MED.VA.GOV" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="ISC-SLC.MED.VA.GOV" D ^DIC Q:+Y>0 LEX
 Q "ISC-SLC.VA.GOV"
