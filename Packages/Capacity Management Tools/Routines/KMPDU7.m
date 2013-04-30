KMPDU7 ;OAK/RAK - CM Tools Routine Utilities ;7/22/04  09:06
 ;;3.0;KMPD;;Jan 22, 2009;Build 42
 ;
 ;
SBLIST(KMPDY,KMPDLIST,KMPDSS,KMPDGBL) ;-- rpc search by list
 ;-------------------------------------------------------------------
 ; KMPDY()... return array (see LISTSEL^KMPDTU10 for details)
 ; KMPDLIST.. search by list
 ;             2 - client name
 ;             3 - ip address
 ; KMPDSS.... free text - timing monitor subscript
 ; KMPDGBL... global name to store results
 ;-------------------------------------------------------------------
 ;
 K KMPDY
 S KMPDLIST=+$G(KMPDLIST),KMPDSS=$G(KMPDSS)
 I (KMPDLIST<2)!(KMPDLIST>3) S KMPDY(0)="[Search By entry is invalid]" Q
 I KMPDSS="" S KMPDY(0)="[Subscript is null]" Q
 ;
 N I
 ;
 K ^TMP("KMPDTU10-LIST",$J)
 D:KMPDLIST=2 LISTSELR^KMPDTU10
 D:KMPDLIST=3 LISTSELH^KMPDTU10
 I '$O(^TMP("KMPDTU10-LIST",$J,0)) S KMPDY(0)="<No Data to Report>" Q
 ;
 F I=0:0 S I=$O(^TMP("KMPDTU10-LIST",$J,I)) Q:'I  D 
 .S @KMPDGBL@(I)=$G(^TMP("KMPDTU10-LIST",$J,I,0))
 ;
 S KMPDY=$NA(@KMPDGBL)
 ;
 Q
 ;
TMGDATES(KMPDY,KMPDSS) ;-- rpc timing date ranges
 ;-------------------------------------------------------------------
 ; KMPDY()... return value
 ;             KMPDY(0)=FMStartDate^FMEndDate^ExtStartDate^ExtEndDate
 ;             KMPDY(1)=FMDate^ExtDate
 ;             KMPDY(2)=FMDate^ExtDate
 ;             KMPDY(...)=...
 ; KMPDSS.... timing subscript
 ;-------------------------------------------------------------------
 ;
 K KMPDY
 ;
 I $G(KMPDSS)="" S KMPDY(0)="[Timing Subscript is not defined]" Q
 ;
 N DATE,I,LN,SESSION
 ;
 S DATE=$$DATERNG1^KMPDTU10(KMPDSS,.SESSION)
 I 'DATE S KMPDY(0)="<There are no Timing Monitor Dates available>" Q
 S $P(KMPDY(0),U)=$P(DATE,U)
 S $P(KMPDY(0),U,2)=$$FMTE^XLFDT($P(DATE,U))
 S $P(KMPDY(0),U,3)=$P(DATE,U,2)
 S $P(KMPDY(0),U,4)=$$FMTE^XLFDT($P(DATE,U,2))
 S (I,LN)=0
 F  S I=$O(SESSION(I)) Q:'I  D 
 .S LN=LN+1
 .S KMPDY(LN)=I_"^"_$$FMTE^XLFDT(I)
 ;
 ;
 Q
 ;
