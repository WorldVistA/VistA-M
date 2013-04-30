DVBANTFY ;ALB/DJS - FORM 28-8861 REQUEST FOR MEDICAL SERVICES MAILMAN NOTIFICATIONS ;7/2/12 5:09PM
 ;;2.7;AMIE;**181**;Apr 10, 1995;Build 38
 ;
 Q  ;no direct entry
 ;
ENTER(RETURN,IEN,STAT)  ; determine which MailMan message will be sent and to whom based on what the request status is.
 ;
 ;   Input:
 ;     IEN - internal record number of 8861 request
 ;     STAT - request status
 ;
 Q:(STAT="")!(IEN="") 
 I STAT="NEW" D RPCIN^DVBAVRX1(IEN,"NEW")  ; Send New notification to VHA Coordinator
 I STAT="PENDING" D RPCIN^DVBAVRX1(IEN,"PND")  ; Send Pending notification to vha Coordinator and VR&E staff
 I STAT="CANCELLED" D RPCIN^DVBAVRX1(IEN,"CAN")  ; Send Cancelled notification to VHA Coordinator and VR&E staff
 S RETURN=1
 Q
