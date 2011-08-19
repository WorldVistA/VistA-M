LEXAR6 ; ISL Look-up Response (Unresolved Narr)   ; 05/25/1998
 ;;2.0;LEXICON UTILITY;**3,9,11**;Sep 23, 1996
 ;
 Q
 ;  This routines saves Unresolved Narratives (terms not found
 ;  in the Lexicon) in file 757.06.  It also saves comments about
 ;  a term.  Both the Unresolved Narratives and comments are used
 ;  as a tool to update the Lexicon Utility.
 ;
SAVE ; Save Unresolved Narrative
 G:'$L($G(^TMP("LEXSCH",$J,"NAR",0))) SAVEQ
 N Y,DIC,DO,D0,DA,ZTQUEUED,ZTREQ,ZTSAVE,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,%
 N LEXUNR S LEXUNR=$$UNR($G(^TMP("LEXSCH",$J,"NAR",0))) G:LEXUNR>0 SAVEQ
 S ZTSAVE("^TMP(""LEXSCH"",$J,")="",ZTRTN="SV^LEXAR6",ZTDESC="Saving Unresolved Narrative",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD,HOME^%ZIS K ZTSAVE,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN
 D:+($G(^TMP("LEXSCH",$J,"NUM",0)))>0 SET^LEXAR4(1)
 G SAVEQ
COM(LEXX) ; Save a comment as a Unresolved Narative
 D:+($G(LEX))'=0 KSCH^LEXAR K:+($G(LEX))=0 LEX N Y,DIC,DO,D0,DA,LEXCMT,LEXOK,LEXDUP,%,%X,%Y S LEXCMT=$G(LEXX)
 ; Internal Entry Number
 S ^TMP("LEXSCH",$J,"IEN",0)=+($P(LEXX,"^",1)) G:+($G(^TMP("LEXSCH",$J,"IEN",0)))=0 COMQ G:'$D(^LEX(757.01,+($G(^TMP("LEXSCH",$J,"IEN",0))),0)) COMQ
 ; Expression
 S ^TMP("LEXSCH",$J,"EXP",0)=$G(^LEX(757.01,+($G(^TMP("LEXSCH",$J,"IEN",0))),0)) G:'$L(^TMP("LEXSCH",$J,"EXP",0)) COMQ
 ; Duplicate Comment
 S LEXDUP=$$DUP($$UP^XLFSTR($G(^TMP("LEXSCH",$J,"EXP",0)))),LEXOK=$$OK(LEXCMT) G:'LEXOK COMQ
 ; Comment
 S ^TMP("LEXSCH",$J,"COM",0)=$P(LEXX,"^",2) G:'$L(^TMP("LEXSCH",$J,"COM",0)) COMQ
 K LEXCMT,LEXDUP,LEXOK S ZTSAVE("^TMP(""LEXSCH"",$J,")="",ZTRTN="SV^LEXAR6",ZTDESC="Saving Unresolved Narrative Comment",ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS
COMQ ; End of Comment
 K Y,ZTSAVE,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN
 ;
SAVEQ ; End of Save
 ;
 ; End Dialog with the Application (Unresolved Narrative)
 ;    Kill LEX, ^TMP("LEXFND",$J), ^TMP("LEXHIT",$J), ^TMP("LEXSCH",$J)
 I +($G(LEX))'=0 D EDA^LEXAR
 ;
 ; End Dialog with the User
 ;    Set LEX("NAR"), LEX("EXM") and LEX=0
 ;    Kill ^TMP("LEXFND",$J), ^TMP("LEXHIT",$J)
 ;    Kill LEX("LIST"),LEX("MAT"),LEX("MIN"),LEX("MAX")
 I +($G(LEX))=0 D EDU^LEXAR
 ;
 ; End Dialog with the Application (Comment)
 I $D(^TMP("LEXSCH",$J,"COM")) K ^TMP("LEXSCH",$J,"COM"),^TMP("LEXSCH",$J,"EXP"),^TMP("LEXSCH",$J,"IEN") K:+($G(LEX))=0 LEX
 Q
