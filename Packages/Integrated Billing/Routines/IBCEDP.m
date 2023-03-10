IBCEDP ;ALB/ESG - EDI CLAIM STATUS REPORT PRINT ;13-DEC-2007
 ;;2.0;INTEGRATED BILLING;**377,592,641**;21-MAR-94;Build 61
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
PRINT ; entry point to print the report
 NEW CRT,IBPAGE,IBSTOP,IBCT,SV1,SV2,SV3,IEN,DATA,NEWHDR
 NEW DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 I IOST["C-" S CRT=1
 E  S CRT=0
 ;
 S IBPAGE=0,IBSTOP=0,IBCT=0,NEWHDR=0
 ;JWS;IB*2.0*641;added End of Report message to be consistent with when valid data is found.
 I '$D(^TMP($J,"IBCEDC")) D HDR W !!?5,"No data found for this report.",!!,"*** End of Report ***" G PX
 I $G(ZTSTOP) D HDR W !!?5,"This report was halted during compilation by TaskManager Request." G PX
 ;
 D HDR   ; initial header display
 S SV1=""
 F  S SV1=$O(^TMP($J,"IBCEDC",SV1)) Q:SV1=""!IBSTOP  D SD(SV1) D  Q:IBSTOP
 . S SV2=""
 . F  S SV2=$O(^TMP($J,"IBCEDC",SV1,SV2)) Q:SV2=""!IBSTOP  D  Q:IBSTOP
 .. S SV3=""
 .. F  S SV3=$O(^TMP($J,"IBCEDC",SV1,SV2,SV3)) Q:SV3=""!IBSTOP  D  Q:IBSTOP
 ... S IEN=0
 ... F  S IEN=$O(^TMP($J,"IBCEDC",SV1,SV2,SV3,IEN)) Q:'IEN!IBSTOP  D  Q:IBSTOP
 .... S DATA=$G(^TMP($J,"IBCEDC",SV1,SV2,SV3,IEN))
 .... D PRT(DATA)
 .... Q
 ... Q
 .. Q
 . Q
 ;
 I IBSTOP G PRINTX
 D:$Y>(IOSL-4) HDR G:IBSTOP PRINTX
 W !!?5,"Total number of EDI Claims:  ",IBCT
 D:$Y>(IOSL-4) HDR G:IBSTOP PRINTX
 W !!,"*** End of Report ***"
 ;
PX ;
 I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
PRINTX ;
 Q
 ;
PRT(Z) ; print a line on the report
 ; Z - data from the scratch global node
 N DIV,PAY,ADDR1,TAB  ;JRA IB*2.0*592 Added TAB
 D:$Y>(IOSL-3) HDR G:IBSTOP PRTX
 S IBCT=IBCT+1
 ;JWS;IB*2.0*641;if summary report, quit after count
 I $G(^TMP($J,"IBCEDS","SD"))="S" Q
 ;
 S DIV=$P($G(^DG(40.8,+$P(Z,U,10),0)),U,2)      ; division abbr
 S PAY=$P($G(^DIC(36,+$P(Z,U,12),0)),U,1)       ; payer name
 S ADDR1=$P($G(^DIC(36,+$P(Z,U,12),.11)),U,1)   ; payer address line 1
 ;
 W !,$P(Z,U,1)                                            ; claim#
 ;JRA IB*2*592 Add Condition for Dental Form Type 7
 ;W ?9,$S($P(Z,U,2)=2:1500,1:"UB04")                       ; form type  ;JRA IB*2.0*592 ';'
 ;JRA IB*2.0*592 Dental Form Type is 5 chars vs. 4, so set TAB accordingly
 S TAB=$S($P(Z,U,2)=7:8,1:9)                              ; Set tab per form type ;JRA IB*2.0*592
 W ?TAB,$S($P(Z,U,2)=2:"1500",$P(Z,U,2)=7:"J430D",1:"UB04") ; form type  ;JRA IB*2.0*592
 W ?14,$S($P(Z,U,3):"INPT",1:"OUTPT")                     ; inpat/outpat
 W ?21,$P(Z,U,4)                                          ; payer sequence
 W ?25,$P(Z,U,5)                                          ; EDI status code
 W ?29,$E($P(Z,U,13),1,9)                                 ; IB status abbr
 W ?39,$E($P(Z,U,11),1,2)                                 ; ar status abbr
 W ?44,$$FMTE^XLFDT($P(Z,U,6)\1,"2Z")                     ; last transmit date
 W ?55,$J($P(Z,U,7),4)                                    ; age in days
 W ?62,$P(Z,U,8)                                          ; batch#
 W ?69,$J($FN($P(Z,U,9),"",2),9)                          ; balance due
 W ?81,DIV                                                ; division
 W ?89,$E(PAY,1,23)                                       ; payer name
 W ?114,$E(ADDR1,1,18)                                    ; payer address line 1
 ;
 S NEWHDR=0  ; toggle new header flag
PRTX ;
 Q
 ;
HDR ; report header
 ;
 ; if screen output and page# already exists, do a page break at the bottom of the screen
 I IBPAGE,CRT D  I IBSTOP G HDRX
 . S DIR(0)="E" D ^DIR K DIR
 . I 'Y S IBSTOP=1
 . Q
 ;
 ; if screen output OR page# already exists, do a form feed
 I IBPAGE!CRT W @IOF
 I 'IBPAGE,'CRT W $C(13)   ; first printer page - left margin set
 ;
 S IBPAGE=IBPAGE+1
 ;JWS;IB*2.0*641;add summary/detail to header
 W "EDI Claim Status Report",$S($G(^TMP($J,"IBCEDS","SD"))="S":" (Summary)",1:" (Detail)")
 I $G(^TMP($J,"IBCEDS","SD"))="S" W ?48
 E  W ?96
 W $$FMTE^XLFDT($$NOW^XLFDT),"   Page: ",IBPAGE
 I $G(^TMP($J,"IBCEDS","SD"))'="S" W !,"** A claim may appear multiple times if transmitted more than once. **"
 I $G(^TMP($J,"IBCEDS","SD"))'="S" D
 . W !?3,"Sorted by ",$$SD^IBCEDS1($G(IBSORT1))
 . I $G(IBSORT2)'="" W ", then by ",$$SD^IBCEDS1(IBSORT2)
 . I $G(IBSORT3)'="" W ", then by ",$$SD^IBCEDS1(IBSORT3)
 . ;
 . ; display column headers
 . W !?25,"*-- Statuses --*"
 . W !,"Claim",?9,"Form",?14,"Type",?20,"Seq",?25,"EDI",?31,"IB",?39,"AR",?44,"Trans Dt",?56,"Age",?62,"Batch#",?71,"Bal Due"
 . W ?81,"Div",?89,"Payer"
 . ;
 N Z S Z="",$P(Z,"-",$S($G(^TMP($J,"IBCEDS","SD"))="S":80,1:133))="" W !,Z
 ;
 S NEWHDR=1    ; flag indicating a new page header was just printed
 ;
 ; check for a TaskManager stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  G HDRX
 . S (ZTSTOP,IBSTOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 . Q
 ;
HDRX ;
 Q
 ;
SD(SV) ; primary sort value display break.  This procedure is to display a break whenever the primary sort value changes
 ; SV - subscript value of the primary sort
 ;JWS;IB*2.0*641;display summary total only
 I $G(^TMP($J,"IBCEDS","SD"))="S" Q
 I IBSORT1=4!(IBSORT1=6) G SDX  ; don't display a break for current balance or for claim# primary sorts
 ;
 D:$Y>(IOSL-4) HDR G:IBSTOP SDX
 I 'NEWHDR W !     ; an extra line break if a page header was not just printed
 I $E(SV)="-",$D(IBSORTOR(IBSORT1)) S SV=$E(SV,2,999)    ; remove leading "-" on descending numerical sorts
 ;
 I IBSORT1=1 S SV=$$FMTE^XLFDT(SV,"5Z")   ; last transmitted date/time
 I IBSORT1=2 D                            ; payer name and address
 . N INS,ADDR
 . S INS=+$P(SV,U,2)                      ; ins co ien 2nd piece of subscript
 . S ADDR=$$INSADD^IBCNSC02(INS)          ; address fields
 . S SV=$P(SV,U,1)_"   "_$P(ADDR,U,2)_" "_$P(ADDR,U,6)_" "_$P(ADDR,U,5)
 . Q
 I IBSORT1=3 S SV=SV_" - "_$$EXTERNAL^DILFD(364,.03,,SV)   ; edi claim status and description
 I IBSORT1=5 D                                             ; division
 . N DZ,DIVNM
 . S DZ=+$O(^DG(40.8,"C",SV,""))                           ; division ien
 . S DIVNM=$P($G(^DG(40.8,DZ,0)),U,1)                      ; division name
 . S SV=SV_" - "_DIVNM
 . Q
 I IBSORT1=7 D                                             ; AR status
 . N AZ,ANM
 . S AZ=+$O(^PRCA(430.3,"C",SV,""))                        ; AR status ien
 . S ANM=$P($G(^PRCA(430.3,AZ,0)),U,1)                     ; AR status description
 . S SV=SV_" - "_ANM
 . Q
 I IBSORT1=8 S SV=SV_" Days"
 ;
 S SV=$$SD^IBCEDS1(IBSORT1)_": "_SV
 W !,SV
SDX ;
 Q
 ;
