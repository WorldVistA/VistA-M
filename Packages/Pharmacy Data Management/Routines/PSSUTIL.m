PSSUTIL ;BIR/RTR-utility routine for NDF changes ;04/04/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**34,38,147,155,170,243,226**;9/30/97;Build 10
 ;
 ;Reference to PS(50.607 supported by DBIA 2221
 ;
 ;*226- create Hazardous Handle & Dispose API for Drugs/Orderable Items; and Haz Warning text for dialogs in Backdoor
 ;
EN(PSSDIEN) ;Receive Drug entries unmatched as a result of NDF changes
 ;Not called, NDF deletes the possible and local possible dosages
 Q
EN1(PSSDIEN,PSSTALK) ;Receive Drug entries that have been unmatched
 N PSSLD,PSSLOCV,PSSPWXEX
 S PSSLOCV=$O(^PS(59.7,0))
 ;I $P($G(^PS(59.7,+$G(PSSLOCV),80)),"^",3)<2 Q
 W !!,"Deleting Possible Dosages.."
 K ^PSDRUG(PSSDIEN,"DOS"),^PSDRUG(PSSDIEN,"DOS1")
 H 1 W "."
 I '$G(PSSTALK) K ^PSDRUG(PSSDIEN,"DOS2") G EQ
 I '$O(^PSDRUG(PSSDIEN,"DOS2",0)) W !
 I $O(^PSDRUG(PSSDIEN,"DOS2",0)) D DASK D  W ! K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Delete these Local Possible Dosages" D ^DIR K DIR I Y=1 W !!,"Deleting Local Possible Dosages.." K ^PSDRUG(PSSDIEN,"DOS2") H 1 W "." W ! G EQ
 .S PSSPWXEX=0 W !!,"LOCAL POSSIBLE DOSAGES:"
 .W ! F PSSLD=0:0 S PSSLD=$O(^PSDRUG(PSSDIEN,"DOS2",PSSLD)) Q:'PSSLD!(PSSPWXEX)  D
 ..D:($Y+5)>IOSL ZASK Q:PSSPWXEX  W !,$P($G(^PSDRUG(PSSDIEN,"DOS2",PSSLD,0)),"^")_"   "_$S($P($G(^(0)),"^",2)="":"(No package)",1:"(Package -> "_$P($G(^(0)),"^",2)_")") D DOSEADD
 I $O(^PSDRUG(PSSDIEN,"DOS2",0)) W !!,"Local Possible Dosages not deleted.",!
EQ Q
EN2(PSSDIEN,PSSTALK) ;Receive Drug entries matched to NDF
 ;Do we need entry point on an Orderable Item match (not matched to NDF)
 Q:'$D(^PSDRUG(PSSDIEN,0))
 K ^PSDRUG(PSSDIEN,"DOS"),^PSDRUG(PSSDIEN,"DOS1")
 N PSSUPRA,PSSLOC,PSSO,PSSI,PSSND,PSSND1,PSSBOTH,PSSONLYI,PSSONLYO,PSSNODE,PSSDF,PSSST,PSSUN,PSSTOT,PSSTOTX,PSSDUPD,PSSTODOS,PSSFLAG
 S PSSLOC=$O(^PS(59.7,0))
 ;I $P($G(^PS(59.7,+$G(PSSLOC),80)),"^",3)<3 Q
 S PSSBOTH=1
 S (PSSONLYI,PSSONLYO,PSSFLAG)=0,PSSUPRA=""
 S PSSND=$P($G(^PSDRUG(PSSDIEN,"ND")),"^",3),PSSND1=$P($G(^("ND")),"^") I 'PSSND!('PSSND1) G LOC
 S PSSNODE=$$DFSU^PSNAPIS(PSSND1,PSSND) S PSSDF=$P(PSSNODE,"^"),PSSST=$P(PSSNODE,"^",4),PSSUN=$P(PSSNODE,"^",5)
 S PSSUPRA=$$SUPRA^PSSUTIL3(PSSND)
 I $G(PSSTALK) W !!,"Resetting Possible Dosages..",! D  K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 .I PSSUPRA="NO",$G(PSSXYZ)=1 W !,"Due to National Drug File settings only ONE possible dosage was auto-created.",!,"If other dosages are needed, create POSSIBLE DOSAGES or LOCAL POSSIBLE ",!,"DOSAGES as appropriate.",!
 .I PSSUPRA="NB",$G(PSSXYZ)=1 W !,"Due to National Drug File settings TWO possible dosages were auto-created.",!
 I 'PSSDF!('PSSUN)!($G(PSSST)="") G LOC
 I '$D(^PS(50.606,PSSDF,0))!('$D(^PS(50.607,PSSUN,0))) G LOC
 I PSSST'?.N&(PSSST'?.N1".".N) G LOC
 S (PSSI,PSSO)=0
 I $D(^PS(50.606,"ACONI",PSSDF,PSSUN)),$O(^PS(50.606,"ADUPI",PSSDF,0)) S PSSI=1
 I $D(^PS(50.606,"ACONO",PSSDF,PSSUN)),$O(^PS(50.606,"ADUPO",PSSDF,0)) S PSSO=1
 I 'PSSO,'PSSI G LOC
 I PSSUPRA="NN" S ^PSDRUG(PSSDIEN,"DOS")=PSSST_"^"_PSSUN Q
 I PSSUPRA="NO"!(PSSUPRA="NB") G EN2^PSSUTIL3
 I PSSI,'PSSO D  S:PSSTOT>1 PSSTOTX=PSSTOT-1,^PSDRUG(PSSDIEN,"DOS")=PSSST_"^"_PSSUN,PSSONLYO=1,PSSBOTH=0,^PSDRUG(PSSDIEN,"DOS1",0)="^50.0903^"_$G(PSSTOTX)_"^"_$G(PSSTOTX) G LOC
 .S PSSTOT=1 F PSSDUPD=0:0 S PSSDUPD=$O(^PS(50.606,"ADUPI",PSSDF,PSSDUPD)) Q:'PSSDUPD  D
 ..S PSSTODOS=PSSDUPD*PSSST
 ..S ^PSDRUG(PSSDIEN,"DOS1",PSSTOT,0)=PSSDUPD_"^"_PSSTODOS_"^I",^PSDRUG(PSSDIEN,"DOS1","B",PSSDUPD,PSSTOT)="" S PSSTOT=PSSTOT+1
 I PSSO,'PSSI D  S:PSSTOT>1 PSSTOTX=PSSTOT-1,^PSDRUG(PSSDIEN,"DOS")=PSSST_"^"_PSSUN,PSSONLYI=1,PSSBOTH=0,^PSDRUG(PSSDIEN,"DOS1",0)="^50.0903^"_$G(PSSTOTX)_"^"_$G(PSSTOTX) G LOC
 .S PSSTOT=1 F PSSDUPD=0:0 S PSSDUPD=$O(^PS(50.606,"ADUPO",PSSDF,PSSDUPD)) Q:'PSSDUPD  D
 ..S PSSTODOS=PSSDUPD*PSSST
 ..S ^PSDRUG(PSSDIEN,"DOS1",PSSTOT,0)=PSSDUPD_"^"_PSSTODOS_"^O",^PSDRUG(PSSDIEN,"DOS1","B",PSSDUPD,PSSTOT)="" S PSSTOT=PSSTOT+1
 I PSSO,PSSI D  S:PSSTOT>1 PSSTOTX=PSSTOT-1,PSSFLAG=1,^PSDRUG(PSSDIEN,"DOS")=PSSST_"^"_PSSUN,^PSDRUG(PSSDIEN,"DOS1",0)="^50.0903^"_$G(PSSTOTX)_"^"_$G(PSSTOTX)
 .S PSSTOT=1 F PSSDUPD=0:0 S PSSDUPD=$O(^PS(50.606,"ADUPI",PSSDF,PSSDUPD)) Q:'PSSDUPD  D
 ..S PSSTODOS=PSSDUPD*PSSST
 ..S ^PSDRUG(PSSDIEN,"DOS1",PSSTOT,0)=PSSDUPD_"^"_PSSTODOS S $P(^PSDRUG(PSSDIEN,"DOS1",PSSTOT,0),"^",3)=$S($D(^PS(50.606,"ADUPO",PSSDF,PSSDUPD)):"IO",1:"I") S ^PSDRUG(PSSDIEN,"DOS1","B",PSSDUPD,PSSTOT)="" S PSSTOT=PSSTOT+1
 I PSSO,PSSI D  S:PSSTOT>1 PSSTOTX=PSSTOT-1,PSSFLAG=1,^PSDRUG(PSSDIEN,"DOS")=PSSST_"^"_PSSUN,^PSDRUG(PSSDIEN,"DOS1",0)="^50.0903^"_$G(PSSTOTX)_"^"_$G(PSSTOTX)
 .F PSSDUPD=0:0 S PSSDUPD=$O(^PS(50.606,"ADUPO",PSSDF,PSSDUPD)) Q:'PSSDUPD  D
 ..I $D(^PS(50.606,"ADUPI",PSSDF,PSSDUPD)) Q
 ..S PSSTODOS=PSSDUPD*PSSST
 ..S ^PSDRUG(PSSDIEN,"DOS1",PSSTOT,0)=PSSDUPD_"^"_PSSTODOS_"^O",^PSDRUG(PSSDIEN,"DOS1","B",PSSDUPD,PSSTOT)="" S PSSTOT=PSSTOT+1
 Q
