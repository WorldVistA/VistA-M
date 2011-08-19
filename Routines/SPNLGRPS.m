SPNLGRPS ; ISC-SF/GMB - SCD GATHER PATIENT STATISTICS DATA; 3 JUL 94 [ 08/08/94  2:19 PM ] ;6/23/95  11:39
 ;;2.0;Spinal Cord Dysfunction;**18**;01/02/1997
GATHER(DFN,FDATE,TDATE,QLIST) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"PS",
 ; with the following nodes for each sex:
 ; "SEX",sex)            # patients of this sex
 ; "STAT","DEAD",sex)    # patients who are dead
 ; "STAT","ALIVE",sex)   # patients who are alive
 ; "AGE",agerange,sex)   # patients who are in this age range
 ; "RACE",race,sex)      # patients who are this race
 ; "MEANS",means,sex)    # patients who are in this means test category
 ; "POS",pos,sex)        # patients who are from this period of service
 ; "ELIG",elig,sex)      # patients with this eligibility
 ; Additionally, if the user specified a time period:
 ; "SEEN","IP",sex)      # patients seen as an inpatient
 ; "SEEN","OP",sex)      # patients seen as an outpatient
 ; "SEEN","CH",sex)      # patients who had lab tests
 ; "SEEN","RX",sex)      # patients seen in pharmacy
 ; "SEEN","RA",sex)      # patients seen in radiology
 N VADM,VAEL,AGE,SEX,AGERANGE,ISDEAD,MEANS,ELIG,POS,RACE
 N SEEN,SEENIP,SEENOP,SEENCH,SEENRX,SEENRA,LASTSEEN
 D DEM^VADPT ; Get patient demographics
 ; If we are not including dead patients, and if the patient has a date of death recorded, then quit
 S ISDEAD=+$P($G(VADM(6)),U,1)
 I 'QLIST("INCLUDE DEAD"),ISDEAD Q
 ; If we are only interested in patients who were seen during a certain
 ; time period, but this patient was not seen during that period, then quit
 I QLIST("WINDOW") D  Q:'SEEN
 . D SEEN^SPNLGUSN(DFN,FDATE,TDATE,.SEEN,.LASTSEEN,.SEENIP,.SEENOP,.SEENCH,.SEENRX,.SEENRA)
 S SEX=$P(VADM(5),U,1)
 I $F("MF",SEX)<2 S SEX="U"
 ; Capture all the sexes
 S ^TMP("SPN",$J,"PS","SEX",SEX)=""
 ; Capture Dead/Alive
 I ISDEAD S ^(SEX)=$G(^TMP("SPN",$J,"PS","STAT","DEAD",SEX))+1
 E        S ^(SEX)=$G(^TMP("SPN",$J,"PS","STAT","LIVE",SEX))+1
 ; Capture age range
 S AGE=VADM(4)
 S AGERANGE=AGE\5*5
 S ^(SEX)=$G(^TMP("SPN",$J,"PS","AGE",AGERANGE,SEX))+1
 ; Capture Race
 S RACE=$P($G(VADM(12,1)),U,2)
 I RACE="" S RACE="UNSPECIFIED RACE"
 S ^(SEX)=$G(^TMP("SPN",$J,"PS","RACE",RACE,SEX))+1
 D ELIG^VADPT ; Get patient eligibility information
 ; Capture Means Test Info
 S MEANS=$P($G(VAEL(9)),U,2)
 I MEANS="" SET MEANS="NOT REQUIRED"
 S ^(SEX)=$G(^TMP("SPN",$J,"PS","MEANS",MEANS,SEX))+1
 ; Capture Eligibility
 S ELIG=$P($G(VAEL(1)),U,2)
 I ELIG="" S ELIG="UNSPECIFIED ELIGIBILITY"
 S ^(SEX)=$G(^TMP("SPN",$J,"PS","ELIG",ELIG,SEX))+1
 ; Capture Period of Service Info
 S POS=$P($G(VAEL(2)),U,2)
 I POS="" S POS="UNSPECIFIED PERIOD OF SERVICE"
 S ^(SEX)=$G(^TMP("SPN",$J,"PS","POS",POS,SEX))+1
 ; Capture where seen, but only if report is for a specified period
 I QLIST("WINDOW") D
 . S:SEENIP ^(SEX)=$G(^TMP("SPN",$J,"PS","SEEN","IP",SEX))+1
 . S:SEENOP ^(SEX)=$G(^TMP("SPN",$J,"PS","SEEN","OP",SEX))+1
 . S:SEENCH ^(SEX)=$G(^TMP("SPN",$J,"PS","SEEN","CH",SEX))+1
 . S:SEENRX ^(SEX)=$G(^TMP("SPN",$J,"PS","SEEN","RX",SEX))+1
 . S:SEENRA ^(SEX)=$G(^TMP("SPN",$J,"PS","SEEN","RA",SEX))+1
 Q
