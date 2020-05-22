RAHLO1 ;HIRMFO/GJC/BNT-File rpt (data from bridge program) ; Jan 06, 2020@15:12:27
 ;;5.0;Radiology/Nuclear Medicine;**4,5,12,17,21,27,48,55,66,87,84,94,104,47,157,162**;Mar 16, 1998;Build 2
 ; 12/15/2009 BAY/KAM RA*5*104 Rem Call 359702 On-line Verification issue
 ; 11/15/2007 BAY/KAM RA*5*87 Rem Call 216332 Correct UNDEF on null dx code
 ; 09/07/2005 108405 - KAM/BAY Allow Radiology to accept dx codes from Talk Technology
 ; 09/29/2005 114302 KAM/BAY Code Added to trigger alert on 2ndary dx
 ;
 ;Integration Agreements
 ;----------------------
 ;DIE(10018); ,FILE/UPDATE^DIE(2053); CREATE^WVRALINK(4793); $$NOW^XLFDT(10103)
 ;EN^XUSHSHP(10045)
 ;
FILE ;Create entry in file 74 & file data (remember: U = "^")
 ;An existing report record was locked in RAHLO. If no report, find the next available
 ;report record number, create the report record and lock it. the software
 ;locks the new report record by calling $$NEWIEN^RAHLTCPU @ tag NEW1
 ;
 N RAFDA,RAIENS
 ;
 I '$D(ZTQUEUED) N ZTQUEUED S ZTQUEUED="1^dummy to suppress screen displays in UP2^RAUTL1 and elsewhere"
 I '$D(RAQUIET) N RAQUIET S RAQUIET="1^dummy to suppress screen display in PTR^RARTE2"
 N RADATIME S RADATIME=$$NOW^XLFDT() I $L($P(RADATIME,".",2))>4 S RADATIME=$P(RADATIME,".",1)_"."_$E($P(RADATIME,".",2),1,4) S RADATIME=+RADATIME
 N:'$D(RAPRTSET) RAPRTSET N:'$D(RAMEMARR) RAMEMARR
 D EN2^RAUTL20(.RAMEMARR) ; 04/30/99 always recalculate RAPRTSET
 ; If the report (stub/real) exists, unverify the existing report... Else create a new report
 I RARPT,$D(^RARPT(RARPT,0)) S RASAV=RARPT D  S RARPT=RASAV K RASAV L:$D(RAERR) -^RARPT(RARPT) Q:$D(RAERR)  G LOCK1
 . ; must save off RARPT, RAVERF and other RA* variables because
 . ; they are being killed off somewhere in the 'Unverify A Report'
 . ; option. 'Unverify A Report' does lock the the report record in file 74!
 . N RADFN,RADTI,RACNI,RARPTSTS,RASSN,RADATE,RALONGCN,RAVERF
 . ; if report isn't a stub report, then consider it being edited
 . S:'$$STUB^RAEDCN1(RARPT) RAEDIT=1 ;log report receipt event as an edit event
 . I $D(RADENDUM)#2,($P(^RARPT(RARPT,0),U,5)="V") D  Q  ;back the report down from verified
 .. L -^RARPT(RARPT) ;*** -LR1 unlock the report b/c UNVER^RARTE1 also locks the report ***
 .. D UNVER^RARTE1(RARPT)
 .. S RARPT=RASAV  ;RTK 7/28 for RARPT killed in UNVER^RARTE1
 .. S RADUZ=$G(^TMP("RARPT-REC",$J,RASUB,"RAVERF")) ;reset RADUZ for P162
 .. D LOCKR^RAHLTCPU(.RAERR) ;*** +LR1 re-lock the report post UNVER^RARTE1 ***
 .. Q
 . K:'($D(RAERR)#2) ^RARPT(RARPT,"I"),^("R"),^("H")
 . Q
 ;
