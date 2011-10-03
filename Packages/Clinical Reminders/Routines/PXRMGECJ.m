PXRMGECJ ;SLC/AGP,JVS - Restore Func ;7/14/05  10:42
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;Restore GEC Referral to open status
 Q
 ;
EN ;Starting point
 N DIR,DA,DFN,STATUS,NAME,STAMP,CNT,FIRST,SECOND,DIRUT
 K ^TMP("PXRMGEC_CK1",$J),DIR(0),^TMP("PXRMGEC_CK2",$J)
 D PAT
 I $D(DIRUT) Q
 ;
DISP ;Display referrals and data
 N LOC,DIV,SSN,AGE
 S NAME=$P(^DPT(DFN,0),"^",1)
 S LOC=$S($D(^DPT(DFN,.1)):"INPATIENT",1:"OUTPATIENT")
 S DIV=$$GET1^DIQ(2,DFN,.19) I DIV="" S DIV="Unknown"
 S SSN=$$GET1^DIQ(2,DFN,.09)
 S AGE=$$GET1^DIQ(2,DFN,.033)
 S STATUS=$$CK1(DFN)_"^"_$$CK2(DFN)
 ;
 ;
 W !,"================================================================================"
 W !,NAME," (",SSN,") "," AGE:",AGE,"  ",LOC,"  ",DIV," Division",!
 W !,?5,"Current Open Referral::"
 I +STATUS=0 W !,?10,"< N O N E >"
 I +STATUS=1 D
 .N I,DATE,DIALOG,USER,STAMP
 .S I=0 F  S I=$O(^TMP("PXRMGEC_CK1",$J,I)) Q:I=""  D
 ..S J=0 F  S J=$O(^TMP("PXRMGEC_CK1",$J,I,J)) Q:J=""  D
 ...S STAMP=$P(^TMP("PXRMGEC_CK1",$J,I,J),"^",2) I STAMP'="" S STAMP=$$FMTE^XLFDT(STAMP,"1P")
 ...S DIALOG=$$DIALOG($P(^TMP("PXRMGEC_CK1",$J,I,J),"^",3))
 ...S USER=$P(^TMP("PXRMGEC_CK1",$J,I,J),"^",5) I USER'="" S USER=$P(^VA(200,USER,0),"^",1)
 ...S DATE=$P(^TMP("PXRMGEC_CK1",$J,I,J),"^",6) I DATE'="" S DATE=$$FMTE^XLFDT(DATE,"1P")
 ...I J=1 W !,$O(^TMP("PXRMGEC_CK1",$J,0)),?10,STAMP_" (start date)"
 ...W !,?15,DIALOG,?35,"  by: ",USER," ",?62," On: ",DATE
 ;
 W !!,?5,"Historical Referral(s)::"
 I $P(STATUS,"^",2)=0 D
 .W !,?10,"< N O N E >"
 I $P(STATUS,"^",2)=1 D
 .N J,K,STAMP,STAMPB,DIALOG,USER,DATE,I,DAX,COUNT
 .S STAMPB=1,J=1,K=0,COUNT=$S($D(LOOP):5,1:0)
 .S I=1 F  S I=$O(^TMP("PXRMGEC_CK2",$J,I)),COUNT=COUNT+1 Q:I=""  Q:COUNT=3  D
 ..W !
 ..S K=0 F  S K=$O(^TMP("PXRMGEC_CK2",$J,I,K)) Q:K=""  D
 ...S DAX=0 F  S DAX=$O(^TMP("PXRMGEC_CK2",$J,I,K,DAX)) Q:DAX=""  D
 ....S STAMP=$P(^TMP("PXRMGEC_CK2",$J,I,K,DAX),"^",2)
 ....I STAMP'=STAMPB S J=J+1,CNT=I
 ....S CNTA=$O(^TMP("PXRMGEC_CK2",$J,0)),CNTB=CNTA+2
 ....S STAMP=$$FMTE^XLFDT(STAMP,"1P")
 ....S DIALOG=$$DIALOG($P(^TMP("PXRMGEC_CK2",$J,I,K,DAX),"^",3))
 ....S USER=$P(^TMP("PXRMGEC_CK2",$J,I,K,DAX),"^",5) I USER'="" S USER=$P(^VA(200,USER,0),"^",1)
 ....S DATE=$P(^TMP("PXRMGEC_CK2",$J,I,K,DAX),"^",6) I DATE'="" S DATE=$$FMTE^XLFDT(DATE,"1P")
 ....I STAMP'=STAMPB W !,I,?10,STAMP_" (start date)"
 ....W !,?15,DIALOG," ",?35,"  by: ",USER," ",?62," On: ",DATE
 ....S STAMPB=STAMP
 ;
