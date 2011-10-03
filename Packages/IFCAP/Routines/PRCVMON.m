PRCVMON ;ISC-SF/GJW;Monitor subscriptions ; 6/6/05 3:48pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
INIT ;Create initial set of FCP balances
 N I,J,K,IENS,OUT,STAT,FCP
 N IENS1,BAL,NODE
 S I=""
 F  S I=$O(^PRCV(414.03,"AC",1,I)) Q:I=""  D
 .S IENS=I_","
 .D GETS^DIQ(414.03,IENS,"@;.01;.02","I","OUT")
 .S STAT=$G(OUT(414.03,IENS,.01,"I"))
 .S FCP=$G(OUT(414.03,IENS,.02,"I"))
 .K OUT
 .S J=0
 .;The pattern match is needed because IENs in this subfile
 .;are actually strings, not (canonic) numbers
 .F  S J=$O(^PRC(420,STAT,1,FCP,4,J)) Q:((J="")!(J?1.A))  D
 ..;Unfortunately, an IEN of "00" confuses Fileman, so it is
 ..;necessary to use a global read instead of a Fileman call.
 ..I $$FY4(J)'<$$GETFY D
 ...S NODE=$G(^PRC(420,STAT,1,FCP,4,J,0))
 ...F K=1:1:4 D
 ....S BAL(K)=+$P(NODE,"^",K+1)
 ...D UPD(STAT,FCP,J,.BAL)
 Q
 ;
 ;Reset values to contents of PRCVAL
RESET(PRCVAL) ;
 N STAT,FCP,FY,I,MYBAL
 S STAT=""
 F  S STAT=$O(@PRCVAL@(STAT)) Q:STAT=""  D
 .S FY=""
 .F  S FY=$O(@PRCVAL@(STAT,FY)) Q:FY=""  D
 ..I $$FY4(FY)'<$$GETFY D
 ...S FCP=""
 ...F  S FCP=$O(@PRCVAL@(STAT,FY,FCP)) Q:FCP=""  D
 ....F I=1:1:4 D
 .....S MYBAL(I)=$G(@PRCVAL@(STAT,FY,FCP,I))
 ....;update 414.03
 ....D UPD(STAT,FCP,FY,.MYBAL)
 Q
 ;
 ;Schedule the task
SCHED ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTPRI,ZTSK
 ;Quit if not a DM site
 I '$$CHK D  Q
 .W !,"This task may not be scheduled at a non-Dynamed site."
 I $$ISRUN D  Q
 .W !,$C(7),"The FCP monitor is already running!"
 ;
 ;Go ahead and schedule the task
 S ZTRTN="RUN^PRCVMON"
 S ZTDESC="FCP Balance Monitor"
 S ZTDTH=$H ;right now
 S ZTIO=""
 S ZTPRI=3
 D ^%ZTLOAD
 D ISQED^%ZTLOAD
 I $L($G(ZTSK(0)))>0 D
 .D SETRUN(1)
 .W !,"The FCP monitor (task # ",$G(ZTSK),") was scheduled"
 .W " to run at ",$$HTE^XLFDT(ZTSK("D"))
 Q
 ;
DIFF(PRCVX,PRCVY) ;
 N T1,T2,VAL
 ;check for wrap-around
 I PRCVY<PRCVX D
 .S T1=86400-PRCVX
 .S T2=PRCVY
 .S VAL=T1+T2
 Q:PRCVY<PRCVX VAL
 S VAL=PRCVY-PRCVX
 Q VAL
 ;
RUN ;
 N STAT,FCP,OUT,OUT1,OUT2,FY,FY2,FYIEN,VAL,VAL2,DELTA
 N I,J,K,IX,IENS,IENS1,IENS2,IENS3,MROOT,PRCVQUIT
 S PRCVSTRT=$P($H,",",2)
 S DELTA=0
 ;Quit if not a DM site
 I '$$CHK D  Q
 .D SETRUN(0)
 N $ET,$ES S $ET="D TRAP^PRCVMON"
 ;
 D INIT ;initialize 414.03 from 420 (one time only)
 S PRCVQUIT=0
 ;loop through the active subscriptions
