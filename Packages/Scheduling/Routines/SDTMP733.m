SDTMP733 ;;MS/PB - TMP POST INSTALL;SEP 16, 2019
 ;;5.3;Scheduling;**733**;SEP 16, 2019;Build 72
 ;Post install routine to create new indexes in Patch SD*5.3*704
 ;This routine will be deleted at the end of the install
 ;by the KIDS install process
 Q
ATMP1 ; Changes the execution to be at the record level and not the field level.
 ;Q:$O(^DD("IX","BB",44,"ATMP1",0))
 N SDTMPX,SDTMPY
 S SDTMPX("FILE")=44,SDTMPX("NAME")="ATMP1"
 I $O(^DD("IX","BB",SDTMPX("FILE"),SDTMPX("NAME"),0)) D DELIXN^DDMOD(SDTMPX("FILE"),SDTMPX("NAME"))
 S SDTMPX("TYPE")="MU",SDTMPX("USE")="A"
 S SDTMPX("EXECUTION")="R",SDTMPX("ACTIVITY")="IR"
 S SDTMPX("SHORT DESCR")="TMP HL7"
 S SDTMPX("DESCR",1)="The Tele Health Management Platform (TMP) application"
 S SDTMPX("DESCR",2)="allows users to schedule and cancel appointments in VistA."
 S SDTMPX("DESCR",3)="TMP needs to be kept up to date with specific clinic"
 S SDTMPX("DESCR",4)="information in order to be able to accurately display"
 S SDTMPX("DESCR",5)="clinic information."
 S SDTMPX("DESCR",6)=""
 S SDTMPX("DESCR",7)="This index will trigger an update to be sent to the TMP"
 S SDTMPX("DESCR",8)="platform via HL7 when one of the fields below is edited for"
 S SDTMPX("DESCR",9)="a tele health clinic or if a new tele health clinic is"
 S SDTMPX("DESCR",10)="added. Tele health clinics are identified by either the"
 S SDTMPX("DESCR",11)="Stop Code Number (primary stop code) or the Credit Stop"
 S SDTMPX("DESCR",12)="Code (secondary stop code)."
 S SDTMPX("DESCR",13)=""
 S SDTMPX("DESCR",14)="Name (#.01) Stop Code Number (#8) Credit Stop Code (#2504)"
 S SDTMPX("DESCR",15)="Service (#9) Treating Specialty (#9.5) Overbooks/Day"
 S SDTMPX("DESCR",16)="Maximum (#1918) Inactivate Date (#2505) Reactivate Date"
 S SDTMPX("DESCR",17)="(#2506)."
 S SDTMPX("SET CONDITION")="S X=X1(1)'=""""!X1(2)'=""""!X1(3)'=""""!X1(4)'=""""!X1(5)'=""""!X1(6)'=""""!X1(7)'=""""!X1(8)'=""""!X1(9)'="""""
 S SDTMPX("SET")="D EN^SDTMPHLB(DA)"
 S SDTMPX("KILL")="Q"
 ;S SDTMPX("WHOLE KILL")="Q"
 S SDTMPX("VAL",1)=.01 ;Name
 S SDTMPX("VAL",2)=8 ;Stop Code Number
 S SDTMPX("VAL",3)=2503 ;Credit Stop Code
 S SDTMPX("VAL",4)=9.5 ;Treating Specialty
 S SDTMPX("VAL",5)=9 ;Service
 S SDTMPX("VAL",6)=16 ;Default Provider
 S SDTMPX("VAL",7)=1918 ;Overbooks/Day Maximum
 S SDTMPX("VAL",8)=2505 ;Inactive date
 S SDTMPX("VAL",9)=2506 ;Reactivate date
 D CREIXN^DDMOD(.SDTMPX,"",.SDTMPY) ;SDTMPY=ien^name of index
 I +$G(SDTMPY)>0 N IEN S IEN=+SDTMPY,^DD("IX",IEN,"NOREINDEX")=1
 Q
 ;
