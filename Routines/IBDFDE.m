IBDFDE ;ALB/AAS - AICS Data Entry, Entry point by form ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3,51**;APR 24, 1997
 ;
 W !,?4,"** This option is OUT OF ORDER **" QUIT   ;Code set Versioning
 ;
% N %,%H,C,I,J,X,Y,ADD,DEL,ASKOTHER,DIR,DIC,DA,CNT,DFN,DIRUT,DUOUT,DTOUT,POP,RTN,FRMDATA,IBY,IBQUIT,IBDF,IBDOBJ,IBDPTSTI,IBDPTSTE,IBDPTNM,IBDPTDTI,SEL
 N IBDPTDTE,IBDFMNME,IBDFMIEN,IBDFMSTI,IBDFMSTE,IBDFMIDI,IBDCLNME,IBFORM,IBDCLNPH,IBDPID,IBDPTPRI,IBDSEL,IBDPI,IBDCO,PXCA,SDCLST,PXCASTAT,PXKNODA,PXKNODB,IBDREDIT,IBDASK,IBDPRE,IBDOK,IBD,IBDCKOUT
 N ANS1,AUPNDAYS,AUPNDOB,AUPNDOD,AUPNPAT,AUPNSEX
 ;
 I '$D(DT) D DT^DICRW
 D HOME^%ZIS
 W !!,"Data Entry of Encounter Forms (by Form)",!!
 ;
STRT ; -- ask for form id
 D END
 S DIR("?")="Enter the encounter form id, printed on the form.  This is the second number from the left, just right of the label 'ID:'."
 S DIR(0)="PO^357.96:AEQM",DIR("A")="Encounter Form ID" D ^DIR K DIR,DA,DR,DIC
 I $D(DIRUT) G END
 S IBDF("FORM")=+Y
 D EN
 ;
STRTQ I '$P($G(^IBD(357.09,1,0)),"^",6) D PAUSE
 G:IBQUIT END
 W @IOF
 Q:$G(IBDF("OPTION"))
 G STRT
 ;
EN ; -- entry point to edit one form,  
 ;    Input IBDF("FORM") := form number
 ;
 D:$D(XRTL) T0^%ZOSV
 N IBDSTRT,IBDFIN,IBDTIME S IBDSTRT=$H
 S IBQUIT=0
 L +^IBD(357.96,IBDF("FORM")):5 I '$T W !!,"Form is currently being entered by another user, try again later!" S IBFLAG=1 G ENQ
 I $G(^IBD(357.96,IBDF("FORM"),0))="" W !!,"Form Tracking Entry has been deleted, Data entry not available" S IBFLAG=1 G ENQ
 ;
