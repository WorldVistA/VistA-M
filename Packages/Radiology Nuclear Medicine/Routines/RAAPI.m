RAAPI ;HISC/GJC,RTK - API & function utilities ;04/16/07  15:02
 ;;5.0;Radiology/Nuclear Medicine;**47**;Mar 16, 1998;Build 21
 ;
 ;Integration Agreements
 ;----------------------
 ;$$NS^XUAF4(2171); $$KSP^XUPARAM(2541)
 ;
ACCNUM(RADFN,RADTI,RACNI) ; return the site specific accession number
 ;internal use for the VistA Radiology application
 ;
 ;input : RADFN=the DFN of the patient record in the PATIENT (#2) file
 ;        RADTI=inverse date/time of the exam
 ;        RACNI=the IEN of the case level record
 ;return: sss-mmddyy-case# (site specific accession number)
 ;
 I RADFN=""!(RADTI="")!(RACNI="") Q "" ;all MUST be defined
 N RAC,RAD,RAE S RAE=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ;exam node
 S RAC=9999999.9999-RADTI ;RAC=FM internal date/time
 S RAD=$E(RAC,4,7)_$E(RAC,2,3)_"-"_+RAE ;mmddyy-case#
 Q $E($P($$NS^XUAF4($$KSP^XUPARAM("INST")),U,2),1,3)_"-"_RAD
 ;
ACCFIND(Y,RAA) ;
 ;
 ;input : Y=the accession number in either a 'sss-mmddyy-xxxxx' or
 ;          'mmddyy-xxxxx' format
 ;      : RAA(n)=the array used to return the data in the following
 ;               format RADFN_^_RADTI_^_RACNI
 ;
 ;return: n>0 successful, else n<0... 'n' is the number of array
 ;        elements when successful. When unsuccessful (n<0) 'n' is
 ;        a specific error dialog which is returned along with the
 ;        invalid accession number.
 ;
 ;        Examples:
 ;        -1^"invalid site accession number format"^accession #
 ;        -2^"invalid accession number format"^accession #
 ;        -3^"no data associated with this accession number"^accession #
 ;
 I $L(Y,"-")=3 Q:Y'?3N1"-"6N1"-"1.5N "-1^invalid site accession number format^"_Y
 I $L(Y,"-")=2 Q:Y'?6N1"-"1.5N "-2^invalid accession number format^"_Y
 N X S X=$S($L(Y,"-")=3:$NA(^RADPT("ADC1")),1:$NA(^RADPT("ADC")))
 Q:$O(@X@(Y,0))'>0 "-3^no data associated with this accession number^"_Y
 N RADFN,RADTI,RACNI,Z S:$D(U)#2=0 U="^"
 S (RADFN,Z)=0 F  S RADFN=$O(@X@(Y,RADFN)) Q:'RADFN  D
 .S RADTI=0 F  S RADTI=$O(@X@(Y,RADFN,RADTI)) Q:'RADTI  D
 ..S RACNI=0 F  S RACNI=$O(@X@(Y,RADFN,RADTI,RACNI)) Q:'RACNI  D
 ...S Z=Z+1,RAA(Z)=RADFN_U_RADTI_U_RACNI
 ...Q
 ..Q
 .Q
 Q Z ;success
 ;
ACCRPT(Y,RAA) ;return accession number(s) given file #74 pointer value - RTK
 ;
 ;input : Y=pointer to a record in file #74
 ;      : RAA(n)=the array used to return the data.
 ;
 ;return: n>0 successful, n<0 unsuccessful
 ;
 ;        When successful, 'n' is the number of array elements.
 ;          If n=1 the single accession number is returned in RAA(1)
 ;          If n>1, the "lead" accession number (for printsets) is
 ;           returned in RAA(1) and subsequent ones are returned in
 ;           RAA(2) thru RAA(n)
 ;          Accession numbers are returned in either "mmddyy-case#" or
 ;           "sss-mmddyy-case#" format
 ;        When unsuccessful, n<0, an error message is
 ;          returned along with the invalid file #74 pointer value.
 ;
 K RAA N RADCN,RAOTHCS,RARPTIEN,Z S RARPTIEN=Y
 I '$D(^RARPT(Y,0)) Q "-1^invalid file #74 pointer value^"_Y
 S RADCN=$P($G(^RARPT(RARPTIEN,0)),U,1)   ;day-case #
 S Z=1,RAA(Z)=RADCN
 F RAOTHCS=0:0 S RAOTHCS=$O(^RARPT(RARPTIEN,1,RAOTHCS)) Q:RAOTHCS'>0  D
 .S Z=Z+1,RAA(Z)=$P($G(^RARPT(RARPTIEN,1,RAOTHCS,0)),U,1)
 Q Z
 ;
SIUID() ; called from [RA REGISTER] template, creates the STUDY INSTANCE UID
 ; also called directly from RAMAG03C for exams created thru the importer
 ; RADFN, RADTI and RACNI are set in RA REGISTER template/RAMAG03C
 N RASSAN,RASIUID S RASIUID=""
 ; if SSAN exists use it to build RASIUID
 S RASSAN=$$SSANVAL^RAHLRU1(RADFN,RADTI,RACNI)
 I RASSAN'="" S RASIUID=$$STUDYUID^MAGDRAHL(RADTI,RACNI,RASSAN) Q RASIUID
 ; else if RASSAN="" do the lines below to use the legacy acc #
 N RAC,RAD,RAE S RAE=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ;exam node
 S RAC=9999999.9999-RADTI ;RAC=FM internal date/time
 S RAD=$E(RAC,4,7)_$E(RAC,2,3)_"-"_+RAE ;mmddyy-case#
 S RASIUID=$$STUDYUID^MAGDRAHL(RADTI,RACNI,RAD)
 Q RASIUID
 ;
GETSIUID(RADFN,RADTI,RACNI) ; return the value of the exam's SIUID
 Q $G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SIUID"))
 ;
SIUIDFND(Y,RAA) ; return exam data for a given study instance UID
 ;input : Y=the study instance UID
 ;      : RAA(1)=variable to hold the data in the following format:
 ;               RADFN_^_RADTI_^_RACNI
 ;
 ;return: n=1 if successful, else n<-1 with error message
 ;        When successful, n=1 and RAA(1) is returned in above format
 ;        When unsuccessful 'n' is a specific error dialog
 ;        which is returned along with the invalid study instance UID:
 ;          -1^"no data associated with this study instance UID"^siuid
 ;
 K RAA N RADFN,RADTI,RACNI S RASIUID=Y,Z=0
 S RADFN=0 F  S RADFN=$O(^RADPT("ASIUID",RASIUID,RADFN)) Q:'RADFN  D
 .S RADTI=0 F  S RADTI=$O(^RADPT("ASIUID",RASIUID,RADFN,RADTI)) Q:'RADTI  D
 ..S RACNI=0 F  S RACNI=$O(^RADPT("ASIUID",RASIUID,RADFN,RADTI,RACNI)) Q:'RACNI  D
 ...S Z=Z+1,RAA(Z)=RADFN_"^"_RADTI_"^"_RACNI
 I Z=0 Q "-1^no data associated with this study instance UID^"_RASIUID
 Q Z
