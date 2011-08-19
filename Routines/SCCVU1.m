SCCVU1 ;ALB/RMO,TMP - SCHED VISITS CONVERT/ARCHIVE UTILITIES; [ 10/10/95  2:39 PM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
CHKDT(SCRESULT,SC,SCCVTYP) ; -- Check date range
 ; Input  -- SC       Array:
 ;                    SC("STARTDT")    Start date
 ;                      ("ENDDT")      End date
 ;        -- SCCVTYP "CST" for convert function
 ;                   "AST" for archive function
 ; Output -- SCRESULT (#=Error number | 0=No Error)^Message
 ;
 N SCENDT,SCERRMSG,SCERRNB,SCSTDT
 ;
 S SCERRNB=0
 ;
 S SCSTDT=$G(SC("STARTDT"))
 S SCENDT=$G(SC("ENDDT"))
 ;
 ;Check if start date or end date not defined
 I 'SCSTDT,'SCENDT D
 . S SCERRNB=4049006.005
 . D GETERR^SCCVLOG1(SCERRNB,"","","",1,.SCERRMSG)
 ;
 ;Verify date range
 I 'SCERRNB S SCERRNB=$$VERDT^SCCVU2(SCSTDT,SCENDT,"",.SCERRMSG)
 ;
 S SCRESULT=SCERRNB
 I SCERRNB S SCRESULT=SCRESULT_U_$$BLDSTR(.SCERRMSG)
 ;
CHKDTQ Q
 ;
CHKDUP(SCRESULT,SC,SCCVT) ; -- Check duplicate log entries
 ; Input  -- SC       Array:
 ;                    SC("TYPE")      Conversion type
 ;                      ("STARTDT")   Start date
 ;                      ("ENDDT")     End date
 ;                      ("TEMPLNO")    Template number ien
 ;        -- SCCVT   "CST" for convert function
 ;                   "AST" for archive function
 ; Output -- SCRESULT (#=Error number | 0=No Error)^Message
 ;
 N SCCVTYP,SCENDT,SCERRMSG,SCERRNB,SCLOG,SCSTDT
 ;
 S SCERRNB=0
 ;
 S SCCVTYP=$G(SC("TYPE"))
 S SCSTDT=$G(SC("STARTDT"))
 S SCENDT=$G(SC("ENDDT"))
 S SCLOG=$G(SC("TEMPLNO"))
 ;
 ;Check if type, date range and Template number ien are defined
 I 'SCCVTYP!('SCSTDT)!('SCENDT)!('SCLOG) D
 . S SCERRNB=4049006.002
 . D GETERR^SCCVLOG1(SCERRNB,"","","",1,.SCERRMSG)
 ;
 ;Check duplicate log entries
 I 'SCERRNB S SCERRNB=$$CHKDUP^SCCVU2(SCCVTYP,SCSTDT,SCENDT,SCLOG,.SCERRMSG)
 ;
 S SCRESULT=SCERRNB
 I SCERRNB S SCRESULT=SCRESULT_U_$$BLDSTR(.SCERRMSG)
 ;
CHKDUPQ Q
 ;
PROCREQ(SCRESULT,SC) ; -- Process conversion/estimate request
 ; Input  -- SC       Array:
 ;                    SC("TEMPLNO")    Template number ien
 ;                      ("REQNUM")     Request number ien
 ; Output -- SCRESULT (#=Error number | 0=No Error)^Message
 ;
 N SCERRMSG,SCERRNB,SCLOG,SCREQ,SCREQACT,SCREQEVT
 S SCERRNB=0
 ;
 S SCLOG=$G(SC("TEMPLNO"))
 S SCREQ=$G(SC("REQNUM"))
 ;
 ;Quit if Template number ien or request ien are not defined
 I 'SCLOG!('SCREQ) D
 . S SCERRNB=4049006.003
 . D GETERR^SCCVLOG1(SCERRNB,"","","",1,.SCERRMSG)
 ;
 S SCRESULT=$S('SCERRNB:0,1:SCERRNB_U_$$BLDSTR(.SCERRMSG))
 ;
 G:SCERRNB PROCREQQ
 ;
 ; Set request action
 S SCREQACT=$P($G(^SD(404.98,SCLOG,"R",SCREQ,0)),U,2)
 S SCREQEVT=$P($G(^SD(404.98,SCLOG,"R",SCREQ,0)),U,3)
 ;
 ; Queue conversion request to start or re-start
 I "^1^3^"[(U_SCREQACT_U) D 
 . D QUE^SCCVE(SCLOG,SCREQ)
 . IF SCREQEVT D JOURNAL(SCLOG)
 ;
 ; Process conversion request to stop
 I SCREQACT=2 D STOP^SCCVE(SCLOG,SCREQ)
 ;
PROCREQQ Q
 ;
TASKSTA(SCRESULT,SCLOG) ; -- Retrieve task status description
 ; Input  -- SCLOG    Template number ien
 ; Output -- 
 ;    SCRESULT (0^Task status description^status code or Error #^Message)
 ;
 N SCERRNB,SCTSKD,ZTCPU
 ;
 S SCERRNB=0
 S SCTSKD="Unknown"
 ;
 ;Quit if Template number ien is not defined
 I '$G(SCLOG) D  G TASKSTAQ
 . S SCERRNB=4049006.004
 . D GETERR^SCCVLOG1(SCERRNB,"","","",0,.SCERRMSG)
 ;
 ;Get task status description
 I 'SCERRNB D
 . S ZTSK=$P($G(^SD(404.98,SCLOG,1)),U,3),ZTCPU=$P($G(^(1)),U,4)
 . I ZTSK D
 . . D STAT^%ZTLOAD
 . . S SCTSKD=ZTSK(2)_U_ZTSK(1)
 ;
 S SCRESULT=SCERRNB_U_SCTSKD
 ;
TASKSTAQ Q
 ;
BLDSTR(E) ; -- Build error message string
 ; Input  -- E        Error message array
 ; Output -- Error message string for display purposes
 N I,Y,STOP
 S Y=""
 S (I,STOP)=0
 F  S I=$O(E(I)) Q:'I  D  Q:STOP
 . I ($L(Y)+$L(E(I)))<240 S Y=Y_" "_E(I) Q
 . S STOP=1
 Q $G(Y)
DTOK(SC) ; -- Verify that date range is OK
 N SCERR,SCOK
 S SCOK=1
 D CHKDT(.SCERR,.SC)
 G:$G(SCERR) DTOKQ
 S SC("TEMPLNO")=DA,SC("TYPE")=1
 D CHKDUP(.SCERR,.SC,"CST")
 ;
DTOKQ ;
 I +$G(SCERR) W !!,*7,$P(SCERR,U,2),!! S SCOK=0
 Q SCOK
 ;
CNVTSCH(SCLOG) ; -- Function determines if any convert was scheduled
 ; Returns 0 if none scheduled, 1 if any ever scheduled
 N SCSCH,Z
 S SCSCH=0
 S Z=0 F  S Z=$O(^SD(404.98,SCLOG,"R",Z)) Q:'Z  I $P($G(^(Z,0)),U,3) S SCSCH=1 Q
 Q SCSCH
 ;
JOURNAL(SCLOG) ; -- display journal message and global growth estimates
 N DIC,DR,DIQ,DA,SCDATA,SCTOT,FLD
 S DIC="404.98",DA=SCLOG,DR="207:211",DIQ="SCDATA",DIQ(0)="E"
 D EN^DIQ1
 S SCTOT=0
 F FLD=207:1:211 S SCTOT=SCTOT+$G(SCDATA(404.98,SCLOG,FLD,"E"))
 ;
 W !
 W !,">>> The estimated global growth profile for this template is the following:"
 W !
 W !,?10,"Global",?25,"Blocks",?40,"[Block Size: ",$$BLKSIZE^SCCVEGU1()," bytes]"
 W !,?10,"---------",?25,"-----------"
 W !,?10,"^SCE",?25,$J($FN($G(SCDATA(404.98,SCLOG,207,"E")),","),11)
 W !,?10,"^AUPNVSIT",?25,$J($FN($G(SCDATA(404.98,SCLOG,208,"E")),","),11)
 W !,?10,"^AUPNVPRV",?25,$J($FN($G(SCDATA(404.98,SCLOG,209,"E")),","),11)
 W !,?10,"^AUPNVPOV",?25,$J($FN($G(SCDATA(404.98,SCLOG,210,"E")),","),11)
 W !,?10,"^AUPNVCPT",?25,$J($FN($G(SCDATA(404.98,SCLOG,211,"E")),","),11)
 W !,?10,"---------",?25,"-----------"
 W !,?10,"Total",?25,$J($FN(SCTOT,","),11)
 ;
 W !
 W !,">>> Please verify that enough global disk space and journal space"
 W !,"    are available for these anticipated increases."
 W !
 W !,">>> Also, please verify that system backup is not scheduled to"
 W !,"    run within the start and stop times of this conversion job."
 W !
 D PAUSE^SCCVU
 Q
 ;
