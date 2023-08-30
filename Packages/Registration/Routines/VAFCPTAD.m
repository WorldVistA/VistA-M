VAFCPTAD ;ISA/RJS,ZOLTAN - Add an entry to the PATIENT (#2) file; 26-Apr-2023 4:26 PM
 ;;5.3;Registration;**149,800,876,944,950,955,1033,1042,1050,1099**;Aug 13, 1993;Build 1
 ;
ADD(RETURN,PARAM) ;Entry point for VAFC VOA ADD PATIENT remote procedure
 ;Input  PARAM array = List of data to be used for the creation of a VistA PATIENT (#2) record at the Preferred Facility.
 ;Required elements include:
 ;  PARAM("PRFCLTY")=PREFERRED FACILITY
 ;  PARAM("NAME")=NAME (last name minimal; recommend full name), 30 chars max
 ;  PARAM("GENDER")=SEX                    PARAM("DOB")=DATE OF BIRTH
 ;  PARAM("SSN")=SOCIAL SECURITY NUMBER OR NULL IF NONE and want a psuedo SSN created
 ;  PARAM("SRVCNCTD")=SERVICE CONNECTED?   PARAM("TYPE")=Patient TYPE
 ;  PARAM("VET")=VETERAN (Y/N)?            PARAM("FULLICN")=INTEGRATION CONTROL NUMBER with CHECKSUM
 ;Optional elements include:
 ;  PARAM("LONGNAME")=NAME (set if full name is greater than 30 chars) ;**1050,VAMPI-9503 (mko): New input, allows setting Name Components to long name
 ;  PARAM("POBCTY")=PLACE OF BIRTH [CITY]  PARAM("POBST")=PLACE OF BIRTH [STATE]
 ;  PARAM("MMN")=MOTHER'S MAIDEN NAME      PARAM("MBI")=MULTIPLE BIRTH INDICATOR
 ;  PARAM("ALIAS",#)=ALIAS NAME(last^first^middle^suffix)^ALIAS SSN
 ; **1033 enrollment, address and phone
 ;  PARAM("ENROLLMENT")=1 if would like the ES messaging triggered
 ;  PARAM("ResAddL1")=Resident Street Address line 1     ;PARAM("ResAddL2")=Resident Street Address line 2
 ;  PARAM("ResAddL3")=Resident Street Address line 3     ;PARAM("ResAddCity")=Resident City
 ;  PARAM("ResAddState")=Resident State                  ;PARAM("ResAddZIP")=Resident Zip
 ;  PARAM("ResPhone")=Home Phone Number                  ;PARAM("ResAddCountry")=COUNTRY FOR FORIEGN ADDRESS
 ;  PARAM("ResAddPCode")=POSTAL CODE FOR FORIEGN ADDRESS ;PARAM("ResAddProvince")=PROVINCE FOR FORIEGN ADDRESS
 ;Output:
 ;  On Failure:  -1^error text - record add failed
 ;  On Success:   1^DFN of new PATIENT (#2) record
 ;
EN1 ;Check value of all required fields
 K RETURN D NOW^%DTC
 N ALSERR,DIERR,DPTIDS,DPTX,ERROR,FLG,FDA,FN,LN,MN,RESULT,RGRSICN,SFX,VAL,VAFCA08,X,Y,UPDNC,VAFCDFN,VAFCDOB,VAFCICN,VAFCMMN,VAFCNAM,VAFCPF,VAFCPOBC,VAFCPOBS
 N VAFCRSN,VAFCSRV,VAFCSSN,VAFCSUM,VAFCSX,VAFCTYP,VAFCVET,VAFCMBI,VAFCPN,VAFCPR,VAFCPC,VAFCPCT,VAFCAL1,VAFCAL2,VAFCAL3,VAFCACY,VAFCAST,VAFCAZ,VAFCACTY,CNTY
 N VAFCSEQ S VAFCSEQ=$$RECORD(.PARAM)
 S (RGRSICN,VAFCA08)=1 S FLG=0 ;allow update to ICN; prevent triggering of messages
 ;PREFERRED FACILITY
 I $G(PARAM("PRFCLTY"))="" S RETURN(1)="-1^PREFERRED FACILITY is a required field." G END
 ;**955 (cmc) Story 699475 don't require perferred facility to be this site if this is station 200
 I $P($$SITE^VASITE(),"^",3)'=200 I $G(PARAM("PRFCLTY"))'=$P($$SITE^VASITE(),"^",3) S RETURN(1)="-1^PREFERRED FACILITY is not the station to which the RPC was sent." G END
 I $G(PARAM("PRFCLTY"))'="" S VAL=$G(PARAM("PRFCLTY")) D CHK^DIE(2,27.02,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) G END
 S VAFCPF=VAL,FLG=1
 ;
 ;INTEGRATION CONTROL NUMBER and ICN CHECKSUM
 I $G(PARAM("FULLICN"))=""!($G(PARAM("FULLICN"))'["V") S RETURN(1)="-1^Full INTEGRATION CONTROL NUMBER with ICN CHECKSUM is required." G END
 I $G(PARAM("FULLICN"))'="" S PARAM("ICN")=$P(PARAM("FULLICN"),"V"),PARAM("CHKSUM")=$P(PARAM("FULLICN"),"V",2)
 I $G(PARAM("ICN"))'="" S VAL=$G(PARAM("ICN")) D CHK^DIE(2,991.01,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) G END
 S VAFCICN=VAL,FLG=1
 I $G(PARAM("CHKSUM"))'="" S VAL=$G(PARAM("CHKSUM")) D CHK^DIE(2,991.02,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) G END
 S VAFCSUM=VAL,FLG=1
 ;Has patient already been created at this facility?  If so get DFN and quit.
 S VAFCDFN=+$O(^DPT("AICN",PARAM("ICN"),0))
 I VAFCDFN D  G:$D(RETURN(1)) END
 .;**1050,VAMPI-9503 (mko): Make sure the 0 node of the patient exists before quitting with the DFN.
 .;  If not, kill the erroneous "AICN" index entry and continue
 .I $D(^DPT(VAFCDFN,0))[0 K ^DPT("AICN",PARAM("ICN"),VAFCDFN),VAFCDFN Q
 .S RETURN(1)="1^"_$O(^DPT("AICN",PARAM("ICN"),0))_$S($$GETFLAG^VAFCPTED:"^^1",1:"")
 ;
 ;NAME INPUT AS:LAST^FIRST^MIDDLE^SUFFIX; MUST BE FORMATTED FOR VISTA INPUT
 ;**1099,VAMPI-19828 (mko): Build VistA name in VAFCNAM instead of PARAM("NAME")
 I $G(PARAM("NAME"))="" S RETURN(1)="-1^Patient NAME is a required field." G END
 S LN=$P($G(PARAM("NAME")),"^"),FN=$P($G(PARAM("NAME")),"^",2),MN=$P($G(PARAM("NAME")),"^",3),SFX=$P($G(PARAM("NAME")),"^",4)
 S VAFCNAM=LN_","
 S:FN'="" VAFCNAM=VAFCNAM_FN
 S:MN'="" VAFCNAM=VAFCNAM_" "_MN
 S:SFX'="" VAFCNAM=VAFCNAM_" "_SFX
 D CHK^DIE(2,.01,,VAFCNAM,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) G END
 S FLG=1,DPTX=VAFCNAM ;variable used by SSN input transform
 ;
 ;DATE OF BIRTH
 I $G(PARAM("DOB"))="" S RETURN(1)="-1^DATE OF BIRTH is a required field." G END
 I $G(PARAM("DOB"))'="" S VAL=$G(PARAM("DOB")) D CHK^DIE(2,.03,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) G END
 S VAFCDOB=VAL,FLG=1,DPTIDS(.03)=RESULT ;variable used by PSEUDO-SSN code
 ;
 ;SOCIAL SECURITY NUMBER not equal null; valid 9-digit number
 I '$D(PARAM("SSN")) S RETURN(1)="-1^SOCIAL SECURITY NUMBER is a required field.  A null value may be sent." G END
 I $G(PARAM("SSN"))'="" S VAL=$G(PARAM("SSN")) D CHK^DIE(2,.09,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) G END
 I $G(PARAM("SSN"))'="" S VAFCSSN=VAL,FLG=1
 I $G(PARAM("SSN"))="" D  ;SSN null, set PSEUDO SSN REASON=SSN UNKNOWN/FOLLOW-UP
 .S PARAM("SSN")="P" ;PSEUDO SSN
 .S PARAM("PSEUDO")="S" ;PSEUDO SSN REASON
 .S VAFCSSN=$G(PARAM("SSN")),FLG=1
 .;If SSN null, set PSEUDO SSN REASON (#.0906) =SSN UNKNOWN/FOLLOW-UP
 .S VAFCRSN=$G(PARAM("PSEUDO")),FLG=1
 ;
 ;SEX
 I $G(PARAM("GENDER"))="" S RETURN(1)="-1^GENDER is a required field." G END
 I $G(PARAM("GENDER"))'="" S VAL=$G(PARAM("GENDER")) D CHK^DIE(2,.02,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) G END
 S VAFCSX=VAL,FLG=1
 ;
 ;SERVICE CONNECTED?
 I $G(PARAM("SRVCNCTD"))="" S RETURN(1)="-1^'SERVICE CONNECTED?' is a required field." G END
 ;input set to either YES or NO on the MPI before RPC call; skip CHK^DIE here as it resulted in error; expected DFN variable which is not yet set.
 I $G(PARAM("SRVCNCTD"))'="" S VAFCSRV=$G(PARAM("SRVCNCTD"))
 ;
 ;TYPE
 I $G(PARAM("TYPE"))="" S RETURN(1)="-1^Patient TYPE is a required field." G END
 I $G(PARAM("TYPE"))'="" S VAL=$G(PARAM("TYPE")) D CHK^DIE(2,391,,VAL,.RESULT) I RESULT="^" S RETURN(1)="-1^"_^TMP("DIERR",$J,1,"TEXT",1) G END
 S VAFCTYP=VAL,FLG=1
 ;
 ;VETERAN Y/N?
 I $G(PARAM("VET"))="" S RETURN(1)="-1^'VETERAN Y/N?' is a required field." G END
 ;input set to either YES or NO on the MPI before RPC call; skip CHK^DIE here as it resulted in error; expected DFN variable which is not yet set.
 I $G(PARAM("VET"))'="" S VAFCVET=$E($G(PARAM("VET")),1),FLG=1 ;internal format
 ;
 ;Optional - POB CITY
 I $D(PARAM("POBCTY")) S VAL=$G(PARAM("POBCTY")) D CHK^DIE(2,.092,,VAL,.RESULT) I RESULT="^" S PARAM("POBCTY")=""
 I $G(PARAM("POBCTY"))'="" S VAFCPOBC=VAL,FLG=1
 ;
 ;Optional - POB STATE
 N STIEN,UNDEF S UNDEF=0
 I $D(PARAM("POBST")) D  I UNDEF S PARAM("POBST")=""
 .;Convert STATE ABBREVIATION into STATE NAME
 .S STIEN=$O(^DIC(5,"C",PARAM("POBST"),0))
 .I STIEN="" S UNDEF=1 Q
 .I STIEN'="" S PARAM("POBST")=$P($G(^DIC(5,STIEN,0)),"^")
 .S VAL=$G(PARAM("POBST")) D CHK^DIE(2,.093,,VAL,.RESULT) I RESULT="^" S UNDEF=1 Q
 I $G(PARAM("POBST"))'="" S VAFCPOBS=VAL,FLG=1
 ;
 ;Optional - MOTHER'S MAIDEN NAME RESET TO NULL IF INVALID VALUE TO ALLOW ADD TO CONTINUE **1033
 I $D(PARAM("MMN")) S VAL=$G(PARAM("MMN")) D CHK^DIE(2,.2403,,VAL,.RESULT) I RESULT="^" S PARAM("MMN")=""
 I $G(PARAM("MMN"))'="" S VAFCMMN=VAL,FLG=1
 ;
 ;**876 - MVI_2788 (ckn) - Add MBI
 ;Optional - MULTIPLE BIRTH INDICATOR RESET TO NULL IF INVALID VALUE TO ALLOW ADD TO CONTINUE **1033
 I $D(PARAM("MBI")) S VAL=$G(PARAM("MBI")) D CHK^DIE(2,994,,VAL,.RESULT) I RESULT="^" S PARAM("MBI")=""
 I $G(PARAM("MBI"))'="" S VAFCMBI=VAL,FLG=1
 ;
 ;**1013 OPTIONAL ADDRESS FIELDS AND PHONE RESET TO NULL IF INVALID VALUE TO ALLOW ADD TO CONTINUE **1033
 I $D(PARAM("ResAddL1")) S VAL=$G(PARAM("ResAddL1")) D CHK^DIE(2,.111,,VAL,.RESULT) I RESULT="^" S PARAM("ResAddL1")=""
 ;ONLY GET LINE2+ IF THE LINE BEFORE WAS GOOD
 I $G(PARAM("ResAddL1"))'="" S VAFCAL1=VAL,FLG=1 I $D(PARAM("ResAddL2")) S VAL=$G(PARAM("ResAddL2")) D CHK^DIE(2,.112,,VAL,.RESULT) I RESULT="^" S PARAM("ResAddL2")=""
 I $G(PARAM("ResAddL2"))'="" S VAFCAL2=VAL,FLG=1 I $D(PARAM("ResAddL3")) S VAL=$G(PARAM("ResAddL3")) D CHK^DIE(2,.113,,VAL,.RESULT) I RESULT="^" S PARAM("ResAddL3")=""
 I $G(PARAM("ResAddL3"))'="" S VAFCAL3=VAL,FLG=1
 I $D(PARAM("ResAddCity")) S VAL=$G(PARAM("ResAddCity")) D CHK^DIE(2,.114,,VAL,.RESULT) I RESULT="^" S PARAM("ResAddCity")=""
 I $G(PARAM("ResAddCity"))'="" S VAFCACY=VAL,FLG=1
 I $G(PARAM("ResAddState"))'="" D  I UNDEF S PARAM("ResAddState")=""
 .;Convert STATE ABBREVIATION into STATE NAME
 .S STIEN=$O(^DIC(5,"C",PARAM("ResAddState"),0))
 .I STIEN="" S UNDEF=1 Q
 .I STIEN'="" S PARAM("ResAddState")=$P($G(^DIC(5,STIEN,0)),"^")
 .S VAL=$G(PARAM("ResAddState")) D CHK^DIE(2,.115,,VAL,.RESULT) I RESULT="^" S PARAM("ResAddState")=""
 I $G(PARAM("ResAddState"))'="" S VAFCAST=VAL,FLG=1
 I $D(PARAM("ResAddZIP")) S VAL=$G(PARAM("ResAddZIP")) D CHK^DIE(2,.1112,,VAL,.RESULT) I RESULT="^" S PARAM("ResAddZIP")=""
 I $G(PARAM("ResAddZIP"))'="" S VAFCAZ=VAL,FLG=1
 ;**1042,VAMPI-8199 (mko): Get County from Zip Code.
 ;  State must have a value, as dictated by the input transform of the COUNTY field (#.117) of the PATIENT file (#2).
 ;  Value to be filed is the subien of the county in the state file
 I $G(VAFCAZ)]"",$G(VAFCAST)]"" D
 .N ARR
 .D POSTAL^XIPUTIL(VAFCAZ,.ARR) Q:$G(ARR("COUNTY"))=""
 .S VAL=$O(^DIC(5,+$G(STIEN),1,"B",ARR("COUNTY"),0))
 .S:VAL>0 VAFCACTY=VAL
 I $D(PARAM("ResPhone")) S VAL=$G(PARAM("ResPhone")) D CHK^DIE(2,.131,,VAL,.RESULT) I RESULT="^" S PARAM("ResPhone")=""
 I $G(PARAM("ResPhone"))'="" S VAFCPN=VAL,FLG=1
 I $G(PARAM("ResAddProvince"))'="" S VAL=$G(PARAM("ResAddProvince")) D CHK^DIE(2,.1171,,VAL,.RESULT) I RESULT="^" S PARAM("ResAddProvince")=""
 I $G(PARAM("ResAddProvince"))'="" S VAFCPR=VAL,FLG=1
 ;**1050,VAMPI-9503 (mko): Remove initial I $G(PARAM("ResAddProvince"))'="" test -- don't require a valid Province be sent for Postal Code to be checked
 I $G(PARAM("ResAddPCode"))'="" S VAL=$G(PARAM("ResAddPCode")) D CHK^DIE(2,.1172,,VAL,.RESULT) I RESULT="^" S PARAM("ResAddPCode")=""
 I $G(PARAM("ResAddPCode"))'="" S VAFCPC=VAL,FLG=1
 ;**1050,VAMPI-9503 (mko): Remove initial I $G(PARAM("ResAddProvince"))'="" test -- don't require a valid Province be sent for Country to be checked
 I $G(PARAM("ResAddCountry"))'="" D
 .;convert Country Abbreviation into Country DESCRIPTION
 .S CNTY=$O(^HL(779.004,"B",$G(PARAM("ResAddCountry")),""))
 .I CNTY="" S PARAM("ResAddCountry")=""
 .I CNTY'="" S VAL=PARAM("ResAddCountry") D CHK^DIE(2,.1173,,VAL,.RESULT) I RESULT="^" S PARAM("ResAddCountry")=""
 I $G(PARAM("ResAddCountry"))'="" S VAFCPCT=PARAM("ResAddCountry"),FLG=1
 ;
 I FLG=0 S RETURN(1)="-1^Required information is missing; please check input and try again." G END
 ;Else ok to file entry
FILE ;Call FILE^DICN to add new entry to PATIENT (#2) file
 N DA,DIC,DR,FULLICN K DD,DO,VAFCRSLT
 S DIC="^DPT(",DIC(0)="FLZ",DLAYGO=2,X=VAFCNAM
 ;**876 MVI_2788 (ckn) - Remove four slash use for field 1901
 ;**944 Story #557843 (cml) add code to update FULL ICN (#991.1), WHO ENTERED PATIENT (#.096), and DATE ENTERED INTO FILE (#.097) fields
 S FULLICN=VAFCICN_"V"_VAFCSUM
 S DIC("DR")=".09///"_VAFCSSN_";.03///"_VAFCDOB_";.02///"_VAFCSX_";391///"_VAFCTYP_";1901///"_VAFCVET_";.301///"_VAFCSRV_";991.01///"_VAFCICN_";991.02///"_VAFCSUM_";991.1///"_FULLICN
 I VAFCSSN="P" S DIC("DR")=DIC("DR")_";.0906///"_VAFCRSN
 ;
 ;**1050,VAMPI-9503 (mko): Separate single FILE^DICN call into one FILE^DICN call to add the record with required fields
 ;  and a subsequent FILE^DIE call to update the optional fields
 L +^DPT(0):10
 D FILE^DICN K DA,DIC,DD,DLAYGO,DO,DR
 L -^DPT(0)
 ;If record creation/update fails, return a -1^error text
 I $P(Y,U,3)'=1 S RETURN(1)="-1^"_"Attempt to add patient "_VAFCNAM_" to the PATIENT (#2) file at station number "_$P($$SITE^VASITE,"^",3)_" failed." G END
 S VAFCDFN=+Y
 ;
 ;**1050,VAMPI-9503 (mko): After record is created, call FILE^DIE to update the record
 D
 .N DIERR,DIMSG,DIHELP,FDA,IENS,MSG
 .S IENS=VAFCDFN_","
 .S:$G(VAFCPOBC)]"" FDA(2,IENS,.092)=VAFCPOBC ;POB CITY
 .S:$G(VAFCPOBS)]"" FDA(2,IENS,.093)=VAFCPOBS ;POB STATE
 .S:$G(VAFCMMN)]"" FDA(2,IENS,.2403)=VAFCMMN ;MMN
 .;**876 - MVI_2788 (ckn)
 .S:$G(VAFCMBI)]"" FDA(2,IENS,994)=VAFCMBI ;MBI
 .;**1033 ADDING ADDRESS FIELDS
 .S:$G(VAFCAL1)]"" FDA(2,IENS,.111)=VAFCAL1 ;STREET LINE 1
 .S:$G(VAFCAL2)]"" FDA(2,IENS,.112)=VAFCAL2 ;STREET LINE 2
 .S:$G(VAFCAL3)]"" FDA(2,IENS,.113)=VAFCAL3 ;STREET LINE 3
 .S:$G(VAFCACY)]"" FDA(2,IENS,.114)=VAFCACY ;CITY
 .S:$G(VAFCAST)]"" FDA(2,IENS,.115)=VAFCAST ;STATE
 .S:$G(VAFCAZ)]"" FDA(2,IENS,.1112)=VAFCAZ ;ZIP
 .S:$G(VAFCPN)]"" FDA(2,IENS,.131)=VAFCPN ;PHONE NUMBER
 .S:$G(VAFCPR)]"" FDA(2,IENS,.1171)=VAFCPR ;PROVINCE
 .S:$G(VAFCPC)]"" FDA(2,IENS,.1172)=VAFCPC ;POSTAL CODE
 .S:$G(VAFCPCT)]"" FDA(2,IENS,.1173)=VAFCPCT ;COUNTRY
 .Q:'$D(FDA)
 .L +^DPT(VAFCDFN):10 E  Q
 .D FILE^DIE("E","FDA","MSG") L -^DPT(VAFCDFN)
 ;
 ;**1042,VAMPI-8199 (mko): File County (determined from Zip); Need to use 4-slash stuff because IT is interative
 ;  when county name matches more than one entry (e.g., BALTIMORE and BALTIMORE (CITY)
 ;**1050,VAMPI-9503 (mko): Use FILE^DIE to file county instead of FILE^DICN
 D:$G(VAFCACTY)]""
 .N DIERR,DIMSG,DIHELP,FDA,MSG
 .S FDA(2,VAFCDFN_",",.117)=VAFCACTY ;COUNTY
 .L +^DPT(VAFCDFN):10 E  Q
 .D FILE^DIE("","FDA","MSG") L -^DPT(VAFCDFN)
 ;
 ;**1050,VAMPI-9503 (mko): If NC flag is set, file the name components
 K UPDNC I $$GETFLAG^VAFCPTED S UPDNC=$$UPDNC(VAFCDFN,$G(PARAM("LONGNAME"),$G(PARAM("NAME"))))
 ;
 ;**1033 VAMPI-12 (jfw) - Interfacility Consult (IFC) support
 ;      Trigger enrollment/eligibility HL7 messaging to further update patient info
 S:($G(PARAM("ENROLLMENT"))=1) VAFCRSLT=$$QRY^DGENQRY(VAFCDFN)
 ; file Who and When if not already done
 N DGZ,FDA
 S DGZ=$G(^DPT(VAFCDFN,0))
 S:'$P(DGZ,"^",15) FDA(2,VAFCDFN_",",.096)=DUZ
 S:'$P(DGZ,"^",16) FDA(2,VAFCDFN_",",.097)=DT
 D:$D(FDA) FILE^DIE("","FDA")
 ;
 ;File ALIAS multiple
 I $D(PARAM("ALIAS")) D ALIAS  ;If ALIAS data is passed, call ALIAS module
 I $G(ALSERR)="" S RETURN(1)="1^"_VAFCDFN  ;No errors for ALIAS, return DFN
 I $G(ALSERR)'="" S RETURN(1)=ALSERR
 ;
 ;**1050,VAMPI-9503 (mko): If the components of the name were filed, return 4th piece equal to 1
 S:$G(UPDNC) $P(RETURN(1),U,4)=1
 ;
