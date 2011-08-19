PRCVBLD ;ISC-SF/GJW - Build fund balance notifications ; 6/6/05 1:12pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;
 ;
 ;=============================================================
 ;Format of input array (passed by name):
 ;
 ;array("1QBAL") = 1st quarter uncommited balance
 ;array("2QBAL") = 2nd quarter uncommited balance
 ;array("3QBAL") = 3rd quarter uncommited balance
 ;array("4QBAL") = 4th quarter uncommited balance
 ;array("FY") = fiscal year (2 or 4 digits)
 ;array("TIME") = time of transaction (FM format)
 ;array("FCP_NUM") = FCP number (only)
 ;array("STAT") = station number
 ;=============================================================
 ;
BLD1(PRCVOBJ) ;simple build (fund balance notification)
 N PRCVMSG,PROTOCOL,SEG,I,NOW,FCPEXT,ANIENS
 N PRCVFS,PRCVCS,PRCVRS,PRCVES,PRCVSS
 N $ES,$ET S $ET="ETRAP^PRCVBLD"
 S PRCVMSG=$NA(^TMP("HLS",$J)) ;accumulate message here
 S PROTOCOL="PRCV_DYNAMED_22_EV_FUND_BAL_DATA"
 D INIT^HLFNC2(PROTOCOL,.HL)
 I $G(HL) D  Q  ; error occurred
 .; put error handler here for init failure
 .S PRCVERR=$P(HL,2)
 .S $EC=",U1_HL7_SYSTEM_ERROR,"
 S PRCVFS=$G(HL("FS")) ;field separator
 S PRCVCS=$E(HL("ECH"),1) ;component separator
 S PRCVRS=$E(HL("ECH"),2) ;repetition separator
 S PRCVES=$E(HL("ECH"),3) ;encoding character
 S PRCVSS=$E(HL("ECH"),4) ;subcomponent separator
 S ANIENS=$G(@PRCVOBJ@("FCP_NUM"))_","_$G(@PRCVOBJ@("STAT"))_","
 S FCPEXT=$P($$GET1^DIQ(420.01,ANIENS,.01)," ",1)
 ;MFI segment
 S SEG="MFI"_PRCVFS_"420"_PRCVCS_"CP"_PRCVFS_PRCVFS_"UPD"_PRCVFS
 S SEG=SEG_$$FMTHL7^XLFDT($$NOW^XLFDT)_PRCVFS_PRCVFS_"AL"
 S @PRCVMSG@(1)=SEG
 ;MFE segment
 S SEG="MFE"_PRCVFS_"MUP"_PRCVFS_PRCVFS_PRCVFS
 S SEG=SEG_FCPEXT_PRCVFS_"CE"
 S @PRCVMSG@(2)=SEG
 ;FT1 segment
 S SEG="FT1"_PRCVFS_PRCVFS_PRCVFS_$$YEAR($G(@PRCVOBJ@("FY")))
 S SEG=SEG_PRCVFS_$$FMTHL7^XLFDT($G(@PRCVOBJ@("TIME")))
 S SEG=SEG_PRCVFS_PRCVFS_"BAL"_PRCVFS_"AVAIL_BAL"
 S SEG=SEG_PRCVFS_PRCVFS_PRCVFS_PRCVFS
 S SEG=SEG_+$G(@PRCVOBJ@("1QBAL"))_PRCVSS_"USD"_PRCVRS
 S SEG=SEG_+$G(@PRCVOBJ@("2QBAL"))_PRCVSS_"USD"_PRCVRS
 S SEG=SEG_+$G(@PRCVOBJ@("3QBAL"))_PRCVSS_"USD"_PRCVRS
 S SEG=SEG_+$G(@PRCVOBJ@("4QBAL"))_PRCVSS_"USD"_PRCVFS
 ;Assorted HL7 noise (not directly used by this interface)
 S NOW=$$FMTHL7^XLFDT($$NOW^XLFDT)
 F I=1:1:8 S SEG=SEG_PRCVFS
 F I=1:1:16 S SEG=SEG_PRCVCS
 S SEG=SEG_NOW_PRCVSS_NOW
 S SEG=SEG_PRCVFS
 F I=1:1:16 S SEG=SEG_PRCVCS
 S SEG=SEG_NOW_PRCVSS_NOW
 F I=1:1:3 S SEG=SEG_PRCVFS
 F I=1:1:16 S SEG=SEG_PRCVCS
 S SEG=SEG_NOW_PRCVSS_NOW
 S @PRCVMSG@(3)=SEG
 Q
 ;
YEAR(PRCVY) ;Expand a (possibly) 2-digit year
 I PRCVY'?2N Q PRCVY
 Q $S(PRCVY>90:"19"_PRCVY,1:"20"_PRCVY)
 ;
 ;
ETRAP ;
 D ^%ZTER
 K PRCVERR ;We want this variable in the error trap
 D UNWIND^%ZTER
 Q
