IBAECU2 ;WOIFO/SS-LTC PHASE 2 UTILITIES ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**171,176,198**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;****** Inpatient LTC related utilities *********
 ;/*--
 ;Returns info about all admissions via ^TMP($J,IBADM,IBDFN) global
 ;
 ;Input:
 ;
 ;IBFRBEG- first date (in FM format),must be a valid,
 ;  (wrong date like 3000231 will cause mistakes)
 ;IBFREND- last date (in FM format),must be a valid date
 ;  if any of dates above > yesterday it will be set to yesterday 
 ;
 ;IBDFN  - patient's ien in file (#2)
 ;IBADM  - any string to identify results in ^TMP($J,IBADM
 ;IBDETL - 1 if you need details of each stay day in ^TMP global
 ;       - 0 if you do not need it
 ;Output:
 ;
 ;temp global array with inpatient info:
 ;  ^TMP($J,IBADM,IBDFN,IBIEN405)=
 ;  Pieces : 
 ;  #1 - admission date
 ;  #2 - discharge date
 ;  #3 - last_date_of_admission
 ;  #4 - stay_days in specified date frame $$STAYDS()
 ;  #5 - days_on_leave in specified date frame $$LEAVDS()
 ;  #6 - total admission days
 ;
 ;Daily info for all stay days about LTC/MeansTest belonging,rate 
 ;and specialty (it may vary during the admission) 
 ;  ^TMP($J,IBADM,IBDFN,IBIEN405,"SD",date)=L/M^rate^specialty  
 ;  where pieces:
 ;  #1 - "L" for LTC, "M" for MeansTest
 ;  #2 - 0
 ;  #3 - specialty ptr to file #42.4
 ;  #4 - pointer to #350.1 IB action type
 ;
 ;Daily info about leave days
 ;  ^TMP($J,IBADM,IBDFN,IBIEN405,"LD") how many days on leave
 ;  ^TMP($J,IBADM,IBDFN,IBIEN405,"LD",date_on_leave)=""
 ;
 ;Returns:
 ;  0 - none
 ;  1 - if any leave or stay days in the period
INPINFO(IBFRBEG,IBFREND,IBDFN,IBADM,IBDETL) ;
 N IBRDT,IBDT6,IBDT6A,IBRDTBEG,IBRDTEND,IBIEN1,IBIEN3,IBIEN6,IBNODE01,IBSTRT,IBFL
 N IBNODE03,IBTYP,IBSPEC,IBLASTD,IBSTAYDS,IBLEAVDS,IBDISCH,IBADMDS,IBADMDT
 N IBYESTRD,IBTEMP
 N IBRETVAL S IBRETVAL=0
 S IBLEAVDS=0,IBSTAYDS=0
 D NOW^%DTC S IBYESTRD=%\1,IBYESTRD=$$CHNGDATE^IBAECU4(IBYESTRD,-1)
 S:IBYESTRD<IBFRBEG IBFRBEG=IBYESTRD
 S:IBYESTRD<IBFREND IBFREND=IBYESTRD
 ; go thru "reverse admissions starting from IBFREND thru all because 
 ; an active admission can start any time in the past
 S IBRDT=9999999.9999999-(IBFREND_".9999999")
 F  S IBRDT=$O(^DGPM("ATID1",IBDFN,IBRDT)) Q:IBRDT=""  D
 . S IBIEN1=$O(^DGPM("ATID1",IBDFN,IBRDT,0))
 . I IBIEN1=""!('$D(^DGPM(IBIEN1,0))) D ERRLOG^IBAECU5(+$G(IBDFN),+$G(IBIEN1),"Admission (INPINFO)","no admission") Q
 . S IBNODE01=$G(^DGPM(IBIEN1,0))
 . S IBADMDT=+IBNODE01\1
 . S IBIEN3=+$P(IBNODE01,"^",17) ;discharge entry
 . I IBIEN3>0 S IBDISCH=+$G(^DGPM(IBIEN3,0))\1
 . I IBIEN3=0 S IBDISCH=0
 . I IBDISCH>0 I IBDISCH<IBFRBEG Q  ;was discharged before start date
 . S:IBDISCH>0 IBLASTD=$$CHNGDATE^IBAECU4(IBDISCH,-1) ;do not count discharge
 . S:IBDISCH=0 IBLASTD=IBFREND
 . ; days on leave
 . S IBLEAVDS=$$LEAVDS(IBFRBEG,IBFREND,IBIEN1,IBDFN,IBADM)
 . ; treat speclty
 . S IBFL=0
 . S IBDT6=0,IBSTRT=$S(IBLASTD>IBFREND:IBFREND,1:IBLASTD)
 . F  S IBDT6=$O(^DGPM("ATS",IBDFN,IBIEN1,IBDT6)) Q:IBDT6=""  D
 . . S IBSPEC=+$O(^DGPM("ATS",IBDFN,IBIEN1,IBDT6,0)) ;pointer to #45.7
 . . S IBDT6A=(9999999.9999999-IBDT6)\1
 . . I IBDT6A<IBFRBEG Q:IBFL=1  S IBDT6A=IBFRBEG,IBFL=1 ;IBFL=1 - quit next time
 . . S IBTEMP=""
 . . I IBSPEC>0 D  ;S IBSPEC=pointer to#42.4
 . . . S IBSPEC=+$P($G(^DIC(45.7,IBSPEC,0)),"^",2) S:IBSPEC>0 IBTEMP=$$TREATSP(IBSPEC),IBTYP=$P(IBTEMP,"^",1)
 . . S:IBSPEC=0 IBTYP="U"
 . . S:IBTEMP="" IBTYP="U"
 . . F  Q:IBDT6A>IBSTRT  D
 . . . I IBDETL=1,'$D(^TMP($J,IBADM,IBDFN,IBIEN1,"LD",IBSTRT)) S ^TMP($J,IBADM,IBDFN,IBIEN1,"SD",IBSTRT)=IBTYP_"^0^"_IBSPEC_"^"_$P(IBTEMP,"^",3)
 . . . S:$D(^TMP($J,IBADM,IBDFN,IBIEN1,"LD",IBSTRT)) ^TMP($J,IBADM,IBDFN,IBIEN1,"LD",IBSTRT)=IBTYP_"^0^"_IBSPEC_"^"_$P(IBTEMP,"^",3)
 . . . S IBSTRT=$$CHNGDATE^IBAECU4(IBSTRT,-1)
 . ; stay days
 . S IBSTAYDS=$$STAYDS(IBFRBEG,IBFREND,IBIEN1,IBDISCH)
 . S IBADMDS=$$FMDIFF^XLFDT(IBLASTD,IBADMDT,1)+1
 . S ^TMP($J,IBADM,IBDFN,IBIEN1)=IBADMDT_"^"_IBDISCH_"^"_IBLASTD_"^"_IBSTAYDS_"^"_IBLEAVDS_"^"_IBADMDS
 . I IBRETVAL=0 S:(IBSTAYDS+IBLEAVDS)>0 IBRETVAL=1
 Q IBRETVAL
 ;
 ;Input:
 ;How many days of stay in this month
 ;IBDTB -begin date of date frame
 ;IBDTE -end date of date frame
 ;IBP405 - pointer to Admission entry in #405
 ;DSDAY - discharge date, if patient is not duscharged then DSDAY=0
STAYDS(IBDTB,IBDTE,IBP405,DSDAY) ;
 S IBDTB=$S($$BILDATE^IBAECN1>IBDTB:$$BILDATE^IBAECN1,1:IBDTB)
 I IBDTE<DSDAY!(DSDAY=0) Q $$LOS^IBCU64(IBDTB,IBDTE,2,IBP405)
 Q $$LOS^IBCU64(IBDTB,IBDTE,1,IBP405)
 ;
 ;Input:
 ;IBDTB -begin date of the given date range
 ;IBDTE -end date of the given date frame
 ;IBP405 - pointer to entry in #405
 ;IBDFN1 - DFN of the patient
 ;IBIDN - identifier for ^TMP node
 ;Output :
 ;returns as a return value: a number of days on leave
 ;returns via ^TMP:
 ; ^TMP($J,IBIDN,IBDFN1,IBP405,"LD")=total_days_on_leave_for_the_date_range
 ; and for each of days on leave: 
 ; ^TMP($J,IBIDN,IBDFN1,IBP405,"LD",the_date_on_leave)=""
LEAVDS(IBDTB,IBDTE,IBP405,IBDFN1,IBIDN) ;
 N DFN,IBII,IBDT1,IBDT2,IBCNT,IBDS,IBVAR
 S DFN=IBDFN1,IBCNT=0
 I IBIDN'="" S ^TMP($J,IBIDN,IBDFN1,IBP405,"LD")=0
 N DT S DT=$$TODAY^IBAECN1()
 N IBLDAYS S IBLDAYS=""
 S:IBDTE>DT IBDTE=DT
 I $$APLD^DGUTL2(IBP405,.IBLDAYS,IBDTB,IBDTE,"B")=-1 Q 0
 ;if no days on leave
 I +IBLDAYS(0)=0 Q 0
 ;if there is no "movement node" in output of $$APLD^DGUTL2 is normal
 I +$O(IBLDAYS(0))=0 D  Q IBCNT
 . S IBDT1=$P(IBLDAYS(0),"^",2)\1 ;begin
 . S IBDT2=$P(IBLDAYS(0),"^",3)\1 ;end
 . S IBDS=$P(IBLDAYS(0),"^",1) ;days
 . I ($$FMDIFF^XLFDT(IBDT2,IBDT1)+1)'=IBDS S IBCNT=0 D
 . . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBP405),"Leave days (LEAVDS), only 0-node","Possibly incorrect number of days on leave")
 . S IBFL=0
 . F IBVAR=1:1:IBDS Q:IBFL  D
 . . S IBCNT=IBCNT+1
 . . I IBIDN'="" D
 . . . S ^TMP($J,IBIDN,IBDFN1,IBP405,"LD")=$G(^TMP($J,IBIDN,IBDFN1,IBP405,"LD"))+1
 . . . S ^TMP($J,IBIDN,IBDFN1,IBP405,"LD",IBDT1)=""
 . . S:IBDT1=IBDT2 IBFL=1
 . . S IBDT1=$$CHNGDATE^IBAECU4(IBDT1,+1)
 ;if output of $$APLD^DGUTL2 has "movement node"
 S IBII=0
 F  S IBII=$O(IBLDAYS(IBII)) Q:+IBII=0  D
 . S IBDT1=$P(IBLDAYS(IBII),"^",1)\1 ;begin
 . S IBDT2=$P(IBLDAYS(IBII),"^",2)\1 ;end
 . S IBDS=$P(IBLDAYS(IBII),"^",3) ;days
 . S IBFL=0
 . F IBVAR=1:1:IBDS Q:IBFL  D
 . . S IBCNT=IBCNT+1
 . . I IBIDN'="" D
 . . . S ^TMP($J,IBIDN,IBDFN1,IBP405,"LD")=$G(^TMP($J,IBIDN,IBDFN1,IBP405,"LD"))+1
 . . . S ^TMP($J,IBIDN,IBDFN1,IBP405,"LD",IBDT1)=""
 . . S:IBDT1=IBDT2 IBFL=1
 . . S IBDT1=$$CHNGDATE^IBAECU4(IBDT1,+1)
 Q IBCNT
 ;
 ;/*-----
 ;
 ;Input:
 ;SPEC - the ien of #42.4 Specialty
 ;Output:
 ;If a LTC Specialty Returns "L^ien of #42.4^ien of 350.1" 
 ;If not LTC Spec Returns "M^ien of #42.4^"
TREATSP(SPEC) ;
 N IBRET,IBNAME,IBATYP
 S IBRET=$$LTCSPEC^IBAECU(SPEC)
 Q:IBRET=0 "M^"_SPEC_"^"
 S IBNAME=$P(IBRET,"^",2)
 S IBATYP=$O(^IBE(350.1,"B",IBNAME,0))
 Q "L^"_SPEC_"^"_IBATYP
 ;
 ;/**
 ;Goes thru all specialty changes and determines specialty
 ;- if meets non-LTC then quits loop & returns 0
 ;- if LTC then calculates a number of stay days between specialty 
 ;  change and IBLSTDAY,if the number>180 then quits loop & returns 1
 ;Input:
 ;IBDFN - DFN of patient
 ;IBAMD - ptr to #405 for the admission
 ;IBLSTDAY - date from which we count 180 clock days toward the past 
 ;(these 180 days must include only stay days on LTC 
 ;and should not include any AA,UA and ASIH days)
 ;IBDISCH - discharge date
MORE180(IBDFN,IBADM,IBLSTDAY,IBDISCH) ;
 N IBRVDT,IBNONLTC,IBDAYS,IB1,IB2,IBCUR,IBQFLG
 S (IBNONLTC,IBDAYS,IBQFLG)=0
 S IBRVDT=9999999.9999999-(IBLSTDAY_".9999999")
 S IB1=IBRVDT
 F  S IB1=$O(^DGPM("ATS",IBDFN,IBADM,IB1)) Q:+IB1=0!(IBQFLG'=0)  D
 . S IBCUR=(9999999.9999999-IB1)\1
 . S IB2=$O(^DGPM("ATS",IBDFN,IBADM,IB1,0))
 . Q:+IB2=0
 . S IB2=+$P($G(^DIC(45.7,IB2,0)),"^",2) I IB2<1 S IBQFLG=-1 Q
 . I $P($$TREATSP(IB2),"^",1)="M" S IBQFLG=-1 Q
 . S IBDAYS=$$STAYDS(IBCUR,IBLSTDAY,IBADM,IBDISCH)
 . I IBDAYS>180 S IBQFLG=1 Q
 Q IBQFLG=1
 ;
 ;/**
 ;is there any inpatient episode with that day
 ;Input:
 ;IBDFN - dfn of the patient
 ;IBDT1 - date
 ;IBTMPLB - ^TMP global subscript like IBADM in $$INPINFO
 ;Output:
 ;Returns "a^b" where :
 ;a - number of LTC admissions on this date
 ;b - number of Means Test admissions on this date
 ;if "" - nothing
 ;means test & stay days:
 ;.IBADMS("M","SD",#)=treating specialty^ien of 350.1 IB action type^admission date
 ;means test & leave days
 ;.IBADMS("M","LD",#)=treating specialty^ien of 350.1 IB action type^admission date
 ;LTC & stay days
 ;.IBADMS("L","SD",#)=treating specialty^ien of 350.1 IB action type^admission date
 ;LTC & leave days
 ;.IBADMS("L","LD",#)=treating specialty^ien of 350.1 IB action type^admission date
ISINPAT(IBDFN,IBDT1,IBTMPLB,IBADMS) ;
 N IBADM,IB1,IBRETV,IBSDLD,IBD
 S IBADM=0,IBRETV=""
 F  S IBADM=$O(^TMP($J,IBTMPLB,IBDFN,IBADM)) Q:+IBADM=0  D
 . S IBSDLD="SD",IBD=$G(^TMP($J,IBTMPLB,IBDFN,IBADM,"SD",IBDT1))
 . I IBD="" S IBSDLD="LD",IBD=$G(^TMP($J,IBTMPLB,IBDFN,IBADM,"LD",IBDT1))
 . S IB1=$P(IBD,"^",1)
 . I IB1="L" D  Q
 . . S IBADMS("L",IBSDLD,IBADM)=$P(IBD,"^",3,4)_"^"_+$G(^TMP($J,IBTMPLB,IBDFN,IBADM))
 . . S $P(IBRETV,"^",1)=$P($G(IBRETV),"^",1)+1
 . I IB1="M" D
 . . S IBADMS("M",IBSDLD,IBADM)=$P(IBD,"^",3,4)_"^"_+$G(^TMP($J,IBTMPLB,IBDFN,IBADM))
 . . S $P(IBRETV,"^",2)=$P($G(IBRETV),"^",2)+1
 Q IBRETV
 ;
