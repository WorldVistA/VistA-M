DGPFLFD1 ;ALB/KCL - PRF DISPLAY FLAG DETAIL BUILD LIST AREA ; 6/9/04 2:49pm
 ;;5.3;Registration;**425,554**;Aug 13, 1993
 ;
 ;no direct entry
 QUIT
 ;
EN(DGARY,DGPFIEN,DGCNT) ;Entry point to build flag detail list area.
 ;
 ;  Input:
 ;     DGARY - global array subscript
 ;   DGPFIEN - IEN of record in PRF NATIONAL FLAG or PRF LOCAL
 ;             FLAG file [ex: "1;DGPF(26.15,"]
 ;
 ; Output:
 ;    DGCNT - number of lines in the list, pass by reference
 ;
 N DGPFF    ;flag array
 N DGPFFH   ;flag history array
 N DGFHIENS ;contains flag history ien's
 N DGFHIEN  ;flag history ien
 N DGHISCNT ;history record counter
 N DGLINE   ;line counter
 N DGSUB    ;subscript of flag history ien's
 ;
 ;quit if required input paramater not passed
 Q:'$G(DGPFIEN)
 ;
 ;init variables
 S (DGCNT,DGLINE,DGHISCNT)=0
 K DGPFF
 ;
 ;get flag into DGPFF array
 Q:'$$GETFLAG^DGPFUT1(DGPFIEN,.DGPFF)
 S DGPFF("PTR")=DGPFIEN
 ;
 ;build 'Flag Details' list area
 D FLAGDET(DGARY,.DGPFF,.DGLINE,.DGCNT)
 ;
 ;quit if NATIONAL flag, they don't have a history
 Q:DGPFF("PTR")'["26.11"
 ;
 ;set history heading into list area
 D HISTHDR(DGARY,.DGLINE,.DGCNT)
 ;
 ;get all history ien's associated with the flag
 K DGFHIENS
 Q:'$$GETALLDT^DGPFALH(+DGPFF("PTR"),.DGFHIENS)
 ;
 ;reverse loop through each flag history ien
 S DGSUB=9999999.999999
 F  S DGSUB=$O(DGFHIENS(DGSUB),-1) Q:DGSUB=""  D
 . S DGFHIEN=$G(DGFHIENS(DGSUB))
 . K DGPFFH
 . ;- for each ien, get flag history into DGPFFH array
 . I $$GETHIST^DGPFALH(DGFHIEN,.DGPFFH) D
 . . ;
 . . ;-- count of history records
 . . S DGHISCNT=DGHISCNT+1
 . . ;
 . . ;-- build flag history details list area
 . . D HISTDET(DGARY,.DGPFFH,.DGLINE,DGHISCNT,.DGCNT)
 ;
 Q
 ;
 ;
