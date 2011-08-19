WVRPCPT ;HIOFO/FT-WV PATIENT file (790) RPCs ;6/18/04  13:21
 ;;1.0;WOMEN'S HEALTH;**16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #10103 - ^XLFDT calls           (supported)
 ;
BRTX(DFN,BRTX,BRDD,CRTX,CRDD,WVPDATE) ; Update the patient's treatment needs and
 ; due dates in WV PATIENT file (790)
 ;  Input:  DFN - patient DFN [required]
 ;         BRTX - breast treatment need IEN (790.51) [optional]
 ;         BRDD - breast treatment need offset (e.g., 1Y) [optional]
 ;         CRTX - cervical treament need IEN (790.5) [optional]
 ;         CRDD - cervical treatment need offset (e.g., 90D) [optional]
 ;      WVPDATE - date procedure was performed [optional]
 ;                default is today
 ; Output: <none>
 Q:'DFN
 Q:'$D(^WV(790,DFN,0))
 S:'$D(BRTX) BRTX=""
 S:'$D(BRDD) BRDD=""
 S:'$D(CRTX) CRTX=""
 S:'$D(CRDD) CRDD=""
 S:'$G(WVPDATE) WVPDATE=DT
 N WVDATE,WVFDA
 S:BRTX]"" WVFDA(790,DFN_",",.18)=BRTX
 I BRDD]"" D
 .S WVDATE=$$FMADD(BRDD,WVPDATE)
 .S:WVDATE>0 WVFDA(790,DFN_",",.19)=WVDATE
 .Q
 S:CRTX]"" WVFDA(790,DFN_",",.11)=CRTX
 I CRDD]"" D
 .S WVDATE=$$FMADD(CRDD,WVPDATE)
 .S:WVDATE>0 WVFDA(790,DFN_",",.12)=WVDATE
 .Q
 I $D(WVFDA) D FILE^DIE("","WVFDA","WVERR")
 Q
 ;
FMADD(WVDAYS,WVPDT) ; This function adds the date offset indicated to the
 ; specified date to calculate a future date.
 ;  Input: WVDAYS - date offset (e.g., 90D, 6M, 1Y)  [required]
 ;         WVPDT  - date of procedure [optional]
 ;                  default is today
 ; Output: FileMan date. Returns null if a FileMan date could not
 ;         be calculated.
 ;
 Q:'WVDAYS ""
 S:'$G(WVPDT) WVPDT=DT
 N WVARRAY,WVERR,WVLOOP,WVMONTH,WVNEWDT,WVYEAR,X
 S WVNEWDT=""
 S X=WVDAYS
 D DMYCHECK^WVPURP ;check offset value
 S WVDAYS=X
 I X=-1 Q WVNEWDT
 I WVDAYS["D" D
 .S WVARRAY=$$FMADD^XLFDT(WVPDT,+WVDAYS)
 .S:WVARRAY>0 WVNEWDT=WVARRAY
 .Q
 I WVDAYS["M" D
 .S WVMONTH=+$E(WVPDT,4,5),WVYEAR=0
 .F WVLOOP=1:1:+WVDAYS D
 ..S WVMONTH=WVMONTH+1
 ..I WVMONTH>12 S WVMONTH=1,WVYEAR=WVYEAR+1
 ..Q
 .S WVNEWDT=WVPDT+(+WVYEAR*10000)
 .S WVMONTH=$S(WVMONTH<10:"0"_WVMONTH,1:WVMONTH)
 .S WVNEWDT=$E(WVNEWDT,1,3)_WVMONTH_$E(WVNEWDT,6,7)
 .Q
 I WVDAYS["Y" S WVNEWDT=WVPDT+(+WVDAYS*10000)
 Q WVNEWDT
 ;
