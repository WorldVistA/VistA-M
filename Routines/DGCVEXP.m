DGCVEXP ;ALB/ERC - FIND VETS WIITH EXPIRED CV STATUS; 12/11/02
 ;;5.3;Registration;**576**; Aug 13, 1993
 ;
 ;this API will list any veterans who have Combat Vet status that has
 ;expired.  This API will be called by IB to look for any vets who have
 ;been billed for treatment on the last day of their CV eligibility.
 ;
EN ;
 N DGC,DGE,DGEX,DGFILE
 K ^TMP("DGCVEX")
 S DGC=""
 S DGFILE=2
 F  S DGC=$O(^DPT("E",DGC)) Q:DGC'>0  D
 . S DGE=""
 . F  S DGE=$O(^DPT("E",DGC,DGE)) Q:DGE'>0  D
 . . S DGEX=$$GET1^DIQ(DGFILE,DGE_",",.5295,"I")
 . . I $G(DGEX)']"" Q
 . . I DT'>DGEX Q
 . . S ^TMP("DGCVEX",$J,DGE,DGEX)=""
 Q
