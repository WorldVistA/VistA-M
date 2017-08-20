LEXQSC ;ISL/KER - Query - SNOMED CT - Extract ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.01,        SACC 1.3
 ;    ^LEX(757.018,       SACC 1.3
 ;    ^LEX(757.02,        SACC 1.3
 ;    ^LEX(757.32,        SACC 1.3
 ;    ^LEX(757.33,        SACC 1.3
 ;    ^TMP("LEXQSCO",$J)  SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXIIEN             Include IENs flag
 ;               
EN ; Main Entry Point
 N LEXENV S LEXENV=$$EV^LEXQM Q:+LEXENV'>0  K ^TMP("LEXQSCO",$J)
 N LEXAD,LEXEDT,LEXCDT,LEXEXIT,LEXTEST S LEXEXIT=0,LEXCDT="" W !
 F  S LEXCDT=$$AD^LEXQM,LEXAD=LEXCDT Q:'$L(LEXCDT)  S LEXEDT=$P(LEXCDT,"^",1),LEXCDT=$P(LEXCDT,"^",2) Q:LEXCDT'?7N  D LOOK Q:LEXCDT'?7N  Q:+LEXEXIT>0
 K ^TMP("LEXQSCO",$J)
 Q
IEN ; Display with IENs
 N LEXIIEN S LEXIIEN=1 D EN
 Q
LOOK ; SNOMED CT Lookup Loop
 S LEXCDT=$G(LEXCDT),LEXEDT=$$ED^LEXQM(LEXCDT) I LEXCDT'?7N S LEXCDT="" Q
 N LEXSCT,LEXSCTC,LEXEEN,LEXEFF,LEXEXP,LEXIDT,LEXSEN,LEXSTA
 F  S LEXSCT=$$SCT^LEXQSCA S:LEXSCT="^^" LEXEXIT=1 Q:LEXSCT="^"!(LEXSCT="^^")  D LOOK2 Q:LEXSCT="^"!(LEXSCT="^^")
 Q
LOOK2 ; Needs LEXCDT and LEXSCT
 ; Needs
 ;   LEXCDT   FileMan date
 ;   LEXEXIT  Exit Flag (0)
 ;   LEXSCT   SNOMED CT = SIEN^CODE^STA^EFF^EIEN^EXP
 K LEXGET,LEXST,LEXSD,LEXLD,LEXMD,LEXLX,LEXWN,LEXLDT,LEXELDT
 N LEXAD,LEXCOD,LEXEDT,LEXSIEN,LEXEIEN,LEXLDT,LEXELDT,LEXINC,LEXFA,LEXCLEN,LEXLLEN,LEXTLEN,LEXLEN
 S:$E($G(LEXCDT),1,7)?7N LEXAD=$$UP^XLFSTR($$FMTE^XLFDT($E(LEXCDT,1,7)))_"^"_$E(LEXCDT,1,7) Q:'$L($G(LEXAD))
 S:$E($G(LEXCDT),1,7)?7N LEXEDT=$$FMTE^XLFDT($E(LEXCDT,1,7),"5Z") Q:'$L($G(LEXEDT))
 S LEXCLEN=18,LEXLLEN=LEXCLEN+7,LEXTLEN=(78-(LEXLLEN+2)),LEXLEN=LEXCLEN_"^"_LEXLLEN_"^"_LEXTLEN
 S LEXSEN=+($G(LEXSCT)),LEXCOD=$P(LEXSCT,"^",2) Q:'$L(LEXCOD)
 S LEXSTA=$P(LEXSCT,"^",3),LEXEFF=$P(LEXSCT,"^",4),(LEXFA,LEXIDT)=$P(LEXSCT,"^",5)
 S LEXEEN=$P(LEXSCT,"^",6),LEXEXP=$P(LEXSCT,"^",7),LEXLDT=+($G(LEXCDT))
 Q:+LEXSEN'>0  Q:+LEXEEN'>0  Q:LEXLDT'?7N  S LEXELDT=$$SD^LEXQM(LEXLDT) Q:'$L(LEXELDT)
 D EN^LEXQSC2
 Q
 ;   
NA(X,Y) ; Next Activation  File 757.02 ACT index
 ;
 ;   Input
 ;     
 ;     X     Code
 ;     Y     CSV Date (default TODAY)
 ;       
 N LEXCOD,LEXCDT,LEXNA S LEXCOD=$G(X),LEXCDT=$G(Y) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 S LEXNA=$O(^LEX(757.02,"ACT",(LEXCOD_" "),3,(LEXCDT-.001))) S X="" S:LEXNA?7N X=LEXNA
 Q X
PF(X) ; Preference       File 757.02, Field 4   0;5
 S X=+($G(X)) S X=$P($G(^LEX(757.02,+X,0)),"^",5),X=$S(X>0:"Preferred Term",1:"")
 Q X
TY(X) ; Type             File 757.01, Field 2   1;2
 S X=+($G(X)) S X=$P($G(^LEX(757.02,+X,1)),"^",2) S X=$S(X=1:"Concept",X=8:"Full Name",1:"Synonym")
 Q X
DA(X) ; Deactivated      File 757.01, Field 9   1;5
 S X=+($G(X)) S X=$P($G(^LEX(757.02,+X,1)),"^",5) S X=$S(X>0:"Deactivated Term",1:"")
 Q X
DS(X,LEX) ; Designation Code    Sub-file 757.118, Fields .01 and 2
 ;
 ;   Input
 ;     
 ;     X     Expression IEN
 ;       
 ;   Output
 ;     
 ;     LEX   Array passed by Reference
 ;       
 ;             LEX(#)= Designation Code "^" Hierarchy
 ;        
 K LEX N LEXO,LEXIEN S LEXIEN=+($G(X)),LEXO="" F  S LEXO=$O(^LEX(757.01,+LEXIEN,7,"C",56,LEXO)) Q:'$L(LEXO)  D
 . N LEXDI S LEXDI=0 F  S LEXDI=$O(^LEX(757.01,+X,7,"C",56,LEXO,LEXDI)) Q:+LEXDI'>0  D
 . . N LEXDS,LEXHI,LEXHN,LEXI,LEXT S LEXDS=$G(^LEX(757.01,+X,7,+LEXDI,0))
 . . S LEXHI=$P(LEXDS,"^",3) S LEXHN=$S(LEXHI?1N.N:$P($G(^LEX(757.018,+LEXHI,0)),"^",1),1:"")
 . . S:$D(LEXIIEN)&(+LEXHI>0) LEXHN=LEXHN_" (IEN "_+LEXHI_")"
 . . S LEXT=$P(LEXDS,"^",1) S:$L(LEXHI) LEXT=LEXT_"^"_LEXHN
 . . S LEXI=$O(LEX(" "),-1)+1,LEX(+LEXI)=LEXT
 Q
IENS(X,LEX) ; Get IENS
 ;
 ;   Input
 ;     
 ;     X     Major Concept Map IEN
 ;       
 ;   Output
 ;     
 ;     LEX   Array passed by Reference
 ;       
 ;             LEX(1,#) = Major Concept Expression IEN
 ;             LEX(2,#) = Fully Specified Name Expression IEN
 ;             LEX(3,#) = Synonymous Expression IEN
 ;        
 K LEX N LEXMC,LEXEIEN S LEXMC=+($G(X)),LEXEIEN=0 F  S LEXEIEN=$O(^LEX(757.01,"AMC",LEXMC,LEXEIEN)) Q:+LEXEIEN'>0  D
 . N LEXT,LEXI,LEXN S LEXT=$P($G(^LEX(757.01,+LEXEIEN,1)),"^",2) S LEXN=$S(LEXT=1:1,LEXT=8:2,1:3)
 . S LEXI=$O(LEX(LEXN," "),-1)+1 S LEX(LEXN,LEXI)=LEXEIEN
 Q
SUBS(X,LEX) ; Get Subsets 
 ;
 ;   Input
 ;     
 ;     X     Major Concept Map IEN
 ;       
 ;   Output
 ;     
 ;     LEX   Array passed by Reference
 ;       
 ;             LEX(SUB) = 4 Piece "^" delimited string
 ;             
 ;                1  Subset Name
 ;                2  Subset Definition IEN file 757.2
 ;                3  Subset IEN file 757.21
 ;                4  Expression IEN file 757.01
 ;        
 K LEX N LEXIENS,LEXMC,LEXIEN S LEXMC=+($G(X)),LEXIEN=0 F  S LEXIEN=$O(^LEX(757.01,"AMC",LEXMC,LEXIEN)) Q:+LEXIEN'>0  D
 . Q:$P($G(^LEX(757.01,+LEXIEN,1)),"^",5)>0  S LEXIENS(LEXIEN)=""
 Q:$O(LEXIENS(0))'>0  S LEXIEN=0 F  S LEXIEN=$O(LEXIENS(LEXIEN)) Q:+LEXIEN'>0  D
 . Q:'$D(^LEX(757.21,"B",LEXIEN))  S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.21,"B",LEXIEN,LEXSIEN)) Q:LEXSIEN'>0  D
 . . N LEXND,LEXSI,LEXSA,LEXSF S LEXSI=$P($G(^LEX(757.21,+LEXSIEN,0)),"^",2),LEXND=$G(^LEXT(757.2,+LEXSI,0))
 . . S LEXSA=$P(LEXND,"^",2),LEXSF=$$MIX^LEXXM($P(LEXND,"^",1))
 . . S:$L(LEXSA)=3&($L(LEXSF)) LEX(LEXSA)=LEXSF_"^"_LEXSI_"^"_LEXSIEN_"^"_LEXIEN
 Q
MAPS(X,LEX,LEXD,LEXL) ;  Get Mappings
 ;
 ;   Input
 ;     
 ;     X     SNOMED Code
 ;     LEXD  Versioning DAte
 ;     LEXL  Length of text
 ;       
 ;   Output
 ;     
 ;     LEX   Array passed by Reference
 ;       
 ;             LEX(#) = Text
 ;             
 N LEXIDT,LEXLEN,LEXISO,LEXMD,LEXTL K LEX S LEXISO=$G(X) Q:'$L(LEXISO)
 S LEXIDT=$P($G(LEXD),".",1) S:LEXIDT'?7N LEXIDT=$$DT^XLFDT
 S LEXLEN=$G(LEXL) S:+LEXLEN'>0 LEXLEN="18^25^53" S LEXTL=+($P($G(LEXLEN),"^",3))
 S LEXMD=0 F  S LEXMD=$O(^LEX(757.32,+LEXMD)) Q:+LEXMD'>0  D
 . Q:+($P($G(^LEX(757.32,+LEXMD,2)),"^",1))'=56  N LEXO,LEXSRC,LEXTO S LEXSRC=$P($G(^LEX(757.32,+LEXMD,2)),"^",2)
 . S LEXTO=+($P($G(^LEX(757.32,+LEXMD,2)),"^",2)) Q:+LEXTO'>0  Q:'$D(^LEX(757.03,+LEXTO,0))
 . S LEXO="" F  S LEXO=$O(^LEX(757.33,"C",LEXMD,LEXISO,LEXO)) Q:'$L(LEXO)  D
 . . N LEXC S LEXC="" F  S LEXC=$O(^LEX(757.33,"C",LEXMD,LEXISO,LEXO,LEXC)) Q:'$L(LEXC)  D
 . . . N LEXE S LEXE=0  F  S LEXE=$O(^LEX(757.33,"C",LEXMD,LEXISO,LEXO,LEXC,LEXE)) Q:LEXE'>0  D
 . . . . N LEXCODE,LEXEF,LEXEIEN,LEXEXP,LEXHI,LEXI,LEXMA,LEXMIEN,LEXN,LEXNOM,LEXSA,LEXSAB,LEXSIEN,LEXST,LEXT
 . . . . S LEXMIEN=LEXE,LEXEF=$O(^LEX(757.33,+LEXE,2,"B",(LEXIDT+.00001)),-1)
 . . . . S LEXHI=$O(^LEX(757.33,+LEXE,2,"B",+LEXEF," "),-1)
 . . . . S LEXST=$P($G(^LEX(757.33,+LEXE,2,+LEXHI,0)),"^",2) Q:LEXST'>0
 . . . . S LEXSA=$S(LEXST>0:"",1:"(Inactive Mapping)")
 . . . . S LEXMA=$P($G(^LEX(757.33,+LEXE,0)),"^",5)
 . . . . S LEXMA=$S(+LEXMA'>0:"(Partial Map)",1:"")
 . . . . S LEXCODE=$P($G(^LEX(757.33,+LEXE,0)),"^",3) Q:'$L(LEXCODE)
 . . . . S LEXNOM=$P($G(^LEX(757.03,+LEXTO,0)),"^",2) Q:'$L(LEXNOM)
 . . . . S LEXSAB=$E($P($G(^LEX(757.03,+LEXTO,0)),"^",1),1,3) Q:$L(LEXSAB)'=3
 . . . . S LEXSRC=$$STATCHK^LEXSRC2(LEXCODE,LEXIDT,,LEXSAB)
 . . . . S LEXSIEN=$P(LEXSRC,"^",2) Q:+LEXSIEN'>0
 . . . . S LEXEIEN=+($G(^LEX(757.02,+LEXSIEN,0)))
 . . . . S LEXEXP=$G(^LEX(757.01,+LEXEIEN,0)) Q:'$L(LEXEXP)
 . . . . S LEXT=LEXEXP_" ("_LEXNOM_" "_LEXCODE_")"
 . . . . S:$L(LEXMA) LEXT=LEXT_" "_LEXMA
 . . . . S:$L(LEXSA) LEXT=LEXT_" "_LEXSA
 . . . . S:$D(LEXIIEN) LEXT=LEXT_" (IEN "_LEXMIEN_")"
 . . . . K LEXN S LEXN(1)=LEXT D PR^LEXU(.LEXN,(+($G(LEXTL))-4))
 . . . . S LEXI=0 F  S LEXI=$O(LEXN(LEXI)) Q:+LEXI'>0  D
 . . . . . N LEXC,LEXT S LEXT=$G(LEXN(LEXI)) Q:'$L(LEXT)
 . . . . . S LEXC=$O(LEX(" "),-1)+1 S:LEXI=1 LEX(LEXC)=LEXT S:LEXI>1 LEX(LEXC)="    "_LEXT
 Q
