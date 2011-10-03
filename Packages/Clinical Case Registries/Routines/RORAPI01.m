RORAPI01 ;HCIOFO/SG - CLINICAL REGISTRIES API ; 5/12/05 1:59pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ;***** EXAMPLE
 ;
 N BUF,IPD,IRD,PATIEN,RC,REGIEN
 W !,"   Patient  Registries"
 W !,"   -------  ----------"
 ;--- Initialize the patient iterator
 S RC=$$PATITER^RORAPI01(.IPD,"VA HEPC")
 I RC<0  W "RC= ",RC,!  Q
 ;--- Browse through the registry patients
 F  S PATIEN=$$NEXTPAT^RORAPI01(.IPD)  Q:PATIEN'>0  D
 . W !,$J(PATIEN,10),"  "
 . ;--- Initialize the registry iterator
 . S RC=$$REGITER^RORAPI01(.IRD,PATIEN)
 . I RC<0  W "RC= ",RC  Q
 . ;--- Browse through the patient's registry records
 . S BUF=""
 . F  S REGIEN=$$NEXTREG^RORAPI01(.IRD)  Q:REGIEN'>0  D
 . . S BUF=BUF_","_REGIEN
 . W $P(BUF,",",2,999)
 ;---
 W !
 Q
 ;
 ;***** RETURNS THE NEXT PATIENT IN THE REGISTRY
 ;
 ; .IDESC        Reference to the iterator descriptor created
 ;               by PATITER^RORAPI01
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  No more patients in the registry
 ;       >0  Patient IEN^empty
 ;
NEXTPAT(IDESC) ;
 N RC
 F  D  Q:$G(RC)
 . ;--- Get IEN of the next registry record
 . S IDESC("IEN")=$O(^RORDATA(798,"AC",IDESC("REGIEN"),IDESC("IEN")))
 . I IDESC("IEN")'>0  S RC="1^END"  Q
 . Q:'$$ACTIVE^RORDD(IDESC("IEN"))
 . ;--- Load the patient IEN (DFN)
 . S RC=$P($G(^RORDATA(798,IDESC("IEN"),0)),U)
 Q $S(RC="1^END":"",1:RC)
 ;
 ;***** RETURNS THE NEXT REGISTRY FOR THE PATIENT
 ;
 ; .IDESC        Reference to the iterator descriptor created
 ;               by REGITER^RORAPI01
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  No more registries for the patient
 ;       >0  Registry IEN^empty
 ;
NEXTREG(IDESC) ;
 N RC
 F  D  Q:$G(RC)
 . ;--- Get IEN of the next registry record
 . S IDESC("IEN")=$O(^RORDATA(798,"B",IDESC("PATIEN"),IDESC("IEN")))
 . I IDESC("IEN")'>0  S RC="1^END"  Q
 . Q:'$$ACTIVE^RORDD(IDESC("IEN"))
 . ;--- Load the registry IEN
 . S RC=$P($G(^RORDATA(798,IDESC("IEN"),0)),U,2)
 Q $S(RC="1^END":"",1:RC)
 ;
 ;***** CREATES AN ITERATOR OF PATIENTS IN THE REGISTRY
 ;
 ; .IDESC        Reference to a local variable where an iterator
 ;               descriptor will be created
 ; REGNAME       Registry name
 ; [MODE]        Bit flags that define iteration mode (3 by default)
 ;                 1  Active patients
 ;                 2  Reserved
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PATITER(IDESC,REGNAME,MODE) ;
 N REGIEN  K IDESC
 ;--- Get an IEN of the Registry Parameters
 S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 Q:REGIEN<0 REGIEN
 ;--- Setup the descriptor
 S MODE=$S($G(MODE):MODE,1:3)
 S IDESC("REGNAME")=REGNAME
 S IDESC("REGIEN")=REGIEN
 S IDESC("ACT")=MODE#2
 S IDESC("ROOT")=$$ROOT^DILFD(798,"",1)
 S IDESC("IEN")=0
 Q 0
 ;
 ;***** CREATES AN ITERATOR OF THE PATIENT REGISTRIES
 ;
 ; .IDESC        Reference to a local variable where an iterator
 ;               descriptor will be created
 ; PATIEN        Patient IEN
 ; [MODE]        Bit flags that define iteration mode (3 by default)
 ;                 1  Registries where the patient is active
 ;                 2  Reserved
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
REGITER(IDESC,PATIEN,MODE) ;
 K IDESC
 ;--- Setup the descriptor
 S MODE=$S($G(MODE):MODE,1:3)
 S IDESC("PATIEN")=PATIEN
 S IDESC("ACT")=MODE#2
 S IDESC("ROOT")=$$ROOT^DILFD(798,"",1)
 S IDESC("IEN")=0
 Q 0
