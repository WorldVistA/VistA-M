PRSASC1 ; HISC/MGD - File Approvals ;01/22/05
 ;;4.0;PAID;**55,93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 D NOW^%DTC S NOW=%
 F DA=0:0 S DA=$O(AP(1,DA)) Q:DA<1  D LV1
 F DA=0:0 S DA=$O(AP(2,DA)) Q:DA<1  D OT1
 F DA=0:0 S DA=$O(AP(3,DA)) Q:DA<1  D ED1
 S NX="" F  S NX=$O(AP(4,NX)) Q:NX=""  D TC1
 S NOD="AXR",NX="" F  S NX=$O(AP(5,NX)) Q:NX=""  D APP^PRSASC3
 D UPD^PRSASAL,APP^PRSASAL Q
LV1 ; Process action
 N SKIP
 S SKIP=0
 ; if action = approve and employee has any PTP memos
 I $P(AP(1,DA),"^",2)="A",$$PTP^PRSPUT3($P(AP(1,DA),"^",1)) D
 . N LVY0,PPLCK,PPLCKE,PRSEX
 . S LVY0=$G(^PRST(458.1,DA,0))
 . ; lock applicable time cards
 . D LCK^PRSPAPU($P(LVY0,U,2),$$FMADD^XLFDT($P(LVY0,U,3),-1),$P(LVY0,U,5),.PPLCK,.PPLCKE)
 . ; if problem locking time cards
 . I $D(PPLCKE) D
 . . S SKIP=1 ; set flag to skip approval of leave
 . . ; construct and send error message
 . . D LVEMSG
 . I '$G(SKIP),$D(PPLCK) D
 . . ; attempt to auto post leave to ESR
 . . D PLR^PRSPLVA(DA,,,.PRSEX)
 . . ; if fatal error during auto post
 . . I $D(PRSEX) D
 . . . S SKIP=1 ; set flag to skip approval of leave
 . . . ; construct and send error message
 . . . D LVEMSG
 . D TCULCK^PRSPAPU($P(LVY0,U,2),.PPLCK) ; remove any TC locks
 Q:SKIP
 S DFN=$P(AP(1,DA),"^",1),ACT=$P(AP(1,DA),"^",2),COM=$P(AP(1,DA),"^",3),X=ESNAM,X1=DUZ,X2=DA D EN^XUSHSHP
 S $P(^PRST(458.1,DA,0),"^",9)=ACT K ^PRST(458.1,"AR",DFN,DA)
 S $P(^PRST(458.1,DA,0),"^",12,14)=DUZ_"^"_NOW_"^"_X
 S:COM'="" $P(^PRST(458.1,DA,1),"^",1)=COM Q
OT1 ; Process action
 S DFN=$P(AP(2,DA),"^",1),ACT=$P(AP(2,DA),"^",2),COM=$P(AP(2,DA),"^",3),X=ESNAM,X1=DUZ,X2=DA D EN^XUSHSHP
 I ACT="S" S ^PRST(458.2,"AS",DFN,DA)=""
 S $P(^PRST(458.2,DA,0),"^",8)=ACT K ^PRST(458.2,"AR",DFN,DA)
 S $P(^PRST(458.2,DA,0),"^",13,15)=DUZ_"^"_NOW_"^"_X
 S:COM'="" $P(^PRST(458.2,DA,1),"^",1)=COM Q
ED1 ; Process action
 S DFN=$P(AP(3,DA),"^",1),ACT=$P(AP(3,DA),"^",2),COM=$P(AP(3,DA),"^",3),X=ESNAM,X1=DUZ,X2=DA D EN^XUSHSHP
 S $P(^PRST(458.3,DA,0),"^",9)=ACT K ^PRST(458.3,"AR",DFN,DA)
 S $P(^PRST(458.3,DA,0),"^",12,14)=DUZ_"^"_NOW_"^"_X
 S:COM'="" $P(^PRST(458.3,DA,1),"^",1)=COM D:ACT="A" ^PRSASC2 Q
