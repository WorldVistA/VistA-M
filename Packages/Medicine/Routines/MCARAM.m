MCARAM ;WASH ISC/JKL-MUSE AUTO INSTRUMENT DATA LOAD INTO DHCP ;5/28/96  14:53
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
START ; Driver for MUSE-run by task manager
 ; WHERE: LANM,TSK,MCINST,T are required for MCARASE
 ; LANM = routine name, T and TSK = auto instrument IEN,
 ; MCINST = auto instrument name
 ; MCL = data type line number,  MCLT = data transmission line number
 ; MCD = one line of lab data, MCA = array of local data,
 ; MCE = internal record number of EKG file where data is stored
 ; MCRD = attempts to read lab data
 ; MCCD= current data transmission number
 ; MCPRO= EKG procedure number from Procedure/Subspecialty file
 N LANM,TSK,MCINST,T,MCL,MCLT,MCA,MCCD,MCCNT,MCE,MCERR,MCRD,MCPRO,MCPRNM
 N MCS,MCTOT,MCTYPE,MCZ,MCREC
 S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)),U="^" I TSK="" Q
 ; Quit if no MUSE data
 I '$D(^LA(TSK,"I",0)) Q
 S MCINST=$P(^LAB(62.4,TSK,0),U) D ^MCARASE I 'TSK Q
 S @TRAP
 ;initial error condition
 S MCA("ERR")=0
 ;get EKG procedure number from Procedure/Subspecialty file
 S MCPRO=$O(^MCAR(697.2,"C","MCAR(691.5",0))
 ;print name for ECG procedure, type of transmission
 S MCPRNM=$$ORPRM(MCPRO),MCTYPE="M"
 ;delay process until record data is complete
 D DELPRO
 ;
READ S MCRD=0,MCL=0,MCCD=-1,MCA("CONT")="@"
 I ^LA(TSK,"I",0)'=0 S MCLT=^LA(TSK,"I",0)+1,MCCD=MCLT-1
 D IN G QUIT
