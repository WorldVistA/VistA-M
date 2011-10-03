RALWKL ;HISC/GJC AISC/MJK,RMO-Workload Reports By Functional Area ;4/12/96  07:54
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
SUM S X=$L(RATITLE)+$L(" Workload Report:")+1
 S $P(RALN1,"-",X)="" K DIR
 W @IOF,!?3,RATITLE," Workload Report:",!?3,RALN1,!
 S DIR(0)="YA",DIR("A")="Do you wish only the summary report? ",DIR("B")="No"
 S DIR("?")="Enter 'Yes' for a summary report, or 'No' for a detailed report."
 D ^DIR K DIR I $D(DIRUT) D PURGE^RALWKL2 Q
 S RASUM=+Y ; if 'RASUM no summary rpt, else summary rpt
 K DIROUT,DIRUT,DTOUT,DUOUT
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0) S RAPSTX=""
 K ^TMP($J,"RA"),^TMP($J,"RA1"),^TMP($J,"RAFLD") S RAXIT=0
 S X=$$DIVLOC^RAUTL7() I X D PURGE^RALWKL2 Q
 W ! D ONE^RALWKL3(RAFILE)
 I '$D(^TMP($J,"RAFLD")) W ! D SELECT^RALWKL3
 I RAXIT D PURGE^RALWKL2 Q
 D ZEROUT^RALWKL2 ; Zero out totals for division and imaging type
 D DATE^RAUTL
 I RAPOP D PURGE^RALWKL2 Q
 D DISPXAM^RALWKL1(RACRT)
 I RAXIT D PURGE^RALWKL2 Q
DEV ; Save off variables, select a device
 S ZTRTN="START^RALWKL" S:$D(RAFL) ZTSAVE("RAFL*")=""
 S ZTSAVE("^TMP($J,""RA"",")=""
 S ZTSAVE("^TMP($J,""RAFLD"",")=""
 S ZTSAVE("^TMP($J,""RA D-TYPE"",")=""
 S ZTSAVE("^TMP($J,""RA I-TYPE"",")=""
 F RASV="BEGDATE","ENDDATE","RAFILE","RAPCE","RATITLE","RACRT(","RASUM","RAXIT","RAINPUT","RADIFLG(" S ZTSAVE(RASV)=""
 W ! D ZIS^RAUTL
 I RAPOP D PURGE^RALWKL2 Q
START ; Start the sorting/storing process
 U IO S RABEG=BEGDATE-.0001,RAEND=ENDDATE+.9999
 S:$D(ZTQUEUED) ZTREQ="@"
 I RAINPUT=0 S RAFLDCNT=0,RALP="" F  S RALP=$O(^TMP($J,"RAFLD",RALP)) Q:RALP=""  S RAFLDCNT=RAFLDCNT+1
 K RALP
 F RADTE=RABEG:0:RAEND S RADTE=$O(^RADPT("AR",RADTE)) Q:RADTE'>0!(RADTE>RAEND)  D  Q:RAXIT
 . F RADFN=0:0 S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:RADFN'>0  D RADTI Q:RAXIT
 . Q
 D:'RAXIT EN1^RALWKL1
 D PURGE^RALWKL2
 Q
RADTI ; Traverse the Registered Exam multiple
 S RADTI=0
 F  K RAOR,RABILAT,RAPORT S RADTI=$O(^RADPT("AR",RADTE,RADFN,RADTI)) Q:RADTI'>0  D  Q:RAXIT
 . I $D(^RADPT(RADFN,"DT",RADTI,0)) S RAD0=$G(^(0)) D RACNI
 . Q
 Q
RACNI ; Traverse the Examinations multiple
 S RADIV=+$P(RAD0,"^",3),RADIV=+$P($G(^RA(79,RADIV,0)),"^"),RADIV=$S($D(^DIC(4,+RADIV,0)):+RADIV,1:99)
 S RADIVNME=$S($D(^DIC(4,RADIV,0)):$P(^(0),U,1),1:"Unknown")
 Q:'$D(^TMP($J,"RA D-TYPE",RADIVNME))  S RACNI=0
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D  Q:RAXIT
 . I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S RAP0=$G(^(0)) D
 .. I $D(RACRT(+$P(RAP0,"^",3))) D
 ... S B=$G(RACRT(+$P(RAP0,"^",3))) D IT^RALWKL2 S RAIMG=$S(B1?3AP1"-".N:B1,1:"") D:RAIMG]"" CHK^RALWKL3
 ... Q
 .. Q
 . Q
 Q
PRC ; Procedure checks
 I +RAZ=25 S RAOR="" Q
 I +RAZ=26 S RAPORT="" Q
 S:$P(RAZ,"^",3)="Y" RABILAT="" F J=1:1 I '$D(RAMIS(J)) S RAMIS(J)=$S(RAMJ]"":+RAZ,1:99),RAWT(J)=+$P(RAMJ,"^",2),RAMUL(J)=$S(+$P(RAZ,"^",2)>0:+$P(RAZ,U,2),1:1) S:$D(RABILAT)&(RAMUL(J)<2) RAMUL(J)=RAMUL(J)*2 S:J>1 RAMULP="" Q
 K RABILAT
 Q
 ;
AUX ;
 I '$D(^TMP($J,"RA",RADIV,RAIMG,RAFLD,A,RAPRC)) D
 . S ^TMP($J,"RA",RADIV,RAIMG,RAFLD,A,RAPRC)="0^0^0^0^0"
 S X=$G(^TMP($J,"RA",RADIV,RAIMG,RAFLD,A,RAPRC))
 S $P(X,"^",C)=$P(X,"^",C)+RANUM,$P(X,"^",5)=$P(X,"^",5)+RAWT
 S ^TMP($J,"RA",RADIV,RAIMG,RAFLD,A,RAPRC)=X
 Q
WARD ; Ward Report Entry Point
 S ZTDESC="Rad/Nuc Med Functional Area Ward Rpt."
 S RAFILE="DIC(42,",RACRT=5,RAPCE=6,RATITLE="Ward",RAFL="" G RALWKL
 ;
SERV ; Service Report Entry Point
 S ZTDESC="Rad/Nuc Med Functional Area Service Rpt."
 S RAFILE="DIC(49,",RACRT=3,RAPCE=7,RATITLE="Service",RAFL="" G RALWKL
 ;
BEDSEC ; PTF Bedsection Report Entry Point
 S ZTDESC="Rad/Nuc Med Functional Area PTF Bedsection Rpt."
 S RAFILE="DIC(42.4,",RACRT=2,RAPCE=19,RATITLE="PTF Bedsection",RAFL="" G RALWKL
 ;
CLINIC ; Clinic Report Entry Point
 S ZTDESC="Rad/Nuc Med Functional Area Clinic Rpt."
 S RAFILE="SC(",RACRT=1,RAPCE=8,RATITLE="Clinic",RAFL="" G RALWKL
 ;
SHAR ; Sharing Agreement/Contract Report Entry Point
 S ZTDESC="Rad/Nuc Med Functional Area Sharing Agreement/Contract Rpt."
 S RAFILE="DIC(34,",RACRT=4,RAPCE=9,RATITLE="Sharing/Contract",RAFL="" G RALWKL
