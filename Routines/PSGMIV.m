PSGMIV ;BIR/MV-IV ORDER FOR THE 24 HOUR MAR. ;25 Nov 98 / 9:07 AM
 ;;5.0; INPATIENT MEDICATIONS ;**4,20,21,28,58,111,131,145**;16 DEC 97;Build 17
 ;
 ; Reference to ^PS(55 supported by DBIA #2191.
 ; Reference to ^PS(52.7 supported by DBIA #2173.
 ;
START ;*** Read IV orders
 S ON=""
 F PSGMARED=PSGPLS-.0001:0 S PSGMARED=$O(^PS(55,PSGP,"IV","AIT",PST,PSGMARED)) Q:'PSGMARED  F  S ON=$O(^PS(55,PSGP,"IV","AIT",PST,PSGMARED,ON)) Q:ON=""  D IV
 Q
IV ;*** Sort IV orders for 24 Hrs MAR.
 K DRG,P N X,ON55,PSJLABEL S DFN=PSGP,PSJLABEL=1 D GT55^PSIVORFB
 Q:P(2)>PSGPLF
 S X=$P(P("MR"),U,2) Q:XTYPE=2&(X["IV")  Q:XTYPE=3&(PST="S")&'($S(X="IV":1,X="IVPB":1,1:0))
 S QST=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3))
 S QST=$S(P(9)["PRN":"OVP",QST="O":"OVO",1:"CV")_XTYPE
 N PSGMARWC  ;DEM (05/30/2006) - PSGMARWC is used to preserve original value of PSGMARWN (patient location) in case location is changed by an order with a clinic location.
 S PSGMARWC=PSGMARWN
 I $G(DRG) S X=$S($G(DRG("AD",1)):DRG("AD",1),1:$G(DRG("SOL",1))),X=$E($P(X,U,2),1,20)_U_ON_"V" D
 . N A
 . S A=$G(^PS(55,PSGP,"IV",+ON,"DSS")) I $P(A,"^")]"" S PSGMARWN="C!"_$P(A,"^") I $G(SUB1)]"",$G(SUB2)]"",'$D(^TMP($J,TM,PSGMARWN,SUB1,SUB2)) D
 . . N X,X1,Y
 . . D SPN^PSGMAR0
 . . Q
 . . ;
 . I PSGSS="P" S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),X)="" Q                         ;DAM 5-01-07 Print by PATIENT
 . I PSGSS="L" Q:((PSGINWDG="")&(PSGMARWN'["C!"))  S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),X)="" Q     ;DAM 5-01-07 Print by clinic group
 . I PSGSS="C" Q:((PSGINWD="")&(PSGMARWN'["C!"))  I ((PSGMARWN[PSGCLNC)!(PSGMARWN'["C!")) S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),X)=""  Q    ;DAM 5-01-07 Print by Clinic
 . ;
 . ;DAM 5-01-07 Set up XTMP global where location and patient names are switched
 . I '$G(PSGREP) N PSGDEM1 S PSGDEM1=X D   ;transfer contents of patient drug information contained in "X" above to a new variable temporarily
 . . S PSGREP="PSGM_"_$J
 . . S X1=DT,X2=1 D C^%DTC K %,%H,%T
 . . S ^XTMP(PSGREP,0)=X_U_DT
 . I PSGRBPPN="P",PSGSS="W" Q:((PSGINCL="")&(PSGMARWN["C!"))  D         ;Construct XTMP global for printing by WARD and sort by PATIENT
 . . S ^XTMP(PSGREP,TM,PPN,PSGMARWN,PSJPRB,$S(+PSGMSORT:$E(QST,1),1:QST),PSGDEM1)=""
 . . D SPN^PSGMAR0
 . I PSGRBPPN="P",PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  D       ;Construct XTMP global for printing by WARD GROUP and sort by PATIENT
 . .  S ^XTMP(PSGREP,TM,PPN,PSGMARWN,PSJPRB,$S(+PSGMSORT:$E(QST,1),1:QST),PSGDEM1)=""
 . .  D SPN^PSGMAR0
 . S X=$G(PSGDEM1)
 . ;END DAM
 . ;
 . I PSGRBPPN="R",PSGSS="W" Q:((PSGINCL="")&(PSGMARWN["C!"))  D        ;Construct TMP global for printing by WARD and sort by ROOM/BED
 . . S ^TMP($J,TM,PSGMARWN,PSJPRB,PPN,$S(+PSGMSORT:$E(QST,1),1:QST),X)=""
 . I PSGRBPPN="R",PSGSS="G" Q:((PSGINCLG="")&(PSGMARWN["C!"))  D      ;Construct TMP global for printing by WARD GROUP and sort by ROOM/BED
 . . S ^TMP($J,TM,PSGMARWN,PSJPRB,PPN,$S(+PSGMSORT:$E(QST,1),1:QST),X)=""
 . ;
 S:PSGMARWN'=PSGMARWC PSGMARWN=PSGMARWC
 ;
 Q
PRT ;*** Print IV orders.
 K TS,P,DRG NEW ON55,LN,PSJLABEL S PSJLABEL=1
 S ON=$P(DAO,U,2),DFN=$P(PN,U,2) D:ON["V" GT55^PSIVORFB
 D:ON["P" GT531^PSIVORFA(DFN,ON)
 S TS=1,TMSTR="" I P(9)]"" D ORSET,TS^PSGMAR3(P(11))
 F X="LOG",2,3 S:P(X) P(X)=$$ENDTC1^PSGMI(P(X))
 S PSGST=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3)) I PSGST'="O" S PSGST=$S(P(9)["PRN":"P",1:"C")
 S PSGLFFD=PSGPLF
 D INITOPI^PSGMMIVC
 NEW NAMENEED,NEED,X S NAMENEED=0
 D LNNEED,PRTIV
 Q
LNNEED ;*** Find lines needed per label.
 ;*** If OPI<29 char, it is ok to put INITs in the same line.
 ;*** Add number of lines needed for additives and solutions and 1 line
 ;*** for infusion rate and x line for OPI. Divide by 5 to determine
 ;*** of label(s) needed for this order.
 F X="AD","SOL" D NAMENEED^PSJMUTL(X,47,.NEED) S NAMENEED=NAMENEED+NEED
 S X=($L($P(P("OPI"),"^"))\47)+(($L($P(P("OPI"),"^"))#47)>28)+1+($P(P("OPI"),"^")]""&(P(4)="C"))
 S X=(NAMENEED+X+2) S X=$S(X<6:1,1:((X-6)\5)+2)
 S LN=$S(TS/6>X:TS/6,1:X)
 Q
 ;
OS ; order record set
 Q
 ;
PRTIV ;*** Print IV order on MAR
 D ONHOLD^PSGMMAR2
 I PSGMAROC,(PSGMAROC+LN)>6 D BOT^PSGMAR3,HEADER^PSGMAR3
 NEW PSGL S PSGL="|"
 S PSGMAROC=PSGMAROC+1 W !?6,"|",?19,"|",?48,PSGL,$G(TS(1)),?55,"|"
 W !,$E(P("LOG"),1,5)," |"
 I ON["V" D
 . I $G(ONHOLD) W "O N  H O L D" Q
 . W $E(P(2),1,5)_$E(P(2),9,14)," |",P(3)
 . Q
 W:ON["P" "P E N D I N G"
 W ?39,"(",$E(PSGP(0))_$E(PSSN,8,12)_")"
 W ?48,PSGL,$G(TS(2)),?55,"|" S L=3
 NEW NAME,PSIVX
 F PSIVX=0:0 S PSIVX=$O(DRG("AD",PSIVX)) Q:'PSIVX  D NAME^PSIVUTL(DRG("AD",PSIVX),47,.NAME,1) F Y=0:0 S Y=$O(NAME(Y)) Q:'Y  W !,NAME(Y) W:L=3 ?47,PSGST W ?48,PSGL,$G(TS(L)),?55,"|" D:(PSIVX=1&((PSGST="O")!(PSGST="C"))) TMSTR^PSGMAR3 D L(1)
 W:$G(DRG("SOL",0)) !,"in "
 NEW PSJPRT2
 F PSIVX=0:0 S PSIVX=$O(DRG("SOL",PSIVX)) Q:'PSIVX  D NAME^PSIVUTL(DRG("SOL",PSIVX),47,.NAME,1) F Y=0:0 S Y=$O(NAME(Y)) Q:'Y  D
 . W:(Y>1!(PSIVX>1)) ! W ?4,NAME(Y) W:L=3 ?47,PSGST W ?48,PSGL,$G(TS(L)),?55,"|" D:L=3 TMSTR^PSGMAR3 D L(1)
 . S PSJPRT2=$P(^PS(52.7,+DRG("SOL",PSIVX),0),U,4) I PSJPRT2]"" W !?7,PSJPRT2 W:L=3 ?47,PSGST W ?48,PSGL,$G(TS(L)),?55,"|" D:L=3 TMSTR^PSGMAR3 D L(1)
 W !,$P(P("MR"),U,2)," ",P(9)," ",P(8) W ?48,PSGL,$G(TS(L)),?55,"|" I L>5,(L#5) W !
 I '$O(DRG("AD",0))!('$O(DRG("SOL",0))) W !?48,PSGL,$G(TS(L)),?55,"|" S L=5
 I P(4)="C",'(L#5),P("OPI")="" W !,"*CAUTION-CHEMOTHERAPY*" S L=L+1 Q
 I P(4)="C" D L(1) W !,"*CAUTION-CHEMOTHERAPY*",?48,PSGL,$G(TS(L)),?55,"|"
 I (L#5)=0,($L($P(P("OPI"),"^"))<29),(TS<7) S L=L+1
 E  D L(1)
 W:P("OPI")=""&(TS>6) !
 I P("OPI")'="" D
 . W:(L#6)=0 !
 . F Y=1:1:$L($P(P("OPI"),"^")," ") S Y1=$P($P(P("OPI"),"^")," ",Y) D  W Y1," "
 . I ($X+$L(Y1))>47 W ?48,PSGL,$G(TS(L)),?55,"|" D L(1) W !
 I L>TS,(L#6) W ?48,PSGL,$G(TS(L)),?55,"|" S L=L+1 W:L#6=0 !
 I (TS-1)>L W ?48,PSGL,$G(TS(L)),?55,"|" D
 . F L=L+1:1:TS-1 D L(0) W !?48,PSGL,$G(TS(L)),?55,"|"
 . S L=L+1
 F  Q:'(L#6)  W !?48,PSGL,$G(TS(L)),?55,"|" S L=L+1
 I '(L#6),(P("OPI")="") W !
 I P("OPI")]"",(L>6) W !
 W ?29,"RPH: ",PSGLRPH,?38,"RN: ",PSGLRN,?48,PSGL,$G(TS(L)),?55,"|" W:PSGMAROC<6 !?7,LN2
 Q
 ;
L(X) ;***Check to see if a new block is needed.
 S L=L+X
 I L#6=0,PSGMAROC<6 W !,"See next label for continuation",?48,PSGL,$G(TS(L)),?55,"|" W:PSGMAROC<6 !?7,LN2 S PSGMAROC=PSGMAROC+1,L=L+1 D
 .I LN>6,(PSGMAROC>5) S MSG1="*** CONTINUE ON NEXT PAGE ***" D BOT^PSGMAR3,HEADER^PSGMAR3 S PSGMAROC=1
 Q
ORSET ; order record set
 Q:PST["P"!P(9)=""
 S PSGMFOR="",(SD,X)=$P(P(2),".") Q:X>PSGPLF  S FD=$P(P(3),"."),PSGOES="",X=P(9) D EN^PSGS0 S T=PSGS0XT
 S X="" I "OB"]PST,$P(P(9),"^")'["@",P(2)'>PSGPLS,P(3)'<PSGPLF,P(11),T<1441,T'="D" S X=P(11),PSGPLC=1
 E  I "OB"]PST!(PST["OV") K PSGMAR D SETL0 S (Q,X)="" F QX=0:0 S Q=$O(PSGMAR(Q)) Q:Q=""  S X=X_$E("0",2-$L(Q))_Q_"-"
 S TMSTR=X
 K HCD,HM,I,J,PSGD,PLSD,CD,M,MID,MN,ND,ND1,OD,ST,QD1,QD2,QQ,TS,UD,WDT,WS,WS1,X,X1,X2 Q
 Q
SETL0 ;*** Set variable to use in ^PSGPL0 to calculate admin time.
 K PSGMAR S PSGPLC=0
 S ND1=P(4),ST=P(2),PLSD=P(3),TS=P(11),MN=T,ND=P(9) I $S(ST'?7N1"."1N.E:1,1:PLSD'?7N1"."1N.E) S PSGPLC="OI" Q
 D ENIV^PSGPL0
 Q
 ;
RPHINIT(RPH) ; Find initial for the person who completed the IV order.
 S RPH=$P($G(^PS(55,PSGP,"IV",+ON,4)),U,4)
 S:+RPH RPH=$$DEFINIT(+RPH)
 I RPH="" S RPH="_____"
 Q
DEFINIT(X)         ;
 S X=$G(^VA(200,X,0)),RPH=$P(X,U,2) Q:RPH]"" RPH
 S X=$P(X,U),RPH=$E(X,$F(X,","))_$E(X) Q RPH
