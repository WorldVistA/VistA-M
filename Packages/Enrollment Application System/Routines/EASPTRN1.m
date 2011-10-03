EASPTRN1 ;ALB/EJG,GN - GENERATE EAS SUBPROCESSES ; 11/09/2004
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**30,33,47,42,59**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Cloned from IVMPTRN1
 ;
 ;EAS*1*47 - break up Z09's by Income year, via new "ATR" xref
 ;EAS*1*42 - add RXCP testing to Expired tag
 ;
 ;
DELMT ; send delete mt transaction if pt no longer meets IVM criteria
 ;
 ; Input - DFN
 ;         IVMMTDT - date of means test
 ;
 N I,IVMIY,X
 S IVMIY=$$LYR^DGMTSCU1(IVMMTDT)
 F I=1:1:5,8:1:14 S $P(X,HLFS,I)=HLQ
 S ^TMP("HLS",$J,HLSDT,IVMCT)="ZMT"_HLFS_X
 D CLOSE(IVMIY,DFN,2,3) ; set flag to stop future transmissions
 Q
 ;
 ;
CLOSE(IVMIY,DFN,IVMCS,IVMCR) ; Close IVM case record for a patient
 ; Input:    DFN  --  Pointer to the patient in file #2
 ;         IVMIY  --  Income year of the closed case
 ;         IVMCS  --  Closure source [1=IVM | 2=DHCP]
 ;         IVMCR  --  Pointer to the closure reason in file #301.93
 ;
 N DA,DIE,DR,X,Y,EVENTS,STATUS,EAEVENT,IVEVENT
 I '$G(IVMIY)!'$G(DFN)!'$G(IVMCS)!'$G(IVMCR) G CLOSEQ
 S IVMDELMT=1 ; flag indicates deletion
 S DA=$O(^IVM(301.5,"APT",+DFN,+IVMIY,0))
 I $G(^IVM(301.5,+DA,0))']"" G CLOSEQ
 ;
 ;don't want closing a case to stop transmission of an enrollment event
 S STATUS=1
 I ($$STATUS^IVMPLOG(+DA,.EVENTS)=0),EVENTS("ENROLL")=1 S STATUS=0
 ;
 ; If previous years event make sure Enrollment Event does not get 
 ; updated, and the IVM Event does
 ;
 S EAEVENT=1,IVEVENT=2
 I $G(EXPIRED)=1 S EAEVENT=2,STATUS=0,IVEVENT=1
 I $G(EXPIRED)=0 S EAEVENT=1,STATUS=0
 D NOW^%DTC S DR=".03////"_STATUS_";.04////1;1.01////"_IVMCR_";1.02////"_IVMCS_";1.03////"_%_";30.01////"_IVEVENT_";30.02////2;30.03////"_$G(EAEVENT)
 S DIE="^IVM(301.5," D ^DIE
CLOSEQ Q
 ;
 ;
PSEUDO ; strip P from pseudo SSNs before transmitting to IVM
 ;
 N X
 S X=IVMPID_$G(IVMPID(1))
 S $P(X,HLFS,20)=$E($P(X,HLFS,20),1,9) ; remove P
 K IVMPID S IVMPID=$E(X,1,245)
 I $L(X)>245 S IVMPID(1)=$E(X,246,999)
 Q
 ;
 ;Check if EDB Z06 in Annual Means Test file #408.31
 ; 'Z06 MT via Edb' will be stored in Comments if EDB Z06 Means Test
 ;
Z06MT(IVMMTIEN,Z06COM) N FLAG,LINE,COMMENT
 I '$G(IVMMTIEN) Q 0
 I $G(Z06COM)="" S Z06COM="Z06 MT via Edb"
 S (FLAG,LINE)=0
 F  S LINE=$O(^DGMT(408.31,IVMMTIEN,"C",LINE)) Q:'LINE!(FLAG)  D
 . S COMMENT=$G(^DGMT(408.31,IVMMTIEN,"C",LINE,0))
 . I COMMENT=Z06COM S FLAG=1 Q
 Q FLAG
 ;
 ;Retrieve Means Test information from incoming HL7 message.  
 ;
