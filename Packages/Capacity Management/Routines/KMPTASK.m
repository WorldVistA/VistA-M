KMPTASK ;SP/JML - Cache TaskManager Task ;7/1/2025
 ;;4.0;CAPACITY MANAGEMENT;**1,4,5**;3/1/2018;Build 9
 ;
 ;
TASK(KMPVNSP) ; CHECK CREATE OR RESUME KMPVRUN TASK IN CACHE TASKMGR
 N I,KMPVMSG,KMPVNSPE,KMPVROLS,KMPVSTAT,KMPVTASK,KMPVTFLG,KMPVTSK,KMPVTSKS,KMPX,KMPVTID,KMPVTRUN
 ;
 S KMPVROLS=##class(KMP.Utilities).getRoles()
 I (KMPVROLS'["%All")&(KMPVROLS'["%Manager") D  Q
 .W !,"You must have either the %Manager or the %All Role",!
 I $G(KMPVNSP)="" S KMPVNSP=$ZDEFNSP
 I '##class(%SYS.Namespace).Exists(KMPVNSP) S KMPVNSP=$ZDEFNSP
 S KMPVTSK="KMPVRUN"
 I KMPVNSP'=$ZDEFNSP S KMPVTSK=KMPVTSK_"_"_KMPVNSP
 S KMPVMSG="CHECKING KMPV SETUP IN "_KMPVNSP_" NAMESPACE..."
 W !,KMPVMSG,!!
 D ##class(%SYS.System).WriteToConsoleLog("ZSTU: "_KMPVMSG,0,0)
 S KMPVTFLG=0
 S KMPVTSKS=##class(%ResultSet).%New("%SYS.TaskSuper.TaskListDetail")
 S KMPVSTAT=KMPVTSKS.Execute()
 F  S KMPX=KMPVTSKS.Next() Q:KMPVTSKS.GetDataByName("ID")=""  D
 .I (KMPVTSKS.GetDataByName("Task Name")=KMPVTSK) D
 ..S KMPVTID=KMPVTSKS.GetDataByName("ID")
 ..S KMPVTRUN=KMPVTSKS.GetDataByName("Next Scheduled Date")_" at "_KMPVTSKS.GetDataByName("Next Scheduled Time")
 ..I KMPVTSKS.GetDataByName("Suspended")'="" D
 ...D ##class(%SYS.Task).Resume(KMPVTID)
 ...S KMPVMSG=KMPVTSK_" Task #"_KMPVTID_" Exists and Resumed to Run at "_KMPVTRUN
 ..E  S KMPVMSG=KMPVTSK_" Task #"_KMPVTID_" Exists and Scheduled to Run at "_KMPVTRUN
 ..S KMPVTFLG=1
 ..W !,KMPVMSG
 ..D ##class(%SYS.System).WriteToConsoleLog("ZSTU: "_KMPVMSG,0,0)
 ;
 ;create task if it doesn't exist
 I 'KMPVTFLG D
 .S KMPVTASK=##Class(%SYS.Task).%New()
 .S KMPVTASK.Name=KMPVTSK
 .S KMPVTASK.Description="Start VSM Collection Drivers"
 .S KMPVTASK.NameSpace=KMPVNSP
 .S KMPVTASK.TaskClass="%SYS.Task.RunLegacyTask"
 .S KMPVTASK.Settings=$lb("ExecuteCode","D RUN^KMPVRUN")
 .S KMPVTASK.RunAsUser="_SYSTEM"
 .S KMPVTASK.Priority=0
 .S KMPVTASK.StartDate=$P($H,",",1)+1
 .S KMPVTASK.DailyFrequency=0 ;task.DailyFrequencyDisplayToLogical("Once")
 .S KMPVTASK.DailyFrequencyTime=""
 .S KMPVTASK.DailyIncrement=""
 .S KMPVTASK.DailyStartTime=60
 .S KMPVTASK.Expires=0
 .S KMPVTASK.DailyEndTime=""
 .S KMPVTASK.RescheduleOnStart=1
 .S KMPVSTAT=KMPVTASK.%Save()
 .I $System.Status.IsError(KMPVSTAT) D  Q
 ..S KMPVMSG(1)="Error #"_$System.Status.GetErrorCodes(KMPVSTAT)
 ..S KMPVMSG(2)=$System.Status.GetOneStatusText(KMPVSTAT,1)
 ..S KMPVMSG(3)="Failed to Create and Schedule Task "_KMPVTSK_" in Cache Task Manager"
 ..F I=1:1:3 W !,KMPVMSG(I) DO ##class(%SYS.System).WriteToConsoleLog("ZSTU: "_KMPVMSG(I),0,1)
 .S KMPVMSG="Created and scheduled Task "_KMPVTSK_" in Cache Task Manager"
 .W !,KMPVMSG DO ##class(%SYS.System).WriteToConsoleLog("ZSTU: "_KMPVMSG,0,0)
 Q
 ;
GLOSTATS(KMPDIRS) ;
 N B,KMPDIR,KMPRES,KMPSTAT,KMPSTATE,KMPVLN
 S KMPVLN=1,B="|"
 S KMPSTATE=##class(%SQL.Statement).%New()
 S KMPSTAT=KMPSTATE.%PrepareClassQuery("%SYS.GlobalQuery","Size")
 S KMPDIR=""
 F  S KMPDIR=$O(KMPDIRS(KMPDIR)) Q:KMPDIR=""  D
 .S KMPRES=KMPSTATE.%Execute(KMPDIR,"","*")
 .D GLOSET(KMPDIR)
 Q
 ;
GLOSET(KMPDIR) ;
 N KMPALL,KMPNAME,KMPUSE
 F  S KMPX=KMPRES.%Next()  Q:KMPRES.%Get("Name")=""  D
 .S KMPNAME=KMPRES.%Get("Name")
 .S KMPALL=KMPRES.%Get("Allocated MB")
 .S KMPUSE=KMPRES.%Get("Used MB")
 .S ^KMPTMP("KMPV","VSTM","TRANSMIT","GLOBALS",$J,KMPVLN)=KMPDIR_B_KMPNAME_B_KMPALL_B_KMPUSE,KMPVLN=KMPVLN+1
 Q
 ;
ZERO() ;
 N B,KMPDATA,KMPFNUM,KMPGNAM,KMPVLN
 S U="^",B="|",KMPVLN=1
 S KMPFNUM=0 F  S KMPFNUM=$O(^DIC(KMPFNUM)) Q:'+KMPFNUM  D
 .Q:$G(^DIC(KMPFNUM,0))=""
 .Q:'$D(^DIC(KMPFNUM,0,"GL"))
 .S KMPGNAM=$G(^DIC(KMPFNUM,0,"GL")) Q:KMPGNAM=""
 .;   file num ^ file name ^ global root ^ version ^ entries ^ last id 
 .S KMPDATA=KMPFNUM_B_$P(^DIC(KMPFNUM,0),U)_B_KMPGNAM_B_+$G(^DD(+$P(^DIC(KMPFNUM,0),U,2),0,"VR"))_B_+$P($G(@(KMPGNAM_"0)")),U,4)_B_+$P($G(@(KMPGNAM_"0)")),U,3)
 .S ^KMPTMP("KMPV","VSTM","TRANSMIT","ZERO",$J,KMPVLN)=KMPDATA,KMPVLN=KMPVLN+1
 Q
