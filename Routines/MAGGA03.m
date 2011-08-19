MAGGA03 ;WOIFO/SG - REMOTE PROCEDURES FOR IMAGE QUERIES ; 5/8/09 10:10am
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;***** RETURNS VARIOUS IMAGE STATISTICS DATA
 ; RPC: MAGG IMAGE STATISTICS
 ;
 ; .MAGRESULTS   Reference to a local variable where the results
 ;               are returned to.
 ;
 ; FLAGS         Flags that control the execution (can be combined):
 ;
 ;                 C  Capture date range. If this flag is provided,
 ;                    then the remote procedure uses values of the
 ;                    FROMDATE and TODATE parameters to select images
 ;                    that were captured in this date range.
 ;
 ;                    Otherwise, values of those parameters are
 ;                    treated as the date range when procedures were
 ;                    performed.
 ;
 ;                 D  Include only deleted images (file #2005.1)
 ;                 E  Include only existing images (file #2005)
 ;
 ;                 S  Return image counts grouped by status
 ;                 U  Return image counts grouped by users and status
 ;
 ;               If neither 'E' nor 'D' flag is provided, then an
 ;               error (-6) is returned.
 ;
 ;               If neither 'S' nor 'U' flag is provided, then an
 ;               error (-6) is returned.
 ;
 ; [FROMDATE]    Date range for image selection. Dates can be in
 ; [TODATE]      internal or external FileMan format. If a date
 ;               parameter is not defined or empty, then the date
 ;               range remains open on the corresponding side.
 ;
 ;               Time parts of parameter values are ignored and both
 ;               ends of the date range are included in the search.
 ;               For example, in order to search images for May 21,
 ;               2008, the inernal value of both parameters should
 ;               be 3080521.
 ;
 ;               If the FROMDATE is after the TODATE, then values of
 ;               the parameters are swapped.
 ; 
 ; Return Values
 ; =============
 ;     
 ; Zero value of the 1st '^'-piece of the @MAGRESULTS@(0) indicates an
 ; error during execution of the procedure. In this case, the array
 ; is formatted as described in the comments to the RPCERRS^MAGUERR1.
 ;
 ; Otherwise, the array contains the requested data. See description
 ; of the MAGG IMAGE STATISTICS remote procedure for details.
 ;
 ; Notes
 ; =====
 ;
 ; Temporary global nodes ^TMP("MAGGA03",$J) and ^TMP("MAGGA03A,$J")
 ; are used by this procedure.
 ;
IMGQUERY(MAGRESULTS,FLAGS,FROMDATE,TODATE) ;RPC [MAGG IMAGE STATISTICS]
 N RC
 S MAGRESULTS=$NA(^TMP("MAGGA03",$J))
 K ^TMP("MAGGA03A",$J),@MAGRESULTS
 S (@MAGRESULTS@(0),RC)=0
 D CLEAR^MAGUERR(1)
 ;
 D
 . N MAGDATA      ; Data for the image query callback function
 . N MAGSTCACHE   ; Local cache for image status descriptions
 . N EDT,ERROR,QF
 . ;
 . ;=== Validate parameters
 . S FLAGS=$G(FLAGS),ERROR=0
 . ;--- Unknown/Unsupported flag(s)
 . I $TR(FLAGS,"CDESU")'=""  D IPVE^MAGUERR("FLAGS")     S ERROR=1
 . ;--- Missing required flag(s)
 . I $TR(FLAGS,"DE")=FLAGS   D ERROR^MAGUERR(-6,,"D,E")  S ERROR=1
 . I $TR(FLAGS,"SU")=FLAGS   D ERROR^MAGUERR(-6,,"S,U")  S ERROR=1
 . ;--- Date range
 . S:$$DTRANGE^MAGUTL03(.FROMDATE,.TODATE)<0 ERROR=1
 . ;--- Abort in case of error(s)
 . I ERROR  D ERROR^MAGUERR(-30)  S RC=$$FIRSTERR^MAGUERR1()  Q
 . ;
 . ;=== Query the image file(s)
 . S EDT=$S(TODATE<9999999:$$FMADD^XLFDT(TODATE,1),1:TODATE)
 . ;--- Pass the original flags to the callback function
 . S MAGDATA("FLAGS")=FLAGS
 . ;--- Remove flags that are not supported by the $$QUERY^MAGGI13
 . S QF=$$TRFLAGS^MAGUTL05(FLAGS,"CDE")
 . ;--- Execute the query
 . S RC=$$QUERY^MAGGI13("$$QRYCBK^MAGGA03A",QF,.MAGDATA,FROMDATE,EDT)
 . Q:RC<0
 . ;
 . ;=== Calculate image counts and store them to the result array
 . I FLAGS["S"  S RC=$$SECTIONS(MAGRESULTS)  Q:RC<0
 . I FLAGS["U"  S RC=$$SECTIONU(MAGRESULTS)  Q:RC<0
 . Q
 ;
 ;=== Cleanup
 K ^TMP("MAGGA03A",$J)
 I RC<0  D RPCERRS^MAGUERR1(.MAGRESULTS,RC)  Q
 S @MAGRESULTS@(0)="1^Ok"
 Q
 ;
 ;+++++ APPENDS IMAGE COUNTS BY STATUS TO THE RESULT ARRAY
 ;
 ; MAGRESULTS    Name of the global node where the results
 ;               are returned to.
 ;
 ; Input Variables
 ; ===============
 ;   ^TMP("MAGGA03A",$J,"S",...)
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ;
SECTIONS(MAGRESULTS) ;
 N BASE,CNT,I,SCNT,STC,TMP,SVPCT
 ;--- Reserve the spot for the section header
 S (BASE,CNT)=$O(@MAGRESULTS@(""),-1)+1,SCNT=0
 ;--- Store counts for each status and calculate the totals
 S STC=""
 F  S STC=$O(^TMP("MAGGA03A",$J,"S",STC))  Q:STC=""  D
 . S SCNT=SCNT+1,TMP=^TMP("MAGGA03A",$J,"S",STC)
 . S CNT=CNT+1,@MAGRESULTS@(CNT)="S^"_SCNT_U_U_$$STATUS(STC)_U_TMP
 . F I=1,2  S SCNT(I)=$G(SCNT(I))+$P(TMP,U,I)
 . Q
 ;--- Store the header of the "S"-section
 S TMP="S^^"_SCNT_"^^Totals"
 S SVPCT=$S($G(SCNT(1)):$J($G(^TMP("MAGGA03A",$J,"S",2))/SCNT(1)*100,0,2),1:"") ; 2 - QA Reviewed
 S @MAGRESULTS@(BASE)=TMP_U_$G(SCNT(1))_U_$G(SCNT(2))_U_SVPCT
 Q 0
 ;
 ;+++++ APPENDS IMAGE COUNTS BY USERS AND STATUS TO THE RESULT ARRAY
 ;
 ; MAGRESULTS    Name of the global node where the results
 ;               are returned to.
 ;
 ; Input Variables
 ; ===============
 ;   ^TMP("MAGGA03A",$J,"U",...)
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ;
SECTIONU(MAGRESULTS) ;
 N BASE,CNT,I,IEN,NAME,STC,TMP,UCNT,UPTR,USCNT,UVPCT,UVCNT,NAMESRT
 ;=== Reserve the spot for the section header
 S (BASE,CNT)=$O(@MAGRESULTS@(""),-1)+1,UCNT=0
 ;=== Store counts for each user and calculate the totals
 K ^TMP("MAGGA03A.NAME",$J)
 S IEN=""
 F  S IEN=$O(^TMP("MAGGA03A",$J,"U",IEN))  Q:IEN=""  D
 . ;--- Get the user's name
 . S NAME=""
 . I IEN>0  D
 . . S NAME=$$NAME^XUSER(IEN,"F")
 . . S:NAME="" NAME="Invalid User IEN: "_IEN
 . . Q
 . S NAMESRT=NAME_"~"_IEN
 . S ^TMP("MAGGA03A.NAME",$J,NAMESRT)=IEN
 . Q
 S NAMESRT=""
 S UVCNT=0
 F  S NAMESRT=$O(^TMP("MAGGA03A.NAME",$J,NAMESRT))  Q:NAMESRT=""  D
 . S NAME=$P(NAMESRT,"~")
 . S IEN=^TMP("MAGGA03A.NAME",$J,NAMESRT)
 . ;--- Reserve the spot for the the "U"-item
 . S UCNT=UCNT+1,(CNT,UPTR)=CNT+1
 . K USCNT  S USCNT=0
 . ;--- Process the user's counts (by status)
 . S STC=""
 . F  S STC=$O(^TMP("MAGGA03A",$J,"U",IEN,STC))  Q:STC=""  D
 . . S USCNT=USCNT+1,TMP=^TMP("MAGGA03A",$J,"U",IEN,STC)
 . . S CNT=CNT+1,@MAGRESULTS@(CNT)="US^"_USCNT_U_U_$$STATUS(STC)_U_TMP
 . . F I=1,2  S USCNT(I)=$G(USCNT(I))+$P(TMP,U,I)
 . . Q
 . ;--- Calculate verification percentage
 . I $G(USCNT(1))>0  D
 . . S TMP=+$G(^TMP("MAGGA03A",$J,"U",IEN,2))
 . . S UVPCT=+$J(TMP/USCNT(1)*100,0,2)
 . . S UVCNT=UVCNT+TMP
 . . Q
 . E  S UVPCT=""
 . ;
 . ;--- Store the "U"-item
 . S TMP="U^"_UCNT_U_USCNT_U_$S(IEN>0:IEN,1:"")_U_NAME
 . S @MAGRESULTS@(UPTR)=TMP_U_$G(USCNT(1))_U_$G(USCNT(2))_U_UVPCT
 . F I=1,2  S UCNT(I)=$G(UCNT(I))+$G(USCNT(I))
 . Q
 ;=== Store the header of the "U"-section
 S TMP="U^^"_UCNT_"^^Totals"
 S @MAGRESULTS@(BASE)=TMP_U_$G(UCNT(1))_U_$G(UCNT(2))_U_$S($G(UCNT(1)):$J(UVCNT/UCNT(1)*100,0,2),1:"")
 K ^TMP("MAGGA03A.NAME",$J)
 Q 0
 ;
 ;+++++ RETURNS THE STATUS CODE AND DESCRIPTION
 ;
 ; STC           Image status code
 ;
 ; Input Variables
 ; ===============
 ;   MAGSTCACHE
 ;
 ; Output Variables
 ; ================
 ;   MAGSTCACHE
 ;
 ; Return Values
 ; =============
 ;               StatusCode^StatusDescription
 ;
STATUS(STC) ;
 Q:STC'>0 U
 S:'$D(MAGSTCACHE(STC)) MAGSTCACHE(STC)=STC_U_$$IMGSTDSC^MAGGI11(STC)
 Q MAGSTCACHE(STC)
