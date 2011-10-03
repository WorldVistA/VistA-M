RARTE5 ;HISC/SWM AISC/MJK,RMO-Enter/Edit Outside Reports ;1/26/09  11:36
 ;;5.0;Radiology/Nuclear Medicine;**56,95,97**;Mar 16, 1998;Build 6
 ;Private IA #4793 CREATE^WVRALINK
 ;Controlled IA #3544 ^VA(200
 ;Supported IA #2056 GET1^DIQ
 ;Supported IA #10013 IX1^DIK
 ;Supported IA #10141 MES^XPDUTL
 ; adapted from RARTE, RARTE1, RARTE4
 F I=1:1:10 W !?3,$P($T(INTRO+I),";;",2)
 W ! D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 N RAXIT,RASUBY0,RA18EX,RAPRTSET,RAMEMARR,RA1,RA7003
 S RAXIT=0
 K RASSS,RASSSX ;clear HL7 exclusion vars
 I $D(RANOSCRN) S X=$$DIVLOC^RAUTL7() I X D Q1 QUIT
 ;
 ; only require any Radiology Classification in New Person file
 S X=0 F I="C","R","S","T" S:$D(^VA(200,"ARC",I,DUZ)) X=1
 I 'X W !,"Your user account is missing a Radiology classification.",! D INCRPT Q
 ;
