IVMPTRN8 ;ALB/RKS,PDJ,BRM,TDM,PJH,TDM,PWC,LBD,DRP,DJS,KUM - HL7 FULL DATA TRANSMISSION (Z07) BUILDER ;27 Nov 2017  8:56 AM
 ;;2.0;INCOME VERIFICATION MATCH;**9,11,19,12,21,17,24,36,37,47,48,42,34,77,76,75,79,85,89,98,56,97,104,113,109,114,105,115,121,151,141,150,160,161,168,167,164,184**;21-OCT-94;Build 23
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; *164* #858271 - Sending ZAV Segment with CASS field value for all Address types 
 ;
BUILD(DFN,IVMMTDT,IVMCT,IVMQUERY) ; --
 ;  Description: This entry point will be used to create an HL7 
 ;  "Full Data Transmission" message for a patient.
 ;
 ;  Input:
 ;        DFN - Patient IEN
 ;    IVMMTDT - date of the patient's Means Test or Copay Test
 ;      IVMCT - count of hl7 segments transmitted, pass by reference
 ;   IVMQUERY - array passed in by reference where
 ;    IVMQUERY("LTD") -- # of the QUERY that is currently open or
 ;                undefined, zero, or null if no QUERY opened for
 ;                last treatment date
 ;    IVMQUERY("OVIS") -- # of the QUERY that is currently open or
 ;                undefined, zero, or null if no QUERY opened for
 ;                finding outpatient visits
 ;
 ;  HL7 variables as defined by call to INIT^IVMUFNC:
 ;      HLEVN - HL7 message event counter 
 ;      HLSDT - a flag that indicates that the data to be sent is
 ;              stored in the ^TMP("HLS") global array.
 ;
 ;  The following variables returned by the INIT^HLTRANS entry point:
 ;    HLNDAP - Non-DHCP Application Pointer from file 770
 ;   HLNDAP0 - Zero node from file 770 corresponding to HLNDAP
 ;     HLDAP - DHCP Application Pointer from file 771
 ;     HLDAN - The DHCP Application Name (.01 field, file 771) for HLDAP
 ;     HLPID - HL7 processing ID from file 770
 ;     HLVER - HL7 version number from file 770
 ;      HLFS - HL7 Field Separator from the 'FS' node of file 771
 ;     HLECH - HL7 Encoding Characters from the 'EC' node of file 771
 ;       HLQ - Double quotes ("") for use in building HL7 segments
 ;     HLERR - if an error is encountered, an error message is returned
 ;             in the HLERR variable.
 ;      HLDA - the internal entry number for the entry created in
 ;             file #772.
 ;      HLDT - transmission date/time (associated with the entry in file
 ;             #772 identified by HLDA) in internal VA FileMan format.
 ;     HLDT1 - the same transmission date/time as the HLDT variable, 
 ;             only in HL7 format.
 ;
 ; Output:
 ;  ^TMP("HLS",$J,IVMCT) - global array containing all segments of the HL7 message that the VistA application wishes to send.  The HLSDT variable is defined above and the IVMCT variable is a sequential number incremented by 1.
 ;
 ;
 N DGINC,DGINR,DGREL,I,IVMNTE,IVMPID,IVMSUB,IVMSUB1,IVMZRD,IVMZAV,VAFPID,VAFZEL,FBZFE,IVMZCD,DELETE,NODE,IVMPIEN,TEST,IVMPNODE,TESTTYPE,SEQS,TESTCODE
 N HARDSHIP,ACTVIEN,IVMZMH,IVMSEQ,EDBMTZ06,ZMHSQ,SETID,OBXCNT,OBXTMP,DGSEC,SEGOCC,ZIOSEG,N101015,RF1SEG,ZCTTYP,ZCTARY,ZCTSQ,VAFPID,CAFLG,IVMZAVA,VAFZTE
 N ERROR
 S IVMZAVA=""
 ;
 ; create (PID) Patient Identification segment
 ; **** Add ICN to 2nd piece PID segment for MPI@HEC.
 S IVMCMOR="1,2",IVMSEQ=1
 ; check to see if site is a legacy site.  If not add ICN to PID segment.
 I '$D(^PPP(1020.128,"AC",$P($$SITE^VASITE,"^",3))) D
 . I +$$GETICN^MPIF001(DFN)>0,($$IFLOCAL^MPIF001(DFN)=0) S IVMSEQ=IVMSEQ_",2",IVMCMOR="1,2,3"  ;add SEQ 1 and 2 for PID
 ;
 ; send SSN indicating pseudo
 ; I $P(IVMPID_$G(IVMPID(1)),HLFS,20)["P" D PSEUDO^IVMPTRN1  ; strip 'P' from pseudo SSNs
 S IVMSEQ=IVMSEQ_",3,5,6,7,8,10,11,12,13,14,16,17,19,22,24"
 K IVMPID D BLDPID^VAFCQRY1(DFN,1,IVMSEQ,.IVMPID,.HL,.ERROR)
 K VAFPID D STRIP11
 S SEGOCC="" F  S SEGOCC=$O(VAFPID(SEGOCC)) Q:SEGOCC=""  D
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=VAFPID(SEGOCC)
 ;
 ; **** create (PD1) Patient CMOR segment for MPI@HEC.
 S:'$D(HL("FS")) HL("FS")=HLFS
 S:'$D(HL("ECH")) HL("ECH")=HLECH
 S:'$D(HL("Q")) HL("Q")=HLQ
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLPD1(DFN,IVMCMOR)
 ;
 ; create (ZPD) Patient Dependent Info. segment
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN1^VAFHLZPD(DFN,"1,6,7,8,9,11,12,13,17,19,30,31,32,33,34,35,40"),IVMINS=$P(^(IVMCT),HLFS,12)
 I $D(VAFZPD(1)) S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=VAFZPD(1) K VAFZPD(1)
 ;
 ; create (ZTA) Temporary Address segment
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZTA(DFN,"1,2,3,4,5,6,7,8,9",,.HL)
 ; KUM IVM*2.0*164 - Set Flag to determine if Temporary address is in Message
 I $TR($P(^TMP("HLS",$J,IVMCT),HLFS,6),"~""""^","")'="" S IVMZAVA("C")=""
 ;
 ; KUM - IVM*2.0*164 - Send CASS field value for all Address Types
 ; create (ZAV) Rated Disabilities segment(s)
 D EN^VAFHLZAV(DFN,"1,2,3,",HLQ,HLFS,.IVMZAV,.IVMZAVA)
 F IVMSUB=0:0 S IVMSUB=+$O(IVMZAV("HL7",IVMSUB)) Q:'IVMSUB  D
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$G(IVMZAV("HL7",+IVMSUB))
 ;
 ; create (ZIE) Ineligible segment
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIE(DFN,"1,2,3",1)
 ;
 ; create (ZEL) Eligibility segment(s) 
 ; **** Add 5th piece to ZEL to correct consistency check
 ; added 41-44 for CLV IVM*2.0*161
 D EN1^VAFHLZEL(DFN,"1,2,5,6,7,8,10,11,13,14,15,16,17,18,19,20,21,22,23,24,25,29,34,35,37,38,39,40,41,42,43,44,45,46,47",2,.VAFZEL)
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$G(VAFZEL(1))  ; Primary Eligibility
 I $D(VAFZEL(1,1)) S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$G(VAFZEL(1,1))
 ; - other entitled eligibilities
 F IVMSUB=1:0 S IVMSUB=+$O(VAFZEL(IVMSUB)) Q:'IVMSUB  D
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$G(VAFZEL(+IVMSUB))
 ;
 ; create ZE2 segment (Optional)
 I $P($G(^DPT(DFN,.385)),U)'="" S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZE2(DFN,"1,2")
 ;
 ; create ZTE segments (optional)
 D EN^VAFHLZTE(DFN,"1,2,3,4,5,6,7,8,9,10,11,12,13",0,.VAFZTE)
 S IVMSUB=0 F  S IVMSUB=$O(VAFZTE(IVMSUB)) Q:'IVMSUB  D
 .S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$G(VAFZTE(IVMSUB))
 .S IVMSUB1=0 F  S IVMSUB1=$O(VAFZTE(IVMSUB,IVMSUB1)) Q:'IVMSUB1  S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$G(VAFZTE(IVMSUB,IVMSUB1))
 .Q
 ;
 ; create (ZEN) Enrollment segment
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZEN(DFN)
 ;
 ; create (ZCD) Catastrophic Disability segment(s)
 D BUILD^VAFHLZCD(.IVMZCD,DFN,,HLQ,HLFS)
 F IVMSUB=0:0 S IVMSUB=+$O(IVMZCD(IVMSUB)) Q:'IVMSUB  D
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$G(IVMZCD(+IVMSUB))
 ;
 ; Optionally create (ZMH) Military History segments
 ; Pass "*" as parameter to send unlimited MSEs in Z07 (IVM*2*141)
 D ENTER^VAFHLZMH(DFN,"IVMZMH","*")
 ;DJS, Don't create ZMH segment if array entry is an FDD MSE; IVM*2.0*167
 N ZMHED,MSESUB,DONEMSE
 S (ZMHSQ,SETID,DONEMSE)=0
 I $D(IVMZMH) F  S ZMHSQ=$O(IVMZMH(ZMHSQ)) Q:ZMHSQ=""  D
 . Q:$TR($P(IVMZMH(ZMHSQ,0),HLFS,4,5),"""^~")=""
 . ;If no Service Entry Date, QUIT
 . S ZMHED=$P(IVMZMH(ZMHSQ,0),U,5),ZMHED=$P(ZMHED,"~",1) Q:ZMHED=""
 . S ZMHED=$$HL7TFM^XLFDT(ZMHED)
 . ;Get MSE, if no more MSEs, process Conflict Information, if present
 . I 'DONEMSE S MSESUB="",MSESUB=$O(^DPT(DFN,.3216,"B",ZMHED,MSESUB)) S:MSESUB="" DONEMSE=1
 . ;Do not create ZMH segment if FDD MSE
 . I 'DONEMSE,$P(^DPT(DFN,.3216,MSESUB,0),U,8)'="" Q  ;Only check for FDD if MSE entry
 . S SETID=SETID+1,IVMCT=IVMCT+1
 . S ^TMP("HLS",$J,IVMCT)="ZMH"_HLFS_SETID_HLFS_$P(IVMZMH(ZMHSQ,0),HLFS,3,6)
 ;
 ; create (ZRD) Rated Disabilities segment(s)
 D EN^VAFHLZRD(DFN,"1,2,3,4,12,13,14,",HLQ,HLFS,"IVMZRD")
 F IVMSUB=0:0 S IVMSUB=+$O(IVMZRD(IVMSUB)) Q:'IVMSUB  D
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$G(IVMZRD(+IVMSUB,0))
 ;
 ; create (ZCT) Emergency Contact segment
 ;S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZCT(DFN,"1,2,3,4,5,6,7,10","",1,1)
 K ZCTARY F ZCTTYP=1:1:5 D   ;Create Optional ZCT Segments
 . S ZCTARY(ZCTTYP)=$$EN^VAFHLZCT(DFN,"1,2,3,4,5,6,7,10","",ZCTTYP,1)
 S (ZCTTYP,ZCTSQ)=0
 I $D(ZCTARY) F  S ZCTTYP=$O(ZCTARY(ZCTTYP)) Q:ZCTTYP=""  D
 . Q:$P(ZCTARY(ZCTTYP),HLFS,11)=HLQ
 . S ZCTSQ=ZCTSQ+1,$P(ZCTARY(ZCTTYP),HLFS,2)=ZCTSQ
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=ZCTARY(ZCTTYP)
 I ZCTSQ=0 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=ZCTARY(1)
 ;
 ; create (ZEM) Employment Info. segment for (1) Patient & (2) Spouse
 ;*168 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZEM(DFN,"1,2,3,4,5,6,7")
 ;*168 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZEM(DFN,"1,2,3,4,5,6,7",2,2)
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZEM(DFN,"1,2,3,4,5,6,7,9") ;re-enable imprecise date.
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZEM(DFN,"1,2,3,4,5,6,7,9",2,2)
 ;
 ; create (ZGD) Guardian segment for (1) VA & (2) Civil 
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZGD(DFN,"1,2,3,4,5,6,7,8",1)
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZGD(DFN,"1,2,3,4,5,6,7,8",2)
 ;
 ; Income Year requiring transmission from IVM Patient File (301.5)
 S IVMIY=$S($D(IVMIY):IVMIY,1:(IVMMTDT-10000))
 N MTINFO S MTINFO=$$FUT^DGMTU(DFN)
 I ($E(IVMIY,1,3)+1)=$E($P(MTINFO,U,2),1,3) S IVMMTDT=$P(MTINFO,U,2)
 ;get the primary test for the income year
 S TESTTYPE=$$GETTYPE^IVMPTRN9(DFN,IVMMTDT,.TESTCODE,.HARDSHIP,.ACTVIEN)
 ;
 ; The following function call returns:
 ;   - Patient Relation IEN array in DGREL
 ;   - Individual Annual Income IEN array in DGINC
 ;   - Income Relation IEN array in DGINR
 D ALL^DGMTU21(DFN,"VSC",IVMMTDT,"IPR",ACTVIEN)
 ;
 S EDBMTZ06=0 I $$VERZ06^EASPTRN1(DFN) S EDBMTZ06=1
 ; create (ZIC) Income segment for veteran
 S IVMCT=IVMCT+1
 ;IVM*2.0*115 -- Check for Means Test Version Indicator
 N MTVERS S MTVERS=$S(+$G(ACTVIEN):+$P($G(^DGMT(408.31,ACTVIEN,2)),"^",11),1:0)
 I MTVERS=0 D  I 1
 . S ^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIC(+$G(DGINC("V")),"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20")
 E  D
 . S ^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIC(+$G(DGINC("V")),"1,2,3,9,12,13,14,15,16,18,19")
 I EDBMTZ06 S ^TMP("HLS",$J,IVMCT)="ZIC^"_$P(^TMP("HLS",$J,IVMCT),"^",2,3)
 ;use IVMIY not IVMMTDT. For LTC copay exemption, IVMMTDT is not correct
 S $P(^TMP("HLS",$J,IVMCT),"^",3)=$$HLDATE^HLFNC(IVMIY)
 ;
 ; create (ZIR) Income Relation segment for veteran
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIR(+$G(DGINR("V")),"1,2,3,4,5,10,15")  ;IVM * 2.0 *160
 I EDBMTZ06 S ^TMP("HLS",$J,IVMCT)="ZIR^1"
 ;
 ; create (ZDP) Patient Dependent Info. segment for spouse
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZDP(+$G(DGREL("S")),"1,2,3,4,5,6,7,8,9,10,13,14")
 ;I $P(^TMP("HLS",$J,IVMCT),HLFS,3)'=HLQ,($P($G(^(IVMCT)),HLFS,6)=HLQ) D
 ;. ; - pass non-existent SSNs as 0s
 ;. S $P(X,HLFS,6)="000000000"
 ;
 ; create (ZIC) Income segment for spouse
 S IVMCT=IVMCT+1
 ;IVM*2.0*115
 I MTVERS=0 D  I 1
 . S ^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIC(+$G(DGINC("S")),"1,2,3,4,5,6,7,8,9,10,11,12,16,17,18,19,20")
 E  D
 . S ^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIC(+$G(DGINC("S")),"1,2,3,9,12,16,18,19")
 I EDBMTZ06 S ^TMP("HLS",$J,IVMCT)="ZIC^"_$P(^TMP("HLS",$J,IVMCT),"^",2,3)
 ;
 ; create (ZIR) Income Relation segment for spouse
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIR(+$G(DGINR("S")),"1,2,3")
 I EDBMTZ06 S ^TMP("HLS",$J,IVMCT)="ZIR^"_$P(^TMP("HLS",$J,IVMCT),"^",2)
 ;
 ;
 ; create ZDP, ZIC, and ZIR segments for all Means Test dependents
 F IVMSUB=0:0 S IVMSUB=$O(DGREL("C",IVMSUB)) Q:'IVMSUB  D
 . ;
 . ; - create (ZDP) Dependent Info. segment for dependent child
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZDP(+$G(DGREL("C",IVMSUB)),"1,2,3,4,5,6,7,9,10")
 .; I $P(^TMP("HLS",$J,IVMCT),HLFS,3)'=HLQ,($P($G(^(IVMCT)),HLFS,6)=HLQ) D
 .; . ; - pass non-existent SSNs as 0s
 .; . S $P(X,HLFS,6)="000000000"
 . ;
 . ; - create (ZIC) Income segment for dependent child
 . S IVMCT=IVMCT+1
 . ;IVM*2.0*115
 . I MTVERS=0 D  I 1
 . . S ^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIC(+$G(DGINC("C",IVMSUB)),"1,2,3,4,5,6,7,8,9,10,11,12,15")
 . E  D
 . . S ^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIC(+$G(DGINC("C",IVMSUB)),"1,2,3,9,12,15,16,18,19")
 . I EDBMTZ06 S ^TMP("HLS",$J,IVMCT)="ZIC^"_$P(^TMP("HLS",$J,IVMCT),"^",2,3)
 . ;
 . ; - create (ZIR) Income Relation segment for dependent child
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZIR(+$G(DGINR("C",IVMSUB)),"1,2,3,4,6,7,8,9,14,15")  ;IVM * 2.0 *160
 . I EDBMTZ06 S ^TMP("HLS",$J,IVMCT)="ZIR^"_$P(^TMP("HLS",$J,IVMCT),"^",2)
 . ;
 ; Send INACTIVE spouse/dependents.
 D GETINACD^DGMTU11(DFN,.DGREL)
 F I="S","C" D
 . F IVMSUB=0:0 S IVMSUB=$O(DGIREL(I,IVMSUB)) Q:'IVMSUB  D
 . . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZDP(+$G(DGIREL(I,IVMSUB)),"1,2,3,4,5,6,7,9,10,11",,,$P(DGIREL(I,IVMSUB),U,3))
 ;
 D GOTO^IVMPTRN9
 Q
 ;
STRIP11 N APID,ZPID,ASQ,ATYP,SSQ
 ;Extract PID segment
 S IVMPID(1)=$E(IVMPID(1),5,$L(IVMPID(1)))
 D BLDPID^IVMPREC6(.IVMPID,.APID)
 ;
 S CAFLG=0
 I $D(APID(11)) D
 .I $O(APID(11,"")) D  Q
 ..M ZPID(11)=APID(11) K APID(11)
 ..S (ASQ,SSQ)=0 F  S ASQ=$O(ZPID(11,ASQ)) Q:ASQ=""  D
 ...S ATYP=$P($G(ZPID(11,ASQ)),$E(HLECH),7) Q:ATYP=""
 ...;KUM - IVM*2.0*164 - Comment below 2 lines and Add line to enable all categories of Confidential Address
 ...;I (ATYP="VACAA")!(ATYP="VACAC")!(ATYP="VACAM")!(ATYP="VACAO") Q
 ...;I ATYP="VACAE" S CAFLG=1
 ...I (ATYP="VACAE")!(ATYP="VACAA")!(ATYP="VACAC")!(ATYP="VACAM")!(ATYP="VACAO") S CAFLG=1
 ...I (CAFLG=1) S IVMZAVA("CNF")=""
 ...I (ATYP="P") S IVMZAVA("P")=""
 ...I (ATYP="R") S IVMZAVA("R")=""
 ...S SSQ=SSQ+1,APID(11,SSQ)=ZPID(11,ASQ)
 .Q:$G(APID(11))=""
 .S ATYP=$P($G(APID(11)),$E(HLECH),7) Q:ATYP=""
 .;KUM - IVM*2.0*164 - Comment below 2 lines and Add line to enable all categories of Confidential Address
 .;I ATYP="VACAE" S CAFLG=1 Q
 .;I (ATYP="VACAA")!(ATYP="VACAC")!(ATYP="VACAM")!(ATYP="VACAO") K APID(11)
 .I (ATYP="VACAE")!(ATYP="VACAA")!(ATYP="VACAC")!(ATYP="VACAM")!(ATYP="VACAO") S CAFLG=1 Q
 ;
 I 'CAFLG,$D(APID(13)) D
 .I $O(APID(13,"")) D  Q
 ..S ASQ=0 F  S ASQ=$O(APID(13,ASQ)) Q:ASQ=""  D
 ...Q:$G(APID(13,ASQ))=""
 ...S ATYP=$P($G(APID(13,ASQ)),$E(HLECH),2) Q:ATYP=""
 ...I ATYP="VACPN" K APID(13,ASQ) Q
 .Q:$G(APID(13))=""
 .S ATYP=$P($G(APID(13)),$E(HLECH),2) Q:ATYP=""
 .I ATYP="VACPN" K APID(13) Q
 ;
 ;Rebuild PID
 D KVA^VADPT
 D MAKEIT^VAFHLU("PID",.APID,.VAFPID,.VAFPID)
 S VAFPID(0)=VAFPID
 Q
