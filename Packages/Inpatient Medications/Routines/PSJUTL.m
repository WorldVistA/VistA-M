PSJUTL ;BIR/MLM-MISC. INPATIENT UTILITIES ; 10/7/08 1:22pm
 ;;5.0;INPATIENT MEDICATIONS;**9,47,58,80,110,136,157,177,134,179,267**;16 DEC 97;Build 158
 ;
 ; Reference to ^DIC(42 is supported by DBIA 10039.
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PSDRUG( is supported by DBIA 2192.
 ; Reference to ^DIC is supported by DBIA 10006.
 ; Reference to ^DIC1 is supported by DBIA 10007.
 ; Reference to ^DIR is supported by DBIA 10026.
 ; Reference to ^VALM1 is supported by DBIA 10116.
 ;
ENDL ; device look-up
 N DA,DIC,DIE,DIX,DO,DR
 S DIC="^%ZIS(1,",DIC(0)="EIMZ" D DO^DIC1,^DIC I Y'>0 K X Q
 S X=Y(0,0)
 Q
 ;
ENDH(X) ; device help
 N D,XQH,DA,DIC,DIE,DO,DR,DZ
 S DIC="^%ZIS(1,",DIC(0)="EIM" D DO^DIC1,^DIC
 Q
 ;
READ ; hold screen
 I $D(IOST) Q:$E(IOST)'="C"
 W ! I $D(IOSL),$Y<(IOSL-4) G READ
 W !?5,"Press return to continue  " R X:$S($D(DTIME):DTIME,1:300)
 Q
 ;
ENOISC(PSJOI,USAGE)          ;Set DIC("S") so that only Orderable Items with at 
 ;least 1 active dispense drug for the specified usage.
 ;Input:  PSJOI IEN of Orderable Item selected
 ;        USAGE - Type of drugs (UD,IV,etc) to be selected
 ;Output: 1-At least one dispense drug found
 ;        0-None found
 N FOUND,PSJ
 S PSJ=$P($G(^PS(50.7,+PSJOI,0)),U,4),FOUND=$S('PSJ:1,PSJ>DT:1,1:0)
 I FOUND S FOUND=0 F PSJ=0:0 S PSJ=$O(^PSDRUG("ASP",PSJOI,PSJ)) Q:FOUND!'PSJ  I $P($G(^PSDRUG(PSJ,2)),U,3)[USAGE,'$G(^("I"))!($G(^("I"))'<DT) S FOUND=1
 Q FOUND
 ;
AADR ; display allergies and adverse reactions
 D ATS^PSJMUTL(60,50,1) N A,B
 I (PSGALG=0)&(PSGADR=0) W !!,"No allergies or ADRs on file."
 I PSGALG'=0 W !!,"Allergies: " S B="PSGALG" F  S A=$Q(@B) Q:A=""  W ?12,$G(@A),! S B=A
 I PSGADR'=0 W !,"      ADR: " S B="PSGADR" F  S A=$Q(@B) Q:A=""  W ?12,$G(@A),! S B=A
 D READ K PSGALG,PSGADR Q
 ;
ENALU ; application look-up
 N PSJ S PSJ=DA(1) N DA,DIC,DIE,DIX,DO,DR S DIC="^PS(50.35,",DIC(0)="EIMZ" D DO^DIC1,^DIC I Y'>0 K X Q
 S X=$P(Y(0),"^",2) K:$S(X="":1,1:$D(^PS(50.3,PSJ,1,"B",X))) X
 Q
 ;
ENAQ ; application query
 S X=DZ N D,DA,DIC,DIE,DO,DR,DZ,XQH S DIC="^PS(50.35,",DIC(0)="EIMQ" D DO^DIC1,^DIC
 Q
 ;
ENPCL(PSJTYP,PSGP,PSJORD) ; Copy Provider Comments -> Special Instructions.
 Q:'$G(PSJORD) ""
 Q:'$D(^PS(53.1,+$G(PSJORD),12,1,0)) ""
 ; Count number of lines minus blank trailing lines
 N LN,LNCNT S LNCNT=0,LN=9999 F  S LN=$O(^PS(53.1,+$G(PSJORD),12,LN),-1) Q:'LN  D
 .I 'LNCNT,($G(^PS(53.1,+$G(PSJORD),12,LN,0))="") Q
 .S LNCNT=LNCNT+1
 I 'LNCNT Q ""
 K ^PS(53.45,+$G(PSJSYSP),5),^PS(53.45,+$G(PSJSYSP),6)
 N DIR,X,Y,PSJSAVY S (X,Y)="" F  S X=$O(^PS(53.1,+$G(PSJORD),12,X)) Q:'X  S Y=$G(^PS(53.1,+$G(PSJORD),12,X)) S:($G(PSJTYP)'="V") Y=$$ENSET^PSGSICHK(Y) S ^PS(53.45,+$G(PSJSYSP),5,X,0)=Y
 W !,"PROVIDER COMMENTS: "
 ;Display Provider Comments Prior to Asking the Copy Provider Comments Question;BHW;PSJ*5*136
 N PSJTMP S PSJTMP=0
 F  S PSJTMP=$O(^PS(53.1,+$G(PSJORD),12,PSJTMP)) Q:'PSJTMP  W !,^PS(53.1,+$G(PSJORD),12,PSJTMP,0)
 S PSGSI=Y W ! S DIR(0)="S^Y:Yes (copy);N:No (don't copy);!:Copy and flag for display in a BCMA Message Box;E:Copy and Edit;"
 S DIR("A")="Copy the Provider Comments into "_$$ENFIELD(PSJTYP)_" (Yes/No/!/E)",DIR("??")="^D ENPCHLP1^PSJUTL(PSJTYP)" D ^DIR S PSJSAVY=Y
 S PSGSI=$S(PSJSAVY="Y":$P(PSGSI,"^"),PSJSAVY="!":$P(PSGSI,"^")_"^1",PSJSAVY="E":$P(PSGSI,"^"),1:"")
 I PSJSAVY="Y"!(PSJSAVY="E")!(PSJSAVY="!") D
 .I ($G(PSJTYP)="V") N OPILN S OPILN=$O(^PS(53.1,+$G(PSJORD),12," "),-1) N TXT,OPIMSG,PSJTMPTX,PSJOVRMX S OPIMSG="Instructions too long. See Order View or BCMA for full text." D
 ..S PSJTMPTX="",PSJOVRMX=0 S TMPLIN=0 F  S TMPLIN=$O(^PS(53.1,+PSJORD,12,TMPLIN)) Q:'TMPLIN!(PSJOVRMX)  D
 ...S:($L(PSJTMPTX)+$L($G(^PS(53.1,+PSJORD,12,TMPLIN,0))))>60 PSJOVRMX=1 Q:$G(PSJOVRMX)  S PSJTMPTX=$G(PSJTMPTX)_$S($G(PSJTMPTX)]"":" ",1:"")_$G(^PS(53.1,+PSJORD,12,TMPLIN,0))
 ..S PSGSI=$S(PSJTMPTX]"":PSJTMPTX,1:OPIMSG) I $G(PSJOVRMX),(PSJSAVY'="E") D OPIWARN^PSJBCMA5(1)
 .S PSGSI=$S(PSJSAVY="!":$P($$PUT5345(PSGORD),"^")_"^1",1:$P($$PUT5345(PSGORD),"^"))
 I PSJSAVY="E"  K ^PS(53.45,+$G(PSJSYSP),5),^PS(53.45,+$G(PSJSYSP),6) D
 .N PRVCLN,X S PRVCLN=$O(^PS(53.1,+$G(PSJORD),12,""),-1)
 .S:($G(PSJTYP)["V") ^PS(53.45,+$G(PSJSYSP),6,0)="^53.1136^"_+$G(PRVCLN)_"^"_+$G(PRVCLN)_"^"_1
 .S:($G(PSJTYP)'["V") ^PS(53.45,+$G(PSJSYSP),5,0)="^53.1135^"_+$G(PRVCLN)_"^"_+$G(PRVCLN)_"^"_1
 .S X=0 F  S X=$O(^PS(53.1,+$G(PSJORD),12,X)) Q:'X  S Y=$G(^PS(53.1,+$G(PSJORD),12,X,0)) S:($G(PSJTYP)'="V") Y=$$ENSET^PSGSICHK(Y) S ^PS(53.45,+$G(PSJSYSP),$S($G(PSJTYP)="V":6,1:5),X,0)=Y
 .D:PSJTYP="V" EDITOPI^PSJBCMA5(PSGP,PSJORD) D:PSJTYP'="V" EDITSI^PSJBCMA5(PSGP,PSJORD)
 I PSJSAVY="E" S PSGSI=$$ENBCMA(PSJTYP)
 Q PSGSI
 ;
ENPC(PSJTYP,PSJSYSP,LEN,TEXT) ; Copy Provider Comments -> Special Instructions.
 S PSGSI=$$ENPCL(PSJTYP,$G(PSGP),$G(PSGORD))
 Q PSGSI
 ;
REDISP ; Redisplay Provider Comments and allow entry of Spec. Instructions.
 D CLEAR^VALM1 F X=0:0 S X=$O(^PS(53.1,+$G(PSJORD),12,X)) Q:'X  W ^(X,0),!
 W !! S PSGSI=""
 D:PSJTYP'="V" 8^PSGOE81
 I PSJTYP="V" D 64^PSIVEDT1 S PSGSI=P("OPI")
 Q
 ;
ENPCHLP1(Y) ; Display help messages for Provider Comment copy.
 W !,"Enter ""YES"" to copy Provider Comments into the ",$$ENFIELD(Y)," field",!,"or ""NO"" to bypass",!,"or ""!"" to copy the Provider Comments into the ",$$ENFIELD(PSJTYP)," field",!,"and flag them for display in a BCMA Message Box"
 W !,"or type ""E"" to copy the Provider Comments into the ",$$ENFIELD(PSJTYP)," field and open a word processing window for editing."
 Q
ENPCHLP2(Y,X) ;
 W !,"The Provider Comments entered for this order are longer than the space available",!,"in the ",$$ENFIELD(Y)," field.",!!,"Enter ""YES"" to copy the first ",X-3," characters into the ",$$ENFIELD(Y),!,"field, or ""NO"" to continue.",!!
 Q
ENBCMA(PSJTYP)  ;
 N DIR,X,Y
 I $G(PSJTYP)="V" Q:'$L($G(^PS(53.45,+$G(PSJSYSP),6,0))) ""
 I $G(PSJTYP)="V" Q:($G(^PS(53.45,+$G(PSJSYSP),6,0))<0) ""
 I $G(PSJTYP)="U" Q:'$L($G(^PS(53.45,+$G(PSJSYSP),5,0))) ""
 W !!,"Would you like to flag the ",$$ENFIELD(PSJTYP)," field for display in a BCMA",!,"Message box?"
 W ! S DIR(0)="S^Y:Yes;N:No",DIR("A")="Flag the "_$$ENFIELD(PSJTYP)_" (Yes/No)" D ^DIR
 K PSJCOMSI I $G(PSJCOM),$G(PSJORD)'["P" N TEXT S TEXT=$S(PSJTYP="U":$G(PSGSI),1:$G(P("OPI"))) S PSJCOMSI=$$COMSI(PSJCOM,TEXT)
 Q:Y="Y" $S($G(PSJTYP)="U":$P(PSGSI,"^")_"^1",1:$P(P("OPI"),"^")_"^1")
 Q $S(PSJTYP="U":PSGSI,1:P("OPI"))
ENFIELD(Y) ;
 Q $S(Y="V":"Other Print Info",1:"Special Instructions")
 ;
COMSI(PARENT,INSTR) ;
 N DIR,X,Y
 W !!!!?15,"** WARNING **",!?5,"This order is part of a complex order."
 W !!,"Would you like to copy the ",$$ENFIELD(PSJTYP)
 W !,"to the other orders in the complex order?"
 S DIR(0)="S^Y:Yes;N:No",DIR("A")="     Copy the "_$$ENFIELD(PSJTYP)_" (Yes/No)" D ^DIR
 Q:Y="Y" 1
 Q 0
 ;
ENORL(X) ; Return patient's location as variable ptr.
 Q $S(+$G(^DIC(42,+X,44)):+$G(^(44))_";SC(",$D(^DIC(42,+X,0)):+X_";DIC(42,",1:"")
 ;
ENMARD() ; validate MAR SELECTION DEFAULT string in WARD PARMS file.
 N PSJANS,PSJX1,PSJX2,RANGE,Q
 S RANGE="1:6" F PSJX1=1:1:6 S RANGE(PSJX1)=""
 S:$E(X)="-" X=+RANGE_X S:$E($L(X))="-" X=X_$P(RANGE,":",2)
 S PSJANS="" F Q=1:1:$L(X,",") S PSJX1=$P(X,",",Q) D FS Q:'$D(PSJANS)
 Q:'$G(PSJANS) 0
 S PSJANS=$E(PSJANS,1,$L(PSJANS)-1) F Q=1:1:$L(PSJANS,",") D  Q:'$D(PSJANS)
 .I $P(PSJANS,",",Q)=1,$L(PSJANS,",")>1 W !!,"All Medications (1) may not be selected in combination with other types." K PSJANS Q
 .W ?47,$P(PSJANS,",",Q)," - ",$P($T(@$P(PSJANS,",",Q)),";;",2),!
 S:$G(PSJANS) X=PSJANS Q $G(PSJANS)
 ;
FS ;
 I $S(PSJX1?1.N1"-"1.N:0,PSJX1'?1.N:1,'$D(RANGE(PSJX1)):1,1:","_PSJANS[PSJX1) K PSJANS Q
 I PSJX1'["-" S PSJANS=PSJANS_PSJX1_"," Q
 S PSJX2=+PSJX1,PSJANS=PSJANS_PSJX2_","
 F  S PSJX2=$O(RANGE(PSJX2)) K:$S(X="":1,","_PSJANS[PSJX2:1,1:PSJX2>$P(PSJX1,"-",2)) PSJANS Q:'$D(PSJANS)  S PSJANS=PSJANS_PSJX2_"," Q:PSJX2=$P(PSJX1,"-",2)
 Q
 ;
ENMARDH ;Help text for MAR default answer.
 W !!?2,"Enter the number corresponding to the type of orders to be included on MARs",!,"printed for this ward. Multiple types (except 1) may be selected using ""-""",!,"or "","" as delimiters.",!!,"Choose from: ",!
 N X F X=1:1:6 W !?13,X," - ",$P($T(@X),";;",2)
 W !
 Q
1 ;;All Medications
2 ;;Non-IV Medications only
3 ;;IV Piggybacks
4 ;;LVPs
5 ;;TPNs
6 ;;Chemotherapy Medications (IV)
 ;
EFD ;The following EFD Tags are used to Calculate the Expected First Dose for backdoor
 ;orders.  The call to $$ENQ^PSJORP2 is used to actually perform the calculation.
 ;The program $$ENQ^PSJORP2 requires the variable INFO to equal the following:
 ;BHW;PSJ*5*136
 ; INFO (piece 1) = START DATE/TIME      ;PSGNESD (NEW ORDER)
 ; INFO (piece 2) = STOP DATE/TIME       ;PSGNEFD (NEW ORDER)
 ; INFO (piece 3) = SCHEDULE             ;PSGSCH  (NEW ORDER)
 ; INFO (piece 4) = SCHEDULE TYPE        ;PSGST   (NEW ORDER)
 ; INFO (piece 5) = ORDERABLE ITEM       ;PSGDRG  (NEW ORDER)
 ; INFO (piece 6) = ADMIN TIMES          ;PSGS0Y  (NEW ORDER)
 ; 
EFDNEW ;Call Here if NEW or RENEWED Order
 N INFO
 S INFO=($G(PSGNESD))_U_($G(PSGNEFD))_U_($G(PSGSCH))_U_($G(PSGST))_U_($G(PSGDRG))_U_($G(PSGS0Y))
 D EFDDISP
 QUIT
EFDACT ;Call here if Editing Fields for an ACTIVE order
 ; Field 10 = Start Date
 ; Field 34 = Stop Date
 ; Field 41 = Admin Times
 N INFO,KEY,ORDER,LAST
 ;Loop Fields to be edited, in order, and determine when to Display expected first dose message
 F KEY=1:1 S ORDER=$P(PSGOEER,";",KEY) Q:'$L(ORDER)  I "10^34^41"[$P(ORDER,U,1) S ORDER(KEY)=$P(ORDER,U,1)
 ;If there are no entries in ORDER, then were Not Editing Start/Stop or Admin Times
 S LAST=$O(ORDER(99),-1) Q:'LAST
 ;BHW;PSJ*5*179;Remove "Display Once" logic.
 ;S LAST=ORDER(LAST)
 ;I LAST'=PSGF2 Q
 S INFO=($G(PSGSD))_U_($G(PSGFD))_U_($G(PSGSCH))_U_($G(PSGST))_U_($G(PSGPDRG))_U_($G(PSGS0Y))
 S PSGEFDMG="Next Dose Due"
 D EFDDISP
 QUIT
EFDNV ;Call here if Editing Fields for a NON-VERIFIED order
 ; Field 10 = Start Date
 ; Field 25 = Stop Date
 ; Field 39 = Admin Times
 N INFO,KEY,ORDER,LAST
 ;Check if called during finish process
 I '$D(PSGOEER) D  D EFDDISP Q
 . S INFO=($G(PSGNESD))_U_($G(PSGNEFD))_U_($G(PSGSCH))_U_($G(PSGST))_U_($G(PSGPDRG))_U_($G(PSGS0Y))
 . Q
 ;Loop Fields to be edited, in order, and determine when to Display expected first dose message
 F KEY=1:1 S ORDER=$P(PSGOEER,";",KEY) Q:'$L(ORDER)  I "10^25^39"[$P(ORDER,U,1) S ORDER(KEY)=$P(ORDER,U,1)
 ;If there are no entries in ORDER, then were Not Editing Start/Stop or Admin Times
 S LAST=$O(ORDER(99),-1) Q:'LAST
 ;Only display EFD once, so Quit if this call is not for the Last field in the Edit
 S LAST=ORDER(LAST)
 I LAST'=PSGF2 Q
 S INFO=($G(PSGSD))_U_($G(PSGFD))_U_($G(PSGSCH))_U_($G(PSGST))_U_($G(PSGPDRG))_U_($G(PSGS0Y))
 D EFDDISP
 QUIT
EFDIV(PSGZZND) ;Set variables for EFD on IV orders.
 I $G(PSGZZND)="" D
 .N X,ZZND,LYN,PSGS0XT,PSGS0Y,PSGOES S PSGOES=1 S X=P(9) D EN^PSGS0 S:$G(ZZND)'="" PSGZZND=ZZND
 S PSGNESD=P(2),PSGNEFD=P(3),PSGSCH=P(9),PSGST=$P($G(PSGZZND),"^",5),PSGDRG=$P($G(P("PD")),"^"),PSGS0Y=P(11)
 ;BHW - PSJ*5*177 Add call to check stop date.  If it's in the past, Display Message
 D CHKSTOP
 D EFDNEW
 W !
 Q
EFDDISP ;Display Expected First Dose
 N Y,Z
 Q:$G(PSGST)="OC"!($G(PSGST)="P")!($G(PSGST)="O")
 Q:$G(PSGSCH)["ON CALL"!($G(PSGSCH)["ON-CALL")!($G(PSGSCH)["ONCALL")
 Q:$G(PSGSCH)["PRN"
 I '$L($G(PSGP)) N PSGP S PSGP=""
 S Y=$$ENQ^PSJORP2(PSGP,INFO)
 I 'Y S Y="Unable to Calculate"
 X ^DD("DD")
 ;BHW;PSJ*5*179;Add Variable Message. "Next Dose Due".  Default to "Expected First Dose"
 I '$D(PSGEFDMG) S PSGEFDMG="Expected First Dose"
 W !,PSGEFDMG,": ",Y H 3
 K PSGEFDMG
 Q
CHKSTOP ;BHW - PSJ*5*177 Warn user if the Stop Date is < now.
 I '+$G(P(3)) Q
 N PSNOW,%,%H,%I,X D NOW^%DTC S PSNOW=%
 I +P(3)<PSNOW D  Q
 . W !,$C(7),"The Stop Date/Time is in the Past!!!  This order will",!,"automatically EXPIRE upon Verification!!",!
 . Q
 Q
 ;
PUT5345(PSGORD) ; Get text from provider comments, place into temp storage
 Q:'$D(^PS(53.1,+PSGORD,12)) ""
 N PSJTMPTX,PSJOVRMX,TMPLIN,SIMSG
 N LN,TXT,LNCNT S TXT="",LN=0 F LNCNT=0:1 S LN=$O(^PS(53.1,+PSGORD,12,LN)) Q:'LN  D
 .S TXT=$G(^PS(53.1,+PSGORD,12,LN,0)) S ^PS(53.45,+PSJSYSP,$S($G(PSJTYP)="U":5,$G(PSJTYP)="V":6,1:5),LN,0)=TXT
 I $G(LNCNT) N PSJFIREF S PSJFIREF="^PS(53.45,"_+PSJSYSP_","_$S($G(PSJTYP)="U":5,$G(PSJTYP)="V":6,1:5)_"," D ENSI(PSJFIREF)
 I $G(LNCNT) S ^PS(53.45,+PSJSYSP,$S(($G(PSJTYP)="V"):6,1:5),0)="^^"_LNCNT_"^"_LNCNT
 N DIE,DA
 S SIMSG="Instructions too long. See Order View or BCMA for full text."
 S PSJTMPTX="",PSJOVRMX=0 S TMPLIN=0 F  S TMPLIN=$O(^PS(53.45,+PSJSYSP,$S($G(PSJTYP)="V":6,1:5),TMPLIN)) Q:'TMPLIN!(PSJOVRMX)  D
 .S:($L(PSJTMPTX)+$L($G(^PS(53.45,+PSJSYSP,$S($G(PSJTYP)="V":6,1:5),TMPLIN,0))))>$S($G(PSJTYP)["V":60,1:180) PSJOVRMX=1
 .Q:$G(PSJOVRMX)  S PSJTMPTX=$G(PSJTMPTX)_$S($G(PSJTMPTX)]"":" ",1:"")_$G(^PS(53.45,+PSJSYSP,$S($G(PSJTYP)="V":6,1:5),TMPLIN,0))
 S TXT=$S(PSJOVRMX:SIMSG,1:PSJTMPTX)
 Q TXT
 ;
ENSI(PSJSIFIL) ; Expand comments using MEDICATIONS INSTRUCTIONS file (#51)
 N X,PSJTMPFI,PSJTMPLI,DONE,PSJNWTXT,TOLIN,II,PSJSITXT,FULL,OLD,I S PSJTMPFI=PSJSIFIL_"1)" Q:'$D(@PSJTMPFI)
 K ^TMP("PSGSIL",$J)
 F I=1:1 Q:$G(DONE)  S PSJTMPFI=PSJSIFIL_I_",0)" S DONE=$D(@PSJTMPFI) S DONE=$S(DONE:0,1:1) D
 .S PSJTMPLI=$G(@PSJTMPFI) I ($TR(PSJTMPLI," ")'="") D TXT^PSGMUTL($$ENSISET(PSJTMPLI),74)
 .I ($TR(PSJTMPLI," ")="") S MARX(1)=PSJTMPLI
 .S II="" F  S II=$O(MARX(II)) Q:'II  S TOLIN=+$O(^TMP("PSGSIL",$J,+$G(PSJSYSP),""),-1) D
 ..S ^TMP("PSGSIL",$J,+$G(PSJSYSP),TOLIN+1)=MARX(II) Q
 S I="" I $O(^TMP("PSGSIL",$J,+$G(PSJSYSP),0)) K ^PS(53.45,+$G(PSJSYSP),5) S TOLIN="" F I=0:1 S TOLIN=$O(^TMP("PSGSIL",$J,+$G(PSJSYSP),TOLIN)) Q:TOLIN=""  D
 .S ^PS(53.45,+$G(PSJSYSP),5,TOLIN,0)=^TMP("PSGSIL",$J,+$G(PSJSYSP),TOLIN)
 S I=$O(^PS(53.45,+$G(PSJSYSP),5,""),-1),^PS(53.45,+$G(PSJSYSP),5,0)="^55.6135^"_I_"^"_I_"^"_$P($G(PSGDT),".")
 K ^TMP("PSGSIL",$J)
 Q
 ;
ENSISET(X) ; expands the SPECIAL INSTRUCTIONS field contained in X into Y
 N X1,X2,Y S Y=""
 ;BHW;PSJ*5*185;Modified Logic below to NOT strip spaces and allow existing logic to flow.
 ;             ;Removed code I X2]"" Before Set of Y and created argumentless DO structure.
 F X1=1:1:$L(X," ") S X2=$P(X," ",X1) D
 . I X2']"" S Y=Y_" " Q  ;if multiple spaces in text and were $P'ing through text, X2 will="" so just add space and continue
 . S Y=Y_$S($L(X2)>30:X2,'$D(^PS(51,+$O(^PS(51,"B",X2,0)),0)):X2,$P(^(0),"^",2)]""&$P(^(0),"^",4):$P(^(0),"^",2),1:X2)_" "
 . Q
 ;BHW;Modified stripping of spaces at end of string
 F X1=$L(Y):-1:0 Q:$E(Y,X1,X1)'=" "  S Y=$E(Y,1,X1-1)
 Q Y
