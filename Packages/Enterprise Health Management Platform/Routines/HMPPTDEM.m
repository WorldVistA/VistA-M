HMPPTDEM  ;ASMR/EJK,JD - File Patient Demographic Information passed via RPC ; 09/16/2014
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Oct 10, 2014;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; RPC = HMP WRITEBACK PT DEM
 ;
 ; *** NOTES ***
 ; Return variable must be an ARRAY
 ; A success MUST be sent as a 1
 ; A failure may take any form
 ; *************
 ;
 Q  ;Must come in at a tag.
 ;
FILE(RSP,HMPDEM) ;File Patient Demographic information.
 ;Inbound data layout:
 ; "^" delimited
 ; Piece 1: DFN
 ; Piece 2: Home Phone Number - ^DD(2,.131 - ^DPT(DFN,.13) piece 1
 ; Piece 3: Cell Phone Number - ^DD(2,.134 - ^DPT(DFN,.13) piece 4
 ; Piece 4: Work Phone Number - ^DD(2,.132 - ^DPT(DFN,.13) piece 2
 ; Piece 5: Emergency Phone Number - ^DD(2,.339 - ^DPT(DFN,.33) piece 9
 ; Piece 6: NOK Phone Number - ^DD(2,.219 - ^DPT(DFN,.21) piece 9
 ;
 ; If a piece contains -1, it means DELETE it
 ; If a piece is null, it means LEAVE it ALONE
 ; If a piece is not -1 and not null, it means UPDATE it
 ; 
 ;D BEFORE  ; testing ONLY
 D PROC
 ;D AFTER  ; testing ONLY
 Q
 ;
PROC ;
 N HMPDFN,HMPHPN,HMPCPN,HMPWPN,HMPEPN,HMPNPN,RSPCNT
 N HMPER,HMPX
 K HMPX
 S RSPCNT=0,HMPER=""
 S HMPDFN=$P(HMPDEM,"^",1)
 S HMPHPN=$P(HMPDEM,"^",2)
 S HMPCPN=$P(HMPDEM,"^",3)
 S HMPWPN=$P(HMPDEM,"^",4)
 S HMPEPN=$P(HMPDEM,"^",5)
 S HMPNPN=$P(HMPDEM,"^",6)
 S DA=HMPDFN
 K RSP
 S RSP(0)=1 ;"Writeback was successful"  ; default to good news!
 I HMPDFN']"" S RSP(0)="No DFN" Q
 I '$D(^DPT(HMPDFN)) S RSP(0)="Patient does not exist.  DFN: "_HMPDFN Q  ;ICR 10035 DE2818 ASF 11/12/15
 I $$GET1^DIQ(2,HMPDFN_",",.331)']"",HMPEPN]"" S RSP(0)="Setting EM CO PH w/o EM CO Name" Q
 I $$GET1^DIQ(2,HMPDFN_",",.211)']"",HMPNPN]"" S RSP(0)="Setting NOK PH w/o NOK Name" Q
 S HMPX(2,DA_",",.131)=$S(HMPHPN=-1:"",HMPHPN="":$$GET1^DIQ(2,HMPDFN_",",.131),1:HMPHPN)
 S HMPX(2,DA_",",.132)=$S(HMPWPN=-1:"",HMPWPN="":$$GET1^DIQ(2,HMPDFN_",",.132),1:HMPWPN)
 S HMPX(2,DA_",",.134)=$S(HMPCPN=-1:"",HMPCPN="":$$GET1^DIQ(2,HMPDFN_",",.134),1:HMPCPN)
 S HMPX(2,DA_",",.219)=$S(HMPNPN=-1:"",HMPNPN="":$$GET1^DIQ(2,HMPDFN_",",.219),1:HMPNPN)
 S HMPX(2,DA_",",.339)=$S(HMPEPN=-1:"",HMPEPN="":$$GET1^DIQ(2,HMPDFN_",",.339),1:HMPEPN)
 D UPDATE^DIE(,"HMPX",,"HMPER")
 I HMPER]"" S RSP(0)=HMPER
 Q
BEFORE ;
 S DFN=$P(HMPDEM,"^",1)
 K HPN,CPN,WPN,EPN,NPN,PTNAME
 S (HPN,CPN,WPN,EPN,NPN)=""
 S PTNAME=$$GET1^DIQ(2,DFN_",",.01,"E")
 S HPN=$$GET1^DIQ(2,DFN_",",.131,"E")
 S CPN=$$GET1^DIQ(2,DFN_",",.134,"E")
 S WPN=$$GET1^DIQ(2,DFN_",",.132,"E")
 S EPN=$$GET1^DIQ(2,DFN_",",.339,"E")
 S NPN=$$GET1^DIQ(2,DFN_",",.219,"E")
 U 0 W "Patient: "_PTNAME,!
 U 0 W "Before executing input string:",!
 U 0 W ?5,"Home Phone: "_HPN,!
 U 0 W ?5,"Cell Phone: "_CPN,!
 U 0 W ?5,"Work Phone: "_WPN,!
 U 0 W ?5,"Emergency Phone: "_EPN,!
 U 0 W ?5,"NOK Phone: "_NPN,!!
 Q
AFTER ;
 S (HPN,CPN,WPN,EPN,NPN)=""
 S PTNAME=$$GET1^DIQ(2,DFN_",",.01,"E")
 S HPN=$$GET1^DIQ(2,DFN_",",.131,"E")
 S CPN=$$GET1^DIQ(2,DFN_",",.134,"E")
 S WPN=$$GET1^DIQ(2,DFN_",",.132,"E")
 S EPN=$$GET1^DIQ(2,DFN_",",.339,"E")
 S NPN=$$GET1^DIQ(2,DFN_",",.219,"E")
 U 0 W "After executing input string:",!
 U 0 W "Patient: "_PTNAME,!
 U 0 W ?5,"Home Phone: "_HPN,!
 U 0 W ?5,"Cell Phone: "_CPN,!
 U 0 W ?5,"Work Phone: "_WPN,!
 U 0 W ?5,"Emergency Phone: "_EPN,!
 U 0 W ?5,"NOK Phone: "_NPN
 Q
