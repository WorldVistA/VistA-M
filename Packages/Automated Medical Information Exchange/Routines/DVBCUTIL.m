DVBCUTIL ;ALB/GTS-557/THM;C&P UTILITY ROUTINE ; 11/3/2010
 ;;2.7;AMIE;**17,126,143,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
KILL ;common exit
 D ^%ZISC I $D(FF),'$D(ZTQUEUED) W @FF,!!
 K %DT,ADR1,ADR2,ADR3,BDTRQ,BUSPHON,CITY,CNDCT,CNUM,DFN,DIW,DIWF,DIWL,DIWR,DIWT,DN,DOB,DTA,DTRQ,DX,DXCOD,DXNUM,EDTRQ,HOMPHON,I,LINE,MDTRM,NAME,OTHDIS,PCT,PG,PGHD,POP,PRINT,REQN,RO,ROHD,RONAME,RQ,SC,D,DIE,ONE,DVBCNEW,LN,FEXM,PRIO,DTB
 K SEX,SSN,STATE,TST,X,Y,Z,JI,JII,ZIP,JJ,KJX,D0,D1,DA,DI,DIC,DIPGM,DLAYGO,DQ,DWLW,HD,HD1,HD2,J,ONFILE,CTIM,JJ,C,DIZ,DPTSZ,STAT,JDT,JY,TSTDT,DIYS,EXAM,DR,REQDT,ELIG,INCMP,PRDSV,WARD,ADD1,ADD2,CNTY,PG,OLDDA,DIRUT,DUOUT
 K DVBCCNT,TNAM,DIR,TEMP,SWITCH,EDTA,RAD,EOD,%T,STATUS,XX,XDD,OLDA,OLDA1
 K DTTRNSC,ZIP4,DVBAINSF,DTT,TAD1,TAD2,TAD3,TCITY,TST,TZIP,TPHONE
 K COUNTY,PROVINCE,POSTALCD,COUNTRY
 G KILL^DVBCUTL2
 ;
DICW ;used on ^DIC lookups only
 W ! S TSTDT=$P(^(0),U,2),RO=$P(^(0),U,3),STAT=$P(^(0),U,18),RONAME=$S($D(^DIC(4,+RO,0)):$P(^(0),U,1),1:"Unknown RO") D DICW1
 W ! Q
 ;
DICW1 F JY=0:0 S JY=$O(^DVB(396.4,"C",+Y,JY)) Q:JY=""  S EXAM=$P(^DVB(396.4,+JY,0),U,3),EXAM=$S($D(^DVB(396.6,EXAM,0)):$P(^(0),U,1),1:"Unknown exam") D DICW2
 Q
 ;
DICW2 W ?3,EXAM," (",$$FMTE^XLFDT(TSTDT,"5DZ")," by ",RONAME,")",!
 Q
 ;
VARS S DTA=^DVB(396.3,DA,0),DFN=$P(DTA,U,1),(NAME,PNAM)=$P(^DPT(DFN,0),U,1),DOB=$P(^(0),U,3),SEX=$P(^(0),U,2),SSN=$P(^(0),U,9),CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown"),DTRQ=$P(DTA,U,2)
 S RO=$P(DTA,U,3),FEXM=$P(DTA,U,9) S:RO="" RO=0 S RONAME=$S($D(^DIC(4,RO,0)):$P(^(0),U,1),1:"Unknown")
 S REQN=$P(DTA,U,4),REQN=$S($D(^VA(200,+REQN,0)):$P(^(0),U,1),1:"Unknown"),OTHDIS=$P(DTA,U,11) I $D(^DVB(396.3,DA,1)) S OTHDIS1=$P(^(1),U,9),OTHDIS2=$P(^(1),U,10)
 S ZPR=$P(DTA,U,10) S PRIO="" D  S:PRIO']"" PRIO="Unknown"
 . I ZPR="T" S PRIO="Terminal" Q
 . I ZPR="P" S PRIO="Prisoner of war" Q
 . I ZPR="OS" S PRIO="Original SC" Q
 . I ZPR="ON" S PRIO="Original NSC" Q
 . I ZPR="I" S PRIO="Increase" Q
 . I ZPR="R" S PRIO="Review" Q
 . I ZPR="OTR" S PRIO="Other" Q
 . I ZPR="E" S PRIO="Inadequate exam" Q
 . I ZPR="AO" S PRIO="Agent Orange" Q
 . I ZPR="BDD" S PRIO="Ben Deliv at Disch" Q
 . I ZPR="DCS" S PRIO="DES Claimed Cond By Svcmbr" Q
 . I ZPR="DFD" S PRIO="DES Fit-For-Duty" Q
 . I ZPR="QS" S PRIO="Quick Start"
 K DVBAINSF S:ZPR="E" DVBAINSF=""
 S (ADR1,ADR2,ADR3,CITY,STATE,ZIP)=""
 I $D(^DPT(DFN,.11)) D
 .S DTA=^DPT(DFN,.11)
 .S ADR1=$P(DTA,U,1),ADR2=$P(DTA,U,2),ADR3=$P(DTA,U,3),CITY=$P(DTA,U,4)
 .S ZIP=$P(DTA,U,12) S:ZIP'="" ZIP=$S($L(ZIP)>5:$E(ZIP,1,5)_"-"_$E(ZIP,6,9),1:ZIP) I ZIP="" S ZIP="No Zip"
 .S CITY=$S(CITY]"":CITY,1:"Unknown") S STATE=$P(DTA,U,5) I STATE]"" S STATE=$S($D(^DIC(5,STATE,0)):$P(^(0),U,1),1:"Unknown")
 .S COUNTY=$P(DTA,U,7),PROVINCE=$P(DTA,U,8),POSTALCD=$P(DTA,U,9)
 .S COUNTRY=$P(DTA,U,10)
 S (HOMPHON,BUSPHON)="Unknown" I $D(^DPT(DFN,.13)) S HOMPHON=$P(^(.13),U,1),BUSPHON=$P(^(.13),U,2)
 I $D(^DPT(DFN,.121)) D   ;DVBA/126 added
 .S (DTT,TAD1,TAD2,TAD3,TCITY,TST,TZIP,TPHONE)=""
 .S DTT=^DPT(DFN,.121)
 .S TAD1=$P(DTT,U,1),TAD2=$P(DTT,U,2),TAD3=$P(DTT,U,3),TCITY=$P(DTT,U,4)
 .S TZIP=$P(DTT,U,12) S:TZIP'="" TZIP=$S($L(TZIP)>5:$E(TZIP,1,5)_"-"_$E(TZIP,6,9),1:TZIP) I TZIP="" S TZIP="No Zip"
 .S TCITY=$S(TCITY]"":TCITY,1:"Unknown") S TST=$P(DTT,U,5) I TST]"" S TST=$S($D(^DIC(5,TST,0)):$P(^(0),U,1),1:"Unknown")
 .S TPHONE=$P(DTT,U,10) S:TPHONE="" TPHONE="Unknown"
 S EDTA=$$SVC(DFN,"I"),EOD=$P(EDTA,U),RAD=$P(EDTA,U,2),Y=$S($D(^DVB(396.3,DA,1)):$P(^(1),U,7),1:"") X ^DD("DD") S LREXMDT=Y
 Q
 ;
