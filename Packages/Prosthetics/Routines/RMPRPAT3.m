RMPRPAT3 ;HINES-CIOFO/HNC,RVD - Detail Display Patient 10-2319 Transaction ;11/03/04
 ;;3.0;PROSTHETICS;**3,12,25,28,32,41,69,92,99,90,162,163,168**;Feb 09, 1996;Build 43
 ;
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ; Reference to $$VLT^ICDEX   supported by ICR #5747
 ; 
 ; RVD 4/30/02 patch #69 - add ICD-9 CODE and description in the display.
 ;                         add HCPCS and Short Description.
 ; AAC 08/03/04 Patch 92 - Code Set Versioning (CSV)
 ; RGB 09/14/10 Patch 163 - Add Suspense Date to appliance line item detail
 ;
 ;expect ANS,IT(ANS)
 ;          +IT(ANS)=ien of file 660
 ;expect variables from GETPAT^RMPRUTIL
 ;    RMPRSSNE (external form of SSN)
 ;    RMPRNAM (name of patient)
 ;    RMPRDOB
 ;display detailed record
PRINT ;called from RMPRPAT2
 ;get 2319 transaction
 ;
 N DIC,DIQ,DR,DA,RMPRV,RMPRDA,RV,DESCRPT
 S DIC=660,DIQ="R19",DR=".01:96",DIQ(0)="EN"
 S (RMPRDA,DA)=+IT(ANS)
 D EN^DIQ1
 S DIQ="R19",DR=72,DIQ(0)="I" D EN^DIQ1
 ;get vendor info
 S DA=$P(^RMPR(660,RMPRDA,0),U,9)
 I DA D
 .S DIC=440,DIQ="RV",DR=".01:6",DIQ(0)="EN"
 .S (RMPRV,DA)=$P(^RMPR(660,RMPRDA,0),U,9)
 .D EN^DIQ1
 ;
 ;array defined for record in following format:
 ;R19(filenumber,ien,field,E)=external form of data
 ;RV(filenumber,ien,field,E)=external form of data
 ;example:
 ;R19(660,100,.01,"E")=APR 27, 1995
 ;R19(660,100,.02,"E")=FUDGE,CHOCOLATE
 ;RV(440,131,.01,"E")=ORTHOTIC LAB
 ;
 D HDR
 W !,"TYPE OF FORM: ",$G(R19(660,RMPRDA,11,"E"))
 W ?25,"INITIATOR: ",$G(R19(660,RMPRDA,27,"E"))
 W ?55,"DATE: ",$G(R19(660,RMPRDA,1,"E"))
 ;historical/original item
 ;W !,"ITEM DESCRIPTION: ",$G(R19(660,RMPRDA,89,"E"))
 W !,"DELIVER TO: ",$G(R19(660,RMPRDA,25,"E"))
 W !,"TYPE TRANS: ",$G(R19(660,RMPRDA,2,"E"))
 W ?30,"QTY: ",$G(R19(660,RMPRDA,5,"E"))
 W:$G(R19(660,RMPRDA,29,"E")) ?40,"INVENTORY POINT: ",R19(660,RMPRDA,29,"E"),!
 W ?40,"SOURCE: ",$G(R19(660,RMPRDA,12,"E"))
 ;vendor tracking number
 I $G(R19(660,RMPRDA,11,"E"))="VISA" D
 .W !,"VENDOR TRACKING: ",$G(R19(660,RMPRDA,4.2,"E"))
 .W ?38,"BANK AUTHORIZATION: ",$G(R19(660,RMPRDA,4.3,"E"))
 W !,"VENDOR: ",?15,$G(R19(660,RMPRDA,7,"E"))
 I $D(RV) D
 .W !,"VENDOR PHONE: ",?15,$G(RV(440,RMPRV,5,"E"))
 .W !?15,$G(RV(440,RMPRV,1,"E"))
 .W !?15,$G(RV(440,RMPRV,4.2,"E")),","
 .W ?$X+3,$G(RV(440,RMPRV,4.4,"E")),?$X+5,$G(RV(440,RMPRV,4.6,"E"))
 W !,"DELIVERY DATE: "
 I $D(R19(660,RMPRDA,10,"E")) W R19(660,RMPRDA,10,"E")
 W ?40,"SUSPENSE DATE: " I $D(R19(660,RMPRDA,8.1,"E")) W R19(660,RMPRDA,8.1,"E")   ;Patch RMPR*3*163
 W !
 I '$P(IT(AN),U,3) D
 .W "TOTAL COST: "
 .I $G(R19(660,RMPRDA,14,"E"))'="" W "$"_$J(R19(660,RMPRDA,14,"E"),2)
 .I $G(R19(660,RMPRDA,14,"E"))="" W $S($G(R19(660,RMPRDA,6,"E"))'="":"$"_$J(R19(660,RMPRDA,6,"E"),2),$G(R19(660,RMPRDA,48,"E"))'="":"$"_$J(R19(660,RMPRDA,48,"E"),2),1:"")
 W ?30,"OBL: ",$G(R19(660,RMPRDA,23,"E"))
 ;
 ;lab data
 I $D(^RMPR(660,RMPRDA,"LB")) D
 .N DIC,DIQ,DR,L19,DA
 .S (DA,RMPRLA)=$P(^RMPR(660,RMPRDA,"LB"),U,10)
 .Q:DA=""
 .S DIC=664.1,DIQ="L19",DR="15",DIQ(0)="E"
 .D EN^DIQ1
 .W !,"WORK ORDER: ",$G(R19(660,RMPRDA,71,"E"))
 .W ?40,"RECEIVING STATION: ",$G(R19(660,RMPRDA,70,"E"))
 .W !,"TECHNICIAN: ",$G(L19(664.1,RMPRLA,15,"E"))
 .W !,"TOTAL LABOR HOURS: ",$G(R19(660,RMPRDA,45,"E"))
 .W ?40,"TOTAL LABOR COST: ",$G(R19(660,RMPRDA,46,"E"))
 .W !,"TOTAL MATERIAL COST: ",$G(R19(660,RMPRDA,47,"E"))
 .W ?40,"TOTAL LAB COST: ",$G(R19(660,RMPRDA,48,"E"))
 .W !,"COMPLETION DATE: ",$G(R19(660,RMPRDA,50,"E"))
 .W ?40,"LAB REMARKS: ",$G(R19(660,RMPRDA,51,"E"))
 W !,"REMARKS: ",?15,$G(R19(660,RMPRDA,16,"E"))
 I $G(R19(660,RMPRDA,17.5,"E")) W ?40,"RETURN STATUS: ",R19(660,RMPRDA,17.5,"E")
 ;
 ;historical data
 I $G(R19(660,RMPRDA,15,"E"))["*" D
 .;include records that have been merged
 .W !!,"HISTORICAL DATA",!
 .Q:'$D(R19(660,RMPRDA,89))
 .W !,?15,"ITEM: ",$G(R19(660,RMPRDA,89,"E"))
 .W !,?15,"STATION: ",$G(R19(660,RMPRDA,90,"E"))
 .W !,?15,"VENDOR: ",$G(R19(660,RMPRDA,91,"E")),"   PHONE: ",$G(R19(660,RMPRDA,92,"E"))
 .W !,?23,$G(R19(660,RMPRDA,93,"E")),!,?23,$G(R19(660,RMPRDA,94,"E"))
 .W "   ",$G(R19(660,RMPRDA,95,"E")),"  ",$G(R19(660,RMPRDA,96,"E"))
 ;put in lab display here fields 45,46,47,48 and 51
 ;lab amis
 I $G(R19(660,RMPRDA,73,"E")) D
 .W ?40,"ORTHOTICS LAB CODE: "
 .W $S($D(R19(660,RMPRDA,74,"E")):R19(660,RMPRDA,74,"E"),$D(R19(660,RMPRDA,75,"E")):R19(660,RMPRDA,75,"E"),1:"")
 .W !?40,"RESTORATIONS LAB CODE: "
 .W $S($D(R19(660,RMPRDA,76,"E")):R19(660,RMPRDA,76,"E"),$D(R19(660,RMPRDA,77,"E")):R19(660,RMPRDA,77,"E"),1:"")
 ;purchasing and issue from stock amis
 W !,"DISABILITY SERVED: ",$G(R19(660,RMPRDA,62,"E"))
 ;appliance/item information
 ;historical/original item
 W !,"ITEM DESCRIPTION: ",$G(R19(660,RMPRDA,89,"E"))
 ;check for item description changes
 I $G(R19(660,RMPRDA,89,"E"))'=$G(R19(660,RMPRDA,4,"E")) W !,"*** See Above For Original Item Description ***"
 W !,"APPLIANCE: ",$G(R19(660,RMPRDA,4,"E"))
 W !,"CONTRACT #: ",$G(R19(660,RMPRDA,38.7,"E"))
 W !,"EXCLUDED/WAIVER: ",$G(R19(660,RMPRDA,38.1,"E"))
 W !,"PSAS HCPCS: ",$G(R19(660,RMPRDA,4.5,"E"))
 I $P($G(^RMPR(660,RMPRDA,1)),U,4) W ?22,$P($G(^RMPR(661.1,$P(^RMPR(660,RMPRDA,1),U,4),0)),U,2)
 ; added by #69
 ;
 ; PATCH 92 - Code Set Versioning (CSV) changes below
 ; AAC      - 08/03/04
 ; Changes for ICD-10 Class I Remediation Project
 ;
 N RMPRACS,RMPRACSI,RMPRCNT,RMPRDAT,RMPRDATA,RMPRERR,RMPRICD,RMPRSICD
 N RMPRPROD,RMPRTOR,RMPRTXT1
 S (RMPRACS,RMPRACSI,RMPRDAT,RMPRDATA,RMPRICD,RMPRSICD)=""
 S (RMPRPROD,RMPRTOR,RMPRTXT1)=""
 S RMPRERR=0
 S RMPRDAT=$P($G(^RMPR(660,RMPRDA,0)),U,1)
 ; Determine Active Coding System based on Date of Interest
 S RMPRACS=$$SINFO^ICDEX("DIAG",RMPRDAT) ; Supported by ICR 5747
 S RMPRACSI=$P(RMPRACS,U,1)
 S RMPRACS=$P(RMPRACS,U,2)
 S RMPRACS=$S(RMPRACS="ICD-9-CM":"ICD-9 ",RMPRACS="ICD-10-CM":"ICD-10 ",1:"ICD: ")
 ;
 ; Load Suspense data
 S RMPRDATA=$G(^RMPR(660,RMPRDA,10))
 I RMPRDATA'="" D
 .S RMPRTOR=$P(RMPRDATA,U,5) ; TYPE OF REQUEST #8.5
 .S RMPRPROD=$P(RMPRDATA,U,7) ; PROVISIONAL DIAGNOSIS #8.7
 .S RMPRSICD=$P(RMPRDATA,U,8) ; SUSPENSE ICD #8.8
 ;
 ; If SUSPENSE ICD existed, retrieve data
 I RMPRSICD'="" D
 .; Use new API to return ICD Data
 .S RMPRICD=$$ICDDX^ICDEX(RMPRSICD,RMPRDAT,RMPRACSI,"I") ; Supported by ICR 5747
 .S RMPRERR=$P(RMPRICD,U,1)
 .; Update error message to display either ICD-9 or ICD-10 based on Date Of Interest
 .I RMPRERR<0 W !,RMPRACS_"Message: "_$P(RMPRICD,U,2) Q
 .; Retrieve full ICD Description
 .S RMPRTXT(2)=$$VLT^ICDEX(80,+RMPRICD,RMPRDAT) ; Supported by ICR 5747
 ;
 ; Check for Manual Suspense and adjust line label if needed
 S RMPRTXT(1)=$S(RMPRTOR="MANUAL"&(RMPRSICD=""):"MANUAL SUSPENSE: ",1:RMPRACS_"CODE: ")
 ;
 I +$G(RMPRSICD) D
 .S RMPRTXT(1)=RMPRTXT(1)_$P(RMPRICD,U,2)_"  "
 .;
 .; Process SUSPENSE ICD
 .I $P(RMPRICD,U,10)'>0 D
 ..S Y=$P(RMPRICD,U,12) ; Inactive Date
 ..D DD^%DT
 ..S RMPRTXT(3)="  ** Inactive ** Date: "_Y
 .;
 .; Parse ICD data into 80 char array
 .D PARSE^RMPOPED(.RMPRTXT)
 ;
 ; Loop to display ICD and Suspense info
 F RMPRCNT=1:1 Q:'$D(RMPRTXT(RMPRCNT))  W !,RMPRTXT(RMPRCNT)
 K RMPRTXT
 ;
 ; End of Patch 92 & ICD-10 mods
 ; 
 W !,"CPT MODIFIER: ",$G(R19(660,RMPRDA,4.7,"E"))
 ;set description and modify for SHIPPING CHARGE; patch RMPR*3.0*162
 S DESCRPT=$G(R19(660,RMPRDA,24,"E")) S:$P(^RMPR(660,RMPRDA,0),U,17) DESCRPT="SHIPPING CHARGE"
 W !,"DESCRIPTION: ",DESCRPT
 W !,"EXTENDED DESCRIPTION: ",!
 I $D(R19(660,RMPRDA,28)) D  G:$D(DUOUT)!$D(DTOUT) EX1
 .N R28
 .;command part of new standards
 .MERGE R28=R19(660,RMPRDA,28)
 .I $P($G(^RMPR(660,RMPRDA,"DES",0)),U,3)>1 N DIR S DIR(0)="E" D ^DIR Q:$D(DUOUT)!$D(DTOUT)  D HDR W !,"EXTENDED DESCRIPTION: ",!
 .D EN^DDIOL(.R28)
 ;NPPD key items consolidated, example L5300 limb order
 I $P(IT(AN),U,3) W !!,"*** Return For DETAIL REPORT ***" N DIR S DIR(0)="E" D ^DIR G:$D(DUOUT)!$D(DTOUT) EX1  W @IOF D HDR,^RMPRPAT7
 ;display work order if it is a 2529-3 form
 ;must pass ien to file 664.1 NOT 664.2
 I $G(R19(660,RMPRDA,72,"I"))'="" D  G EX1
 .S DIR(0)="E" D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 .S RMPRBCK=RMPRDA
 .N DIC
 .S RMPRDA=R19(660,RMPRBCK,72,"I")
 .D DISP^RMPR293(RMPRDA)
 .S RMPRDA=RMPRBCK K RMPRBCK
 ;return from work order
 G EXIT
 ;
HDR ;display heading
 W @IOF,RMPRNAM,?30," SSN: "
 W $E(RMPRSSN,1,3)_"-"_$E(RMPRSSN,4,5)_"-"_$E(RMPRSSN,6,10),?50
 W $G(R19(660,RMPRDA,8,"E")),?70,"DOB: "
 W $S(RMPRDOB:$E(RMPRDOB,4,5)_"-"_$E(RMPRDOB,6,7)_"-"_(1700+$E(RMPRDOB,1,3)),1:"Unknown")
 W !?20,"APPLIANCE/REPAIR LINE ITEM DETAIL ",?70,"<4-",ANS,">",!
 Q
EXIT ;common exit point
 I $Y>(IOSL-4) F  W ! Q:$Y>(IOSL-3)
 N DIR S DIR(0)="E" D ^DIR
 ;duout,dtout is evaluated in dis+1^rmprpat2
EX1 ;back out through that point to clean up
 K R19,RV,RMPRICD,RMPRICD,MSGICD,RMPRERR,Y W @IOF
 Q
 ;end
