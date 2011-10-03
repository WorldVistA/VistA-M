PSARDCBL ;BIRM/MHA - Return Drug Batch Work List - ListMan ;07/01/08
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**69,72**;10/24/97;Build 2
 ;
ST ; Entry point
 I '$$CHKEY^PSARDCUT() Q  ;security key check
 N PSAPHLOC,PSADTRNG,PSABASTS
 ;
 ; - Pharmacy location selection
 S PSAPHLOC=$$PHLOC^PSARDCUT() I 'PSAPHLOC Q
 ;
 ; - Date range selection
 S PSADTRNG=""
 ;
 ; - Return drug credit status selection
 S PSABASTS="AP,PU"
 D EN(PSAPHLOC,PSADTRNG,PSABASTS)
 Q
EN(PSAPHLOC,PSADT,PSASTA) ;- ListManager entry point
 N PSALOC S PSALOC=+PSAPHLOC
 N LASTLINE
LST ; - ListManager entry point
 D EN^VALM("PSA RETURN DRUG BATCH LIST")
 D FULL^VALM1
 G EXIT
 ;
HDR ; - Header
 N LINE1,LINE2,LINE3,LINE4
 S LINE1="Pharmacy Location: "_$P(PSAPHLOC,"^",2)
 S LINE2="Date Range       : "_$S(+PSADT:$$FMTE^XLFDT(+PSADT,"2Z"),1:"ALL")_$S(+$P(PSADT,"^",2):" THRU "_$$FMTE^XLFDT(+$P(PSADT,"^",2),"2Z"),1:"")
 K VALMHDR
 S VALMHDR(1)=LINE1,VALMHDR(2)=LINE2
 N HDR
 S HDR="              DATE      DATE      DATE          TOTAL                       # OF"
 S $E(HDR,81)="" D INSTR^VALM1(IORVON_HDR_IOINORM,1,4)
 S HDR=" #  BATCH #   CREATED   PICKED UP COMPLETED     CREDIT  RETURN CONTRACTOR  ITEMS"
 S $E(HDR,81)="" D INSTR^VALM1(IORVON_HDR_IOINORM,1,5)
 Q
 ;
INIT ; - Populates the Body section for ListMan
 K ^TMP("PSARDCBL",$J),^TMP("PSATMP",$J)
 S VALMCNT=0
 D SORT,SETLINE
 S VALMSG="Select the entry # to view or ?? for more actions"
 Q
 ;
SORT ; - Sort according to the status to be displayed in ListMan
 N BAT,STA,SEQ,ARR,SDT,EDT,FDT
 S SDT=$P(PSADT,"^"),SDT=$S(+SDT>0:SDT,1:0)
 S EDT=$P(PSADT,"^",2),EDT=$S(+EDT>0:EDT_".9",1:9999999)
 F I=1:1:$L(PSASTA,",")  S ARR($P(PSASTA,",",I))=""
 S (BAT,SEQ)=0
 F  S BAT=$O(^PSD(58.35,PSALOC,"BAT",BAT)) Q:'BAT  D
 . S STA=$$GET1^DIQ(58.351,BAT_","_PSALOC,1,"I") I STA="" Q
 . I '$D(ARR("ALL")),'$D(ARR(STA)) Q
 . S FDT=$$GET1^DIQ(58.351,BAT_","_PSALOC,3,"I")
 . I (SDT>FDT)!(FDT>EDT) Q
 . S ^TMP("PSATMP",$J,STA,BAT)=""
 Q
 ;