HDR W @FF,?(IOM-$L(HD2)\2),HD2,!!!?5,"Veteran name: ",PNAM,?45,"SSN: ",SSN,!?40,"C-NUMBER: ",CNUM,!!,"Exams on this request:",!!
 S JII=""
 F JIJ=0:0 S JII=$O(^TMP($J,JII)) Q:JII=""  S XST=$P(^TMP($J,JII),U,1) W JII,", ",$S(XST="C":"Completed",XST="RX":"Cancelled by RO",XST="X":"Cancelled by MAS",XST="T":"Transferred",1:"Open"),", " I $X>30 W !
 Q
 ;
ADDR ;
 N ADD1,ADD2,ADD3,CITY,CNTY,STATE,ZIP,COUNTRY,POSTCODE,PROVINCE
 N PRDSV,ELIG,INCMP
 S (ADD1,ADD2,ADD3,CITY,CNTY,STATE,ZIP,COUNTRY,POSTCODE,PROVINCE)=""
 I $D(^DPT(DFN,.11)) S DTA=^(.11),ADD1=$P(DTA,U,1),ADD2=$P(DTA,U,2),ADD3=$P(DTA,U,3),CITY=$P(DTA,U,4),STATE=$P(DTA,U,5),ZIP=$P(DTA,U,12),CNTY=$P(DTA,U,7),PROVINCE=$P(DTA,U,8),POSTCODE=$P(DTA,U,9),COUNTRY=$P(DTA,U,10)
 W !!?0,"Address: ",?14,ADD1,!
 W:ADD2]"" ?14,ADD2,!
 W:ADD3]"" ?14,ADD3,!
 ;Functionality for USA Unique Address Output
 D:$$ISFORGN(COUNTRY)'>0 
 . S:ZIP'="" ZIP=$S($L(ZIP)>5:$E(ZIP,1,5)_"-"_$E(ZIP,6,9),1:ZIP)
 . S CNTY=$S($D(^DIC(5,+STATE,1,+CNTY,0)):$P(^(0),U,1),1:"Unknown")
 . S STATE=$S($D(^DIC(5,+STATE,0)):$P(^(0),U,1),1:"Unknown")
 . W ?0,"City:",?14,CITY,"  ",STATE,"  ",ZIP,!?0,"County:",?14,CNTY,!
 ;Functionality for Foreign Unique Address Output
 D:$$ISFORGN(COUNTRY)>0
 . I POSTCODE="" S POSTCODE="Unknown"
 . I CITY="" S CITY="Unknown"
 . I PROVINCE="" S PROVINCE="Unknown"
 . W ?0,"Postal Code:",?14,POSTCODE,!?0,"City:",?14,CITY,!?0,"Province: ",?14,PROVINCE,!
 W:COUNTRY>0 ?0,"Country:",?14,$$GETCNTRY(+COUNTRY),!
 W !
 S PRDSV=$S($D(^DPT(DFN,.32)):$P(^(.32),U,3),1:"") I PRDSV]"" S PRDSV=$P(^DIC(21,PRDSV,0),U,1)
 W "Period of service: ",PRDSV,!
 S ELIG="",INCMP=0
 W ?0,"Eligibility data:" I $D(^DPT(DFN,.36)),$P(^(.36),U,1)]"" S ELIG=$S($D(^DIC(8,+^(.36),0)):$P(^(0),U,6),1:"")
 I ELIG]"",$D(^DPT(DFN,.361)),^(.361)]"" S ELIG=ELIG_" ("_$S($P(^(.361),U,1)="P":"Pend ver",$P(^(.361),U,1)="R":"Pend re-verif",$P(^(.361),U,1)="V":"Verified",1:"Not verified")_")"
 I $D(^DPT(DFN,.29)),$P(^(.29),U,1)]"" S INCMP=1
 I $D(^DPT(DA,.293)),$P(^(.293),U,1)=1 S INCMP=1
 W ?19,ELIG_$S(ELIG]"":", ",1:"")_$S(INCMP=1:"Incompetent",1:""),!
 Q
 ;
