SDAMQ5 ;ALB/MJK - AM Background Job/Disposition Processing ; 05/19/97
 ;;5.3;Scheduling;**24,125,374**;Aug 13, 1993
 ;
EN(SDBEG,SDEND) ; -- count dispositions
 N SDIVNM,SDT,SD0,SDDA,SDNAT,DFN,X,SDOE
 S SDT=SDBEG F  S SDT=$O(^DPT("ADIS",SDT)) Q:'SDT!(SDT>SDEND)  I $$REQ^SDM1A(.SDT)="CO" D
 .S DFN=0 F  S DFN=$O(^DPT("ADIS",SDT,DFN)) Q:'DFN  D
 ..S SDDA=0 F  S SDDA=$O(^DPT("ADIS",SDT,DFN,SDDA)) Q:'SDDA  D CHK(.DFN,.SDDA,.SDT)
ENQ Q
 ;
CHK(DFN,SDDA,SDT) ;  check dispositions
 N SDOE,SD0,SDIVNM,SDNAT,X,SDERR,SDLOC
 S SDERR=""
 G CHKQ:'$D(^DPT(DFN,"DIS",SDDA,0)) S SD0=^(0)
 I $P(SD0,U,2)=0!($P(SD0,U,2)=1),$P(SD0,U,7),$$DIV^SDAMQ(+$P(SD0,U,4),.SDIVNM,35) D
 .;CHECK INSTALL DATE FOR PATCH DG*5.3*459 IF BEFORE RELEASE DATE
 .;SEND TO ERROR CHECKER OTHERWISE SKIP. DBIA:2197
 .N SDINIEN,SDINDT,SDPCHK S SDPCHK=0
 .S SDINIEN=$O(^XPD(9.7,"B","DG*5.3*459",0)) D
 ..I SDINIEN'="" S SDINDT=$$GET1^DIQ(9.7,SDINIEN,2,"I") D
 ...I SDINDT>SDT S SDPCHK=1
 .S SDOE=$P(SD0,U,18)
 .I SDOE="" I SDPCHK S SDERR=1 G CHKERR
 .I SDOE="" Q
 .I '$D(^SCE(SDOE,0)) S SDERR=2 G CHKERR
 .S SDLOC=$P(^SCE(SDOE,0),U,4)
 .I SDLOC="" S SDERR=3 G CHKERR
 .I '$D(^PX(815,1,"DHL","B",SDLOC)) S SDERR=4 G CHKERR
 .S SDNAT='$$CO^SDAMQ(+$$GETDISP^SDVSIT2(DFN,SDT))
 .S X=$G(^TMP("SDSTATS",$J,SDIVNM,"DISP",102)),^(102)=(X+SDNAT)_U_($P(X,U,2)+1) Q
CHKERR .S ^TMP("SDSTATS",$J,SDIVNM,"DISP","ERR",SDERR,DFN,SDDA)="" Q
CHKQ Q
 ;
BULL(SDIVNM,SDLN,SDTOT) ;  build disposition section of bulletin
 N SDSTOP,NAT,GRAND,OTHER,TNAT,TGRAND
 I $D(^TMP("SDSTATS",$J,SDIVNM,"DISP","ERR")) D ERRLIST
 D HDR
 S (SDSTOP,TNAT,TGRAND)=0
 F  S SDSTOP=$O(^TMP("SDSTATS",$J,SDIVNM,"DISP",SDSTOP)) Q:'SDSTOP!(SDSTOP="ERR")  S X=^(SDSTOP) D
 .S NAT=+X,GRAND=+$P(X,U,2)
 .S TNAT=TNAT+NAT,TGRAND=TGRAND+GRAND
 .S SDTOT("DIV","NAT")=SDTOT("DIV","NAT")+NAT
 .S SDTOT("DIV","GRAND")=SDTOT("DIV","GRAND")+GRAND
 D LINE^SDAMQ3("Dispositions",TNAT,TGRAND)
BULLQ Q
 ;
HDR ;  header for disposition section of bulletin
 D SET^SDAMQ3("")
 D SET^SDAMQ3("                                       Dispositions")
 D SET^SDAMQ3("                                       Requiring Action      Total     Pct.")
 D SET^SDAMQ3("                                       ----------------    -------   -------")
 Q
ERRLIST ;  if disposition errors, add to bulletin
 I $D(^TMP("SDSTATS",$J,SDIVNM,"DISP","ERR",1)) D SHOWIT(1)
 I $D(^TMP("SDSTATS",$J,SDIVNM,"DISP","ERR",2)) D SHOWIT(2)
 I $D(^TMP("SDSTATS",$J,SDIVNM,"DISP","ERR",3)) D SHOWIT(3)
 I $D(^TMP("SDSTATS",$J,SDIVNM,"DISP","ERR",4)) D SHOWIT(4)
 Q
SHOWIT(SDERR) ; add disposition errors to bulletin
 N SDDFN,SDDI,SDPAT,Y
 D SET^SDAMQ3("")
 D SET^SDAMQ3($P($T(HEADERS+SDERR),"^",2))
 D SET^SDAMQ3("                             (not included in totals)")
 D SET^SDAMQ3("                       -------------------------------------")
 S SDDFN=""
 F  S SDDFN=$O(^TMP("SDSTATS",$J,SDIVNM,"DISP","ERR",SDERR,SDDFN)) Q:'SDDFN  D
 .S SDDI=""
 .F  S SDDI=$O(^TMP("SDSTATS",$J,SDIVNM,"DISP","ERR",SDERR,SDDFN,SDDI)) Q:'SDDI  D
 ..S SDPAT=$P(^DPT(SDDFN,0),U,1),Y=(9999999-SDDI) D DD^%DT
 ..D SET^SDAMQ3("                       "_SDPAT_"   "_Y)
 Q
HEADERS ;  text for message headers
 ;;^            **** Disposition without encounter pointer: ****
 ;;^     **** Disposition points to non-existent encounter: ****
 ;;^                       **** Disposition clinic missing: ****
 ;;^               **** Disposition clinic not in file 815: ****
 ;
