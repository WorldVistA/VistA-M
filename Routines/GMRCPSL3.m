GMRCPSL3 ;SLC/MA - Special Consult Reports;9/21/01  05:25 ;1/17/02  18:19
 ;;3.0;CONSULT/REQUEST TRACKING;**23,22**;DEC 27, 1997
 ; This routine is called by GMRCPSL2 to generate reports or
 ; date output.
 ; DBIA 10035 call DIQ=2     ;PATIENT FILE
 ; DBIA 10040 call DIQ=44    ;LOCATION FILE
 ; DBIA 10060 call DIQ=200   ;NEW PERSON FILE
 ; GMRCDT1  = Start date
 ; GMRCDT2  = Stop date
 ; GMRCBRK  = Print page break between sub-totals <Y-N>
 ; TOTCNTR  = Count for total records
 ; DISPLINE = ^GMR(123,,0) + FORMATED 12 NODE
REPORT32(SUBTOT,TOTCNTR,GMRCSRCH,GMRCBRK) ; Read ^TMP("GMRCRPT",$J) and format report
 ; The ^TMP global can be in any order but it will always have 3
 ; sorting parameters (PROVIDER,DATE,IEN) or (PT LOCATION,DATE,IEN)
 ; or (PROCEDURE TYPE,DATE,IEN)
 ; RPTTITL = Used to vary report title
 ; SRTCOMP = Used to tell when to print subtotals
 ; SUBTOT  = Used to count subtotals
 N RPTTITL,SRTCOMP,GMRCQUIT
 U IO
 N IEN,SRT1,SRT2,SRT3,DISPLINE,LINECNT,PAGE,RPTTITL,SUBCOMP,GMRCFRST
 S RPTTITL=$$RPTT(GMRCSRCH)
 S (LINECNT,PAGE,SUBTOT,GMRCQUIT)=0,GMRCFRST=1
 S SRT1="",SRTCOMP=""
 ;  Sorted by GMRCSRCH & date.  First sort compare is just to watch
 ;  for GMRCSRCH change to print sub-totals.
 F  S SRT1=$O(^TMP("GMRCRPT",$J,SRT1)) Q:'$L(SRT1)  Q:GMRCQUIT  D
 .  I SRTCOMP="" S SRTCOMP=SRT1
 .  I SRTCOMP'=SRT1 D
 . .  W !!,"SUB TOTAL= ",SUBTOT,!
 . .  S LINECNT=LINECNT+3
 . .  S SUBTOT=0
 . .  I GMRCBRK D PAGEBK32
 .  S SRT2=0
 .  F  S SRT2=$O(^TMP("GMRCRPT",$J,SRT1,SRT2)) Q:'SRT2  Q:GMRCQUIT  D
 . . S SRT3=0
 . . F  S SRT3=$O(^TMP("GMRCRPT",$J,SRT1,SRT2,SRT3)) Q:'SRT3  Q:GMRCQUIT  D
 . . .   S DISPLINE=^TMP("GMRCRPT",$J,SRT1,SRT2,SRT3)
 . . .   I GMRCFRST D PAGEBK32           ;  Kick out first page header
 . . .   I LINECNT>IOSL D PAGEBK32
 . . .   I GMRCQUIT Q
 . . .  ;
 . . .  ; Start writing the print line
 . . .   W !,$P(DISPLINE,"|",1)                    ;IEN
 . . .   W ?11,$$FMTE^XLFDT($P(DISPLINE,"^",7),"D")   ;REQ DAT
 . . .   ; If Provider not NULL, If IFC record Provider will be NULL
 . . .   I GMRCSRCH=1 D
 . . . .   I +$P(DISPLINE,"^",14) D
 . . . . .   W ?25,$E($$GET1^DIQ(200,$P(DISPLINE,"^",14),.01),1,20) ;PROVIDER
 . . . .   ; Provider Null and REMOTE ORDERING PROVIDER not, must be an IFC record 
 . . . .   I '+$P(DISPLINE,"^",14),$P(DISPLINE,"^",24)'="" D
 . . . . .   W ?25,$E($P(DISPLINE,"^",24),1,40)
 . . . .   W ?48,$E($$GET1^DIQ(123.5,$P(DISPLINE,"^",5),.01),1,40)  ;TO SERVICE
 . . .     I GMRCSRCH=2 D
 . . . .     ; Location not null, if null then it is a IFC record
 . . . .     I +$P(DISPLINE,"^",4) D
 . . . . .     W ?25,$E($$GET1^DIQ(44,$P(DISPLINE,"^",4),.01),1,22)
 . . . .     ; Location null and Ordering Facility not, IFC record
 . . . .     I '+$P(DISPLINE,"^",4),+$P(DISPLINE,"^",21) D
 . . . . .     W ?25,$E($$GET1^DIQ(4,$P(DISPLINE,"^",21),.01),1,22)
 . . . .     ; Location null, Ordering Facility null, Routing Facility not
 . . . .     ; meaning this is an IFC record
 . . . .     I '+$P(DISPLINE,"^",4),'+$P(DISPLINE,"^",21),+$P(DISPLINE,"^",23) D
 . . . . .     W ?25,$E($$GET1^DIQ(4,$P(DISPLINE,"^",23),.01),1,22)
 . . . .     W ?48,$E($$GET1^DIQ(123.5,$P(DISPLINE,"^",5),.01),1,40)  ;TO SERVICE
 . . .     I GMRCSRCH=3 D
 . . . .     W ?25,$E($$GET1^DIQ(123.3,$P($P(DISPLINE,"^",8),";",1),.01),1,20) ;PROCEDURE
 . . . .     W ?48,$E($$GET1^DIQ(123.5,$P(DISPLINE,"^",5),.01),1,40)  ;TO SERVICE
 . . .     W ?89,$E($$GET1^DIQ(2,$P(DISPLINE,"^",2),.01),1,20)       ;PATIENT
 . . .     W ?121,$E($$GET1^DIQ(2,$P(DISPLINE,"^",2),.09),6,9) ;SSN
 . . .     W ?129,$$GET1^DIQ(100.01,$P(DISPLINE,"^",12),.1) ;STATUS
 . . .     S LINECNT=LINECNT+1,TOTCNTR=TOTCNTR+1,SUBTOT=SUBTOT+1
 Q
 ;
