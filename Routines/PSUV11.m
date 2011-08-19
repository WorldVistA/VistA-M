PSUV11 ;BIR/DAM - IV AMIS Summary Message I;04 MAR 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;No DBIA's required
 ;
EN ;Entry point for MailMan message
 ;Called from PSUIV0
 ;
 D SITE
 D EN^PSUV12
 D MAIL
 Q
 ;
SITE ;Create the IV AMIS summary mailman message
 ;
 ;
 K LVP,PB,TPN,CH,SYR     ;KILL ARRAYS
 ;
 ;PSUDIV is the division number
 ;PSUDIVNM is the division name
 ;
 S PSUDIV=0
 F  S PSUDIV=$O(^XTMP(PSUIVSUB,"RECORDS",PSUDIV)) Q:PSUDIV=""  D
 .D GETDIV^PSUV3
 .D LVP
 .D IVP
 .D TPN
 .D CHEM
 .D SYR
 Q
 ;
LVP ;Set contents of LVP ^XTMP global into local array
 ;
 M LVP(PSUDIV)=^XTMP(PSUIVSUB,"LVP",PSUDIV)   ;Data array
 ;
 ;
 Q
 ;
IVP ;Set contents of IVPB ^XTMP global into local array
 ;
 M PB(PSUDIV)=^XTMP(PSUIVSUB,"PB",PSUDIV)     ;Data array
 ;
 Q
 ;
TPN ;Set contents of TPN ^XTMP global into local array
 ;
 M TPN(PSUDIV)=^XTMP(PSUIVSUB,"TPN",PSUDIV)
 ;
 Q
 ;
CHEM ;Set contents of CHEMO ^XTMP global into local array
 ;
 M CH(PSUDIV)=^XTMP(PSUIVSUB,"CH",PSUDIV)
 ;
 Q
 ;
SYR ;Set contents of SYR ^XTMP global into local array
 ;
 M SYR(PSUDIV)=^XTMP(PSUIVSUB,"SYR",PSUDIV)
 ;
 Q
 ;
MAIL ;Send AMIS summary mailman message
 ;
 ;Do not send message if option selection includes 1,2,3,4,6
 I $D(^XTMP("PSU_"_PSUJOB,"CBAMIS")) D  Q
 .M ^XTMP("PSU_"_PSUJOB,"IVCOMBO")=AMIS
 .S ^XTMP("PSU_"_PSUJOB,"IVCOMBO",1)=""
 ;
 S PSUDIV=PSUSNDR D GETDIV^PSUV3
 S XMSUB="V. 4.0 PBMIV "_PSUMON_" "_PSUSNDR_" "_PSUDIVNM
 S XMTEXT="AMIS("
 M ^XTMP("PSU_"_PSUJOB,"IVAMIS")=AMIS
 S XMCHAN=1
 M XMY=PSUXMYS2
 D ^XMD
 ;
 Q
