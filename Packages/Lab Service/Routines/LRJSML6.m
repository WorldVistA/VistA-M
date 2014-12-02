LRJSML6 ;ALB/GTS - Lab Vista Hospital Location Initialization;02/22/2010 14:37:07
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
SCHDBCKG ;Schedule the HL Change Audit Rpt
 ;
 ;Called from Protocol: LRJ SYS MAP HL SCHED AUDIT RPT TASK
 ;
 NEW LROK,LRSTDTM,LROPT,LRFREQ,LRPARMDT,LRSCHED
 D FULL^VALM1
 SET LROK=1
 WRITE !!,"This action will schedule the 'LRJ SYS MAP HL Change Management TaskMan Report'"
 WRITE !,"  option [LRJ SYS MAP HL TASKMAN RPT] as a background task.",!
 ;
 IF +$$GET^XPAR("SYS","LRJ HL LAST END DATE",1,"Q")>0 SET LROK=1 ;* IA #2263
 IF +$$GET^XPAR("SYS","LRJ HL LAST END DATE",1,"Q")'>0 SET LROK=0
 ;
 IF 'LROK DO
 .SET DIR("A",1)=""
 .SET DIR("A",2)="Hospital Location configuration has not been accepted!!  Check configuration."
 .SET DIR("A",3)=""
 .SET DIR("A",4)="When Hospital Locations on legacy VistA match those on COTS,"
 .SET DIR("A",5)=" execute the 'Accept/edit current HL config dates' action and then"
 .SET DIR("A",6)=" schedule the background task via this action."
 .SET DIR("A",7)=""
 .SET DIR("A")="Press RETURN to redisplay Lab Hospital Location Tools..."
 .SET DIR(0)="E"
 .DO ^DIR
 .KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 ;
 ;If End Date defined, Prompt to set Background job
 IF LROK DO
 .WRITE !
 .SET DIR(0)="Y"
 .SET DIR("A")="Do you want to do this"
 .SET DIR("B")="NO"
 .SET DIR("?",1)="Define the TaskMan schedule for running the 'LRJ SYS MAP HL TASKMAN RPT' option."
 .SET DIR("?",2)="This option will report changes to hospital locations since the last time the"
 .SET DIR("?")="report was generated [current value of LRJ HL LAST END DATE]."
 .DO ^DIR
 .SET LROK=+Y
 .KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 ;
 ;Prompt for start time
 IF LROK DO
 .NEW STRESULT,LRDEFSD
 .DO OPTSTAT^XUTMOPT("LRJ SYS MAP HL TASKMAN RPT",.LRSCHED)
 .SET LRDEFSD=$P($G(LRSCHED(1)),"^",2)
 .SET LRDEFSD=$$FMTE^XLFDT(LRDEFSD)
 .SET STRESULT=$$STARTDTM^LRJSMLU(LRDEFSD)
 .SET LRSTDTM=$P(STRESULT,"^",2)
 .SET LROK=+STRESULT
 .IF LROK,LRSTDTM="" SET LRSTDTM=$P(STRESULT,"^",3)
 ;
 IF LROK,LRSTDTM="@" DO
 .NEW LRERR,LRDELTSK
 .SET DIR(0)="Y"
 .SET DIR("A")="Are you sure you want to delete the background task"
 .SET DIR("B")="NO"
 .SET DIR("?")="You are about to de-schedule the LRJ SYS MAP HL Change Management Task"
 .DO ^DIR
 .SET LRDELTSK=+Y
 .KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 .DO:LRDELTSK RESCH^XUTMOPT("LRJ SYS MAP HL TASKMAN RPT","@","","@","L",.LRERR)
 .IF +$G(LRERR)<0 DO
 ..SET DIR("A",1)="LRJ SYS MAP HL TASKMAN RPT option not found!!"
 ..SET DIR("A",2)="Check Installation before running this option again."
 ..SET DIR(0)="E"
 ..DO ^DIR
 .KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 .SET LROK=0
 ;
 ;Prompt for frequency when task is scheduled
 IF LROK DO
 .NEW LRDEFFRQ
 .SET LRDEFFRQ=$P($G(LRSCHED(1)),"^",3)
 .SET DIR(0)="FAr^^D BJITS^LRJSMLU"
 .SET DIR("A")="RESCHEDULING FREQUENCY: "
 .SET:$G(LRDEFFRQ)="" DIR("B")="1D"
 .SET:$G(LRDEFFRQ)'="" DIR("B")=LRDEFFRQ
 .SET DIR("?")="^D ITSHELP^LRJSMLU(X)"
 .DO ^DIR
 .SET LRFREQ=Y
 .KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 .IF $$ENTCHK(LRFREQ)>0 DO
 ..DO RESCH^XUTMOPT("LRJ SYS MAP HL TASKMAN RPT",LRSTDTM,"",LRFREQ,"L",.LRERR)
 ..SET LROK=0
 ;
 ;Show updated task schedule
 DO INIT^LRJSML5 ;Sets VALMBCK & VALMBG
 QUIT
 ;
