FBAAPCS ;WCIOFO/SAB-REPORT COST/SAVINGS FROM RBRVS FEE SCHEDULE ;6/28/1999
 ;;3.5;FEE BASIS;**4,77**;JAN 30, 1995
 ;
 ; ask date range
 D DATE^FBAAUTL Q:FBPOP
 ;
 W !,"Note: code descriptors will be versioned for the Ending DATE"
 N ICPTVDT S ICPTVDT=$G(ENDDATE)
 ;
 ; ask CPT codes to include
 K FBRCPT
 S DIR(0)="Y",DIR("A")="Include all CPT codes",DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBRCPT=$S(Y:"A",1:"")
 ; if not all CPT codes then ask selection method
 I FBRCPT="" D
 . S DIR(0)="S^1:RANGE OF CODES;2:INDIVIDUAL CODES"
 . S DIR("A")="Choose a method to specify CPT Codes"
 . S DIR("?",1)="You must choose one of the two methods that can be used"
 . S DIR("?",2)="to specify the CPT codes to be included on the report."
 . S DIR("?",3)="If the Range method is chosen, you will asked for one or more"
 . S DIR("?",4)="ranges of CPT codes. (e.g. from 11000 to 11999)"
 . S DIR("?",5)="If the Individual method is chosen, you will be asked to select"
 . S DIR("?",6)="one or more specific CPT codes."
 . S DIR("?")="Enter a code from the list."
 . D ^DIR K DIR Q:$D(DIRUT)
 . S FBRCPT=$S(Y=1:"R",1:"I")
 I FBRCPT="" G EXIT
 ; if individual selected then ask specific codes
 I FBRCPT="I" D  I $D(DTOUT)!$D(DUOUT)!'$O(FBRCPT(0)) G EXIT
 . W !,"Note: code descriptors will be versioned for the Ending DATE"
 . F  D  Q:Y'>0!$D(DIRUT)
 . . S DIR(0)="PO^81:EM"
 . . D ^DIR K DIR Q:$D(DIRUT)
 . . I Y>0 S FBRCPT($P(Y,U))=$P(Y,U,2)
 ; if range selected then ask ranges
 I FBRCPT="R" D  I $D(DTOUT)!$D(DUOUT)!'$O(FBRCPT(0)) G EXIT
 . N FBI,FBX
 . S FBI=0 F  D  Q:Y=""!$D(DIRUT)
 . . S DIR(0)="FO^5:5",DIR("A")="Start of CPT Range #"_(FBI+1)
 . . D ^DIR K DIR Q:$D(DIRUT)
 . . S FBX=Y
 . . S DIR(0)="F^5:5",DIR("A")="End of CPT Range #"_(FBI+1)
 . . D ^DIR K DIR Q:$D(DIRUT)
 . . S $P(FBX,U,2)=Y
 . . I $P(FBX,U)]$P(FBX,U,2) W $C(7),!,"Start can't be after the End" Q
 . . S FBI=FBI+1,FBRCPT(FBI)=FBX
 ;
 ; ask device
 W !!,"Note: Additional data printed if device supports 130+ characters"
 S VAR="BEGDATE^ENDDATE^FBRCPT*",PGM="START^FBAAPCS"
 D ZIS^FBAAUTL G EXIT:FBPOP
 ;
