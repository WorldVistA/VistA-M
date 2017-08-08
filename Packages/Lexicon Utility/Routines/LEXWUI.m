LEXWUI ;ISL/KER - Lexicon Keywords - Update (ICD) ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^ICD0(              ICR   4486
 ;    ^ICD9(              ICR   4485
 ;    ^LEX(757.03,        SACC 1.3
 ;    ^TMP("LEXWU",$J)    SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    IX1^DIK             ICR  10013
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10011
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    Control
 ;      LEXCHK            Word to check for
 ;      LEXKEY            Keyword to add if found
 ;      LEXINC            Text that must be included in term
 ;      LEXEXC            Text that must be excluded from the term
 ;      LEXCOM            Commit Flag
 ;      LEXTD             Today's Date
 ;      ZTQUEUED          TaskMan
 ;      ZTREQ             TaskMan
 ;      LEXQUIET          For testing only
 ;    Counters
 ;      LEXI01C           ICD-9 Diagnosis Counter
 ;      LEXI02C           ICD-9 Procedure Counter
 ;      LEXI30C           ICD-10 Diagnosis Counter
 ;      LEXI31C           ICD-10 Procedure Counter
 ;      LEXICDC           ICD Diagnosis Counter
 ;      LEXICPC           ICD Procedure Counter
 ;               
 Q
IDP ; ICD Diagnosis/Procedures
 S:$D(ZTQUEUED) ZTREQ="@" N LEXDIC F LEXDIC=80,80.1 D
 . N LEXRT,LEXFI,LEXFID,LEXASRC I LEXDIC=80 S LEXRT="^ICD9(",LEXFI=LEXDIC,LEXFID="80.682",LEXASRC="^1^30^"
 . I LEXDIC=80.1 S LEXRT="^ICD0(",LEXFI=LEXDIC,LEXFID="80.1682",LEXASRC="^2^31^"
 . Q:+($G(LEXFI))'>0  Q:'$L($G(LEXRT))  Q:'$L($G(LEXFID))  Q:'$L($G(LEXASRC))  D IFI
 Q
IFI ;   ICD by File #
 Q:$G(LEXTD)'?7N  Q:'$L($G(LEXKEY))  Q:'$L($G(LEXCHK))  Q:'$L($G(LEXINC))
 N LEXSI,LEXSRC,LEXTMP F LEXSI=2:1 S LEXSRC=$P(LEXASRC,"^",LEXSI) Q:'$L(LEXSRC)  Q:$$ABT  D ISR Q:$$ABT
 Q
ISR ;   ICD by Source
 N LEXALT,LEXCTL,LEXPRI,LEXSAB,LEXSYS S LEXPRI=LEXCHK,LEXALT="" D SPC
 S LEXSYS=$$SYS(LEXSRC) S LEXSAB=$E($G(^LEX(757.03,+LEXSRC,0)),1,3) Q:$L(LEXSAB)'=3
 F LEXCTL=LEXPRI,LEXALT D:$L(LEXCTL) ISC
 Q
ISC ;   ICD by Check Word
 N LEXIIEN S LEXIIEN=0 F  S LEXIIEN=$O(@(LEXRT_"""AD"","_+LEXSRC_","""_LEXCTL_""","_LEXIIEN_")")) Q:+LEXIIEN'>0  Q:$$ABT  D IIE  Q:$$ABT
 Q
IIE ;   ICD by IEN
 N LEXEFF,LEXHIEN,LEXEXP,LEXCT,LEXIN,LEXI,LEXTMP,LEXTYPE,LEXFIL
 S LEXHIEN=0 F  S LEXHIEN=$O(@(LEXRT_+LEXIIEN_",68,"_LEXHIEN_")")) Q:+LEXHIEN'>0  D IEX
 Q
IEX ;   ICD by Expression
 S LEXEXP=$$UP^XLFSTR($G(@(LEXRT_+LEXIIEN_",68,"_+LEXHIEN_",1)"))) Q:'$L(LEXEXP)
 Q:$D(@(LEXRT_+LEXIIEN_",68,"_+LEXHIEN_",2,""B"","""_LEXKEY_""")"))
 ;     Term contains ALL Includes
 S (LEXCT,LEXIN)=0 D  Q:LEXIN'>0  Q:LEXCT'=LEXIN
 . F LEXI=1:1 S LEXTMP=$$TM($P(LEXINC,";",LEXI)) Q:'$L(LEXTMP)  S LEXCT=LEXCT+1 S:$$IN(LEXTMP,LEXEXP)>0 LEXIN=LEXIN+1
 ;     Term contains Excludes
 I $L($G(LEXEXC)) S LEXIN=0 D  Q:LEXIN>0
 . S LEXIN=0 I $L($G(LEXEXC)) F LEXI=1:1 S LEXTMP=$P(LEXEXC,";",LEXI) Q:'$L(LEXTMP)  S:LEXEXP[LEXTMP LEXIN=1
 S:LEXSRC=1 LEXI01C=+($G(LEXI01C))+1 S:LEXSRC=30 LEXI30C=+($G(LEXI30C))+1
 S:LEXSRC=2 LEXI02C=+($G(LEXI02C))+1 S:LEXSRC=31 LEXI31C=+($G(LEXI31C))+1
 S LEXICDC=+($G(LEXI01C))+($G(LEXI30C)) S LEXICPC=+($G(LEXI02C))+($G(LEXI31C))
 D DEXP I $D(LEXCOM) D IIS
 Q
IIS ;   ICD Set
 N DA,DIK,LEXKIEN,LEXP3,LEXP4 Q:+($G(LEXIIEN))'>0  Q:+($G(LEXHIEN))'>0  Q:'$L($G(LEXKEY))
 S LEXDIC=$G(LEXDIC) Q:"^80^80.1^"'[("^"_LEXDIC_"^")
 I LEXDIC=80 S:'$L(LEXRT) LEXRT="^ICD9(" S:'$L(LEXFID) LEXFID="80.682" S:'$L(LEXASRC) LEXASRC="^1^30^"
 I LEXDIC=80.1 S:'$L(LEXRT) LEXRT="^ICD0(" S:'$L(LEXFID) LEXFID="80.1682" S:'$L(LEXASRC) LEXASRC="^2^31^"
 Q:'$L($G(LEXRT))  Q:'$L($G(LEXSAB))  Q:'$L($G(LEXFID))  Q:'$L($G(LEXASRC))  Q:'$L(LEXKEY)
 Q:$D(@(LEXRT_+LEXIIEN_",68,"_+LEXHIEN_",2,""B"","""_LEXKEY_""")"))
 S LEXP3=$O(@(LEXRT_+LEXIIEN_",68,"_+LEXHIEN_",2,"" "")"),-1),(LEXKIEN,LEXP3)=LEXP3+1
 S LEXP4=$P($G(@(LEXRT_+LEXIIEN_",68,"_+LEXHIEN_",2,0)")),"^",4),LEXP4=LEXP4+1
 S @(LEXRT_+LEXIIEN_",68,"_+LEXHIEN_",2,"_+LEXKIEN_",0)")=LEXKEY
 S @(LEXRT_+LEXIIEN_",68,"_+LEXHIEN_",2,0)")="^"_LEXFID_"^"_+LEXP3_"^"_+LEXP4
 K DA,DIK S DA(2)=LEXIIEN,DA(1)=LEXHIEN,DA=LEXKIEN
 S DIK=LEXRT_DA(2)_",68,"_DA(1)_",2," D IX1^DIK
 Q
 ;
 ; Miscellaneous
IN(X,Y) ;   Is X in Y
 N LEXC,LEXE,LEXP,LEXO S LEXO=0 S LEXC=$G(X),LEXE=$G(Y) Q:$E(LEXE,1,$L(LEXC))=LEXC 1
 F LEXP=" ","-","[","(","&","+","/","," S:LEXE[(LEXP_LEXC) LEXO=1
 S X=LEXO
 Q X
DEXP ;   Display Expression
 Q:$D(LEXQUIET)  Q:$D(ZTQUEUED)  Q:'$L(LEXEXP)  Q:'$L(LEXINC)  Q:'$L(LEXKEY)  Q:'$L($G(LEXRT))
 N LEXS,LEXT S LEXS=$P($G(@(LEXRT_+LEXIIEN_","_+LEXIIEN_",1)")),"^",1)
 S:LEXS=1!(LEXS=30) LEXT="ICD Grouper Diagnosis (80)" S:LEXS=2!(LEXS=31) LEXT="ICD Grouper Procedure (80.1)"
 W:$L($G(LEXT)) !,"Type:            ",LEXT W:$D(LEXSYS) !,"System:          ",LEXSYS
 W !,"Expression:      ",LEXEXP,!,"Include/Keyword: ",LEXINC,"/",LEXKEY
 I +($G(LEXIIEN))>0,$L($G(LEXRT)) W !,"IEN:             ",LEXRT,LEXIIEN,","
 W !
 Q
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
 N LEXNM S LEXNM=$$GET1^DIQ(200,(DUZ_","),.01)
 I '$L(LEXNM) W !!,?5,"Invalid/Missing DUZ" Q 0
 Q 1
