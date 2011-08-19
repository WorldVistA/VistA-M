IBDFDE6 ;ALB/AAS - AICS Manual Data Entry, Entry point by clinic ; 29-APR-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**11,51**;APR 24, 1997
 ;
 W !,?4,"** This option is OUT OF ORDER **" QUIT   ;Code set Versioning
 ;
% N %,%H,C,I,J,X,Y,ADD,DEL,ASKOTHER,DIR,DIC,DA,CNT,DFN,DIRUT,DUOUT,DTOUT,POP,RTN,FRMDATA,IBY,IBQUIT,IBDF,IBDOBJ,IBDPTSTI,IBDPTSTE,IBDPTNM,IBDPTDTI,SEL,IBD,IBDCKOUT
 N IBDPTDTE,IBDFMNME,IBDFMIEN,IBDFMSTI,IBDFMSTE,IBDFMIDI,IBDCLNME,IBFORM,IBDCLNPH,IBDPID,IBDPTPRI,IBDSEL,IBDPI,IBDCO,PXCA,SDCLST,PXCASTAT,PXKNODA,PXKNODB,IBDREDIT,IBDASK,IBDPRE,IBDX,ANS,CLNAME,CLSETUP,IBDSC,FORM,FORMLST,IBDFDT,IBD
 ;
 I '$D(DT) D DT^DICRW
 D HOME^%ZIS
 W !!,"Data Entry of Encounter Forms (by Clinic)",!!
 ;
STRT ; -- ask for Clinic, date then patient.  
 ;    Only list patients w/no data entry
 ;    find all forms for appt., then go through 1 at a time
 ;
 D END
 S IBQUIT=0
 S (IBDSC,IBDF("CLINIC"))=$$SELCL G:IBQUIT STRTQ
 I IBDSC<1 S IBQUIT=1 G STRTQ
 S CLNAME=$P($G(^SC(+IBDSC,0)),"^")
 S CLSETUP=$G(^SD(409.95,+$O(^SD(409.95,"B",+IBDSC,0)),0))
 ;
APPT W ! S IBDFDT=$$SELAP(.IBDF) G:IBQUIT STRTQ
 I IBDFDT<0 W !! G STRT
 ;
 D BLD
 I '$D(^TMP("IBD-PL",$J,IBDF("CLINIC"))) W !!,"No appointments on that Date!",!! G APPT
 ;
OVER D HDR ;,LIST
 W !! D SELPT G:IBQUIT STRTQ
 S IBDF("OPTION")=1
 I $G(RESULT)="" G APPT
 I $G(RESULT)=-1 G OVERQ
 S (DFN,IBDF("DFN"))=+RESULT,IBDF("APPT")=$P(RESULT,"^",2)
 S FORMLST=$$FINDID^IBDF18C(DFN,IBDF("APPT"),"",1)
 I FORMLST]"" I IBDF("CLINIC")'=$P(^IBD(357.96,+FORMLST,0),"^",10) S FORMLST=""
 I FORMLST="" W !,"No forms Printed for Patient" D ANYWAY I IBQUIT G STRTQ
 I FORMLST="" G OVERQ ;D PAUSE^IBDFDE G OVERQ
 F IBDX=1:1 S IBDF("FORM")=$P(FORMLST,"^",IBDX) Q:IBDF("FORM")=""  I IBDF("FORM")'="" D EN^IBDFDE K IBDSEL,IBDPI Q:IBQUIT
 W !!
 ;S IBDF("CLINIC")=IBDSC
OVERQ G OVER
 ;
STRTQ ;D PAUSE^IBDFDE
 G:IBQUIT END
 G APPT
 ;
