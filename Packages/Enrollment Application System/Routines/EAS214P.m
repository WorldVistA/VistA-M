EAS214P  ;ATL/JPN, - eGate - Post install to add logical links into the system ; 21 Dec 2021 12:58 PM
 ;;1.0;Enrollments Application System;**214**;2-14-2022;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
EN ;Entry point
 N EASADDR,EASLLIEN,EASTEST,EASPORT,EASSLLN,EASLLO,EASSTAT,J,X
 ;
 S EASTEST=$S($$PROD^XUPROD:0,1:1) ;value of 1 indicates test system
 ;
 ;Station number
 S EASSTAT=$P($$SITE^VASITE,"^",3)
 ;
 ;Only set the TCP/IP port number if installing in production environment.
 ;Port will be null if installing in test environment.
 S EASPORT="" S:'EASTEST EASPORT=7300
 ;
 ;Loop through tag DATA to find station number, get TCP/IP address corresponding to VDIF regional server
 F J=1:1 S X=$T(DATA+J) Q:'$P(X,";",3)  I EASSTAT=$P(X,";",3) S EASADDR=$P(X,";",4) Q
 ;
 ;If station number was not in the list, display error message and quit
 I $G(EASADDR)="" D BMES^XPDUTL("Unable to find TCP/IP Address for station number ("_EASSTAT_"). Contact support.")
 ;
 ;Do not set TCP/IP address if installing in test environment. Set to null after checking for Station number not found.
 S:EASTEST EASADDR=""
 ;
 ;New logical link name is EASLLZ09, used for VistA event Z09 communication with VDIF regional server.
 S EASSLLN="EASLLZ09"
 ;
 ;Create or update logical link, function returns new logical link ien or error
 S EASLLIEN=$$SETLL16(EASSLLN,$G(EASADDR),$G(EASPORT))
 ;
 ;Add the new logical link to existing protocol
 D PROTOCOL(EASLLIEN,EASSTAT)
 ;
 Q
 ;
SETLL16(EASSLLN,EASADDR,EASPORT) ;
 ;Input EASSLLN = Logical Link Name (ex. "LL HEC 500") (required)
 ; EASADDR = TCP/IP Address (optional, defaults null)
 ; EASPORT = TCP/IP Port # (optional, defaults to null)
 ;
 ;Purpose: Create or update a Logical Link for TCP/IP transmissions, HL7 event Z09
 ;
 N EASDATA,EASERR,EASIEN,EASRTN,EASOLD
 S EASADDR=$G(EASADDR),EASPORT=$G(EASPORT)
 ;
 ;Set up array of data to file
 S EASDATA(870,"?+1,",.01)=EASSLLN                          ;LOGICAL LINK NAME
 S EASDATA(870,"?+1,",2)=$O(^HLCS(869.1,"B","TCP",0)) ;LLP TYPE, TCP
 S EASDATA(870,"?+1,",3)="NC"                               ;QUEUE TYPE, NC=NON-PERSISTENT CLIENT
 S EASDATA(870,"?+1,",4.5)=1 ;AUTOSTART ENABLED
 S EASDATA(870,"?+1,",21)=10 ;QUEUE SIZE
 S EASDATA(870,"?+1,",200.02)=3 ;RE-TRANSMISSION ATTEMPTS
 S EASDATA(870,"?+1,",200.021)="R"                          ;EXCEED RE-TRANSMISSION, R=RESTART
 S EASDATA(870,"?+1,",200.04)=90 ;READ TIMEOUT
 S EASDATA(870,"?+1,",200.05)=270 ;ACK TIMEOUT
 S EASDATA(870,"?+1,",400.01)=EASADDR                       ;TCP/IP ADDRESS
 S EASDATA(870,"?+1,",400.02)=EASPORT                       ;TCP/IP PORT
 S EASDATA(870,"?+1,",400.03)="C"                           ;TCP/IP SERVICE TYPE, C=CLIENT(SENDER)
 S EASDATA(870,"?+1,",400.04)="N"                           ;PERSISTENT, N=NO
 S EASDATA(870,"?+1,",400.06)=""                            ;STARTUP NODE
 S EASDATA(870,"?+1,",14)=1 ;SHUTDOWN
 ;
 ;File new entry
 D UPDATE^DIE("","EASDATA","EASIEN","EASERR")
 ;
 ;Return new logical link ien if successful,otherwise return -1.
 ;
 S EASRTN=+$G(EASIEN(1))
 S:$D(EASERR)!(+EASRTN=0) EASRTN=-1
 ;
 I +EASRTN<0 D BMES^XPDUTL("Unable to create "_EASSLLN_", contact support.") Q EASRTN
 I EASTEST D BMES^XPDUTL("Test Environment, TCP/IP address and port omitted from logical link "_EASSLLN_".") Q EASRTN
 D BMES^XPDUTL("Logical link "_EASSLLN_" successfully updated.")
 Q EASRTN
 ;
