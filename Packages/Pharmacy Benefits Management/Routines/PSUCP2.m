PSUCP2 ;BIR/TJH - CHECK COMPLETION OF MONTHLY PBM REPORT ;25 AUG 1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIAs
 ; Reference to File #4    supported by DBIA 10090
 ; Reference to File #4.3  supported by DBIA 10091
 ; Reference to File #40.8 supported by DBIA 2438
 ; Reference to File #59.7 supported by DBIA 2854
 ;
MANUAL ; Entry point if tasked by PSU PBM MANUAL option
 S PSUWAY="Manual"
AUTO ; Entry point if tasked by PSU PBM AUTO option
 I '$D(PSUWAY) S PSUWAY="Automatic"
 D NOW^%DTC
 S PSUNOW=% K %,%H,%I,X
 S PSULRD=$$VALI^PSUTL(59.7,1,90) ; last run date
 D
 .I PSULRD="" S PSUOK=0 Q  ; it's 24 hours later and finish time is not set, may be a problem.
 .S X1=PSUNOW,X2=PSULRD D ^%DTC
 .I X>6 S PSUOK=0 Q  ; the last run date must be left over from a previous run, it's a problem.
 .S PSUOK=1
 G:PSUOK EXIT ; no message sent if OK.
 D XMY^PSUTL1
 M XMY=PSUXMYS1
 I $G(PSUMASF) M XMY=PSUXMYH
 S X=$$VALI^PSUTL(4.3,1,217),PSUDIV=+$$VAL^PSUTL(4,X,99)
 S X=PSUDIV,DIC=40.8,DIC(0)="XM" D ^DIC
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 S XMSUB="PBM "_PSUWAY_" Statistics Job "_PSUDIV_" "_PSUDIVNM
 S X(1)="The PBM "_PSUWAY_" Statistics background job did not run to completion."
 S X(2)="Please correct the problem and retransmit the data to the National PBM"
 S X(3)="section at Hines."
 S XMTEXT="X("
 S XMCHAN=1
 D ^XMD
EXIT ; normal exit point from PSUCP2
 K PSUWAY,PSUNOW,PSULRD,PSUOK,PSUDIV,PSUDIVNM
 Q
MMNOMAP ; Generate MM regarding locations not mapped
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3"))  ;Quit if user does not want a 
 ;copy sent to self
 ;
 N TXT1,TXT2
 ;
 D PULL^PSUCP
 F I=1:1:$L(PSUOPTS,",") S PSUMOD($P(PSUOPTS,",",I))=""
 S X=$$VALI^PSUTL(4.3,1,217),PSUSNDR=+$$VAL^PSUTL(4,X,99),PSUNAME=$$VAL^PSUTL(4,X,.01)
 K TXT
 S TXT(1)="The locations listed below have not been mapped to a Medical Center"
 S TXT(2)="Division or Outpatient Site. All data extracted from these locations have"
 S TXT(3)="been attributed to "_PSUSNDR_" "_PSUNAME
 S TXT(4)=" "
 S TLC=4
 ;
 I $D(PSUARSUB) D
 .I $D(^XTMP(PSUARSUB,"AOU")),$D(PSUMOD(3)) D
 ..K AOUNMAP,MAP  ;Array to hold unmapped AOU data
 ..N LOC,LOC1
 ..M MAP=^XTMP(PSUARSUB,"AOU")
 ..F TXT=" ","AOUs:" D TXT
 ..S IEN=0 F  S IEN=$O(MAP(IEN)) Q:IEN=""  D
 ...S LOC=MAP(IEN,.01)
 ...M AOUNMAP(LOC)=MAP(IEN)
 ..S LOC1=0
 ..F  S LOC1=$O(AOUNMAP(LOC1)) Q:LOC1=""  D
 ...S TXT1=AOUNMAP(LOC1,.01)
 ...S TXT2=$G(AOUNMAP(LOC1,3)) I TXT2'="" S TXT2="   **INACTIVE**"
 ...S TXT=TXT1_TXT2 D TXT
 .;
 .I '$D(^XTMP(PSUARSUB,"AOU")),$D(PSUMOD(3)) D
 ..F TXT=" ","AOUs:" D TXT
 ..S TXT="There are no unmapped AOU's for the dates of this extract" D TXT
 ;
 I $D(PSUARSUB) D
 .I $D(^XTMP(PSUARSUB,"NAOU")),$D(PSUMOD(6)) D
 ..K NAOUMAP,MAP
 ..N LOC,LOC1
 ..M MAP=^XTMP(PSUARSUB,"NAOU")
 ..F TXT="","NAOUs:" D TXT
 ..S IEN=0 F  S IEN=$O(MAP(IEN)) Q:IEN'>0  D
 ...S LOC=MAP(IEN,.01)
 ...M NAOUMAP(LOC)=MAP(IEN)
 ..S LOC1=0
 ..F  S LOC1=$O(NAOUMAP(LOC1)) Q:LOC1=""  D
 ...S TXT1=NAOUMAP(LOC1,.01)
 ...S TXT2=$G(NAOUMAP(LOC1,4)) I TXT2'="" S TXT2="   **INACTIVE**"
 ...S TXT=TXT1_TXT2 D TXT
 .;
 .I '$D(^XTMP(PSUARSUB,"NAOU")),$D(PSUMOD(6)) D
 .. F TXT=" ","NAOUs:" D TXT
 ..S TXT="There are no unmapped NAOU's for the dates of this extract" D TXT
 ;
 I $D(PSUARSUB) D
 .I $D(^XTMP(PSUARSUB,"DAPH")),$D(PSUMOD(5)) D
 ..K DAPH,MAP
 ..N LOC,LOC1
 ..M MAP=^XTMP(PSUARSUB,"DAPH")
 ..F TXT="","DA Pharmacy Locations:" D TXT
 ..S IEN=0 F  S IEN=$O(MAP(IEN)) Q:IEN'>0  D
 ...S LOC=MAP(IEN,.01)
 ...M DAPH(LOC)=MAP(IEN)
 ..S LOC1=0
 ..F  S LOC1=$O(DAPH(LOC1)) Q:LOC1=""  D
 ...S TXT1=DAPH(LOC1,.01)
 ...S TXT2=$G(DAPH(LOC1,4)) I TXT2'="" S TXT2="   **INACTIVE**"
 ...S TXT=TXT1_TXT2 D TXT
 .;
 .I '$D(^XTMP(PSUARSUB,"DAPH")),$D(PSUMOD(5)) D
 .. F TXT=" ","DA Pharmacy Locations:" D TXT
 ..S TXT="There are no unmapped DA Pharmacy Locations for the dates of this extract" D TXT
 ;
MSGNOMAP ; send MM 
 ;
 S Y=PSUSDT\1 X ^DD("DD") S PSUDTS=Y
 S Y=PSUEDT\1 X ^DD("DD") S PSUDTE=Y
 S XMSUB="PBM Unmapped Locations for "_PSUDTS_" to "_PSUDTE_" from "_PSUSNDR_" "_PSUNAME
 S XMTEXT="TXT("
 S XMY("G.PSU PBM")=""
 S XMY(DUZ)=""
 I $D(PSUARSUB) D ^XMD
 Q
 ;
TXT S TLC=TLC+1,TXT(TLC)=TXT
 Q
