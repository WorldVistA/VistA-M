KMPOPSW ;SP/JML - HTML to Display VistA Ops Data;7/1/2025
 ;;4.0;CAPACITY MANAGEMENT;**5**;3/1/2018;Build 9
 ;
 ;
 ;
GETWEBG(FROMDATE,TODATE,REFRESH) ;
 N KMPARR,KMPCLASS,KMPFTASKS,KMPI,KMPICFG,KMPILIST,KMPKEY,KMPLIST,KMPSITE,KMPVAL,KMPVAL,KMPD,KMPT,KMPTEMP,KMPFH,KMPFDIS
 N KMPTH,KMPTDIS,KMPDARR,KMPHL7,KMPHLO,KMPOCFG,KMPPARR,KMPITR,KMPMAIL,KMPQUES,KMPSDET,KMPSMGR,KMPTASK,%H,X,%
 I FROMDATE="" S FROMDATE=$ZDATE($H-14,3)
 I TODATE="" S TODATE=$ZDATE($H+1,3)
 S REFRESH=$G(REFRESH,60)
 S KMPFH=$ZDATEH(FROMDATE,3)
 S KMPFDIS=$ZDATE(KMPFH)
 S KMPTH=$ZDATEH(TODATE,3)
 S KMPTDIS=$ZDATE(KMPTH)
 S KMPHL7=$$GETHL7^KMPOPS("ALL")
 S KMPHLO=$$GETHLO^KMPOPS("ALL")
 S KMPTASK=$$GETTASK^KMPOPS()
 S KMPMAIL=$$GETMAIL^KMPOPS()
 S KMPPARR=$$GETPLIST^KMPOPS(FROMDATE,TODATE)
 S KMPSITE=$$SITEINFO^KMPVCCFG()
 W "<html>"
 W "<head><title>CPE VSM Operations Status</title>"
 W "<meta http-equiv='refresh' content='"_REFRESH_"'>"
 W "</head>"
 ; start of style sheet
 W "<style>"
 W "body { background-color:#121117; color:#CCCCDC}"
 W "h1 { color:white; }"
 W "h2 { background-color:#4F81BD; color:white; text-align:center; }"  ; cpe dark blue
 W "th { color:#DBE5F1; text-align:left; }"   ; cpe light blue
 W "table { width:100%; cellspacing:5; valign:top; }"
 W ".alert { color: #ff8383; }"
 w ".label { text-align: left; color:#DBE5F1; }"
 W ".warn { text-align: left; color:yellow; }"
 w ".value { text-align:left; color:white; }"
 W "</style>"
 ; end of style sheet
 w "<body>"
 W "<table>"
 w "<tr><td width='30%' align='left'>"_$P(KMPSITE,"^")_"</td><td width='40%' align='center'><h1>CPE VSM VistA Operations Status</h1></td><td width='30%' align='right'>"_$P(KMPSITE,"^",5)_"</td></tr>"
 W "</table>"
 W "<table>"
 W "<tr>"
 ; hl7 column
 W "<td valign='top'><table>"
 W "<tr><td colspan=2 align='center'><h2>HL7 Status</h2></td></tr>"
 S KMPVAL=KMPHL7.LinkManagerStatus,KMPCLASS=$S(KMPVAL="Running":"value",1:"alert")
 W "<tr><td class='label'>Link Manager Status:</TD><TD class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPVAL=KMPHL7.LinkManagerCurrent,KMPCLASS=$S(KMPVAL["current":"value",1:"alert")
 W "<tr><td class='label'>Link Manager Current:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPVAL=KMPHL7.InCount,KMPICFG=KMPHL7.InConfig
 S KMPCLASS=$S(KMPVAL>=KMPICFG:"value",1:"alert")
 W "<tr><td class='label'>In Filer Count:</td><td class='"_KMPCLASS_"'>"_KMPVAL_" running of "_KMPICFG_" configured</td></tr>"
 S KMPVAL=KMPHL7.OutCount,KMPOCFG=KMPHL7.OutConfig
 S KMPCLASS=$S(KMPVAL>=KMPOCFG:"value",1:"alert")
 W "<tr><td class='label'>Out Filer Count:</td><td class='"_KMPCLASS_"'>"_KMPVAL_" running of "_KMPOCFG_" configured</td></tr>"
 W "<tr><td colspan=2>&nbsp;</td></tr>"
 W "<tr><td class='label'>Filer Detail:</td>"
 W "<td><table>"
 W "<tr><th>Direction</th><th>$J</th><th>Last Run</th><th>Stop Flag</th><th>Error</th></tr>"
 S KMPILIST=KMPHL7.FilerList
 ;
 S KMPARR=##class(KMP.Utilities).toArray(KMPILIST)
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .W "<tr><td class='value'>"_KMPLIST.Direction_"</td>"
 .w "<td class='value'>"_KMPLIST.JobNumber_"</td>"
 .w "<td class='value'>"_KMPLIST.Behind_"</td>"
 .w "<td class='value'>"_KMPLIST.StopFlag_"</td>"
 .w "<td class='value'>"_KMPLIST.Error_"</td></tr>"
 W "</table></td></tr>"
 W "<tr><td colspan=2>&nbsp;</td></tr>"
 ;
 W "<tr><td colspan=2><h2>HLO Status</h2></td></tr>"
 S KMPVAL=KMPHLO.SystemStatus,KMPCLASS=$S(KMPVAL="Running":"value",1:"alert")
 W "<tr><td class='label'>System Status</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPVAL=KMPHLO.ProcessManager,KMPCLASS=$S(KMPVAL["Running":"value",1:"alert")
 W "<tr><td class='label'>Process Manager:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPVAL=KMPHLO.StandardListener,KMPCLASS=$S(KMPVAL="Running":"value",1:"alert")
 W "<tr><td class='label'>Standard Listener:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 W "<tr><td class='label'>DownLinks:</td><td class='value'>"_KMPHLO.DownLinks_"</td></tr>"
 W "<tr><td class='label'>Client Link Processes:</td><td class='value'>"_KMPHLO.ClientLinkProcesses_"</td></tr>"
 W "<tr><td class='label'>In Filer Processes:</td><td class='value'>"_KMPHLO.InFilerProcesses_"</td></tr>"
 W "<tr><td class='label'>Messages Pending on Out Queues:</td><td class='value'>"_KMPHLO.MessagesPendingOutQueues_"</td></tr>"
 W "<tr><td class='label'>Messages Pending on Sequence Queues:</td><td class='value'>"_KMPHLO.MessagesPendingSequenceQueues_"</td></tr>"
 W "<tr><td class='label'>Messages Pending on Application Queues:</td><td class='value'>"_KMPHLO.MessagesPendingApplications_"</td></tr>"
 W "<tr><td class='label'>Stopped Incoming Queues:</td><td class='value'>"_KMPHLO.StoppedIncomingQueues_"</td></tr>"
 W "<tr><td class='label'>Stopped Outgoing Queues:</td><td class='value'>"_KMPHLO.StoppedOutgoingQueues_"</td></tr>"
 W "<tr><td class='label'>File 777 Record Count</td>"
 S KMPD=$P(KMPHLO.File777RecordDate," "),KMPT=$P(KMPHLO.File777RecordDate," ",2)
 S KMPTEMP=$P(KMPD,"-",2)_"-"_$P(KMPD,"-",3)_"-"_+KMPD_"  "_$P(KMPT,"Z")
 W "<td class='value'>"_+KMPHLO.File777RecordCount_"&nbsp; as of &nbsp;"_KMPTEMP_"</td></tr>"
 W "<tr><td class='label'>File 777 Record Count:</td>"
 S KMPD=$P(KMPHLO.File778RecordDate," "),KMPT=$P(KMPHLO.File778RecordDate," ",2)
 S KMPTEMP=$P(KMPD,"-",2)_"-"_$P(KMPD,"-",3)_"-"_+KMPD_"  "_$P(KMPT,"Z")
 W "<td class='value'>"_+KMPHLO.File778RecordCount_"&nbsp; as of &nbsp;"_KMPTEMP_"</td></tr>"
 W "<tr><td class='label'>Messages Sent Today:</td><td class='value'>"_KMPHLO.MessagesSentToday_"</td></tr>"
 W "<tr><td class='label'>Messages Received Today:</td><td class='value'>"_KMPHLO.MessagesReceivedToday_"</td></tr>"
 W "<tr><td class='label'>Message Errors Today:</td><td class='value'>"_KMPHLO.MessageErrorsToday_"</td></tr>"
 ;   **** LOOK AGAIN
 w "<tr><td colspan=2>&nbsp;</td></tr>"
 W "<tr><td class='label'>High Stopped Queues</td>"
 W "<td><table>"
 W "<tr><th>Link</th><th>Queue</th><th>Count</th></tr>"
 S KMPQUES=KMPHLO.PendingOutMessageCounts
 S KMPARR=##class(KMP.Utilities).toArray(KMPQUES)
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .W "<tr><td class='value'>"_KMPLIST.Link_"</td>"
 .w "<td class='value'>"_KMPLIST.Queue_"</td>"
 .w "<td class='value'>"_KMPLIST.count_"</td>"
 W "</table></td></tr>"
 ;
 W "<tr><td class='label'>High Sequence Queues</td>"
 W "<td><table>"
 W "<tr><th>Link</th><th>Queue</th><th>Count</th></tr>"
 S KMPQUES=KMPHLO.PendingSeqMessageCounts
 S KMPARR=##class(KMP.Utilities).toArray(KMPQUES)
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .W "<tr><td class='value'>"_KMPLIST.Link_"</td>"
 .w "<td class='value'>"_KMPLIST.Queue_"</td>"
 .w "<td class='value'>"_KMPLIST.count_"</td>"
 W "</table></td></tr>"
 ;
 W "<tr><td class='label'>High Sequence Queues</td>"
 W "<td><table>"
 W "<tr><th>Link</th><th>Queue</th><th>Count</th></tr>"
 S KMPQUES=KMPHLO.PendingInMessageCounts
 S KMPARR=##class(KMP.Utilities).toArray(KMPQUES)
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .W "<tr><td class='value'>"_KMPLIST.Link_"</td>"
 .w "<td class='value'>"_KMPLIST.Queue_"</td>"
 .w "<td class='value'>"_KMPLIST.count_"</td>"
 W "</table></td></tr>"
 W "</table></td>"
 ;
 ;   Start Taskman Column
 W "<td valign='top'><table>"
 W "<tr><td colspan=2><h2>Task Manager</h2></td></tr>"
 S KMPVAL=KMPTASK.TaskmanStatus,KMPCLASS=$S(KMPVAL="Running":"value",1:"alert")
 W "<tr><td class='label'>Taskman Status:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPVAL=KMPTASK.RunStatus,KMPCLASS=$S(KMPVAL["Current":"value",1:"alert")
 I KMPVAL="Late" S KMPCLASS=$S(KMPTASK.RunLate>50:"alert",KMPTASK.RunLate>20:"warn",1:"value")
 W "<tr><td class='label'>Run Status:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPVAL=KMPTASK.RunLate,KMPCLASS=$S(KMPVAL>50:"alert",KMPVAL>20:"warn",1:"value")
 W "<tr><td class='label'>Seconds Late:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPVAL=KMPTASK.JobsWaiting,KMPCLASS=$S(KMPVAL>29:"alert",KMPVAL>19:"warn",1:"value")
 W "<tr><td class='label'>Jobs Waiting:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPVAL=KMPTASK.TasksRunning,KMPCLASS=$S(KMPVAL>1099:"alert",KMPVAL>999:"warn",1:"value")
 W "<tr><td class='label'>Tasks Running:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPD=$P(KMPTASK.CurrentTimestamp," "),KMPT=$P(KMPTASK.CurrentTimestamp," ",2)
 S KMPTEMP=$P(KMPD,"-",2)_"-"_$P(KMPD,"-",3)_"-"_+KMPD_"  "_$P(KMPT,"Z")
 W "<tr><td class='label'>Current Timestamp:</td><td class='value'>"_KMPTEMP_"</td></tr>"
 S KMPD=$P(KMPTASK.RunNodeTimestamp," "),KMPT=$P(KMPTASK.RunNodeTimestamp," ",2)
 S KMPTEMP=$P(KMPD,"-",2)_"-"_$P(KMPD,"-",3)_"-"_+KMPD_"  "_$P(KMPT,"Z")
 W "<tr><td class='label'>Run Node Timestamp:</td><td class='value'>"_KMPTEMP_"</td></tr>"
 ; Status list
 w "<tr><td colspan=2>&nbsp;</td></tr>"
 w "<tr><td class='label'>Status List:</td>"
 w "<td><table>"
 S KMPSDET=KMPTASK.StatusDetails
 S KMPITR=KMPSDET.%GetIterator()
 S KMPI=KMPITR.%GetNext(.KMPKEY,.KMPVAL)
 w "<tr><td class='label'>Node:</td><td class='value'>"_KMPVAL.Node_"</td></tr>"
 w "<tr><td class='label'>Weight:</td><td class='value'>"_KMPVAL.Weight_"</td></tr>"
 w "<tr><td class='label'>Status:</td><td class='value'>"_KMPVAL.Status_"</td></tr>"
 w "<tr><td class='label'>Time:</td><td class='value'>"_KMPVAL.Time_"</td></tr>"
 w "<tr><td class='label'>$J:</td><td class='value'>"_KMPVAL.JobNumber_"</td></tr>"
 w "<tr><td class='label'>Execute:</td><td class='value'>"_KMPVAL.Execute_"</td></tr>"
 w "<tr><td class='label'>Message:</td><td class='value'>"_KMPTASK.StatusMessage_"</td></tr>"
 w "</table></td></tr>"
 ; schedule list
 w "<tr><td colspan=2>&nbsp;</td></tr>"
 w "<tr><td class='label'>Schedule List:</td>"
 w "<td><table>"
 S KMPVAL=KMPTASK.TasksScheduled,KMPCLASS=$S(KMPVAL>2999:"alert",KMPVAL>2899:"warn",1:"value")
 w "<tr><td class='label'>Tasks Scheduled:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 S KMPVAL=KMPTASK.TasksLate,KMPCLASS=$S(KMPVAL>29:"alert",KMPVAL>19:"warn",1:"value")
 w "<tr><td class='label'>Tasks Late:</td><td class='"_KMPCLASS_"'>"_KMPVAL_"</td></tr>"
 w "<tr><td class='label'>First Task Late by:</td><td class='"_KMPCLASS_"'>"_KMPTASK.FirstLateTaskSeconds_"</td></tr>"
 w "</table></td></tr>"
 ; io list
 w "<tr><td colspan=2>&nbsp;</td></tr>"
 w "<tr><td class='label'>IO List:</td>"
 w "<td><table>"
 w "<tr><td class='label'>Last Scan:</td><td class='value'>"_KMPTASK.LastScan_"</td></tr>"
 w "<tr><td class='label'>Last Device:</td><td class='value'>"_KMPTASK.LastDev_"</td></tr>"
 w "<tr><td class='label'>Device Details:</td><td class='value'>"_KMPTASK.DeviceDetails_"</td></tr>"
 w "<tr><td class='label'>Tasks Waiting on IO:</td><td class='value'>"_KMPTASK.TotalTasksWaitingIo_"</td></tr>"
 w "</table></td></tr>"
 ;
 ; sub managers
 w "<tr><td colspan=2>&nbsp;</td></tr>"
 w "<tr><td class='label'>Waiting on Sub-Managers:</td><td class='value'>"_KMPTASK.SubWait_"</td></tr>"
 w "<tr><td colspan=2>&nbsp;</td></tr>"
 ;
 W "<tr><td colspan=2 valign='top'>"
 W "<table>"
 W "<tr><th>Node</th><th>Count</th><th>Status</th><th>No Start Flag</th></tr>"
 S KMPSMGR=KMPTASK.SubManagerStatus
 S KMPARR=##class(KMP.Utilities).toArray(KMPSMGR)
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .W "<tr><td class='value'>"_KMPLIST.Node_"</td>"
 .w "<td class='value'>"_KMPLIST.Count_"</td>"
 .w "<td class='value'>"_KMPLIST.Status_"</td>"
 .w "<td class='value'>"_KMPLIST.NoStart_"</td></tr>"
 W "</table></td></tr>"
 ;
 W "<tr><td colspan=2 valign='top'>"
 W "<table>"
 W "<tr><th>Task</th><th>Next Run</th></tr>"
 S KMPFTASKS=KMPTASK.FutureTasks
 S KMPARR=##class(KMP.Utilities).toArray(KMPFTASKS)
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .S KMPCLASS=$S(KMPLIST.TaskDate="Not Scheduled":"alert",1:"value")
 .W "<tr><td class='value'>"_KMPLIST.Task_"</td>"
 .W "<td class='"_KMPCLASS_"'>"_KMPLIST.TaskDate_"</td></tr>"
 W "</table></td></tr>"
 ;
 W "</table></td>"
 ;
 ; Start Mail Queues Column
 W "<td valign='top'><table>"
 W "<tr valign='top'><td colspan=3 valign='top'><h2>Mail Queues</h2></td></tr>"
 W "<tr><td class='label'>Total Messages Queued:</td><td class='value'>"_KMPMAIL.TotalMessagesQueued_"</td></tr>"
 W "<tr><td class='label'>Total Domains:</td><td class='value'>"_KMPMAIL.TotalDomains_"</td></tr>"
 w "<tr><td colspan=3>&nbsp;</td></tr>"
 W "<tr><td colspan=3><table>"
 w "<tr><th>Mail Domain</th><th>Messages</th><th>Link</th></tr>"
 S KMPDARR=KMPMAIL.Queues
 S KMPARR=##class(KMP.Utilities).toArray(KMPDARR)
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .W "<tr><td class='value'>"_KMPLIST.Domain_"</td>"
 .W "<td class='value'>"_$P(KMPLIST.MessageData,"^",1)_"</td>"
 .W "<td class='value'>"_$P(KMPLIST.MessageData,"^",2)_"</td></tr>"
 W "</table></td></tr>"
 ;
 W "<tr><td colspan=2>&nbsp;</td></tr>"
 W "<tr><td colspan=2 align='center'><h2>Patch Installs</td></tr>"
 W "<tr><td colspan=2 align='center'>"_KMPFDIS_" through "_KMPTDIS_"</td></tr>"
 W "<tr><td colspan=2>&nbsp;</td></tr>"
 S KMPARR=##class(KMP.Utilities).toArray(KMPPARR)
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .W "<tr><td>"_KMPLIST.Patch_"</td>"
 .W "<td class='value'>"_KMPLIST.InstallDate_"</td></tr>"
 ;
 W "</table></td>"
 ;
 W "</tr></table>"
 W "</body></html>"
 Q
