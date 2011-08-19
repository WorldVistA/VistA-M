PXRRWLSE ;ISL/PKR,ISA/Zoltan - Sort encounters for encounter summary report. ;12/1/1998
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**20,58,61**;Aug 12, 1996
 ;
 ;Sort the encounters according to the selection criteria.
SORT ;
 N BYCLOC,BD,BUSY,CLINIC,CLINIEN,CPT,CSSCR
 N DATE,DAY,DFN,ED,EM,EMLIST,FAC,FACILITY,FOUND
 N HLOCIEN,HLOCNAM,HSSCR,IC,INOUT,LOCATION,NEWPIEN
 N PCLASS,PPNAME
 N PROVIDER,PRVCNT,PRVIEN,PRVSCR
 N STOIND,TEMP,TOTUNIQ,TOTVIS,UPAT,VIEN,VISIT,VISIT150,VISITS
 N MULTPR
 ;
 D SORT2^PXRRWLS2
 ;
 S BD=PXRRBDT-.0001
 S ED=PXRREDT+.2359
NDATE S BD=$O(^AUPNVSIT("B",BD))
 ;If we have passed the ending date we are done.
 I (BD>ED)!(BD="") G DONE
 ;
 ;If this is an interactive session let the user know that something
 ;is happening.
 I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting encounters",.BUSY)
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 D EXIT^PXRRGUT
 ;
 ;Get the VISIT IEN
 S VIEN=0
VISIT S VIEN=$O(^AUPNVSIT("B",BD,VIEN))
 I VIEN="" G NDATE
 S VISIT=^AUPNVSIT(VIEN,0)
 ;
 ;Screen out inappropriate vists.
 ;Service categories.
 I PXRRSCAT'[$P(VISIT,U,7) G VISIT
 ;Encounter types.
 S VISIT150=$G(^AUPNVSIT(VIEN,150))
 I PXRRENTY'[$P(VISIT150,U,3) G VISIT
 ;
 ;Make sure that the facility is on the list.
 S FOUND=0
 S FAC=$P(VISIT,U,6)
 F IC=1:1:NFAC I $P(PXRRFAC(IC),U,1)=FAC D  Q
 . S FACILITY=FAC
 . S FOUND=1
 I 'FOUND G VISIT
 ;
 S HLOCNAM=""
 ;
 D VISIT2^PXRRWLS2
 ;
 I 'FOUND G VISIT
 ;
 ;Get the Provider
 S PRVCNT=0
 S PRVIEN=0
 S MULTPR=""
PRV ;
 S PRVIEN=$O(^AUPNVPRV("AD",VIEN,PRVIEN))
 I (PRVIEN="")&(PRVCNT>0) G VISIT
 I (PRVIEN="") S NEWPIEN=0
 E  S NEWPIEN=+$P(^AUPNVPRV(PRVIEN,0),U,1)
 S PRVCNT=PRVCNT+1
 I NEWPIEN>0 S PPNAME=$P(^VA(200,NEWPIEN,0),U,1)_U_NEWPIEN
 E  S PPNAME="Unknown"_U_NEWPIEN
 ;
 ;Apply any Provider screens.
 ;List of providers.
 I $D(PXRRPRPL) D  G:'FOUND PRV
 . S FOUND=0
 . F IC=1:1:NPL I $P(PXRRPRPL(IC),U,2)=NEWPIEN D  Q
 ..;Mark this provider as being matched.
 .. S $P(PXRRPRPL(IC),U,4)="M"
 .. S FOUND=1
 ;
 ;Person class screen.
 I $D(PXRRPECL) D  G:'FOUND PRV
 . S PCLASS=$$OCCUP^PXBGPRV(NEWPIEN,BD,"",1,"")
 . S FOUND=$$MATCH^PXRRPECU(PCLASS)
 . S PPNAME=PPNAME_U_$P(PCLASS,U,7)
 ;
 D PRV2^PXRRWLS2
 ;
CLOC ;
 D CLOC2^PXRRWLS2
 ;
 ;Find the CPT code(s) and associated E&M codes for this encounter.
 S IC=$O(^AUPNVCPT("AD",VIEN,""))
 I +IC=0 D  G BYCLOC
 . S ^XTMP(PXRRXTMP,FACILITY,STOIND,"NOCPT")=$G(^XTMP(PXRRXTMP,FACILITY,STOIND,"NOCPT"))+1
 .;Total for multiple provider encounters.
 . I MULTPR S ^XTMP(PXRRXTMP,FACILITY,"&&","NOCPT")=$G(^XTMP(PXRRXTMP,FACILITY,"&&","NOCPT"))+1
 ;
 S IC=""
GETCPT S IC=$O(^AUPNVCPT("AD",VIEN,IC))
 I +IC>0 D GC2^PXRRWLS2 G GETCPT
 ;
