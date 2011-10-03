SDPMHLS ;BPFO/JRC -Build ROU-R01 HL7 message for 'SD ENC PERF MON' application ; 4/2/04 7:12am [5/12/04 10:29am]
 ;;5.3;Scheduling;**313,371,416**;AUG 13, 1993
 ;
QUE ;Queue retroactive XMIT job
 ;Declare variables
 S (STDT,EDT,Y,X)=""
 ;Prompt user for month and year
 S %DT("A")="Please select MONTH and YEAR for TIU's National Rollup to transmit: "
 S %DT="AEMX"
 ;Set %DT not to allow current and future months
 S %DT(0)=-($$FMADD^XLFDT($$NOW^XLFDT(),-32))
 D ^%DT
 ;Check date input if (-1) quit else continue
 I Y<0 Q
 ;Set STDT = user selected month and year and add 1 day
 S STDT=Y+01
 ;Add 32 days to STDT
 S X=$$FMADD^XLFDT(STDT,32)
 ;Subtract number of days that overlap into the following month
 S EDT=$$FMADD^XLFDT(X,-($E(X,6,7)))
 ;Set task variables
 S ZTIO=""
 S ZTDESC="Performance Indicator National Rollup"
 S ZTRTN="EN^SDPMHLS"
 S ZTSAVE("STDT")=""
 S ZTSAVE("EDT")=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 K STDT,EDT,X,Y,%DT,%DT("A"),%DT(0)
 Q
EN ;Entry point
 ;Note: Retroactive reports use variables STDT and EDT to pass dates
 ;   STDT - start date, first day of the month for selected month
 ;   EDT - ending date, last day of the month for selected month
 ;Declare variables
 N STDATE,ENDDATE
 N XMTARRY,SCRNARR,SORTARR,OUTARR,X,RDATE
 S SCRNARR="^TMP(""SCRPW"",$J,""SCRNARR"")"
 S SORTARR="^TMP(""SCRPW"",$J,""SORTARR"")"
 S OUTARR="^TMP(""SCRPW"",$J,""OUTARR"")"
 S XMTARRY="^TMP(""HLS"","_$J_")"
 S (STDATE,ENDDATE)=""
 ;Set national screen/sort
 D ROLLUP^SCRPW303(SCRNARR,SORTARR)
 ;Call module to build scratch global
 D GETINFO
 ;Build HL7 Message
 D BLDMSG(OUTARR,XMTARRY)
 ;Send HL7 Message
 I +$O(@XMTARRY@(""))>0 D
 .S J=$$SENDMSG(.XMTARRY)
 ;Send XMIT notifications
 D MSG
 ;Cleanup an quit
 D EXIT
 Q
BLDMSG(OUTARR,XMTARRY) ;Build OBR segment
 ;Input : OUTARR - Ouptut array 
 ;Output: XMTARRY - HL7 temporary array
 ;Declare variables
 N HL,HLFS,HLECH,HLQ,SNODE,PNODE,DIVHL,TYPE,COUNT
 D INIT^HLFNC2("SD ENC PERF MON ORU-R01 SERVER",.HL)
 Q:$O(HL(""))=""
 N VAFEVN,VAFSTR,CNT,MAKE,VAFOBR,VAFOBX,I,XCNT,INFO,DIV,DIVHL
 S CNT=1,XCNT=0
 S MAKE(1)="1"
 S MAKE(4,1,1)="01"
 S MAKE(4,1,2)="VA ENC PERF MONITOR"
 S MAKE(7)=$$HLDATE^HLFNC(RDATE)
 S MAKE(25)="F"
 S MAKE(27,1,4)=$$HLDATE^HLFNC(STDATE,"DT")
 S MAKE(27,1,5)=$$HLDATE^HLFNC(ENDDATE,"DT")
 K VAFOBR
 D MAKEIT^VAFHLU("OBR",.MAKE,.VAFOBR,.VAFOBR)
 M @XMTARRY@(CNT)=VAFOBR
 S XCNT=XCNT+1,CNT=CNT+1
 ;Build OBX segment for facility
 S SNODE=$G(@OUTARR@("SUMMARY"))
 S PNODE=$G(@OUTARR@("SUMMARY","PI"))
 S DIVHL=$P($$SITE^VASITE,"^",3)
 D MAKEOBX
 ;Build OBX segment for division(s)
 S DIV="" F  S DIV=$O(@OUTARR@("SUBTOTAL",DIV)) Q:DIV=""  D
 .N SNODE,PNODE
 .S SNODE=$G(@OUTARR@("SUBTOTAL",DIV))
 .S PNODE=$G(@OUTARR@("SUBTOTAL",DIV,"PI"))
 .S DIVHL=$P(DIV,"^",2)
 .D MAKEOBX
 .Q
 Q