REPORT80(SUBTOT,TOTCNTR,GMRCSRCH,GMRCBRK)   ; Read ^TMP("GMRCRPT",$J) and format report
 ; The ^TMP global can be in any order but it will always have 3
 ; sorting parameters (PROVIDER,DATE,IEN) or (PT LOCATION,DATE,IEN)
 ; or (PROCEDURE TYPE,DATE,IEN)
 ; RPTTITL = Used to vary report title
 ; SRTCOMP = Used to tell when to print subtotals
 ; SUBTOT  = Used to count subtotals
 ; GMRCFRST= Set to one to get first report headers to print
 N RPTTITL,SRTCOMP,GMRCQUIT
 U IO
 N IEN,SRT1,SRT2,SRT3,DISPLINE,LINECNT,PAGE,RPTTITL,SUBCOMP,GMRCFRST
 S RPTTITL=$$RPTT(GMRCSRCH)
 S (LINECNT,PAGE,SUBTOT,GMRCQUIT)=0,GMRCFRST=1
 S SRT1="",SRTCOMP=""
 ;  Sorted by GMRCSRCH & date.  First sort compare is just to watch
 ;  for GMRCSRCH change to print sub-totals.
 F  S SRT1=$O(^TMP("GMRCRPT",$J,SRT1)) Q:'$L(SRT1)  Q:GMRCQUIT  D
 .  I SRTCOMP="" S SRTCOMP=SRT1
 .  I SRTCOMP'=SRT1 D
 . .  I (LINECNT+3)>IOSL D PAGEBK80
 . .  W !!,"SUB TOTAL= ",SUBTOT,!
 . .  S LINECNT=LINECNT+3
 . .  S SUBTOT=0
 . .  I GMRCBRK D PAGEBK80
 .  S SRT2=0
 .  F  S SRT2=$O(^TMP("GMRCRPT",$J,SRT1,SRT2)) Q:'SRT2  Q:GMRCQUIT  D
 . . S SRT3=0
 . . F  S SRT3=$O(^TMP("GMRCRPT",$J,SRT1,SRT2,SRT3)) Q:'SRT3  Q:GMRCQUIT  D
 . . .    S DISPLINE=^TMP("GMRCRPT",$J,SRT1,SRT2,SRT3)
 . . .    I GMRCFRST=1 D PAGEBK80          ; Kick out first page header
 . . .    I LINECNT>IOSL D PAGEBK80
 . . .    I GMRCQUIT Q
 . . .    ;
 . . .    ; STARTING WRITING THE PRINT LINE
 . . .    ;
 . . .    W !,$P(DISPLINE,"|",1)                    ;IEN
 . . .    W ?9,$P($$FMTE^XLFDT($P(DISPLINE,"^",7),2),"@",1)   ;REQ DATE
 . . .    I GMRCSRCH=1 D
 . . . .    ; Provider not null, If null then it is an IFC record
 . . . .    I +$P(DISPLINE,"^",14) D
 . . . . .    W ?18,$E($$GET1^DIQ(200,$P(DISPLINE,"^",14),.01),1,16) ;PROVIDER
 . . . .    ; Provider null and REMOTE ORDERING PROVIDER  not, this is an IFC record
 . . . .    I '+$P(DISPLINE,"^",14),$P(DISPLINE,"^",24)'="" D
 . . . . .    W ?18,$E($P(DISPLINE,"^",24),1,16)
 . . .    ; Location not null,  If null then it is an IFC record
 . . .    I GMRCSRCH=2,+$P(DISPLINE,"^",4) D
 . . . .    W ?18,$E($$GET1^DIQ(44,$P(DISPLINE,"^",4),.01),1,16)  ;LOCATION
 . . . .  ; Location null meaning IFC record.  Use Ordering Facility
 . . .    I GMRCSRCH=2,$P(DISPLINE,"^",4)="",+$P(DISPLINE,"^",21) D
 . . . .    W ?18,$E($$GET1^DIQ(4,$P(DISPLINE,"^",21),.01),1,16) ;ORD FACILITY
 . . .    ; Location null, Ordering Facility null, use Routing Facilty
 . . .    ; Still an IFC record
 . . .    I GMRCSRCH=2,$P(DISPLINE,"^",4)="",'$P(DISPLINE,"^",21) D
 . . . .    I +$P(DISPLINE,"^",23) D
 . . . . .    W ?18,$E($$GET1^DIQ(4,$P(DISPLINE,"^",23),.01),1,16) ;ROUTIN FACILITY
 . . .    I GMRCSRCH=3 D
 . . . .    W ?18,$E($$GET1^DIQ(123.3,$P($P(DISPLINE,"^",8),";",1),.01),1,16)   ; PROCEDURE
 . . .    W ?35,$E($$GET1^DIQ(2,$P(DISPLINE,"^",2),.01),1,20)  ;PATIENT
 . . .    W ?56,$E($$GET1^DIQ(2,$P(DISPLINE,"^",2),.09),6,9) ;SSN
 . . .    W ?61,$E($$GET1^DIQ(123.5,$P(DISPLINE,"^",5),.01),1,15)  ;TO SERVICE
 . . .    W ?77,$$GET1^DIQ(100.01,$P(DISPLINE,"^",12),.1) ;STATUS
 . . .    S LINECNT=LINECNT+1,TOTCNTR=TOTCNTR+1,SUBTOT=SUBTOT+1
 Q
