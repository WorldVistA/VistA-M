SDEC09 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
 ;
GETREGA(SDECRET,DFN) ;return basic reg info/demographics for given patient
 ;GETREGA(SDECRET,DFN)  external parameter tag is in SDEC
 ;DFN - Patient ID - Pointer to PATIENT file
 ;Returns IEN^STREET^CITY^STATE^ZIP^NAME^DOB^SSN^HRN
 ;   10 HOMEPHONE^OFCPHONE^MSGPHONE^
 ;   13 NOK NAME^RELATIONSHIP^PHONE^STREET^CITY^STATE^ZIP
 ;   20 DATAREVIEWED^
 ;   21 Medicare#^Suffix
 ;   23 RegistrationComments
 ;   24 GAF - <text> | <GAF score> | <GAF date> | <diagnosis by IEN> | <diagnosis by name>
 ;   25 PRACE  - Patient Race pointer to RACE file 10 | separates entries
 ;   26 PRACEN - Patient Race name from RACE file | separates entries
 ;   27 PETH   - Patient Ethnicity list separated by pipe |
 ;               Pointer to ETHNICITY file 10.2
 ;   28 PETHN  - Patient Ethnicity names separated by pipe |
 ;   29 PCOUNTRY - Country pointer to COUNTRY CODE file
 ;   30 GENDER  - Patient Gender - valid values are MALE  FEMALE
 ;   31 SENSITIVE - Sensitive Record Access data separated by pipe |:
 ;            1. return code:
 ;               -1-RPC/API failed
 ;                  Required variable not defined
 ;                0-No display/action required
 ;                  Not accessing own, employee, or sensitive record
 ;                1-Display warning message
 ;                  Sensitive and DG SENSITIVITY key holder
 ;                  or Employee and DG SECURITY OFFICER key holder
 ;                2-Display warning message/require OK to continue
 ;                  Sensitive and not a DG SENSITIVITY key holder
 ;                  Employee and not a DG SECURITY OFFICER key holder
 ;                3-Access to record denied
 ;                  Accessing own record
 ;                4-Access to Patient (#2) file records denied
 ;                  SSN not defined
 ;            2. display text/message
 ;            3. display text/message
 ;            4. display text/message
 ;   32 SVCCONN  - Patient's Service Connected status
 ;                 YES   NO
 ;   33 SVCCONNP - Patient's Service Connected Percentage
 ;                 Numeric 0-100
 ;   34 BADADD   - BAD ADDRESS INDICATOR
 ;                     1=UNDELIVERABLE
 ;                     2=HOMELESS
 ;                     3=OTHER
 ;                     4=ADDRESS NOT FOUND
 ;
 ;For patient with ien DFN
 ;K ^TMP("SDEC",$J)
 N SDDEMO,SDECI,SDECNOD,SDECNAM,SDSENS,Y
 N PRACE,PRACEN,PETH,PETHN,PCOUNTRY,SVCCONN,SVCCONNP
 S SDECRET="^TMP(""SDEC"","_$J_")"
 K @SDECRET
 S SDECI=0
 ;
 ;S ^TMP("SDEC",$J,0)="T00030IEN^T00030STREET^T00030CITY^T00030STATE^T00030ZIP^T00030NAME^D00030DOB^T00030SSN^T00030HRN"
 S ^TMP("SDEC",$J,0)="T00030IEN^T00030STREET^T00030CITY/STATE^T00030WARD:^T00030ZIP^T00030NAME^D00030DOB^T00030SSN^T00030HRN"
 S ^TMP("SDEC",$J,0)=^TMP("SDEC",$J,0)_"^T00030HOMEPHONE^T00030OFCPHONE^T00030MSGPHONE"
 S ^TMP("SDEC",$J,0)=^TMP("SDEC",$J,0)_"^T00030NOK NAME^T00030RELATIONSHIP^T00030PHONE^T00030STREET^T00030CITY^T00030STATE^T00030ZIP"
 S ^TMP("SDEC",$J,0)=^TMP("SDEC",$J,0)_"^D00030DATAREVIEWED"
 S ^TMP("SDEC",$J,0)=^TMP("SDEC",$J,0)_"^T00030Medicare#^T00030Suffix"
 S ^TMP("SDEC",$J,0)=^TMP("SDEC",$J,0)_"^T00030RegistrationComments^T00100GAF"
 S ^TMP("SDEC",$J,0)=^TMP("SDEC",$J,0)_"^T00030PRACE^T00030PRACEN^T00030PETH^T00030PETHN^T00030PCOUNTRY^T00030GENDER^T00100SENSITIVE"
 S ^TMP("SDEC",$J,0)=^TMP("SDEC",$J,0)_"^T00030SVCCONN^T00030SVCCONNP^T00030BADADD"
 S ^TMP("SDEC",$J,0)=^TMP("SDEC",$J,0)_$C(30)
 ;
 S SDECY="ERROR"
 I '+DFN S ^TMP("SDEC",$J,1)=$C(31) Q
 I '$D(^DPT(+DFN,0)) S ^TMP("SDEC",$J,1)=$C(31) Q
 S SDECY=""
 S $P(SDECY,U)=DFN
 S $P(SDECY,U,23)=""
 S SDECNOD=^DPT(+DFN,0)
 S $P(SDECY,"^",6)=$P(SDECNOD,U) ;NAME
 S $P(SDECY,"^",8)=$P(SDECNOD,U,9) ;SSN
 S Y=$P(SDECNOD,U,3) I Y]""  X ^DD("DD") S Y=$TR(Y,"@"," ")
 S $P(SDECY,"^",7)=Y ;DOB
 S $P(SDECY,"^",9)=""
 I $D(DUZ(2)) I DUZ(2)>0 S $P(SDECY,"^",9)=$P($G(^AUPNPAT(DFN,41,DUZ(2),0)),U,2) ;HRN
 S $P(SDECY,"^",4)=$G(^DPT(+DFN,.1)) ;WARD
 D MAIL
 D PHONE
 D NOK
 D GAF
 D RACELST^SDECU2(DFN,.PRACE,.PRACEN)
 ;S ($P(SDECY,"^",25),PRACE)=$P(SDECNOD,U,6)   ;get race
 S $P(SDECY,U,25)=PRACE
 S $P(SDECY,U,26)=PRACEN
 ;S $P(SDECY,"^",26)=$S(+PRACE:$P($G(^DIC(10,PRACE,0)),U,1),1:"")
 D ETH^SDECU2(DFN,.PETH,.PETHN)   ;get ethnicity
 S:PETH'="" $P(SDECY,"^",27)=PETH
 S:PETHN'="" $P(SDECY,"^",28)=PETHN
 S $P(SDECY,"^",30)=$S($P(SDECNOD,U,2)="M":"MALE",$P(SDECNOD,U,2)="F":"FEMALE",1:"")
 S SDSENS=$$PTSEC^SDECUTL(DFN) S $P(SDECY,"^",31)=SDSENS
 D PDEMO^SDECU2(.SDDEMO,DFN)
 S $P(SDECY,"^",29)=SDDEMO("PCOUNTRY")
 S $P(SDECY,"^",32)=SDDEMO("SVCCONN")
 S $P(SDECY,"^",33)=SDDEMO("SVCCONNP")
 S $P(SDECY,"^",34)=SDDEMO("BADADD")
 ;D DATAREV
 ;D MEDICARE
 ;D REGCMT
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECY_$C(30,31)
 Q
 ;
