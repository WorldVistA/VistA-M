RGRSBUL1 ;ALB/RJS,CML-RGRSTEXT BULLETIN ROUTINE (PART 2) ;07/24/98
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**1,3,19,52**;30 Apr 99;Build 2
 ;
SSNBULL(DFN,ARRAY,NAME,SSN,ICN,CMOR) ;
 ;Entry point generates a bulletin to the RG CIRN DEMOGRAPHIC
 ;ISSUES mail group about an SSN change for a given patient.
 ;
 ;Input:  Required Variables
 ;
 ;   DFN   - IEN in the PATIENT file (#2)
 ;  ARRAY  - Array of data containing sending sites station number
 ;   NAME  - Patient's Name
 ;   SSN   - Patient's SSN
 ;   ICN   - Patient's ICN (Integration Control Number) 
 ;   CMOR  - Patient's CMOR (Coordinating Master of Record)
 ;
 Q:$G(DFN)=""!($G(ARRAY)="")
 N LOCDATA,RGRSTEXT,INDEX,COUNTER
 S RGRSTEXT(1)="The MPI/PD Package has received an SSN change from:"
 S RGRSTEXT(2)=$$INST(@ARRAY@("SENDING SITE"))
 S RGRSTEXT(3)="           "
 S RGRSTEXT(4)="This change has been made in your local data base for:"
 S RGRSTEXT(5)=NAME
 S RGRSTEXT(6)="           "
 S RGRSTEXT(7)="=> Local "_$P($$SITE^VASITE(),"^",2)_" data PRIOR to update:"
 S RGRSTEXT(8)="NAME: "_NAME
 S RGRSTEXT(9)="SSN: "_SSN
 S RGRSTEXT(10)="ICN: "_ICN
 S RGRSTEXT(11)="CMOR: "_CMOR
 S RGRSTEXT(12)="--------------------------------------------------------"
 S RGRSTEXT(13)="=> Update received from "_$P($$INST(@ARRAY@("SENDING SITE"))," -->")_":"
 S RGRSTEXT(14)="SSN: "_@ARRAY@("SSN")
 D BULL2^RGRSBULL("MPI/PD SSN CHANGE - "_NAME,"RGRSTEXT(")
 Q
 ;
NOT2(ARRAY) ;
 ;Entry point generates a bulletin to the RG CIRN DEMOGRAPHIC
 ;ISSUES mail group about invalid subscription information for a given
 ;patient.
 ;
 ;Input:  Required Variables
 ;
 ;  ARRAY  - Array of information regarding the invalid subscription
 ;
 Q:($G(ARRAY)="")
 N RGRSTEXT,INDEX,COUNTER
 S RGRSTEXT(1)="The MPI/PD Package has received a message from:"
 S RGRSTEXT(2)=$$INST(@ARRAY@("SENDING SITE"))
 S RGRSTEXT(3)="This patient has your station as a subscriber, however"
 S RGRSTEXT(4)="the patient was not found in your database."
 S RGRSTEXT(5)="--------------------------------------------------------"
 S RGRSTEXT(6)="Remote Data"
 S RGRSTEXT(7)="           "
 S INDEX=0,COUNTER=8
 F  S INDEX=$O(@ARRAY@("MESSAGE",INDEX)) Q:INDEX']""  D
 . S RGRSTEXT(COUNTER)=@ARRAY@("MESSAGE",INDEX)
 . S COUNTER=COUNTER+1
 D BULL2^RGRSBULL("MPI/PD - PATIENT NOT FOUND","RGRSTEXT(")
 Q
 ;
SENSTIVE(DFN,ARRAY,NAME) ;FIRES WHEN PT. IS FLAGGED AS SENSITIVE AT ANOTHER SITE
 ;Entry point generates a bulletin to the RG CIRN DEMOGRAPHIC
 ;ISSUES mail group when a given patient is flagged as sensitive at
 ;another site.
 ;
 ;Input:  Required Variables
 ;
 ;   DFN  - IEN in the PATIENT file (#2)
 ;  ARRAY - Array of data containing sending sites station number and SSN
 ;  NAME  - Patient's name
 ;  CMOR  - Coordinating Master of Record
 ;
 Q:($G(ARRAY)="")!($G(DFN)="")
 N RGRSTEXT,INDEX,COUNTER,CMOR
 S CMOR=$$CMOR2^MPIF001(DFN) I $P(CMOR,"^")<0 S CMOR="not assigned"
 S RGRSTEXT(1)="The MPI/PD Package has received a message from:"
 S RGRSTEXT(2)=$$INST(@ARRAY@("SENDING SITE"))
 S RGRSTEXT(3)="   "
 S RGRSTEXT(4)="This message indicates that patient "_NAME_" is flagged"
 S RGRSTEXT(5)="as Sensitive at the other facility but is not flagged as"
 S RGRSTEXT(6)="Sensitive at your facility."
 S RGRSTEXT(7)="  "
 S RGRSTEXT(8)="Remote Patient SSN: "_$S(@ARRAY@("SSN")="":"Not Available",1:@ARRAY@("SSN"))
 S RGRSTEXT(9)="Remote User who Flagged the Patient as Sensitive: "_@ARRAY@("SENSITIVITY USER")
 S RGRSTEXT(10)="Date/Time Remote User Flagged Patient Sensitive:  "_$$FMTE^XLFDT(@ARRAY@("SENSITIVITY DATE"))
 S RGRSTEXT(11)="  "
 S RGRSTEXT(12)="CMOR Site: "_CMOR
 D BULL2^RGRSBULL("Remote Sensitivity Indicated","RGRSTEXT(")
 Q
 ;
 ;MPIC_772 - **52; Commented out Remote Date of Death Indicated module.
 ;Only RGADTP2 and RGRSPT called this module; and both have been commented out.
RMTDOD(DFN,ARRAY,NAME,RDOD,LDOD) ;Fires when patient has a Date of Death at another site
 ;Entry point generates a bulletin to the RG CIRN DEMOGRAPHIC
 ;ISSUES mail group when a given patient has a Date of Death at
 ;another site.
 ;
 ;Input:  Required Variables
 ;
 ;  DFN   - IEN in the PATIENT file (#2)
 ;  ARRAY - Array of data containing sending sites station number and SSN
 ;  NAME  - Patient's name
 ;  RDOD  - Date of Death at remote site
 ;  LDOD  - Date of Death at local site
 ;  CMOR  - Coordinating Master of Record
 ;
 ;Q:($G(ARRAY)="")!($G(DFN)="")
 ;Q:(RDOD=LDOD)  ;If remote DOD and local DOD same, QUIT
 ;N CMOR
 ;S CMOR=$$CMOR2^MPIF001(DFN) I $P(CMOR,"^")<0 S CMOR="not assigned"
 ;N RGRSTEXT
 ;S RGRSTEXT(1)="The MPI/PD Package has received a message from:"
 ;S RGRSTEXT(2)=$$INST(@ARRAY@("SENDING SITE"))
 ;S RGRSTEXT(3)="   "
 ;S RGRSTEXT(4)="This message indicates that patient "_NAME
 ;I 'LDOD S RGRSTEXT(5)="has a date of death at the other facility but not at your facility." G RMTMSG
 ;I LDOD,(LDOD'=RDOD) S RGRSTEXT(5)="has a different date of death at the other facility than at your facility."
RMTMSG ;S RGRSTEXT(6)="  "
 ;S RGRSTEXT(7)="Remote Patient SSN: "_$S(@ARRAY@("SSN")="":"Not Available",1:@ARRAY@("SSN"))
 ;S RGRSTEXT(8)="Date of Death from other facility:  "_$$FMTE^XLFDT(RDOD)
 ;I LDOD,(LDOD'=RDOD) S RGRSTEXT(9)="Date of Death at your facility:  "_$$FMTE^XLFDT(LDOD)
 ;S RGRSTEXT(10)="  "
 ;S RGRSTEXT(11)="CMOR site: "_CMOR
 ;D BULL2^RGRSBULL("Remote Date of Death Indicated","RGRSTEXT(")
 Q
 ;
INST(SITENUM) ;
 N RETURN,IEN,DATA,NAME,NUMBER
 S RETURN=""
 Q:$G(SITENUM)="" RETURN
 S IEN=$$LKUP^XUAF4(SITENUM)
 I IEN>0 S DATA=$$NS^XUAF4(IEN)
 I $G(DATA)]"" D 
 . S NAME=$P(DATA,"^",1),NUMBER=$P(DATA,"^",2)
 . S RETURN=NAME_" --> Site Number: "_NUMBER
 Q RETURN
 ;
FORMAT(DATA1,DATA2) ;
 N SPACES,SPACENUM,LENGTH1,LENGTH2,RETURN
 S SPACES="                       "
 S LENGTH1=$L(DATA1),LENGTH2=$L(DATA2)
 I LENGTH1>23 S DATA1=$E(DATA1,1,23) S LENGTH1=23
 I LENGTH2>22 S DATA2=$E(DATA2,1,22)
 S SPACENUM=23-LENGTH1
 S SPACES=$E(SPACES,1,SPACENUM)
 S RETURN=DATA1_SPACES_" "_DATA2
 Q $G(RETURN)
 ;
FREE(DATA) ;
 Q:$G(DATA)="" ""
 Q:$G(DATA)["@" ""
 Q:$G(DATA)=HL("Q") ""
 Q $G(DATA)
