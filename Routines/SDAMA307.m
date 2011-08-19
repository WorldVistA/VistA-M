SDAMA307 ;BPOIFO/ACS-Filter API Call RSA ; 9/14/05 12:45pm
 ;;5.3;Scheduling;**301,508**;13 Aug 1993
 ;PER VHA DIRECTIVE 2004-038, DO NOT MODIFY THIS ROUTINE
 ;
 ;**              GET APPOINTMENT DATA FROM RSA                **
 ;
 ;***************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    ---------------------------------------
 ;12/04/03  SD*5.3*301    ROUTINE COMPLETED
 ;09/14/05  SD*5.3*372    Phase II Apptmts on Multiple Databases
 ;02/22/07  SD*5.3*508    SEE SDAMA301 FOR CHANGE LIST
 ;***************************************************************
 ;  
 ;***************************************************************
 ;INPUT
 ;       SDARRAY  APPOINTMENT FILTER ARRAY (by reference)
 ;       SDVRFR   OVERLOAD PARAMETER FOR VERIFIER [optional]
 ;                (Returns Screened RSA Appts (Migrating))
 ;***************************************************************
DATA(SDARRAY,SDVRFR) ;Get RSA appointment data (Phase II)
 ;Initialize variables
 N SDRESP,SDCOUNT,SDDFN,SDX,SDGBL
 S SDX=0
 ;if patient filter defined ensure that at least 1 patient has 
 ;an ICN. if no patient in the list or global has an icn then RSA 
 ;does not need to be called (No Appointments will exist.)
 I (($G(SDARRAY(4))]"")&($G(SDARRAY(4))'="^DPT(")) D  Q:'SDX
 .;patients in global
 .I SDARRAY("PATGBL")=1 D
 ..S SDGBL=SDARRAY(4),SDDFN=0
 ..F  S SDDFN=$O(@(SDGBL_"SDDFN)")) Q:((+$G(SDDFN)=0)!SDX)  D
 ...S:(+$$GETICN^MPIF001(SDDFN)>0) SDX=1
 .;patients in list
 .I SDARRAY("PATGBL")=0 D
 ..S SDCOUNT=$L(SDARRAY(4),";")
 ..F SDDFN=1:1:SDCOUNT Q:SDX  D
 ...S:(+$$GETICN^MPIF001($P(SDARRAY(4),";",SDDFN))>0) SDX=1
 ;if patient filter is not defined ensure that if the status
 ;filter is defined that it has more than cancelled appt statuses
 ;(Cancelled Appts not returned if Patient filter not defined)
 I (($G(SDARRAY(4))']"")&($G(SDARRAY(3))]"")) D  Q:'SDX
 .N SDSTAT,SDI S SDSTAT="",SDX=0
 .F SDI=1:1:$L(SDARRAY(3),";") Q:SDX  D
 ..S:($P(SDARRAY(3),";",SDI)'["C") SDX=1
 ;Call RSA Business Delegate
 ;S SDRESP=$$XMLDLGT^SDAMA309(.SDARRAY,$G(SDVRFR))
 ;error occurred creating appt records
 I SDRESP<0 S SDARRAY("CNT")=-1
 ;no errors/update total appt counter/adjust appts to max filter
 ;as RSA appts were appended to output and may exceed the MAX
 I '(SDRESP<0) D
 .S SDARRAY("CNT")=SDARRAY("CNT")+SDRESP
 .;adjust total number of appointments
 .D MAXAPPTS(.SDARRAY)
 Q
 ;
 ;***************************************************************
 ;OUTPUT
 ;    If RSA Implemented, return 1,10 or 11 if Appt Entry Exists
 ;    If RSA NOT Implemented, return 0
 ;***************************************************************
IMP() ;RSA Implemented
 Q $D(^XOB(18.08,"B",$$GETSRVNM))
 ;
 ;***************************************************************
 ;OUTPUT
 ;       Returns RSA Application Server Name
 ;***************************************************************
GETSRVNM() ;return the VL 2.0 application server name
 Q "SDAM-RSA"
 ;
 ;***************************************************************
 ;INPUT
 ;       SDCLIEN      Clinic's Internal Entry Number (Required)
 ;       SDARRAY      APPOINTMENT FILTER ARRAY (by reference)
 ;OUTPUT
 ;       1 Return a Patients or Clinics VistA Appointments
 ;       0 Exclude a Patients or Clinics VistA Appointments 
 ;       
 ;       SDARRAY("RSA")=1 will exist if RSA has to be Called
 ;       SDARRAY("MIG") will exist for VistA Clinics that have an 
 ;                      earliest migrated date/time and has
 ;                      completed migration.
 ; ***************************************************************
CLMIG(SDCLIEN,SDARRAY) ;clinic status switch       
 ;initialize variables 
 N SDRSA
 S SDARRAY("CLIN")=SDCLIEN,SDARRAY("MIG")=""
 ;quit if clinic is not of type "C" (Clinic)
 Q:($P($G(^SC(SDCLIEN,0)),"^",3)'="C") 0
 ;determine if RSA Clinic,
 ;if RSA Clinic Quit VistA doesnt need to be called
 S SDRSA=$$RSACLNC(SDCLIEN)
 ;
 ;RSA CLINIC (Check-In Point) Logic
 ;Call RSA for Future Migrated/New appointments  
 I SDRSA S SDARRAY("RSA")=1 Q 0
 ;
 ;VISTA CLINIC Logic
 ;return all VistA appointments (Migration not completed)
 Q:($P($G(^SC(SDCLIEN,"RSA")),"^",6)']"") 1
 ;retrieve earliest migrated date/time
 S SDARRAY("MIG")=+$P($G(^SC(SDCLIEN,"RSA")),"^",3)
 ;return non-migrated VistA appointments
 Q:(SDARRAY("MIG")>+$G(SDARRAY("DATE"))) 1
 ;migrated VistA appointments not returned
 Q 0
 ;
 ;***************************************************************
 ;INPUT
 ;   SDCLNC  -  Clinic IEN
 ;OUTPUT
 ;   1 - Is an RSA Clinic
 ;   0 - Is not an RSA Clinic
 ;***************************************************************
RSACLNC(SDCLNC) ;determine if Clinic is an RSA Clinic
 ;RSA Clinic if Resource Id (#44.203) and 
 ;              Appt Purpose ID (#44.204) exist
 ;initialize variables  
 N SDRID,SDLAPID
 ;get resource id
 S SDRID=$P($G(^SC(SDCLNC,"RSA")),"^",4)
 ;get local appt purpose id
 S SDLAPID=$P($G(^SC(SDCLNC,"RSA")),"^",5)
 Q $S(((SDRID'="")&(SDLAPID'="")):1,1:0)
 ;
 ;***************************************************************
 ;OUTPUT
 ;   Returns the Sites VistA Instance Number
 ;*************************************************************** 
VI() ;Get VistA Instance    
 N SDVI
 S SDVI=$$SITE^VASITE
 Q +$P(SDVI,"^",3)
 ;
 ;******************************************************************
 ;INPUT
 ;   SDARRAY         APPOINTMENT FILTER ARRAY (by reference)
 ;****************************************************************** 
MAXAPPTS(SDARRAY) ;Adjust combined appointments (VistA/RSA) to MAX            
 N SDDIFF,SDDIR,SDREF,SDMAX,SDI,SDDTM,SDSORT1,SDSORT2
 S SDMAX=$S(SDARRAY("MAX")<0:SDARRAY("MAX")*-1,1:SDARRAY("MAX"))
 S SDDIR=1,SDREF="^TMP($J,""SDRSRT"")"
 ;quit if max filter not defined / max equals appt count / or
 ;appt count is less than max
 Q:($S(SDARRAY("MAX")="":1,SDMAX=SDARRAY("CNT"):1,SDARRAY("CNT")<SDMAX:1,1:0))
 ;determine how many appts to kill and QUERY direction
 I SDARRAY("MAX")>0 D
 .S SDDIFF=SDARRAY("CNT")-SDARRAY("MAX"),SDDIR=-1
 .I $G(SDARRAY("SORT"))="P" S SDREF="^TMP($J,""SDRSRT"",""A"",""A"")"
 .E  S SDREF="^TMP($J,""SDRSRT"",""A"",""A"",""A"")"
 S:SDARRAY("MAX")<0 SDDIFF=SDARRAY("CNT")+SDARRAY("MAX")
 ;create temporary resorted output global by Date/Time
 ;D MAXRESRT^SDAMA309(.SDARRAY)
 ;
 ;loop through appt set and kill the excess appts
 F  Q:'SDDIFF  D
 .S SDREF=$Q(@SDREF,SDDIR)
 .;retrieve subscribpt to delete from output global
 .S SDDTM=$P(SDREF,",",3),SDSORT1=+$P(SDREF,",",4),SDSORT2=+$P(SDREF,",",5)
 .K:($G(SDARRAY("SORT"))="P") ^TMP($J,"SDAMA301",SDSORT1,SDDTM)
 .K:($G(SDARRAY("SORT"))'="P") ^TMP($J,"SDAMA301",SDSORT1,SDSORT2,SDDTM)
 .K @SDREF  ;delete resorted temp output copy
 .S SDDIFF=SDDIFF-1
 ;reset total appt count to max
 S SDARRAY("CNT")=$S(SDARRAY("MAX")>0:SDARRAY("MAX"),1:(SDARRAY("MAX")*(-1)))
 K ^TMP($J,"SDRSRT")
 Q
 ;
 ;Both Patient and Clinic Filter Defined, Determine if RSA should be
 ;called, by evaluating the Clinic Filter List. Patient may have no
 ;appointments in VistA, so Clinic Filter has to be evaluated.
 ;******************************************************************
 ;INPUT
 ;   SDARRAY         APPOINTMENT FILTER ARRAY (by reference)
 ;******************************************************************
CALLRSA(SDARRAY) ;
 ;initialize variables
 N SDCOUNT,SDX,SDCLIEN,SDQUIT,SDGBL,SDRSLT
 S (SDCOUNT,SDQUIT)=0
 ;if clinic is in a list:
 I SDARRAY("CLNGBL")=0 D
 . S SDCOUNT=$L(SDARRAY(2),";")
 . ;For each clinic in the filter (LIST):
 . F SDX=1:1:SDCOUNT Q:SDQUIT  D
 .. S SDCLIEN=$P(SDARRAY(2),";",SDX)
 .. ;determine if clinic has migrated (Call RSA)
 .. S SDRSLT='$$CLMIG(SDCLIEN,.SDARRAY)
 .. S SDQUIT=+$G(SDARRAY("RSA"))
 ;if clinic is in array, get IENs
 I SDARRAY("CLNGBL")=1 D
 . S SDGBL=SDARRAY(2),SDCLIEN=0
 . ;for each clinic in the filter (GLOBAL):
 . F  S SDCLIEN=$O(@(SDGBL_"SDCLIEN)")) Q:(($G(SDCLIEN)="")!(SDQUIT))  D
 .. ;determine if clinic has migrated (Call RSA)
 .. S SDRSLT='$$CLMIG(SDCLIEN,.SDARRAY)
 .. S SDQUIT=+$G(SDARRAY("RSA"))
 Q
 ;
 ;**************************************************************** 
 ;INPUT
 ;   SDERRNUM  Appropriate error diagnosing problem (REQUIRED)
 ;              101     Database Unavailable
 ;              115     Invalid Input Array Entry
 ;              116     Data Mismatch
 ;              117     SDAPI Error (Other Error)
 ;   SDVLRHNL  Request Handle (optional)
 ;       
 ;Output 
 ;   N/A
 ;**************************************************************** 
ERROR(SDERRNUM,SDVLRHNL) ;error handling  
 ;clean up locations
 ;D:$G(SDVLRHNL)'="" CLEAN^XOBVJLIB(SDVLRHNL)
 ;kill existing global entries
 K ^TMP($J,"SDAMA301")
 ;create error entry in global
 D ERROR^SDAMA300(SDERRNUM)
 Q
 ;
 ;**************************************************************** 
 ;INPUT
 ;   SDVLRHNL  VistALink Request Handle (REQUIRED) 
 ;   SDVRFR    OVERLOAD PARAMETER FOR VERIFIER [optional]
 ;             (Creates Error Info in Output Global - 101 Returned)      
 ;**************************************************************** 
VLERR(SDVLRHNL,SDVRFR) ;write vistalink errors to err log
 N SDERR  ;initialize variables
 ;setup err log variables and call err log handler
 S SDERR(1)="SDAMA301"
 ;S SDERR(5)="VistALink returned ERROR Code: "_$$GETFLTCD^XOBVJRQ(SDVLRHNL)_" ERROR Message: "_$$GETFLTMS^XOBVJRQ(SDVLRHNL)
 S SDERR(6)="SDRSA101"
 ;remove special characters from VL calls
 S SDERR(5)=$E(SDERR(5),1,$L(SDERR(5))-1)
 ;D LOGERR^SDAMA314(.SDERR)
 D:($G(SDVRFR)) ERROR(101,SDVLRHNL) ;write error to output global
 Q
