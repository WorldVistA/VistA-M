RMPOPAT3 ;HINES-CIOFO/RVD-Detail Display Patient 10-2319 Transaction;11/04/04
 ;;3.0;PROSTHETICS;**70,92,99**;Feb 09, 1996
 ;
 ; RVD 7/8/02 patch #70 - this routine is a copy of RMPRPAT3.
 ;                        For Read Only 2319.
 ; AAC 08/03/04 Patch 92 - Code Set Versioning (CSV) 
 ;Used API=ICDDX^ICDCODE to replace direct calls to global ICD9(80).
 ;
 ;DBIA # 10082 - file #80, global read.
 ;                        
 ;expect ANS,IT(ANS)
 ;          +IT(ANS)=ien of file 660
 ;expect variables from GETPAT^RMPRUTIL
 ;    RMPRSSNE (external form of SSN)
 ;    RMPRNAM (name of patient)
 ;    RMPRDOB
 ;display detailed record
PRINT ;called from RMPOPAT2
 ;get 2319 transaction
 ;
 N DIC,DIQ,DR,DA,RMPRV,RMPRDA,RV
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
 ;example
 ;R19(660,100,.01,"E")=APR 27, 1995
 ;R19(660,100,.02,"E")=FUDGE,CHOCOLATE
 ;RV(440,131,.01,"E")=ORTHOTIC LAB
 ;
 D HDR
 W !,"TYPE OF FORM: ",$G(R19(660,RMPRDA,11,"E"))
 W ?25,"INITIATOR: ",$G(R19(660,RMPRDA,27,"E"))
 ;historical item
 W !,"ITEM DESCRIPTION: ",$G(R19(660,RMPRDA,89,"E"))
 W ?55,"DATE: ",$G(R19(660,RMPRDA,1,"E"))
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
 .W !?15,$G(RV(440,RMPRV,1,"E"))
 .W !?15,$G(RV(440,RMPRV,4.2,"E")),","
 .W ?$X+3,$G(RV(440,RMPRV,4.4,"E")),?$X+5,$G(RV(440,RMPRV,4.6,"E"))
 W !,"DELIVERY DATE: "
 I $D(R19(660,RMPRDA,10,"E")) W R19(660,RMPRDA,10,"E")
 W !
 I '$P(IT(AN),U,3) D
 .W "TOTAL COST: "
 .I $G(R19(660,RMPRDA,14,"E"))'="" W "$"_$J(R19(660,RMPRDA,14,"E"),2)
 .I $G(R19(660,RMPRDA,14,"E"))="" W $S($G(R19(660,RMPRDA,6,"E"))'="":"$"_$J(R19(660,RMPRDA,6,"E"),2),$G(R19(660,RMPRDA,48,"E"))'="":"$"_$J(R19(660,RMPRDA,48,"E"),2),1:"")
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
 .W !,?15,"VENDOR: ",$G(R19(660,RMPRDA,91,"E"))
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
 ;check for changes to item description
 I $G(R19(660,RMPRDA,89,"E"))'=$G(R19(660,RMPRDA,4,"E")) W !,"*** See Above For Original Item Description ***"
 W !,"APPLIANCE: ",$G(R19(660,RMPRDA,4,"E"))
 W !,"PSAS HCPCS: ",$G(R19(660,RMPRDA,4.5,"E"))
 I $P($G(^RMPR(660,RMPRDA,1)),U,4) W ?22,$P($G(^RMPR(661.1,$P(^RMPR(660,RMPRDA,1),U,4),0)),U,2)
 ;added by #69
 ;
 ; PATCH 92 - Code Set Versioning (CSV) changes below
 ; AAC      - 08/03/04
 ;
 S (RMPRICD,RMPRIC9,RMPRCOD,RMPRDAT)="" S RMPRERR=0
 S RMPRDAT=$P($G(^RMPR(660,RMPRDA,0)),U,1)
 I $D(^RMPR(660,RMPRDA,10)) S RMPRIC9=$P(^RMPR(660,RMPRDA,10),U,8)
 I RMPRIC9'="" D
 .S RMPRICD=$$ICDDX^ICDCODE(RMPRIC9,RMPRDAT)
 .S RMPRERR=$P(RMPRICD,U,1)
 .I RMPRERR<0 W !,"ICD-9 Message: ",$P(RMPRICD,U,2)
 W !,"ICD-9 Code: "
 I $G(RMPRICD)'="" W $P(RMPRICD,U,2),?19,$E($P(RMPRICD,U,4),1,55) I $P(RMPRICD,U,10)'>0 W " ","** Inactive ** Date: " S Y=$P(RMPRICD,U,12) D DD^%DT W Y
 ;
 ; End Patch 92
 ;
 W !,"CPT MODIFIER: ",$G(R19(660,RMPRDA,4.7,"E"))
 W !,"DESCRIPTION: ",$G(R19(660,RMPRDA,24,"E"))
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
 S RMOXY=Y
 ;duout,dtout is evaluated in dis+1^rmpopat2
EX1 ;back out through that point to clean up
 K R19,RV,RMPRICC,RMPRICD,RMPRIC9,RMPRCOD,RMPRDAT,RMPRERR,Y W @IOF
 Q
 ;end
