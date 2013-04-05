ONCOPRT ;Hines OIFO/GWB - OncoTrax reports ;05/03/12
 ;;2.11;ONCOLOGY;**24,25,26,27,36,50,51,52,53,56**;Mar 07, 1995;Build 10
 ;This routine invokes Integration Agreement #3151
SUS ;[SP Print Suspense List by Suspense Date (132c)]
 S BY="@75,INTERNAL(#3),@75,.01,75,2;C2"
 S (FR,TO)=DUZ(2)_",?"
 S FLDS="[ONCO SUSPENSE]"
 G PRT60
 ;
DI ;[DI Disease Index]
 ;Supported by IA #3151
 S (COUNT,SUSCOUNT)=0
 S OSPIEN=$O(^ONCO(160.1,"C",DUZ(2),0))
 S AFLDIV=""
 I $O(^ONCO(160.1,OSPIEN,6,0)) D
 .S ADIEN=0 F  S ADIEN=$O(^ONCO(160.1,OSPIEN,6,ADIEN)) Q:ADIEN'>0  S AFLDIV=AFLDIV_^ONCO(160.1,OSPIEN,6,ADIEN,0)_U
 W !
 K DIR
 S DIR(0)="SAO^1:Casefinding;2:Customized search"
 S DIR("A")=" Select DISEASE INDEX report: "
 S DIR("?",1)=" Select 'Casefinding' if you want to find and add to SUSPENSE"
 S DIR("?",2)=" cases with reportable tumors for the selected date range."
 S DIR("?",3)=""
 S DIR("?",4)=" Select 'Customized search' if you want to search for an"
 S DIR("?",5)=" individual ICD-CM code or range of codes."
 S DIR("?")=" "
 D ^DIR
 I $D(DIRUT) K DIRUT Q
 I Y<1 Q
 I +Y=1 S (SORT,BY)="[ONC DISEASE INDEX CASEFINDING]"
 I +Y=2 S (SORT,BY)="[ONC DISEASE INDEX]"
 S DIC="^AUPNVPOV(",L=0
 S FLDS="[ONC DISEASE INDEX]"
 S DIS(0)="I $$DIDIV^ONCFUNC(D0)=""Y"""
 ;sets the ICD screens
 D ICD^ONCOPRT1
 ;
 S DHIT="S SAVED0=D0 D DISUS^ONCOPRT S D0=SAVED0"
 I SORT="[ONC DISEASE INDEX CASEFINDING]" S DIOEND="W !?6,""-----"",!,""COUNT "",COUNT,!,""Added to SUSPENSE "",SUSCOUNT"
 E  S DIOEND="W !?6,""-----"",!,""COUNT "",COUNT"
 D EN1^DIP
 K AFLDIV,ADIEN,COUNT,D0,DHIT,DIOEND,DIR,DR,ONCSUB,OSPIEN,POV,SAVED0,SORT,SUSCOUNT
 G EX
 ;
