GMTSRAE1 ; SLC/GSS Selected Radiology Extracts ; 01/17/2007
 ;;2.7;Health Summary;**84**;Oct 20, 1995;Build 6
 ;
 ; External References
 ;   DBIA  2056  $$GET1^DIQ (file 70, subfile 70.03, file 74)
 ;   DBIA   504  retrieve fields from file 75.1
 Q
GETHIS ; Gets Clinical History (#70/#74)
 N X,GMTSLN
 ; GMTSRA27=$$PROK^GMTSU("RAUTL9",27) -> vesion 27 of RAUTL9 in environment
 I +($G(GMTSRA27))>0 S X=$$GET1^DIQ(70.03,(GMTSPN_","_GMTSIDT_","_DFN_","),400,,"GMTST")
 I +($G(GMTSRA27))'>0 S X=$$GET1^DIQ(74,GMTSPTR,400,,"GMTST") ;Rad/Nuc Med reports for registered exams
 K ^UTILITY($J,"W") N X,GMTSI S GMTSI=0 F  S GMTSI=$O(GMTST(GMTSI)) Q:+GMTSI=0  S X=$G(GMTST(GMTSI)) D FORMAT^GMTSRAE
 I $D(^UTILITY($J,"W")) F GMTSLN=1:1:^UTILITY($J,"W",3) S ^TMP("RAE",$J,GMTSIDT,GMTSPN,"H",GMTSLN)=^UTILITY($J,"W",3,GMTSLN,0)
 K ^UTILITY($J,"W"),GMTST Q
 Q
GETR4S ; Gets Reason for Study
 N X
 S X=$$GET1^DIQ(75.1,GMTSIMGO,1.1) ;Rad/Nuc Med info pertaining to an imaging order
 I $D(X) S ^TMP("RAE",$J,GMTSIDT,GMTSPN,"S",1)=X ;Reason for Study (one line, max 64 char)
 Q