NEW1 ; The variable RARPT is set to zero in RAHLO. NEWIEN^RAHLTCPU() will
 ; return a record number in RARPT to used for filing a new report. Use
 ; UPDATE^DIE to create a report with the record number returned in RARPT.
 S RARPT=$$NEWIEN^RAHLTCPU()
 ;
 ;*** + LR2 $$NEWIEN^RAHLTCPU() locked the new report record *** P162
 S RAIENS(1)=RARPT,RAFDA(74,"+1,",.01)=RALONGCN,RAFDA(74,"+1,",2)=RADFN
 ;S RAFDA(74,"+1,",3)=(9999999.9999-RADTI),RAFDA(74,"+1,",4)=$P(RALONGCN,"-",2)
 S RAFDA(74,"+1,",3)=(9999999.9999-RADTI),RAFDA(74,"+1,",4)=$P(RALONGCN,"-",$L(RALONGCN,"-"))  ;format of RALONGCN after P47 could be SSS-DDDDDD-CASE# so get LAST "-" piece instead of 2nd piece
 D UPDATE^DIE("","RAFDA","RAIENS","RAERR") K RAFDA,RAIENS
 I $D(RAERR("DIERR"))#2 S RAERR="Error filing a new record in the RAD/NUC MED REPORTS file." Q  ;report is unlocked upon return to RAHLO p162
 ;
