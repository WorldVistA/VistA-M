SDRROR ;10N20/MAH;Recall Reminder CPRS Display;01/15/2008
 ;;5.3;Scheduling;**536,561**;Aug 13, 1993;Build 7
 ;;This routine is called from ORWCV
 ;;and will be called if Outpatient Clinic param entry is either
 ;;null or cards
 ;VAR BEG,END,AND DFN WILL BE KILLED WITH OR ROUTINES
COVER ; GET RECALL DATES FOR A PATIENT
 ;At ORWCV TAG VST+24 ADD D COVER^SDRROR
 Q:BEG<1!(END<1)
 F RCIFN=0:0 S RCIFN=$O(^SD(403.5,"B",DFN,RCIFN)) Q:RCIFN<1  D
 .S RCX=$G(^SD(403.5,RCIFN,0)) Q:RCX=""
 .S RCDT=$P(RCX,U,6) Q:RCDT<BEG  Q:RCDT>END
 .S RCTYPE=$P(RCX,U,4),RCCLIN=$P(RCX,U,2)
 .S:RCTYPE]"" RCTYPE=$P($G(^SD(403.51,RCTYPE,0)),U,2)
 .S:RCCLIN]"" RCCLIN=$$GET1^DIQ(44,RCCLIN_",",.01)
 .S DATE1=RCDT S:$D(^TMP("ORVSTLIST",$J,RCDT)) DATE1=RCDT+.0001
 .S RCNODE="RECALL ("_RCTYPE_") "_RCCLIN,RCNODE=$E(RCNODE,1,45)
 .S ^TMP("ORVSTLIST",$J,DATE1,"R",1)="R;"_RCDT_";"_RCIFN_U_RCDT_U_RCNODE
 K RCIFN,RCX,RCTYPE,RCCLIN,RCDT,RCNODE,DATE1
 Q
RCDTL ; RECALL DETAILS At ORWCV TAG DTLVST+18 ADD I $P(APPTINFO,";")="R" D RCDTL^SDRROR
 S RPT(1)="The patient will be sent a letter prior to this date reminding them to make an"  ;SD*561 text changed to read 'prior to this date'
 S RPT(2)="appointment with the listed clinic."
 S RCIFN=$P(APPTINFO,";",3) Q:RCIFN=""
 S APPTINFO=$G(^SD(403.5,RCIFN,0)) Q:APPTINFO=""
 S COMM=$P(APPTINFO,U,7),FAST=$P(APPTINFO,U,8)
 S:FAST]"" FAST=$P($P(^DD(403.5,2.6,0),FAST_":",2),";")
 S RPT(3)="  "
 S:FAST]"" RPT(4)="Patient should be "_FAST
 S RPT($S(FAST]"":5,1:4))="Comment: "_COMM
 K RCIFN,COMM,FAST
 Q