GAF ;24 determine if GAF score needed
 N GAF,GAFR
 S GAFR=""
 S GAF=$$NEWGAF^SDUTL2(DFN)
 S:GAF="" GAF=-1
 S $P(GAFR,"|",1)=$S(+GAF:"New GAF Required",1:"No new GAF required")
 S $P(GAFR,"|",2)=$P(GAF,U,2)
 S $P(GAFR,"|",3)=$$FMTE^XLFDT($P(GAF,U,3))
 S $P(GAFR,"|",4)=$P(GAF,U,4)
 S $P(GAFR,"|",5)=$P($G(^VA(200,+$P(GAF,U,4),0)),U,1)
 S $P(SDECY,"^",24)=GAFR
 Q
 ;
MAIL N SDECST
 NEW SDECNOD
 Q:'$D(^DPT(+DFN,.11))
 S SDECNOD=^DPT(+DFN,.11)
 Q:SDECNOD=""
 S $P(SDECY,"^",2)=$E($P(SDECNOD,U),1,50) ;STREET
 S $P(SDECY,"^",3)=$P(SDECNOD,U,4) ;CITY
 S SDECST=$P(SDECNOD,U,5)
 I +SDECST,$D(^DIC(5,+SDECST,0)) S SDECST=$P(^DIC(5,+SDECST,0),U,2)
 ;S $P(SDECY,"^",4)=SDECST ;STATE
 S:$L(SDECST) $P(SDECY,"^",3)=$P(SDECY,"^",3)_","_SDECST ;add ,STATE
 S $P(SDECY,"^",5)=$P(SDECNOD,U,6) ;ZIP
 ;S $P(SDECY,"^",29)=$$GET1^DIQ(2,DFN_",",.1173)
 Q
 ;
