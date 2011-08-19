PRSRUTL ;HISC/JH,WCIOFO/JAH-UTILITY FOR PAID ADDIM. REPORTS ;10/16/97
 ;;4.0;PAID;**2,16,24**;Sep 21, 1995
CHKTLE ;CHECK IF SELECTED EMP. IS ASSIGNED TO USER
 S (STFSW,TL)=0 F  S TL=$O(TLE(TL)) Q:TL'>0  D  Q:STFSW
 .  S TL(1)=0 F  S TL(1)=$O(TLE(TL,TL(1))) Q:TL(1)'>0  D  Q:STFSW
 ..  I $P(TLE(TL,TL(1)),U)=D0 S NAM=$P(TLE(TL,TL(1)),U,2),STFSW=1 Q
 ..  Q
 .  Q
 W:'STFSW !?2,$C(7),"EMPLOYEE NOT ASSIGNED TO THAT T&L.",!
 Q
QUERY N DA,I,X W @IOF,!!,"T&L's Assigned to you.",! S DA=0 F  S DA=$O(TLE(DA)) Q:DA'>0  D
 .  D:$Y>(IOSL-4) RTN W !?2,$P(TLE(DA),U)
 .  Q
 Q
RTN R !!,"Press Enter/Return to continue. ",X:DTIME Q:'$T
 Q
STAFF(X) ;This utility will pass back an employees' STATION (if no duty station) ^ STATION_"."_DUTY STATION (if duty station) ^ ORGANIZATION ^
 ; SERVICE ^ TITLE '
 ;Input - D STAFF^PRSRUTL(.veriable), whereas 'veriable' is the
 ;                                    employees Duz No.
 ;Output - variable = 'station_"."_duty station^T&L^organization^service^title'
 N STA,TLE,COS,COSORG,DTX,DA,ORG Q:X'>0  S STA=$P($G(^PRSPC(X,0)),"^",7),TLE=$P($G(^(0)),U,8),COSORG=$P(^(0),"^",49),DTY=$P($G(^(1)),U,42),Y=$P($G(^(0)),U,17) I Y'="" D OST^PRSDUTIL
 I TLE'="" S DA=0,DA=$O(^PRST(455.5,"B",TLE,0)),TLE=$P($G(^PRST(455.5,DA,0)),U,2)
 S COS=$S(COSORG'="":$E(COSORG,1,4),1:""),ORG=$S(COSORG'="":$E(COSORG,5,8),1:"")
 I ORG'="" S ORG=$O(^PRSP(454,1,"ORG","B",COS_":"_ORG,"")),ORG=$P(^PRSP(454,1,"ORG",ORG,0),"^",2),ORG=$P(^PRSP(454.1,ORG,0),"^")
 S X=$S(DTY'="":STA_"."_DTY,1:STA)_U_DA_U_TLE_U_Y_U_ORG Q
DTY(DTY) ;This utility will pass back an employees 'duty station'.
 ;Input - D DTY^PRSRUTL(.variable), whereas 'variable' is the
 ;                                  employees' Duz No.
 ;Output - variable = employees' duty station.
 S DTY=$P($G(^PRSPC(DTY,1)),U,42) Q
UPPER(X) ;Convert contents in x to upper case.
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
CKSTOP S:$$S^%ZTLOAD ZTSTOP=1 Q
ST D HOME^%ZIS Q
DUZ S PRSRDUZ="",SSN=$P($G(^VA(200,DUZ,1)),"^",9) I SSN'="" S PRSRDUZ=$O(^PRSPC("SSN",SSN,0))
 I 'PRSRDUZ W !!,*7,"Your SSN was not found in Employee File!"
 I SSN="" W !!,*7,"Your SSN was not found in the New Person File!"
 Q
CCORG(EMP0NODE) ;pass employees 0 node from file 450 EMP0NODE
 ;function returns employees cost center organization
 ; description (dx) from file 454.1.  returns code if no dx. 
 ; added in patch 16 by John Heiges
 ; EMP0NODE = the employee data from the zero node in file 450
 ;
 ; get piece 49 (field 458 in file 450, employees cost center/organiz)
 S COSORG=$P(EMP0NODE,"^",49)
 S COS=$S(COSORG'="":$E(COSORG,1,4),1:"")
 S ORG=$S(COSORG'="":$E(COSORG,5,8),1:"")
 I ORG'="" D
 .  ;look up ccoc description.  If no dx, just display ccoc.
 .  N ORGDX
 .  S ORGDX=$O(^PRSP(454,1,"ORG","B",COS_":"_ORG,""))
 .  ;ptr 2 ccoc description
 .  I ORGDX'="" S ORGDX=$P($G(^PRSP(454,1,"ORG",ORGDX,0)),"^",2)
 .  I ORGDX'="" S ORG=$P(^PRSP(454.1,ORGDX,0),"^")
 .  E  S ORG=COS_":"_ORG
 Q ORG
CCORGBUL(CODE,RPTDUZ,REPORT,EMP) ;
 ;This routine is invoked when the cost center organization code
 ;description is missing during the running of the EMPLOYEE LEAVE USED
 ;and the EMPLOYEE LEAVE PATTERN report.  It sends a bulleting to
 ;the PAD mail group asking them to fix it.
 ;
 ;EMP  = the employee who's leave is being looked at in the report
 ;CODE = cost center/organization code
 ;RPTDUZ = person who is running the report.
 ;REPORT : 1 = EMPLOYEE LEAVE USED, 0 = EMPLOYEE LEAVE PATTERN
 ;
 N TXT,I,XMDUZ,XMB,XMY,XMDUZ
 S XMY("G.PAD@"_^XMB("NETNAME"))=""
 S XMDUZ="DHCP PAID PACKAGE"
 S XMB="PRS UPDATE CCORG"
 S XMB(1)=CODE,XMB(2)=$P($G(^PRSPC(RPTDUZ,0)),"^",1)
 I REPORT>0 S XMB(3)="``Employee Leave Requested''"
 S XMB(4)=EMP
 E  S XMB(3)="``Employee Leave Pattern''"
 D ^XMB
 Q
