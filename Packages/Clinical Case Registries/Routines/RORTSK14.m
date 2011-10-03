RORTSK14 ;HCIOFO/SG - PARSER FOR REPORT PARAMETERS (TOOLS) ; 4/25/07 2:48pm
 ;;1.5;CLINICAL CASE REGISTRIES;**2**;Feb 17, 2006;Build 6
 ;
 Q
 ;
 ;***** CALCULATES START AND END DATES FROM DATE RANGE ATTRIBUTES
 ;
 ; .ATTR         Reference to a local variable that contains
 ;               attributes of the <DATE_RANGE> element.
 ;
 ; .STDT         Reference to a local variable where
 ;               the start date is returned to
 ;
 ; .ENDT         Reference to a local variable where
 ;               the end date is returned to
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; NOTE: In case of an error the function does not change
 ;       values of the STDT and ENDT parameters.
 ;
DTRANGE(ATTR,STDT,ENDT) ;
 N ENDT1,FISCAL,I,QUARTER,RC,RORMSG,STDT1,TMP,TYPE,YEAR
 S (STDT1,ENDT1)="",TYPE=$G(ATTR("TYPE"))
 S RC=0  D  Q:RC<0 $$DBS^RORERR("RORMSG",-9)
 . ;
 . ;--- CUSTOM: StartDate, EndDate
 . I TYPE="CUSTOM"  D  Q
 . . S STDT1=$G(ATTR("START")),ENDT1=$G(ATTR("END"))
 . ;
 . ;--- CUTOFF: Cutoff
 . I TYPE="CUTOFF"  D  Q
 . . S ENDT1=$$DT^XLFDT,TMP=$$TRIM^XLFSTR($G(ATTR("CUTOFF")))
 . . ;--- Strip "TODAY-" (or "T-") from the attribute value
 . . S:TMP["-" TMP=$P(TMP,"-",2)
 . . ;--- Calculate the start date
 . . D DT^DILF("P","TODAY-"_TMP,.STDT1,-ENDT1,"RORMSG")
 . . S:STDT1<0 RC=STDT1
 . ;
 . ;--- QUARTER: Quarter, Year, Fiscal
 . I TYPE="QUARTER"  D  Q
 . . S QUARTER=+$G(ATTR("QUARTER")),YEAR=+$G(ATTR("YEAR"))
 . . S FISCAL=+$G(ATTR("FISCAL"))  S:FISCAL QUARTER=QUARTER-1
 . . S TMP=$P("10/01^01/01^04/01^07/01^10/01","^",QUARTER+1)
 . . S TMP=TMP_"/"_$S(QUARTER:YEAR,1:YEAR-1)
 . . D DT^DILF("P",TMP,.STDT1,,"RORMSG")
 . . I STDT1<0  S RC=STDT1  Q
 . . S TMP=$P("12/31^03/31^06/30^09/30^12/31","^",QUARTER+1)
 . . S TMP=TMP_"/"_$S(QUARTER:YEAR,1:YEAR-1)
 . . D DT^DILF("P",TMP,.ENDT1,STDT1,"RORMSG")
 . . I ENDT1<0  S RC=ENDT1  Q
 . ;
 . ;--- YEAR: Year, Fiscal
 . I TYPE="YEAR"  D  Q
 . . S YEAR=+$G(ATTR("YEAR")),FISCAL=+$G(ATTR("FISCAL"))
 . . S TMP=$S(FISCAL:"10/01/"_(YEAR-1),1:"01/01/"_YEAR)
 . . D DT^DILF("P",TMP,.STDT1,,"RORMSG")
 . . I STDT1<0  S RC=STDT1  Q
 . . S TMP=$S(FISCAL:"09/30/"_YEAR,1:"12/31/"_YEAR)
 . . D DT^DILF("P",TMP,.ENDT1,STDT1,"RORMSG")
 . . I ENDT1<0  S RC=ENDT1  Q
 ;
 ;--- Invalid time frame
 I (STDT1'>0)!(ENDT1'>0)!(STDT1>ENDT1)  D  Q RC
 . S RC=$$ERROR^RORERR(-88,,,,"DATE_RANGE",STDT1_"-"_ENDT1)
 ;
 ;--- Success
 S STDT=STDT1,ENDT=ENDT1
 Q 0