IN S MCLT=^LA(TSK,"I",0)+1 I '$D(^(MCLT)) S MCRD=MCRD+1 Q:MCRD>6  H 8 G IN
 S ^LA(TSK,"I",0)=MCLT,MCRD=0,MCERR=0
 I '$D(MCREC) F MCZ=1:1 D:'$D(^LA(TSK,"I",MCLT+MCZ)) DELPRO I ($D(^LA(TSK,"I",MCLT+MCZ))#2),((^LA(TSK,"I",MCLT+MCZ)["EOR")!(^LA(TSK,"I",MCLT+MCZ)["ERR")!(^LA(TSK,"I",MCLT+MCZ)["BYE")) S MCREC="" Q
 I '$D(MCA("ERR")) S MCA("ERR")=0
 ;ignore set if retransmit set of data lines
 I $D(^LA(TSK,"I",MCLT+3)),^LA(TSK,"I",MCLT+3)=^LA(TSK,"I",MCLT),^LA(TSK,"I",MCLT)?.E1.A.E S MCCD=MCCD+3,^LA(TSK,"I",0)=MCLT+2 G IN
 ;check for start of transmission-suppressed H
 I $E(^LA(TSK,"I",MCLT),1,5)="HELLO" S MCCD=MCLT-3
 ;check for start of transmission-IRM
 I $E(^LA(TSK,"I",MCLT),1,3)="IRM" S MCCD=MCLT-3
 ;transfer one line of lab data to local array
 I MCCD+3=MCLT S MCERR=$$RLAB^MCARAM(.MCA,.MCL,MCLT)
 ;transmission error
 I +MCERR=5 K MCA,MCERR,MCREC N MCA,MCERR G IN
 ;transfer local array data into DHCP
 ;record successful or unsuccessful data transfer attempt
 I +MCERR=10 S:$$GRERR^MCARAM7(.MCA)=0 MCERR=$$LDHCP^MCARAM3(.MCA,.MCE) S MCERR=$$KPERR^MCARAM7(.MCA,.MCS) K MCA,MCERR,MCE,MCS,MCREC N MCA,MCERR,MCE,MCS
 G IN
 ;
DELPRO ;delay process until record data is complete
 S MCCNT=0
DELP I $D(^LA(TSK,"I")) S MCTOT=^LA(TSK,"I"),MCCNT=MCCNT+1 H 15 I MCTOT=^LA(TSK,"I"),MCCNT<7 G DELP
 K MCTOT,MCCNT
 Q
 ;
 ;
OUT S MCLT=^LA(TSK,"O")+1,^("O")=MCLT,^("O",MCLT)=OUT
 L +^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=TSK L -^LA("Q") Q
 Q
 ;
 ;
RLAB(MCA,MCL,MCLT) ; Read Lab data and place in local array
 ; USAGE: S X=$$RLAB^MCARAM(.A,.B,C)
 ; WHERE: .A=Array into which data is placed
 ;        .B=Data type line number
 ;         C=Data transmission line number
 ;
 ;lab data
 S MCD=^LA(TSK,"I",MCLT)
 I ($E(MCD,1,5)="HELLO")!($E(MCD,1,3)="EOT") S MCL=0,MCA("CONT")="@",MCCD=MCLT-1 Q 0
 I $E(MCD,1,3)="BYE" S MCL=0,MCA("CONT")="@",MCCD=MCLT-2 Q 0
 I $E(MCD,1,3)="IRM" S MCL=0,MCA("CONT")="@",MCCD=MCLT Q 0
 I $E(MCD,1,3)="EOR" S MCERR="10-End of record" S MCCD=MCLT Q MCERR
 I $E(MCD,1,3)="ERR" S MCERR="5-Transmission error-expect retry of record" S MCL=0,MCA("CONT")="@",MCCD=MCLT-1 Q MCERR
 S MCL=MCL+1,MCA("CONT")=$C($A(MCA("CONT"))+1)
 ;transfer lab data to local
 I MCL<13 S MCTR=$S(MCL<7:"S MCERR=$$L"_MCL_"^MCARAM1(.MCA,MCD)",MCL=12:"S MCERR=$$L"_MCL_"^MCARAM3(.MCA,MCD)",MCL>6:"S MCERR=$$L"_MCL_"^MCARAM2(.MCA,MCD)") X MCTR S MCCD=MCLT Q:+MCERR>0 MCERR  Q 0
 ;fill diagnosis array
 I MCL>12 S MCERR=$$DGCT^MCARAM4(.MCA,MCD,MCL),MCCD=MCLT I +MCERR>0 Q MCERR
 Q 0
 ;
TRAP ;entry from MCARASE
 K ^LA("LOCK",TSK) S T=TSK D SET^MCARASE
 S ^LA(TSK,"Q")=0 D ERROR^MCARASE
 G @(U_LANM)
 ;
ORPRM(MCPRO) ;Get print name for ECG procedure
 ;USAGE: S X=$$ORPRM(MCPRO)
 ;WHERE: X = print name for ECG procedure/subspecialty
 ;       MCPRO = EKG procedure number from Procedure/Subspecialty file
 I '$D(MCOEON) D ORDER^MCPARAM I '$D(MCOEON) Q ""
 Q $P(^MCAR(697.2,MCPRO,0),U,8)
 ; 
HSHAKE ; MUSE dialog, called by LAB which executes HANDSHAKE fld of AI file
 ; Does checksum on MUSE input, sets OUT to ACK or NAK
 I IN="BYE" S OUT="" K MCSM Q
 I IN="HELLO" S T=T-BASE,OUT="ACK" K MCSM
 I IN?.E1.A.E N MCI S MCSM=0 F MCI=1:1:$L(IN) S MCSM=MCSM+$A(IN,MCI)
 I IN?1.5N,$D(MCSM) S T=T-BASE S:MCSM'=IN OUT="NAK" S:MCSM=IN OUT="ACK" K MCSM
 K MCI Q
QUIT L +^LA(TSK) H 1
 K ^LA(TSK)
 L -^LA(TSK)
 K ^LA("LOCK",TSK)
 D DQ^%ZTLOAD
 S:$D(ZTQUEUED) ZTREQ="@" K ZTSK
 Q
