RGFIU ;ALB/CJM-MPI/PD NDBI MERGE UTILITY (CONTINUED) ;08/27/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**5,13,25**;30 Apr 99
 ;
STATNUM(IEN) ;
 ;Description:  Given an ien to the Institution file, returns as the function value the station number.  Returns "" on failure.
 ;
 N STATION
 Q:'$G(IEN) ""
 Q:'$D(^DIC(4,IEN,0)) ""
 S STATION=$P($$NNT^XUAF4(IEN),"^",2)
 Q $S(+STATION:STATION,1:"")
 ;
UPD(FILE,RGDA,DATA,ERROR) ;File data into an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   RGDA - New name for traditional DA array, with same meaning.
 ;            Pass by reference.
 ;   DATA - Data array to file (pass by reference)
 ;          Format: DATA(<field #>)=<value>
 ;
 ; Output:
 ;  Function Value -     0=error and 1=no error
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To update a record in subfile 2.0361 in record with ien=353,
 ;          subrecord ien=68, with the field .01 value = 21:
 ;    S DATA(.01)=21,RGDA=68,RGDA(1)=353 I $$UPD^RGFIU(2.0361,.RGDA,.DATA,.ERROR) W !,"DONE"
 ;
 N FDA,FIELD,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;FDA - the FDA array as defined by FM
 ;
 I '$G(RGDA) S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED" Q 0
 S IENS=$$IENS^DILF(.RGDA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 D FILE^DIE("K","FDA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 E  D
 .S ERROR=""
 ;
 I $S(+$G(DIERR):0,1:1) D CLEAN^DILF Q 1
 E  D CLEAN^DILF Q 0
 ;
GETFIELD(FILE,FIELD,RGDA,ERROR,EXT) ;Get field value from an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   RGDA - New name for traditional DA array, with same meaning.
 ;            Pass by reference.
 ;   FIELD - Field for which value is needed
 ;   EXT - (optional) If $G(EXT) then returns the external display form of the value
 ; Output:
 ;  Function Value -  field value in internal format,"" if an error was encountered
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 N FDA,IENS,ERRORS,VALUE
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;FDA - the FDA array as defined by FM
 ;
 I '$G(RGDA) S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED" Q ""
 S IENS=$$IENS^DILF(.RGDA)
 S VALUE=$$GET1^DIQ(FILE,IENS,FIELD,$S($G(EXT):"",1:"I"),,"ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 E  D
 .S ERROR=""
 ;
 I $S(+$G(DIERR):0,1:1) D CLEAN^DILF Q VALUE
 E  D CLEAN^DILF Q ""
 ;
DELETE(FILE,RGDA,ERROR) ;Delete an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   RGDA - New name for traditional DA array, with same meaning.
 ;            Pass by reference.
 ;
 ; Output:
 ;  Function Value -     0=error and 1=no error
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To delete a record in subfile 2.0361 in record with ien=353,
 ;          subrecord ien=68:
 ;    S RGDA=68,RGDA(1)=353 I $$DELETE^RGFIU(2.0361,.RGDA,.DATA,.ERROR) W !,"DONE"
 ;
 N DATA
 S DATA(.01)="@"
 Q $$UPD^RGFIU(FILE,.RGDA,.DATA,.ERROR)
 Q
 ;
ADD(FILE,RGDA,DATA,ERROR,IEN) ;
 ;Description: Creates a new record and files the data.
 ; Input:
 ;   FILE - File or sub-file number
 ;   RGDA - New name for traditional FileMan DA array with same
 ;            meaning. Pass by reference.  Only needed if adding to a
 ;            subfile.
 ;   DATA - Data array to file, pass by reference
 ;          Format: DATA(<field #>)=<value>
 ;   IEN - internal entry number to use (optional)
 ;
 ; Output:
 ;   Function Value - If no error then it returns the ien of the created record, else returns NULL.
 ;  RGDA - returns the ien of the new record, NULL if none created.  If needed, pass by reference.
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To add a record in subfile 2.0361 in the record with ien=353
 ;          with the field .01 value = 21:
 ;  S DATA(.01)=21,RGDA(1)=353 I $$ADD^RGFIU(2.0361,.RGDA,.DATA) W !,"DONE"
 ;
 ; Example: If creating a record not in a subfile, would look like this:
 ;          S DATA(.01)=21 I $$ADD^RGFIU(867,,.DATA) W !,"DONE"
 ;
 N FDA,FIELD,IENA,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;IENA - the Internal Entry Numebr Array defined by FM
 ;FDA - the FDA array defined by FM
 ;IEN - the ien of the new record
 ;
 S RGDA="+1"
 S IENS=$$IENS^DILF(.RGDA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 I $G(IEN) S IENA(1)=IEN
 D UPDATE^DIE("","FDA","IENA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 .S IEN=""
 E  D
 .S IEN=IENA(1)
 .S ERROR=""
 D CLEAN^DILF
 S RGDA=IEN
 Q IEN
 ;
TESTVAL(FILE,FIELD,VALUE) ;
 ;Description: returns 1 if VALUE is a valid value for FIELD in FILE
 ;
 Q:(('$G(FILE))!('$G(FIELD))) 0
 ;
 N DISPLAY,VALID,RESULT
 S VALID=1
 ;
 ;if there is no external value then it is not valid
 S DISPLAY=$$EXTERNAL^DILFD(FILE,FIELD,"F",VALUE)
 I (DISPLAY="") S VALID=0
 ; 
 I VALID,$$GET1^DID(FILE,FIELD,"","TYPE")'["POINTER" D
 .D CHK^DIE(FILE,FIELD,,VALUE,.RESULT) I RESULT="^" S VALID=0 Q
 Q VALID
 ;
GETLINK(INSTIEN) ;
 ;Description:  Returns name of logical link for institition, given the institution ien.  Returns "" if a logical link name not found.
 ;
 Q:'$G(INSTIEN) ""
 ;
 N LINK,I,LINKNAME
 S LINKNAME=""
 D
 .;don't check if enabled - if shut down, message will be queued
 .;Q:'$$CHKLL^HLUTIL(INSTIEN)
 .;
 .D LINK^HLUTIL3(INSTIEN,.LINK)
 .S I=$O(LINK(0))
 .I I,$L(LINK(I)) S LINKNAME=LINK(I)
 Q LINKNAME
 ;
ASKYESNO(PROMPT,DEFAULT) ;
 ;Description: Displays PROMPT, appending '?'.  Expects a YES NO response.
 ;Input:
 ;   PROMPT - text to display as prompt.  Appends '?'
 ;   DEFAULT - (optional) YES or NO.  If not passed, defaults to YES
 ;Output:
 ;  Function value: 1 if yes, 0 if no, "" if '^' entered or timeout
 ;
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")=PROMPT
 S DIR("B")=$S($G(DEFAULT)="NO":"NO",1:"YES")
 D ^DIR
 Q:$D(DIRUT) ""
 Q Y
 ;
EXC(RGEXC,RGERR,RGDFN,RGMSGID,RGSITE) ;
 ;Description: Calls the MPI/PD Exception Handler
 ;Inputs:
 ;  RGEXC - the exception type
 ;  RGERR - (optional) text
 ;  RGDFN - (optional) patient DFN
 ;  RGMSGID - (optional) HL7 message id
 ;  RGSITE - (optional) station # of site where the exception occurred
 N ICN
 I +$G(RGDFN) D
 .S ICN=+$$GETICN^MPIF001(RGDFN)
 .I ICN'>0 S ICN=""
 .S RGERR=$G(RGERR)_"  Patient Name: "_$E($$NAME(RGDFN),1,25)_" SSN: "_$$SSN(RGDFN)_"  ICN: "_ICN
 D EXC^RGHLLOG($G(RGEXC),$E($G(RGERR),1,235),$G(RGDFN),$G(RGMSGID),$G(RGSITE))
 Q
 ;
SSN(DFN) ;
 ;Description: Function returns the patient's SSN, or "" on failure.
 Q $$GETFIELD(2,.09,.DFN)
 ;
NAME(DFN) ;
 ;Description: Function returns the patient's NAME, or "" on failure.
 Q $$GETFIELD(2,.01,.DFN)
 ;
ICN(DFN) ;Return patient ICN
 NEW RESULT
 S RESULT=+$$GETICN^MPIF001($G(DFN))
 I RESULT<0 Q ""
 Q +RESULT
 ;
DFN(ICN) ;Return patient IEN
 NEW RESULT
 I ICN'="" S ICN=+ICN
 S RESULT=$$GETDFN^MPIF001($G(ICN))
 I RESULT<0 Q ""
 Q RESULT
 ;
MPINODE(DFN) ;
 N NODE
 S NODE=$$MPINODE^MPIFAPI($G(DFN))
 I +NODE=-1 S NODE=""
 Q NODE
 ;
GETALL(DFN,MPIDATA) ;
 ;Descripition: Gets the MPI data and treating facility list
 ;
 ;Input:
 ;   DFN - patient ien
 ;Output:
 ;   MPIDATA       - output array (pass by reference)
 ;       "ICN") = <ICN>
 ;       "CHKSUM") = <ICN checksum>
 ;       "LOC") = <1 if ICN is local, 0 if national>
 ;       "CMOR") = <station number of CMOR>
 ;       "TF",<station number of TF>,"INSTIEN")=<ien of treating facility in Institution file>
 ;       "TF",<station number of TF>,"LASTDATE")=<date last treated>
 ;       "TF",<station number of TF>,"EVENT")=<ADT event reason (a pointer)>
 ;       "SUB") = <ien of subscriber list>
 ;
 N NODE,IEN,STAT,INST,LINK,I,HLL
 ;
 K MPIDATA
 ;
 ;get MPI data
 S NODE=$$MPINODE^RGFIU(DFN)
 S MPIDATA("ICN")=$P(NODE,"^"),MPIDATA("CHKSUM")=$P(NODE,"^",2),MPIDATA("LOC")=$P(NODE,"^",4),MPIDATA("CMOR")=$$STATNUM^RGFIU($P(NODE,"^",3)),MPIDATA("SUB")=$P(NODE,"^",5)
 ;
 ;get TF list
 I MPIDATA("ICN") D
 .N ARRAY,ITEM,NODE,STAT
 .Q:$$QUERYTF^VAFCTFU1(MPIDATA("ICN"),"ARRAY")
 .S ITEM=0
 .F  S ITEM=$O(ARRAY(ITEM)) Q:'ITEM  D
 ..S NODE=ARRAY(ITEM)
 ..S STAT=$$STATNUM^RGFIU($P(NODE,"^"))
 ..Q:'STAT
 ..S MPIDATA("TF",STAT,"INSTIEN")=$P(NODE,"^",1)
 ..S MPIDATA("TF",STAT,"LASTDATE")=$P(NODE,"^",2)
 ..S MPIDATA("TF",STAT,"EVENT")=$P(NODE,"^",3)
 Q
