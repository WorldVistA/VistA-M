SDSCCLM ;ALB/JAM/RBS - ASCD Update Claims Tracking ; 3/12/07 4:58pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 Q
CLM(SDENC) ;  Check Claims Tracking
 N SDOE0,SCSTAT,SCTIEN,SCVAL,SCTUPD,SDSC,SCERR
 ;
 ;  If this encounter is not yet completed, quit
 I $P(^SDSC(409.48,SDENC,0),"^",5)'="C" Q
 ;
 ;  Status of encounter must be 'checked out'
 S SDOE0=$$GETOE^SDOE(SDENC)
 S SCSTAT=$P(SDOE0,"^",12) I SCSTAT'=2 Q
 ;
 ; Call IB API to get the claims tracking number
 S SCTIEN=$$CT^IBRSUTL(SDENC)
 ;
 ;If there is no CT entry quit
 I SCTIEN="" Q
 S SDSC(409.48,SDENC_",",.1)=SCTIEN
 D FILE^DIE("I","SDSC","SCERR")
 ;
 ;If SC value hasn't changed quit, else update CT in IB
 S SCVAL=$$SCHNG^SDSCUTL(SDENC) I '+SCVAL Q
 S SCTUPD=$$RNBU^IBRSUTL(SDENC,$S($P(SCVAL,U,3):1,1:2))
 Q
