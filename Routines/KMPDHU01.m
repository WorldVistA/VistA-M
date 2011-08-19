KMPDHU01 ;OAK/RAK - CM Tools HL7 Utility ;6/21/05  10:12
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
 ;
WEEKLY(KMPDT,KMPDPRGE) ;-- compress daily stats to weekly
 ;-----------------------------------------------------------------------
 ; KMPDT.... Compression date in internal fileman formt.  This date
 ;           must be a Sunday.  It represents the date from which the
 ;           previous weeks data should be compressed. 
 ;           Example: if KMPDT = 2981011  then compression will begin
 ;                    on 2981010 (KMPDT-1)
 ; KMPDPRGE. 0 - do not purge data from file #8973.1
 ;           1 - purge data from file #8973.1
 ;
 ; Every Sunday compress the daily stats in file #8973.1 into weekly
 ; and upload the data to the CM RUM National Database
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPDT)
 S KMPDPRGE=+$G(KMPDPRGE)
 ;
 N DATA,DATE,DDLDT,DELDATE,EN,END,HOURS,I,IEN,J,NM,PT,SITE,STR,START,SYNC
 ;
 ; quit if not sunday.
 Q:$$DOW^XLFDT(KMPDT,1)
 ; storage  processed
 K ^TMP($J),^TMP("KMPDHU01",$J)
 ; site info.
 S SITE=$$SITE^VASITE Q:SITE=""
 S DATE=KMPDT
 S (START,END)="",STR=$$NOW^XLFDT
 ; days to keep - this is represented by 'weeks to keep' in file #8973 
 ; so must be converted to days
 S DDLDT=$P($G(^KMPD(8973,1,3)),U,11)*7
 S:'DDLDT DDLDT=14
 ; Date to begin deletion.
 S DELDATE=$$FMADD^XLFDT(KMPDT,-DDLDT)
 ;
 W:'$D(ZTQUEUED) !,"Compressing data into weekly format..."
 ; Reverse $order to get previous dates.
 F  S DATE=$O(^KMPD(8973.1,"B",DATE),-1) Q:'DATE  D 
 .; If DATE is saturday set START and END dates and kill TMPARRY.
 .I $$DOW^XLFDT(DATE,1)=6 D 
 ..S END=DATE,START=$$FMADD^XLFDT(DATE,-6)
 ..K ^TMP($J)
 .Q:'START
 .S SYNC=0
 .F  S SYNC=$O(^KMPD(8973.1,"ASYNC",DATE,SYNC)) Q:'SYNC  S IEN=0 D 
 ..F  S IEN=$O(^KMPD(8973.1,"ASYNC",DATE,SYNC,IEN)) Q:'IEN  D 
 ...Q:'$D(^KMPD(8973.1,IEN,0))
 ...; data nodes into DATA() array.
 ...S DATA(0)=^KMPD(8973.1,IEN,0) F I=1,1.1,1.2,2,2.1,2.2,5.1:.1:5.5,5.7,5.8,5.9,99,99.2,99.3,99.5 S DATA(I)=$G(^(I))
 ...; quit if data has already been sent to national database
 ...Q:$P(DATA(0),U,2)
 ...; quit if no namespace or protocol
 ...S NM=$P(DATA(0),U,3),PT=$P(DATA(0),U,5) Q:NM=""!(PT="")
 ...; change first piece to start date (this is for national database)
 ...S $P(DATA(0),U)=START
 ...; second piece not applicable to national database
 ...S $P(DATA(0),U,2)=""
 ...D @$S(SYNC=2:"ASYNC(IEN,NM,PT,.DATA)",1:"SYNC(IEN,NM,PT,.DATA)")
 ...; add to processed array.
 ...S ^TMP("KMPDHU01",$J,IEN)=""
 .;
 .; Back to DATE level.
 .; If START then transmit data.
 .I DATE=START I $D(^TMP($J)) D TRANSMIT K ^TMP($J)
 ;
 D:$D(^TMP($J)) TRANSMIT
 K ^TMP($J)
 ;
 ; update field .02 (SENT TO CM NATIONAL DATABASE) to 'YES' for all
 ; processed entries.
 W:'$D(ZTQUEUED) !!,"Updating records to reflect transmission..."
 S IEN=0
 F  S IEN=$O(^TMP("KMPDHU01",$J,IEN)) Q:'IEN  D 
 .K FDA,ERROR W:'$D(ZTQUEUED) "."
 .S FDA($J,8973.1,IEN_",",.02)=1
 .D FILE^DIE("","FDA($J)","ERROR")
 ;
 K ^TMP("KMPDHU01",$J)
 ;
 S STR=$$NOW^XLFDT
 ; leave two complete weeks of data in file #8973.1
 D:KMPDPRGE PURGE^KMPDUTL3(DELDATE)
 D STRSTP^KMPDUTL2(3,2,2,STR)
 ;
 W:'$D(ZTQUEUED) !!,"Finished!"
 ;
 Q
 ;
