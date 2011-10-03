IBDFDE0 ;ALB/AAS - AICS Data Entry, Check out interview; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**29,36,44**;APR 24, 1997
 ;
% G ^IBDFDE
 ;
CHKOUT(SDOE) ; -- ask check out questions
 ; -- assumes forms are always for an appointment
 ;    does not require provider, cpt, or diag. to input data
 ;    acts same as input from scanned form.
 ;
 S IBQUIT=0
 W !!,">>> Check out interview..."
 ;
 ; -- can't check out future appointments
 I $E(IBDF("APPT"),1,7)>DT W "not available at this time." G CHKOUTQ
 ;
 ; -- get encounter if not already there (won't work unless appt exists)
 ;I 'SDOE S SDOE=$$GETAPT(DFN,IBDF("APPT"),IBDF("CLINIC"))
 ;
 ; -- see if already done, or needs to be done first
 S X=$$REQ(DFN,IBDF("APPT"),IBDF("CLINIC"),SDOE,$G(IBDCKOUT))
 I X<1 W $S(X=0:"no questions.",X=-2:"not required",X=-3:"already completed today",1:"already complete.") G CHKOUTQ
 W "required."
 ;
 ; -- ask eligibility/appt type ;not unless asked for
 ;S ELIG=$$ELAP^SDPCE(DFN,IBDF("APPT"))
 ;
 ; -- ask checkout Date
 S IBDPRE=$G(IBDCO("CO"))
 S X=$S($G(IBDCO("CO"))="":"NOW",1:$$FMTE^XLFDT(IBDCO("CO")))
 S IBDCO("CO")=$E($$ASKDT("Checkout Date: ",X,"",IBDF("APPT"),$$FMADD^XLFDT(DT,1)),1,12)
 I $G(IBDCO("CO"))="" K IBDCO W "   Checkout Deleted!" G CHKOUTQ
 I $G(IBDCO("CO"))<0 K:IBDPRE="" IBDCO("CO") W:IBDPRE="" "   Checkout Deleted!" S:IBDPRE IBDCO("CO")=IBDPRE S IBQUIT=1 G CHKOUTQ
 ;
 ; -- ask classifications
 I $$SC^SDCO22(DFN,+SDOE)!($D(IBDF("SC"))) S IBDCO("SC")=$$ASKYN("Was treatment for SC Condition",$G(IBDCO("SC")),"D SCCOND^IBDFN4") D
 .I $G(IBDCO("SC"))="" K IBDCO("SC") W "   Deleted!"
 I $G(IBDCO("SC"))<0 K IBDCO("SC") S IBQUIT=1 G CHKOUTQ
 ;
 I $G(IBDCO("SC")) G MST ; if service connected others don't apply
 ;
 I $$AO^SDCO22(DFN,+SDOE)!($D(IBDF("AO"))) S IBDCO("AO")=$$ASKYN("Was treatment related to Agent Orange Exposure",$G(IBDCO("AO"))) D
 .I $G(IBDCO("AO"))="" K IBDCO("AO") W "   Deleted!"
 I $G(IBDCO("AO"))<0 K IBDCO("AO") S IBQUIT=1 G CHKOUTQ
 ;
 I $$IR^SDCO22(DFN,+SDOE)!($D(IBDF("IR"))) S IBDCO("IR")=$$ASKYN("Was treatment related to  Ionizing Radiation Exposure",$G(IBDCO("IR"))) D
 .I $G(IBDCO("IR"))="" K IBDCO("IR") W "   Deleted!"
 I $G(IBDCO("IR"))<0 K IBDCO("IR") S IBQUIT=1 G CHKOUTQ
 ;
 I $$EC^SDCO22(DFN,+SDOE)!($D(IBDF("EC"))) S IBDCO("EC")=$$ASKYN("Was treatment related to Environmental Contaminant Exposure",$G(IBDCO("EC"))) D
 .I $G(IBDCO("EC"))="" K IBDCO("EC") W "   Deleted!"
 I $G(IBDCO("EC"))<0 K IBDCO("EC") S IBQUIT=1 G CHKOUTQ
 ;
MST ;- Ask Military Sexual Trauma question (patch IBD*3*36)
 I $$MST^SDCO22(DFN,+SDOE)!($D(IBDF("MST"))) S IBDCO("MST")=$$ASKYN("Was treatment related to MST (Note: ask provider only)",$G(IBDCO("MST"))) D
 .I $G(IBDCO("MST"))="" K IBDCO("MST") W "   Deleted!"
 I $G(IBDCO("MST"))<0 K IBDCO("MST") S IBQUIT=1 G CHKOUTQ
 ;
 I '$D(IBDCO) W "no questions."
CHKOUTQ I IBQUIT W !!,"Required information missing."
 K IBDPRE,SDFN
 Q
 ;
ASKYN(QUES,DEFLT,EXHELP) ; -- ask yes/no question
 N DIR,DIRUT,DUOUT,DTOUT
 I $G(EXHELP)'="" S DIR("??")="^"_EXHELP
 S DIR("A")=QUES,DIR(0)="YO",DIR("B")=$S($G(DEFLT):"Yes",1:"No") D ^DIR
 I $D(DIRUT),Y'="" S Y=-1 ;i y="" user typed "@"
 I $D(DTOUT)!($D(DUOUT)) S IBQUIT=1,Y=-1
 Q Y
 ;
ASKDT(QUES,DEFLT,PARAM,EARLY,LATEST,EXHELP) ; -- ask date questions
 N X,Y,DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="DOA^"_$E($G(EARLY),1,7)_":"_$G(LATEST)_":"_$S($G(PARAM)'="":PARAM,1:"AERX")
 I $G(QUES)'="" S DIR("A")=QUES
 I $G(DEFLT)'="" S DIR("B")=DEFLT
 I $L($G(EXHELP)) S DIR("??")="^"_EXHELP
 S DIR("?")="This response requires an appointment Date and Time"
 D ^DIR
 I $D(DIRUT),Y'="" S Y=-1 ;i y="" user typed "@"
 I $D(DTOUT)!($D(DUOUT)) S IBQUIT=1,Y=-1
 Q Y
 ;
REQ(DFN,APPT,CLINIC,SDOE,IBDC) ; is checkout interview required for this appt.
 N IBDY S IBDY=0
 I $$INP^SDAM2(DFN,APPT)="I" G REQQ ; inpatient appointment
 I '$$CLINIC^SDAMU(CLINIC) G REQQ ; not a clinic or non-count
 I $$REQ^SDM1A(APPT)'="CO" G REQQ ; checkout not required
 I $$EXCL(CLINIC,APPT) S IBDY=-2 G REQQ ; clinic stop codes are exempt
 I $$COMDT^SDCOU(+SDOE) S IBDY=-1 G REQQ ;process completed
 I $P($G(IBDC),".")=DT S IBDY=-3 G REQQ ;already checked out today
 S IBDY=1
REQQ K SDFN
 Q IBDY
 ;
EXCL(CL,DAT) ; -- are clinic stop codes exempt from classifications
 ; -- 1=yes, 0=no
 ;    original logic from exoe^sdcou2 except uses clinic stops rather
 ;    than outpatient encounter stops
 ;
 N SC1,SC2,EXMPT
 S SC1=$P($G(^SC(CL,0)),"^",7),SC2=$P($G(^SC(CL,0)),"^",18)
 I $$EX^SDCOU2(SC1,$G(DAT)) D
 .S EXMPT=1
 .I SC2,'$$EX^SDCOU2(SC2,$G(DAT)) S EXMPT=0
EXCLQ Q +$G(EXMPT)
 ;
WRITE(SDOE,CNT) ; -- print checkout interview
 W !?3,"Check out interview..."
 S X=$$REQ(DFN,IBDF("APPT"),IBDF("CLINIC"),SDOE)
 I X<1 W $S(X=0:"no questions.",1:"already complete.") G WRITEQ
 W "required."
 G:$D(IBDCO)'>1 WRITEQ
 ;D:$G(CNT)="" DISP
 D:$G(CNT)'="" LIST
 ;
WRITEQ Q
 ;
DISP ; -- display the old way
 I $D(IBDCO("CO")) W !,"                 Checkout Date: ",$$FMTE^XLFDT(IBDCO("CO"))
 I $D(IBDCO("SC")) W !,"    Treatment for SC Condition: ",$S(IBDCO("SC")=1:"YES",1:"NO")
 I $D(IBDCO("AO")) W !,"         Agent Orange Exposure: ",$S(IBDCO("AO")=1:"YES",1:"NO")
 I $D(IBDCO("IR")) W !,"   Ionizing Radiation Exposure: ",$S(IBDCO("IR")=1:"YES",1:"NO")
 I $D(IBDCO("EC")) W !,"    Environmental Contaminants: ",$S(IBDCO("EC")=1:"YES",1:"NO")
 I $D(IBDCO("MST")) W !,"                          MST: ",$S(IBDCO("MST")=1:"YES",1:"NO")
 Q
 ;
LIST ; -- display with a list
 I $D(IBDCO("CO")) S CNT=CNT+1 W !?3,CNT,?7,"Checkout Date ",?31,$$FMTE^XLFDT(IBDCO("CO"))
 I $D(IBDCO("SC")) S CNT=CNT+1 W !?3,CNT,?7,"SC Condition ",?31,$S(IBDCO("SC")=1:"YES",1:"NO")
 I $D(IBDCO("AO")) S CNT=CNT+1 W !?3,CNT,?7,"Agent Orange ",?31,$S(IBDCO("AO")=1:"YES",1:"NO")
 I $D(IBDCO("IR")) S CNT=CNT+1 W !?3,CNT,?7,"Ionizing Radiation ",?31,$S(IBDCO("IR")=1:"YES",1:"NO")
 I $D(IBDCO("EC")) S CNT=CNT+1 W !?3,CNT,?7,"Env. Contaminants ",?31,$S(IBDCO("EC")=1:"YES",1:"NO")
 I $D(IBDCO("MST")) S CNT=CNT+1 W !?3,CNT,?7,"MST ",?31,$S(IBDCO("MST")=1:"YES",1:"NO")
 Q
