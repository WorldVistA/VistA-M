XUVSM ;BAY/JML - TaskMan Read-Only Calls for the VistA System Monitor;7/1/2025
 ;;8.0;KERNEL;**818**;7/10/1995;Build 5
 ;
 ; This routine provides read-only callables to populate the VSM Operational Dashboard
 ;
RUNSTATUS() ; returns the Run Status of TaskMan - Adapted from RUN^ZTMON
 N ZTH,ZTR,ZTD,ZTD,ZTY,ZTRUNSTAT
 S ZTH=$H,ZTR=$G(^%ZTSCH("RUN"))
 I ZTR]"" S ZTD=$$DIFF^%ZTM(ZTH,ZTR,0)
 S ZTY=$S(ZTR="":0,ZTD>20:0,1:1)
 S ZTRUNSTAT=$S(ZTY=1:"Current",ZTY=0:"Late",ZTY=""&$D(^%ZTSCH("STOP")):"Shutting Down",ZTY=""&'$D(^%ZTSCH("STATUS")):"Not Running",1:"Unknown")
 Q ZTRUNSTAT_"^"_ZTD_"^"_ZTH_"^"_ZTR
 ;
STATLIST(KMPARR) ; TaskMan status list - Adapted from STATUS^ZTMON
 N ZT,ZTH,ZT2,ZTC,ZTI,ZTX,ZT1,%
 S ZT="",ZTH=$$H3^%ZTM($H),ZT2=""
 M ZTC("S")=^%ZTSCH("STATUS"),ZTC("L")=^%ZTSCH("LOADA")
 F  S ZT=$O(ZTC("S",ZT)) Q:ZT=""  S ZTX=ZTC("S",ZT) I $L($P(ZTX,"^",3)) S ZTC("D",$P(ZTX,"^",3),ZT)=ZT
 S ZT="",ZTI=1
 F  S ZT=$O(ZTC("D",ZT)),ZT1="" Q:ZT=""  F  S ZT1=$O(ZTC("D",ZT,ZT1)) Q:ZT1=""  D
 .S %=ZTC("S",ZT1),ZT2=1
 .S KMPARR("LIST",ZTI,"NODE")=ZT
 .S KMPARR("LIST",ZTI,"WEIGHT")=$S($D(ZTC("L",ZT)):$J($P(ZTC("L",ZT),"^",2),3),1:"")
 .S KMPARR("LIST",ZTI,"STATUS")=$P(%,"^",2)
 .S KMPARR("LIST",ZTI,"TIME")=$$STIME^ZTMON($P(%,"^"))
 .S KMPARR("LIST",ZTI,"JOBNUM")=ZT1
 .S KMPARR("LIST",ZTI,"EXECUTE")=$P(%,"^",4)
 .S ZTI=ZTI+1
 S KMPARR("STATMESS")=$S('ZT2:"The Status List is "_$S(ZTY:"temporarily ",1:"")_"empty.",1:"")
 S KMPARR=ZTI
 Q
 ;
SCHLIST() ;Evaluate Schedule List - Adapted from SCHQ^ZTMON
 N ZT1,ZTCO,ZTC,ZTH,X,ZTL,ZT2
 S ZT1=0,ZTCO=0,ZTC=0,ZTH=$$H3^%ZTM($H)
 S X=$O(^%ZTSCH(0)),ZTL=$$DIFF^ZTMON(ZTH,X,1)
 F  S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  D
 . F ZT2=0:0 S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:ZT2=""  S ZTC=ZTC+1 I $$DIFF^ZTMON(ZTH,ZT1,1)>0 S ZTCO=ZTCO+1
 Q ZTC_"^"_ZTCO_"^"_$S((ZTC>0)&(ZTL>0):ZTL,1:"")
 ;
IOLIST(KMPARR) ;Evaluate Waiting Lists - Adapted from IO^ZTMON
 N X,X1,Y,ZT1,ZT2,ZT3,ZT,ZTCT,ZTTAT,ZTC,ZTI
 S ZT1=$$H3^ZTMON1($H),ZT2=$G(^%ZTSCH("IO")),ZT=$$DIFF^%ZTMS1(ZT1,+ZT2,1)
 S KMPARR("LASTSCAN")=$S(($D(^%ZTSCH("IO"))>2)&(+ZT2):ZT,1:"")
 S KMPARR("LASTDEV")=$S(($D(^%ZTSCH("IO"))>2)&($P(ZT2,"^",2)]""):$P(ZT2,"^",2),1:"")
 S ZT1="",ZTCT=0,ZTI=1
 F  S ZT1=$O(^%ZTSCH("IO",ZT1)) Q:ZT1=""  D
 .I $D(^%ZTSCH("IO",ZT1))<9 Q
 .S Y=1 I ZT1'=$I S X=ZT1,X1=$G(^%ZTSCH("IO",ZT1)) D DEVOK^%ZOSV
 .S ZTSTAT=$S(Y:" is not available,",$D(^%ZTSCH("DEV",ZT1)):" is allocated,",1:" is AVAILABLE,")
 .S ZTC=0,ZT2="" F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:'ZT2  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTC=ZTC+1,ZTCT=ZTCT+1
 .S KMPARR("LIST",ZTI,"ONE")=ZT1
 .S KMPARR("LIST",ZTI,"TWO")=ZTSTAT
 .S KMPARR("LIST",ZTI,"THREE")=ZTC
 .S ZTI=ZTI+1
 S KMPARR("TTSKWAIT")=ZTCT
 Q
 ;
JOBSWAIT()   ; returns # of jobs waiting - Adapted from ^ZTMON1
 N ZTC,ZT,ZT1,ZT2
 S ZTC=0,ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2=0 Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:'ZT2  S ZTC=ZTC+1
 Q ZTC
 ;
TASKSRUN()  ; returns the # of tasks running - Adapted from ^ZTMON1
 N ZTC,ZT1
 S ZTC=0 F ZT1=0:0 S ZT1=$O(^%ZTSCH("TASK",ZT1)) Q:'ZT1  S ZTC=ZTC+1
 Q ZTC
 ;
SMLIST(KMPARR) ; returns Sub-Manager data - Adapted from ^ZTMON1
 N ZTNODE,ZTCNT,ZT4,ZTSTAT,ZTNOSTRT
 S KMPARR("SUBWAIT")=$S($D(^%ZTSCH("WAIT","SUB")):1,1:0)
 S ZTNODE="",ZTI=1
 F  S ZTNODE=$O(^%ZTSCH("SUB",ZTNODE)) Q:ZTNODE=""  D
 .S ZTCNT=$G(^%ZTSCH("SUB",ZTNODE)),ZT4=+$G(^%ZTSCH("LOADA",ZTNODE))
 .S ZTSTAT=$S($D(^%ZTSCH("STOP","SUB",ZTNODE)):"Stop",ZT4:"BWait",1:"Run")
 .S ZTNOSTRT=$S($G(^%ZTSCH("SUB",ZTNODE,0))>5:1,1:0)
 .S KMPARR("LIST",ZTI,"NODE")=ZTNODE
 .S KMPARR("LIST",ZTI,"COUNT")=ZTCNT
 .S KMPARR("LIST",ZTI,"STATUS")=ZTSTAT
 .S KMPARR("LIST",ZTI,"NOSTART")=ZTNOSTRT
 Q
 ;
INSTALL(XTARRAY,XTSDAT,XTEDAT) ;
 ; returns list of patch installs and install dates
 ; inputs:  an array by reference to return results and start/end dates in fileman format
 ; Defaults for dates are today-14 through today
 N XTIEN,XTCHK,XTPAT,%,%H,X
 S XTSDAT=$G(XTSDAT),XTEDAT=$G(XTEDAT)
 I XTSDAT="" D
 .S XTSDAT=$H-14
 .S %H=XTSDAT D YMD^%DTC S XTSDAT=X
 I XTEDAT="" D
 .S XTEDAT=+$H+1
 .S %H=XTEDAT D YMD^%DTC S XTEDAT=X
 S XTIEN=0
 F  S XTIEN=$O(^XPD(9.7,XTIEN)) Q:+XTIEN=0  D
 .S XTCHK=$P(^XPD(9.7,XTIEN,0),"^",3)
 .I XTCHK>XTSDAT,XTCHK<XTEDAT D
 ..S XTPAT=$P(^XPD(9.7,XTIEN,0),"^")
 ..S XTARRAY(XTCHK,XTPAT)=""
 Q
 ;
 ;
FUT(ZTCHECK) ;Future tasks.
 N ZT1,ZT2,ZTS,XU0,XU1,XU2,XUOPT,XUDAY,XURT,XUTIME
 ; FROM XUTMQ2
 K ^TMP($J)
 S ZT1="" F  S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  D
 .S ZT2="" F  S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:'ZT2  D
 .. D SORT(ZT1,ZT2) ;S ^TMP($J,99999-ZT1,99999-$P(ZT1,",",2),ZT2)=""
 S ZT1=$$H3^%ZTM($H) F  S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  D
 .S ZTS=0 F  S ZTS=$O(^%ZTSCH(ZT1,ZTS)) Q:'ZTS  D
 .. D SORT(ZT1,ZTS) ;S ^TMP($J,99999-ZT1,99999-$P(ZT1,",",2),ZTS)=""
 S ZT1="" F  S ZT1=$O(^%ZTSCH("IO",ZT1)) Q:ZT1=""  D
 .S ZT2="" F  S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:'ZT2  D
 ..S ZT3=0 F  S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  D
 ... D SORT(ZT2,ZT3) ;S ^TMP($J,99999-ZT2,99999-$P(ZT2,",",2),ZT3)=""
 S ZT1="" F  S ZT1=$O(^%ZTSCH("LINK",ZT1)) Q:'ZT1  D
 .S ZT2="" F  S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:'ZT2  D
 ..S ZTS=0 F  S ZTS=$O(^%ZTSCH("LINK",ZT1,ZT2,ZTS)) Q:'ZTS  D
 ... D SORT(ZT2,ZTS) ;S ^TMP($J,99999-ZT2,99999-$P(ZT2,",",2),ZTS)=""
 ; BASED ON XUTMQ
 S XU1=""
 F  S XU1=$O(^TMP($J,XU1)) Q:XU1'>0  D
 .S XU2=0
 .F  S XU2=$O(^TMP($J,XU1,XU2)) Q:XU2'>0  D
 ..S XU0=$G(^%ZTSK(XU2,0))
 ..Q:XU0=""
 ..S XUOPT=$P(XU0,"^",9) Q:XUOPT=""
 ..I $D(ZTCHECK(XUOPT)) D
 ...S XURT=$P(XU0,"^",6)
 ...S XUDAY=$ZD($P(XURT,","),3),XUTIME=$ZT($P(XURT,",",2))
 ...S ZTCHECK(XUOPT)=XUDAY_" "_XUTIME
 K ^TMP($J)
 Q
 ;
SORT(ZTDTH,ZTSK) ;
 I ZTDTH["," S ZTDTH=$$H3^%ZTM(ZTDTH)
 S ^TMP($J,ZTDTH,ZTSK)=""
 Q