ASYNC(IEN,NM,PR,DATA) ; compile asynchronous stats
 ;-----------------------------------------------------------------------
 ; IEN..... Ien for file #8973.1 (CM HL7 DATA)
 ; NM...... Namespace (free text)
 ; PR...... Protocol (free text)
 ; DATA().. Array containing node data for file #8973.1 (CM HL7 DATA)
 ;-----------------------------------------------------------------------
 Q:'$G(IEN)
 Q:$G(NM)=""
 Q:$G(PR)=""
 Q:'$D(DATA)
 N CS,I,J
 ; quit if no contact site
 S CS=$P(DATA(99.2),U,12) Q:CS=""
 S ^TMP($J,START,NM,PR,CS,0)=DATA(0)
 ; node 99.1 is for national database (end date^facility name)
 S DATA(99.1)=END_"^"_$P(SITE,U,2)_"^"_$P(SITE,U,3)
 ; pieces 6 through 13 of node 99.2 contain text
 F I=6:1:13 S $P(^TMP($J,START,NM,PR,CS,99.2),U,I)=$P(DATA(99.2),U,I)
 W:'$D(ZTQUEUED) "."
 F I=0:0 S I=$O(DATA(I)) Q:'I  D 
 .; 99.1 data not to be totalled
 .I I=99.1 F J=1:1:3 S $P(^TMP($J,START,NM,PR,CS,I),U,J)=$P(DATA(I),U,J)
 .; Add data to get weekly totals.
 .E  F J=1:1:$S($E(I)=5:24,I=99:6,I=99.2:3,I=99.3:9,99.5:3,1:9) D 
 ..S $P(^TMP($J,START,NM,PR,CS,I),U,J)=$P($G(^TMP($J,START,NM,PR,CS,I)),U,J)+$P(DATA(I),U,J)
 ;
 Q
 ;
SYNC(IEN,NM,PR,DATA) ; compile asynchronous stats
 ;-----------------------------------------------------------------------
 ; IEN..... Ien for file #8973.1 (CM HL7 DATA)
 ; NM...... Namespace (free text)
 ; PR...... Protocol (free text)
 ; DATA().. Array containing node data for file #8973.1 (CM HL7 DATA)
 ;-----------------------------------------------------------------------
 Q:'$G(IEN)
 Q:$G(NM)=""
 Q:$G(PR)=""
 Q:'$D(DATA)
 N I,J
 S ^TMP($J,START,NM,PR,0)=DATA(0)
 ; node 99.1 is for national database (end date^facility name)
 S DATA(99.1)=END_"^"_$P(SITE,U,2)_"^"_$P(SITE,U,3)
 ; pieces 6 through 13 of node 99.2 contain text
 F I=6:1:13 S $P(^TMP($J,START,NM,PR,99.2),U,I)=$P(DATA(99.2),U,I)
 W:'$D(ZTQUEUED) "."
 F I=0:0 S I=$O(DATA(I)) Q:'I  D 
 .; 99.1 data not to be totalled
 .I I=99.1 F J=1:1:3 S $P(^TMP($J,START,NM,PR,I),U,J)=$P(DATA(I),U,J)
 .; Add data to get weekly totals.
 .E  F J=1:1:$S(I=99:6,1:9) D 
 ..S $P(^TMP($J,START,NM,PR,I),U,J)=$P($G(^TMP($J,START,NM,PR,I)),U,J)+$P(DATA(I),U,J)
 Q
 ;