LOC ;Set local possible dosages
 N PSSOITEM,PSSOID,PSSLTOT,PSSLTOTX,PSDUPDPT,PSNOUN,PSNOUNPA,PSNOUNPT,PSALL,PSDOD,PSSLPT,PSSLPTX,PSSLPNO,PSSLP,PSSNL,PSSNLF,PSSNLX
 S PSSOITEM=$P($G(^PSDRUG(PSSDIEN,2)),"^") Q:'PSSOITEM
 S PSSOID=$P($G(^PS(50.7,PSSOITEM,0)),"^",2) Q:'PSSOID
 Q:'$O(^PS(50.606,PSSOID,"NOUN",0))
 I $O(^PSDRUG(PSSDIEN,"DOS2",0)) G LOCMRG
 I '$G(PSSTALK) G QUIET
 W ! K DIR S DIR("A")="This drug has no Local Possible Dosages, do you want to create them",DIR("B")="Y",DIR(0)="Y"
 S DIR("?")=" ",DIR("?",1)="If you answer 'YES', Local Possible Dosages will be created for this drug using",DIR("?",2)="nouns associated with the "_$P($G(^PS(50.606,+$G(PSSOID),0)),"^")_" Dosage Form."
 D ^DIR K DIR I Y'=1 Q
 W !!,"Setting Local Possible Dosages..",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