DISUS ;Add DISEASE INDEX case to suspense
 N DA,DC,DIC,DPTIEN,ICD,ONCS,ONCDIV,ONCIEN,ONCPAT,X
 S ICD=$P(^AUPNVPOV(D0,0),U,1)
 S DPTIEN=$P(^AUPNVPOV(D0,0),U,2)
 I '$D(POV(DPTIEN)) S COUNT=COUNT+1,POV(DPTIEN)=""
 Q:SORT="[ONC DISEASE INDEX]"
 S ONCPAT=DPTIEN_";DPT("
 S ONCIEN=$O(^ONCO(160,"B",ONCPAT,0))
 I ONCIEN'>0 D
 .K DO
 .S DIC="^ONCO(160,",DIC(0)="Z"
 .S X=ONCPAT
 .D FILE^DICN
 .K DO
 .S ONCIEN=+Y
 S ONCDIV="",ONCS=""
 F  S ONCS=$O(^ONCO(160,ONCIEN,"SUS","C",ONCS)) Q:ONCS'>0  S ONCDIV=ONCDIV_U_ONCS
 I ONCDIV[DUZ(2) Q
 S DA(1)=ONCIEN
 S DIC="^ONCO(160,"_DA(1)_",""SUS"","
 K DO
 S DIC(0)="L"
 S DIC("P")=$P(^DD(160,75,0),U,2)
 S X=$$GET1^DIQ(9000010,$$GET1^DIQ(9000010.07,D0,.03,"I"),.01,"I")
 S X=$P(X,".",1)
 D FILE^DICN
 K DO,DIE
 S DA(1)=ONCIEN
 S DIE="^ONCO(160,"_DA(1)_",""SUS"","
 S (ONCSUB,DA)=+Y
 S DR="1///^S X=DT;2///^S X=""DI"";3////^S X=DUZ(2);8////^S X=ICD"
 D ^DIE
 S SUSCOUNT=SUSCOUNT+1
 Q
 ;
DNP ;[NP Oncology Patient List-NO Primaries/Suspense]
 S BY="@75,INTERNAL(#3),@NO PRIMARY;L1,NAME"
 S (FR,TO)=DUZ(2)
 S FLDS="[ONCO PATIENT ONLY]"
 G PRT60
 ;
ABI ;[NC Print Abstract NOT Complete List]
 W !
 N BY,FLDS,FR,DIR,DIS,TO,Y
 K DIR
 S DIR(0)="SAO^1:Date Dx;2:Date of First Contact"
 S DIR("A")=" Select date field to be used for sorting: "
 S DIR("?")="Select the date field you wish to use for sorting this report."
 D ^DIR
 I $D(DIRUT) K DIRUT Q
 I Y<1 S OUT=1 Q
 I +Y=1 S BY="#+91,@INTERNAL(#3)"
 I +Y=2 S BY="#+91,@INTERNAL(#155)"
 S FR=",@"
 S TO=""
 S FLDS="[ONCO ABSTRACT NOT-COMPLETE]"
 S DIS(0)="I $P($G(^ONCO(165.5,D0,7)),U,2)'=3"
 G PRT655
 ;
PFH ;[FH Patient Follow-up History]
 D PAT I Y'<0 D  G EX
 .S BY="@NUMBER"
 .S (FR,TO)=+Y
 .S FLDS="[ONCO FOLLOWUP HISTORY]"
 .D PRT60
 Q
 ;
DUF ;[DF Print Due Follow-up List by Month Due]
 W !
 N BY,FLDS,DIR,DIS,Y
 D DIR
 I $D(DIRUT) K DIRUT Q
 I Y<1 Q
 I +Y=1 S (BY,FLDS)="[ONCO DUE FOLLOWUP]"
 I +Y=2 S BY="[ONCO DUE FOLLOWUP]",FLDS="[ONCO DUE FOLLOWUP2]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
DEL ;[LF Print Delinquent (LTF) List]
 N BY,FLDS,DIR,DIS,Y
 W !!?5,"FOLLOW-UP STATUS will be changed from ""Active"" to ""LTF""."
 W !?5,"After 15 months the patient is considered LOST TO FOLLOW-UP."
 W !
 D DIR
 I $D(DIRUT) K DIRUT Q
 I Y<1 Q
 I +Y=1 S (BY,FLDS)="[ONCO DELINQUENT(LTF) LIST]"
 I +Y=2 S BY="[ONCO DELINQUENT(LTF) LIST]",FLDS="[ONCO DELINQUENT(LTF) LIST2]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
DIR ;DIR
 K DIR
 S DIR(0)="SAO^1:Standard format;2:Remote employees format"
 S DIR("A")=" Select report format: "
 S DIR("?")="Select the report format you wish to use for this report."
 D ^DIR
 Q
 ;
FST ;[SR Follow-up Status Report by Patient (132c)]
 W ! S (BY,FLDS)="[ONCO FOLLOWUP STATUS RPT]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
PFR ;[FR Individual Follow-up Report]
 D PAT I Y'<0 D  G EX
 .S BY="@NUMBER"
 .S (FR,TO)=+Y
 .S FLDS="[ONCO FOLLOWUP PATIENT RPT]"
 .D PRT60
 Q
 ;
ACOS80 ;[AA Accession Register-ACOS (80c)]
 S (BY,FLDS)="[ONCO ACCREG-ACOS80]" D HA G PRT655
 ;
AC80ST ;[AS Accession Register-Site (80c)]
 S (BY,FLDS)="[ONCO ACCREG-SITE/GP80]" D HA G PRT655
 ;
EOAC ;[AE Accession Register-EOVA (132c)]
 S (BY,FLDS)="[ONCO ACCREG-EOVA132]" D HA G PRT655
 ;
HA ;Help for Accession Registers
 W !!?3,"For a complete register:"
 W !?5,"START WITH ACC/SEQ NUMBER: FIRST// <Enter>"
 W !!?3,"For a single accession year (e.g. 1999):"
 W !,?5,"START WITH ACC/SEQ NUMBER: FIRST// 1999-00000"
 W !,?5,"GO TO ACC/SEQ NUMBER: LAST// 1999-99999"
 W !!?3,"For a single patient (e.g. 1999-00001):"
 W !,?5,"START WITH ACC/SEQ NUMBER: FIRST// 1999-00001/00"
 W !,?5,"GO TO ACC/SEQ NUMBER: LAST// 1999-00001/99"
 W !
 Q
 ;
ACOSPT ;[PA Patient Index-ACOS (132c)]
 S BY="NAME",(FR,TO)=""
 S FLDS="[ONCO PATIENT INDX-ACOS]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
PAT80 ;[PS Patient Index-Site (80c)]
 S BY="NAME"
 S (FR,TO)=""
 S FLDS="[ONCO PATIENT INDX80]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
EOVA ;[PE Patient Index-EOVA (132c)]
 S BY="NAME"
 S (FR,TO)=""
 S FLDS="[ONCO PATIENT INDX-EOVA132]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
ICD80 ;[IN Primary ICDO Listing (80c)]
 S (BY,FLDS)="[ONCO ICDO-SITE80]"
 G PRT655
 ;
SIT80 ;[SG Primary Site/GP Listing (80c)]
 S (BY,FLDS)="[ONCO SITE/GP80]"
 G PRT655
 ;
ICD132 ;[IW Primary ICDO Listing (132c)]
 S (BY,FLDS)="[ONCO ICDO-SITE132]"
 G PRT655
 ;
PAT ;ONCOLOGY PATIENT (160) lookup
 W !
 S DIC="^ONCO(160,",DIC(0)="AEQM",DIC("A")=" Select Patient Name: "
 D ^DIC K DIC W !
 Q
 ;
PRT60 ;Print ONCOLOGY PATIENT (160) file
 S DIC="^ONCO(160,",L=0 D EN1^DIP G EX
 ;
PRT655 ;Print ONCOLOGY PRIMARY (165.5) file
 S DIC="^ONCO(165.5,",L=0 D EN1^DIP G EX
 ;
EX ;Exit
 K BY,DIC,DHD,DIS,FLDS,FR,L,TO,Y
 Q
 ;
CLEANUP ;Cleanup
 K OUT
