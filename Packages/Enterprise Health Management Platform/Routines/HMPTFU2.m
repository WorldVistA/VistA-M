HMPTFU2 ;ASMR/JCH,CK,DKK - Utilities for the Treating Facility file 391.91 ;Apr 27, 2016 10:35:07
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2,3**;May 15, 2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIQ                          2056  ;DE6363 - JD - 8/23/16
 ;
 ; Reference to ^DGCN(391.91 is NOT currently supported; see ICR #2911 for an existing Private ICR between 
 ; Registration and CIRN that would meet the needs of this routine, or provide an example for a new ICR.
 ;
 Q
 ;
TFL(LIST,PT) ;for this PT [patient] (either DFN, ICN or EDIPI) return the list of treating facilities
 ; CALLED FROM RPC HMP LOCAL GET CORRESPONDINGIDS
 ; PT values :   Source ID^Source ID Type^Assigning Authority^Assigning Facility
 ;  ICN example:   1008520438V882204^NI^USVHA^200M
 ;  DFN example:   100000511^PI^USVHA^500
 ;  EDIPI example: 852043888^NI^USDOD^200DOD
 ;
 ; SOURCE ID:      SOURCE ID is the unique system assigned identifier at the identified facility for the
 ;                 patient record.  The value of SOURCE ID varies, depending on the source facility. 
 ;                 If SOURCE ID is from the Master Patient Index, the value is the Integration 
 ;                 Control Number (ICN).  If SOURCE ID is from the Department of Defense (DOD), the
 ;                 value is the Electronic Data Interchange Personal Identifier (EDIPI), which is 
 ;                 their equivalent of an ICN. In the future, SOURCE ID may come from other sources 
 ;                 due to additional initiatives.
 ;
 ; SOURCE ID TYPE: SOURCE ID TYPE defines the data source for the TREATING FACILITY LIST file (#391.91) entry.
 ;                 The source ID type is a reference to the HL7 Table 0203, Identifier Type, and the VA
 ;                 Identity Management user defined values: NI (National Identifier), PI (Patient Identifier)
 ; 
 ; Return:
 ; This will return the ICN and the list of treating facilities in the following format:
 ;   RESULT(n)=Id^IdType^AssigningFacility^AssigningAuthority^IdStatus
 ;     Examples:
 ;      RESULT(1)="1011232151V598646^NI^200M^A"
 ;      RESULT(2)="7168937^PI^91E3^USVHA^A"
 ;      RESULT(3)="852043888^NI^200DOD^USDOD^A"
 ;
 ; ID STATUS:      ID STATUS supports joint VA/DoD medical centers, Veteran's Record Management (VRM), and Virtual 
 ;                 Lifetime Electronic Record (VLER) initiatives.  This field allows the capture of resolved 
 ;                 duplicate events and exposes the related identifier and identifier status to the consuming 
 ;                 applications. A value of ""A"" indicates that the patient record is an active record on 
 ;                 the identifying system (e.g., VAMC or DoD). A value of "H" indicates that the patient 
 ;                 record was identified as part of a duplicate pair, has been merged, and is no longer active 
 ;                 on the identifying system (e.g., VAMC or DoD).
 ;
 N X,ICN,DFN,EDIPI,ASSIGN,ID,SITE,TYPE,SITEIEN,TFIEN
 ;
 ; Master Patient Index (MPI) must be installed to continue
 S X="MPIF001" X ^%ZOSF("TEST") I '$T S LIST(1)="-1^MPI Not Installed" Q
 ;
 K LIST ; Clear "return" variable
 ;
 ; what do we have
 S TYPE=$P(PT,"^",2) ; SOURCE ID TYPE
 S SITE=$P(PT,"^",4) ; 
 S ID=$P(PT,"^")
 S ASSIGN=$P(PT,"^",3)
 ; check input data
 I ID']"" S LIST(1)="-1^Id is not defined." Q
 I TYPE'="NI",TYPE'="PI" S LIST(1)="-1^Invalid Id Type." Q
 I ASSIGN'="USVHA",ASSIGN'="USDOD" S LIST(1)="-1^Invalid Assigning Authority." Q
 I SITE']"" S LIST(1)="-1^Missing Assigning Facility." Q
 ; find the ien for the station number
 S SITEIEN=$$FIND1^DIC(4,"","X",SITE,"D")
 I 'SITEIEN S LIST(1)="-1^Assigning Facility is not defined in database." Q
 I TYPE="PI",ASSIGN="USVHA" S DFN=ID
 I TYPE="NI",ASSIGN="USVHA",SITE="200M" S ICN=ID
 I TYPE="NI",ASSIGN="USDOD",SITE="200DOD" S EDIPI=ID
 I $D(ICN) S DFN=$$GETDFN^MPIF001(ICN) D  Q:$D(LIST(1))
 . I +DFN<0 S LIST(1)="-1^ICN is not known" Q
 . S SITEIEN=$$IEN^XUAF4($P($$SITE^VASITE,"^",3))
 ;
 I $D(DFN) S ICN=$$GETICN^MPIF001(DFN)
 ; DFN should be defined, but ICN may not.
 ;Use new xref AISS appropriately to retrieve DFN from EDIPI
 I $D(EDIPI)=""!(ASSIGN="")!(TYPE="")!(SITEIEN="") S LIST(1)="-1^Insufficient data" Q
 I $D(EDIPI),'$D(^DGCN(391.91,"AISS",EDIPI,ASSIGN,TYPE,SITEIEN)) D  Q
 . S LIST(1)="-1^EDIPI Record is unknown at this facility"
 I $D(EDIPI),$D(^DGCN(391.91,"AISS",EDIPI,ASSIGN,TYPE,SITEIEN)) D
 .S EN=$O(^DGCN(391.91,"AISS",EDIPI,ASSIGN,TYPE,SITEIEN,0))
 .S DFN=$P($G(^DGCN(391.91,EN,0)),"^")
 ;
 ; if ICN is not defined, it is OK, but DFN should be defined
 ; bad input, such as Id^NI^USVHA^123
 I '$G(DFN) S LIST(1)="-1^Invalid input" Q
 ; check DFN and Site to be matching an entry in file #391.91
 I '$O(^DGCN(391.91,"APAT",DFN,SITEIEN,0)) D  Q
 . S LIST(1)="-1^Id as '"_ID_"'"_" is not in database"
 ; DFN should be defined, but ICN may not.
 S X=$$QUERYTF($P($G(ICN),"V"),"LIST")
 I $P(X,U)="1" S LIST(1)="-1"_U_$P(X,U,2) Q
 Q
 ;
GETICN(EDIPI) ;return the ICN when EDIPI is passed
 N EN,DFN,ICN,IEN
 S IEN=$$IEN^XUAF4("200DOD")
 I 'IEN Q "-1^Unknown Assigning Facility."
 I '$D(^DGCN(391.91,"ASCR",EDIPI,IEN)) Q "-1^EDIPI Record is unknown at this facility"
 I $D(^DGCN(391.91,"ASCR",EDIPI,IEN)) D
 .S EN=$O(^DGCN(391.91,"ASCR",EDIPI,$$IEN^XUAF4("200DOD"),""))
 .S DFN=$P($G(^DGCN(391.91,EN,0)),"^")
 .I DFN'="" S ICN=$$GETICN^MPIF001(DFN)
 .I DFN="" S ICN="-1^No Site Record associated with this entry"
 Q ICN
 ;
QUERYTF(PAT,ARY) ;a query for Treating Facility.
 ;INPUT   PAT - The patient's ICN
 ;        ARY - The array in which to return the Treating facility info.
 ;OUTPUT  A list of the Treating Facilities in the array provided from
 ;        the parameter.  It will be in the structure of x(1), x(2) etc.
 ;  Ex  X(1)=<ID> ^ <ID TYPE> ^ <Assigning Authority> ^ <Assigning Facility> ^ <ID Status>
 ;
 ; This is also a function call.  If there is an error then "1^error description" will be returned. 
 ; If no data is found the array will not be populated and "1^error description" will be returned.
 ;
 N PDFN,HMPER,LP,CTR
 ;
 ; ICN is not required
 I ('$D(ARY)) S HMPER="1^Parameter missing." G QUERYTFQ
 S HMPER=0,CTR=1
 S X="MPIF001" X ^%ZOSF("TEST") I '$T G QUERYTFQ
 S PDFN=$G(DFN)
 I '$G(PDFN) S HMPER="1^DFN is not defined." G QUERYTFQ
 ;SET FIRST ENTRY TO BE THE ICN - FULL ICN - PAT IS NOT THE ICN
 S @ARY@(CTR)=$$GETICN^MPIF001(PDFN)_"^NI^200M^USVHA^A"
 ;**856 - MVI 1371 (ckn)
 ;Loop through all TFIENs for site
 ;F LP=0:0 S LP=$O(^DGCN(391.91,"APAT",PDFN,LP)) Q:'LP  S TFIEN=$O(^(LP,"")) D SET(TFIEN,ARY,.CTR)
 F LP=0:0 S LP=$O(^DGCN(391.91,"APAT",PDFN,LP)) Q:'LP  D
 .S TFIEN=0 F  S TFIEN=$O(^DGCN(391.91,"APAT",PDFN,LP,TFIEN)) Q:'TFIEN  D
 ..D SET(TFIEN,ARY,.CTR)
 I $D(@ARY)'>9 S HMPER="1^Could not find Treating Facilities"
QUERYTFQ Q HMPER
 ;
SET(TFIEN,ARY,CTR) ;This sets the array with the treating facility list.
 ;  Ex  ARY(1)=<ID> ^ <ID TYPE> ^ <Assigning Facility> ^ <Assigning Authority> ^ <ID Status>
 N DGCN,INSTIEN,SOURCE,EN,SDFN,STATUS,SITEN,ID,IDTYPE,SITE,ASSAUTH,FOUND,NODE,NODE0,NODE2,STNNUM
 S DGCN(0)=$G(^DGCN(391.91,TFIEN,0)),SITEN=""
 ;
 S INSTIEN=$P($G(DGCN(0)),"^",2) ;            TREATING FACILITY LIST (#391.91) INSTITUTION field (#.02)
 I INSTIEN'="" S SITEN=$$STA^XUAF4(INSTIEN) ; STATION from Institution IEN
 S ID=$P(DGCN(0),"^") ;                       ID=Patient DFN field (#.01)
 S STNNUM=SITEN
 ;
 S NODE2=$G(^DGCN(391.91,TFIEN,2))
 S SDFN=$P(NODE2,"^",2) ; SDFN="SOURCE ID"
 S STATUS=$P(NODE2,"^",3) ; STATUS="IDENTIFIER STATUS"
 S ASSAUTH=$P(NODE2,"^") ; Assigning Authority
 ;
 S NODE0=$G(^DGCN(391.91,TFIEN,0))
 S IDTYPE=$P(NODE0,"^",9) ; SOURCE ID TYPE
 ;
 I SITEN="200DOD"!(SITEN["200N") S IDTYPE="NI"
 I SITEN="200DOD" S ASSAUTH="USDOD"
 I IDTYPE="" S IDTYPE="PI"
 I ASSAUTH="" S ASSAUTH="USVHA"
 I SITEN["200N"&(IDTYPE="NI")&(ASSAUTH="USVHA") S ASSAUTH=""
 I IDTYPE="PI" S SITEN=$$TF2SITEN(TFIEN) Q:(SITEN=""&(STNNUM'="742V1"))
 ;
 ; If VA Internal Patient ID, get site hash from domain associated with Treating Facility
 S NODE0=$G(^DGCN(391.91,TFIEN,0))
 S NODE2=$G(^DGCN(391.91,TFIEN,2))
 S SDFN=$P(NODE2,"^",2),STATUS=$P(NODE2,"^",3),IDTYPE=$P(NODE0,"^",9)
 ; DE2345 - MBS 9/15/2015; Only return active entries
 I STATUS'="A" Q
 S ASSAUTH=$P(NODE2,"^")
 I SITEN="200DOD"!(SITEN["200N") S IDTYPE="NI"
 I SITEN="200DOD" S ASSAUTH="USDOD"
 I IDTYPE="" S IDTYPE="PI"
 I ASSAUTH="" S ASSAUTH="USVHA"
 I SITEN["200N"&(IDTYPE="NI")&(ASSAUTH="USVHA") S ASSAUTH=""
 I SDFN'="" S CTR=CTR+1,@ARY@(CTR)=SDFN_"^"_IDTYPE_"^"_SITEN_"^"_ASSAUTH_"^"_STATUS_"^"_STNNUM,FOUND=1
 Q
TF2SITEN(TFIEN) ;Find the DOMAIN associated with the TREATING FACILITY and return the station number.
 ;Currently, our test systems' station numbers are not set up for local DOMAINs. This would result in these
 ;entries failing all the time, thus breaking existing behavior. For the time being, we will default to
 ;the old behavior if we cannot locate a station number as a temporary measure. In the future, we need to
 ;fix the test systems to set up the station numbers correctly, and then change this code to return
 ;an empty string if the DOMAIN could not be resolved.
 S SITEN=""
 Q:'+$G(TFIEN) ""
 Q:'$D(^DGCN(391.91,TFIEN)) ""
 ;Get station number from Institution file (pointed to from Treating Facility List)
 N INSTNUM,STNNUM,DONE,I
 S INSTNUM=$P($G(^DGCN(391.91,TFIEN,0)),U,2) Q:'+INSTNUM SITEN
 S STNNUM=$$GET1^DIQ(4,INSTNUM_",",99) ;ICR 2056
 Q:'+STNNUM SITEN
 ;DE2345 - MBS 9/15/2015; Do not return entries with station numbers=+200
 I STNNUM?1"200".A Q ""
 ;Domain file doesn't have an x-ref on station number, so we have to brute-force it
 S (I,DONE)=0 F  S I=$O(^DIC(4.2,I)) Q:'+I  D  Q:DONE
 . I $P(^DIC(4.2,I,0),U,13)=STNNUM S SITEN=$$SYS^HMPUTILS($P(^DIC(4.2,I,0),U)),DONE=1
 Q SITEN
 ;