ANYWAY ; -- if no forms available ask if want to enter form anyway
 ;    all to use default form, clinic setup,or any form
 ;
 N X,Y,DIR,DIRUT
 S DIR("?")="If you wish to enter data for this patient anyway, chose whether to use the default form, select any form, or use the clinic setup.  Answer None if you don't wish to enter any data."
 S DIR("A")="Enter Data from [A]ny form, [C]linic Setup, [D]efault, [N]one: "
 S DIR(0)="SA^A:ANYFORM;C:CLINIC SETUP;D:DEFAULT;N:NONE",DIR("B")="CLINIC SETUP"
 I '$D(CLSETUP),+$G(IBDF("CLINIC")) S CLNAME=$P($G(^SC(+IBDF("CLINIC"),0)),"^"),CLSETUP=$G(^SD(409.95,+$O(^SD(409.95,"B",+IBDF("CLINIC"),0)),0))
 I CLSETUP="" S DIR("B")="DEFAULT" W !,"No Forms Defined for Clinic"
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) S IBQUIT=1 G ANYWAYQ
 I $D(DIRUT) G ANYWAYQ
 S ANS=Y
 I ANS="N" G ANYWAYQ
 ;
 I ANS="D" D  G ANYWAYQ
 .S IBFORM=$P($G(^IBD(357.09,1,0)),"^",4)
 .I IBFORM="" S IBFORM=$O(^IBE(357,"B","PRIMARY CARE SAMPLE V2.1",0))
 .S FORMLST=$$OTHFRM(IBFORM)
 .Q
 ;
 I ANS="A" D  G ANYWAYQ
 .S DIC("S")="I $P(^(0),U)'=""GARBAGE"",$P(^(0),U)'=""TOOL KIT"""
 .S DIC="^IBE(357,",DIC(0)="AEQM" D ^DIC K DIC Q:+Y<1
 .S IBFORM=+Y
 .S FORMLST=$$OTHFRM(IBFORM)
 .Q
 ;
 I ANS="C" D  G ANYWAYQ
 .F IBD=2,6,8,9,3,4 S IBFORM=$P(CLSETUP,"^",IBD) I IBFORM W ! S FORMLST=FORMLST_$$OTHFRM(IBFORM)_"^"
 .I FORMLST="" W !!,"No forms defined for clinic"
 .Q
ANYWAYQ Q
 ;
OTHFRM(IBFORM) ; -- if no form printed, add form tracking entry,
 ; -- compile form if necessary return form list
 N FORMID,FORMLST
 S FORMID=$P($G(^IBE(357,IBFORM,0)),"^",13)
 I FORMID="" D
 .W !,"Please wait, Creating the necessary entry..."
 .L +^IBE(357,IBFORM):1
 .S FORMID=$$FORMTYPE^IBDF18D(1) W "."
 .S $P(^IBD(357.95,FORMID,0),"^",21)=IBFORM W "."
 .S $P(^IBE(357,IBFORM,0),"^",13)=FORMID
 .S:$P(^IBE(357,IBFORM,0),"^",13) ^IBE(357,"ADEF",$P(^IBE(357,IBFORM,0),"^",13),IBFORM)=""
 .L -^IBE(357,IBFORM)
 S FORMLST=+$$FID^IBDF18C(DFN,IBDF("APPT"),1,FORMID,IBDF("CLINIC"))
 S DIE="^IBD(357.96,",DR=".11////20",DA=FORMLST D ^DIE K DA,DR,DIC,DIE
 ;
 Q FORMLST
 ;
SELCL() ; -- select clinic
 S IBQUIT=0
 N DIR,DA,DR,DIC,DIE,X,Y,ANS,DIRUT
 S ANS=-1
 S DIR("?")="Enter the name of the clinic that you are entering encounter forms for."
 S DIR("S")="I $P(^(0),U,3)=""C"""
 S DIR(0)="PO^44:AEQM",DIR("A")="Select Clinic" D ^DIR K DIR,DA,DR,DIC
 I $D(DUOUT)!($D(DTOUT)) S IBQUIT=1 G SELCLQ
 I $D(DIRUT) G SELCLQ
 S ANS=+Y
SELCLQ Q ANS
 ;
 ;
SELAP(IBDF) ; -- select appointment date for a clinic
 S IBQUIT=0
 N DIR,DA,DR,DIC,DIE,X,Y,ANS,DIRUT
 S ANS=-1
 ;I $G(LASTDATE)?7N S DIR("B")=$$FMTE^XLFDT(LASTDATE)
 ;R !,"Appointment Date: ",X:$G(DTIME)
 S DIR(0)="DO^:DT:EX",DIR("A")="Appointment Date"
 S DIR("?")="Enter the date for the clinic that you wish to enter encounter forms for"
 S DIR("??")="^D APDT^IBDFDE6"
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) S IBQUIT=1 G SELAPQ
 I $D(DIRUT) G SELAPQ
 S ANS=+Y
