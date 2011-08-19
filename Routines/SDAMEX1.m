SDAMEX1 ;ALB/MJK,RMO - Appointment Check In/Check Out Cont. ; 5/6/93
 ;;5.3;Scheduling;**27**;08/13/93
 ;
CK(DFN,SDCL,SDT,SDDA,SDACT) ; -- ask 'ok' and call check-in or check-out
 ;    input: DFN
 ;          SDCL := ifn of clinic
 ;          SDT := appt date/time
 ;          SDDA := ifn of ^sc multiple
 ;         SDACT := action CI or CO
 ;   output: none
 ; returned: check-in/check-out process called [1 := yes | 0 := no]
 ;
 N SDMAX
 W !
 ;
 I '$D(^SD(409.63,"ACO",1,+$$STATUS^SDAM1(DFN,SDT,SDCL,$G(^DPT(DFN,"S",SDT,0)),SDDA))) W !!,*7,">>> You can not check in/out this appointment." D PAUSE^VALM1 S Y=0 G CKQ
 ;
 S DIR(0)="Y",DIR("A")="Continue" D ^DIR K DIR
 I Y=0!($D(DIRUT)) S Y=0 G CKQ
 I SDACT="CI" D
 .D ONE^SDAM2(DFN,SDCL,SDT,SDDA,0,"")
 I SDACT="CO" D
 .D CO^SDCO1(DFN,SDT,SDCL,SDDA,1)
 W:$X>47 ! W ?47,"Status: ",$P($$STATUS^SDAM1(DFN,SDT,SDCL,$G(^DPT(DFN,"S",SDT,0)),SDDA),";",3)
 S Y=1
CKQ Q Y
