PSONFI ;BIR/MHA - dispense drug/orderable item text display ;09/13/00
 ;;7.0;OUTPATIENT PHARMACY;**46,94,131,225**;DEC 1997;Build 29
 ;External reference to PSSDIN is supported by DBIA 3166
 ;External reference to ^PS(50.606 is supported by DBIA 2174
 ;External reference to ^PS(50.7 is supported by DBIA 2223
 ;External reference to ^PSDRUG( is supported by DBIA 221
 ;
NFI ;display restriction/guidelines
 D EN^PSSDIN(PSODRUG("OI"),PSODRUG("IEN")) S NFI=$$PROMPT^PSSDIN
 I NFI]"","ODY"[NFI D TD^PSONFI S DIR(0)="E" D ^DIR K DIR
 K NFI Q
DDTX ;Display drug text for the hidden action DIN
 N OI,DD
 S:$D(PSODRUG("OI")) OI=PSODRUG("OI") S:$D(PSODRUG("IEN")) DD=PSODRUG("IEN")
 I $G(OI),$G(DD) G 1
 I $D(PSORNSV),$G(PSORNSV)]"" S OI=+$P(OR0,"^",8),DD=+$P(OR0,"^",9) G 1
 S OI=+RXOR,DD=+$P(RX0,"^",6)
1 S OI=$S($G(OI):OI,1:""),DD=$S($G(DD):DD,1:"")
 D EN^PSSDIN(OI,DD)
 N N1,N2,N3,N4,TX,NX S NX="PSSDIN"
 W @IOF,!!,"Drug restriction/guideline info:",!!
 W !,"Orderable Item: "_$P(^PS(50.7,OI,0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")_$S($P(^PS(50.7,OI,0),"^",12):" ***(N/F)***",1:""),!!
 I $O(^TMP("PSSDIN",$J,"OI",0)) S N1="OI" D TXD
 W:'$O(^TMP("PSSDIN",$J,"OI",0)) ?5,"No information available ",!!
 I $G(DD),$D(^PSDRUG(DD,0)) W !,"Drug: "_$P(^PSDRUG(DD,0),"^")_$S($P(^PSDRUG(DD,0),"^",9):" ***(N/F)***",1:""),!! D
 .I $O(^TMP("PSSDIN",$J,"DD",0)) S N1="DD" D TXD
 .W:'$O(^TMP("PSSDIN",$J,"DD",0)) ?5,"No information available ",!!
HLD K DIR S DIR(0)="E" D ^DIR K DIR
 Q
DIN(OI,DD) ;Setup DIN indicator
 S (NFIO,NFID)=""
 I $D(OI),$G(OI) S:$P($G(^PS(50.7,OI,0)),"^",12) NFIO=" ***(N/F)***"
 I $D(DD),$G(DD) S:$P($G(^PSDRUG(DD,0)),"^",9) NFID=" ***(N/F)***"
 D EN^PSSDIN(OI,DD)
 S:$O(^TMP("PSSDIN",$J,"OI",0)) NFIO=NFIO_" <DIN>"
 S:$O(^TMP("PSSDIN",$J,"DD",0)) NFID=NFID_" <DIN>"
 K ^TMP("PSSDIN",$J) Q
 Q
RV ;reverse video
 I $G(PKID),$G(PKIE)]"" D
 .I $O(^PS(52.41,ORD,"OBX",0)) D CNTRL^VALM10(1,1,13,IORVON,IORVOFF,0),RV^PSOPKIV1 Q
 .D CNTRL^VALM10(1,1,$L(PKIE),IORVON,IORVOFF,0)
 D:$G(NFIO) CNTRL^VALM10(+NFIO,$P(NFIO,",",2),5,IORVON,IORVOFF,0)
 D:$G(NFID) CNTRL^VALM10(+NFID,$P(NFID,",",2),5,IORVON,IORVOFF,0)
 K NFIO,NFID,PKID
 ;- Reverses video for the words "Flagged" and "Unflagged"
 N L
 F L=1:1:VALMCNT D
 . D:$D(FLAGLINE(L)) CNTRL^VALM10(L,1,FLAGLINE(L),IORVON,IORVOFF,0)
 Q
 ;
TD N N1,N2,N3,N4,TX,NX S NX="PSSDIN"
 W @IOF
 I NFI="O" D OIT
 I NFI="D" D DDT
 I NFI="Y" D DDT,OIT
 Q
OIT ;
 S N1="OI",TX="Orderable Item Text:" D TXT
 Q
DDT ;
 S N1="DD",TX="Dispense Drug Text:" D TXT
 Q
TXT ;
 W !,TX
TXD K ^UTILITY($J,"W")
 S N2="" F  S N2=$O(^TMP(NX,$J,N1,N2)) Q:'N2!($D(DIRUT))  D
 .S N3="" F  S N3=$O(^TMP(NX,$J,N1,N2,N3)) Q:'N3!($D(DIRUT))  D
 ..S N4="" F  S N4=$O(^TMP(NX,$J,N1,N2,N3,N4)) Q:'N4!($D(DIRUT))  D
 ...W !?5,^TMP(NX,$J,N1,N2,N3,N4) I $Y>20 W ! D HLD Q:$D(DIRUT)  W @IOF
 W ! K ^UTILITY($J,"W")
 Q