SETLINE ; - Sets the line to be displayed in ListMan
 ; - Resetting list to NORMAL video attributes
 F I=1:1:$G(LASTLINE) D RESTORE^VALM10(I)
 ;
 N BAT,REC,STA,SEQ,FLDS,BATN,DTCR,DTPU,DTCP,TOTC,CMFR,NIT,LN,DSTA,CNT,GRPLN
 S (BAT,SEQ,CNT,PSACNT)=0,STA=""
 F  S STA=$O(^TMP("PSATMP",$J,STA)) Q:STA=""  D
 .S LN="",DSTA=$$EXTERNAL^DILFD(58.351,1,,STA),$E(LN,(41-($L(DSTA)\2)))=DSTA
 .S SEQ=SEQ+1,VALMCNT=VALMCNT+1,^TMP("PSARDCBL",$J,SEQ,0)=LN,GRPLN(SEQ)=DSTA
 .F  S BAT=$O(^TMP("PSATMP",$J,STA,BAT)) Q:'BAT  D
 . .D GETS^DIQ(58.351,BAT_","_PSALOC_",","*","IE","FLDS")
 . .K REC M REC=FLDS(58.351,BAT_","_PSALOC_",") K FLDS Q:'REC(.01,"E")
 . .S SEQ=SEQ+1,CNT=CNT+1,BATN=REC(.01,"E"),DTCR=$$FMTE^XLFDT($E(REC(3,"I"),1,7),"2Z"),DTPU=$$FMTE^XLFDT($E(REC(2,"I"),1,7),"2Z")
 . .S DTCP=$$FMTE^XLFDT($E(REC(9,"I"),1,7),"2Z")
 . .S CMFR=$E(REC(4,"E"),1,20)
 . .S TOTC=$J($P($$TOTCRE^PSARDCUT(PSALOC,BAT),"^",2),0,2)
 . .S (LN,NIT)=0 D NIT
 . .;Display Line
 . .S LN="",LN=$J(CNT,3),$E(LN,5)=BATN,$E(LN,15)=DTCR,$E(LN,25)=DTPU,$E(LN,35)=DTCP,$E(LN,45)=$J(TOTC,10),$E(LN,57)=CMFR,$E(LN,78)=$J(NIT,3)
 . .S ^TMP("PSARDCBL",$J,SEQ,0)=LN,VALMCNT=VALMCNT+1
 . .S ^TMP("PSARDCBL",$J,CNT,"BAT")=BAT
 ;
 S PSACNT=CNT
 ; - Saving NORMAL video attributes to be reset later
 I SEQ>$G(LASTLINE) D
 . F I=($G(LASTLINE)+1):1:SEQ D SAVE^VALM10(I)
 . S LASTLINE=SEQ
 ;
 I '$D(^TMP("PSARDCBL",$J)) D
 . S ^TMP("PSARDCBL",$J,7,0)="                    No batches to display"
 . S VALMCNT=0
 D RV
 Q
 ;
 ; - Highlighting the group lines (order type and status)
RV ;
 S LN=0 F  S LN=$O(GRPLN(LN)) Q:'LN  D
 . S DSTA=GRPLN(LN),CNT=41-($L(DSTA)\2)
 . D CNTRL^VALM10(LN,1,CNT-1,IOUON_IOINHI,IOINORM)
 . D CNTRL^VALM10(LN,CNT,$L(DSTA),IORVON_IOINHI,IORVOFF_IOINORM)
 . D CNTRL^VALM10(LN,CNT+$L(DSTA),81-CNT-$L(DSTA),IOUON_IOINHI,IOINORM)
 Q
NIT ;
 F  S LN=$O(^PSD(58.35,PSALOC,"BAT",BAT,"ITM",LN)) Q:'LN  I $D(^(LN,0)) S NIT=NIT+1
 Q
 ;
ADD ; - Add New Batch
 I '$D(^PSD(58.35,PSALOC)) D
 . N DIC,DA,X,DINUM
 . S DIC="^PSD(58.35,",(DINUM,X)=PSALOC,DIC(0)=""
 . K DD,DO D FILE^DICN D:Y<1  K DD,DO
 . . S $P(^PSD(58.35,PSALOC,0),"^")=PSALOC K DIK S DA=PSALOC,DIK="^PSD(58.35,",DIK(1)=.01 D EN^DIK K DIK
 N PSABAT,I,J,CMF,PSALK S (PSALK,PSABAT)=$E(DT,4,5)_$E(DT,2,3)
 L +^PSD(58.35,PSALOC,PSALK):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W $C(7),!!,"**** The File is Being Edited by Another User - Try Later ****",! H 3 G ADDQ
 S J=$O(^PSD(58.35,PSALOC,"BAT","B",PSABAT_"-999"),-1)
 S J=$S(PSABAT=$E(J,1,4):$P(J,"-",2),1:0)
 S PSABAT=PSABAT_"-"_$E(1000+(J+1),2,4)
 D FULL^VALM1 W !!,"       New Batch #: "_PSABAT
 K DIC,Y,X
 S DIC="^PSD(58.36,",DIC(0)="QEAM",DIC("A")=" RETURN CONTRACTOR: "
 S DIC("S")="I $S($P($G(^(0)),""^"",2):$P($G(^(0)),""^"",2)>DT,1:1)"
 S DIC("B")=$P($$DEFCTMF^PSARDCUT(),"^",2) K:DIC("B")="" DIC("B")
 D ^DIC I X=""!$D(DTOUT)!$D(DUOUT) K DTOUT,DUOUT D  G ADDQ
 . W !!,"Batch not created - contracter/mfr not entered!",! N DIR S DIR(0)="E" D ^DIR
 S CMF=+Y
 W ! K DIR,X,Y S DIR(0)="Y",DIR("B")="NO",DIR("A")="Save Batch" D ^DIR K DIR G:Y<1 ADDQ
 D NOW^%DTC
 N DIC,DR,DA,X,DINUM,DLAYGO,DD,DO
 S DIC="^PSD(58.35,"_PSALOC_",""BAT"",",X=PSABAT,DIC(0)=""
 S DA(1)=PSALOC,DIC("DR")="1////"_"AP"_";3////"_%_";4////"_CMF
 K DD,DO,% D FILE^DICN K DD,DO L -^PSD(58.35,PSALOC,PSALK)
 ;
 D  ;
 . N XQORM
 . D EN^PSARDCBA(PSALOC,+Y)
 ;
