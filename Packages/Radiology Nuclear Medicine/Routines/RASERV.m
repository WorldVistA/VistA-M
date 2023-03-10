RASERV ;HISC/CAH,FPT,GJC AISC/MJK,DMK-Finds Service, Ward, Bedsection of Inpatient ; May 04, 2021@13:50:39
 ;;5.0;Radiology/Nuclear Medicine;**181**;Mar 16, 1998;Build 1
 ;
 ;VAIP(1): The Internal Entry Number (IEN) of the PATIENT MOVEMENT (#405) record
 ; found for the specified date/time VAIP("D") VALUE). (e.g., IEN=231009).
 ;VAIP(5): The WARD LOCATION to which patient was assigned with that movement in
 ; internal^external format (e.g., 32^1B-SURG).
 ;VAIP(8): The TREATING SPECIALTY assigned with that movement in internal^external
 ; format (e.g., 98^OPTOMETRY).
 ;
 ;Note: both RESER & RASERIEN are required variables referenced in the [RA REGISTER] input template
 ;output variables:
 ;RASER=external value of a SERVICE/SECTION record or "Unknown"
 ;RASERIEN = an IEN of a SERVICE/SECTION record or null
 ;
 Q:'$D(RADFN)  S DFN=RADFN,VA200=1 I $D(RADTE),RADTE S VAIP("D")=RADTE
 D IN5^VADPT G Q:VAIP(1)=""
 ;defualt RASERIEN to null
 S RASERIEN=""
 ;RASER = external value of TREATING SPECIALTY
 S RASER=$P(VAIP(8),"^",2),RAWD=""
 ;RATS = internal value of TREATING SPECIALTY
 ;RAWARD = external value of WARD LOCATION
 S RATS=+$P(VAIP(8),"^"),RAWARD=$P(VAIP(5),"^",2)
 ;if the patient is assigned to a ward on the date in question: VAIP("D")
 ;set RAWD equal to the zero node of WARD LOCATION record.
 I VAIP(5)]"" S RAWD=$G(^DIC(42,+VAIP(5),0))
 ;if no TREATING SPECIALTY
 I '$D(^DIC(45.7,RATS,0)) D SER G Q
 ;if TREATING SPECIALTY:
 ;+$P(RATS,"^",2) = IEN of SPECIALTY (#42.4) record
 ;+$P(RATS,"^",4) = IEN of SERVICE/SECTION (#49) record
 S RATS=$G(^DIC(45.7,RATS,0))
 S RASER=$S($D(^DIC(49,+$P(RATS,"^",4),0)):$P(^(0),"^"),1:"Unknown")
 ;the SERVICE/SECTION was found reset RASERIEN to its IEN
 S:RASER'="Unknown" RASERIEN=+$P(RATS,"^",4)
 ;set RABED value based off SPECIALTY record
 S:$D(^DIC(42.4,+$P(RATS,"^",2),0)) RABED=$P(^(0),"^")
 ;
Q ;quit/clean-up/exit
 K RADMI,RAWD,RADM,RANOW,RATRN,RATS,RATSD,RATSI,VA200,VAERR,VAIP
 Q
 ;
SER ;From the SERVICE field value (set of codes) defined for our ward try
 ;to find a matching record in the SERVICE/SECTION (#49) file.
 ;Note: RASERIEN used in RA REGISTER input template
 N RAX S RAX=$$EXTERNAL^DILFD(42,.03,"",$P(RAWD,"^",3)) S:RAX']"" RAX="UNKNOWN"
 S RASERIEN=$O(^DIC(49,"B",$E(RAX,1,30),0))
 S RASER=$S($D(^DIC(49,+RASERIEN,0)):$P(^(0),"^"),1:"Unknown")
 Q
 ;
