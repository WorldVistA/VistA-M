KMPDTU10 ;OAK/RAK - CP Tools Timing Utility ;6/21/05  10:17
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
 ;
DATERNG(KMPDSS,KMPDEF,KMPDRES,KMPDDT) ; timing date range for a subscript
 ;-----------------------------------------------------------------------
 ; KMPDSS.... KMPTMP SUBSCRIPT
 ; KMPDEF.... (optional) default number of days to track - if not defined
 ;            will default to seven (7)
 ; KMPDRES(). Results of api in format:
 ;             KMPDRES(0)=piece 1 - Start Date Internal
 ;                        piece 2 - End Date Internal
 ;                        piece 3 - Start Date External
 ;                        piece 4 - End Date External
 ;                 Null ("") is returned if no results are found
 ;             KMPDRES(1)=NumberOfDays
 ; KMPDDT.... Date only (do not ask for days)
 ;             0 - both date & days
 ;             1 - date only - do not ask for days
 ;
 ; This api determines the date range for KMPDSS (ex: ORWCV for CPRS 
 ; cover sheets).  It asks the user the ending date.  After the ending
 ; date is entered, the user is prompted for the number of days to track.
 ; Results are returned in the KMPDRES() array as described above.
 ;-----------------------------------------------------------------------
 K KMPDRES S KMPDRES(0)="",KMPDRES(1)=""
 Q:$G(KMPDSS)=""
 S:'$G(KMPDEF) KMPDEF=7
 S KMPDDT=+$G(KMPDDT)
 N COUNT,DATE,DAYS,END,SESS,START
 ; start & end dates
 S DATE=$$DATERNG1(KMPDSS,.SESS)
 Q:'$D(SESS)
 S START=$P(DATE,U),END=$P(DATE,U,2)
 Q:'START!('END)
 ; get end date
 K DIR S DIR(0)="DO^"_START_":"_END_":E"
 S DIR("A")="Select End Date",DIR("B")=$$FMTE^XLFDT(END)
 W ! D ^DIR Q:'Y  S END=Y
 ; if date only
 I KMPDDT D  Q
 .S KMPDRES(0)=END_U_END_U_$$FMTE^XLFDT(END)_U_$$FMTE^XLFDT(END)
 ; determine number of days
 S DATE=END+.1,START=END,DAYS=0
 F  S DATE=$O(SESS(DATE),-1) Q:'DATE   S START=DATE,DAYS=DAYS+1
 Q:'DAYS
 ; days to go back
 K DIR S DIR(0)="NO^1:"_DAYS_":O"
 S DIR("A")="Select # of Days Review"
 S DIR("B")=$S(DAYS'<KMPDEF:KMPDEF,1:DAYS)
 D ^DIR Q:Y=""!(Y="^")
 ; determine start date
 S START=END
 I Y'=1 S COUNT=1 D 
 .F  S START=$O(SESS(START),-1) Q:'START  S COUNT=COUNT+1 Q:COUNT'<Y
 S KMPDRES(0)=START_U_END_U_$$FMTE^XLFDT(START)_U_$$FMTE^XLFDT(END)
 S KMPDRES(1)=Y
 ;
 Q
 ;
DATERNG1(KMPDSS,KMPDSESS) ;-- extrinsic function
 ;-----------------------------------------------------------------------
 ; KMPDSS.... KMPTMP SUBSCRIPT
 ; KMPDSESS() Array of dates: 
 ;             KMPDSESS(3030801)=""
 ;             KMPDSESS(3030802)=""
 ;             ...
 ;
 ; Return: StartDate^EndDate - in internal fileman format
 ;         "" - no results
 ;-----------------------------------------------------------------------
 Q:$G(KMPDSS)="" ""
 N DATE,END,START
 ; determine most recent date
 F DATE=0:0 S DATE=$O(^KMPD(8973.2,"ASVDTSS",KMPDSS,DATE)) Q:'DATE  D 
 .; set array of session dates
 .S KMPDSESS(DATE)=""
 Q:'$D(KMPDSESS) ""
 ; set start and end dates according to SESS() array
 S END=$O(KMPDSESS("A"),-1),START=$O(KMPDSESS(""))
 Q START_"^"_END
 ;
DTTMRNG(KMPDSS,KMPDEF,KMPDRES,KMPDEFH) ; timing date/time range for a subscript
 ;-----------------------------------------------------------------------
 ; KMPDSS.... KMPTMP SUBSCRIPT
 ; KMPDEF.... (optional) default number of days to track - if not defined
 ;            will default to seven (7)
 ; KMPDRES(). Results of api in format:
 ;             KMPDRES(0)=piece 1 - Start Date Internal
 ;                        piece 2 - End Date Internal
 ;                        piece 3 - Start Date External
 ;                        piece 4 - End Date External
 ;                 Null ("") is returned if no results are found
 ;             KMPDRES(1)=NumberOfDays
 ; KMPDEFH.. (optional) Default hour.
 ;
 ; This api determines the date range for KMPDSS (ex: ORWCV for CPRS 
 ; cover sheets).  It asks the user the ending date.  After the ending
 ; date is entered, the user is prompted for the number of hours to
 ; review. Results are returned in the KMPDRES() array as described 
 ; above.
 ;-----------------------------------------------------------------------
 K KMPDRES S KMPDRES(0)="",KMPDRES(1)=""
 Q:$G(KMPDSS)=""
 S:'$G(KMPDEF) KMPDEF=7
 S KMPDEFH=$G(KMPDEFH)
 N COUNT,DATE,DAYS,END,SESS,START
 ; get date
 D DATERNG(KMPDSS,1,.KMPDRES,1)
 Q:'$D(KMPDRES)
 Q:$G(KMPDRES(0))=""
 S KMPDRES(1)=""
 ; determine number of hours
 K DIR S DIR(0)="LO^0:23:O"
 S DIR("A")="Select Hour(s) to Review"
 S:KMPDEFH'="" DIR("B")=KMPDEFH
 D ^DIR Q:Y=""!(Y="^")
 S KMPDRES(1)=Y
 Q
 ;
LISTSEL(KMPDLIST,KMPDSS,KMPDRLTM) ;-- extrinsic function - build list and select entry
 ;-----------------------------------------------------------------------
 ; KMPDLIST... 2 - Client Name
 ;             3 - IP Address
 ; KMPDSS..... Field #.07 (KMPTMP SUBSCRIPT)
 ; KMPDRLTM... Real-Time data
 ;              0 - not real-time
 ;              1 - real-time
 ;
 ; Return: "" - no selection 
 ;         Name - free text
 ;
 ; This function will build a list of entries from file #8973.2 
 ;(CP TIMING) and ask the user to select an entry.
 ;-----------------------------------------------------------------------
 S KMPDLIST=+$G(KMPDLIST)
 Q:KMPDLIST<2!(KMPDLIST>3) ""
 Q:$G(KMPDSS)="" ""
 S KMPDRLTM=+$G(KMPDRLTM)
 ;
 N DIC,I,X,XREF,Y
 ;
 W " ==> building list..."
 K ^TMP("KMPDTU10-LIST",$J)
 D @$S('KMPDRLTM:"LISTSELH",1:"LISTSELR")
 ; quit if no data
 Q:'$D(^TMP("KMPDTU10-LIST",$J))
 S DIC="^TMP(""KMPDTU10-LIST"",$J,"
 S DIC(0)="AEQZ"
 S DIC("A")=$S(KMPDLIST=2:"Select Client",1:"IP Address")_": "
 D ^DIC
 K ^TMP("KMPDTU10-LIST",$J)
 Q $S(Y<1:"",1:$P(Y,"^",2))
 ;
LISTSELH ;-- historical data list
 N I,CNT,DOT,XREF
 ; determine xref to build list
 S XREF=$S(KMPDLIST=2:"ASSCLDTTM",KMPDLIST=3:"ASSIPDTTM",1:"")
 S I="",(CNT,DOT)=0
 F  S I=$O(^KMPD(8973.2,XREF,KMPDSS,I)) Q:I=""  D 
 .S CNT=CNT+1,DOT=DOT+1 W:'(DOT#100) "."
 .S ^TMP("KMPDTU10-LIST",$J,CNT,0)=I
 .S ^TMP("KMPDTU10-LIST",$J,"B",I,CNT)=""
 S ^TMP("KMPDTU10-LIST",$J,0)=$S(KMPDLIST=2:"Client Name",1:"IP Address")_"^1.01^"_CNT_"^"_CNT
 Q
 ;
LISTSELR ;-- real-time data list
 N I,CNT,DATA,DOT,X
 S I="",(CNT,DOT)=0
 F  S I=$O(^KMPTMP("KMPDT",KMPDSS,I)) Q:I=""  S DATA=^(I) I DATA]"" D 
 .S X=$S(KMPDLIST=2:$P(DATA,U,4),1:$P($P(I," ",2),"-"))
 .Q:$O(^TMP("KMPDTU10-LIST",$J,"B",X,0))
 .S CNT=CNT+1,DOT=DOT+1 W:'(DOT#100) "."
 .S ^TMP("KMPDTU10-LIST",$J,CNT,0)=X
 .S ^TMP("KMPDTU10-LIST",$J,"B",X,CNT)=""
 S ^TMP("KMPDTU10-LIST",$J,0)=$S(KMPDLIST=2:"Client Name",1:"IP Address")_"^1.01^"_CNT_"^"_CNT
 Q
 ;
SRCHBY(KMPDRES,KMPDSS,KMPDRLTM) ;-- api - search by criteria
 ;-----------------------------------------------------------------------
 ; KMPDRES().. Array (passed by reference) containing results in format:
 ;             KMPDRES    = "" - no valid selection
 ;             KMPDRES    = 1^User Name
 ;             KMPDRES(1) = DUZ^NewPersonName
 ;             KMPDRES    = 2^Client Name
 ;             KMPDRES(1) = ClientName (free text)
 ;             KMPDRES    = 3^IP Address
 ;             KMPDRES(1) = IPAddress
 ;             KMPDRES    = 4^Any Occurrence
 ; KMPDSS..... KMPTMP SUBSCIPT - field #.07 from file #8973.2 (CP TIMING)
 ; KMPDRLTM... Real-Time data
 ;              0 - not real-time
 ;              1 - real-time
 ;-----------------------------------------------------------------------
 K KMPDRES S KMPDRES=""
 Q:$G(KMPDSS)=""
 S KMPDRLTM=+$G(KMPDRLTM)
 N DIC,DIR,X,Y
 S DIR(0)="SO^1:User Name;2:Client Name;3:IP Address;4:All of the Above"
 S DIR("A")="Search By"
 S DIR("B")=4
 D ^DIR
 Q:'Y
 S KMPDRES=Y_"^"_Y(0)
 ; quit if 'all of the above'
 Q:(+KMPDRES)=4
 ;
 ; user name
 I (+KMPDRES)=1 D  Q
 .S DIC=200,DIC(0)="AEMQZ",DIC("A")="Select User: "
 .D ^DIC
 .I Y<1 S KMPDRES="" Q
 .S KMPDRES(1)=Y
 ;
 ; client name
 I (+KMPDRES)=2 D  Q
 .S KMPDRES(1)=$$LISTSEL(+KMPDRES,KMPDSS,KMPDRLTM)
 .S:KMPDRES(1)="" KMPDRES=""
 ;
 ; ip address
 I (+KMPDRES)=3 D  Q
 .S KMPDRES(1)=$$LISTSEL(+KMPDRES,KMPDSS,KMPDRLTM)
 .S:KMPDRES(1)="" KMPDRES=""
 ;
 Q
 ;
TTLSEC() ;-- extrinsic function - time-to-load threshold seconds
 ;-----------------------------------------------------------------------
 ;-----------------------------------------------------------------------
 N DIR,X,Y
 S DIR(0)="NAO^1"
 S DIR("A")="Select Time-To-Load Threshold (Seconds): "
 S DIR("B")=60
 D ^DIR
 Q $S(Y:Y,1:"")
