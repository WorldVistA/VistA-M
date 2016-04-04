DDUCHK3 ;SFISC/RWF-CHECK DD (XREF,COMPUTED) ;12:40 PM  4 Mar 2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**130**
 ;
XREF F DDUCY=0:0 S DDUCY=$O(^DD(DDUCFI,DDUCFE,1,DDUCY)) Q:DDUCY'>0  S DDUCX=^(DDUCY,0),DDUCRFI=+DDUCX,DDUCX1=$P(DDUCX,U,2) D XREF1
 Q
XREF1 ;
 I DDUCRFI,$D(^DD(DDUCRFI,0)),$D(^DD(DDUCRFI,0,"IX",DDUCX1,DDUCFI,DDUCFE))[0 D WHO,WFI W "missing 'IX' node." D:DDUCFIX XREFM Q
 I DDUCX["TRIGGER" S DDUCRFI=+$P(DDUCX,U,4),DDUCRFE=+$P(DDUCX,U,5),DDUC5=DDUCFI_U_DDUCFE_U_DDUCY D TRIG
 Q
XREFM S ^DD(DDUCRFI,0,"IX",DDUCX1,DDUCFI,DDUCFE)="" W !?10,"^DD(",DDUCRFI,",0,""IX"",""",DDUCX1,""",",DDUCFI,",",DDUCFE,") = """" was set."
 Q
TRIG I $D(^DD(DDUCRFI,0))[0 W !?5,"Field: ",DDUCFE," (",DDUCXN,") triggers missing file ",DDUCRFI Q
 I $D(^DD(DDUCRFI,DDUCRFE,0))[0 W !?5,"*Field: ",DDUCFE," (",DDUCXN,") triggers missing field ",DDUCRFE," in file ",DDUCRFI Q
 I '$D(^DD(DDUCRFI,DDUCRFE,5)) D WHO,WFI,WFE W " 5 node is missing." I DDUCFIX S ^DD(DDUCRFI,DDUCRFE,5,1,0)=DDUC5 W !?10,"^DD(",DDUCRFI,",",DDUCRFE,",5,1,0) = ",DDUC5," was set." Q
 Q:'DDUCFIX  S (DDUCYY1,DDUCOK)=0
 F DDUCYY=0:0 S DDUCYY=$O(^DD(DDUCRFI,DDUCRFE,5,DDUCYY)) Q:DDUCYY'>0  S DDUCYY1=DDUCYY,DDUCYYX=^(DDUCYY,0) I DDUCYYX=DDUC5 S DDUCOK=1 Q
 I 'DDUCOK D WHO,WFI,WFE W " 5 node is missing." D:DDUCFIX TRIGM Q
 Q
TRIGM S ^DD(DDUCRFI,DDUCRFE,5,(DDUCYY1+1),0)=DDUC5
 I DDUCRFI'=DDUCFE W !?10,"^DD(",DDUCRFI,",",DDUCRFE,",5,",DDUCYY1+1,",0) = ",DDUC5," was set."
 Q
COMP Q:DDUCX2'["C"  S DDUCX=$S($D(^DD(DDUCFI,DDUCFE,9.01)):^(9.01),1:"")
 F DDUCX1=1:1 Q:$P(DDUCX,";",DDUCX1)=""  S DDUCRFI=+$P(DDUCX,";",DDUCX1),DDUCRFE=+$P($P(DDUCX,";",DDUCX1),U,2) I $D(^DD("ACOMP",DDUCRFI,DDUCRFE,DDUCFI,DDUCFE))[0 S:DDUCFIX ^DD("ACOMP",DDUCRFI,DDUCRFE,DDUCFI,DDUCFE)=""
 Q
WHO W !?8,"Field: ",DDUCFE," (",DDUCXN,") " Q
WFI W !?8,"File: ",DDUCRFI," " Q
WFE W ?8,"Field: ",DDUCRFE," " Q
 ;
DXREF ; Check for $Next usage; 22*130
 ; DDUCFI = File #
 ; DDUCFE = Field #
 ; XRN = Cross Reference #
 N XRN S XRN=0
 F  S XRN=$O(^DD(DDUCFI,DDUCFE,1,XRN)) Q:'XRN  D
 . ; XRN1 = Cross Reference Node Data
 . N XRN1 S XRN1=""
 . ; XRNW = 0 Have Not written warning, 1 have written warning
 . N XRNW S XRNW=0
 . F  S XRN1=$O(^DD(DDUCFI,DDUCFE,1,XRN,XRN1)) Q:XRN1=""  D
 .. N GMSG S GMSG=0 ;1 equals use general message
 .. I XRN1="%D" Q
 .. I XRN1="DT" Q
 .. ; Check for $Next any cross reference code
 .. I ^DD(DDUCFI,DDUCFE,1,XRN,XRN1)["$N(",^DD(DDUCFI,DDUCFE,1,XRN,XRN1)'["$$N(" D  I GMSG W !?5,"*Field: ",DDUCFE,", Cross Reference #: ",XRN,", Sub-Script: ",XRN1,", contains $Next."
 ... I $P(^DD(DDUCFI,DDUCFE,1,XRN,0),U,3)'="TRIGGER" S GMSG=1 Q
 ... ; Display/Fix known old FileMan TRIGGER Code:
 ... ; "D ^DICR:$N(^DD(DIH,DIG,1,0))>0"
 ... N DICRVAL
 ... S DICRVAL=$G(^DD(DDUCFI,DDUCFE,1,XRN,XRN1))
 ... I DICRVAL'["D ^DICR:$N(^DD(DIH,DIG,1,0))>0" S GMSG=1 Q
 ... I 'XRNW D
 .... W !?5,"*File: "_DDUCFI_", Field: "_DDUCFE_", XREF: "_XRN_" contains $Next in TRIGGER code."
 .... S ^TMP("DDUCHK",$J,DDUCFI,DDUCFE,XRN)=""
 .... S XRNW=1
 Q