OVER ; -- start here to re-edit an entry
 N IOINHI,IOINORM
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S (IBQUIT,IBDF("KILL"))=0
 D IDPAT^IBDFRPC3(.FRMDATA,IBDF("FORM"))
 D EXPAND(FRMDATA)
 I $P($G(^IBE(357,IBDFMIEN,0)),"^",12)'=1 W !!,"Form is not scannable.  Data entry not available" S IBFLAG=1 G ENQ
 ;
 I '$G(IBDF("FRMDEF")) W !!,"Form Definition entry not defined for form tracking entry.",!,"Data entry not available." D ERR S IBFLAG=1 G ENQ
 I $G(^IBD(357.95,+$G(IBDF("FRMDEF")),0))="" W !!,"Form Definition Entry has been deleted.",!,"Data entry not available." D ERR S IBFLAG=1 G ENQ
 I $P($G(^IBD(357.95,+$G(IBDF("FRMDEF")),0)),"^",21)="" W !!,"Can not determine Encounter Form from Form Tracking entry.",!,"Data entry not available." D ERR S IBFLAG=1 G ENQ
 I $G(^IBE(357,IBDFMIEN,0))="" W !!,"Encounter Form has been deleted.  Data entry not available." D ERR S IBFLAG=1 G ENQ
 I $G(^DPT(DFN,"S",IBDF("APPT"),0))'="",$P(^DPT(DFN,"S",IBDF("APPT"),0),"^",1)'=IBDF("CLINIC") W !!,"Form "_IBDF("FORM")_" is for an Appointment that has been canceled.",!,"Data entry not available." S IBFLAG=1 G ENQ
 S X=$P($G(^DPT(DFN,"S",IBDF("APPT"),0)),"^",2) I X'="","^C^N^NA^CA^PC^PCA^"[("^"_X_"^") W !!,"Form "_IBDF("FORM")_" is for an Appointment that has been canceled or no-showed.",!,"Data entry not available." S IBFLAG=1 G ENQ
 I '$P($G(^IBE(357,IBDFMIEN,0)),"^",5),'$G(IBDREDIT) D KILLTMP
 I '$G(IBDREDIT) D HDR
 ;
 I IBDFMSTI=3!(IBDFMSTI=6) D  I IBQUIT G ENQ ; -- already sent to pce
 .Q:$G(IBDREDIT)
 .S IBQUIT=1
 .W !!,"Current form Status is ",IBDFMSTE
 .W:'IBDCKOUT "."
 .W:IBDCKOUT " and was checked out",!,"on "_$$FMTE^XLFDT(IBDCKOUT)_", Status is "_$G(IOINHI)_IBDPTSTE_$G(IOINORM)_".",!
 .S DIR("?")="Data Entry on this form appears to have been completed by either scanning or data entry.  Deleting or editing of data is not allowed with this option.  Answer 'Yes' if you wish to continue, or 'No' if to select another form."
 .S DIR("?",1)="Enter ?? to see a list of data stored in PCE."
 .S DIR("?",2)=" "
 .S DIR("??")="^D WRITE^IBDFRPC5"
 .S DIR(0)="Y",DIR("B")="No",DIR("A")="Are you sure you want to continue"
 .D ^DIR K DIR I Y=1 S IBQUIT=0
 ;
 I +IBDCKOUT>0 D  I IBQUIT G ENQ ; -- already sent to pce
 .I IBDFMSTI=3!(IBDFMSTI=6) Q
 .Q:$G(IBDREDIT)
 .S IBQUIT=1
 .W !!,"Appointment has already been Checked Out on "_$$FMTE^XLFDT(IBDCKOUT)_",",!,"Status is: "_$G(IOINHI)_IBDPTSTE_$G(IOINORM)_".",!
 .S DIR("?")="This appointment appears to have been checked out on "_$$FMTE^XLFDT(IBDCKOUT)_".  Deleting or editing of data is not allowed with this option.  Answer 'Yes' if you wish to continue, or 'No' if to select another form."
 .S DIR("?",1)="Enter ?? to see a list of data stored in PCE."
 .S DIR("?",2)=" "
 .S DIR("??")="^D WRITE^IBDFRPC5"
 .S DIR(0)="Y",DIR("B")="No",DIR("A")="Are you sure you want to continue"
 .D ^DIR K DIR I Y=1 S IBQUIT=0
 ;
 I '$G(IBDREDIT),$G(^DPT(DFN,"S",IBDF("APPT"),0))="" S IBDOK=1 D FNDAPPT^IBDFDE1 I 'IBDOK W !!,"No action Taken",! G ENQ
 ;
 I '$D(^TMP("IBD-OBJ",$J,IBDFMIEN,0)) D FRMLSTI^IBDFRPC("^TMP(""IBD-OBJ"",$J,IBDFMIEN)",IBDFMIEN,"",1)
 I $O(^TMP("IBD-OBJ",$J,IBDFMIEN,0))="" W !,$G(^TMP("IBD-OBJ",$J,IBDFMIEN,0)),! G ENQ
 ;