SV ; Save an unresolved narrative (tasked) in file 757.06
 N X,Y,DA,DD,DO,D0,DIC,DLAYGO,DI,DIE,DIK,DQ,DR,LEXADD,LEXNAR,LEXDTG,LEXSCH,LEXNUM,LEXAPP,LEXCOM,LEXIEN,LEXSVC,LEXLOC,LEXFLN,LEXIDX,LEXSCT,LEXFIL
 S LEXDTG=$$DTG,LEXADD=0
 I '$D(^TMP("LEXSCH",$J,"COM",0)) D
 . S LEXNAR=$$NAR,LEXSCH=$$SCH,LEXNUM=$$NUM,LEXAPP=$$APP,LEXSVC=$$SVC
 . S LEXLOC=$$LOC,LEXFLN=$$FLN,LEXIDX=$$IDX,LEXSCT=$$SCT,LEXFIL=$$FIL
 . S (DR,DIC("DR"))=".01////^S X=LEXNAR;1////^S X=LEXDTG;2////^S X=LEXSCH;3////^S X=LEXNUM;4////^S X=LEXAPP;5////^S X=LEXSVC;6////^S X=LEXLOC;7////^S X=LEXFLN;8////^S X=LEXIDX;9////^S X=LEXSCT;10////^S X=LEXFIL"
 I $D(^TMP("LEXSCH",$J,"COM",0)) D
 . S (X,LEXNAR)=$$EXP,LEXIEN=$$IEN,LEXCOM=$$CMT S:'$L(LEXCOM)!(+LEXIEN=0) LEXNAR=""
 . S (DR,DIC("DR"))=".01///^S X=LEXNAR;1///^S X=LEXDTG;11////^S X=LEXIEN;12///^S X=LEXCOM"
 I $L($G(LEXNAR)) D
 . N X,DIC K DD,DO S DIC="^LEX(757.06,",DIC(0)="L",DLAYGO=757.06,X=LEXNAR
 . D FILE^DICN S LEXADD=+($P($G(Y),"^",3)) D:LEXADD ED,SF D:'LEXADD KF K DLAYGO
 S:$D(ZTQUEUED) ZTREQ="@" K:+($G(LEX))'=0 ^TMP("LEXSCH",$J) G:'LEXADD SVQ
 D:+($$TOT)>49 SEND^LEXAR7
SVQ ; End of Narrative Save
 Q
ED ; Edit fields  PCH 11
 S DR=$G(DR),DIE="^LEX(757.06,",DA=+($G(Y)) Q:+DA'>0  Q:'$L(DR)  D ^DIE
 Q
DTG(LEXX) ; FM Day-Time-Group
 N %,%H,%I D NOW^%DTC S LEXX=% Q LEXX
NAR(LEXX) ; Narrative (provided by user)
 S LEXX=$TR($$UP^XLFSTR($E($G(^TMP("LEXSCH",$J,"NAR",0)),1,99)),";"," ") S:$L(LEXX)'>0 LEXX="UNKNOWN" Q LEXX
EXP(LEXX) ; Narrative (provided by user)
 S LEXX=$TR($$UP^XLFSTR($E($G(^TMP("LEXSCH",$J,"EXP",0)),1,99)),";"," ") S:$L(LEXX)'>0 LEXX="UNKNOWN" Q LEXX
SCH(LEXX) ; String searched for (provided by LEX)
 S LEXX=$$UP^XLFSTR($E($G(^TMP("LEXSCH",$J,"SCH",0)),1,100)) S:'$L(LEXX) LEXX="UNKNOWN" Q LEXX
NUM(LEXX) ; Number of terms found in search
 Q +($G(^TMP("LEXSCH",$J,"NUM",0)))
APP(LEXX) ; Application conducting the search
 S LEXX=$$UP^XLFSTR($E($G(^TMP("LEXSCH",$J,"APP",1)),1,63)) S:'$L(LEXX) LEXX="UNKNOWN" Q LEXX
IEN(LEXX) ; Internal Entry Number of term found (Comments only)
 Q +($G(^TMP("LEXSCH",$J,"IEN",0)))
SVC(LEXX) ; User's Service
 S LEXX=$$UP^XLFSTR($E($G(^TMP("LEXSCH",$J,"SVC",0)),1,63)) S:'$L(LEXX) LEXX="UNKNOWN" Q LEXX
