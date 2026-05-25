PXCOMPACTBKGRND ;ALB/BPA,CMC - Background job routine for COMPACT Act administrative eligibility ;12/23/2020
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**240,246**;Aug 12, 1996;Build 14
 ; *246* Background routine for COMPACT Act administrative eligibility
 ; Reference to $$ELIG^DGCOMPACTELIG in ICR #7462
 ;
 Q
 ;
CHECKELG ;
 N DFN,MESSAGE,PXCURELG,PXENDDT,PXEOCNUM,PXEOCSEQ,PXLSTELG
 S DFN=""
 ; Loop through the "B" level of the episode of care file (#818)
 F  S DFN=$O(^PXCOMP(818,"B",DFN)) Q:DFN=""  D
 . S (PXCURELG,PXENDDT,PXEOCNUM,PXEOCSEQ,PXLSTELG)=""
 . I $$ASC^PXCOMPACT(DFN)="N" Q
 . ; Check the current administrative eligibility
 . S PXCURELG=$$ELIG^DGCOMPACTELIG(DFN,"PXCOMPACTBKGRND")
 . ; Convert the web service value to compare to the stored values in EoC
 . S PXCURELG=$S(PXCURELG="ELIGIBLE":"E",PXCURELG="NOT ELIGIBLE":"N",1:"U")
 . ; Get the episode of care number and sequence 
 . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN),PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 . S PXENDDT=$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",2)
 . ; If the episode has ended, this would not need to be checked
 . I PXENDDT'="" Q
 . S PXLSTELG=$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",8)
 . I PXCURELG'=PXLSTELG D
 . . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",8)=PXCURELG
 . . ; If current eligibility is N (Not Eligible) close the episode by calling the end episode API
 . . I PXCURELG="N" D
 . . . D SETENDDT^PXCOMPACT(DFN,DT,"PR")
 . . . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",6)="R",$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",7)="A"
 Q
 ;
BCKGRDJOB ;
 N DFN,ENDDT,PXLASTSEQ,PXEOCNUM,PXTY
 ;this is a background job that will identify episodes of care that have expired and end them
 S DFN=""
 F  S DFN=$O(^PXCOMP(818,"B",DFN)) Q:DFN=""  D
 . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 . ;check EOC OPEN/CLOSE flag (1 = open, 0 = closed)
 . I $P(^PXCOMP(818,PXEOCNUM,0),"^",2)=0 Q
 . ;check if episode is Inpatient or Outpatient
 . S PXTY=$P(^PXCOMP(818,PXEOCNUM,0),"^",3)
 . I PXTY="" Q
 . ;get latest episode of care sequence
 . S PXLASTSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 . ;now verify the corresponding Inpatient/Outpatient benefit end date and compare to today
 . I PXTY="I" S ENDDT=$P($G(^PXCOMP(818,PXEOCNUM,10,PXLASTSEQ,0)),"^",4)
 . I PXTY="O" S ENDDT=$P($G(^PXCOMP(818,PXEOCNUM,10,PXLASTSEQ,0)),"^",5)
 . I ENDDT="" Q
 . I DT>ENDDT D
 . . D SETENDDT^PXCOMPACT(DFN,ENDDT,"TE",,"Time expired")
 Q