SELAPQ Q ANS
 ;
SELPT ; -- select patient(s) to process
 S IBDCLIN=IBDF("CLINIC") N ARRAY,CNT,IBD K IBDF,IBDCO,PXCA,SEL S IBDF("CLINIC")=IBDCLIN K IBDCLIN
 S (ARRAY,RESULT,ANS)="",(IBQUIT,CNT)=0
 S DIR("?")="Enter the listed number or the name of the patient or the last 4 number of the SSN or the first letter of the last name with the last 4 numbers of the SSN."
 S DIR("??")="^D LIST^IBDFDE6"
 S DIR(0)="FO^1:30",DIR("A")="Select Patient"
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) S IBQUIT=1 G SELQ
 S ANS=$$UP^XLFSTR(Y)
 I ANS="" G SELQ
 I $D(DIRUT) S IBQUIT=1 G SELQ
 I ANS=+ANS S ARRAY="IBD-PL" I $D(^TMP(ARRAY,$J,IBDF("CLINIC"),ANS)) S RESULT=^(ANS) W "   ",$P($G(^DPT(+RESULT,0)),"^") G SELQ
 ;
 I ANS?4N S ARRAY="IBD-PL4" D ARRAY(ARRAY,ANS) G FIND
 I ANS?1A4N S ARRAY="IBD-PLB" D ARRAY(ARRAY,ANS) G FIND
 S ARRAY="IBD-PLN" D ARRAY(ARRAY,ANS) D  G FIND
 .S NAME=ANS F  S NAME=$O(^TMP(ARRAY,$J,IBDF("CLINIC"),NAME)) Q:$E(NAME,1,$L(ANS))'=ANS  D ARRAY(ARRAY,NAME)
 G SELQ
FIND ;find appropriate pt appt from array
 I CNT=1 S RESULT=$G(^TMP(ARRAY,$J,IBDF("CLINIC"),$P(IBD(CNT),"^",2),+IBD(CNT))) D:$D(RESULT)  G SELQ
 .I ARRAY="IBD-PLN" W "   ",$E($P($G(^DPT(+RESULT,0)),"^"),($L(ANS)+1),999) Q
 .W "   ",$P($G(^DPT(+RESULT,0)),"^")
 S RESULT=$$MULT^IBDFDE61(CNT,.IBD) D:$D(RESULT)
 .W "   ",$P($G(^DPT(+RESULT,0)),"^")
 I RESULT="" W $C(7),"  ??  Not Found" S RESULT=-1
 ;
SELQ Q
 ;
ARRAY(ARRAY,ANS) ; -- bld array of multiple patients
 ; -- required variables:  array = name x-ref; ans = name of selection
 S A=0 F  S A=$O(^TMP(ARRAY,$J,IBDF("CLINIC"),ANS,A)) Q:'A  S CNT=CNT+1,IBD(CNT)=A_"^"_ANS
 Q
BLD ; -- Find all appointments for a date
 K ^TMP("IBD-PL",$J),^TMP("IBD-PLN",$J)
 N SC,IBD,IBD1,NODE,SNODE
 S IBD=IBDFDT,SC=IBDF("CLINIC"),CNT=0
 F  S IBD=$O(^SC(SC,"S",IBD)) Q:'IBD!(IBD>(IBDFDT+.24))  D
 .S IBD1=0 F  S IBD1=$O(^SC(SC,"S",IBD,1,IBD1)) Q:'IBD1  D
 ..S NODE=$G(^SC(SC,"S",IBD,1,IBD1,0))
 ..S SNODE=$G(^DPT(+NODE,"S",IBD,0))
 ..S X=$P(SNODE,"^",2)
 ..I X'="","CNAPCA"[X Q  ;inpatient appointments are okay
 ..S (DFN,IBDF("DFN"))=+NODE
 ..S CNT=CNT+1
 ..S ^TMP("IBD-PL",$J,SC,CNT)=DFN_"^"_IBD_"^"_SNODE
 ..S ^TMP("IBD-PLN",$J,SC,$P(^DPT(DFN,0),"^"),CNT)=DFN_"^"_IBD_"^"_SNODE
 ..S ^TMP("IBD-PLB",$J,SC,$E($P(^DPT(DFN,0),"^",1),1)_$E($P(^DPT(DFN,0),"^",9),6,9),CNT)=DFN_"^"_IBD_"^"_SNODE
 ..S ^TMP("IBD-PL4",$J,SC,$E($P(^DPT(DFN,0),"^",9),6,9),CNT)=DFN_"^"_IBD_"^"_SNODE
 Q
 ;