TSKERMSG(LRMMARY) ; Send message when Task job runs before HL config accepted
 NEW LRPARAM,LRLNCNT,LRMSUBJ,XQSND
 SET:$G(LRMMARY)="" LRMMARY=""
 SET LRLNCNT=0
 SET X=" VistA LRJ SYS MAP HL TASKMAN RPT was scheduled and run but the current"
 DO LRADDNOD^LRJSML3(.LRLNCNT,X,"","MAIL",LRMMARY)
 SET X=" Lab Hospital Location configuration has not been accepted!"
 DO LRADDNOD^LRJSML3(.LRLNCNT,X,"","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"  ","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"  ","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*************************************************************","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*                                                           *","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*             HL AUDIT REPORT NOT GENERATED!!               *","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*                                                           *","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*  Use the Hospital Location Monitor Tools 'Accept          *","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*  current HL config/edit dates' action to accept           *","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*  Hospital Locations configured on COTS and schedule       *","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*  the 'LRJ SYS MAP HL TASKMAN RPT' option!                 *","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*                                                           *","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"*************************************************************","","MAIL",LRMMARY)
 DO LRADDNOD^LRJSML3(.LRLNCNT,"  ","","MAIL",LRMMARY)
 SET LRMSUBJ="Audit Report not Generated"_$S(+$G(LRTO)>0:" on "_$$FMTE^XLFDT(LRTO),1:"")_"!!"
 SET XQSND=DUZ
 DO SNDMSG^LRJSML8(LRMSUBJ,XQSND,LRMMARY,1) ;"1" = created by TaskMan; send to Mailgroup
 QUIT
 ;
ENTCHK(X) ;Check X for legit frequency indicator
 ;
 ; Output:
 ;       1 - X is legit frequencey
 ;       0 - X is not legit frequency
 ;
 IF X?1.3N1"H" Q 1
 IF X?1.4N1"S" Q 1
 IF X?1.3N1"D" Q 1
 IF X?1.2N1"M" Q 1
 IF X?1.2N1"M(".E1")" Q 1
 IF "MTWRFSUDE"[$E(X),"@,"[$E(X,2) Q 1
 QUIT 0
 ;
BJITT ;input transform for time (#2)
 N Y,%,DIR S %DT="ETRXF" D ^%DT S X=Y,%=$$NOW^XLFDT() I %+.0002>X K X
 I '$D(X) DO
 .W !,?5,"The current time is ",$E(%,9,10),":",$E(%,11,12)
 .W !,?2,"Queued time must be at least 2 minutes later than the current time."
 Q
 ;
ACPTCNFG ; Accept the current HL Configuration or edit parameters for LRJ SYS MAP HL TASKMAN RPT
 ;Called from Protocol: LRJ SYS MAP HL ACCEPT CONFIG
 ;
 ; This API will update the Last Start/End date for the HLCMS background task report
 NEW LROK,LRSTDTM,LROPT,LRPARMDT,LREND,LRBEGIN,LRAUDMSG,LRACTEDT
 D FULL^VALM1
 SET LRACTEDT=""
 SET LROK=1
 SET LRBEGIN=$$GET^XPAR("SYS","LRJ HL LAST START DATE",1,"Q") ;* IA #2263
 SET LREND=$$GET^XPAR("SYS","LRJ HL LAST END DATE",1,"Q")
 IF +LRBEGIN'>0,+LREND'>0 SET LRACTEDT="ACCEPT"
 IF (+LRBEGIN>0)!(+LREND>0) SET LRACTEDT="EDIT"
 IF LRACTEDT="ACCEPT" DO
 .WRITE !,"This action will accept the current Hospital Location configuration on"
 .WRITE !,"  COTS and define reporting start dates for the [LRJ SYS MAP HL TASKMAN RPT]"
 .WRITE !,"  background task."
 .;
 .;Prompt to accept current config
 .SET DIR(0)="Y"
 .SET DIR("A")="Accept current Lab Hospital Location Config"
 .SET DIR("B")="NO"
 .SET DIR("?",1)="Accepting the current configuration will set the"
 .SET DIR("?",2)="LRJ HL LAST START DATE and LRJ HL LAST END DATE parameters."
 .SET DIR("?",3)="If COTS locations match legacy VistA, enter 'YES'."
 .SET DIR("?")="If COTS locations do NOT match legacy VistA, enter 'NO'."
 .DO ^DIR
 .SET LROK=Y
 .KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 .;
 .;If accept config, set parameters
 .IF LROK DO
 ..NEW ERR
 ..DO NOW^%DTC
 ..SET LRPARMDT=$E(%,1,12) ;Set NOW for Parameter date
 ..DO EN^XPAR("SYS","LRJ HL LAST END DATE",,LRPARMDT,.ERR) ;* IA #2263
 ..DO EN^XPAR("SYS","LRJ HL LAST START DATE",,LRPARMDT,.ERR)
 .;
 .IF 'LROK DO
 ..SET DIR("A",1)=" "
 ..SET DIR("A",2)="   Current configuration not accepted!!"
 ..SET DIR("A",3)=" "
 ..SET DIR("A")="Press Return to continue"
 ..SET DIR(0)="E"
 ..DO ^DIR
 ..KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 ;
 IF LRACTEDT="EDIT" DO
 .SET DIR(0)="Y"
 .SET DIR("A",1)=" "
 .SET DIR("A",2)="Previous Audit Report dates are "_$S(LRBEGIN'="":$$FMTE^XLFDT(LRBEGIN),1:"undefined")_" - "_$S(LREND'="":$$FMTE^XLFDT(LREND),1:"undefined")
 .SET DIR("A",3)=" "
 .SET DIR("A")="Do you want to edit these dates"
 .SET DIR("B")="NO"
 .SET DIR("?",1)="These dates control the window of time in which Hospital Location changes"
 .SET DIR("?",2)="are reported.  The Tasked reports assume COTS Hospital Location"
 .SET DIR("?",3)="configurations are current as of the End Date.  Changing these dates will"
 .SET DIR("?")="change the report generated by the LRJ SYS MAP HL TASKMAN RPT background job!!"
 .D ^DIR
 .SET LROK=Y
 .KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 .IF LROK D PARAMED^LRJSML2
 ;IF TASK SCHEDULE SCREEN DO INIT^LRJSML5 ELSE...
 IF ^TMP("LRJ SYS MAP HL INIT MGR",$J,1,0)=" Hospital Location Audit task schedule" DO
 .DO INIT^LRJSML5
 E  DO
 .D MSG^LRJSML
 .SET VALMBCK="R"
 QUIT
