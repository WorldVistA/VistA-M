MAGVIM02 ;WOIFO/MAT,PMK - Utilities for RPC calls for DICOM file processing ; 25 Jul 2013 4:49 PM
 ;;3.0;IMAGING;**118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ; +++++ Wrap calls to___    To retrieve____________
 ; 
 ;        OER^GMRCSLM1 ..... consult/procedure list (IA #2740).
 ;        ORDERS^MAGDRPCB .. Radiology Exam List.
 ;
 ;  RPC: MAGV GET PAT ORDERS
 ;
 ; INPUTS
 ; ======
 ;
 ;  MAGVRY ........... Name of output array, passed by reference.
 ;  PIDENT ........... EnterprisePatientID
 ;  PIDTYPE .......... EnterprisePatientIDType
 ;  PIDAUTHN ......... AssigningAuthority
 ;  PIDCR8OR ......... CreatingEntity
 ;  ORDRTYPE ......... OrderType
 ;  ORDTSTRT ......... DateStart
 ;  ORDTSTOP ......... DateEnd
 ;
 ; OUTPUTS
 ; =======
 ;
 ;  Array of radiology or consult orders as f(OrderType). Descriptions of each
 ;  appear before their respective tags, GETORCON & GETORAD.
 ;
 ;  NOTES
 ;  =====
 ;
GETORD(MAGVRY,PIDENT,PIDTYPE,PIDAUTHN,PIDCR8OR,ORDRTYPE,ORDTSTRT,ORDTSTOP) ;
 ;
 ;--- Initialize.
 K RETURN
 ;
 ;--- Set output array separators per MAG*3.0*34 convention.
 N SEPOUTP,SEPSTAT D ZRUSEPIN
 ;
 ;--- Validate inputs exist. External calls validate further.
 N MAGVERR S MAGVERR=0
 D
 . I '$D(ORDRTYPE)!(ORDRTYPE'?3U) S MAGVERR="Undefined or mis-formatted Order Type." Q
 . I "CON/RAD/LAB"'[ORDRTYPE S MAGVERR="Unsupported Order Type "_ORDRTYPE_"." Q
 . I '$D(ORDTSTRT) S MAGVERR="Undefined Order Start Date." Q
 . I '$D(ORDTSTOP) S MAGVERR="Undefined Order Stop Date." Q
 . I ORDTSTRT'?8N S MAGVERR="Unexpected Order Start Date format." Q
 . I ORDTSTOP'?8N S MAGVERR="Unexpected Order Stop Date format." Q
 . Q
 ;
 I MAGVERR'=0 S MAGVRY(0)="-1"_SEPSTAT_MAGVERR Q
 ;
 ;--- Convert incoming MMDDYYYY dates to FileMan format.
 D DT^DILF(,ORDTSTRT,.ORDTSTRT)
 D DT^DILF(,ORDTSTOP,.ORDTSTOP)
 ;
 ;--- Set defaults for incoming undefined.
 S:PIDTYPE="" PIDTYPE="D"
 S:PIDAUTHN="" PIDAUTHN="V"
 S:PIDCR8OR="" PIDCR8OR="Unknown." ;???_Lookup_in_^MAGV(2005.62,_Field_#.03
 ;
 ;--- Filter consults by ORDER STATUS file (#100.01) IEN's.
 N ORDRSTAT S ORDRSTAT="3,4,5,6,8,9,10,15,16"
 ;
 ;--- Branch to processor.
 D:ORDRTYPE["CON" GETORCON(PIDENT,"",ORDTSTRT,ORDTSTOP,ORDRSTAT,ORDRTYPE)
 D:ORDRTYPE["RAD" GETORRAD(PIDENT,ORDRTYPE)
 D:ORDRTYPE["LAB" GETORLAB(PIDENT,ORDTSTRT,ORDTSTOP)
 M MAGVRY=RETURN K RETURN
 Q
 ;
 ;+++++ Wrap call to OER^GMRCSLM1 (IA #2740).
 ;
 ;
GETORCON(MAGVPDFN,MAGVNULL,STARTDT,STOPDT,STATUS,OTYPE) ;
 ;
 S MAGVNULL=""
 ;
 ;--- IA #2740.
 D OER^GMRCSLM1(MAGVPDFN,MAGVNULL,STARTDT,STOPDT,STATUS,1)
 ;
 ;--- Re-format output w/o trailing "0" subscript.
 N MAGVGBL S MAGVGBL=$NA(^TMP("GMRCR",$J,"CS",1,0))
 ;
 ;--- Process if none found, or error, & QUIT.
 I $E($G(@MAGVGBL))="<" D  Q
 . ;
 . I $G(@MAGVGBL)["PATIENT DOES NOT HAVE ANY" D
 . . S RETURN(0)="0"_SEPSTAT_"0"
 . . Q
 . E  S RETURN(0)="-1"_SEPSTAT_$G(@MAGVGBL)
 . K @MAGVGBL
 . Q
 ;
 S MAGVGBL=$NA(^TMP("GMRCR",$J,"CS",0))
 ;
 ;--- Process expected output.
 E  D
 . N LINETOT S LINETOT=$P($G(@MAGVGBL),U,4)
 . S RETURN(0)="0"_SEPSTAT_LINETOT
 . N CT F CT=1:1:LINETOT S MAGVGBL=$Q(@MAGVGBL) D
 . . N DATA S DATA=$G(@MAGVGBL)
 . . K MAGV
 . . ;
 . . ;--- Parse incoming data.
 . . S MAGV("GMRCIEN")=$P(DATA,U,1)
 . . S MAGV("REQSTDT")=$$FMTE^XLFDT($P(DATA,U,2),1)
 . . S MAGV("ORDRSTAT")=$P(DATA,U,3)
 . . S MAGV("SERVTO")=$P(DATA,U,4)
 . . S MAGV("NMPROCON")=$P(DATA,U,5)
 . . S MAGV("SERVFROM")=$P(DATA,U,6)
 . . S MAGV("CONTITLE")=$P(DATA,U,7)
 . . S MAGV("OERRDFN")=$P(DATA,U,8)
 . . ;
 . . ;--- record type for proper GUI icon
 . . ;--- "C"=reg cons, "P"=reg proc, "M"=clin proc, "I"=IF cons, "R"=IF proc
 . . S MAGV("CONTYPE")=$P(DATA,U,9)
 . . ;
 . . ;--- First line of Reason for Request (#123.01,.01).
 . . S MAGV("ORDREASN")=$$GET1^DIQ(123.01,"1,"_MAGV("GMRCIEN")_",",.01)
 . . ;
 . . S MAGV("CLINPROC")=$$GET1^DIQ(123,MAGV("GMRCIEN"),1.01)
 . . ;
 . . ;--- Re-format output.
 . . N LINEOUT S LINEOUT=$QS(MAGVGBL,4)
 . . S $P(RETURN(LINEOUT),U,1)=OTYPE
 . . S $P(RETURN(LINEOUT),U,2)=MAGVPDFN
 . . S $P(RETURN(LINEOUT),U,3)=MAGV("REQSTDT")
 . . S $P(RETURN(LINEOUT),U,4)=MAGV("ORDREASN")
 . . S $P(RETURN(LINEOUT),U,5)=MAGV("SERVTO")
 . . S $P(RETURN(LINEOUT),U,7)=$$GMRCACN^MAGDFCNV(MAGV("GMRCIEN"))
 . . S $P(RETURN(LINEOUT),U,8)=MAGV("ORDRSTAT")
 . . S $P(RETURN(LINEOUT),U,9)=MAGV("GMRCIEN")
 . . S $P(RETURN(LINEOUT),U,10)=MAGV("CONTITLE")
 . . S $P(RETURN(LINEOUT),U,11)=$G(MAGV("CLINPROC"))
 . . S $P(RETURN(LINEOUT),U,12)=$G(MAGV("EXAMIEN"))
 . . S $P(RETURN(LINEOUT),U,13)=$G(MAGV("RAOIEN"))
 . . S $P(RETURN(LINEOUT),U,14)=$G(MAGV("EXAMIEN2"))
 . . S $P(RETURN(LINEOUT),U,15)=$G(MAGV("ORDRPHYS"))
 . . S $P(RETURN(LINEOUT),U,16)=$G(MAGV("ORDRLOCIEN"))
 . . S $P(RETURN(LINEOUT),U,17)=$G(MAGV("PROCMOD"))
 . . ;
 . . S RETURN($QS(MAGVGBL,4))=$TR(RETURN(LINEOUT),U,SEPOUTP)
 . . Q
 . K MAGV
 . Q
 K @MAGVGBL
 Q
 ;
 ;+++++ Wrap call to modified code from ORDERS^MAGDRPCB (RPC: MAG DICOM GET RAD ORDERS)
 ;
 ; NOTES
 ; =====
 ; Filters on REQUEST STATUS field (#5) of the RAD/NUC MED ORDERS file (#75.1)
 ; ,QUITting if status is DISCONTINUED, UNRELEASED or is null.
 ;
 ; Procedure Modifiers are multiple, concatenated as "Name1|1~Name2|2~...",
 ;   and get re-formatted as "NAME1~NAME2~..."
 ;
 ; Possible errors:
 ;
 ; . S ARRAY(1)="-1,Invalid or missing patient identifier: """_DFN_"""."
 ; . S ARRAY(1)="-2,DFN_" undefined in the RAD/NUC MED PATIENT file (#70).
 ;
GETORRAD(PATDFN,OTYPE) ;
 ;
 K RETURN
 D ORDERS^MAGVIM07(.RETURN,PATDFN)            ;MAGDRPCB(.RETURN,PATDFN)
 ;
 ;--- Process error output & QUIT.
 I $P(RETURN(1),",")<0 D  Q
 . S $P(MAGTMP(0),SEPSTAT,2)=$P(RETURN(1),",",2)
 . K RETURN S RETURN(0)="-1"_MAGTMP(0)
 . K MAGTMP
 . Q
 ;
 ;--- Re-subscript.
 N CTIN S CTIN=0
 F  S CTIN=$O(RETURN(CTIN)) Q:CTIN=""  S RETURN(CTIN-1)=RETURN(CTIN)
 S CTIN=$O(RETURN(""),-1) K RETURN(CTIN)
 ;
 N LINECUR S LINECUR=0
 N LINETOT S LINETOT=RETURN(0)
 N LINEOUT S LINEOUT=0
 ;
 F LINECUR=1:1:LINETOT D
 . ;
 . K MAGV
 . ;
 . ;--- Array "^" pieces & re-write line.
 . S MAGV("RAOIEN")=$P(RETURN(LINECUR),U,1)
 . S MAGV("PROCIEN")=$P(RETURN(LINECUR),U,2)
 . S MAGV("PROCMOD")=$P(RETURN(LINECUR),U,3)
 . ;--- Re-format Procedure Modifiers
 . I $G(MAGV("PROCMOD"))'="" N PCES S PCES="" D  S MAGV("PROCMOD")=PCES
 . . N CT F CT=1:1:$L(MAGV("PROCMOD"),"~") D
 . . . N PCE S PCE=$P($P(MAGV("PROCMOD"),"~",CT),"|",1),$P(PCES,"~",CT)=PCE
 . . . Q
 . . Q
 . . ;
 . ; S MAGV("ORDRSTAT")=$P(RETURN(LINECUR),U,4)
 . S MAGV("ORDERDT")=$$FMTE^XLFDT($P(RETURN(LINECUR),U,5),1)
 . S MAGV("ORDREASN")=$P(RETURN(LINECUR),U,6)
 . S MAGV("EXAMACN")=$P(RETURN(LINECUR),U,9)
 . N SS
 . F SS="EXAMADC","EXAMCASE","EXAMIEN","EXAMIEN2","EXAMSTAT","CREDMETH","UIDSTUDY" S MAGV(SS)=""
 . D:MAGV("EXAMACN")'=""
 . . ;
 . . ;--- Resolve DAY-CASE, CASE from (Site-)Access'n Number [###-]MMDDYY-#####
 . . N ACNL S ACNL=$L(MAGV("EXAMACN"),"-")
 . . I ACNL>1 D
 . . . S MAGV("EXAMADC")=$P(MAGV("EXAMACN"),"-",ACNL-1,ACNL)
 . . E  D
 . . . S MAGV("EXAMADC")=MAGV("EXAMACN")
 . . S MAGV("EXAMCASE")=$P(MAGV("EXAMACN"),"-",ACNL)
 . . ;
 . . ;--- Resolve examination IEN from DAY-CASE/ACN.
 . . N ROOT S ROOT=$NA(^RADPT("ADC",MAGV("EXAMADC"),PATDFN)),ROOT=$Q(@ROOT)
 . . Q:$QS(ROOT,1)'="ADC"
 . . S MAGV("EXAMIEN")=$QS(ROOT,4)
 . . S MAGV("EXAMIEN2")=$QS(ROOT,5)
 . . ;
 . . ;--- Resolve Examination Status and Credit Method.
 . . N EXSTP
 . . S EXSTP=$P($G(^RADPT(PATDFN,"DT",MAGV("EXAMIEN"),"P",MAGV("EXAMIEN2"),0)),U,3)
 . . S MAGV("EXAMSTAT")=$$GET1^DIQ(72,EXSTP,.01,"E")
 . . ;
 . . N IENS S IENS=MAGV("EXAMIEN2")_","_MAGV("EXAMIEN")_","_PATDFN_","
 . . S MAGV("CREDMETH")=$$GET1^DIQ(70.03,IENS,26,"E")
 . . ;
 . . ;--- Resolve Study Instance UID
 . . S MAGV("UIDSTUDY")=$$GET1^DIQ(70.03,IENS,81)
 . . Q
 . ;--- IA #10103 (Supported).
 . S MAGV("EXAMDATE")=$$FMTE^XLFDT($P(RETURN(LINECUR),U,10),1)
 . ;--- IA #2056 (Supported).
 . S MAGV("PROCNAME")=$$GET1^DIQ(71,MAGV("PROCIEN"),.01) ; procedure name
 . S MAGV("ORDRLOCN")=$$GET1^DIQ(75.1,MAGV("RAOIEN"),22) D
 . . ;
 . . I MAGV("ORDRLOCN")="" S MAGV("ORDRLOCIEN")="" Q
 . . S MAGV("ORDRLOCIEN")=$$GET1^DIQ(75.1,MAGV("RAOIEN"),22,"I")
 . . Q
 . S LINEOUT=LINEOUT+1
 . ;
 . S MAGV("ORDRPHYS")=$$GET1^DIQ(75.1,MAGV("RAOIEN"),14,"I") ; Requesting Phys.
 . ;
 . ;--- Re-order for output.
 . S $P(RETURN(LINEOUT),SEPOUTP,1)=OTYPE
 . S $P(RETURN(LINEOUT),SEPOUTP,2)=PATDFN
 . S $P(RETURN(LINEOUT),SEPOUTP,3)=MAGV("ORDERDT")
 . S $P(RETURN(LINEOUT),SEPOUTP,4)=MAGV("ORDREASN")
 . S $P(RETURN(LINEOUT),SEPOUTP,5)=MAGV("ORDRLOCN")
 . S $P(RETURN(LINEOUT),SEPOUTP,6)=MAGV("EXAMDATE")
 . S $P(RETURN(LINEOUT),SEPOUTP,7)=MAGV("EXAMACN")
 . S $P(RETURN(LINEOUT),SEPOUTP,8)=MAGV("EXAMSTAT")
 . S $P(RETURN(LINEOUT),SEPOUTP,9)=MAGV("PROCIEN")
 . S $P(RETURN(LINEOUT),SEPOUTP,10)=MAGV("PROCNAME")
 . S $P(RETURN(LINEOUT),SEPOUTP,11)=MAGV("EXAMCASE")
 . S $P(RETURN(LINEOUT),SEPOUTP,12)=MAGV("EXAMIEN")
 . S $P(RETURN(LINEOUT),SEPOUTP,13)=MAGV("RAOIEN")
 . S $P(RETURN(LINEOUT),SEPOUTP,14)=MAGV("EXAMIEN2")
 . S $P(RETURN(LINEOUT),SEPOUTP,15)=MAGV("ORDRPHYS")
 . S $P(RETURN(LINEOUT),SEPOUTP,16)=MAGV("ORDRLOCIEN")
 . S $P(RETURN(LINEOUT),SEPOUTP,17)=MAGV("PROCMOD")
 . S $P(RETURN(LINEOUT),SEPOUTP,18)=MAGV("CREDMETH")
 . S $P(RETURN(LINEOUT),SEPOUTP,19)=MAGV("UIDSTUDY")
 . Q
 . ;
 S RETURN(0)="0"_SEPSTAT_LINEOUT
 Q
 ;
 ;
 ; NOTES
 ; =====
 ; The case in the LAB DATA file (#63) is defined by three fields:
 ; 1) LRDFN - this is the patient ien in the file.  It is stored
 ;            in the PATIENT file (#2) in file 63 (^DPT(DFN,"LR")=LRDFN
 ; 2) LRSS -- lab section ("CY", "EM", or "SP"), each has its own subfile
 ;            See $$GETFILE^MAGT7MA(LRSS) for details
 ; 3) LRI --- the is the inverse date/time of the study.  The cases are
 ;            stored in reverse chronological order.
 ; 
 ; There are only two return variables to define the case in the LAB DATA file.
 ; 1) EXAMIEN -- this is the subfile number for the corresponding  lab section
 ; 2) EXAMIEN2 - this is the LRI value, the inverse date/time subsript
 ; 
 ; It is assumed that LRDFN can be obtained from the following code:
 ;       S LRDFN=$$GET1^DIQ(2,DFN,63,"I")
 ; 
GETORLAB(PATDFN,ORDRSTRT,ORDRSTOP) ;
 ;
 N ERROR
 N FILE ; ------ LAB DATA file (#63) subfile numbers
 N IORDRSTRT ;-- inverted order start date/time
 N IORDRSTOP ;-- inverted order stop date/time
 N LRDFN ; ----- ien for patient in LAB DATA file (#63)
 N LRI ; ------- inverted date/time for LAB DATA file (#63)
 N LRSS ; ------ lab section (EM, CY, and SP)
 N LRSSIX ;----- index for lab section
 N MAGVGBL ; --- pointer to temporary lab data
 N A,B,L,L1 ;--- scratch variables from GETS^DIQ
 ;
 N LINEOUT S LINEOUT=0
 K RETURN
 ;
 S IORDRSTRT=9999999.9999-ORDRSTRT
 S IORDRSTOP=9999999.9999-ORDRSTOP-2 ; fudge for $O-ing
 ;
 S LRDFN=$$GET1^DIQ(2,PATDFN,63)
 I 'LRDFN S RETURN(0)=0_SEPSTAT_0 Q
 ;
 S MAGVGBL=$NA(^TMP("MAG",$J,"MAGVIM02")) K @MAGVGBL
 F LRSS="EM","CY","SP" D
 . N IENS,LRILIST
 . ; get FILE information
 . S ERROR=$$GETFILE^MAGT7MA(LRSS)
 . K @MAGVGBL
 . D GETS^DIQ(63,LRDFN,FILE("FIELD")_"*","I",MAGVGBL,"ERROR")
 . S IENS="" F  S IENS=$O(@MAGVGBL@(FILE(0),IENS)) Q:IENS=""  D
 . . S LRILIST($P(IENS,",",1))=""
 . . Q
 . S LRI=IORDRSTOP ; file 63 is in reverse chronological order
 . F  S LRI=$O(LRILIST(LRI)) Q:LRI=""  Q:(LRI)>IORDRSTRT  D
 . . D GETLCASE(MAGVGBL,.FILE,LRDFN,LRSS,LRI)
 . . Q
 . Q
 S RETURN(0)="0"_SEPSTAT_LINEOUT
 K @MAGVGBL
 Q
 ;
GETLCASE(MAGVGBL,FILE,LRDFN,LRSS,LRI) ; get the data for one lab case
 N ACNUMB,LABTEST,IENS,MAGV,X
 S IENS=LRI_","_LRDFN_","
 K @MAGVGBL
 D GETS^DIQ(FILE(0),IENS,"**","I",MAGVGBL,"ERROR")
 S X=$G(@MAGVGBL@(FILE(0),IENS,.01,"I")) ; date/time specimen taken
 S MAGV("ORDERDT")=$$FMTE^XLFDT(X)
 S MAGV("ORDREASN")="Perform pathology exam on specimen(s)."
 S MAGV("ORDRLOCN")=@MAGVGBL@(FILE(0),IENS,.08,"I") ; patient location at order time
 S X=$G(@MAGVGBL@(FILE(0),IENS,.1,"I")) ; date/time specimen received in lab
 S MAGV("EXAMDATE")=$$FMTE^XLFDT(X)
 S (ACNUMB,MAGV("EXAMACN"))=$G(@MAGVGBL@(FILE(0),IENS,.06,"I"))
 S X=$G(@MAGVGBL@(FILE(0),IENS,.03,"I")) ; date report completed
 S MAGV("EXAMSTAT")=$S(X:"Completed",1:"Active")
 D TESTLKUP^MAGT7SB(MAGVGBL,.LABTEST)
 S MAGV("PROCIEN")=LABTEST("ID")
 S MAGV("PROCNAME")=LABTEST("TEXT")
 S MAGV("EXAMCASE")=$P(ACNUMB," ",3)
 S MAGV("EXAMIEN")=FILE(0)
 S MAGV("RAOIEN")=""
 S MAGV("EXAMIEN2")=LRI
 S MAGV("ORDRPHYS")=$G(@MAGVGBL@(FILE(0),IENS,.07,"I")) ; surgeon/physician
 S MAGV("ORDRLOCIEN")=""
 S MAGV("PROCMOD")=""
 ;
 S LINEOUT=LINEOUT+1
 S $P(RETURN(LINEOUT),SEPOUTP,1)="LAB"
 S $P(RETURN(LINEOUT),SEPOUTP,2)=PATDFN
 S $P(RETURN(LINEOUT),SEPOUTP,3)=MAGV("ORDERDT")
 S $P(RETURN(LINEOUT),SEPOUTP,4)=MAGV("ORDREASN")
 S $P(RETURN(LINEOUT),SEPOUTP,5)=MAGV("ORDRLOCN")
 S $P(RETURN(LINEOUT),SEPOUTP,6)=MAGV("EXAMDATE")
 S $P(RETURN(LINEOUT),SEPOUTP,7)=MAGV("EXAMACN")
 S $P(RETURN(LINEOUT),SEPOUTP,8)=MAGV("EXAMSTAT")
 S $P(RETURN(LINEOUT),SEPOUTP,9)=MAGV("PROCIEN")
 S $P(RETURN(LINEOUT),SEPOUTP,10)=MAGV("PROCNAME")
 S $P(RETURN(LINEOUT),SEPOUTP,11)=MAGV("EXAMCASE")
 S $P(RETURN(LINEOUT),SEPOUTP,12)=MAGV("EXAMIEN")
 S $P(RETURN(LINEOUT),SEPOUTP,13)=MAGV("RAOIEN")
 S $P(RETURN(LINEOUT),SEPOUTP,14)=MAGV("EXAMIEN2")
 S $P(RETURN(LINEOUT),SEPOUTP,15)=MAGV("ORDRPHYS")
 S $P(RETURN(LINEOUT),SEPOUTP,16)=MAGV("ORDRLOCIEN")
 S $P(RETURN(LINEOUT),SEPOUTP,17)=MAGV("PROCMOD")
 Q
 ;
 ;+++ Routine Utility: Initialize Separators
ZRUSEPIN ;
 S SEPOUTP=$$OUTSEP^MAGVIM01
 S SEPSTAT=$$STATSEP^MAGVIM01
 Q
 ;
 ; MAGVIM02
