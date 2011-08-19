MAGGTU42 ;WOIFO/SG/NST - WORKSTATION-CLIENT VERSION REPORTS  ; 30 Apr 2010 11:07 AM
 ;;3.0;IMAGING;**93,94**;Mar 19, 2002;Build 1744;May 26, 2010
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;+++++ PRINTS THE ERROR MESSAGE
 ;
 ; ERR           Error descriptor (see $$ERROR^MAGUERR)
 ;
ERROR(ERR) ;
 Q:$G(ERR)'<0
 W !!,"ERROR: "_$P(ERR,U,2)
 W !,"Location: "_$TR($P(ERR,U,3),"~","^")
 Q
 ;
 ;+++++ PRINTS THE REPORT TABLE FOR THE XREF SUBTREE
 ;
 ; NODE          Closed reference (name) of the xref subtree
 ;
 ; IQS           Position of the sequential number in a closed
 ;               reference of a cross-reference entry.
 ;
 ; Input Variables
 ; ===============
 ;   MAGRAW, MAGSORT
 ;
PRINT(NODE,IQS) ;
 N BUF,FLT,FLTL,I,PI,PREVCL,PREVWSNAME,RC,SEQN,TMP
 S (PI,FLT)=NODE,FLTL=$L(FLT)-1,FLT=$E(FLT,1,FLTL)
 ;---
 S (PREVCL,PREVWSNAME)="",RC=0
 F  S PI=$Q(@PI)  Q:$E(PI,1,FLTL)'=FLT  D  Q:RC<0
 . S SEQN=+$QS(PI,IQS),BUF=$G(@MAGRAW@(SEQN))  Q:BUF=""
 . ;--- Check if a new page should be started
 . S RC=$$PAGE^MAGUTL05(1)  Q:RC<0
 . D:RC PRTBLH
 . ;--- Do not repeat the workstation name for its subsequent
 . ;--- clients unless this is the beginning of a new page.
 . D:MAGSORT="W"
 . . I $P(BUF,U,5)=PREVWSNAME  S:'RC $P(BUF,U,5)=""
 . . E  S PREVWSNAME=$P(BUF,U,5)
 . . Q
 . ;--- Do not repeat the client name and version for subsequent
 . ;--- workstations unless this is the beginning of a new page.
 . D:MAGSORT="V"
 . . I $P(BUF,U,2,3)=PREVCL  S:'RC $P(BUF,U,2,3)=U
 . . E  S PREVCL=$P(BUF,U,2,3)
 . . Q
 . ;--- Print the report line
 . D PRINT1(BUF)
 . Q
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;+++++ PRINTS THE LINE OF THE REPORT
 ;
 ; BUF           Column values in the same format as those
 ;               returned by the $$WSCVCHCK^MAGGTU42.
 ;
 ;               If the value of this parameter does not contain
 ;               the '^' delimiter, then the first character is
 ;               used to print a separator line.
 ;
 ; [BUF1]        Headers for additional columns (not loaded by the
 ;               $$WSCVCHCK^MAGGTU42).
 ;
 ; Input Variables
 ; ===============
 ;   MAGRAW, MAGSORT
 ;
