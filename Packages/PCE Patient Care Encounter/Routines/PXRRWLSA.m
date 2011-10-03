PXRRWLSA ;ISL/PKR - Sort appointments for encounter summary report. ;12/1/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**20,61**;Aug 12, 1996
 ;
 ;Sort the encounters found in PXRRWLSE and attach them to appointments.
SORT ;
 N APPT,BUSY,DATE,DFN,FACILITY,IC,OUPENC,POV,STOIND,VIEN
 N MULTPR
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 I '(PXRRQUE!$D(IO("S"))) D INIT^PXRRBUSY(.BUSY)
 ;
 S FACILITY=0
NFAC S FACILITY=$O(^XTMP(PXRRXTMP,FACILITY))
 I +FACILITY=0 G DONE
 ;
 S STOIND=""
NIND S STOIND=$O(^XTMP(PXRRXTMP,FACILITY,STOIND))
 I STOIND="" G NFAC
 ;
 S DFN=0
NDFN S DFN=$O(^XTMP(PXRRXTMP,FACILITY,STOIND,"PATIENT",DFN))
 I +DFN=0 G NIND
 ;
 S DATE=0
NDATE S DATE=$O(^XTMP(PXRRXTMP,FACILITY,STOIND,"PATIENT",DFN,DATE))
 I +DATE=0 G NDFN
 ;
 ;If this is an interactive session let the user know that something
 ;is happening.
 I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting appointments",.BUSY)
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 D EXIT^PXRRGUT
 ;
 S VIEN=0
NVISIT S VIEN=$O(^XTMP(PXRRXTMP,FACILITY,STOIND,"PATIENT",DFN,DATE,VIEN))
 I +VIEN=0 G NDATE
 ;
 S MULTPR=$G(^XTMP(PXRRXTMP,FACILITY,STOIND,"PATIENT",DFN,DATE,VIEN))
 ;
 ;We have a DFN, DATE, and a VIEN look for an appointment.
 ;We will need DBIAs for reading DPT and SCE.
 S APPT=$G(^DPT(DFN,"S",DATE,0))
 S OUPENC=$P(APPT,U,20)
 I $L(OUPENC)>0 D
 .;Make sure that we point back to the same visit.
 . I $P($G(^SCE(OUPENC,0)),U,5)=VIEN D
 ..;Save the purpose of visit.
 .. S POV=$P(APPT,U,7)
 .. S ^XTMP(PXRRXTMP,FACILITY,STOIND,"POV",POV)=$G(^XTMP(PXRRXTMP,FACILITY,STOIND,"POV",POV))+1
 .. I MULTPR=1 D
 ... S ^XTMP(PXRRXTMP,FACILITY,"&&","POV",POV)=$G(^XTMP(PXRRXTMP,FACILITY,"&&","POV",POV))+1
 G NVISIT
 ;
DONE ;
 ;Sorting is done.
 I '(PXRRQUE!$D(IO("S"))) D DONE^PXRRBUSY("done")
EXIT ;
 ;
 ;Print the report information.
 I PXRRQUE D 
 .;Start the printing that was queued but not scheduled.
 . N DESC,ROUTINE,TASK
 . S ROUTINE="PXRRWLPR"
 . S DESC="Encounter Summary Report - print"
 . S ZTDTH=$$NOW^XLFDT
 . S TASK=^XTMP(PXRRXTMP,"PRZTSK")
 . D REQUE^PXRRQUE(DESC,ROUTINE,TASK)
 E  D ^PXRRWLPR
 Q
 ;
