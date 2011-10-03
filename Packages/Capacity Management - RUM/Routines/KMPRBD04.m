KMPRBD04 ;OAK/RAK - RUM Data Compression ;5/28/03  08:45
 ;;2.0;CAPACITY MANAGEMENT - RUM;;May 28, 2003
 ;
 ; Background Driver (cont.)
 ;
WEEKLY(KMPRDT) ;-- compress daily stats to weekly
 ;-----------------------------------------------------------------------
 ; KMPRDT... Compression date in internal fileman formt.  This date
 ;           must be a Sunday.  It represents the date from which the
 ;           previous weeks data should be compressed. 
 ;           Example: if KMPRDT = 2981011  then compression will begin
 ;                    on 2981010 (KMPRDT-1)
 ;
 ; Every Sunday compress the daily stats in file #8971.1 into weekly
 ; and upload the data to the CM RUM National Database
 ;
 ; ^TMP($J)............. temporary storage for RUM data
 ; ^TMP("KMPR PROC",$J). entries that have been processed and will be
 ;                        updated as 'send to national dabase'
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPRDT)
 ;
 N DATA,DATE,DELDATE,END,HOURS,I,IEN,J,NODE,OPTION,SITE,START
 ;
 ; quit if not sunday
 Q:$$DOW^XLFDT(KMPRDT,1)
 ;
 K ^TMP($J),^TMP("KMPR PROC",$J)
 ;
 ; site info
 S SITE=$$SITE^VASITE Q:SITE=""
 ;
 S DATE=KMPRDT
 S (START,END)=""
 ;
 ; date to begin deletion
 S DELDATE=$$FMADD^XLFDT(KMPRDT,-14)
 ;
 W:'$D(ZTQUEUED) !,"Compressing data into weekly format..."
 ; reverse $order to get previous dates
 F  S DATE=$O(^KMPR(8971.1,"B",DATE),-1) Q:'DATE  D 
 .; if DATE is saturday set START and END dates and kill ^TMP($J)
 .I $$DOW^XLFDT(DATE,1)=6 D 
 ..S END=DATE,START=$$FMADD^XLFDT(DATE,-6)
 ..K ^TMP($J)
 .Q:'START
 .S IEN=0
 .F  S IEN=$O(^KMPR(8971.1,"B",DATE,IEN)) Q:'IEN  D
 ..;
 ..Q:'$D(^KMPR(8971.1,IEN,0))
 ..;
 ..; data nodes into DATA() array
 ..S DATA(0)=^KMPR(8971.1,IEN,0),DATA(1)=$G(^(1)),DATA(1.1)=$G(^(1.1)),DATA(1.2)=$G(^(1.2)),DATA(2)=$G(^(2)),DATA(2.1)=$G(^(2.1)),DATA(2.2)=$G(^(2.2)),DATA(3)=$G(^(3))
 ..;
 ..; quit if data has already been sent to national database
 ..Q:$P(DATA(0),U,2)
 ..;
 ..; cpu node
 ..S NODE=$P(DATA(0),U,3) Q:NODE=""
 ..;
 ..; option
 ..S OPTION=$P(DATA(0),U,4)
 ..; rpc
 ..S:OPTION="" OPTION=$P(DATA(0),U,7)
 ..; hl7
 ..S:OPTION="" OPTION=$P(DATA(0),U,9)
 ..;
 ..Q:OPTION=""
 ..;
 ..; OPTION = OptionName^ProtocolName
 ..S $P(OPTION,U,2)=$P(DATA(0),U,5)
 ..;
 ..S ^TMP($J,START,NODE,OPTION,0)=DATA(0)
 ..; change first piece to starting date (START)
 ..S $P(^TMP($J,START,NODE,OPTION,0),U)=START
 ..; second piece not applicable to national database
 ..S $P(^TMP($J,START,NODE,OPTION,0),U,2)=""
 ..; EndingDate^SiteName^SiteNumber
 ..S ^TMP($J,START,NODE,OPTION,99)=END_U_$P(SITE,U,2)_U_$P(SITE,U,3)
 ..;
 ..; add data to get weekly totals
 ..F I=1,1.1,1.2,2,2.1,2.2,3 I DATA(I)]"" D 
 ...; if subscript 1 or 2 or 3 ('I#1) add pieces 1 - 8
 ...; else add pieces 1 - 24
 ...F J=1:1:$S('(I#1):8,1:24) D 
 ....S $P(^TMP($J,START,NODE,OPTION,I),U,J)=$P($G(^TMP($J,START,NODE,OPTION,I)),U,J)+$P(DATA(I),U,J)
 ....; update "HOURS" subscript
 ....S:(I#1)&($P(DATA(I),U,J)) $P(^KMPTMP("KMPR","HOURS",DATE,NODE),U,J)=1
 ..;
 ..; back to IEN level
 ..; add to processed array
 ..S ^TMP("KMPR PROC",$J,IEN)=""
 .;
 .; back to DATE level
 .; if START then transmit data
 .I DATE=START I $D(^TMP($J)) D TRANSMIT K ^TMP($J)
 ;
 ; transmit data to national database
 W:'$D(ZTQUEUED) !,"Transmitting data to national database..."
 D:$D(^TMP($J)) TRANSMIT
 K ^TMP($J)
 ;
 ; update field .02 (SENT TO CM NATIONAL DATABASE) to 'YES' for all
 ; processed entries
 W:'$D(ZTQUEUED) !,"Updating records to reflect transmission..."
 S IEN=0
 F  S IEN=$O(^TMP("KMPR PROC",$J,IEN)) Q:'IEN  D 
 .K FDA,ERROR
 .S FDA($J,8971.1,IEN_",",.02)=1
 .D FILE^DIE("","FDA($J)","ERROR")
 K ^TMP("KMPR PROC",$J)
 ;
 ; leave two complete weeks of data in file #8971.1
 D PURGE^KMPRUTL3(DELDATE,1)
 ;
 Q
 ;
TRANSMIT ;-- format ^TMP($J) data, put into e-mail and send to cm.
 ;
 Q:'$D(^TMP($J))
 ;
 N HRSDAYS,I,IEN,LN,N,O,S,XMSUB,X,XMTEXT,XMY,XMZ,Y,Z
 ;
 K ^TMP("KMPRBD04-3",$J)
 ;
 S LN=1
 ; version and patch info and weekly background info
 S Z=$G(^KMPTMP("KMPR","BACKGROUND","WEEKLY","TOTAL","START"))_"^"_$G(^("STOP"))_"^"_$G(^("DELTA"))
 S ^TMP("KMPRBD04-3",$J,LN)="VERSION="_$$VERSION^KMPRUTL_"^"_Z
 ;
 ; get system information
 S LN=LN+1
 S ^TMP("KMPRBD04-3",$J,LN)="SYSINFO="_$$SYSINFO^KMPDUTL1()
 ;
 ; get number of days/hours data for the specified date range
 D HRSDAYS^KMPRUTL3(START,END,1,.HRSDAYS)
 ;
 ; if ^KMPTMP("KMPR","HOURS","START") exists then this is the first time
 ; the "HOURS" subscript is being accessed.  chances are this is only
 ; partial data, so it should be ignored.
 I $G(^KMPTMP("KMPR","HOURS","START"))&($D(HRSDAYS)) D 
 .K HRSDAYS,^KMPTMP("KMPR","HOURS","START")
 ;
 I $D(HRSDAYS) S S=0 D 
 .F  S S=$O(HRSDAYS(S)) Q:'S  S N="" D 
 ..F  S N=$O(HRSDAYS(S,N)) Q:N=""  D 
 ...S LN=LN+1
 ...; StartDate^Node^EndDate^PTDays^PTHours^NPTDays^NPTHours
 ...; ... ^WDDays^WDHours^NWDays^NWHours
 ...S ^TMP("KMPRBD04-3",$J,LN)="HRSDAYS="_START_"^"_N_"^"_END_"^"_HRSDAYS(S,N)
 ;
 ; reformat so that data is in ^TMP("KMPR UPLOAD",$J,LN)= format.
 S IEN=0,S=""
 F  S S=$O(^TMP($J,S)) Q:S=""  S N="" D 
 .F  S N=$O(^TMP($J,S,N)) Q:N=""  S O="" D 
 ..F  S O=$O(^TMP($J,S,N,O)) Q:O=""  S I="",IEN=IEN+1 D 
 ...F  S I=$O(^TMP($J,S,N,O,I)) Q:I=""  D 
 ....S LN=LN+1
 ....S ^TMP("KMPRBD04-3",$J,LN)=IEN_","_I_")="_^TMP($J,S,N,O,I)
 ;
 ; quit if no data to transmit.
 Q:'$D(^TMP("KMPRBD04-3",$J))
 ; send packman message.
 S XMTEXT="^TMP(""KMPRBD04-3"","_$J_","
 S XMSUB="RUM DATA~"_$P(SITE,U,2)_" ("_$P(SITE,U,3)_")~"_$$FMTE^XLFDT(START)_"~"_$P($$VERSION^KMPRUTL,U)
 S XMY("S.KMP2-RUM-SERVER@FO-ALBANY.MED.VA.GOV")=""
 S XMY("CAPACITY,MANAGEMENT@FO-ALBANY.MED.VA.GOV")=""
 D ^XMD
 W:'$D(ZTQUEUED) !,"Message #",$G(XMZ)," sent..."
 K ^TMP("KMPRBD04-3",$J)
 ;
 Q
