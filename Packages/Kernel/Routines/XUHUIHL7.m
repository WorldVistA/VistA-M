XUHUIHL7 ;OAKCIOFO/JG - HL7 GENERATION ROUTINE; 06/010/2002
 ;;8.0;KERNEL;**239**;JUL 10, 1995
 ; Supported by IA#3589
 ; This routine generates an HL7 MFN Staff message based on data 
 ; passed by the XUHUI FIELD CHANGE EVENT protocol to the XUHUI SEND HL7 
 ; MSG protocol.  This data is based on change in value of fields in the 
 ; NEW PERSON (#200) file and in the the KEY (#200.051) multiple.  
 ; The following fields are monitored for the NEW PERSON file: 
 ;   .01 NAME
 ;   9.2 TERMINATION DATE
 ;   5 DOB
 ;   9 SSN
 ; The Provider key is monitored for the KEY subfile.
 ;
 ; Input:
 ; XUHUIXR    - Name of xref being passed by protocols
 ;              "AXUHUI": file 200 updated; 
 ;              "AXUHUIKEY": file 200.051 updated
 ; XUHUIA     - "S": logic executed; "K": kill logic executed
 ; XUHUIX2    - X2 array with file 200 content
 ; XUHUIDA    - DA array
 ; 
 ; Output: none
 ; Postcondition:
 ;    - An HL7 MFN message is generated that contains the structure
 ;      MSH MFI MFE STF
 ; 
 N XUHUIERR,NAME,SSN,DOB,TERMDATE,ACTIVE
 Q:XUHUIXR'["AXUHUI" 
 I XUHUIXR="AXUHUI" D F200
 I XUHUIXR="AXUHUIKEY" D FKEY
 Q:$G(XUHUIERR)
 D SENDMSG
 Q
 ;
F200 ; NEW PERSON file was updated 
 ; XUHUIX2(1)=NAME
 ; XUHUIX2(2)=TERMINATION DATE
 ; XUHUIX2(3)=DOB
 ; XUHUIX2(4)=SSN
 ; XUHUIDA=file 200 ien
 I '$D(XUHUIX2) S XUHUIERR="1^no XUHUIX2 array" Q 
 S IEN=XUHUIDA
 ; TERMINATION DATE determines Active/Inactive
 S ACTIVE=$S($G(XUHUIX2(2))]"":"I",1:"A")
 ; get newest values for name, ssn, dob, and termination date
 S NAME=$S($G(XUHUIX2(1))="":"""""",1:XUHUIX2(1))
 S SSN=$S($G(XUHUIX2(4))="":"""""",1:XUHUIX2(4))
 S DOB=$$FMTHL7^XLFDT($G(XUHUIX2(3)))
 S DOB=$S(DOB="":"""""",1:DOB)
 S TERMDATE=$$FMTHL7^XLFDT($G(XUHUIX2(2)))
 S TERMDATE=$S(TERMDATE="":"""""",1:TERMDATE)
 Q
 ;
FKEY ; PROVIDER key was updated
 ; XUHUIDA(1)=file 200 ien
 ; XUHUIA= S or K
 I '$G(XUHUIDA(1)) S XUHUIERR="1^no IEN" Q 
 S IEN=XUHUIDA(1) ; ien of provider staff
 ; XUHUIA determines Active/Inactive
 S ACTIVE=$S($G(XUHUIA)="K":"I",1:"A")
 ; get newest values for name, ssn, dob, and termination date
 S NAME=$$GET1^DIQ(200,IEN_",","NAME")
 S NAME=$S(NAME="":"""""",1:NAME)
 S SSN=$$GET1^DIQ(200,IEN_",","SSN")
 S SSN=$S(SSN="":"""""",1:SSN)
 S DOB=$$GET1^DIQ(200,IEN_",","DOB","I")
 S DOB=$S(DOB="":"""""",1:$$FMTHL7^XLFDT(DOB))
 S TERMDATE=$$GET1^DIQ(200,IEN_",","TERMINATION DATE","I")
 S TERMDATE=$S(TERMDATE="":"""""",1:$$FMTHL7^XLFDT(TERMDATE))
 Q
 ;
SENDMSG ; initialize HL variables
 N HL,NOW,RESULT
 D INIT^HLFNC2("XUHUI MFN",.HL)
 I $G(HL) D  Q  ; error occurred
 . S XUHUIERR="1^HL init"
 S HLFS=$G(HL("FS")) S:HLFS="" HLFS="^"
 S HLCS=$E(HL("ECH"),1)
 ;
 ; create message
 S NOW=$$FMTHL7^XLFDT($$NOW^XLFDT)
 ; MFI^PRA^VA KERNEL^UPD^entered date^^NE
 S HLA("HLS",1)="MFI"_HLFS_"PRA"_HLFS_"VA KERNEL"_HLFS_"UPD"_HLFS_NOW_HLFS_HLFS_"NE"
 ; MFE^MUP^^^ien~IEN~NEW PERSON
 S HLA("HLS",2)="MFE"_HLFS_"MUP"_HLFS_HLFS_HLFS_IEN_HLCS_"IEN"_HLCS_"NEW PERSON"
 ; STF^ssn~NEW PERSON~SSN^^name^^^dob^active/inactive^^^^^^inactive date
 S HLA("HLS",3)="STF"_HLFS_IEN_HLCS_"IEN"_HLCS_"NEW PERSON"_HLFS_SSN_HLCS_HLCS_HLCS_"SSN"_HLFS_NAME_HLFS_HLFS_HLFS_DOB_HLFS_ACTIVE_HLFS_HLFS_HLFS_HLFS_HLFS_HLFS_TERMDATE
 ; generate message
 D GENERATE^HLMA("XUHUI MFN","LM",1,.RESULT,"",.HL)
 I +$P(RESULT,U,2) D  Q 
 . S XUHUIERR="1^HL Generate"
 Q
 ;
