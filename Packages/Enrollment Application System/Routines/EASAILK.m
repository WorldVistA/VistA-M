EASAILK ;ALB/BRM - ADDRESS INDEXING APIS ; 11/13/02 4:28pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**13**;Mar 15, 2001
 ;
 Q
 ;
GETFIPS(DFN,INCYR,AIGMT) ;get the appropriate FIPS code and address for GMT
 ;
 ;INPUT:
 ;   DFN - internal entry number for the #2 file
 ;   INCYR - (optional) income year for which the GMT Address will
 ;           be returned. If this value is null, then this function
 ;           will not check for an existing GMT address (i.e. new
 ;           MT, conversion, etc.) but will follow all other
 ;           applicable rules. INCYR is in internal FILEMAN format
 ;
 ;OUTPUT:
 ;   The AIGMT array will be returned with the FIPS code and
 ;   address data used to compute the FIPS code.  The array will
 ;   be structured as follows:
 ;     AIGMT("INCYR") - Income Year used to compute GMT Threshold
 ;     AIGMT("FIPS") - FIPS County Code to compute GMT Threshold
 ;     AIGMT("MSA") - MSA code associated with this zip code
 ;     AIGMT("ST1") - Street Address 1
 ;     AIGMT("ST2") - Street Address 2
 ;     AIGMT("CITY") - City
 ;     AIGMT("STATE") - State
 ;     AIGMT("ZIP") - Zip Code
 ;     AIGMT("COUNTY") - County
 ;     AIGMT("GMTIEN") - ien for the GMT Thresholds file
 ;     AIGMT("SOURCE") - this field will contain the source of the
 ;                       address.
 ;     AIGMT("SITE") - this field will hold the site number related
 ;                     to the source if AIGMT("SOURCE")="MT"
 ;
 ;   If AIGMT("SOURCE")="PATIENT" then the address used for obtaining
 ;     the County FIPS code information was based on the Patient's
 ;     address in the #2 file.
 ;
 ;   If AIGMT("SOURCE")="MT" then the address used to obtain the
 ;     county FIPS code information was based on the Primary Means
 ;     Test location.
 ;
 N X
 ; initialize AIGMT array values
 F X="FIPS","ST1","ST2","ST3","CITY","STATE","ZIP","COUNTY","SOURCE","SITE","INCYR","MSA","GMTIEN" S AIGMT(X)=""
 Q:'DFN
 S:'$G(INCYR) INCYR=($E($$DT^XLFDT,1,3)-1)
 S INCYR=$E(INCYR,1,3)_"0000"
 ; look for patient address in #2
 D PATIENT(DFN,.AIGMT,.INCYR) Q:AIGMT("SOURCE")'=""
 ; look for Primary Means Test location address
 D PRIMMT(DFN,.AIGMT,.INCYR)
 Q
 ;
PATIENT(DFN,AIGMT,INCYR) ;find patient's address in the Patient (#2) file
 Q:'$G(DFN)
 N ZIPDAT,VAPA,MSA,GMTIEN
 ; get patient address
 S VAPA("P")=1 D ADD^VADPT
 ; quit if no zip code is present on the Patient record
 Q:$G(VAPA(6))=""
 ; determine postal code validity
 D POSTAL^XIPUTIL(VAPA(6),.ZIPDAT)
 ; quit if FIPS cannot be determined for this zip code
 Q:$G(ZIPDAT("ERROR"))]""
 ; determine MSA code for this zip code
 S MSA=$$MSACHK(VAPA(6))
 ; determine if GMT Threshold exists for this zip code
 S GMTIEN=$$GMTCHK(.INCYR,$G(ZIPDAT("FIPS CODE")),.MSA)
 Q:'GMTIEN
 ; populate array
 S AIGMT("INCYR")=$G(INCYR)
 S AIGMT("FIPS")=$G(ZIPDAT("FIPS CODE"))
 S AIGMT("ST1")=$G(VAPA(1))
 S AIGMT("ST2")=$G(VAPA(2))
 S AIGMT("ST3")=$G(VAPA(3))
 S AIGMT("CITY")=$G(VAPA(4))
 S AIGMT("STATE")=$G(VAPA(5))  ;ien^state name
 S AIGMT("ZIP")=$G(VAPA(6))
 S AIGMT("COUNTY")=$G(ZIPDAT("COUNTY"))
 S AIGMT("MSA")=MSA
 S AIGMT("GMTIEN")=GMTIEN
 S AIGMT("SOURCE")="PATIENT"
 Q
 ;
