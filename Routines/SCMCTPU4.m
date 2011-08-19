SCMCTPU4 ;ALB/MJK - Team Position Dangler Bulletin ; 10-JUL-1998
 ;;5.3;Scheduling;**148,177**;AUG 13, 1993
 ;
BULL ; -- send bulletin (called from SCMCTPU3)
 N XMY,XMTEXT,XMSUB,XMDUZ,SCLCNT
 D INIT
 D TEXT
 IF 'SCSTOP D ^XMD
 D FINAL
 Q
 ;
INIT ; -- set vars for bulletin
 N SCPCT
 S XMDUZ=.5
 S XMY($S($G(DUZ):DUZ,1:XMDUZ))=""
 S XMSUB="Patient Team Position Assignment Review"
 K ^TMP("SCTPTEXT",$J)
 S XMTEXT="^TMP(""SCTPTEXT"",$J,"
 S SCLCNT=0
 S SCPCT="0.00"
 IF $G(SCNT("TOTAL")) S SCPCT=(+$G(SCNT("BAD"))/+$G(SCNT("TOTAL")))*100
 ;
 ; -- summary info
 ;
 D SET("  In order to correct the following active positions with discharged team")
 D SET("assignments, please refer to the documentation for the Patient Team")
 D SET("Position Assignment Review option found in the Stand-alone Options")
 D SET("Section of the PCMM User Guide.")
 D SET(" ")
 ;
 ;D SET(" ")
 ;D SET(" Mode: "_$S(SCMODE=1:"Diagnostic Only",1:"Fix"))
 ;
 ; -- show teams
 D SET("   Teams Reviewed: "_$S(SCTMLST=1:"All",1:""))
 IF SCTMLST=0 D
 . ; -- sort and set
 . N SCTMI,X
 . S SCTMI=0
 . F  S SCTMI=$O(SCTMLST(SCTMI)) Q:'SCTMI  S X(SCTMLST(SCTMI)_SCTMI)=SCTMLST(SCTMI)
 . S SCTMI=""
 . F  S SCTMI=$O(X(SCTMI)) Q:SCTMI=""  D SET("       "_X(SCTMI))
 . D SET(" ")
 . Q
 ;
 D SET(" ")
 D SET("   Patient Team Position Assignments Reviewed: "_$J(+$G(SCNT("TOTAL")),6))
 D SET("   Number of Assignments with Problems       : "_$J(+$G(SCNT("BAD")),6)_"  ("_$J(SCPCT,6,2)_"%)")
 D SET(" ")
 D DASH("=")
 Q
 ;
FINAL ; -- clean up
 K ^TMP("SCTPTEXT",$J)
 Q
 ;
TEXT ; -- set of mm array
 N SCTMI,SCTPI,SCPTI,SCASDTI,SCPTAI
 ; 
 ; -- sort is by team, position, patient, assign date, position assignment ien
 ;
 S SCSTOP=0
 S SCTMI=""
 F  S SCTMI=$O(@SCERTMP@(SCTMI)) Q:SCTMI=""  D  Q:SCSTOP
 . S SCTPI="" F  S SCTPI=$O(@SCERTMP@(SCTMI,SCTPI)) Q:SCTPI=""  D
 . . S SCPTI="" F  S SCPTI=$O(@SCERTMP@(SCTMI,SCTPI,SCPTI)) Q:SCPTI=""  D
 . . . S SCASDTI=0 F  S SCASDTI=$O(@SCERTMP@(SCTMI,SCTPI,SCPTI,SCASDTI)) Q:'SCASDTI  D
 . . . . S SCTPAI=0 F  S SCTPAI=$O(@SCERTMP@(SCTMI,SCTPI,SCPTI,SCASDTI,SCTPAI)) Q:'SCTPAI  D PTA
 . ;
 . ; -- check if user asked job to stop
 . IF $$S^%ZTLOAD() S (SCSTOP,ZTSTOP)=1
 Q
 ;
PTA ; -- process errors for team position assignment
 N SCTP,SCTP0,SCTPNM
 N SCTM,SCTM0,SCTMNM
 N SCPT,SCPT0,SCPTNM,SCPTID
 N SCTPA,SCTPA0,SCTPASDT,SCTPUNDT
 N SCTMA,SCTMA0,SCTMASDT,SCTMUNDT
 N SCER
 ; -- get data
 D DATA^SCMCTPU3(SCTPAI)
 ;
 ; -- set mm text
 D SET(" Team: "_SCTMNM_"              Position: "_SCTPNM)
 D SET("         Patient: "_SCPTNM_" ("_SCPTID_")")
 S SCER=0
 F  S SCER=$O(@SCERTMP@(SCTMI,SCTPI,SCPTI,SCASDTI,SCTPAI,SCER)) Q:'SCER  D
 . IF SCER=1 D
 . . D SET("           Error: Position Assigned Date is BEFORE Team Assigned Date")
 . . D SET("                    Position Assigned Date: "_$$FMTE^XLFDT($E(SCTPASDT,1,7),"5Z"))
 . . D SET("                        Team Assigned Date: "_$$FMTE^XLFDT($E(SCTMASDT,1,7),"5Z"))
 . ; 
 . IF SCER=2 D
 . . D SET("           Error: Position Unassigned Date is AFTER Team Unassigned Date")
 . . D SET("                         Team Unassigned Date: "_$S(SCTMUNDT=9999999:"<none>",1:$$FMTE^XLFDT($E(SCTMUNDT,1,7),"5Z")))
 . . D SET("                     Position Unassigned Date: "_$S(SCTPUNDT=9999999:"<none>",1:$$FMTE^XLFDT($E(SCTPUNDT,1,7),"5Z")))
 . ; -- do fix if selected
 . IF SCMODE=2 D FIX
 D DASH()
 Q
 ;
FIX ; -- fix team position assignment entry (future)
 Q
 ;
SET(X) ;
 S SCLCNT=SCLCNT+1,^TMP("SCTPTEXT",$J,SCLCNT,0)=X
 Q
 ;
DASH(CHAR) ; -- send line of CHAR
 N X
 S $P(X,$E($G(CHAR,"-")),78)=""
 D SET(" "_X)
 Q
 ;
