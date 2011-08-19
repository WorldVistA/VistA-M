SDAMA202 ;BPOIFO/ACS-Scheduling Replacement APIs ; 12/13/04 3:15pm
 ;;5.3;Scheduling;**253,275,283,316,347**;13 Aug 1993
 ;
 ;GETPLIST - Returns appointment information for a clinic
 ;
 ;**   BEFORE USING THE API IN THIS ROUTINE, PLEASE SUBSCRIBE      **
 ;**   TO DBIA #3869                                               **
 ;
 ;*******************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;09/20/02  SD*5.3*253    ROUTINE COMPLETED
 ;12/10/02  SD*5.3*275    ADDED PATIENT STATUS FILTER
 ;07/03/03  SD*5.3*283    REMOVED 'NO ACTION TAKEN' EDIT.  REMOVED
 ;                        'GETALLCL' API
 ;09/16/03  SD*5.3*316    EXCLUDE 'CANCELLED' APPTS.  CHECK FOR 
 ;                        CLINIC MATCH ON ^DPT
 ;07/26/04  SD*5.3*347    ADDED PATIENT VARIABLE CHECK TO ENSURE THAT
 ;                        VALUE RETURNED FROM $$GETPTIEN^SDAMA200 IS 
 ;                        NOT NULL
 ;                        REMOVE DIRECT ACCESS TO DATA.  ALL ACCESS
 ;                        THROUGH SDAPI ONLY
 ;********************************************************************  
 ;