TMGMON(KMPDY,KMPDSTM) ;-- timing monitor data
 ;-------------------------------------------------------------------
 ; remote procedure: KMPD TMG MON DATA
 ; 
 ; KMPDY()... return value: 
 ;            KMPDY(0)= ^piece 1: Last Updated
 ;                       piece 2: Running Time
 ;                       piece 3: Update Minutes
 ;                       piece 4: alert seconds
 ;                       piece 5: start time
 ;            KMPDY(...) Hour^AverageDeltaSeconds^AverageCount
 ;            
 ; KMPDSTM... monitor start time in internal fileman format. if not
 ;            defined this will be set as NOW.               
 ;-------------------------------------------------------------------
 ;
 K KMPDY
 ;
 S:'$G(KMPDSTM) KMPDSTM=$$NOW^XLFDT
 ;
 N DATA,I,KMPUTIME,KMPUTMP,LN,NOW
 ;
 D DATA^KMPDTM
 I '$D(KMPUTMP) S KMPDY(0)="<No Timing Monitor Data to Report>" Q
 ;
 S NOW=$$NOW^XLFDT
 S DATA=$G(^KMPD(8973,1,19))
 ; zero node: LastUpdated^RunningTime^UpdateMinutes^AlertSeconds
 S $P(KMPDY(0),U)=$P($$FMTE^XLFDT(NOW),"@",2)
 S $P(KMPDY(0),U,2)=$$FMDIFF^XLFDT(NOW,KMPDSTM,3)
 S $P(KMPDY(0),U,3)=$S($P(DATA,U):$P(DATA,U),1:10)
 S $P(KMPDY(0),U,4)=$S($P(DATA,U,2):$P(DATA,U,2),1:30)
 S $P(KMPDY(0),U,5)=KMPDSTM
 ; 
 S LN=0
 F I=0:0 S I=$O(KMPUTMP(I)) Q:'I  D 
 .S LN=LN+1,KMPDY(LN)=$G(KMPUTMP(I,0))
 ;
 Q
 ;
TMGRPT(KMPDY,KMPDRPT,KMPDTM,KMPDATE,KMPDSRCH,KMPDTSEC,KMPDHOUR) ;-- rpc - timing reports
 ;-------------------------------------------------------------------
 ; KMPDY()... array containing report
 ; KMPDRPT... report name (free text)
 ; KMPDTM.... time frame - prime time or non-prime time
 ; KMPDATE... date (fileman format)
 ; KMPDSRCH.. ttl search text
 ;              1: User Name
 ;              2: Client Name
 ;              3: IP Address
 ;              4: All Items
 ; KMPDTSEC.. seconds
 ; KMPDTHR... hour
 ;-------------------------------------------------------------------
 ;
 K KMPDY
 ;
 S KMPDRPT=$G(KMPDRPT)
 I KMPDRPT="" S KMPDY(0)="[There is no Report Name]" Q
 S KMPDTM=$G(KMPDTM)
 I KMPDTM="" S KMPDY(0)="[There is no Time Frame]" Q
 I '$D(KMPDATE) S KMPDY(0)="[There is no Ending Date]" Q
 ;
 N DATA,DATE,HR,I,KMPDPTNP,LN
 ;
 K ^TMP($J)
 ;
 I KMPDRPT="TMG - Average Daily Coversheet Load" D ADCL^KMPDU7A
 I KMPDRPT="TMG - Average Hourly Coversheet Load" D AHCR^KMPDU7A
 I KMPDRPT="TMG - Coversheet TTL Alert Report" D CTTLAR^KMPDU7A
 I KMPDRPT="TMG - Daily Coversheet TTL Detailed Report" D DCTTLDR^KMPDU7A
 I KMPDRPT="TMG - Hourly Coversheet TTL Detailed Report" D HCTTLDR^KMPDU7A
 I KMPDRPT="TMG - Real-Time Average Hourly Coversheet Load" D RTAHCL^KMPDU7A
 I KMPDRPT="TMG - Real-Time Threshold Alert" D RTTA^KMPDU7A
 ;
 S:'$D(KMPDY) KMPDY(0)="<No Data to Report>"
 ;
 Q
 ;
TMGSST(KMPDY,KMPDSST) ;-- rpc - start/stop timing monitor
 ;-------------------------------------------------------------------
 ; KMPDY()... array containing timing monitor status
 ;            0 - timing monitor is off
 ;            1 - timing monitor is on
 ; KMPSST.... start/stop
 ;            0 - stop timing monitor
 ;            1 - start timing monitor
 ;-------------------------------------------------------------------
 ;
 S KMPDSST=+$G(KMPDSST)
 S:KMPDSST>1 KMPDSST=1
 S ^KMPTMP("KMPD-CPRS")=KMPDSST
 S KMPDY(0)=KMPDSST
 Q
 ;
TMGSTAT(KMPDY) ;-- rpc - timing monitor status
 ;-------------------------------------------------------------------
 ; KMPDY()... array containing timing monitor status
 ;            0 - timing monitor is off
 ;            1 - timing monitor is on
 ;-------------------------------------------------------------------
 ;
 S KMPDY(0)=$G(^KMPTMP("KMPD-CPRS"))
 ;
 Q
