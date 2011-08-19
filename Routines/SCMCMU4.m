SCMCMU4 ;ALB/MJK - PCMM Mass Team/Position Unassignment Bulletin ; 10-JUL-1998
 ;;5.3;Scheduling;**148**;AUG 13, 1993
 ;
BULL ; -- send bulletin
 N SCLCNT,XMY,XMTEXT,XMSUB,XMDUZ,SCINFO
 D INIT
 D TEXT
 D ^XMD
 D FINAL
 Q
 ;
INIT ; -- set vars for bulletin
 N SCCLN
 S XMDUZ=.5
 S XMY($S($G(DUZ):DUZ,1:XMDUZ))=""
 S XMSUB="Mass Team"_$S(SCMUTYPE="P":"Position",1:"")_" Unassignment Information"
 K ^TMP("SCMUTEXT",$J) S XMTEXT="^TMP(""SCMUTEXT"",$J,",SCLCNT=0
 ;
 S SCINFO("NAME","TEAM")=$P($G(^SCTM(404.51,+$G(SCTEAM),0),"Unknown"),U)
 ;
 IF SCMUTYPE="P" D
 . S SCPOS0=$G(^SCTM(404.57,+$G(SCPOS),0),"Unknown")
 . S SCINFO("NAME","POSITION")=$P(SCPOS0,U)
 . S SCCLN=+$P(SCPOS0,U,9)
 . IF SCCLN S SCINFO("NAME","CLINIC")=$P($G(^SC(SCCLN,0),""),U)
 . Q
 ;
 S SCINFO("NAME","USER")=$P($G(^VA(200,XMDUZ,0),"Unknown"),U)
 S SCINFO("DATE","EFFECTIVE")=$$FMTE^XLFDT($E(SCDATE,1,7),"5Z")
 ;
 Q
 ;
FINAL ; -- clean up
 K ^TMP("SCMUTEXT",$J)
 Q
 ;
TEXT ; -- set of mm array
 D SET("Mass Team"_$S(SCMUTYPE="P":"-Position",1:"")_" Unassignment has been completed.")
 D SET("")
 D SET("             Team: "_SCINFO("NAME","TEAM"))
 ;
 IF SCMUTYPE="P" D
 . D SET("         Position: "_SCINFO("NAME","POSITION"))
 . IF $G(SCINFO("NAME","CLINIC"))]"" D SET("           Clinic: "_SCINFO("NAME","CLINIC"))
 . Q
 ;
 D SET("             User: "_SCINFO("NAME","USER"))
 D SET("   Effective Date: "_SCINFO("DATE","EFFECTIVE"))
 ;
 D SET("")
 D SET(" Patients Processed")
 D SET("   Unassigned     : "_SCUNCNT)
 D SET("   Errors/Warnings: "_SCASCNT_"    (still assigned)")
 D SET("   Total          : "_SCSELCNT)
 ;
 D CLINIC
 D SET("")
 ;
 ; -- list pats that remain assigned
 D ERRARY
 ;
 D SET("")
 D SET("")
 ;
 ; -- list pats unassigned
 D OKARY
 Q
 ;
SET(X) ;
 S SCLCNT=SCLCNT+1,^TMP("SCMUTEXT",$J,SCLCNT,0)=X
 Q
 ;
ERRARY ; -- process error array
 N SCNT,SCX,SCER,SCERI
 ;
 D SET(" Error List:")
 D SET(" ===========")
 ;
 IF '$O(@SCBADAR@(0)) D  Q
 . D SET("     No errors to report.")
 . Q
 ;
 D HDR
 ;
 S SCNT=0
 F  S SCNT=$O(@SCBADAR@(SCNT)) Q:'SCNT  D
 . S SCX=@SCBADAR@(SCNT)
 . D PT(SCNT)
 . ;
 . IF '$D(@SCERRAR@(SCNT)) Q
 . S SCERI=0
 . F  S SCERI=$O(@SCERRAR@(SCNT,"TEAM",SCTEAM,SCERI)) Q:'SCERI  D
 . . S SCER=$G(@SCERRAR@(SCNT,"TEAM",SCTEAM,SCERI))
 . . D SET("     >>> "_SCER)
 . . Q
 . ;
 . IF '$O(@SCERRAR@(SCNT,"POS",0)) Q
 . S SCPOS=0
 . F  S SCPOS=$O(@SCERRAR@(SCNT,"POS",SCPOS)) Q:'SCPOS  D
 . . IF SCMUTYPE="T" D SET("     >>> Position: "_$P($G(^SCTM(404.57,SCPOS,0),"Unknown"),U))
 . . S SCERI=0
 . . F  S SCERI=$O(@SCERRAR@(SCNT,"POS",SCPOS,SCERI)) Q:'SCERI  D
 . . . S SCER=$G(@SCERRAR@(SCNT,"POS",SCPOS,SCERI))
 . . . D SET("         >>>> "_SCER)
 . . . Q
 . . Q
 . D SET("")
 . Q
 Q
 ;