SSNSHRT ;  ** Set SSN in the Format '123 45 6789' **
 K DVBCSSNO
 S DVBCSSNO=$E(SSN,1,3)_" "_$E(SSN,4,5)_" "_$E(SSN,6,9)
 Q
 ;
SSNOUT ;  ** Set SSN in the Format '123 45 6789 (Z6789) **
 D SSNSHRT
 S DVBCSSNO=DVBCSSNO_" ("_$E(PNAM)_$E(SSN,6,9)_")"
 Q
 ;
ISFORGN(DVBIEN)  ;  ** Is country entry foreign? **
 ;  Input:  DVBIEN - IEN of COUNTRY CODE file
 ;
 ;  Output:  Return 1 when country is foreign
 ;           Return 0 when country is not foreign
 ;           Return -1 on error
 ;
 N DVBCNTRY
 N DVBERR
 Q:$G(DVBIEN)="" -1
 S DVBCNTRY=$$GET1^DIQ(779.004,DVBIEN_",",".01","","","DVBERR")
 Q $S($D(DVBERR):-1,DVBCNTRY="USA":0,1:1)
 ;
GETCNTRY(DVBIEN)  ;  ** Get POSTAL NAME for country code **
 ;  Input:  DVBIEN - IEN of COUNTRY CODE file
 ;
 ;  Output:  Return POSTAL NAME field on success or
 ;           DESCRIPTION field when POSTAL NAME = "<NULL>";
 ;           Otherwise, return "" on failure.
 ;
 N DVBCNTRY
 N DVBERR
 N DVBIENS
 N DVBNAME
 S DVBNAME=""
 I $G(DVBIEN)'="" D
 . S DVBIENS=DVBIEN_","
 . D GETS^DIQ(779.004,DVBIENS,"1.3;2","E","DVBCNTRY","DVBERR")
 . I '$D(DVBERR) D
 . . S DVBNAME=$G(DVBCNTRY(779.004,DVBIENS,1.3,"E"))
 . . I DVBNAME="<NULL>" S DVBNAME=$$UP^XLFSTR($G(DVBCNTRY(779.004,DVBIENS,2,"E")))
 Q DVBNAME
 ;
SVC(DFN,DVBCIE) ;Retrieve Last Military Service Data Info
 ; Using supported API SVC^VAPDT, which encapsulates the
 ; Military Service Episode (MSE) changes due to the
 ; Enrollment Military Service Data Sharing (MSDS) project 
 ; (Patch DG*5.3*797)
 ; INPUT
 ;    DFN     - Patient (#2) file internal entry  number (Required)
 ;    DVBCIE  - "I" to return service dates in Fileman format (Default)
 ;              "E" to return servce dates in external format
 ; OUTPUT
 ;    Returns '^' delimitted string
 ;       1. Last Service Entry Date
 ;       2. Last Service Seperation Date
 ;       3. Last Service Branch
 ;       4. Last Service Discharge Type
 ; 
 ;Quit if DFN not greater than zero
 Q:($G(DFN)'>0) ""
 ;If DVBCIE not "I" or "E" set to default of "I"
 S:"^I^E^"'[(U_$G(DVBCIE)_U) DVBCIE="I"
 N VASV,VAHOW,VAROOT,DVBMSE
 D SVC^VADPT
 D:DVBCIE="E"  ;external Last MSE data
 . S DVBMSE=$P($G(VASV(6,4)),U,2)_"^"_$P($G(VASV(6,5)),U,2)_"^"
 . S DVBMSE=DVBMSE_$P($G(VASV(6,1)),U,2)_"^"_$P($G(VASV(6,3)),U,2)
 D:DVBCIE="I"  ;internal Last MSE data
 . S DVBMSE=$P($G(VASV(6,4)),U)_"^"_$P($G(VASV(6,5)),U)_"^"
 . S DVBMSE=DVBMSE_$P($G(VASV(6,1)),U)_"^"_$P($G(VASV(6,3)),U)
 Q DVBMSE
