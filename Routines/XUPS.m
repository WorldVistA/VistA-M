XUPS ;CS&ISS-RAM/DW - NPF API ; 1 April 2004
 ;;8.0;KERNEL;**309**; Jul 10, 1995;
 ;
 Q
 ;
VPID(IEN) ; VA Person ID
 ;
 Q $P($G(^VA(200,+$G(IEN),"VPID")),U)
 ;
IEN(VPID) ; Internal Entry Number
 ;
 Q:$G(VPID)="" ""
 Q $O(^VA(200,"AVPID",VPID,0))
 ;
