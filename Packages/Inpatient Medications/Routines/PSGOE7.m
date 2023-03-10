PSGOE7 ;BIR/CML3 - SELECT DRUG ;Mar 25, 2020@13:21:35
 ;;5.0;INPATIENT MEDICATIONS;**9,26,34,52,55,50,87,111,181,254,267,260,288,281,317,355,327,319,415**;16 DEC 97;Build 3
 ;
 ; Reference to ^PS(50.7 is supported by DBIA 2180
 ; Reference to ^PS(59.7 is supported by DBIA 2181
 ; Reference to ^PSDRUG( is supported by DBIA 2192
 ; Reference to ^PSNAPIS is supported by DBIA 2531
 ; Reference to $$GET^XPAR is supported by DBIA 2263
 ; Reference to ^VADPT is supported by DBIA 10061
 ; Reference to ^TMP("PSODAOC",$J supported by DBIA 6071
 ; NFI-UD chgs for FR#: 1
 ;
 S PSGDICS="U"
 ;
AD ; Ask Drug
 K PSJDOSE,PSJDOX ;var array use in ^PSJDOSE
 K PSGODO,^TMP("PSJINTER",$J) D KILL^PSJBCMA5(+$G(PSJSYSP))
 D ENKILL^PSJLMUDE
 K DIC S DIC="^PS(50.7,",DIC(0)="EMQZVT",D="B^C" I '$P(PSJSYSU,";",4) S DIC("S")="I $$ENOISC^PSJUTL(Y,""U"")"
 N PSJTABS,PSJPLTYP,PSJPDLOC
 E  D
 .I '$D(PSJDGCK) S DIC("T")="",DIC="^PSDRUG(",DIC("S")="I $$GET1^DIQ(50,+Y,2.1,""I""),$$GET1^DIQ(50,+Y,63)[""U"" S X(1)=+$$GET1^DIQ(50,+Y,100,""I"") I $S('X(1):1,1:X(1)>DT)",D="B^C^VAPN^VAC^NDC^XATC"
 .I $D(PSJDGCK) S DIC("T")="",DIC="^PSDRUG(",DIC("S")="I $$GET1^DIQ(50,+Y,2.1,""I""),$$GCN^PSGOE7(+Y),$$PKGFLG^PSGOE7($$GET1^DIQ(50,+Y,63)) S X(1)=+$$GET1^DIQ(50,+Y,100,""I"") I $S('X(1):1,1:X(1)>DT)",D="B^C^VAPN^VAC^NDC^XATC"
 ;
AD1 ;
 K PSGORD,PSJORD,PSJALLGY,PSGUSRX,^TMP("PSJINTER",$J),^PS(53.45,+$G(PSJSYSP),5),^PS(53.45,+$G(PSJSYSP),6),PSJPLTYP,PSJPDLOC
 K ^TMP("PSODAOC",$J)
 S PSGORQF=0 R !!,"Select DRUG: ",X:DTIME I '$T W $C(7) S X="^"
 ; -- save off value of X in PSGUSRX so variable can be reliable checked at DO tag
 S PSGUSRX=X
 I $D(PSJDGCK) I ($G(PSJOCNT)=1&(X="")) D  Q
 .W !!,"Not enough active profile drugs to perform drug check",!
 .K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
 I $D(PSJDGCK),X="" N PSGDGCKF S PSGDGCKF=1 G DGCKX
 I ("^"[X)!(X="") S PSGORQF=1 G DONE
 G:X?1"S."1.E DONE
 I X?1."?" W !!?2,"Select the medication you wish the patient to receive." W:PSJSYSU<3 "  You should consult",!,"with your pharmacy before ordering any non-formulary medication." W !
 ; PSJ*5*317 - PADE - Define PADE identifier for lookups if kernel parameter turned on
 I $$GET^XPAR("SYS","PSJ PADE OE BALANCES") N PSJTABS,DFN N:'$G(VAIN(4))&$G(PSGP) VAIN D
 .N PSJORCL,PSJCLNK K DIC("W")
 .S DFN=$G(PSGP)
 .I $P(PSJPCAF,"^",2),'$G(VAIN(4)),$G(DFN) D INP^VADPT
 .; If clinic order, quit if clinic location is not linked to PADE
 .S PSJORCL="" I $G(PSJCLAPP) S PSJORCL=PSJCLAPP I 1 ;p319 - Clinic order
 .E  I $G(PSGORD)["P" S PSJORCL=$$GET1^DIQ(53.1,+$G(PSGORD),113,"I")_"^"_$$GET1^DIQ(53.1,+$G(PSGORD),126,"I") I 1
 .E  I $G(PSGORD)["U" S PSJORCL=$$GET1^DIQ(55.06,+$G(PSGORD)_","_+$G(PSGP),130,"I")_"^"_$$GET1^DIQ(55.06,+$G(PSGORD)_","_+$G(PSGP),131,"I") I 1
 .E  I $G(PSGORD)["V" S PSJORCL=$$GET1^DIQ(55.01,+$G(PSGORD)_","_+$G(PSGP),136,"I")_"^"_$$GET1^DIQ(55.01,+$G(PSGORD)_","_+$G(PSGP),139,"I")
 .I PSJORCL,$P(PSJORCL,"^",2) S PSJCLNK=$$PADECL^PSJPAD50(+$G(PSJORCL)) Q:'PSJCLNK
 .I '$G(PSJCLNK) Q:'$$PADEWD^PSJPAD50(+$G(VAIN(4)))
 .S $P(PSJTABS," ",40)=""
 .S PSJPLTYP=$S($G(PSJCLNK):"""CL""",1:"""WD"""),PSJPDLOC=$S(PSJPLTYP["CL":+PSJORCL,1:+$G(VAIN(4)))
 .S DIC("W")="W $E(PSJTABS,1,(40-$L($S($G(DIY)]"""":$G(DIY),1:$$GET1^DIQ(50,+$G(Y),.01)))))_""  PADE: ""_$$DRGQTY^PSJPADSI(+Y,"_PSJPLTYP_","_$G(PSJPDLOC)_")_""   ""_$$GET1^DIQ(50,+Y,101)"
 ;
 D MIX^DIC1 G:X?1."?" AD1 G:"^"[X!(Y'>0) AD1 S (PSGDO,PSGDRG,PSGDRGN,PSGNEDFD,PSGPDRG,PSGPDRGN)=""
 I $D(PSJDGCK) I $$PSJSUPCK^PSJDGCK(+Y) G AD1
 ;
DGCKX I $P(PSJSYSU,";",4) D  G DO
 .S:'$D(PSJDGCK) PSGDRG=+Y,PSGDRGN=Y(0,0)
 .S:$D(PSJDGCK)&'$D(PSGDGCKF) PSGDRG=+Y,PSGDRGN=Y(0,0)
 .S:$D(PSJDGCK)&$D(PSGDGCKF) PSGDRG=$P($$DGCKIEN^PSJDGCK(),";",2),PSGDRGN=$$GET1^DIQ(50,PSGDRG,.01)
 .D DIN^PSJDIN(+$$GET1^DIQ(50,PSGDRG,2.1,"I"),PSGDRG)
 .I '$D(PSJDGCK) I $P(Y(0),"^",9) D NF S:Y>0 PSGDRG=+Y(0),PSGDRGN=Y(0,0) D SNFM
 .I $D(PSJDGCK)&'$D(PSGDGCKF) I $P(Y(0),"^",9) D NF S:Y>0 PSGDRG=+Y(0),PSGDRGN=Y(0,0) D SNFM
 .S PSGPDRG=+$$GET1^DIQ(50,PSGDRG,2.1,"I"),PSGPDRGN=$$OINAME^PSJLMUTL(PSGPDRG)
 I '$D(PSJDGCK) S PSGPDRG=+Y,PSGPDRGN=$$OINAME^PSJLMUTL(PSGPDRG)
 I $D(PSJDGCK)&'$D(PSGDGCKF) S PSGPDRG=+Y,PSGPDRGN=$$OINAME^PSJLMUTL(PSGPDRG)
 D LIST^DIC(50,,.01,"I",,,PSGPDRG,"ASP",,,"ARRAY") I +ARRAY("DILIST",0)=1 S (X,PSGDRG)=ARRAY("DILIST",2,1),PSGDRGN=$$ENDDN^PSGMI(X)
 ;
DO ; dosage ordered
 NEW PSJALLGY,PSGFLG,ANQX  ;; NCC Remediation 317/327 intergation.  RJS-327
 S PSGNEDFD=$$GTNEDFD("U",PSGPDRG)
 ; -- if PSGDGCKF is set, CK action is being used and no DRUG was entered, do not set PSJALLGY array
 I $G(PSGDRG),$P(PSJSYSU,";",4) D  G:$G(PSGORQF) AD
 .S:'$G(PSGDGCKF) PSJALLGY(PSGDRG)=$S($G(PSGUSRX)=""&($G(PSGDRG)):"",1:"P")
 .D ENDDC^PSGSICHK(PSGP,PSGDRG)
 ;;START NCC T4 MODS >> 327*RJS
 N CLOZFLG S CLOZFLG=$$ISCLOZ^PSJCLOZ(,,,,PSGDRG)
 I $P(PSJSYSU,";",4),CLOZFLG D  G:$G(ANQX) AD
 .D ^PSOCLO1
 I '$P(PSJSYSU,";",4) D  G:$G(ANQX) AD S PSGX=PSGPDRG D END^PSGSICHK G:Y<0 AD
 .I CLOZFLG D ^PSOCLO1 S PSGFLG=1
 ;; END NCC T4 MODS << 327*RJS
 S PSGDO=""
 ;
DONE ;
 K DIC,%,%Y,PSGDICS,PSJLUAPP,Q1,Q2,Q3,Z,PSJALLGY,PSGUSRX Q
 ;
NF ;
 S Y=0 W $C(7),!!,"PLEASE NOTE: The selected item is not currently on your medical center's",!?13,"formulary." Q:'$P(PSJSYSU,";",2)
 N CNT S CNT=0 F Q1=0:0 S Q1=$O(^PSDRUG(PSGDRG,65,Q1)) Q:'Q1  I $$CHKDRG(+$G(^(Q1,0))) S CNT=CNT+1
 I CNT=0 W !!,"There are no formulary alternatives entered for this item." W:PSJSYSU>2 "  You should consult",!,"with your pharmacy before ordering this item." S Y=0 Q
 I CNT=1 S Q1=$O(^PSDRUG(PSGDRG,65,0)),Q1=+$G(^(Q1,0)),Q3=$P(^PSDRUG(Q1,0),"^") W !!,Q3," has been entered as a formulary " W:$X>67 ! W "alternative."
 I  F Q=1:1 S %=2 W !!,"Is ",$S(Q=1:"this",1:Q3)," acceptable" D YN^DICN Q:%  D NFOH
 I CNT=1 S:%=1 (Y(0),Y)=Q1,Y(0,0)=Q3 S:%<0 Y=-1 Q
 K DA,DIC S DA(1)=PSGDRG,DIC="^PSDRUG("_PSGDRG_",65,",DIC(0)="AEMQZ",DIC("A")="Select FORMULARY ALTERNATIVE: " W ! D ^DIC K DIC Q
 ;
NFOH ;
 S X="Answer 'YES' to order this formulary alternative ("_Q3_") for the patient instead of the non-formulary item originally selected.  Answer 'NO' to use the drug originally selected."
 W !!?2 F Y=1:1:$L(X," ") S Z=$P(X," ",Y) W:$L(Z)+$X+2>IOM ! W Z," "
 Q
CHKDRG(DRG) ; Determine if dispense drug is valid for Unit Dose.
 I $D(^PSDRUG(DRG,0)),$P($G(^(2)),U,3)["U" S X=+$G(^("I")) I 'X!(X>DT) Q DRG
 Q 0
 ;
SNFM ; show non-formulary message
 S Y=1 Q:PSJSYSU=3!'$O(^PS(59.7,1,21,0))  W $C(7),! S Q=0 F  S Q=$O(^PS(59.7,1,21,Q)) Q:'Q  W !,$G(^(Q,0))
 W ! D READ^PSJUTL S Y=1 Q
 ;
GTNEDFD(APP,PDRG) ; Find defaults from Orderable Item.
 Q $P($G(^PS(50.7,+PDRG,0)),"^",5,8)
 N Q,X S X=""
 F Q=1:1:$L(APP) S X=$E(APP,Q) Q:X=""  S X=$O(^PS(50.3,+PDRG,1,"B",X,0)) I X S X=$P($G(^PS(50.3,+PDRG,1,X,0)),"^",5,8) Q
 Q X
 ;
PKGFLG(PKF) ;Return 0 for not in range of acceptable package flags, 1 for within range
 I $S(PKF["U":1,1:0) Q 1
 I $S(PKF["I":1,1:0) Q 1
 Q 0
 ;
GCN(PSGIENID) ;Return 0 for not matched, 1 for matched with no GCNSEQNO, 1^1 for matched with a GCNSEQNO
 N PSGNDFID,PSGGCNPT,PSGGCNID
 S PSGNDFID=$P($G(^PSDRUG(PSGIENID,"ND")),"^"),PSGGCNPT=$P($G(^PSDRUG(PSGIENID,"ND")),"^",3)
 I 'PSGNDFID!('PSGGCNPT) Q 0
 S PSGGCNID=$$PROD0^PSNAPIS(PSGNDFID,PSGGCNPT)
 I $P(PSGGCNID,"^",7) Q PSGIENID_";"_PSGNDFID_";"_$P(PSGGCNID,"^",7)
 Q PSGIENID_";"_PSGNDFID
