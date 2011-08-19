PXRMXTA ; SLC/PJH - Reminder Reports Template Edit ;07/30/2009
 ;;2.0;CLINICAL REMINDERS;**4,12**;Feb 04, 2005;Build 73
 ; 
 ; Called from PXRMYD,PXRMXD
 ;
 ;Edit selected template or run report
 ;-------------------------------------
CANEDIT(TIEN) ;
 I $P($G(^PXRMPT(810.1,TIEN,0)),U,11)=DUZ Q 1
 I $D(^XUSEC("PXRM MANAGER",DUZ)) Q 1
 Q 0
 ;
START(ROUTINE) ;
 N DA,PXRMASK,PXRMEDIT,PXRMCOPY,MSG,DIC,NLOC
 N PXRMTREM,PXRMTCAT
 S PXRMASK="N",PXRMCOPY="N",PXRMEDIT="N"
 ;Option to edit/copy template
USE I 'PXRMUSER,$$CANEDIT($P(PXRMTMP,U)) D ASK(.PXRMASK) Q:$D(DUOUT)!$D(DTOUT)
 ;Option to edit template
 I PXRMASK="Y" D  Q:$D(DUOUT)!$D(DTOUT)
 .;Template edit and redisplay
 .D LOCK Q:$D(DUOUT)
 .D EDIT^PXRMXTE,UNLOCK
 .;Rollback changes on exit
 .I $D(DUOUT)!$D(DTOUT) D  Q
 ..D ROLL^PXRMXTF
 .;If all the templates have been deleted exit report
 .I '$$FIND^PXRMXT(PXRMTYP) S DTOUT=1 Q
 .;Check if template has been deleted 
 .I '$D(DA) S DUOUT=1 Q
 .;Sort out the filing
 .D ^PXRMXTF I $D(MSG) S DUOUT=1 Q
 ;
CHECK ;Check for missing fields
 N CNT,CRCNT,NODE,QUIT,RIEN
 S CNT=0,QUIT=0
 I PXRMSEL="R" F  S CNT=$O(PXRMLIST(CNT)) Q:CNT'>0  D
 .S NODE=$G(PXRMLIST(CNT))
 .I $P(^PXRMXP(810.5,$P(NODE,U),30,0),U,3)'>0 S QUIT=1 W !!,"PATIENT LIST: "_$P(NODE,U,2)_"DOES NOT CONTAIN PATIENTS!" Q
 ;I PXRMSEL="O" F  S CNT=$O(PXRMOTM(CNT)) Q:CNT'>0  D
 ;.S NODE=$G(PXRMOTM(CNT)) 
 ;.I $P(^OR(100.21,$P(NODE,U),10,0),U,3)'>0 S QUIT=1 W !!,"OE/RR TEAM: "_$P(NODE,U,2)_"DOES NOT CONTAIN PATIENTS!" Q
 S CNT=0
 I $D(PXRMRCAT)>0 F  S CNT=$O(PXRMRCAT(CNT)) Q:CNT'>0  D
 .S NODE=$G(PXRMRCAT(CNT))
 .S CRCNT=0 F  S CRCNT=$O(^PXRMD(811.7,$P(NODE,U),2,CRCNT)) Q:CRCNT'>0  D
 ..S RIEN=$P($G(^PXRMD(811.7,$P(NODE,U),2,CRCNT,0)),U)
 ..I $D(^PXD(811.9,RIEN))'>0 S QUIT=1 D
 ...W !!,"REMINDER CATEGORY: "_$P(NODE,U,2)_" CONTAINS A POINTER TO ONE OR MORE REMINDERS THAT DO"
 ...W !,"NOT EXIST ON THE SYSTEM!" Q
 I QUIT=1,'PXRMUSER W !!,"THE TEMPLATE NEEDS TO BE EDITED." H 2 G USE
 I QUIT=1,PXRMUSER W !!,"HAVE THE REMINDERS CLINICAL APPLICATION COORDINATOR CORRECT THE TEMPLATE." H 2 Q
 ;
FAC ;Option to combine multifacility report
 I "IRPO"'[PXRMSEL,NFAC>1 D  Q:$D(DTOUT)  I $D(DUOUT) Q:PXRMUSER  G USE
 .D COMB^PXRMXSD(.PXRMFCMB,"Facilities","N")
 ;
 ;Date range input (location only)
