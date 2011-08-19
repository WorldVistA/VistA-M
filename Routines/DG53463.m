DG53463 ;ALB/RMM - Mail Group Utility ; 2/03/03
 ;;5.3;Registration;**463**;Aug 13, 1993
 ;
 ; This post-install routine will add the user who is performing the
 ; install of Patch DG*5.3*463 to the MT INCONSISTENCIES Mail Group
 ;
EN ; Get the IEN of the mail group distributed in this patch
 N DGENDA,DATA,ERR
 S DGENDA(1)=$O(^XMB(3.8,"B","MT INCONSISTENCIES",""))
 ;
 ; Quit if the user has already been added to the mail group
 Q:$D(^XMB(3.8,DGENDA(1),1,"B",DUZ))
 ;
 ; Add the user to the MT INCONSISTENCIES Mail Group
 S DATA(.01)=DUZ
 I $$ADD^DGENDBS(3.81,.DGENDA,.DATA,.ERR)
 ;
 Q
