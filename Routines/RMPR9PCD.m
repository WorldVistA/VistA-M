RMPR9PCD ;HOIFO/HNC - PURCHASE ORDER CHECK PA AUTHORIZATION ;JAN 2003
 ;;3.0;PROSTHETICS;**90**;Feb 09, 1996
 ;
 Q
B1(DUZ,SITE,RMPR668) G B2
EN1(RESULTS,DUZ,SITE,RMPR668) ;broker entry point
B2      ;
 I '$D(^PRC(440.5,"H",DUZ)),'$D(^PRC(440.5,"C",DUZ)) S RESULTS(0)="1^You are not an authorized Purchase Card User, CONTACT FISCAL!"
 S RMPRDFN=$P(^RMPR(668,RMPR668,0),U,2)
 I '$D(^RMPR(665,RMPRDFN,0)) S RESULTS(0)="1^Patient not defined in PROSTHETICS PATIENT FILE please use the option: AP     Add/Edit Patient to Prosthetics and try again." Q
 S (RMPRWHO,RMPRSC)="",(LINE,ALL)=0
 S RMPRSC=$O(^RMPR(669.9,"PA",DUZ,RMPRSC)) Q:RMPRSC=""  D
 . I '$D(^RMPR(669.9,RMPRSC,0)) Q
 . I '$D(^RMPR(669.9,RMPRSC,5,"B",DUZ)) Q
 . S RMPRWHO=$O(^RMPR(669.9,RMPRSC,5,"B",DUZ,""))
 I RMPRWHO="" S RESULTS(0)="1^User Not Defined in Site Parmeters File." Q
 S PPASSN=$P($G(^VA(200,DUZ,1)),U,9)
 I PPASSN="" S RESULTS(0)="1^User Does Not have an SSN in File 200." Q
 ;
 D NOW^%DTC
 K DD,DO
 ;purchasing agent SSN
 S $P(RESULTS(0),U,1)=PPASSN
 S $P(RESULTS(0),U,2)=RMPRWHO
 S $P(RESULTS(0),U,3)=RMPRDFN
 Q
EXIT ;common exit point
 ;END
