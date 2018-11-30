VAFCPTAD ; ISA/RJS,Zoltan;BIR/PTD,CKN - ADD NEW PATIENT ENTRY ; 8/14/14 6:07pm
 ;;5.3;Registration;**149,800,876,944,950**;Aug 13, 1993;Build 4
 ;
ADD(RETURN,PARAM) ;Add an entry to the PATIENT (#2) file for VOA
 ;
 ;Input
 ;  PARAM = List of data to be used for the creation of a VistA
 ;          PATIENT (#2) record at the Preferred Facility.
 ;  
 ;Required elements include:
 ;  PARAM("PRFCLTY")=PREFERRED FACILITY
 ;  PARAM("NAME")=NAME (last name minimal; recommend full name)
 ;  PARAM("GENDER")=SEX
 ;  PARAM("DOB")=DATE OF BIRTH
 ;  PARAM("SSN")=SOCIAL SECURITY NUMBER OR NULL IF NONE
 ;  PARAM("SRVCNCTD")=SERVICE CONNECTED?
 ;  PARAM("TYPE")=TYPE
 ;  PARAM("VET")=VETERAN (Y/N)?
 ;  PARAM("FULLICN")=INTEGRATION CONTROL NUMBER AND CHECKSUM
 ;
 ;Optional elements include:
 ;  PARAM("POBCTY")=PLACE OF BIRTH [CITY]
 ;  PARAM("POBST")=PLACE OF BIRTH [STATE]
 ;  PARAM("MMN")=MOTHER'S MAIDEN NAME
 ;  PARAM("MBI")=MULTIPLE BIRTH INDICATOR
 ;  PARAM("ALIAS",#)=ALIAS NAME(last^first^middle^suffix)^ALIAS SSN
 ;
 ;Output:
 ;  On Failure:  -1^error text - record add failed
 ;  On Success:   1^DFN of new PATIENT (#2) record
 ;
EN1 ;Check value of all required fields
 D NOW^%DTC
 N ALSERR,DIERR,DPTIDS,DPTX,ERROR,FLG,FDA,FN,LN,MN,RESULT,RGRSICN,SFX,VAL,VAFCA08,X,Y
 N VAFCDFN,VAFCDOB,VAFCICN,VAFCMMN,VAFCNAM,VAFCPF,VAFCPOBC,VAFCPOBS
 N VAFCRSN,VAFCSRV,VAFCSSN,VAFCSUM,VAFCSX,VAFCTYP,VAFCVET,VAFCMBI
 K RETURN
 S (RGRSICN,VAFCA08)=1 S FLG=0 ;allow update to ICN; prevent triggering of messages
 ;
 ;PREFERRED FACILITY
 I $G(PARAM("PRFCLTY"))="" S RETURN(1)="-1^PREFERRED FACILITY is a required field." Q
 I $G(PARAM("PRFCLTY"))'=$P($$SITE^VASITE(),"^",3) S RETURN(1)="-1^PREFERRED FACILITY is not the station to which the RPC was sent." Q
 I $G(PARAM("PRFCLTY"))'="" S VAL=$G(PARAM("PRFCLTY")) D CHK^DIE(2,27.02,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 S VAFCPF=VAL,FLG=1
 ;
 ;INTEGRATION CONTROL NUMBER and ICN CHECKSUM
 I $G(PARAM("FULLICN"))="" S RETURN(1)="-1^Full INTEGRATION CONTROL NUMBER with ICN CHECKSUM is required." Q
 I $G(PARAM("FULLICN"))'["V" S RETURN(1)="-1^Full INTEGRATION CONTROL NUMBER with ICN CHECKSUM is required." Q
 I $G(PARAM("FULLICN"))'="" D
 .S PARAM("ICN")=$P(PARAM("FULLICN"),"V")
 .S PARAM("CHKSUM")=$P(PARAM("FULLICN"),"V",2)
 I $G(PARAM("ICN"))'="" S VAL=$G(PARAM("ICN")) D CHK^DIE(2,991.01,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 S VAFCICN=VAL,FLG=1
 I $G(PARAM("CHKSUM"))'="" S VAL=$G(PARAM("CHKSUM")) D CHK^DIE(2,991.02,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 S VAFCSUM=VAL,FLG=1
 ;Has patient already been created at this facility?  If so get DFN and quit.
 I $O(^DPT("AICN",PARAM("ICN"),0)) S RETURN(1)="1^"_$O(^DPT("AICN",PARAM("ICN"),0)) Q
 ;
 ;NAME INPUT AS:LAST^FIRST^MIDDLE^SUFFIX; MUST BE FORMATTED FOR VISTA INPUT
 I $G(PARAM("NAME"))="" S RETURN(1)="-1^Patient NAME is a required field." Q
 S LN=$P($G(PARAM("NAME")),"^"),FN=$P($G(PARAM("NAME")),"^",2),MN=$P($G(PARAM("NAME")),"^",3),SFX=$P($G(PARAM("NAME")),"^",4)
 S PARAM("NAME")=LN_","
 I FN'="" S PARAM("NAME")=PARAM("NAME")_FN
 I MN'="" S PARAM("NAME")=PARAM("NAME")_" "_MN
 I SFX'="" S PARAM("NAME")=PARAM("NAME")_" "_SFX
 I $G(PARAM("NAME"))'="" S VAL=$G(PARAM("NAME")) D CHK^DIE(2,.01,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 S VAFCNAM=VAL,FLG=1
 S DPTX=VAL ;variable used by SSN input transform
 ;
 ;DATE OF BIRTH
 I $G(PARAM("DOB"))="" S RETURN(1)="-1^DATE OF BIRTH is a required field." Q
 I $G(PARAM("DOB"))'="" S VAL=$G(PARAM("DOB")) D CHK^DIE(2,.03,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 S VAFCDOB=VAL,FLG=1
 S DPTIDS(.03)=RESULT ;variable used by PSEUDO-SSN code
 ;
 ;SOCIAL SECURITY NUMBER not equal null; valid 9-digit number
 I '$D(PARAM("SSN")) S RETURN(1)="-1^SOCIAL SECURITY NUMBER is a required field.  A null value may be sent." Q
 I $G(PARAM("SSN"))'="" S VAL=$G(PARAM("SSN")) D CHK^DIE(2,.09,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 I $G(PARAM("SSN"))'="" S VAFCSSN=VAL,FLG=1
 I $G(PARAM("SSN"))="" D  ;SSN null, set PSEUDO SSN REASON=SSN UNKNOWN/FOLLOW-UP
 .S PARAM("SSN")="P" ;PSEUDO SSN
 .S PARAM("PSEUDO")="S" ;PSEUDO SSN REASON
 .S VAFCSSN=$G(PARAM("SSN")),FLG=1
 .;If SSN null, set PSEUDO SSN REASON (#.0906) =SSN UNKNOWN/FOLLOW-UP
 .S VAFCRSN=$G(PARAM("PSEUDO")),FLG=1
 ;
 ;SEX
 I $G(PARAM("GENDER"))="" S RETURN(1)="-1^GENDER is a required field." Q
 I $G(PARAM("GENDER"))'="" S VAL=$G(PARAM("GENDER")) D CHK^DIE(2,.02,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 S VAFCSX=VAL,FLG=1
 ;
 ;SERVICE CONNECTED?
 I $G(PARAM("SRVCNCTD"))="" S RETURN(1)="-1^'SERVICE CONNECTED?' is a required field." Q
 ;input set to either YES or NO on the MPI before RPC call; skip CHK^DIE
 ;here as it resulted in error; expected DFN variable which is not yet set.
 I $G(PARAM("SRVCNCTD"))'="" S VAFCSRV=$G(PARAM("SRVCNCTD"))
 ;
 ;TYPE
 I $G(PARAM("TYPE"))="" S RETURN(1)="-1^Patient TYPE is a required field." Q
 I $G(PARAM("TYPE"))'="" S VAL=$G(PARAM("TYPE")) D CHK^DIE(2,391,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 S VAFCTYP=VAL,FLG=1
 ;
 ;VETERAN Y/N?
 I $G(PARAM("VET"))="" S RETURN(1)="-1^'VETERAN Y/N?' is a required field." Q
 ;input set to either YES or NO on the MPI before RPC call; skip CHK^DIE
 ;here as it resulted in error; expected DFN variable which is not yet set.
 I $G(PARAM("VET"))'="" S VAFCVET=$E($G(PARAM("VET")),1),FLG=1 ;internal format
 ;
 ;Optional - POB CITY
 I $D(PARAM("POBCTY")) S VAL=$G(PARAM("POBCTY")) D CHK^DIE(2,.092,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 I $D(PARAM("POBCTY")) S VAFCPOBC=VAL,FLG=1
 ;
 ;Optional - POB STATE
 N STIEN,UNDEF S UNDEF=0
 I $D(PARAM("POBST")) D  I UNDEF S RETURN(1)="-1^The value passed for PLACE OF BIRTH [STATE], "_PARAM("POBST")_", is not a valid STATE (#5) file entry." Q
 .;Convert STATE ABBREVIATION into STATE NAME
 .S STIEN=$O(^DIC(5,"C",PARAM("POBST"),0))
 .I STIEN="" S UNDEF=1 Q
 .I STIEN'="" S PARAM("POBST")=$P($G(^DIC(5,STIEN,0)),"^")
 .S VAL=$G(PARAM("POBST"))
 .D CHK^DIE(2,.093,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 .S VAFCPOBS=VAL,FLG=1
 ;
 ;Optional - MOTHER'S MAIDEN NAME
 I $D(PARAM("MMN")) S VAL=$G(PARAM("MMN")) D CHK^DIE(2,.2403,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 I $D(PARAM("MMN")) S VAFCMMN=VAL,FLG=1
 ;
 ;**876 - MVI_2788 (ckn) - Add MBI
 ;Optional - MULTIPLE BIRTH INDICATOR
 I $D(PARAM("MBI")) S VAL=$G(PARAM("MBI")) D CHK^DIE(2,994,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) Q
 I $G(PARAM("MBI"))'="" S VAFCMBI=VAL,FLG=1
 ;
 I FLG=0 S RETURN(1)="-1^Required information is missing; please check input and try again." Q
 ;Else ok to file entry
FILE ;Call FILE^DICN to add new entry to PATIENT (#2) file
 N DA,DIC,DR,FULLICN K DD,DO
 S DIC="^DPT(",DIC(0)="FLZ",DLAYGO=2,X=VAFCNAM
 ;**876 MVI_2788 (ckn) - Remove four slash use for field 1901
 ;**944 Story #557843 (cml) add code to update FULL ICN (#991.1), WHO ENTERED PATIENT (#.096), and DATE ENTERED INTO FILE (#.097) fields
 S FULLICN=VAFCICN_"V"_VAFCSUM
 S DIC("DR")=".09///"_VAFCSSN_";.03///"_VAFCDOB_";.02///"_VAFCSX_";391///"_VAFCTYP_";1901///"_VAFCVET_";.301///"_VAFCSRV_";991.01///"_VAFCICN_";991.02///"_VAFCSUM_";991.1///"_FULLICN
 I VAFCSSN="P" S DIC("DR")=DIC("DR")_";.0906///"_VAFCRSN
 I $G(VAFCPOBC)'="" S DIC("DR")=DIC("DR")_";.092///"_VAFCPOBC
 I $G(VAFCPOBS)'="" S DIC("DR")=DIC("DR")_";.093///"_VAFCPOBS
 I $G(VAFCMMN)'="" S DIC("DR")=DIC("DR")_";.2403///"_VAFCMMN
 ;**876 - MVI_2788 (ckn)
 I $G(VAFCMBI)'="" S DIC("DR")=DIC("DR")_";994///"_VAFCMBI
 L +^DPT(0):10
 D FILE^DICN K DA,DIC,DD,DLAYGO,DO,DR
 L -^DPT(0)
 ;If record creation/update fails, return a -1^error text
 I $P(Y,U,3)'=1 S RETURN(1)="-1^"_"Attempt to add patient "_VAFCNAM_" to the PATIENT (#2) file at station number "_$P($$SITE^VASITE,"^",3)_" failed." Q
 S VAFCDFN=+Y
 ; file Who and When if not already done
 N DGZ
 S DGZ=$G(^DPT(VAFCDFN,0))
 S:'$P(DGZ,"^",15) FDA(2,VAFCDFN_",",.096)=DUZ
 S:'$P(DGZ,"^",16) FDA(2,VAFCDFN_",",.097)=DT
 D:$D(FDA) FILE^DIE("","FDA")
 ;
 ;File ALIAS multiple
 I $D(PARAM("ALIAS")) D ALIAS  ;If ALIAS data is passed, call ALIAS module
 I $G(ALSERR)="" S RETURN(1)="1^"_VAFCDFN  ;No errors for ALIAS, return DFN
 I $G(ALSERR)'="" S RETURN(1)=ALSERR
 Q
 ;
 ;
ALIAS ;Optional - Add ALIAS and ALIAS SSN data for entry
 ;Only occurs for a NEW record; there is no previous ALIAS data
 I '$D(PARAM("ALIAS")) Q
 ;ALIAS input comes in as: LAST^FIRST^MIDDLE^SUFFIX^SSN
 N AFN,ALN,AMN,ASFX,ASSN,ERR,FDA,I,LOC,NUM
 S (I,NUM)=0 F  S NUM=$O(PARAM("ALIAS",NUM)) Q:'NUM  D
 .S ALN=$P($G(PARAM("ALIAS",NUM)),"^") Q:ALN=""  ;Last name minimal input
 .S AFN=$P($G(PARAM("ALIAS",NUM)),"^",2)
 .S AMN=$P($G(PARAM("ALIAS",NUM)),"^",3)
 .S ASFX=$P($G(PARAM("ALIAS",NUM)),"^",4)
 .S ASSN=$P($G(PARAM("ALIAS",NUM)),"^",5)
 .;Change format for VistA input: LAST,FIRST MIDDLE SUFFIX^SSN
 .S LOC(NUM)=ALN_","
 .I AFN'="" S LOC(NUM)=LOC(NUM)_AFN
 .I AMN'="" S LOC(NUM)=LOC(NUM)_" "_AMN
 .I ASFX'="" S LOC(NUM)=LOC(NUM)_" "_ASFX
 .S LOC(NUM)=LOC(NUM)_"^"
 .I ASSN'="" S LOC(NUM)=LOC(NUM)_ASSN
 .;Set FDA nodes
 .S I=I+1 ;Unique sequence number for add to ALIAS SUB-FILE (#2.01
 .S FDA(2.01,"+"_I_","_VAFCDFN_",",.01)=$P(LOC(NUM),"^") ; (#.01) ALIAS (name)
 .I ASSN'="" S FDA(2.01,"+"_I_","_VAFCDFN_",",1)=$P(LOC(NUM),"^",2) ; (#1) ALIAS SSN
 ;Update ALIAS multiple with new entries
 I $D(FDA) D  ;We have ALIAS data to add
 .S ALSERR=""
 .L +^DPT(VAFCDFN):10
 .D UPDATE^DIE("E","FDA",,"ERR")
 .L -^DPT(VAFCDFN)
 .I $D(ERR("DIERR")) S ALSERR="1^"_VAFCDFN_"^Patient "_PARAM("NAME")_" was successfully added at "_$P($$SITE^VASITE,"^",3)_".  However, the ALIAS data failed to update. Error message: "_$G(ERR("DIERR","1","TEXT",1)) Q
 Q
 ;
