SDEC55A ;ALB/SAT,WTC,TJB - VISTA SCHEDULING RPCS ;Apr 19, 2023@15:22
 ;;5.3;Scheduling;**627,671,701,722,734,694,790,844**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
APPSDGET(SDECY,MAXREC,LASTSUB,SDBEG,SDEND,NOTEFLG,SDRES,DFN,SDID,SDIEN)  ;GET appointment data from SDEC APPOINTMENT file 409.84
 ;APPSDGET(.SDECY,MAXREC,LASTSUB,SDBEG,SDEND,NOTEFLG,SDRES,DFN,SDID,SDIEN)  external parameter tag is in SDEC
 ;INPUT:
 ; 1. MAXREC = (optional) Max records returned default to all
 ; 2. LASTSUB = (optional) last subscripts from previous call
 ; 3. SDBEG = (optional) Begin Date range in external format
 ;                    Default to all dates
 ; 4. SDEND = (optional) End Date range in external format
 ;                    Default to all dates
 ; 5. NOTEFLG = (optional) 1=do NOT return NOTE text
 ;                      0=return NOTE text
 ; 6. SDRES = (optional) Resource ID pointer to SDEC RESOURCE file
 ;                    Default to all resources
 ; 7. DFN = (optional) pointer to PATIENT file 2
 ;                  Default to all patients
 ; 8. SDID = (optional) external ID (free-text)
 ;                   Default to all external IDs
 ; 9. SDIEN = (optional) pointer to SDEC APPOINTMENT file 409.84
 ;RETURN:
 ; Successful Return:
 ; Global Array in which each array entry contains data from the
 ; SDEC APPOINTMENT file 409.84.
 ; Data is separated by ^:
 ; 1. IEN - pointer to SDEC APPOINTMENT file
 ; 2. DATE1 - STARTTIME in external format   .01
 ; 3. DATE2 - ENDTIME in external format     .02
 ; 4. CHECKIN_TIME - CHECKIN date/time in external format   .03
 ; 5. DATE - CHECK IN TIME ENTERED - date/time in external format   .04
 ; 6. DFN - Patient ID      .05
 ; 7. NAME - Patient NAME   .05
 ; 8. SDEC_ACCESS_TYPE_IEN - <not used>
 ; 9. SDEC_ACCESS_TYPE_NAME - <not used>
 ; 10. RESOURCEID - Pointer to the SDEC RESOURCE file
 ; 11. RESOURCE_NAME - NAME from SDEC RESOURCE file
 ; 12. USERIEN - DATA ENTRY CLERK id pointer to NEW PERSON file
 ; 13. USERNAME - DATA ENTRY CLERK name from NEW PERSON file
 ; 14. DATE3 - DATE APPT MADE in external format
 ; 15. NOSHOW - NOSHOW flag 1=YES; 0=NO default to no
 ; 16. DATE4 - NOSHOW DATETIME in external format
 ; 17. USERIEN1 - NOSHOW BY USER id pointer to NEW PERSON file
 ; 18. USERNAME1 - NOSHOW BY USER name from NEW PERSON file
 ; 19. DATE5 - REBOOK DATETIME in external format
 ; 20. DATE6 - CANCEL DATETIME in external format
 ; 21. USERIEN2 - CANCELLED BY USER id pointer to NEW PERSON file
 ; 22. USERNAME2 - CANCELLED BY USER name from NEW PERSON file
 ; 23. CANCELLATION_REASONS_IEN - CANCELLATION REASON id pointer
 ;                            to CANCELLATION REASONS file 409.2
 ; 24. CANCELLATION_REASONS_NAME - CANCELLATION REASON name from
 ;                            CANCELLATION REASONS file
 ; 25. WALKIN - WALKIN flag y=YES; n=NO default to NO
 ; 26. CHECKOUT - CHECKOUT date/time in external format
 ; 27. V_PROVIDER_IEN - V PROVIDER IEN id pointer to
 ;                      V PROVIDER file
 ; 28. V_PROVIDER_NAME - V PROVIDER name from V PROVIDER FILE
 ; 29. PROVIEN - PROVIDER id pointer to NEW PERSON file
 ; 30. PROVNAME - PROVIDER name from NEW PERSON file
 ; 31. STATUS - STATUS set of codes
 ;              valid values in external form are:
 ;                NO-SHOW
 ;                CLINIC
 ;                NO-SHOW & AUTO RE-BOOK
 ;                CANCELLED BY CLINIC & AUTO RE-BOOK
 ;                INPATIENT APPOINTMENT
 ;                CANCELLED BY PATIENT
 ;                CANCELLED BY PATIENT & AUTO-REBOOK
 ;                NO ACTION TAKEN
 ; 32. APPTLEN - LENGTH OF APPT numeric 5-120
 ; 33. APPT_STAT_IEN - PREV APPT STATUS id pointer to
 ;                     APPOINTMENT STATUS file 409.63
 ; 34. APPT_STAT_NAME - PREV APPT STATUS name from
 ;                      APPOINTMENT STATUS file
 ; 35. DAPTDT - DESIRED DATE OF APPOINTMENT in external format
 ; 36. SDID - EXTERNAL ID free-text
 ; 37. SDAPTYP - APPT REQUEST TYPE - variable pointer pointer
 ;               to one of these files:
 ;                SD WAIT LIST - E|<WL IEN> E|123
 ;                REQUEST/CONSULTATION - C|<CONSULT IEN> C|123
 ;                RECALL REMINDERS - R|^<RECALL IEN> R|123
 ; 38. NOTE - NOTE free-text converted from Word Processing
 ;            field. May contain Carriage return/line feed
 ;            characters
 ; 39. EESTAT - Patient Status  N=NEW  E=ESTABLISHED
 ; 40. APPTTYPE_IEN - pointer to the APPOINTMENT TYPE file
 ; 41. APPTTYPE_NAME - name from the APPOINTMENT TYPE file
 ;
 N SD1,SD2,SDAPP,SDECI,SDI,SDJ,SDTMP,MAXDAYS,X,Y,%DT
 S SDECY="^TMP(""SDEC55A"","_$J_",""APPSDGET"")"
 K @SDECY
 S SDECI=0
 ;              1         2           3           4                  5          6         7
 S SDTMP="T00030IEN^T00030DATE1^T00030DATE2^T00030CHECKIN_TIME^T00030DATE^T00030DFN^T00030NAME"
 ;                     8                          9                           10               11
 S SDTMP=SDTMP_"^T00030SDEC_ACCESS_TYPE_IEN^T00030SDEC_ACCESS_TYPE_NAME^T00030RESOURCEID^T00030RESOURCE_NAME"
 ;                     12            13             14          15           16          17             18
 S SDTMP=SDTMP_"^T00030USERIEN^T00030USERNAME^T00030DATE3^T00030NOSHOW^T00030DATE4^T00030USERIEN1^T00030USERNAME1"
 ;                     19          20          21             22              23
 S SDTMP=SDTMP_"^T00030DATE5^T00030DATE6^T00030USERIEN2^T00030USERNAME2^T00030CANCELLATION_REASONS_IEN"
 ;                     24                              25           26             27                   28
 S SDTMP=SDTMP_"^T00030CANCELLATION_REASONS_NAME^T00030WALKIN^T00030CHECKOUT^T00030V_PROVIDER_IEN^T00030V_PROVIDER_NAME"
 ;                     29            30             31           32            33                  34
 S SDTMP=SDTMP_"^T00030PROVIEN^T00030PROVNAME^T00030STATUS^T00030APPTLEN^T00030APPT_STAT_IEN^T00030APPT_STAT_NAME"
 ;                     35           36         37            38
 S SDTMP=SDTMP_"^T00030DAPTDT^T00030SDID^T00030SDAPTYP^T00200NOTE^T00030EESTAT^T00030APPTTYPE_IEN^T00030APPTTYPE_NAME^T00030PRIMARYELIGCD"
 S @SDECY@(SDECI)=SDTMP_$C(30)
 ;*zeb+1 722 1/9/19 prevent giant loop on bad data
 I $G(SDIEN)_$G(DFN)_$G(SDRES)="" G GETX
 ;validate MAXREC - optional
 S MAXREC=$G(MAXREC)
 I MAXREC'="" I '+MAXREC S MAXREC=""
 ;validate LASTSUB - optional
 S LASTSUB=$G(LASTSUB)
 S SD1=$P(LASTSUB,"|",1),SD2=$P(LASTSUB,"|",2)
 I SD2'="" I SDID="" S SD1=SD1-.0001
 ;
 ;validate SDRES -optional 
 S SDRES=$G(SDRES)
 I SDRES'="",'$D(^SDEC(409.831,SDRES,0)) D ERR1^SDECERR(-1,"Invalid resource ID.",SDECI,SDECY) Q
 ;
 ;validate SDIEN - optional
 S SDIEN=$G(SDIEN)
 I SDIEN'="",'$D(^SDEC(409.84,SDIEN,0)) D ERR1^SDECERR(-1,"Invalid ID.",SDECI,SDECY) Q
 ;
 ; Get the value for MAXDAYS, pass in the Appointment IEN or Resource IEN (both could be null so default of 390 is returned)
 S MAXDAYS=$$GETMAXDAYS(SDIEN,SDRES)
 ;
 ;  Change date/time conversion so midnight is handled properly.  wtc 694 4/24/18
 ;
 ;validate SDBEG - optional
 S SDBEG=$G(SDBEG)
 ;I $G(SDBEG)'="" S %DT="" S X=$P($G(SDBEG),"@",1) D ^%DT S SDBEG=Y I Y=-1 D ERR1^SDECERR(-1,"Invalid begin date/time.",SDECI,SDECY) Q
 I SDBEG'="" S SDBEG=$$NETTOFM^SDECDATE(SDBEG,"Y") I SDBEG=-1 D ERR1^SDECERR(-1,"Invalid begin date/time.",SDECI,SDECY) Q  ;
 I SDBEG'="",SDBEG<$$FMADD^XLFDT($$NOW^XLFDT(),-10*365) D ERR1^SDECERR(-1,"Invalid begin date/time.",SDECI,SDECY) Q  ;  WTC 701
 ;
 ;  Limit search to start 10 years ago.  wtc 6/18/18  SD*5.3*701
 ;
 I SDBEG="" S SDBEG=$$FMADD^XLFDT($$NOW^XLFDT(),-10*365) ;
 ;
 ;validate SDEND - optional
 S SDEND=$G(SDEND)
 ;I $G(SDEND)'="" S %DT="" S X=$P($G(SDEND),"@",1) D ^%DT S SDEND=Y_".2359" I Y=-1 D ERR1^SDECERR(-1,"Invalid end date/time.",SDECI,SDECY) Q
 I SDEND'="" S SDEND=$$NETTOFM^SDECDATE(SDEND) S:SDEND>0 SDEND=SDEND_".2359" I SDEND=-1 D ERR1^SDECERR(-1,"Invalid end date/time.",SDECI,SDECY) Q  ; 
 I SDEND'="",SDEND>$$FMADD^XLFDT($$NOW^XLFDT(),MAXDAYS) D ERR1^SDECERR(-1,"Invalid end date/time.",SDECI,SDECY) Q  ;  WTC 701
 ;
 ;  Limit search to no later than 390 days in the future.  wtc 6/18/18 SD*5.3*701
 ;  modified the SDEND to be +MAXDAYS based on "MAX # DAYS FOR FUTURE BOOKING" File #44 field 2002
 I SDEND="" S SDEND=$P($$FMADD^XLFDT($$NOW^XLFDT(),MAXDAYS),".",1)_".2359" ;
 ;
 ;validate NOTEFLG - optional
 S NOTEFLG=$S($G(NOTEFLG)=1:1,1:0)
 ;
 ;validate DFN -optional
 S DFN=$G(DFN)
 I DFN'="" I '$D(^DPT(DFN,0)) D ERR1^SDECERR(-1,"Invalid patient ID.",SDECI,SDECY) Q
 ;validate SDID - optional
 S SDID=$G(SDID)
 ;
 I SDIEN'="" D GET1(SDIEN,SDBEG,SDEND,NOTEFLG,SDRES,DFN,SDID,.SDECI,SDECY)
 G:SDIEN'="" GETX
 ;look in external id xref AEX
 I SDID'="" D
 .S SDAPP=$S(SD1'="":SD1,1:0) F  S SDAPP=$O(^SDEC(409.84,"AEX",SDID,SDAPP)) Q:SDAPP'>0  D  I +MAXREC,SDECI>=MAXREC S LASTSUB=SDAPP Q
 ..D GET1(SDAPP,SDBEG,SDEND,NOTEFLG,SDRES,DFN,SDID,.SDECI,SDECY)
 G:SDID'="" GETX
 ;look in patient xref CPAT
 I DFN'="" D
 .S SDAPP=$S(SD1'="":SD1,1:0) F  S SDAPP=$O(^SDEC(409.84,"CPAT",DFN,SDAPP)) Q:SDAPP'>0  D  I +MAXREC,SDECI>=MAXREC S LASTSUB=SDAPP Q
 ..D GET1(SDAPP,SDBEG,SDEND,NOTEFLG,SDRES,DFN,SDID,.SDECI,SDECY)
 G:DFN'="" GETX
 ;
 ;look in resource xref ARSRC
 I SDRES'="" D
 .S SDI=$S(SD1'="":SD1,1:SDBEG) F  S SDI=$O(^SDEC(409.84,"ARSRC",SDRES,SDI)) Q:SDI'>0  Q:SDI>SDEND  D  I +MAXREC,SDECI>=MAXREC S LASTSUB=SDI_"|"_SDAPP Q
 ..S SDAPP=$S(SD2'="":SD2,1:0) S SD2=0 F  S SDAPP=$O(^SDEC(409.84,"ARSRC",SDRES,SDI,SDAPP)) Q:SDAPP'>0  D  I +MAXREC,SDECI>=MAXREC S LASTSUB=SDI_"|"_SDAPP Q
 ...D GET1(SDAPP,SDBEG,SDEND,NOTEFLG,SDRES,DFN,SDID,.SDECI,SDECY)
 G:SDRES'="" GETX
 ;look in start time xref B
 S SDI=$S(SD1'="":SD1,1:SDBEG) F  S SDI=$O(^SDEC(409.84,"B",SDI)) Q:SDI'>0  Q:SDI>SDEND  D  I +MAXREC,SDECI>=MAXREC S LASTSUB=SDI_"|"_SDAPP Q
 .S SDAPP=$S(SD2'="":SD2,1:0) S SD2=0 F  S SDAPP=$O(^SDEC(409.84,"B",SDI,SDAPP)) Q:SDAPP'>0  D  I +MAXREC,SDECI>=MAXREC S LASTSUB=SDI_"|"_SDAPP Q
 ..D GET1(SDAPP,SDBEG,SDEND,NOTEFLG,SDRES,DFN,SDID,.SDECI,SDECY)
GETX  S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
GET1(SDAPP,SDBEG,SDEND,NOTEFLG,SDRES,DFN,SDID,SDECI,SDECY) ;get 1 appointment record
 ;INPUT:
 ; SDAPP - appointment ID pointer to SDEC APPOINTMENT file 409.84
 N SDA,SDDATA,SDNOTE,SDRET,SDTYP,SDX,SDY,SDCLINIEN,HLAPIEN,APTSTART,ECODE
 S SDBEG=$G(SDBEG)
 S SDEND=$G(SDEND)
 S NOTEFLG=$G(NOTEFLG)
 S SDRES=$G(SDRES)
 S DFN=$G(DFN)
 S SDID=$G(SDID)
 S SDECI=$G(SDECI)
 S SDECY=$G(SDECY)
 D GETS^DIQ(409.84,SDAPP_",",".01:.23","IE","SDDATA")
 S SDA="SDDATA(409.84,"""_SDAPP_","")"
 S $P(SDRET,U,1)=SDAPP           ;ien
 ;
 ;  Change date/time conversion so midnight is handled properly.  wtc 694 5/30/18
 ;
 ; S $P(SDRET,U,2)=@SDA@(.01,"E")  ;start time
 S $P(SDRET,U,2)=$$FMTONET^SDECDATE($P(^SDEC(409.84,SDAPP,0),U,1)) ; wtc 694 5/30/18
 Q:(SDBEG'="")&($P(@SDA@(.01,"I"),".",1)<$P(SDBEG,".",1))
 ; S $P(SDRET,U,3)=@SDA@(.02,"E")  ;end time
 S $P(SDRET,U,3)=$$FMTONET^SDECDATE($P(^SDEC(409.84,SDAPP,0),U,2)) ; wtc 694 5/30/18
 Q:(SDEND'="")&($P(@SDA@(.02,"I"),".",1)>$P(SDEND,".",1))
 ; S $P(SDRET,U,4)=@SDA@(.03,"E")  ;check in time
 S $P(SDRET,U,4)=$$FMTONET^SDECDATE($P(^SDEC(409.84,SDAPP,0),U,3)) ; wtc 694 5/30/18
 ; S $P(SDRET,U,5)=@SDA@(.04,"E")  ;check in time entered
 S $P(SDRET,U,5)=$$FMTONET^SDECDATE($P(^SDEC(409.84,SDAPP,0),U,4)) ; wtc 694 5/30/18
 S $P(SDRET,U,6)=@SDA@(.05,"I")  ;patient ID
 Q:(DFN'="")&($P(SDRET,U,6)'=DFN)
 S $P(SDRET,U,7)=@SDA@(.05,"E")  ;patient NAME
 S ($P(SDRET,U,40),$P(SDRET,U,8))=@SDA@(.06,"I")  ;appointment type ID
 S ($P(SDRET,U,41),$P(SDRET,U,9))=@SDA@(.06,"E")  ;appointment type NAME
 S $P(SDRET,U,10)=@SDA@(.07,"I")  ;resource ID
 Q:(SDRES'="")&($P(SDRET,U,10)'=SDRES)
 S $P(SDRET,U,11)=@SDA@(.07,"E")  ;resource NAME
 S $P(SDRET,U,12)=@SDA@(.08,"I")  ;data entry clerk ID
 S $P(SDRET,U,13)=@SDA@(.08,"E")  ;data entry clerk NAME
 S $P(SDRET,U,14)=@SDA@(.09,"E")  ;date appointment made
 S $P(SDRET,U,15)=@SDA@(.1,"E")   ;noshow flag
 ; S $P(SDRET,U,16)=@SDA@(.101,"E") ;no show date time
 S $P(SDRET,U,16)=$$FMTONET^SDECDATE($P(^SDEC(409.84,SDAPP,0),U,23)) ; wtc 694 5/30/18
 S $P(SDRET,U,17)=@SDA@(.102,"I") ;no show by user ID
 S $P(SDRET,U,18)=@SDA@(.102,"E") ;no show by user NAME
 ; S $P(SDRET,U,19)=@SDA@(.11,"E") ;rebook date time
 S $P(SDRET,U,19)=$$FMTONET^SDECDATE($P(^SDEC(409.84,SDAPP,0),U,11)) ; wtc 694 5/30/18
 ; S $P(SDRET,U,20)=@SDA@(.12,"E") ;cancel date time
 S $P(SDRET,U,20)=$$FMTONET^SDECDATE($P(^SDEC(409.84,SDAPP,0),U,12)) ; wtc 694 5/30/18
 S $P(SDRET,U,21)=@SDA@(.121,"I") ;cancelled by user ID
 S $P(SDRET,U,22)=@SDA@(.121,"E") ;cancelled by user NAME
 S $P(SDRET,U,23)=@SDA@(.122,"I") ;cancellation reason ID
 S $P(SDRET,U,24)=@SDA@(.122,"E") ;cancellation reason NAME
 S $P(SDRET,U,25)=@SDA@(.13,"E")  ;walk-in
 ; S $P(SDRET,U,26)=@SDA@(.14,"E")  ;check-out date/time
 S $P(SDRET,U,26)=$$FMTONET^SDECDATE($P(^SDEC(409.84,SDAPP,0),U,14)) ; wtc 694 5/30/18
 S $P(SDRET,U,27)=@SDA@(.15,"I")  ;v provider ID
 S $P(SDRET,U,28)=@SDA@(.15,"E")  ;v provider NAME
 S $P(SDRET,U,29)=@SDA@(.16,"I")  ;provider ID
 S $P(SDRET,U,30)=@SDA@(.16,"E")  ;provider NAME
 S $P(SDRET,U,31)=@SDA@(.17,"E")  ;status
 S $P(SDRET,U,32)=@SDA@(.18,"E")  ;length of appt
 S $P(SDRET,U,33)=@SDA@(.19,"I")  ;prev appt status ID
 S $P(SDRET,U,34)=@SDA@(.19,"E")  ;prev appt status NAME
 S $P(SDRET,U,35)=$P(@SDA@(.2,"E"),"@",1) ;desired date of appointment ;wtc 734 10/7/2019 - strip off time that VAOS puts on CID
 S $P(SDRET,U,36)=@SDA@(.21,"E")  ;external id
 Q:(SDID'="")&($P(SDRET,U,36)'=SDID)
 S SDX=@SDA@(.22,"I") S SDY=$P(SDX,";",2)
 S SDTYP=$S(SDY="SDWL(409.3,":"E|",SDY="GMR(123,":"C|",SDY="SD(403.5,":"R|",SDY="SDEC(409.85,":"A|",1:"")_$P(SDX,";",1)  ;appt request type
 S $P(SDRET,U,37)=SDTYP
 ;
 N SDECIEN
 S SDNOTE=""
 I 'NOTEFLG I $D(^SDEC(409.84,SDAPP,1)) D
 .S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.84,SDAPP,1,SDECIEN)) Q:'+SDECIEN  D
 ..S SDNOTE=SDNOTE_$G(^SDEC(409.84,SDAPP,1,SDECIEN,0))
 ..S SDNOTE=SDNOTE_$C(13)_$C(10)
 S $P(SDRET,U,38)=SDNOTE
 S $P(SDRET,U,39)=@SDA@(.23,"E")  ;patient status
 ;
 S $P(SDRET,U,42)=""
 I $P(SDRET,U,10)="" S $P(SDRET,U,10)=$$MISSINGRES^SDESAPPTUTIL(SDAPP) S:+$P(SDRET,U,10)=0 $P(SDRET,U,10)=""
 I +$P(SDRET,U,10) D
 .S SDCLINIEN=$$GET1^DIQ(409.831,$P(SDRET,U,10),.04,"I")
 .S APTSTART=@SDA@(.01,"I")
 .S HLAPIEN=+$$FIND^SDAM2($P(SDRET,U,6),APTSTART,SDCLINIEN)
 .S ^ZTODD($J)="RES: "_$P(SDRET,U,10)_" Clin: "_SDCLINIEN_" APPT DT: "_APTSTART_" HL APPT: "_HLAPIEN
 .I HLAPIEN'="" D
 ..S ECODE=$P($G(^SC(SDCLINIEN,"S",APTSTART,1,HLAPIEN,0)),U,10)
 ..S ^ZTODD($J)="RES: "_$P(SDRET,U,10)_" Clin: "_SDCLINIEN_" APPT DT: "_APTSTART_" HL APPT: "_HLAPIEN_" EL CD: "_ECODE
 ..S:ECODE $P(SDRET,U,42)=$$GET1^DIQ(8,ECODE,.01,"E")
 .I $P(SDRET,U,42)="" S $P(SDRET,U,42)=$$GET1^DIQ(2,$P(SDRET,U,6),.361,"E")
 ;
 S SDECI=SDECI+1 S @SDECY@(SDECI)=SDRET_$C(30)
 K SDDATA
 Q
 ;
GETMAXDAYS(SDAPIEN,SDRESIEN) ; Get the number of days in the future to be able to book appointments
 ; The "MAX # DAYS FOR FUTURE BOOKING" is in File #44 field #2002 
 ; SDAPIEN - Appointment IEN from SDEC APPOINTMENT (#409.84)
 ; SDRESIEN - Resource IEN from SDEC RESOURCE FILE (#409.831)
 ; MAXDAYS - Value to be returned from 'MAX # DAYS FOR FUTURE BOOKING' file 44 field 2002
 N MAXDAYS,PTR44,SDRES1 S PTR44="",MAXDAYS=""
 S SDAPIEN=$G(SDAPIEN)
 S SDRESIEN=$G(SDRESIEN)
 I SDRESIEN'="",$D(^SDEC(409.831,SDRESIEN,0))]"" S PTR44=$P($G(^SDEC(409.831,SDRESIEN,0)),"^",4)
 I SDAPIEN'="",SDRESIEN="" S SDRES1=$P($G(^SDEC(409.84,SDAPIEN,0)),U,7),PTR44=$P($G(^SDEC(409.831,SDRES1,0)),"^",4)
 ; Get file 44 field 2002
 I +PTR44,$D(^SC(PTR44,"SDP")) S MAXDAYS=$P($G(^SC(PTR44,"SDP")),"^",2)
 S:+MAXDAYS'>1 MAXDAYS=390
 Q MAXDAYS
