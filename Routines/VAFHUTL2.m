VAFHUTL2 ;ALB/CM UTILITIES ROUTINE ;5/1/95
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
 ;
EBULL(DFN,EDATE,PIVOT,XMTEXT) ;
 ;This routine will generate an error bulletin when a segment and/or
 ;message was unable to be generated
 ;
 ;Input:  DFN    - Patient file 
 ;        EDATE  - event date/time in FileMan format
 ;        PIVOT  - pivot number
 ;        XMTEXT - global or array root (EX. "^TMP("), location of error message(s)
 ;
 ;
 S XMB="VAFH ADT/HL7 ERROR"
 D NOW^%DTC S XMDT=X K X
 S XMB(1)=$S(+DFN:$P($G(^DPT(DFN,0)),"^"),1:"UNKNOWN"),Y=EDATE
 D DD^%DT S XMB(2)=Y,XMB(3)=PIVOT K Y
 S XMDUZ=$S($D(DUZ):DUZ,1:.5)
 D ^XMB
 K XMB,XMDT
 Q
 ;
SET ;
 ;This is the set logic for the AHL7 cross reference on the PRIMARY
 ;LONG ID (.363) of the PATIENT file (#2)
 ;
 N KILL
 I $D(^TMP($J,"VAFHLMRG")) K ^TMP($J,"VAFHLMRG") S KILL="Y"
 I '$D(^TMP($J,"VAFHLMRG"))&('$D(KILL)) S ^TMP($J,"VAFHLMRG")=""
 Q
 ;
KILL(DFN,ENTRY) ;
 ;This is the kill logic for the AHL7 cross reference on the PRIMARY
 ;LONG ID (.363) of the PATIENT file (#2)
 ;
 I $D(^TMP($J,"VAFHSSN")) K ^TMP($J,"VAFHSSN"),^TMP($J,"VAFHLMRG")
 I '$D(^TMP($J,"VAFHLMRG")) D EN^VAFHDD("M",DFN,ENTRY)
 Q
