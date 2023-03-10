VSITSTAT ;ISL/PKR - Visit Tracking in/out patient Update Protocol for ADT ;04/14/2022
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76,231**;Aug 12, 1996;Build 1
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;**2**;Aug 12, 1996
 ;
 ;==========
ADMISSION(ADMDATA,VAIP) ;If there is an admission save the data.
 ;If the movement is just a change in discharge time UTILITY(...1,...)
 ;will not exist.
 N MVMNT,WARD
 S MVMNT=$O(^UTILITY("DGPM",$J,1,""))
 I MVMNT D
 . S ADMDATA("A","DT")=$P($G(^UTILITY("DGPM",$J,1,MVMNT,"A")),U,1)
 . S ADMDATA("P","DT")=$P($G(^UTILITY("DGPM",$J,1,MVMNT,"P")),U,1)
 E  D
 . S ADMDATA("A","DT")=$P(VAIP(13,1),U,1)
 . S ADMDATA("P","DT")=ADMDATA("A","DT") ;no ^UTILITY = no change
 Q
 ;
 ;==========
DISCHARGE(DISDATA,VAIP) ;If there is a discharge save the data.
 N MVMNT,WARD
 S MVMNT=$O(^UTILITY("DGPM",$J,3,""))
 I MVMNT D
 . S DISDATA("A","DT")=$P($G(^UTILITY("DGPM",$J,3,MVMNT,"A")),U,1)
 . S DISDATA("P","DT")=$P($G(^UTILITY("DGPM",$J,3,MVMNT,"P")),U,1)
 E  D
 . S DISDATA("A","DT")=$P(VAIP(17,1),U,1)
 . S DISDATA("P","DT")=DISDATA("A","DT") ;no ^UTILITY = no change
 Q
 ;
 ;==========
EN ;Main entry point, invoked by the DGPM MOVEMENT EVENTS protocol.
 ;If admission or discharge dates change, a scan for visits in the affected
 ;date range is made to update the SERVICE CATEGORY and PATIENT STATUS IN/OUT
 ;fields accordingly. 
 ;
 ;If the admission date/time changes, a search is made for the admission visit and
 ;VISIT/ADMIT DATE&TIME is updated to the new admission DATE/TIME. If there is no
 ;admission visit, then one is created.
 ;
 I '$D(^UTILITY("DGPM",$J,1))&'$D(^UTILITY("DGPM",$J,3)) Q
 W:'$G(DGQUIET) !!,"Updating visit status..."
 ;
 N ADMDATA,DISDATA,VAIP
 ;
 ;Try to get complete information for the movement.
 S VAIP("E")=DGPMDA
 D IN5^VADPT
 ;
 ;Setup the admission information.
 D ADMISSION(.ADMDATA,.VAIP)
 ;
 ;Setup the discharge information.
 D DISCHARGE(.DISDATA,.VAIP)
 ;
 ;We must have a value either for the admission after or previous.
 I (ADMDATA("A","DT")="")&(ADMDATA("P","DT")="") D  Q
 . W:'$G(DGQUIET) !,"VSITSTAT FATAL ERROR -- NO ADMISSION TIME"
 ;
 N HLOC,IN,INOUT,OUT,SDBEG,SDEND
 S IN=1,OUT=0
 ;
 ;New Admission.
 I (ADMDATA("A","DT")>0),(ADMDATA("P","DT")="") D
 . S SDBEG=ADMDATA("A","DT")
 . I +DISDATA("A","DT")>0 S SDEND=DISDATA("A","DT")
 . E  S SDEND=9999999
 . S INOUT=IN
 . D SCANUPD(DFN,SDBEG,SDEND,INOUT)
 ;
 ;Admission edited, date earlier than previous admission date.
 I (ADMDATA("A","DT")>0),(ADMDATA("A","DT")<ADMDATA("P","DT")) D
 . S SDBEG=ADMDATA("A","DT")
 . S SDEND=ADMDATA("P","DT")
 . S INOUT=IN
 . D SCANUPD(DFN,SDBEG,SDEND,INOUT)
 ;
 ;Admission edited, date later than previous admission date.
 I (ADMDATA("P","DT")>0),(ADMDATA("A","DT")>ADMDATA("P","DT")) D
 . S SDBEG=ADMDATA("P","DT")
 . S SDEND=ADMDATA("A","DT")
 . S INOUT=OUT
 . D SCANUPD(DFN,SDBEG,SDEND,INOUT)
 ;
 ;Admission deleted.
 I (ADMDATA("P","DT")>0),(ADMDATA("A","DT")="") D
 . S SDBEG=ADMDATA("P","DT")
 . I +DISDATA("P","DT")>0 S SDEND=DISDATA("P","DT")
 . E  S SDEND=9999999
 . S INOUT=OUT
 . D SCANUPD(DFN,SDBEG,SDEND,INOUT)
 ;
 ;Discharge added.
 I (ADMDATA("A","DT")=ADMDATA("P","DT")),(DISDATA("P","DT")="")&(DISDATA("A","DT")>0) D
 . S SDBEG=DISDATA("A","DT")
 . S SDEND=9999999
 . S INOUT=OUT
 . D SCANUPD(DFN,SDBEG,SDEND,INOUT)
 ;
 ;New discharge date earlier than previous discharge date.
 I (DISDATA("A","DT")>0),(DISDATA("A","DT")<DISDATA("P","DT")) D
 . S SDBEG=DISDATA("A","DT")
 . S SDEND=DISDATA("P","DT")
 . S INOUT=OUT
 . D SCANUPD(DFN,SDBEG,SDEND,INOUT)
 ;
 ;New discharge date later than previous discharge date.
 I (DISDATA("P","DT")>0),(DISDATA("A","DT")>DISDATA("P","DT")) D
 . S SDBEG=DISDATA("P","DT")
 . S SDEND=DISDATA("A","DT")
 . S INOUT=IN
 . D SCANUPD(DFN,SDBEG,SDEND,INOUT)
 ;
 ;Discharge deleted.
 I (ADMDATA("A","DT")=ADMDATA("P","DT")),(DISDATA("A","DT")="")&(DISDATA("P","DT")>0) D
 . S SDBEG=ADMDATA("P","DT")
 . S SDEND=DISDATA("P","DT")
 . S INOUT=IN
 . D SCANUPD(DFN,SDBEG,SDEND,INOUT)
 ;
 ;Any admission created or edited
 N VSITMVT,AFTER,PRIOR
 S VSITMVT=0 F  S VSITMVT=$O(^UTILITY("DGPM",$J,1,VSITMVT)) Q:VSITMVT<1  D
 . S AFTER=$G(^UTILITY("DGPM",$J,1,VSITMVT,"A")),PRIOR=$G(^("P"))
 . ;no addl visit updates if deleted, or date & location unchanged
 . Q:PRIOR&(AFTER="")  I +AFTER=+PRIOR,$P(AFTER,U,6)=$P(PRIOR,U,6) Q
 . D UPDADMVISIT(DFN,PRIOR,AFTER)
 ;
 W:'$G(DGQUIET) "completed."
 ;
