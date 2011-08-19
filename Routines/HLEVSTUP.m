HLEVSTUP ;O-OIFO/LJA - Event Monitor SETUP ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
E7761 ; Enter/Edit 776.1...
 N DA,DIC,DIE,DR,IEN,X,Y
 D HD,EX
 F  D  QUIT:IEN'>0
 .  W !
 .  S IEN=$$ASKIEN^HLEVREP(776.1,"L") QUIT:'IEN  ;->
 .  W !!,$$CJ^XLFSTR("---------------- editing entry ----------------",IOM)
 .  W !
 .  D EDIT(776.1,IEN,"[HLEV MONITOR ENTER/EDIT]")
 .  W !
 .  D ASKRUN^HLEVAPI1(+IEN)
 .  D HD,EX
 Q
 ;
E7769 ; Edit 776.999...
 N DA,DIC,DIE,DR,IEN,X,Y
 W @IOF
 D EDIT(776.999,1,"[HLEV MASTER JOB ENTER/EDIT]")
 W !
 S X=$$BTE^HLCSMON("Press RETURN to exit... ")
 Q
 ;
EDIT(FILE,IEN,DR) ; Edit entry...
 N DA,DIE
 S DA=+IEN,DIE=FILE
 D ^DIE
 Q
 ;
HD W @IOF,$$CJ^XLFSTR("Event Monitoring System Enter/Edit",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EX N I,T F I=1:1 S T=$T(EX+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;You may now enter new entries, and edit existing entries.  Enter a new entry
 ;;now, or select the existing entry to be edited.
 QUIT
 ;
HELP(FILE,FLD) D HELPM
 ;;776.1^2^HD^STATUS (#2)
 ;;776.1^2^TX^Enter ACTIVE to make this event monitor "available" to the master job for
 ;;776.1^2^TX^queuing.  When set to ACTIVE the master job will run this event monitor
 ;;776.1^2^TX^according to the REQUEUE FREQUENCY (that you will be asked several prompts
 ;;776.1^2^TX^from now.)
 ;;776.1^2^TX^
 ;;776.1^2^TX^NOTE:  If you're entering this event monitor for the first time, you should
 ;;776.1^2^TX^       set this field to INACTIVE until all fields have been filled in.  Then,
 ;;776.1^2^TX^       change this field back to ACTIVE.^1
 ;;
 ;;776.1^3^HD^SHORT DESCRIPTION (#3)
 ;;776.1^3^TX^Enter a short description for this event monitor; something that is more
 ;;776.1^3^TX^complete and descriptive than the NAME.^1
 ;;
 ;;776.1^4^HD^REQUEUE FREQUENCY (#4)
 ;;776.1^4^TX^The master job will run this event monitor as often as you specify.  And, this
 ;;776.1^4^TX^field is the way you specify rerun frequency.  Enter the number of minutes
 ;;776.1^4^TX^that should elapse after this event monitor runs until it is run again.
 ;;776.1^4^TX
 ;;776.1^4^TX^NOTE:  Enter '0' if you want this event to run every time the master job
 ;;776.1^4^TX^       checks this monitor.^1
 ;;
 ;;776.1^5^HD^REMOTE REQUESTABLE
 ;;776.1^5^TX^Some monitors can only be started locally at a site.  Some monitors can be
 ;;776.1^5^TX^started locally, and also requested remotely.  (A remote request occurs when
 ;;776.1^5^TX^someone at another site or location sends a Mailman message to your site - to
 ;;776.1^5^TX^your site's HL7 Event Monitor's server option - requesting that the monitor be
 ;;776.1^5^TX^run.)^1
 ;;776.1^5^TX^WARNING!!  Does this monitor return a report to the requester containing
 ;;776.1^5^TX^           sensitive information?  If so, you should not, under any 
 ;;776.1^5^TX^           circumstances, set this field to YES.^1
 ;;776.1^5^TX^Please specify now whether this monitor can be requested remotely.  Enter YES
 ;;776.1^5^TX^to allow remote users to run this monitor.  Enter NO if remote requests should
 ;;776.1^5^TX^ignored.^1
 ;;
 ;;776.1^6^HD^M STARTUP LOCATION
 ;;776.1^6^TX^The master job uses this field to determine how to start this event monitor.
 ;;776.1^6^TX^So, enter the M location (subroutine and routine) where the event
 ;;776.1^6^TX^should be queued.  Enter it in the SUBROUTINE~ROUTINE format, substituting
 ;;776.1^6^TX^a tilde (~) for the up-arrow.
 ;;776.1^6^TX^
 ;;776.1^6^TX^The M location you enter now is the location where queued jobs start.^1
 ;;
 ;;776.1^7^HD^M START CHECK (EXTRINSIC FUNCTION)
 ;;776.1^7^TX^Normally, the master job uses the monitor's requeue frequency in order to
 ;;776.1^7^TX^determine whether a new monitor job should be queued.  Alternately, you may
 ;;776.1^7^TX^call an extrinsic function to determine whether a new monitor job should be
 ;;776.1^7^TX^started.  Entry of the M check extrinsic function is optional.
 ;;776.1^7^TX^
 ;;776.1^7^TX^Extrinsic functions must follow these rules:
 ;;776.1^7^TX^
 ;;776.1^7^TX^ * Syntax = $$TAG~ROUTINE (where TAG and ROUTINE do not exceed 8 characters.)
 ;;776.1^7^TX^ * $$TAG~ROUTINE returns a 1 or 0.  
 ;;776.1^7^TX^
 ;;776.1^7^TX^The extrinsic function should return '0' if a new monitor job should not be
 ;;776.1^7^TX^started, or a '1' to start a new monitor job.^1
 ;;
 ;;776.1^41^HD^PARAMETER NOTES
 ;;776.1^41^TX^Enter description and documentation of the just entered parameters.^1
 ;;
 ;;776.1^50^HD^EVENT MONITOR NOTES
 ;;776.1^50^TX^Enter overall comments about this event monitor.^1
 ;;
 ;;776.1^51^HD^MAIL GROUPs, USERs, REMOTE USERs
 ;;776.1^51^TX^Enter the mail groups and local users and remote users to which notification
 ;;776.1^51^TX^messages are to be sent.  If no notification message will ever be sent, leave
 ;;776.1^51^TX^these fields blank.^1
 ;;
 ;;=====================================================================
 ;;776.999^.01^HD^MONITORING SYSTEM NAME
 ;;776.999^.01^TX^You may change the name of the monitoring system if you like.  (But, it
 ;;776.999^.01^TX^makes no difference to the monitoring system!)^1
 ;;
 ;;776.999^2^HD^MASTER JOB STATUS
 ;;776.999^2^TX^Set this field to ACTIVE to enable the master job to run and monitor your
 ;;776.999^2^TX^system.  (The master job is started and stopped using the 'Turn on/off
 ;;776.999^2^TX^monitoring system [HLEV EDIT MASTER ON-OFF]' menu option.)  Set this field
 ;;776.999^2^TX^to INACTIVE to stop the master job (if it is running), and to ensure that
 ;;776.999^2^TX^the master job does not start^1
 ;;
 ;;776.999^3^HD^MASTER JOB INTERVAL (MINUTES)
 ;;776.999^3^TX^The master job is started every MASTER JOB INTERVAL minutes to evaluate your
 ;;776.999^3^TX^system.  Enter the number of minutes now that should elapse between every
 ;;776.999^3^TX^"run" of the master job.^1
 ;;
 ;;776.999^4^HD^PURGE LIMIT FOR DATA
 ;;776.999^4^TX^Whenever the master job runs, data is created in the HL7 Monitor Master Job
 ;;776.999^4^TX^file (#776.2.)  Whenever the master job spawns off a new background job for
 ;;776.999^4^TX^an event monitor, data is created in the HL7 Monitor Job file (#776.)  Purging
 ;;776.999^4^TX^of this data occurs automatically.  This parameter controls how much data to
 ;;776.999^4^TX^retain.  For example, if you enter '96' now, then no data less than 96 hours
 ;;776.999^4^TX^old will be purged.^1
 ;;
 ;;776.999^6^TX^
 ;;776.999^6^TX^
 ;;776.999^6^TX^                        --- EVENT MONITORING FIELDS ---
 ;;776.999^6^TX^
 ;;776.999^6^HD^STATUS OF EVENT MONITORING
 ;;776.999^6^TX^The master job periodically "fires off" event monitors.  If you set this field
 ;;776.999^6^TX^to INACTIVE, the master job will continue to start and run, but no events
 ;;776.999^6^TX^will be started.  When this field is set to ACTIVE, the master job will be
 ;;776.999^6^TX^able to run event monitors.^1
 ;
 Q
 ;
HELPM ; Display of HELP logic...
 N I,INFO,J,T,TYP
 F I=1:1 S T=$T(HELP+I) Q:T'[";;"  D
 .  S T=$P(T,";;",2,999)
 . I +T=FILE,$P(T,U,2)=FLD D
 .  .  S TYP=$P(T,U,3),INFO=$P(T,U,4)
 .  .  W:TYP="HD" !!,$$CJ^XLFSTR(" "_INFO_" ",IOM,"=")
 .  .  W:TYP="TX" !,INFO
 .  .  W:TYP="FT" !,$$REPEAT^XLFSTR("=",IOM)
 .  .  I $P(T,U,5)>0 F J=1:1:$P(T,U,5) W !
 Q
 ;
IMPLEMNT ; Not yet implemented API...
 N OPT
 S OPT=$P($G(XQY0),U,2)_" ["_$P($G(XQY0),U)_"]"
 W !!,$$CJ^XLFSTR("This '"_OPT_"' menu option",IOM)
 W !,$$CJ^XLFSTR("is not yet implemented.",IOM)
 W !
 S X=$$BTE^HLCSMON("Press RETURN to return to menu...")
 Q
 ;
EOR ;HLEVSTUP - Event Monitor SETUP ;5/16/03 14:42
