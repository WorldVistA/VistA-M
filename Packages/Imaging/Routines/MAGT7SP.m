MAGT7SP ;WOIFO/MLH/PMK - telepathology - create HL7 message to DPS - segment build - PID ; 01 Jul 2013 11:01 AM
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
PIDSEG(SEGELTS,DFN) ; FUNCTION - main entry point - create a PID segment
 N COMPIX ; component index in an HL7 field
 N KT ; count / repetition index
 N LRDFN ; IEN on the lab data file
 N ERRSTAT S ERRSTAT=0 ; error status to be returned - assume nothing to report
 N VADM ; array for pt data return from VADPT
 N PTNAME ; patient name (from VADPT) and name elements (from XLFNAME)
 N DOB ; date of birth
 N VA ; array for data returned by DEM^VADPT
 N VAERR ; error code returned by VADPT calls
 N VACNTRY ; set in VADPT1
 N VAHOW ; how to return data from VADPT calls - default numeric subscripts
 N VAFY ; array for race/ethnic data return from VAFHLPI1
 N VAPA ; array for address data return from ADD^VADPT
 N VAPD ; array for other patient data from OPD^VADPT
 N RACECMPS ; elements of the RACE field
 N ETHCMPS ; elements of the ETHNICITY field
 N ADDRCMPS ; elements of the ADDRESS field
 N HL7NULL S HL7NULL="""""" ; null value for HL7 field deletion
 N HL7CECMPS ; components of the HL7 CE data type
 S HL7CECMPS="ID^TEXT^SYSTEM^ALTERNATE ID^ALTERNATE TEXT^ALTERNATE SYSTEM"
 N FLDPID S FLDPID=3 ; index of pt identifier field
 N FLDNAM S FLDNAM=5 ; index of pt name field
 N FLDDOB S FLDDOB=7 ; index of date-of-birth field
 N FLDSEX S FLDSEX=8 ; index of admin sex field
 N FLDRACE S FLDRACE=10 ; index of race field
 N FLDADDR S FLDADDR=11 ; index of address field
 N FLDHFON S FLDHFON=13 ; index of home phone field
 N FLDBFON S FLDBFON=14 ; index of business phone field
 N FLDETH S FLDETH=22 ; index of ethnicity field
 N X ; scratch variable
 I $G(DFN)'?1.N Q "-8`Invalid DFN format ("_$G(DFN)_")"
 I $G(DUZ(2))="" Q "-9`Cannot ascertain site number from DUZ(2) value ("_$G(DUZ(2))_")"
 K SEGELTS S SEGELTS="" ; always refresh *segment* array (not message array) on entry
 ;
 D DEM^VADPT ; get VA patient data
 S PTNAME=VADM(1)
 D STDNAME^XLFNAME(.PTNAME,"C") ; extract subelts of pt name for PID-5
 ;
 D SET^HLOAPI(.SEGELTS,"PID",0) ; segment type
 D  ; PID-3-patient identifier list
 . N AUTHORITY
 . S AUTHORITY=$S($$ISIHS^MAGSPID():"USIHS",1:"USVHA")
 . ; set elts of each of three repetitions:
 . ; 1=ID, 4=assigning authority, 5=ID type
 . D  ; first repetition is site-DFN
 . . D SET^HLOAPI(.SEGELTS,$$STATNUMB^MAGDFCNV()_"-"_DFN,FLDPID,1,1,1)
 . . D SET^HLOAPI(.SEGELTS,AUTHORITY,FLDPID,4,1,1)
 . . D SET^HLOAPI(.SEGELTS,"PI",FLDPID,5,1,1)
 . . Q
 . D  ; second repetition is ICN
 . . D SET^HLOAPI(.SEGELTS,$$GETICN^MPIF001(DFN),FLDPID,1,1,2)
 . . D SET^HLOAPI(.SEGELTS,AUTHORITY,FLDPID,4,1,2)
 . . D SET^HLOAPI(.SEGELTS,"NI",FLDPID,5,1,2)
 . . Q
 . D  ; third repetition is either SSN for the VA or Hospital Record Number for IHS
 . . D SET^HLOAPI(.SEGELTS,AUTHORITY,FLDPID,4,1,3)
 . . I $$ISIHS^MAGSPID() D  ; Hospital Record Number for IHS
 . . . D SET^HLOAPI(.SEGELTS,$G(VA("PID")),FLDPID,1,1,3)
 . . . D SET^HLOAPI(.SEGELTS,"MR",FLDPID,5,1,3)
 . . . Q
 . . E  D  ; SSN for the VA
 . . . D SET^HLOAPI(.SEGELTS,$P($G(VADM(2)),"^",1),FLDPID,1,1,3)
 . . . D SET^HLOAPI(.SEGELTS,"SS",FLDPID,5,1,3)
 . . . Q
 . . Q
 . Q
 D  ;PID-5-patient name
 . D SETXPN^HLOAPI4(.SEGELTS,.PTNAME,5)
 . D SET^HLOAPI(.SEGELTS,"L",5,7,1,1) ; "L"=legal name
 . Q
 S DOB=$$HLDATE^HLFNC($P($G(VADM(3)),"^",1))
 S X=$$STRIP0^MAG7UD("DOB") ; strip 0's off DOB
 D SET^HLOAPI(.SEGELTS,DOB,FLDDOB) ;PID-7-date/time of birth
 D SET^HLOAPI(.SEGELTS,$P($G(VADM(5)),"^",1),FLDSEX) ;PID-8-administrative sex
 D  ;PID-10-race
 . D SEQ10^VAFHLPI1("NB",HL7NULL) ; new race file values, both VA and CDC codes - returns VAFY()
 . S KT=0 F  S KT=$O(VAFY(FLDRACE,KT)) Q:'KT  D
 . . ; strip suffix, if any, off race and ethnicity codes (3rd piece)
 . . S VAFY(FLDRACE,KT,1)=$P(VAFY(FLDRACE,KT,1),"-",1,2)
 . . F COMPIX=1:1:6 S RACECMPS($P(HL7CECMPS,"^",COMPIX))=VAFY(FLDRACE,KT,COMPIX)
 . . D SETCE^HLOAPI4(.SEGELTS,.RACECMPS,FLDRACE,,KT)
 . . Q
 . Q
 D  ;PID-11-patient address
 . S VAHOW="" D ADD^VADPT ; fetch address with numeric subscripts - returns VAPA()
 . S ADDRCMPS("STREET1")=VAPA(1)
 . S ADDRCMPS("STREET2")=VAPA(2)
 . S ADDRCMPS("CITY")=VAPA(4)
 . S ADDRCMPS("STATE")=$P(VAPA(5),"^",2)
 . S ADDRCMPS("ZIP")=VAPA(6)
 . D SETAD^HLOAPI4(.SEGELTS,.ADDRCMPS,11)
 . Q
 D  ;PID-13-phone number-home
 . ; from VAPA() - populated earlier for PID-11
 . D SET^HLOAPI(.SEGELTS,"PRN",FLDHFON,2,1,1)
 . D SET^HLOAPI(.SEGELTS,"PH",FLDHFON,3,1,1)
 . D SET^HLOAPI(.SEGELTS,VAPA(8),FLDHFON,12,1,1)
 . Q
 D  ;PID-14-phone number-business
 . S VAHOW="" D OPD^VADPT ; fetch other patient data with numeric subscripts - returns VAPD()
 . D SET^HLOAPI(.SEGELTS,"WPN",FLDBFON,2,1,1)
 . D SET^HLOAPI(.SEGELTS,"PH",FLDBFON,3,1,1)
 . D SET^HLOAPI(.SEGELTS,VAPD(8),FLDBFON,12,1,1)
 . Q
 D  ;PID-22-ethnic group
 . D SEQ22^VAFHLPI1("NB",HL7NULL) ; new ethnicity file values, both VA and CDC codes - returns VAFY()
 . S KT=0 F  S KT=$O(VAFY(FLDETH,KT)) Q:'KT  D
 . . ; strip suffix, if any, off race and ethnicity codes (3rd piece)
 . . S VAFY(FLDETH,KT,1)=$P(VAFY(FLDETH,KT,1),"-",1,2)
 . . F COMPIX=1:1:6 S ETHCMPS($P(HL7CECMPS,"^",COMPIX))=VAFY(FLDETH,KT,COMPIX)
 . . D SETCE^HLOAPI4(.SEGELTS,.ETHCMPS,FLDETH,,KT)
 . . Q
 . Q
 Q ERRSTAT