QUIET ;
 Q:'$O(^PS(50.606,PSSOID,"DUPD",0))
 I $O(^PS(50.606,PSSOID,"DUPD",0)) D  S:PSSLTOT>1 PSSLTOTX=PSSLTOT-1,^PSDRUG(PSSDIEN,"DOS2",0)="^50.0904^"_$G(PSSLTOTX)_"^"_$G(PSSLTOTX) Q
 .S PSSLTOT=1
 .F PSNOUN=0:0 S PSNOUN=$O(^PS(50.606,PSSOID,"NOUN",PSNOUN)) Q:'PSNOUN  S PSNOUNPT=$P($G(^(PSNOUN,0)),"^"),PSNOUNPA=$P($G(^(0)),"^",2) D:PSNOUNPT'=""
 ..Q:PSNOUNPA=""
 ..F PSDOD=0:0 S PSDOD=$O(^PS(50.606,PSSOID,"DUPD",PSDOD)) Q:'PSDOD  S PSDUPDPT=$P($G(^(PSDOD,0)),"^") D:PSDUPDPT'=""
 ...I $G(PSSONLYO),PSNOUNPA'["O" Q
 ...I $G(PSSONLYI),PSNOUNPA'["I" Q
 ...D TEST^PSSUTIL3
 ...S PSALL=$G(PSDUPDPT)_" "_$S($G(PSSNLF):$G(PSSNLX),1:$G(PSNOUNPT)) K PSSNL,PSSNLF,PSSNLX
 ...S ^PSDRUG(PSSDIEN,"DOS2",PSSLTOT,0)=$G(PSALL)_"^"_$G(PSNOUNPA),^PSDRUG(PSSDIEN,"DOS2","B",$E(PSALL,1,30),PSSLTOT)="" S PSSLTOT=PSSLTOT+1
 S PSSLTOT=1 F PSNOUN=0:0 S PSNOUN=$O(^PS(50.606,PSSOID,"NOUN",PSNOUN)) Q:'PSNOUN  S PSNOUNPT=$P($G(^(PSNOUN,0)),"^"),PSNOUNPA=$P($G(^(0)),"^",2) D:PSNOUNPT'=""
 .Q:PSNOUNPA=""
 .I $G(PSSONLYI),PSNOUNPA'["I" Q
 .I $G(PSSONLYO),PSNOUNPA'["O" Q
 .S ^PSDRUG(PSSDIEN,"DOS2",PSSLTOT,0)=PSNOUNPT_"^"_$G(PSNOUNPA),^PSDRUG(PSSDIEN,"DOS2","B",$E(PSNOUNPT,1,30),PSSLTOT)="" S PSSLTOT=PSSLTOT+1
 I PSSLTOT>1 S PSSLTOTX=PSSLTOT-1 S ^PSDRUG(PSSDIEN,"DOS2",0)="^50.0904^"_$G(PSSLTOTX)_"^"_$G(PSSLTOTX)
 Q
