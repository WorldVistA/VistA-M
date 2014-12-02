HBHCUPD ;LR VAMC(IRMS)/MJT - HBHC update missing data in ^HBHC(631) using ^HBHC(634.1) & ^HBHC(634.3) as input for which records/fields to update, HBHC(634.2 errors must be corrected using PCE, 634.2 data killed @ end of processing ;3/18/14
 ;;1.0;HOSPITAL BASED HOME CARE;**2,6,8,10,24,25**;NOV 01, 1993;Build 45
 ; HBHC(634.7 MFH errors must be corrected using MFH option, 634.7 killed here so validity processing can occur again
 ;
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; $$SINFO^ICDEX is also called from the [HBHC UPDATE DISCHARGE] input template
 ; 
 I $P($G(^HBHC(631.9,1,0)),U,9)]"" K ^HBHC(634.7) S ^HBHC(634.7,0)="HBHC MEDICAL FOSTER HOME ERROR(S)^634.7P"
 I ('$D(^HBHC(634.1,"B")))&($D(^HBHC(634.2,"B")))&('$D(^HBHC(634.3,"B")))&('$D(^HBHC(634.5,"B"))) D PCEMSG^HBHCUTL3 S HBHCFLAG=1 G PSEUDO
PROMPT ; Prompt user for patient name
 W ! K DIC S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC
 G:Y=-1 PSEUDO
 S HBHCDPT=+Y
 I ('$D(^HBHC(634.1,"B",HBHCDPT)))&('$D(^HBHC(634.2,"B",HBHCDPT)))&('$D(^HBHC(634.3,"B",HBHCDPT)))&('$D(^HBHC(634.5,"B",HBHCDPT))) W $C(7),!!,"This patient has no records containing errors on file.",! H 3 G PROMPT
 F HBHCFILE=634.1,634.3 I $D(^HBHC(HBHCFILE,"B",HBHCDPT)) K DR S HBHCFORM=$S(HBHCFILE=634.1:3,1:5) S:HBHCFORM=5 HBHCCNT=1 S HBHCIEN="" F  S HBHCIEN=$O(^HBHC(HBHCFILE,"B",HBHCDPT,HBHCIEN)) Q:HBHCIEN=""  D PROCESS
 G PROMPT
PSEUDO ; Process pseudo SSN message
 I '$D(HBHCFLAG) D:$D(^HBHC(634.2,"B")) PCEMSG^HBHCUTL3
 I $D(^HBHC(634.5,"B")) D PSEUDO^HBHCUTL3 K ^HBHC(634.5) S ^HBHC(634.5,0)="HBHC PSEUDO SSN ERROR(S)^634.5P^"
EXIT ; Exit module
 ; HBHC(634.2 visit errors must be corrected using PCE software, 634.2 killed here so validity processing can occur again
 K ^HBHC(634.2) S ^HBHC(634.2,0)="HBHC VISIT ERROR(S)^634.2P^"
 K DA,DIC,DIE,DIK,DR,HBHC,HBHC12,HBHC359,HBHCAFLG,HBHCCNT,HBHCCOLM,HBHCDATE,HBHCDFLG,HBHCDFN,HBHCDIED,HBHCDPT,HBHCDR,HBHCDT,HBHCFILE,HBHCFLAG,HBHCFLG,HBHCFORM,HBHCI,HBHCIEN,HBHCJ,HBHCKEEP,HBHCL,HBHCM,HBHCMSG,HBHCNOD1,HBHCPC,HBHCQ
 K HBHCQ1,HBHCRFLG,HBHCSUB,HBHCTFLG,HBHCTXT,HBHCUPD,HBHCWRD1,HBHCWRD2,HBHCWRD3,HBHCY0,Y
 Q
PROCESS ; Process errors via DIE
 N HBHCDRA,HBHCDRD,HBHC39,HBHC46
 S HBHCDRA="" ;Test for ICD-9 second ^DIE call
 S DA=$P(^HBHC(HBHCFILE,HBHCIEN,0),U,2),HBHCTXT=$S(HBHCFORM=3:"Evaluation/Admission",1:"Discharge")
 L +^HBHC(631,DA):0 I '$T W $C(7),!!,"Another user is editing this "_HBHCTXT_" entry.",! H 3 Q
 ; If Pri DX @ Admission (#18) call DXCHKA to adjust for ICD-9/ICD-10
 I HBHCFORM=3 D
 .S (DR,HBHCDR)=^HBHC(HBHCFILE,HBHCIEN,1)
 .I DR["18;" D DXCHKA1(DA)
 ; For Discharges check for #39 and/or #46
 I HBHCFORM=5 D
 .; Call DXCHKD1 now to update the necessary fields in the Global which is indexed sequentially
 .; and adjust DR string;
 .; If DISCHARGE DATE #39 AND PRI DX @ DISCHARGE #46 are being edited, #46 and all remaining fields
 .; will be saved off in HBHCDRD and prompted for in second ^DIE call after #39 was edited in first ^DIE call
 .D DXCHKD1(DA,HBHCIEN)
 .S HBHCSUB=0
 .; Load fields to be edited from #634.3 into DR array
 .F  S HBHCSUB=$O(^HBHC(HBHCFILE,HBHCIEN,HBHCSUB)) Q:HBHCSUB'>0  D SET
 K DIE S DIE="^HBHC(631,",DIE("NO^")="OUTOK"
 S HBHC=HBHCIEN,HBHCPC=$S(HBHCFORM=5:40,1:18),HBHCCOLM=$S(HBHCFORM=3:14,1:19)
 S HBHCDT=$P($G(^HBHC(631,DA,0)),U,HBHCPC) S:HBHCDT="" HBHCDT=$P($G(^HBHC(631,DA,0)),U,2) S HBHCDATE=$S(HBHCDT]"":$E(HBHCDT,4,5)_"-"_$E(HBHCDT,6,7)_"-"_$E(HBHCDT,2,3),1:"")
 W !!!?HBHCCOLM,"===  Editing "_$S(HBHCDATE]"":HBHCDATE_" "_HBHCTXT,1:HBHCTXT)_" data  ===",!
 D ^DIE K DR,ICDVDT,ICDSYS,ICDFMT,HBHCDFN
 ; Admissions - Check for second ^DIE call to process #18
 I HBHCFORM=3,HBHCDRA'="" D
 .; Load remaining Admissions fields into DR
 .D DXCHKA2(DA)
 .K DIE S DIE="^HBHC(631,",DIE("NO^")="OUTOK"
 .D ^DIE
 .K DR,ICDVDT,ICDSYS,ICDFMT,HBHCDFN
 ; Discharges - Check for second ^DIE call to process #46
 I HBHCFORM=5,$D(HBHCDRD)=10 D
 .; Load remaining Discharge fields into DR
 .D DXCHKD2(DA)
 .K DIE S DIE="^HBHC(631,",DIE("NO^")="OUTOK"
 .D ^DIE
 .K DR,ICDVDT,ICDSYS,ICDFMT
 ; Admit/Reject Action branch
 S:HBHCDR["14;" DR="K HBHCQ;S X=$P(^HBHC(631,DA,0),U,15);D ACTION^HBHCUTL;15;16;I $D(HBHCQ) K HBHCQ S Y=17;"_$S($$ICD^HBHCUPD:"18:36",1:"D ADMDX^HBHCLKU1;19:36")
 ; Discharge Status branch
 S:HBHCDR["43;" DR="[HBHC UPDATE DISCHARGE]"
 I $D(DR) I '$D(Y) I (DR["D ACTION")!(DR["[HBHC UPDATE") S HBHCDFN=DA,HBHCUPD=1 D ^DIE K HBHCUPD
 L -^HBHC(631,DA) I '$D(HBHCKEEP) I '$D(Y) K DIK S DIK="^HBHC(HBHCFILE,",DA=HBHC D ^DIK K HBHCKEEP
 Q
SET ; Set DR string(s) for Discharge data
 S:$D(DR) DR(1,631,HBHCCNT)=^HBHC(HBHCFILE,HBHCIEN,HBHCSUB),HBHCCNT=HBHCCNT+1
 S:'$D(DR) (DR,HBHCDR)=^HBHC(HBHCFILE,HBHCIEN,HBHCSUB)
 Q
ICD() ;
 ; Set ICDVDT based on whether process Admission or Discharge
 S ICDVDT=$S(HBHCDR["14;":$P(^HBHC(631,DA,0),U,18),1:$P(^HBHC(631,DA,0),U,40))
 S ICDSYS=+$$SINFO^ICDEX("DIAG",ICDVDT)
 I ICDSYS=1 S ICDFMT=1
 Q $S(ICDSYS=1:1,1:0)
 ;
DXCHKA1(DA) ; Admissions - Check for DX codes and adjust DR as needed for first ^DIE call
 N HBHCFND,HBHCIDX
 S HBHCFND=0
 ; If no DATE field, Determine if 9 or 10 lookup needed based on current value in DATE
 I DR'["17;" D  Q 
 .D GETDT(DA)
 .I ICDSYS=1 Q
 .F HBHCIDX=1:1 Q:$P(DR,";",HBHCIDX)=""  D  Q:HBHCFND
 ..Q:$P(DR,";",HBHCIDX)'=18
 ..S $P(DR,";",HBHCIDX)="D ADMDX^HBHCLKU1",HBHCDFN=DA,HBHCFND=1
 ; If DATE field included, break DR into 2 separate calls
 S HBHCDRA=$P(DR,"17;",2)_";"
 S DR=$P(DR,"17;",1)_"17;"
 Q
 ;
DXCHKA2(DA) ; Admissions - adjust DR as needed for second ^DIE call
 N HBHCFND,HBHCIDX
 ; Get current DATE to use for Date of Interest
 D GETDT(DA)
 ; For ICD-9 era records use FileMan
 I ICDSYS=1 S DR=HBHCDRA Q
 ; For ICD-10 era records use ADMDX^HBHCLKU1
 F HBHCIDX=1:1 Q:$P(HBHCDRA,";",HBHCIDX)=""  D  Q:HBHCFND
 .Q:$P(HBHCDRA,";",HBHCIDX)'="18"
 .S $P(HBHCDRA,";",HBHCIDX)="D ADMDX^HBHCLKU1",HBHCDFN=DA,HBHCFND=1,DR=HBHCDRA
 Q
 ;
DXCHKD1(DA,HBHCIEN) ; Discharges - Check for DX codes as adjust as needed for first ^DIE call
 ; DA = #631 IEN
 ; HBHCIEN = #634.3 IEN
 ; Loop through DR looking for DISCHARGE DATE #39 & PRI DX @ DISCHARGE (#46).
 ; Fields are stored in numerical sequence so if DISCHARGE DATE (#39) is defined, it will be processed first
 N HBHCCNT,HBHCDATA,HBHCIDX1,HBHCIDX2
 S HBHCCNT=0,(HBHC39,HBHC46)=""
 F  S HBHCCNT=$O(^HBHC(634.3,HBHCIEN,HBHCCNT)) Q:'HBHCCNT!((HBHC39'="")&(HBHC46'=""))  D
 .S HBHCDATA=^HBHC(634.3,HBHCIEN,HBHCCNT)
 .I HBHCDATA["39;" S HBHC39=$$FNDIT(39,HBHCCNT,HBHCDATA) ; Line^Piece
 .; Since the DX @ Discharge can be defaulted, we can't check for 46;
 .; Since the DX @ Discharge can be the first field we can't check for ;46 so just check for 46
 .I HBHCDATA["46" S HBHC46=$$FNDIT(46,HBHCCNT,HBHCDATA) ; Line^Piece
 ; QUIT If neither #39 or #46 are being edited 
 Q:HBHC39=""&(HBHC46="")
 ; QUIT If #39 edited but #46 not edited
 Q:HBHC39'=""&(HBHC46="")
 ; If no #39 but #46 check date in #39 as adjust as needed
 I HBHC39="",HBHC46'="" D  Q
 .D GETDT(DA)
 .; If ICD-9 era data, special lookup vars are now set
 .Q:ICDSYS=1
 .; If ICD-10 era date update DR to call DCDX^HBHCLKU1
 .S $P(^HBHC(634.3,HBHCIEN,$P(HBHC46,U,1)),";",$P(HBHC46,U,2))="D DCDX^HBHCLKU1(DA)"
 .Q
 ; If #39 & #46 are in the same Node, OR in different Nodes, take everything from #46 to 
 ; end of Node(s) and store it in HBHCDRD until after #39 is set in first ^DIE call
 S HBHCDRD(1,631,$P(HBHC46,U,1))=$P(^HBHC(634.3,HBHCIEN,$P(HBHC46,U,1)),";",$P(HBHC46,U,2),999)
 ; Delete everything from #46 to end of ^HBHC node
 S ^HBHC(634.3,HBHCIEN,$P(HBHC46,U,1))=$P(^HBHC(634.3,HBHCIEN,$P(HBHC46,U,1)),";",1,$P(HBHC46,U,2)-1)
 ; Save off any other Nodes after Node containing #46
 F HBHCIDX=$P(HBHC46,U,1)+1:1 Q:'$D(^HBHC(634.3,HBHCIEN,HBHCIDX))  D
 .S HBHCDRD(1,631,HBHCIDX)=^HBHC(634.3,HBHCIEN,HBHCIDX)
 .; Delete Node in #634.3 prior to first ^DIE call
 .K ^HBHC(634.3,HBHCIEN,HBHCIDX)
 Q
 ;
DXCHKD2(DA) ; Discharges - Load fields in HBHCDRD into DR for second ^DIE call
 ; Determine Date of Interest based on current value in #39
 D GETDT(DA)
 ; For ICD-9 era dates, key DX lookup variables are now set so we just need to reload DR
 ; For ICD-10 era dates, update HBHCDRD to call DCDX^HBHCLKU1
 I ICDSYS=30 S $P(HBHCDRD(1,631,$P(HBHC46,U,1)),";",1)="D DCDX^HBHCLKU1(DA)"
 ; Restore DR from HBHCDRD and re-index to start at 1
 S HBHCIDX2=1
 F HBHCIDX1=$P(HBHC46,U,1):1 Q:'$D(HBHCDRD(1,631,HBHCIDX1))  D
 .S:$D(DR) DR(1,631,HBHCIDX2)=HBHCDRD(1,631,HBHCIDX1),HBHCIDX2=HBHCIDX2+1
 .S:'$D(DR) DR=HBHCDRD(1,631,HBHCIDX1)
 Q
FNDIT(HBHCFLD,HBHCCNT,HBHCDATA) ; 
 ; Find target HBHCFLD in string HBHBDATA
 ; Return either HBHC39 or HBHC46 = Line^Piece
 N HBHCI,HBHCFND
 S HBHCFND=""
 F HBHCI=1:1 Q:($P(HBHCDATA,";",HBHCI)="")!HBHCFND  D
 .Q:$P(HBHCDATA,";",HBHCI)'[HBHCFLD
 .S @$S(HBHCFLD=39:"HBHC39",1:"HBHC46")=HBHCCNT_U_HBHCI,HBHCFND=1
 Q $S(HBHCFLD=39:HBHC39,1:HBHC46)
 ;
GETDT(DA) ;
 S ICDVDT=$P(^HBHC(631,DA,0),U,18)
 S ICDSYS=+$$SINFO^ICDEX("DIAG",ICDVDT)
 I ICDSYS=1 S ICDFMT=1
 Q
