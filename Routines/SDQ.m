SDQ ;ALB/MJK - Query Object Methods ;8/12/96
 ;;5.3;Scheduling;**131**;Aug 13, 1993
 ;
OPEN(SDQ,SDERR) ; -- SDQ OPEN                                     [API ID: 79]
 D PREP^SDQUT
 ;
 ; -- get query object instance and set up query class info
 IF '$$CREATE(.SDQ,"SD STANDARD ENCOUNTER QUERY",$G(SDERR)) G OPENQ
 ;
 ; -- do query object instance kills and sets
 K @SDQUERY@(SDQ)
 S @SDQUERY@(SDQ)=""
 F X="SCAN" M @SDQUERY@(SDQ,X)=^TMP("SDQUERY CLASS",$J,SDQ,X)
 D STOP^SDQPROP(.SDQ)
 ;
 ; -- do open actions
 N SDOPEN
 S SDOPEN=$G(^TMP("SDQUERY CLASS",$J,SDQ,"OPEN"))
 IF SDOPEN]"" X SDOPEN
OPENQ Q
 ;
CLOSE(SDQ,SDERR) ; -- SDQ CLOSE                            [API ID: 80]
 D PREP^SDQUT
 ;
 ; -- do validation checks
 IF '$$QRY^SDQVAL(.SDQ,$G(SDERR)) G CLOSEQ
 ;
 ; -- do close actions
 N SDCLOSE
 S SDCLOSE=$G(^TMP("SDQUERY CLASS",$J,SDQ,"CLOSE"))
 IF SDCLOSE]"" X SDCLOSE
 ;
 ; -- do query object instance kills
 K @SDQUERY@(SDQ)
 ;
 ; -- do query class kills
 IF '$$DESTROY(.SDQ) G CLOSEQ
 S SDQ=""
CLOSEQ Q
 ;
