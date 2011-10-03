HLOAPI6 ;OIFO-OAK/RBN - VDEF HLO User interface API ;10/02/2008
 ;;1.6;HEALTH LEVEL SEVEN;**139**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ; No direct calls - must use $$VDEFPCK^HLOAPI5
 ;
 Q
 ;
VDEFPCK(LINK,APP,TYPE,EVENT) ;; VDEF PARAMETER CHECK function
 ;;
 ;; REQUIREMENT #4 HL*1.6*139
 ;;
 ;;  
 ;;  Description:
 ;;               This API is provided to allow VDEF to verify that HLO is installed,
 ;;               running and has all the required parameters for a specific HL7
 ;;               message type and HL7 event type.  These parameters must be defined
 ;;               prior to use by VDEF users before VDEF can use HLO.
 ;;
 ;;  Inputs :
 ;;            The input parameters are all required if used. 
 ;;            1 LINK : Name of HL7 logical link.
 ;;            2 APP  : Name of HLO application.
 ;;            3 TYPE : HL7 Message Type.
 ;;            4 EVENT: HL7 Event type.
 ;;
 ;;  Outputs: Returns
 ;;             With input parameters:
 ;;              1         VDEF Event 'xxxxx' parameters exists HLO Engine.
 ;;              0         HLO running but parameters for VDEF Event 'xxxx'don't exist.
 ;;             -1         HLO installed but not running on target system.
 ;;             -2         HLO not installed on target system.
 ;;               
 ;;             If input parameters are null:
 ;;              1         HLO installed and running.
 ;;             -1         HLO installed but not running on target system.
 ;;             -2         HLO not installed on target system.
 ;;
 ;;  Variables used:
 ;;               .
 ;;               PARM1   - IEN of link in HL&7 Logical Link file (#870)
 ;;               PARM2   - IEN of application in HLO APPLICATION registry file (#779.2)
 ;;               PARM3   - IEN of message type in MESSAGE TYPE ACTION subfile (#779.21)
 ;;               RESULT  - Return value.
 ;; 
 ;
 N RESULT,PARM1,PARM2,PARM3
 S RESULT=-2
 ; Is HLO installed?
 Q:$D(^HLD(779.1))=0 RESULT
 ;
 ; Is HLO running?
 S RESULT=-1
 Q:$P($G(^HLD(779.1,1,0)),"^",9)=0 RESULT
 ;
 ; null parameters, so exit with a 1
 S RESULT=1
 Q:'$G(LINK)&'$G(APP)&'$G(TYPE)&'$G(EVENT) RESULT
 ;
 ; Are the link, app and event setup?
 S RESULT=0
 S (PARM1,PARM2,PARM3)=""
 S PARM1=$O(^HLCS(870,"B",LINK,PARM1))
 S PARM2=$O(^HLD(779.2,"B",APP,PARM2))
 I (PARM1&PARM2) D
 . S PARM3=$O(^HLD(779.2,PARM2,1,"B",TYPE,PARM3))
 . ; Yes, so return a 1
 . I PARM3 D
 . .  S:$P(^HLD(779.2,PARM2,1,PARM3,0),"^",2)=EVENT RESULT=1
 Q RESULT
