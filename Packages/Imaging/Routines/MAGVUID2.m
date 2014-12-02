MAGVUID2 ;WOIFO/NST - MAGV Generate UID ; 26 Jun 2013 5:09 PM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ;*****  Generate a new UID that is not unique
 ;       
 ; RPC:MAGV GENERATE UID
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; MAGPARAM("ACCESSION NUMBER")
 ; MAGPARAM("SITE")
 ; MAGPARAM("INSTRUMENT")
 ; MAGPARAM("TYPE") = "STUDY" or "SERIES" or "SOP"
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^New UID 
 ;
GENNWUID(MAGRY,MAGPARAM) ; RPC [MAGV GENERATE UID]
 N SSEP,UID
 ; 
 S ACNUMB=$G(MAGPARAM("ACCESSION NUMBER"))
 S SITE=$G(MAGPARAM("SITE"))
 S INSTR=$G(MAGPARAM("INSTRUMENT"))
 S TYPE=$G(MAGPARAM("TYPE"))
 ;
 S SSEP=$$STATSEP^MAGVRS41
 ;
 ; Verify input parameters
 I ACNUMB="" S MAGRY="-1"_SSEP_"Invalid ACCESSION NUMBER parameter" Q
 I SITE="" S MAGRY="-2"_SSEP_"Invalid SITE parameter" Q
 I INSTR="" S MAGRY="-3"_SSEP_"Invalid INSTRUMENT parameter" Q
 I (TYPE'="STUDY"),(TYPE'="SERIES"),(TYPE'="SOP") S MAGRY="-4"_SSEP_"Invalid TYPE parameter" Q
 ;   
 S UID=$$GENUID(ACNUMB,SITE,INSTR,TYPE) ; Generate a new UID
 ; Check for errors
 I $P(UID,"~")<0 S MAGRY="-5"_SSEP_$P(UID,"~",2) Q
 I UID="" S MAGRY="-6"_SSEP_"Unexpected UID generation error" Q 
 ;
 S MAGRY="0"_SSEP_UID
 Q
 ;
GENUID(ACNUMB,SITE,INSTR,TYPE)  ; Utility to Generate new UID for TYPE
 ; ACNUMB -- Accession Number
 ; SITE   -- Site
 ; INSTR  -- Instrument
 ; TYPE   -- "STUDY" or "SERIES" or "SOP"
 ;
 ; Remove alpha characters from SITE/STATION number
 ; 
 N I,ID,STAMP,UID,UINST,PGM
 ;
 S SITE=$E(SITE,1,3)
 ;
 S (UID,UINST)=""
 ;
 S ID=$S($E($P(ACNUMB,"-"),1)'?1N:$TR($H,",","")_$P(ACNUMB,"-",2),1:$TR(ACNUMB,"-",""))
 F I=1:1:$L(INSTR) S UINST=UINST+$A($E(INSTR,I))
 S SITE=SITE_"."_UINST
 S STAMP=$$NOW^XLFDT
 S STAMP=$TR($TR(STAMP,".","")," ","")
 S ID=+ID_+STAMP
 S PGM=TYPE_"^MAGVUID1(.UID,SITE,ID)"
 D @PGM
 Q UID