LOCMRG ;Merge new Local Possible Dosages with existing ones
 N PSSLIEN,PSSLIENX,PSSPWZEX
 I '$G(PSSTALK),'$G(PSSUPRAF) G QUIET1
 W !!,"This drug has the following Local Possible Dosages:",!
 S PSSPWZEX=0 F PSSLIEN=0:0 S PSSLIEN=$O(^PSDRUG(PSSDIEN,"DOS2",PSSLIEN)) Q:'PSSLIEN!(PSSPWZEX)  D
 .D:($Y+5)>IOSL XASK Q:PSSPWZEX  S PSSLIENX=$P($G(^PSDRUG(PSSDIEN,"DOS2",PSSLIEN,0)),"^")
 .I $L(PSSLIENX)'>53 W !,PSSLIENX,?55,"PACKAGE: ",$P($G(^PSDRUG(PSSDIEN,"DOS2",PSSLIEN,0)),"^",2) D DOSEADX Q
 .W !,PSSLIENX,!,?55,"PACKAGE: ",$P($G(^PSDRUG(PSSDIEN,"DOS2",PSSLIEN,0)),"^",2) D DOSEADX
 W ! K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to merge new Local Possible Dosages"
 S DIR("?")=" ",DIR("?",1)="If you answer 'YES', any new Local Possible Dosages found based on the nouns",DIR("?",2)="associated with the "_$P($G(^PS(50.606,+$G(PSSOID),0)),"^")_" Dosage Form"
 S DIR("?",3)="will be added to you current Local Possible Dosages."
 D ^DIR K DIR I Y'=1 Q
 W !!,"Setting Local Possible Dosages..",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
