%ZOSVKR ;SF/KAK/RAK - Collect RUM Statistics for OpenM/Cache;8/20/99  08:43  ;3/27/00  11:24
 ;;8.0;KERNEL;**90,94,107,122,143,186**;May 1, 2003 11:49 am
 ;
RO(OPT) ; Record option resource usage in ^KMPTMP("KMPR"
 ;
 N KMPRTYP S KMPRTYP=0  ; option
 G EN
 ;
RP(PRTCL) ; Record protocol resource usage in ^KMPTMP("KMPR"
 ; Variable PRTCL = option_name^protocol_name
 ;
 ; quit if rum is turned off
 Q:'$G(^%ZTSCH("LOGRSRC"))
 ;
 N OPT
 S OPT=$P(PRTCL,"^"),PRTCL=$P(PRTCL,"^",2)
 Q:PRTCL=""
 ;
 N KMPRTYP S KMPRTYP=1  ; protocol
 G EN
 ;
RU(KMPROPT,KMPRTYP,KMPRSTAT) ;-- set resource usage into ^KMPTMP("KMPR"
 ;----------------------------------------------------------------------
 ; KMPROPT... Option name (may be option, protocol, rpc, etc.)
 ; KMPRTYP...
 ;    Type of option:
 ;                   0 - Option
 ;                   1 - Protocol
 ;                   2 - RPC (Remote Procedure Call)
 ;                   3 - HL7
 ; KMPRSTAT..
 ;    Status (for future use):
 ;                   1 - start
 ;                   2 - stop
 ;----------------------------------------------------------------------
 ;
 Q:$G(KMPROPT)=""
 ;
 S KMPRTYP=+$G(KMPRTYP)
 S KMPRSTAT=$G(KMPRSTAT)
 ;
 N OPT,PRTCL
 ; 
 ; OPT   = option name
 ; PRTCL = protocol name (optional)
 S OPT=$P(KMPROPT,"^"),PRTCL=$P(KMPROPT,"^",2)
 ;
EN ;
 ; CURHDAY... current $H day
 ; CURHSEC... current $H seconds
 ; CURSTAT... current stats
 ; DIFF...... difference (CURSTAT minus PREVSTAT)
 ; NODE...... current node
 ; PREVHDAY.. previous $H day
 ; PREVHSEC.. previous $H seconds
 ; PREVSTAT.. previous stats
 ; PRIMETM... prime time (1) or non-prime time (0)
 ;
 N ACTV,ARRAY,CURHDAY,CURHSEC,CURSTAT,CURRHR,DIFF
 N I,NODE,PREVHDAY,PREVHSEC,PREVSTAT,PRIMETM,Y
 ;
 ; quit if not in "PROD" uci
 S Y="" X $G(^%ZOSF("UCI")) Q:Y'[$G(^%ZOSF("PROD"))
 ;
 D GETENV^%ZOSV S NODE=$P(Y,"^",3),U="^"
 I KMPRTYP I OPT="" S:$P($G(KMPR("JOB",NODE,$J)),"^",10)["$LOGIN$" OPT="$LOGIN$"
 I OPT="" Q:'+$G(^XUTL("XQ",$J,"T"))  S OPT=$P($G(^XUTL("XQ",$J,^XUTL("XQ",$J,"T"))),"^",2) Q:OPT=""
 ;
 ; CURSTAT = current stats for this $job
 ;         = cpu^dio^bio^pg_fault^cmd^glo^$H_day^$H_sec^ascii_time
 S CURSTAT=$P($$STATS,"^",1,9)
 Q:CURSTAT=""
 ;
 S CURHDAY=$P(CURSTAT,"^",7),CURHSEC=$P(CURSTAT,"^",8)
 ;
 ; PREVSTAT = previous stats for this $job
 S PREVSTAT=$G(KMPR("JOB",NODE,$J))
 ;
 ; if previous option was tagged as being run from taskman(!)
 ; then mark current OPTion as running from taskman(!)
 I $P($P(PREVSTAT,"^",10),"***")=("!"_OPT) S OPT="!"_OPT
 ;
 ; concatenate to CURSTAT: ...^OPTion^option_type
 S CURSTAT=CURSTAT_"^"_$S(KMPRTYP=2:"`"_OPT,KMPRTYP=3:"&"_OPT,1:OPT)_"***"_$G(PRTCL)_"^"_$G(XQT)
 S KMPR("JOB",NODE,$J)=CURSTAT
 ;
 ; if option and login or taskman
 I 'KMPRTYP I OPT="$LOGIN$"!(OPT="$STRT ZTMS$") Q
 ;
 I OPT="$LOGOUT$"!(OPT="$STOP ZTMS$")!(OPT="XUPROGMODE") K KMPR("JOB",NODE,$J)
 ;
 Q:PREVSTAT=""
 ;
 ; check for negative numbers for m commands and glo references
 F I=5,6 I $P(CURSTAT,"^",I)<0 D 
 .S $P(CURSTAT,"^",I)=$P(CURSTAT,"^",I)+(2**31)+(2**31)
 .I $P(PREVSTAT,"^",I)<0 S $P(PREVSTAT,"^",I)=$P(PREVSTAT,"^",I)+(2**31)+(2**31)
 ;
 S PREVHDAY=$P(PREVSTAT,"^",7),$P(PREVSTAT,"^",7)=$P(PREVSTAT,"^",8)
 ;
 ; quit if not $h
 Q:'PREVHDAY
 ;
 ; if option has been running more than one day
 ; add the number of seconds in each day to the current $H seconds
 S $P(CURSTAT,"^",7)=(CURHDAY-PREVHDAY)*86400+CURHSEC
 ;
 ; difference = current stats minus previous stats
 ; DIFF       = CURSTAT - PREVSTAT
 ;            = cpu^dio^bio^pg_fault^cmd^glo^elapsed_sec
 F I=1:1:7 S $P(DIFF,"^",I)=$P(CURSTAT,"^",I)-$P(PREVSTAT,"^",I)
 ;
 ; quit if negative m commands or global references
 Q:$P(DIFF,"^",5)<0
 Q:$P(DIFF,"^",6)<0
 ;
 ; option name
 S OPT=$P(PREVSTAT,"^",10)
 ;
 ; PRIMETM = 0: non-prime time
 ;           1: prime time
 S PRIMETM=0
 ;
 ; set prime time = 1 if after 8am and before 5pm
 ; non-workday prime time and non-prime time will be converted
 ; into non-workday time in nightly background job (KMPRBD02)
 I CURHSEC>28799&(CURHSEC<61201) S PRIMETM=1
 ;
 ; global location for data storage
 S ARRAY=$G(^KMPTMP("KMPR","DLY",NODE,CURHDAY,OPT,$J,PRIMETM))
 ;
 ; seven elements for this option
 F I=1:1:7 S $P(ARRAY,"^",I)=$P($G(ARRAY),"^",I)+$P(DIFF,"^",I)
 ; 8th piece is occurrence counter for this option
 S $P(ARRAY,"^",8)=$P(ARRAY,"^",8)+1
 ;
 ; current hour => 0 - 23
 S CURRHR=CURHSEC\3600
 ;
 ; time starts at zero hour - shift everything by 10 so zero hour
 ; begins at 10th piece, hour 1 is 11th, ... and hour 23 is 33rd piece
 ;
 ; record last hour this option ran - this will be moved to file 8971.1
 ; hourly stats are only attributed to the current hour
 ;
 ; add ~1 if this job runs from top of hour to 60 seconds
 ; this will give active number of jobs per hour
 S ACTV=$P(ARRAY,"^",(CURRHR+10)),$P(ACTV,"~")=$P(ACTV,"~")+1
 I (($P(CURSTAT,"^",8)#3600)-$P(DIFF,"^",7))<60 S $P(ACTV,"~",2)=1
 S $P(ARRAY,"^",(CURRHR+10))=ACTV
 ;
 ; 9th piece: current $h seconds ~ elapsed seconds ~ difference
 S $P(ARRAY,"^",9)=($P(CURSTAT,"^",8))_"~"_($P(DIFF,"^",7))_"~"_(($P(CURSTAT,"^",8)#3600)-$P(DIFF,"^",7))
 ;
 ; set into global
 S ^KMPTMP("KMPR","DLY",NODE,CURHDAY,OPT,$J,PRIMETM)=ARRAY
 ;
 Q
 ;
STATS() ;-- extrinsic - return current stats for this $job
 ;
 N H,RETURN,V,VER,ZH,ZT
 ;
 S RETURN="",ZT=$P($ZTIMESTAMP,".",2),V=$V(-1,$J),VER=$P($P($P($ZV,") ",2)," "),".",1,2)
 ;
 ; if version is less than 4
 I (+VER)<4 D
 .; cpu^dio^bio^pg_fault^cmd^glo^$H_date^$H_sec^time in thousands
 .; -> no cpu^dio^bio^pg_fault information is returned
 .S RETURN="^^^^"_$P($P(V,"^",7),",")_"^"_$P($P(V,"^",7),",",2)_"^"_+$H_"^"_$P($H,",",2)_"."_ZT_"^"_ZT
 ;
 ; if version is 4 or greater
 E  D
 .S ZH=$ZU(171),ZT=$P($ZTIMESTAMP,".",2)
 .S H=$P(ZH,",",3),H=$E(H,13,23),H=+$H_","_($P(H,":")*3600+($P(H,":",2)*60))_"."_ZT
 .; cpu^dio^bio^pg_fault^cmd^glo^$H_date^$H_sec^ascii_time^$s
 .S RETURN=$P(ZH,",")_"^"_$P(ZH,",",7)_"^"_$P(ZH,",",8)_"^"_$P(ZH,",",4)_"^"_$P($P(V,"^",7),",")_"^"_$P($P(V,"^",7),",",2)_"^"_$P(H,",")_"^"_$P(H,",",2)_"^"_$P(ZH,",",3)_"^"_$S
 ;
 Q RETURN
 
