IBAECB1 ;WOIFO/AAT-LTC BILLING CLOCK INQUIRY ; 21-FEB-02
 ;;2.0;INTEGRATED BILLING;**171,176**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 Q
 ;
 ; Printing the report to the current device
 ; Input:
 ;   IBCLK - LTC Billing Clock IEN
 ;   IOST,IOSL,IOF Must be defined
 ; Output: IBQUIT=1 if user entered "^"
REPORT ;Print the report to the current device
 N IBZ,IBN4,IBDFN,IBPTZ,IBNAM,IBSSN,IBDOB,IBVET,IBFTN,IBTAB,IBDT1,IBDT2,IBSTA
 N:'$D(IBQUIT) IBQUIT
 S IBQUIT=0
 ;
 ; Define required data
 ;
 S IBZ=$G(^IBA(351.81,IBCLK,0)) I IBZ="" W !,"Data not found..." Q
 S IBDFN=+$P(IBZ,U,2) I 'IBDFN W !,"No patient data..." Q
 S IBPTZ=$G(^DPT(IBDFN,0)) I IBPTZ="" W !,"Patient data not found... (",IBDFN,")" Q
 S IBN4=$G(^IBA(351.81,IBCLK,4)) ; Node 4
 S IBNAM=$P(IBPTZ,U) ; Patient name
 S IBSSN=$P(IBPTZ,U,9) ; Patient SSN
 S IBDOB=$P(IBPTZ,U,3) ; Patient DOB
 S IBVET=+$P($G(^DPT(IBDFN,"TYPE")),U,1) ; Veteran type code
 S IBVET=$S(IBVET:$P($G(^DG(391,IBVET,0)),U),1:"") ; Veteran type name
 ; Write caption
 W IBNAM,?32," ",$$SSN(IBSSN),?48," ",$$DAT1(IBDOB),?62,IBVET
 W ! D LINE("=",80)
 ;
 ; The body of report
 S IBFTN=$P(IBZ,U)
 ;; W !,$$FRM("Facility Clock Number"),IBFTN
 S IBSTA=$P(IBZ,U,5)
 I 0 W !,$$FRM("LTC Copay Clock Status"),$$EXTERNAL^DILFD(351.81,.05,"",IBSTA)
 W !,$$FRM("LTC Copay Clock Start Date"),$$DAT2($P(IBZ,U,3))
 I 1 W ?56," Clock Status: ",$$EXTERNAL^DILFD(351.81,.05,"",IBSTA)
 W !,$$FRM("LTC Copay Clock End Date  "),$$DAT2($P(IBZ,U,4))
 I '$$SCR() W !
 ;;W !,$$FRM("Current Events Date"),$S($P(IBZ,U,7):$$DAT2($P(IBZ,U,7)),1:"none")
 ;;I '$$SCR() W !
 W !,$$FRM("Free Days Remaining"),+$P(IBZ,U,6)
 I $O(^IBA(351.81,IBCLK,1,0)) ; Not used yet 
 D FRDAYS Q:IBQUIT
 W ! D CHKPAUSE Q:IBQUIT
 W !,$$FRM("User Added Entry "),$$PERS($P(IBN4,U,1)) D CHKPAUSE Q:IBQUIT
 I 0 W !,$$FRM("Date Entry Added")
 E  W ?55
 W $$DAT2($P(IBN4,U,2)) D CHKPAUSE Q:IBQUIT
 W !,$$FRM("User Last Updated"),$$PERS($P(IBN4,U,3)) D CHKPAUSE Q:IBQUIT
 I 0 W !,$$FRM("Date Last Updated")
 E  W ?55
 W $$DAT2($P(IBN4,U,4))
 Q
 ;
 ;
 ; Fotmatting row labels
FRM(IBLBL,IBCUT) ;
 I $G(IBCUT,1) S IBLBL=$E(IBLBL,1,26)
 Q "  "_IBLBL_": "  ;;;$J("",26-$L(IBLBL))_":  "
 ;
SSN(IBSSN) I IBSSN?9N Q $E(IBSSN,1,3)_"-"_$E(IBSSN,4,5)_"-"_$E(IBSSN,6,9)
 Q IBSSN
 ;
DAT1(IBDAT) ;FM -> External date, like 12/25/2000
 Q $$FMTE^XLFDT(IBDAT,"5PMZ")
 ;
DAT2(IBDAT) ;FM -> External date, like OCT 25, 2001
 Q $$FMTE^XLFDT(IBDAT,"1PMZ")
 ;
 ; Draw a line, of characters IBC, length IBN
LINE(IBC,IBN) N IBL
 I $L($G(IBC))'=1 S IBC="="
 I +$G(IBN)=0 S IBN=80
 S $P(IBL,IBC,IBN+1)=""
 W IBL
 Q
 ; Person
PERS(IBIEN) ;
 I '$G(IBIEN) Q ""
 Q $P($G(^VA(200,IBIEN,0)),U)
 ;
 ; Input:
 ; IBCLK - LBC Billing Clock IEN
 ; IBQUIT - if defined, pauses will be made at the bottom of screen ("C-" devices only!)
 ; Output:
 ; IBQUIT=1 if user pressed "^". Only if IBQUIT was defined initially!
FRDAYS ; Write the list of exempt days
 N IBZ,IBV,IBC,IBI,IBA,IBN
 S IBZ=$G(^IBA(351.81,IBCLK,0)) I IBZ="" W !,"Corrupted record of LTC clock ",IBCLK Q
 S IBC=0 ; Counter of free days
 ; Collect an array of free days:
 S IBI=0 F  S IBI=$O(^IBA(351.81,IBCLK,1,IBI)) Q:'IBI  D:$P(^(IBI,0),U,2)
 . S IBC=IBC+1
 . S IBA(IBC)=$P(^IBA(351.81,IBCLK,1,IBI,0),U,2)
 ;I '$$SCR() W !,$$FRM("Days free of LTC copay")
 ;E
 W !,$$FRM("Days Not Subject To LTC Copay",0)
 I 'IBC W "none" Q
 S IBV=IBC\3 I IBC#3 S IBV=IBV+1
 F IBI=1:1:IBV D  Q:$G(IBQUIT)
 .  D:$D(IBQUIT) CHKPAUSE
 .  S IBN=IBI W !?5,$J(IBN,2),?10,$$FMTE^XLFDT(IBA(IBN))
 .  S IBN=IBI+IBV I $G(IBA(IBN)) W ?30,$J(IBN,2),?35,$$FMTE^XLFDT(IBA(IBN))
 .  S IBN=IBI+(2*IBV) I $G(IBA(IBN)) W ?55,$J(IBN,2),?60,$$FMTE^XLFDT(IBA(IBN))
 Q
 ;
PAUSE Q:'$$SCR()  ;Screen only
 N IBJ,DIR,DIRUT,DTOUT,DUOUT,DIROUT,Y,IOSL2
 S IOSL2=$S(IOSL>24:24,1:IOSL)
 F IBJ=$Y:1:(IOSL2-4) W !
 S DIR(0)="E" D ^DIR K DIR I $G(DUOUT) S IBQUIT=1
 Q
 ;
CHKPAUSE ;Check pause
 I $Y>(IOSL-5) D PAUSE Q:IBQUIT  W @IOF D LINE("-",80) W !
 Q
 ;
SCR() Q $E(IOST,1,2)="C-" ; Screen
