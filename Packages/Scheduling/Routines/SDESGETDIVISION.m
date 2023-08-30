SDESGETDIVISION ;ALB/BWF,TJB - SDES GET DIVISION/FACILITY/TIMEZONE ;JUNE 5, 2023
 ;;5.3;Scheduling;**819,846**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
GETDIVISIONLIST(RESULTS,SEARCHTRM,EAS) ;
 N DATA,FACILITYNUM,FACARRY,ERRORS,ERR
 S SEARCHTRM=$G(SEARCHTRM)
 D VALINPUT(.ERRORS,SEARCHTRM)
 D VALIDATEEAS(.ERRORS,$G(EAS))
 I $D(ERRORS) D  Q
 .S ERRORS("Division",1)=""
 .D BUILDJSON^SDESBUILDJSON(.RESULTS,.ERRORS) Q
 ; If INPUT data passed in use FIND to get the list of matching DIVISIONS
 I SEARCHTRM'="" D
 . K DATA,ERR D FIND^DIC(40.8,,".07I;1","M",SEARCHTRM,,,,,"DATA","ERR")
 ; Otherwise just list all DIVISION from file 40.8
 I SEARCHTRM="" D
 . K DATA,ERR D LIST^DIC(40.8,,".07I;1","",,,,,,,"DATA","ERR")
 I $D(ERR) D  Q
 . S ERRORS("Division",1)=""
 . S ERRORS("Error",1)="Errors in "_$S(SEARCHTRM'="":"FIND^DIC",1:"LIST^DIC")
 . S ERRORS("Error",2)=$G(ERR("DIERR",1,"TEXT",1))
 . D BUILDJSON^SDESBUILDJSON(.RESULTS,.ERRORS) Q
 ; Build the FACARRY to then be returned
 D BUILDATA(.DATA,.FACARRY)
 D BUILDJSON^SDESBUILDJSON(.RESULTS,.FACARRY)
 Q
VALINPUT(ERRORS,INPUT)    ;
 Q:$G(INPUT)=""  ; If INP is empty then just continue
 I $L($G(INPUT))<2 D ERRLOG^SDESJSON(.ERRORS,64)
 Q
VALIDATEEAS(ERRORS,SDEAS) ;
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL($G(SDEAS))
 I $P($G(SDEAS),U)=-1 D ERRLOG^SDESJSON(.ERRORS,142)
 Q
BUILDATA(DATA,FACARRY) ; Build out array to be put into JSON format
 N DCNT,ITEM,DIVNM,DIVIEN,FACILITYNUM,INST,INSTIMEZONE,FACTYP,PARINST,INSTFAC,J,JJ,TZARRAY,JTZ
 S (DCNT,ITEM,J)=0 F  S ITEM=$O(DATA("DILIST",1,ITEM)) Q:'ITEM  D
 . S (DIVNM,DIVIEN,FACILITYNUM,PARINST,FACTYP)=""
 . S DCNT=DCNT+1
 . S DIVNM=$G(DATA("DILIST",1,ITEM)) ; DIVISION Name
 . S DIVIEN=$G(DATA("DILIST",2,ITEM)) ; DIVISION IEN
 . S FACILITYNUM=$G(DATA("DILIST","ID",ITEM,1))
 . S PARINST=$G(DATA("DILIST","ID",ITEM,.07)) ; Parent Institution IEN
 . S FACARRY("Division",DCNT,"Name")=DIVNM
 . S FACARRY("Division",DCNT,"ID")=DIVIEN
 . S FACARRY("Division",DCNT,"FacilityNumber")=FACILITYNUM
 . ; Get data from the instution file
 . K INST,ERR D GETS^DIQ(4,PARINST_",","101;.01;99;11;13;800;802","IEP","INST","ERR")
 . S INSTIMEZONE=$G(INST(4,PARINST_",",800,"I"))
 . ; Get data from world timezone file
 . I INSTIMEZONE'="" K TZARRAY,ERR D GETS^DIQ(1.71,INSTIMEZONE_",","1*","IE","TZARRAY","ERR")
 . S FACTYP=$G(INST(4,PARINST_",",13,"I"))
 . ; Get data from the Facility Type file
 . I FACTYP'="" K INSTFAC,ERR D GETS^DIQ(4.1,FACTYP_",",".01;3","IE","INSTFAC","ERR")
 . S FACARRY("Division",DCNT,"Institution","Inactive")=$G(INST(4,PARINST_",",101,"I"))
 . S FACARRY("Division",DCNT,"Institution","Name")=$G(INST(4,PARINST_",",.01,"I"))
 . S FACARRY("Division",DCNT,"Institution","StationNumber")=$G(INST(4,PARINST_",",99,"I"))
 . S FACARRY("Division",DCNT,"FacilityType","Name")=$G(INSTFAC(4.1,FACTYP_",",.01,"I"))
 . S FACARRY("Division",DCNT,"FacilityType","Status")=$G(INSTFAC(4.1,FACTYP_",",3,"I"))
 . S FACARRY("Division",DCNT,"ParentFacility")=PARINST
 . S FACARRY("Division",DCNT,"Status")=$G(INST(4,PARINST_",",11,"I"))
 . S FACARRY("Division",DCNT,"InactiveFacilityFlag")=$G(INST(4,PARINST_",",101,"I"))
 . S FACARRY("Division",DCNT,"TimeZone")=$G(INST(4,PARINST_",",800,"E"))
 . I $D(TZARRAY(1.711))>0 S JJ="",J=0 F  S JJ=$O(TZARRAY(1.711,JJ)) Q:JJ=""  D
 . . S J=J+1
 . . S FACARRY("Division",DCNT,"TimeZoneDetails",J,"TimeFrame")=$G(TZARRAY(1.711,JJ,.01,"E"))
 . . S FACARRY("Division",DCNT,"TimeZoneDetails",J,"Offset")=$G(TZARRAY(1.711,JJ,.02,"E"))
 . . S FACARRY("Division",DCNT,"TimeZoneDetails",J,"TimeZoneCode")=$G(TZARRAY(1.711,JJ,.03,"E"))
 . S FACARRY("Division",DCNT,"TimeZoneException")=$G(INST(4,PARINST_",",802,"E"))
 I '$D(FACARRY) S FACARRY("Division",1)=""
 Q