QUIET1 ;
 Q:'$O(^PS(50.606,PSSOID,"DUPD",0))
 I $O(^PS(50.606,PSSOID,"DUPD",0)) D  Q
 .F PSNOUN=0:0 S PSNOUN=$O(^PS(50.606,PSSOID,"NOUN",PSNOUN)) Q:'PSNOUN  S PSNOUNPT=$P($G(^(PSNOUN,0)),"^"),PSNOUNPA=$P($G(^(0)),"^",2) D:PSNOUNPT'=""
 ..Q:PSNOUNPA=""
 ..F PSDOD=0:0 S PSDOD=$O(^PS(50.606,PSSOID,"DUPD",PSDOD)) Q:'PSDOD  S PSDUPDPT=$P($G(^(PSDOD,0)),"^") D:PSDUPDPT'=""
 ...I $G(PSSONLYO),PSNOUNPA'["O" Q
 ...I $G(PSSONLYI),PSNOUNPA'["I" Q
 ...D TEST^PSSUTIL3
 ...S PSALL=$G(PSDUPDPT)_" "_$S($G(PSSNLF):$G(PSSNLX),1:$G(PSNOUNPT)) K PSSNL,PSSNLF,PSSNLX
 ...S (PSSLPT,PSSLPTX,PSSLPNO)=0 F PSSLP=0:0 S PSSLP=$O(^PSDRUG(PSSDIEN,"DOS2",PSSLP)) Q:'PSSLP  S PSSLPTX=PSSLPTX+1 S PSSLPT=PSSLP I PSALL=$P($G(^PSDRUG(PSSDIEN,"DOS2",PSSLP,0)),"^") S PSSLPNO=1
 ...Q:PSSLPNO
 ...S PSSLPT=PSSLPT+1,PSSLPTX=PSSLPTX+1
 ...S ^PSDRUG(PSSDIEN,"DOS2",PSSLPT,0)=$G(PSALL)_"^"_$G(PSNOUNPA),^PSDRUG(PSSDIEN,"DOS2","B",$E(PSALL,1,30),PSSLPT)="",^PSDRUG(PSSDIEN,"DOS2",0)="^50.0904^"_$G(PSSLPT)_"^"_$G(PSSLPTX)
 F PSNOUN=0:0 S PSNOUN=$O(^PS(50.606,PSSOID,"NOUN",PSNOUN)) Q:'PSNOUN  S PSNOUNPT=$P($G(^(PSNOUN,0)),"^"),PSNOUNPA=$P($G(^(0)),"^",2) D:PSNOUNPT'=""
 .Q:PSNOUNPA=""
 .I $G(PSSONLYO),PSNOUNPA'["O" Q
 .I $G(PSSONLYI),PSNOUNPA'["I" Q
 .S (PSSLPT,PSSLPTX,PSSLPNO)=0 F PSSLP=0:0 S PSSLP=$O(^PSDRUG(PSSDIEN,"DOS2",PSSLP)) Q:'PSSLP  S PSSLPTX=PSSLPTX+1 S PSSLPT=PSSLP I PSNOUNPT=$P($G(^PSDRUG(PSSDIEN,"DOS2",PSSLP,0)),"^") S PSSLPNO=1
 .Q:PSSLPNO
 .S PSSLPT=PSSLPT+1,PSSLPTX=PSSLPTX+1
 .S ^PSDRUG(PSSDIEN,"DOS2",PSSLPT,0)=$G(PSNOUNPT)_"^"_$G(PSNOUNPA),^PSDRUG(PSSDIEN,"DOS2","B",$E(PSNOUNPT,1,30),PSSLPT)="",^PSDRUG(PSSDIEN,"DOS2",0)="^50.0904^"_$G(PSSLPT)_"^"_$G(PSSLPTX)
 Q
 ;
DOSEADD ;New fields added with PSS*1*147
 N PSSPW1,PSSPW2,PSSPW3,PSSPW4,PSSPW5,PSSPW6,PSSPW7,PSSPW8
 S PSSPW7=""
 S PSSPW1=$G(^PSDRUG(PSSDIEN,"DOS2",PSSLD,0))
 S PSSPW2=$P(PSSPW1,"^",3)
 S PSSPW3=$S($E(PSSPW2)=".":"0",1:"")_PSSPW2
 D:($Y+5)>IOSL ZASK Q:PSSPWXEX  W !?3,"BCMA UNITS PER DOSE: "_PSSPW3
 S PSSPW4=$P(PSSPW1,"^",5),PSSPW5=$P(PSSPW1,"^",6)
 S PSSPW6=$S($E(PSSPW5)=".":"0",1:"")_PSSPW5
 I PSSPW4 S PSSPW7=$P($G(^PS(51.24,+PSSPW4,0)),"^")
 S PSSPW8=$L(PSSPW6)+$L(PSSPW7)
 D:($Y+5)>IOSL ZASK Q:PSSPWXEX  I PSSPW8<49 W !?3,"NUMERIC DOSE: "_PSSPW6_"   DOSE UNIT: "_PSSPW7 Q
 W !?3,"NUMERIC DOSE: "_PSSPW6
 W !?3,"DOSE UNIT: "_PSSPW7
 Q
 ;
