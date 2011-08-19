GMTSPLST ; SLC/JER,KER - Problem List ; 04/15/2002
 ;;2.7;Health Summary;**28,35,52**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10011  ^DIWP
 ;   DBIA  1183  GETLIST^GMPLHS
 ;   DBIA  1573  $$DSMONE^LEXU
 ;                  
 ; Variable NEWed/KILLed Elsewhere
 ;    DFN, GMPXICDF, GMPXNARR, GMTSNPG, GMTSQIT
 ;                  
ACTIVE ; Get Active Problems
 N STATUS S STATUS="A" D MAIN Q
INACT ; Get Inactive Problems
 N STATUS S STATUS="I" D MAIN Q
ALL ; Get All Problems (Active and Inactive)
 N STATUS S STATUS="ALL" D MAIN Q
MAIN ; Driver
 D GETLIST^GMPLHS(DFN,STATUS) Q:'$D(^TMP("GMPLHS",$J))  D SUBHDR D WRT K ^TMP("GMPLHS",$J) Q
 ;                  
WRT ;   Writes Problem List Component,X
 ;                  
 ;     ^TMP("GMPLHS",$J,#,0)=
 ;         Piece 1:  Diagnosis
 ;               2:  Date Last Modified
 ;               3:  Site
 ;               4:  Date Entered
 ;               5:  Status
 ;               6:  Date of Onset
 ;               7:  Responsible Provider
 ;               8:  Service
 ;               9:  Service Abbreviation
 ;              10:  Date Resolved
 ;              11:  Clinic
 ;              12:  Date Recorded
 ;              13:  Problem - Lexicon Term
 ;              14:  Exposure Combined String
 ;                  
 ;     ^TMP("GMPLHS",$J,#,"L")           Lexicon Term
 ;     ^TMP("GMPLHS",$J,#,"N")           Provider Narrative
 ;     ^TMP("GMPLHS",$J,#,"C",LOC,#,0))  Comments
 ;                      
 N GMREC,GMTSICL,GMTAB,LINE1,DIWL
 S GMTSICL=32,DIWL=0,GMTAB=0,GMREC=0
 F  S GMREC=$O(^TMP("GMPLHS",$J,GMREC)) Q:GMREC'>0  D  Q:$D(GMTSQIT)
 . N GMNODE,GMDIAG,GMDIAC,GMDIAT,GMDIAS,LASTMDT,STAT,ONSETDT,PROV,SERV
 . N RESDT,NARR,GMICD,GMDSM,GMDSMS,CODE,LEXI,LEX,PLIFN,ADDINFO,EXP,GMTSX,X
 . S GMNODE=$G(^TMP("GMPLHS",$J,GMREC,0))
 . Q:GMNODE']""
 . S GMDIAG=$P(GMNODE,U),LASTMDT=$P(GMNODE,U,2),STAT=$P(GMNODE,U,5)
 . S X=LASTMDT D REGDT4^GMTSU S LASTMDT=X
 . S ONSETDT=$P(GMNODE,U,6),PROV=$P(GMNODE,U,7)
 . S RESDT=$P(GMNODE,U,10),GMICD=""
 . S EXP=$P(GMNODE,U,14) S:$L(EXP) EXP=" ("_EXP_")"
 . I STAT="A",+ONSETDT S X=ONSETDT D REGDT4^GMTSU S ADDINFO="Onset "_X
 . I STAT="I",+RESDT S X=RESDT D REGDT4^GMTSU S ADDINFO="Resolved "_X
 . S NARR=""
 . S:$G(GMPXNARR)'="N" NARR=$G(^TMP("GMPLHS",$J,GMREC,"N"))
 . I $G(GMPXICDF)]"",$G(GMPXICDF)'="N",GMDIAG]"" D
 . . D GETICDDX^GMTSPXU1(.GMDIAG,$G(GMPXICDF)) S GMICD=GMDIAG
 . S GMDIAC=$P($G(GMICD),"-",1),GMDIAT=$P($G(GMICD),"-",2,299)
 . S LEX=$G(^TMP("GMPLHS",$J,GMREC,"L"))
 . S LEXI=+LEX,LEX=$P(LEX,"^",2) S:$$UP(LEX)["UNRESOLVED"!(+LEXI'>1) (LEXI,LEX)=""
 . S (CODE,GMDIAS,GMDSMS,GMDSM)="" S:+LEXI>0 GMDSM=$$DSMONE^LEXU(+LEXI)
 . S:GMDIAC["799.9" GMDSM=""
 . S:$L(GMDSM)>2&(GMDSM'[".") GMDSM=GMDSM_"."
 . S:$L(GMDIAC) GMDIAS="(ICD "_GMDIAC_")"
 . S:$L(GMDSM) GMDSMS="(DSM "_GMDSM_")"
 . S:$L(GMDIAC)&($L(GMDSM))&(GMDIAC=GMDSM) GMDIAS="(ICD/DSM "_GMDIAC_")",GMDSMS=""
 . S:$L(GMDIAS) CODE=GMDIAS S:$L(GMDSMS) CODE=CODE_" "_GMDSMS F  Q:$E(CODE,1)'=" "  S CODE=$E(CODE,2,$L(CODE))
 . S:$L(LEX)&($L(CODE)) LEX=LEX_" "_CODE
 . S:$L(GMDIAT)&($L(CODE)) GMICD=GMDIAT_" "_CODE
 . ; Unresolved or Unspecified
 . I GMDIAC["799.9",$L($G(NARR)) D
 . . N UNARR S UNARR=$$UP(NARR)
 . . I UNARR["UNKNOWN AND UNSPECIFIED"!(UNARR["UNKNOWN OR UNSPECIFIED")!(UNARR["MORBIDITY OR MORTALITY") D  Q
 . . . S GMICD=GMDIAT_" "_CODE,NARR=""
 . . S GMICD=$$UP($E(NARR,1))_$E(NARR,2,$L(NARR))_" "_CODE
 . . S:$L(LEX) GMICD=LEX S NARR=""
 . ; Specified by Lexicon
 . I GMDIAC'["799.9",$L($G(LEX)) D
 . . S GMICD=LEX,NARR=""
 . ; Specified by Provider Narrative
 . I GMDIAC'["799.9",'$L($G(LEX)) D
 . . S:$L(NARR)&($$UP(GMDIAT)'=$$UP(NARR)) GMICD=GMICD_"; "_NARR S NARR=""
 . S:$G(IOST)["P-"&(EXP["MST") EXT=$$RM(EXP)
 . S:$L(GMICD)&($L(EXP)) GMICD=GMICD_EXP
 . S:$L(GMICD) GMICD=GMICD_$S($G(ADDINFO)]"":", "_ADDINFO,1:""),NARR=""
 . S GMICD=$$RF(GMICD)
 . D TXTFMT^GMTSPXU1(GMICD,$G(NARR),GMTSICL,GMTAB,DIWL)
 . I '$D(^UTILITY($J,"W")) Q
 . S GMTSX=0,LINE1=1
 . F  S GMTSX=$O(^UTILITY($J,"W",DIWL,GMTSX)) Q:GMTSX'>0!$D(GMTSQIT)  D
 . . D:LINE1 L1 D:'LINE1 LN S LINE1=0
 . D DC
 . D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG SUBHDR2 W !
 Q
L1 ;     Line #1 Problem, date, provider
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG SUBHDR2 W:STATUS="ALL" STAT W ?3,$G(^UTILITY($J,"W",DIWL,GMTSX,0)),?53,LASTMDT,?65,$E(PROV,1,15),! Q
LN ;     Line >1 Problem (other)
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG SUBHDR2 W ?3,$G(^UTILITY($J,"W",DIWL,GMTSX,0)),! Q
 ;                    
DC ; Comments are displayed if there are any
 N LOC,GMR,NODE,DATE,X,UCNT,CNT,CMT,T,I S LOC="",CNT=0
 F  S LOC=$O(^TMP("GMPLHS",$J,GMREC,"C",LOC)) Q:LOC']""  D  Q:$D(GMTSQIT)
 . S (CNT,UCNT)=0 S:+($O(^TMP("GMPLHS",$J,GMREC,"C",LOC," "),-1))>1 UCNT=1
 . S GMR=0 F  S GMR=$O(^TMP("GMPLHS",$J,GMREC,"C",LOC,GMR)) Q:+GMR'>0  D  Q:$D(GMTSQIT)
 . . S NODE=$G(^TMP("GMPLHS",$J,GMREC,"C",LOC,GMR,0)) Q:NODE']""
 . . S CMT=$P(NODE,U) I $L($G(CMT)) D LC
 Q
LC ;   List Comments (unnumbered and numbered)
 S CNT=CNT+1 K ^UTILITY($J,"W") D:UCNT CF(CNT,CMT) D:'UCNT CF(0,CMT)
 I $D(^UTILITY($J,"W",0)) N I,T S I=0 F  S I=$O(^UTILITY($J,"W",0,I)) Q:+I=0  D
 . S T=$$RT($G(^UTILITY($J,"W",0,I,0))) Q:'$L(T)  D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG SUBHDR2 W:I=1 ?3 W:I>1 ?7 W $G(T),!
 Q
CF(GMC,GMT) ;   Formats GMC (count) and GMT (text) together
 S GMC=+($G(GMC)),GMT=$G(GMT) Q:'$L(GMT)  S GMT=$$LD(GMT)
 N GMCOL,DIWL,DIWR,DIWF,X S GMCOL=34,DIWL=0,DIWR=80-(GMCOL) K ^UTILITY($J,"W")
 S:+($G(GMC))=0 X="    "_GMT S:+($G(GMC))>0 X=$J(GMC,2)_". "_GMT D:$G(X)]"" ^DIWP
 Q
 ;                
SUBHDR ; Subheader for Problem List Component
 N NUM,TOT,NODE S NODE=$G(^TMP("GMPLHS",$J,STATUS,0)) S NUM=$P(NODE,U),TOT=$P(NODE,U,2)
 D CKP^GMTSUP Q:$D(GMTSQIT)  S:TOT>NUM NUM=NUM_" of "_TOT W ?50,NUM_$S(STATUS="A":" Active",STATUS="I":" Inactive",1:"")_" Problems",!
SUBHDR2 ; Will be written on new pages
 D CKP^GMTSUP Q:$D(GMTSQIT)  W:STATUS="ALL" "ST" W ?3,"PROBLEM",?53,"LAST MOD",?65,"PROVIDER",! Q
 ;                
RM(X) ; Remove MST
 S X=$G(X) F  Q:X'["MST"  S X=$P(X,"MST",1)_$P(X,"MST",2)
 F  Q:X'["//"  S X=$P(X,"//",1)_"/"_$P(X,"//",2)
 F  Q:$E(X,$L(X))'="/"  S X=$E(X,1,($L(X)-1))
 F  Q:$E(X,1)'="/"  S X=$E(X,2,$L(X))
 Q X
RF(X) ; Remove Leading Spaces/Punctuation
 F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,1)'=";"  S X=$E(X,2,$L(X))
 F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 S X=$$LD(X) Q X
LD(X) ; Uppercase Leading Character
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(X,2,$L(X))
RT(X) ; Right Trim Spaces
 S X=$G(X) F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
UP(X) ; Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
