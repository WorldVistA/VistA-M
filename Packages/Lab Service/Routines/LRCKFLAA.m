LRCKFLAA ;DALOI/RWF/RLM-CHECK LOAD LIST & AUTO INSTRUMENT FILES (CONT);2/5/91 12:32
 ;;5.2;LAB SERVICE;**272**;Sep 27, 1994
 ; Reference to CHK^DIE supported by IA #2053
 ; Reference to $$FMTE^XLFDT supported by IA #10103
 ; Reference to ^VA(200 supported by IA #10060
 ;
 Q  ;Continuation of LRCKFLA
TRAY ; validation of RUN or TRAY NUMBER subfile data elements (Node 1).
 ; Several multiples are contained within this subfile:
 ;         RUN or TRAY NUMBER (multiple #68.21)
 ;         SEQUENCE or CUP NUMBER (multiple #68.22)
 ;         TESTS (multiple #68.222)
 ;         TEST or PANEL NUMBER (multiple #68.225)
 I LRWARN,$D(^LRO(68.2,DA,1,0))[0 D LABEL S @LRTMPGL@(DA,"68.2,2")=">>WARNING<< - Missing nodes at the RUN OR TRAY NUMBER subfile (Multiple #68.21)." Q
 S RUN=0 F  S RUN=$O(^LRO(68.2,DA,1,RUN)) Q:RUN<1  I $D(^(RUN,0))#2 S LA1=^(0) D TRAYV
 Q
TRAYV ;
 I $D(^VA(200,+$P(LA1,U,3),0))[0 D LABEL S @LRTMPGL@(DA,1,RUN,"68.21,3")=">>FATAL<< - Invalid TECH pointer to NEW PERSON file (#200) for entry "_RUN_" at RUN or TRAY NUMBER subfile."
 I $D(^LRO(68,+$P(LA1,U,4),0))[0 D LABEL S @LRTMPGL@(DA,1,RUN,"68.21,4")=">>FATAL<< - Invalid ACCESSION AREA pointer to ACCESSION file (#68) for entry "_RUN_" at RUN or TRAY NUMBER subfile."
 S Z="",X=$P($G(^LRO(68,+$P(LA1,U,4),0)),U) I $L(X) D CHK^DIE(68.21,4,"E",X,.Z) I Z=U D
 . D LABEL S @LRTMPGL@(DA,1,RUN,"68.21,4",1)=">>CRITICAL<< - The value '"_X_"' for field ACCESSION AREA in RUN or TRAY NUMBER subfile is not valid. Only accession areas identified as work areas are valid.  Entry: "_RUN
 S SEQ=0 F  S SEQ=$O(^LRO(68.2,DA,1,RUN,1,SEQ)) Q:SEQ<1  I $D(^(SEQ,0))#2 S LA1S=^(0) D SEQCUP
 Q
SEQCUP ; validation for data elements at SEQUENCE or CUP NUMBER, TESTS multiples at the RUN or TRAY NUMBER subfile
 I $D(^LRO(68,+$P(LA1S,U),0))[0 D LABEL D
  . S @LRTMPGL@(DA,1,RUN,SEQ,"68.22,.01")=">>FATAL<< - Invalid ACCESSION AREA pointer to ACCESSION file (#68) found in SEQUENCE or CUP NUMBER multiple of RUN or TRAY NUMBER subfile. Entry: "_RUN_" Subentry: "_SEQ
 S Z="",X=$P($G(^LRO(68,$P(LA1S,U),0)),U) I $L(X) D CHK^DIE(68.22,.01,"E",X,.Z) I Z=U D
 . D LABEL S @LRTMPGL@(DA,1,RUN,SEQ,"68.22,.01",1)=">>CRITICAL<< - The value '"_X_"' for field ACCESSION AREA in SEQUENCE or CUP NUMBER multiple of RUN or TRAY NUMBER subfile is not valid."
 . S @LRTMPGL@(DA,1,RUN,SEQ,"68.22,.01",2)="Only accession area identified as work areas are valid.  Entry: "_RUN_" Subentry: "_SEQ
 D CHK^DIE(68.22,3,"E",$P(LA1S,U,4),.Z) I Z=U D LABEL D
 . S @LRTMPGL@(DA,1,RUN,SEQ,"68.22,3")=">>FATAL<< - The value '"_$P(LA1S,U,4)_"' for field PROFILE in SEQUENCE or CUP NUMBER multiple of RUN or TRAY NUMBER subfile is not valid.  Entry: "_RUN_" Subentry: "_SEQ
 I $L($P(LA1S,U,5)),$D(^LAB(61,$P(LA1S,U,5),0))[0 D LABEL D
 . S @LRTMPGL@(DA,1,RUN,SEQ,"68.22,4")=">>FATAL<< - Invalid SPECIMEN pointer to TOPOGRAPHY FIELD file (#61) found in SEQUENCE or CUP NUMBER multiple of RUN or TRAY NUMBER subfile.  Entry: "_RUN_" Subentry: "_SEQ
 S TST=0 F  S TST=$O(^LRO(68.2,DA,1,RUN,1,SEQ,1,TST)) Q:TST<1  I $D(^(TST,0))#2 S LA1T=+^(0) I $D(^LAB(60,LA1T,0))[0 D LABEL D 
 . S @LRTMPGL@(DA,1,RUN,SEQ,TST,"68.222,.01")=">>FATAL<< - Invalid TEST pointer to LABORATORY TEST file (#60) found in TESTS multiple within the SEQUENCE or CUP NUMBER multiple of RUN or TRAY NUMBER subfile. Entry: "_RUN_" Subentry: "_SEQ
 Q
PROFILE ;  validation of PROFILE subfile data elements (node 10)
 ; Several multiples are contained within this subfile:
 ;        PROFILE (multiple #68.23)
 ;        TEST (multiple #68.24) 
 ;        TRAY # FOR CONTROL (multiple #68.25)
 ;        CONTROL (multiple #68.26)
 ;        CONTROLS TO BEGIN WORKLIST (multiple #68.28)
 ;        CONTROLS TO END WORKLIST (multiple #68.29)
 I LRWARN,$D(^LRO(68.2,DA,10,0))[0 D LABEL S @LRTMPGL@(DA,"68.2,50")=">>WARNING<<- PROFILE subfile NOT defined." Q
 S PROF=0,LRPROF="" F  S PROF=$O(^LRO(68.2,DA,10,PROF)) Q:PROF<1  D PROFILV
 Q
PROFILV ;
 I $D(^LRO(68.2,DA,10,PROF,0))[0 D LABEL S @LRTMPGL@(DA,10,PROF,"68.23,.01")=">>FATAL - Missing PROFILE subfile for entry "_PROF Q
 S:$D(^LRO(68.2,DA,10,PROF,0))#2 LA10="profile: "_^(0)
 I $D(^LRO(68,+$P(LA10,U,2),0))[0 D LABEL S @LRTMPGL@(DA,10,PROF,"68.23,2")=">>FATAL<< - Invalid ACCESSION AREA pointer to the ACCESSION file (#68) at the PROFILE subfile for entry "_PROF
 S X=$P($G(^LRO(68,+$P(LA10,U,2),0)),U),Z="" I $L(X) D CHK^DIE(68.23,2,"E",X,.Z) I Z=U D LABEL D
 . S @LRTMPGL@(DA,10,PROF,"68.23,2",1)=">>CRITICAL<< - The value '"_X_"' for field ACCESSION AREA in PROFILE subfile is not valid. Only accession areas identified as work areas are valid.  Entry: "_PROF
 S B=1,I=0 F  S I=$O(^LRO(68.2,DA,10,PROF,1,I)) Q:I<1  I $D(^(I,0))#2 D
 . S X=^(0),B=(B&$P(X,U,3)) I $D(^LAB(60,+X,0))[0 D LABEL S @LRTMPGL@(DA,10,PROF,I,"63.24,.01")=">>FATAL<< - Invalid TEST pointer to the LABORATORY TEST file (#60) at the TEST multiple of the PROFILE subfile.  Entry: "_PROF_"  Subentry: "_I
 I B D LABEL S @LRTMPGL@(DA,10,PROF,1,I,"68.24,2")=">>FATAL<< - At least one test of the panel must NOT be BUILD LABEL ONLY at the TEST multiple of the PROFILE subfile."
 I LRWARN,'$P(LA,U,3) S C1=$O(^LRO(68.2,DA,10,PROF,2,1)) I C1>0 D LABEL S @LRTMPGL@(DA,10,PROF,2,1,"68.23,3")=">>WARNING<< - A sequence/batch should NOT have a control TRAY "_C1_" defined. Entry: "_PROF
 F LR45=4,5 D
 . D SET45
 . S C=0 F  S C=$O(^LRO(68.2,DA,10,PROF,LR45,C)) Q:C'>0  I $D(^(C,0))#2 S X=+^(0) D CHKCTR
 Q
CHKCTR ; validation of data elements at the CONTROLS TO BEGIN WORKLIST, CONTROLS TO END WORKLIST multiples
 I $D(^LAB(62.3,X,0))[0 D LABEL S @LRTMPGL@(DA,10,PROF,LR45,C,LRFIELD)=">>FATAL<<  - Invalid CONTROLS TO "_LRLIT_" WORKLIST pointer to LAB CONTROL NAME file (#62.3).  Entry: "_PROF_"  Subentry: "_C Q
 S (B,J)=0 F  S J=$O(^LAB(62.3,X,2,J)) Q:J<1  I $D(^(J,0))#2 S T=+^(0) I $D(^LRO(68.2,DA,10,PROF,1,"B",T)) S B=1
 I 'B D LABEL S @LRTMPGL@(DA,10,PROF,LR45,C,LRFIELD)=">>FATAL<< - CONTROL: "_$P(^LAB(62.3,X,0),U)_" has no tests to accession for this profile for "_LRLIT_" WORKLIST.  Entry: "_PROF_" Subentry: "_C
 Q:'LRWARN
 S LREXPDT=+$P(^LAB(62.3,X,0),U,2)
 I 'LREXPDT D LABEL S @LRTMPGL@(DA,10,PROF,LR45,C,LRFIELD)=">>WARNING<< - CONTROL: "_$P(^LAB(62.3,X,0),U)_" does not have an EXPIRATION DATE for "_LRLIT_" WORKLIST.  Entry: "_PROF_" Subentry: "_C Q
 I LREXPDT<DT D LABEL S @LRTMPGL@(DA,10,PROF,LR45,C,LRFIELD)=">>WARNING<< - CONTROL: "_$P(^LAB(62.3,X,0),U)_" contains an expired EXPIRATION DATE: "_$$FMTE^XLFDT($P(^LAB(62.3,X,0),U,2),"")_" for "_LRLIT_" WORKLIST.  Entry: "_PROF_" Subentry: "_C
 Q
SUFFIX ; validation of "SUF" node data elements
 Q:'$D(^LRO(68.2,DA,"SUF"))
 S LASUF=^LRO(68.2,DA,"SUF")
 I $D(^LAB(64.2,+LASUF,0))[0 D LABEL S @LRTMPGL@(DA,"68.2,.14")=">>FATAL<< - Invalid WKLD METHOD pointer to WKLD SUFFIX CODES file (#64.2)"
 I $L($P(LASUF,U,7)),$D(^LRO(68,+$P(LASUF,U,7),0))[0 D LABEL S @LRTMPGL@(DA,"68.2,1")=">>FATAL<< - Invalid MAJOR ACCESSION AREA pointer to ACCESSION file (#68)"
 I $L($P(LASUF,U,8)),$D(^LRO(68,+$P(LASUF,U,8),0))[0 D LABEL S @LRTMPGL@(DA,"68.2,1.5")=">>FATAL<< - Invalid LAB SUBSECTION pointer to ACCESSION file (#68)"
 I $L($P(LASUF,U,9)) D
 . I $D(^LRO(68,$P(LASUF,U,9),0))[0 D LABEL S @LRTMPGL@(DA,"68.2,1.7")=">>FATAL<< - Invalid WORK AREA pointer to ACCESSION file (#68)" Q
 . I LRWARN S X=$P(^LRO(68,$P(LASUF,U,9),0),U),Z="" D CHK^DIE(68.2,1.7,"E",X,.Z) D
 . . I Z=U D LABEL S @LRTMPGL@(DA,"68.2,1.7")=">>CRITICAL<< - The value '"_X_"' for field WORK AREA is not valid.  Only accession areas identified as work areas are valid."
 Q
LABEL ;
 I LRDA'=DA S @LRTMPGL@(DA)=$P(LA,U) S LRDA=DA
 I $D(LA10),$P(LA10,U)'=LRPROF S (LRPROF,@LRTMPGL@(DA,10,PROF))=$P(LA10,U)
 Q
SET45 ;
 ; variable assignment during processing of controls to begin and end
 ; worklist data elements
 S LRFIELD=$S(LR45=4:"68.28,.01",1:"68.29,.01"),LRLIT=$S(LR45=4:"BEGIN",1:"END")
 Q
