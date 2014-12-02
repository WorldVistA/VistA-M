MAGVSTDY ;WOIFO/RRB,MAT - Read a DICOM image file ;  5 Apr 2013 12:55 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ;
 Q
 ;+++++ Lookup the patient/study for an imaging service.
 ;
 ;   [RPC: MAGV STUDY LOOKUP]
 ;   
 ;   Calls LOOKUP^MAGVORDR
 ;
 ; Inputs
 ; ======
 ;
 ;   RADATA     Variable to contain the string to return.
 ;   CASENUMB   Day-Case/Accession Number (RAD package)
 ;   IMGSVC     Imaging Service (RAD, CON)
 ;   PNAMEDCM   DICOM Header (0010,0010) Patient Name
 ;   PIDDCM      "     "     (0010,0020)  "      ID
 ;   PDOBDCM     "     "     (0010,0030)  "      Date of Birth
 ;   PSEXDCM     "     "     (0010,0040)  "      Sex
 ;   [PICNDCM]   "     "        ????      "      Integration Control Number
 ; 
 ; Output
 ; ======
 ;           ----From MAGVORDR----  --From PIDCHECK--
 ;           Error     Success      Error    Success
 ;    "~"-1  -1        0
 ;       -2  Errmsg1   DFN
 ;       -3   ---      Site ID
 ;       -4   ---      ---------->  n<1      0
 ;       -5   ---      ---------->  Errmsg2  PID OK
 ;
 ;    Errmsg1______   If_____________
 ;  
 ;    -1~BAD CASE #     RAD and Null RADPTx
 ;                      RAD - Null Exam Status pointer
 ;                      RAD - Null Exam Status
 ;    -1~NO CASE #      RAD,CON - Exam Status = CANCELLED
 ;                      RAD,CON - no patient demographic file pointer
 ;                      CON - incomplete consult study
 ;
LOOKUP(RADATA,CASENUMB,IMGSVC,PNAMEDCM,PIDDCM,PDOBDCM,PSEXDCM,PICNDCM) ;
 ;
 S PICNDCM=$G(PICNDCM)
 ;
 ;--- Lookup DFN, SITE. Quit if -1, Else RADATA="0~"_DFN_"~"_SITE.
 S RADATA=$$LOOKUP^MAGVORDR(CASENUMB,IMGSVC)
 Q:+RADATA=-1
 ;
 ; Look up and compare Patient Data associated with the CASENUM
 N DFN S DFN=$P(RADATA,"~",2)
 S RADATA=RADATA_"~"_$$PIDCHECK(DFN,PNAMEDCM,PIDDCM,PDOBDCM,PSEXDCM,PICNDCM)
 Q
 ;+++++  Wrap call to PIDCHECK^MAGDIR8A() and change delimiter.
 ;   
 ;   Internal entry point called by tag LOOKUP.
 ;   Lookup patient demographics by DFN to validate DICOM header values.
 ;
 ; Inputs
 ; ======
 ; 
 ;   DFN     IEN in the RAD/NUC MED PATIENT File (#70)
 ;
 ;   Other parameters as described at tag LOOKUP.
 ;
 ; Output
 ; ======
 ; 
 ;   If found & match:  0~PID OK
 ;   On error:          n<0~ERRMSG
 ; 
 ; Notes
 ; =====
 ;
 ;   PIDCHECK^MAGDIR8A expects:
 ; 
 ;     PID        As passed to MAGDIR8 by the gateway. Here it is
 ;                  set to PIDDCM.
 ;     CASENUMB
 ;     [INSTLOC]  Instrument Location: A Site ID from the gateway's
 ;                  INSTRUMENT DICTIONARY: ^MAGDICOM(2006.581,IEN, "^"-5
 ;                  used by DEM^MAGSPID.
 ;
PIDCHECK(DFN,PNAMEDCM,PIDDCM,PDOBDCM,PSEXDCM,PICNDCM) ;
 ;
 ;--- Initialize additional expected variables.
 N FIRSTDCM,LASTDCM,MIDCM,PNAMEVAH
 N PID S PID=PIDDCM
 ;--- Next line check & transform copied from READFILE+27^MAGDIR6B.
 I $$ISIHS^MAGSPID() S PID=+PID ; P123 strip off leading zero(s)
 N RETURN
 S RETURN=$$PIDCHECK^MAGDIR8A()
 S RETURN=$S(RETURN=0:"0~PID OK",1:$TR(RETURN,",","~"))
 Q RETURN
 ;
 ; MAGVSTDY
