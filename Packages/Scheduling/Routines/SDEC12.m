SDEC12 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
AVADD(SDECY,SDECSTART,SDECEND,SDECTYPID,SDECRES,SDECSLOTS,SDECNOTE) ;Create entry in SDEC ACCESS BLOCK
 ;AVADD(SDECY,SDECSTART,SDECEND,SDECTYPID,SDECRES,SDECSLOTS,SDECNOTE)  external parameter tag is in SDEC
 ;INPUT:
 ; SDECSTART - (required) SDEC ACCESS BLOCK start date/time
 ; SDECEND   - (required) SDEC ACCESS BLOCK end date/time
 ; SDECTYPID - (required) ACCESS TYPE ien - pointer to the SDEC ACCESS TYPE file
 ; SDECRES   - (required) Resource Name from the NAME field of the
 ;                        SDEC RESOURCE file
 ; SDECSLOTS - (required) Value added to the SLOTS field of the
 ;                       SDEC ACCESS BLOCK file (must be 0-99)
 ; SDECNOTE  - (optional) Represents a note; will be converted to a WP field
 ;
 ;RETURN:
 ; Recordset having fields
 ; AvailabilityID and ErrorNumber
 ;
 ;
 N SDAB,SDECERR,SDECIEN,SDECDEP,SDECI,SDECAVID,SDECI,SDECERR,SDECFDA,SDECMSG,SDECRESD,SDECTMP
 N SDI,SDNOD,%DT,X,Y
 K ^TMP("SDEC",$J)
 S SDECERR=0
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="I00020AVAILABILITYID^I00020ERRORID"_$C(30)
 ;Check input data for errors
 S:SDECSTART["@0000" SDECSTART=$P(SDECSTART,"@")
 S:SDECEND["@0000" SDECEND=$P(SDECEND,"@")
 S %DT="RXT",X=SDECSTART D ^%DT S SDECSTART=Y
 I SDECSTART=-1 D ERR(70) Q
 S %DT="RXT",X=SDECEND D ^%DT S SDECEND=Y
 I SDECEND=-1 D ERR(70) Q
 I $L(SDECEND,".")=1 D ERR(70) Q
 I SDECSTART>SDECEND S SDECTMP=SDECEND,SDECEND=SDECSTART,SDECSTART=SDECTMP
 I $P(SDECSTART,".",1)'=$P(SDECEND,".",1) D ERR(70) Q
 ;Validate Access Type
 I '+SDECTYPID D ERR(70) Q
 I '$D(^SDEC(409.823,+SDECTYPID,0)) D ERR(70) Q
 ;Validate Resource
 I '$D(^SDEC(409.831,"B",SDECRES)) S SDECERR=70 D ERR(SDECERR) Q
 S SDECRESD=$O(^SDEC(409.831,"B",SDECRES,0)) I '+SDECRESD S SDECERR=70 D ERR(SDECERR) Q
 S SDNOD=$G(^SDEC(409.831,SDECRESD,0))
 I $P($P(SDNOD,U,11),";",2)'="SC(" D ERR(70) Q  ;only add to clinics
 ;Validate SDECSLOTS
 S SDECSLOTS=$G(SDECSLOTS,0)
 ;get current slots for the day
 S SDAB="^TMP("_$J_",""SDEC"",""BLKS"")"
 K @SDAB
 D GETSLOTS^SDEC04(SDAB,SDECRESD,$P(SDECSTART,".",1),$P(SDECEND,".",1)_".2359")
 S SDI=$P($G(@SDAB@("CNT")),U,1)+1
 S @SDAB@(SDI)=U_SDECSTART_U_SDECEND_U_SDECSLOTS_U_SDECTYPID
 ;
 ;update AVAILABILITY in file 44 for clinic type resource
 D AV44($P(SDECSTART,".",1),$P(SDNOD,U,4),SDECRESD)
 ;
 ;Return Recordset
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECAVID_"^-1"_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
AV44(SDAY,SDCL,SDRES)  ;update AVAILABILITY in file 44
 N SDAB,SDAPL,SDI,SDJ,SDNOD
 N CNT,LAST,H1,H2,M1,M2
 S SDAPL=$$GET1^DIQ(44,SDCL_",",1912,"I")
 ;delete all slots for the day in file 44
 D DEL(SDCL,SDAY_".0001",SDAY_".2359")
 ;add all blocks for the day to file 44
 S CNT=0
 S SDI=0 F  S SDI=$O(@SDAB@(SDI)) Q:SDI'>0  D
 .S SDNOD=@SDAB@(SDI)
 .Q:'$P(SDNOD,U,4)
 .S H1=$E($P($P(SDNOD,U,2),".",2),1,2) S:H1?1N H1=H1_"0"
 .S M1=$E($P($P(SDNOD,U,2),".",2),3,4) S:M1?1N M1=M1_"0" S:M1="" M1="00"
 .S H2=$E($P($P(SDNOD,U,3),".",2),1,2) S:H2?1N H2=H2_"0"
 .S M2=$E($P($P(SDNOD,U,3),".",2),3,4) S:M2?1N M2=M2_"0" S:M2="" M2="00"
 .D AVA(.CNT,SDCL,SDAY,H1_M1,H2_M2,$P(SDNOD,U,4),SDAPL)
 ;update zero node for day
 I +CNT S ^SC(SDCL,"T",SDAY,2,0)="^44.004A^"_CNT_"^"_CNT
 ;update zero node for "T"
 S (CNT,LAST,SDI)=0 F  S SDI=$O(^SC(SDCL,"T",SDI)) Q:SDI'>0  D
 .S LAST=SDI,CNT=CNT+1
 S ^SC(SDCL,"T",0)="^44.002DA^"_LAST_"^"_CNT
 D CA(SDCL,SDAY)
 Q
CA(SDCL,SDAY)  ;set current availability in PATTERN if does not already exist
 N D,D0,DA,DH,DO,DOW,SDREACT,SI,SL,STARTDAY,%DT,X,Y N CTR,OK
 S DA=SDCL
 S D0=SDAY
 S SL=^SC(DA,"SL")
 S D=$P(SL,U,6),SI=$S(D:D,1:4)
 S DH=SL*SI\60
 S STARTDAY=$$GET1^DIQ(44,DA_",",1914) S:STARTDAY="" STARTDAY=8
 ;build pattern from AVAILABILITY; from SDB0
 F X=0:0 S X=$O(^SC(DA,"T",D0,2,X)) Q:X'>0  S Y=^(X,0) F D=1:1:DH S Y(Y#100*SI\60+(Y\100*SI)-(STARTDAY*SI)+D)=$S($P(Y,U,2):$E("123456789jklmnopqrstuvwxyz",$P(Y,U,2)),1:0)
 S (DH,DO,X)=""
 ;I $D(HSI) I HSI=1!(HSI=2) D CKSI1^SDB0
 F Y=1:1 S DH=$D(Y(Y)),X=X_$S('DH&DO:"]",'DO&DH:"[",Y#SI=1:"|",1:" ")_$S(DH:Y(Y),1:" "),DO=DH I 'DH,$O(Y(Y))'>0 Q
 K Y
 S DH=X,OK=0,CTR=0
 S D=D0,X=D0,DO=$$FMADD^XLFDT(X,1)
 S X=D,Y="" D DOW^SDM0 S DOW=Y
 S ^SC(DA,"ST",X,9)=D,SDREACT=1 S:'$D(^SC(DA,"ST",0)) ^(0)="^44.005DA^^" D B1^SDB1
 Q
AVA(CNT,SDCL,SDAY,T1,T2,SDSLOTS,SDAPL)  ;add block to AVAILABILITY
 N ADF,FM,H1,M1,SDTIME
 Q:'SDSLOTS
 S ADF=0
 I '$D(^SC(SDCL,"T",SDAY,0)) S ^SC(SDCL,"T",SDAY,0)=SDAY S ADF=1
 S SDTIME=T1
 F  Q:(SDAY_"."_SDTIME)>(SDAY_"."_T2)  D
 .S CNT=CNT+1 S ^SC(SDCL,"T",SDAY,2,CNT,0)=SDTIME_"^"_SDSLOTS
 .S FM=SDAY_"."_SDTIME S FM=$$FMADD^XLFDT(FM,,,SDAPL)
 .S H1=$E($P(FM,".",2),1,2) S:H1?1N H1=H1_"0"
 .S M1=$E($P(FM,".",2),3,4) S:M1?1N M1=M1_"0" S:M1="" M1="00"
 .S SDTIME=H1_M1
 Q
 ;
DEL(SDCL,SDBEG,SDEND)  ;delete AVAILABILITY from file 44
 N AV,D1,D2,DIK,H1,H2,M1,M2,SDAY,SDI,SDNOD
 S SDAY=$P(SDBEG,".",1)
 Q:'$D(^SC(SDCL,"T",SDAY))
 S H1=$E($P(SDBEG,".",2),1,2) S:H1?1N H1=H1_"0"
 S M1=$E($P(SDBEG,".",2),3,4) S:M1?1N M1=M1_"0" S:M1="" M1="00"
 S H2=$E($P(SDEND,".",2),1,2) S:H2?1N H2=H2_"0"
 S M2=$E($P(SDEND,".",2),3,4) S:M2?1N M2=M2_"0" S:M2="" M2="00"
 ;array of existing blocks
 S SDI=0 F  S SDI=$O(^SC(SDCL,"T",SDAY,2,SDI)) Q:SDI'>0  D
 .S AV($P($G(^SC(SDCL,"T",SDAY,2,SDI,0)),U,1))=SDI
 Q:'$D(AV)
 S D1=$G(AV(H1_M1),1),D2=$G(AV(H2_M2),999)
 S SDI=D1-1 F  S SDI=$O(^SC(SDCL,"T",SDAY,2,SDI)) Q:SDI'>0  Q:SDI>D2  D
 .S DIK="^SC("_SDCL_",""T"","_SDAY_",2,"
 .S DA=SDI
 .D ^DIK
 Q
 ;
DAY ;;^SUN^MON^TUES^WEDNES^THURS^FRI^SATUR
 ;
ERR(ERRNO) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)="0^"_ERRNO_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
