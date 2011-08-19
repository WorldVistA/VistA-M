IBTRCD0 ;ALB/AAS - CLAIMS TRACKING - EXPAND CONTACTS SCREEN - CONT ; 02-JUL-1993
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ;
EN D CONT,APPEAL,INS,COMM,USER
 Q
 ;
CONT ; -- Contact infomation display
 N OFFSET,START
 S START=1,OFFSET=2
CON1 D SET^IBCNSP(START,OFFSET," Contact Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET,"    Contact Date: "_$$DAT1^IBOUTL(+IBTRCD,"2P"))
 D SET^IBCNSP(START+2,OFFSET,"Person Contacted: "_$E($P(IBTRCD,"^",6),1,20))
 D SET^IBCNSP(START+3,OFFSET,"  Contact Method: "_$$EXPAND^IBTRE(356.2,.17,$P(IBTRCD,"^",17)))
 D SET^IBCNSP(START+4,OFFSET,"Call Ref. Number: "_$E($P(IBTRCD,"^",9),1,20))
 D SET^IBCNSP(START+5,OFFSET,"     Review Date: "_$$DAT1^IBOUTL($P(IBTRCD,"^",24)))
 I '$P(IBTRCD,"^",2) D SET^IBCNSP(START+2,OFFSET,"Patient Contacted: "_$P($G(^DPT(+$P(IBTRCD,"^",5),0)),"^"))
 Q
 ;
APPEAL ; -- Appeals address infomation display
 N OFFSET,START
 S START=15,OFFSET=2
AP1 D SET^IBCNSP(START,OFFSET," Appeal Address Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET,"  Ins. Co. Name: "_$E($P($G(^DIC(36,+$P(IBTRCD,"^",8),0)),"^"),1,24))
 N APLAD S APLAD=$G(^DIC(36,+$P(IBTRCD,"^",8),.14))
 D SET^IBCNSP(START+2,OFFSET," Alternate Name: "_$P(APLAD,"^",7))
 D SET^IBCNSP(START+3,OFFSET,"  Street line 1: "_$P(APLAD,"^",1))
 D SET^IBCNSP(START+4,OFFSET,"  Street line 2: "_$P(APLAD,"^",2))
 D SET^IBCNSP(START+5,OFFSET,"  Street line 3: "_$P(APLAD,"^",3))
 D SET^IBCNSP(START+6,OFFSET," City/State/Zip: "_$P(APLAD,"^",4)_$S($P(APLAD,"^",4)]"":", ",1:"")_$P($G(^DIC(5,+$P(APLAD,"^",5),0)),"^",2)_"  "_$P(APLAD,"^",6))
 Q
 ;
INS ; -- Ins. Co. infomation display
 N OFFSET,START,IBCDFND,IBPHONE
 S START=9,OFFSET=2
ENINS ; -- entry point, must set start and offset
 D SET^IBCNSP(START,OFFSET+25," Insurance Policy Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET,"   Ins. Co. Name: "_$E($P($G(^DIC(36,+$P(IBTRCD,"^",8),0)),"^"),1,24))
 S IBCDFND=$G(^DPT(DFN,.312,+$P(IBTRCD1,"^",5),0))
 D SET^IBCNSP(START+2,OFFSET,"    Group Number: "_$$GRP^IBCNS($P(IBCDFND,"^",18)))
 D SET^IBCNSP(START+3,OFFSET," Whose Insurance: "_$$EXPAND^IBTRE(2.312,6,$P(IBCDFND,"^",6)))
 S IBPHONE=$G(^DIC(36,+$P(IBTRCD,"^",8),.13))
 S IBPHONE=$S($P(IBPHONE,"^",3)'="":$P(IBPHONE,"^",3),1:$P(IBPHONE,"^"))
 D SET^IBCNSP(START+4,OFFSET,"  Pre-Cert Phone: "_IBPHONE)
 D INS1
 Q
INS1 ; -- second site of Ins. info
 S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET,"Subscriber Name: "_$P(IBCDFND,"^",17))
 D SET^IBCNSP(START+2,OFFSET,"  Subscriber ID: "_$P(IBCDFND,"^",2))
 D SET^IBCNSP(START+3,OFFSET," Effective Date: "_$$DAT1^IBOUTL($P(IBCDFND,"^",8),"2P"))
 D SET^IBCNSP(START+4,OFFSET,"Expiration Date: "_$$DAT1^IBOUTL($P(IBCDFND,"^",4),"2P"))
 Q
 ;
USER ; -- display user information
 N OFFSET,START
 S START=15,OFFSET=45
USER1 D SET^IBCNSP(START,OFFSET," User Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET,"    Entered By: "_$P($G(^VA(200,+$P(IBTRCD1,"^",2),0)),"^"))
 D SET^IBCNSP(START+2,OFFSET,"    Entered On: "_$$DAT1^IBOUTL(+$P(IBTRCD1,"^"),"2P"))
 D SET^IBCNSP(START+3,OFFSET,"Last Edited By: "_$P($G(^VA(200,+$P(IBTRCD1,"^",4),0)),"^"))
 D SET^IBCNSP(START+4,OFFSET,"Last Edited On: "_$$DAT1^IBOUTL(+$P(IBTRCD1,"^",3),"2P"))
 Q
 ;
COMM ; -- Comment display
 N OFFSET,START,I,IBLCNT
 S START=23,OFFSET=2
COM1 D SET^IBCNSP(START,OFFSET," Comments ",IORVON,IORVOFF)
 S (IBLCNT,IBI)=0 F  S IBI=$O(^IBT(356.2,IBTRC,11,IBI)) Q:IBI<1  D
 .S IBLCNT=IBLCNT+1
 .D SET^IBCNSP(START+IBLCNT,OFFSET,"  "_$E($G(^IBT(356.2,IBTRC,11,IBI,0)),1,80))
 D SC
 Q
 ;
SC ; -- Service connected conditions
 S START=START+2+IBLCNT,OFFSET=2,IBCNT=0,IBLCNT=0
 D SC1^IBTRED01
 Q
