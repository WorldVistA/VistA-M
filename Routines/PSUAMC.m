PSUAMC ;BIR/DAM - Combined AMIS Summary Report:21 APR 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**9**;MARCH, 2005;Build 6
 ;
 ;This routine creates a combined AMIS summary report when
 ;the following extracts are run either by the automatic
 ;monthly extract or manual selection
 ; 1. IV extract
 ; 2. UD extract
 ; 3. AR/WS extract
 ; 4. Prescription extract
 ; 6. CS extract
 ;
 ;
EN ;Entry point.  Called from ^PSUCSR2
 ;
 K AMIS
 ;
 S Y=PSUSDT\1 X ^DD("DD") S PSUDTS=Y ;    start date
 S Y=PSUEDT\1 X ^DD("DD") S PSUDTE=Y ;    end date
 ; * PSU*4*9 - RESET THE PARENT FACILITY
 S X=PSUSNDR,DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 K DIC,DIC(0),D
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
        ;
 S AMIS(1,1)="Monthly AMIS Summary for "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 S AMIS(1,2)=""
 S AMIS(1,3)=""
 ;
 M AMIS(2)=^XTMP("PSU_"_PSUJOB,"OPCOMBO")
 ;
 M AMIS(3)=^XTMP("PSU_"_PSUJOB,"UDCOMBO")
 ;
 M AMIS(4)=^XTMP("PSU_"_PSUJOB,"ARCOMBO")
 ;
 M AMIS(5)=^XTMP("PSU_"_PSUJOB,"CSCOMBO")
 ;
 M AMIS(6)=^XTMP("PSU_"_PSUJOB,"IVCOMBO")
 ;
 ;Reorganize AMIS array
 S C=1
 S PSUCT=0
 F  S PSUCT=$O(AMIS(PSUCT)) Q:PSUCT=""  D
 .S PSULN=0
 .F  S PSULN=$O(AMIS(PSUCT,PSULN)) Q:PSULN=""  D
 ..S AMIS(C)=AMIS(PSUCT,PSULN)
 ..S C=C+1
 ;
 D MAIL
 Q
 ;
MAIL ;Mail combo message
 ;
 S PSUST=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,1)    ;Facility #
 S PSUSTNM=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2)  ;Facility name
 ;
 S XMSUB="V. 4.0 PBMAMIS "_PSUMON_" "_PSUST_" "_PSUSTNM
 S XMTEXT="AMIS("
 M ^XTMP("PSU_"_PSUJOB,"COMBOAMIS")=AMIS
 S XMCHAN=1
 M XMY=PSUXMYS2
 D ^XMD
 ;
 Q
