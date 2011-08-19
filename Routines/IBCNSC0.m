IBCNSC0 ;ALB/NLR - INSURANCE COMPANY EDIT -  ;12-MAR-1993
 ;;2.0; INTEGRATED BILLING ;**371**; 21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CLAIMS1 ; display Inpatient Claims information
 N OFFSET,START,IBCNS12,IBADD
 S START=27,OFFSET=2
 D SET^IBCNSP(START,OFFSET+20," Inpatient Claims Office Information ",IORVON,IORVOFF)
 S IBCNS12=$$ADDRESS(IBCNS,.12,5)
 D SET^IBCNSP(START+1,OFFSET," Company Name: "_$P($G(^DIC(36,+$P(IBCNS12,"^",7),0)),"^",1))
 D SET^IBCNSP(START+2,OFFSET,"       Street: "_$P(IBCNS12,"^",1))
 D SET^IBCNSP(START+3,OFFSET,"     Street 2: "_$P(IBCNS12,"^",2))
 N OFFSET S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET,"     Street 3: "_$P(IBCNS12,"^",3)) S IBADD=1
 D SET^IBCNSP(START+1+IBADD,OFFSET,"   City/State: "_$E($P(IBCNS12,"^",4),1,15)_$S($P(IBCNS12,"^",4)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCNS12,"^",5),0)),"^",2)_" "_$E($P(IBCNS12,"^",6),1,5))
 D SET^IBCNSP(START+2+IBADD,OFFSET,"        Phone: "_$P(IBCNS12,"^",8))
 D SET^IBCNSP(START+3+IBADD,OFFSET,"          Fax: "_$P(IBCNS12,"^",9))
 Q
 ;
R1Q Q
CLAIMS2 ; display Outpatient Claims information
 ;
 N OFFSET,START,IBCNS16,IBADD
 S START=34,OFFSET=2
 D SET^IBCNSP(START,OFFSET+20," Outpatient Claims Office Information ",IORVON,IORVOFF)
 S IBCNS16=$$ADDRESS(IBCNS,.16,6)
 D SET^IBCNSP(START+1,OFFSET," Company Name: "_$P($G(^DIC(36,+$P(IBCNS16,"^",7),0)),"^",1))
 D SET^IBCNSP(START+2,OFFSET,"       Street: "_$P(IBCNS16,"^",1))
 D SET^IBCNSP(START+3,OFFSET,"     Street 2: "_$P(IBCNS16,"^",2))
 N OFFSET S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET,"     Street 3: "_$P(IBCNS16,"^",3)) S IBADD=1
 D SET^IBCNSP(START+1+IBADD,OFFSET,"   City/State: "_$E($P(IBCNS16,"^",4),1,15)_$S($P(IBCNS16,"^",4)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCNS16,"^",5),0)),"^",2)_" "_$E($P(IBCNS16,"^",6),1,5))
 D SET^IBCNSP(START+2+IBADD,OFFSET,"        Phone: "_$P(IBCNS16,"^",8))
 D SET^IBCNSP(START+3+IBADD,OFFSET,"          Fax: "_$P(IBCNS16,"^",9))
 Q
 ;
ADDRESS(INS,NODE,PH) ; -- generic find address
 ;
 N IBX,INSSAVE,IBPH,IBFX,IBCNT,IBA
 S IBX="" ;S IBPH="",IBFX="",IBA=""
 ;
REDO ; gather insurance carrier's main address information 
 S IBX=$G(^DIC(36,+INS,.11)),IBPH=$P($G(^DIC(36,+INS,.13)),"^",1),IBFX=$P(IBX,"^",9)
 ;S IBCNT=$G(IBCNT)+1
 ;
 ; -- if process the same co. more than once you are in an infinite loop
 ;I $D(IBCNT(IBCNS)) G ADDREQ
 ;S IBCNT(IBCNS)=""
 ;
 ; -- gather address information from specific office (Claims, Appeals, Inquiry)
 ;
 I $P($G(^DIC(36,+INS,+NODE)),"^",5) S IBX=$G(^DIC(36,+INS,+NODE)),IBPH=$P($G(^DIC(36,+INS,.13)),"^",PH),IBFX=$P($G(IBX),"^",9)
 I $P($G(^DIC(36,+INS,+NODE)),"^",7) S INSSAVE=INS,INS=$P($G(^DIC(36,+INS,+NODE)),"^",7) I INSSAVE'=INS G REDO
 ;
ADDRESQ ; concatenate company name, address, phone and fax 
 S $P(IBA,"^",1,6)=$P($G(IBX),"^",1,6)
 S $P(IBA,"^",7)=INS
 S $P(IBA,"^",8)=IBPH
 S $P(IBA,"^",9)=IBFX
ADDREQ Q IBA