LIST ; -- print list of patients
 N IBD,IBJ,FORM,STATUS,CNT,X,IBQUIT
 S IBQUIT=0
 S IBD=0 F  S IBD=$O(^TMP("IBD-PL",$J,IBDF("CLINIC"),IBD)) Q:'IBD!(IBQUIT)  S NODE=$G(^TMP("IBD-PL",$J,IBDF("CLINIC"),IBD)) D ONE(NODE,IBD) I '(IBD#15) D ASKPT^IBDFDE61(IBD)
 Q
 ;
ONE(NODE,IBD1) ; -- write one line
 N CNT,C
 Q:$G(NODE)=""
 S DFN=+NODE,APPT=$P(NODE,"^",2)
 S FORM=$$FINDID^IBDF18C(DFN,APPT,"",1),STATUS="NO FORM PRINTED"
 S CNT=0 F IBJ=1:1 S X=$P(FORM,"^",IBJ) Q:X=""  S CNT=CNT+1
 I +FORM S Y=$P($G(^IBD(357.96,+FORM,0)),"^",11),C=$P(^DD(357.96,.11,0),"^",2) D Y^DIQ S STATUS=Y
 W !?2,IBD1,?5,$E($P(^DPT(DFN,0),"^"),1,18),?26,$P($G(^DPT(DFN,.36)),"^",4),?32,$$FMTE^XLFDT(+APPT),?52,$E($G(STATUS),1,24),?77,"("_CNT_")"
 Q
 ;
APDT ; -- list last 30 days appointment dates in clinic
 S (X,Y)=$$FMADD^XLFDT(DT,-62),CNT=0
 F  S X=$O(^SC(IBDF("CLINIC"),"S",X)) Q:'X!(X>DT)  D
 .I $E(X,1,7)=Y Q
 .S Y=$E(X,1,7),CNT=CNT+1
 .I CNT=1 W !!,"The following are valid Appointment dates in the past 60 days:"
 .W:(CNT#4=1) !,?3,$$FMTE^XLFDT(Y)
 .W:(CNT#4=2) ?20,$$FMTE^XLFDT(Y)
 .W:(CNT#4=3) ?40,$$FMTE^XLFDT(Y)
 .W:(CNT#4=0) ?60,$$FMTE^XLFDT(Y)
 Q
 ;
HDR ; -- print Clinic header
 N CNT,IBD,IBD1 W @IOF
 S CNT=0
 F IBD=2,6,8,9,3,4 S IBD1=$P(CLSETUP,"^",IBD) I IBD1 S CNT=CNT+1
 W !,"      Clinic: ",$E(CLNAME,1,25) W ?40,"         Date: ",$$FMTE^XLFDT(IBDFDT)
 S FORM=$P(CLSETUP,"^",2),IBDFMNME=$P($G(^IBE(357,+FORM,0)),"^")
 W !,"  Basic Form: ",$E(IBDFMNME,1,25) W ?40," Active Forms: ",CNT
 W !,"Appointments: ",$O(^TMP("IBD-PL",$J,IBDF("CLINIC"),""),-1)
 W !,$TR($J(" ",IOM)," ","=")
 Q
 ;
END K I,J,X,Y,DA,DR,DIC,DIE,DIR,DTOUT,DUOUT,DIRUT,IBDSEL,CHOICE,TEXT,TEXTU,RESULT,IBDPI,IBDCO,IBDF
 K ^TMP("IBD-PL",$J),^TMP("IBD-PLN",$J),^TMP("IBD-PLB",$J),^TMP("IBD-PL4",$J),^TMP("IBD-MORE",$J),^TMP("IBD-PLCHK",$J)
 K ^TMP("IBD-ASK",$J),^TMP("IBD-LCODE",$J),^TMP("IBD-LST",$J),^TMP("IBD-LTEXT",$J),^TMP("IBD-OBJ",$J)
 Q
