IBACV ;WOIFO/SS-COMBAT VET UTILITIES ;7-AUG-03
 ;;2.0;INTEGRATED BILLING;**234,247,275,339,347** ;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;To replace CL^SDCO21 with CL^IBACV that wraps out both CL^SDCO21 and $$CVEDT^DGCV
CL(IBDFN,IBSDDT,IBSDOE,IBSDCLY) ;Build Classification Array
 ; Input -- DFN Patient file IEN 
 ; SDDT Date/Time [Optional]
 ; SDOE Outpatient Encounter file IEN [Optional]
 ; Output -- SDCLY Classification Array
 ; Subscripted by Class. Type file (#409.41) IEN
 ;
 D CL^SDCO21(IBDFN,$G(IBSDDT),$G(IBSDOE),.IBSDCLY)
 Q
 ;
 ;returns CV status as:
 ; current_CV_status^end_date^if_ever_had_CV_status
CVEDT(IBDFN,IBDT) ;
 N IBRET S IBRET=$$CVEDT^DGCV($G(IBDFN),$G(IBDT))
 Q (+$P(IBRET,"^",3))_"^"_(+$P(IBRET,"^",2))_"^"_(+$P(IBRET,"^",1)) ;swop
 ;
 ;/**
 ;Return the classification description of code sets for #.03 in #351.2.
 ; Input:
 ; X -- Patient class [1-ao|2-ir|3-swa|4-sc|5-mst|6-hnc|7-cv|8-SHAD]
 ; IBCASE -- "M" - mixed case (the first letter is uppercase and others-lowercase)
PATTYPE(X,IBCASE) ; */
 N IBZ
 S IBZ=$S(X=1:"AGENT ORANGE",X=2:"IONIZING RADIATION",X=3:"SOUTHWEST ASIA",X=4:"SERVICE CONNECTED",X=5:"MILITARY SEXUAL TRAUMA",X=6:"HEAD/NECK CANCER",X=7:"COMBAT VETERAN",X=8:"PROJECT 112/SHAD",1:"SPECIAL")
 Q:$G(IBCASE)="M" $$LOWER^VALM1(IBZ)
 Q IBZ
 ;
PATTYAB(X) ; Return External Abbreviation of Special Inpatient Billing Case Patient Type (#351.2,.03)
 ; Input: 351.2, .03 internal value
 N IBZ S X=$G(X)
 S IBZ=$S(X=1:"AO",X=2:"IR",X=3:"SWA",X=4:"SC",X=5:"MST",X=6:"HNC",X=7:"CV",X=8:"SHAD",1:"UNK")
 Q IBZ
 ;
 ;if Combat Vet sends e-mail to mailgroup "IB COMBAT VET RX COPAY"
 ;IBDFN-patient IEN, IBDT - date, IBRXPTR - pointer to #52 file to get prescription #
RXALRT(IBDFN,IBDT,IBRXPTR) ;
 N IB1
 S IB1=$$CVEDT(IBDFN,$G(IBDT))
 I +IB1 D EMAIL(IBDFN,$G(IBDT),$P(IB1,"^",2),$G(IBRXPTR))
 Q
 ;sends e-mail to mail group IB COMBAT VET RX COPAY
EMAIL(DFN,IBEFDT,IBEXPDT,IBRX) ;
 N IBTODAY,IBPAT,IBT,IBSSN
 N XMSUB,XMY,XMTEXT,XMDUZ
 N Y D NOW^%DTC S Y=%\1 X ^DD("DD") S IBTODAY=Y
 I +$G(DFN)>0 D
 . N VADM,VA,VAERR
 . D DEM^VADPT
 . S IBPAT=$G(VADM(1))
 . S IBSSN=$P($G(VADM(2)),"^",2)
 I $G(IBRX) S IBRX=$$FILE^IBRXUTL(IBRX,.01) ;get RX number
 S:IBPAT="" IBPAT="Unknown"
 S XMSUB="COMBAT VET RX COPAY REVIEW NEEDED"
 S XMY("G.IB COMBAT VET RX COPAY")=""
 S XMTEXT="IBT(",XMDUZ="INTEGRATED BILLING PACKAGE"
 S IBT(1,0)="PATIENT: "_IBPAT
 I $G(IBEXPDT)>0 S Y=IBEXPDT X ^DD("DD") S IBT(1,0)=IBT(1,0)_" COMBAT VET until: "_Y
 S IBT(2,0)="SSN: "_IBSSN
 S IBT(3,0)=""
 S IBT(4,0)=$S($G(IBRX)'="":"RX#: "_$G(IBRX),1:"")
 S IBT(5,0)="RX RELEASE DATE: "_IBTODAY
 S IBT(6,0)=""
 S IBT(7,0)="The above patient has a Combat Veteran status. Please review this"
 S IBT(8,0)="prescription to determine if the RX Copay charge should be cancelled."
 S IBT(9,0)=""
 D ^XMD
 Q
 ;
 ;--------------------------------------------------------------------
 ;is called from PROC^IBAMTC for each active inpatient
IFCVEXP(IBDFN,IBNJDT,IB405) ;
 ;Input:IBDFN1 - patient's ien in PATIENT file
 ; IBNJDT - Nightly Job date 
 ; IB405 - ptr to #405
 N IBTSTDT,IBPAT,IBZ,IBEXPIR,IBADM
 S IBPAT=$$PT^IBEFUNC(IBDFN)
 S (IBZ,IBEXPIR)=0
 S IBZ=$$CVEDT^IBACV(IBDFN,IBNJDT)
 I $P(IBZ,"^",3)=0 Q  ;patient has never been CV
 S IBEXPIR=+$P(IBZ,"^",2)\1
 I IBEXPIR>IBNJDT Q  ;expires in the future
 ;get last date when Nightly job checked CV status for inpatients
 S IBTSTDT=$$XTMPLST()
 ;if ^XTMP is not there then make the last CV check date as TODAY-7
 I IBTSTDT=0 S IBTSTDT=$$CHNGDATE^IBAHVE3(IBNJDT,-7) D SETXTMP0(IBTSTDT)
  S IBADM=+$G(^DGPM(IB405,0))\1 ;admission/movement date
 I IBTSTDT'<IBNJDT Q
 ;check for all the days since the last check date thru today
 F  D  Q:(IBTSTDT'<IBNJDT)!(IBTSTDT=IBEXPIR)
 . S IBTSTDT=$$CHNGDATE^IBAHVE3(IBTSTDT,+1) ;next date
 . ;quit if the date is before the admission
 . I IBTSTDT<IBADM Q
 . ;send alert if CV expires this day
 . I IBEXPIR=IBTSTDT D SETXTPM(IBDFN,IBTSTDT,IBEXPIR,IBADM,IBPAT)
 Q
 ;
XTMPLST() ;get the last CV check date in ^XTMP
 Q +$P($G(^XTMP("IBCVEXPDT",0)),"^",2)
 ;
SETXTPM(IBDFN,IBCHKDT,IBEXP,IBADMIS,IBPT) ;save info in ^XTMP
 ;Input:IBDFN - patient's ien in PATIENT file
 ; IBEXP - CV expiration date
 ; IBADMIS - admission/movement date
 ; IBPT - patient's info
 S ^XTMP("IBCVEXPDT",IBDFN)=IBDFN_"^"_IBCHKDT_"^"_IBEXP_"^"_IBADMIS_"^"_$P(IBPT,"^",1,2)
 Q
 ;
 ;is called from IBAMTC after PROC^IBAMTC and sends e-mail alert 
 ;with the list of inpatient's with CV expired
CVEXMAIL(IBDT) ;send all e-mails
 N Y,IBT,IBZ1,IBZ2,IBC,IBT,IBTOTAL
 S IBC=0,IBTOTAL=0
 ;loop thru ^XTMP
 S IBZ1=0 F  S IBZ1=$O(^XTMP("IBCVEXPDT",IBZ1)) Q:+IBZ1=0  D
 . D HEADER
 . S IBZ2=$G(^XTMP("IBCVEXPDT",IBZ1))
 . I IBZ2'="" S IBTOTAL=IBTOTAL+1 D MKEMAIL($P(IBZ2,U,3),$P(IBZ2,U,4),$P(IBZ2,U,5),$P(IBZ2,U,6))
 I IBC>0 D
 . D FOOTER(IBTOTAL)
 . D SEND^IBACVA2
 D SETXTMP0(IBDT)
 Q
 ;
HEADER ;prints a header for the e-mail
 I IBC>0 Q
 S XMSUB="INPATIENTS' COMBAT VET STATUS EXPIRED"
 N IBX S IBX="",$P(IBX,"=",70)=""
 S IBC=IBC+1,IBT(IBC)="The following patients whose records indicate that they had CV status, were"
 S IBC=IBC+1,IBT(IBC)="admitted for inpatient care with CV status, and their CV status has expired"
 S IBC=IBC+1,IBT(IBC)="during their stays. Please check their CV exp date again before adjusting"
 S IBC=IBC+1,IBT(IBC)="their billings accordingly."
 S IBC=IBC+1,IBT(IBC)=""
 S IBC=IBC+1,IBT(IBC)=$$LRJ("Patient NAME",23)_$$LRJ("SSN",14)_$$LRJ("CV exp. date",20)_$$LRJ("Date of admission",20)
 S IBC=IBC+1,IBT(IBC)=IBX
 Q
FOOTER(IBTOTAL) ;
 S IBC=IBC+1,IBT(IBC)=""
 S IBC=IBC+1,IBT(IBC)="Total: "_IBTOTAL_" patient(s)"
 Q
 ;
MKEMAIL(IBEXP,IBADM,IBNAME,IBSSN) ;
 ;send e-mail alert if CV does expire today
 N Y
 S Y=IBEXP D DD^%DT S IBEXP=Y
 S Y=IBADM D DD^%DT S IBADM=Y
 S IBC=IBC+1,IBT(IBC)=$$LRJ($E(IBNAME,1,21),23)_$$LRJ(IBSSN,14)_$$LRJ(IBEXP,20)_$$LRJ(IBADM,20)
 Q
 ;
SETXTMP0(IBDT) ;set the new "last CV check date" in ^XTMP
 N IBPURGDT S IBPURGDT=+$$CHNGDATE^IBAHVE3(IBDT,+7)
 K ^XTMP("IBCVEXPDT")
 S ^XTMP("IBCVEXPDT",0)=IBPURGDT_"^"_IBDT_"^LAST DATE NIGHTLY JOB CHECKED COMBAT VET EXPIRATION FOR INPATIENTS"
 Q
 ;
 ;---
 ;adds spaces on right/left or truncates to make return string IBLEN characters long
 ;IBST- original string
 ;IBLEN - desired length
 ;IBCHR -character (default = SPACE)
 ;IBSIDE - on which side to add characters (default = RIGHT)
LRJ(IBST,IBLEN,IBCHR,IBSIDE) ;
 N Y S $P(Y,$S($L($G(IBCHR)):IBCHR,1:" "),$S(IBLEN-$L(IBST)<0:1,1:IBLEN-$L(IBST)+1))=""
 Q $E($S($G(IBSIDE)="L":Y_IBST,1:IBST_Y),1,IBLEN)
 ;---
 ;
