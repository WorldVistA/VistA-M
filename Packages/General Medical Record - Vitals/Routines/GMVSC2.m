GMVSC2 ;HIRMFO/YH,FT-CUMULATIVE V/M - CONTINUED ;10/30/07  10:16
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls          (supported)
 ;
SETLN ; {called from GMVSC1}
 N GMRVPO,GMVLOOP,GMVQNAME
 K GMRVARY
 S GMRVER=$P(^TMP($J,"GMRV",GMRDATE,GMRVTY,GMRVDA),"|",1)
 S GMRVARY=$P(^TMP($J,"GMRV",GMRDATE,GMRVTY,GMRVDA),"|",3)
 D:IOSL<($Y+9) HDR Q:GMROUT  W ! W:GMRVER "(E)"
 I GPRT(GMRVTY)=0 D
 . W ?4,$S(GMRVTY="T":"T: ",GMRVTY="P":"P: ",GMRVTY="R":"R: ",GMRVTY="BP":"B/P: ",GMRVTY="WT":"Wt: ",GMRVTY="HT":"Ht: ",GMRVTY="CG":"Circumference/Girth: ",GMRVTY="CVP":"Central Venous Pressure: ",GMRVTY="PO2":"Pulse Oximetry: ",1:"")
 . I GMRVTY="PN" W ?4,"Pain: "
 S GPRT(GMRVTY)=1
 S GMRDAT=$P(^TMP($J,"GMRV",GMRDATE,GMRVTY,GMRVDA),"|",2)
 I "PRBPCVPCGPO2PN"[GMRVTY S GMRVX=GMRVTY,GMRVX(0)=$P(GMRDAT,"^",8) D
 .  I "UNAVAILABLEPASSREFUSED"[$$UP^XLFSTR(GMRVX(0)) W ?9,GMRVX(0) Q
 . I GMRVTY="PN" D
 . . I GMRVX(0)=0 W ?9,GMRVX(0)_" - No pain" Q
 . . I GMRVX(0)=99 W ?9,GMRVX(0)_" - Unable to respond" Q
 . . I GMRVX(0)=10 W ?9,GMRVX(0)_" - Worst imaginable pain" Q
 . . W ?9,GMRVX(0) Q
 . ;I GMRVTY'="PN" W ?9,GMRVX(0)
 . D EN1^GMVSAS0
 . I GMRVTY="P","^"_GPEDIS_"^"[GMRVARY,$P(GMRDAT,"^",8)=1 S GMRVX(1)=""
 . S Z=$S(GMRVTY="CG":$J($P(GMRDAT,"^",8),0,2),GMRVTY="CVP":$J($P(GMRDAT,"^",8),0,1),GMRVTY'="BP":$J($P(GMRDAT,"^",8),3,0),1:$P(GMRDAT,"^",8)) D:GMRVTY'="BP" BLNK W:GMRVTY'="PN" ?9,Z_$S('$D(GMRVX(1)):" ",'GMRVX(1):"",1:"*")
 . I GMRVTY="CG" W " in ("_$J(Z/.3937,0,2)_" cm)"
 . I GMRVTY="CVP" W " cmH2O ("_$J(Z/1.36,0,1)_" mmHg)"
 . I GMRVTY="PO2" S GMRVPO=$P(GMRDAT,"^",10) W "%"_$S(GMRVPO'="":" with supplemental O2 "_$S(GMRVPO["l/min":$P(GMRVPO," l/min")_"L/min",1:"")_$S(GMRVPO["l/min":$P(GMRVPO," l/min",2),1:GMRVPO),1:"")
 I GMRVTY="T" S X=$P(GMRDAT,"^",8) D
 . I X'>0 W ?9,X Q
 . S GMRVX=GMRVTY,GMRVX(0)=X D EN1^GMVSAS0
 . D EN1^GMVUTL S:'Y Y="" S Z=$J(X,5,1) D BLNK W ?9,Z_" F " S Z=$J(Y,4,1) D BLNK W "("_Z_" C)"_$S('$D(GMRVX(1)):" ",'GMRVX(1):"",1:"*")
 I GMRVTY="HT" S X=$P(GMRDAT,"^",8) D
 . I X'>0 W ?9,X Q
 . D EN2^GMVUTL S:'Y Y="" S Z=$J(X,5,2) D BLNK W ?9,Z_" in " S Z=$J(Y,5,2) D BLNK W "("_Z_" cm)" I 'GMRVER S GMRVHT=Z/100
 I GMRVTY="WT" S X=$P(GMRDAT,"^",8) D
 . I X'>0 W ?9,X Q
 . D EN3^GMVUTL S:'Y Y="" S Z=$J(X,7,2) D BLNK W ?9,Z_" lb " S Z=$J(Y,6,2) D BLNK W "("_Z_" kg)"
 S GMRZZ=""
 F GMVLOOP=1:1 Q:$P(GMRVARY,U,GMVLOOP)=""  D
 .S GMVQNAME=$$FIELD^GMVGETQL($P(GMRVARY,U,GMVLOOP),1,"E")
 .Q:GMVQNAME=""!(GMVQNAME=-1)
 .S GMRZZ=GMRZZ_$S(GMRZZ'="":", ",1:"")_GMVQNAME
 I "UNAVAILABLEPASSREFUSED"[$$UP^XLFSTR($P(GMRDAT,U,8)) Q
 S GMRVITY=+$P(GMRDAT,"^",3)
 S:GMRZZ'=""&(GMRVTY'="PO2") GMRZZ=" ("_GMRZZ_")"
 I GMRZZ'="" W:GMRVTY="PO2" !,?8," via " W GMRZZ
 I GMRVTY="WT",'GMRVER S GMRBMI="",GMRBMI(1)=$P(GMRDAT,"^"),GMRBMI(2)=+$P(GMRDAT,"^",8) D CALBMI^GMVBMI(.GMRBMI) W:GMRBMI>0 !,?4,"Body Mass Index: "_GMRBMI
 K Z
 Q
HDR ; Report header
 I 'GMR1ST D FOOTER^GMVSC0
 W:$Y>0 @IOF
 S GMRPG=GMRPG+1,GFLAG=1 ;what is GFLAG?
 W !,GMRPDT,?25,"Cumulative Vitals/Measurements Report",?70,"Page ",GMRPG
 W !?25,GMVRANGE ;report date range
 W !,$E(GMRDSH,1,78)
 I 'GMR1ST,$P(GMRDATE,".")=GMRDATE(0) W !,$E(GMRDATE(0),4,5)_"/"_$E(GMRDATE(0),6,7)_"/"_$E(GMRDATE,2,3)_" (continued)",!
 ; include date range in header
 S GMR1ST=0
 Q
BLNK ;
 F I=1:1:$L(Z) Q:$E(Z,I)'=" "
 S Z=$E(Z,I,$L(Z))
 Q
