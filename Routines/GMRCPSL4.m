GMRCPSL4 ;SLC/MA - Special Consult Reports;1/10/02  14:27 ;1/17/02  18:20
 ;;3.0;CONSULT/REQUEST TRACKING;**23,22**;DEC 27, 1997
 ; This routine is called by GMRCPSL2 to generate reports or
 ; date output.
 ; DBIA 10035 call DIQ=2     ;PATIENT FILE
 ; DBIA 10040 call DIQ=44    ;LOCATION FILE
 ; DBIA 10060 call DIQ=200   ;NEW PERSON FILE
        ; DISPLINE = ^GMR(123,,0) + FORMATED 12 NODE
DATAONLY ;  Write data only for user to capture
 N SRT1,SRT2,SRT3,IEN,DISPLINE
 ; DATA LINE = IEN^REQ DATE^PROVIDER^LOCATION^TO SERVICE^
 ;             PATIENT^SSN^STATUS^PROCEDURE
 S SRT1="",SRTCOMP=""
 W !,"Consult#^Req Date^Ordering Provider^Location^"
 W "To Service^Patient^SSN^Status^Procedure"
 W !
 F  S SRT1=$O(^TMP("GMRCRPT",$J,SRT1)) Q:'$L(SRT1)  D
 .  S SRT2=0
 .  F  S SRT2=$O(^TMP("GMRCRPT",$J,SRT1,SRT2)) Q:'SRT2  D
 . . S SRT3=0
 . . F  S SRT3=$O(^TMP("GMRCRPT",$J,SRT1,SRT2,SRT3)) Q:'SRT3  D
 . . .   S DISPLINE=^TMP("GMRCRPT",$J,SRT1,SRT2,SRT3)
 . . .   D DATAMOVE
 Q
DATAMOVE ; Create the DATA ONLY OUTPUT
 N DATALINE
 S $P(DATALINE,"^",1)=$P(DISPLINE,"|",1)                      ;IEN
 S $P(DATALINE,"^",2)=$$FMTE^XLFDT($P(DISPLINE,"^",7),"D")    ;REQ Date
 ; Provider not Null.  If null the must be an IFC record
 I +$P(DISPLINE,"^",14) D
 .  S $P(DATALINE,"^",3)=$$GET1^DIQ(200,$P(DISPLINE,"^",14),.01) ;PROVIDER
 ; Provider Null, REMOTE ORDERING PROVIDER not.  IFC record
 I '+$P(DISPLINE,"^",14),$P(DISPLINE,"^",24)'="" D
 .  S $P(DATALINE,"^",3)=$P(DISPLINE,"^",24)                    ;PROVIDER
 ;
 ; Patient location not null.  If null then must be an IFC record
 I +$P(DISPLINE,"^",4) D
 . S $P(DATALINE,"^",4)=$$GET1^DIQ(44,$P(DISPLINE,"^",4),.01)
 ;
 ; Patient Location null, Ordering Facility not.  IFC record
 I '+$P(DISPLINE,"^",4),+$P(DISPLINE,"^",21) D
 . S $P(DATALINE,"^",4)=$$GET1^DIQ(4,$P(DISPLINE,"^",21),.01)
 ;
 ; Patient Location null, Ordering Facility null, Routing Facility not
 ; IFC record
 I '+$P(DISPLINE,"^",4),'+$P(DISPLINE,"^",21),+$P(DISPLINE,"^",23) D
 . S $P(DATALINE,"^",4)=$$GET1^DIQ(4,$P(DISPLINE,"^",23),.01)
 ;
 S $P(DATALINE,"^",5)=$$GET1^DIQ(123.5,$P(DISPLINE,"^",5),.01) ;TO SERVICE
 S $P(DATALINE,"^",6)=$$GET1^DIQ(2,$P(DISPLINE,"^",2),.01)     ;PATIENT
 S $P(DATALINE,"^",7)=$E($$GET1^DIQ(2,$P(DISPLINE,"^",2),.09),6,10) ;SSN
 S $P(DATALINE,"^",8)=$$GET1^DIQ(100.01,$P(DISPLINE,"^",12),.1)   ;STATUS
 I $P(DISPLINE,"^",8)>"" D
 . S $P(DATALINE,"^",9)=$$GET1^DIQ(123.3,$P($P(DISPLINE,"^",8),";",1),.01)  ;PROCEDURE
 W !,DATALINE
 Q
