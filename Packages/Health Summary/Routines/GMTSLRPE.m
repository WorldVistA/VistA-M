GMTSLRPE ; SLC/JER,KER - Cytopathology Extract Routine ; 08/27/2002
 ;;2.7;Health Summary;**3,28,37,56**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA   525  ^LR(
 ;   DBIA   529  ^LAB(61.1   0;1
 ;   DBIA   526  ^LAB(61.2   0;1
 ;   DBIA 10133  ^LAB(61.4   0;1
 ;   DBIA 10134  ^LAB(61.5   0;1
 ;   DBIA  2056  $$GET1^DIQ (file #61.1, 61.2, 61.4, and 61.5)
 ;                    
XTRCT ; Extract
 N IX0,IX K ^TMP("LRCY",$J) S IX=GMTS1
 F IX0=1:0:MAX S IX=$O(^LR(LRDFN,"CY",IX)) Q:IX'>0!(IX>GMTS2)  D CYSET
 Q
CYSET ; Sets ^TMP("LRCY",$J, with appropriate data elements
 N ACC,CDT,D1,D2,D3,DA,DIC,DIQ,DR,DX,ICD,OT,SR,RELEASE,SITE,SN,X,YR
 S CDT=$P(^LR(LRDFN,"CY",IX,0),U),ACC=$P(^(0),U,6),RELEASE=$P(^(0),U,11)
 I $D(ACC) S IX0=IX0+1
 S X=CDT D REGDT4^GMTSU S CDT=X K X
 S ^TMP("LRCY",$J,IX,0)=CDT_U_ACC
 I $D(^LR(LRDFN,"CY",IX,.1)) S ^TMP("LRCY",$J,IX,1)="Site/Specimen"_U_RELEASE
 Q:'RELEASE
 S SN=0 F  S SN=$O(^LR(LRDFN,"CY",IX,.1,SN)) Q:SN'>0  S ^TMP("LRCY",$J,IX,1,SN)=$P(^LR(LRDFN,"CY",IX,.1,SN,0),U)
 S OT=0 F  S OT=$O(^LR(LRDFN,"CY",IX,.2,OT)) Q:+OT'>0  S ^TMP("LRCY",$J,IX,"AH",OT)=$G(^LR(LRDFN,"CY",IX,.2,OT,0))
 S OT=0 F  S OT=$O(^LR(LRDFN,"CY",IX,1,OT)) Q:OT'>0  S ^TMP("LRCY",$J,IX,"G",OT)=^LR(LRDFN,"CY",IX,1,OT,0)
 S OT=0 F  S OT=$O(^LR(LRDFN,"CY",IX,1.1,OT)) Q:OT'>0  S ^TMP("LRCY",$J,IX,"MI",OT)=^LR(LRDFN,"CY",IX,1.1,OT,0)
 S OT=0 F  S OT=$O(^LR(LRDFN,"CY",IX,1.2,OT)) Q:OT'>0  D
 . Q:+$P($G(^LR(LRDFN,"CY",IX,1.2,OT,0)),U,2)'>0
 . S ^TMP("LRCY",$J,IX,"SR",OT,0)=$P($G(^LR(LRDFN,"CY",IX,1.2,OT,0)),U)
 . S SR=0 F  S SR=$O(^LR(LRDFN,"CY",IX,1.2,OT,1,SR)) Q:SR'>0  D
 . . S ^TMP("LRCY",$J,IX,"SR",OT,SR)=$P($G(^LR(LRDFN,"CY",IX,1.2,OT,1,SR,0)),U)
 S OT=0 F  S OT=$O(^LR(LRDFN,"CY",IX,1.4,OT)) Q:+OT'>0  S ^TMP("LRCY",$J,IX,"NDX",OT)=$P($G(^LR(LRDFN,"CY",IX,1.4,OT,0)),U)
 Q
D ; Get Disease Field data
 N GMI,GMD,DIS S GMD=0 F  S GMD=$O(^LR(LRDFN,"CY",IX,2,OT,1,GMD)) Q:GMD=""  D
 . S GMI=+^LR(LRDFN,"CY",IX,2,OT,1,GMD,0)
 . S ^TMP("LRCY",$J,IX,"OT"_OT,"D"_GMD)=$$GET1^DIQ(61.4,GMI,.01,"I")
 Q
M ; Get Morphology Field data
 N GMI,GMM,MORPH S GMM=0 F  S GMM=$O(^LR(LRDFN,"CY",IX,2,OT,2,GMM)) Q:GMM=""  D
 . S GMI=+^LR(LRDFN,"CY",IX,2,OT,1,GMD,0)
 . S ^TMP("LRCY",$J,IX,"OT"_OT,"M"_GMM)=$$GET1^DIQ(61.1,GMI,.01,"I")
 . D E
 Q
E ; Get Etiology Field data
 N GMI,GME,ETIOL S GME=0 F  S GME=$O(^LR(LRDFN,"CY",IX,2,OT,2,GMM,1,GME)) Q:GME'>0  D
 . S GMI=+^LR(LRDFN,"CY",IX,2,OT,2,GMM,1,GME,0)
 . S ^TMP("LRCY",$J,IX,"OT"_OT,"M"_GMM,"E"_GME)=$$GET1^DIQ(61.2,GMI,.01,"I")
 Q
P ; Get Procedure Field data
 N GMI,GMP,PROC S GMP=0 F  S GMP=$O(^LR(LRDFN,"CY",IX,2,OT,4,GMP)) Q:GMP=""  D
 . S GMI=+^LR(LRDFN,"CY",IX,2,OT,4,GMP,0)
 . S ^TMP("LRCY",$J,IX,"OT"_OT,"P"_GMP)=$$GET1^DIQ(61.5,GMI,.01,"I")
 Q
