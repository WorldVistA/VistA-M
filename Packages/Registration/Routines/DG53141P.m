DG53141P ;ALB/SEK 0% SC CLEANUP POST-INS DG*5.3*141 ;09/24/97
 ;;5.3;Registration;**141**;Aug 13, 1993
 ;
 ;This routine will be run as post-installation for patch DG*5.3*141.
 ;This is a cleanup for all 0% SC veterans who had an outpatient
 ;encounter since the installation of Tricare, who is an inpatient
 ;(when or since the installation of Tricare), who has a future
 ;appointment, and who has a Means Test entry since installation of
 ;Tricare.  If the veteran meets any of the above criteria, routine
 ;DGMTR141 is called to determine if the veteran requires a Means Test.
 ;The following can occur:
 ;       No change is made if the requirement is the same as the
 ;          veteran has now.
 ;       Status of the veteran will be changed to NO LONGER REQUIRED
 ;          from REQUIRED.
 ;       Status of the veteran will be changed to REQUIRED by
 ;          adding a new test with a status of REQUIRED or by
 ;          changing a NO LONGER REQUIRED status to REQUIRED. 
 ;
 ;       Status of Copay Tests will be changed to INCOMPLETE or
 ;          NO LONGER APPLICABLE
 ;
POST ;entry point for post-install, setting up checkpoints
 N %
 I $D(XPDNM) S %=$$NEWCP^XPDUTL("DFN","EN^DG53141P",0)
 Q
 ;
EN ;begin processing
 ;
 ;go through PATIENT file finding 0% SC veterans and determine
 ;and change if necessary the Means Test status and/or add a
 ;REQUIRED Means Test
 N DFN,DGINSDT
 ;
 D BMES^XPDUTL("  >> 0% SC Means Test cleanup")
 ;
 ;get value from checkpoints, previous run
 I $D(XPDNM) S DFN=+$$PARCP^XPDUTL("DFN")
 ;
 D INSTDT
 D LOOP
 D PRINT
 Q
 ;
 ;
INSTDT ;get install date of Tricare from KIDS file.  If not found use
 ;Tricare release date (8/8/97)
 N I
 S I=0,I=$O(^XPD(9.7,"B","DG*5.3*114",I)) I 'I S DGINSDT=2970808 Q
 S DGINSDT=$P($P($G(^XPD(9.7,I,0)),"^",3),".") S:'DGINSDT DGINSDT=2970808
 Q
 ;
LOOP ;
 N %
 S ^XTMP("DG53141G",0)=2980401_"^"_DT_"^"_"MEANS TEST REQUIRED CHANGED LOG"  ;temp array
 I '$D(XPDNM) S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D  I $D(XPDNM) S %=$$UPCP^XPDUTL("DFN",DFN)
 .I $P($G(^DPT(DFN,.3)),"^",2)'=0 Q
 .N DGADDDT,SORT
 .S DGADDDT=$$OUTPAT(DFN,DGINSDT) I DGADDDT S SORT=1 D EN^DG141PB Q
 .S DGADDDT=$$INPAT(DFN,DGINSDT) I DGADDDT S SORT=2 D EN^DG141PB Q
 .S DGADDDT=$$FUTAPP(DFN,DGINSDT) I DGADDDT S SORT=3 D EN^DG141PB Q
 .S DGADDDT=$$CURRMT(DFN,DGINSDT) I DGADDDT S SORT=4 D EN^DG141PB
 .Q
 Q
 ;
 ;
OUTPAT(DFN,DGINSDT) ;check is veteran had an outpatient encounter since
 ;installation of Tricare
 ;input   DFN       Patient IEN
 ;        DGINSDT   Tricare installation date
 ;output  0 if no outpatient encounter
 ;        date of encounter if had encounter
 ;
 N Y,INSDT
 S Y=0,INSDT=DGINSDT
 F  S INSDT=$O(^SCE("ADFN",DFN,INSDT)) Q:('INSDT!(INSDT>(DT_.9999)))  S Y=$P(INSDT,".") Q
 Q +$G(Y)
 ;
INPAT(DFN,DGINSDT) ;check is veteran is an inpatient or was when Tricare 
 ;was installed
 ;input   DFN       Patient IEN
 ;        DGINSDT   Tricare installation date
 ;output  0 if not an inpatient on or since date of Tricare installation 
 ;        date of installation if inpatient on installation
 ;        date of becoming inpatient if after installation date
 ;
 ;
 N Y,I,J,INSDT
 S Y=0,INSDT=DGINSDT
 I '$D(^DGPM("ADFN"_DFN)) G INPATQ
 F  S INSDT=$O(^DGPM("ADFN"_DFN,INSDT)) Q:'INSDT  D  Q:Y'=0
 .S I=0 F  S I=$O(^DGPM("ADFN"_DFN,INSDT,I)) Q:'I  D  Q:Y'=0
 ..S J=$P($G(^DGPM(I,0)),"^",2)
 ..I J=1 S Y=$P(INSDT,".") Q
 ..I "^2^3^6^"[("^"_J_"^") S Y=DGINSDT Q
 ..I $D(^DPT(DFN,.105)) S Y=DGINSDT
 ..Q
INPATQ Q +$G(Y)
 ;
 ;
FUTAPP(DFN,DGINSDT) ;check is veteran has a future appointment
 ;input   DFN       Patient IEN
 ;        DGINSDT   Tricare installation date
 ;output  0 if no future appointment
 ;        today's date if has future appointment
 ;
 ;
 N Y,INSDT
 S Y=0,INSDT=DGINSDT
 F  S INSDT=$O(^DPT(DFN,"S",INSDT)) Q:'INSDT  I $P($G(^DPT(DFN,"S",INSDT,0)),"^",2)="" S Y=DT Q
 Q +$G(Y)
 ;
 ;
CURRMT(DFN,DGINSDT) ;check if veteran had a Means Test since installation
 ;                of Tricare
 ;input   DFN       Patient IEN
 ;        DGINSDT   Tricare installation date
 ;output  0 if had no Means Test
 ;        date of Means Test
 ;
 ;
 N Y,INSDT,DGMTCU
 S Y=0,INSDT=DGINSDT
 S DGMTCU=$P($$LST^DGMTU(DFN),"^",2) S:DGMTCU>(INSDT-1) Y=DGMTCU
 Q +$G(Y)
 ;
 ;
PRINT ;print summary
 N TOTAL,I
 S TOTAL=0 F I=1:1:4 S TOTAL=$G(^XTMP("DG53141G",1,I,0))+TOTAL
 D BMES^XPDUTL(TOTAL_"  0% SC vets made Means Test REQUIRED")
 S TOTAL=0 F I=1:1:4 S TOTAL=$G(^XTMP("DG53141G",3,I,0))+TOTAL
 D BMES^XPDUTL(TOTAL_"  0% SC vets made Means Test NO LONGER REQUIRED")
 D BMES^XPDUTL("  >> cleanup done.")
 D BMES^XPDUTL("  >> run DG141 LIST [DG141 SC 0% MT REPORT] option to produce report(s)")
 Q
