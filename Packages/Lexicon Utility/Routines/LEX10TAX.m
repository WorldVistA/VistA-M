LEX10TAX ;ISL/KER - Post ICD-10 Taxonomy Look-up ;12/19/2014
 ;;2.0;LEXICON UTILITY;**80,86**;Sep 23, 1996;Build 1
 ;
 ; Global Variables
 ;    ^LEX(757.01         N/A
 ;    ^LEX(757.02         N/A
 ;    ^LEX(757.03         N/A
 ;    ^TMP("LEXFND"       SACC 2.3.2.5.1
 ;    ^TMP("LEXHIT"       SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH"       SACC 2.3.2.5.1
 ;    ^TMP(LEX10          SACC 2.3.2.5.1
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
 ;    LOOK^LEXA           ICR   2950
 ;    CONFIG^LEXSET       ICR   1609
 ;    $$STATCHK^LEXSRC2   ICR   4083
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;               
 Q
TAX(X,LEXSRC,LEXDT,LEXSUB,LEXVER) ; Get Taxonomy Information
 ;
 ; Input: 
 ; 
 ;  X       Search String
 ;    
 ;  LEXSRC  String of Sources
 ;          Delimited by an "^" Up-Arrow
 ;                
 ;            Using source abbreviations
 ;            "ICD^ICP^10D^10P"
 ;                 
 ;            Using source pointers to file 757.03
 ;            "1^2^30^31"
 ;                 
 ;            Using Nomenclature
 ;            "ICD-9-CM^ICD-9 Proc^ICD-10-CM^ICD-10 Proc
 ;                 
 ;  LEXDT   Date to use to evaluate status
 ;    
 ;  LEXSUB  Name of a subscript to use in the ^TMP 
 ;          global (optional)
 ;            
 ;          ^TMP(LEXSUB,$J,
 ;          ^TMP("LEXTAX",$J,    Default
 ;    
 ;  LEXVER  Versioning Flag (optional, default = 0)
 ;     
 ;          0  Return active and inactive codes
 ;          1  Version, return active codes only
 ;     
 ; Output: 
 ; 
 ;  $$TAX   The number of codes found or -1 ^ error message
 ;    
 ;  ^TMP(LEXSUB,$J,SRC,(CODE_" "),#)
 ;    
 ;          5 piece "^" delimited string
 ;                             
 ;          1   Activation Date (can be a future date)
 ;          2   Inactivation Date (can be a future date)
 ;          3   Lexicon IEN to Expression File 757.01
 ;          4   Variable Pointer to a National file
 ;          5   Short Name from a National file
 ; 
 ;  ^TMP(LEXSUB,$J,SRC,(CODE_" "),#,0)
 ;    
 ;          2 piece "^" delimited string
 ;                             
 ;          1   Code (no spaces)
 ;          2   Lexicon Expression
 ;              
 ;   Subscript SRC is a pointer to the CODING SYSTEM FILE 757.03
 ;                             
 N LEX,LEXX,LEXIS,LEXVDT,LEX10SUB S LEXX=$$UP^XLFSTR($G(X)) Q:$L(LEXX)'>1 "-1^Search Text Missing"
 S LEXVDT="" S:$P($G(LEXDT),".",1)'?7N LEXDT=$$DT^XLFDT
 S:$P($G(LEXDT),".",1)?7N LEXVDT=$P($G(LEXDT),".",1)
 S LEXSRC=$$SRC($G(LEXSRC))
 S LEX10SUB=$G(LEXSUB) S:'$L(LEX10SUB) LEX10SUB="LEXTAX"
 S LEXIS=$$IS(LEXX),LEXVER=+($G(LEXVER)) D:LEXIS LBC D:'LEXIS LBT
 S X=+($G(^TMP(LEX10SUB,$J,0))) S:X'>0 X="-1^No Entries Found"
 Q X
LBC ; Lookup by Code
 N LEXCTL,LEXORD S LEXCTL=LEXX,LEXORD=$E(LEXX,1,($L(LEXX)-1))_$C($A($E(LEXX,$L(LEXX)))-1)_"~ "
 F  S LEXORD=$O(^LEX(757.02,"CODE",LEXORD)) Q:'$L(LEXORD)!($E(LEXORD,1,$L(LEXCTL))'=LEXCTL)  D
 . N LEXSIEN S LEXSIEN=0
 . F  S LEXSIEN=$O(^LEX(757.02,"CODE",LEXORD,LEXSIEN)) Q:+LEXSIEN'>0  D
 . . N LEXND,LEXIEN,LEXCD,LEXPF,LEXTY,LEXSR S LEXND=$G(^LEX(757.02,+LEXSIEN,0)),LEXIEN=+LEXND
 . . S LEXCD=$P(LEXND,"^",2),LEXPF=$P(LEXND,"^",5),LEXSR=$P(LEXND,"^",3)
 . . Q:("^"_LEXSRC_"^")'[("^"_LEXSR_"^")
 . . S LEXTY=$P($G(^LEX(757.01,+LEXIEN,1)),"^",2)
 . . Q:LEXTY'=1  Q:LEXPF'>0  Q:$E(LEXCD,1,$L(LEXCTL))'=LEXCTL  D ES(LEXIEN,$G(LEXVDT))
 D REO D:+($G(^TMP(LEX10SUB,$J,0)))'>0 LBT
 Q
LBT ; Looup by Text
 K ^TMP("LEXSCH",$J),^TMP("LEXFND",$J),^TMP("LEXHIT",$J),LEX
 N LEXTMP,LEXFQ,LEXIEN,DIC,LEXSAB S DIC="^LEX(757.01,",LEXTMP=$G(LEXVDT)
 D CONFIG^LEXSET("PXRM","CR1")
 S ^TMP("LEXSCH",$J,"ADF",0)=1 S ^TMP("LEXSCH",$J,"FIL",0)="I 1"
 S ^TMP("LEXSCH",$J,"FIL",1)="ALL" S ^TMP("LEXSCH",$J,"LEN",0)=1
 K LEXVDT D LOOK^LEXA(LEXX,"PXRM",1,"CR1") S:LEXTMP?7N LEXVDT=LEXTMP
 S LEXIEN=+$G(LEX("LIST",1)) D:LEXIEN>0 ES(LEXIEN,$G(LEXTMP))
 S LEXFQ="" F  S LEXFQ=$O(^TMP("LEXFND",$J,LEXFQ)) Q:'$L(LEXFQ)  D
 . S LEXIEN=0 F  S LEXIEN=$O(^TMP("LEXFND",$J,LEXFQ,LEXIEN)) Q:+LEXIEN'>0  D
 . . K LEXCTL D ES(LEXIEN)
 K ^TMP("LEXSCH",$J),^TMP("LEXFND",$J),^TMP("LEXHIT",$J),LEX D REO
 Q
ES(X,Y) ; Expression to Code
 N LEXIEN,LEXSIEN,LEXDT S LEXIEN=+($G(X)) Q:+LEXIEN'>0  S LEXDT=$P($G(Y),".",1) S:LEXDT'?7N LEXDT=$$DT^XLFDT
 S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"B",LEXIEN,LEXSIEN)) Q:+LEXSIEN'>0  D
 . N LEXND,LEXV,LEXEF,LEXHI,LEXST,LEXCO,LEXSR,LEXSB,LEXNM,X,LEX,LEXCT,LEXCD,LEXFIL
 . S LEXV=1,LEXND=$G(^LEX(757.02,+LEXSIEN,0)),LEXCD=$P(LEXND,"^",2),LEXSR=$P(LEXND,"^",3)
 . Q:("^"_LEXSRC_"^")'[("^"_LEXSR_"^")
 . I 0 I LEXSR=56 S LEXFIL=$$SCT(LEXIEN,LEXDT) Q:LEXFIL'>0
 . Q:'$L(LEXCD)  Q:+LEXSR'>0  Q:'$D(^LEX(757.03,+LEXSR,0))
 . I +($G(LEXVER))>0,$G(LEXVDT)?7N D  Q:LEXV'>0
 . . N LEXST S LEXST=$$STATCHK^LEXSRC2(LEXCD,LEXVDT,,LEXSR) S:+LEXST'>0 LEXV=0
 . Q:$D(^TMP(LEX10SUB,$J,+LEXSR,(LEXCD_" ")))  S X=$$PERIOD^LEXU(LEXCD,+LEXSR,.LEX)
 . S LEXCT=0,LEXEF=0 F  S LEXEF=$O(LEX(LEXEF)) Q:+LEXEF'>0  D
 . . Q:LEXEF'?7N  N LEXND,LEXDD S LEXND=$G(LEX(LEXEF)),LEXDD=$G(LEX(LEXEF,0))
 . . Q:$P(LEXND,"^",2)'>0  Q:'$L(LEXDD)  S LEXCT=LEXCT+1
 . . I '$D(^TMP(LEX10SUB,$J,+LEXSR,(LEXCD_" "))) D
 . . . S ^TMP(LEX10SUB,$J,0)=$G(^TMP(LEX10SUB,$J,0))+1
 . . S ^TMP(LEX10SUB,$J,+LEXSR,(LEXCD_" "),LEXCT)=LEXEF_"^"_LEXND
 . . S ^TMP(LEX10SUB,$J,+LEXSR,(LEXCD_" "),LEXCT,0)=LEXCD_"^"_LEXDD
 Q
REO ; Reorder Array
 N LEXKEY S LEXKEY="" F  S LEXKEY=$O(^TMP(LEX10SUB,$J,"IN",LEXKEY)) Q:'$L(LEXKEY)  D
 . N LEXCD S LEXCD="" F  S LEXCD=$O(^TMP(LEX10SUB,$J,"IN",LEXKEY,LEXCD)) Q:'$L(LEXCD)  D
 . . N LEXND,LEXSB,LEXI S LEXND=$G(^TMP(LEX10SUB,$J,"IN",LEXKEY,LEXCD))
 . . S LEXSB=$P(LEXND,"^",7) Q:'$L(LEXSB)  S LEXSR=$P(LEXND,"^",6) Q:+LEXSR'>0
 . . S LEXI=$O(^TMP(LEX10SUB,$J,LEXSR," "),-1)+1 S ^TMP(LEX10SUB,$J,LEXSR,LEXI)=LEXND
 K ^TMP(LEX10SUB,$J,"IN")
 Q
IS(X) ; Is a Code
 S X=$G(X) Q:'$L(X) 0
 Q:$D(^LEX(757.02,"CODE",(X_" "))) 1
 Q:$O(^LEX(757.02,"CODE",(X_" ")))[X 1
 Q 0
SRC(X) ; Re-Create Source String
 N LEXX,LEXN,LEXI S LEXN="" S LEXX=$G(X) Q:'$L(LEXX) "ALL"
 F LEXI=1:1 Q:'$L($P(LEXX,"^",LEXI))  D
 . N LEXSB,LEXSR S LEXSB=$P(LEXX,"^",LEXI)
 . S LEXSR=$$CS(LEXSB) S:+LEXSR>0 LEXN=LEXN_"^"_+LEXSR
 S X=$$TM(LEXN,"^")
 Q X
CS(X) ; Coding System
 N LEXIN S LEXIN=$G(X) Q:'$L(LEXIN) ""
 Q:LEXIN?1N.N&($D(^LEX(757.03,+LEXIN,0))) +LEXIN
 Q:$D(^LEX(757.03,"ASAB",LEXIN))&($O(^LEX(757.03,"ASAB",LEXIN,0))>0) $O(^LEX(757.03,"ASAB",LEXIN,0))
 Q:$D(^LEX(757.03,"B",LEXIN))&($O(^LEX(757.03,"B",LEXIN,0))>0) $O(^LEX(757.03,"B",LEXIN,0))
 Q:$D(^LEX(757.03,"C",LEXIN))&($O(^LEX(757.03,"C",LEXIN,0))>0) $O(^LEX(757.03,"C",LEXIN,0))
 Q ""
 ; 
 ; Miscellaneous
SCT(LEX,LEXVDT) ;   Filter by SNOMED CT (SCT) (Human only)
 ; 
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$SCT    Human SNOMED Code or Null
 ;             Excludes Veterinary SNOMED codes
 ;
 N LEXEX,LEXMC,LEXD,LEXC,LEXI,LEXO,LEXPL,LEXVT S LEXEX=+($G(LEX)),LEXD=$G(LEXVDT) Q:LEXEX'>0 0
 S LEXC=$S(LEXD?7N:$$ONE^LEXU(+LEXEX,LEXD,"SCT"),1:$$ONE^LEXU(+LEXEX,,"SCT"))
 Q:'$L(LEXC) 0  S LEXMC=+($G(^LEX(757.01,+LEXEX,1))) Q:LEXMC'>0 0  Q:'$D(^LEX(757.1,"B",LEXMC)) 0
 S LEXVT=0,LEXI=0 F  S LEXI=$O(^LEX(757.1,"B",LEXMC,LEXI)) Q:+LEXI'>0  D  Q:LEXVT>0
 . N LEXT,LEXN S LEXT=$P($G(^LEX(757.1,LEXI,0)),"^",3),LEXN=$$UP^XLFSTR($P($G(^LEX(757.12,+LEXT,0)),"^",2)) S:LEXN["VETERINARY" LEXVT=1
 S LEXPL=0,LEXI=0 F  S LEXI=$O(^LEX(757.21,"B",LEXEX,LEXI)) Q:+LEXI'>0  D  Q:LEXPL>0
 . N LEXT,LEXN S LEXT=$P($G(^LEX(757.21,LEXI,0)),"^",2),LEXN=$P($G(^LEXT(757.2,+LEXT,0)),"^",2) S:LEXN="PLS" LEXPL=1
 S LEXO=1 S:LEXVT=1 LEXO=0 S:LEXPL'>0 LEXO=0
 S X=LEXO
 Q X
SHO ;   Show ^TMP global
 N LEXNN,LEXNC,LEXS S LEXS=$G(LEXSUB) S:'$L(LEXS) LEXS="LEXTAX"
 S LEXNN="^TMP("""_LEXS_""","_$J_")",LEXNC="^TMP("""_LEXS_""","_$J_","
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . N LEXND S LEXND=@LEXNN W !,LEXNN,"=",LEXND
 Q
EXP ;   Show ^TMP global (expanded display)
 N LEXN1,LEXN2,LEXN3,LEXNN,LEXNC,LEXS,LEXTD S LEXS=$G(LEXSUB) S:'$L(LEXS) LEXS="LEXTAX"
 S LEXTD=$$DT^XLFDT,LEXN1=0 F  S LEXN1=$O(^TMP(LEXS,$J,LEXN1)) Q:+LEXN1'>0  D
 . N LEXSNM Q:'$D(^LEX(757.03,LEXN1,0))
 . S LEXSNM=$P($G(^LEX(757.03,LEXN1,0)),"^",2) Q:'$L(LEXSNM)
 . S LEXN2="" F  S LEXN2=$O(^TMP(LEXS,$J,LEXN1,LEXN2)) Q:'$L(LEXN2)  D
 . . W !,?3,LEXSNM," Code:  ",LEXN2
 . . S LEXN3=0 F  S LEXN3=$O(^TMP(LEXS,$J,LEXN1,LEXN2,LEXN3)) Q:+LEXN3'>0  D
 . . . N LEXN,LEX0,LEXAC,LEXIN,LEXIE,LEXVP,LEXSN,LEXCD,LEXNM,LEXA,LEXI
 . . . S LEXN=$G(^TMP(LEXS,$J,LEXN1,LEXN2,LEXN3))
 . . . S LEX0=$G(^TMP(LEXS,$J,LEXN1,LEXN2,LEXN3,0))
 . . . S LEXAC=$P(LEXN,"^",1),LEXIN=$P(LEXN,"^",2)
 . . . S LEXIE=$P(LEXN,"^",3),LEXVP=$P(LEXN,"^",4)
 . . . S LEXSN=$P(LEXN,"^",5)
 . . . W !,?5,"Active:  ",$$ED(LEXAC) W:LEXAC>LEXTD " (Pending)"
 . . . W ?36,"Inactive:  ",$$ED(LEXIN) W:LEXIN>LEXTD " (Pending)"
 . . . S LEX0=$G(^TMP(LEXS,$J,LEXN1,LEXN2,LEXN3,0))
 . . . S LEXCD=$P(LEX0,"^",1)
 . . . S LEXNM=$P(LEX0,"^",2) S LEXA(1)=LEXNM D PR(.LEXA,(79-36))
 . . . W !,?5,"   IEN:  ",LEXIE W:$L($G(LEXA(1))) ?36,$G(LEXA(1))
 . . . S LEXI=1 F  S LEXI=$O(LEXA(LEXI)) Q:+LEXI'>0  W:$L($G(LEXA(LEXI))) !,?36,$G(LEXA(LEXI))
 Q
ED(X) ;   Exernal Date
 S X=$G(X) Q:X'?7N "--/--/----"
 S X=$$FMTE^XLFDT(X,"5Z")
 Q X
VET(X) ; Veterinary Term - 1 = Yes
 N LEXEX,LEXMC,LEXD,LEXC,LEXI,LEXO S LEXEX=+($G(X)) Q:LEXEX'>0 -1
 S LEXMC=+($G(^LEX(757.01,+LEXEX,1))) Q:LEXMC'>0 -1  Q:'$D(^LEX(757.1,"B",LEXMC)) -3
 S LEXO=0,LEXI=0 F  S LEXI=$O(^LEX(757.1,"B",LEXMC,LEXI)) Q:+LEXI'>0  D
 . N LEXT,LEXN S LEXT=$P($G(^LEX(757.1,LEXI,0)),"^",3)
 . S LEXN=$$UP^XLFSTR($P($G(^LEX(757.12,+LEXT,0)),"^",2))
 . S:LEXN["VETERINARY" LEXO=1
 S X=LEXO
 Q X
PR(LEX,X) ;   Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,LEXI,LEXLEN,LEXC K ^UTILITY($J,"W") Q:'$D(LEX)
 S LEXLEN=+($G(X)) S:+LEXLEN'>0 LEXLEN=79 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXLEN S LEXI=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W")
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