PAGEBK32 ;
 S GMRCFRST=0
 K DIR
 I ($E(IOST)="C")&(IO=IO(0))&(PAGE>0) D
 .S DIR(0)="E"
 .W !
 .D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT))!($D(DIROUT)) S GMRCQUIT=1  Q
 W:$D(IOF) @IOF
 S PAGE=PAGE+1
 I $E(IOST)="C",IO=IO(0) W @IOF
 E  W !
 N TEMPDATE,TEXTLEN,LINE
 S TEMPDATE=$$NOW^XLFDT,TEMPDATE=$$FMTE^XLFDT(TEMPDATE,"P")
 S TEMPDATE=TEMPDATE_"  Page "_PAGE
 I GMRCSRCH=1,GMRCBRK D
 . W !,?6,"ORDERING PROVIDER:  ",?26,SRT1
 I GMRCSRCH=2,GMRCBRK D
 . W !,?6,"LOCATION:  ",?12,SRT1,?45
 I GMRCSRCH=3,GMRCBRK D
 . W !,?6,"PROCEDURE:  ",?12,SRT1,?45
 W !,"CONSULT LIST BY "_RPTTITL_", FOR SPECIFIED DATE(S)"
 W ?97,TEMPDATE
 I GMRCDT1>0 D
 . W !,"FROM: ",$$FMTE^XLFDT(GMRCDT1,"D"),"   TO: ",$$FMTE^XLFDT(GMRCDT2-1,"D")
 ELSE  W !,"FROM:  ALL","   TO:  ALL"
 W ?121,"LAST 4",?128,"CON"
 W !!,"CONSULT #",?11,"REQUEST DATE"
 I GMRCSRCH=1 W ?26,"ORDERING PROVIDER",?48,"TO SERVICE"
 I GMRCSRCH=2 W ?26,"FROM LOCATION",?48,"TO SERVICE"
 I GMRCSRCH=3 W ?26,"PROCEDURE",?48,"ASSOCIATED CONSULT SERVICE"
 W ?89,"PATIENT NAME",?121,"SSN",?128,"STAT"
 S LINE="",$P(LINE,"-",132)=""
 W !,LINE
 S LINECNT=$S(GMRCBRK=1:8,1:7)
 S LINECNT=9
 Q