ASK ;Ask the User what they want to do.
 N DIR,Y,X,MODE,ROPNNUM
 K DIR(0),DIR("A")
 I STATUS="0^1",CNT=2,'$D(LOOP) S DIR(0)="S^R:Re-open 1 Referral;V:View All Historical Referrals;P:New Patient;Q:Quit"
 I STATUS="0^1",CNT=2,$D(LOOP) S DIR(0)="S^R:Re-open 1 Referral;D:Display Last 2 Referrals Only;P:New Patient;Q:Quit"
 I STATUS="0^1",CNT>2,'$D(LOOP) S DIR(0)="S^R:Re-open 1 Referral;M:Merge 2 Referrals;V:View All Historical Referrals;P:New Patient;Q:Quit"
 I STATUS="0^1",CNT>2,$D(LOOP) S DIR(0)="S^R:Re-open 1 Referral;M:Merge 2 Referrals;D:Display Last 2 Referrals Only;P:New Patient;Q:Quit"
 I STATUS="1^1",'$D(LOOP) S DIR(0)="S^C:CLOSE Open Referral;M:Merge 2 Referrals;V:View ALL Historical Referrals;P:New Patient;Q:Quit"
 I STATUS="1^1",$D(LOOP) S DIR(0)="S^C:CLOSE Open Referral;M:Merge 2 Referrals;D:Display Last 2 Referrals Only;P:New Patient;Q:Quit"
 I STATUS="1^0"!(STATUS="0^0") S DIR(0)="S^C:CLOSE Open Referral;P:New Patient;Q:Quit"
 D ^DIR S MODE=Y W !
 I MODE="R" D
 .S DIR(0)="NO^"_$O(^TMP("PXRMGEC_CK2",$J,0))_":"_CNT_":0"
 .S DIR("A")="Enter the number on the Left side of the screen next to the Historical Referral that you want to re-open."
 .D ^DIR
 .S ROPNNUM=Y
 I MODE="M" D  I $D(DIRUT) G ASK
MRG .I STATUS="0^1" S DIR(0)="NO^"_CNTA_":"_$S($D(LOOP):CNT,1:CNTB)_":0"
 .I STATUS="1^1" S DIR(0)="NO^"_$O(^TMP("PXRMGEC_CK1",$J,0))_":"_CNT_":0"
 .S DIR("A")="First Referral Record"
 .D ^DIR Q:$D(DIRUT)  S FIRST=Y D  Q:$D(DIRUT)
 ..I STATUS="0^1" S DIR(0)="NO^"_CNTA_":"_$S($D(LOOP):CNT,1:CNTB)_":0"
 ..I STATUS="1^1" S DIR(0)="NO^"_$O(^TMP("PXRMGEC_CK1",$J,0))_":"_CNT_":0"
 ..S DIR("A")="Second Referral Record"
 ..D ^DIR Q:$D(DIRUT)  S SECOND=Y
 .I +FIRST>0,+SECOND>0,FIRST=SECOND W !,"Try again.." G MRG
 I MODE="Q" D EXIT
 I MODE="R" D REOPEN^PXRMGECL(ROPNNUM) G DISP
 I MODE="M" D MERGE(FIRST,SECOND,DFN) G DISP
 I MODE="V" S LOOP=1 G DISP
 I MODE="D" K LOOP G DISP
 I MODE="P" G EN
 I MODE="C" D FINISHED^PXRMGECU(DFN,1) G DISP
 Q
 ;