MAKEOBX ;Set type and count for total encounters to bld OBX
 ;Input : SNODE - Temporary counter node for summary
 ;        PNODE - Temporary counter node for PI
 ;        DIVHL - Division and Suffix
 ;        CNT - Temporary array subscript count
 ;        XCNT  - OBX segment counter
 ;        XMTARRY - Temporary HL array ^TMP("HLS",$J)
 S TYPE="CD",COUNT=$P($G(SNODE),U,1),OBID=1 D BLDOBX
 ;Set type and count for counters for ET in days F0 - F10 to bld OBX
 F M4=0:1:10 D
 .S OBID=2
 .S TYPE="F"_M4
 .S COUNT=$P($G(PNODE),U,(M4+1))
 .D BLDOBX
 ;Set type and count for scanned notes and Uniques to bld OBX
 S TYPE="FSPN",OBID=2,COUNT=$P($G(SNODE),U,7) D BLDOBX
 S TYPE="FEP",OBID=2,COUNT=$P($G(SNODE),U,4) D BLDOBX
 S TYPE="FDSS",OBID=2,COUNT=$P($G(SNODE),U,5) D BLDOBX
 ;Set types and count for encounters w/o progress notes and
 ;encounters w/progress notes pending signatures
 S TYPE="FNPN",OBID=2,COUNT=+$P(SNODE,U,1)-(+($P(SNODE,U,2)))-(+($P(SNODE,U,9)))-(+($P(SNODE,U,7)))-(+($P(PNODE,U,11))) D BLDOBX
 S TYPE="FNPS",OBID=2,COUNT=$P($G(SNODE),U,9) D BLDOBX
 Q
BLDOBX ;Build OBX
 ;Ouput : @XMTARRY = Temporary HL array
 ;Set variables
 N MAKE,VAFOBX
 S MAKE(1)=XCNT
 S MAKE(2)="NM"
 S MAKE(3,1,1)=OBID
 S MAKE(3,1,4)=TYPE
 S MAKE(5)=COUNT
 S MAKE(11)="F"
 S MAKE(15)=DIVHL
 K VAFOBX
 D MAKEIT^VAFHLU("OBX",.MAKE,.VAFOBX,.VAFOBX)
 M @XMTARRY@(CNT)=VAFOBX
 S XCNT=XCNT+1,CNT=CNT+1
 Q
SENDMSG(XMTARRY) ;Send HL7 message
 ;Input - @XMTARRY
 ;Output - ARRY4HL7
 N ARRY4HL7,KILLARRY,HL,HLRESLT,HLFS,HLECH,HLQ,HLP
 S XMTARRY=$G(XMTARRY)
 S:'(XMTARRY]"") XMTARRY="^TMP(""HLS"","_$J_")"
 Q:($O(@XMTARRY@(""))="") "-1^Can not send empty message"
 S ARRY4HL7="TMP(""HLS"","_$J_")"
 ;Initialize HL7 variables
 D INIT^HLFNC2("SD ENC PERF MON ORU-R01 SERVER",.HL)
 Q:($O(HL(""))="") "-1^Unable to initialize HL7 variables"
 ;Check if XMTARRY is ^TMP("HLS",$J)
 S KILLARRY=0
 I $NA(@XMTARRY)'=$NA(@ARRY4HL7) D
 .K @ARRY4HL7
 .M @ARRY4HL7=@XMTARRY
 .S KILLARRY=1
 ;Broadcast message
 D GENERATE^HLMA("SD ENC PERF MON ORU-R01 SERVER","GM",1,.HLRESLT,"",.HLP)
 S:('HLRESLT) HLRESLT=$P(HLRESLT,"^",2,3)
 ;Delete ^TMP("HLS",$J) if XMTARRY was different
 K:(KILLARRY) @ARRY4HL7
 Q $G(HLRESLT)
GETINFO ;Get performance monitor data
 ;Input:
 ;    @SCRNARR - Screen array full global reference
 ;    @SORTARR - Sort array full global reference
 ;Output:
 ;    @OUTARR - Ouput array full global reference 
 ;Remember starting time
 S RDATE=$$NOW^XLFDT()
 ;Check STDT and EDT, if 1 set STDATE and ENDDATE
 I $D(STDT)&$D(EDT) S STDATE=STDT,ENDDATE=EDT
 I STDATE="" D
 .;Set start date = 1st day of previous month
 .N X,X1,X2
 .S X1=$$DT^XLFDT(),X2=-30 S:$E(X1,6,7)=31 X2=-31
 .D C^%DTC
 .S STDATE=$E(X,1,5)_"01"
 .;Set end date = start date + 32 minus number of days into next month
 .S X=$$FMADD^XLFDT(STDATE,32)
 .S ENDDATE=$$FMADD^XLFDT(X,-($E(X,6,7)))
 .Q
 ;Set date range in screen array
 S @SCRNARR@("RANGE")=STDATE_"^"_ENDDATE
 ;Get data
 D GETDATA^SDPMUT1(SCRNARR,SORTARR,OUTARR)
 Q
MSG ;Build bulletin and send
 ;Input:
 ;     RDATE - report starting time
 ;Output: 
 ;   Notificaion bulletin to SD ENC PERF MON mail group
 N MSGTEXT,XMTEXT,XMSUB,XMY,XMCHAN,XMZ,XMDUZ
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="Performance Indicator National Rollup was started on "_$$FMTE^XLFDT(RDATE,1)
 S MSGTEXT(3)="Encounter date range: "_$$FMTE^XLFDT(STDATE,1)_" to "_$$FMTE^XLFDT(ENDDATE,1)
 S MSGTEXT(3)="Extraction of data and sending of data completed "_$$FMTE^XLFDT($$NOW^XLFDT(),1)
 S MSGTEXT(4)=" "
 ;Send completion bulletin to current user
 S XMSUB="Performance Indicator National Rollup"
 S XMTEXT="MSGTEXT("
 S XMY("G.SD PM NOTIFICATION TIU")=""
 S XMCHAN=1
 S XMDUZ="Performance Indicator"
 D ^XMD
 Q
EXIT ;Done
 K @SCRNARR,@SORTARR,@OUTARR,@XMTARRY
 Q
