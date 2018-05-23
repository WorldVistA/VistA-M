%ZOSVKR ;SF/KAK/RAK/JML - ZOSVKRO - Collect RUM Statistics for Cache on VMS/Linux/Windows ;7/7/2010
 ;;8.0;KERNEL;**90,94,107,122,143,186,550,568,670**;3/1/2018;Build 45
 ;
RO(KMPVOPT) ; Record option resource usage in ^KMPTMP("KMPR"
 ;
 N KMPVTYP S KMPVTYP=0  ; option
 G EN
 ;
RP(KMPEVENT) ; Record protocol resource usage in ^KMPTMP("KMPR"
 ; Variable PRTCL = option_name^protocol_name
 ;
 ; quit if rum is turned off
 Q:'$G(^%ZTSCH("LOGRSRC"))
 ;
 N KMPVOPT,KMPVPROT
 S KMPVOPT=$P(KMPEVENT,"^"),KMPVPROT=$P(KMPEVENT,"^",2)
 Q:KMPVPROT=""
 ;
 N KMPVTYP S KMPVTYP=1  ; protocol
 G EN
 ;
RU(KMPEVENT,KMPVTYP,KMPVEXT) ;
 ;----------------------------------------------------------------------
 ; Set metrics into ^KMPTMP("KMPV","VBEM","DLY"
 ; Set negative number errors into ^KMPTMP("KMPV","VBEM","ERROR"
 ;
 ;Inputs: - MIRRORS RUM COLLECTOR
 ;  KMPVOPT... Option name (may be option, protocol, rpc, etc.)
 ;  KMPVTYP... type of option:
 ;                   0 - Option
 ;                   1 - Protocol
 ;                   2 - RPC (Remote Procedure Call)
 ;                   3 - HL7
 ;  KMPVEXT... Possible: Extended option type - to identify requests from non-legacy sources
 ;
 ; ^KMPTMP("KMPV","VBEM","DLY"... Storage of data for current day
 ;
 ;NOTE: KMPV("NOKILL" is not "NEWED" or "KILLED" as it must exist between calls
 ;         KMPV("NOKILL",node) contains stats that must exist between routine calls
 ;         KMPV("NOKILL","KMPVMUMPS") persists M implementation to decrease overhead
 ;         KMPV("NOKILL","KMPVVER") persists Version number to decrease overhead 
 ;----------------------------------------------------------------------
 ;
 Q:$G(KMPEVENT)=""
 ;
 N KMPVOPT,KMPVPROT
 S KMPVOPT=$P(KMPEVENT,"^"),KMPVPROT=$P(KMPEVENT,"^",2)
 ;
 S KMPVTYP=+$G(KMPVTYP),KMPVEXT=+$G(KMPVEXT)
 ;
EN ;
 ;
 N KMPVCSTAT,KMPVDIFF,KMPVH,KMPVHOUR,KMPVHRSEC,KMPVHTIME,KMPVI,KMPVMET
 N KMPVMIN,KMPVNODE,KMPVPOPT,KMPVPSTAT,KMPVSINT,KMPVSLOT,Y
 ;
 S KMPVSINT=$$GETVAL^KMPVCCFG("VBEM","COLLECTION INTERVAL",8969)
 ;
 D GETENV^%ZOSV S KMPVNODE=$P(Y,U,3)_":"_$P($P(Y,U,4),":",2) ;  IA 10097
 I KMPVTYP I KMPVOPT="" S:$P($G(KMPV("NOKILL",KMPVNODE,$J)),U,10)["$LOGIN$" KMPVOPT="$LOGIN$"
 I KMPVOPT="" Q:'+$G(^XUTL("XQ",$J,"T"))  S KMPVOPT=$P($G(^XUTL("XQ",$J,^XUTL("XQ",$J,"T"))),U,2) Q:KMPVOPT=""
 ;
 ; KMPVCSTAT = current stats for this $job:  cpu^lines^commands^GloRefs^ElapsedTime
 S KMPVCSTAT=$$STATS()
 Q:KMPVCSTAT=""
 S $P(KMPVCSTAT,"^",5)=$ZTIMESTAMP
 ;
 ; KMPVPSTAT = previous stats for this $job
 S KMPVPSTAT=$G(KMPV("NOKILL",KMPVNODE,$J,"STATS"))
 S KMPVPOPT=$G(KMPV("NOKILL",KMPVNODE,$J,"OPT"))
 ;
 ; if previous option was tagged as being run from taskman(!)
 ; then mark current OPTion as running from taskman(!)
 I $P(KMPVPOPT,"***")=("!"_KMPVOPT) S KMPVOPT="!"_KMPVOPT
 ;
 ; concatenate to KMPVCSTAT: ...^OPTion^option_type
 S KMPV("NOKILL",KMPVNODE,$J,"STATS")=KMPVCSTAT
 S KMPV("NOKILL",KMPVNODE,$J,"OPT")=$S(KMPVTYP=2:"`"_KMPVOPT,KMPVTYP=3:"&"_KMPVOPT,1:KMPVOPT)_"***"_$G(KMPVPROT)
 ;
 ; if option and login or taskman
 I 'KMPVTYP I KMPVOPT="$LOGIN$"!(KMPVOPT="$STRT ZTMS$") Q
 ;
 I KMPVOPT="$LOGOUT$"!(KMPVOPT="$STOP ZTMS$")!(KMPVOPT="XUPROGMODE") K KMPV("NOKILL",KMPVNODE,$J)
 ;
 Q:KMPVPSTAT=""
 ; difference = current stats minus previous stats
 ; KMPVDIFF       = KMPVCSTAT - KMPVPSTAT
 ;            = cpu^lines^commands^GloRefs^ElapsedTime
 F KMPVI=1:1:4 S $P(KMPVDIFF,"^",KMPVI)=$P(KMPVCSTAT,U,KMPVI)-$P(KMPVPSTAT,"^",KMPVI)
 S $P(KMPVDIFF,U,5)=$$ETIME($P(KMPVCSTAT,U,5),$P(KMPVPSTAT,U,5))
 ;
 S KMPVOPT=KMPVPOPT ; Setting data from previous call
 ;
 S KMPVH=$H
 S KMPVHRSEC=$ZT($P(KMPVH,",",2))
 S KMPVHOUR=$P(KMPVHRSEC,":")
 S KMPVMIN=$P(KMPVHRSEC,":",2)
 S KMPVSLOT=+$P(KMPVMIN/KMPVSINT,".")
 S KMPVHTIME=(KMPVHOUR*3600)+(KMPVSLOT*KMPVSINT*60) ; Same as KMPVVTCM using KMPVHANG. 
 ;
 S KMPVMET=$G(^KMPTMP("KMPV","VBEM","DLY",+KMPVH,KMPVNODE,KMPVHTIME,KMPVPOPT,$J))
 S $P(KMPVMET,U)=$P(KMPVMET,U)+1
 F KMPVI=2:1:6 S $P(KMPVMET,U,KMPVI)=$P(KMPVMET,U,KMPVI)+$P(KMPVDIFF,U,KMPVI-1)
 F KMPVI=2:1:6 I $P(KMPVMET,U,KMPVI)<0 D  Q
 .S ^KMPTMP("KMPV","VBEM","ERROR",+KMPVH,KMPVNODE,KMPVHTIME,KMPVPOPT,$J)=KMPVMET
 S ^KMPTMP("KMPV","VBEM","DLY",+KMPVH,KMPVNODE,KMPVHTIME,KMPVPOPT,$J)=KMPVMET
 ;
 Q
 ;
STATS() ;  return current stats for this $job
 N KMPVCPU,KMPVMUMPS,KMPVOS,KMPVPROC,KMPVRET,KMPVTCPU,KMPVV,KMPVVER,KMPVZH
 ;
 S KMPVRET=""
 ; mumps implementation
 I $G(KMPV("NOKILL","KMPVMUMPS"))="" S KMPV("NOKILL","KMPVMUMPS")=$$VERSION^%ZOSV(1) ; IA 10097
 ; quit if not cache
 Q:$TR(KMPV("NOKILL","KMPVMUMPS"),"cahe","CAHE")'["CACHE" ""
 ; cache version
 I $G(KMPV("NOKILL","KMPVVER"))="" S KMPV("NOKILL","KMPVVER")=$P($$VERSION^%ZOSV(0),".",1,2) ; IA 10097
 ;
 ; if version is greater than 2007
 I KMPV("NOKILL","KMPVVER")>2007 D 
 .; RETURN = cpu^lines^commands^GloRefs
 .S KMPVPROC=##class(%SYS.ProcessQuery).%OpenId($J)
 .Q:KMPVPROC=""
 .; cpu time
 .S KMPVCPU=KMPVPROC.GetCPUTime()
 .S KMPVTCPU=$P(KMPVCPU,",")+$P(KMPVCPU,",",2)
 .S $P(KMPVRET,U)=KMPVTCPU
 .; m commands - lines
 .S $P(KMPVRET,U,2)=KMPVPROC.LinesExecuted
 .; m commands - commands
 .S $P(KMPVRET,U,3)=KMPVPROC.CommandsExecuted
 .; global references
 .S $P(KMPVRET,U,4)=KMPVPROC.GlobalReferences
 .; current time UTC
 .S $P(KMPVRET,U,5)=$ZTIMESTAMP
 ;
 ; if version is 4 or greater and not linux and not unknown
 E  D
 .; operating system
 .S KMPVOS=$$OS^%ZOSV ; IA 10097
 .I (+KMPV("NOKILL","KMPVVER"))'<4&(KMPVOS'["UNIX")&(KMPVOS'["UNK") D
 ..S KMPVV=$V(-1,$J),KMPVZH=$ZU(171)
 ..; cpu time
 ..S $P(KMPVRET,U)=$P(KMPVZH,",")
 ..; m commands
 ..S $P(KMPVRET,U,2)=$P($P(KMPVV,U,7),",")
 ..; global references
 ..S $P(KMPVRET,U,4)=$P($P(KMPVV,U,7),",",2)
 ;
 Q KMPVRET
 ;
ETIME(KMPVCUR,KMPVPREV) ;Calculate elapsed time for event
 N KMPVDAYS,KMPVETIME
 ; IF WITHIN SAME DAY
 S KMPVETIME=""
 I +KMPVCUR=+KMPVPREV D
 .S KMPVETIME=$P(KMPVCUR,",",2)-$P(KMPVPREV,",",2)
 ; IF OVER CHANGE OF DAY
 E  D
 .S KMPVETIME=$P(KMPVCUR,",",2)+(86400-$P(KMPVPREV,",",2))
 .; IN CASE RUNS OVER 2 DAY BOUNDARIES
 .S KMPVDAYS=(+KMPVCUR)-(+KMPVPREV)
 .I KMPVDAYS>1 S KMPVETIME=KMPVETIME+((KMPVDAYS-1)*86400)
 Q KMPVETIME
