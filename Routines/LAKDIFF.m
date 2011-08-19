LAKDIFF ;DALOI/RWF - KEYBOARD DIFFERENTIAL COUNTER ;8/16/90  10:38
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**13,52**;Sep 27, 1994
 ;
 ; Cross link by id = accession
 ;
LA1 ;
 I '$D(LRPARAM) D ^LRPARAM
 ;
 D HOME^%ZIS
 ;
 S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)),U="^"
 I TSK<1 D  Q
 . W !,"Unable to find entry in AUTO INSTRUMENT file using ",LANM," as PROGRAM NAME"
 . D QUIT
 ;
 W !!?20,"KEYPAD DIFF ENTRY",!!
 ;
 S LREND=0,LRTOP=$P(^LAB(69.9,1,1),U,1)
 D ^LASET
 I 'TSK D  Q
 . W $C(7),!!,"AUTO INSTRUMENT file is incompletly defined for the Keypad Diff."
 . D QUIT
 ;
 I LALCT="N" D  Q
 . W $C(7),!!,"Field LOAD CHEM TESTS is configured incorrectly in AUTO INSTRUMENT File"
 . W !,"Set it to either 'TC ARRAY' or 'TMP GLOBAL'."
 . D QUIT
 ;
 K ^LA("LOCK",TSK)
 ;
 S DTIME=$$DTIME^XUP(DUZ)
 S DT=$$DT^XLFDT
 ;
 D DISPLAY
 I LREND D QUIT Q
 ;
 ; Select accession date to use
 S LRAA=+$G(WL)
 I LRAA<1 D QUIT Q
 D ADATE^LRWU
 I LREND D QUIT Q
 ;
 ; Get last accession used on this date if any
 S LRAN=+$P($G(^LRO(68,LRAA,1,LRAD,2)),"^",4)
 ;
 I $P(LRPARAM,U,14),$P($G(^LRO(68,LRAA,0)),U,16) D ^LRCAPV
 I LREND D QUIT Q
 ;
 D INT
 ;
 ; Setup screen and keyboard
 S LAXGF=1 D PREP^XGF
 ;
 ; Set read terminator to <CR>. Otherwise problems in scroll&roll sections.
 D INITKB^XGF($C(13))
 ;
 ; Turn on echo, cursor, keypad in numeric mode
 X ^%ZOSF("EON") W IOCUON_IOKPNM
 ;
 ; Get code to erase entire display
 S X="IOEDALL" D ENDR^%ZISS
 ;
 F  D LA2 Q:LREND
 D QUIT
 ;
 Q
 ;
LA2 ;
 N CUP,FLAG,I,ID,IDE,LADFN,LADT,LAOK,TRAY,TV,X,Y
 ;
 S RMK=""
 F  D WLN Q:LREND!(LAOK)
 I LREND Q
 S FLAG=0
 ;
 ; Save value of LRDFN, call to LAGEN sets it to 0
 S LADFN=LRDFN
 S (ID,LOG)=LRAN,IDE=0,LADT=LRAD
 S TRAY=1,CUP=""
 ;Can be changed by the cross-link code
 X LAGEN
 I 'ISQN D  Q
 . W !!,$C(7),"Unable to create entry in LAH global",!
 ;
 S LRDFN=LADFN
 ;
 D ^LAKDIFF1
 I 'FLAG D ^LAKDIFF2
 I FLAG Q
 ;
 S I=0
 F  S I=$O(TV(I)) Q:I<1  S:TV(I,1)]"" ^LAH(LWL,1,ISQN,I)=TV(I,1)
 I $L($G(RMK)) D RMK^LASET
 ;
 D ^LAKDIFF3
 Q
 ;
