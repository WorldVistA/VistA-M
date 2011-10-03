SCMCCV6 ;BP/CMF - PCMM HL7 Baseline Xmit to AAC ; March 26, 2000
 ;;5.3;Scheduling;**212**;AUG 13, 1993
 ;
 ;Traverse PATIENT TEAM POSITION ASSIGNMENT file (#404.43)
 ;and create events in file (#404.48) for all entries that meet
 ;the following criteria:
 ;    1. Field PC ROLE=1 ;..Primary Care
 ;           -- and one of the following --
 ;    2a. assignment is active as of SD*5.3*212 run date (now!)
 ;    2b. assignment was active as of SD*5.3*177 install date
 ;    2c. assignment was active between 2a and 2b 
 ;
 ;
 W !,"This is not an interactive entry point."
 W !,"This routine should only be executed by IRM staff"
 W !,"              -- ONCE --"
 W !,"using Taskman to Queue option 'PCMM BASELINE SEEDING'"
 W !,"to run during a non-busy period."
 Q
 ;
EN(SCTST,SCDFN) ;
 ; entry point for option 'SCMC PCMM BASELINE SEEDING'
 ;  this option should not be on any users menu
 ;  this option should be queued to run once
 ;  it should not be run more than once without consulting NVS
 ;
 ; input
 ;  SCTST - 1 = test [default = 0]
 ;  SCDFN - Patient IEN used to seed for restarts only [default = 0]
 ;
 S SCTST=+$G(SCTST,0)
 S SCDFN=+$G(SCDFN,0)
 N SCP177  ; patch 177 install date
 N SCP212  ; patch 212 run date
 N SC1,SC2 ; message holders
 N SCARRAY ; message text array
 N SCSTIM  ; process start time
 S SCSTIM=$$HTE^XLFDT($H)
 S SC1="PCMM PC Baseline Seed Process Aborted:"
 ;
 I $$VPATCH^SCUTBK3("SD*5.3*177")=0 D  Q
 . S SC2="  PCMM Patch 'SD*5.3*177' has not been loaded!"
 . D MSG(SC1,SC2)
 . Q
 ;
 I $$VPROGMR^SCUTBK3()=0 D  Q
 . S SC2="  User must have 'XUPROG' key!"
 . D MSG(SC1,SC2)
 . Q
 ;
 S SCP212=$$CHECK()
 I SCP212'="" D  Q
 . I +SCP212 D  Q
 . . S SC2="  PCMM Baseline seeded on "_$$FMTE^XLFDT(SCP212)_"."
 . . D MSG(SC1,SC2)
 . . Q
 . I SCP212=-1 D  Q
 . . S SC2="  Missing PCMM Parameter file entry."
 . . D MSG(SC1,SC2)
 . . Q
 . I SCP212=-2 D  Q
 . . S SC2="  FM Error retrieving data from PCMM Parameter file."
 . . D MSG(SC1,SC2)
 . . Q
 . S SC2="  Undefined Error."
 . D MSG(SC1,SC2)
 . Q
 ;
 S SCP177=$$PDAT^SCMCGU("SD*5.3*177")
 I +SCP177=0 D  Q
 . S SC2="  Unable to obtain SD*5.3*177 Installation Date."
 . D MSG(SC1,SC2)
 . Q
 ;
 I $$BASELINE(SCP177,DT,SCDFN,SCTST)'=1 D  Q
 . S SC2="  PCMM PC Baseline failed"_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 . D MSG(SC1,SC2)
 . Q
 ;
 Q
 ;
BASELINE(SCP177,SCP212,SCPDFN,SCPTST) ;
 ; input
 ;  SCP177 = Patch 177 date (required)
 ;  SCP212 = Patch 212 date (optional, default = today)
 ;  SCPDFN = Patient ien    (optional, default = 0)
 ;  SCPTST = 1 := test [default = 0]
 ;      
 ; output
 ;  1 = success
 ;  0 = failure
 ;
 N SCFLAG,SC1,SC2
 S SC1="PCMM PC Baseline Process Failure:"
 S SC177=$G(SCP177,"")
 I SC177="" D  Q 0
 . S SC2="  Invalid SD*5.3*177 Date Parameter"
 . D MSG(SC1,SC2)
 . Q
 S SC212=$G(SCP212,DT)
 I SC212="" D  Q 0
 . S SC2="  Invalid SD*5.3*212 Date (DT) Parameter"
 . D MSG(SC1,SC2)
 . Q
 S SCDFN=$G(SCPDFN,0)
 I SCDFN="" D  Q 0
 . S SC2="  Invalid DFN Parameter"
 . D MSG(SC1,SC2)
 . Q
 I '$D(^SCPT(404.43,"APCPOS")) D  Q 0
 . S SC2="  Missing ""APCPOS"" x-ref in file 404.43!"
 . D MSG(SC1,SC2)
 . Q
 ;
 S SCTST=+$G(SCPTST,0)
 S SCFLAG=$$EVENT(SC177,SC212,SCDFN,SCTST)
 ;
 I SCTST=1 D MSG("","",+SCFLAG) Q 1
 N SCFDA,SCERR,SC1,SC2
 S SC1="PCMM PC Baseline Seeding"
 S SC2=+$P(SCFLAG,U,2)
 S SCFLAG=+$P(SCFLAG,U)
 S SC1=SC1_$S(+SC2:" stopped by TM stop request:",1:" completed:")
 S SCFDA(1,404.44,"1,",17)=SC212
 D FILE^DIE("","SCFDA(1)","SCERR")
 I $D(SCERR) D 
 . S SC2="  Caution: Baseline Date NOT updated in PCMM Parameter file"
 . D MSG(SC1,SC2)
 . Q
 S SC2="  "_SCFLAG_" assignments placed in HL7 transmission queue."
 D MSG(SC1,SC2)
 Q 1
 ;
CHECK() ;
 ; Description:  Determine whether or not the Baseline has run.
 ;
 ; Input: None
 ;
 ; Output:
 ;   Function Value: Return date Baseline was run
 ;
 N SCX
 I '$D(^SCTM(404.44,1)) Q -1
 K ^TMP($J,"SCMCCV6")
 S SCX=$$GET1^DIQ(404.44,"1,",17,"I","","^TMP($J,""SCMCCV6"")")
 I $D(^TMP($J,"SCMCCV6")) S SCX=-2
 K ^TMP($J,"SCMCCV6")
 Q SCX
 ;
 ;
EVENT(SC177,SC212,SCDFN,SCTST) ;
 ; Description: Create an Event in file (#404.48)
 ;
 ; Input:
 ;   SC177 - date patch SD*5.3*177 was installed. [required]
 ;   SC212 - date process runs [default = DT]
 ;   SCDFN - patient ien (ptr file 2) [default = 0]
 ;   SCTST - 1 = test [default = 0]
 ;
 ; Output: 
 ;   p1 = number of entries created
 ;   p2 = stopped by Taskman
 ;
 N SCCNT   ; counter
 N SCPAI   ; position assignment IEN (ptr file 404.43)
 N SCTP    ; team position IEN (ptr file 404.57)
 N SCADT   ; position assignment start date
 N SCDDT   ; position assignment end date
 N SCNOW   ; time process starts
 N SCVAR   ; variable pointer string for HL7
 N SC1     ; shorthand for ' "APCPOS",SCDFN,1 ' node
 N SCZ     ; Taskman flag to stop process
 ;
 ; check for ZSTOP
 S SCZ=$$S^%ZTLOAD
 I +SCZ Q 0_U_1
 S SCTST=+$G(SCTST,0)
 K ^XTMP("SCMCCV6")
 S ^XTMP("SCMCCV6",0)=DT_U_$$FMADD^XLFDT(""_DT_"",7)_U_"SCMC PCMM BASELINE SEEDING"
 S SCNOW=$$NOW^XLFDT
 S SCCNT=0
 S SCDFN=+SCDFN
 F  S SCDFN=$O(^SCPT(404.43,"APCPOS",SCDFN)) Q:(SCDFN="")!(SCZ)  D
 . S SCZ=$$S^%ZTLOAD
 . Q:+SCZ
 . ;
 . S ^XTMP("SCMCCV6","LASTDFN")=SCDFN
 . S SC1="^SCPT(404.43,""APCPOS"",SCDFN,1)"
 . ;
 . ; quit if no PC assignments
 . Q:'$D(@SC1)
 . S SCADT=0
 . F  S SCADT=$O(@SC1@(SCADT)) Q:SCADT=""  D
 . . S SCTP=0
 . . F  S SCTP=$O(@SC1@(SCADT,SCTP)) Q:'SCTP  D
 . . . ;
 . . . ; quit if team position does not exist
 . . . Q:'$D(^SCTM(404.57,SCTP,0))
 . . . S SCPAI=0
 . . . F  S SCPAI=$O(@SC1@(SCADT,SCTP,SCPAI)) Q:'SCPAI  D
 . . . . S SCDDT=$P($G(^SCPT(404.43,SCPAI,0)),U,4)
 . . . . ;
 . . . . ; quit if not active within date range
 . . . . Q:$$DTCHK^SCAPU1(SC177,SC212,0,SCADT,SCDDT)<1
 . . . . S SCVAR=SCPAI_";SCPT(404.43,"
 . . . . ;
 . . . . ; add to HL7 event file
 . . . . Q:$$CHECK^SCMCHLB1(SCVAR)'=1
 . . . . ;
 . . . . ; queue for transmit or report
 . . . . I SCTST=0 D ADD^SCMCHLE("NOW",SCVAR,SCDFN,SCTP)
 . . . . I SCTST=1 S SCARRAY(SCCNT+3)=SCVAR_" ^ "_$$GET1^DIQ(2,SCDFN_",",.01)_" ^ "_$$GET1^DIQ(404.57,SCTP_",",.01)_" ^ "_$$FMTE^XLFDT(SCADT)_" ^ "_$$FMTE^XLFDT(SCDDT)
 . . . . ;
 . . . . ; increment counter
 . . . . S SCCNT=SCCNT+1
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 Q SCCNT_U_SCZ
 ;
MSG(SC1,SC2,SCTST) ;
 N XMY,XMDUZ,XMSUB,XMTEXT
 S SCTST=+$G(SCTST,0)
 S XMDUZ="PCMM Module"
 S (XMY(DUZ),XMY(XMDUZ))=""
 I SCTST=0 D
 . S XMSUB="PCMM PC Baseline Seeding Job"
 . K SCARRAY
 . S SCARRAY(1)=""
 . S SCARRAY(2)=SC1
 . S SCARRAY(3)=SC2
 . S SCARRAY(4)=""
 . S SCARRAY(5)="TaskMan Job Number:       "_$G(ZTSK)
 . S SCARRAY(6)="Baseline Start Date/Time: "_$G(SCSTIM)
 . S SCARRAY(7)="Baseline End Date/Time:   "_$$HTE^XLFDT($H)
 . S SCARRAY(8)="HL7 Transmit Limit:       "_$$GET1^DIQ(404.44,"1,",15)
 . S SCARRAY(9)=""
 . Q
 E  D
 . S XMSUB="PCMM PC Baseline Trial Entries ("_$G(ZTSK)_")"
 . S SCARRAY(1)=""
 . S SCARRAY(2)=SCTST_" entries would have been placed in HL7 queue:"
 . S SCARRAY(3)="==================================================="
 S XMTEXT="SCARRAY("
 D ^XMD
 Q
 ;
RESTART(SCTST) ; alb/rpm
 ; This undocumented entry point allows a user to clear the Baseline
 ; date stored in file #404.44 field #17.  Then the last patient IEN
 ; that was processed from the last run is retrieved from ^XTMP("SCMCCV6"
 ; and decremented to seed the restart point.  If ^XTMP does not exist
 ; the IEN is set to 0.
 ;
 ; Input:
 ;       SCTST - 1 = test [default = 0]
 ;
 S SCTST=+$G(SCTST,0)
 ;
 NEW SC1,SC2,SCDFA,SCDFN,SCERR
 S SC1="PCMM PC Baseline Seeding"
 S SCDFN=0
 ; Retrieve the last IEN processed
 I +$G(^XTMP("SCMCCV6","LASTDFN"))>0 D
 . S SCDFN=+$G(^XTMP("SCMCCV6","LASTDFN"))-1
 ; Delete the Baseline date from last run
 S SCFDA(1,404.44,"1,",17)="@"
 D FILE^DIE("","SCFDA(1)","SCERR")
 I $D(SCERR) D  Q
 . S SC2="  Warning: Baseline Date NOT cleared in PCMM Parameter file"
 . D MSG(SC1,SC2)
 . Q
 ; Call interactive entry point
 D EN(SCTST,SCDFN)
 Q