END ;**1050,VAMPI-9503 (mko): Record return value and quit
 D RETURN(VAFCSEQ,.RETURN)
 Q
 ;
ALIAS ;Optional - Add ALIAS and ALIAS SSN data for entry
 ;Only occurs for a NEW record; there is no previous ALIAS data
 I '$D(PARAM("ALIAS")) Q
 ;ALIAS input comes in as: LAST^FIRST^MIDDLE^SUFFIX^SSN
 N AFN,ALN,AMN,ASFX,ASSN,ERR,FDA,I,LOC,NUM
 S (I,NUM)=0 F  S NUM=$O(PARAM("ALIAS",NUM)) Q:'NUM  D
 .S ALN=$P($G(PARAM("ALIAS",NUM)),"^") Q:ALN=""  ;Last name minimal input
 .S AFN=$P($G(PARAM("ALIAS",NUM)),"^",2),AMN=$P($G(PARAM("ALIAS",NUM)),"^",3)
 .S ASFX=$P($G(PARAM("ALIAS",NUM)),"^",4),ASSN=$P($G(PARAM("ALIAS",NUM)),"^",5)
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
 .L +^DPT(VAFCDFN):10 D UPDATE^DIE("E","FDA",,"ERR") L -^DPT(VAFCDFN)
 .I $D(ERR("DIERR")) S ALSERR="1^"_VAFCDFN_"^Patient "_PARAM("NAME")_" was successfully added at "_$P($$SITE^VASITE,"^",3)_".  However, the ALIAS data failed to update. Error message: "_$G(ERR("DIERR","1","TEXT",1)) Q
 Q
 ;