PRINT1(BUF,BUF1) ;
 N FLDW,SP  S SP=" "
 ;=== Load additional data from IMAGING WINDOWS WORKSTATIONS file
 I BUF>0  D
 . N I,IENS,MAGBUF,MAGMSG  S IENS=+BUF_","
 . D GETS^DIQ(2006.81,IENS,"2;10.5","EI","MAGBUF","MAGMSG")
 . S $P(BUF1,U,1)=$G(MAGBUF(2006.81,IENS,2,"I"))
 . S $P(BUF1,U,2)=$G(MAGBUF(2006.81,IENS,10.5,"I"))
 . ;--- Convert dates to external format
 . F I=7  S TMP=$P(BUF,U,I)  D:TMP>0
 . . S $P(BUF,U,I)=$$FMTE^XLFDT(TMP,"2DZ")
 . . Q
 . F I=1  S TMP=$P(BUF1,U,I)  D:TMP>0
 . . S $P(BUF1,U,I)=$$FMTE^XLFDT(TMP,"2DZ")
 . . Q
 . Q
 E  S:BUF'[U SP=$E(BUF,1),(BUF,BUF1)=""
 ;
 ;=== Print the line
 I MAGSORT="W"  D  Q
 . W !,$$LJ^XLFSTR($P(BUF,U,5),25,SP)     ; Workstation Name
 . W "  "_$$LJ^XLFSTR($P(BUF,U,2),10,SP)  ; Client Application
 . W "  "_$$LJ^XLFSTR($P(BUF,U,3),14,SP)  ; Client Version
 . W "  "_$$CJ^XLFSTR($P(BUF,U,7),8,SP)   ; Client Date
 . W "  "_$$CJ^XLFSTR($P(BUF1,U,1),8,SP)  ; Last Logon
 . W "  "_$$CJ^XLFSTR($P(BUF1,U,2),4,SP)  ; Session Type
 . Q
 ;---
 W !,$$LJ^XLFSTR($P(BUF,U,2),10,SP)       ; Client Application
 W "  "_$$LJ^XLFSTR($P(BUF,U,3),14,SP)    ; Client Version
 W "  "_$$LJ^XLFSTR($P(BUF,U,5),25,SP)    ; Workstation Name
 W "  "_$$CJ^XLFSTR($P(BUF,U,7),8,SP)     ; Client Date
 W "  "_$$CJ^XLFSTR($P(BUF1,U,1),8,SP)    ; Last Logon
 W "  "_$$CJ^XLFSTR($P(BUF1,U,2),4,SP)    ; Session Type
 Q
 ;
 ;+++++ PRINTS THE TABLE HEADER
 ;
 ; Input Variables
 ; ===============
 ;   MAGPAGE
 ;
 ; Output Variables
 ; ================
 ;   MAGPAGE
 ;
PRTBLH ;
 N TMP
 S MAGPAGE=MAGPAGE+1
 W:MAGPAGE>1 !,$$RJ^XLFSTR("Page "_MAGPAGE,IOM-1)
 ;--- 1st line of the table headers
 S TMP="^^^^^^Client"
 D PRINT1(TMP,"Last^")
 ;--- 2nd line of the table headers
 S TMP="^Client^Client Version^^Workstation Name^^Date"
 D PRINT1(TMP,"Logon^Type")
 ;--- Separator
 D PRINT1("-")
 Q
 ;
 ;##### CHECKS VERSIONS OF CLIENTS THAT RAN ON THE WORKSTATIONS
 ;
 ; MAG8DST       Closed reference (name) of a parent node where
 ;               the list of workstations is returned to.
 ;
 ; @MAG8DST@(
 ;
 ;   0)          Result descriptor
 ;                 ^01: Number of fields in the data record
 ;
 ;   Seq#)       Workstation-Client data
 ;                 ^01: Workstation IEN (file #2006.81)
 ;                 ^02: Client application name (see the
 ;                      $$CLADESC^MAGGTU41 for details)
 ;                 ^03: Client version (from the last run)
 ;                 ^04: Version check code returned by
 ;                      the $$CHKVER1^MAGGTU41
 ;                 ^05: Workstation name (value of the .01 field)
 ;                 ^06: External value of the PLACE field (.04)
 ;                 ^07: Client application date/time (internal)
 ;
 ;   "CPW",      Number of subscripts in the Client-Place-Workstation
 ;               index (see the "C" flag below).
 ;     ClientName,PlaceName,WSName,Seq#)=""
 ;
 ;   "PCVW",     Number of subscripts in the Place-Client-Version-
 ;               Patch-Build-Workstation ("PCVW") index in the result 
 ;               array (see the "V" flag below).
 ;     PlaceName,ClientName,Version,Patch,Build,WSName,Seq#)=""
 ;
 ;   "PWC",      Number of subscripts in the Place-Workstation-Client
 ;               index (see the "W" flag below).
 ;     PlaceName,WSName,ClientName,Seq#)=""
 ;    
 ;    "TOTALS"   Count total workstations processed and how many have to updated
 ;                ^01: Total workstations processed
 ;                ^02: Total workstations need to be updated
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 C  Create the Client-Place-Workstation ("CPW")
 ;                    index in the result array.
 ;
 ;                 V  Create the Place-Client-Version-Patch-Build-
 ;                    Workstation ("PCVW") index in the result array.
 ;
 ;                 W  Create the Place-Workstation-Client ("PWC")
 ;                    index in the result array.
 ;
 ; [CVRCTRSH]    Threshold number for the version check code (0-4).
 ;               If the version check code is not less than the
 ;               threshold, then the workstation-client pair is
 ;               added to the result list.
 ;
 ;               If this parameter is not defined or empty, then
 ;               the value of 3 is assumed (see $$CHKVER1^MAGGTU41
 ;               for details).
 ;
 ; [CLALST]      List of client names (see the $$CLADESC^MAGGTU41
 ;               for details)) separated by commas.
 ;
 ;               By default ($G(CLALST)=""), all supported clients
 ;               are checked.
 ;   
 ;   MAGLLGDT    Workstation Last Login date
 ; 
 ;   MAGWNMB     Workstation name contains
 ;   
 ;   MAGALLW     Include all workstations in the report (0/1)
 ;
 ; 
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see $$ERROR^MAGUERR)
 ;            0  Ok
 ;