MERGE(FIR,SEC,DFN) ;Merge 2 Referrals
 Q:FIR=""
 Q:SEC=""
 Q:DFN=""
 N DATE1,DATE2,OLDDT,OLD,SRCHDT
 W !,"DO MERGE",!
 ;Get Date to use for setting and to be changed.
 I $D(^TMP("PXRMGEC_CK1",$J,FIR,1)) S DATE(FIR)=$P($G(^TMP("PXRMGEC_CK1",$J,FIR,1)),"^",2)
 I $D(^TMP("PXRMGEC_CK1",$J,SEC,1)) S DATE(SEC)=$P($G(^TMP("PXRMGEC_CK1",$J,SEC,1)),"^",2)
 I $D(^TMP("PXRMGEC_CK2",$J,FIR)) D
 .N SUB3,SUBDA
 .S SUB3=$O(^TMP("PXRMGEC_CK2",$J,FIR,0))
 .S SUBDA=$O(^TMP("PXRMGEC_CK2",$J,FIR,SUB3,0))
 .S DATE(FIR)=$P($G(^TMP("PXRMGEC_CK2",$J,FIR,SUB3,SUBDA)),"^",2)
 I $D(^TMP("PXRMGEC_CK2",$J,SEC)) D
 .N SUB3,SUBDA
 .S SUB3=$O(^TMP("PXRMGEC_CK2",$J,SEC,0))
 .S SUBDA=$O(^TMP("PXRMGEC_CK2",$J,SEC,SUB3,0))
 .S DATE(SEC)=$P($G(^TMP("PXRMGEC_CK2",$J,SEC,SUB3,SUBDA)),"^",2)
 S OLD(DATE(FIR))=FIR
 S OLD(DATE(SEC))=SEC
 S OLDDT=$O(OLD(0))
 S SRCHDT=$O(OLD(OLDDT))
 ;
 ;List of Health Factors DA's to change
 N DATE,ARY,GEC,DA,VISIT,ROOT,PKG,SOURCE
 N HF0,HF12,HF801,HF812,ARY1
 S ARY="^AUPNVHF(""AED"","_SRCHDT_","_DFN_")"
 S GEC="" F  S GEC=$O(@ARY@(GEC)) Q:GEC=""  D
 .S DA=0 F  S DA=$O(@ARY@(GEC,DA)) Q:DA=""  D
 ..S VISIT=$P($G(^AUPNVHF(DA,0)),"^",3)
 ..S ^TMP("PXRMGECMRG",$J,VISIT,DA,SRCHDT)=""
 ;
 ;Change HF with DATA2PCE
 S I=0
 S ROOT="^TMP(""PXRMGECMRGPCE"",$J)"
 S SOURCE="Geriatric Extended Care Merge"
 ;
 S ARY1="^TMP(""PXRMGECMRG"",$J)"
 S VISIT=0 F  S VISIT=$O(@ARY1@(VISIT)) Q:VISIT=""  D
 .S DA=0 F  S DA=$O(@ARY1@(VISIT,DA)) Q:DA=""  D
 ..I $D(^AUPNVHF(DA)) D
 ...S HF0=$G(^AUPNVHF(DA,0))
 ...S HF12=$G(^AUPNVHF(DA,12))
 ...S HF812=$G(^AUPNVHF(DA,812))
 ...;
 ...S PKG=$P(HF812,"^",2)
 ...S SOURCE=$P(HF812,"^",3)
 ...S USER=DUZ
 ...S @ROOT@("HEALTH FACTOR",DA,"HEALTH FACTOR")=$P(HF0,"^",1)
 ...S @ROOT@("HEALTH FACTOR",DA,"LEVEL/SEVERITY")=$P(HF0,"^",4)
 ...S @ROOT@("HEALTH FACTOR",DA,"ENC PROVIDER")=$P(HF12,"^",4)
 ...S @ROOT@("HEALTH FACTOR",DA,"EVENT D/T")=OLDDT
 .I $D(^TMP("PXRMGECMRGPCE",$J)) D
 ..N NOEVT
 ..S NOEVT="PXKNOEVT"
 ..S @NOEVT=1
 ..S OK=$$DATA2PCE^PXAPI(ROOT,PKG,SOURCE,.VISIT,USER,"","","")
 ;
 ;Change 801.55
 N GEC,DA,GECX,GECM
 ;
 S GEC="" F  S GEC=$O(^PXRMD(801.55,"AC",DFN,SRCHDT,GEC)) Q:GEC=""  D
 .S DA=0 F  S DA=$O(^PXRMD(801.55,"AC",DFN,SRCHDT,GEC,DA)) Q:DA=""  D
 ..S GECX(1,801.55,DA_",",.02)=OLDDT
 ..D FILE^DIE("","GECX(1)") K GECX
 ..;
 ..I FIR=$O(^TMP("PXRMGEC_CK1",$J,0)) D
 ...;I FIR=1!(SEC=1) D
 ...I '$D(^PXRMD(801.5,"AC",DFN,SRCHDT,GEC)) D
 ....S GECM(1,801.5,"+1,",.01)=$P($G(^PXRMD(801.55,DA,0)),"^",1)
 ....S GECM(1,801.5,"+1,",.02)=$P($G(^PXRMD(801.55,DA,0)),"^",2)
 ....S GECM(1,801.5,"+1,",.03)=$P($G(^PXRMD(801.55,DA,0)),"^",3)
 ....S GECM(1,801.5,"+1,",.04)=$P($G(^PXRMD(801.55,DA,0)),"^",4)
 ....S GECM(1,801.5,"+1,",.05)=$P($G(^PXRMD(801.55,DA,0)),"^",5)
 ....S GECM(1,801.5,"+1,",.06)=$P($G(^PXRMD(801.55,DA,0)),"^",6)
 ....D UPDATE^DIE("","GECM(1)")
 ;
 ;
 ;Change 801.5
 N GEC,DA,GECX
 ;
 S GEC="" F  S GEC=$O(^PXRMD(801.5,"AC",DFN,SRCHDT,GEC)) Q:GEC=""  D
 .S DA=0 F  S DA=$O(^PXRMD(801.5,"AC",DFN,SRCHDT,GEC,DA)) Q:DA=""  D
 ..S GECX(1,801.5,DA_",",.02)=OLDDT
 ..D FILE^DIE("","GECX(1)") K GECX
 ;EXIT
 K ^TMP("PXRMGECMRG",$J)
 K ^TMP("PXRMGECMRGPCE",$J)
 Q
 ;
 ;