CREATE(SDQ,SDQNAME,SDERR) ; -- query class level method for CREATE
 N SDCLS,SDCLS0,SDOK,SDSTORE
 S SDCLS=+$O(^SD(409.64,"B",SDQNAME,0))
 IF SDCLS D
 . S SDCLS0=$G(^SD(409.64,SDCLS,0))
 . S SDSTORE=$S($P(SDCLS0,U,4):$P(SDCLS0,U,4),1:5000)
 . IF $G(SDQUERY)="" S SDQUERY="SDQDATA"
 . D STORE(.SDQUERY,SDSTORE)
 . IF '$O(@SDQUERY@(0)) D KILL
 . ;
 . ; -- set query id
 . S (SDQ,@SDQUERY)=$G(@SDQUERY)+1
 . ; -- set up tmp class info
 . K ^TMP("SDQUERY CLASS",$J,SDQ)
 . M ^TMP("SDQUERY CLASS",$J,SDQ)=^SD(409.64,SDCLS)
 . S ^TMP("SDQUERY CLASS",$J,SDQ)=SDCLS
 . S ^TMP("SDQUERY CLASS",$J,SDQ,"GL")=$G(^DIC(+$P(SDCLS0,"^",2),0,"GL"))
 . ; -- subscript level of files root ; ex:^SCE = 0 ; ex:^SD(404.42, = 1
 . S ^TMP("SDQUERY CLASS",$J,SDQ,"GL SUBSCRIPTS")=+$P(SDCLS0,"^",3)
 . ;
 . S SDOK=1
 ELSE  D
 . ; -- build error msg
 . N SDIN,SDOUT
 . S SDIN("CLASS")=SDQNAME
 . S SDOUT("CLASS")=SDQNAME
 . D BLD^SDQVAL(4096400.001,.SDIN,.SDOUT,$G(SDERR))
 . S SDOK=0
 ;
 Q SDOK
 ;
STORE(SDQUERY,SDSTORE) ; -- decide whether to use a local or global
 N SDOLD
 IF $S<SDSTORE,SDQUERY'["^TMP" D
 . S SDOLD=SDQUERY
 . S SDQUERY=$NA(^TMP("SDQDATA",$J))
 . K @SDQUERY
 . M @SDQUERY=@SDOLD
 . K @SDOLD
 Q
 ;
DESTROY(SDQ) ; -- query class level method for DESTROY
 K ^TMP("SDQUERY CLASS",$J,SDQ)
 IF '$O(@SDQUERY@(0)) D KILL K SDQUERY
 Q 1
 ;
KILL ; -- kill class and ien list globals
 K ^TMP("SDQUERY CLASS",$J)
 K ^TMP("SDQUERY LIST",$J)
 K @SDQUERY
 Q
 ;
 ;
PAT(SDQ,SDFN,SDACT,SDERR) ; -- SDQ PATIENT                  [API ID: 81]
 D PREP^SDQUT
 G PATG^SDOEQ
 ;
GETPAT(SDQ,SDERR) ; -- get patient property             [API ID: 1xx]
 ; -- not supported
 D PREP^SDQUT
 N SDFN
 D PAT^SDOEQ(.SDQ,.SDFN,"GET",$G(SDERR))
 Q $G(SDFN)
 ;
DATE(SDQ,SDBEG,SDEND,SDACT,SDERR) ; -- SDQ DATE RANGE       [API ID: 82]
 D PREP^SDQUT
 G DATEG^SDQPROP
 ;
GETDATE(SDQ,SDERR) ; -- get date range property          [API ID: 1xx]
 ; -- not supported
 D PREP^SDQUT
 N SDBEG,SDEND
 D DATE^SDQPROP(.SDQ,.SDBEG,.SDEND,"GET",$G(SDERR))
 Q $G(SDBEG)_"^"_$G(SDEND)
 ;
FILTER(SDQ,SDFIL,SDACT,SDERR) ; -- SDQ FILTER                   [API ID: 83]
 D PREP^SDQUT
 G FILTERG^SDQPROP
 ;
GETFIL(SDQ,SDERR) ; -- get filter property              [API ID: 1xx]
 ; -- not supported
 D PREP^SDQUT
 N SDFIL
 D FILTER^SDQPROP(.SDQ,.SDFIL,"GET",$G(SDERR))
 Q $G(SDFIL)
 ;
VISIT(SDQ,SDVST,SDACT,SDERR) ; -- SDQ VISIT                   [API ID: 84]
 D PREP^SDQUT
 G VISITG^SDOEQ
 ;
GETVISIT(SDQ,SDERR) ; -- get visit property              [API ID: 1xx]
 ; -- not supported
 D PREP^SDQUT
 N SDVST
 D VISIT^SDOEQ(.SDQ,.SDVST,.SDACT,$G(SDERR))
 Q $G(SDVST)
 ;
INDEX(SDQ,SDIDX,SDACT,SDERR) ; -- SDQ INDEX NAME              [API ID: 85]
 D PREP^SDQUT
 G INDEXG^SDQPROP
 ;
GETINDEX(SDQ,SDERR) ; -- get index property              [API ID: 1xx]
 ; -- not supported
 D PREP^SDQUT
 N SDIDX
 D INDEX^SDQPROP(.SDQ,.SDIDX,"GET",$G(SDERR))
 Q $G(SDIDX)
 ;
ACTIVE(SDQ,SDSTAT,SDACT,SDERR) ; -- SDQ ACTIVE STATUS           [API ID: 88]
 D PREP^SDQUT
 G ACTIVEG^SDQPROP
 ;
GETACT(SDQ,SDERR) ; -- activate query                      [API ID: 1xx]
 ; -- not supported
 D PREP^SDQUT
 N SDSTAT
 D ACTIVE^SDQPROP(.SDQ,.SDSTAT,.SDACT,$G(SDERR))
 Q $G(SDSTAT)
 ;
REFRESH(SDQ,SDERR) ; -- SDQ REFRESH                         [API ID: 94]
 D PREP^SDQUT
 G REFRESHG^SDQUT
 ;
SCAN(SDQ,SDIR,SDERR) ; -- SDQ SCAN                            [API ID: 99]
 D PREP^SDQUT
 G SCANG^SDQNAV
 ;
SCANCB(SDQ,SDCB,SDACT,SDERR) ; -- SDQ SCAN CALLBACK           [API ID: 100]
 D PREP^SDQUT
 G SCANCBG^SDQNAV
 ;
NEXT(SDQ,SDERR) ; -- SDQ NEXT                                    [API ID: 92]
 D PREP^SDQUT
 G NEXTG^SDQNAV
 ;
PRIOR(SDQ,SDERR) ; -- SDQ PRIOR                           [API ID: 93]
 D PREP^SDQUT
 G PRIORG^SDQNAV
 ;
FIRST(SDQ,SDERR) ; -- SDQ FIRST                           [API ID: 90]
 D PREP^SDQUT
 G FIRSTG^SDQNAV
 ;
LAST(SDQ,SDERR) ; -- SDQ LAST                                    [API ID: 91]
 D PREP^SDQUT
 G LASTG^SDQNAV
 ;
EOF(SDQ,SDERR) ; -- SDQ EOF                                     [API ID: 86]
 D PREP^SDQUT
 Q $$EOF^SDQNAV(.SDQ,$G(SDERR))
 ;
BOF(SDQ,SDERR) ; -- SDQ BOF                                     [API ID: 87]
 D PREP^SDQUT
 Q $$BOF^SDQNAV(.SDQ,$G(SDERR))
 ;
COUNT(SDQ,SDERR) ; -- SDQ COUNT                           [API ID: 89]
 D PREP^SDQUT
 Q $$COUNT^SDQNAV(.SDQ,$G(SDERR))
 ;
GETENTRY(SDQ,SDERR) ; -- SDQ GET CURRENT ENTRY ID            [API ID: 95]
 D PREP^SDQUT
 Q $$GETENTRY^SDQUT(.SDQ,$G(SDERR))
 ;
