DVBCPSH2 ;ALB/RJA - DBQ PUSH UTILITY RPC; MAY 9, 2024@8:20am ; 5/9/24 8:20am
 ;;2.7;AMIE;**252**;Apr 10, 1995;Build 92
 ;Per VHA Directive 6402 this routine should not be modified
 ;
 Q
 ;
LISTTEMP(DVBRET,DVBFILT,DVBSORT) ;
 ;DVBA CAPRI TEMP DEF LIST CAPRI-10314 RJA 05/10/24
 ;
 N DVBIEN,DVBCNT,DVBNM,DVBFLAGRLS,DVBFLAGUSR,DVBFLAGACT,DVBAD
 K ^TMP("DVBLTMP",$J)
 S DVBCNT=0
 ;Default filtering and sorting to 0 if no value is passed (No Filter, Alphabetical)
 I $G(DVBFILT)="" S DVBFILT=0
 I $G(DVBSORT)="" S DVBSORT=0
 S DVBIEN=0 F  S DVBIEN=$O(^DVB(396.18,DVBIEN)) Q:DVBIEN=""!('DVBIEN)  D
 .;DVBFILT=0: (Default) No Filter
 .I DVBFILT=0 D SETARRAY Q
 .S DVBFLAGRLS=0 I $$GET1^DIQ(396.18,DVBIEN,9)="YES" S DVBFLAGRLS=1
 .;DVBFILT=1: "Released"
 .I DVBFILT=1,DVBFLAGRLS D SETARRAY Q
 .;DVBFILT=2: "Selectable by User"
 .S DVBFLAGUSR=0 I $$GET1^DIQ(396.18,DVBIEN,7)="YES" S DVBFLAGUSR=1
 .I DVBFILT=2,DVBFLAGUSR D SETARRAY Q
 .;DVBFILT=3: "Activated"
 .S DVBFLAGACT=0 I $$GET1^DIQ(396.18,DVBIEN,3)="" S DVBFLAGACT=1
 .I DVBFILT=3,DVBFLAGACT D SETARRAY Q
 .;DVBFILT=4: "Released" & "Selectable by User"
 .I DVBFILT=4,DVBFLAGRLS,DVBFLAGUSR D SETARRAY Q
 .;DVBFILT=5: "Released" & "Activated"
 .I DVBFILT=5,DVBFLAGRLS,DVBFLAGACT D SETARRAY Q
 .;DVBFILT=6: "Selectable by User" & "Activated"
 .I DVBFILT=6,DVBFLAGUSR,DVBFLAGACT D SETARRAY Q
 .;DVBFILT=7: "Released" & "Selectable by User" & "Activated"
 .I DVBFILT=7,DVBFLAGRLS,DVBFLAGUSR,DVBFLAGACT D SETARRAY Q
 .Q
 ;DVBSORT=0: (Default) Alphabetical
 I DVBSORT=0 D SORT0
 ;DVBSORT=1: "Activated" followed by "Deactivated"
 I DVBSORT=1 D SORTACT,SORTDEACT
 ;DVBSORT=2: "Deactivated" followed by "Activated"
 I DVBSORT=2 D SORTDEACT,SORTACT
 K ^TMP("DVBLTMP",$J)
 Q
SETARRAY ;
 S DVBNM=$$GET1^DIQ(396.18,DVBIEN,.01)
 ;Include DVBIEN as subnode so that duplicate template names with differing IENs are accounted for
 S DVBAD=$S($$GET1^DIQ(396.18,DVBIEN,3)="":"A",1:"D")
 S ^TMP("DVBLTMP",$J,DVBNM,DVBIEN)=DVBAD
 Q
SORT0 ;
 ; DVBSORT=0: (Default) Alphabetical
 ;Set DVBRET array from ^TMP as it is already sorted alphabetical
 S DVBNM="",DVBCNT=0 F  S DVBNM=$O(^TMP("DVBLTMP",$J,DVBNM)) Q:DVBNM=""  D
 .;Include DVBIEN as subnode so that duplicate template names with differing IENs are accounted for
 .S DVBIEN="" F  S DVBIEN=$O(^TMP("DVBLTMP",$J,DVBNM,DVBIEN)) Q:DVBIEN=""  D
 ..S DVBRET(DVBCNT)=DVBNM_U_DVBIEN,DVBCNT=DVBCNT+1
 ..Q
 .Q
 Q
SORTACT ;
 ; Set array with active template definitions
 S DVBNM="" F  S DVBNM=$O(^TMP("DVBLTMP",$J,DVBNM)) Q:DVBNM=""  D
 .;Include DVBIEN as subnode so that duplicate template names with differing IENs are accounted for
 .S DVBIEN="" F  S DVBIEN=$O(^TMP("DVBLTMP",$J,DVBNM,DVBIEN)) Q:DVBIEN=""  D
 ..;Set array only with activated template definitions (1)
 ..I $G(^TMP("DVBLTMP",$J,DVBNM,DVBIEN))="A" S DVBRET(DVBCNT)=DVBNM_U_DVBIEN,DVBCNT=DVBCNT+1
 ..Q
 .Q
 Q
SORTDEACT ;
 ; Set array with deactivated template definitions
 S DVBNM="" F  S DVBNM=$O(^TMP("DVBLTMP",$J,DVBNM)) Q:DVBNM=""  D
 .;Include DVBIEN as subnode so that duplicate template names with differing IENs are accounted for
 .S DVBIEN="" F  S DVBIEN=$O(^TMP("DVBLTMP",$J,DVBNM,DVBIEN)) Q:DVBIEN=""  D
 ..;Set array only with deactivated template definitions (2)
 ..I $G(^TMP("DVBLTMP",$J,DVBNM,DVBIEN))="D" S DVBRET(DVBCNT)=DVBNM_U_DVBIEN,DVBCNT=DVBCNT+1
 ..Q
 .Q
 Q