TC1 ; Process action
 S DFN=$P(AP(4,NX),"^",1),ACT=$P(AP(4,NX),"^",2),PPI=$P(NX,"~",2)
 S X=ESNAM,X1=DUZ,X2=DFN D EN^XUSHSHP
 I ACT="A" F DAY=0:0 S DAY=$O(^PRST(458,"ATC",DFN,PPI,DAY)) G:DAY="" T1 S $P(^PRST(458,PPI,"E",DFN,"D",DAY,0),"^",5,7)=DUZ_"^"_NOW_"^"_X
 ; tour change(s) were disapproved or canceled so undo them
 S STAT=$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2) I STAT'="","PX"[STAT G T1
 S TYP="" F DAY=0:0 S DAY=$O(^PRST(458,"ATC",DFN,PPI,DAY)) Q:DAY=""  D
 .; special undo if tour change made to next pay period
 .I $P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),U,3)=2 D  Q
 ..S $P(^PRST(458,PPI,"E",DFN,"D",DAY,0),U,3,4)="^"
 ..S $P(^PRST(458,PPI,"E",DFN,"D",DAY,0),U,10,11)=DUZ_"^"_NOW
 .; tour change not made to next pay period
 .I $D(^PRST(458,PPI,"E",DFN,"D",DAY,4)) K ^(4) S $P(^(0),"^",13,15)="^^"
 .S TD=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",4),Y=$G(^PRST(457.1,+TD,1)),TDH=$P($G(^(0)),"^",6) D SET^PRSATE
 .Q
T1 K ^PRST(458,"ATC",DFN,PPI) Q
 ;
LVEMSG ; Construct and send a leave approval error message
 ; inputs LVY0,PPLCKE(),
 N LN,PRSARR,PRSI,PRST,TYPI,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 S PRST(1)="You recently entered an approval for the following leave request:"
 S PRST(2)=" "
 S PRST(3)="  Employee: "_$P($G(^PRSPC($P(LVY0,U,2),0)),U)
 S TYPI=$S($P(LVY0,U,7)'="":$O(^PRST(457.3,"B",$P(LVY0,U,7),0)),1:"")
 I TYPI S PRST(3)=PRST(3)_"   Type: "_$P($G(^PRST(457.3,TYPI,0)),U,3)
 S PRST(4)="  "_$P(LVY0,U,4)_" "_$$FMTE^XLFDT($P(LVY0,U,3))
 S PRST(4)=PRST(4)_"  to  "_$P(LVY0,U,6)_" "_$$FMTE^XLFDT($P(LVY0,U,5))
 S PRST(5)=" "
 S PRST(6)="The software was unable to save the approval of this leave"
 S PRST(7)="request and nothing has been changed.  The request will"
 S PRST(8)="continue to appear as a pending action under the Supervisory"
 S PRST(9)="Approvals option."
 S PRST(10)=" "
 S LN=10
 ; load lock problems (if any)
 I $D(PPLCKE) D
 . D RLCKE^PRSPAPU(.PPLCKE,0,"PRSARR")
 . S PRSI=0
 . F  S PRSI=$O(PRSARR(PRSI)) Q:'PRSI  S LN=LN+1,PRST(LN)=PRSARR(PRSI)
 ; load time card status problem (if any)
 I $G(PRSEX) D
 . S LN=LN+1,PRST(LN)="This leave request can not be approved because the employee is"
 . S LN=LN+1,PRST(LN)="a part-time physician with a memorandum of service level"
 . S LN=LN+1,PRST(LN)="expectations, and the leave request may impact a time card for"
 . S LN=LN+1,PRST(LN)="pay period "_$P($G(^PRST(458,PRSEX,0)),U)_" that has a status of Payroll."
 . S LN=LN+1,PRST(LN)="The request can be approved once the time card status changes."
 . S LN=LN+1,PRST(LN)="(i.e. returned to Timekeeper or transmitted to Austin)"
 S XMDUZ="PAID Package"
 S XMSUB="Unable to File Approval of Leave Request"
 S XMTEXT="PRST("
 S XMY(DUZ)=""
 D ^XMD
 Q
