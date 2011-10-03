RMPRCPTU ;HIN/RVD-EXTRINSIC FUNCTION FOR CPT MOD ;5/16/00
 ;;3.0;PROSTHETICS;**41,69**;Feb 09, 1996
 ;
 ;RVD 5/15/02 PATCH #69 - changed GX modifier to GY.
 ;process CPT field
 ;Set variable RMCPT for all valid CPT modifier.
 ;X=PSAS HCPCS^TYPE OF TRANSACTION^SOURCE^FILE
 ;rmcphc=PSAS HCPCS
 ;rmcpty=TYPE OF TRANSACTION
 ;rmcpso=SOURCE 
 ;rmcpfi=file used (660,664 or 664.1)
 ;rmcpt=CPT Modifier dilimited by comma; RETURN VARIABLE
CPT(RDA) ;entry point for CPT.
 N Y,DIR,DIE,DA,RM6611,RMCPT1,RMCPSO,RMCP0,RMCP4,RMCRF,RMCBW,RMCPT5,RMHCPCS,RMCP11,RMCLEN,RMCPFI,RMCPTY,RMCPHC,RMCP5,RMCPHC2
 S RMCPHC=$P(RDA,U,1),RMCPTY=$P(RDA,U,2),RMCPSO=$P(RDA,U,3),RMCPFI=$P(RDA,U,4)
 S RMCPT=""
 I (RMCPHC="")!(RMCPTY="") Q
 K RMCPT1,DIR
 S RM6611=RMCPHC,RMCP4=$G(^RMPR(661.1,RM6611,4))
 S RMCP11=$G(^RMPR(661.1,RM6611,0))
 S RMCP5=$G(^RMPR(661.1,RM6611,5))
 S RMCRF=$P(RMCP5,U,1)
 S (RMCPT1,RMCPHC)=$P(RMCP4,U,1),RMCPT=""
 S RMHCPCS=$P(RMCP11,U,1),RMCPHC2=$E(RMHCPCS,1,2)
 Q:RMCPT1=""
 ;next code will be used for different CPT Modifiers.
 I (RMCPT1["LT"),(RMCPT1["RT") D LRT G:$D(DUOUT)!$D(DTOUT)!$D(DIRUT) EXIT
 I (RMCPT1["KM"),(RMCPT1["KN") D KMN G:$D(DUOUT)!$D(DTOUT)!$D(DIRUT) EXIT
 I RMCPT1["RR",$G(RMCRF) D RR G:$D(DUOUT)!$D(DTOUT)!$D(DIRUT) EXIT
 I RMCPT1["RP" D RP G:$D(DUOUT)!$D(DTOUT)!$D(DIRUT) EXIT
 I RMCPT1["UE",RMCPSO="V" D UE G:$D(DUOUT)!$D(DTOUT)!$D(DIRUT) EXIT
 I RMCPT1["NU",RMCPSO="C" D NU G:$D(DUOUT)!$D(DTOUT)!$D(DIRUT) EXIT
 I RMCPT1["PL" D PL G:$D(DUOUT)!$D(DTOUT)!$D(DIRUT) EXIT
 I RMCPT1["GY" D GY
 I RMCPT1["QH" D QH
 I RMCPT1["KA" D KA
EXIT ;remove comma @ the end and return to calling program
 S RMCLEN=$L(RMCPT),RMCPT=$E(RMCPT,1,RMCLEN-1)
 Q
 ;
LRT ;prompt for LEFT OR RIGHT CPT modifier
 K DIR
 S DIR(0)="SBO^LT:Left;RT:Right;B:Both Left and Right"
 S DIR("A")="Enter a CPT MODIFIER for HCPCS "_RMHCPCS
 D ^DIR I $D(DUOUT)!$D(DTOUT)!($D(Y)&(Y="")) W !,"This is a required field!!!" G LRT
 I Y="B" S Y="LT,RT"
 S RMCPT=RMCPT_Y_","
 Q
 ;
KMN ;prompt for new impression/moulage or previous master model.
 K DIR
 S DIR(0)="SBO^KM:new impression/moulage;KN:previous master model"
 S DIR("A")="Enter a CPT MODIFIER for HCPCS "_RMHCPCS
 D ^DIR I $D(DUOUT)!$D(DTOUT)!($D(Y)&(Y="")) W !,"This is a required field!!!" G KMN
 S RMCPT=RMCPT_Y_","
 Q
 ;
RR ;Append "RR" cpt modifier"
 S DIR(0)="Y"
 S DIR("A")="Is this RENTAL "
 S DIR("?")="Enter 'Y for YES' or 'N for NO' ",DIR("B")="Y"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT) W !,"This is a required field!!!" G RR
 S:$G(Y) RMCPT=RMCPT_"RR,"
 Q
 ;
RP ;append "RP" cpt modifier.
 I (RMCPTY="R")!(RMCPTY="X") S RMCPT=RMCPT_"RP,"
 Q
 ;
UE ;append "UE" cpt modifier.
 S:RMCPSO="V" RMCPT=RMCPT_"UE,"
 Q
 ;
NU ;append "NU" cpt modifier.
 I (RMCPSO="C"),(RMCPT'["RR") S RMCPT=RMCPT_"NU,"
 Q
 ;
QH ;append "QH" CPT modifier for Home Oxygen.
 S RMCPT=RMCPT_"QH,"
 Q
 ;
PL ;Append PL cpt modifier.
 S RMCPT=RMCPT_"PL,"
 Q
 ;
KA ;Append KA cpt modifier for HCPCS that contains wheelchair accessories.
 S RMCPT=RMCPT_"KA,"
 Q
 ;
GY ;Append GY CPT Modifier.
 S RMCPT=RMCPT_"GY,"
 Q
