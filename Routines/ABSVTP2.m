ABSVTP2 ;VAMC ALTOONA/CTB - CONTINUATION OF VOLUNTARY TAPE PROCESSING ;3/3/95  09:54
V ;;4.0;VOLUNTARY TIMEKEEPING;**2,3**;JULY 6, 1994
EN1 K ^TMP($J)
 S:'$D(^ABS(503330,0)) ^ABS(503330,0)="VOLUNTARY MASTER FILE^503330"
 S DAZ=0,U="^" F I=1:1 S DAZ=$O(^TMP("VOL1",$J,DAZ)) Q:'DAZ  D EN2 S I=1 Q:$D(STACK)
 I $D(STACK) K STACK S X="Station Number "_STA_" does not exist in your Institution file (4).  Please correct and rerun this program.*" D MSG^ABSVQ G OUT
 D PRNT S X="Conversion is complete.  The Voluntary Master File has been built and all cross references set.  Refer to Users and technical manuals for instructions on the use of this package.*" D MSG^ABSVQ W !!,"DONE.",!!
OUT K ZY,DAZ,DIC,DA,DAZ,ABSVX,X,NY,Y,COUNT,CNT,NM,SSN,SEX,ADR,CTY,ST,ZIP,BD,ED,TD,COMBS,STA,PI,C
 K SY,HY,AH,AC,AD
 Q
