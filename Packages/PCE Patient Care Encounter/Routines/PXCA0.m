PXCA0 ;ISL/dee - Main routine for PCE Device Interface Module ;11/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**5,14,33,124**;Aug 12, 1996
 Q
 ;
 ;Variables:
 ;  PXCANPRV  Count of the number of providers
 ;  PXCANPOV  Count of the number of diagnoses
 ;  PXCADT  Encounter Date/Time
 ;  PXCAPAT   Pointer to the patient (9000001 & 2)
 ;  PXCAHLOC  Pointer to Hospital Location (44)
 ;  PXCACSTP  Pointer to the Credit Stop (40.7)
 ;  PXCAGLB   First sub script of ^TMP(
 ;              is "PXK" to send to PXK*
 ;              is "PXCA" to use correct data errors
 ;  PXCAERRS  Flag if
 ;              true then builds ^TMP(PXCAGLB,$J, even if there are
 ;                errors, used to build the input data so that the user
 ;                can fix the error and create or correct the entry. 
 ;              false does not build ^TMP(PXCAGLB,$J, when there is an
 ;                error in the data need to build it. 
 ;  PXCADNUM  Index into ^TMP( for the diagnosis on a "DIAGNOSIS/PROBLEM"
 ;              node so that the problem number add after calling 
 ;              Problem List
 ;
EN ;Entry called form PXCAEP.
 I '$D(PXCA) S PXCA("ERROR","ENCOUNTER",0,0,0)="Local data array is missing" Q
 N PXCADT,PXCAPAT,PXCAHLOC,PXCACSTP,PXCAPPRV,PXCAPDX,PXKDUZ,PXCADNUM
 S PXKDUZ=DUZ
 D BUILD("PXK",0)
 D:'$D(PXCA("ERROR")) FINISH("PXK")
 D:$D(PXKERROR) PXKERROR^PXCAERR("PXK")
 D EXIT("PXK")
 Q
 ;
BUILD(PXCAGLB,PXCAERRS) ;Takes an PXCA array and builds the ^TMP(PXCAGLB,$J, array.
 ;
 N PXCANPRV,PXCANPOV
 K PXKERROR
 K ^TMP(PXCAGLB,$J)
 S PXCANPRV=0,PXCANPOV=0
 ;
 D PROCESS(.PXCA,1,PXCAERRS)
 ;
 I $D(ZTQUEUED),$D(PXCA("ERROR")) S PXKERROR("PXCA")="There were errors in the data validation in the tasked job, no data was stored."
 Q
 ;
PROCESS(PXCA,PXCABULD,PXCAERRS) ;
 N PXCAEVAL S PXCAEVAL=0
 I '($D(PXKDUZ)#2) N PXCAPAT,PXCAHLOC,PXCACSTP,PXCAPPRV,PXCAPDX,PXKDUZ,PXCADNUM,PXCADT S PXKDUZ=DUZ
 N PXCAPKG,PXCASOR
 S PXCAVSIT=""
 S PXCAPKG=$$PKG2IEN^VSIT("PX")
 S PXCASOR=$P($G(PXCA("SOURCE")),"^",1)
 S (PXCAPPRV,PXCAPDX)=0
 D
 . N PXCAENC
 . S PXCAENC=$G(PXCA("ENCOUNTER"))
 . S PXCADT=+$P(PXCAENC,"^",1)
 . S PXCAPAT=+$P(PXCAENC,"^",2)
 . D:PXCAPAT PATINFO^PXCEPAT(.PXCAPAT)
 . S PXCAHLOC=+$P(PXCAENC,"^",3)
 . ; - ignore stop code passed in and always use the one for
 . ;             the Hospital Location
 . S PXCACSTP=$P($G(^SC(PXCAHLOC,0)),"^",7)
 . S PXCAVSIT=$$LOOKVSIT^PXUTLVST(PXCAPAT,PXCADT,PXCAHLOC,PXCACSTP,"","")
 . S:PXCAVSIT<1 PXCAVSIT=""
 ;
 I PXCAVSIT>0 D
 . ; - return error if trying to send data for a disposition
 . I $$DISPOSIT^PXUTL1(PXCAPAT,PXCADT,PXCAVSIT) S PXCA("ERROR","ENCOUNTER",0,0,0)="Dispositions can only be done through the Disposition menu options"
 . S PXCAPPRV=$$PRIMVPRV^PXUTL1(PXCAVSIT)
 . S PXCAPDX=$$PRIMVPOV^PXUTL1(PXCAVSIT)
 ;
 D ENCOUNT^PXCAVST(.PXCA,PXCABULD,PXCAERRS,.PXCAEVAL)
 D SOURCE^PXCASOR(.PXCA,PXCABULD,PXCAERRS)
 ;
 D PROV^PXCAPRV(.PXCA,PXCABULD,PXCAERRS)
 D DIAG^PXCAPOV(.PXCA,PXCABULD,PXCAERRS)
 D PROC^PXCACPT(.PXCA,PXCABULD,PXCAERRS,PXCAEVAL)
 ;
 D HFACTORS^PXCAHF(.PXCA,PXCABULD,PXCAERRS)
 D IMMUN^PXCAVIMM(.PXCA,PXCABULD,PXCAERRS)
 D PATED^PXCAPED(.PXCA,PXCABULD,PXCAERRS)
 D SKINTEST^PXCASK(.PXCA,PXCABULD,PXCAERRS)
 D EXAM^PXCAXAM(.PXCA,PXCABULD,PXCAERRS)
 ;
 ;Have Vitals validate its data.
 D:$L($T(VALIDATE^GMRVPCE0)) VALIDATE^GMRVPCE0(.PXCA)
 ;
 D PROBLEM^PXCAPL(.PXCA,PXCABULD,PXCAERRS)
 ;
 D DXPL^PXCADXPL(.PXCA,PXCABULD,PXCAERRS) ;must be after DIAG^PXCAPOV
 ;
 ;Message if there are no Primary diagnoses
 I 'PXCAPDX D
 . I $P($G(^PX(815,1,"DI")),"^",3) S PXCA("ERROR","DIAGNOSIS",0,0,2)="There is no Primary Diagnosis for this encounter^"
 . E  S PXCA("WARNING","DIAGNOSIS",0,0,2)="There is no Primary Diagnosis for this encounter^"
 ;
 D KVA^VADPT
 Q
 ;
FINISH(PXCAGLB) ;
 ;
 ;Have Vitals process its data.
 I $L($T(VALIDATE^GMRVPCE0)),$L($T(STORE^GMRVPCE0)) D STORE^GMRVPCE0(.PXCA)
 ;
 ;Now store the problems into Problem List
 ; That are in the "PROBLEM" node
 D PROBLIST^PXCAPL1
 ; That are in the "DIAGNOSIS/PROBLEM" node
 D PROBLIST^PXCAPL2
 ;
 ;Now store the rest of the information in the V-Files
 ; - save PXKERRORs from problem list calls in PXCAPXKE
 N PXCAPXKE
 M PXCAPXKE=PXKERROR
 D EN1^PXKMAIN
 M PXKERROR=PXCAPXKE
 ; - setting PXCAVSIT for use in PXCAERR
 S PXCAVSIT=+$G(^TMP(PXCAGLB,$J,"VST",1,"IEN"))
 ;Now do the event to tell the rest of the world about the new info.
 D EVENT^PXKMAIN
 ;
 Q
 ;
EXIT(PXCAGLB) ;Done clean up and exit.
 K PXKERROR
 K ^TMP(PXCAGLB,$J)
 D PATKILL^PXCEPAT
 Q
 ;
