GMTSLROS ; SLC/JER,KER - Lab Order Status Summary ; 09/21/2001
 ;;2.7;Health Summary;**28,47**;Oct 20, 1995
 ;
MAIN ; Lab Order Status
 N GMW,GMX,ICD,MAX,OC,SN
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:999)
 D ^GMTSLROE I '$D(^TMP("LRO",$J)) Q
 S (ICD,OC)=0 F  S ICD=$O(^TMP("LRO",$J,ICD)) Q:'ICD!(OC'<MAX)  S SN=0 F  S SN=$O(^TMP("LRO",$J,ICD,SN)) Q:'SN!(OC'<MAX)  D GET
 K ^TMP("LRO",$J)
 Q
GET ; Get Data from ^TMP("LRO",$J
 S GMX=^TMP("LRO",$J,ICD,SN),OC=OC+1
 I ICD>GMTS1,(ICD'>GMTS2) D CKP^GMTSUP Q:$D(GMTSQIT)  W:OC>1&'(GMTSNPG) ! D WRT
 Q
WRT ; Write Data
 N GMI,TSET,TEST S TSET="",$P(GMX,U,3)=$E($P(GMX,U,3),1,10)
 F GMI=1:1:3 S $P(TEST,"-",GMI)=$S(GMI=3:$P(GMX,U,GMI+1),1:$P($P(GMX,U,GMI+1),";",2))
 F  Q:$L(TEST)<23  S TSET=$P(TEST,"-",$L(TEST,"-"))_" "_TSET,TEST=$P(TEST,"-",1,$L(TEST,"-")-1)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W $P(GMX,U),?18,$E(TEST,1,20),?39,"Prov: ",$E($P($P(GMX,U,6),";",2),1,10),?56,"Ord'd: ",$P(GMX,U,7),!
 D CKP^GMTSUP Q:$D(GMTSQIT)  G:GMTSNPG WRT W ?18,$E(TSET,1,20),?39,"# ",$E($P(GMX,U,8),1,15),?56,"Avail: ",$P(GMX,U,9),!
 Q
