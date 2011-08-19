KMPRBD03 ;OAK/RAK - Resource Usage Monitor Data Compression ;5/28/03  08:38
 ;;2.0;CAPACITY MANAGEMENT - RUM;;May 28, 2003
 ;
 ; Background Driver (cont.)
 ;
FILE(KMPRDATE,KMPRNODE,KMPROPT,KMPRPT,KMPRNP,KMPRPTHR,KMPRNPHR,KMPROK,KMPRMSG) ;
 ;-----------------------------------------------------------------------
 ; KMPRDATE.... Date in $H Format
 ; KMPRNODE.... Node Name
 ; KMPROPT..... Option (in 2 pieces with "***" as delimiter)
 ;                piece 1 - option name
 ;                piece 2 - protocol (optional)
 ; KMPRPT().... Array for Prime Time data - passed by reference
 ;       (1)... Prime Time Data (8 elements)
 ;       (1.1). Hour count (24 hours)
 ;       (1.2). User count (24 hours)
 ; KMPRNP().... Array fo Non-Prime data - passed by reference
 ;       (1)... Non-Prime Time Data (8 elements)
 ;       (1.1). Hour count (24 hours)
 ;       (1.2). User count (24 hours)
 ; KMPRPTHR.... Number of Prime Time Hours
 ; KMPRNPHR.... Number of Non Prime Hours
 ; KMPROK...... Returns: 0 - update not successful
 ;                       1 - update successful
 ; KMPRMSG..... If KMPROK = 0 then message text will be returned in this
 ;              array (passed by reference)
 ;
 ; File data in file #8971.1 (RESOUCE USAGE MONITOR)
 ;-----------------------------------------------------------------------
 ;
 S KMPROK=0
 Q:'$G(KMPRDATE)
 Q:$G(KMPRNODE)=""
 Q:$G(KMPROPT)=""
 Q:'$D(KMPRPT)&('$D(KMPRNP))
 S KMPRPTHR=+$G(KMPRPTHR),KMPRNPHR=+$G(KMPRNPHR)
 S KMPROK=1
 K KMPRMSG
 ;
 N FDA,FMDATE,I,J,MESSAGE,OPT,WORKDAY,ZIEN
 ;
 S FMDATE=$$HTFM^XLFDT(KMPRDATE),WORKDAY=$$WORKDAY^XUWORKDY(FMDATE)
 ;
 ; date
 S FDA($J,8971.1,"+1,",.01)=FMDATE
 ; sent to cm national database
 S FDA($J,8971.1,"+1,",.02)=0
 ; cpu node
 S FDA($J,8971.1,"+1,",.03)=KMPRNODE
 ; option
 S OPT=$P(KMPROPT,"***")
 ; rum designation
 S FDA($J,8971.1,"+1,",.08)=$$RUMDESIG(OPT)
 ; if the first character of OPT is '`' then this is an RPC
 I $E(OPT)="`" S FDA($J,8971.1,"+1,",.07)=$E(OPT,2,999)
 ; if the first character of OPT is '&' then this is an HL7
 E  I $E(OPT)="&" S FDA($J,8971.1,"+1,",.09)=$E(OPT,2,999)
 ; option
 E  S FDA($J,8971.1,"+1,",.04)=$$OPTION(OPT)
 ; protocol
 S:$P(KMPROPT,"***",2)'="" FDA($J,8971.1,"+1,",.05)=$P(KMPROPT,"***",2)
 ;
 ;--Populate prime time, non-prime time and non-workday fields
 F I=1:1:8 S J=I*.01 D
 .;
 .; subscript 1 - workday prime time (PT)
 .I $P($G(KMPRPT(1)),U,I)'=""&(KMPRPTHR) D 
 ..S FDA($J,8971.1,"+1,",1+J)=$FN($P(KMPRPT(1),U,I),"",2)
 .;
 .I $P($G(KMPRNP(1)),U,I)'=""&(KMPRNPHR) D
 ..; subscript 2 - workday non-prime time (NP)
 ..I WORKDAY S FDA($J,8971.1,"+1,",2+J)=$FN($P(KMPRNP(1),U,I),"",2)
 ..; subscript 3 - entire non-workday time (NW)
 ..E  S FDA($J,8971.1,"+1,",3+J)=$FN($P(KMPRNP(1),U,I),"",2)
 ;
 ;--Populate workday and non-workday hourly occurrence and user counts
 ; non-workday is considered non-prime time
 F I=1:1:24 S J=I*.001 D
 .;
 .; subscript 1.1 - workday (WD) hourly occurrence counts
 .I $P($G(KMPRPT(1.1)),U,I)'="" D 
 ..S FDA($J,8971.1,"+1,",1.1+J)=$P(KMPRPT(1.1),U,I)
 .;
 .; subscript 1.2 - workday (WD) hourly user counts
 .I $P($G(KMPRPT(1.2)),U,I)'="" D
 ..S FDA($J,8971.1,"+1,",1.2+J)=$P(KMPRPT(1.2),U,I)
 .;
 .; subscript 2.1 - non-workday (NW) hourly occurrence counts
 .I $P($G(KMPRNP(1.1)),U,I)'="" D
 ..S FDA($J,8971.1,"+1,",2.1+J)=$P(KMPRNP(1.1),U,I)
 .;
 .; subscript 2.2 - non-workday (NW) hourly user counts
 .I $P($G(KMPRNP(1.2)),U,I)'="" D
 ..S FDA($J,8971.1,"+1,",2.2+J)=$P(KMPRNP(1.2),U,I)
 ;
 ; update file 8971.1
 D UPDATE^DIE("","FDA($J)","ZIEN","MESSAGE")
 ; if error message
 I $D(MESSAGE) S KMPROK=0 D MSG^DIALOG("A",.KMPRMSG,60,10,"MESSAGE")
 ;
 Q
 ;
RUMDESIG(KMPROPT) ;-- extrinsic function - determine rum designation
 ;-----------------------------------------------------------------------
 ; KMPROPT... Option name
 ;
 ; Return: RUM Designation (see field #.08 RUM DESIGNATION in file
 ;         #8971.1)
 ;-----------------------------------------------------------------------
 ;
 ; 5 = other
 Q:$G(KMPROPT)="" 5
 ; 1 = taskman
 Q:KMPROPT="$AFTR ZTMS$"!(KMPROPT="$STRT ZTMS$")!($E(KMPROPT)="!") 1
 ; 3 = broker
 Q:$E(KMPROPT)="`" 3
 ; 4 = users
 Q:$E(KMPROPT)="#" 4
 ; 2 - option
 Q 2
 ;
OPTION(KMPROPT) ;-- extrinsic function - option name
 ;-----------------------------------------------------------------------
 ; KMPROPT... Option name as it appears from ^KMPTMP("KMPR","DLY")
 ;
 ; Return: Option name with extraneous characters removed
 ;-----------------------------------------------------------------------
 ;
 Q:$G(KMPROPT)="" ""
 Q:$E(KMPROPT)="!" $E(KMPROPT,2,999)
 ; rpc
 Q:$E(KMPROPT)="`" ""
 Q KMPROPT
