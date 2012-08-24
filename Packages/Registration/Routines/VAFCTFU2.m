VAFCTFU2 ;BHM/CMC,CKN-Utilities for the Treating Facility file 391.91, CONTINUED ; 5/23/12 6:25pm
 ;;5.3;Registration;**821,856**;Aug 13, 1993;Build 5
TFL(LIST,PT) ;for this PT [patient] (either DFN, ICN or EDIPI) return the list of treating facilities
 ; CALLED FROM RPC VAFC LOCAL GET CORRESPONDINGIDS
 ; PT values -->
 ;ICN example:   1008520438V882204^NI^USVHA^200M
 ;DFN example:   100000511^PI^USVHA^500
 ;EDIPI example: 852043888^NI^USDOD^200DOD
 ; 
 ; Return:
 ; This will return the ICN and the list of treating facilities in the following.
 ;
 ;   format:
 ;   Id^IdType^AssigningAuthority^AssigningFacility^IdStatus
 ;
 ;   Examples:
 ;   RESULT(1)="1011232151V598646^NI^200M^A"
 ;   RESULT(2)="7168937^PI^USVHA^500^A"
 ;   RESULT(3)="852043888^NI^USDOD^200DOD^A"
 ;
 N X,ICN,DA,DR,VAFCTFU1,DIC,DIQ,VAFC,DFN,EDIPI,ASSIGN,ID,SITE,TYPE
 S X="MPIF001" X ^%ZOSF("TEST") I '$T S LIST(1)="-1^MPI Not Installed" Q
 ; clear "return" variable
 K LIST
 ; what do we have
 S TYPE=$P(PT,"^",2),SITE=$P(PT,"^",4),ID=$P(PT,"^"),ASSIGN=$P(PT,"^",3)
 ; check input data
 I ID']"" S LIST(1)="-1^Id is not defined." Q
 I TYPE'="NI",TYPE'="PI" S LIST(1)="-1^Invalid Id Type." Q
 I ASSIGN'="USVHA",ASSIGN'="USDOD" S LIST(1)="-1^Invalid Assigning Authority." Q
 I SITE']"" S LIST(1)="-1^Missing Assigning Facility." Q
 ; find the ien for the station number
 S SITEIEN=$O(^DIC(4,"D",SITE,0))
 I 'SITEIEN S LIST(1)="-1^Assigning Facility is not defined in database." Q
 ;
 I TYPE="PI",ASSIGN="USVHA" S DFN=ID
 I TYPE="NI",ASSIGN="USVHA",SITE="200M" S ICN=ID
 I TYPE="NI",ASSIGN="USDOD",SITE="200DOD" S EDIPI=ID
 I $D(ICN) S DFN=$$GETDFN^MPIF001(ICN) D  Q:$D(LIST(1))
 . I +DFN<0 S LIST(1)="-1^ICN is not known" Q
 . S SITEIEN=$$IEN^XUAF4($P($$SITE^VASITE,"^",3))
 ;
 I $D(DFN) S ICN=$$GETICN^MPIF001(DFN)
 ; DFN should be defined, but ICN may not.
 ; I $D(EDIPI) S ICN=$$GETICN(EDIPI)
 ; check EDIPI
 ;I $D(EDIPI),'$D(^DGCN(391.91,"ASCR",EDIPI,SITEIEN)) D  Q
 ;. S LIST(1)="-1^EDIPI Record is unknown at this facility"
 ;I $D(EDIPI),$D(^DGCN(391.91,"ASCR",EDIPI,SITEIEN)) D
 ;.S EN=$O(^DGCN(391.91,"ASCR",EDIPI,SITEIEN,0))
 ;.S DFN=$P($G(^DGCN(391.91,EN,0)),"^")
 ;**856 MVI 1371 (ckn)
 ;Use new xref AISS appropriately to retrieve DFN from EDIPI
 I $D(EDIPI)=""!(ASSIGN="")!(TYPE="")!(SITEIEN="") S LIST(1)="-1^Insufficient data" Q
 I $D(EDIPI),'$D(^DGCN(391.91,"AISS",EDIPI,ASSIGN,TYPE,SITEIEN)) D  Q
 . S LIST(1)="-1^EDIPI Record is unknown at this facility"
 I $D(EDIPI),$D(^DGCN(391.91,"AISS",EDIPI,ASSIGN,TYPE,SITEIEN)) D
 .S EN=$O(^DGCN(391.91,"AISS",EDIPI,ASSIGN,TYPE,SITEIEN,0))
 .S DFN=$P($G(^DGCN(391.91,EN,0)),"^")
 ;
 ; if ICN is not defined, it is OK, but DFN should be defined
 ; I $G(ICN)<0 S LIST(1)=ICN Q
 ; bad input, such as Id^NI^USVHA^123
 I '$G(DFN) S LIST(1)="-1^Invalid input" Q
 ; check DFN and Site to be matching an entry in file #391.91
 I '$O(^DGCN(391.91,"APAT",DFN,SITEIEN,0)) D  Q
 . S LIST(1)="-1^Id as '"_ID_"'"_" is not in database"
 ; DFN should be defined, but ICN may not.
 S X=$$QUERYTF($P($G(ICN),"V"),"LIST")
 I $P(X,U)="1" S LIST(1)="-1"_U_$P(X,U,2) Q
 ;S DR=".01;13;99",DIC=4,DIQ(0)="E",DIQ="VAFCTFU2"
 ;F VAFC=0:0 S VAFC=$O(LIST(VAFC)) Q:VAFC=""  D
 ;.K VAFCTFU2
 ;.S DA=+LIST(VAFC)
 ;.D EN^DIQ1
 ;.S LIST(VAFC)=VAFCTFU2(4,+LIST(VAFC),99,"E")_"^"_VAFCTFU2(4,+LIST(VAFC),.01,"E")_"^"_$P(LIST(VAFC),"^",2)_"^"_$P(LIST(VAFC),"^",3)_"^"_VAFCTFU2(4,+LIST(VAFC),13,"E")_"^"_$P(LIST(VAFC),"^",4)
 Q
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
SET(TFIEN,ARY,CTR) ;This sets the array with the treating facility list.
 ;  Ex  ARY(1)=<ID> ^ <ID TYPE> ^ <Assigning Authority> ^ <Assigning Facility> ^ <ID Status>
 N DGCN,INSTIEN,LSTA,SOURCE,EN,NODE,SDFN,STATUS,SITEN,ID,IDTYPE,SITE,ASSAUTH,FOUND,NODE0,NODE2
 S DGCN(0)=$G(^DGCN(391.91,TFIEN,0)),SITEN=""
 ;** FROM DG*5.3*800 - (ckn) - Quit if IPP field is not set for 200MH record
 S INSTIEN=$P($G(DGCN(0)),"^",2),LSTA=$$STA^XUAF4(INSTIEN)
 I $E(LSTA,1,5)="200MH",$P($G(DGCN(0)),"^",8)'=1 Q
 S ID=$P(DGCN(0),"^"),SITE=$P(DGCN(0),"^",2) I SITE'="" S SITEN=$$STA^XUAF4(SITE)
 ;S IDTYPE="PI"
 ;I SITEN="200DOD"!(SITEN["200N") S IDTYPE="NI"
 ;S ASSAUTH="USVHA"
 ;I SITEN="200DOD" S ASSAUTH="USDOD"
 ; GET SOURCE ID AND SOURCE STATUS - CAN BE MORE THAN ONE
 ;^DGCN(391.91,14842,0)=7169806^17942
 ;^DGCN(391.91,14842,1,0)=^391.9101A^2^2
 ;^DGCN(391.91,14842,1,1,0)=1^A
 ;^DGCN(391.91,14842,1,2,0)=2^H
 ;^DGCN(391.91,14842,1,"B",1,1)=
 ;^DGCN(391.91,14842,1,"B",2,2)=
 ;^DGCN(391.91,1708,0)=7169806^500^3081204.152808^^^^1
 ;^DGCN(391.91,1708,1,0)=^391.9101A^1^1
 ;^DGCN(391.91,1708,1,1,0)=27^H
 ;^DGCN(391.91,1708,1,"B",27,1)=
 ;**856 - MVI 1371 (ckn)
 ;After DG*5.3*837 - TREATING FACILITY LIST file #391.91 does not
 ;store Source Id value in SOURCE ID multiple field. This field is
 ;is moved to top level. We no longer need to loop through SOURNCE ID
 ;multiple to get the values.
 ;S SOURCE="",FOUND=0
 ;I $D(^DGCN(391.91,TFIEN,1)) D
 ;.S EN=0 F  S EN=$O(^DGCN(391.91,TFIEN,1,EN)) Q:EN=""  D
 ;..;S NODE=$G(^DGCN(391.91,TFIEN,1,EN,0))
 S NODE0=$G(^DGCN(391.91,TFIEN,0))
 S NODE2=$G(^DGCN(391.91,TFIEN,2))
 S SDFN=$P(NODE2,"^",2),STATUS=$P(NODE2,"^",3),IDTYPE=$P(NODE0,"^",9)
 S ASSAUTH=$P(NODE2,"^")
 I SITEN="200DOD"!(SITEN["200N") S IDTYPE="NI"
 I SITEN="200DOD" S ASSAUTH="USDOD"
 I IDTYPE="" S IDTYPE="PI"
 I ASSAUTH="" S ASSAUTH="USVHA"
 I SITEN["200N"&(IDTYPE="NI")&(ASSAUTH="USVHA") S ASSAUTH=""
 ;S SDFN=$P(NODE,"^"),STATUS=$P(NODE,"^",2)
 I SDFN'="" S CTR=CTR+1,@ARY@(CTR)=SDFN_"^"_IDTYPE_"^"_ASSAUTH_"^"_SITEN_"^"_STATUS,FOUND=1
 ;I FOUND=0 S CTR=CTR+1,@ARY@(CTR)=""_"^"_IDTYPE_"^"_ASSAUTH_"^"_SITEN
 Q
 ;
QUERYTF(PAT,ARY) ;a query for Treating Facility.
 ;INPUT   PAT - The patient's ICN
 ;        ARY - The array in which to return the Treating facility info.
 ;OUTPUT  A list of the Treating Facilities in the array provided from
 ;        the parameter.  It will be in the structure of x(1), x(2) etc.
 ;  Ex  X(1)=<ID> ^ <ID TYPE> ^ <Assigning Authority> ^ <Assigning Facility> ^ <ID Status>
 ;
 ;    This is also a function call.  If there is an error then a 
 ;    1^error description will be returned. 
 ;
 ;  *** If no data is found the array will not be populated and
 ;  a 1^error description will be returned.
 ;
 N PDFN,VAFCER,LP,CTR
 ;
 ; ICN is not required, comment out
 ; I '$G(PAT)!('$D(ARY)) S VAFCER="1^Parameter missing." G QUERYTFQ
 I ('$D(ARY)) S VAFCER="1^Parameter missing." G QUERYTFQ
 S VAFCER=0,CTR=1
 S X="MPIF001" X ^%ZOSF("TEST") I '$T G QUERYTFQ
 ; ICN is not required, comment out
 ; S PDFN=$$GETDFN^MPIF001(PAT)
 ; I PDFN<0 S VAFCER="1^No patient DFN." G QUERYTFQ
 S PDFN=$G(DFN)
 I '$G(PDFN) S VAFCER="1^DFN is not defined." G QUERYTFQ
 ;SET FIRST ENTRY TO BE THE ICN - FULL ICN - PAT IS NOT THE ICN
 S @ARY@(CTR)=$$GETICN^MPIF001(PDFN)_"^NI^USVHA^200M^A"
 ;**856 - MVI 1371 (ckn)
 ;Loop through all TFIENs for site
 ;F LP=0:0 S LP=$O(^DGCN(391.91,"APAT",PDFN,LP)) Q:'LP  S TFIEN=$O(^(LP,"")) D SET(TFIEN,ARY,.CTR)
 F LP=0:0 S LP=$O(^DGCN(391.91,"APAT",PDFN,LP)) Q:'LP  D
 .S TFIEN=0 F  S TFIEN=$O(^DGCN(391.91,"APAT",PDFN,LP,TFIEN)) Q:'TFIEN  D
 ..D SET(TFIEN,ARY,.CTR)
 I $D(@ARY)'>9 S VAFCER="1^Could not find Treating Facilities"
QUERYTFQ Q VAFCER
 ;
NEWTF(RESULT,DFN,EDIPI) ;
 ; for MPIC_2019
 ; called from RPC: VAFC NEW NC TREATING FACILITY
 ; Input:
 ;   DFN: Vista Patient Identifier will be the PATIENT file (#2) IEN (aka DFN)
 ;        example of DFN="7168937"
 ;
 ;   EDIPI: The DOD Identifier will be EDIPI data with the
 ;          following format:
 ;          Id^IdType^AssigningAuthority^AssigningFacility
 ;          example:  852043888^NI^USDOD^200DOD
 ;
 ; Return:
 ; This will return a list of treating facilities in the following.
 ;
 ;   format:
 ;   Id^IdType^AssigningAuthority^AssigningFacility^IdStatus[^NEW]
 ;
 ;   Examples:
 ;   RESULT(1)="7168937^PI^USVHA^500^A"
 ;   RESULT(2)="85204388^NI^USDOD^200DOD^A^NEW"
 ;     Note: If there is data in the 6th piece of the RESULT(<number>),
 ;       with data value as "NEW", then it means that the entry was
 ;       newly created in the TREATING FACILITY LIST (#391.91) file
 ;       by this RPC call.
 ;
 N X,TYPE,SITE,ID,ASSIGN,PTDFN,LP,CTR,NCTFIEN,ERROR,II
 S X="MPIF001" X ^%ZOSF("TEST") I '$T S RESULT(1)="-1^MPI Not Installed" Q
 ; clear "return" variable
 K RESULT
 ; input parameters
 S PTDFN=$G(DFN)
 I 'PTDFN S RESULT(1)="-1^Invalid DFN:"""_PTDFN_"""" Q
 ; check the field #.01 data in patient entry
 I $P($G(^DPT(PTDFN,0)),"^")']"" D  Q
 . S RESULT(1)="-1^No patient in database for the DFN:"_PTDFN
 ;
 S ID=$P(EDIPI,"^"),TYPE=$P(EDIPI,"^",2),ASSIGN=$P(EDIPI,"^",3)
 S SITE=$P(EDIPI,"^",4)
 ;
 I ID']"" S RESULT(1)="-1^Id is not defined." Q
 I TYPE'="NI" S RESULT(1)="-1^Invalid Id Type." Q
 I ASSIGN'="USDOD" S RESULT(1)="-1^Invalid Assigning Authority." Q
 I SITE'="200DOD" S RESULT(1)="-1^Invalid Assigning Facility." Q
 S SITEIEN=$O(^DIC(4,"D","200DOD",0))
 I 'SITEIEN S RESULT(1)="-1^Assigning Facility is not defined in database." Q
 ;
 ; get ien of file #391.91
 S NCTFIEN=$O(^DGCN(391.91,"APAT",PTDFN,SITEIEN,0))
 ;
 ; Assigning Facility as "200DOD" of the patient is already existed
 ; in file #391.91
 S CTR=0
 I NCTFIEN D  Q
 . N TFIEN
 . F LP=0:0 S LP=$O(^DGCN(391.91,"APAT",PTDFN,LP)) Q:'LP  S TFIEN=$O(^(LP,0)) D
 .. Q:'TFIEN
 .. ; retrieve entry in file #391.91
 .. D SET(TFIEN,"RESULT",.CTR)
 ;
 ; add new entry to file #391.91
 D FILENEW^VAFCTFU(PTDFN,SITEIEN,"","","",.ERROR,"",ID,"A")
 I $D(ERROR(SITEIEN)) D  Q
 . S RESULT(1)="-1^"_$G(ERROR(SITEIEN))
 ;
 ; for Cache client/server model in case that there is a delay for
 ; retrieving the new created entry.
 F II=1:1:5 Q:$O(^DGCN(391.91,"APAT",PTDFN,SITEIEN,0))  H II
 ; retrieving the results
 F LP=0:0 S LP=$O(^DGCN(391.91,"APAT",PTDFN,LP)) Q:'LP  S TFIEN=$O(^(LP,0)) D
 . Q:'TFIEN
 . ; retrieve entry in file #391.91
 . D SET(TFIEN,"RESULT",.CTR)
 . I $P($G(RESULT(CTR)),"^",3)="USDOD" S RESULT(CTR)=RESULT(CTR)_"^NEW"
 Q
 ;