LOCK1 ;jump here if we intend to amend an existing report
 I $D(RAESIG) S X=RAESIG,X1=$G(RAVERF),X2=RARPT D EN^XUSHSHP S RAESIG=X
 K RAFDA,RAIENS S RAIENS=RARPT_","
 S RAFDA(74,RAIENS,5)=RARPTSTS ; rpt status
 ;Verifier & Verified date will be set if RAVERF exists for new
 ;reports, edits, and addendums.  Date rpt entered and reported date
 ;will be set for new reports, and not reset for edits and addendums
 I '($D(RAEDIT)#2),($D(RADATIME)#2) S RAFDA(74,RAIENS,6)=RADATIME ; date/time report entered
 I $G(RAVERF)&(RARPTSTS="V") S RAFDA(74,RAIENS,7)=RADATIME ; v'fied date/time
 I $D(RADATE)#2 S RAFDA(74,RAIENS,8)=RADATE ; reported date
 I $G(RAVERF)&(RARPTSTS="V") S RAFDA(74,RAIENS,9)=RAVERF ; v'fying phys
 S:$L($G(RATELENM)) RAFDA(74,RAIENS,9.1)=RATELENM ;Teleradiologist name - Patch 84
 S:$L($G(RATELEPI)) RAFDA(74,RAIENS,9.2)=RATELEPI ;Teleradiologist NPI  - Patch 84
 S RAFDA(74,RAIENS,10)=$S($D(RAESIG)&(RARPTSTS="V"):RAESIG,1:"") ;esig
 S RAFDA(74,RAIENS,11)=$S($G(RATRANSC):RATRANSC,$G(RAVERF):RAVERF,1:"") ; transcriptionist
 ;next: status changed to 'verified' by
 I $G(RAVERF),(RARPTSTS="V") S RAFDA(74,RAIENS,17)=$G(^TMP("RARPT-REC",$J,RASUB,"RAWHOCHANGE"))
 D FILE^DIE("","RAFDA","RAERR")
 I $D(RAERR("DIERR"))#2 D  Q  ;report is unlocked upon return to RAHLO p162
 .S RAERR="Error filing report record data in the RAD/NUC MED REPORTS file."
 .;KILL THE WHOLE RECORD???
 .Q
 ;--------------------------------------
 ;
 ;if case is member of a print set, then create sub-recs for file #74
 I RAPRTSET D
 .I '$D(RARPTN) N RARPTN S RARPTN=RALONGCN
 .N RAXIT D PTR^RARTE2 ;create corresponding subrecs in ^RARPT()
 .Q
 ;--------------------------------------
 ;
 ;--- start FILE^DIE block for 70.03 ---
 ;don't file a Pri. Dx code for teleradiology reports in the released status (P84v11 bus. rule)
 S RARELTEL=$S(($D(RATELE)#2)&(RARPTSTS="R"):1,1:"")
 ;
 ;build the RADFA array to file Dx Code, resident/staff, and the report pointer
 ;with a single call to FILE^DIE (silent DBS call)
 K RAFDA,RAIENS S RAIENS=RACNI_","_RADTI_","_RADFN_","
 ;
 ; 02/08/2008 GJC replaced $G w/($D(RADX)#2) p84
 ; 11/15/2007 BAY/KAM RA*5*87 Rem Call 216332 Changed next line to $G
 ; 09/07/2005 108405 KAM/BAY Removed('$D(RADENDUM)#2) from next line
 I ($D(RADX)#2),RARELTEL="" D
 .S RAFDA(70.03,RAIENS,13)=RADX
 .S:$P(^RA(78.3,+RADX,0),U,4)="y" RAAB=1
 .Q
 ;
 K RARELTEL
 S RAZRES=+$G(^TMP("RARPT-REC",$J,RASUB,"RARESIDENT"))
 S RAZSTF=+$G(^TMP("RARPT-REC",$J,RASUB,"RASTAFF"))
 ;
 I '($D(RADENDUM)#2),(RAZRES!(RAZSTF)) D
 .S:$D(^VA(200,"ARC","R",RAZRES)) RAFDA(70.03,RAIENS,12)=RAZRES
 .S:$D(^VA(200,"ARC","S",RAZSTF)) RAFDA(70.03,RAIENS,15)=RAZSTF
 .Q
 ;
 S RAZ7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ;the following business rule WAS reviewed
 S RAZPCE=$S($D(^VA(200,"ARC","S",+$G(RAVERF))):15,$D(^VA(200,"ARC","R",+$G(RAVERF))):12,1:"")
 I '($D(RADENDUM)#2),(RAZPCE) S RAFDA(70.03,RAIENS,RAZPCE)=$G(RAVERF) ;P162
 ;
 ;file the report pointer w/the exam record
 S RAFDA(70.03,RAIENS,17)=RARPT
 D FILE^DIE(,"RAFDA","RAERR")
 I $D(RAERR("DIERR"))#2 D  Q  ;report is unlocked upon return to RAHLO p162
 .N RAFIELD S RAFIELD=$G(RAERR("DIERR",1,"PARAM","FIELD"))
 .S RAERR="Error filing report pointer value: "_$G(RARPT,"unknown")
 K RAFDA,RAIENS,RAZ7003,RAZPCE,RAZRES,RAZSTF
 ;---- end FILE^DIE block for 70.03 ----
 ;
 ; 09/29/2005 114302 KAM/BAY Code Added to trigger alert on 2ndary dx
 I $D(RASECDX) D
 . N RAX S RAX=0
 . F  S RAX=$O(RASECDX(RAX)) Q:RAX'>0  D
 .. S:$P(^RA(78.3,+RAX,0),U,4)="y" RAAB=1
 ;
 ; file impression text if present & not an addendum
 I '$D(RADENDUM) D
 . S J=0 I $O(^TMP("RARPT-REC",$J,RASUB,"RAIMP",0)) S I=0 F J=0:1 S I=$O(^TMP("RARPT-REC",$J,RASUB,"RAIMP",I)) Q:I'>0  I $D(^(I)) S ^RARPT(RARPT,"I",(J+1),0)=$G(^TMP("RARPT-REC",$J,RASUB,"RAIMP",I))
 . S:J ^RARPT(RARPT,"I",0)="^^"_J_U_J_U_RADATE
 . Q
 ; file report text if present & not an addendum
 I '$D(RADENDUM) D
 . S J=0 I $O(^TMP("RARPT-REC",$J,RASUB,"RATXT",0)) S I=0 F J=0:1 S I=$O(^TMP("RARPT-REC",$J,RASUB,"RATXT",I)) Q:I'>0  I $D(^(I)) S ^RARPT(RARPT,"R",(J+1),0)=$G(^TMP("RARPT-REC",$J,RASUB,"RATXT",I))
 . S:J ^RARPT(RARPT,"R",0)="^^"_J_U_J_U_RADATE
 . Q
 ; if addendum, add addendum text to impression or report
 I $D(RADENDUM),($O(^TMP("RARPT-REC",$J,RASUB,"RAIMP",0))!$O(^TMP("RARPT-REC",$J,RASUB,"RATXT",0))) D ADENDUM^RAHLO2 ; store new lines at the end of existing text
 ;
 ; Check for History from Dictation
 ; If history sent, check if previous history exists.  If previous
 ; history then current history will follow adding 'Addendum:' before 
 ; the text.
 I $O(^TMP("RARPT-REC",$J,RASUB,"RAHIST",0)) D
 . S RACNT=+$O(^RARPT(RARPT,"H",9999999),-1),RAHSTNDE=RACNT+1
 . S RANEW=$S(RACNT>0:0,1:1)
 . S I=0 F  S I=$O(^TMP("RARPT-REC",$J,RASUB,"RAHIST",I)) Q:I'>0  D
 . . S RACNT=RACNT+1
 . . S RALN=$G(^TMP("RARPT-REC",$J,RASUB,"RAHIST",I))
 . . S:'RANEW&(I=$O(^TMP("RARPT-REC",$J,RASUB,"RAHIST",0))) RALN="Addendum: "_RALN ; if the first line, append 'Addendum:'
 . . I (RAHSTNDE=RACNT),(RACNT>1) S ^RARPT(RARPT,"H",RACNT,0)=" ",RACNT=RACNT+1
 . . S ^RARPT(RARPT,"H",RACNT,0)=RALN
 . . Q
 . S ^RARPT(RARPT,"H",0)="^^"_RACNT_U_RACNT_U_RADATE
 . Q
 ;
 I $P(^RARPT(RARPT,0),U,5)="V",$T(CREATE^WVRALINK)]"" D CREATE^WVRALINK(RADFN,RADTI,RACNI) ; women's health
 G:'RAPRTSET UPACT ; the next section is for printsets only
 ; copy DX (prim & sec), Prim Resid, Prim Staff
 N RACNISAV,RA7
 N RA13,RA12,RA15 ;prim dx, prim resid, prim staff, rpt pointer
 S RACNISAV=RACNI,RA7=0
 S RA13=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,13),RA12=$P(^(0),U,12),RA15=$P(^(0),U,15)
 ;KLM/p157 - Remove Addendum check next line (need secondary DX codes updated on all descendants)
 F  S RA7=$O(RAMEMARR(RA7)) Q:RA7=""  I RACNISAV'=RA7 S RACNI=RA7 D UPMEM^RAHLO4 I $D(RASECDX) D SECDX^RAHLO2
 S RACNI=RACNISAV
 ;
UPACT ;Update the Activity Log (74.01) w/DBS call
 K RAIENS,RAFDA S RAIENS="+1,"_RARPT_","
 S RAFDA(74.01,RAIENS,.01)=$E($$NOW^XLFDT(),1,12)
 S RAFDA(74.01,RAIENS,2)=$S(RARPTSTS="V":"V",$D(RAEDIT):"E",1:"I")
 S RAFDA(74.01,RAIENS,3)=$S($G(RAVERF):RAVERF,$G(RATRANSC):RATRANSC,1:"")
 D UPDATE^DIE("","RAFDA","RAIENS","") K RAIENS,RAFDA,DIERR,^TMP("DIERR",$J)
 ;
 ; 12/15/2009 BAY/KAM RA*5*104 Changed next line to rebuild indexes
 ;S RAQUEUED=1 ;to be checked in routines "jumped to" from RAHLO1
 S DA=RARPT,DIK="^RARPT(",RAQUEUED=1 D IX^DIK K DA,DIK
 ;
 ;If verified, update report & exam statuses; else, just update exam status
 ;Be careful; exam locks are executed within both:
 ;- UPSTAT^RAUTL0
 ;- UP1^RAUTL1
 ;
 I $D(RAMDV),RAMDV'="" D
 .;*** unlock the study & report based on called tag^routines below p162 ***
 .L -^RARPT(RARPT) L -^RADPT(RADFN,"DT",RADTI)
 .D:RARPTSTS="V" UPSTAT^RAUTL0
 .D:RARPTSTS'="V" UP1^RAUTL1
 .Q
 ;
 ;p162 dropped the check for 'Kurzweil'
 D:'$D(RAERR) GENACK^RAHLTCPB
 ;
PACS ;If there are subscribers to RA RPT xxx events broadcast ORU mesages to those subscribers
 ;via TASK^RAHLO4. If VOICE DICTATION AUTO-PRINT (#26) field is set to 'Y' print the report to
 ;the printer defined in the REPORT PRINTER NAME (#10) field via VOICE^RAHLO4.
 I ($P(^RARPT(RARPT,0),U,5)="V")!($P(^(0),U,5)="R") D TASK^RAHLO4,VOICE^RAHLO4
 ;
KVAR K RAAB,RAEDIT,RAESIG,RAQUEUED,RAHIST
 Q
 ;
