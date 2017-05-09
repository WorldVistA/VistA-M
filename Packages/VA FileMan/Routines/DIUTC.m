DIUTC ;O-OIFO/ALA/LG - UTC Timezone API ;Dec 16, 2015  10:00 AM
 ;;22.2;VA FileMan;**2**;Jan 05, 2016;Build 139
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
UTC(DTM,TMZ,INST,CNTRY,EXT) ;PEP - Return UTC value
 ;
 ; Input Parameters - DATE/TIME (DTM) is (*REQUIRED*) all other parameters are (Optional)
 ;
 ;   DTM   - Standard Date/Time; FileMan Internal and External; FileMan-specific e.g. NOW, T+1@12A
 ;   TMZ   - TimeZone ? Either Full Name (e.g., EASTERN; EASTERN EUPOREAN; ESTONIA; YUKON)
 ;           or Pointer to the WORLD TIMEZONE (#1.71) file.
 ;           Note: Time Zone Abbreviation (e.g. EST) can be ambiguous so is not used
 ;   INST  - Pointer to Institution (#4) file
 ;   CNTRY - Country Name or Pointer to the COUNTRY CODE (#779.004) file.
 ;           If Country Name is passed in, it must match the name in the HL7 COUNTRY file  
 ;   EXT   - Extended return value
 ;           Null=Default returns GMT with offset (internal FM format)
 ;           1 returns GMT with offset (internal FM format) with additional external values (multi-part)
 ;
 ; Output 
 ;   returns GMT with offset (internal FM format), if EXT=1 returns additional external values
 ;
 ;
 N %DT,XX,H,M,X,Y
 N CODE,DTME,GMT,GMTE,GMTO,INSTE,OFF,TMFRM,TMZE,CNTRYE,TMZEXC
 ;
 ; get values for all possible parameters
 F XX="DTM","TMZ","INST","CNTRY","EXT" S @XX=$G(@XX)
 ;
 I DTM="" Q -1_"^Date/Time parameter is missing."
 I INST]"",(TMZ]""!(CNTRY]"")) Q -1_"^Institution parameter cannot include Country or Timezone parameter."
 I TMZ]"",CNTRY="" Q -1_"^Timezone parameter must include Country parameter."
 I CNTRY]"",TMZ="" Q -1_"^Country parameter must include Timezone parameter."
 I EXT'="",(EXT'=1) Q -1_"^Extended parameter must be NULL or a 1 for extended output."
 ;
 S %DT="RSTX",X=DTM D ^%DT
 I Y<0 Q Y_"^Invalid Date/Time"
 S DTM=$E(Y_"00000",1,14)
 S Y=DTM D DD^%DT S DTME=Y ; External Date/Time
 ;
 ; Find offset if timezone and country parameteres are passed
 I TMZ]"" D  ;
 . I +TMZ'=TMZ S TMZ=$$FIND1^DIC(1.71,"","X",TMZ,"","","ERROR")
 . S TMZE=$$GET1^DIQ(1.71,TMZ_",",.01,"E")
 I CNTRY]"" D  ;
 . I +CNTRY'=CNTRY S CNTRY=$$FIND1^DIC(779.004,"","MX",CNTRY,"D","","ERROR")
 ;
 ; If no timezone param, no country param, look for institution param
 ; If the institution param exists get values:
 ; institution (external), timezone (internal/external), country (internal), timezone exception (internal)
 ; If no institution param, try to get data from default instituion stored in DUZ(2)
 I TMZ="",CNTRY="" N MSG D  I $D(MSG) Q -1_MSG
 . I INST D  Q  ; if Institution is passed get data from Institution file #4
 . . S INSTE=$$GET1^DIQ(4,INST_",",.01,"E")
 . . S TMZ=$$GET1^DIQ(4,INST_",",800,"I")
 . . S TMZE=$$GET1^DIQ(4,INST_",",800,"E")
 . . S CNTRY=$$GET1^DIQ(4,INST_",",801,"I")
 . . S TMZEXC=$$GET1^DIQ(4,INST_",",802,"I")
 . . I 'TMZ!'CNTRY S MSG="^Cannot determine Country and Timezone from the Institution."
 . ; if Institution not passed try default Institution in DUZ(2)
 . I +$G(DUZ(2))=0 S MSG="^Cannot determine User location." Q  ; quit if DUZ(2) not defined with message
 . S INSTE=$$GET1^DIQ(4,+DUZ(2)_",",.01,"E")
 . S TMZ=$$GET1^DIQ(4,+DUZ(2)_",",800,"I")
 . S TMZE=$$GET1^DIQ(4,+DUZ(2)_",",800,"E")
 . S CNTRY=$$GET1^DIQ(4,+DUZ(2)_",",801,"I")
 . S TMZEXC=$$GET1^DIQ(4,+DUZ(2)_",",802,"I")
 . I 'TMZ!'CNTRY S MSG="^Cannot determine Country and Timezone from User location."
 ;
 ; uppercase the external value for Country from Description field (#2) in file (#779.004)
 I CNTRY S CNTRYE=$$UP^XLFSTR($$GET1^DIQ(779.004,CNTRY_",",2,"E"))
 ;
 I 'TMZ Q -1_"^Invalid Timezone."
 I 'CNTRY Q -1_"^Invalid Country."
 I '$D(^DIT(1.71,"AB",CNTRY,TMZ)) Q -1_"^Mismatch of Country and Timezone."
 ;
 D CHECKDST ; check for daylight savings, standard, or summer timeframe
 D GMT ; convert input time to Greenwich Mean Time based on Offset
 ;
 ; Quit with GMT+Offset only (internal value)
 I 'EXT Q GMT_GMTO
 ;
 ; Quit with "Extended" output
 Q GMT_GMTO_U_GMTE_" (UTC"_OFF_")"_U_OFF_U_$G(TMZE)_U_$G(CNTRYE)_U_$G(CODE)_U_$G(TMFRM)_U_$G(INSTE)
 ;
 ;GMT+OFFSET ^ GMT+OFFSET EXT ^ OFFSET ^ TIMEZONE EXT ^ COUTRY EXT ^ TIMEZONE ABBREV ^ TIMEFRAME EXT (DAYLIGHT,STANDARD,SUMMER) ^ INSTITUTION EXT
 ;
GMT ; calculate GMT time
 ;
 I '$D(OFF) Q  ; quit if we don't have the Offset
 ;
 S H=$E(OFF,2,3),M=$E(OFF,4,5) ; get hour and minutes from GMT offset
 S H=$TR($E(OFF),"-+","+-")_H
 S M=$TR($E(OFF),"-+","+-")_M
 S GMT=$$FMADD^XLFDT(DTM,,H,M,) ; GMT internal Date/Time value
 S GMT=$E(GMT_"00000",1,14)
 S Y=GMT D DD^%DT S GMTE=Y ; GMT External Date/Time value
 S GMTO=OFF,M=$E(GMTO,4,5)
 S GMTO=$E(GMTO,1,3)*60+M/5+500
 ;(+/-hours x 60 + minutes) / 5 = value    then   500 +/- value = offset
 ;
 ; massage offset for output
 S OFF=$E(OFF,1,3)_":"_$E(OFF,4,5)
 Q
 ;
CHECKDST ;
 ; Check if this timezone changes to daylight (or summer) time or not
 ; (TDST=1, DOES NOT CHANGE, TDST=0, does change)
 ;
 N TDST,SIEN,DIEN,CIEN,DSIEN,YEAR,YIEN,STAN,SDTM,EDTM,DST,DSAV,SAME
 ;
 S TDST=1
 S SIEN=$O(^DIT(1.71,TMZ,1,"B","SST",""))
 S DIEN=$O(^DIT(1.71,TMZ,1,"B","DST",""))
 I 'DIEN S DIEN=$O(^DIT(1.71,TMZ,1,"B","SUM",""))
 I DIEN S CIEN=$O(^DIT(1.71,TMZ,1,DIEN,1,"B",CNTRY,""))
 I $G(CIEN) S TDST=0,DST=1
 I '$G(CIEN) S TDST=1
 ; If the timezone does not change, then DST would be zero for standard time (SST)
 I $G(TDST) S DST=0
 ; retrieve the offset for daylight savings (DST=1) OR standard (DST=0)
 S STAN=^DIT(1.71,TMZ,1,SIEN,0) I DIEN'="" S DSAV=^DIT(1.71,TMZ,1,DIEN,0)
 I 'TDST D
 . S DSIEN=$O(^DIT(1.72,"B",CNTRY,""))
 . I 'DSIEN Q  ; quit if country timeframes not found in world daylight savings file #1.72
 . S SAME=$P(^DIT(1.72,DSIEN,0),"^",3)
 . I SAME'="" S DSIEN=$O(^DIT(1.72,"B",SAME,""))
 ;
 ; using the year from the date, determine the start and end date/time of world daylight savings from file #1.72
 I $G(DSIEN) D
 . S YEAR=$P($$FMTE^XLFDT(DTM\1,5),"/",3)
 . S YIEN=$O(^DIT(1.72,DSIEN,1,"B",YEAR,""))
 . I YIEN'="" S SDTM=$P(^DIT(1.72,DSIEN,1,YIEN,0),"^",2),EDTM=$P(^(0),"^",3)
 . I YIEN="" Q  ; quit if year data not found
 . ; if DST=1, daylight savings in affect, DST=0, standard time in affect
 . I DTM<SDTM!(DTM'<EDTM) S DST=0
 . I DTM'<SDTM,DTM<EDTM S DST=1
 ;
 I $G(TMZEXC)=0 S DST=0 ; Timezone Exception from Institution file #4
 ;
 I 'DST S OFF=$P(STAN,"^",2),CODE=$P(STAN,"^",3),TMFRM=$P(STAN,U)
 I DST S OFF=$P(DSAV,"^",2),CODE=$P(DSAV,"^",3),TMFRM=$P(DSAV,U)
 S TMFRM=$S(TMFRM="SST":"STANDARD",TMFRM="DST":"DAYLIGHT SAVINGS",TMFRM="SUM":"SUMMER",1:"") ; set Timeframe
 Q