LOOP ;
 H 1 ;breathing room
 ;Asked to stop?
 S:$D(PRCVEND) DELTA=+$G(DELTA)+$$DIFF(PRCVSTRT,PRCVEND)
 I +$G(DELTA)'<120 D
 .I $$S^%ZTLOAD S PRCVQUIT=1
 .I $$SHLDSTP S PRCVQUIT=1
 .S PRCVSTRT=$P($H,",",2)
 .S DELTA=0
 G:PRCVQUIT DONE
ONCE ;
 S VAL=$NA(^TMP("PRCVAL",$J)) ;values from 420
 S VAL2=$NA(^TMP("PRCVAL2",$J)) ;values from 414.03
 ;
 ;for each subscription type
 S I=""
 F  S I=$O(^PRCV(414.03,"AC",1,I)) Q:I=""  D
 .S IENS=I_","
 .D GETS^DIQ(414.03,IENS,"@;.01;.02","I","OUT")
 .S STAT=$G(OUT(414.03,IENS,.01,"I"))
 .S FCP=$G(OUT(414.03,IENS,.02,"I"))
 .K OUT
 .;get a list of values from file 420
 .S IENS1=","_FCP_","_STAT_","
 .D LIST^DIC(420.06,IENS1,"@;.01;1;2;3;4","P",,,,"B",,,"OUT1")
 .S J=""
 .F  S J=$O(OUT1("DILIST",J)) Q:J=""  D
 ..S FYIEN=$P($G(OUT1("DILIST",J,0)),"^",1)
 ..S FY=$P($G(OUT1("DILIST",J,0)),"^",2)
 ..I $$FY4(FY)'<$$GETFY D
 ...S @VAL@(STAT,FY,FCP,1)=$P($G(OUT1("DILIST",J,0)),"^",3)
 ...S @VAL@(STAT,FY,FCP,2)=$P($G(OUT1("DILIST",J,0)),"^",4)
 ...S @VAL@(STAT,FY,FCP,3)=$P($G(OUT1("DILIST",J,0)),"^",5)
 ...S @VAL@(STAT,FY,FCP,4)=$P($G(OUT1("DILIST",J,0)),"^",6)
 .K OUT1
 .S K=0
 .F  S K=$O(^PRCV(414.03,I,1,K)) Q:+K'>0  D
 ..S IENS2=K_","_I_","
 ..S FY2=$$GET1^DIQ(414.031,IENS2,.01)
 ..S IENS3=","_IENS2
 ..D LIST^DIC(414.0311,IENS3,"@;.01;1","P",,,,"B",,,"OUT2","MROOT")
 ..I $$FY4(FY2)'<$$GETFY D
 ...F IX=1:1:4 D
 ....S @VAL2@(STAT,FY2,FCP,IX)=$P($G(OUT2("DILIST",IX,0)),"^",3)
 ...K OUT2
 ;Reset the values in 414.03
 ;The old values are not needed, as they have been captured in ^TMP.
 D RESET(VAL)
 ;Now, compare the values
 D COMP2(VAL,VAL2)
 K @VAL,@VAL2
 H 10 ;breathing room
 S PRCVEND=$P($H,",",2) ;seconds since midnight
 Q:'$D(PRCVQUIT)
 G LOOP
DONE ;
 K PRCVSTRT,PRCVEND
 D SETRUN(0)
 Q
 ;
