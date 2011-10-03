MAGSIXG2 ;WOIFO/SG - LIST OF IMAGES RPCS (PARAMETERS) ; 2/12/09 3:52pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ;
 ; This routine uses the following ICRs:
 ;
 ; #10035        Read file #2 (supported)
 ;
 Q
 ;
 ;+++++ RETURNS THE HEADER FOR THE RPC RESULT ARRAY
BLDHDR() ;
 N HDR,I,TMP
 S HDR=""
 F I=3:1  S TMP=$P($T(BLDHDR1+I),";;",2)  Q:TMP=""  D
 . S HDR=HDR_U_$$TRIM^XLFSTR($P(TMP,U,2))
 . Q
 Q $P(HDR,U,2,9999)
 ;
BLDHDR1 ;+++++ TEMPLATE OF THE HEADER FOR THE RESULT ARRAY
 ;;  #   Header              Data Description
 ;;---   --------------      --------------------------------------
 ;;  1 ^ Item~S2           ^ Sequential number
 ;;  2 ^ Site              ^
 ;;  3 ^ Note Title~~W0    ^ *
 ;;  4 ^ Proc DT~S1        ^ Procedure date
 ;;  5 ^ Procedure         ^ Procedure
 ;;  6 ^ # Img~S2          ^ Number of images
 ;;  7 ^ Short Desc        ^
 ;;  8 ^ Pkg               ^ PACKAGE INDEX (40) - Internal
 ;;  9 ^ Class             ^ CLASS INDEX (41) - External
 ;; 10 ^ Type              ^ TYPE INDEX (42) - External
 ;; 11 ^ Specialty         ^ SPEC/SUBSPEC INDEX (44) - External
 ;; 12 ^ Event             ^ PROC/EVENT INDEX (43) - External
 ;; 13 ^ Origin            ^ ORIGIN INDEX (45)
 ;; 14 ^ Cap Dt~S1~W0      ^ Capture date
 ;; 15 ^ Cap by~~W0        ^ User who captured the image
 ;; 16 ^ Image ID~S2~W0    ^ Image IEN
 ;
 ; Notes
 ; =====
 ;
 ; Only the second "^"-column is used to build the header; everything 
 ; else is provided for documentation purposes.
 ;
 Q
 ;
 ;+++++ RETURNS DESCRIPTION OF THE IMAGE SELECTION CRITERIA
 ;
 ; .MAGFLT       Reference to a local variable that stores the image
 ;               selection criteria
 ;
 ; FROMDATE      Date range
 ; TODATE
 ;
 ; FLAGS         Flags that control the image selection
 ; 
 ; Return Values
 ; =============
 ;               Description of the image selection criteria.
 ;