CHECKMT(DFN) N SOURCE,IVMLAST,IVMMTDT,IVMMTIEN
 I IVMTYPE'=1 Q    ;Only want MT = 1
 S SOURCE=$P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,22)
 S IVMMTDT=$$FMDATE^HLFNC($P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,2))
 S IVMLAST=$$LST^DGMTU(DFN,$E(IVMMTDT,1,3)_1231,1)
 S IVMMTIEN=+IVMLAST
 Q $$Z06MT(IVMMTIEN)
 ;
 ;Based upon DFN and MT Date find primary MT
 ;
VERZ06(DFN) N CMT,CMTDATE,MTIEN,PRIM
 S CMT=$$LST^DGMTU(DFN)
 S MTIEN=+CMT,CMTDATE=$P(CMT,"^",2)
 I 'MTIEN Q 0                             ;No Means Test found
 S PRIM=$G(^DGMT(408.31,MTIEN,"PRIM"))
 I PRIM,$$Z06MT(MTIEN) Q 1
 Q 0
 ;
 ;Check for expired MT or CT                                 ;EAS*1*42
 ;
EXPIRED(DFN,DGMTDT) N CMT,PMT,CCT,PCT
 S (CMT,PMT,CCT,PCT)=""
 S:DGMTYPT=2 PCT=$$LST^DGMTU(DFN,DGMTDT,2)     ;Retrieve previous CT
 S PMT=$$LST^DGMTU(DFN,DGMTDT,1)               ;Retrieve previous MT
 I PCT="",PMT="" Q 0
 S:DGMTYPT=2 CCT=$$LST^DGMTU(DFN,DT,2)         ;Retrieve current CT
 S CMT=$$LST^DGMTU(DFN,DT,1)                   ;Retrieve current MT
 ;check for any expired test
 I DGMTYPT=2,$P(PCT,"^",2)<$P(CCT,"^",2) Q 1   ;Prev Yr CT is Expired
 I $P(PMT,"^",2)<$P(CMT,"^",2) Q 1             ;Prev Yr MT is Expired
 Q 0
 ;
 ;Determine if Z09 should be sent to EDB or HEC legacy       ;EAS*1*47
 ; Input:  DFN
 ; Output: Where to Send Z09
 ;          0 - HEC Legacy
 ;          1 - EDB
 ;
WHERETO(ICYR,DFN) N COM,DATE,FOUND,FRMDATE,IEN,MIEN,ONODE,MTD,TYPE,Z06COM
 S FOUND=0
 S Z06COM="Z06 MT via Edb"
 S IEN=$O(^IVM(301.61,"ATR",ICYR,DFN,0)) I IEN="" Q FOUND
 S FRMDATE=$P($G(^IVM(301.61,IEN,0)),"^",5) I FRMDATE="" Q FOUND
 S TYPE=""
 F  S TYPE=$O(^DGMT(408.31,"AID",TYPE)) Q:TYPE=""!(FOUND)  D
 .S MTD=""
 .F  S MTD=$O(^DGMT(408.31,"AID",TYPE,DFN,MTD)) Q:MTD=""!(FOUND)  D
 ..S MIEN=""
 ..F  S MIEN=$O(^DGMT(408.31,"AID",TYPE,DFN,MTD,MIEN)) Q:MIEN=""!(FOUND)  D
 ...S ONODE=$G(^DGMT(408.31,MIEN,0))
 ...S DATE=$P(ONODE,"^",25)                     ;Use IVM Verified Date
 ...I DATE="" S DATE=$P(ONODE,"^",7)            ;Use Completed Date
 ...S COM=$G(^DGMT(408.31,MIEN,"C",1,0))        ;Comment
 ...I DATE'="",COM[Z06COM,FRMDATE>(DATE-1),$G(^DGMT(408.31,MIEN,"PRIM")) S FOUND=1
 Q FOUND