DAT I PXRMSEL="L" D  Q:$D(DTOUT)  I $D(DUOUT) Q:PXRMUSER  G USE
 .I PXRMFD="P" D PDR^PXRMXDUT(.PXRMBDT,.PXRMEDT,"ENCOUNTER")
 .I PXRMFD="F" D FDR^PXRMXDUT(.PXRMBDT,.PXRMEDT,"APPOINTMENT")
 .I PXRMFD="A" D PDR^PXRMXDUT(.PXRMBDT,.PXRMEDT,"ADMISSION")
 .I PXRMFD="C" S PXRMBDT=DT,PXRMEDT=DT
 ;Due Effective Date
EFF D SDR^PXRMXDUT(.PXRMSDT) Q:$D(DTOUT)
 I $D(DUOUT) G:PXRMSEL="L" DAT Q:PXRMUSER  G USE
 ;
 ;Check if combined location report is required
LCOMB S NLOC=0
 I PXRMREP="D",PXRMSEL="L" D  G:$D(DTOUT) EXIT G:$D(DUOUT) EFF
 .N DEFAULT,TEXT
 .D NLOC^PXRMXD
 .I NLOC>1 D COMB^PXRMXSD(.PXRMLCMB,TEXT,DEFAULT)
 ;
 ;Check if combined OE/RR team report is required
TCOMB S NOTM=0
 I PXRMREP="D",PXRMSEL="O" D  G:$D(DTOUT) EXIT G:$D(DUOUT) EFF
 .N DEFAULT,TEXT
 .S NOTM=$O(PXRMOTM(""),-1) I NOTM<2 Q
 .S DEFAULT="N",TEXT="OE/RR teams"
 .D COMB^PXRMXSD(.PXRMTCMB,TEXT,DEFAULT)
 ;
 ;Reminders Due sort and appointment date options
APPT I PXRMREP="D" D FUT Q:$D(DTOUT)  I $D(DUOUT) G:(PXRMSEL="L")&(NLOC>1) LCOMB G:(PXRMSEL="O")&(NOTM>1) TCOMB G EFF
 ;
 ;
 ;Option to print full SSN
SSN I PXRMREP="D" D  G:$D(DTOUT) EXIT G:$D(DUOUT) APPT
 .D SSN^PXRMXSD(.PXRMSSN)
 ;
 ;Option to print without totals, with totals or totals only