NEWOVER ; -- start here to re-edit an entry
 I $G(IBDREDIT) D HDR
 D LISTOB
 D CHKOUT^IBDFDE0(IBDF("SDOE"))
 I '$G(IBDF("PROVIDER PI"))!($G(IBDF("PROVIDER"))) D DEFPROV^IBDFDE21
 ;
 K ^TMP("IBD-PI-CNT",$J)
 S I=0 F  S I=$O(^TMP("IBD-OBJ",$J,IBDFMIEN,I)) Q:I=""  D
 .S X=$P($G(^TMP("IBD-OBJ",$J,IBDFMIEN,I)),"^",2)
 .S ^TMP("IBD-PI-CNT",$J,X)=$G(^TMP("IBD-PI-CNT",$J,X))+1
 ;
 S I=0 F  S I=$O(^TMP("IBD-OBJ",$J,IBDFMIEN,I)) Q:I=""!(IBQUIT)  D
 .S IBDOBJ=$G(^TMP("IBD-OBJ",$J,IBDFMIEN,I))
 .S IBDF("PI")=+$P(IBDOBJ,"^",2),IBDF("TYPE")=$P(IBDOBJ,"^",5)
 .S IBDF("IEN")=+$P(IBDOBJ,"^",6),IBDF("VITAL")=$P(IBDOBJ,"^",7)
 .S IBDF("PAGE")=$P(IBDOBJ,"^",10)\80+1 ;scannable forms only
 .Q:IBDF("IEN")<1!(IBDF("PI")<1)
 .S IBDF("IBDF")=I
 .S RTN=$G(^IBE(357.6,IBDF("PI"),18)) Q:RTN=""
 .X RTN
 .I $G(IBDF("GOTO"))'="" S I=IBDF("GOTO") K IBDF("GOTO")
 K ^TMP("IBD-PI-CNT",$J)
 D FINAL^IBDFDE1 I $G(IBDREDIT) S IBQUIT=0 G OVER
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV
 ;
ENQ K SDFN
 L -^IBD(357.96,IBDF("FORM"))
 I $D(IBFLAG) D
 .I $P($G(^IBD(357.09,1,0)),"^",6) W !! D PAUSE
 .K IBFLAG
 Q
 ;
HDR ; -- print patient header
 W @IOF
 W IBDPTNM,?32,IBDPID,?47,$$FMTE^XLFDT($P($G(^DPT(DFN,0)),"^",3))
 W "    Form ID: ",$P(^IBD(357.96,IBDF("FORM"),0),"^")
 W !,$TR($J(" ",IOM)," ","=")
 W !,"      Clinic: ",$E(IBDCLNME,1,25) W ?40,"  Date/Time: ",IBDPTDTE
 W !,"   Form Name: ",$E(IBDFMNME,1,25) W ?40,"Form Status: ",$E(IBDFMSTE,1,25)
 Q
 ;
