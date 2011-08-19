GMTSLRAE ; SLC/JER,KER - Surgical Pathology Extract ; 09/21/2001
 ;;2.7;Health Summary;**3,28,47**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA   525  ^LR( all fields
 ;    DBIA 10060  ^VA(200, field .01 Read w/Fileman
 ;    DBIA  2056  $$GET1^DIQ (file #200)
 ;    DBIA 10015  EN^DIQ1 (file 63)
 ;    DBIA 10011  ^DIWP
 ;                      
XTRCT ; Extract Surgical Pathology
 N IX0,IX,DIWF,DIWL,DIWR K ^TMP("LRA",$J)
 S IX=GMTS1 F IX0=1:0:MAX S IX=$O(^LR(LRDFN,"SP",IX)) Q:IX'>0!(IX>GMTS2)  D APSET
 K AP
 Q
APSET ; Sets ^TMP("LRA",$J
 N ACC,CDT,DA,DIC,DIQ,DR,GMW,SN,X,YR,SPP
 S CDT=$P(^LR(LRDFN,"SP",IX,0),U),SPP=$P(^LR(LRDFN,"SP",IX,0),U,7),SPP=$$GET1^DIQ(200,(+SPP_","),.01),ACC=$P(^LR(LRDFN,"SP",IX,0),U,6)
 I $S(+$P(^LR(LRDFN,"SP",IX,0),U)'>0:1,+$P(^(0),U,11)'>0:1,1:0) Q
 I $D(ACC) S IX0=IX0+1
 S X=CDT D REGDTM4^GMTSU S CDT=X K X
 S ^TMP("LRA",$J,IX,0)=CDT_U_ACC
 S:$L($G(SPP)) ^TMP("LRA",$J,IX,"SPP")=$G(SPP)
 I $D(^LR(LRDFN,"SP",IX,.1)) S ^TMP("LRA",$J,IX,.1)="Site/Specimen"
 S SN=0 F  S SN=$O(^LR(LRDFN,"SP",IX,.1,SN)) Q:SN'>0  S ^TMP("LRA",$J,IX,.1,SN)=$P(^LR(LRDFN,"SP",IX,.1,SN,0),U)
 I $D(^LR(LRDFN,"SP",IX,.2,0)),($P(^(0),U,3)]"") D CLHX
 I $D(^LR(LRDFN,"SP",IX,1,0)),($P(^(0),U,3)]"") D GROSS
 I $D(^LR(LRDFN,"SP",IX,1.1,0)),($P(^(0),U,3)]"") D MIC
 I $D(^LR(LRDFN,"SP",IX,1.2,0)),($P(^(0),U,3)]"") D SUPPR
 I $D(^LR(LRDFN,"SP",IX,1.3,0)),($P(^(0),U,3)]"") D FROZ
 I $D(^LR(LRDFN,"SP",IX,1.4,0)),($P(^(0),U,3)]"") D SPDX
 Q
MPD ; Morphology, Procedure data and Disease data (not used)
 S DIC=63,DIQ="AP",DIQ(0)="E",DR(63.08)=10,DR(63.12)=".01;1.5;3;4"
 S DR(63.16)=".01;1",DR(63.82)=.01,DR(63.17)=.01
 S DA(63.12)=0,DA(63.08)=IX
 F  S DA(63.12)=$O(^LR(LRDFN,"SP",IX,2,DA(63.12))) Q:DA(63.12)=""  D M,P,D
 Q
M ; Morphology data
 N AP S DR=8,DA=LRDFN D EN^DIQ1 I $D(AP(63.12)) S ^TMP("LRA",$J,IX,2)="Topography Data",^(2,DA(63.12))=$S($D(AP(63.12,DA(63.12),.01,"E")):AP(63.12,DA(63.12),.01,"E"),1:"")
 S DA(63.16)=0 F  S DA(63.16)=$O(^LR(LRDFN,"SP",IX,2,DA(63.12),2,DA(63.16))) Q:DA(63.16)=""  D EN^DIQ1 I $D(AP(63.16)) D MSET
 K DA(63.16)
 Q
MSET ; Save Morphology data
 S ^TMP("LRA",$J,IX,2,DA(63.12),2,DA(63.16))=$S($D(AP(63.16,DA(63.16),.01,"E")):AP(63.16,DA(63.16),.01,"E"),1:"") D
 . S DA(63.17)=0 F  S DA(63.17)=$O(^LR(LRDFN,"SP",IX,2,DA(63.12),2,DA(63.16),1,DA(63.17))) Q:DA(63.17)=""  D EN^DIQ1 I $D(AP(63.17)) D
 . . S ^TMP("LRA",$J,IX,2,DA(63.12),2,DA(63.16),1,DA(63.17))=$S($D(AP(63.17,DA(63.17),.01,"E")):AP(63.17,DA(63.17),.01,"E"),1:"")
 K DA(63.17)
 Q
