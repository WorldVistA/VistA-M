PXKMAIN2 ;ISL/JVS - Special Routine ;5/21/96  13:20
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**69,186**;Aug 12, 1996;Build 3
 ;  VARIABLES
 ; See variables lists under each line tag
 ;
 ;
SPEC ;Populate other v files
 ;  VARIABLES
 ; PXKAV(0)  = The AFTER variables created in PXKMAIN
 ; PXKBV(0)  = The BEFORE variables created in PXKMAIN
 ; PXKFG(ED,DE,AD) =The EDIT,DELETE,ADD flags
 ; PXKCAT    = The category being $o through (CPT,IMM etc...)
 ; PXKIN     = The pointer value of first piece in the mapping file
 ; PXKPXD    = An array with all the entries to be mapped this go around
 ; PXKDIEN   = IEN of the coding file
 ;
 S PXKDONE=0
 Q:PXKFGED=1
 I (PXKFGAD=1) D
 .I $D(^PXD(811.1,"AA",PXKAV(0,1),""_PXKCAT_"",1)) D
 ..S PXKDONE=$O(^PXD(811.1,"AA",PXKAV(0,1),""_PXKCAT_"",1,PXKDONE))
 ..S PXJ(1)=$G(^PXD(811.1,PXKDONE,0)) ;8TH IEN
 ..S PXJ(2)=$P(PXJ(1),"^",2) ;SECOND PIECE OF 8TH IEN
 ..S PXJ(3)=$P(PXJ(2),";",1) ;FIRST PIECE OF ABOVE
 ..S PXJ(4)=$P(PXJ(1),"^",4) ;TO
 ..S PXKDONE=$O(^PXD(811.1,"AA",PXJ(3),""_PXJ(4)_"",1,0))
 ..S:PXKDONE="" PXKDONE=0  I '$D(PXKPXD($G(PXKDONE))) D POP
 I (PXKFGDE=1) D
 .I $D(^PXD(811.1,"AA",PXKBV(0,1),""_PXKCAT_"",1)) D
 ..S PXKDONE=$O(^PXD(811.1,"AA",PXKBV(0,1),""_PXKCAT_"",1,PXKDONE))
 ..S PXJ(1)=$G(^PXD(811.1,PXKDONE,0)) ;8TH IEN
 ..S PXJ(2)=$P(PXJ(1),"^",2) ;SECOND PIECE OF 8TH IEN
 ..S PXJ(3)=$P(PXJ(2),";",1) ;FIRST PIECE OF ABOVE
 ..S PXJ(4)=$P(PXJ(1),"^",4) ;TO
 ..S PXKDONE=$O(^PXD(811.1,"AA",PXJ(3),""_PXJ(4)_"",1,0))
 ..S:PXKDONE="" PXKDONE=0  I '$D(PXKPXD($G(PXKDONE))) D POP
 K PXKDONE
 Q
 ;
POP ;Population of more than one v file using PCE CODE MAPPING file 811.1
 ;
 ;N PXKPXD
 N PXKROU,PXKIN,PXKX,PXKXX,PXKDIEN,PXKTO
 S PXKIN=$S(PXKFGAD=1:PXKAV(0,1),PXKFGDE=1:PXKBV(0,1),1:"")
 S PXKDIEN=0 F  S PXKDIEN=$O(^PXD(811.1,"AA",PXKIN,PXKCAT,1,PXKDIEN)) Q:PXKDIEN=""  D
 .S PXKPXD(PXKDIEN)=$G(^PXD(811.1,PXKDIEN,0))
 S (PXKX,PXKXX)=0 F  S PXKX=$O(PXKPXD(PXKX)) Q:PXKX=""  S PXKXX=PXKXX+.01 D
 .I TMPPX[("^"_PXKX_"^") Q
 .S PXKTO=$P(PXKPXD(PXKX),"^",4)
 .S PXKROU=$P(PXKPXD(PXKX),"^",3)_"^PXKF"_PXKTO_"1" D @PXKROU
 .S TMPPX=TMPPX_PXKX_"^"
 S PXKNORG("SOR")=$G(^TMP("PXK",$J,"SOR"))
 S PXKNORG("VSTIEN")=$G(^TMP("PXK",$J,"VST",1,"IEN"))
 Q
 ;
RECALL ; Recall PXKMAIN to populate special circumstances
 D EVENT^PXKMAIN K ^TMP("PXK",$J)
 S PXKREF="^TMP(""PXKSAVE"",$J)"
 F  S PXKREF=$Q(@PXKREF) Q:$P(PXKREF,",",1)'["PXKSAVE"  Q:$P(PXKREF,",",2)'[$J  Q:PXKREF=""  S PXKSAVE=PXKREF D
 .S $P(PXKSAVE,"""",2)="PXK" S @PXKSAVE=$G(@PXKREF)
 S ^TMP("PXK",$J,"SOR")=$G(PXKNORG("SOR"))
 S ^TMP("PXK",$J,"VST",1,"IEN")=$G(PXKNORG("VSTIEN"))
 K ^TMP("PXKSAVE",$J),PXKNORG
 D EN1^PXKMAIN,EVENT^PXKMAIN
 Q
 ;
 ;
PRVTYPE ;---POPULATE PROVIDER TYPE
 ;
 ;--**
 I '$D(^TMP("PXK",$J,"PRV")) Q
 I '$L($T(GET^XUA4A72)) Q
 N PXKPSUB,PXKPRV,PXKDT,NOD0,TYPE
 S PXKPSUB=0 F  S PXKPSUB=$O(^TMP("PXK",$J,"PRV",PXKPSUB)) Q:PXKPSUB=""  D
 .S NOD0=$G(^TMP("PXK",$J,"PRV",PXKPSUB,0,"AFTER"))
 .S PXKPRV=$P(NOD0,"^",1)
 .I '$G(PXKPRV) Q
 .S PXKDT=+$P($G(^AUPNVSIT($G(^TMP("PXK",$J,"VST",1,"IEN")),0)),"^",1)
 .;--** ADD FUNCTION
 .S TYPE=+$$GET^XUA4A72($G(PXKPRV),+$P($G(PXKDT),".")) Q:TYPE<1
 .I $P(NOD0,"^",6)']"" S $P(NOD0,"^",6)=TYPE
 .S ^TMP("PXK",$J,"PRV",PXKPSUB,0,"AFTER")=NOD0
 Q
