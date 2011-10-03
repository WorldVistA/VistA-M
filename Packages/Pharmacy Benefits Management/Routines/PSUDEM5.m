PSUDEM5 ;BIR/DAM - Patient Demographics Mail Messages ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
PDMAIL ;EN  Mail patient demographics message
 ;
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3"))  ;don't send a mailman message if flag is set
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUMONTH")) D AUTO  ;Find month if auto extract
 ;
 D VAR
 S PSUST=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,1)
 S PSUSTNM=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2)
 S PSUMON=$P(^XTMP("PSU_"_PSUJOB,"PSUMONTH"),U,1)
 I $G(^XTMP("PSU_"_PSUJOB,"REXMIT"))="YES" S PSUMON=PSURMON
 S XMDUZ=DUZ
 S XMSUB="V. 4.0 PBMPD"_" "_PSUMON_" "_PSUM_"/"_PSUMC_" "_PSUST_" "_PSUSTNM
 S XMCHAN=1
 ;S PSUPBMG=^XTMP("PSU_"_PSUJOB,"PSUPBMG")
 S XMTEXT="^XTMP(""PSU_""_PSUJOB,""PSUXMD"",PSUM,"
 I PSUMASF!PSUDUZ!PSUPBMG D
 .I 'PSUSMRY M XMY=PSUXMYH D   ;Detailed message to Hines and self
 .D ^XMD
 Q
 ;
AUTO ;Find month if auto extract is run
 ;
 D NOW^%DTC S PSUMON=$S('$D(DT):X,1:DT),PSUMON=$E(PSUMON,1,5)-1 ;Prior mt
 I $E(PSUMON,4,5)="00" S PSUMON=($E(PSUMON,1,3)-1)_"12"
 S ^XTMP("PSU_"_PSUJOB,"PSUMONTH")=PSUMON
 Q
 ;
VAR ;Get variables common to all extract messages
 ;
 N PSUSTNM,PSUST,PSUMON
 D INST^PSUDEM1
 ;
 Q
 ;
PROV ;EN  Mail Provider message
 ;
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3"))  ;don't send a mailman message if flag is set
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUMONTH")) D AUTO  ;Find month if auto
 D VAR
 S PSUST=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,1)
 S PSUSTNM=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2)
 S PSUMON=$P(^XTMP("PSU_"_PSUJOB,"PSUMONTH"),U,1)
 ;
 S XMCHAN=1
 S XMDUZ=DUZ
 S XMSUB="V. 4.0 PBMPRO"_" "_PSUMON_" "_PSUM_"/"_PSUMC_" "_PSUST_" "_PSUSTNM
 S XMTEXT="^XTMP(""PSU_""_PSUJOB,""PSUXMD"",PSUM,"
 I PSUMASF!PSUDUZ!PSUPBMG D
 .I 'PSUSMRY M XMY=PSUXMYH D   ;Detailed message to Hines and self
 .D ^XMD
 Q
 ;
OPV ;EN  Outpatient encounter message
 ;
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3"))  ;don't send a mailman message if flag is set
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUMONTH")) D AUTO  ;Find month if auto
 D VAR
 S PSUST=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,1)
 S PSUSTNM=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2)
 S PSUMON=$P(^XTMP("PSU_"_PSUJOB,"PSUMONTH"),U,1)
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUOPV")) S PSUMC=1
 ;
 S XMDUZ=DUZ
 S XMSUB="V. 4.0 PBMOV"_" "_PSUMON_" "_PSUM_"/"_PSUMC_" "_PSUST_" "_PSUSTNM
 S XMCHAN=1
 S XMTEXT="^XTMP(""PSU_""_PSUJOB,""PSUXMD"",PSUM,"
 I PSUMASF!PSUDUZ!PSUPBMG D
 .I 'PSUSMRY M XMY=PSUXMYH D   ;Detailed message to Hines and self
 .D ^XMD
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUOPV")) M XMY=PSUXMYS1 D    ;NODATA  message
 .D ^XMD
 ;K ^XTMP("PSU_"_PSUJOB,"PSUMONTH")
 Q
 ;
PTF ;EN  INPATIENT RECORD MESSAGE
 ;
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3"))  ;don't send a mailman message if flag is set
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUMONTH")) D AUTO  ;Find month if auto
 D VAR
 S PSUST=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,1)
 S PSUSTNM=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2)
 S PSUMON=$P(^XTMP("PSU_"_PSUJOB,"PSUMONTH"),U,1)
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUIPV")) S PSUMC=1
 ;
 S XMDUZ=DUZ
 S XMSUB="V. 4.0 PBMPTF"_" "_PSUMON_" "_PSUM_"/"_PSUMC_" "_PSUST_" "_PSUSTNM
 S XMCHAN=1
 S XMTEXT="^XTMP(""PSU_""_PSUJOB,""PSUXMD"",PSUM,"
 I PSUMASF!PSUDUZ!PSUPBMG D
 .I 'PSUSMRY M XMY=PSUXMYH D   ;Detailed message to Hines and self
 .D ^XMD
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUIPV")) M XMY=PSUXMYS1 D    ;NODATA  message
 .D ^XMD
 Q
 ;
PRSUM ;EN  Provider summary message
 ;
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3"))  ;don't send a mailman message if flag is set
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUMONTH")) D AUTO  ;Find month if auto
 D VAR
 S PSUST=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,1)
 S PSUSTNM=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2)
 S PSUMON=$P(^XTMP("PSU_"_PSUJOB,"PSUMONTH"),U,1)
 ;
 S XMDUZ=DUZ
 S XMCHAN=1
 S XMSUB="V. 4.0 PBMPRO"_" "_PSUMON_" "_PSUST_" "_PSUSTNM
 S XMTEXT="^XTMP(""PSU_""_PSUJOB,""PSUSUM"","
 M XMY=PSUXMYS1
 I PSUSMRY=1 M XMY=PSUXMYS2     ;Summary only mailgroup
 D ^XMD
 Q
 ;
PDSUM ;EN  Pt. demographics summary message
 ;
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3"))  ;don't send a mailman message if flag is set
 ;N PSUSTNM,PSUST
 D PULL^PSUCP
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUMONTH")) D AUTO  ;Find month if auto
 D VAR
 S PSUST=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,1)
 S PSUSTNM=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2)
 S PSUMON=$P(^XTMP("PSU_"_PSUJOB,"PSUMONTH"),U,1)
 ;
 S XMDUZ=DUZ
 S XMCHAN=1
 S XMSUB="V. 4.0 PBMPD"_" "_PSUMON_" "_PSUST_" "_PSUSTNM
 S XMTEXT="^XTMP(""PSU_""_PSUJOB,""PSUSUMA"","
 I PSUSMRY=1 M XMY=PSUXMYS2     ;Summary only mailgroup
 M XMY=PSUXMYS1                 ;No Data mailgroup
 D ^XMD
 Q
