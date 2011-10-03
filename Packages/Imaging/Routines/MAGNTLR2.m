MAGNTLR2 ;WOIFO/NST - TeleReader Configuration  ; 21 Jun 2010 12:19 PM
 ;;3.0;IMAGING;**114**;Mar 19, 2002;Build 1827;Aug 17, 2010
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
 ;***** Return all records in TELEREADER READER file (#2006.5843)
 ; RPC: MAG3 TELEREADER READER LIST
 ;
 ; Input Parameters
 ; ================
 ;  No input parameters
 ;  
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = "0^Error"
 ; if success
 ;   MAGRY(0)    = "1^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "Reader ID^Reader Name^AQ Site ID^AQ Site^AQ Status^
 ;                   Specialty ID^Specialty^Specialty Status^
 ;                   Procedure ID^Procedure^Procedure Status^Procedure User Pref"
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
LREADER(MAGRY) ;RPC [MAG3 TELEREADER READER LIST]
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 ;
 N D0,D1,D2
 N I0,I1,I2,I3
 N OUT0,OUT1,OUT2,OUT3
 N MSG0,MSG1,MSG2,MSG3
 N CNT
 N RVAL,RNAME
 N ACQSITE,ACQSITES,ACQSITEN,ACQSITST
 N SPECIDX,SPECIDXS,SPECIDXN
 N PROCIDX,PROCIDXS,PROCIDXU,PROCIDXN
 ;
 S MAGRY(0)="0^Error"
 S MAGRY(1)="Reader ID^Reader Name^AQ Site ID^AQ Site^AQ Station^AQ Status^"
 S MAGRY(1)=MAGRY(1)_"Specialty ID^Specialty^Specialty Status^"
 S MAGRY(1)=MAGRY(1)_"Procedure ID^Procedure^Procedure Status^Procedure User Pref"
 S CNT=1 ; Will skip 0 and 1
 S I0=0
 D LIST^DIC(2006.5843,"","@;.01I;.01",,,,,,,,"OUT0","MSG0")
 F  S I0=$O(OUT0("DILIST","ID",I0)) Q:'I0  D
 . S RVAL=OUT0("DILIST","ID",I0,".01","I")
 . S RNAME=OUT0("DILIST","ID",I0,".01","E")
 . S D0=OUT0("DILIST","2",I0)
 . D LIST^DIC(2006.58431,","_D0_",","@;.01I;.01;.5I",,,,,,,,"OUT1","MSG1")
 . S I1=0
 . F  S I1=$O(OUT1("DILIST","ID",I1)) Q:'I1  D
 . . S ACQSITE=OUT1("DILIST","ID",I1,".01","I")
 . . S ACQSITEN=OUT1("DILIST","ID",I1,".01","E")
 . . S ACQSITST=$$GET1^DIQ(4,ACQSITE,99)
 . . S ACQSITES=OUT1("DILIST","ID",I1,".5")
 . . S D1=OUT1("DILIST","2",I1)
 . . D LIST^DIC(2006.584311,","_D1_","_D0_",","@;.01I;.01;.5I",,,,,,,,"OUT2","MSG2")
 . . S I2=0
 . . F  S I2=$O(OUT2("DILIST","ID",I2)) Q:'I2  D
 . . . S SPECIDX=OUT2("DILIST","ID",I2,".01","I")
 . . . S SPECIDXN=OUT2("DILIST","ID",I2,".01","E")
 . . . S SPECIDXS=OUT2("DILIST","ID",I2,".5")
 . . . S D2=OUT2("DILIST","2",I2)
 . . . D LIST^DIC(2006.5843111,","_D2_","_D1_","_D0_",","@;.01I;.01;.5I;1I",,,,,,,,"OUT3","MSG3")
 . . . S I3=0
 . . . F  S I3=$O(OUT3("DILIST","ID",I3)) Q:'I3  D
 . . . . S PROCIDX=OUT3("DILIST","ID",I3,".01","I")
 . . . . S PROCIDXN=OUT3("DILIST","ID",I3,".01","E")
 . . . . S PROCIDXS=OUT3("DILIST","ID",I3,".5")
 . . . . S PROCIDXU=OUT3("DILIST","ID",I3,"1")
 . . . . S CNT=CNT+1
 . . . . S MAGRY(CNT)=RVAL_U_RNAME_U_ACQSITE_U_ACQSITEN_U_ACQSITST_U_ACQSITES
 . . . . S MAGRY(CNT)=MAGRY(CNT)_U_SPECIDX_U_SPECIDXN_U_SPECIDXS
 . . . . S MAGRY(CNT)=MAGRY(CNT)_U_PROCIDX_U_PROCIDXN_U_PROCIDXS_U_PROCIDXU
 . . . . Q
 . . . Q
 . . Q
 . Q
 S MAGRY(0)="1^"_(CNT-1)
 Q
 ;
 ;***** Return all records in DICOM HEALTHCARE PROVIDER SERVICE file (#2006.5831)
 ; RPC: MAG3 TELEREADER DHPS LIST
 ;
 ; Input Parameters
 ; ================
 ;  No input parameters
 ;  
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = "0^Error"
 ; if success
 ;   MAGRY(0)    = "1^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "IEN^Requested Service ID^Requested Service^Service Group ID^Service Group ID^
 ;                   Service Division ID^Service Division ID^Clinic"
 ;                 
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1)
 ;   
 ;   Clinic column is tilda delimited - Clinic ID~Clinic~.... 
 ; 
LDHSP(MAGRY) ;RPC [MAG3 TELEREADER DHPS LIST]
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 ;
 N I0,I1,D0
 N CNT,DEL,DEL1,MLTPL
 N OUT,OUT1,MSG,MSG1
 K MAGRY,OUT,MSG
 S MAGRY(0)="0^Error"
 S MAGRY(1)="Requested Service ID^Requested Service^Service Group ID^Service Group ID^"
 S MAGRY(1)=MAGRY(1)_"Service Division ID^Service Division ID^Clinic"
 D LIST^DIC(2006.5831,"","@;.01I;.01;2I;2;3I;3",,,,,,,,"OUT","MSG")
 Q:$D(MSG("DIERR"))
 S CNT=1 ; Will skip 0 and 1
 S I0=0
 F  S I0=$O(OUT("DILIST","ID",I0)) Q:'I0  D
 . S D0=OUT("DILIST",2,I0)
 . S CNT=CNT+1
 . S MAGRY(CNT)=D0
 . S MAGRY(CNT)=MAGRY(CNT)_U_OUT("DILIST","ID",I0,".01","I")_U_OUT("DILIST","ID",I0,".01","E")
 . S MAGRY(CNT)=MAGRY(CNT)_U_OUT("DILIST","ID",I0,"2","I")_U_OUT("DILIST","ID",I0,"2","E")
 . S MAGRY(CNT)=MAGRY(CNT)_U_OUT("DILIST","ID",I0,"3","I")_U_OUT("DILIST","ID",I0,"3","E")
 . K OUT1,MSG1
 . D LIST^DIC(2006.58314,","_D0_",","@;.01I;.01",,,,,,,,"OUT1","MSG1")
 . S I1=0
 . S MLTPL=""
 . S DEL="",DEL1="~"
 . F  S I1=$O(OUT1("DILIST","ID",I1)) Q:'I1  D
 . . S MLTPL=MLTPL_DEL_OUT1("DILIST","ID",I1,".01","I")_DEL1_OUT1("DILIST","ID",I1,".01","E")
 . . S DEL=DEL1
 . . Q
 . S MAGRY(CNT)=MAGRY(CNT)_U_MLTPL
 . Q
 S MAGRY(0)="1^"_(CNT-1)
 Q