ENQ ;
 D KVA^VADPT
 Q
 ;
 ;===========
FINDADMVISIT(DFN,HLOC,ADMDT) ;Given the DFN, hospital location, and 
 ;admission date and time try to find the corresponding Visit file entry.
 N ADMVISIT,VISITIEN
 I '$D(^AUPNVSIT("AET",DFN,ADMDT,HLOC,"P")) Q 0
 S ADMVISIT=0,VISITIEN=""
 F  S VISITIEN=$O(^AUPNVSIT("AET",DFN,ADMDT,HLOC,"P",VISITIEN)) Q:VISITIEN=""  D  Q:ADMVISIT>0
 . I $P(^AUPNVSIT(VISITIEN,0),U,7)'="H" Q
 . S ADMVISIT=VISITIEN
 Q ADMVISIT
 ;
 ;==========
SCANUPD(DFN,BEGDT,ENDDT,INOUT) ;Scan a date range of visits and update
 ;SERVICE CATEGORY and PATIENT STATUS IN/OUT.
 ;  input:
 ;         DFN = patient
 ;         BEGDT = beginning date
 ;         ENDDT = end date
 ;         INOUT = PATIENT STATUS IN/OUT
 ;
 N INVDT,INVEND,VISITIEN,VSIT
 S INVDT=(9999999-$E(ENDDT,1,7))_$E(ENDDT,8,14)-.0000001
 S INVEND=(9999999-$E(BEGDT,1,7))_$E(BEGDT,8,14)
 F  S INVDT=+$O(^AUPNVSIT("AA",DFN,INVDT)) Q:(INVDT>INVEND)!(INVDT=0)  D
 . S VISITIEN=""
 . F  S VISITIEN=$O(^AUPNVSIT("AA",DFN,INVDT,VISITIEN)) Q:VISITIEN=""  D
 .. S VSIT("IEN")=VISITIEN
 .. S VSIT("IO")=INOUT
 .. S VSIT("MDT")=$$NOW^XLFDT
 .. S VSIT("SVC")=$$UPDSCAT(VISITIEN,INOUT)
 .. D UPD^VSIT
 Q
 ;
 ;==========
UPDADMVISIT(DFN,PRIOR,AFTER) ;Update the VISIT/ADMIT DATE&TIME to the new 
 ;admission date and time. If an admission visit does not exist, create one.
 N ADMVISIT,VDT,HLOC,VSIT,Y
 S VDT=+$P(PRIOR,U,1),HLOC=+$G(^DIC(42,+$P(PRIOR,U,6),44))
 S ADMVISIT=$$FINDADMVISIT(DFN,HLOC,VDT)
 I ADMVISIT>0 D  Q
 . S VSIT("IEN")=ADMVISIT
 . S VSIT("MDT")=$$NOW^XLFDT
 . S VSIT("VDT")=$P(AFTER,U,1)
 . S VSIT("LOC")=$G(^DIC(42,+$P(AFTER,U,6),44))
 . D UPD^VSIT
 I ADMVISIT=0 D
 . S VDT=+$P(AFTER,U,1)
 . S VSIT("PRI")="P",VSIT("SVC")="H"
 . S VSIT("LOC")=$G(^DIC(42,+$P(AFTER,U,6),44))
 . S (VSIT("CDT"),VSIT("MDT"))=$$NOW^XLFDT
 . S VSIT("PKG")="PX"
 . S VSIT("SOR")=$$SOURCE^PXAPIUTL("DGPM MOVEMENT EVENT - VSITSTATUS")
 . S Y=$$GET^VSIT(VDT,DFN,"EF",.VSIT)
 Q
 ;
 ;==========
UPDSCAT(VISITIEN,INOUT) ;Set the Service Category for in or outpatient.
 N CSC,NSC
 S (CSC,NSC)=$P($G(^AUPNVSIT(VISITIEN,0)),U,7)
 I (CSC="A")!(CSC="I") D
 . I INOUT S NSC="I"
 . E  S NSC="A"
 ;
 I (CSC="D")!(CSC="X") D
 . I INOUT S NSC="D"
 . E  S NSC="X"
 ;
 ;If the current Service Category was not A, I, D, or X return the original.
 Q NSC
 ;
