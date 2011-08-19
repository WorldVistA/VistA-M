GMTSLRSC ; SLC/JER,KER - Sel Cum Lab Comp w/Sel Items ; 01/06/2003
 ;;2.7;Health Summary;**28,47,58**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA 10035  ^DPT(
 ;    DBIA    67  ^LAB(60
 ;    DBIA   525  ^LR(
 ;                           
MAIN ; Selected Cumulative Lab w/Selection Items
 N GMTSI,LRDFN,MAX,TEST,RWIDTH,GMCMNT,COMMNBR,GMCOM,TAB
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:999) Q:'$D(^DPT(DFN,"LR"))
 Q:'$D(^DPT(DFN,"LR"))  S LRDFN=+^DPT(DFN,"LR") Q:'$D(^LR(LRDFN))  Q:'$O(GMTSEG(GMTSEGN,60,0))
 S RWIDTH=4,GMTSI=0 F  S GMTSI=$O(GMTSEG(GMTSEGN,60,GMTSI)) Q:GMTSI'>0  D  Q:$D(GMTSQIT)
 . S TEST=GMTSEG(GMTSEGN,60,GMTSI) D ^GMTSLRSE
 Q:'$D(^TMP("LRS",$J))  S GMCMNT=$S($P($G(^GMT(142.99,1,0)),U,3)="Y":1,1:0),COMMNBR=0
 F  D DISPLAY Q:$O(^TMP("LRS",$J,0))'>0  Q:$D(GMTSQIT)
 I GMCMNT,'$D(GMTSQIT) D WRTCOMM
 K ^TMP("LRS",$J),^TMP("LRSR",$J)
 Q
DISPLAY ; Displays up to 7 tests across page
 N GMC,GMN,GMI,GMW,GMX,HDR,TST,IT,IX,MORE,RES
 D INVRT Q:$D(GMTSQIT)  S IT="" F GMI=0:1:6 S IT=$O(^TMP("LRS",$J,IT)) Q:'IT  D
 . S IX="" F  S IX=$O(^(IT,IX)) Q:IX'>0  D
 . . S TST=+$P(^(IX),U,3),HDR(GMI)=$S(TST'="":$E($P($G(^LAB(60,TST,.1)),U),1,7),1:"")
 . . K ^TMP("LRS",$J,IT)
 D WRTHDR S RES=$$RES,MORE=$S(+($G(RES))>+($G(MAX)):1,1:0)
 S IX="" F GMW=1:1:MAX S IX=$O(^TMP("LRSR",$J,IX)) Q:+IX'>0  D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG WRTHDR
 . S IT="" F GMI=0:1 S IT=$O(^TMP("LRSR",$J,IX,IT)) Q:IT=""  D  Q:$D(GMTSQIT)
 . . D WRT I '$O(^TMP("LRSR",$J,IX,IT)) W !
 I '$D(GMTSOBJ),+($G(MORE)) D
 . D CKP^GMTSUP Q:$D(GMTSQIT) 
 . W $C(7),!?10,"** Additional Results available outside occurrence limit **",!
 K ^TMP("LRSR",$J) W:$D(^TMP("LRS",$J)) !
 Q
WRTHDR ; Writes Column Header
 N GMI
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Collection DT"
 W ?19,$S(+$G(GMCMNT):" ",1:""),"Spec"
 F GMI=0:1:6 D CKP^GMTSUP Q:'$D(HDR(GMI))!($D(GMTSQIT))  W ?(((8*GMI+25)+(7-$L(HDR(GMI))\2))),$E(HDR(GMI),1,7)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 I '$D(GMTSOBJ) D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
WRT ; Writes the Lab Record
 S GMX=^TMP("LRSR",$J,IX,IT),TAB=$P(GMX,U)
 I GMI=0!(GMTSNPG) D
 . I +$G(GMCMNT),$D(^TMP("LRS",$J,"C",IX))>0,$D(GMCOM("DT",IX))'>0,COMMNBR<26 D
 . . S GMLTR=$C(97+COMMNBR) S COMMNBR=COMMNBR+1
 . . S GMCOM("DT",IX)=GMLTR,GMCOM("LTR",GMLTR)=IX
 . I +$G(GMCMNT) D  Q
 . . W $E($G(GMCOM("DT",IX)),1),?2,$P(GMX,U,2),?19,$E($P($P(GMX,U,3),";",2),1,5)
 . W $P(GMX,U,2),?19,$E($P($P(GMX,U,3),";",2),1,5)
 W ?(8*TAB+25),$P(GMX,U,4)," ",$P(GMX,U,5)
 Q
WRTCOMM ; Writes the lab Comments
 N GMLTR,GMLINE
 Q:$D(GMCOM)'>0
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "COMMENTS:",!
 S GMLTR=""
 F  S GMLTR=$O(GMCOM("LTR",GMLTR)) Q:GMLTR']""  D  Q:$D(GMTSQIT)
 . S IX=$G(GMCOM("LTR",GMLTR)),GMLINE=0
 . F  S GMLINE=$O(^TMP("LRS",$J,"C",+IX,GMLINE)) Q:GMLINE'>0  D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  I GMTSNPG W "COMMENTS:",!
 . . W:GMLINE=1!GMTSNPG GMLTR_"."
 . . W ?3,$G(^TMP("LRS",$J,"C",+IX,GMLINE)),!
 Q
 ;                     
RES(X) ; Results
 N NN,NC S X=0,NN="^TMP(""LRSR"","_$J_")",NC="^TMP(""LRSR"","_$J_","
 F  S NN=$Q(@NN) Q:NN=""!(NN'[NC)  S X=X+1
 Q X
INVRT ; Inverts Global Array
 ;                     
 ;  From: ^TMP("LRS",$J,IT,IX)=CDT^SPC^TNM^RSLT^FLAG^UNIT^LO^HI
 ;  To:   ^TMP("LRSR",$J,IX,IT)=GMI,CDT,SPC,RSLT,FLAG
 ;
 N GMI,IT,IX
 S IT=""
 F GMI=0:1:6 S IT=$O(^TMP("LRS",$J,IT)) Q:IT'>0  D
 . S IX="" F  S IX=$O(^TMP("LRS",$J,IT,IX)) Q:IX=""  D
 . . S ^TMP("LRSR",$J,IX,IT)=GMI_U_$P(^TMP("LRS",$J,IT,IX),U,1,2)_U_$P(^TMP("LRS",$J,IT,IX),U,4,5)
 Q
