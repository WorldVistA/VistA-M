GMTSLRS ; SLC/JER,KER - Sel Lab Component w/Selection Items ; 01/06/2003
 ;;2.7;Health Summary;**16,28,47,58**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA    67  ^LAB(60
 ;    DBIA   525  ^LR( all fields
 ;    DBIA 10035  ^DPT( field 63 Read w/Fileman
 ;    DBIA  2056  $$GET1^DIQ (file 2)
 ;                       
MAIN ; Selected Lab w/Selection Items
 N GMTSI,GMW,GMX,LRDFN,MAX,IT,IX,PTEST,TEST,BEGIN,END,CNT,RWIDTH,GMLINE,GMCMNT,GMCFLAG
 S RWIDTH=8,LRDFN=+($$GET1^DIQ(2,(+($G(DFN))_","),63,"I")) Q:+LRDFN=0  Q:'$D(^LR(LRDFN))
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:999) Q:'$O(GMTSEG(GMTSEGN,60,0))
 S GMCMNT=$S($P($G(^GMT(142.99,1,0)),U,3)="Y":1,1:0)
 S GMTSI=0 F  S GMTSI=$O(GMTSEG(GMTSEGN,60,GMTSI)) Q:GMTSI'>0  D  Q:$D(GMTSQIT)
 . S (PTEST,TEST)=GMTSEG(GMTSEGN,60,GMTSI)
 . D @$S($L($P(^LAB(60,TEST,0),U,5)):"^GMTSLRSE",1:"PANEL")
 Q:'$D(^TMP("LRS",$J))  D WRTHDR Q:$D(GMTSQIT)
 S IT=0 F  S IT=$O(^TMP("LRS",$J,IT)) Q:+IT'>0  D  Q:$D(GMTSQIT)
 . S IX="" F  S IX=$O(^TMP("LRS",$J,IT,IX)) Q:'IX!(IX>GMTS2)  D  Q:$D(GMTSQIT)
 . . S GMX=^TMP("LRS",$J,IT,IX) D WRT
 I +$G(GMCFLAG) D
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W "!!  Indicates COMMENTS AVAILABLE...Refer to Interim Lab Report.",!
 K ^TMP("LRS",$J)
 Q
PANEL ; Visits "PANEL" multiple to get pointers to atomic tests
 N TEST,GMW,INDX
 S INDX=0 F  S INDX=$O(^LAB(60,PTEST,2,INDX)) Q:'INDX  S TEST=^(INDX,0) S:'$L($P(^LAB(60,TEST,0),U,5)) PTEST=TEST D @$S($L($P(^LAB(60,TEST,0),U,5)):"^GMTSLRSE",1:"PANEL")
 Q
WRTHDR ; Prints columnar header
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Collection DT",?18,"Specimen"
 W ?29,"Test Name",?48,"Result",?58,"Units",?68,"Ref Range",!
 W:'$D(GMTSOBJ) !
 Q
WRT ; Writes the Lab Record
 D CKP^GMTSUP Q:$D(GMTSQIT)  D
 . D:GMTSNPG WRTHDR N GMTSI
 . W $P(GMX,U),?18,$P($P(GMX,U,2),";",2)
 . I $D(^TMP("LRS",$J,"C",IX))>9,'+$G(GMCMNT) W ?24,"!! " S GMCFLAG=1
 . S GMTSI=$P(GMX,U,8) S:GMTSI="NEGATIVE" GMTSI="NEG"
 . W ?29,$E($P($P(GMX,U,3),";",2),1,17),?46,$P(GMX,U,4)," ",$P(GMX,U,5)
 . W ?58,$P(GMX,U,6),?68,$J($P(GMX,U,7),4),?73,"-",?74,$J(GMTSI,4),!
 I +$G(GMCMNT),$D(^TMP("LRS",$J,"C",IX))>9,'$D(^TMP("LRS",$J,+$O(^TMP("LRS",$J,IT)),IX)) D  Q
 . S GMLINE=0
 . F  S GMLINE=$O(^TMP("LRS",$J,"C",IX,GMLINE)) Q:GMLINE'>0  D
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W "Comment: ",^TMP("LRS",$J,"C",IX,GMLINE),!
 Q