LISTOB ; -- header for input object list
 W !!,"Items available for Input:"
 D WRITE^IBDFDE0(IBDF("SDOE"))
 S I=0 F  S I=$O(^TMP("IBD-OBJ",$J,IBDFMIEN,I)) Q:I=""  D
 .S X=$G(^TMP("IBD-OBJ",$J,IBDFMIEN,I))
 .Q:'$P(X,"^",8)
 .S Y=$S($P(X,"^",7)="":$P(X,"^"),1:$P(X,"^",7))
 .I Y="INPUT PROVIDER" S IBDF("PROVIDER PI")=+$P(X,"^",2)
 .I Y["INPUT " S Y=$P(Y,"INPUT ",2)
 .W !?3,$E(Y,1,35)
 .;
 .F  S I=I+1 S X=$G(^TMP("IBD-OBJ",$J,IBDFMIEN,I)) Q:X=""!($P(X,"^",8))
 .Q:X=""
 .S Y=$S($P(X,"^",7)="":$P(X,"^"),1:$P(X,"^",7))
 .I Y="INPUT PROVIDER" S IBDF("PROVIDER PI")=+$P(X,"^",2)
 .I Y["INPUT " S Y=$P(Y,"INPUT ",2)
 .W ?40,$E(Y,1,35)
 ;
 W !,$TR($J(" ",IOM)," ","=")
 Q
 ;
EXPAND(X) ; -- sets standard varibles for form data
 S (DFN,IBDF("DFN"))=$P(X,"^",2) ;DFN
 S IBDF("CLINIC")=$P(X,"^",7) ;   clinic ien
 S IBDPTNM=$P(X,"^") ;    patient name
 S IBDPID=$P(X,"^",3) ;   Patient identifier (ssn)
 S IBDFMNME=$P(X,"^",4) ; form name
 S IBDFMIEN=$P(X,"^",5) ; form ien (pointer to 357)
 S IBDCLNME=$P(X,"^",6) ; clinic name
 S IBDCLNPH=$P(X,"^",8) ; clinic physical location
 S IBDF("APPT")=$P(X,"^",9) ; appt date/time (fm format)
 S IBDPTDTE=$P(X,"^",10) ;appt date (external format)
 S IBDPTSTI=$P(X,"^",11) ;appt status (piece two of "S" node)
 S IBDPTSTE=$P(X,"^",12) ;appt status expanded
 S IBDFMSTI=$P(X,"^",13) ;form status (internal)
 S IBDFMSTE=$P(X,"^",14) ;form status (expanded)
 S IBDF("FRMDEF")=$P(X,"^",15) ;form id (pointer to 357.95)
 S IBDPTPRI=$P(X,"^",16) ;default provider internal
 S IBDPTPRI=$P(X,"^",17) ;default provider external
 S IBDCKOUT=$P(X,"^",20) ;checkout dt
 S IBDF("SDOE")=$$FNDSDOE(DFN,IBDF("APPT")) ;outpatient encounter
 Q
 ;Q $$GETAPT^SDVSIT2(DFN,APPT,IBDF("CLINIC"))
 ; -- will create encounters for appts/unsch vsts (but not disps or ae?)
 ;
FNDSDOE(DFN,APPT) ; -- returns pointer to opt encounter for appt.
 N SDOE
 S SDOE=$P($G(^DPT(+$G(DFN),"S",+$G(APPT),0)),"^",20)
 I SDOE="",$G(^DPT(+$G(DFN),"S",+$G(APPT),0))="" S SDOE=$P($$SDV^IBDFRPC3(DFN,APPT),"^",2)
 Q SDOE
 ;
PAUSE ; -- go to bottom of screen and pause for return
 Q:$G(IBQUIT)
 N I,DIR,DIRUT,DUOUT,DTOUT I $Y'>(IOSL-3)  W !!
 I $E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR S IBQUIT='Y
 Q
 ;
END K I,J,X,Y,DA,DR,DIC,DIE,DIR,DTOUT,DUOUT,DIRUT,IBDSEL,CHOICE,TEXT,TEXTU,RESULT,IBDPI,IBDCO,IBDF
 K ^TMP("IBD-ASK",$J),^TMP("IBD-LCODE",$J),^TMP("IBD-LST",$J),^TMP("IBD-LTEXT",$J),^TMP("IBD-OBJ",$J)
 Q
 ;
KILLTMP K ^TMP("IBD-OBJ",$J,IBDFMIEN),^TMP("IBD-LST",$J,IBDFMIEN),^TMP("IBD-ASK",$J,IBDFMIEN),^TMP("IB",$J,"INTERFACES"),^TMP("IBD-LTEXT",$J,IBDFMIEN),^TMP("IBD-LCODE",$J,IBDFMIEN)
 Q
 ;
ERR ;
 W !!,"Entry in Form Tracking file (357.96) = ",$S($G(IBDF("FORM"))'="":IBDF("FORM"),1:"NULL")
 W !,"   Entry in Form Definition (357.95) = ",$S($G(IBDF("FRMDEF"))'="":IBDF("FRMDEF"),1:"NULL")
 W !,"  Entry if Encounter Form file (357) = ",$S($G(IBDFMIEN)'="":IBDFMIEN,1:"NULL"),!
 Q
