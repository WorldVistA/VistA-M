LR7OB63B ;slc/dcm - Get Micro (Parasite, Virology, TB, Mycology) ;8/11/97
 ;;5.2;LAB SERVICE;**121**;Sep 27, 1994
 ;
MI ;Microbiology
 I $D(^LR(LRDFN,"MI",IVDT,5)) S X=^(5) D  ;Parasite
 . Q:'$L($P(X,"^"))
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,24,IFN)) Q:IFN<1  S X1=^(IFN,0),Y1="PARASITOLOGY SMEAR/PREP",Y2=X1,CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,6,IFN)) Q:IFN<1  S X1=^(IFN,0),Y1="Parasite",X2=$P(^LAB(61.2,+X1,0),"^") D
 .. S IFN1=0 F  S IFN1=$O(^LR(LRDFN,"MI",IVDT,6,IFN,1,IFN1)) Q:IFN1<1  S X3=^(IFN1,0) D
  ... S Y2=X2_" Stage: "_$P($P(";"_$P(^DD(63.35,.01,0),"^",3),";"_$P(X3,"^")_":",2),";")_$S($L($P(X3,"^",2)):" Quantity: "_$P(X3,"^",2),1:""),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 ... S IFN2=0 F  S IFN2=$O(^LR(LRDFN,"MI",IVDT,6,IFN,1,IFN1,1,IFN2)) Q:IFN2<1  S X1=^(IFN2,0),Y1="Comment",Y2=X1,CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,7,IFN)) Q:IFN<1  S X1=^(IFN,0),Y1="Parasitology Remark(s)",Y2=X1,CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 ;
 I $D(^LR(LRDFN,"MI",IVDT,16)) S X=^(16) D  ;Virology
 . Q:'$L($P(X,"^"))
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,17,IFN)) Q:IFN<1  S X1=^(IFN,0),Y1="Virus",Y2=$P(^LAB(61.2,$P(X1,"^"),0),"^"),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,18,IFN)) Q:IFN<1  S X1=^(IFN,0),Y1="Virology Remark(s)",Y2=X1,CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 ;
 I $D(^LR(LRDFN,"MI",IVDT,11)) S X=^(11) D  ;TB
 . Q:'$L($P(X,"^"))
 . S X1=$P(X,"^",3),Y1="MYCOBACTERIOLOGY "_$S(X1["D":"Direct",X1["C":"Concentrate",1:"")_" Acid Fast Stain: "_$S(X1["P":"Positive",X1["N":"Negative",1:X1)_$S($P(X,"^",4):" Quantity: "_$P(X,"^",4),1:"")
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,12,IFN)) Q:IFN<1  S X1=^(IFN,0) D
 .. S X2=$P(^LAB(61.2,+X1,0),"^"),Y1="Mycobacterium: "_X2_$S($P(X1,"^",2):" Quantity: "_$P(X1,"^",2),1:""),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 .. S IFN1=0 F  S IFN1=$O(^LR(LRDFN,"MI",IVDT,12,IFN,1,IFN1)) Q:IFN1<1  S X1=^(IFN1,0),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=X1_"^^^^^^^^^^^^^^"_X1_"^^^"_Y1_"^^^"_Y18
 .. S IFN1=2
 .. F  S IFN1=$O(^LR(LRDFN,"MI",IVDT,12,IFN,IFN1)) Q:IFN1<1!(IFN1'["2.")  S Y2=^(IFN1),Y1=$O(^DD(63.39,"GL",IFN1,1,0)),Y1=$P(^DD(63.39,Y1,0),"^"),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,13,IFN)) Q:IFN<1  S X1=^(IFN,0),Y1="Mycobacteriology Remark(s)",Y2=X1,CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 ;
 I $D(^LR(LRDFN,"MI",IVDT,8)) S X=^(8) D  ;Mycology
 . Q:'$L($P(X,"^"))  N IFN
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,15,IFN)) Q:IFN<1  S X1=^(IFN,0),Y1="MYCOLOGY SMEAR/PREP",Y2=X1,CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,9,IFN)) Q:IFN<1  S X1=^(IFN,0) D
 .. S X2=$P(^LAB(61.2,+X1,0),"^"),Y1="Fungus/Yeast",Y2=X2_$S($P(X1,"^",2):" Quantity: "_$P(X1,"^",2),1:""),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 .. S IFN1=0 F  S IFN1=$O(^LR(LRDFN,"MI",IVDT,9,IFN,1,IFN1)) Q:IFN1<1  S X1=^(IFN1,0),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_X1_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,10,IFN)) Q:IFN<1  S X1=^(IFN,0),Y1="Mycology Remark(s)",Y2=X1,CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_$P(X,"^",2)_"^^^^^^^^^"_Y1_"^^^"_Y18
 Q
