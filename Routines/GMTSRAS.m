GMTSRAS ; SLC/JER,KER HIN/GJC - Radiology Profile       ; 04/19/2002
 ;;2.7;Health Summary;**14,25,28,37,47,51,84**;Oct 20, 1995;Build 6
 ;              
 ; External References
 ;   DBIA  3125  ^RADPT( file 70
 ;   DBIA  2056  $$GET1^DIQ (file 70)
 ;   DBIA 10011  ^DIWP
 ;                        
ENSRA ; Controls branching
 Q:+($G(DFN))=0  Q:+($G(DFN))'=+($$RP(+($G(DFN))))
 N GMDATA D MAIN^GMTSRAE(2) Q:'$D(^TMP("RAE",$J))
 D LOOP K ^TMP("RAE",$J) Q
LOOP ; Loops through ^TMP("RAE",$J,
 N GMW,GMTSORD,GMTSIDT,GMTSPN,GMLN,GMPSET,GMXSET S GMTSIDT=0
 F  S GMTSIDT=$O(^TMP("RAE",$J,GMTSIDT)) Q:GMTSIDT'>0  D  Q:$D(GMTSQIT)
 . S GMPSET=$S($D(^TMP("RAE",$J,GMTSIDT,"PRINTSET")):1,1:0)
 . S GMXSET=$S($D(^TMP("RAE",$J,GMTSIDT,"EXAMSET")):1,1:0)
 . S GMTSPN=0 F  S GMTSPN=$O(^TMP("RAE",$J,GMTSIDT,GMTSPN)) Q:GMTSPN'>0  D
 . . S GMTSORD=+($P($G(^TMP("RAE",$J,GMTSIDT,GMTSPN,0)),"^",10))
 . . D WRT D:+$O(^TMP("RAE",$J,GMTSIDT,GMTSPN)) BL Q:$D(GMTSQIT)
 . D:+$O(^TMP("RAE",$J,GMTSIDT)) BL Q:$D(GMTSQIT)
 Q
WRT ; Writes component data
 Q:$D(GMTSQIT)  N X,GMI,GMTMP S GMDATA=1,GMTMP=$G(^TMP("RAE",$J,GMTSIDT,GMTSPN,0))
 D CKP^GMTSUP Q:$D(GMTSQIT)
 D DAT,PRO D:'GMPSET SSET D:GMPSET PSET
 Q
 ;            
SSET ; Output for Non-Printsets (single exam) (GMPSET=0)
 ;               
 ;  Procedure Modifiers, Procedure Status, 
 ;  CPT Code, CPT Modifiers, Interpreting Staff,
 ;  Interpreting Resident, Report Status, 
 ;  Technologist, Report Text
 ;            
 D:$D(^TMP("RAE",$J,GMTSIDT,GMTSPN,"M")) PMD D CPT,CMD,INS,INR,CAS,EST,STT,RPT
 Q
PSET ; Output for Printsets (GMPSET=1)
 ;                
 ;  Procedure Modifiers, Procedure Status, 
 ;  CPT Code, CPT Modifier, Report Status, 
 ;  Technologist
 ;            
 D:$D(^TMP("RAE",$J,GMTSIDT,GMTSPN,"M")) PMD D CPT,CMD
 D:'+$O(^TMP("RAE",$J,GMTSIDT,GMTSPN)) LSET
 Q
LSET ; Last Set/Case in Printset
 ;            
 ;  Interpreting Staff, Interpreting Resident, Report Status, 
 ;  Technologist, Report Text
 ;            
 D BL,INS,INR,CAS,EST,STT N GMTSPN S GMTSPN=$O(^TMP("RAE",$J,GMTSIDT,0)) D:GMTSPN RPT
 Q
 ; Data Elements
DAT ;   Date                                  +1
 Q:'$L($G(GMTMP))  Q:+($G(GMTMP))=0  Q:'$D(GMXSET)  Q:'$D(GMTSPN)  Q:+($G(GMTSIDT))=0
 N X,GMTSDT S X=+GMTMP D REGDT4^GMTSU S GMTSDT=X
 D CKP^GMTSUP Q:$D(GMTSQIT)  W:+($G(GMXSET))=0 GMTSDT
 W:(+($G(GMXSET))>0)&(GMTSPN=$O(^TMP("RAE",$J,GMTSIDT,0))) GMTSDT
 Q
PRO ;   Procedure                              2
 Q:'$L($G(GMTMP))  N GMTSA,GMTSB S GMTSA=$P($G(GMTMP),"^",2)
 S:$L(GMTSA)>65 GMTSA=$$WRAP^GMTSORC(GMTSA,65)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?12,$P(GMTSA,"|"),!
 F GMTSB=2:1:$L(GMTSA,"|") D  Q:$D(GMTSQIT) 
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:$P(GMTSA,"|",GMTSB)]"" ?23,$P(GMTSA,"|",GMTSB),!
 Q
CAS ;   Case Number                            9
 Q:'$L($G(GMTMP))  N GMTSA S GMTSA=$P(GMTMP,"^",9) Q:GMTSA=""
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?12,"Exam Case Number:",?33,GMTSA,!
 Q
EST ;   Exam Status                            3
 Q:'$L($G(GMTMP))  N GMTSA S GMTSA=$P(GMTMP,"^",3) Q:GMTSA=""
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?12,"Exam Status:",?33,GMTSA,!
 Q
RST ;   Report Status                          4
 Q:'$L($G(GMTMP))  N GMTSA S GMTSA=$P(GMTMP,"^",4) Q:GMTSA=""
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?12,"Rpt Status:  ",GMTSA,!
 Q
INR ;   Interpreting Resident                  5
 Q:'$L($G(GMTMP))  N GMTSA S GMTSA=$P(GMTMP,"^",5) Q:GMTSA=""
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?12,"Interpreting Res.:",?33,GMTSA,!
 Q
INS ;   Interpreting Staff                     6
 Q:'$L($G(GMTMP))  N GMTSA S GMTSA=$P(GMTMP,"^",6) Q:GMTSA=""
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?12,"Interpreting Staff:",?33,GMTSA,!
 Q
CPT ;   CPT Code                               7
 Q:'$L($G(GMTMP))  N GMTSA S GMTSA=$P($G(GMTMP),"^",7)
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?12,"CPT Code:",?25,GMTSA,!
 Q
TEC ;   Technologist                           8
 Q:'$L($G(GMTMP))  N GMTSA S GMTSA=$P($G(GMTMP),"^",8) Q:GMTSA=""
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?12," Technologist: ",GMTSA,!
 Q
STT ;   Report Status/Technologist            4/8
 Q:'$L($G(GMTMP))  N GMTSA,GMTSB S GMTSA=$P(GMTMP,"^",4),GMTSB=$P(GMTMP,"^",8)
 Q:($G(GMTSA)_$G(GMTSB))=""  Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?12,"Rpt Status:  ",$E($G(GMTSA),1,18) W ?45," Technologist: ",$G(GMTSB),!
 Q
CMD ;   CPT Modifiers
 N GMTSCPTM
 S GMTSCPTM=+($$CPT^GMTSU(+($G(GMTSEGN)))) S:$G(GMPXCMOD)="N" GMTSCPTM=0
 Q:'GMTSCPTM  Q:'$L($G(GMTMP))  N GMTSC,GMTSCM,GMTSCT,GMTSI,GMTSCNT S (GMTSC,GMTSCNT)=0
 F  S GMTSC=$O(^TMP("RAE",$J,GMTSIDT,GMTSPN,"CM",GMTSC)) Q:+GMTSC=0  D
 . S GMTSCM=$P($G(^TMP("RAE",$J,GMTSIDT,GMTSPN,"CM",GMTSC)),"^",1) Q:'$L(GMTSCM)
 . S GMTSCT=$P($G(^TMP("RAE",$J,GMTSIDT,GMTSPN,"CM",GMTSC)),"^",3) Q:'$L(GMTSCT)
 . S GMTSCT=GMTSCM_" - "_GMTSCT
 . S GMTSCNT=GMTSCNT+1
 . S:$L(GMTSCT)>47 GMTSCT=$$WRAP^GMTSORC(GMTSCT,47)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:GMTSCNT=1 ?12,"CPT Modifier:" W ?28,$P(GMTSCT,"|"),!
 . F GMTSI=2:1:$L(GMTSCT,"|") D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W:$P(GMTSCT,"|",GMTSI)]"" ?33,$P(GMTSCT,"|",GMTSI),!
 Q