START S RAFIRST=0 ;=1 for 1st time rpt given "EF" rpt status
 K RAVER S RAVW="",RAREPORT=1 D ^RACNLU G Q1:"^"[X
 ; RACNLU defines RADFN, RADTI, RACNI, RARPT
 S RASUBY0=Y(0) ; save value of y(0)
 G:$P(^RA(72,+RAST,0),"^",3)>0 CONTIN
 I $D(^XUSEC("RA MGR",DUZ)) G CONTIN
 G:$P(RAMDV,"^",22)=1 CONTIN
 W $C(7),!!,"The STATUS for this case is CANCELLED. You may not enter a report.",!! D INCRPT G START
 ;
CONTIN ; continue
 S RAXIT=0 D DISPLAY^RARTE6
 I RA18EX=-1 D INCRPT G START
 ; raprtset is defined in display^rarte6
 S RAPNODE="^RADPT("_RADFN_",""DT"","_RADTI_",""P"","
 S RA7003=@(RAPNODE_RACNI_",0)")
 S RAXIT=$$LOCK^RARTE6(RAPNODE,RACNI) I RAXIT D INCRPT G START
 ;
 ; Real rpt must have fld 5="EF" & fld 18 w/ data.  Stub rpt allowed
 I $D(^RARPT(+RARPT,0)),(($P(^(0),"^",5)'="EF")!($P(^(0),"^",18)="")),'$$STUB^RAEDCN1(+RARPT) W !?3,$C(7),"Only Electronically Filed reports can be selected!",! D UNLOCK^RAUTL12(RAPNODE,RACNI) D INCRPT G START
 ;Create new rpt, or skip to IN to edit existing report
 G IN:$D(^RARPT(+RARPT,0))
 ;
 G:'RAPRTSET NEW G:$P(^RA(72,+RAST,0),"^",3)>0 NEW
 ; case is part of a print set, AND is cancelled
 N RA2 S (RA1,RA2)=""
 F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""  S:$P(RAMEMARR(RA1),"^",3)]"" RA2=$P(RAMEMARR(RA1),"^",3)
 G:RA2="" NEW
 W !!,$C(7),"Other cases of this cancelled case ",RACN,"'s print set are entered in a report already",!!,"You may NOT create a new report for this cancelled case,",!,"but you may include this cancelled case in the existing report."
 W !!,"Do you want to include this cancelled case in the same report",!,"as the others in the print set ?"
 S %=2 D YN^DICN
 W:%>0 "...",$S(%=1:"Include",1:"Skip")," this case"
 I %=1 S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",17)=RA2,RARPT=RA2,RARPTN=$P(^RARPT(RARPT,0),"^"),RA1=RACN D INSERT^RARTE2
 D UNLOCK^RAUTL12(RAPNODE,RACNI) D INCRPT G START
NEW G:'RAPRTSET NEW1
 L +^RADPT(RADFN,"DT",RADTI):DILOCKTM G:$T NEW1
 W !!?10,$C(7),"** This case belongs to a printset, and someone else is",?68,"**",!?10,"** editing another case from this printset, or entering",?68,"**"
 W !?10,"** a report for this printset, so you may not enter a",?68,"**",!?10,"** new report.",?68,"**"
 H 2 D UNLOCK^RAUTL12(RAPNODE,RACNI) D INCRPT G START
 ;
NEW1 S RARPTN=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN
 W !?3,"...report not entered for this exam...",!?10,"...will now initialize report entry..."
 S I=+$P(^RARPT(0),"^",3)
 ;
LOCK ;Try to lock next avail IEN, if locked - fail, if used - increment again
 S I=I+1 S RAXIT=$$LOCK^RARTE6("^RARPT(",I) I RAXIT D UNLOCK2^RARTE4 D INCRPT G START
 ;don't check ^RARPT("B",RARPTN) due cloaked deleted reports
 I $D(^RARPT(I)) D UNLOCK^RAUTL12("^RARPT(",I) G LOCK
 S ^RARPT(I,0)=RARPTN,RARPT=I,^(0)=$P(^RARPT(0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),^DISV($S($D(DUZ)#2:DUZ,1:0),"^RARPT(")=I S:'$D(^RARPT(RARPT,"T")) ^("T")=""
 S ^RARPT(RARPT,0)=RARPTN_"^"_RADFN_"^"_RADTE_"^"_RACN_"^EF",DIK="^RARPT(",DA=RARPT D IX1^DIK
 K %,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 S DIE="^RADPT("_RADFN_",""DT"","_RADTI_",""P"","
 S DR="17////"_RARPT D ^DIE
 K %,D,D0,DA,DI,DIC,DIE,DQ,DR,RAY1,X,Y
 ;if printset -- set pc 17 in subfile 70.03 and subrec in subfile 74.05
 I RAPRTSET D PTR^RARTE2
 I RAXIT D UNLOCK2^RARTE4,UNLOCK^RAUTL12("^RARPT(",RARPT) G Q1
 W !,RAI
 G IN0
IN ;edit existing rpt, so lock rpt fr the 1st time
 S RAXIT=$$LOCK^RARTE6("^RARPT(",RARPT) I RAXIT D UNLOCK2^RARTE4 G Q1
IN0 ;skip to here if rpt created in this session and already locked
 ; Flag first time EF report is made if piece 18 has no data  yet
 I $P(^RARPT(RARPT,0),U,18)="" S RAFIRST=1
 ; save DXs before edit
 S RANY1=$$ANYDX^RARTE7(.RAA1) ;1=has DXs, 0=no DXs, RAA1() stores DXs
 ; Ask if copy standard report
 I $P(RAMDV,"^",12) D STD^RARTE1 I X="^" S RAXIT=1 G UNCASE
 ;  Ask Report Date
 S DR="8",DA=RARPT,DIE="^RARPT(" D ^DIE K DE,DQ
 ; y is defined if user "^" out
 I $D(Y) K Y G UNCASE
 ;   Display Clinical History
 D CHPRINT^RAUTL9
 ; report status before editing
 S RACT=$P(^RARPT(RARPT,0),U,5)
 ; Edit Report Text and enter Diagnostic code(s)
 D ERPT
 ; Resident and Staff not asked and not copied to other cases of printset
 ; continue to check sufficient data even if RAXIT=1 at this point
UNCASE ; 
 D UNLOCK^RAUTL12(RAPNODE,RACNI) ;unlock case
 ; copy diags to other cases of printset
 ; and unlock case "DT" level after copying is done
 I RAPRTSET S RADRS=1,RAXIT=0 D COPY^RARTE2 L -^RADPT(RADFN,"DT",RADTI)
 ; first time EF rpt made -- del rpt & xrefs if no rpt txt & impression
 I RAFIRST S RAXIT=$$CCAN(RARPT)
 D UNLOCK^RAUTL12("^RARPT(",RARPT) ;unlock report
 G:RAXIT PRT
 ;
 ;  "EF" was stuffed in LOCK+5 for new rpts but not stub rpt yet
 I $P(^RARPT(RARPT,0),U,5)'="EF" D SETFF^RARTE6(74,5,RARPT,"EF")
 W !!?5,"Report status is stored as ""Electronically Filed""."
 ; Stuff in initial entry date only once
 I RAFIRST D SETFF^RARTE6(74,18,RARPT,"NOW","E")
 ;   Stuff in Activity Log subfile at all times
 D SETALOG^RARTE6("+1,"_RARPT_",","F","")
 ;
 ; transmit to women's health each time this point is reached
 ; COPY^WVRALINK will stop if the same case number is already in 790.1
 ;
 I $P(^RARPT(RARPT,0),U,5)="EF",$T(CREATE^WVRALINK)]"" D CREATE^WVRALINK(RADFN,RADTI,RACNI) ; women's health
 ;
PRT I RAXIT S RAXIT=0 D UNLOCK2^RARTE4 D INCRPT G START
 ;
 ; report status after editing
 S RACT=$P(^RARPT(RARPT,0),U,5)
 ; ---
 ; set RAHLTCPB to prevent broadcast ORM messages
 N RAHLTCPB S RAHLTCPB=1
 ;
 ; update case's exam status only if exam status isn't COMPLETE
 ; and isn't CANCEL
 ; and ((birads not required) or (birads required and entered))
 S RA2=$$GET1^DIQ(72,+$P(RA7003,U,3)_",",3)
 I RA2'=9,(RA2'=0) D
 .I 'RABIREQ D UP1^RAUTL1 Q
 .I RABIDAT D UP1^RAUTL1 Q
 .E  W !!?5,"Exam status not recalculated due to missing BI-RADS code."
 .Q
 S RANY2=$$ANYDX^RARTE7(.RAA2) ;RAA2() store DXs after edit
 ; check if new/changed diagnostic codes, send alert if nec.
 D ALERT^RARTE7
 K RAAB
 ; broadcast if EF rpt made first time, or any DX changed/added/del'd
 I $O(RAA2(0))!(RAFIRST) D
 .D HLXMSG ;find VR subscribers to exclude
 .D RPT^RAHLRPC
 .Q
PRT1 R !!,"Do you wish to print this report? No// ",X:DTIME S:'$T!(X["^") X="N" S:X="" X="N" ;030497
 I "Nn"[$E(X) D INCRPT G START
 I "Yy"'[$E(X) W:X'["?" $C(7) W !!?3,"Enter 'YES' to print this report, or 'NO' not to." G PRT1
 S ION=$P(RAMLC,"^",10),IOP=$S(ION]"":"Q;"_ION,1:"Q")
 S RAMES="W !!?3,""Report has been queued for printing on device "",ION,""."""
 D Q^RARTR D INCRPT G START ; queue rpt, cleanup, startover
 ;
Q1 K %,%DT,%W,%Y,%Y1,C,D0,D1,DA,DIC,DIE,DR,OREND,RABTCH,RABTCHN,RACN,RACNI,RACOPY,RACS,RACT,RADATE,RADFN,RADTE,RADTI,RADUZ,RAELESIG,RAFIN,RAHEAD,RAI,RAJ1
 K RALI,RALR,RANME,RANUM,RAOR,RAORDIFN,RAPNODE,RAPRC,RAPRIT,RAQUIT,RAREPORT,RARES,RARPDT,RARPT,RARPTN,RARPTZ,RARTPN,RASET,RASI,RASIG,RASN,RASSN,RAST,RAST1,RASTI,RASTFF,RAVW,XQUIT,W,X,Y
 K D,D2,DDER,DI,DIPGM,DLAYGO,J,RAEND,RAF5,RAFL,RAFST,RAIX,RAPOP,RAY1
 K ^TMP($J,"RAEX")
 K POP,DUOUT,RAFDA,RATEXT,RADIR0,RAXIT
 D INCRPT
 Q
INCRPT ; Kill extraneous variables to avoid collisions.
 ; Incomplete report information, select another case #.
 K DA,DIE,DR,RATXT
 K %,%DT,D,D0,D1,D2,DI,DIC,DIWT,DN,I,J,RAA1,RAA2
 K RABIENS,RABIDAT,RABIREQ,RACN,RACNI,RACT
 K RADATE,RADRS,RADTE,RADTI,RAFIN,RAFIRST,RAI,RALI,RALR,RANME,RAPRC,RARPT
 K RARPTN,RASSN,RAST,RAVW,RASSS,RASSSX,X
 Q
CCAN(IEN74) ;Check canned report for Outside Reporting
 ; adapted from EN3^RAUTL15
 ; outputs:  0 if report is kept
 ;           1 if report is deleted due to no canned text entered
 ;
 N RAPRG74,RATXT
 ; keep report if it is linked to images
 I $O(^RARPT(IEN74,2005,0))>0 Q 0
 ;
 ;del canned report if missing both REPORT TEXT and IMPRESSION TEXT
 I '$O(^RARPT(IEN74,"I",0)),'$O(^RARPT(IEN74,"R",0)) D  Q 1
 .; un-link rpt from other cases of printset
 .D DEL17^RARTE2(IEN74)
 .; exec field's xrefs' KILL logic
 .S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 .D ENKILL^RAXREF(70.03,17,IEN74,.DA)
 .;
 .;del piece 17 from case record
 .S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",17)="" K DA,X
 .;
 .; Del report ptr from batch and distribution files
 .D UPDTPNT^RAUTL9(IEN74)
 .;
 .; Del entry from Report file
 .S DA=IEN74,DIK="^RARPT(" D ^DIK
 .S RATXT(1)=" "
 .S RATXT(2)="   Outside canned report not complete.  Must Delete......deletion complete!"
 .S RATXT(3)=$C(7) D MES^XPDUTL(.RATXT)
 .; also delete any diagnostic codes from case record
 .I RAPRTSET D DELDXPRT ;del DXs from printset cases
 .I 'RAPRTSET D DELDX ;del DXs from standalone case
 .Q
 Q 0
ERPT ; Edit report text, impression, and enter/edit diagnostic codes
 ;remove lock case commands here since case is still locked
 S $P(RATXT,"+",52)=""
 W !!?5,RATXT,!?8,"Required:  REPORT TEXT and/or IMPRESSION TEXT",!?5,RATXT
 S RAXIT=0 ; here, =1 means user "^" out
 S DA=RARPT,DIE="^RARPT("
 S DR="200;I X=""^"" S Y=""@8"";300;I X'=""^"" S Y=""@9"";@8;S RAXIT=1;@9"
 D ^DIE
 ; subseq edit -- Report Text and Impression Text cannot both be empty
 I 'RAFIRST,'$O(^RARPT(RARPT,"I",0)),'$O(^RARPT(RARPT,"R",0)) G ERPT
 ; dont quit on "^" if mammography study
 D CKREQ^RABIRAD ;check if BIRADS diag is required
 I RAXIT=1,'RABIREQ Q
DIAG ; Diagnostic codes
 ; (code taken from routine RARTE1)
 S RAIMGTYI=$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,2),RAIMGTYJ=$P($G(^RA(79.2,+RAIMGTYI,0)),U)
 S X=+$O(^RA(72,"AA",RAIMGTYJ,9,0)),DA(2)=RADFN,DA(1)=RADTI,DA=RACNI,DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P""," K RAIMGTYI,RAIMGTYJ
 ; ask Prim. Diag, required if site require diag, don't ck abnormal here
 S DR=13_$S('$D(^RA(72,X,.1)):"",$P(^(.1),"^",5)'="Y":"",1:"R")
 ; allow user to "^" exit
 D ^DIE K DA,DE,DQ,DIE,DR
 I ($P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,13)="")!($D(Y)) S RAXIT=0 G PACS
 S DR="50///"_RACN
 S DR(2,70.03)=13.1
 S DR(3,70.14)=.01 ; don't ck abnormal here
 S DA(1)=RADFN,DA=RADTI,DIE="^RADPT("_DA(1)_",""DT"","
 D ^DIE K DA,DE,DQ,DIE,DR
 I $D(Y) K Y S RAXIT=1 ;$D(Y) means user "^" out
PACS ; do not broadcast ORU message at this point
 ;
 ; if BIRADS required, ck if BIRADS entered, if not, go back to ask diag
 I RABIREQ D CKDATA^RABIRAD I 'RABIDAT I $$ASK^RABIRAD G DIAG
 ; move WV outside of this in case rpt is deleted due insufficient data
 Q
 ;
HLXMSG ; set up RASSSX() of VR subscribers to exclude from ORM msg broadcast
 N RA,XX
 ; q if there are no HL applications that use the 4 RA HL7 protocols
 Q:'$$GETAP^RAHLRS1(.XX)
 S RA=$NA(XX)
 F  S RA=$Q(@RA) Q:RA=""  I RA'["RA-TALK",(RA'["RA-PSCRIBE"),(RA'["RA-SCIMAGE"),(RA'["RA-RADWHERE") S RASSS(@RA)=""
 ; RASSS(ien #771)
 ; RASSSX(ien #101 driver, ien #101 subscriber)=".01 value of driver"
 D:$D(RASSS)>1 GETSUB^RAHLRS1(.RASSS,.RASSSX)
 Q
DELDX ; del any Prim. and Sec. DXs from standalone case
 S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",13)="@" ;Prim DX
 D FILE^DIE("","RAFDA")
 K RAFDA
 D KILSEC^RARTE7(70.14,RACNI)
 Q
DELDXPRT ;del any Prim. and Sec. DXs from all cases in printset
 S RA1=0
 F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""  D
 .S RAFDA(70.03,RA1_","_RADTI_","_RADFN_",",13)="@" ;Prim DX
 .D FILE^DIE("","RAFDA")
 .K RAFDA
 .D KILSEC^RARTE7(70.14,RA1)
 .Q
 Q
INTRO ;
 ;;+--------------------------------------------------------+
 ;;|                                                        |
 ;;|  This option is for entering canned text for           |
 ;;|  outside work:  interpreted report done outside,       |
 ;;|  and images made outside this facility.                |
 ;;|                                                        |
 ;;|  For a printset, the canned text must apply to all     |
 ;;|  cases within the printset.                            |
 ;;|                                                        |
 ;;+--------------------------------------------------------+
