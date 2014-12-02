LRJSML2 ;ALB/GTS - Lab Vista Hospital Location Utilities;02/24/2010 14:31:15
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
 ;Following API called from TaskMan scheduled job (LRJ SYS MAP HL TASKMAN RPT)
TSKMMARY(LRHLARY,LRMMARY) ;TASKMAN API for Mail Message array
 ;
 ;INPUT (Roots for arrays to create)
 ; LRHLARY - Raw Data Array [^TMP($J,"LRJ SYS") when called by LRJ SYS MAP HL SEND MSG]
 ; LRMMARY - Mail Message array to send in msg [^TMP($J,"LRDATA")]
 ; 
 NEW LRFROM,LRTO,LRMSUBJ,XQSND,ERR,LRTOVA,LRTASKVA,LRINSTVA
 DO NOW^%DTC
 SET LRTO=$E(%,1,12) ;NOW: end date/time
 KILL %,X,%H,%I(1),%I(2),%I(3)
 SET:'$D(LRINIT) LRINIT=+$G(^TMP("LRJ SYS USER MANAGER - INIT",$JOB))
 SET LRFROM=$$GET^XPAR("SYS","LRJ HL LAST END DATE",1,"Q") ;* IA #2263
 ;
 IF LRFROM="" DO TSKERMSG^LRJSML6(LRMMARY)  ;Current config not yet accepted
 ;
 ; Current Config accepted
 IF LRFROM'="" DO 
 .DO EN^XPAR("SYS","LRJ HL LAST END DATE",,LRTO,.ERR) ;* IA #2263
 .DO EN^XPAR("SYS","LRJ HL LAST START DATE",,LRFROM,.ERR) ;* IA #2263
 .;
 .DO BLDREC^LRJSMLA(LRFROM,LRTO,LRHLARY)
 .;
 .IF ^TMP($J,"LRJ SYS",1)="   NO CHANGES FOUND!!" DO
 ..NEW LRPARAM,LRLNCNT
 ..SET:$G(LRMMARY)="" LRMMARY=""
 ..SET LRLNCNT=0
 ..SET X=" VistA Hospital Location changes"_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 ..DO LRADDNOD^LRJSML3(.LRLNCNT,X,"","MAIL",LRMMARY)
 ..DO LRADDNOD^LRJSML3(.LRLNCNT,"  ","","MAIL",LRMMARY)
 ..DO LRADDNOD^LRJSML3(.LRLNCNT,"  ","","MAIL",LRMMARY)
 ..DO LRADDNOD^LRJSML3(.LRLNCNT,"********************************************","","MAIL",LRMMARY)
 ..DO LRADDNOD^LRJSML3(.LRLNCNT,"*                                          *","","MAIL",LRMMARY)
 ..DO LRADDNOD^LRJSML3(.LRLNCNT,"*  NO CHANGES FOUND FOR THIS DATE RANGE!!  *","","MAIL",LRMMARY)
 ..DO LRADDNOD^LRJSML3(.LRLNCNT,"*                                          *","","MAIL",LRMMARY)
 ..DO LRADDNOD^LRJSML3(.LRLNCNT,"********************************************","","MAIL",LRMMARY)
 ..DO LRADDNOD^LRJSML3(.LRLNCNT,"  ","","MAIL",LRMMARY)
 ..SET LRMSUBJ="NO HL changes"_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 ..SET XQSND=DUZ
 ..DO SNDMSG^LRJSML8(LRMSUBJ,XQSND,LRMMARY,1) ;"1" = created by TaskMan; send to Mailgroup
 .;
 .IF ^TMP($J,"LRJ SYS",1)'="   NO CHANGES FOUND!!" DO
 ..DO CRTRPTAR^LRJSML8(LRHLARY,LRFROM,LRTO,"MAIL",LRMMARY)
 ..;
 ..SET LRMSUBJ="HL changes"_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 ..SET XQSND=DUZ
 ..DO SNDMSG^LRJSML8(LRMSUBJ,XQSND,LRMMARY,1) ;"1" = created by TaskMan; send to Mailgroup
 ..;
 ..;Send Extract msg with attachmts
 ..SET LRMSUBJ="HL extract"_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 ..;
 ..;Check Network addresses and mail attachmt
 ..SET LRINSTVA("ADDR FLAGS")="R"  ;Do not Restrict Message addressing
 ..SET LRINSTVA("FROM")="LAB_HLCSM_USER_ACTION"
 ..SET LRTOVA(XQSND)=""
 ..SET LRTOVA("G.LRJ SYS MAP HL TASK REPORT")=""
 ..;
 ..DO OUTLKARY^LRJSML8(LRHLARY,"^TMP($J,""LRNETMSG"")",LRMSUBJ)
 ..DO SENDMSG^XMXAPI(XQSND,LRMSUBJ,"^TMP($J,""LRNETMSG"")",.LRTOVA,.LRINSTVA)
 ;
 KILL @LRHLARY,@LRMMARY,^TMP($J,"LRNETMSG")
 QUIT
 ;