GETPLIST(SDCLIEN,SDFIELDS,SDAPSTAT,SDSTART,SDEND,SDRESULT,SDIOSTAT) ;
 ;********************************************************************
 ;
 ;               GET APPOINTMENTS FOR A CLINIC
 ;
 ;INPUT
 ;  SDCLIEN      Clinic IEN (required) 
 ;  SDFIELDS     Fields requested (optional)
 ;  SDAPSTAT     Appointment Status filter (optional)
 ;  SDSTART      Start date/time (optional)
 ;  SDEND        End date/time (optional)
 ;  SDRESULT     Record count returned here (optional)
 ;  SDIOSTAT     Patient Status filter (optional)
 ;  
 ;OUTPUT
 ;  ^TMP($J,"SDAMA202","GETPLIST",X,Y)=FieldYdata
 ;  where "X" is an incremental appointment counter and
 ;  "Y" is the field number requested
 ;  
 ;
 ;********************************************************************
 N SDAPINAM,SDRTNNAM
 S SDAPINAM="GETPLIST",SDRTNNAM="SDAMA202",SDRESULT=0
 K ^TMP($J,SDRTNNAM,SDAPINAM)
 S SDRESULT=$$VALIDATE^SDAMA200(.SDCLIEN,.SDFIELDS,.SDAPSTAT,.SDSTART,.SDEND,SDAPINAM,SDRTNNAM,.SDIOSTAT)
 I SDRESULT=-1 Q
 ;
 N SDCOUNT,SDNUM,SDTMP,SDI,SDARRAY,SDAPLST,SDX,SDY,SDCI,SDPI,SDTI,SDTR,SDF,SDA,SDR,SDO
 S (SDNUM,SDCOUNT,SDI)=0,(SDAPLST,SDTMP)=""
 F SDI="SDFIELDS","SDAPSTAT","SDSTART","SDEND","SDRESULT","SDIOSTAT" S @SDI=$G(@SDI)
 ; Quit if only status requested is "C"
 I SDAPSTAT="C"!(SDAPSTAT=";C;") S SDRESULT=0 Q
 I +SDSTART!(+SDEND) S SDARRAY(1)=SDSTART_";"_SDEND
 S SDARRAY(2)=SDCLIEN
 I $L($G(SDAPSTAT))>0 D
 . ;Remove a leading and a trailing semicolon
 . I $E(SDAPSTAT,$L(SDAPSTAT))=";" S SDAPSTAT=$E(SDAPSTAT,1,($L(SDAPSTAT)-1))
 . I $E(SDAPSTAT)=";" S SDAPSTAT=$E(SDAPSTAT,2,$L(SDAPSTAT))
 . ;IO/Appt Statuses have been validated by SDAMA200 to be I or O/R NT
 . I $L($G(SDIOSTAT))=1 S SDAPLST=$S(SDIOSTAT="I":"I;",SDIOSTAT="O":SDAPSTAT_";")
 . I $L($G(SDIOSTAT))'=1,$L($G(SDAPSTAT)) D
 .. ;Reset appointment status R=R;I N=NS,NSR
 .. S SDNUM=$L(SDAPSTAT,";") F SDI=1:1:SDNUM D
 ... S SDTMP=$P(SDAPSTAT,";",SDI) Q:SDTMP="C"
 ... S SDTMP=$S(SDTMP="R":"R;I",SDTMP="N":"NS;NSR",1:SDTMP)
 ... S SDAPLST=SDAPLST_SDTMP_";"
 . ;Remove trailing semicolon
 . S SDAPLST=$E(SDAPLST,1,($L(SDAPLST)-1))
 I $L($G(SDAPSTAT))=0 S SDAPLST="R;I;NS;NSR;NT"
 S SDARRAY(3)=SDAPLST
 ;Field List Conversion
 S SDARRAY("FLDS")=""
 F SDX=1:1 S SDY=$P(SDFIELDS,";",SDX) Q:SDY=""  D
 . I SDY=12,SDFIELDS[3 Q  ; if appt. stat. exists, pat. stat. not needed 
 . I SDY=12 S SDY=3
 . S SDARRAY("FLDS")=SDARRAY("FLDS")_SDY_";"
 S:$L(SDARRAY("FLDS")) SDARRAY("FLDS")=$E(SDARRAY("FLDS"),1,$L(SDARRAY("FLDS"))-1)
 I '$L(SDFIELDS) S SDARRAY("FLDS")="1;2;3;4;5;6;7;8;9;10;11"
 ;
 ; Setup done, call SDAPI, quit if no appointment (SDCOUNT=0) and return 0
SDAPI S (SDRESULT,SDCOUNT)=$$SDAPI^SDAMA301(.SDARRAY) I SDCOUNT=0 S SDRESULT=0 Q
 ;
 ;If we have an appointment, process it
 I SDCOUNT>0 S SDA=0,SDCI="" F  S SDCI=$O(^TMP($J,"SDAMA301",SDCI)) Q:SDCI=""  D
 . S SDPI="" F  S SDPI=$O(^TMP($J,"SDAMA301",SDCI,SDPI)) Q:SDPI=""  D
 .. S SDTI="" F  S SDTI=$O(^TMP($J,"SDAMA301",SDCI,SDPI,SDTI)) Q:SDTI=""  S SDTR=^(SDTI) D
 ... S SDA=SDA+1 F SDX=1:1 S SDF=$P(SDFIELDS,";",SDX),SDY=$P(SDTR,"^",SDF) Q:SDF=""  D
 .... I "^1^5^9^11^"[(U_SDF_U) S SDO=SDY D OUT Q
 .... I "^2^4^8^10^"[(U_SDF_U) S SDO=$TR(SDY,";","^") D OUT Q
 .... I "^3^6^7^12^"[(U_SDF_U) D @("FLD"_SDF)
 ; Process errors if any
 I SDCOUNT<0 D
 .S SDRESULT=-1,SDX=$O(^TMP($J,"SDAMA301",""))
 .S SDX=$S(SDX=101:101,SDX=116:116,1:117)
 .D ERROR^SDAMA200(SDX,SDAPINAM,0,SDRTNNAM) Q
 K ^TMP($J,"SDAMA301")
 Q
FLD3 S SDR=$P(SDY,";",1)
 S SDO=$S(SDR="I":"R",SDR?1(1"NS",1"NSR"):"N",1:SDR) D OUT
 Q
FLD6 S SDO=$G(^TMP($J,"SDAMA301",SDCI,SDPI,SDTI,"C"))
 D OUT
 Q
FLD7 S SDO=$S(SDY="":"N",1:SDY)
 D OUT
 Q
FLD12 S SDR=$P($P(SDTR,U,3),";",1)
 S SDO=$S(SDR="I":"I",SDR="R":"O",SDR="NT":"O",1:"") D OUT
 Q
OUT S ^TMP($J,"SDAMA202","GETPLIST",SDA,SDF)=SDO
 Q