COMP2(PRCVNEW,PRCVOLD) ;
 N STAT,FY,FCP,PRCVTMP1,PRCVTMP2
 S STAT=""
 F  S STAT=$O(@PRCVNEW@(STAT)) Q:STAT=""  D
 .S FY=""
 .F  S FY=$O(@PRCVNEW@(STAT,FY)) Q:FY=""  D
 ..S FCP=""
 ..F  S FCP=$O(@PRCVNEW@(STAT,FY,FCP)) Q:FCP=""  D
 ...K PRCVTMP1,PRCVTMP2
 ...M PRCVTMP1=@PRCVNEW@(STAT,FY,FCP)
 ...M PRCVTMP2=@PRCVOLD@(STAT,FY,FCP)
 ...D CHECK(.PRCVTMP1,.PRCVTMP2,STAT,FY,FCP)
 K PRCVTMP1,PRCVTMP2
 Q
 ;
CHECK(PRCVNBAL,PRCVOBAL,PRCVSTAT,PRCVFY,PRCVCP) ;
 N I,CHG
 Q:$$FY4(PRCVFY)<$$GETFY  ;don't send anything for past years
 S CHG=0 ;assume no change
 F I=1:1:4 I +$G(PRCVNBAL(I))'=+$G(PRCVOBAL(I)) S CHG=1
 I CHG D SEND(PRCVSTAT,PRCVFY,PRCVCP,.PRCVNBAL)
 Q
 ;
SEND(PRCVSTAT,PRCVFY,PRCVCP,PRCVBAL) ;
 N OBJ,PROTO,MYOPTNS,MYRES
 S OBJ=$NA(^TMP($J,"PRCV_FBAL"))
 S @OBJ@("TIME")=$$NOW^XLFDT
 S @OBJ@("STAT")=$G(PRCVSTAT)
 S @OBJ@("FCP_NUM")=$G(PRCVCP)
 S @OBJ@("FY")=$G(PRCVFY)
 S @OBJ@("1QBAL")=$G(PRCVBAL(1))
 S @OBJ@("2QBAL")=$G(PRCVBAL(2))
 S @OBJ@("3QBAL")=$G(PRCVBAL(3))
 S @OBJ@("4QBAL")=$G(PRCVBAL(4))
 D BLD1^PRCVBLD(OBJ)
 S PROTO="PRCV_DYNAMED_22_EV_FUND_BAL_DATA"
 S MYOPTNS("NAMESPACE")="PRCV"
 D GENERATE^HLMA(PROTO,"GM",1,.MYRES,,.MYOPTNS)
 K @OBJ
 Q
 ;
 ;Update 414.03
UPD(PRCVSTAT,PRCVFCP,PRCVFY,PRCVBAL) ;
 N OUT,VAL,IEN,IENS1,IENS2,MYFDA,I
 N MROOT
 S VAL(1)=PRCVSTAT
 S VAL(2)=PRCVFCP
 S VAL(3)=1
 D FIND^DIC(414.03,,"@;.01;.02;.03","KX",.VAL,,,,,"OUT","MROOT")
 S IEN=$G(OUT("DILIST",2,1))
 S IENS1="?+1"_","_IEN_","
 S MYFDA(414.031,IENS1,.01)=PRCVFY
 S I=""
 F  S I=$O(PRCVBAL(I)) Q:I=""  D
 .S IENS2="?+"_(I+1)_","_IENS1
 .S MYFDA(414.0311,IENS2,.01)=I
 .S MYFDA(414.0311,IENS2,1)=$G(PRCVBAL(I))
 D UPDATE^DIE("EK","MYFDA",,"MROOT")
 Q
 ;
TRAP ;
 ;clear the 'run' flag
 D SETRUN(0)
 ;Have the temporary globals been deleted?
 S VAL=$G(VAL),VAL2=$G(VAL2)
 I VAL?1"^".E1"(".E K @VAL
 I VAL2?1"^".E1"(".E K @VAL2
 D ^%ZTER
 D UNWIND^%ZTER
 Q
 ;
 ;Provide a convenient way to enable/disable monitor
