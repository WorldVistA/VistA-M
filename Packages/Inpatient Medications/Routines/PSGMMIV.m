PSGMMIV ;BIR/MV-IV ORDER FOR THE 7/14 DAY MAR. ;25 Nov 98 / 9:24 AM
 ;;5.0; INPATIENT MEDICATIONS ;**20,21,58,111,131,145**;16 DEC 97;Build 17
 ;
 ; Reference to ^PS(52.7 supported by DBIA #2173.
 ; Reference to ^PS(55 supported by DBIA #2191.
 ;
START ;*** Read IV orders
 NEW MULTIPG
 S ON=""
 F PSGMARED=PSGMARSD-.0001:0 S PSGMARED=$O(^PS(55,PSGP,"IV","AIT",PST,PSGMARED)) Q:'PSGMARED  F  S ON=$O(^PS(55,PSGP,"IV","AIT",PST,PSGMARED,ON)) Q:ON=""  D IV
 Q
IV ;*** Sort IV orders for 24 Hrs, 7/14 Day MAR.
 K DRG,P N X,ON55,PSJLABEL S DFN=PSGP,PSJLABEL=1 D GT55^PSIVORFB
 Q:P(2)>PSGMARFD
 S X=$P(P("MR"),U,2) Q:XTYPE=2&(X["IV")  Q:XTYPE=3&(PST="S")&'($S(X="IV":1,X="IVPB":1,1:0))
 S QST=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3))
 S QST=$S(P(9)["PRN":"OVP",QST="O":"OVO",1:"CV")_XTYPE
 Q:(PSGMARS=2&(QST["C"))
 Q:(PSGMARS=1&(QST["O"))
 N PSGMARWC  ;DEM (05/30/2006) - PSGMARWC is used to preserve original value of PSGMARWN (patient location) in case location is changed by an order with a clinic location.
 S PSGMARWC=PSGMARWN
 I $G(DRG) S X=$S($G(DRG("AD",1)):DRG("AD",1),1:$G(DRG("SOL",1))),X=$E($P(X,U,2),1,20)_U_+ON_"V" D
 . N A
 . S A=$G(^PS(55,PSGP,"IV",+ON,"DSS")) I $P(A,"^")]"" S PSGMARWN="C!"_$P(A,"^") I $G(SUB1)]"",$G(SUB2)]"",'$D(^TMP($J,TM,PSGMARWN,SUB1,SUB2)) D
 . . N X,Y
 . . D SPN^PSGMMAR0
 . . Q
 . . ;
 . I PSGSS="P" S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),X)="" Q                         ;DAM  5-01-07 Print by PATIENT
 . I PSGSS="L" Q:((PSGINWDG="")&(PSGMARWN'["C!"))  S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),X)="" Q     ;DAM  5-01-07 Print by clinic group
 . I PSGSS="C" Q:((PSGINWD="")&(PSGMARWN'["C!"))  I ((PSGMARWN[PSGCLNC)!(PSGMARWN'["C!")) S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),X)=""  Q    ;DAM 5-01-07 Print by Clinic
 . ;
 . ;DAM 5-01-07 Set up XTMP global where location and patient names are switched for printing by WARD/PATIENT or WARD GROUP/PATIENT
 . I '$G(PSGREP) N PSGDEM1 S PSGDEM1=X D    ;transfer contents of patient drug information contained in "X" above to  a new variable temporarily
 . . S PSGREP="PSGM_"_$J
 . . S X1=DT,X2=1 D C^%DTC K %,%H,%T
 . . S ^XTMP(PSGREP,0)=X_U_DT
 . I PSGRBPPN="P",PSGSS="W" Q:((PSGINCL="")&(PSGMARWN["C!"))  D         ;Construct XTMP global for printing by WARD and sort by PATIENT
 . . S ^XTMP(PSGREP,TM,PPN,PSGMARWN,PSJPRB,$S(+PSGMSORT:$E(QST,1),1:QST),PSGDEM1)=""
 . . D SPN^PSGMMAR0
 . I PSGRBPPN="P",PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  D       ;Construct XTMP global for printing by WARD GROUP and sort by PATIENT
 . . S ^XTMP(PSGREP,TM,PPN,PSGMARWN,PSJPRB,$S(+PSGMSORT:$E(QST,1),1:QST),PSGDEM1)=""
 . . D SPN^PSGMMAR0
 . S X=$G(PSGDEM1)      ;Return value of X from PSGDEM1 back to X
 . ;
 . I PSGRBPPN="R",PSGSS="W" Q:((PSGINCL="")&(PSGMARWN["C!"))  D        ;Construct TMP global for printing by WARD and sort by ROOM/BED
 . . S ^TMP($J,TM,PSGMARWN,PSJPRB,PPN,$S(+PSGMSORT:$E(QST,1),1:QST),X)=""
 . I PSGRBPPN="R",PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  D      ;Construct TMP global for printing by WARD GROUP and sort by ROOM/BED
 . . S ^TMP($J,TM,PSGMARWN,PSJPRB,PPN,$S(+PSGMSORT:$E(QST,1),1:QST),X)=""
  . ;End DAM modifications 5-01-07
  . ;
 S:PSGMARWN'=PSGMARWC PSGMARWN=PSGMARWC
 Q
IVPRN ;*** Set ^tmp to store IV orders that have schedule of PRN.
 K P,DRG NEW ON55,CHEMO,TXT,PSJLABEL
 S ON=$P(DAOO,U,2),DFN=$P(PN,U,2),PSJLABEL=1
 ;* D:PST'["Z" GT55^PSIVORFB
 ;* I PST["Z" D GT531^PSIVORFA(DFN,ON)
 D:ON["V" GT55^PSIVORFB
 D:ON["P" GT531^PSIVORFA(DFN,ON)
 D SETVAR,SETLTRT
 ;the two naked references below refer to the full reference to the right of the = sign
 S ^(1)=$G(^TMP($J,"1PRN",PG,LAB,1))_UP_"      |            |"
 S ^(2)=$G(^TMP($J,"1PRN",PG,LAB,2))_UP_$E(P("LOG"),1,5)_" |",LN=3
 ;* S:PST["Z" ^(2)=^(2)_"P E N D I N G"
 ;* S:PST'["Z" ^(2)=^(2)_$E(P(2),1,5)_$E(P(2),9,14)_" |"_P(3)
 ;Naked reference below refers to ^TMP($J,"1PRN",PG,LAB,2)
 S:ON["P" ^(2)=^(2)_"P E N D I N G"
 ;Naked reference below refers to ^TMP($J,"1PRN",PG,LAB,2)
 S:ON["V" ^(2)=^(2)_$E(P(2),1,5)_$E(P(2),9,14)_" |"_P(3)
 ;Naked reference below refers to ^TMP($J,"1PRN",PG,LAB,2)
 S ^(2)=$$SETSTR^VALM1("("_$E(PSGP(0))_$E(PSSN,8,12)_")",^(2),40,7)
 F X=0:0 S X=$O(DRG("AD",X)) Q:'X  S TXT=$$WRTDRG^PSIVUTL(DRG("AD",X),47) S:LN=3 TXT=TXT_$$SP(47-$L(TXT))_PSGST,PSGST="" D CHK(.TXT)
 S TXT="in "
 ;; F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  S TXT=TXT_$$WRTDRG^PSIVUTL(DRG("SOL",X),47) S:LN=3 TXT=TXT_$$SP(47-$L(TXT))_PSGST,PSGST="" D CHK(.TXT) S TXT="   "
 F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  D
 . S TXT=TXT_$$WRTDRG^PSIVUTL(DRG("SOL",X),47) S:LN=3 TXT=TXT_$$SP(47-$L(TXT))_PSGST,PSGST="" D CHK(.TXT) S TXT="   "
 . S PSJPRT2=$P(^PS(52.7,+DRG("SOL",X),0),U,4) I PSJPRT2]"" S TXT=TXT_"   "_PSJPRT2 S:LN=3 TXT=TXT_$$SP(47-$L(TXT))_PSGST,PSGST="" D CHK(.TXT) S TXT="   "
 S TXT=$P(P("MR"),U,2)_" "_P(9)_" "_P(8) D CHK(.TXT)
 I P(4)="C" S CHEMO="*CAUTION-CHEMOTHERAPY*" D:P("OPI")]"" CHK(CHEMO)
 S Y1="" F Y=1:1:$L($P(P("OPI"),"^")," ") S Y1=Y1_$P($P(P("OPI"),"^")," ",Y)_" " I $L(Y1)>47 D CHK(Y1) S Y1=""
 I $L(Y1)>28 D CHK(Y1) S Y1=""
 I Y1<29,'(LN#6) S TXT=$S((P("OPI")=""&$D(CHEMO)):CHEMO,1:Y1),X=29-$L(TXT),TXT=TXT_$$SP(X)_INIT
 E  D  S TXT=$$SP(29)_INIT,LN=LN+1
 . ;the following three naked references below refer to the full references to the right of the = sign
 .  I LN=5 S ^(LN)=$G(^TMP($J,"1PRN",PG,LAB,LN))_UP_Y1
 .  E  D:$L(Y1) CHK(Y1) F LN=LN:1:5 S ^(LN)=$G(^TMP($J,"1PRN",PG,LAB,LN))_UP_""
 S ^(LN)=$G(^TMP($J,"1PRN",PG,LAB,LN))_UP_TXT
 Q
SETVAR ;***Initialize variables.
 NEW TMSTR
 F X="LOG",2,3 S:P(X) P(X)=$$ENDTC^PSGMI(P(X))
 S PSGST=$S(P(9)["PRN":"P",P(2)=P(3):"O",1:"C"),TMSTR=P(11),PSGLFFD=PSGMARFD
 D INITOPI^PSGMMIVC
 ;;S INIT="RPH: "_PSGLRPH,INIT=INIT_$$SP(37-($L(INIT)+29))_"RN: "_PSGLRN
 S INIT="RPH: "_PSGLRPH,INIT=INIT_$$SP(38-($L(INIT)+29))_"RN: "_PSGLRN
 ;* S INIT="RPH: "_PSGLRPH_" RN: "_PSGLRN
 ;* S INIT="RPH: "_$S(PSGLRPH]"":PSGLRPH_" ",1:"_____")_" RN: "_$S($G(PSGLRN)]"":PSGLRN,1:"_____")
 ;*** If OPI<29 char, it is ok to put INITs in the same line.
 ;*** If OPI=""&it's a Chemo order, warning & Inits prt on same line.
 ;*** Add number lines needed for additives and solutions and 1 line
 ;*** for infusion rate and 1 line for start/stop date.
 ;*** Multiple labels can have up to 5 lines per label and the last
 ;*** label can have up to 6 lines..
 ;
 NEW X S NAMENEED=0
 F X="AD","SOL" D NAMENEED^PSJMUTL(X,47,.NEED) S NAMENEED=NAMENEED+NEED
 S MULTIPG=0,NEED=1
 ;* S X=($L(P("OPI"))>28)+1+(P("OPI")]""&(P(4)="C"))
 ;* Find # of lines needed for OPI -- (($L(P("OPI"))\47)
 ;* If the last line in OPI < 29 --(($L(P("OPI")#47)>28) include init.
 S X=($L($P(P("OPI"),"^"))\47)+(($L($P(P("OPI"),"^"))#47)>28)+1+($P(P("OPI"),"^")]""&(P(4)="C"))
 S X=(NAMENEED+X+2) S:X>5 NEED=((X-6)\5)+2
 S:NEED>BL MULTIPG=1
 Q
CHK(TXT) ;
 ;naked reference below refers to the full reference to the right of the = sign
 I '(LN#6) S ^(LN)=$G(^TMP($J,"1PRN",PG,LAB,LN))_UP_"See next label for continuation",LN=1 D
 . I PSGMAROC+1>(BL/2) D
 . . I PSGMAROC=BL-1,MULTIPG D
 . . .;naked reference below refers to the full reference to the right of the = sign
 . . .F LN=LN:1:6 S ^(LN)=$G(^TMP($J,"1PRN",PG,LAB,LN))_UP_"" S:LN=3 ^(LN)=UP_"*** CONTINUE ON NEXT PAGE ***"
 . . .S PG=PG+1,(LN,LT,RT)=1,(PSGMAROC,MULTIPG)=0 D LTRT^PSGMMAR3(.LT,"")
 . . E  D LTRT^PSGMMAR3(.RT,"^")
 . E  D LTRT^PSGMMAR3(.LT,"")
 ;naked reference below refers to the full reference to the right of the = sign
 S ^(LN)=$G(^TMP($J,"1PRN",PG,LAB,LN))_UP_TXT,LN=LN+1,TXT=""
 Q
SETLTRT ;*** Increment line number for left or right label on PRN sheet.
 I (NEED+PSGMAROC)>BL S:PSGMAROC PG=PG+1,(LT,RT)=1,PSGMAROC=0
 I NEED+PSGMAROC=BL D  Q
 . I PSGMAROC<(BL/2) D LTRT^PSGMMAR3(.LT,"")
 . E  D LTRT^PSGMMAR3(.RT,"^")
 I PSGMAROC,((NEED+PSGMAROC)>(BL/2)) S PSGMAROC=$S(PSGMAROC>(BL/2):PSGMAROC,1:(BL/2)) D LTRT^PSGMMAR3(.RT,"^")
 E  D LTRT^PSGMMAR3(.LT,"")
 Q
SP(X) ;***Set up spaces need between info on TXT for the label.
 N Y S $P(Y," ",X)=" "
 Q $G(Y)
