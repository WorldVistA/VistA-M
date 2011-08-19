LREVENT ;DALIO/JMC - Shipping Event X-ref Utility ; [ 05/21/97  2:26 PM ]
 ;;5.2;LAB SERVICE;**153,286**;Sep 27, 1994
 Q
 ;
ADT ; set logic for ADT x-ref in file 62.85
 N LRMAN S LRMAN=$P(^LAHM(62.85,DA,0),"^") Q:'$O(^LAHM(62.8,"B",LRMAN,0))
 S ^LAHM(62.85,"ADT",LRMAN,9999999-X,DA)=""
 Q
 ;
 ;
KADT ; kill logic for ADT x-ref in file 62.85
 K ^LAHM(62.85,"ADT",$P(^LAHM(62.85,DA,0),"^"),9999999-X,DA)
 Q
 ;
 ;
ATST ; set logic for ATST x-ref in file 62.85
 N LREVDT,LRUID S LREVDT=$P($G(^LAHM(62.85,DA,0)),"^",7) Q:'LREVDT
 S LRUID=$P(^LAHM(62.85,DA,0),"^") I $D(^LAHM(62.8,LRUID,0)) Q
 I X S ^LAHM(62.85,"ATST",LRUID,X,9999999-LREVDT,DA)=""
 Q
 ;
 ;
KATST ; kill logic for ATST x-ref in file 62.85
 N LREVDT S LREVDT=$P($G(^LAHM(62.85,DA,0)),"^",7) Q:'LREVDT
 I X K ^LAHM(62.85,"ATST",$P(^LAHM(62.85,DA,0),"^"),X,9999999-LREVDT,DA)
 Q
 ;
 ;
ATST1 ; set logic for ATST1 x-ref in file 62.85
 N LRTST,LRUID S LRTST=$P($G(^LAHM(62.85,DA,0)),"^",8) Q:'LRTST
 S LRUID=$P(^LAHM(62.85,DA,0),"^") I $D(^LAHM(62.8,LRUID,0)) Q
 S ^LAHM(62.85,"ATST",LRUID,LRTST,9999999-X,DA)=""
 Q
 ;
 ;
KATST1 ; kill logic for ATST1 x-ref in file 62.85
 N LRTST S LRTST=$P($G(^LAHM(62.85,DA,0)),"^",8) Q:'LRTST
 K ^LAHM(62.85,"ATST",$P(^LAHM(62.85,DA,0),"^"),LRTST,9999999-X,DA)
 Q
 ;
 ;
STATUS(LRUID,LRTSTN,LRMAN) ; return status of referral test
 ; Call with LRUID = accession's unique identifier (UID)
 ;          LRTSTN = file #60 test ien
 ;           LRMAN = manifest shipping #
 ;
 ; Returns LREVNT = status of referral testing.
 ;
 N LRAA,LRAD,LRAN,LRDA,LREVNT,LRIEN,LRINVDT,X
 ;
 S LREVNT=""
 I LRUID="" Q ""
 I LRMAN="" D
 . S X=$Q(^LRO(68,"C",LRUID)) Q:X=""
 . I $QS(X,3)'=LRUID Q
 . S LRAA=$QS(X,4),LRAD=$QS(X,5),LRAN=$QS(X,6)
 . S LRDA=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,"B",LRTSTN,0)) Q:'LRDA
 . S X=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRDA,0),"^",10) Q:'X
 . S LRMAN=$P($G(^LAHM(62.8,X,0),"Manifest missing in file #62.8 with ien "_X),"^")
 ;
 S LRINVDT=$O(^LAHM(62.85,"ATST",LRUID,LRTSTN,0))
 I LRINVDT D
 . S LRIEN=$O(^LAHM(62.85,"ATST",LRUID,LRTSTN,LRINVDT,0))
 . I 'LRIEN Q
 . I LRMAN="" S LRMAN=$P(^LAHM(62.85,LRIEN,0),"^",9)
 . D EVENT
 ;
 I 'LRINVDT,LRMAN'="" D
 . S LRINVDT=$O(^LAHM(62.85,"ADT",LRMAN,0))
 . I 'LRINVDT Q
 . S LRIEN=$O(^LAHM(62.85,"ADT",LRMAN,LRINVDT,0))
 . I LRIEN D EVENT
 ;
 Q LREVNT
 ;
 ;
EVENT ;
 N LRX
 S LRX=$P(^LAHM(62.85,LRIEN,0),"^",5)
 I LRX S $P(LREVNT,"^")=$$GET1^DIQ(62.85,LRIEN_",",.05)
 S LRX=$P(^LAHM(62.85,LRIEN,0),"^",7)
 I LRX S $P(LREVNT,"^",2)=$$FMTE^XLFDT(LRX,"MZ")
 S $P(LREVNT,"^",3)=LRMAN
 Q