EN2 S X=^TMP("VOL1",$J,DAZ)
 ;DOES VOLUNTEER EXITS - SSN XREF
 S NM=$E(X,15,28) F I=1:1 Q:$E(NM,$L(NM))'=" "  S NM=$E(NM,1,$L(NM)-1)
 S FNM=$E(X,29,38) F I=1:1 Q:$E(FNM,$L(FNM))'=" "  S FNM=$E(FNM,1,$L(FNM)-1)
 S NM=NM_","_FNM K FNM S SSN=$E(X,6,14) Q:SSN=""  W !,NM
 K SSNCK I $D(^ABS(503330,"D",SSN)),$O(^(SSN,0))>0 W " Volunteer with this SSN already exits, Person specific information will not be updated from tape." S SSNCK=""
 I $D(SSNCK) S DA=$O(^ABS(503330,"D",SSN,0))
 E  L +^ABS(503330,0):60 S DA=$P(^ABS(503330,0),"^",4) F I=1:1 S DA=DA+1 I '$D(^ABS(503330,DA)) S $P(^(0),"^",3)=DA,$P(^(0),"^",4)=$P(^(0),"^",4)+1 L -^ABS(503330,0) Q
 S ADR=$E(X,39,57),CTY=$E(X,58,72),ST=$E(X,73,74),ZIP=$E(X,75,79),SEX=$E(X,80),BD="2"_$E(X,83,84)_$E(X,81,82)_"00",ED="2"_$E(X,87,88)_$E(X,85,86)_"00"
 S TD=$S($E(X,89,92)'="0000":"2"_$E(X,91,92)_$E(X,89,90)_"00",1:""),COMBS=$E(X,111,158),STA=$E(X,1,4),PI=$E(X,5),SY=$E(X,93,94),HY=$E(X,95,99),AH=$E(X,102,105)_"0",AC=$S($E(X,100,101)'="00":$E(X,100,101),1:"")
 S AD=$S($E(X,107,110)'="0000":"2"_$E(X,109,110)_$E(X,107,108)_"00",1:"")
 I MEDIA="T" S SY=$E(SY)_$S("0{"[$E(SY,2):0,1:$C($A(SY,2)-16)),HY=$E(HY)_$S("0{"[$E(HY,5):0,1:$C($A(HY,5)-16))
 F I=0:0 Q:$E(STA,$L(STA))'=" "  S STA=$E(STA,1,$L(STA)-1)
 F I=0:0 Q:$E(NM,$L(NM))'=" "  S NM=$E(NM,1,$L(NM)-1)
 F I=0:0 Q:$E(ADR,$L(ADR))'=" "  S ADR=$E(ADR,1,$L(ADR)-1)
 F I=0:0 Q:$E(CTY,$L(CTY))'=" "  S CTY=$E(CTY,1,$L(CTY)-1)
 S J=1 F I=1:1:6 S C(I)=$E(COMBS,J,J+7),J=J+8
 F J=1:1:6 F I=0:0 Q:$E(C(J),$L(C(J)))'=" "  S C(J)=$E(C(J),1,$L(C(J))-1)
EN3 S ST=$O(^DIC(5,"C",ST,0)) I '$D(^ABS(503338,"AD",STA)) S STACK="" Q
 S INST=$O(^ABS(503338,"AD",STA,0))
 ;SET 0TH NODE WHEN '$D(SSNCK)
 I $D(SSNCK) G COMB
 S VOL=NM_U_SSN_U_ADR_U_CTY_U_ST_U_ZIP_U_SEX_U_BD_"^^^^^^^^"_BD_"^^"_PI_"^^^^"_$E(NM)_$E(SSN,6,9)
 S ^ABS(503330,"B",$E(NM,1,30),DA)="",^ABS(503330,"AC",BD,DA)="",^ABS(503330,"C",$E(NM)_$E(SSN,6,9),DA)="",^ABS(503330,"D",SSN,DA)=""
 S ^ABS(503330,DA,0)=VOL
COMB ;ADD COMBINATIONS
 I '$D(^ABS(503330,DA,1,0)) S ^ABS(503330,DA,1,0)="^503330.03I"
 F J=1:1:6 I C(J)'="" D NXT,COM
 W " - Combinations added"
STAINFO ;ADD STATION INFORMATION
 S:'$D(^ABS(503330,DA,4,0)) ^ABS(503330,DA,4,0)="^503330.01P^^"
 S DA1=INST,$P(^(0),"^",3,4)=INST_"^"_($P(^ABS(503330,DA,4,0),"^",4)+1)
 S X=INST_"^"_ED_"^"_+SY_"^"_+HY_"^"_+AH_"^"_AD_"^"_AC_"^"_TD,^ABS(503330,DA,4,DA1,0)=X,^ABS(503330,DA,4,"B",INST,INST)="",^ABS(503330,"AB",INST,DA,DA1)=""
 W " - Station Info added"
 S DIK="^ABS(503330," D IX1^DIK K DIK
EX K AC,AD,ADR,AH,BD,C,COMBS,CTY,DA1,ED,HY,INST,NM,PI,SEX,SSN,ST,STA,SY,TD,VOL,X,ZIP Q
COM S ORGPT=+$E(C(J),1,3)
 S SCHPT=$O(^ABS(503333,"B",$E(C(J),4),0))
 S SERPT=$O(^ABS(503332,"B",$E(C(J),5,8),0))
 S ^ABS(503330,DA,1,DA1,0)=STA_"-"_J_U_ORGPT_U_SCHPT_U_SERPT_U_C(J),$P(^(0),"^",3,4)=DA1_U_($P(^ABS(503330,DA,1,0),"^",4)+1),^ABS(503330,DA,1,"AC",C(J),J)=""
 S ^ABS(503330,DA,1,"B",STA_"-"_J,DA1)="",^ABS(503330,DA,1,"AD",STA,J,DA1)="" K ORGPT,SCHPT,SERPT Q
PRNT W !!!
 S X="Transfer has completed.  I will now print out the entries in the master file.  Have Voluntary Service make a comparision with the 'Alpha Listing'.  If discrepancies are noted use the package menu options to edit master file."
 D MSG^ABSVQ S DIC="^ABS(503330,",L=0,(TO,FR)=ABSV("SITENAME"),BY="[ABSV ALPHA SORT]",FLDS=".01,1,2,3,4,5,6,7,8.5" D EN1^DIP
 Q
NXT F I=1:1 S DA1=$P(^ABS(503330,DA,1,0),"^",4)+1 I '$D(^ABS(503330,DA,1,DA1)) S $P(^ABS(503330,DA,1,0),"^",3,4)=DA1_"^"_DA1 Q
 Q