PROTOCOL(EASLLIEN,EASSTAT) ;
 ;Input EASLLIEN = Logical Link IEN
 ; EASSTAT = Station number
 ;
 ;Purpose: Use the new logical link in an existing protocol
 ;
 N DA,DIE,DR,LLOLD,PIEN,PNAME
 ;
 ;For each protocol, update the logical link
 S PNAME="EAS EDB ORU-Z09 CLIENT"
 ;Get IEN for protocol 
 S PIEN=$$FIND1^DIC(101,,"B",PNAME)
 I +PIEN'>0 D BMES^XPDUTL("Unable to update logical link in protocol "_PNAME_", contact support") Q
 ;
 ;Get the original logical link
 S LLOLD=$$LNAME(PNAME)
 ;and save it to ^XTMP for possible uninstall.
 D SETL(LLOLD)
 ;
 ;Update the logical link
 S DR=770.7_"////"_EASLLIEN,DIE=101,DA=PIEN D ^DIE
 D:LLOLD'="EASLLZ09"
 . D BMES^XPDUTL("Logical link changed in "_PNAME)
 . D MES^XPDUTL("Old: "_LLOLD)
 . D MES^XPDUTL("New: EASLLZ09")
  Q
 ;
LNAME(EASP) ;link name
 N EASIENS,EASERR
 S EASP=$$FIND1^DIC(101,,"AB",EASP)
 S EASIENS=EASP_","
 Q $$GET1^DIQ(101,EASIENS,770.7,,,"EASERR")
 ;
SETL(EASVAL,EASTTL) ;set link (uninstall data)
 S EASTTL=+$G(EASTTL,30) ;default to 30 days
 S ^XTMP("EAS214U",0)=DT_U_$$FMADD^XLFDT(DT,EASTTL)_U_"uninstall data for EAS*1*214"
 S ^XTMP("EAS214U",1)=$G(EASVAL)
 Q
 ;
