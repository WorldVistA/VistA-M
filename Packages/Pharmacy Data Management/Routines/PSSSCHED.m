PSSSCHED ;BIR/JMC-BUILD SCHEDULE LIST FOR CPRS GUI SELECTION;02/27/08
 ;;1.0;PHARMACY DATA MANAGEMENT;**94**;9/30/97;Build 26
 ;
 ;
 Q  ;Cannot be called directly.  Must use API
 ;
SCHED(PSSWIEN,PSSARRY) ;Receive ward IEN from CPRS and return list of schedules.
 ;
 ;PSSWIEN   = Ward IEN
 ;PSSARRY   = array passed by reference from CPRS
 ;
 ;If there is a duplicate schedule, and if one of them contains
 ;ward-specific admin times for the ward location of the patient,
 ;the schedule returned for inclusion in the list of selectable
 ;schedules to CPRS will be the one with the ward-specific admin
 ;times.  If neither duplicate has ward-specific admin times,
 ;then the current functionality of the schedule with the lowest
 ;IEN number will remain in place.  If both (or more than one)
 ;duplicate schedules have ward-specific admin times for the ward
 ;location of the patient, then the one with the lowest IEN number
 ;will be the schedule returned to CPRS.
 ;
 ;Example:  Patient's ward location is ICU
 ;^PS(51.1,"APPSJ","BID",1)=""
 ;^PS(51.1,"APPSJ","BID",2)=""
 ;
 ;If ^PS(51.1,1 does not have ward-specific admin times for
 ;the ICU, but ^PS(51.1,2 does, ^PS(51.1,2 will be in the list
 ;of schedules returned to CPRS.
 ;
 ;If neither schedule has ward-specific admin times for the ICU
 ;then ^PS(51.1,1 will be in the list of schedules returned to CPRS.            
 ;
 ;If both schedules have ward-specific admin times for the ICU
 ;then ^PS(51.1,1 will be in the list of schedules returned to CPRS.
 ;
 ;The returned array to CPRS will be in the format:
 ;PSSARRY(n)=IEN^NAME^OUTPATIENT EXPANSION^SCHEDULE TYPE^ADMIN TIME
 ;
 N PSSSKED,PSSSKED1,PSSSK
 K ^TMP("PSSADMIN"),^TMP("PSSDUP")
 I $G(PSSWIEN)="" S PSSWIEN=0
 S PSSSKED=""
 F  S PSSSKED=$O(^PS(51.1,"APPSJ",PSSSKED)) Q:PSSSKED=""  D
 . S PSSSKED1="",PSSSK=1
 . F  S PSSSKED1=$O(^PS(51.1,"APPSJ",PSSSKED,PSSSKED1)) Q:PSSSKED1=""  D
 . . Q:$P($G(^PS(51.1,PSSSKED1,0)),"^",5)=""
 . . S ^TMP("PSSDUP",$J,PSSSKED,PSSSK)=PSSSKED1  ;Identify duplicate schedules to work with.
 . . S ^TMP("PSSADMIN",$J,"STD",PSSSKED,PSSSKED1)=$S($P($G(^PS(51.1,PSSSKED1,1,PSSWIEN,0)),"^",2)'="":$P($G(^PS(51.1,PSSSKED1,1,PSSWIEN,0)),"^",2),1:$P($G(^PS(51.1,PSSSKED1,0)),"^",2))
 . . S PSSSK=PSSSK+1
 . I '$D(^TMP("PSSDUP",$J,PSSSKED,2)) K ^TMP("PSSDUP",$J,PSSSKED)
 I $D(^TMP("PSSDUP")) D DUP,FORMAT,KILL Q  ;Duplicate schedules - determine if any have ward-specific admin times
 I '$D(^TMP("PSSDUP")) D FORMAT,KILL Q  ;No duplicates in the schedule file - format for proper return to CPRS
 Q
KILL ;
 K ^TMP("PSSADMIN"),PSSSKED,PSSSKED1,PSSSK,PSSWIEN
 Q
DUP ;Compare duplicates to see if any have ward-specific admin times.
 S PSSSKED="",PSSSKED1=""
 F  S PSSSKED=$O(^TMP("PSSDUP",$J,PSSSKED)) Q:PSSSKED=""  D
 . S PSSSK=""
 . F  S PSSSK=$O(^TMP("PSSDUP",$J,PSSSKED,PSSSK)) Q:PSSSK=""  D
 . . S PSSSKED1=$G(^TMP("PSSDUP",$J,PSSSKED,PSSSK))
 . . I '$D(^TMP("PSSADMIN",$J,"STD",PSSSKED)) S ^TMP("PSSADMIN",$J,"STD",PSSSKED,PSSSKED1)=$P($G(^PS(51.1,PSSSKED1,0)),"^",2)
 . . I '$D(^PS(51.1,PSSSKED1,1,PSSWIEN,0)),PSSSK>1 K ^TMP("PSSADMIN",$J,"STD",PSSSKED,PSSSKED1) Q
 . . I $D(^PS(51.1,PSSSKED1,1,PSSWIEN,0)),'$D(^TMP("PSSADMIN",$J,"WARD",PSSSKED)) S ^TMP("PSSADMIN",$J,"WARD",PSSSKED,PSSSKED1)=$P($G(^PS(51.1,PSSSKED1,1,PSSWIEN,0)),"^",2)
 . . I $D(^TMP("PSSADMIN",$J,"WARD",PSSSKED)) D  Q
 . . . K ^TMP("PSSADMIN",$J,"STD",PSSSKED)
 . . . S ^TMP("PSSADMIN",$J,"STD",PSSSKED,PSSSKED1)=$G(^TMP("PSSADMIN",$J,"WARD",PSSSKED,PSSSKED1))
 . . . K ^TMP("PSSADMIN",$J,"WARD",PSSSKED)
 K ^TMP("PSSDUP")
 Q
FORMAT ;Format array for proper return to CPRS
 N PSSCNTR,PSSTMP
 S PSSSKED="",PSSSKED1="",PSSCNTR=1
 F  S PSSSKED=$O(^TMP("PSSADMIN",$J,"STD",PSSSKED)) Q:PSSSKED=""  D
 . F  S PSSSKED1=$O(^TMP("PSSADMIN",$J,"STD",PSSSKED,PSSSKED1)) Q:PSSSKED1=""  D
 . . S PSSTMP=$G(^PS(51.1,PSSSKED1,0))
 . . S PSSARRY(PSSCNTR)=PSSSKED1_"^"_PSSSKED_"^"_$P(PSSTMP,"^",8)_"^"_$P(PSSTMP,"^",5)_"^"_$G(^TMP("PSSADMIN",$J,"STD",PSSSKED,PSSSKED1))
 . . S PSSCNTR=PSSCNTR+1
 K PSSCNTR,PSSTMP
 Q
