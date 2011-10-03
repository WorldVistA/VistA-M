IVMLERR1 ;ALB/RMO,ERC - IVM Transmission Error Processing - Build List area; 15-SEP-1997 ; 2/20/08 11:10am
 ;;2.0;INCOME VERIFICATION MATCH;**9,121**; 21-OCT-94;Build 45
 ;
EN(IVMARY,IVMBEG,IVMEND,IVMEPSTA,IVMSRTBY,IVMCNT) ;Entry point to build list area for IVM transmission errors
 ;The following variables are 'system wide variables' in the
 ;IVM Transmission Error Processing List Manager application:
 ; Input  -- IVMARY   Global array subscript
 ;           IVMBEG   Begin date
 ;           IVMEND   End date
 ;           IVMEPSTA Error processing statuses
 ;                    1   - New
 ;                    2   - Checked
 ;                    1^2 - Both
 ;           IVMSRTBY Sort by criteria
 ;                    P - patient name
 ;                    D - date/time ack received
 ;                    E - error message
 ;                    O - error message of 'Person Not Found' only
 ; Output -- IVMCNT   Number of lines in the list
 D WAIT^DICD
 ;
 ;Get IVM transmission log errors
 D GET(IVMARY,IVMBEG,IVMEND,IVMEPSTA,IVMSRTBY)
 ;
 ;Build list area for for IVM transmission log errors
 D BLD(IVMSRTBY,.IVMCNT)
 ;
 ;Print message if no IVM transmission log errors meet selection criteria
 I 'IVMCNT D
 . D SET(IVMARY,1,"",1,60,0,,,.IVMCNT)
 . D SET(IVMARY,2,"No 'Transmission Errors' meet the selection criteria.",4,60,0,,,.IVMCNT)
 Q
 ;
GET(IVMARY,IVMBEG,IVMEND,IVMEPSTA,IVMSRTBY) ;Get IVM transmission log errors
 ; Input  -- IVMARY   Global array subscript
 ;           IVMBEG   Begin date
 ;           IVMEND   End date
 ;           IVMEPSTA Error processing statuses
 ;           IVMSRTBY Sort by criteria
 ; Output -- IVM Transmission log error list sorted by patient name
 ;           ^TMP("IVMERRSRT",$J,<sort by>,<patient name>,<trans log IEN>)
 ;                            or date/time ack received
 ;           ^TMP("IVMERRSRT",$J,<sort by>,<date/time ack received>,<trans log IEN>)
 ;                            or by error message (added with IVM*2*121)
 ;           ^TMP("IVMERRSRT",$J,<sort by>,<error message>,<trans log IEN>)
 N IVMDFN,IVMDTR,IVMTLIEN,PCE,STA
 ;
 ;Loop through IVM transmission log for selected date range
 F IVMDTR=IVMBEG:0 S IVMDTR=$O(^IVM(301.6,"AEPS",IVMDTR)) Q:'IVMDTR!($P(IVMDTR,".")>IVMEND)  D
 . ;Loop through selected error processing statuses
 . F PCE=1:1 S STA=$P(IVMEPSTA,U,PCE) Q:STA=""  D
 . . ;Loop through patients
 . . S IVMDFN=0
 . . F  S IVMDFN=$O(^IVM(301.6,"AEPS",IVMDTR,STA,IVMDFN)) Q:'IVMDFN  D
 . . . ;Loop though internal entry numbers
 . . . S IVMTLIEN=0
 . . . F  S IVMTLIEN=$O(^IVM(301.6,"AEPS",IVMDTR,STA,IVMDFN,IVMTLIEN)) Q:'IVMTLIEN  D SORT(IVMSRTBY,IVMDTR,IVMDFN,IVMTLIEN)
 Q
 ;