DATA  ; format ;;site#;TCP/IP address (TCP/IP address will be used in new Logical Link, variable EASADDR)
 ;;358;hc-vdif-r01-01.domain.ext
 ;;459;hc-vdif-r01-01.domain.ext
 ;;463;hc-vdif-r01-01.domain.ext
 ;;504;hc-vdif-r01-01.domain.ext
 ;;519;hc-vdif-r01-01.domain.ext
 ;;531;hc-vdif-r01-01.domain.ext
 ;;570;hc-vdif-r01-01.domain.ext
 ;;612;hc-vdif-r01-01.domain.ext
 ;;640;hc-vdif-r01-01.domain.ext
 ;;648;hc-vdif-r01-01.domain.ext
 ;;653;hc-vdif-r01-01.domain.ext
 ;;654;hc-vdif-r01-01.domain.ext
 ;;663;hc-vdif-r01-01.domain.ext
 ;;668;hc-vdif-r01-01.domain.ext
 ;;687;hc-vdif-r01-01.domain.ext
 ;;691;hc-vdif-r01-01.domain.ext
 ;;692;hc-vdif-r01-01.domain.ext
 ;;437;hc-vdif-r02-01.domain.ext
 ;;438;hc-vdif-r02-01.domain.ext
 ;;502;hc-vdif-r02-01.domain.ext
 ;;520;hc-vdif-r02-01.domain.ext
 ;;537;hc-vdif-r02-01.domain.ext
 ;;549;hc-vdif-r02-01.domain.ext
 ;;556;hc-vdif-r02-01.domain.ext
 ;;564;hc-vdif-r02-01.domain.ext
 ;;568;hc-vdif-r02-01.domain.ext
 ;;578;hc-vdif-r02-01.domain.ext
 ;;580;hc-vdif-r02-01.domain.ext
 ;;585;hc-vdif-r02-01.domain.ext
 ;;586;hc-vdif-r02-01.domain.ext
 ;;589;hc-vdif-r02-01.domain.ext
 ;;598;hc-vdif-r02-01.domain.ext
 ;;607;hc-vdif-r02-01.domain.ext
 ;;618;hc-vdif-r02-01.domain.ext
 ;;623;hc-vdif-r02-01.domain.ext
 ;;626;hc-vdif-r03-01.domain.ext
 ;;629;hc-vdif-r02-01.domain.ext
 ;;635;hc-vdif-r02-01.domain.ext
 ;;636;hc-vdif-r02-01.domain.ext
 ;;656;hc-vdif-r02-01.domain.ext
 ;;657;hc-vdif-r02-01.domain.ext
 ;;667;hc-vdif-r02-01.domain.ext
 ;;671;hc-vdif-r02-01.domain.ext
 ;;674;hc-vdif-r02-01.domain.ext
 ;;676;hc-vdif-r02-01.domain.ext
 ;;695;hc-vdif-r02-01.domain.ext
 ;;740;hc-vdif-r02-01.domain.ext
 ;;506;hc-vdif-r03-01.domain.ext
 ;;508;hc-vdif-r03-01.domain.ext
 ;;509;hc-vdif-r03-01.domain.ext
 ;;515;hc-vdif-r03-01.domain.ext
 ;;516;hc-vdif-r03-01.domain.ext
 ;;517;hc-vdif-r03-01.domain.ext
 ;;521;hc-vdif-r03-01.domain.ext
 ;;534;hc-vdif-r03-01.domain.ext
 ;;538;hc-vdif-r03-01.domain.ext
 ;;539;hc-vdif-r03-01.domain.ext
 ;;541;hc-vdif-r03-01.domain.ext
 ;;544;hc-vdif-r03-01.domain.ext
 ;;546;hc-vdif-r03-01.domain.ext
 ;;548;hc-vdif-r03-01.domain.ext
 ;;550;hc-vdif-r03-01.domain.ext
 ;;552;hc-vdif-r03-01.domain.ext
 ;;553;hc-vdif-r03-01.domain.ext
 ;;557;hc-vdif-r03-01.domain.ext
 ;;558;hc-vdif-r03-01.domain.ext
 ;;565;hc-vdif-r03-01.domain.ext
 ;;573;hc-vdif-r03-01.domain.ext
 ;;581;hc-vdif-r03-01.domain.ext
 ;;583;hc-vdif-r03-01.domain.ext
 ;;590;hc-vdif-r03-01.domain.ext
 ;;596;hc-vdif-r03-01.domain.ext
 ;;603;hc-vdif-r03-01.domain.ext
 ;;610;hc-vdif-r03-01.domain.ext
 ;;614;hc-vdif-r03-01.domain.ext
 ;;619;hc-vdif-r03-01.domain.ext
 ;;621;hc-vdif-r03-01.domain.ext
 ;;637;hc-vdif-r03-01.domain.ext
 ;;652;hc-vdif-r03-01.domain.ext
 ;;655;hc-vdif-r03-01.domain.ext
 ;;658;hc-vdif-r03-01.domain.ext
 ;;659;hc-vdif-r03-01.domain.ext
 ;;672;hc-vdif-r03-01.domain.ext
 ;;673;hc-vdif-r03-01.domain.ext
 ;;675;hc-vdif-r03-01.domain.ext
 ;;679;hc-vdif-r03-01.domain.ext
 ;;757;hc-vdif-r03-01.domain.ext
 ;;460;hc-vdif-r04-01.domain.ext
 ;;503;hc-vdif-r04-01.domain.ext
 ;;512;hc-vdif-r04-01.domain.ext
 ;;529;hc-vdif-r04-01.domain.ext
 ;;540;hc-vdif-r04-01.domain.ext
 ;;542;hc-vdif-r04-01.domain.ext
 ;;562;hc-vdif-r04-01.domain.ext
 ;;595;hc-vdif-r04-01.domain.ext
 ;;613;hc-vdif-r04-01.domain.ext
 ;;642;hc-vdif-r04-01.domain.ext
 ;;646;hc-vdif-r04-01.domain.ext
 ;;688;hc-vdif-r04-01.domain.ext
 ;;693;hc-vdif-r04-01.domain.ext
 ;;436;hc-vdif-r01-02.domain.ext
 ;;442;hc-vdif-r01-02.domain.ext
 ;;501;hc-vdif-r01-02.domain.ext
 ;;554;hc-vdif-r01-02.domain.ext
 ;;575;hc-vdif-r01-02.domain.ext
 ;;593;hc-vdif-r01-02.domain.ext
 ;;600;hc-vdif-r01-02.domain.ext
 ;;605;hc-vdif-r01-02.domain.ext
 ;;644;hc-vdif-r01-02.domain.ext
 ;;649;hc-vdif-r01-02.domain.ext
 ;;660;hc-vdif-r01-02.domain.ext
 ;;662;hc-vdif-r01-02.domain.ext
 ;;664;hc-vdif-r01-02.domain.ext
 ;;666;hc-vdif-r01-02.domain.ext
 ;;678;hc-vdif-r01-02.domain.ext
 ;;741;hc-vdif-r01-02.domain.ext
 ;;756;hc-vdif-r01-02.domain.ext
 ;;402;hc-vdif-r04-02.domain.ext
 ;;405;hc-vdif-r04-02.domain.ext
 ;;518;hc-vdif-r04-02.domain.ext
 ;;523;hc-vdif-r04-02.domain.ext
 ;;526;hc-vdif-r04-02.domain.ext
 ;;528;hc-vdif-r04-02.domain.ext
 ;;561;hc-vdif-r04-02.domain.ext
 ;;608;hc-vdif-r04-02.domain.ext
 ;;620;hc-vdif-r04-02.domain.ext
 ;;630;hc-vdif-r04-02.domain.ext
 ;;631;hc-vdif-r04-02.domain.ext
 ;;632;hc-vdif-r04-02.domain.ext
 ;;650;hc-vdif-r04-02.domain.ext
 ;;689;hc-vdif-r04-02.domain.ext
 ;;
 ;;site#;TCP/IP address
 Q
 ;
