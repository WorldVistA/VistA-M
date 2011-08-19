SCMCCV4 ; bp-ciofo/vad - PCMM PC Attending Assignments Report ; 05 May 99  9:05 AM
 ;;5.3;Scheduling;**195**;AUG 13, 1993
 ;
 ; List those assignments that are for PC Attending.  This is to easily
 ; inform the user of these assignments since they are no longer valid
 ; as a result of the enhancements from the PCMM Phase II (177) release.
 ;
 ; This report is sent to the user as a Mailman Message.
 ;
 ; This routine is part of a Pre-Release Patch to 177.  The Pre-Release
 ; Patch number is 195.
 ; -------------------------------------------------------------------
 ;
 Q
 ;
 ;
 ; -------------------------------------------------------------------
MAIN ; Main module to drive this routine
 ; -------------------------------------------------------------------
 K SCY
 S SCY(1)=""
 S SCY(2)="PCMM PC Attending Assignments Report"
 S SCY(3)=$$DTU^SCMCCV3()
 S SCY(4)="------------------------------------"
 S SCY(5)=$$QIT
 K ZTSK
 S SCY(6)=""
 D EN^DDIOL(.SCY)
 Q
 ;
 ; -------------------------------------------------------------------
QIT() ; Module to QUEUE and Run this job in the Background.
 ; -------------------------------------------------------------------
 N SCX,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="MAINQ^SCMCCV4"
 S ZTDESC="PCMM PC Attending Assignments Report"
 S ZTDTH=$H
 S ZTIO=""
 S SCMCSTOP=$$ASKTEAM()
 F SCX="SCMCSTOP","SCMCTM","SCMCTM(","SCTMNAM","SCTMNAM(" S ZTSAVE(SCX)=""
 D ^%ZTLOAD
 Q "==> "_$S(+ZTSK:" Queued - Task # "_ZTSK,1:" Not Queued!")
 ;
 ; -------------------------------------------------------------------
MAINQ ; Main module to drive this routine
 ; -------------------------------------------------------------------
 S STORE="^TMP(""SCMCCV4"",$J)"
 S REPORT="^TMP(""SCMC-RPT"",$J)"
 K @STORE,@REPORT
 I SCMCSTOP D EXIT Q
 ;
 D RUNIT
 ;
 Q
 ;
 ; -------------------------------------------------------------------
RUNIT ; Module to gather the data and print the report.
 ; -------------------------------------------------------------------
 D SCPTLP  ; Process thru the ^SCPT(404.43) global.
 D PRINT   ; Store the Report in a Temp array.
 I 'SCGOTONE D   ; No data to print.
 . F I=1:1:3 S STRING=" " X SCLNUP
 . S STRING=$E(SCBLK,1,5)_"Zero Team Position Assignments were found based upon selection criteria."
 . X SCLNUP
 ;
 D MAILIT  ; Queue the report as a Mailman Message.
 D EXIT
 Q
 ;
 ; -------------------------------------------------------------------
ASKTEAM() ; Prompt for "A"ll or "S"elected Teams.
 ; -------------------------------------------------------------------
 ; Sets up the SCMCTM and SCTMNAM arrays.
 ; Returns a "1" to STOP, or a "0" to CONTINUE.
 ;
 N STOP
 K SCMCTM,SCTMNAM
 S (STOP,SCMCTM,SCTMNAM)=0
 S SCMCTYPE=$$TYPE()  ; Gets the type of selections (all or selected)
 I SCMCTYPE=0 S STOP=1 Q STOP
 ;
 I SCMCTYPE="A" Q STOP
 ;
 I SCMCTYPE="S" D TMLP S:'+SCMCTM STOP=1
 Q STOP
 ;
 ; -------------------------------------------------------------------
TYPE() ; Ask the user to enter "A"ll or "S"elected teams.
 ; -------------------------------------------------------------------
 ; "A" means All Teams.
 ; "S" means Select Teams.
 ; Returns a "0" to quit or a "1" to continue.
 ;
 N DIR
 S DIR(0)="SM^A:All Teams;S:Specific Teams"
 S DIR("?",1)="Select A for a report of All Teams"
 S DIR("?",2)="Select S for a report of Specific Teams"
 S DIR("?",3)=" "
 ;
 D ^DIR
 Q $S($D(DIRUT):0,1:Y)
 ;
 ; -------------------------------------------------------------------
