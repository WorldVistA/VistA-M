IBCNSC0 ;ALB/NLR - INSURANCE COMPANY EDIT -  ;12-MAR-1993
 ;;2.0;INTEGRATED BILLING;**371,547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
CLAIMS1 ; display Inpatient Claims information
 N OFFSET,START,IBCNS12,IBADD
 ;WCJ;IB*2.0*547
 ;S START=27,OFFSET=2
 S START=28+(2*$G(IBACMAX)),OFFSET=2
 D SET^IBCNSP(START,OFFSET+20," Inpatient Claims Office Information ",IORVON,IORVOFF)
 ;
 ;WCJ;IB*2.0*547;Call New API
 ;S IBCNS12=$$ADDRESS(IBCNS,.12,5)
 S IBCNS12=$$ADD2(IBCNS,.12,5)
 ;
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
 ;WCJ;IB*2.0*547
 ;S START=34,OFFSET=2
 S START=35+(2*$G(IBACMAX)),OFFSET=2
 D SET^IBCNSP(START,OFFSET+20," Outpatient Claims Office Information ",IORVON,IORVOFF)
 ;
 ;WCJ;IB*2.0*547;Call New API
 ;S IBCNS16=$$ADDRESS(IBCNS,.16,6)
 S IBCNS16=$$ADD2(IBCNS,.16,6)
 ;
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
 ; Only adding comments on patch 547.  Changes are on the ADD2 tag below.
 ; This tag is called from the Output formatter.
 ; It returns a "complete" address
 ; It judges an address complete if it has a state (don't ask why, I am just adding the comments)
 ; If the address it wants is not complete, it returns the main address.
 ; These addresses go out on claims and claims (X12 837) don't like partial addresses.
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
 ;
 ; WCJ;IB*2.0*547;
 ; This is a new tag which is just called from the insurance company editor screens.
 ; The billers/insurance verifiers want to see what data is actually in the insurance company file.
 ; They don't care if it's complete.  Heck, a phone number may be enough.
 ; This will just return what is in the file for the ins company that handles that type of claims.
 ; Input: INS - IREN to file 36
 ;        NODE - Node in File 36 (corresponds to Claims, Appeals, Inquiry...)
 ;        PH - Location of Phone number in node .13
ADD2(INS,NODE,PH) ;
 N IBX,INSSAVE,IBFX,IBPH,IBA
 F  S IBX=$G(^DIC(36,+INS,+NODE)) Q:'$P(IBX,U,7)  S INSSAVE=INS,INS=$P(IBX,U,7) Q:INSSAVE=INS
 ; concatenate company name, address, phone and fax  
 S IBPH=$P($G(^DIC(36,+INS,.13)),U,PH),IBFX=$P(IBX,U,9)
 S $P(IBA,U,1,6)=$P(IBX,U,1,6),$P(IBA,U,7)=INS,$P(IBA,U,8)=IBPH,$P(IBA,U,9)=IBFX
 Q IBA