UPDNC(VAFCDFN,NAME) ;Update name components; Return 1 if updated
 ;**1050,VAMPI-9503 (mko): New subroutine
 N CURR,DIERR,DIMSG,DIHELP,FDA,MSG,NCIENS
 Q:$G(NAME)?."^" 0
 Q:$G(VAFCDFN)'>0 0
 S NCIENS=$P($G(^DPT(+VAFCDFN,"NAME")),U)_"," Q:'NCIENS 0
 ;
 ;Get current values
 D GETS^DIQ(20,NCIENS,"1;2;3;5","","CURR","MSG") Q:$G(DIERR) 0
 ;
 ;**1099,VAMPI-19828 (mko): Quit 0 if there are no differences
 S CURR("NAME")=CURR(20,NCIENS,1)_U_CURR(20,NCIENS,2)_U_CURR(20,NCIENS,3)_U_CURR(20,NCIENS,5)_U
 S $P(NAME,U,5)=""
 Q:CURR("NAME")=NAME 0
 ;
 ;**1099,VAMPI-19828 (mko): Set FDA for each component even if not different from current
 ;  so that FILE^DIE can check that all are valid before any are filed.
 S FDA(20,NCIENS,1)=$P(NAME,U)
 S FDA(20,NCIENS,2)=$P(NAME,U,2)
 S FDA(20,NCIENS,3)=$P(NAME,U,3)
 S FDA(20,NCIENS,5)=$P(NAME,U,4)
 ;
 ;Call Filer
 D FILE^DIE("EKT","FDA","MSG")
 Q '$G(DIERR)
 ;
 ;=================================================
 ; Code for storing debugging information in ^XTMP
 ;=================================================