ADDQ L -^PSD(58.35,PSALOC,PSALK) D INIT S VALMBCK="R"
 Q
 ;
CMF ; - Add/Edit Contractor
 L +^PSD(58.36):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W $C(7),!!,"**** The File is Being Edited by Another User - Try Later ****",! H 3 G CMFQ
 D FULL^VALM1 W !
 N FQ F FQ=0:0 K DIC S DIC="^PSD(58.36,",DIC(0)="AEQLS",DLAYGO=58.36 D ^DIC K DIC Q:Y'>0  D
 . S DR=".01//^S X=$G(DIC_+Y_"",0"";1//",DIE="^PSD(58.36,",DA=+Y D ^DIE K DA,DIE,DR W !
 L -^PSD(58.36)
CMFQ D INIT S VALMBCK="R"
 Q
 ;
SEL ; - Select Item action
 I VALMCNT=0 S VALMSG="There are no batches to select!",VALMBCK="R" W $C(7) Q
 N PSASEL,BAT
 S PSASEL=+$P($P($G(Y(1)),"^",4),"=",2)
 I $G(PSASEL),'$D(^TMP("PSARDCBL",$J,PSASEL,"BAT")) D  Q
 . S VALMSG="Invalid selection!",VALMBCK="R" W $C(7)
 I '$G(^TMP("PSARDCBL",$J,PSASEL,"BAT")) D  I 'PSASEL S VALMBCK="R" Q
 . N DIR,Y,X,DIRUT,DIROUT
 . D FULL^VALM1 S DIR(0)="N^1:"_PSACNT,DIR("A")="SELECT RETURN BATCH"
 . 
 . W ! D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y'>0) S VALMBCK="R" Q
 . S PSASEL=+Y
 ;
 S BAT=$G(^TMP("PSARDCBL",$J,PSASEL,"BAT"))
 D  ;
 . N XQORM
 . D EN^PSARDCBA(PSALOC,BAT),INIT
 ;
 S VALMBCK="R"
 Q
  ;
CBAT ; Complete Batch
 I '$$CHKEY^PSARDCUT() Q   ;security key check
 N PSAPHLOC,PSADTRNG,PSABASTS
 ;
 ; - Pharmacy location selection
 S PSAPHLOC=$$PHLOC^PSARDCUT() I 'PSAPHLOC Q
 ;
 ; - Date range selection
 W ! S PSADTRNG=$$DTRNG^PSARDCUT("T-90","T") I PSADTRNG="^" Q
 ;
 ; - Return drug credit status selection
 W ! S PSABASTS=$$STASEL^PSARDCUT() I PSABASTS="" Q
 ;
 ; - Call ListMan driver for Batch List Processing
 D EN(PSAPHLOC,PSADTRNG,PSABASTS)
 Q
 ;
EXIT ;
 K ^TMP("PSARDCBL",$J),^TMP("PSATMP",$J),PSACNT
 Q
 ;
HELP Q
 ;
DELCMF(DA) ; check if cmf has entries tied to it
 I $G(DA)="" Q 1
 N PSADEL,I,J
 S (PSADEL,I)=0
 F  S I=$O(^PSD(58.35,I)) Q:'I  S J=0 F  S J=$O(^PSD(58.35,I,"BAT",J)) Q:'J  I $P($G(^PSD(58.35,I,"BAT",J,0)),"^",5)=+DA S PSADEL=1
 Q PSADEL
