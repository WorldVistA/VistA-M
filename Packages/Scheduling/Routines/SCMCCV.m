SCMCCV ;ALB/REW - PCMM Conversion of Patient File Fields ; 1 Feb 1996
 ;;5.3;Scheduling;**41**;AUG 13, 1993
EN ; 
 ; Variables:
 ;     SCASSIGN: 1=Make Patient Assignments if unambiguous (0=No,default)
 ;     SCDT:     Date to make assignments (Default=DT)
 ;     SCYESTM:  1=Make Pt Tm as well as Pt Posit Assmnts,default(0=No)
 ;     SCNOPRPT  1=Don't print patient-detail lines
 ;
 N SCOK,DFN,SCPCNODE,SCLIST,SCTMPLST,SCHISTAR,SCASSIGN,SCYESTM,SCTM,Y,SCSTOP,SCPAGE,SCNOPRPT,SCTEAMAR,SCNOW,SCSUB
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 IF '$$OKASK D MESS("Search aborted","!?5") G QTEN
 IF '$D(IO("Q")) D
 .U IO
 .D REP
 .D ^%ZISC
 ELSE  D
 .F X="SCASSIGN","SCYESTM","SCDT","SCNOPRPT" S ZTSAVE(X)=""
 .S Y=$$QUE("SC Patient-Team/Practitioner"_$S('SCASSIGN:"Report Only",1:"Report and Assignment"),"REP^SCMCCV")
QTEN Q
 ;
OKASK() ;
 N SCOK,DIR
 ;do you want to assign or just get a report?
 S DIR(0)="Y"
 S DIR("B")="NO"
 S DIR("A")="Do you want to assign patients right now?"
 S DIR("A",1)=""
 S DIR("A",2)=""
 S DIR("A",3)="  YES = Assign Patients to Teams and Team Positions"
 S DIR("A",4)="  NO  = Just print report to see how things would be"
 D ^DIR
 IF $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S SCOK=0 G QTASK
 S SCASSIGN=Y
 ;do you want to omit printing patients?
 S DIR(0)="Y"
 S DIR("B")="YES"
 S DIR("A")="Do you want to omit printing patients?"
 S DIR("A",1)=""
 S DIR("A",2)=""
 S DIR("A",3)="  NO  = Print detail line for each patient that is assignable"
 S DIR("A",4)="  YES = Just print Team & Practitioner information"
 D ^DIR
 IF $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S SCOK=0 G QTASK
 S SCNOPRPT=Y
 IF '$D(SCASSIGN) S SCASSIGN=0
 IF '$D(SCDT) S SCDT=DT
 IF '$D(SCYESTM) S SCYESTM=1
 S SCOK=$$GETDEV
QTASK Q SCOK
 ;
REP ;non-interactive portion
 Q:$$FIRST^SCMCRU  ;check for task end
 IF '$$OKINIT() G QTEN
 D MESS("  ..Ok")
 IF '$$OKBUILD G QRP
 D MESS("  ..Ok")
 IF '$$OKREPORT G QRP
 D MESS("  ..Ok")
 IF '$$OKCLEAN G QRP
 D MESS("  ..Ok")
QRP Q
 ;
OKINIT() ;
 N SCOK
 S SCOK=1
 D MESS(">>> Checking Programmer Variables:","!,?5")
 IF +$G(DUZ)'>0!($G(U)'="^")!('$D(DT)) D  Q 0
 . S XPDABORT=1
 . D MESS("You must first initialize Programmer Environment by running ^XUP")
 . S SCOK=0
 S SCLIST="SCTMPLST"
 D INIT^SCAPMCU1(.SCOK)
 D NOW^%DTC
 S SCNOW=%
 S SCHISTAR(.05)=1      ;pc practitioner
 S SCHISTAR(.06)=DUZ    ;user entering
 S SCHISTAR(.07)=SCNOW  ;date entered
 S SCTEAMAR(.08)=1      ;pc team
 S SCTEAMAR(.11)=DUZ    ;user
 S SCTEAMAR(.12)=SCNOW  ;date enter=now
 Q SCOK
 ;
OKBUILD() ;
 N SCOK
 S SCOK=1
 D MESS(">>> Looping through PC Nodes of PATIENT File","!,?5")
 S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S SCPCNODE=$G(^DPT(DFN,"PC")) IF SCPCNODE]"" D  D:'(DFN#100) MESS(".")
 .S ^TMP("SCMC",$J,"TMPRPT",+$P(SCPCNODE,U,2),+$P(SCPCNODE,U,1),DFN)=""
 Q SCOK
 ;
OKREPORT() ;
 N SCOK,SCTM,SCPR,SCTMNODE
 S SCOK=1
 D MESS(">>> Producing PATIENT File PC Report","!?5")
 D MESS("    Checking Team/Practitioner Assignments:","!?10")
 S SCTM=0
 F  S SCTM=$O(^TMP("SCMC",$J,"TMPRPT",SCTM)) Q:'SCTM!$G(SCSTOP)  D
 .S SCTMNODE=$G(^SCTM(404.51,SCTM,0))
 .D MESS(">>>Team: "_$$DISPTM(SCTM),"!!?10")
 .IF '$$OKTEAM(SCTM,SCDT) D
 ..S SCOK=0
 ..;D MESS("Problem(s) with Practitioner Assignments","!?15")
 Q SCOK
 ;
OKTEAM(SCTM,SCDT) ;return 1 if exactly 1 posit for each team assignment
 ;needs 'tmp('scmc',$j,'tmpr' array defined
 ;return count of positions pract is assigned to to team
 N SCOK,SC200,SCTMND,SCFLD,SCF
 S SCOK=1
 S SCTMND=$G(^SCTM(404.51,+$G(SCTM),0))
 F SCFLD=3,6,7 IF '$P(SCTMND,U,SCFLD) D  ;check required fields
 .S SCOK=0
 .S SCF=$$DDNAME^SCMCRU(404.51,(SCFLD*.01))
 .D MESS(SCF_" (#"_(SCFLD*.01)_") of Team required.  Enter via PCMM ","!?20")
 G:'SCOK QTOKTM
 S SCOK=$$ACTTM^SCMCTMU(SCTM,SCDT)
 IF 'SCOK D  G QTOKTM
 .N SCX
 .S SCX=$D(^SCTM(404.58,SCTM,"AIDT",SCTM))
 .D:'SCX MESS(" Never activated - Edit via PCMM")
 .D:SCX MESS(" Not active on "_SCDT)
 IF SCOK<0 D  G QTOKTM
 .D MESS(" Error in setup")
 IF $D(^TMP("SCMC",$J,"TMPRPT",SCTM,0)) D
 .D MESS("Team Assignment Only","!?15")
 .D:'SCNOPRPT MESS("Patients to be assigned to this team:","!?20")
 .S DFN=0 F  S DFN=$O(^TMP("SCMC",$J,"TMPRPT",SCTM,0,DFN)) Q:'DFN  D
 ..D MESS($$DISPPT(DFN),"!?25")
 ..S SCX=$$NMPCTM^SCAPMCU2(DFN,SCDT,1)
 ..D:SCX&(+SCX=SCTM)&('SCNOPRPT) MESS("Already assigned","!?27")
 ..D:SCX&(+SCX'=SCTM)&('SCNOPRPT) MESS("Previously assigned to "_$P(SCX,U,2),"!?27")
 ..Q:SCX
 ..D:$G(SCASSIGN) PCUPDTM(DFN)
 .D:$G(SCASSIGN) MAILLST^SCMCTMM(SCTM,"SCTEAMAR",SCDT,"^TMP(""SCMC"",$J,""NEWTM"",SCTM)")
 .F SCSUB="NEWTM","BADTM" K ^TMP("SCMC",$J,SCSUB,SCTM)
 S SC200=0
 F  S SC200=$O(^TMP("SCMC",$J,"TMPRPT",SCTM,SC200)) Q:'SC200  D
 .N SCTMPLST,SCCNT,SCTP,SCX,DFN
 .D MESS("Practitioner: "_$$DISP200(SC200),"!?15")
 .IF '$D(^VA(200,SC200,0)) D
 ..S SCOK=0
 ..D MESS("Bad Practitioner Assignment"_$S(SCNOPRPT:"",1:" for the following patient(s):"),"!?15")
 ..S DFN=0 F  S DFN=$O(^TMP("SCMC",$J,"TMPRPT",SCTM,SC200,DFN)) Q:'DFN  D
 ...D MESS($$DISPPT(DFN),"!?25")
 .ELSE  D
 .S:'$$TPPR^SCAPMC(SC200,"SCDTS",,,"SCTMPLST($J)",.SCERR) SCOK=0
 .S SCXTP=0 F SCCNT=0:1 S SCXTP=$O(SCTMPLST($J,"SCTP",SCTM,SCXTP)) Q:'SCXTP  S SCTP=SCXTP D MESS("Position: "_$$DISPTP(SCTP),"!?17")
 .;if no team-position assignments for pract
 .IF 'SCCNT D
 ..S SCOK=0
 ..D MESS("is assigned to "_SCCNT_" positions on team","!?20")
 ..D MESS("you need to assign him/her to a position on the team","!?20")
 ..S ^TMP("SCMC",$J,"NO_TP",SCTM,SC200)=""
 .;if exactly one practitioner assignment to team
 .IF SCCNT=1 D
 ..D:'SCNOPRPT MESS("Patients to be assigned to this position:","!?20")
 ..S DFN=0 F  S DFN=$O(^TMP("SCMC",$J,"TMPRPT",SCTM,SC200,DFN)) Q:'DFN  D
 ...D MESS($$DISPPT(DFN),"!?25")
 ...S SCX=$$NMPCTP^SCAPMCU2(DFN,SCDT,1)
 ...D:SCX&(+SCX=SCTP)&('SCNOPRPT) MESS("Already assigned","!?27")
 ...D:SCX&(+SCX'=SCTP)&('SCNOPRPT) MESS("Previously assigned to "_$P(SCX,U,2),"!?27")
 ...Q:SCX
 ...D:$G(SCASSIGN) PCUPD(DFN)
 ..D:$G(SCASSIGN) MAILLST^SCMCTPM(SCTP,"SCHISTAR",SCDT,"^TMP(""SCMC"",$J,""NEWTP"",SCTP)","^TMP(""SCMC"",$J,""OLDTP"",SCTP)","^TMP(""SCMC"",$J,""BADTP"",SCTP)")
 ..D:$G(SCASSIGN) MAILLST^SCMCTMM(SCTM,"SCTEAMAR",SCDT,"^TMP(""SCMC"",$J,""NEWTM"",SCTM)")
 ..F SCSUB="NEWTP","OLDTP","BADTP" K ^TMP("SCMC",$J,SCSUB,SCTP)
 ..K ^TMP("SCMC",$J,"NEWTM",SCTM)
 .;if multiple positin assignments for team for pract
 .IF SCCNT>1 D
 ..S SCOK=0
 ..D MESS("Practitioner is assigned to "_SCCNT_" positions on team","!?20")
 ..D MESS("because there is more than one position for this team","!?20")
 ..D MESS("and practitioner, there will be no patient assignments","!?20")
 ..S SCTP=0 F  S SCTP=$O(SCTMPLST($J,SCTM,SCTP)) Q:'SCTP  S ^TMP("SCMC",$J,"MULT_TP",SCTM,SC200,SCTP)=""
 .IF SCCNT=1 S ^TMP("SCMC",$J,"ONE_TP",SCTM,SC200,SCTP)=""
QTOKTM Q SCOK
 ;
PCUPD(DFN) ;
 N SCX,SCNOMAIL
 S SCNOMAIL=1
 ;This is NOT a stand-alone procedure
 S SCX=$$ACPTTP^SCAPMC(DFN,SCTP,"SCHISTAR",SCDT,.SCERR,SCYESTM)
 IF SCX D
 .D MESS("File #404.43 ien = "_+SCX,"!?30")
 .IF $P(SCX,U,2) D
 ..D MESS("  New Entry")
 ..S ^TMP("SCMC",$J,"NEWTP",SCTP,DFN)=""
 ..IF $P(SCX,U,4) D
 ...D MESS(" Team Assignment Made.  IEN="_$P(SCX,U,3),"!?30")
 ...S ^TMP("SCMC",$J,"NEWTM",SCTM,DFN)=""
 .ELSE  D
 ..D MESS("  Already Assigned")
 ..S ^TMP("SCMC",$J,"OLDTP",SCTP,DFN)=""
 ELSE  D
 .D MESS(" - NOT saved")
 .S ^TMP("SCMC",$J,"BADTP",+$G(SCTP),DFN)=""
 .D:('$P(SCX,U,2))&('$P(SCX,U,4))&('$P(SCX,U,3)) MESS("No Patient Team Assignment","!?30")
 Q
 ;
PCUPDTM(DFN) ;
 N SCX,SCNOMAIL
 S SCNOMAIL=1
 ;This is NOT a stand-alone procedure
 S SCX=$$ACPTTM^SCAPMC(DFN,SCTM,"SCTEAMAR",SCDT,.SCERR)
 IF SCX D
 .D MESS("File #404.42 ien = "_+SCX,"!?30")
 .IF $P(SCX,U,2) D
 ..D MESS("  New Entry")
 ..S ^TMP("SCMC",$J,"NEWTM",SCTM,DFN)=""
 ELSE  D
 .D MESS(" - NOT saved")
 .S ^TMP("SCMC",$J,"BADTM",+$G(SCTM),DFN)=""
 Q
 ;
OKCLEAN() ;
 D MESS(">>> Cleaning up ^TMP(""SCMC"" global","!?5")
 N SCOK
 S SCOK=1
 ;K ^TMP("SCMC",$J)
 Q SCOK
 ;
DISP200(SC200) ;
 Q $P($G(^VA(200,SC200,0)),U,1)_" [#"_SC200_"]"
 ;
DISPTP(SCTP) ;
 Q $P($G(^SCTM(404.57,SCTP,0)),U,1)_" [#"_SCTP_"]"
 ;
DISPTM(SCTM) ;
 Q $P($G(^SCTM(404.51,SCTM,0)),U,1)_" [#"_SCTM_"]"
 ;
DISPPT(DFN) ;
 Q $S(SCNOPRPT:"",1:$E($P($G(^DPT(DFN,0)),U,1),1,21)_" [SSN#:"_$P($G(^DPT(DFN,0)),U,9)_"]")
 ;
MESS(TEXT,FORMAT) ;
 Q:$G(SCSTOP)!($G(TEXT)="")
 S FORMAT=$G(FORMAT,"?5")
 D OUT^SCMCRU(TEXT,FORMAT)
 Q
 ;
GETDEV() ;
 N SCOK
 S SCOK=0
 S %ZIS="PMQ" D ^%ZIS  G:POP QTGDV
 S SCOK=1
QTGDV Q (SCOK)
 ;
QUE(NAME,START) ;
 ;  Needed: ZTSAVE array
 ;  NAME   = description
 ;  START  = starting point of routine
 S ZTDESC=NAME,ZTRTN=START
 D ^%ZTLOAD W:$D(ZTSK) !,"TASK #",ZTSK
 D HOME^%ZIS K IO("Q")
 Q ZTSK