RECORD(PARAM,RPCNAME) ;Record RPC inputs for debugging
 ;Return seq# in ^XTMP
 N NODE,NOW,SEQ,TODAY
 Q:'$$ISDEBUG 0
 S:$G(RPCNAME)="" RPCNAME="VAFC VOA ADD PATIENT"
 S NOW=$$NOW^XLFDT,TODAY=$P(NOW,".")
 S NODE=$$NODE
 ;
 L +^XTMP(NODE):2
 D SETXTMP0(NODE)
 S SEQ=$O(^XTMP(NODE," "),-1)+1
 M ^XTMP(NODE,SEQ,"PARAM")=PARAM
 S ^XTMP(NODE,SEQ,"DT")=NOW
 S ^XTMP(NODE,SEQ,"DUZ")=$G(DUZ)
 S ^XTMP(NODE,SEQ,"RPC")=RPCNAME
 L -^XTMP(NODE)
 Q SEQ
 ;
RETURN(SEQ,RETURN) ;Record the return value
 Q:'SEQ  Q:'$$ISDEBUG
 M ^XTMP($$NODE,SEQ,"RETURN")=RETURN
 Q
 ;
DBON ;Set DEBUG on
 N NODE
 S NODE=$$NODE
 D SETXTMP0
 S ^XTMP(NODE,"DEBUG")=1
 W !,$NA(^XTMP(NODE,"DEBUG"))_" set to 1.",!
 Q
 ;