GETSTAT() ;
 N PRMY,IENS
 S PRMY=$$PSTAT
 S IENS=PRMY_","
 Q +$$GET1^DIQ(411,IENS,106,"I")
 ;
SETSTAT(PRCVST) ;
 N FDA,IENS,PRMY,STATE
 S PRCVST=$G(PRCVST)
 S STATE=$$EXTERNAL^DILFD(411,106,,PRCVST)
 I STATE="" D  Q
 .W:IO=IO(0) !,"Invalid status!"
 W:IO=IO(0) !,"Setting status to ",STATE
 S PRMY=$$PSTAT
 S IENS=PRMY_","
 S FDA(411,IENS,106)=PRCVST
 D UPDATE^DIE("","FDA")
 Q
 ;
SETRUN(PRCVST) ;
 N FDA,IENS,PRMY
 S PRCVST=+$G(PRCVST)
 Q:((PRCVST'=0)&(PRCVST'=1))
 S PRMY=$$PSTAT
 S IENS=PRMY_","
 S FDA(411,IENS,107)=PRCVST
 D UPDATE^DIE("","FDA")
 Q
ISRUN() ;
 N PRMY,IENS
 S PRMY=$$PSTAT
 S IENS=PRMY_","
 Q +$$GET1^DIQ(411,IENS,107,"I")
 ;
GETFY() ;
 N DATE,YEAR,MON,FY
 ;Get the calendar year
 S DATE=$$DT^XLFDT
 S YEAR=($E(DATE,1)+17)*100+$E(DATE,2,3)
 S MON=+$E(DATE,4,5)
 S FY=$S(MON>9:YEAR+1,1:YEAR)
 Q FY
 ;
FY4(PRCVFY) ;
 I $L(PRCVFY)'<4 Q PRCVFY
 I +$G(PRCVFY)'<30 Q 1900+PRCVFY
 Q 2000+PRCVFY
 ;
 ;Various simple checks
CHK() ;
 Q $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")
 ;
 ;Primary station
PSTAT() ;
 N PRMY
 I '$D(^PRC(411,"AC","Y")) Q 0  ;no primary station in x-ref
 Q $O(^PRC(411,"AC","Y",""))
 ;
 ;Should the monitor stop?
SHLDSTP() ;
 N FLG
 S FLG=$$GETSTAT
 Q $S(FLG=0:1,FLG=1:0,FLG=2:1,1:1)
 ;
PUSH1(PRCVSTAT,PRCVFY,PRCVCP) ;
 N OBJ,PROTO,MYOPTNS,MYRES
 S OBJ=$NA(^TMP($J,"PRCV_FBAL"))
 S @OBJ@("TIME")=$$NOW^XLFDT
 S @OBJ@("STAT")=$G(PRCVSTAT)
 S @OBJ@("FCP_NUM")=$G(PRCVCP)
 S @OBJ@("FY")=$G(PRCVFY)
 S @OBJ@("1QBAL")=+$P($G(^PRC(420,PRCVSTAT,1,PRCVCP,4,PRCVFY,0)),"^",2)
 S @OBJ@("2QBAL")=+$P($G(^PRC(420,PRCVSTAT,1,PRCVCP,4,PRCVFY,0)),"^",3)
 S @OBJ@("3QBAL")=+$P($G(^PRC(420,PRCVSTAT,1,PRCVCP,4,PRCVFY,0)),"^",4)
 S @OBJ@("4QBAL")=+$P($G(^PRC(420,PRCVSTAT,1,PRCVCP,4,PRCVFY,0)),"^",5)
 D BLD1^PRCVBLD(OBJ)
 S PROTO="PRCV_DYNAMED_22_EV_FUND_BAL_DATA"
 S MYOPTNS("NAMESPACE")="PRCV"
 D GENERATE^HLMA(PROTO,"GM",1,.MYRES,,.MYOPTNS)
 ;W:IO=IO(0) !,"Message generated: ",$P(MYRES,"^",1)
 K @OBJ
 Q