BYCLOC ;If necessary accumulate the information about each clinic stop
 ;location.
 I BYCLOC,$L(STOIND,U)=3 D  G CLOC
 . S HLOCIEN=$P(VISIT,U,22)
 . ;Null Subscript: Visit is missing hospital location.
 . ;Undefined: Hospital Location may have been deleted.
 . S STOIND=STOIND_U_$P(^SC(HLOCIEN,0),U,1)
 ;Pass flag to report for header message.
 I MULTPR=1 S ^XTMP(PXRRXTMP,"PXRRMPR")=1
 ; Get the next provider for the encounter...
 S PXRRPRSC=$G(PXRRPRSC) ; Ensure it exists.
 I $E(PXRRPRSC)="S",$G(NPL)>1 S MULTPR=1 G PRV
 I $E(PXRRPRSC)="C"!($E(PXRRPRSC)="A") S MULTPR=1 G PRV
 ; ...or get the next encounter.
 G VISIT
 ;
DONE ;
 ;Process the patient list, get the number of unique patients, and the
 ;number of visits.  A visit is defined to be any activity for a patient
 ;within a 24 hour period.
 ;
 S FACILITY=0
NFAC S FACILITY=$O(^TMP(PXRRXTMP,$J,FACILITY))
 I +FACILITY=0 G SDONE
 ;
 D NF2^PXRRWLS2
 ;
 S STOIND="&"
NSTO S STOIND=$O(^TMP(PXRRXTMP,$J,FACILITY,STOIND))
 I STOIND="" G NFAC
 ;
 S TOTVIS=0
 S UPAT=0
 S VISITS(0)=0
 S VISITS(1)=0
 ;
 ;If this is an interactive session let the user know that something
 ;is happening.
 I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting encounters",.BUSY)
 ;
 S DFN=0
NDFN S DFN=$O(^TMP(PXRRXTMP,$J,FACILITY,STOIND,"PATIENT",DFN))
 I +DFN=0 D  G NSTO
 . S ^XTMP(PXRRXTMP,FACILITY,STOIND,"TOTVIS")=TOTVIS
 . S ^XTMP(PXRRXTMP,FACILITY,STOIND,"UPAT")=UPAT
 . S ^XTMP(PXRRXTMP,FACILITY,STOIND,"VISITS",0)=VISITS(0)
 . S ^XTMP(PXRRXTMP,FACILITY,STOIND,"VISITS",1)=VISITS(1)
 S UPAT=UPAT+1
 ;
 S DAY=""
NDAY S DAY=$O(^TMP(PXRRXTMP,$J,FACILITY,STOIND,"PATIENT",DFN,DAY))
 I DAY="" G NDFN
 S TOTVIS=TOTVIS+1
 ;
 S INOUT=-1
NINOUT S INOUT=$O(^TMP(PXRRXTMP,$J,FACILITY,STOIND,"PATIENT",DFN,DAY,INOUT))
 I INOUT="" G NDAY
 S VISITS(INOUT)=VISITS(INOUT)+1
 G NINOUT
 ;
SDONE ;Sorting is done.
 I '(PXRRQUE!$D(IO("S"))) D DONE^PXRRBUSY("done")
 K ^TMP(PXRRXTMP)
 ;
 ;If there were selected clinic stops build dummy entries for all
 ;those without entries.
 I $D(PXRRCS) D
 . F FAC=1:1:NFAC D
 .. S FACILITY=$P(PXRRFAC(FAC),U,1)
 .. F IC=1:1:NCS  D
 ... I $P(PXRRCS(IC),U,4)'="M" D
 .... S HLOCNAM=PXRRCS(IC)
 .... S ^XTMP(PXRRXTMP,FACILITY,HLOCNAM,0,0)=""
 ;
 ;If there were selected hospital locations build dummy entries for all
 ;those without entries.
 I $D(PXRRLCHL) D
 . F FAC=1:1:NFAC D
 .. S FACILITY=$P(PXRRFAC(FAC),U,1)
 .. F IC=1:1:NHL  D
 ... I $P(PXRRLCHL(IC),U,4)'="M" D
 .... S HLOCNAM=PXRRLCHL(IC)
 .... S ^XTMP(PXRRXTMP,FACILITY,HLOCNAM,0,0)=""
 ;
EXIT ;
 ;Sort the appointment information.
 I PXRRQUE D 
 .;Start the appointment sorting that was queued but not scheduled.
 . N DESC,ROUTINE,TASK
 . S ROUTINE="PXRRWLSA"
 . S DESC="Encounter Summary Report - sort appointments"
 . S ZTDTH=$$NOW^XLFDT
 . S TASK=^XTMP(PXRRXTMP,"SAZTSK")
 . D REQUE^PXRRQUE(DESC,ROUTINE,TASK)
 E  D SORT^PXRRWLSA
 Q
