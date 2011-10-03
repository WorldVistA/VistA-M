DGQERPC ;ALB/RPM - VIC REPLACEMENT VISTA TO MAXIMUS RPC ; 10/04/05
 ;;5.3;Registration;**571,679**;Aug 13, 1993
 ;
 ; This routine contains the primary entry points to the 
 ; VistA to Maximus interface RPCs.
 ;
 Q  ;no direct entry
 ;
GETDEMO(RESULT,DGICN) ;retrieve patient demographics
 ;
 ; --rpc: DGQE GET PATIENT DEMO
 ;
 ; This remote procedure retrieves demographic data for a given patient
 ; and returns an array of text lines.  Each text line consists of at
 ; least two circumflex("^")-delimited fields.  The first field of each
 ; line contains an XML style tag (e.g. <RESULT>).  The second through
 ; nth fields contain data.
 ;
 ;  Supported References:                                               
 ;    DBIA #2701: $$GETDFN^MPIF001
 ;
 ;  Input:
 ;    DGICN - patient's Integration Control Number
 ;
 ;  Output:
 ;    RESULT - array of tag-labeled patient demographics
 ;
 ; Subscript  Field#  Field contents             Description
 ; ---------  ------  -------------------------  ----------------
 ;     1         1    <RESULT>                   RPC status tag
 ;               2    Card Print Release Status
 ;               3    "VIC"
 ;
 ;     2         1    <MSG>                      Remarks tag
 ;               2    Free text remarks
 ;
 ;     3         1    <NAME>                     Identifier tag
 ;               2    Full Name
 ;               3    Social Security Number
 ;               4    Date of Birth
 ;
 ;     4         1    <NAME1>                    Name components tag
 ;               2    Last Name
 ;               3    First Name
 ;               4    Middle Name
 ;               5    Name Suffix
 ;               6    Name Prefix
 ;
 ;     5         1    <TYPE>                     Veteran type tag
 ;               2    Service Connected Indicator
 ;               3    Prisoner of War Indicator
 ;               4    Purple Heart Indicator
 ;
 ;     6         1    <PATAS>                    Mailing address tag
 ;               2    Street Line 1
 ;               3    Street Line 2
 ;               4    Street Line 3
 ;
 ;     7         1    <PATAZ>                    Mailing address tag
 ;               2    City
 ;               3    State
 ;               4    Zip
 ;
 ;     8         1    <MPI>                     Master Patient Index tag
 ;               2    Integration Control Number
 ;               3    DFN
 ;
 ;     9         1    <SITE>                    Facility tag
 ;               2    Facility Name
 ;               3    Station Number
 ;               4    VISN
 ;
 N DGDFN   ;pointer to patient in PATIENT (#2) file
 N DGVIC   ;patient data array
 ;
 ;initialize patient data array
 D INITARR^DGQEUT1(.DGVIC)
 ;
 D  ;drop out of block on error
 . ;
 . ;check for input parameter
 . S DGDFN=+$$GETDFN^MPIF001($G(DGICN))
 . Q:(DGDFN'>0)
 . ;
 . ;build patient object
 . Q:'$$GETPAT^DGQEUT1(DGDFN,.DGVIC)
 . ;
 . ;build eligibility object
 . Q:'$$GETELIG^DGQEUT1(DGDFN,.DGVIC)
 ;
 ;determine card print release status and get into array
 D CPRSTAT^DGQEUT2(.DGVIC)
 ;
 ;build results document
 D BLDDOC(.DGVIC,.RESULT)
 ;
 Q
 ;
 ;
SETID(RESULT,DGICN,DGRSTAT,DGID) ;callback RPC from Maximus workstation
 ;
 ; --rpc: DGQE SET CARD ID
 ;
 ; This remote procedure provides a "callback" for the VIC PICS
 ; Workstation to notify VistA that a patient's VIC request has been
 ; successfully forwarded to the National Card Management Directory.
 ; The procedure creates an entry in the VIC REQUEST (#39.6) file when
 ; the Card Print Release Status is "H" [Hold].
 ; 
 ;  Supported References:                                               
 ;    DBIA #2701: $$GETDFN^MPIF001
 ;
 ;  Input:
 ;     DGICN - patient's Integration Control Number
 ;   DGRSTAT - card print release status
 ;      DGID - NCMD assigned Card ID
 ;
 ;  Output:
 ;    none
 ;
 N DGDFN  ;pointer to patient in PATIENT (#2) file
 ;
 S DGDFN=+$$GETDFN^MPIF001($G(DGICN))
 I DGDFN>0,$D(^DPT(DGDFN,0)),$G(DGRSTAT)]"" D
 . I $E(DGRSTAT)="H" D STOCID^DGQEREQ(DGID,DGDFN,DGRSTAT)
 S RESULT=1
 ;
 Q
 ;
 ;
BLDDOC(DGPAT,DGRSLT) ;build results document based on DOCMAP table
 ; This procedure uses the array subscript to field location table
 ; in linetag DOCMAP to format the GETDEMO RPC result array.
 ;
 ;  Input:
 ;    DGPAT - combined patient/eligibility data array
 ;
 ;  Output:
 ;    DGRSLT - RPC result array
 ;
 N DGFLD    ;table field location
 N DGLCNT   ;line count
 N DGLINE   ;line content
 N DGFLDNM  ;field name
 ;
 F DGLCNT=1:1 S DGLINE=$T(DOCMAP+DGLCNT) Q:DGLINE=""  D
 . S DGRSLT(DGLCNT)="<"_$P(DGLINE,";",3)_">"  ;set TAG
 . F DGFLD=4:1 S DGFLDNM=$P(DGLINE,";",DGFLD) Q:DGFLDNM=""  D
 . . S DGRSLT(DGLCNT)=DGRSLT(DGLCNT)_"^"_$G(DGPAT(DGFLDNM))
 ;
 Q
 ;
 ;
DOCMAP ;document field to array subscript map;TAG;FIELD1;FIELD2;...;FIELDn
 ;;RESULT;STAT;DOCTYPE
 ;;MSG;REMARKS
 ;;NAME;NAME;SSN;DOB
 ;;NAME1;LAST;FIRST;MIDDLE;SUFFIX;PREFIX
 ;;TYPE;SC;POW;PH
 ;;PATAS;STREET1;STREET2;STREET3
 ;;PATAZ;CITY;STATE;ZIP
 ;;MPI;ICN;DFN
 ;;SITE;FACNAME;FACNUM;VISN
