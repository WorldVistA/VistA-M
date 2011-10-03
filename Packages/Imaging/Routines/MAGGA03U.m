MAGGA03U ;WOIFO/GEK - USERS CAPTURED IMAGES IN DATE RANGE ; 
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
 ;***** RETURNS USERS THAT HAVE CAPTURED IMAGES IN THE DATE RANGE
 ; RPC: MAGG CAPTURE USERS
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; FLAGS         Controls which users are returned.
 ;               FLAGS refers to field #8.1 CAPTURE APPLICATION 
 ;               That field tells which device captured this image.
 ;               C =  Capture Application 
 ;                    Images that were captured by VI Capture Client
 ;               I =  Import API
 ;                    Images that were captured by VI Import API
 ;               If Flags is 'null' it defaults to 'CI'
 ;               So, it returns Users that have capture C and/or
 ;               I images, in the date range.
 ;               
 ; [FROMDATE]    Date range for image selection. Dates can be in
 ; [TODATE]      internal or external FileMan format. If a date
 ;               parameter is not defined or empty, then an error
 ;               is returned.
 ;
 ;               Time parts of parameter values are ignored and both
 ;               ends of the date range are included in the search.
 ;               For example, in order to search images for May 21,
 ;               2008, the internal value of both parameters should
 ;               be 3080521.
 ;
 ;               If the FROMDATE is after the TODATE, then values of
 ;               the parameters are swapped.
 ; 
 ; Return Values
 ; =============
 ;     
 ; MAGRY(0)     is in the format:   0^<error message> if error during execution
 ;                            or    1^<success message>  
 ; MAGRY(1..n) are in the format:   Last First Middle ^ DUZ
 ; Notes
 ; =====
 ;
 ; Temporary global nodes ^TMP("MAGGA03U",$J) and ^TMP($J,"MAGUSERS" 
 ;   and ^TMP($J,"MAGDUZ"  are used by this procedure.
 ;
USERS(MAGRY,FROMDATE,TODATE,FLAGS) ;  [RPC MAGG CAPTURE USERS]
 N I,EDT,N0,N2,CT,TMP,MERR,IDUZ,INM,MSG,X,Y
 S MAGRY=$NA(^TMP("MAGGA03U",$J))
 K @MAGRY,^TMP($J,"MAGUSERS"),^TMP($J,"MAGDUZ")
 ;
 ; Validate parameters.
 S MERR=0
 D
 . S FLAGS=$G(FLAGS) I FLAGS="" S FLAGS="CI"
 . I $TR(FLAGS,"CI")'="" S MERR=1,MSG="Invalid Flags: '"_FLAGS_"'.  Only 'C' and/or 'I'" Q
 . S X=$G(FROMDATE) D ^%DT I Y=-1 S MERR=1,MSG="Invalid date "_FROMDATE Q
 . S FROMDATE=Y
 . S X=$G(TODATE) D ^%DT I Y=-1 S MERR=1,MSG="Invalid date "_TODATE Q
 . S TODATE=Y
 I MERR S @MAGRY@(0)="0^"_MSG Q
 ;
 ; Swap the dates if necessary
 K TMP I FROMDATE>TODATE S TMP=FROMDATE,FROMDATE=TODATE,TODATE=TMP
 ;
 ;  Loop through AD Cross ref and find users that have captured images.
 ;  We don't count children of Groups, just the Group.
 S EDT=$$FMADD^XLFDT(TODATE,1)
 F  S EDT=$O(^MAG(2005,"AD",EDT),-1) Q:EDT<FROMDATE  D
 . S I="" F  S I=$O(^MAG(2005,"AD",EDT,I)) Q:'I  D
 . . S N0=^MAG(2005,I,0)
 . . Q:$P(N0,"^",10)  ; Quit if we have a Pointer to Group Parent.
 . . S N2=^MAG(2005,I,2)
 . . Q:FLAGS'[$P(N2,"^",12)  ; Quit if not captured by App in flags
 . . ; for speed, get all DUZ first, then convert to names.
 . . S IDUZ=$P(N2,"^",2) Q:'IDUZ  Q:$D(^TMP($J,"MAGDUZ",IDUZ))
 . . S ^TMP($J,"MAGDUZ",IDUZ)=""
 . . Q
 . Q
 ;  convert DUZ to Names using Kernel API
 I '$D(^TMP($J,"MAGDUZ")) S @MAGRY@(0)="0^No users found." Q
 S IDUZ="" F  S IDUZ=$O(^TMP($J,"MAGDUZ",IDUZ)) Q:'IDUZ  D
 . S INM=$$GETNAME(IDUZ)
 . S ^TMP($J,"MAGUSERS",INM,IDUZ)=""
 . Q
 ;
 ; Result array from Names and DUZs
 S CT=0,(INM,IDUZ)=""
 F  S INM=$O(^TMP($J,"MAGUSERS",INM)) Q:INM=""  D
 . F  S IDUZ=$O(^TMP($J,"MAGUSERS",INM,IDUZ)) Q:IDUZ=""  D
 . . S CT=CT+1,@MAGRY@(CT)=INM_"^"_IDUZ
 S @MAGRY@(0)=1_"^Success: "_CT_" users found"
 K ^TMP($J,"MAGUSERS"),^TMP($J,"MAGDUZ")
 Q
 ;
 ;***** RETURN NAME FROM NAME COMPONENTS
 ;  IDUZ is the DUZ of the User.
 ;  Uses supported API #3065 to call $$NAMEFMT^XLFNAME()
 ; ===== Return values
 ;   Returns the name in mixed case "Last,First Middle" format
GETNAME(IDUZ) ;
 N MAGN,MN
 ; set the needed parameters for the API Call.
 S MAGN("FILE")=200
 S MAGN("IENS")=IDUZ_","
 S MAGN("FIELD")=".01"
 ; make the call
 S MN=$$NAMEFMT^XLFNAME(.MAGN,"F","FMC")
 ; handle problems with call
 I MN="" S MN="Undefined User "_IDUZ
 Q MN
