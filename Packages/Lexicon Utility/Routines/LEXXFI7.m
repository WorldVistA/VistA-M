LEXXFI7 ; ISL/KER - File Info - Prompts and Header   ; 02/22/2007
 ;;2.0;LEXICON UTILITY;**32,49**;Sep 23, 1996;Build 3
 Q
 ;                    
 ; Global Variables
 ;   ^%ZOSF("UCI")       DBIA 10096
 ;   ^%ZOSF("PROD")      DBIA 10096
 ;
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA  2056  $$GET1^DIQ (file #200)
 ;   DBIA 10096  ^%ZOSF("UCI")
 ;   DBIA 10096  ^%ZOSF("PROD")
 ;                    
MT(X) ; Method - One or All Files
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,Y
 S DIR(0)="SAO^O:Checksum for ONE file;A:Checksum for ALL files (LEX/ICD/CPT)"
 S DIR("A",1)=" Compute Checksum for:",DIR("A",2)=" "
 S DIR("A",3)="   One Lexicon, ICD or CPT file"
 S DIR("A",4)="   All Lexicon, ICD or CPT files (757*/80*/81*)"
 S DIR("A",5)=" ",DIR("A")=" Select One or All:  (O/A)  "
 S DIR("B")="O",(DIR("?"),DIR("??"))="^D MTH^LEXXFI7"
 W ! D ^DIR S X=$S(Y="O":"ONE",Y="A":"ALL",1:"")
 Q X
MTH ;   Method Help
 W !,"     Do you wish to compute the checksum for a single Lexicon, ICD"
 W !,"     or CPT file or all Lexicon, ICD and CPT files (757*/80*/81*)"
 W:$G(X)["??" !,"     Answer either 'O'ne or 'A'll or '^' to exit"
 Q
 ;                             
CC(X) ; Checksum AND Count
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,Y
 S DIR(0)="YAO",DIR("A")=" Include a Record Count with the Checksum?  (Y/N)  "
 S DIR("B")="N",(DIR("?"),DIR("??"))="^D CCH^LEXXFI7"
 W ! D ^DIR S X=$S(+Y>0:1,1:0)
 Q X
CCH ;   Checksum AND Count Help
 W !,"     Answer 'Yes' to include a count of the total the number of records"
 W !,"     in the file/sub-file along with the checksum"
 Q
 ;                        
FI(X) ; Select Lexicon/ICD File
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,Y
 S DIR(0)="FAO^1:45"
 S DIR("A")=" Select File:  "
 S (DIR("?"),DIR("??"))="^D FIH^LEXXFI7" D ^DIR S X=$$FOT(Y)
 Q X
FIH ;   File Help
 W !,"     Select either a Lexicon, ICD or CPT file:"
 W !!,"                          Lexicon                  ICD       CPT"
 W !,"     ----------------------------------------       ----      ----"
 W !,"     757        757.03     757.12     757.31        80        81"
 W !,"     757.001    757.03     757.13     757.4         80.1      81.1"
 W !,"     757.01     757.05     757.14     757.41        80.3      81.2"
 W !,"     757.011    757.06     757.2                              81.3"
 W !,"     757.014    757.1      757.21"
 W !,"     757.02     757.11     757.3 "
 Q
FOT(X) ;   File Output Transform
 N LEX,LEXX
 S LEXX=$G(X) Q:'$L(X) "^"  D ARY(LEXX,.LEX)
 S:+($G(LEX(0)))=1 LEXX=$$ONE(X,.LEX)
 S:+($G(LEX(0)))>1 LEXX=$$MULT(X,.LEX)
 S X=$S(+LEXX>0:+LEXX,1:"^")
 Q X
ONE(X,LEX) ;   One Entry
 S X=+($G(LEX(1)))
 I $L($P($G(LEX(1)),"^",2)),+X>0 D
 . W "    ",$P($G(LEX(1)),"^",2)," (#",+X,")"
 Q:+X'>0 "^"  Q X
MULT(X,LEX) ;   Multiple Entries
 N LEXE,LEXEX,LEXFI,LEXI,LEXM,LEXMAX,LEXNAM,LEXS
 S LEXMAX=$G(LEX(0)) Q:+LEXMAX'>1  W ! W !," ",LEXMAX," matches found"
 S LEXS=0,LEXEX=0 F LEXI=1:1:LEXMAX Q:((LEXS>0)&(LEXS<LEXI+1))  Q:LEXEX  D  Q:LEXEX
 . S LEXE=$G(LEX(LEXI)),LEXNAM=$P(LEXE,"^",2),LEXFI=+LEXE Q:'$L(LEXNAM)  Q:+LEXFI'>0  S LEXM=LEXI
 . W:LEXI#5=1 ! W !," ",$J(LEXI,4),".  ",LEXNAM," (#",+LEXFI,")"
 . W:LEXI#5=0 ! S:LEXI#5=0 LEXS=$$SEL(LEXM,.LEX) S:LEXS["^" LEXEX=1
 I LEXI#5'=0,+LEXS=0 W ! S LEXS=$$SEL(LEXM,.LEX) S:LEXS["^" LEXEX=1
 S X="^" S:'LEXEX&(+LEXS>0) X=+LEXS S:+X'>0 X="^"
 Q X
SEL(X,LEX) ;     Select Multiple
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXM,Y S LEXM=+($G(X)) Q:LEXM=0 -1
 S:+($O(LEX(+($G(LEXI)))))>0 DIR("A")=" Select 1-"_LEXM_" or '^' to exit:  "
 S:+($O(LEX(+($G(LEXI)))))'>0 DIR("A")=" Select 1-"_LEXM_":  "
 S (DIR("?"),DIR("??"))="Answer must be from 1 to "_LEXM_", or <Return> to continue  "
 S DIR(0)="NAO^1:"_LEXM_":0" D ^DIR S X="" S:$D(DTOUT)!(X[U) X=U
 I $L($P($G(LEX(+Y)),"^",2)),+($G(LEX(+Y)))>0 D
 . W "    ",$P($G(LEX(+Y)),"^",2)," (#",+($G(LEX(+Y))),")"
 . S X=+($G(LEX(+Y)))
 Q X
ARY(X,LEX) ;   Build Array  of Files
 N LEXF,LEXNM,LEXO,LEXX,Y
 S LEXX=$TR($G(X),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") N X,Y
 Q:'$L(LEXX) ""  I +LEXX=LEXX D  Q
 . N LEXO,LEXN,LEXC S LEXO=LEXX-.00000001
 . F  S LEXO=$O(@("^DIC("_LEXO_")")) Q:+LEXO=0!($E(LEXO,1,$L(LEXX))'=LEXX)  D
 . . N LEXNM S LEXNM=$$FN^LEXXFI8(LEXO) Q:'$L(LEXNM)  S LEX(0)=($O(LEX(" "),-1)+1),LEX(+LEX(0))=+LEXO_"^"_LEXNM
 S LEXO=$E(LEXX,1,($L(LEXX)-1))_$C($A($E(LEXX,$L(LEXX)))-1)_"~"
 F  S LEXO=$O(@("^DIC(""B"","_LEXO_")")) Q:LEXO=""  Q:$E(LEXO,1,$L(LEXX))'[LEXX  D
 . S LEXF=0 F  S LEXF=$O(@("^DIC(""B"","_LEXO_","_LEXF_")")) Q:+LEXF'>0  D
 . . Q:+($$LEX^LEXXFI8(LEXF))'>0&(+($$IC^LEXXFI8(LEXF))'>0)  N LEXNM S LEXNM=$$FN^LEXXFI8(LEXF)
 . . Q:'$L(LEXNM)  S LEX(0)=($O(LEX(" "),-1)+1),LEX(+LEX(0))=+LEXF_"^"_LEXNM
 Q
 ;                          
 ; Miscellaneous
U(X) ;   UCI where Lexicon is installed
 N LEXU,LEXP,LEXT,Y X ^%ZOSF("UCI") S LEXU=Y,LEXP="" S:LEXU=^%ZOSF("PROD")!($P(LEXU,",",1)=^%ZOSF("PROD")) LEXP=" (Production)"
 S:LEXU'=^%ZOSF("PROD")&($P(LEXU,",",1)'=^%ZOSF("PROD")) LEXP=" (Test)" S X="",$P(X,"^",1)=LEXU,$P(X,"^",2)=LEXP
 Q X
A(X) ;   As of date/time
 N LEXX S LEXX=$$NOW^XLFDT,LEXX=$$FMTE^XLFDT(LEXX,"1")
 S:LEXX["@" LEXX=$P(LEXX,"@",1)_"  "_$P(LEXX,"@",2,299)
 S X=LEXX
 Q X
P(X) ;   Person
 N LEXDUZ,LEXPH,LEXNM
 S LEXDUZ=+($G(DUZ)),LEXNM=$$GET1^DIQ(200,+($G(LEXDUZ)),.01) Q:'$L(LEXNM) "UNKNOWN^"
 S LEXDUZ=+($G(DUZ)) S LEXPH=$$GET1^DIQ(200,+($G(LEXDUZ)),.132)
 S:LEXPH="" LEXPH=$$GET1^DIQ(200,+($G(LEXDUZ)),.133)
 S:LEXPH="" LEXPH=$$GET1^DIQ(200,+($G(LEXDUZ)),.134)
 S:LEXPH="" LEXPH=$$GET1^DIQ(200,+($G(LEXDUZ)),.135)
 S LEXDUZ=$$PM(LEXNM)
 S X=LEXDUZ_"^"_LEXPH
 Q X
PM(X) ;     Person, Mixed Case
 N LEXF,LEXL,LEXP S LEXP=$G(X),LEXL=$$MX($P(LEXP,",",1)),LEXF=$P(LEXP,",",2)
 S LEXL(1)=$$MX($P(LEXL,"-",1)),LEXL(2)=$$MX($P(LEXL(1)," ",2,2)),LEXL(1)=$$MX($P(LEXL(1)," ",1))
 S:$L(LEXL(1))&($L(LEXL(2))) LEXL(1)=LEXL(1)_" "_LEXL(2)
 S LEXL(3)=$$MX($P(LEXL,"-",2)),LEXL(4)=$$MX($P(LEXL(3)," ",2,2)),LEXL(3)=$$MX($P(LEXL(3)," ",1))
 S:$L(LEXL(3))&($L(LEXL(4))) LEXL(3)=LEXL(3)_" "_LEXL(4)
 S LEXL=LEXL(1) S:$L(LEXL(1))&($L(LEXL(3))) LEXL=LEXL(1)_"-"_LEXL(3)
 S LEXF=$$MX($P(LEXP,",",1)),LEXF=$P(LEXP,",",2)
 S LEXF(1)=$$MX($P(LEXF,"-",1)),LEXF(2)=$$MX($P(LEXF(1)," ",2,2)),LEXF(1)=$$MX($P(LEXF(1)," ",1))
 S:$L(LEXF(1))&($L(LEXF(2))) LEXF(1)=LEXF(1)_" "_LEXF(2)
 S LEXF(3)=$$MX($P(LEXF,"-",2)),LEXF(4)=$$MX($P(LEXF(3)," ",2,2)),LEXF(3)=$$MX($P(LEXF(3)," ",1))
 S:$L(LEXF(3))&($L(LEXF(4))) LEXF(3)=LEXF(3)_" "_LEXF(4)
 S LEXF=LEXF(1) S:$L(LEXF(1))&($L(LEXF(3))) LEXF=LEXF(1)_"-"_LEXF(3)
 S LEXP=LEXL_", "_LEXF,X=LEXP
 Q X
MX(X) ;     Mix Case
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
