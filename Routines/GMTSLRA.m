GMTSLRA ; SLC/JER,KER - Surgical Pathology Component ; 09/21/2001
 ;;2.7;Health Summary;**28,47**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA 10035  ^DPT( field 63 Read w/Fileman
 ;    DBIA  2056  $$GET1^DIQ (file 2)
 ;                       
MAIN ; Surgical Pathology
 N GMI,MAX,LRDFN,IX,X,SP,IX0
 S LRDFN=+($$GET1^DIQ(2,(+($G(DFN))_","),63,"I")) Q:+LRDFN=0
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:999) D ^GMTSLRAE
 I '$D(^TMP("LRA",$J)) Q
 S IX=0 F GMI=1:1:MAX S IX=$O(^TMP("LRA",$J,IX)) Q:$D(GMTSQIT)  Q:IX'>0  D  Q:$D(GMTSQIT)
 . D:GMI>1 CKP^GMTSUP Q:$D(GMTSQIT)  W:GMI>1&('GMTSNPG) ! D
 . . S IX0="" F  S IX0=$O(^TMP("LRA",$J,IX,IX0)) Q:IX0=""!(IX0?1A)  D
 . . . S X=^TMP("LRA",$J,IX,IX0)
 . . . S SP=$G(^TMP("LRA",$J,IX,"SPP")) D WRT
 . . I $D(^TMP("LRA",$J,IX,1.2)) D SUPPR
 K ^TMP("LRA",$J)
 Q
WRT ; Writes Surgical Pathology Record
 N IX1,GMJ
 I IX0=0 D  Q
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?8,"Collected:",?19,$P(X,U),?31,"Acc:",?36,$P(X,U,2),!
 . Q:'$L($G(SP))  D CKP^GMTSUP Q:$D(GMTSQIT)
 . W "Surgeon/Physician:",?19,$G(SP),!
 I IX0=.1 D WRTSPC Q
 I $S(IX0=.2:1,IX0=1:1,IX0=1.1:1,IX0=1.3:1,IX0=1.4:1,1:0) D TEXT Q
 I IX0=2 S IX1=0 F  S IX1=$O(^TMP("LRA",$J,IX,IX0,IX1)) Q:IX1'>0  S X=^(IX1) D WRTTM,WRTP
 Q
WRTSPC ; Writes Specimen field entries
 N GMS
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?9,"Specimen:"
 S GMS=0
 F  S GMS=$O(^TMP("LRA",$J,IX,.1,GMS)) Q:GMS'>0  D CKP^GMTSUP Q:$D(GMTSQIT)  W ?19,^TMP("LRA",$J,IX,.1,GMS),!
 Q
TEXT ; Handles GROSS DESCRIPTION & MICROSCOPIC EXAM/DX Print
 N LN,GMTSLN,GMTSLNI
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?(17-$L(X)),X_":",!
 S LN=0
 F  S LN=$O(^TMP("LRA",$J,IX,IX0,LN)) Q:LN'>0  S GMTSLN=^(LN) D
 .I $L(GMTSLN)>78 S GMTSLN=$$WRAP^GMTSORC(GMTSLN,78)
 .D CKP^GMTSUP Q:$D(GMTSQIT)  W $P(GMTSLN,"|"),! D
 ..F GMTSLNI=2:1:$L(GMTSLN,"|") D CKP^GMTSUP Q:$D(GMTSQIT)  W:$P(GMTSLN,"|",GMTSLNI)]"" $P(GMTSLN,"|",GMTSLNI),!
 Q
SUPPR ; Writes Supplementary Report
 N GMTSR,SRDATE,GMTSRL,GMTSRLI,X
 S IX1=0
 F  S IX1=$O(^TMP("LRA",$J,IX,1.2,IX1)) Q:IX1'>0  D CKP^GMTSUP Q:$D(GMTSQIT)  S SRDATE=^TMP("LRA",$J,IX,1.2,IX1,0) S X=SRDATE D REGDTM4^GMTSU W "Supplementary Rpt: ",X,! D
 .S GMTSR=0
 .F  S GMTSR=$O(^TMP("LRA",$J,IX,1.2,IX1,GMTSR)) Q:GMTSR'>0  S GMTSRL=^(GMTSR) D
 ..I $L(GMTSRL)>78 S GMTSRL=$$WRAP^GMTSORC(GMTSRL,78)
 ..W $P(GMTSRL,"|"),! D
 ...F GMTSRLI=2:1:$L(GMTSRL,"|") D CKP^GMTSUP Q:$D(GMTSQIT)  W:$P(GMTSRL,"|",GMTSRLI)]"" $P(GMTSRL,"|",GMTSRLI),!
 Q
WRTTM ; Writes Topography and Morphology
 N GMT,GMD,GME
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?7,"Topography:",?19,$P(X,U),!
 I $O(^TMP("LRA",$J,IX,IX0,IX1,1,0)) D CKP^GMTSUP Q:$D(GMTSQIT)
 S GMD=0
 F  S GMD=$O(^TMP("LRA",$J,IX,IX0,IX1,1,GMD)) Q:GMD'>0  W:GMD=1 ?9,"Disease:" W ?21,^TMP("LRA",$J,IX,IX0,IX1,1,GMD),! Q
 I $O(^TMP("LRA",$J,IX,IX0,IX1,2,0)) D CKP^GMTSUP Q:$D(GMTSQIT)
 S GMT=0
 F  S GMT=$O(^TMP("LRA",$J,IX,IX0,IX1,2,GMT)) Q:GMT'>0  D
 .I GMT'=4 D CKP^GMTSUP Q:$D(GMTSQIT)
 .I  W ?7,"Morphology:",?21,^TMP("LRA",$J,IX,IX0,IX1,2,GMT),! D  Q
 ..S GME=0
 ..F  S GME=$O(^TMP("LRA",$J,IX,IX0,IX1,2,GMT,1,GME)) Q:GME'>0  D
 ...D CKP^GMTSUP Q:$D(GMTSQIT)  W:GME=1 ?9,"Etiology:" W ?23,^TMP("LRA",$J,IX,IX0,IX1,2,GMT,1,GME),! Q
 Q
WRTP ; Writes Procedure field
 N GMQ,GMK
 I $O(^TMP("LRA",$J,IX,IX0,IX1,4,0)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?7,"Procedures:"
 S GMT=0
 F  S GMT=$O(^TMP("LRA",$J,IX,IX0,IX1,4,GMT)) Q:GMT'>0  D
 .S GMQ=$P(^TMP("LRA",$J,IX,IX0,IX1,4,GMT),U)
 .I $L(GMQ)>56 S GMQ=$$WRAP^GMTSORC(GMQ,56)
 .D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,$P(GMQ,"|"),! D
 ..F GMK=2:1:$L(GMQ,"|") D CKP^GMTSUP Q:$D(GMTSQIT)  W:$P(GMQ,"|",GMK)]"" ?23,$P(GMQ,"|",GMK),!
 Q
