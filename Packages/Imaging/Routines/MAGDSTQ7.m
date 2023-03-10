MAGDSTQ7 ;WOIFO/PMK - Study Tracker - Query/Retrieve user patient lookup ; Jul 01, 2020@10:00:22
 ;;3.0;IMAGING;**231**;Mar 19, 2002;Build 9;Feb 27, 2015
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
 ; Notice: This routine is on both VistA and the DICOM Gateway
 ;
 Q
 ;
 ; Entry point from ^MAGDSTQ1 for manual Q/R client
PATIENTQ ; need current and previous PII
 N CLIENT S CLIENT="MANUAL" ; set the patient lookup CLIENT for manual Q/R client
 N CHANGED,CHANGEDATE,DFN,DOB,DOD,FINIS,HISTINFO,IHISTINFO,IPATINFO
 N K,NAME,NODE,OK,PATINFO,PROMPT,RETURN,SENSITIVE,SEX,SSN,X,Y
 ;
 ; PATINFO is not used in this subroutine
 ;
 S DFN=$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT DFN"))
 S PROMPT="patient"
 S IPATINFO=$$PATIENT^MAGDSTQA(.PATINFO,.DFN) ; find the patient
 I IPATINFO D
 . D HISTLKUP^MAGDSTQA(.HISTINFO,DFN) ; get previous PII, if any
 . I HISTINFO(0)>1 D  ; select the appropriate version of PII
 . . S PROMPT="patient identification information"
 . . S IHISTINFO=$$PATIENT2^MAGDSTQA("PII CHANGES",.HISTINFO,1) ; select previous PII interaction
 . . I IHISTINFO D SAVEKEYS(.HISTINFO,IHISTINFO)
 . . Q
 . E  D  ; only one version of PII
 . . D SAVEKEYS(.PATINFO,IPATINFO)
 . . Q
 . Q
 Q
 ;
SAVEKEYS(INFO,I) ; save the query keys
 N DAY,PIDDASHES,MONTH,YEAR
 D GETINFO^MAGDSTQA(.INFO,I)
 I CHANGED="" D  ; today's pii values, get DICOM formatted name
 . D DCMNAME(.NAME,DFN)
 . Q
 S PIDDASHES=$G(^TMP("MAG",$J,"Q/R PARAM","PATIENT ID DASHES"))
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT NAME")=$TR(NAME,",","^")
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT ID")=$S(PIDDASHES="N":$TR(SSN,"-"),1:SSN)
 I $L(DOB)=4 S YEAR=DOB,(MONTH,DAY)="01"
 E  S YEAR=$E(DOB,7,10),MONTH=$E(DOB,1,2),DAY=$E(DOB,4,5)
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT BIRTH DATE")=YEAR_MONTH_DAY
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT'S SEX")=$E(SEX,1)
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT DFN")=DFN
 Q
 ;
DCMNAME(OUTPUT,DFN) ; get properly formatted DICOM patient name
 ; DICOM: family ^ given ^ middle ^ prefix ^ suffix
 ;
 N I
 I $$VISTA^MAGDSTQ D  ; VistA code - call API
 . D DCMNAME^MAGDSTA3(.OUTPUT,DFN)
 . Q
 E  D  ; DICOM Gateway code - call RPC
 . N RPCERR
 . S RPCERR=$$CALLRPC^MAGM2VCU("MAG DICOM FORMAT PATIENT NAME","M",.OUTPUT,DFN)
 . I RPCERR<0 D  S OUTPUT(0)=-1 Q
 . . D ERRORMSG^MAGDSTQ0(1,"Error in MAG DICOM FORMAT PATIENT NAME rpc",.OUTPUT)
 . . Q
 . Q
 ; remove trailing delimiters
 F I=$L(OUTPUT):-1:1 Q:$E(OUTPUT,I)'="^"  S $E(OUTPUT,I)=""
 Q
