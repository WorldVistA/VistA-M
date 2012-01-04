GMTSLRC ; SLC/JER,KER - Chemistry & Hematology Comp Dvr ; 01/06/2003
 ;;2.7;Health Summary;**28,47,58,88**;Oct 20, 1995;Build 23
 ;
 ; External References
 ;    DBIA   525  ^LR( all fields
 ;    DBIA 10035  ^DPT( field 63 Read w/Fileman
 ;    DBIA  2056  $$GET1^DIQ (file 2)
 ;                       
MAIN ; Chemisty and Hematology
 N GMCFLAG,GMCMNT,IX0,IX,LRDFN,MAX,CNT,PTR,RWIDTH
 S LRDFN=+($$GET1^DIQ(2,(+($G(DFN))_","),63,"I")) Q:+LRDFN=0  Q:'$D(^LR(LRDFN))
 I $D(GMTSNDM),(GMTSNDM>0) S MAX=GMTSNDM
 E  S MAX=999
 S RWIDTH=8 ;Optional variable used in ^GMTSLRCE
 D ^GMTSLRCE
 I '$D(^TMP("LRC",$J)) Q
 D WRTHDR S GMCMNT=$S($P($G(^GMT(142.99,1,0)),U,3)="Y":1,1:0)
 S IX=GMTS1 F IX0=1:1:MAX S IX=$O(^TMP("LRC",$J,IX)) Q:IX=""!(IX>GMTS2)  S (PTR,CNT)=0 F  S PTR=$O(^TMP("LRC",$J,IX,PTR)) Q:PTR=""  S CNT=CNT+1 D WRT
 I +$G(GMCFLAG) D
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W "!!  Indicates COMMENTS AVAILABLE...Refer to Interim Lab Report.",!
 K ^TMP("LRC",$J)
 Q
WRTHDR ; Prints columnar header
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Collection DT",?18,"Specimen",?29
 W "Test Name",?48,"Result",?58,"Units",?70,"Ref Range",!
 W:'$D(GMTSOBJ) !
 S GMTSNPG=1
 Q
WRT ; Writes Chemistry & Hematology Component
 N GMI,GMX,GMTSI,ISNEG,REF,TAB
 I PTR="C",'+$G(GMCMNT) Q
 I PTR="C",($D(^TMP("LRC",$J,IX,"C"))>9),+$G(GMCMNT) D  Q
 . S GMI=0 F  S GMI=$O(^TMP("LRC",$J,IX,"C",GMI)) Q:GMI'>0  D
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W "Comment: ",^TMP("LRC",$J,IX,"C",GMI),!
 S GMX=^TMP("LRC",$J,IX,PTR)
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG WRTHDR
 W:CNT=1!(GMTSNPG) $P(GMX,U),?18,$E($P(GMX,U,2),1,10)
 W:CNT>1&'(GMTSNPG) ?3,"""",?12,"""",?20,""""
 I $D(^TMP("LRC",$J,IX,"C"))>9,'+$G(GMCMNT) W ?24,"!! " S GMCFLAG=1
 W ?29,$E($P(GMX,U,3),1,17),?46,$P(GMX,U,4)," ",$P(GMX,U,5)
 W ?58,$P(GMX,U,6)
 ; VM/RJT - Ref Range reformat
 ; W ?68,$J($P(GMX,U,7),4),?73,"-",?74,$J(GMTSI,4),!
 S GMTSI=$P(GMX,U,8),ISNEG=0 S:GMTSI="NEGATIVE" GMTSI="NEG",ISNEG=1
 D
 . I ((ISNEG=1)!($P(GMX,U,7)="NEGATIVE")) W ?69,$J("NEG",12),! Q
 . S REF=$$EN^LRLRRVF($P(GMX,U,7),$G(GMTSI))
 . S TAB=67+($S(REF?1A.E:2,1:(8-$F(REF,"-")))) S:TAB<67 TAB=67
 . I (TAB>72)&($L(REF)>5) S TAB=67+((13-($L(REF))/2))
 . I ($L(REF)>12),($L(REF)<15) S TAB=80-($L(REF))
 . W ?TAB,REF,!
 Q
  