TRANSMIT ;-- format TMPARRY data, put into e-mail and send to cm.
 ;
 Q:'$D(^TMP($J))
 ;
 N C,CPU,HRSDAYS,I,IEN,LN,N,P,S,TL,TRANSTO,XMSUB,X,XMTEXT,XMY,XMZ,Y,Z
 ;
 K ^TMP("KMPDHU01-2",$J)
 ;
 S LN=0
 ; version and patch info
 S LN=LN+1,^TMP("KMPDHU01-2",$J,LN)="VERSION="_$$VERSION^KMPDUTL
 ; system information
 S LN=LN+1,^TMP("KMPDHU01-2",$J,LN)="SYSINFO="_$$SYSINFO^KMPDUTL1()
 ; send cpu data to national database
 D CPU^KMPDUTL5(.CPU) I $D(CPU) S I="" F  S I=$O(CPU(I)) Q:I=""  D 
 .S LN=LN+1,^TMP("KMPDHU01-2",$J,LN)="CPU="_I_U_CPU(I)
 ;
 W:'$D(ZTQUEUED) !!,"Formatting ",$$FMTE^XLFDT($G(START))," data for mail delivery..."
 ; reformat so that data is in ^TMP("KMPR UPLOAD",$J,LN)= format.
 S IEN=0,S=""
 F  S S=$O(^TMP($J,S)) Q:S=""  S N="" W "." D 
 .F  S N=$O(^TMP($J,S,N)) Q:N=""  S P="" D 
 ..F  S P=$O(^TMP($J,S,N,P)) Q:P=""  S I="",IEN=IEN+1 D 
 ...; synchronous data
 ...F  S I=$O(^TMP($J,S,N,P,I)) Q:(+I)'=I  S LN=LN+1 D 
 ....S ^TMP("KMPDHU01-2",$J,LN)=IEN_","_I_")="_^TMP($J,S,N,P,I)
 ...; asynchronous data
 ...S C="-"
 ...F  S C=$O(^TMP($J,S,N,P,C)) Q:C=""  S I="",IEN=IEN+1 D 
 ....F  S I=$O(^TMP($J,S,N,P,C,I)) Q:(+I)'=I  S LN=LN+1 D
 .....S ^TMP("KMPDHU01-2",$J,LN)=IEN_","_I_")="_^TMP($J,S,N,P,C,I)
 ;
 ; quit if no data to transmit.
 Q:'$D(^TMP("KMPDHU01-2",$J))
 S TL=$G(^KMPD(8973,"TEST LAB"))
 S TL=$S(TL:"TESTLAB-",1:"")
 ; send packman message.
 S XMTEXT="^TMP(""KMPDHU01-2"","_$J_","
 S XMSUB="CM HL7 DATA~"_TL_$P(SITE,U,2)_" ("_$P(SITE,U,3)_")~"_$$FMTE^XLFDT(START)
 D TRANSTO^KMPDUTL7(1,3,.TRANSTO)
 Q:'$D(TRANSTO)  S I=""
 F  S I=$O(TRANSTO(I)) Q:I=""  S XMY(I)=""
 D ^XMD
 W:'$D(ZTQUEUED) !,"Message #",$G(XMZ)," sent..."
 K ^TMP("KMPDHU01-2",$J)
 ;
 Q
