GMTSLROB ; SLC/JER - Brief Lab Order ; 01/06/2003
 ;;2.7;Health Summary;**28,58**;Oct 20, 1995
MAIN ; Driver
 N GMW,GMX,ICD,MAX,OC,SN
 I $D(GMTSNDM),(GMTSNDM>0) S MAX=GMTSNDM
 E  S MAX=999
 D ^GMTSLROE
 I '$D(^TMP("LRO",$J)) Q
 D WRTHDR
 S (ICD,OC)=0 F  S ICD=$O(^TMP("LRO",$J,ICD)) Q:'ICD!(OC'<MAX)  S SN=0 F  S SN=$O(^TMP("LRO",$J,ICD,SN)) Q:'SN!(OC'<MAX)  D GET
 K ^TMP("LRO",$J)
 Q
GET ; Get Data
 S GMX=^TMP("LRO",$J,ICD,SN),OC=OC+1 I ICD>GMTS1,(ICD'>GMTS2) D WRT
 Q
WRTHDR ; Prints Header
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Collection DT",?18,"Test Name",?39,"Specimen",?51,"Urgency",?68,"Status",!
 W:'$D(GMTSOBJ) !
 Q
WRT ; Writes Component
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG WRTHDR W $P(GMX,U),?18,$P($P(GMX,U,2),";",2),?39,$E($P($P(GMX,U,3),";",2),1,10),?51,$P(GMX,U,4),?68,$P(GMX,U,5),!
 Q
