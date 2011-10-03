VSITSTAT ;ISL/PKR - Visit Tracking in/out patient Update Protocol for ADT ;4/23/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;**2**;Aug 12, 1996
 ;
EN ;Main entry point called by ADT event driver, process adm and d/c only.
 I '$D(^UTILITY("DGPM",$J,1))&'$D(^UTILITY("DGPM",$J,3)) G ENQ
 W:'$G(DGQUIET) !!,"Updating visit status..."
 ;
 N MAXDATE,TOFFSET
 S MAXDATE=9999999
 S TOFFSET=.0000001
 ;
 ;Build a time ordered list of visits for this patient.
 N DATE,TIME,VDT,VIEN
 S VDT=""
 F  S VDT=$O(^AUPNVSIT("AA",DFN,VDT)) Q:'VDT  D
 . S VIEN="",VIEN=$O(^AUPNVSIT("AA",DFN,VDT,VIEN))
 . S DATE=$P(VDT,".",1)
 . S TIME=VDT-DATE
 . S DATE=MAXDATE-DATE+TIME
 . S ^TMP("VSITSTAT",$J,DFN,DATE,VIEN)=""
 ;
 ;Try to get information for the complete movement.
 S VAIP("E")=DGPMDA
 D IN5^VADPT
 ;
 ;Setup the admission information.
 N ADMA,ADMIT
 S ADMIT=$$ADMISSIO(.ADMA)
 ;
 ;Setup the discharge information.
 N DISA,DISCHG
 S DISCHG=$$DISCHARG(.DISA)
 ;
 ;We must have a value either for the admission after or previous.
 I (ADMA("A")="")&(ADMA("P")="") D  Q
 . W !,"VSITSTAT FATAL ERROR -- NO ADMISSION TIME"
 ;
 N IN,INOUT,OUT,SDBEG,SDEND
 S IN=1,OUT=0
 ;
 ;General, this handles admission add and parts of admission change
 ;delete change.
 I (+ADMA("A")>0)&(ADMA("A")'=ADMA("P")) D
 . S SDBEG=ADMA("A")-TOFFSET
 . I DISCHG S SDEND=DISA("A")
 . E  S SDEND=MAXDATE
 . S INOUT=IN
 . D SCANUPD(SDBEG,SDEND,INOUT)
 ;
 ;Admission change.  We only need to worry about a latter time.  The
 ;earlier case is entirely handled above.
 I (+ADMA("P")>0)&(+ADMA("P")<+ADMA("A")) D
 . S SDBEG=ADMA("P")
 . S SDEND=ADMA("A")-TOFFSET
 . S INOUT=OUT
 . D SCANUPD(SDBEG,SDEND,INOUT)
 ;
 ;Admission delete.
 I (+ADMA("P")>0)&(ADMA("A")="") D
 . S SDBEG=ADMA("P")-TOFFSET
 . I +DISA("P")>0 S SDEND=DISA("P")
 . E  S SDEND=MAXDATE
 . S INOUT=OUT
 . D SCANUPD(SDBEG,SDEND,INOUT)
 ;
 ;Discharge add.
 I (ADMA("A")=ADMA("P"))&(+DISA("A")>0) D
 . S SDBEG=DISA("A")+TOFFSET
 . S SDEND=MAXDATE
 . S INOUT=OUT
 . D SCANUPD(SDBEG,SDEND,INOUT)
 ;
 ;Discharge change.  We only need to worry about an earlier discharge
 ;time.
 I (+DISA("A")>0)&(+DISA("A")<+DISA("P")) D
 . S SDBEG=DISA("A")+TOFFSET
 . S SDEND=DISA("P")
 . S INOUT=OUT
 . D SCANUPD(SDBEG,SDEND,INOUT)
 ;
 ;Discharge delete.
 I (ADMA("A")=ADMA("P"))&(+DISA("P")>0)&(DISA("A")="") D
 . S SDBEG=ADMA("A")-TOFFSET
 . S SDEND=DISA("P")
 . S INOUT=IN
 . D SCANUPD(SDBEG,SDEND,INOUT)
 ;
 W:'$G(DGQUIET) "completed."
 ;
ENQ ;
 K ^TMP("VSITSTAT",$J,DFN)
 D KVA^VADPT
 Q
 ;
 ;=======================================================================
ADMISSIO(ADMA) ;Return true if there is an admission.
 ;
 ;If the movement is just a change in discharge time UTILITY(...1,...)
 ;will not exist.
 N MVMNT
 S MVMNT="",MVMNT=$O(^UTILITY("DGPM",$J,1,MVMNT))
 I MVMNT D
 . S ADMA("A")=$P($G(^UTILITY("DGPM",$J,1,MVMNT,"A")),U,1)
 . S ADMA("P")=$P($G(^UTILITY("DGPM",$J,1,MVMNT,"P")),U,1)
 E  D
 . S ADMA("A")=$P(VAIP(13,1),U,1)
 . I VAIP(13)=DGPMDA S ADMA("P")=$P(DGPMP,U,1)
 . E  S ADMA("P")=""
 Q 1
 ;
 ;=======================================================================
DISCHARG(DISA) ;Return true if there is a discharge.
 N MVMNT,RETVAL
 S MVMNT="",MVMNT=$O(^UTILITY("DGPM",$J,3,MVMNT))
 I MVMNT D
 . S DISA("A")=$P($G(^UTILITY("DGPM",$J,3,MVMNT,"A")),U,1)
 . S DISA("P")=$P($G(^UTILITY("DGPM",$J,3,MVMNT,"P")),U,1)
 E  D
 . S DISA("A")=$P(VAIP(17,1),U,1)
 . I VAIP(17)=DGPMDA S DISA("P")=$P(DGPMP,U,1)
 . E  S DISA("P")=""
 I DISA("A")>0 S RETVAL=1
 E  S RETVAL=0
 Q RETVAL
 ;
 ;=======================================================================
SCANUPD(VSITBEG,VSITEND,INOUT) ;Scan range of visits and update
 ;  input:
 ;         VSITBEG := begin date
 ;         VSITEND := end date
 ;         INOUT   := visit status
 ;
 N VSIT,VSITDT,VSITIEN
 S VSITDT=VSITBEG
 F  S VSITDT=$O(^TMP("VSITSTAT",$J,DFN,VSITDT)) Q:('VSITDT)!(VSITDT>VSITEND)  D
 . S VSITIEN="",VSITIEN=$O(^TMP("VSITSTAT",$J,DFN,VSITDT,VSITIEN))
 . S VSIT("IEN")=VSITIEN
 . S VSIT("IO")=INOUT
 . S VSIT("SVC")=$$UPDSCAT(VSITIEN,INOUT)
 . D UPD^VSIT
 ;
 Q
 ;=======================================================================
UPDSCAT(VSITIEN,INOUT) ;Set the Service Category for in or outpatient.
 N CSC,NSC
 S (CSC,NSC)=$P($G(^AUPNVSIT(VSITIEN,0)),U,7)
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
