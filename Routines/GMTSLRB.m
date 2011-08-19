GMTSLRB ; SLC/JER,KER - Blood Availability Component ; 11/26/2002
 ;;2.7;Health Summary;**17,47,59**;Oct 20, 1995
 ;                                      
 ; External References
 ;   DBIA   525  ^LR( all fields
 ;   DBIA  2056  $$GET1^DIQ (file 2)
 ;   DBIA  3177  AVUNIT^VBECA4()  Blood Bank Pkg
 ;                         
MAIN ; Blood Availability 
 N GMI,MAX,LRDFN,IX,X,LOC
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:999),LOC="LRB"
 S LRDFN=$$GET1^DIQ(2,+($G(DFN)),63,"I") Q:+LRDFN=0!('$D(^LR(+LRDFN)))
 ;                 
 ; Get Available Units
 ;   Blood Bank Package  AVUNIT^VBECA4
 ;   Lab Package         ^GMTSLRBE    
 ;                 
 D:+($$ROK^GMTSU("VBECA4"))>0 AVUNIT^VBECA4(DFN,LOC,GMTS1,GMTS2,MAX)
 D:+($$ROK^GMTSU("VBECA4"))'>0 ^GMTSLRBE
 Q:'$D(^TMP("LRB",$J))
 D WRTBTYP
 S IX=0 F  S IX=$O(^TMP("LRB",$J,IX)) Q:IX=""  D
 . S X=^TMP("LRB",$J,IX) D WRT
 K ^TMP("LRB",$J)
 Q
WRTBTYP ; Writes Blood Type (Added 03/31/1994)
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?1,"Patient Blood Type:",?22,$P(^TMP("LRB",$J,0),U,1)
 W ?25,$P(^TMP("LRB",$J,0),U,2),!!
 Q
WRT ; Writes Blood Availability Record
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W $P(X,U),?2,$P(X,U,2),?11,$P(X,U,3),?22,$P(X,U,4)
 W ?62,$J($P(X,U,6),2),?65,$P(X,U,7),?69,$P(X,U,8),!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?6,"Unit Location:"
 W ?22,$S($L($P(X,U,10)):$P(X,U,10),1:"Blood Bank"),!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?6,"Unit Division:",?22,$P(X,U,9),!
 I $L($P(X,U,8)) D CKP^GMTSUP Q:$D(GMTSQIT)  D
 . W ?6,"Donation Type:",?22,$P(X,U,8),!
 Q
