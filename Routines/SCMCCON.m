SCMCCON ;ALB/REW - Patient Consult MailMessages ; 26 Mar 1996
 ;;5.3;Scheduling;**41,87,100,130**;AUG 13, 1993
 ;1
MAIL(DFN,SCCLNM,ENORAP,DATE,SCTMCNA) ;Do Patient Team Changes MailMan Message
 ;   DFN    - ien to PATIENT File
 ;   SCCLNM - Name of Clinic
 ;   ENORAP - Enrollment or Appointment? 1=Enrollment, 2=Appointment
 ;   DATE   - Date of interest, Default =DT
 ;   SCTMCNA- Array of teams affected
 ;
 ; - called by SCMC PT TEAM CHANGES MAIL MESSAGE protocol
 G:$G(SCNOMAIL) END  ;- flag can be set to stop message generation
 N XMDUZ,XMY,XMSUB,XMTEXT,VA,VAERR,XMZ,Y,SCCNXM
 N SCTMAR,SCSTAT,SCNODE,SCY,SCSPACE,SCCNDTS,SCSTAT,SCTM
 S SCCNDTS("BEGIN")=DATE,SCCNDTS("END")=DATE
 S SCSTAT=$S(ENORAP=1:"Enrollment",(ENORAP=2):"Appointment",1:"")
 S $P(SCSPACE," ",80)=""
 ;   SCTMAR - ARRAY OF TEAMS (before & after)
 ;set xmy array for practitioners in positions receiving consult notices
 G:'$$PCMMXMY^SCAPMC25(4,DFN,SCTMCNA,"SCCMDTS",0) END
 D:'$G(DGQUIET) EN^DDIOL("Sending Patient-Consult "_SCSTAT_" Message")
 D PID^VADPT6
 S SCPTNM=$P(^DPT(DFN,0),U,1)
 S XMSUB=SCSTAT_" PATIENT-CLINIC "_SCSTAT_" for Patient ("_$E(SCPTNM,1)_VA("BID")_")",XMTEXT="SCCNXM(",SCLNCNT=0
 D SETLN("This notice is sent because:")
 D SETLN("  The patient had an "_SCSTAT_" to "_$G(SCCLNM)_" and")
 D SETLN("  has restricted consults due to the following team assignment(s):")
 S SCTM=0
 F  S SCTM=$O(@SCTMCNA@(SCTM)) Q:'SCTM  D
 .D SETLN("         "_@SCTMCNA@(SCTM))
 S SCLNCNT=$$PCMAIL^SCMCMM(DFN,"SCCNXM",DT)
 S XMDUZ=$G(DUZ,.5)
 S XMY(XMDUZ)=""
 D ^XMD
END ;
 Q
 ;
SETLN(TEXT) ;
 Q:$G(TEXT)=""
 ; increments SCLNCNT, adds text to sccnxm(sclncnt)
 S SCLNCNT=SCLNCNT+1
 S SCCNXM(SCLNCNT)=TEXT
 Q
 ;
TEXT(SCFILE,SCNODE,SCPC,SCSPACE,SCLAB) ;returns fldname & external value
 ;returns fldname & external value
 ;   Note- Only works for non wp fields of standard numbering conventions
 ;   SCFLILE =FILENUM
 ;   SCNODE  = 0 NODE
 ;   SCPC    = piece of node
 ;   SCSPACE = 80 SPACES
 ;   SCLAB = 1 if print field name
 N SCX,SCINT,SCFLD
 S SCX=""
 S SCINT=$P(SCNODE,U,SCPC)
 G:SCINT="" QTTXT
 S SCFLD=SCPC*.01
 ;;;
 IF $G(SCLAB) D
 .S SCX=$$DDNAME^SCMCTMM(SCFLD)_":"
 .S:$G(SCLAB)=1 SCX=SCX_$E(SCSPACE,1,(23-$L(SCX)))
 .S:$G(SCLAB)=2 SCX=SCX_$E(SCSPACE,1,(50-$L(SCX)))
 S:SCINT]"" SCX=SCX_$$EXTERNAL^DILFD(SCFILE,SCFLD,"",SCINT)
QTTXT Q SCX