OKARY ; -- process ok array
 N SCNT,SCPT,SCX
 D SET(" Unassigned List:")
 D SET(" ================")
 ;
 IF '$O(@SCOKAR@(0)) D  Q
 . D SET("     No patients unassigned.")
 . Q
 ;
 D HDR
 ;
 S SCNT=0
 F  S SCNT=$O(@SCOKAR@(SCNT)) Q:'SCNT  D
 . D PT(SCNT)
 . D TM(SCNT)
 . D POS(SCNT)
 . Q
 Q
 ;
HDR ; -- send patient info header
 S X=""
 S X=$$SETSTR^VALM1("Patient",X,2,7)
 S X=$$SETSTR^VALM1("ID",X,40,2)
 D SET(X)
 ;
 S X=""
 S X=$$SETSTR^VALM1("-------",X,2,7)
 S X=$$SETSTR^VALM1("--",X,40,2)
 D SET(X)
 Q
 ;
PT(SCNT) ; -- send patient info
 N NAME,ID,X,SCPT,SCX
 S SCPT=$G(@SCPTINFO@(SCNT))
 S NAME=$P(SCPT,U,2)
 S ID=$P(SCPT,U,6)
 S X=""
 S X=$$SETSTR^VALM1(NAME,X,2,30)
 S X=$$SETSTR^VALM1(ID,X,40,15)
 D SET(X)
 Q
 ;
TM(SCNT) ; -- show any team info for patient
 N SCTMMSG
 S SCTMMSG=$G(@SCOKAR@(SCNT,"TEAM",SCTEAM,1))
 D INFO("TEAM",SCTEAM)
 Q
 ;
POS(SCNT) ; -- send position (for team unassignment) & clinic discharge info
 N SCPOS,SCTPMSG,SCCLNM,SCPOS0,SCLNX,SCI
 S SCPOS=0
 F  S SCPOS=$O(@SCOKAR@(SCNT,"POS",SCPOS)) Q:'SCPOS  D
 . S SCTPMSG=$G(@SCOKAR@(SCNT,"POS",SCPOS,1))
 . S SCLNX=$G(@SCOKAR@(SCNT,"CLINIC",SCPOS,1))
 . S SCPOS0=$G(^SCTM(404.57,SCPOS,0))
 . ;
 . IF SCMUTYPE="T" D
 . . D SET("     >>> Position assignment to "_$P(SCPOS0,U)_$S(SCTPMSG="":" was unassigned.",1:":"))
 . D INFO("POS",SCPOS)
 . ;
 . IF SCLNX]"",$D(SCTPDIS(SCPOS)) D
 . . S SCCLNM=$P($G(^SC(+$P(SCPOS0,U,9),0),"Unkown"),U)
 . . IF +SCLNX=1 D SET("          >>> Discharged from '"_SCCLNM_"' clinic")
 . . IF +SCLNX=2 D
 . . . D SET("              Still enrolled in '"_SCCLNM_"' clinic")
 . . . D SET("              Reason: "_$P(SCLNX,U,2))
 . . Q
 . Q
 Q
 ;
CLINIC ; -- display clinic to be discharged from
 N SCPOS,SCX,Y
 D SET(" ")
 IF '$O(SCTPDIS(0)) D  G CLINICQ
 . D SET(" Clinic Discharges:  None")
 . Q
 ;
 S Y=""
 S Y=$$SETSTR^VALM1("Clinic Discharges:",Y,2,20)
 S Y=$$SETSTR^VALM1("Position",Y,25,25)
 S Y=$$SETSTR^VALM1("Associated Clinic",Y,55,25)
 D SET(Y)
 S Y=""
 S Y=$$SETSTR^VALM1("--------",Y,25,25)
 S Y=$$SETSTR^VALM1("-----------------",Y,55,25)
 D SET(Y)
 ;
 S SCPOS=0
 F  S SCPOS=$O(SCTPDIS(SCPOS)) Q:'SCPOS  D
 . S SCX=$G(^SCTM(404.57,SCPOS,0),"Unknown")
 . S Y=""
 . S Y=$$SETSTR^VALM1($E($P(SCX,U),1,25),Y,25,25)
 . S Y=$$SETSTR^VALM1($E($P($G(^SC(+$P(SCX,U,9),0),"Unknown"),U),1,25),Y,55,25)
 . D SET(Y)
 . Q
 ;
CLINICQ Q
 ;
INFO(TYPE,SCIEN) ; -- load ok info text
 N SCI
 S SCI=0
 F  S SCI=$O(@SCOKAR@(SCNT,TYPE,SCIEN,SCI)) Q:'SCI  D
 . S X=$G(@SCOKAR@(SCNT,TYPE,SCIEN,SCI))
 . IF X]"" D SET("     "_X)
 . Q
 Q
 ;