FLAGDET(DGARY,DGPFF,DGLINE,DGCNT) ;This procedure will build the lines of FLAG details in the list area.
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;    DGPFF - flag array, pass by reference
 ;   DGLINE - line counter
 ;
 ; Output:
 ;    DGCNT - number of lines in the list, pass by reference
 ;
 ;temp vars used
 N DGSUB   ;array subscript
 N DGTEMP  ;temp text holder
 N DGCOUNT ;principal investigator count
 ;
 ;set flag name
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Flag Name: "_$P($G(DGPFF("FLAG")),U,2),11,,,,,.DGCNT)
 ;
 ;set flag category
 S DGLINE=DGLINE+1
 S DGTEMP=$S(DGPFF("PTR")["26.11":"II (LOCAL)",DGPFF("PTR")["26.15":"I (NATIONAL)",1:"UNKNOWN")
 D SET^DGPFLF1(DGARY,DGLINE,"Flag Category: "_DGTEMP,7,,,,,.DGCNT)
 ;
 ;set flag type
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Flag Type: "_$P($G(DGPFF("TYPE")),U,2),11,,,,,.DGCNT)
 ;
 ;set flag status
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Flag Status: "_$P($G(DGPFF("STAT")),U,2),9,,,,,.DGCNT)
 ;
 ;set flag review frequency
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Review Freq Days: "_$P($G(DGPFF("REVFREQ")),U,2),4,,,,,.DGCNT)
 ;
 ;set notification days
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Notification Days: "_$P($G(DGPFF("NOTIDAYS")),U,2),3,,,,,.DGCNT)
 ;
 ;set flag review mail group
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Review Mail Group: "_$P($G(DGPFF("REVGRP")),U,2),3,,,,,.DGCNT)
 ;
 ;set associated progress note title
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Progress Note Title: "_$E($P($G(DGPFF("TIUTITLE")),U,2),1,59),1,,,,,.DGCNT)
 ;
 ;set if principal investigator(s)
 I $D(DGPFF("PRININV")) D
 . S (DGSUB,DGTEMP)=""
 . S DGCOUNT=1
 . F  S DGSUB=$O(DGPFF("PRININV",DGSUB)) Q:'DGSUB  D
 . . Q:$G(DGPFF("PRININV",DGSUB,0))="@"
 . . I DGCOUNT=1 D
 . . . S DGLINE=DGLINE+1
 . . . S DGTEMP="Principal"
 . . . D SET^DGPFLF1(DGARY,DGLINE,DGTEMP,5,,,,,.DGCNT)
 . . . S DGLINE=DGLINE+1
 . . . S DGTEMP="Investigator(s): "_$P($G(DGPFF("PRININV",DGSUB,0)),U,2)
 . . . D SET^DGPFLF1(DGARY,DGLINE,DGTEMP,5,,,,,.DGCNT)
 . . I DGCOUNT>1 D
 . . . S DGTEMP=$P($G(DGPFF("PRININV",DGSUB,0)),U,2)
 . . . S DGLINE=DGLINE+1
 . . . D SET^DGPFLF1(DGARY,DGLINE,DGTEMP,22,,,,,.DGCNT)
 . . S DGCOUNT=DGCOUNT+1
 ;
 ;set flag description
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"",1,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Flag Description:",1,IORVON,IORVOFF,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"-----------------",1,,,,,.DGCNT)
 I '$D(DGPFF("DESC",1,0)) D  Q
 . S DGLINE=DGLINE+1
 . D SET^DGPFLF1(DGARY,DGLINE,"Unknown",1,,,,,.DGCNT)
 S DGSUB=0,DGTEMP=""
 F  S DGSUB=$O(DGPFF("DESC",DGSUB)) Q:'DGSUB  D
 . S DGTEMP=$G(DGPFF("DESC",DGSUB,0))
 . S DGLINE=DGLINE+1
 . D SET^DGPFLF1(DGARY,DGLINE,DGTEMP,1,,,,,.DGCNT)
 ;
 Q
 ;
 ;
HISTDET(DGARY,DGPFFH,DGLINE,DGHISCNT,DGCNT) ;This procedure will build the lines of FLAG HISTORY details in the list area.
 ;
 ;  Input:
 ;     DGARY - global array subscript
 ;    DGPFFH - flag history array, pass by reference
 ;    DGLINE - line counter
 ;  DGHISCNT - history record counter
 ;
 ; Output:
 ;    DGCNT - number of lines in the list, pass by reference
 ;
 ;temporary variables used
 N DGTEMP
 N DGSUB
 S DGTEMP=""
 ;
 ;set blank line
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"",1,,,,,.DGCNT)
 ;
 ;add an additional blank line except on the first history
 I DGHISCNT>1 D
 . S DGLINE=DGLINE+1
 . D SET^DGPFLF1(DGARY,DGLINE,"",1,,,,,.DGCNT)
 ;
 ;set history counter
 S DGLINE=DGLINE+1
 S DGTEMP=DGHISCNT_"."
 D SET^DGPFLF1(DGARY,DGLINE,DGTEMP,1,IORVON,IORVOFF,,,.DGCNT)
 ;
 ;set edit date/time
 D SET^DGPFLF1(DGARY,DGLINE,"Enter/Edit On: "_$$FDTTM^VALM1($P($G(DGPFFH("ENTERDT")),U)),14,IORVON,IORVOFF,,,.DGCNT)
 ;
 ;set entered by
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Enter/Edit By: "_$P($G(DGPFFH("ENTERBY")),U,2),14,,,,,.DGCNT)
 ;
 ;set blank line
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"",1,,,,,.DGCNT)
 ;
 ;set edit reason text
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"Reason For Flag Enter/Edit:",1,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"---------------------------",1,,,,,.DGCNT)
 I $D(DGPFFH("REASON",1,0)) D
 . S DGSUB=0,DGTEMP=""
 . F  S DGSUB=$O(DGPFFH("REASON",DGSUB)) Q:'DGSUB  D
 .. S DGTEMP=$G(DGPFFH("REASON",DGSUB,0))
 .. S DGLINE=DGLINE+1
 .. D SET^DGPFLF1(DGARY,DGLINE,DGTEMP,1,,,,,.DGCNT)
 E  D
 . S DGLINE=DGLINE+1
 . D SET^DGPFLF1(DGARY,DGLINE,"Unknown",1,,,,,.DGCNT)
 ;
 Q
 ;
 ;
HISTHDR(DGARY,DGLINE,DGCNT) ;Set history heading into list area.
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;   DGLINE - line counter
 ;
 ; Output:
 ;    DGCNT - number of lines in the list, pass by reference
 ;
 ;set blank line
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,"",1,,,,,.DGCNT)
 ;
 ;set hist heading
 S DGLINE=DGLINE+1
 D SET^DGPFLF1(DGARY,DGLINE,$TR($J("",80)," ","="),1,,,,,.DGCNT)
 D SET^DGPFLF1(DGARY,DGLINE,"<Flag Enter/Edit History>",28,IORVON,IORVOFF,,,.DGCNT)
 ;
 Q