TOT I PXRMREP="S" D  Q:$D(DTOUT)  I $D(DUOUT) G EFF
 .;Default is normal report
 .S PXRMTOT="I"
 .;Ignore patient list and individual patient options
 .I "RI"[PXRMSEL Q
 .;Only prompt if more than one location, team or provider is selected
 .I PXRMSEL="P",'$O(PXRMPRV(1)) Q
 .I PXRMSEL="O",'$O(PXRMOTM(1)) Q
 .I PXRMSEL="T",'$O(PXRMPCM(1)) Q
 .;Ignore reports for all locations
 .I PXRMSEL="L",PXRMLCMB="Y" Q
 .I PXRMSEL="L" N DEFAULT,TEXT D NLOC^PXRMXD Q:NLOC<2
 .;Prompt for options
 .N LIT1,LIT2,LIT3
 .D LIT^PXRMXD,TOTALS^PXRMXSD(.PXRMTOT,LIT1,LIT2,LIT3)
 ;
SEPCS ;Allow users to determine the output of the Clinic Stops report
 D SEPCS^PXRMXSD(.PXRMCCS) G:$D(DTOUT) EXIT I $D(DUOUT) G:PXRMREP="D" SSN G TOT
 ;Option to print delimiter separated output
TABS D  G:$D(DTOUT) EXIT I $D(DUOUT) G:PXRMREP="D" SSN G TOT
 .D TABS^PXRMXSD(.PXRMTABS)
 ;
 ;Select chracter
TCHAR I PXRMTABS="Y" D  G:$D(DTOUT) EXIT G:$D(DUOUT) TABS
 .S PXRMTABC=$$DELIMSEL^PXRMXSD
 ;
DPAT ;Ask whether to include deceased and test patients.
 S PXRMDPAT=$$ASKYN^PXRMEUT("N","Include deceased patients on the list")
 N PXRMIDOD I PXRMDPAT>0 S PXRMIDOD=1
 Q:$D(DTOUT)  G:$D(DUOUT) TABS
TPAT ;
 S PXRMTPAT=$$ASKYN^PXRMEUT("N","Include test patients on the list")
 Q:$D(DTOUT)  G:$D(DUOUT) DPAT
PATLIST ;
 N PATLST,PATCREAT
 I PXRMSEL'="I"&(PXRMUSER=0) D
 . D ASK^PXRMXD(.PATLST,"Save due patients to a patient list: ",3)
 . I $G(PATLST)="" Q
 . I $G(PATLST)="N" S PXRMLIS1=""
 . I $G(PATLST)="Y" D
 . . S PATCREAT="N" D ASK^PXRMXD(.PATCREAT,"Secure list?: ",2)
 . . Q:$D(DTOUT)!($D(DUOUT))
 . . K PLISTPUG
 . . S PLISTPUG="N" D ASK^PXRMXD(.PLISTPUG,"Purge Patient List after 5 years?: ",5)
 I $G(PATLST)="" G:$D(DTOUT) EXIT I $D(DUOUT) G TPAT
 G:$D(DTOUT) EXIT I $D(DUOUT) G PATLIST
 I $G(PATLST)="Y" S TEXT="Select PATIENT LIST name: " D PLIST^PXRMLCR(.PXRMLIS1,TEXT,"") Q:$D(DUOUT)!$D(DTOUT)
 ;Initiate report
 D @ROUTINE
EXIT Q
 ;
 ;File locking
 ;------------
UNLOCK L -^PXRMPT(810.1,$P(PXRMTMP,U)) Q
LOCK L +^PXRMPT(810.1,$P(PXRMTMP,U)):0
 E  W !!?5,"Another user is editing this entry" S DUOUT=1
 Q
 ;
 ;Option to use report template
 ;-----------------------------
ASK(YESNO) ;
 N X,Y,TEXT
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")="WANT TO EDIT '"_$P(PXRMTMP,U,2)_"' TEMPLATE: "
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXTA(1)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
 ;General help text routine. Write out the text in the HTEXT array
 ;----------------------------------------------------------------
HELP(CALL) ;
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C70",DIWL=0,DIWR=70
 ;
 I CALL=1 D
 .S HTEXT(1)="Enter 'N' to run the report using the parameters from "
 .S HTEXT(2)="the existing template. Enter 'Y' to copy/edit the "
 .S HTEXT(3)="template."
 ;
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 Q
 ;
 ;Reminders Due specific prompts
 ;------------------------------
FUT ;For detailed report give option to display future appointments
 S PXRMFUT="N",PXRMDLOC="N"
 I PXRMREP="D" D  Q:$D(DTOUT)!$D(DUOUT)
 .D FUTURE^PXRMXSD(.PXRMFUT,"Display All Future Appointments: ",5)
 .I PXRMFUT="Y" D  Q:$D(DTOUT)!$D(DUOUT)
 ..D FUTURE^PXRMXSD(.PXRMDLOC,"Display Appointment Location: ",15)
 ;
SRT ;For detailed report give option to sort by appointment date
 S PXRMSRT="N"
 I PXRMREP="D",(PXRMSEL'="I") D  G:$D(DUOUT) FUT
 .;Inpatient report
 .S PXRMINP=$$INP^PXRMXD
 .;Option to sort by bed
 .I PXRMINP D BED^PXRMXSD(.PXRMSRT) Q
 .;Option to sort by appt date
 .D SRT^PXRMXSD(.PXRMSRT)
 ;
 Q
 ;
 ;Input validation for file #810.1
 ;
 ;If detail report allow only one reminder
PXRMREM I $P(^PXRMPT(810.1,DA(1),0),U,6)'="D" Q
 ;If template has no reminders ignore
 I +$P($G(^PXRMPT(810.1,DA(1),1,0)),U,4)=0 Q
 ;If this a new entry
 I $G(Y)=-1 K X W !,"Only one reminder allowed for detailed report."
 Q
 ;
 ;If changing from Summary to Detail report
PXRMREP Q:$G(X)'="D"
 Q:$P($G(^PXRMPT(810.1,DA,0)),U,6)'="S"
 Q:+$G(NREM)<2
 W !,"Only the first reminder on this template will be evaluated"
 Q
