IBAMTBU2 ;ALB/CPM - MEANS TEST BILLING BULLETINS (CON'T.) ; 15-JUN-93
 ;;2.0;INTEGRATED BILLING;**153,202**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
MT ; Generate the 'change in Means Test' bulletin.
 W:'DGMTINF !!,"Patient's Means Test billing status has changed..."
 K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - MEANS TEST CHANGE"
 S IBT(1)="A Means Test has been "_$S(DGMTP="":"added",DGMTA="":"deleted",1:"edited")_" for the following patient:"
 S IBT(2)=" ",IBC=2,IBDUZ=DUZ D PAT^IBAERR1 S IBC=IBC+1,IBT(IBC)=" "
 S Y=+IBMT D DD^%DT S IBC=IBC+1,IBT(IBC)="Test Date: "_Y
 S IBC=IBC+1,IBT(IBC)="   Status: "_$P($$MTS^DGMTU(DFN,+$P(IBMT,"^",3)),"^")
 I "^2^6^"[("^"_+$P(IBMT,"^",3)_"^") S IBT(IBC)=IBT(IBC)_$J("",$S($P(IBMT,"^",3)=2:11,1:21))_"Agrees to Pay Deductible? "_$S($P(IBMT,"^",11):"YES",$P(IBMT,"^",11)=0:"NO",1:"UNANSWERED")
 I $P(IBMT,"^",3)=3 D ELIG^VADPT I VAEL(3) S DIC="^DPT(",DR=.3012,DA=DFN,DIQ="IBDIQ",DIQ(0)="E" D EN^DIQ1 S IBDIQ=$G(IBDIQ(2,DFN,.3012,"E")),IBT(IBC)=IBT(IBC)_$J("",13)_"SC Award Date: "_$S(IBDIQ]"":IBDIQ,1:"Unknown")
 S Y=+$P(IBMT,"^",7) I Y D DD^%DT S IBC=IBC+1,IBT(IBC)="Completed: "_Y
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="This patient is no"_$S(IBCATCA:"w",1:" longer")_" billable for medical care copayments."
 D @$S(IBCATCP:"LCHG",1:"LEP") ; build bulletin for charges or episodes
 D MAIL^IBAERR1 ; send bulletin
 W:'DGMTINF "bulletin has been generated."
 Q
 ;
LCHG ; List charges in bulletin.
 N C,IBD,IBIL,IBN,IBND,X,Y
 S IBC=IBC+1,IBT(IBC)=$S($G(IBCANCEL):"Please note that the following charge(s) were automatically cancelled:",1:"The following charges have been billed since "_$$DAT1^IBOUTL($S(+$P(IBMT,"^",7):+$P(IBMT,"^",7),1:+IBMT))_":")
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="   Bill From  Bill To   Charge Type             Bill #  Status        Charge"
 S IBC=IBC+1,IBT(IBC)=$TR($J("",79)," ","=")
 ;
 ; - build detail lines
 S IBD="" F  S IBD=$O(IBARR(IBD)) Q:'IBD  S IBN=0 F  S IBN=$O(IBARR(IBD,IBN)) Q:'IBN  D
 .S IBND=$G(^IB(IBN,0)),IBIL=$P(IBND,"^",11)
 .S IBC=IBC+1,IBT(IBC)="   "_$$DAT1^IBOUTL(+$P(IBND,"^",14))_"   "_$$DAT1^IBOUTL(+$P(IBND,"^",15))_"  "
 .S X=$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^") S:$E(X,1,2)="DG" X=$E(X,4,99)
 .S IBT(IBC)=IBT(IBC)_X_$J("",24-$L(X))_$S(IBIL]"":$P(IBIL,"-",2)_"  ",1:$J("",8))
 .S Y=$P(IBND,"^",5),C=$P(^DD(350,.05,0),"^",2) D Y^DIQ
 .S IBT(IBC)=IBT(IBC)_Y_$J("",15-$L(Y))_"$"_$P(IBND,"^",7)
 ;
 I '$G(IBCANCEL) S IBC=IBC+1,IBT(IBC)=" ",IBC=IBC+1,IBT(IBC)="Please review these charges and cancel those that should not be billed."
 Q
 ;
LEP ; List episodes of care in bulletin.
 N IBD,IBN,IBX,X
 S IBC=IBC+1,IBT(IBC)="The following episodes of care have occurred since "_$$DAT1^IBOUTL($S(+$P(IBMT,"^",7):+$P(IBMT,"^",7),1:+IBMT))_":"
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Episode Date/Time      Type of Care   Ward/Clinic/Disposition/Appt Type"
 S IBC=IBC+1,IBT(IBC)=$TR($J("",79)," ","=")
 ;
 ; - build detail lines
 S IBD=0 F  S IBD=$O(IBARR(IBD)) Q:'IBD  S IBN="" F  S IBN=$O(IBARR(IBD,IBN)) Q:IBN=""  D
 .S IBX=IBARR(IBD,IBN),X=$$DAT2^IBOUTL(IBD)
 .S IBC=IBC+1,IBT(IBC)=X_$J("",23-$L(X))
 .D @$S(IBN["SC":"SC",1:IBN) S IBT(IBC)=IBT(IBC)_X
 ;
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Please review these episodes and add charges for those that should be billed."
 Q
 ;
SC ; Build string for Stop Codes.
 S X="STOP CODE      "_$E($P($G(^DIC(40.7,+IBX,0)),"^"),1,20)_" ("_$$FLD5^IBOVOP1(+$P(IBX,"^",2))_")"
 Q
 ;
APP ; Build string for Scheduled Appointments.
 S X="APPOINTMENT    "_$E($P($G(^SC(+IBX,0)),"^"),1,20)_" ("_$$FLD5^IBOVOP1(+$P(IBX,"^",2))_")"
 Q
 ;
R ; Build string for Registrations.
 S X="REGISTRATION   "_$P($G(^DIC(37,+IBX,0)),"^")
 Q
 ;
ADM ; Build string for Admissions.
 S X="ADMISSION      "_$P($G(^DIC(42,+IBX,0)),"^")
 Q
