DGROUT ;DJH/AMA - ROM UTILITIES ; 28 Apr 2004  12:24 PM
 ;;5.3;Registration;**533,572**;Aug 13, 1993
 ;
 Q   ;no direct entry
 ;
MPIOK(DGDFN,DGICN,DGLST) ;return non-local LST and ICN
 ;This function retrieves an ICN given a pointer to the PATIENT (#2)
 ;file for a patient.  When the ICN is not local and the local site
 ;is not the Last Site Treated (LST), the LST is retrieved as a
 ;pointer to the INSTITUTION (#4) file.
 ;  Called from SNDQRY^DGROHLR
 ;
 ;  Supported DBIA #2701:  The supported DBIA is used to access MPI
 ;                         APIs to retrieve ICN, determine if ICN
 ;                         is local and if site is LST.
 ;  Supported DBIA #2702:  The supported DBIA is used to retrieve the
 ;                         MPI node from the PATIENT (#2) file.
 ;
 ;  Input:
 ;    DGDFN - IEN of patient in PATIENT (#2) file
 ;    DGICN - passed by reference to contain national ICN
 ;    DGLST - passed by reference to contain LST
 ;
 ;  Output:
 ;   Function Value - 1 on national ICN and non-local LST, 0 on failure
 ;            DGICN - Patient's Integrated Control Number
 ;            DGLST - Pointer to INSTITUTION (#4) file for LST if LST
 ;                    is not local, undefined otherwise.
 ;
 N DGRSLT
 S DGRSLT=0
 I $G(DGDFN)>0,$D(^DPT(DGDFN,"MPI")) D
 . S DGICN=$$GETICN^MPIF001(DGDFN)
 . ;
 . ;ICN must be valid
 . I (DGICN'>0) D  Q
 . . S DGMSG(1)=" "
 . . S DGMSG(2)="The query to the LST has been terminated because required"
 . . S DGMSG(3)="information was not provided by the MPI."
 . . D EN^DDIOL(.DGMSG) R A:5
 . ;
 . ;ICN must not be local
 . I $$IFLOCAL^MPIF001(DGDFN) D  Q
 . . S DGMSG(1)=" "
 . . S DGMSG(2)="The query to the LST has been terminated because required"
 . . S DGMSG(3)="information was not provided by the MPI."
 . . D EN^DDIOL(.DGMSG) R A:5
 . ;
 . ;Get LST from Treating Facility List
 . S DGLST=$$TFL(DGDFN)
 . ;
 . I (DGLST'>0) D  Q
 . . S DGMSG(1)=" "
 . . S DGMSG(2)="The query to the LST has been terminated because required"
 . . S DGMSG(3)="information was not provided by the MPI."
 . . D EN^DDIOL(.DGMSG) R A:5
 . ;
 . S DGRSLT=1
 Q DGRSLT
 ;
TFL(DFN) ;
 ;Retrieve Last Site Treated from the Treating Facility List ^DGCN(391.91
 ;This function will retrieve the most recent treatment site
 ;from the Treating Facility List (TFL) received from the MPI
 ;
 ;  Input:
 ;    DFN - (required) IEN of patient in PATIENT (#2) File
 ;
 ;  Output:
 ;    Function value - Facility IEN on success, 0 on failure
 ;
 N RSLT       ;Result returned from call
 N QFL        ;Quit flag
 N TFLDR      ;Treating Facility List Record Number
 N DATA       ;Array of TFL data
 N RDATA      ;Array of Treating Facilities arranged by date and TFLDR
 N DATE,TFL
 ;
 S (RSLT,QFL)=0
 ;Check to see if there is a TFL for this patient.
 ;If not exit and return -1 to call.
 I '$D(^DGCN(391.91,"B",DFN)) G EXITTFL
 ;
 ;Go through the "B" index of TFL file and retrieve
 ;record numbers for the patient DFN.
 S TFLDR="" F  S TFLDR=$O(^DGCN(391.91,"B",DFN,TFLDR)) Q:TFLDR=""  D
 . ;Retrieve data from record and store in DATA array by record number.
 . S DATA(TFLDR)=$G(^DGCN(391.91,TFLDR,0))
 . ;Extract DATE from 3rd piece of record
 . S DATE=$P(DATA(TFLDR),"^",3)
 . ;Quit if DATE is null
 . Q:DATE=""
 . ;Get Station Number using the facility pointer to the Institution (#4) file
 . S FAC=$P(DATA(TFLDR),"^",2)
 . S FAC=$$STA^XUAF4(FAC) Q:FAC=""
 . ;Build RDATA array using the DATE and TFLDR
 . S RDATA(DATE,TFLDR)=FAC
 ;Exit if the RDATA array does not exist.
 G:'$D(RDATA) EXITTFL
 ;
 ;Reverse order through the RDATA array (start with the latest date).
 ;Extract the treating facility from the RDATA array.
 ;Check the facility against local facility number:  if they are
 ;the same, then get the next facility.  (Should never happen)
 S DATE="" F  S DATE=$O(RDATA(DATE),-1) Q:DATE=""  D  Q:QFL=1
 . S TFL="" F  S TFL=$O(RDATA(DATE,TFL)) Q:TFL=""  D  Q:QFL=1
 . . S FAC=RDATA(DATE,TFL) I FAC=$G(DIV(0)) Q
 . . ;If the facility is not the current facility, then set RSLT to the facility and quit
 . . S RSLT=FAC,QFL=1  ;set QFL to 1 to stop going through the RDATA array
EXITTFL Q RSLT  ;Return the LST to the calling routine