START ; queued entry
 ; input
 ;   BEGDATE - begin date (fileman)
 ;   ENDDATE - end date (fileman)
 ;   FBRCPT  - CPT codes to report ('A' All, 'I' Individual, 'R' Ranges)
 ;   FBRCPT( - array of specifc codes or ranges when not All CPT codes
 ;     format when FBRCPT="I"
 ;       FBRCPT(cpt code internal value)=cpt code external value
 ;     format when FBRCPT="R"
 ;       FBRCPT(sequential range #)=start value^end value
 U IO
 ;
GATHER ; collect and sort data
 K ^TMP($J)
 ; loop thru payments by date finalized
 S FBDT=BEGDATE-1
 F  S FBDT=$O(^FBAAC("AK",FBDT)) Q:FBDT'>0!(FBDT>ENDDATE)  D
 . ; loop thru veterans
 . S FBDFN=0
 . F  S FBDFN=$O(^FBAAC("AK",FBDT,FBDFN)) Q:FBDFN'>0  D
 . . ; loop thru vendors
 . . S FBV=0
 . . F  S FBV=$O(^FBAAC("AK",FBDT,FBDFN,FBV)) Q:FBV'>0  D
 . . . ; loop thru initial treatment dates
 . . . S FBK=0
 . . . F  S FBK=$O(^FBAAC("AK",FBDT,FBDFN,FBV,FBK)) Q:FBK'>0  D
 . . . . ; loop thru service provided (cpt)
 . . . . S FBL=0
 . . . . F  S FBL=$O(^FBAAC("AK",FBDT,FBDFN,FBV,FBK,FBL)) Q:FBL'>0  D
 . . . . . S FBY0=$G(^FBAAC(FBDFN,1,FBV,1,FBK,1,FBL,0))
 . . . . . S FBCPT=$$CPT^FBAAUTL4($P(FBY0,U))
 . . . . . ; quit if CPT code not included in report
 . . . . . I FBRCPT="I",'$D(FBRCPT($P(FBY0,U))) Q
 . . . . . I FBRCPT="R" S FBFND=0 D  Q:'FBFND
 . . . . . . S FBI=0 F  S FBI=$O(FBRCPT(FBI)) Q:'FBI  I $P(FBRCPT(FBI),U)']FBCPT,FBCPT']$P(FBRCPT(FBI),U,2) S FBFND=1 Q
 . . . . . ; passed CPT checks
 . . . . . S FBY2=$G(^FBAAC(FBDFN,1,FBV,1,FBK,1,FBL,2))
 . . . . . S FBMODL=$$MODL^FBAAUTL4("^FBAAC("_FBDFN_",1,"_FBV_",1,"_FBK_",1,"_FBL_",""M"")","E")
 . . . . . S FBCPTM=" "_FBCPT_$S(FBMODL]"":"-"_FBMODL,1:"")
 . . . . . ; retrieve counts and totals for the CPT-MODIFIERS combination
 . . . . . S FBX=$G(^TMP($J,FBCPTM))
 . . . . . ; update counts and totals for this payment
 . . . . . S $P(FBX,U)=$P(FBX,U)+1 ; total count
 . . . . . S $P(FBX,U,2)=$P(FBX,U,2)+$P(FBY0,U,3) ; total paid
 . . . . . ; if paid at the RBRVS amount
 . . . . . I +$P(FBY0,U,3)=+$P(FBY2,U,12),$P(FBY2,U,13)="R" D
 . . . . . . S $P(FBX,U,3)=$P(FBX,U,3)+1 ; RBRVS count
 . . . . . . S $P(FBX,U,4)=$P(FBX,U,4)+$P(FBY0,U,3) ; RBRVS payments
 . . . . . . ; calc 75th percentile
 . . . . . . S FBDOS=$P($G(^FBAAC(FBDFN,1,FBV,1,FBK,0)),U)
 . . . . . . S FBAMT=$$PRCTL^FBAAFSF($P(FBY0,U),FBMODL,FBDOS)
 . . . . . . I FBAMT>0 D
 . . . . . . . S $P(FBX,U,5)=$P(FBX,U,5)+1 ; covered by 75th count
 . . . . . . . S $P(FBX,U,6)=$P(FBX,U,6)+FBAMT ; 75th estimated payment
 . . . . . . E  D
 . . . . . . . S $P(FBX,U,7)=$P(FBX,U,7)+1 ; not covered by 75th count
 . . . . . . . S $P(FBX,U,8)=$P(FBX,U,8)+$P(FBY0,U,2) ; claimed amount
 . . . . . ; save counts and totals for the CPT-MODIFIERS combination
 . . . . . S ^TMP($J,FBCPTM)=FBX
 ;
