OOPSGUI1 ;WIOFO/LLH-RPC routines ;9/3/01
 ;;2.0;ASISTS;**4,8,7,11,15,18,20,21,23**;Jun 03, 2002;Build 6
 ;
OPT(RESULTS,INP) ; Returns the ASISTS GUI Menus user has access to
 ;      INP      - Input String containing the version of GUI making call
 ;  RESUTLS      - return value for broker call
 ;                 P1 = 1 DUZ defined
 ;                 P2 = 1 Emp Health menu accessible
 ;                 P3 = 1 Employee menu accessible
 ;                 P4 = 1 Supervisor menu accessible
 ;                 P5 = 1 Safety Officer menu accessible
 ;                 P6 = 1 Union menu accessible
 ;                 P7 = 1 Workers' Comp menu accessible
 ;                 P8 = SSN from New Person file for user
 ;                 P9 = server version #
 ;
 N CNT,MENU,OPT,PRIM,SM,VER
 S CNT=1
 I 'DUZ S RESULTS="0^^^^^^^" Q
 S RESULTS=DUZ_"^0^0^0^0^0^0^"
 ;V1_P23 - changed version to 23
 S VER="2.23.1.0"        ;Define version check patch #4
 I $G(INP)=""!($G(INP)'=VER) Q
 S PRIM=$$GET1^DIQ(200,DUZ,201)     ; get primary menu
 I $G(PRIM)'="" S MENU(PRIM)=""
 S SM=0
 F  S SM=$O(^VA(200,DUZ,203,SM))  Q:SM'>0  D
 . S OPT=$$GET1^DIQ(19,$P($G(^VA(200,DUZ,203,SM,0)),U),.01)
 . I $G(OPT)'="" S MENU(OPT)=""
 I $D(MENU("OOPS GUI EMPLOYEE HEALTH MENU")) S $P(RESULTS,U,2)=1
 I $D(MENU("OOPS GUI EMPLOYEE")) S $P(RESULTS,U,3)=1
 I $D(MENU("OOPS GUI SUPERVISOR MENU")) S $P(RESULTS,U,4)=1
 I $D(MENU("OOPS GUI SAFETY OFFICER MENU")) S $P(RESULTS,U,5)=1
 I $D(MENU("OOPS GUI UNION MENU")) S $P(RESULTS,U,6)=1
 I $D(MENU("OOPS GUI WORKERS' COMP MENU")) S $P(RESULTS,U,7)=1
 I +$$ACCESS^XQCHK(DUZ,"OOPS GUI EMPLOYEE") S $P(RESULTS,U,3)=1
 S $P(RESULTS,U,8)=$$GET1^DIQ(200,DUZ,9)
 S $P(RESULTS,U,9)=VER              ;return the version defined above.
 Q
SETSIGN(RESULTS,INPUT,SIGN) ; This subroutine validates that the signature
 ;                         can be entered and is valid
 ;  Input:   INPUT - Contains the IEN of the ASISTS case, the form type,
 ;                   and the field number.  The field number is used
 ;                   to trigger what validation should be preformed on
 ;                   the fields in the form so that the signature can
 ;                   be applied. The fourth parameter is a special flag
 ;                   indicating the Workers Comp is signing for employee
 ;                   Format is IEN^FORM^FIELD^WCFLAG
 ;            SIGN - contains the signature test to be encrypted.
 ; Output: RESULTS - is an array containing a list of fields that did
 ;                   not pass the data validation and must be corrected
 ;                   prior to applying a signature.
 N CALL,DTIME,FDUZ,FDT,FLD,IEN,INC,FORM,ESIG,VALID,CALLER,WOK
 N DR,DA,DIE,WCFLG
 S IEN=$P($G(INPUT),U),FORM=$P($G(INPUT),U,2),FLD=$P($G(INPUT),U,3)
 I '$G(IEN)!('$G(FLD)) S RESULTS(1)="User not Authorized to sign form" Q
 I FLD=45!(FLD=170)!(FLD=266) S CALL="S"
 I FLD=49!(FLD=77) S CALL="O"
 ; Patch 5 ll - added !(FLD=313)!(FLD=320)
 I FLD=68!(FLD=313)!(FLD=320) S CALL="W"
 I FLD=80 S CALL="H"
 ; Patch 5 llh - added !(FLD=310)
 I FLD=120!(FLD=222)!(FLD=310) S CALL="E"
 S WCFLG=$P($G(INPUT),U,4)
 I WCFLG'="W" D
 .; Patch 5 llh - moved non fld check logic to separate line
 .; added stuff to check if dual benefits have been signed
 .I (FLD=120!(FLD=222)) D
 ..I ($$GET1^DIQ(2260,IEN,71,"I")'="Y") D  Q
 ...S RESULTS(1)="Claim cannot be signed until the Bill of Rights Statement is understood."
 ...D WCPBOR^OOPSMBUL(IEN)
 ;..Commented out Patch 11 cvw
 ;..I $$GET1^DIQ(2260,IEN,310)="" D  Q
 ;...S RESULTS(1)="Claim cannot be signed until the Dual Benefits form has been signed."
 ; check to make sure PAID fields (also Service) not "", if "" get data
 D CHKPAID
 S VALID=0
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 ; Patch 5 llh - added ,(FLD'>300)
 I (FLD'=77),(FLD'=80),(FLD'>300) D  I 'VALID Q
 .D VALIDATE^OOPSGUI9(IEN,FORM,CALL,.VALID)
 I $G(SIGN)="" S RESULTS(1)="No Signature Entered" Q
 S VALID=$$VALIDATE($$DECRYP^XUSRB1(SIGN))
 I 'VALID D  Q
 .I $P($G(^VA(200,DUZ,20)),"^",4)="" S RESULTS(1)="No Electronic Signature on File" Q
 .S RESULTS(1)="Invalid Signature Entered."
SIGN ; All field validated, file signature
 I FLD=77 S FDUZ=76,FDT=78             ; Safety approve WC sign
 I FLD=80 S FDUZ=79,FDT=81             ; EH approve WC sign
 I FLD=120 S FDUZ=119,FDT=121          ; Employee sign CA1
 I FLD=222 S FDUZ=221,FDT=223          ; Employee sign CA2
 I FLD=170 S FDUZ=169,FDT=171          ; Super sign CA1
 I FLD=266 S FDUZ=265,FDT=267          ; Super sign CA2
 I FLD=45 S FDUZ=44,FDT=46             ; Super sign 2162
 I FLD=49 S FDUZ=48,FDT=50             ; Safety sign 2162
 I FLD=68 S FDUZ=67,FDT=69,WOK=1       ; WC approve to DOL
 ; patch 5 llh - added next 2 lines (may need more)
 I FLD=310 S FDUZ=309,FDT=311          ; Emp sign Dual Benefits
 I FLD=313 S FDUZ=312,FDT=314          ; WC sign Dual Benefits
 D NOW^%DTC S DTIME=%
 K DR S DIE="^OOPS(2260,",DA=IEN
 S DR=FDUZ_"////^S X=+DUZ;"_FLD_"////^S X=ESIG;"_FDT_"////^S X=DTIME"
 D ^DIE
 I $G(Y)'="" Q
 I FLD=68 D WCP^OOPSMBUL(IEN,"S")
 I FLD=120!(FLD=222) S CALLER=CALL D EMP^OOPSVAL1
 I FLD=45 D SAFETY^OOPSMBUL(IEN)
 I (FLD=170)!(FLD=266) D SUPS^OOPSMBUL(IEN),UNION^OOPSMBUL(IEN)
 Q
VALIDATE(X) ; Validate Electronic Sign code
 ;  Input:  X - contains the signature to be validated
 ; Output: VSIGN - contains a 1 if a valid e-signature, a 0 if not valid
 N VSIGN
 S VSIGN=0
 D HASH^XUSHSHP
 I X'="",(X=$P($G(^VA(200,DUZ,20)),"^",4)) S VSIGN=1,ESIG=X
 Q VSIGN
CHKPAID ; check to make sure PAID fields have data, if not populate
 ; this subroutine can be removed when go completely to GUI
 N DA,DIE,DR,CAT,FLD,IEN200,OCCD,PAY,PAYP,RET,SAL,SERV,SSN
 I $$GET1^DIQ(2260,IEN,60)="" D
 .S FLD=26,RET="",RET=$$PAID^OOPSUTL1(IEN,FLD)
 .S RET=$S(RET="FULL CSRS":"CSRS",RET="FERS":"FERS",1:"OTHER")
 .S DIE="^OOPS(2260,",DA=IEN,DR="60///^S X=RET" D ^DIE
 I $$GET1^DIQ(2260,IEN,86)="" D
 .S SERV="",SSN=$$GET1^DIQ(2260,IEN,5,"I")
 .I $G(SSN) S IEN200=$O(^VA(200,"SSN",SSN,""))
 .I $G(IEN200) S SERV=$$GET1^DIQ(200,IEN200,29)
 .S DIE="^OOPS(2260,",DA=IEN,DR="86///^S X=SERV" D ^DIE
 I $$GET1^DIQ(2260,IEN,166)="" D
 .S FLD=28,SAL="",SAL=$$PAID^OOPSUTL1(IEN,FLD)
 .S DIE="^OOPS(2260,",DA=IEN,DR="166///^S X=SAL" D ^DIE
 I $$GET1^DIQ(2260,IEN,167)="" D
 .S FLD=19,PAY="",PAY=$$PAID^OOPSUTL1(IEN,FLD)
 .S PAY=$S(PAY="PER ANNUM":"ANNUAL",PAY="PER HOUR":"HOURLY","PER DIEM":"DAILY","BIWEEKLY":"BI-WEEKLY",1:"")
 .S DIE="^OOPS(2260,",DA=IEN,DR="167///^S X=PAY" D ^DIE
 I $$GET1^DIQ(2260,IEN,63)="",($$GET1^DIQ(2260,IEN,2,"I")<3) D
 .S CAT=$$GET1^DIQ(2260,IEN,2,"I")
 .I CAT=1 S PAYP=$$PAID^OOPSUTL1(IEN,20) I $G(PAYP)'="" S PAYP=$$PAYP^OOPSUTL1(PAYP)
 .I CAT=2 S PAYP="VO"
 .S DIE="^OOPS(2260,",DA=IEN,DR="63///^S X=PAYP" D ^DIE
 I $$GET1^DIQ(2260,IEN,111)="" D
 .S FLD=16,OCCD="",OCCD=$$PAID^OOPSUTL1(IEN,FLD)
 .S DIE="^OOPS(2260,",DA=IEN,DR="111///^S X=OCCD" D ^DIE
 Q
VALEMP(RESULTS,INPUT) ; This broker call should be used if the Pay
 ;                 Plan = "OT" (other) to determine if the claim
 ;                 can be successfully submitted to DOL.  The PERSONNEL
 ;                 STATUS is assumed to equal 1 (employee)
 S IEN=$P($G(INPUT),U,2),FORM=$P($G(INPUT),U)
 I '$G(IEN)!($G(FORM)="") S RESULTS="Invalid Input, cannot continue." Q
 I $$VALEMP^OOPSUTL6 S RESULTS="Valid" Q
 S RESULTS="Invalid data on claim"
 Q
