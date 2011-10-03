SDAMA302 ;BPOIFO/ACS-Filter API By Clinic ; 9/14/05 12:45pm
 ;;5.3;Scheduling;**301,347,508**;13 Aug 1993
 ;PER VHA DIRECTIVE 2004-038, DO NOT MODIFY THIS ROUTINE
 ;
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;12/04/03  SD*5.3*301    ROUTINE COMPLETED
 ;08/06/04  SD*5.3*347    CHANGE CALL TO ^SDAMA305 TO SETARRAY
 ;02/22/07  SD*5.3*508    SEE SDAMA301 FOR CHANGE LIST
 ;*****************************************************************
 ;
 ;*****************************************************************
 ;
 ;               GET APPOINTMENT DATA BY CLINIC
 ;
 ;INPUT
 ;  SDARRAY   Appointment Filter array
 ;  SDDV      Appointment Data Values array
 ;  SDFLTR    Filter Flags array
 ;  
 ;*****************************************************************
CLIN(SDARRAY,SDDV,SDFLTR) ;
 N SDCOUNT,SDX,SDQUIT,SDCLIEN,SDSTART,SDEND,SDGBL
 S (SDCOUNT,SDQUIT)=0
 ;Set up start and end date/times for search criteria
 I $G(SDARRAY("MAX"))'<0  D
 .S SDSTART=$S(SDARRAY("FR")'="":(SDARRAY("FR")-.000001),1:0)
 .S SDEND=SDARRAY("TO")
 I $G(SDARRAY("MAX"))<0  D
 .S SDSTART=$S($G(SDARRAY("FR"))'="":SDARRAY("FR"),1:0)
 .S SDEND=(SDARRAY("TO")+.000001)
 ;
 ;If clinic filter is populated
 I $L($G(SDARRAY(2)))>0 D
 . ;if clinic is in a list:
 . I SDARRAY("CLNGBL")=0 D
 .. S SDCOUNT=$L(SDARRAY(2),";")
 .. ;For each clinic in the filter:
 .. F SDX=1:1:SDCOUNT D
 ... S SDCLIEN=$P(SDARRAY(2),";",SDX)
 ... ;call VistA for appointment information
 ... D CALLVSTA(SDCLIEN,SDSTART,SDEND,.SDARRAY)
 . ;if clinic is in array, get IENs
 . I SDARRAY("CLNGBL")=1 D
 .. S SDGBL=SDARRAY(2),SDCLIEN=0
 .. ;for each clinic in the global:
 .. F  S SDCLIEN=$O(@(SDGBL_"SDCLIEN)")) Q:$G(SDCLIEN)=""  D
 ... ;call VistA for appointment information
 ... D CALLVSTA(SDCLIEN,SDSTART,SDEND,.SDARRAY)
 ;
 ;If clinic filter is not populated
 I $L(SDARRAY(2))'>0 D
 . ;for each clinic on ^SC
 . S SDCLIEN=0 F  S SDCLIEN=$O(^SC(SDCLIEN)) Q:(+$G(SDCLIEN)=0)  D
 .. ;call VistA for appointment information
 .. D CALLVSTA(SDCLIEN,SDSTART,SDEND,.SDARRAY)
 Q
 ;
CALLVSTA(SDCLIEN,SDSTART,SDEND,SDARRAY) ;
 ;retrieve appointment information from VistA
 I $$CLMIG^SDAMA307(SDCLIEN,.SDARRAY) D
 . ;adjust end time if clinic has completed migration
 . ;(Only Non-migrated appointments returned from VistA)
 . I $G(SDARRAY("MIG"))]"" D
 .. S SDEND=+$G(SDARRAY("MIG"))
 .. ;increment SDEND to capture all appointments when ordering
 .. S:$G(SDARRAY("MAX"))<0 SDEND=(SDEND+.000001)
 . D GETAPPT(SDCLIEN,SDSTART,SDEND,.SDARRAY)
 Q
 ;
GETAPPT(SDCLIEN,SDSTART,SDEND,SDARRAY) ;
 ;since "by clinic", 1st sort is clinic
 S SDARRAY("SORT1")=SDCLIEN
 N SDAPPTDT,SDA
 ;if the current clinic has no appointments on ^SC, get next clinic
 Q:'$D(^SC(SDCLIEN,"S"))
 ;
 ;get first "N" appointments
 I $G(SDARRAY("MAX"))'<0  D
 .S SDAPPTDT=SDSTART
 .;spin through each date/time for current clinic
 .F  S SDAPPTDT=$O(^SC(SDCLIEN,"S",SDAPPTDT)) Q:$S(+$G(SDAPPTDT)=0:1,SDAPPTDT>SDEND:1,SDARRAY("CNT")=$G(SDARRAY("MAX")):1,1:0)  D
 .. ;spin through each appointment for that date/time
 .. S SDA=0 F  S SDA=$O(^SC(SDCLIEN,"S",SDAPPTDT,1,SDA)) Q:$S(+$G(SDA)=0:1,SDARRAY("CNT")=$G(SDARRAY("MAX")):1,1:0)  D
 ... D GETINFO(SDCLIEN,SDAPPTDT,SDA,.SDARRAY)
 ;
 ;get last "N" appointments
 I $G(SDARRAY("MAX"))<0  D
 .S SDAPPTDT=SDEND
 .;spin through each date/time for current clinic (REVERSE Order)
 .F  S SDAPPTDT=$O(^SC(SDCLIEN,"S",SDAPPTDT),-1) Q:$S(+$G(SDAPPTDT)=0:1,SDAPPTDT<SDSTART:1,SDARRAY("CNT")=-$G(SDARRAY("MAX")):1,1:0)  D
 .. ;spin through each appointment for that date/time (REVERSE Order)
 .. S SDA="" F  S SDA=$O(^SC(SDCLIEN,"S",SDAPPTDT,1,SDA),-1) Q:$S(+$G(SDA)=0:1,SDARRAY("CNT")=-$G(SDARRAY("MAX")):1,1:0)  D
 ... D GETINFO(SDCLIEN,SDAPPTDT,SDA,.SDARRAY)
 Q
 ;
GETINFO(SDCLIEN,SDAPPTDT,SDA,SDARRAY) ;
 N SDPATIEN,SDCAN,SDQUIT
 S SDQUIT=0
 ;get appointment data on ^SC
 S SDARRAY("SC0")=$G(^SC(SDCLIEN,"S",SDAPPTDT,1,SDA,0))
 S SDARRAY("SCC")=$G(^SC(SDCLIEN,"S",SDAPPTDT,1,SDA,"C"))
 S SDARRAY("SCOB")=$G(^SC(SDCLIEN,"S",SDAPPTDT,1,SDA,"OB"))
 S SDARRAY("SCONS")=$G(^SC(SDCLIEN,"S",SDAPPTDT,1,SDA,"CONS"))
 S SDARRAY("DATE")=SDAPPTDT
 ;exclude cancelled appts
 S SDCAN=$P($G(SDARRAY("SC0")),"^",9)
 Q:$G(SDCAN)="C"
 ;initialize patient appointment data to null and get patient DFN
 S (SDARRAY("DPT0"),SDARRAY("DPT1"))=""
 S (SDPATIEN,SDARRAY("PAT"))=+SDARRAY("SC0")
 ;quit if patient is null on ^SC
 Q:SDPATIEN=0
 ;since "by clinic", 2nd sort is patient
 S SDARRAY("SORT2")=SDPATIEN
 ;get corresponding appt zero node on ^DPT
 S SDARRAY("DPT0")=$G(^DPT(SDPATIEN,"S",SDAPPTDT,0))
 ;skip if appointment is cancelled on DPT
 Q:($P($G(SDARRAY("DPT0")),"^",2)["C")
 ;skip if appointment on DPT is for different clinic
 Q:(+$G(SDARRAY("DPT0"))'=SDCLIEN)
 ;get appointment 1 node on ^DPT
 S SDARRAY("DPT1")=$G(^DPT(SDPATIEN,"S",SDAPPTDT,1))
 ;appointment must match the "clinic" filter values
 I $$MATCH^SDAMA304("C",.SDARRAY,.SDFLTR,.SDDV) D
 . ;if appointment matches the "patient" filter values, put appointment data into output array
 . I $$MATCH^SDAMA304("P",.SDARRAY,.SDFLTR,.SDDV) D SETARRAY^SDAMA305(.SDARRAY)
 Q
