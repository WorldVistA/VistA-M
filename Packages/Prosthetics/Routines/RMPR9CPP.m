RMPR9CPP ;HOIFO/SPS - CHECK IF PATIENT IN FILE 665  ;JAN 2003
 ;;3.0;PROSTHETICS;**75**;Feb 09, 1996;Build 25
 ;
 Q
B1(RMPRDFN) G B2
EN1(RESULTS,RMPRDFN) ;broker entry point
B2 ;
 ;S RMPRDFN=$P(^RMPR(668,RMPR668,0),U,2)
 I '$D(^RMPR(665,RMPRDFN,0)) S RESULTS(0)="1^Patient not defined in PROSTHETICS PATIENT FILE please use the option: AP     Add/Edit Patient to Prosthetics and try again." Q
 E  S RESULTS(0)=0
 Q
 ;END
