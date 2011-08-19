GMTSDGC2 ; SLC/SBW,KER - Extended ADT Hist (cont) ; 03/24/2004
 ;;2.7;Health Summary;**28,49,71**;Oct 20, 1995
 ;                   
 ; External References
 ;   DBIA  1372  ^DGPT(
 ;   DBIA  3390  $$ICDOP^ICDCODE
 ;                     
ICDP(DFN,PTF) ; Module For History of PTF Procedures
 Q:'$D(^DGPT(PTF,"P"))
 N II,PRX,X,IX,GMP,GTA,O,O1,LN1
 S II=0
 F  S II=$O(^DGPT(PTF,"P",II)) Q:'II  S PRX=^DGPT(PTF,"P",II,0),X=$P(PRX,U,1),IX=9999999-X D REGDT4^GMTSU D
 . S GMP(IX)="Procedure "_X F GTA=5:1:9 D
 . . N ICDP,ICDI,ICDX Q:$P(PRX,U,GTA)=""
 . . S ICDI=+($P(PRX,U,GTA)) Q:+ICDI'>0
 . . S ICDX=$$ICDOP^ICDCODE(+ICDI)
 . . S ICDP(80.1,ICDI,.01)=$P(ICDX,"^",2)
 . . S ICDP(80.1,ICDI,4)=$P(ICDX,"^",5)
 . . I $D(ICDP(80.1,ICDI)) D
 . . . S GMP(IX,GTA)=$E(ICDP(80.1,ICDI,4),1,45)_U_ICDP(80.1,ICDI,.01)
 I $D(GMP) S O=0 F  S O=$O(GMP(O)) Q:O=""  D
 . S O1=0,LN1=1
 . F  S O1=$O(GMP(O,O1)) Q:O1=""  D CKP^GMTSUP Q:$D(GMTSQIT)  S:GMTSNPG LN1=1 W:LN1 ?2,GMP(O) W ?23,$P(GMP(O,O1),U),?69,$P(GMP(O,O1),U,2),! S LN1=0
 Q
ICDS(DFN,PTF) ; Module for history of PTF surgery episodes
 Q:'$D(^DGPT(PTF,"S"))
 N II,SURG,X,IX,GMS,GMA,O,O1,LN1
 S II=0
 F  S II=$O(^DGPT(PTF,"S",II)) Q:'II  S SURG=^DGPT(PTF,"S",II,0),X=$P(SURG,U,1),IX=9999999-X D REGDT4^GMTSU D
 . ;   Load Surgery entries into GMS array in inverted sequence
 . S GMS(IX)="  Surgery "_X F GMA=8:1:12 D
 . . ;   Surgery Line
 . . N ICDS,ICDI,ICDX
 . . S ICDI=+($P(SURG,U,GMA)) Q:+ICDI'>0
 . . S ICDX=$$ICDOP^ICDCODE(+ICDI)
 . . S ICDS(80.1,ICDI,.01)=$P(ICDX,"^",2)
 . . S ICDS(80.1,ICDI,4)=$P(ICDX,"^",5)
 . . I $D(ICDS(80.1,ICDI)) S GMS(IX,GMA)=$E(ICDS(80.1,ICDI,4),1,45)_U_ICDS(80.1,ICDI,.01)
 I $D(GMS) S O=0 F  S O=$O(GMS(O)) Q:O=""  D
 . S O1=0,LN1=1
 . F  S O1=$O(GMS(O,O1)) Q:O1=""  D CKP^GMTSUP Q:$D(GMTSQIT)  S:GMTSNPG LN1=1 W:LN1 ?2,GMS(O) W ?23,$P(GMS(O,O1),U),?69,$P(GMS(O,O1),U,2),! S LN1=0
 Q