WLN ; Select accession/patient to work with
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S LAOK=0
 S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN))
 I LRAN'>0 S LRAN="^"
 S DIR(0)="NO^1:9999999:0^K:'$D(^LRO(68,LRAA,1,LRAD,1,X,0)) X"
 S DIR("A")="Accession Number",DIR("B")=LRAN
 S DIR("?")="Enter a valid accession number to enter DIFF results on."
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 S LRAN=Y
 ;
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRACC=$S($D(^(.2)):^(.2),1:"")
 S LRODT=$S($P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,4):$P(^(0),U,4),1:$P(^(0),U,3)),LRSN=$P(^(0),U,5)
 S LRIDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5)
 ;
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX
 ;
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="YO"
 S DIR("A",1)="Patient name: "_PNM_"  SSN: "_SSN_"  Acc: "_LRACC
 S DIR("A")="Is this the correct patient"
 S DIR("B")="YES"
 D ^DIR
 ;
 I $D(DIRUT) S LREND=1 Q
 I Y=1 S LAOK=1
 Q
 ;
INT ;
 N I1,I2,I3,I4,LAI,LAJ,X
 ;
 K KEY
 ;
 I LALCT="T" D
 . M ^TMP("LA",$J)=TC
 . K TC
 ;
 S LAI=0
 F  S LAI=$O(^TMP("LA",$J,LAI)) Q:LAI'>0  D
 . S LAJ=$S(LAI<30:"W",1:"R")
 . S I3=^(LAI,3),I4=^(4),X=^(0)
 . ;
 . I $D(KEY(LAJ,I4)) D  Q
 . . W $C(7),!!,">> The same KEY (",I4,") is set for more than one TEST<<",!!,$C(7)
 . ;
 . S I1=$P(^LAB(60,X,.1),U,1),I2=+^(.2)
 . S ^TMP("LA",$J,LAI,.1)=I1,^(.2)=I2
 . S ^TMP($J,LAJ,LAI)=I4,KEY(LAJ,I4)=""
 . I I3=2 S ^TMP($J,"NC",LAI)=""
 Q
 ;
DISPLAY ; Ask user if display should be updated on each key press
 ;
 N DIR,DIROUT,DIRUT,DTOUT,LAXPAR,X,Y
 ;
 ; Get stored value from parameter tool
 S X=$$GET^XPAR("USR","LA KDIFF DISPLAY UPDATE",1,"E")
 ;
 I $L(X) S DIR("B")=X
 E  S DIR("B")="YES"
 S DIR(0)="YO"
 S DIR("A")="Update display on each key press"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 ;
 S LAUPDATE=Y
 ; Save parameter for future use
 D EN^XPAR("USR","LA KDIFF DISPLAY UPDATE",1,Y,.LAXPAR)
 Q
 ;
QUIT ;
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 I $G(LAXGF) D
 . D CLEAN^XGF
 . D KILL^%ZISS
 ;
 S LREND=0
 I $D(LRCSQ),'$O(^XTMP("LRCAP",LRCSQ,DUZ,0)) D
 . K ^XTMP("LRCAP",LRCSQ,DUZ)
 . K LRCSQ
 ;
 I $D(LRCSQ),$G(LRAA),$P($G(^LRO(68,+LRAA,0)),U,16) D STD^LRCAPV
 ;
 D STOP^LRCAPV
 D ^LRGVK
 ;
 K %,ACK,ASK,BASE,C,CENUM,CHK,CNT,CODE,CONT,CUP,DA,DATYP,DFN,DONE,DPF,ECHOALL,ER,FLAG,HDR,HOME,HRD,I,I1,I3,I4,ID,IDE,IDENT,IDT,IN,ISQN,J,K,KEY,L,LAGEN,LACT,LALCT,LANM,LAUPDATE,LAXGF,LINE
 K LINK,LOG,LRAA,LRACC,LRAD,LRAN,LRDFN,LRDPF,LRDY,LREND,LRIDT,LRIO,LRLL,LRODT,LROVER,LRPGM,LRSET,LRSN,LRSUBS,LRTIME,LRTOP,LRTST,LWL,M,METH,NAK,NC,NOW,OUT,PNM,Q,RMK,RT,SS
 K SSN,STORE,T,T1,T2,TC,TEMP,TOTAL,TOUT,TP,TQ,TRAP,TRAY,TRY,TSK,TV,TY,TYPE,V,WDT,WL,X,Y,YY,Z,ZTSK
 ;
 K ^TMP($J),^TMP("LA",$J),^TMP("LR",$J)
 Q
 ;
TRAP ; Error Trap
 D ^LABERR
 S T=TSK D SET^LAB
 G @("LA2^"_LANM)