TMLP ; Allow the user to select multiple teams.
 ; -------------------------------------------------------------------
 ; Sets up the SCMCTM and SCTMNAM arrays with the teams.
 ; Sets SCSTOP=1 to stop selection.
 ;
 N SCSTOP,SCCTR,SCTMREC
 S (SCSTOP,SCCTR)=0
 F  D  I SCSTOP Q
 . N TM
 . S TM=$$TEAM^SCMCMU(DT)
 . I (TM>0),'$D(SCMCTM(TM)) D
 . . S SCMCTM(TM)="",SCCTR=SCCTR+1
 . . S SCTMREC=$G(^SCTM(404.51,TM,0))
 . . S SCTMNAM($P(SCTMREC,U,1))=TM
 . E  S SCSTOP=1
 . Q
 S (SCMCTM,SCTMNAM)=SCCTR
 Q
 ;
 ; -------------------------------------------------------------------
SCPTLP ; Process the ^SCPT(404.43) global to gather reportable data.
 ; -------------------------------------------------------------------
 N SCTNAME,SCMCVAR,SCZZPROV,SCMCERR,SCG,SCG2
 S (DFN,SCACTDT,SCTMPOS,SCTNAME,SCSEQ1,SCSTATUS)=""
 F  S SCTNAME=$O(SCTMNAM(SCTNAME)) Q:SCTNAME=""  D
 . S @STORE@("B",SCTNAME)=0
 ;
 S SCG="^SCPT(404.43,""APCPOS"")"
 F  S DFN=$O(@SCG@(DFN)) Q:DFN=""  D
 . I '$D(@SCG@(DFN,2)) Q   ; Attending only
 . N VA,VADM,VAERR
 . D DEM^VADPT
 . S SCPTNM=$G(VADM(1),"Invalid Name:"_DFN)     ;patient name
 . S SCPTSSN=$G(VA("PID"),"Invalid PID:"_DFN)   ;patient SSN
 . ;
 . S SCG2="^SCPT(404.43,""APCPOS"","_DFN_",2)"
 . F  S SCACTDT=$O(@SCG2@(SCACTDT)) Q:SCACTDT=""  D
 . . F  S SCTMPOS=$O(@SCG2@(SCACTDT,SCTMPOS)) Q:SCTMPOS=""  D
 . . . F  S SCSEQ1=$O(@SCG2@(SCACTDT,SCTMPOS,SCSEQ1)) Q:SCSEQ1=""  D
 . . . . S SCREC1=$G(^SCPT(404.43,SCSEQ1,0))
 . . . . I +$P(SCREC1,U,4),$P(SCREC1,U,4)<DT Q  ;no old discharges 
 . . . . S Y=$P(SCREC1,U,3)
 . . . . S SCASNDT=$$FMTE^DILIBF(Y,"6U")        ;mm-dd-yyyy
 . . . . ;
 . . . . S SCREC2=$G(^SCTM(404.57,SCTMPOS,0))
 . . . . S SCPOSNM=$P(SCREC2,U,1)
 . . . . S SCTMNO=$P(SCREC2,U,2)
 . . . . Q:(+SCTMNO<1)!('$D(^SCTM(404.51,SCTMNO,0)))
 . . . . ;
 . . . . I +SCMCTM,'$D(SCMCTM(SCTMNO)) Q        ;not a selected Team
 . . . . ;
 . . . . S SCREC3=$G(^SCTM(404.51,SCTMNO,0))
 . . . . S SCTMNM=$P(SCREC3,U,1)
 . . . . ;
 . . . . N SCMCVAR,SCDATES,SCZZPROV,SCMCERR
 . . . . S SCMCVAR=$$PRTP^SCAPMC8(SCTMPOS,"SCDATES","SCZZPROV","SCMCERR")
 . . . . I 'SCMCVAR Q
 . . . . I '$D(SCZZPROV(1)) Q
 . . . . ; There should be only one provider for this day
 . . . . S SCPHYPOS=$P(SCZZPROV(1),U,4)_" ("_$P(SCZZPROV(1),U,2)_")"
 . . . . ; Store a data record.
 . . . . N SCCNT
 . . . . S SCCNT=+$G(@STORE@(SCTMNO,0))+1
 . . . . S @STORE@("B",SCTMNM)=SCTMNO
 . . . . S @STORE@(SCTMNO,0)=SCCNT
 . . . . S @STORE@(SCTMNO,1,SCPHYPOS,2,SCPTNM,DFN,SCACTDT,SCCNT)=""
 . . . . S @STORE@(SCTMNO,SCCNT)=SCTMNM_U_SCPHYPOS_U_SCPTNM_U_SCPTSSN_U_SCASNDT
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
 ; -------------------------------------------------------------------
PRINT ; Store the report in temp array prior to a Mailman Message.
 ; -------------------------------------------------------------------
 S (SCTMNM,SCPHYPOS,SCPTNM,SCPTSSN,SCASNDT)=""
 S (SCGOTONE,SCSTOP,SCLNSEQ)=0
 S SCLNUP="S SCLNSEQ=SCLNSEQ+1,@REPORT@(SCLNSEQ)=STRING"
 S SCRPDT=$$FMTE^XLFDT($$NOW^XLFDT())
 S SCBLK=" ",$P(SCBLK," ",80)=" "
 S SCDSH="-",$P(SCDSH,"-",80)="-"
 S SCDBL="=",$P(SCDBL,"=",80)="="
 ;
 S STRING=$E(SCBLK,1,15)_"PCMM PC Attending Assignments Report - "_SCRPDT
 X SCLNUP
 S STRING=$E(SCBLK,1,$S(+SCMCTM:26,1:23))_"Selection Criteria: "_$S(+SCMCTM:"SELECTED",1:"ALL")_" TEAMS"
 X SCLNUP
 ;
 F  S SCTMNM=$O(@STORE@("B",SCTMNM)) Q:SCTMNM=""  D
 . D PRTTMHDR
 . S SCTMNO=@STORE@("B",SCTMNM)
 . I SCTMNO=0 D  Q
 . . S STRING=$E(SCBLK,1,5)_"Zero Team Position Assignments were found within this team."
 . . X SCLNUP
 . ;
 . S SCPHYPOS=""
 . F  S SCPHYPOS=$O(@STORE@(SCTMNO,1,SCPHYPOS)) Q:SCPHYPOS=""  D
 . . D PRTPHHDR
 . . S SCPTNM=""
 . . F  S SCPTNM=$O(@STORE@(SCTMNO,1,SCPHYPOS,2,SCPTNM)) Q:SCPTNM=""  D
 . . . S DFN=0
 . . . F  S DFN=$O(@STORE@(SCTMNO,1,SCPHYPOS,2,SCPTNM,DFN)) Q:'DFN  D
 . . . . S SCACTDT=0
 . . . . F  S SCACTDT=$O(@STORE@(SCTMNO,1,SCPHYPOS,2,SCPTNM,DFN,SCACTDT)) Q:'SCACTDT  D
 . . . . . S SCCNT=$O(^(SCACTDT,0))
 . . . . . S SCX=@STORE@(SCTMNO,SCCNT)
 . . . . . ; Print a Detail Line.
 . . . . . S STRING=$$LJ("",10)_$$LJ(SCPTNM,29)_$$LJ($P(SCX,U,4),18)_$P(SCX,U,5)
 . . . . . X SCLNUP
 . . . . . ;
 . . . . . S SCGOTONE=1
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
LJ(STRING,LENGTH) Q $$LJ^XLFSTR(STRING,LENGTH)
 ;
 ; -------------------------------------------------------------------
PRTTMHDR ; Print the Team Sub-heading.
 ; -------------------------------------------------------------------
 N STRING
 ;
 S STRING=" " F I=1:1:2 X SCLNUP
 S STRING=$E(SCDBL,1,11+$L(SCTMNM)) X SCLNUP
 S STRING="TEAM NAME: "_SCTMNM X SCLNUP
 S STRING=$E(SCDBL,1,11+$L(SCTMNM)) X SCLNUP
 S STRING=" " X SCLNUP
 S STRING=$E(SCBLK,1,5)_"Positions" X SCLNUP
 S STRING=$E(SCBLK,1,5)_$E(SCDSH,1,9) X SCLNUP
 Q
 ;
 ; -------------------------------------------------------------------
PRTPHHDR ; Print the Physician Sub-heading.
 ; -------------------------------------------------------------------
 N STRING
 ;
 S STRING=" " X SCLNUP
 S STRING=$E(SCBLK,1,5)_SCPHYPOS X SCLNUP
 S STRING=$E(SCBLK,1,5)_$E(SCDSH,1,$L(SCPHYPOS)) X SCLNUP
 ;
 ;
 S STRING=" " X SCLNUP
 S STRING=$E(SCBLK,1,10)_"Patient Name"_$E(SCBLK,1,17)_"SSN"_$E(SCBLK,1,12)_"Date Assigned"
 X SCLNUP
 S STRING=$E(SCBLK,1,10)_$E(SCDSH,1,12)_$E(SCBLK,1,17)_"---"_$E(SCBLK,1,12)_$E(SCDSH,1,13)
 X SCLNUP
 Q
 ;
 ; -------------------------------------------------------------------
MAILIT ; Queue the report as a MailMan Message.
 ; -------------------------------------------------------------------
 N XMY,XMDUZ,XMSUB,XMTEXT
 S XMDUZ=.5
 S (XMY(DUZ),XMY(XMDUZ))=""
 S XMSUB="PCMM PC Attending Assignments Report"
 S XMTEXT="^TMP(""SCMC-RPT"",$J,"
 D ^XMD
 Q
 ;
 ; -------------------------------------------------------------------
EXIT ; Clean up and Exit
 ; -------------------------------------------------------------------
 K @STORE,@REPORT
 D KILL^XUSCLEAN
 Q