DOSEADX ;New fields added with PSS*1*147
 N PSSPWX1,PSSPWX2,PSSPWX3,PSSPWX4,PSSPWX5,PSSPWX6,PSSPWX7,PSSPWX8
 S PSSPWX7=""
 S PSSPWX1=$G(^PSDRUG(PSSDIEN,"DOS2",PSSLIEN,0))
 S PSSPWX2=$P(PSSPWX1,"^",3)
 S PSSPWX3=$S($E(PSSPWX2)=".":"0",1:"")_PSSPWX2
 D:($Y+5)>IOSL XASK Q:PSSPWZEX  W !?3,"BCMA UNITS PER DOSE: "_PSSPWX3
 S PSSPWX4=$P(PSSPWX1,"^",5),PSSPWX5=$P(PSSPWX1,"^",6)
 S PSSPWX6=$S($E(PSSPWX5)=".":"0",1:"")_PSSPWX5
 I PSSPWX4 S PSSPWX7=$P($G(^PS(51.24,+PSSPWX4,0)),"^")
 S PSSPWX8=$L(PSSPWX6)+$L(PSSPWX7)
 D:($Y+5)>IOSL XASK Q:PSSPWZEX  I PSSPWX8<49 W !?3,"NUMERIC DOSE: "_PSSPWX6_"   DOSE UNIT: "_PSSPWX7 Q
 W !?3,"NUMERIC DOSE: "_PSSPWX6
 W !?3,"DOSE UNIT: "_PSSPWX7
 Q
 ;
