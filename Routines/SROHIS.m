SROHIS ;BIR/ADM - MOVE REPORTS FOR HISTORICAL CASES TO TIU ; [ 01/22/04  11:19 AM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to $$WHATITLE^TIUPUTU supported by DBIA #3351
 ; Reference to MAKE^TIUSRVP supported by DBIA #3535
 ; Reference to UPDATE^TIUSRVP supported by DBIA #3535
 ; Reference to ZTSAVE("DUZ")=.5 supported by SACC exemption
 ;
 N SRINST,SRINSTP,SRN,SRRPT,SRPOS,SRSD,SRSDT,SRSOUT,X,Y
EN S SRSOUT=0 W @IOF,!,"Make Reports Viewable in CPRS",!!
 W ?3,"This option allows Operation Reports, Nurse Intraoperative Reports,",!,?3,"Anesthesia Reports and Procedure Reports (Non-O.R.) for historical cases"
 W !,?3,"to be moved into TIU as ""electronically unsigned"" to make them viewable",!,?3,"within the CPRS Surgery tab. Historical cases are cases performed before"
 W !,?3,"the Surgery Electronic Signature for Operative Reports feature was",!,?3,"implemented.",!
 W !,?3,"These ""electronically unsigned"" reports will contain a disclaimer",!,?3,"stating: ""This information is provided from historical files and cannot"
 W !,?3,"be verified that the author has authenticated/approved this information.",!,?3,"The authenticated source document in the patient's medical record should"
 W !,?3,"be reviewed to ensure that all information concerning this event has been",!,?3,"reviewed or noted.""",!
 W !,?3,"CAUTION!! This is a system intensive process that creates new documents",!,?3,"in TIU. Please ensure adequate disk space availability before running"
 W !,?3,"this process. Also, late activity messages may be suppressed by disabling",!,?3,"the mail group defined as the ""Late Activity Mail Group"" while this"
 W !,?3,"process runs. Upon completion, this mail group must be reestablished.",!
DATE K DIR S DIR("A")="Enter starting date for reports to be moved",DIR(0)="DO^:DT:AEPX",DIR("?")="Reports for all cases performed on this date to the present will be moved."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y G END
 S SRSD=Y
 S SRINST=$$INST() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
 W ! K DIR S DIR("A")="Do you want to move the Operation Reports (Y/N)? " D ASK G:SRSOUT END S SRRPT(1)=Y
 W ! K DIR S DIR("A")="Do you want to move the Nurse Intraoperative Reports (Y/N)? " D ASK G:SRSOUT END S SRRPT(2)=Y
 W ! K DIR S DIR("A")="Do you want to move the Anesthesia Reports (if used) (Y/N)? " D ASK G:SRSOUT END S SRRPT(3)=Y
 W ! K DIR S DIR("A")="Do you want to move the Procedure Reports (Non-O.R.) (Y/N)? " D ASK G:SRSOUT END S SRRPT(4)=Y W !
 I 'SRRPT(1),'SRRPT(2),'SRRPT(3),'SRRPT(4) W !,"No reports selected." D PRESS,END Q
 S Y=SRSD D DD^%DT S SRSDT=Y
 S DIR("A",1)="The following reports for cases performed "_SRSDT_" to the present",DIR("A",2)="for "_SRINST_" will be moved.",SRN=3
 I SRRPT(1) S DIR("A",SRN)="   Operation Report",SRN=SRN+1
 I SRRPT(2) S DIR("A",SRN)="   Nurse Intraoperative Report",SRN=SRN+1
 I SRRPT(3) S DIR("A",SRN)="   Anesthesia Report",SRN=SRN+1
 I SRRPT(4) S DIR("A",SRN)="   Procedure Report (Non-O.R.)",SRN=SRN+1
 S DIR("A",SRN)="",DIR("A")="Is this correct (Y/N)? " D ASK G:SRSOUT END G:'Y EN
 W ! S ZTRTN="MOVE^SROHIS",ZTDESC="Surgery - Make Reports Viewable in CPRS",ZTIO="",(ZTSAVE("SRSD"),ZTSAVE("SRRPT*"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"))="",ZTSAVE("DUZ")=.5 D ^%ZTLOAD
 I $D(ZTSK) W !!,"Queued as task #"_ZTSK
PRESS W !! S DIR(0)="FOA",DIR("A")="Press RETURN to continue. " D ^DIR
END W @IOF D ^SRSKILL
 Q
INST() ; determine division used by process
 N SR,SRCNT,SRINST,X S (SRCNT,X)=0 F  S X=$O(^SRO(133,X)) Q:'X  I '$P($G(^SRO(133,X,0)),"^",21) S SRCNT=SRCNT+1
 I SRCNT=1 S SRINST=$P($$SITE^SROVAR,"^",1,2) Q SRINST
 W ! K DIR,Y S DIR(0)="YO",DIR("?")="Enter 'Yes' to include all divisions, or 'No' to pick one division",DIR("A")="Move reports for all divisions",DIR("B")="YES" D ^DIR S SRINST=$S($G(Y(0))'="":Y(0),1:"^")
 I SRINST="YES" S SRINST=$P($$SITE^SROVAR,U,2)_" - ALL DIVISIONS"
 I SRINST="NO" D LIST^DIC(133,"",".01","B","*","","","","","","SR") W ! D
 .S X=0 F  S X=$O(SR("DILIST",1,X)) Q:'X  W !,X,". ",SR("DILIST",1,X)
 .K DIR W ! S DIR(0)="NO^1:"_$P(SR("DILIST",0),U),DIR("A")="Select Number",DIR("?")="Enter the corresponding number of the division for which you want to move reports" D ^DIR K DIR
 .S:+Y<1 SRINST="^" S:+Y>0 SRINST=SR("DILIST",2,+Y)
 Q $S(SRINST["ALL DIVISIONS":SRINST,SRINST=U:SRINST,1:$P(^SRO(133,SRINST,0),U)_U_SR("DILIST",1,+Y))
MOVE ; entry point when queued
 N DFN,SR0,SRDIV,SRED1,SRLOC,SRSD1,SRTIU,SRTN
 S SRED1=DT+.9999,SRSD1=SRSD-.0001
 F  S SRSD1=$O(^SRF("AC",SRSD1)) Q:SRSD1>SRED1!'SRSD1  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSD1,SRTN)) Q:'SRTN  I $$MANDIV^SROUTL0(SRINSTP,SRTN) D
 .S SR0=^SRF(SRTN,0),DFN=$P(SR0,"^"),SRDIV=$$SITE^SROUTL0(SRTN)
 .I $P($G(^SRF(SRTN,"NON")),"^")'="Y" D  Q
 ..I $P($G(^SRF(SRTN,.2)),"^",12) D
 ...D LOC^SROESX
 ...I SRRPT(1),'$P($G(^SRF(SRTN,"TIU")),"^"),$O(^SRF(SRTN,12,0)) D OR
 ...I SRRPT(2),'$P($G(^SRF(SRTN,"TIU")),"^",2) D NR
 ...I SRRPT(3),$P($G(^SRF(SRTN,.2)),"^",4),$$INUSE^SROESXA(SRTN),'$P($G(^SRF(SRTN,"TIU")),"^",4) D AR
 .I SRRPT(4),$P($G(^SRF(SRTN,"NON")),"^",5),'$P($G(^SRF(SRTN,"TIU")),"^",3),$P($G(^SRF(SRTN,"TIU")),"^",5)="",$O(^SRF(SRTN,12,0)) D NONOR
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D END
 Q
ASK S DIR(0)="YA",DIR("B")="NO" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 Q
OR ; create entry in TIU for operation report
 N SRAY,SRTIU,SRV,SRX,TITLE,VDT,VLOC,VSIT,X
 S SRX=$$WHATITLE^TIUPUTU("OPERATION REPORT"),TITLE=$P(SRX,"^") I 'TITLE Q
 S SRAY(.02)=DFN,SRAY(.05)=1,SRAY(1301)=$P(SR0,"^",9),SRAY(1302)=.5,SRAY(1303)="C",SRAY(1405)=SRTN_";SRF(",SRAY(1701)="Case #: "_SRTN
 D DISCLAIM,DICT
 S VDT=$P(SR0,"^",9),VLOC=SRLOC,VSIT=""
 I VLOC S SRAY(1211)=VLOC,VSTR=VLOC_";"_VDT_";E"
 D MAKE^TIUSRVP(.SRTIU,DFN,TITLE,VDT,VLOC,VSIT,.SRAY,$G(VSTR),1,1) I SRTIU S $P(^SRF(SRTN,"TIU"),"^")=SRTIU D STATUS(7)
 Q
NONOR ; create entry in TIU for non-or procedures
 N SRAY,SRTIU,SRV,SRX,TITLE,VDT,VLOC,VSIT,X
 D LOC^SROESXP
 S SRX=$$WHATITLE^TIUPUTU("PROCEDURE REPORT"),TITLE=$P(SRX,"^") I 'TITLE Q
 S SRAY(.02)=DFN,SRAY(.05)=1,SRAY(1301)=$P(SR0,"^",9),SRAY(1303)="C",SRAY(1405)=SRTN_";SRF(",SRAY(1701)="Case #: "_SRTN
 D DISCLAIM,DICT
 S SRV=$P(^SRF(SRTN,"NON"),"^",4),VDT=$S(SRV:SRV,1:$P(SR0,"^",9)),VLOC=SRLOC,VSIT=""
 I VLOC S SRAY(1211)=VLOC,VSTR=VLOC_";"_VDT_";E"
 D MAKE^TIUSRVP(.SRTIU,DFN,TITLE,VDT,VLOC,VSIT,.SRAY,$G(VSTR),1,1) I SRTIU S $P(^SRF(SRTN,"TIU"),"^",3)=SRTIU D STATUS(7)
 Q
NR ; create entry in TIU for nurse intraoperative report
 N SRAY,SRTIU,SRTXT,SRV,SRX,TITLE,VDT,VLOC,VSIT,X
 S SRX=$$WHATITLE^TIUPUTU("NURSE INTRAOPERATIVE REPORT"),TITLE=$P(SRX,"^") I 'TITLE Q
 S SRAY(.02)=DFN,SRAY(.05)=1,SRAY(1301)=$P(SR0,"^",9),SRAY(1303)="C",SRAY(1405)=SRTN_";SRF(",SRAY(1701)="Case #: "_SRTN
 D RPT^SRONRPT(SRTN),DISCLAIM
 S SRL=0,SRTXT=10 F  S SRL=$O(^TMP("SRNIR",$J,SRTN,SRL)) Q:'SRL  S SRAY("TEXT",SRTXT,0)=^TMP("SRNIR",$J,SRTN,SRL),SRTXT=SRTXT+1
 S VDT=$P(SR0,"^",9),VLOC=SRLOC,VSIT=""
 I VLOC S SRAY(1211)=VLOC,VSTR=VLOC_";"_VDT_";E"
 D MAKE^TIUSRVP(.SRTIU,DFN,TITLE,VDT,VLOC,VSIT,.SRAY,$G(VSTR),1,1) I SRTIU S $P(^SRF(SRTN,"TIU"),"^",2)=SRTIU D STATUS(7)
 K ^TMP("SRNIR",$J,SRTN)
 Q
AR ; create entry in TIU for anesthesia report
 N SRAY,SRTIU,SRTXT,SRV,SRX,TITLE,VDT,VLOC,VSIT,X
 S SRX=$$WHATITLE^TIUPUTU("ANESTHESIA REPORT"),TITLE=$P(SRX,"^") I 'TITLE Q
 S SRAY(.02)=DFN,SRAY(.05)=1,SRAY(1301)=$P(SR0,"^",9),SRAY(1303)="C",SRAY(1405)=SRTN_";SRF(",SRAY(1701)="Case #: "_SRTN
 D RPT^SROANR(SRTN),DISCLAIM
 S SRL=0,SRTXT=10 F  S SRL=$O(^TMP("SRANE",$J,SRTN,SRL)) Q:'SRL  S SRAY("TEXT",SRTXT,0)=^TMP("SRANE",$J,SRTN,SRL),SRTXT=SRTXT+1
 S VDT=$P(SR0,"^",9),VLOC=SRLOC,VSIT=""
 I VLOC S SRAY(1211)=VLOC,VSTR=VLOC_";"_VDT_";E"
 D MAKE^TIUSRVP(.SRTIU,DFN,TITLE,VDT,VLOC,VSIT,.SRAY,$G(VSTR),1,1) I SRTIU S $P(^SRF(SRTN,"TIU"),"^",4)=SRTIU D STATUS(7)
 K ^TMP("SRANE",$J,SRTN)
 Q
STATUS(SRSTAT) ; update status
 K SRAY S SRAY(.05)=SRSTAT,(SRAY(1202),SRAY(1204),SRAY(1208),SRAY(1209))="" D UPDATE^TIUSRVP(.SRDOC,SRTIU,.SRAY,1)
 Q
DICT ; get summary from surgeon's dictation field in file 130
 N SRL,SRTXT S SRL=0,SRTXT=10
 F  S SRL=$O(^SRF(SRTN,12,SRL)) Q:'SRL  S SRAY("TEXT",SRTXT,0)=^SRF(SRTN,12,SRL,0) S SRTXT=SRTXT+1
 Q
DISCLAIM ; disclaimer statement
 S SRAY("TEXT",1,0)=""
 S SRAY("TEXT",2,0)=" ************************************************************************"
 S SRAY("TEXT",3,0)=" *  DISCLAIMER: This information is provided from historical files and  *"
 S SRAY("TEXT",4,0)=" *  cannot be verified that the author has authenticated/approved this  *"
 S SRAY("TEXT",5,0)=" *  information.  The authenticated source document in the patient's    *"
 S SRAY("TEXT",6,0)=" *  medical record should be reviewed to ensure that all information    *"
 S SRAY("TEXT",7,0)=" *  concerning this event has been reviewed or noted.                   *"
 S SRAY("TEXT",8,0)=SRAY("TEXT",2,0),SRAY("TEXT",9,0)=""
 Q