DBOFF ;Set DEBUG off
 N NODE
 S NODE=$$NODE
 K ^XTMP(NODE,"DEBUG")
 K:'$O(^XTMP(NODE,0)) ^XTMP(NODE)
 W !,$NA(^XTMP(NODE,"DEBUG"))_" killed.",!
 Q
 ;
ISDEBUG() ;Return 1 if DEBUG mode flag is set
 Q $G(^XTMP($$NODE,"DEBUG"))
 ;
PURGE ;Purge the debugging data stored in ^XTMP
 N ISDEBUG
 S ISDEBUG=$$ISDEBUG
 K ^XTMP($$NODE)
 W !,$NA(^XTMP($$NODE))_" killed.",!
 D:ISDEBUG DBON
 Q
 ;
SETXTMP0(NODE,DESC,LIFE) ;Set 0 node of ^XTMP(node)
 N CREATEDT
 S:$G(NODE)="" NODE=$$NODE
 S CREATEDT=$S($D(^XTMP(NODE,0))#2:$P(^(0),U,2),1:DT)
 S:'$G(LIFE) LIFE=30
 S:$G(DESC)="" DESC="Inputs and Outputs to RPC: VAFC VOA ADD PATIENT"
 S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,LIFE)_U_CREATEDT_U_DESC
 Q
 ;
NODE() ;Return ^XTMP Debug subscript
 Q "VAFC_VOA_ADD_PATIENT"