CRTMMARY(LRHLARY,LRMMARY) ;Load Hospital Locations in Mail Msg array
 ; Protocol: LRJ SYS MAP HL SEND MSG
 ;INPUT
 ; LRHLARY - Raw Data Array
 ;             [^TMP($J,"LRJ SYS") when called by LRJ SYS MAP HL SEND MSG]
 ; LRMMARY - Mail Msg array to send in message [^TMP($J,"LRDATA")]
 ;
 NEW LRMSUBJ,XQSND,LRFROM,LRTO,XQSND,LRNODE,LRLPCNT,LRINIT
 ;
 DO FULL^VALM1
 SET LRINIT=$$INITCK^LRJSML1()
 DO LISTHLMM^LRJSML8(LRHLARY)
 IF 'LRINIT DO
 .DO SETRNG^LRJSML1(.LRFROM,.LRTO)
 .SET ^TMP("LRJ SYS USER MANAGER - DATES",$JOB)=LRFROM_"^"_LRTO
 ;
 S:('LRINIT) LRMSUBJ="HL changes"_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 IF LRINIT SET LRMSUBJ="HL Configurations on "_$$FMTE^XLFDT($P($G(^TMP($J,"LRJ SYS",1)),"^",11))
 S XQSND=DUZ
 S (LRNODE,LRLPCNT)=0
 DO CREATMM^LRJSML1(LRHLARY) ;; Excutes REFRESH^LRJSML1 setting VALMBCK & VALMBG
 F  S LRNODE=$O(@VALMAR@(LRNODE)) Q:LRNODE=""  DO
 .S LRLPCNT=LRLPCNT+1
 .S @LRMMARY@(LRLPCNT)=@VALMAR@(LRNODE,0)
 .I LRLPCNT=1 D LRADDLNE^LRJSML3(.LRLPCNT,"",LRMMARY)
 .I @VALMAR@(LRNODE,0)["BEDS" DO
 ..D LRADDLNE^LRJSML3(.LRLPCNT,"",LRMMARY)
 ..D LRADDLNE^LRJSML3(.LRLPCNT,"",LRMMARY)
 IF '$D(@VALMAR@(2,0)) DO
 . DO LRADDLNE^LRJSML3(.LRLPCNT,"",LRMMARY)
 . DO LRADDLNE^LRJSML3(.LRLPCNT," No data was extracted for date range!!",LRMMARY)
 . DO LRADDLNE^LRJSML3(.LRLPCNT,"",LRMMARY)
 DO SNDMSG^LRJSML8(LRMSUBJ,XQSND,LRMMARY,0)
 IF $O(@VALMAR@(0))="" K @LRMMARY@(1),@LRMMARY@(2),@LRMMARY@(3)
 Q
 ;
 ;Protocol invokes this API: LRJ SYS MAP HL SEND EXT
CRTXTMM(LRHLARY) ;Load Hospital Locations in the Mail Msg array
 ;INPUT
 ; LRHLARY - Raw Data Array [^TMP($J,"LRJ SYS") when called by LRJ SYS MAP HL SEND MSG]
 ;
 NEW LRFROM,LRTO,LRMSUBJ,XQSND,LRINIT
 SET (LRFROM,LRTO)=""
 SET LRINIT=$$INITCK^LRJSML1()
 ;
 DO FULL^VALM1
 ;
 WRITE !!,"This action will send an E-mail message that includes the raw extracts as"
 WRITE !,"  attachments to selected users.  Large extract files can take time to create."
 ;
 IF '$D(LRINIT) SET LRINIT=+$G(^TMP("LRJ SYS USER MANAGER - INIT",$JOB))
 ;
 IF 'LRINIT DO
 .DO SETRNG^LRJSML1(.LRFROM,.LRTO)
 .SET ^TMP("LRJ SYS USER MANAGER - DATES",$JOB)=LRFROM_"^"_LRTO
 .SET LRMSUBJ="HL extract"_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 SET:LRINIT LRMSUBJ="HL Configuration extract on "_$$FMTE^XLFDT($P($G(^TMP($J,"LRJ SYS",1)),"^",11))
 SET XQSND=DUZ
 DO SNDEXT^LRJSML8(LRMSUBJ,XQSND,LRHLARY)
 DO DISPEXT^LRJSML1(LRHLARY)
 DO MSG^LRJSML
 SET VALMBCK="R"
 SET VALMBG=1
 QUIT
 ;
 ;Called by: ACPTCNFG^LRJSML6
PARAMED ;Edit Dates referenced by tasked Option "LRJ SYS MAP HL TASKMAN RPT"
 ; This API invokes Edit Instance and Value of Parameter API to edit following Parameters:
 ;   LRJ HL LAST START DATE
 ;   LRJ HL LAST END DATE
 ;   
 ; These parameters control the period that the Audit file extract is performed via the
 ; TaskMan scheduled job for the "LRJ SYS MAP HL TASKMAN RPT" option
 NEW LROK
 SET LROK=1
 ;
 WRITE !!,"Lab Hospital Location Audit extract dates indicate the report dates"
 WRITE !," for the most recent Legacy VistA Hospital Location extract completed."
 WRITE !!,"The LRJ HL LAST END DATE is the start date/time used by the next"
 WRITE !," execution of the LRJ SYS MAP HL TASKMAN RPT option."
 WRITE !!,"WARNING: Editing the LRJ HL LAST END DATE will affect the information"
 WRITE !," reported by the LRJ SYS MAP HL TASKMAN RPT option.  This option makes"
 WRITE !," assumptions about data previously reported based upon this date.",!
 WRITE !!,"A USER CHANGING THE 'LRJ HL LAST END DATE' MUST UNDERSTAND THE RESULT"
 WRITE !," OF THE CHANGE MADE AND [IF NECESSARY] RECONCILE THE NEXT REPORT AGAINST"
 WRITE !," PREVIOUS REPORTS TO ASSURE LAB LOCATIONS DEFINED ON COTS MATCH"
 WRITE !," THOSE DEFINED ON LEGACY VISTA!",!
 SET DIR(0)="E"
 DO ^DIR
 SET LROK=+Y
 KILL X,Y,DTOUT,DUOUT,DIROUT
 ;
 IF LROK DO
 .D EDITPAR^XPAREDIT("LRJ HL LAST START DATE") ;;IA #2336
 .WRITE !!,"-------------------------------------------------------------------------------"
 .D EDITPAR^XPAREDIT("LRJ HL LAST END DATE") ;;IA #2336
 .KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 Q
