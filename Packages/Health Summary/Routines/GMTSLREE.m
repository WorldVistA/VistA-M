GMTSLREE ; SLC/JER,KER - Electron Microscopy Extract ; 08/27/2002
 ;;2.7;Health Summary;**3,28,56**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA   525  ^LR(
 ;   DBIA 10011  ^DIWP
 ;                    
XTRCT ; Extract
 N IX0,IX K ^TMP("LREM",$J) S IX=GMTS1
 F IX0=1:0:MAX S IX=$O(^LR(LRDFN,"EM",IX)) Q:IX'>0!(IX>GMTS2)  D APSET
 K AP
 Q
APSET ; Sets ^TMP("LREM",$J
 N ACC,CDT,DA,DIC,DIQ,DR,GMW,SN,X,YR
 S CDT=$P(^LR(LRDFN,"EM",IX,0),U),ACC=$P(^(0),U,6)
 I $S(+$P(^LR(LRDFN,"EM",IX,0),U)'>0:1,+$P(^(0),U,11)'>0:1,1:0) Q
 I $D(ACC) S IX0=IX0+1
 S X=CDT D REGDTM4^GMTSU S CDT=X K X
 S ^TMP("LREM",$J,IX,0)=CDT_U_ACC
 I $D(^LR(LRDFN,"EM",IX,.1)) S ^TMP("LREM",$J,IX,.1)="Site/Specimen"
 S SN=0 F  S SN=$O(^LR(LRDFN,"EM",IX,.1,SN)) Q:SN'>0  S ^TMP("LREM",$J,IX,.1,SN)=$P(^LR(LRDFN,"EM",IX,.1,SN,0),U)
 I $D(^LR(LRDFN,"EM",IX,.2,0)),($P(^(0),U,3)]"") D CLHX
 I $D(^LR(LRDFN,"EM",IX,1,0)),($P(^(0),U,3)]"") D GROSS
 I $D(^LR(LRDFN,"EM",IX,1.1,0)),($P(^(0),U,3)]"") D MIC
 I $D(^LR(LRDFN,"EM",IX,1.2,0)),($P(^(0),U,3)]"") D SUPPR
 I $D(^LR(LRDFN,"EM",IX,1.4,0)),($P(^(0),U,3)]"") D SPDX
 Q
CLHX ; Brief Clinical History text
 N LN
 S ^TMP("LREM",$J,IX,.2)="Brief Clinical Hx"
 K ^UTILITY($J,"W") S LN=0 F  S LN=$O(^LR(LRDFN,"EM",IX,.2,LN)) Q:LN'>0  S X=$P(^LR(LRDFN,"EM",IX,.2,LN,0),U) D FORMAT
 I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LREM",$J,IX,.2,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
GROSS ; Gross Description text
 N LN
 S ^TMP("LREM",$J,IX,1)="Gross Description"
 K ^UTILITY($J,"W") S LN=0 F  S LN=$O(^LR(LRDFN,"EM",IX,1,LN)) Q:LN'>0  S X=$P(^LR(LRDFN,"EM",IX,1,LN,0),U) D FORMAT
 I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LREM",$J,IX,1,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
MIC ; Microscopic Exam/Diagnosis text
 N LN
 S ^TMP("LREM",$J,IX,1.1)="Microscopic Exam"
 K ^UTILITY($J,"W") S LN=0 F  S LN=$O(^LR(LRDFN,"EM",IX,1.1,LN)) Q:LN'>0  S X=$P(^LR(LRDFN,"EM",IX,1.1,LN,0),U) D FORMAT
 I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LREM",$J,IX,1.1,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
SUPPR ; Supplementary Report date/text
 N SP1 S ^TMP("LREM",$J,IX,1.2)="Supplementary Report"
 S SP1=0
 F  S SP1=$O(^LR(LRDFN,"EM",IX,1.2,SP1)) Q:SP1'>0  D
 . Q:+$P($G(^LR(LRDFN,"EM",IX,1.2,SP1,0)),U,2)'>0
 . S ^TMP("LREM",$J,IX,1.2,SP1,0)=$P($G(^LR(LRDFN,"EM",IX,1.2,SP1,0)),U)
 . K ^UTILITY($J,"W")
 . S SR=0
 . F  S SR=$O(^LR(LRDFN,"EM",IX,1.2,SP1,1,SR)) Q:SR'>0  D
 . . S X=$P($G(^LR(LRDFN,"EM",IX,1.2,SP1,1,SR,0)),U) D FORMAT
 . I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LREM",$J,IX,1.2,SP1,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
SPDX ; Electron Microscopy DX text
 N LN
 S ^TMP("LREM",$J,IX,1.4)="Surgical Path Dx"
 K ^UTILITY($J,"W") S LN=0 F  S LN=$O(^LR(LRDFN,"EM",IX,1.4,LN)) Q:LN'>0  S X=$P(^LR(LRDFN,"EM",IX,1.4,LN,0),U) D FORMAT
 I $D(^UTILITY($J,"W")) F LN=1:1:^UTILITY($J,"W",3) S ^TMP("LREM",$J,IX,1.4,LN)=^UTILITY($J,"W",DIWL,LN,0)
 K ^UTILITY($J,"W")
 Q
FORMAT ; Format Text
 S DIWF="N",DIWL=3,DIWR=78 D ^DIWP
 Q