PAT ;LOOK UP ALL PATIENTS
 W @IOF,!
 S DIR(0)="801.55,.01"
 D ^DIR
 S DFN=+Y
 K Y,Y(0),Y(0,0)
 Q
 ;
CK1(DFN) ;Check for current open referral
 Q:DFN'>0
 N STATUS,I,Z
 K ^TMP("PXRMGEC_CK1",$J)
 S STATUS=0,I=1,J=0
 ;S Z=$$CK2(DFN) S I=$O(^TMP("PXRMGEC_CK2",$J,0))-1
 I $D(^PXRMD(801.5,"B",DFN)) D
 .S DA=0 F  S DA=$O(^PXRMD(801.5,"B",DFN,DA)) Q:DA=""  S J=J+1 D
 ..S ^TMP("PXRMGEC_CK1",$J,I,J)=$G(^PXRMD(801.5,DA,0))
 .S STATUS=1
 Q STATUS
 ;
CK2(DFN) ;Check for entries in History file 801.55
 Q:DFN'>0
 N STATUS,I,CURRENT,DATE,DIA,DA,J
 K ^TMP("PXRMGEC_CK2",$J)
 S STATUS=0,I=1000,J=0
 I $D(^TMP("PXRMGEC_CK1",$J)) S CURRENT=$P($G(^TMP("PXRMGEC_CK1",$J,$O(^TMP("PXRMGEC_CK1",$J,0)),1)),"^",2)
 I $D(^PXRMD(801.55,"B",DFN)) D
 .S DATE="" F  S DATE=$O(^PXRMD(801.55,"AC",DFN,DATE)) Q:DATE=""  D
 ..Q:$G(CURRENT)=DATE
 ..S I=I-1
 ..S DIA="" F  S DIA=$O(^PXRMD(801.55,"AC",DFN,DATE,DIA)) Q:DIA=""  D
 ...S J=J+1
 ...S DA=0 F  S DA=$O(^PXRMD(801.55,"AC",DFN,DATE,DIA,DA)) Q:DA=""  D
 ....S ^TMP("PXRMGEC_CK2",$J,I,J,DA)=$G(^PXRMD(801.55,DA,0))
 ....S STATUS=1
 ;RENUMBER ARRAY
 I $D(^TMP("PXRMGEC_CK2",$J)) D
 .N OLD,NEW,J,DA,DATA
 .S NEW=1
 .S OLD=0 F  S OLD=$O(^TMP("PXRMGEC_CK2",$J,OLD)) Q:OLD=""  D
 ..S NEW=NEW+1
 ..S J=0 F  S J=$O(^TMP("PXRMGEC_CK2",$J,OLD,J)) Q:J=""  D
 ...S DA=0 F  S DA=$O(^TMP("PXRMGEC_CK2",$J,OLD,J,DA)) Q:DA=""  D
 ....S DATA=$G(^TMP("PXRMGEC_CK2",$J,OLD,J,DA))
 ....S ^TMP("PXRMGEC_CK2",$J,NEW,J,DA)=DATA
 ....K ^TMP("PXRMGEC_CK2",$J,OLD,J,DA)
 Q STATUS
 ;
DIALOG(DIA) ;Returns expanded name of dialog
 N NAME
 S NAME=""
 I DIA="GEC1" S NAME="Social Services"
 I DIA="GEC2" S NAME="Nursing Assessment"
 I DIA="GEC3" S NAME="Care Recommendation"
 I DIA="GECF" S NAME="Care Coordination"
 Q NAME
 ;
EXIT ;CLEAN UP
 K CK2,LOOP,X,CNTA,CNTB,ROPNNUM
 K ^TMP("PXRMGEC_CK1",$J),^TMP("PXRMGEC_CK2",$J)
 Q
 ;