PRINT ; report data
 S (FBQUIT,FBPG)=0 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 S FBO=$S(IOM>129:43,1:0) ; column offset if room to display more detail
 ;
 ; build page header text in FBHT( based on selection criteria
 K FBHT
 S FBHT(1)="  for Payments with Finalized Dates from "
 S FBHT(1)=FBHT(1)_$$FMTE^XLFDT(BEGDATE)_" to "_$$FMTE^XLFDT(ENDDATE)
 I FBRCPT="A" S FBHT(2)="  and all CPT Codes"
 E  D
 . S FBL=2,FBHT(FBL)="  and CPT Codes: "
 . S (FBC,FBI)=0 F  S FBI=$O(FBRCPT(FBI)) Q:'FBI  D
 . . I $L(FBHT(FBL))+$S(FBRCPT="I":2,1:10)+$L(FBRCPT(FBI))>75 D
 . . . I FBC S FBHT(FBL)=FBHT(FBL)_","
 . . . S FBL=FBL+1,FBC=0,FBHT(FBL)="                 "
 . . S FBHT(FBL)=FBHT(FBL)_$S(FBC:", ",1:"")
 . . I FBRCPT="I" S FBHT(FBL)=FBHT(FBL)_FBRCPT(FBI)
 . . I FBRCPT="R" S FBHT(FBL)=FBHT(FBL)_"from "_$P(FBRCPT(FBI),U)_" to "_$P(FBRCPT(FBI),U,2)
 . . S FBC=FBC+1 ; count of codes or ranges on current line (FBL)
 ;
 D HD
 I '$D(^TMP($J)) W !!,"  No payments found that match criteria. ",!
 ;
 S FBT="" ; initialize report totals 
 ; loop thru CPT-MODIFIER(S)
 S FBCPTM="" F  S FBCPTM=$O(^TMP($J,FBCPTM)) Q:FBCPTM=""  D  Q:FBQUIT
 . S FBX=$G(^TMP($J,FBCPTM))
 . I $Y+6>IOSL D HD Q:FBQUIT
 . ;
 . ; compute estimated savings
 . S FBSAV=$P(FBX,U,6)+$P(FBX,U,8)-$P(FBX,U,4)
 . ;
 . ; print detail line
 . W !,$E($P(FBCPTM,",",1,4),2,99) W:$P(FBCPTM,",",5)]"" "," W ?18,"|"
 . W ?20,$J($P(FBX,U,1),5),?26,$J($FN($P(FBX,U,2),",",2),13),?40,"|"
 . W ?42,$J($P(FBX,U,3),5),?48,$J($FN($P(FBX,U,4),",",2),13),?62,"|"
 . ; if room display additional detail
 . I FBO D
 . . W ?64,$J($P(FBX,U,5),5),?70,$J($FN($P(FBX,U,6),",",2),13)
 . . W ?85,$J($P(FBX,U,7),5),?91,$J($FN($P(FBX,U,8),",",2),13)
 . . W ?105,"|"
 . W ?63+FBO,$J($FN(FBSAV,",P",2),15),?78+FBO,"|"
 . ; if more than 4 modifiers then display them on subsequent lines
 . F FBI=1:1 Q:$P(FBCPTM,",",(FBI*4)+1)=""  D
 . . W !,?5,"-",$P(FBCPTM,",",(FBI*4)+1,(FBI*4)+4) ; next set of mods
 . . W:$P(FBCPTM,",",(FBI*4)+5)]"" "," ; additional line will be needed
 . . W ?18,"|",?40,"|",?62,"|" W:FBO ?105,"|" W ?78+FBO,"|"
 . ;
 . ; add to report totals
 . F FBI=1:1:8 S $P(FBT,U,FBI)=$P(FBT,U,FBI)+$P(FBX,U,FBI)
 . S $P(FBT,U,9)=$P(FBT,U,9)+FBSAV
 ;
 I FBQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 E  D  ; report totals
 . D DL
 . W !,"REPORT TOTALS ",?18,"|"
 . W ?20,$J($P(FBT,U,1),5),?26,$J($FN($P(FBT,U,2),",",2),13),?40,"|"
 . W ?42,$J($P(FBT,U,3),5),?48,$J($FN($P(FBT,U,4),",",2),13),?62,"|"
 . I FBO D
 . . W ?64,$J($P(FBT,U,5),5),?70,$J($FN($P(FBT,U,6),",",2),13)
 . . W ?85,$J($P(FBT,U,7),5),?91,$J($FN($P(FBT,U,8),",",2),13)
 . . W ?105,"|"
 . W ?63+FBO,$J($FN($P(FBT,U,9),",P",2),15),?78+FBO,"|"
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K BEGDATE,ENDDATE,FBRCPT
 K FBAMT,FBC,FBCPT,FBCPTM,FBDFN,FBDT,FBDTR,FBFND,FBHT,FBI,FBK
 K FBL,FBMODL,FBO,FBPG,FBPOP,FBQUIT,FBRCPT,FBSAV,FBT,FBV,FBX,FBY0,FBY2
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
HD ; page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,"COST/SAVINGS FROM RBRVS FEE SCHEDULE",?49,FBDTR,?72,"page ",FBPG
 S FBI=0 F  S FBI=$O(FBHT(FBI)) Q:'FBI  W !,FBHT(FBI)
 ;
 W !!,"CPT CODE-",?18,"|",?20,"Total Occurrences ",?40,"|"
 W ?42,"Payments at RBRVS",?62,"|"
 W:FBO ?64,"Estimated Payments if RBRVS was not used",?105,"|"
 W ?64+FBO,"Est. Savings",?78+FBO,"|"
 ;
 I FBO D
 . W !,?18,"|",?40,"|",?62,"|"
 . W ?64,"75th Percentile",?85,"Usual & Customary*"
 . W ?105,"|",?78+FBO,"|"
 ;
 W !,"  Modifier(s)",?18,"|",?20,"count   $ amount",?40,"|"
 W ?42,"count   $ amount",?62,"|"
 W:FBO ?64,"count   $ amount",?85,"count   $ amount",?105,"|"
 W ?64+FBO,"from RBRVS",?78+FBO,"|"
 ;
DL ; write dashed line
 W !,"------------------",?18,"|",?20,"----- -------------",?40,"|"
 W ?42,"----- -------------",?62,"|"
 W:FBO ?64,"----- -------------",?85,"----- -------------",?105,"|"
 W ?64+FBO,"-------------",?78+FBO,"|"
 Q
 ;
 ;FBAAPCS
