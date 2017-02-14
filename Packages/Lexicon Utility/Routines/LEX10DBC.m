LEX10DBC ;ISL/KER - ICD-10 Diagnosis Lookup by Code ;11/16/2016
 ;;2.0;LEXICON UTILITY;**80,110**;Sep 23, 1996;Build 6
 ;               
 ; Global Variables
 ;    ^TMP("LEXDX")       SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIM                ICR  10016
 ;    $$DT^XLFDT          ICR  10103
 ;               
I10C(LEXC,LEXA,LEXD,LEXN,LEXF) ; Lookup by Code, Return Pruned List
 ;
 ; Input
 ;   LEXC    ICD-10 DX Code       Required
 ;  .LEXA    Local Array (by Ref) Required
 ;   LEXD    Date (FM Format)     Optional (Default TODAY)
 ;   LEXL    Maximum to Return    Optional (Default = 30)
 ;   LEXF    Filter               Optional (Default 10D)
 ;  
 ; Output
 ; 
 ;   Code is found:
 ;   
 ;      LEXA(0)=# ^ PI  No to exceed lenght where possible
 ;      LEXA(#)=<code ien>_"^"_<code>_"^"_<activation date>
 ;      LEXA(#,0)=<expression ien>_"^"_<expression>
 ;   
 ;   No Code, Category is Returned:
 ;
 ;      LEXA(#)=<NULL>_"^"_<category>_"^"_<activation date> ^
 ;              <number of codes in the category>
 ;      LEXA(#,0)=<NULL>_"^"_<category name>
 ;   
 ;   Note:  Second piece of LEXA(0) is the pruning 
 ;          indicator and set to "1" if pruning
 ;          occurred
 ; 
 ; See WD^LEX10DP for DX Text Lookup by Keywords (Pruned)
 ; 
 K ^TMP("LEXDX",$J),LEXA N LEXSO,LEXCDT,LEXCT,LEXFIL,LEXNUM,LEXUSE
 N LEXFND,LEXTOT S LEXSO=$G(LEXC),LEXCDT=$G(LEXD),LEXNUM=+($G(LEXN))
 S LEXFIL=$G(LEXF) S LEXUSE=0 Q:'$L(LEXSO)
 S:$L(LEXSO)=3&(LEXSO'[".") LEXSO=LEXSO_"."
 S LEXA(0)=-1
 S:'$L(LEXFIL) LEXFIL="I $$SO^LEXU(Y,""10D"",+($G(LEXVDT)))"
 S:LEXNUM'>0 LEXNUM=30 S (LEXFND,LEXCT)=$$FIND(LEXSO,LEXCDT,LEXFIL)
 D REDUCE^LEX10DU(LEXNUM) D ARY^LEX10DU
 S LEXTOT=+($O(LEXA(" "),-1))
 S:LEXTOT>0&(LEXTOT<LEXFND) $P(LEXA(0),"^",2)=1
 K ^TMP("LEXDX",$J)
 Q
 ; Code Search
FIND(LEXC,LEXD,LEXF) ;   Find All Codes
 N LEX1,LEX2,LEXVDT,LEXCT,LEXFIL,LEXLEN,LEXNC,LEXNN,LEXOR,LEXPRE
 S LEXFIL=$G(LEXF) S:'$L(LEXFIL) LEXFIL="I 1"
 S LEXSO=$G(LEXC),LEXVDT=$G(LEXD)
 S LEXOR=$E(LEXSO,1,($L(LEXSO)-1))_$C($A($E(LEXSO,$L(LEXSO)))-1)_"~"
 S LEXNN="^LEX(757.02,""ADX"","""_LEXOR_" "")"
 S LEXNC="^LEX(757.02,""ADX"","""_LEXSO
 S (LEXPRE,LEXLEN,LEXCT)=0
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . N LEXC,LEXD,LEXE,LEXS,LEX1,LEX2
 . S LEXC=$P(LEXNN,",",3),LEXC=$TR(LEXC,"""",""),LEXC=$$TM(LEXC)
 . S LEXD=+($P(LEXNN,",",4)) Q:LEXD'?7N  Q:LEXVDT?7N&((LEXVDT+.001)'>LEXD)
 . S LEXS=+($P(LEXNN,",",5)) Q:LEXS'?1N  I LEXS="0" D  Q:LEXS'=1
 . . I LEXVDT?7N,(LEXVDT+.001)>+($G(LEXD)) D
 . . . S:$D(^TMP("LEXDX",$J,(LEXC_" "))) LEXCT=LEXCT-1 K ^TMP("LEXDX",$J,(LEXC_" "))
 . S LEX1=+($P(LEXNN,",",6)) Q:LEX1'?1N.N  Q:LEX1'>0
 . Q:$P($G(^LEX(757.02,+LEX1,0)),"^",5)'>0
 . S LEXE=+($G(^LEX(757.02,+LEX1,0))) Q:LEXE'?1N.N  Q:LEXE'>0
 . Q:$$SCR(LEXFIL,LEXE)'>0
 . S LEX2=+($P(LEXNN,",",7)) Q:LEX1'?1N.N  Q:LEX2'>0
 . Q:$P($G(^LEX(757.01,+LEXE,1)),"^",5)>0
 . S:$L(LEXC)>LEXLEN LEXPRE=LEXLEN,LEXLEN=$L(LEXC)
 . S:LEXPRE=0 LEXPRE=$L(LEXC) S:$L(LEXC)=(LEXLEN-1) LEXPRE=$L(LEXC)
 . S LEXCT=LEXCT+1,^TMP("LEXDX",$J,(LEXC_" "))=LEX1_"^"_LEXD
 Q LEXCT
 ; 
 ; Miscellaneous
SCR(X,Y) ;   Screen
 S Y=+($G(Y)) Q:+Y'>0 0  Q:'$D(^LEX(757.01,+Y,0)) 0
 N LEXFIL S LEXFIL=$G(X) Q:'$L(LEXFIL) 1  D ^DIM Q:'$D(X) 1
 X LEXFIL S X=$T
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