PMD ;   Procedure Modifiers
 Q:'$L($G(GMTMP))  D CKP^GMTSUP Q:$D(GMTSQIT)  W:+($O(^TMP("RAE",$J,GMTSIDT,GMTSPN,"M",0)))>0 ?12,"Procedure Modifier:"
 S GMI=0 F  S GMI=$O(^TMP("RAE",$J,GMTSIDT,GMTSPN,"M",GMI)) Q:+GMI'>0  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?33,^TMP("RAE",$J,GMTSIDT,GMTSPN,"M",GMI),!
 Q
 ;            
RPT ; Report Text
 N GMTSL F GMTSL="S","H","A","R","I","D" D TXT(GMTSL)
 Q
TXT(X) ;   Report Text Lines
 N GMTST S GMTST=$E($G(X),1) Q:(GMTST="")!("^S^H^A^R^I^D^"'[GMTST)!(GMTST="^")
 Q:GMTST="A"&(+($$PROK^GMTSU("RAUTL9",27))=0)
 Q:+($G(GMTSIDT))=0  Q:+($G(GMTSPN))=0  Q:'$D(^TMP("RAE",$J,GMTSIDT,GMTSPN,GMTST))
 K ^UTILITY($J,"W") N GMTSI,GMTSII,GMTSIND,DIWF,DIWL,DIWR S GMTSIND=12,DIWF="C"_(78-(GMTSIND+2)),DIWL=0,DIWR=0,GMTSI=0
 D:$O(^TMP("RAE",$J,GMTSIDT,GMTSPN,GMTST,0))>0 BL
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?GMTSIND,$S(GMTST="S":"Reason for Study: ",GMTST="H":"History: ",GMTST="A":"Additional History: ",GMTST="R":"Report: ",GMTST="I":"Impression: ",GMTST="D":"DX Codes: ",1:"Text:"),!
 I GMTST'="D" D
 . S GMTSI=0 F  S GMTSI=$O(^TMP("RAE",$J,GMTSIDT,GMTSPN,GMTST,GMTSI)) Q:GMTSI'>0  D  Q:$D(GMTSQIT)
 . . S X=$G(^TMP("RAE",$J,GMTSIDT,GMTSPN,GMTST,GMTSI)) D ^DIWP
 I GMTST="D" D
 . S GMTSI=0 F  S GMTSI=$O(^TMP("RAE",$J,GMTSIDT,GMTSPN,GMTST,GMTSI)) Q:GMTSI'>0  D  Q:$D(GMTSQIT)
 . . S X=$G(^TMP("RAE",$J,GMTSIDT,GMTSPN,GMTST,GMTSI)) S:$L(X)>(78-(GMTSIND+4)) X=$$WRAP^GMTSORC(X,(78-(GMTSIND+4)))
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?(GMTSIND+2),$P(X,"|",1),! F GMTSII=2:1:$L(X,"|") D  Q:$D(GMTSQIT) 
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)  W:$P(X,"|",GMTSII)]"" ?(GMTSIND+4),$P(X,"|",GMTSII),!
 I $D(^UTILITY($J,"W")) D
 . S GMTSI=0 F  S GMTSI=$O(^UTILITY($J,"W",0,GMTSI)) Q:+GMTSI=0  D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?(GMTSIND+2),$G(^UTILITY($J,"W",0,GMTSI,0)),!
 K ^UTILITY($J,"W")
 Q
BL ;   Report Blank Lines
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ! Q
 ;               
RP(X) ; Radiology Patient
 N Y S X=+($G(X)) S Y=$$GET1^DIQ(70,X,.01,"I") S X=Y Q X