LOC(LEXX) ; User's Hospital Location
 S LEXX=$$UP^XLFSTR($E($G(^TMP("LEXSCH",$J,"LOC",0)),1,63)) S:'$L(LEXX) LEXX="UNKNOWN" Q LEXX
FLN(LEXX) ; File number where search was conducted
 S LEXX=$E($G(^TMP("LEXSCH",$J,"FLN",0)),1,7) S:'$L(LEXX)!($E(LEXX,1,3)'="757") LEXX="UNKNOWN" Q LEXX
IDX(LEXX) ; Index used during the search
 S LEXX=$E($$UP^XLFSTR($G(^TMP("LEXSCH",$J,"IDX",0))),1,8) S:'$L(LEXX) LEXX="UNKNONWN" Q LEXX
SCT(LEXX) ; Shortcuts used during the search
 S LEXX=$$UP^XLFSTR($E($G(^TMP("LEXSCH",$J,"SCT",1)),1,63)) S:'$L(LEXX) LEXX="NONE" Q LEXX
FIL(LEXX) ; Filter used during the search - DIC("S")
 N X S X=$G(^TMP("LEXSCH",$J,"FIL",0)) D ^DIM S:$L($G(X))>244 X="" S LEXX=$G(X) Q LEXX
CMT(LEXX) ; Comment
 S LEXX=$$UP^XLFSTR($E($G(^TMP("LEXSCH",$J,"COM",0)),1,199)) Q LEXX
TOT(LEXX) ; Total # of narratives to send
 N DA S (DA,LEXX)=0 D SF,KF F  S DA=$O(^LEX(757.06,DA)) Q:+DA=0  K:'$D(^LEX(757.06,DA,0)) ^LEX(757.06,DA,99) S:+($G(^LEX(757.06,DA,99)))>0 LEXX=LEXX+1
 Q LEXX
SF ; Set Send flag
 N DA S DA=0 F  S DA=$O(^LEX(757.06,DA)) Q:+DA=0  S:$D(^LEX(757.06,DA,0)) ^LEX(757.06,DA,99)=1
 Q
KF ; Kill Send flag
 N DA S DA=0 F  S DA=$O(^LEX(757.06,DA)) Q:+DA=0  K:'$D(^LEX(757.06,DA,0)) ^LEX(757.06,DA,99)
 Q
UNR(LEXX) ; Is the narrative in file 757.06
 S LEXX=$G(LEXX) Q:LEXX="" 0
 N LEXIN,DA S LEXIN=0,DA=0 F  S DA=$O(^LEX(757.06,"B",$E(LEXX,1,30),DA)) Q:+DA=0  S:$P($G(^LEX(757.06,+DA,0)),"^",1)=LEXX LEXIN=1
 S LEXX=LEXIN Q LEXX
DUP(LEXX) ; Is the comment narrative a duplicate 
 S LEXX=$G(LEXX) Q:LEXX="" 0
 N LEXIN,DA S LEXIN=0,DA=0
 F  S DA=$O(^LEX(757.06,"B",$E(LEXX,1,30),DA)) Q:+DA=0  D
 . S:$E($P($G(^LEX(757.06,+DA,0)),"^",1),1,$L(LEXX))=LEXX LEXIN=LEXIN+1
 S LEXX=LEXIN Q LEXX
OK(LEXX) ; Ok to process
 S LEXX=$G(LEXX) N LEXI,LEXN,LEXC,LEXOK S LEXOK=1,LEXC=$E($$UP^XLFSTR($G(^TMP("LEXSCH",$J,"EXP",0))),1,30)
 S LEXN=$E(LEXC,1,($L(LEXC)-1))_$C($A($E(LEXC,$L(LEXC)))-1)_"~"
 F  S LEXN=$O(^LEX(757.06,"B",LEXN)) Q:LEXN=""!($E(LEXN,1,$L(LEXC))'=LEXC)  D
 . S LEXI=0 F  S LEXI=$O(^LEX(757.06,"B",LEXN,LEXI)) Q:+LEXI=0  D
 . . S:$G(^LEX(757.06,LEXI,4))=LEXX LEXOK=0
 S LEXX=LEXOK Q LEXX
