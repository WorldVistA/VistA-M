SDEC55 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;DATE RANGE FOR INPUT
APPIDGET(SDECY,SDID)  ;GET SDEC APPOINTMENT ien for given External ID
 ;APPIDGET(SDECY,SDID)  external parameter tag is in SDEC
 ;INPUT:
 ; SDID = (required) External ID from EXTERNAL ID field in SDEC APPOINTMENT
 ;RETURN:
 ; Successful Return: Global Array in which each array entry contains an appointment ID:
 ;  1. SDECAPTID - appointment ID pointer to SDEC APPOINTMENT
 ;
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDECI,SDI
 S SDECY="^TMP(""SDEC55"","_$J_",""APPIDGET"")"
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00030SDECAPTID"_$C(30)
 I $G(SDID)="" D ERR1^SDECERR(-1,"Invalid External ID.",.SDECI,SDECY)
 S SDI="" F  S SDI=$O(^SDEC(409.84,"AEX",SDID,SDI)) Q:SDI=""  D
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SDI_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
ETHGET(SDECY)  ;GET active Ethnicities from the ETHNICITY file 10.2
 ;ETHGET(.SDECY)  external parameter tag is in SDEC
 ;INPUT - none
 ;RETURN:
 ; Successful Return: Global Array in which each array entry
 ; contains an ethnicity IEN, name, and abbreviation
 ; from the ETHNICITY file 10.2:
 ;    ETHNICITY ^ ETHNICITYNAME ^ ETHNICITYABBR
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDECI,SDI,SDNOD
 S SDECY="^TMP(""SDEC55"","_$J_",""ETHGET"")"
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00030ETHNICITY^T00030ETHNICITYNAME^T00030ETHNICITYABBR"_$C(30)
 S SDI=0 F  S SDI=$O(^DIC(10.2,SDI)) Q:SDI'>0  D
 .Q:+$P($G(^DIC(10.2,SDI,.02)),U,1)
 .S SDNOD=^DIC(10.2,SDI,0)
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SDI_U_$P(SDNOD,U,1)_U_$P(SDNOD,U,2)_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
ETHCMGET(SDECY)  ;GET values from the RACE AND ETHNICITY COLLECTION METHOD file 10.3
 ;ETHCMGET(.SDECY)  external parameter tag is in SDEC
 ;INPUT - none
 ;RETURN:
 ; Successful Return: Global Array in which each array entry
 ; contains an IEN, name, and abbreviation
 ; from file 10.3:
 ;    IEN ^ NAME ^ ABBR
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDECI,SDI,SDNOD
 S SDECY="^TMP(""SDEC55"","_$J_",""ETHCMGET"")"
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00030IEN^T00030NAME^T00030ABBR"_$C(30)
 S SDI=0 F  S SDI=$O(^DIC(10.3,SDI)) Q:SDI'>0  D
 .S SDNOD=^DIC(10.3,SDI,0)
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SDI_U_$P(SDNOD,U,1)_U_$P(SDNOD,U,2)_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
CGET(SDECY)  ;GET active Countries from the COUNTRY CODE file 779.004
 ;CGET(.SDECY)  external parameter tag is in SDEC
 ;INPUT - none
 ;RETURN:
 ; Successful Return: Global Array in which each array entry
 ; contains a Country code IEN, name, and abbreviation
 ; from the COUNTRY CODE file 779.004:
 ;    COUNTRY ^ COUNTRYNAME ^ COUNTRYABBR
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDECI,SDI,SDNOD,SDDATE,SDSTAT
 S SDECY="^TMP(""SDEC55"","_$J_",""CGET"")"
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00030COUNTRY^T00030COUNTRYNAME^T00030COUNTRYABBR"_$C(30)
 S SDI=0 F  S SDI=$O(^HL(779.004,SDI)) Q:SDI'>0  D
 .S SDDATE=$O(^HL(779.004,SDI,"TERMSTATUS","B",9999999),-1)
 .S:SDDATE'="" SDSTAT=$O(^HL(779.004,SDI,"TERMSTATUS","B",SDDATE,0))
 .Q:+$P($G(^HL(779.004,SDI,"TERMSTATUS",+$G(SDSTAT),0)),U,2)=0
 .S SDNOD=^HL(779.004,SDI,0)
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SDI_U_$P(SDNOD,U,2)_U_$P(SDNOD,U,1)_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
RACEGET(SDECY)  ;GET active Race entries from the RACE file 10
 ;RACEGET(.SDECY)  external parameter tag is in SDEC
 ;INPUT - none
 ;RETURN:
 ; Successful Return: Global Array in which each array entry
 ; contains a race IEN, name, and abbreviation
 ; from the RACE file 10:
 ;    RACEIEN ^ RACENAME ^ RACEABBR
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDECI,SDI,SDNOD
 S SDECY="^TMP(""SDEC55"","_$J_",""RACEGET"")"
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00030RACEIEN^T00030RACENAME^T00030RACEABBR"_$C(30)
 S SDI=0 F  S SDI=$O(^DIC(10,SDI)) Q:SDI'>0  D
 .Q:+$P($G(^DIC(10,SDI,.02)),U,1)
 .S SDNOD=^DIC(10,SDI,0)
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SDI_U_$P(SDNOD,U,1)_U_$P(SDNOD,U,2)_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