FLTDESC(MAGFLT,FROMDATE,TODATE,FLAGS) ;
 N BUF,DTRANGE,FLT,TMP
 S FLT=""
 ;
 ;--- Package
 S:$G(MAGFLT("PKG"))'="" FLT=FLT_"Pkg: "_MAGFLT("PKG")_" - "
 ;
 ;--- Class
 I $G(MAGFLT("CLS"))'=""  D  S FLT=FLT_"Class: "_BUF_" - "
 . S BUF=MAGFLT("CLS")
 . I BUF="ADMIN^ADMIN/CLIN^CLIN/ADMIN"  S BUF="ADMIN"  Q
 . I BUF="CLIN^CLIN/ADMIN^ADMIN/CLIN"   S BUF="CLIN"   Q
 . Q
 ;
 S:$G(MAGFLT("TYPE"))'="" FLT=FLT_"Type: "_MAGFLT("TYPE")_" - "
 S:$G(MAGFLT("SPEC"))'="" FLT=FLT_"Spec: "_MAGFLT("SPEC")_" - "
 S:$G(MAGFLT("EVT"))'="" FLT=FLT_"Event: "_MAGFLT("EVT")_" - "
 S:$G(MAGFLT("ORIG"))'="" FLT=FLT_"Origin: "_MAGFLT("ORIG")_" - "
 S:$G(MAGFLT("GDESC"))'="" FLT=FLT_"Descr: '"_MAGFLT("GDESC")_"' - "
 ;
 ;--- Image status
 S:$G(MAGFLT("ISTAT"))'="" FLT=FLT_"Status: "_MAGFLT("ISTAT")_" - "
 ;
 ;--- Controlled image
 S:$G(MAGFLT("SENSIMG"))'="" FLT=FLT_"Controlled: "_MAGFLT("SENSIMG")_" - "
 ;
 ;--- Capture application
 S:$G(MAGFLT("CAPTAPP"))'="" FLT=FLT_"App: "_MAGFLT("CAPTAPP")_" - "
 ;
 ;--- Date Range
 S DTRANGE=""
 S:FROMDATE'="" DTRANGE=DTRANGE_" from "_FROMDATE
 S:TODATE'="" DTRANGE=DTRANGE_" to "_TODATE
 ;
 ;--- Percentage of sparse subset
 S BUF="",TMP=+$G(MAGFLT("SUBSET%"))
 S:TMP>0 BUF=$S(TMP<1:"0"_TMP,1:TMP)_"% of "
 ;
 ;--- Control flags
 I FLT="",DTRANGE=""  S BUF=BUF_"all "
 S:FLAGS["E" BUF=BUF_"existing "
 S:FLAGS["D" BUF=BUF_$S(FLAGS["E":"and ",1:"")_"deleted "
 S FLT=FLT_$$SNTC^MAGUTL05(BUF)_"images"
 ;
 ;--- User who captured the images
 S BUF=$G(MAGFLT("SAVEDBY"))
 S:BUF>0 FLT=FLT_" captured by "_$P(BUF,U,2)
 ;
 ;--- Append the date range
 S FLT=FLT_DTRANGE
 S:FLAGS["C" FLT=FLT_" (capture date range)"
 ;
 ;---
 Q $TR(FLT,"^",",")
 ;
MISCDEFS ;+++++ DEFINITIONS OF MISCELLANEOUS PARAMETERS
 ;;==================================================================
 ;;| Parameter  | File  |Field|Type |Flags|        Comment          |
 ;;|------------+-------+-----+-----+-----+-------------------------|
 ;;|CAPTAPP     |       |  8.1| S   |     | CAPTURE APPLICATION     |
 ;;|GDESC       |       | 10  |     |     | SHORT DESCRIPTION       |
 ;;|IDFN        |       |  5  | P   |     | Patient IEN (DFN)       |
 ;;|ISTAT       |       |113  | S   |     | STATUS                  |
 ;;|IXCLASS     |       |     | P   |     | CLASS INDEX             |
 ;;|IXORIGIN    |       | 45  | S   |     | ORIGIN INDEX            |
 ;;|IXPKG       |       | 40  | S   |     | PACKAGE INDEX           |
 ;;|IXPROC      |       | 43  | P   |     | PROC/EVENT INDEX        |
 ;;|IXSPEC      |       | 44  | P   |     | SPEC/SUBSPEC INDEX      |
 ;;|IXTYPE      |       | 42  | P   |     | TYPE INDEX              |
 ;;|SAVEDBY     |       |  8  | P   |     | Who captured (DUZ)      |
 ;;|SENSIMG     |       |112  | S   |     | CONTROLLED IMAGE         |
 ;;==================================================================
 ;
 ; Notes
 ; =====
 ;
 ; File numbers are not included to disable automatic validation.
 ;
 Q
 ;
 ;+++++ VALIDATES MISCELLANEOUS PARAMETERS
 ;
 ; .MISC         Reference to a local variable that stores the tree
 ;               of miscellaneous RPC parameters
 ;
 ; .MAGFLT       Reference to a local variable where the image
 ;               selection criteria is constructed.
 ; 
 ; Return Values
 ; =============
 ;           <0  Error code
 ;            0  Success
 ;
VALMISC(MISC,MAGFLT) ;
 N ERROR,FLAGS,PNODE,RC,VAL
 S ERROR=0
 ;--- Patient IEN (DFN)
 S PNODE=$NA(MISC("IDFN")),VAL=$P($G(@PNODE),U)
 I VAL'=""  D
 . I +VAL'=VAL  S ERROR=$$IPVE^MAGUERR("VAL",PNODE)  Q
 . I '($D(^DPT(VAL,0))#2)  S ERROR=$$ERROR^MAGUERR(-5,,VAL)  Q
 . S MAGFLT("IDFN")=VAL
 . Q
 E  S MAGFLT("IDFN")=""
 ;--- User IEN (DUZ)
 S PNODE=$NA(MISC("SAVEDBY")),VAL=$P($G(@PNODE),U)
 I VAL'=""  D
 . N NAME
 . I +VAL'=VAL  S ERROR=$$IPVE^MAGUERR("VAL",PNODE)  Q
 . S NAME=$$NAME^XUSER(VAL,"F")
 . I NAME=""  S ERROR=$$IPVE^MAGUERR("VAL",PNODE)  Q
 . S MAGFLT("SAVEDBY")=VAL_U_NAME
 . Q
 E  S MAGFLT("SAVEDBY")=""
 ;--- Capture application
 S VAL=$G(MISC("CAPTAPP"))
 S RC=$$VALCNLST^MAGUTL06(VAL,2005,8.1,$NA(MAGFLT("CAPTAPP")))
 I RC  D:RC>0 ERROR^MAGUERR(-42,,$P(VAL,U,RC))  S ERROR=1
 ;--- Short description
 S VAL=$G(MISC("GDESC"))
 S:VAL'="" MAGFLT("GDESC")=$$UP^XLFSTR(VAL)
 ;--- Status
 S VAL=$G(MISC("ISTAT"))
 S RC=$$VALCNLST^MAGUTL06(VAL,2005,113,$NA(MAGFLT("ISTAT")),"Z")
 I RC  D:RC>0 ERROR^MAGUERR(-31,,$P(VAL,U,RC))  S ERROR=1
 ;--- Controlled image
 S VAL=$G(MISC("SENSIMG"))
 S RC=$$VALCNLST^MAGUTL06(VAL,2005,112,$NA(MAGFLT("SENSIMG")))
 I RC  D:RC>0 ERROR^MAGUERR(-32,,$P(VAL,U,RC))  S ERROR=1
 ;--- Package
 S VAL=$G(MISC("IXPKG"))
 S RC=$$VALCNLST^MAGUTL06(VAL,2005,40,$NA(MAGFLT("PKG")))
 I RC  D:RC>0 ERROR^MAGUERR(-11,,$P(VAL,U,RC))  S ERROR=1
 ;--- Class
 S VAL=$G(MISC("IXCLASS"))
 S RC=$$VALPNLST^MAGUTL06(VAL,2005.82,$NA(MAGFLT("CLS")),"C")
 I RC  D:RC>0 ERROR^MAGUERR(-12,,$P(VAL,U,RC))  S ERROR=1
 ;--- Type
 S VAL=$G(MISC("IXTYPE"))
 S RC=$$VALPNLST^MAGUTL06(VAL,2005.83,$NA(MAGFLT("TYPE")),"C")
 I RC  D:RC>0 ERROR^MAGUERR(-13,,$P(VAL,U,RC))  S ERROR=1
 ;--- Event
 S VAL=$G(MISC("IXPROC"))
 S RC=$$VALPNLST^MAGUTL06(VAL,2005.85,$NA(MAGFLT("EVT")),"C")
 I RC  D:RC>0 ERROR^MAGUERR(-14,,$P(VAL,U,RC))  S ERROR=1
 ;--- Origin
 S VAL=$G(MISC("IXORIGIN"))
 S RC=$$VALCNLST^MAGUTL06(VAL,2005,45,$NA(MAGFLT("ORIG")))
 I RC  D:RC>0 ERROR^MAGUERR(-15,,$P(VAL,U,RC))  S ERROR=1
 ;--- Specialty (patch 59: for capture we don't want subspecialties)
 S FLAGS=$S('$D(MAGJOB("CAPTURE")):"S",1:"")
 S VAL=$G(MISC("IXSPEC"))
 S RC=$$VALSPECS(VAL,$NA(MAGFLT("SPEC")),FLAGS)
 I RC  D:RC>0 ERROR^MAGUERR(-16,,$P(VAL,U,RC))  S ERROR=1
 ;---
 Q $S(ERROR:-30,1:0)
 ;
 ;+++++ VALIDATES THE LIST OF SPECIALTIES
VALSPECS(PTNMLIST,MAG8NODE,FLAGS) ;
 N IEN,RC,SPIEN,XREF
 S RC=$$VALPNLST^MAGUTL06(PTNMLIST,2005.84,MAG8NODE,"C")  Q:RC RC
 Q:$G(FLAGS)'["S" 0
 ;--- Add subspecialties if requested
 S XREF=$$ROOT^DILFD(2005.84,,1),XREF=$NA(@XREF@("ASPEC"))
 S SPIEN=""
 F  S SPIEN=$O(@MAG8NODE@(SPIEN))  Q:SPIEN=""  D:$D(@XREF@(SPIEN))
 . S IEN=""
 . F  S IEN=$O(@XREF@(SPIEN,IEN))  Q:IEN=""  S @MAG8NODE@(IEN)=""
 . Q
 ;--- Success
 Q 0