PRIMMT(DFN,AIGMT,INCYR) ;find Primary MT location address
 N MTIEN,ZIPDAT,MTDATA,ERR,MTSRC,STATION
 S MTIEN=+$$LST^DGMTU(DFN,$$DT^XLFDT)
 Q:'MTIEN
 D GETS^DIQ(408.31,MTIEN_",",".23;2.05","I","MTDATA","ERR")
 Q:$D(ERR)
 S MTSRC=$G(MTDATA(408.31,MTIEN_",",.23,"I"))
 Q:"^2^3^"[("^"_MTSRC_"^")  ;DCD is the source of this income test
 S STATION=$G(MTDATA(408.31,MTIEN_",",2.05,"I"))
 Q:STATION']""
 ; get primary means test location address and populate array
 D STATADDR(STATION,.AIGMT,.INCYR)
 Q
 ;
STATADDR(STATION,AIGMT,INCYR) ;get the VAMC station address
 Q:$G(STATION)']""
 N ZIP,GMTIEN,FIPS,MSA,STFIPS,IEN4,IENS,ZIPDAT,IEN5,SITEADDR
 S IEN4=$$IEN^XUAF4(STATION) Q:'IEN4
 S IENS=IEN4_","
 D GETS^DIQ(4,IENS,"1.01:1.04","","SITEADDR")
 Q:$G(SITEADDR(4,IENS,1.04))=""
 ; determine postal code validity
 D POSTAL^XIPUTIL(SITEADDR(4,IENS,1.04),.ZIPDAT)
 ; quit if FIPS cannot be determined for this zip code
 Q:$G(ZIPDAT("ERROR"))]""
 ; determine MSA code for this zip code
 S MSA=$$MSACHK(SITEADDR(4,IENS,1.04))
 ; determine if GMT Threshold exists for this zip code
 S GMTIEN=$$GMTCHK(.INCYR,$G(ZIPDAT("FIPS CODE")),.MSA)
 Q:'GMTIEN
 ; populate array
 S AIGMT("INCYR")=$G(INCYR)
 S AIGMT("FIPS")=$G(ZIPDAT("FIPS CODE"))
 S AIGMT("ST1")=$G(SITEADDR(4,IENS,1.01))
 S AIGMT("ST2")=$G(SITEADDR(4,IENS,1.02))
 S AIGMT("ST3")=""
 S AIGMT("CITY")=$G(SITEADDR(4,IENS,1.03))
 S AIGMT("STATE")=$G(ZIPDAT("STATE POINTER"))_"^"_$G(ZIPDAT("STATE"))
 S AIGMT("ZIP")=$G(SITEADDR(4,IENS,1.04))
 S AIGMT("COUNTY")=$G(ZIPDAT("COUNTY"))
 S AIGMT("SITE")=STATION
 S AIGMT("MSA")=MSA
 S AIGMT("GMTIEN")=GMTIEN
 S AIGMT("SOURCE")="MT"
 Q
MSACHK(ZIP) ; check and return MSA code if it exists for a Zip Code
 Q:$G(ZIP)']"" ""
 Q:'$D(^EAS(712.6,"B",$E(ZIP,1,5))) ""
 Q $O(^EAS(712.6,"AMSA",$E(ZIP,1,5),""))
 ;
