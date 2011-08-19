RCCPCPS ;WASH-ISC@ALTOONA,PA/NYB-Build Patient Statement File ;12/19/96  4:14 PM
V ;;4.5;Accounts Receivable;**34,70,80,48,104,116,149,170,181,190,223,237,219**;Mar 20, 1995;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
EN N CCPC,CNT,DAT,DEB,DIK,END,INADFL,LDT1,LDT3,PCC,PRN,RCDATE,RCT,SVADM,SVAMT,SVINT,SVOTH,SITE,TXT,VAR,X,%
 N RCINFULL,RCINPART S COMM=0
 K ^RCPS(349.2)
 F X="PA","IS" S RCT=$O(^RCT(349.1,"B",X,0)) Q:'RCT  K ^RCT(349.1,+RCT,4),^RCT(349.1,+RCT,5)
 K ^XTMP("RCCPC")
 D DT^DICRW,SITE^PRCAGU
 I '$D(SITE) W !!,"AR SITE PARAMETER ENTRIES NOT DEFINED!",?50 D NOW^%DTC S Y=% D DD^%DT W Y W !!,"COULD NOT PROCESS AR PATIENT STATEMENTS" Q
 D NOW^%DTC S END=%
 S LDT1=$$FPS^RCAMFN01(DT,-1),RCDATE=DT
 S (CNT,DEB)=0,PRN=1
 F  S DEB=$O(^RCD(340,"AB","DPT(",DEB)) Q:DEB=""  D
 .   N AMT,BBAL,BEG,BN,CAT,DESC,ETY,FC,ND,PAT,PBAL,PC
 .   N PDAT,PEND,ST,SVINT,SVADM,SVOTH,ADDR
 .   I $L(+$$SSN^RCFN01(DEB))<5 Q
 .   ;Check for Emergency Response Indicator (ERI) Flag.
 .   N RCDFN S RCDFN=$P($G(^RCD(340,DEB,0)),"^",1) I $$EMERES^PRCAUTL(+RCDFN)]"" Q
 .   S INADFL=0
 .   S (SVADM,SVAMT,SVINT,SVOTH)=0
 .   N REF,SBAL,SDT,TBAL,TN,TTY,X,Y
 .   K ^TMP("PRCAGT",$J)
 .   S BEG=+$$LST^RCFN01(DEB,2)
 .   S LDT3=$S(BEG>0:$$FPS^RCAMFN01($P(BEG,"."),-3),1:0)
 .   I $P(BEG,".")'<$P(RCDATE,".") Q
 .   D NOW^%DTC S END=%
 .   I BEG<1 S PDAT="",BEG=0,PBAL=0
 .   I BEG S PDAT=BEG,BEG=9999999.999999-BEG,PBAL=0 D PBAL^PRCAGU(DEB,.BEG,.PBAL) ;get prev bal
 .   D EN^PRCAGT(DEB,BEG,.END)
 .   S TBAL=0 D TBAL^PRCAGT(DEB,.TBAL) ;get trans bal
 .   S BBAL=0 D BBAL^PRCAGU(DEB,.BBAL) ;get bill bal
 .   S X=$$PRE^PRCAGU(DEB) S PEND=$P(X,U,2),X=+X I X,BBAL D REF^PRCAGD(DEB,X,$G(REP)) Q
 .   I BBAL=0,PEND,-PEND=PBAL+TBAL Q
 .   I BBAL'=(PBAL+TBAL) D EN^PRCAGD(DEB,BBAL,TBAL,PBAL,BEG,$G(REP)) Q
 .   I BBAL'>0,'$D(^TMP("PRCAGT",$J,DEB)) Q
 .   I BBAL=0,$G(SITE("ZERO")) Q
 .   I BBAL<0,BBAL>-.99 Q
 .   I BBAL'<0,'$D(^XTMP("PRCAGU",$J,DEB)),'COMM Q  ;third letter printed,not comment
 .   S TBAL=TBAL+PBAL
 .   I '$D(^RCPS(349.2,0)) S ^(0)="AR CCPC STATEMENTS RECORDS^349.2I^"
 .   S ^RCPS(349.2,DEB,0)=DEB_"^"_$$SSN^RCFN01(DEB)_"^"
 .   S ADDR=$$DADD^RCAMADD(DEB,1) ;get patient's address, confidential if applicable
 .   S ^RCPS(349.2,DEB,1)=$P(ADDR,"^",1,6)
 .   S ST=$P(ADDR,"^",5)
 .   S ^RCPS(349.2,DEB,7)=$P(^RCD(340,DEB,0),U,7) ;large print
 .   I $G(ST)'="" S ST=$O(^DIC(5,"C",ST,0))
 .   I $G(ST)>90 S FC=$P($G(^DIC(5,ST,0)),"^")
 .   S $P(^RCPS(349.2,DEB,1),"^",7)=$G(FC) S:$G(FC)]"" $P(^RCPS(349.2,DEB,1),"^",5)="FX"
 .   S:$G(FC)]"" $P(^RCPS(349.2,DEB,1),"^",6)=$P(ADDR,"^",8)
 .   D NOW^%DTC S $P(^RCPS(349.2,DEB,0),"^",10)=%
 .   S $P(^RCPS(349.2,DEB,0),"^",3)=$$NAM^RCFN01(DEB)
 .   S $P(^RCPS(349.2,DEB,0),"^",4,7)=$S(TBAL'>0:0,1:TBAL)_"^"_PBAL_"^"_TBAL("CH")_"^"_TBAL("PC"),$P(^(0),"^",8)=PBAL+TBAL("CH")+TBAL("PC")+TBAL("RF")
 .   S $P(^RCPS(349.2,DEB,0),"^",13,17)=BBAL("PB")_"^"_BBAL("INT")_"^"_BBAL("ADM")_"^"_BBAL("MF")_"^"_BBAL("CT")
 .   ;
 .   N RCBILLDA,RCDATA1,RCDEBTDA,RCDESC,RCPSDA,RCTOTAL,RCTRANDA,RCTRDATE,VALUE,RCCOM1,RCCOM2,RCCOM3
 .   S RCDEBTDA=DEB
 .   I '$D(^RCPS(349.2,RCDEBTDA,2,0)) S ^(0)="^349.21DA^^"
 .   ;
 .   S RCCOM1=$E($TR($G(SITE("COM1")),"~|^",""),1,80),(RCCOM2,RCCOM3)=""
 .   ; Add second comment line for the GMT-reduced status
 .   I $$GMT^PRCAGST(RCDEBTDA) S RCCOM2="REDUCTION OF INPATIENT COPAYMENT DUE TO GEOGRAPHIC MEANS TEST STATUS"
 .   I TBAL'>0 S RCCOM3=" *THIS IS NOT A BILL*"
 .   I RCCOM1'="",RCCOM2'="" S $E(RCCOM1,80)=" " ;Make sure GMT message will be printed on separate line.
 .   S ^RCPS(349.2,RCDEBTDA,3)=RCCOM1_RCCOM2_RCCOM3
 .   ;
 .   S RCPSDA=0 ; this variable used to set the description on the PS segment
 .   S RCTRDATE=0 F  S RCTRDATE=$O(^TMP("PRCAGT",$J,RCDEBTDA,RCTRDATE)) Q:'RCTRDATE  S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("PRCAGT",$J,RCDEBTDA,RCTRDATE,RCBILLDA)) Q:'RCBILLDA  D
 .   .   I $P($G(^RCPS(349.2,RCDEBTDA,0)),"^",8)<0 S PC(75)=75
 .   .   I $P($G(^PRCA(430,RCBILLDA,6)),"^",2)]"",($P($G(^PRCA(430,RCBILLDA,7)),"^")>0) S PC(1)="01"
 .   .   S CAT=$P($G(^PRCA(430,RCBILLDA,0)),"^",2)
 .   .   S PC=$P($G(^PRCA(430.2,CAT,0)),"^",14)
 .   .   F X=1:1:100 I $P(PC,",",X)'="" S PCC=$P(PC,",",X),PC(+PCC)=PCC Q:PCC=""
 .   .   S PC="",X=0 F  S X=$O(PC(X)) Q:X=""  I $G(PC(X))'="" S PC=PC_PC(X)
 .   .   S $P(^RCPS(349.2,RCDEBTDA,4),"^")=PC
 .   .   ;
 .   .   I $D(^TMP("PRCAGT",$J,RCDEBTDA,RCTRDATE,RCBILLDA,0)) S AMT=+^(0) I AMT D
 .   .   .   ;  get the description for the bill
 .   .   .   K RCDESC D BILLDESC^RCCPCPS1(RCBILLDA)
 .   .   .   ;
 .   .   .   ;  store the description in file 349.2, PS segment
 .   .   .   S RCPSDA=RCPSDA+1
 .   .   .   S $P(^RCPS(349.2,RCDEBTDA,2,RCPSDA,0),"^",1,4)=$P(RCTRDATE,".")_"^"_$G(RCDESC(1))_"^"_$G(AMT)_"^"_$P(^PRCA(430,RCBILLDA,0),"^")
 .   .   .   F X=2:1 Q:$G(RCDESC(X))=""  S RCPSDA=RCPSDA+1,^RCPS(349.2,RCDEBTDA,2,RCPSDA,0)="^"_RCDESC(X)_"^^"
 .   .   ;
 .   .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP("PRCAGT",$J,RCDEBTDA,RCTRDATE,RCBILLDA,RCTRANDA)) D:'RCTRANDA NO Q:'RCTRANDA  D
 .   .   .   ;  get the description for the transaction
 .   .   .   K RCDESC D TRANDESC^RCCPCPS1(RCTRANDA),RCDESC
 .   .   .   ;  if it is an interest/admin charge, summarize it below
 .   .   .   I $G(RCDESC(1))["INTEREST" Q
 .   .   .   ;  get the value of the transaction for the statement
 .   .   .   S VALUE=$$TRANVALU^RCDPBTLM(RCTRANDA)
 .   .   .   S VALUE=$P(VALUE,"^",2)+$P(VALUE,"^",3)+$P(VALUE,"^",4)+$P(VALUE,"^",5)+$P(VALUE,"^",6)
 .   .   .   ;  if it is a suspended (47) or unsuspended (46) transaction, show value
 .   .   .   ;  make suspended charges appear as negative
 .   .   .   S RCDATA1=$G(^PRCA(433,RCTRANDA,1))
 .   .   .   I $P(RCDATA1,"^",2)=47!($P(RCDATA1,"^",2)=46) S VALUE=$P(RCDATA1,"^",5) I $P(RCDATA1,"^",2)=47 S VALUE=-VALUE
 .   .   .   ;  if it is an amended bill, show value
 .   .   .   I $P(RCDATA1,"^",2)=33 S VALUE=$P(RCDATA1,"^",5)
 .   .   .   ;  store the description in file 349.2, PS segment
 .   .   .   S RCPSDA=RCPSDA+1
 .   .   .   S $P(^RCPS(349.2,RCDEBTDA,2,RCPSDA,0),"^",1,5)=$P(RCTRDATE,".")_"^"_$G(RCDESC(1))_"^"_VALUE_"^"_$P(^PRCA(430,RCBILLDA,0),"^")
 .   .   .   F X=2:1 Q:$G(RCDESC(X))=""  S RCPSDA=RCPSDA+1,^RCPS(349.2,RCDEBTDA,2,RCPSDA,0)="^"_RCDESC(X)_"^^"
 .   .   .   ;
 .   .   .   ;  for comment transaction ... not sure what this is for ?
 .   .   .   I $P(RCDATA1,"^",2)=45,$P($G(^PRCA(433,RCTRANDA,5)),"^",2)["your waiver rights" S ^RCPS(349.2,+RCDEBTDA,4)="0150"
 .   ;
 .   ;  if interest, admin, or other, add them here
 .   S X=$G(RCTOTAL("INT"))+$G(RCTOTAL("ADM"))+$G(RCTOTAL("OTH"))
 .   I X>0 D
 .   .   S RCDESC="INTEREST/ADM. CHARGE (Int:"_$J($G(RCTOTAL("INT")),1,2)_" Adm:"_$J($G(RCTOTAL("ADM")),1,2)_" Other:"_$J($G(RCTOTAL("OTH")),1,2)_")"
 .   .   S RCPSDA=RCPSDA+1
 .   .   S ^RCPS(349.2,RCDEBTDA,2,RCPSDA,0)="^"_RCDESC_"^"_$J(X,1,2)
 .   .   S ^RCPS(349.2,RCDEBTDA,2,0)="^349.21DA^"_RCPSDA_"^"_RCPSDA
 .   ;
 .   ;  set 0th node
 .   I RCPSDA S ^RCPS(349.2,RCDEBTDA,2,0)="^349.21DA^"_RCPSDA_"^"_RCPSDA
 .   ;
 .   I RCPSDA'<287 S ^XTMP("RCCPC",0)=DT,^XTMP("RCCPC",RCDEBTDA)="" Q
 .   D NO
 ;
 S DIK="^RCPS(349.2," D IXALL^DIK
 S DEB=0 S DEB=$O(^RCPS(349.2,DEB)) Q:DEB=""  S $P(^(DEB,0),"^",18)=1
 K ^XTMP("PRCAGU",$J,DEB),COMM
 ;
OSTM ;Process old statements
 S DIK="^RCPS(349.2,",DA=0 F  S DA=$O(^XTMP("RCCPC",DA)) Q:'DA  D ^DIK
 K DA
 ;
STATMNT ;Print patient statements
 N IOP,ZTIO,ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH,PRCADEV
 S (IOP,PRCADEV)=$P($G(^RC(342,1,0)),"^",8)
 I IOP]"" D
 .S ZTRTN="STM^RCCPCSTM",ZTDTH=$H,ZTDESC="Print old AR Statements"
 .S %ZIS="N0" D ^%ZIS Q:POP
 .S ZTSAVE("PRCADEV")="" D ^%ZTLOAD,^%ZISC
 Q
 ;
NO ;If there is no activity
 I $G(^RCPS(349.2,+DEB,4))["0150" D
 .S ^RCPS(349.2,+DEB,2,1,0)="^NOTICE: You now have delinquent charges. Please^^"
 .S ^RCPS(349.2,+DEB,2,2,0)="^review Enforcement of Involuntary Collections^^"
 .S ^RCPS(349.2,+DEB,2,3,0)="^on reverse.^^"
 .S ^RCPS(349.2,+DEB,2,0)="^^3^3"
 I $G(^RCPS(349.2,DEB,2,1,0))="" D
 .S ^RCPS(349.2,DEB,2,1,0)="^No Activity in the Last 30 Days!^^"
 .S ^RCPS(349.2,DEB,2,2,0)="^Please refer to previous statement of rights.^^"
 .S ^RCPS(349.2,DEB,2,0)="^^2^2"
 .I $G(^RCPS(349.2,DEB,4))="" S ^(4)="90"
 Q
BUILD ;This is the entry point from the BUILD CCPC file option
 N TDT,QDT,ZTDESC,ZTASK,ZTSK,ZDTDTH,ZTIO,ZTRTN
 S TDT=$O(^RCPS(349.2,0)) I TDT D
 .S TDT=$$ASOF^RCCPCFN($P($G(^RCPS(349.2,+TDT,0)),"^",10))
 .S TDT=$TR($$SLH^RCFN01(TDT),"/","")
 .S TDT("T")=$P($G(^RCT(349,1,0)),"^",10),TDT("T")=$E(TDT("T"),1,4)_$E(TDT("T"),7,8)
 .I TDT("T")=TDT D
 ..W *7,!,"The current file reflects activity as of ",$E(TDT,1,2)_"/"_$E(TDT,3,4)_"/"_$E(TDT,5,8)_".",!
 ..W !,"IT WAS TRANSMITTED ON ",$TR($P($P($G(^RCT(349,1,0)),"^"),".",2,4),".","/"),!
 ..S TDT=$P($G(^RCT(349,1,0)),"^",9)
 ..W !,"For statement date: ",$E(TDT,1,2)_"/"_$E(TDT,3,4)_"/"_$E(TDT,5,8)
 ..W !!,"PLEASE CONTACT CUSTOMER SUPPORT BEFORE PROCEEDING.",!!
TIME S ZTIO="",ZTRTN="EN^RCCPCPS",ZTDESC="Build CCPC Statement File"
 S ZTDTH="" D ^%ZTLOAD Q:$G(ZTSK)=""
 S %H=ZTSK("D") D YMD^%DTC S QDT=X_%
 I (QDT>DT_"."_0800)&(QDT<(DT_"."_1801)) D  G TIME
 .W !!,*7,"You Can Not Queue this Job Between 8:00am and 6:00pm.",!
 .D KILL^%ZTLOAD
 W !,"Queued for Building."
 Q
 ;
RCDESC ;Remove "IN PART" & "IN FULL" from the the bill description
 QUIT:$G(RCDESC(1))=""
 S RCINFULL=" (IN FULL)"
 S RCINPART=" (IN PART)"
 I RCDESC(1)[RCINFULL S RCDESC(1)=$P(RCDESC(1),RCINFULL)_$P(RCDESC(1),RCINFULL,2)
 I RCDESC(1)[RCINPART S RCDESC(1)=$P(RCDESC(1),RCINPART)_$P(RCDESC(1),RCINPART,2)
 Q
