SCMCCV3 ;bp/cmf - 195 Test/177 File - 404.57 preceptors to 404.53 ; Sep 1999
 ;;5.3;Scheduling;**195,177**;AUG 13, 1993
 ; 
 Q
 ;
ENXPD D EN(1) Q
 ;
ENPRE D EN(0) Q
 ;
EN(SCF) ;input = 1: Postinit(file)
 ;      = 0: PrePatch(validate)
 ;
 N SCY,SCI,SCTM,SCTP,SCREASON,SCZSTOP
 K ^TMP("SCMC",$J)
 S SCI=1
 D BLDI("")
 D BLDI($S(SCF:$$S(1),1:$$S(3)))
 D BLDI($$DTU())
 D BLDI($S(SCF:$$S(2),1:$$S(4)))
 D BLDI("")
 I SCF D  I 'SCREASON D BLD($$S(16)) G MAIL
 . S SCREASON=+$$FIND1^DIC(403.44,"","X","ACTIVATE PRECEPTOR LINK")
 . Q
 ;
LOOP S SCZSTOP=0
 S SCTMNM=""
 F  S SCTMNM=$O(^SCTM(404.51,"B",SCTMNM)) Q:(SCTMNM="")!(SCZSTOP)  D
 . S SCZSTOP=$S($$S^%ZTLOAD:1,1:0)
 . Q:SCZSTOP
 . S SCTM=$O(^SCTM(404.51,"B",SCTMNM,0))
 . Q:'+$$ACTTM^SCMCTMU(SCTM)        ;team inactive
 . Q:'$D(^SCTM(404.57,"C",SCTM))    ;no team positions
 . S SCTM(0)=1
 . S SCTP=0                         ;team position ien
 . F  S SCTP=$O(^SCTM(404.57,"C",SCTM,SCTP)) Q:('SCTP)!(SCZSTOP)  D
 . . S SCZSTOP=$S($$S^%ZTLOAD:1,1:0)
 . . Q:SCZSTOP
 . . S SCTP0=^SCTM(404.57,SCTP,0)   ;team position node
 . . Q:'+$P(SCTP0,U,10)             ;no preceptor entry
 . . S SCTPNM=$P(SCTP0,U)
 . . S SCTP(0)=1
 . . Q:$$AS(SCTP,SCTPNM,25)         ;already seeded
 . . Q:'+$$ACTTP(SCTP)              ;not active
 . . S SCTPFLAG=0
 . . D SCII
 . . I +$P(SCTP0,U,12) D SCY(6,SCTPNM,8) Q:$$SCF()
 . . S SCTPP=+$P(SCTP0,U,10)        ;preceptor team position ien
 . . I SCTPP=SCTP D SCY(6,SCTPNM,9) Q:$$SCF()
 . . I '+$$GETPRTP(SCTP) D SCY(6,SCTPNM,15) Q:$$SCF()
 . . S SCTPP0=^SCTM(404.57,SCTPP,0) ;preceptor team position node
 . . S SCTPPNM=$P(SCTPP0,U)
 . . I (+$P(SCTP0,U,4))&('+$P(SCTPP0,U,4)) D SCY(7,SCTPPNM,10) Q:$$SCF()
 . . I $P(SCTP0,U,2)'=$P(SCTPP0,U,2) D SCY(7,SCTPPNM,11) Q:$$SCF()
 . . I '+$$ACTTP(SCTPP) D SCY(7,SCTPPNM,12) Q:$$SCF()
 . . I +$P(SCTPP0,U,10) D SCY(7,SCTPPNM,13) Q:$$SCF()
 . . Q:$$AS(SCTPP,SCTPPNM,13)
 . . I '+$P(SCTPP0,U,12) D SCY(7,SCTPPNM,14) Q:$$SCF()
 . . I '+$$GETPRTP(SCTPP) D SCY(7,SCTPPNM,15) Q:$$SCF()
 . . I 'SCF D  Q
 . . . I 'SCTPFLAG D SCY(6,$$LINK(),17)
 . . . Q
 . . K SCFDA,SCERR
 . . S SCFDA(1,404.53,"+1,",.01)=SCTP
 . . S SCFDA(1,404.53,"+1,",.02)=DT
 . . S SCFDA(1,404.53,"+1,",.04)=1
 . . S SCFDA(1,404.53,"+1,",.05)=SCREASON
 . . S SCFDA(1,404.53,"+1,",.06)=SCTPP
 . . D UPDATE^DIE("","SCFDA(1)","","SCERR")
 . . I $D(SCERR) D SCY(7,$$LINK(),18)
 . . E  D SCY(7,$$LINK(),19)
 . . Q
 . Q
 I SCZSTOP D BLDI(0),BLD(26)
 ;
MAIL N XMY,XMDUZ,XMSUB,XMTEXT
 S XMDUZ=.5
 S (XMY(DUZ),XMY(XMDUZ))=""
 S XMSUB=$S(SCF=1:$$S(22),1:$$S(24))
 S XMTEXT="^TMP(""SCMC"",$J,"
 D ^XMD
 K ^TMP("SCMC",$J)
 Q
 ;
SCF() I +SCF Q 1
 S SCTPFLAG=1 Q 0
 ;
ACTTP(SCTP) Q $$ACTTP^SCMCTPU(SCTP)
 ;
GETPRTP(SCTP) Q $$GETPRTP^SCAPMCU2(SCTP,DT)
 ;
LINK() Q SCTPNM_"|"_SCTPPNM
 ;
AS(SC1,SC2,SC3) ; test for existing entry on filing
 ; input  SC1 := tm pos ien
 ;        SC2 := tm pos name
 ;        SC3  := line reference
 I 'SCF Q 0
 I $D(^SCTM(404.53,"B",SC1)) D SCY($S(SC3=13:7,1:6),SC2,SC3) Q 1
 Q 0
 ;
SCY(SC1,SC2,SC3) ;build msg array
 ; input SC1=line reference or text string
 ;       SC2=name string
 ;       SC3=line reference or text string
 ;
 D SCII
 ;I SC1=6,SCTM(0) D
 I SCTM(0) D
 . S SCTM(0)=0
 . D BLDI("")
 . D BLDI($$S(5)_SCTMNM)
 . Q
 I SC1=7,SCTP(0) D
 . S SCTP(0)=0
 . D BLDI($$S(6)_SCTPNM)
 D BLD($S(+SC1:$$S(SC1),1:SC1)_SC2_$S(+SC3:$$S(SC3),1:SC3))
 Q
 ;
BLDI(SCX) ; input = text string
 D BLD(SCX)
 D SCII
 Q
 ;
BLD(SCX) ; input = text string
 S ^TMP("SCMC",$J,SCI)=SCX
 Q
 ;
SCII S SCI=SCI+1
 Q
 ;
W(SCX) ;input  = 1:177 KIDS post-init, 0:177 pre-patch
 ;output = 1:KIDS record       , 0:selected device 
 I SCX=21 D MES^XPDUTL(.SCY) Q
 D EN^DDIOL(.SCY)
 Q
 ;
DTU() N SCDTU200,SCDTU,SCDTUX
 S SCDTU200=$G(DUZ,.5)
 S SCDTUX=$$NEWPERSN^SCMCGU(SCDTU200,"SCDTU")
 S SCDTUX=$S(SCDTUX>0:$P(SCDTU(SCDTU200),U),1:0)
 Q $$FMTE^XLFDT($$NOW^XLFDT)_" (by: "_SCDTUX_")"
 ;
ENMAIN(SCX) ;
 ; input = 21: sd*5.3*177 preceptor filer post init
 ;       = 23: sd*5.3*195 preceptor tester option
 K SCY
 S SCY(1)=""
 S SCY(2)=$S(SCX=21:$$S(1),1:$$S(3))
 S SCY(3)=$$DTU()
 S SCY(4)=$S(SCX=21:$$S(2),1:$$S(4))
 S SCY(5)=$$Q(SCX)
 K ZTSK
 S SCY(6)=""
 D W(SCX)
 Q
 ;                       
Q(SCX) ; run job in background
 ; input  = line reference 
 ; output = task #, report via mailman
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN=$S(SCX=21:$$S(21),1:$$S(23))
 S ZTDESC=$S(SCX=21:$$S(22),1:$$S(24))
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 Q $S(+ZTSK:": Queued - Task# "_ZTSK,1:": Not Queued!")
 ;
S(SCX) ;input  = line reference
 ;output = text string
 Q $P($T(T+SCX),";;",2)
 ;
T ;;
1 ;;Move current preceptor assignments to Preceptor History file;;
 ;;------------------------------------------------------------;;
 ;;Validate preceptor assignments vs Preceptor History requirements;;
 ;;----------------------------------------------------------------;;
5 ;;--> Team: ;;
 ;;  --> Position: ;;
 ;;    --> Preceptor: ;;
 ;;: 'Can Act As Preceptor' field must be 'NO'.;;
 ;;: cannot precept itself.;;
10 ;;: Preceptor must be PC if position is PC.;;
 ;;: Preceptor must be on same team.;;
 ;;: Preceptor must be active.;;
 ;;: cannot have a preceptor.;;
 ;;: 'Can Act As Preceptor' field must be 'YES'.;;
15 ;;: must have Staff Assigned.;;
 ;;Scheduling Reason file not updated... Process stopped... ;;
 ;;: Preceptor Link OK.;;
 ;;: Preceptor Link not filed <<  filer error  >>.;;
 ;;: Preceptor Link filed.;;
20 ;;: No Preceptor Assignments.;;
 ;;ENXPD^SCMCCV3;;
 ;;PCMM Preceptor Migration Filer;;
 ;;ENPRE^SCMCCV3;;
 ;;PCMM Preceptor Migration Report;;
25 ;; Link Already Seeded, filer stopped.;;
 ;; <<  Background job stopped by request.  >>;;
 ;