PHONE ;PHONE 10,11,12 HOME,OFC,MSG
 N SDECNOD
 I $D(^DPT(+DFN,.13)) D
 . S SDECNOD=^DPT(+DFN,.13)
 . S $P(SDECY,U,10)=$P(SDECNOD,U,1)
 . S $P(SDECY,U,11)=$P(SDECNOD,U,2)
 I $D(^DPT(+DFN,.121)) D
 . S SDECNOD=^DPT(+DFN,.121)
 . S $P(SDECY,U,12)=$P(SDECNOD,U,10)
 Q
 ;
NOK ;NOK
 ;   13 NOK NAME^RELATIONSHIP^PHONE^STREET^CITY^STATE^ZIP
 N Y,SDECST,SDECNOD
 I $D(^DPT(+DFN,.21)) D
 . S SDECNOD=^DPT(+DFN,.21)
 . S $P(SDECY,U,13)=$P(SDECNOD,U,1)
 . S $P(SDECY,U,14)=""  ;$$VAL^SDECDIQ1(9000001,DFN,2802)
 . S $P(SDECY,U,15)=$P(SDECNOD,U,9)
 . S $P(SDECY,U,16)=$P(SDECNOD,U,3)
 . S $P(SDECY,U,17)=$P(SDECNOD,U,6)
 . S SDECST=$P(SDECNOD,U,7)
 . I +SDECST D
 . . I $D(^DIC(5,+SDECST,0)) S SDECST=$P(^DIC(5,+SDECST,0),U,2),$P(SDECY,U,18)=SDECST
 . S $P(SDECY,U,19)=$P(SDECNOD,U,8)
 Q
 ;
DATAREV Q  S $P(SDECY,U,20)=""  ;$P($$VAL^SDECDIQ1(9000001,DFN,16651),"@")
 Q
 ;
REGCMT N SDECI,SDECM,SDECR
 Q
 S SDECR=""
 D ENP^SDECDIQ1(9000001,DFN,1301,"SDECM(")
 S SDECI=0 F  S SDECI=$O(SDECM(1301,SDECI)) Q:'+SDECI  D
 . S SDECR=SDECR_" "_SDECM(1301,SDECI)
 S $P(SDECY,U,23)=$TR($E(SDECR,1,1024),U," ") ; MJL 1/17/2007
 Q
 ;
MEDICARE ;
 S $P(SDECY,U,21)="" ;$$VAL^SDECDIQ1(9000003,DFN,.03)
 S $P(SDECY,U,22)="" ;$$VAL^SDECDIQ1(9000003,DFN,.04)
 Q
 ;
GETMCARE(SDECY,DFN) ;
 ;Returns IEN^MEDICARE#^SUFFIX^SUBENTRY#^TYPE^ELIG.BEGIN^ELIG.END |
 ;File is dinum
 ;
 Q
 N ASDGX,C,N,SDECNUM,SDECSUF,SDECBLD
 S SDECNUM=$$VAL^SDECDIQ1(9000003,DFN,.03)
 S SDECSUF=$$VAL^SDECDIQ1(9000003,DFN,.04)
 D ENPM^SDECDIQ1(9000003.11,DFN_",0",".01:.03","ASDGX(")
 S C=1,N=0,SDECBLD=""
 F  S N=$O(ASDGX(N)) Q:'N  D
 . S $P(SDECY,"|",C)=DFN_U_SDECNUM_U_SDECSUF_U_N_U_ASDGX(N,.03)_U_ASDGX(N,.01)_U_ASDGX(N,.02)
 . S C=C+1
 . Q
 Q
 ;
GETPVTIN(SDECY,DFN) ;
 ;Returns IEN^SUBENTRY^INSURER^POLICYNUMBER^ELIG.BEGIN^ELIG.END|...
 ;File is dinum
 ;
 Q
 N ASDGX,C,N
 D ENPM^SDECDIQ1(9000006.11,DFN_",0",".01;.02;.06;.07","ASDGX(")
 S C=1,N=0
 F  S N=$O(ASDGX(N)) Q:'N  D
 . S $P(SDECY,"|",C)=DFN_U_N_U_ASDGX(N,.01)_U_ASDGX(N,.02)_U_ASDGX(N,.06)_U_ASDGX(N,.07)
 . S C=C+1
 . Q
 Q
 ;
DFN(FILE,DFN) ; -- returns ien for file
 Q ""
 I FILE'[9000004 Q DFN
 Q +$O(^AUPNMCD("B",DFN,0))