UNMDRUG(DRUGIEN) ; Un-match a Dispense Drug from a VA Product
 ;Input: DRGIEN - Pointer to the DRUG file (#50)
 ;
 N PIECE,VAPRDNAM,NDNODE,CMOPID,VAGENIEN,VAPRDIEN,PRIMDRG
 S DRUGIEN=+$G(DRUGIEN) Q:'DRUGIEN
 I '$D(^PSDRUG(DRUGIEN,"ND")) Q
 S NDNODE=$G(^PSDRUG(DRUGIEN,"ND"))
 S VAGENIEN=$P(NDNODE,"^",1)                  ; VA GENERIC (#50.6) Pointer
 S VAPRDNAM=$E($P(NDNODE,"^",2),1,30)         ; VA PRODUCT NAME
 S VAPRDIEN=$P(NDNODE,"^",3)                  ; VA PRODUCT (#50.68) Pointer
 S PRIMDRG=$P($G(^PSDRUG(DRUGIEN,2)),"^",6)   ; PRIMARY DRUG (#50.3) Pointer
 S CMOPID=$P(NDNODE,"^",10)                   ; CMOP ID
 F PIECE=1:1:5,10,11 S $P(^PSDRUG(DRUGIEN,"ND"),"^",PIECE)=""
 I VAPRDNAM'="" K ^PSDRUG("VAPN",VAPRDNAM,DRUGIEN)
 I CMOPID'="" K ^PSDRUG("AQ1",CMOPID,DRUGIEN)
 I PRIMDRG,VAPRDIEN,VAGENIEN K ^PSDRUG("APN",PRIMDRG,VAGENIEN_"A"_VAPRDIEN,DRUGIEN)
 I VAGENIEN K ^PSDRUG("AND",VAGENIEN,DRUGIEN)
 I VAPRDIEN K ^PSDRUG("APR",VAPRDIEN,DRUGIEN)
 Q
 ;
ZASK ;Ask to continue
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue,'^' to exit the list"  D ^DIR K DIR I 'Y S PSSPWXEX=1
 W @IOF
 Q
 ;
 ;
XASK ;Ask to continue
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue,'^' to exit the list"  D ^DIR K DIR I 'Y S PSSPWZEX=1
 W @IOF
 Q
 ;
 ;
DASK ;Ask to continue
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue"  D ^DIR K DIR
 W @IOF
 Q
 ;
 ;****************************************************************
 ;*226 - A drug is considered Hazardous to Handle or Dispose if
 ; it is marked Hazardous in the PSNDF file #50.68 or points to a
 ; common Orderable Item that is pointed to by any drug that is 
 ; marked as such. 
 ;****************************************************************
HAZ(PSSIEN,PSSF) ;*226 
 ;  Determine if a Drug is Hazardous to Handle and to Dispose. 
 ;  Pass in Drug IEN if known or pass in the OI IEN if preferred.
 ;  Input: PSSIEN - IEN of either Drug file or Pharmacy OI file.        <required>
 ;           PSSF - "OI" passed in, then IEN is Pharmacy OI file, else  <optional>
 ;                  "OI" Not passed in, then IEN is for Drug file.      <default>
 ;  Output: HAZ Handle flag (1/0 ^ HAZ Dispose flag (1/0) ^ Orderable Item name 
 N PSSOI,PSSOINAM S PSSIEN=+$G(PSSIEN),PSSF=$G(PSSF)
 S PSSDR=$S(PSSF'="OI":PSSIEN,1:0)
 S PSSOI=$S(PSSF="OI":PSSIEN,1:$$GET1^DIQ(50,PSSIEN,"PHARMACY ORDERABLE ITEM","I")),PSSOINAM=$$GET1^DIQ(50.7,PSSOI,"NAME")
 Q $$ISHAZ(PSSDR,PSSOI,"HAZARDOUS TO HANDLE")_U_$$ISHAZ(PSSDR,PSSOI,"HAZARDOUS TO DISPOSE")_U_PSSOINAM
 ;
ISHAZ(DRIEN,OIIEN,FLDNAM) ;*226
 ;  Get Hazardous flag by NDF FLDNAM passed in to test
 N HAZ,NDIEN,QQ
 ;quick Drug check if Haz = 1
 I DRIEN S NDIEN=+$$GET1^DIQ(50,DRIEN,"PSNDF VA PRODUCT NAME ENTRY","I") I +$$GET1^DIQ(50.68,NDIEN,FLDNAM,"I") Q 1
 ;Pharm Orderable item check if a related drug(s) via OI xref are Haz true.  Quit upon Haz true found.
 I 'OIIEN Q 0
 S HAZ=0 F QQ=0:0 S QQ=$O(^PSDRUG("ASP",OIIEN,QQ)) Q:'QQ  D  Q:HAZ
 . S NDIEN=+$$GET1^DIQ(50,QQ,"PSNDF VA PRODUCT NAME ENTRY","I")
 . S HAZ=+$$GET1^DIQ(50.68,NDIEN,FLDNAM,"I")
 Q HAZ
 ;
HAZWARNG(PSSDRIEN,PSSIO,PSSHAZH,PSSHAZD,PSSHAZTX) ;*226
 ;  Hazardous standard text warning based on HAZ flags passed in
 ;  Input:  PSSDRIEN - DRUG file #50 IEN
 ;          PSSIO    - Inpatient or Outpatient (I - Clinicians only type warn)  (O - Patient type warn)  
 ;          PSSHAZH - Haz to handle indicated
 ;          PSSHAZD - Haz to Dispose indicated
 ;  Output: PSSHAZTX - text for the specific warning indicated, if only one or both Haz indicators exist. 
 ;            (Not wrapped, calling routine needs to do word wrap for printing and displaying)
 Q:'PSSDRIEN
 S PSSIO=$G(PSSIO),PSSHAZH=$G(PSSHAZH),PSSHAZD=$G(PSSHAZD)
 Q:('PSSHAZH)&('PSSHAZD)
 S PSSHAZTX=$$GET1^DIQ(50,PSSDRIEN,"PHARMACY ORDERABLE ITEM")_" is hazardous to "
 S:(PSSHAZH&'PSSHAZD) PSSHAZTX=PSSHAZTX_"handle. "
 S:('PSSHAZH&PSSHAZD) PSSHAZTX=PSSHAZTX_"dispose. "
 S:(PSSHAZH&PSSHAZD) PSSHAZTX=PSSHAZTX_"handle and dispose. "
 I PSSIO="O" S PSSHAZTX=PSSHAZTX_"Please notify pharmacy staff and counsel patient to take the appropriate "
 I PSSIO="I" S PSSHAZTX=PSSHAZTX_"Please take the appropriate "
 S:(PSSHAZH&'PSSHAZD) PSSHAZTX=PSSHAZTX_"handling precautions."
 S:('PSSHAZH&PSSHAZD) PSSHAZTX=PSSHAZTX_"disposal precautions."
 S:(PSSHAZH&PSSHAZD) PSSHAZTX=PSSHAZTX_"handling and disposal precautions."
 Q