PAGEBK80 ;
 S GMRCFRST=0
 K DIR
 I ($E(IOST)="C")&(IO=IO(0))&(PAGE>0) D
 .S DIR(0)="E"
 .W !
 .D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT))!($D(DIROUT)) S GMRCQUIT=1  Q
 W:$D(IOF) @IOF
 S PAGE=PAGE+1
 I $E(IOST)="C",IO=IO(0) W @IOF
 E  W !
 N TEMPDATE,TEXTLEN,LINE
 S TEMPDATE=$$NOW^XLFDT,TEMPDATE=$$FMTE^XLFDT(TEMPDATE,"P")
 S TEMPDATE=TEMPDATE_"  Page "_PAGE
 I GMRCSRCH=1,GMRCBRK D
 . W !,?6,"ORDERING PROVIDER:  ",?26,SRT1,?45,TEMPDATE
 I GMRCSRCH=2,GMRCBRK D
 . W !,?6,"LOCATION:  ",?12,SRT1,?45,TEMPDATE
 I GMRCSRCH=3,GMRCBRK D
 . W !,?6,"PROCEDURE:  ",?12,SRT1,?45,TEMPDATE
 I 'GMRCBRK W !,?45,TEMPDATE
 W !,"CONSULT LIST BY "_RPTTITL_", FOR SPECIFIED DATE(S)"
 I GMRCDT1>0 D
 . W !,"FROM: ",$$FMTE^XLFDT(GMRCDT1,"D"),"   TO: ",$$FMTE^XLFDT(GMRCDT2-1,"D")
 ELSE  W !,"FROM:  ALL","   TO:  ALL"
 W !!,"CONSULT",?9,"REQ DATE"
 I GMRCSRCH=1 W ?18,"ORDERING PROVIDER"
 I GMRCSRCH=2 W ?18,"LOCATION"
 I GMRCSRCH=3 W ?18,"PROCEDURE"
 W ?37,"PATIENT NAME",?56,"SSN",?61,"TO SERVICE",?77,"ST"
 S LINE="",$P(LINE,"-",80)=""
 W !,LINE
 S LINECNT=9
 Q
RPTT(GMRCSRCH) ; Title
 S RPTTITL=$S(GMRCSRCH=1:"PROVIDER(S)",GMRCSRCH=2:"LOCATION(S)",1:"PROCEDURE(S)")
 I GMRCSRCH'=3 D
 . S RPTTITL=RPTTITL_" - "_$S(GMRCARRY(1)="ALL":"ALL ",1:"SELECTED ")_$S(GMRCARRY="L":"LOCAL",GMRCARRY="R":"REMOTE",1:"LOCAL & REMOTE")
 Q RPTTITL