D ; Disease data
 S DA(63.15)=0 F  S DA(63.15)=$O(^LR(LRDFN,"SP",IX,2,DA(63.12),1,DA(63.15))) Q:DA(63.15)=""  D EN^DIQ1 I $D(AP(63.15)) D
 .S ^TMP("LRA",$J,IX,2,DA(63.12),1,DA(63.15))=$S($D(AP(63.15,DA(63.15),.01,"E")):AP(63.15,DA(63.15),.01,"E"),1:"")
 K DA(63.15)
 Q
P ; Procedure data
 N AP
 S DA(63.82)=0
 S DA(63.82)=0 F  S DR=8,DA=LRDFN,DA(63.82)=$O(^LR(LRDFN,"SP",IX,2,DA(63.12),4,DA(63.82))) Q:DA(63.82)=""  D EN^DIQ1 I $D(AP(63.82)) D PSET
 K DA(63.82)
 Q
PSET ; Save Procedure data
 S ^TMP("LRA",$J,IX,4)="Procedure Field"
 S ^TMP("LRA",$J,IX,2,DA(63.12),4,DA(63.82))=$S($D(AP(63.82,DA(63.82),.01,"E")):AP(63.82,DA(63.82),.01,"E"),1:"")
 Q
CLHX ; Brief Clinical History text
 N LN
 S ^TMP("LRA",$J,IX,.2)="Brief Clinical Hx"
 K ^UTILITY($J,"W") S LN=0 F  S LN=$O(^LR(LRDFN,"SP",IX,.2,LN)) Q:LN'>0  S X=^LR(LRDFN,"SP",IX,.2,LN,0) D FORMAT
 I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LRA",$J,IX,.2,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
GROSS ; Gross Description text
 N LN
 S ^TMP("LRA",$J,IX,1)="Gross Description"
 K ^UTILITY($J,"W") S LN=0 F  S LN=$O(^LR(LRDFN,"SP",IX,1,LN)) Q:LN'>0  S X=$P(^LR(LRDFN,"SP",IX,1,LN,0),U) D FORMAT
 I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LRA",$J,IX,1,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
MIC ; Microscopic Exam/Diagnosis text
 N LN
 S ^TMP("LRA",$J,IX,1.1)="Microscopic Exam"
 K ^UTILITY($J,"W") S LN=0 F  S LN=$O(^LR(LRDFN,"SP",IX,1.1,LN)) Q:LN'>0  S X=$P(^LR(LRDFN,"SP",IX,1.1,LN,0),U) D FORMAT
 I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LRA",$J,IX,1.1,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
SUPPR ; Supplementary Report date/text
 N SP1 S ^TMP("LRA",$J,IX,1.2)="Supplementary Report"
 S SP1=0 F  S SP1=$O(^LR(LRDFN,"SP",IX,1.2,SP1)) Q:SP1'>0  D
 . Q:+$P($G(^LR(LRDFN,"SP",IX,1.2,SP1,0)),U,2)'>0
 . S ^TMP("LRA",$J,IX,1.2,SP1,0)=$P($G(^LR(LRDFN,"SP",IX,1.2,SP1,0)),U)
 . K ^UTILITY($J,"W")
 . S SR=0
 . F  S SR=$O(^LR(LRDFN,"SP",IX,1.2,SP1,1,SR)) Q:SR'>0  D
 . . S X=$P($G(^LR(LRDFN,"SP",IX,1.2,SP1,1,SR,0)),U) D FORMAT
 . I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LRA",$J,IX,1.2,SP1,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
FROZ ; Frozen Section text
 N LN
 S ^TMP("LRA",$J,IX,1.3)="Frozen Section"
 K ^UTILITY($J,"W") S LN=0 F  S LN=$O(^LR(LRDFN,"SP",IX,1.3,LN)) Q:LN'>0  S X=$P(^LR(LRDFN,"SP",IX,1.3,LN,0),U) D FORMAT
 I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LRA",$J,IX,1.3,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
SPDX ; Surgical Pathology DX text
 N LN
 S ^TMP("LRA",$J,IX,1.4)="Surgical Path Dx"
 K ^UTILITY($J,"W") S LN=0 F  S LN=$O(^LR(LRDFN,"SP",IX,1.4,LN)) Q:LN'>0  S X=$P(^LR(LRDFN,"SP",IX,1.4,LN,0),U) D FORMAT
 I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LRA",$J,IX,1.4,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
FORMAT ; Format text - Left Margin 3/Right Margin 78
 S DIWF="N",DIWL=3,DIWR=78 D ^DIWP
 Q
