GMTSROB ; SLC/JER,KER - Surgery Reports Brief ; 06/24/2002
 ;;2.7;Health Summary;**9,11,28,57**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA   2491  ^SRF("B")
 ;   DBIA   2491  ^SRF(  file #130
 ;   DBIA  10011  ^DIWP
 ;   DBIA   2056  $$GET1^DIQ  (file #130)
 ;
ENSR ; Entry point for component
 N MAX,GMCOUNT,GMIDT,GMN,SURG Q:'$D(^SRF("B",DFN))
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:999)
 S GMN=0 F  S GMN=$O(^SRF("B",DFN,GMN)) Q:GMN'>0  D SORT
 I '$D(SURG) Q
 S (GMCOUNT,GMIDT)=0 F  S GMIDT=$O(SURG(GMIDT)) Q:GMIDT'>0!(GMCOUNT'<MAX)  S GMN=SURG(GMIDT) D WRT
 Q
SORT ; Sort surgeries by inverted date
 N GMDT S GMDT=$$GET1^DIQ(130,(+(GMN)_","),.09,"I")
 I GMDT>GMTSBEG&(GMDT<GMTSEND) D
 . F  Q:'$D(SURG(9999999-GMDT))  S GMDT=GMDT+.0001
 . S SURG(9999999-GMDT)=GMN
 Q
WRT ; Write surgical case record
 N X,GMI,GMDT,STATUS K ^UTILITY($J,"W")
 S GMCOUNT=GMCOUNT+1
 ;   Date of Operation
 S X=$$GET1^DIQ(130,(+(GMN)_","),.09,"I") D REGDT4^GMTSU S GMDT=X
 D CKP^GMTSUP Q:$D(GMTSQIT)  W GMDT
 D STATUS S:'$D(STATUS) STATUS="UNKNOWN"
 ;   Principle Procedure
 S X=$$GET1^DIQ(130,(+(GMN)_","),26,"I") D FORMAT
 D CKP^GMTSUP Q:$D(GMTSQIT)  W:$D(^UTILITY($J,"W",1,1,0)) ?21,^(0) W ?61,STATUS,!
 S GMI=1 F  S GMI=$O(^UTILITY($J,"W",1,GMI)) Q:GMI'>0  D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,^UTILITY($J,"W",1,GMI,0),!
 K ^UTILITY($J,"W")
 ;   Other Procedures
 S GMI=0 F  S GMI=$O(^SRF(GMN,13,GMI)) Q:GMI'>0  D CKP^GMTSUP Q:$D(GMTSQIT)  D 
 . S X(GMI)=$$GET1^DIQ(130.16,(+GMI_","_+(GMN)_","),.01,"I")
 . W ?21,X(GMI),!
 Q
STATUS ; case status
 I $$GET1^DIQ(130,(+(GMN)_","),118,"I")="Y" D NONORST Q
 I $D(^SRF(GMN,30)) S STATUS=$S(+($$GET1^DIQ(130,(+(GMN)_","),.205,"I")):"(ABORTED)",1:"CANCELLED") Q
 I +($$GET1^DIQ(130,(+(GMN)_","),.23,"I")) S STATUS="(COMPLETED)" Q
 I +($$GET1^DIQ(130,(+(GMN)_","),.22,"I")),'+($$GET1^DIQ(130,(+(GMN)_","),.23,"I")) S STATUS="INCOMPLETE" Q
 I +($$GET1^DIQ(130,(+(GMN)_","),10,"I")) S STATUS="SCHEDULED" Q
 I +($$GET1^DIQ(130,(+(GMN)_","),36,"I")),'+($$GET1^DIQ(130,(+(GMN)_","),.22,"I")) S STATUS="REQUESTED"
 Q
FORMAT ; format surgery name
 N DIWF,DIWL,DIWR
 S DIWF="C35R",DIWL=1,DIWR=36 D ^DIWP
 Q
NONORST ;Obtains status for NON-OR procedures.
 S STATUS="UNKNOWN"
 I +($$GET1^DIQ(130,(+(GMN)_","),122,"I")) S STATUS="(COMPLETED)" Q
 I +($$GET1^DIQ(130,(+(GMN)_","),121,"I")),'+($$GET1^DIQ(130,(+(GMN)_","),122,"I")) S STATUS="INCOMPLETE" Q
 Q