SORT(IVMSRTBY,IVMDTR,IVMDFN,IVMTLIEN) ;Set array based on sort criteria for IVM transmission log error list display
 ; Input  -- IVMSRTBY Sort by criteria
 ;           IVMDTR   IVM transmission log date/time ack received
 ;           IVMDFN   IVM patient IEN
 ;           IVMTLIEN IVM transmission log IEN
 ; Output -- None
 N IVMTLOG
 I $G(IVMSRTBY)']"" S IVMSRTBY="P"
 I IVMSRTBY="P" D  ;patient name
 . I $$GET^IVMTLOG(IVMTLIEN,.IVMTLOG) D
 . . S ^TMP("IVMERRSRT",$J,IVMSRTBY,$S($P($G(^DPT(+IVMTLOG("DFN"),0)),U)'="":$P(^(0),U),1:"UNKNOWN"),IVMTLIEN)=""
 I IVMSRTBY="D" D  ;default date/time ack received
 . S ^TMP("IVMERRSRT",$J,IVMSRTBY,IVMDTR,IVMTLIEN)=""
 I IVMSRTBY="E"!(IVMSRTBY="O") D  ;added with IVM*2*121
 . N IVMQ
 . S IVMQ=0
 . I $$GET^IVMTLOG(IVMTLIEN,.IVMTLOG) D
 . . I IVMSRTBY="O" D
 . . . I $$UPPER^DGUTL($G(IVMTLOG("ERROR")))'["PERSON NOT FOUND" S IVMQ=1
 . . Q:IVMQ=1
 . . S ^TMP("IVMERRSRT",$J,IVMSRTBY,$S($G(IVMTLOG("ERROR"))]"":IVMTLOG("ERROR"),1:"UNKNOWN"),IVMTLIEN)=""
 Q
 ;
BLD(IVMSRTBY,IVMCNT) ;Build list area for for IVM transmission log errors
 ; Input  -- IVMSRTBY Sort by criteria
 ;                    P - patient name
 ;                    D - date/time ack received
 ;                    E - error message
 ;                    O - error message of 'Person Not Found' only
 ; Output -- IVMCNT   Number of lines in the list
 N DFN,IVMCOL,IVMSUB,IVMTEXT,IVMTLIEN,IVMTLOG,IVMWID,X,VA
 ;
 ;Initialize variables
 S (IVMLINE,IVMNUM)=0
 S X=VALMDDF("NUMBER"),IVMCOL("NUM")=$P(X,U,2),IVMWID("NUM")=$P(X,U,3)
 S X=VALMDDF("RETRANSMIT"),IVMCOL("RET")=$P(X,U,2),IVMWID("RET")=$P(X,U,3)
 S X=VALMDDF("PATIENT"),IVMCOL("PAT")=$P(X,U,2),IVMWID("PAT")=$P(X,U,3)
 S X=VALMDDF("PTID"),IVMCOL("PTID")=$P(X,U,2),IVMWID("PTID")=$P(X,U,3)
 S X=VALMDDF("DATE/TIME"),IVMCOL("DTR")=$P(X,U,2),IVMWID("DTR")=$P(X,U,3)
 S X=VALMDDF("STATUS"),IVMCOL("STA")=$P(X,U,2),IVMWID("STA")=$P(X,U,3)
 ;
 ;Loop through by patient name,error message or date/time ack received
 S IVMSUB=$S(IVMSRTBY="D":0,1:"")
 F  S IVMSUB=$O(^TMP("IVMERRSRT",$J,IVMSRTBY,IVMSUB)) Q:IVMSUB=""  D
 . ;Loop through IVM transmission log IEN(s)
 . S IVMTLIEN=0
 . F  S IVMTLIEN=$O(^TMP("IVMERRSRT",$J,IVMSRTBY,IVMSUB,IVMTLIEN)) Q:'IVMTLIEN  D
 . . W:'(IVMLINE#50) "."
 . . ;Get information for IVM transmission log entry
 . . I $$GET^IVMTLOG(IVMTLIEN,.IVMTLOG) D
 . . . ;Increment selection number
 . . . S IVMNUM=IVMNUM+1
 . . . ;Increment line counter
 . . . S IVMLINE=IVMLINE+1
 . . . ;Set selection number in display array
 . . . D SET(IVMARY,IVMLINE,IVMNUM,IVMCOL("NUM"),IVMWID("NUM"),IVMNUM,IVMTLIEN,IVMTLOG("PAT"),.IVMCNT)
 . . . ;Set retransmit flag in display array
 . . . S IVMTEXT=$S('$G(IVMTLOG("PAT")):" ",'$$STATUS^IVMPLOG(IVMTLOG("PAT")):"*",1:" ")
 . . . D SET(IVMARY,IVMLINE,IVMTEXT,IVMCOL("RET"),IVMWID("RET"),IVMNUM,,,.IVMCNT)
 . . . ;Set patient name in display array
 . . . S IVMTEXT=$$LOWER^VALM1($S($G(IVMTLOG("PAT")):$$EXT^IVMTLOG("PAT",IVMTLOG("PAT")),1:"UNKNOWN"))
 . . . D SET(IVMARY,IVMLINE,IVMTEXT,IVMCOL("PAT"),IVMWID("PAT"),IVMNUM,,,.IVMCNT)
 . . . ;Set patient id in display array
 . . . S DFN=+IVMTLOG("DFN") D PID^VADPT
 . . . D SET(IVMARY,IVMLINE,VA("BID"),IVMCOL("PTID"),IVMWID("PTID"),IVMNUM,,,.IVMCNT)
 . . . ;Set date/time ack received in display array
 . . . S IVMTEXT=$$LOWER^VALM1($S($G(IVMTLOG("DT/TM ACK")):$$EXT^IVMTLOG("DT/TM ACK",IVMTLOG("DT/TM ACK")),1:"UNKNOWN"))
 . . . D SET(IVMARY,IVMLINE,IVMTEXT,IVMCOL("DTR"),IVMWID("DTR"),IVMNUM,,,.IVMCNT)
 . . . ;Set error processing status in display array
 . . . S IVMTEXT=$$LOWER^VALM1($S($G(IVMTLOG("ERROR STATUS")):$$EXT^IVMTLOG("ERROR STATUS",IVMTLOG("ERROR STATUS")),1:"UNKNOWN"))
 . . . D SET(IVMARY,IVMLINE,IVMTEXT,IVMCOL("STA"),IVMWID("STA"),IVMNUM,,,.IVMCNT)
 . . . ;Increment line counter
 . . . S IVMLINE=IVMLINE+1
 . . . ;Set error message in display array
 . . . S IVMTEXT="Error: "_$S($G(IVMTLOG("ERROR"))'="":$$EXT^IVMTLOG("ERROR",IVMTLOG("ERROR")),1:"UNKNOWN")
 . . . K X S $P(X," ",160)=""
 . . . S IVMTEXT=$E(IVMTEXT_X,1,160)
 . . . D SET(IVMARY,IVMLINE,IVMTEXT,3,$L(IVMTEXT),IVMNUM,,,.IVMCNT)
 Q
 ;
SET(IVMARY,IVMLINE,IVMTEXT,IVMCOL,IVMWID,IVMNUM,IVMTLIEN,IVMDFN,IVMCNT) ;Set display array
 ; Input  -- IVMARY   Global array subscript
 ;           IVMLINE  Line number
 ;           IVMTEXT  Text
 ;           IVMCOL   Column to start at
 ;           IVMWID   Column or text width
 ;           IVMNUM   Selection number
 ;           IVMTLIEN IVM transmission log IEN
 ;           IVMDFN   IVM patient IEN
 ; Output -- IVMCNT   Number of lines in the list
 N X
 S:IVMLINE>IVMCNT IVMCNT=IVMLINE
 S X=$S($D(^TMP(IVMARY,$J,IVMLINE,0)):^(0),1:"")
 S ^TMP(IVMARY,$J,IVMLINE,0)=$$SETSTR^VALM1(IVMTEXT,X,IVMCOL,IVMWID)
 S ^TMP(IVMARY,$J,"IDX",IVMLINE,IVMNUM)=""
 ;
 ;Set special index used in retransmitting patient
 I $G(IVMTLIEN),$G(IVMDFN) D
 . S ^TMP(IVMARY_"IDX",$J,IVMNUM)=IVMLINE_U_IVMTLIEN
 . S ^TMP(IVMARY_"IDX",$J,"PT",IVMDFN,IVMLINE)=IVMTLIEN
 Q