WSCVCHCK(MAG8DST,FLAGS,CVRCTRSH,CLALST,MAGLLGDT,MAGWNMB,MAGALLW) ;
 N MAGVCD        ; Version control data
 ;
 N CLNAME,CLVER,CVRC,FLDLST,I,IENS,MAG8BUF,MAG8I
 N MAGMSG,N,PLACE,TMP,WSIEN,WSNAME
 N FUPDWS   ; Should I update the workstation
 N FRPTWS   ; Workstation has at least one version check
 ;
 ;=== Validate parameters and initialize variables
 Q:$G(MAG8DST)?." " $$ERROR^MAGUERR(-8,,"MAG8DST")
 K @MAG8DST  S MAG8I=0
 ;--- Client name(s)
 S CLALST=$TR($G(CLALST)," ")
 S:CLALST="" CLALST=$$CLADESC^MAGGTU41()
 ;--- Version check threshold
 I $G(CVRCTRSH)=""  S CVRCTRSH=3
 E  D  Q:TMP $$IPVE^MAGUERR("CVRCTRSH")
 . S TMP=$S(+CVRCTRSH'=CVRCTRSH:1,CVRCTRSH<0:1,CVRCTRSH>4:1,1:0)
 . Q
 ;--- Flags
 S FLAGS=$G(FLAGS)
 ;
 ;=== Client applications and version field numbers
 S FLDLST="",N=$L(CLALST,",")
 F I=1:1:N  S CLNAME=$P(CLALST,",",I)  D
 . S MAG8BUF=$$CLADESC^MAGGTU41(CLNAME)  Q:MAG8BUF<0
 . ;--- Version field number
 . S TMP=+$P(MAG8BUF,U,2)
 . S:TMP>0 $P(FLDLST(CLNAME),U,1)=TMP,FLDLST=FLDLST_";"_TMP
 . ;--- Date/time field number
 . S TMP=+$P(MAG8BUF,U,3)
 . S:TMP>0 $P(FLDLST(CLNAME),U,2)=TMP,FLDLST=FLDLST_";"_TMP
 . Q
 ;---
 Q:FLDLST="" $$ERROR^MAGUERR(-26,,"FLDLST")
 S FLDLST=".01;.04;2"_FLDLST
 ;
 S WSIEN=0
 F  S WSIEN=$O(^MAG(2006.81,WSIEN))  Q:WSIEN'>0  D
 . K MAG8BUF,MAGMSG
 . ;=== Get the workstation data
 . S IENS=WSIEN_","
 . D GETS^DIQ(2006.81,IENS,FLDLST,"EI","MAG8BUF","MAGMSG")
 . I MAGLLGDT>$G(MAG8BUF(2006.81,IENS,2,"I")) Q  ; Last login date is older than requested
 . S WSNAME=$G(MAG8BUF(2006.81,IENS,.01,"E"))  ; NAME
 . S:WSNAME="" WSNAME="#"_WSIEN                ; Just in case ;-)
 . I '(WSNAME[MAGWNMB) Q  ; Skip. Machine name does not contain MAGWNMB
 . S PLACE=$G(MAG8BUF(2006.81,IENS,.04,"E"))   ; PLACE
 . S:PLACE="" PLACE=" "
 . ;
 . ;=== Check the clients
 . S CLNAME=""
 . S FRPTWS=0
 . F  S CLNAME=$O(FLDLST(CLNAME))  Q:CLNAME=""  D
 . . S CLVER=$G(MAG8BUF(2006.81,IENS,+FLDLST(CLNAME),"E"))  Q:CLVER=""
 . . ;--- Check the version
 . . S CVRC=$$CHKVER1^MAGGTU41(.MAGVCD,CLNAME,.CLVER)
 . . Q:CVRC<0  ; Skip values with errors
 . . S FRPTWS=1  ; at least one client version is checked
 . . S FUPDWS=1
 . . I CVRC<CVRCTRSH  Q:'MAGALLW  S FUPDWS=0,CLVER="*"_CLVER  ; Skip values below threshold or add them we report all workstations
 . . ;--- Store the result
 . . S MAG8BUF=WSIEN_U_CLNAME_U_CLVER_U_CVRC_U_WSNAME_U_PLACE
 . . S TMP=+$P(FLDLST(CLNAME),U,2)
 . . S:TMP $P(MAG8BUF,U,7)=$G(MAG8BUF(2006.81,IENS,TMP,"I"))
 . . S MAG8I=MAG8I+1,@MAG8DST@(MAG8I)=MAG8BUF
 . . ;--- Create indexes
 . . S:FLAGS["C" @MAG8DST@("CPW",CLNAME,PLACE,WSNAME,MAG8I)=""
 . . D:FLAGS["V"
 . . . S TMP=$NA(@MAG8DST@("PCVW",PLACE,CLNAME,+$P(CLVER,".",1,2)))
 . . . S @TMP@(+$P(CLVER,".",3),+$P(CLVER,".",4),WSNAME,MAG8I)=""
 . . . Q
 . . S:FLAGS["W" @MAG8DST@("PWC",PLACE,WSNAME,CLNAME,MAG8I)=""
 . . I FUPDWS,'$D(@MAG8DST@("TOTALSU",WSNAME)) D
 . . . S @MAG8DST@("TOTALSU",WSNAME)=""
 . . . S $P(@MAG8DST@("TOTALS"),U,2)=$P($G(@MAG8DST@("TOTALS")),U,2)+1
 . . . Q
 . . Q
 . I FRPTWS,'$D(@MAG8DST@("TOTALS",WSNAME)) D
 . . S @MAG8DST@("TOTALS",WSNAME)=""
 . . S $P(@MAG8DST@("TOTALS"),U)=$P($G(@MAG8DST@("TOTALS")),U)+1
 . . Q
 . Q
 ;
 ;=== Store the result characteristics
 D:$D(@MAG8DST)>0
 . ;--- Numbers of subscripts in the indexes
 . S:FLAGS["C" @MAG8DST@("CPW")=7
 . S:FLAGS["V" @MAG8DST@("PCVW")=10
 . S:FLAGS["W" @MAG8DST@("PWC")=7
 . ;--- Number of fields in the data record
 . S @MAG8DST@(0)=7
 . Q
 ;===
 Q 0
 ;
 ;***** PRINTS THE WORKSTATION-CLIENT VERSION CHECK REPORT
 ;
 ; Input Variables
 ; ===============
 ;   MAGSORT     ; Sort mode for the report
 ;   MAGLLGDT    ; Workstation Last Login date
 ;   MAGWNMB     ; Workstation name contains
 ;   
 ;
 ; Notes
 ; =====
 ;
 ; The ^TMP("MAGGTU42",$J) global node is used by this entry point to 
 ; store the raw report data.
 ;
WSCVCRPT ;
 N MAGPAGE       ; Current page number
 N MAGRAW        ; Closed reference (name) of the raw report data
 ;
 N RC
 N PRINTHDR      ; If the header is printed already
 S MAGRAW=$NA(^TMP("MAGGTU42",$J))
 S (MAGPAGE,RC)=0
 ;
 D
 . N BUF,FLAGS,IQS,PLACE,XREF
 . S FLAGS=$S($G(MAGSORT)'="":MAGSORT,1:"V")
 . S MAGLLGDT=$S($G(MAGLLGDT)="":$P($$FMADD^XLFDT($$NOW^XLFDT,-30),"."),1:MAGLLGDT)
 . S MAGWNMB=$G(MAGWNMB)
 . S MAGALLW=$S($G(MAGALLW)="":"N",1:MAGALLW)
 . S XREF=$S(FLAGS="V":"PCVW",FLAGS="W":"PWC",1:"")
 . I XREF=""  S RC=$$IPVE^MAGUERR("MAGSORT")  Q
 . ;
 . ;=== Compile the list of workstations and clients
 . S RC=$$WSCVCHCK(MAGRAW,FLAGS,"","",MAGLLGDT,MAGWNMB,MAGALLW)  Q:RC<0
 . S IQS=+$G(@MAGRAW@(XREF))
 . I IQS<0  S RC=$$ERROR^MAGUERR(-26,,$NA(@MAGRAW@(XREF)))  Q
 . ;
 . ;=== Print the report for each site
 . S PRINTHDR=1  ; will print report header if there is no data to print
 . S PLACE="",$Y=0
 . F  S PLACE=$O(@MAGRAW@(XREF,PLACE))  Q:PLACE=""  D  Q:RC<0
 . . W:$E(IOST,1,2)="C-" @IOF
 . . ;--- Print the header
 . . S PRINTHDR=0
 . . D PRTRHDR(MAGALLW,MAGLLGDT,MAGWNMB,IOM)
 . . W !,$$CJ^XLFSTR(PLACE,IOM),!
 . . D PRTBLH
 . . ;--- Print the table
 . . S RC=$$PRINT($NA(@MAGRAW@(XREF,PLACE)),IQS)  Q:RC<0
 . . ;--- Force the new page after the end of each section
 . . S RC=$$PAGE^MAGUTL05(1,1)  Q:RC<0
 . . Q
 . D:PRINTHDR PRTRHDR(MAGALLW,MAGLLGDT,MAGWNMB,IOM)
 . S BUF="Workstation(s) found: "_$P(@MAGRAW@("TOTALS"),U)
 . W !!,$$LJ^XLFSTR(BUF,IOM)
 . S BUF="Workstation(s) to be updated: "_+$P(@MAGRAW@("TOTALS"),U,2)
 . W !,$$LJ^XLFSTR(BUF,IOM)
 . Q
 ;
 ;=== Error handling and cleanup
 D ERROR(RC):RC<-2,^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K @MAGRAW
 Q
 ;
PRTRHDR(MAGALLW,MAGLLGDT,MAGWNMB,IOM) ;--- Print report the header
 N BUF
 S BUF=$S(MAGALLW:"LIST OF ALL WORKSTATIONS AND CLIENTS",1:"LIST OF WORKSTATIONS AND CLIENTS THAT HAVE TO BE UPDATED")
 W !,$$CJ^XLFSTR(BUF,IOM)
 S BUF="LAST LOGIN DATE: "_$$FMTE^XLFDT(MAGLLGDT)
 S BUF=BUF_$S(MAGWNMB'="":"   WS NAME CONTAINS: "_MAGWNMB,1:"")
 W !,$$CJ^XLFSTR(BUF,IOM)
 W !,$$CJ^XLFSTR($$REPEAT^XLFSTR("=",$L(BUF)),IOM)
 Q