GMTCHK(YEAR,FIPS,MSA) ;check for valid GMT Threshold
 ;
 ;INPUT:
 ;  YEAR - Income Yr (FM internal) on which to base the GMT Threshold
 ;         If YEAR="" then the current income year is used
 ;  FIPS - 5-digit FIPS County Code for this record
 ;  MSA (pass by reference) - MSA to utilize for GMT determination
 ;
 ;OUTPUT:
 ;  MSA (pass by reference) - updated MSA code if applicable
 ;  return variable: 0^error if no GMT Threshold can be determined or
 ;                   ien to the GMT Threshold file
 ;
 Q:$G(FIPS)']"" "0^FIPS INPUT PARAMETER MISSING"
 S:'$G(MSA) MSA=$G(MSA)
 S:'$G(YEAR) YEAR=($E($$DT^XLFDT,1,3)-1)_"0000"
 Q:'MSA $$MSAZERO(YEAR,FIPS,.MSA)
 Q:'$D(^EAS(712.5,"AMSA",YEAR)) "0^INVALID YEAR"
 Q:'$D(^EAS(712.5,"AMSA",YEAR,FIPS)) "0^INVALID FIPS"
 Q:$D(^EAS(712.5,"AMSA",YEAR,FIPS,MSA)) $O(^EAS(712.5,"AMSA",YEAR,FIPS,MSA,""))
 S GMTIEN=$$MSAZERO(YEAR,FIPS,.MSA)
 Q:GMTIEN GMTIEN
 Q "0^GMT THRESHOLD CANNOT BE DETERMINED"
 ;
MSAZERO(YEAR,FIPS,MSA) ;MSA for this zip code appears to be zero. Can we
 ; determine a GMT Threshold?
 ;
 ;INPUT:
 ;  YEAR - Income Year on which to base the GMT Threshold
 ;  FIPS - 5-digit FIPS County Code for this record
 ;  MSA (pass by reference) - MSA to utilize for GMT determination
 ;
 ;OUTPUT:
 ;  MSA (pass by reference) - updated MSA code if applicable
 ;  return variable: 0 if no GMT Threshold can be determined or
 ;                   ien to the GMT Threshold file
 ;
 N TMPMSA,TMPGMT
 S GMTIEN="0^GMT THRESHOLD CANNOT BE DETERMINED",(TMPMSA,TMPGMT)=""
 Q:'$G(YEAR)!($G(FIPS)="") GMTIEN
 ;
 ; no MSA file entry - get GMT ien if possible
 I '$D(^EAS(712.5,"AMSA",YEAR,FIPS)) D  Q GMTIEN
 .I '$D(^EAS(712.5,"GMT",YEAR,FIPS)) Q
 .S GMTIEN=$O(^EAS(712.5,"GMT",YEAR,FIPS,""))
 ;
 ; Is there an entry for this MSA?
 I MSA'="",$D(^EAS(712.5,"AMSA",YEAR,FIPS,MSA)) D  Q GMTIEN
 .S GMTIEN=$O(^EAS(712.5,"AMSA",YEAR,FIPS,MSA,""))
 ;
 ; Is there only 1 MSA for this FIPS code?
 S TMPMSA=$O(^EAS(712.5,"AMSA",YEAR,FIPS,TMPMSA))
 Q:$O(^EAS(712.5,"AMSA",YEAR,FIPS,TMPMSA))'="" GMTIEN
 S GMTIEN=$O(^EAS(712.5,"AMSA",YEAR,FIPS,TMPMSA,""))
 S MSA=TMPMSA
 Q GMTIEN
 ;
 ;
FIPS(ZIP,INCYR) ; look-up the 5-digit FIPS County code for the entered zip
 ;
 ;INPUT:
 ;  ZIP - zip code
 ;  INCYR - (optional) income year to use to obtain the GMT Threshold
 ;          if the income year is not defined, then the current income
 ;          year is used.  INCYR is in Fileman internal date format
 ;
 ;OUTPUT:
 ;  5-digit FIPS code ^ MSA value ^ GMT Threshold ien ^ error message
 ;
 N MSA,GMTIEN,FIPS,ZIPDAT
 Q:$G(ZIP)="" "0^0^0^ZIP CODE NOT ENTERED"
 I $G(INCYR),INCYR?4N Q "0^0^0^INCOME YEAR MUST BE INTERNAL DATE"
 D POSTAL^XIPUTIL(ZIP,.ZIPDAT)
 Q:$G(ZIPDAT("ERROR"))]"" "0^0^0^ZIP CODE NOT IN POSTAL CODE FILE"
 S FIPS=$G(ZIPDAT("FIPS CODE")) S:FIPS']"" FIPS=0
 S MSA=$$MSACHK(ZIP)
 S GMTIEN=$$GMTCHK(.INCYR,FIPS,.MSA)
 Q FIPS_"^"_MSA_"^"_GMTIEN
 ;
