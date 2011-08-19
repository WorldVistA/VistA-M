LRVR4 ;DALOI/CJS/DALOI/FHS - LAB ROUTINE DATA VERIFICATION ; 24 Jan 2004
 ;;5.2;LAB SERVICE;**14,42,121,153,221,263,279,283,287,286,330**;Sep 27, 1994
 I $D(LRSBCOM) D
 . N LRX
 . S LRX=0
 . F  S LRX=$O(LRSBCOM(LRX)) Q:LRX=""  S ^LAH(LRLL,1,LRSQ,1,LRX)=LRSBCOM(LRX)
 K %,LRSBCOM
 D LOOP
 Q
 ;
 ;
LOOP ;
 S LRLCT=0
 W !!,PNM,"   SSN: ",SSN,"   "
 I LRDPF=2 W "   LOC: ",$S(LRWRD'="":LRWRD,1:$S($L($P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,7)):$P(^(0),U,7),1:"??"))
 W !,"Pat Info: ",$P($G(^LR(LRDFN,.091)),U)
 W ?34," Sex: ",$S(SEX="M":"MALE",SEX="F":"FEMALE",1:SEX)
 W ?48," Age: ",$$CALCAGE^LRRPU(DOB,LRCDT)," as of ",$$FMTE^XLFDT(LRCDT,"1D")
 S LRPRAC=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,8)
 I LRPRAC>0,LRPRAC=+LRPRAC D GETS^DIQ(200,LRPRAC_",",".01;.132;.137;.138","E","LRPRAC(LRPRAC)","LRERR")
 W !,"Provider: "
 S LRLCT=LRLCT+3
 I LRPRAC'="",'$D(LRPRAC(LRPRAC,200)) W LRPRAC
 I LRPRAC,$D(LRPRAC(LRPRAC,200)) D
 . W LRPRAC(LRPRAC,200,LRPRAC_",",.01,"E"),?40," Voice pager: ",LRPRAC(LRPRAC,200,LRPRAC_",",.137,"E")
 . W !,"   Phone: ",LRPRAC(LRPRAC,200,LRPRAC_",",.132,"E"),?38," Digital pager: ",LRPRAC(LRPRAC,200,LRPRAC_",",.138,"E")
 . S LRLCT=LRLCT+1
 ;
 N PRAC,PR
 D PRAC^LR7OMERG(LRAA,LRAD,LRAN,.PRAC)
 I $O(PRAC(0)) D
 . S PR=0
 . F  S PR=$O(PRAC(PR)) Q:PR<1  I $D(^VA(200,PR,0)) W !?14,$P(^(0),"^") S LRLCT=LRLCT+1
 ;
 W ! S LRNX=0,LRVRM=1,Z=LRCDT,LRLCT=LRLCT+1
 I $P(Z1,U,7)'="" W !,"VOLUME: ",$P(Z1,U,7) S LRLCT=LRLCT+1
 S LRACC=$P(Z1,U,6)
 W !,"ACCESSION:",?30,$P(Z2,U,6),?44," ",LRACC
 W !,LRPANEL,?30,LRDAT(2),?44," ",LRDAT
 S LRLCT=LRLCT+2
 I $D(LRALERT),LRALERT<($P(LRPARAM,U,20)+1) D
 . W !?15 W:$E(IOST,1,2)="C-" @LRVIDO
 . W "Test ordered "_$P($G(^LAB(62.05,+LRALERT,0)),U)
 . W:$E(IOST,1,2)="C-" @LRVIDOF,$C(7)
 . S LRLCT=LRLCT+1
 I $D(LRGVP) D V20 Q
 I ($O(LRSB(0))<1!$D(LRPER))&'$D(LRNUF) D LRSBCOM G EDIT
 K LRNUF
 D V20:'$D(LRPER) Q:$O(LRSB(1))<1  G:LREDIT EDIT
V36 ;
 S LRTEC=$S($D(^LRO(68,LRAA,1,LRAD,2)):$P(^(2),U),1:$S($D(LRUSI):LRUSI,1:"")),LREDIT=0
 ;
V3 ;
 D LRSBCOM,DCOM^LRVERA
 ;
 ; If entering reference lab results only allow editing comments/workload
 K DIR
 S LRLCT=0
 I $G(LRDUZ(2)),DUZ(2)'=LRDUZ(2) D
 . S DIR(0)="SAO^C:Comments;W:Workload"
 . S DIR("A")="SELECT ('C' for Comments, 'W' Workload): "
 E  D
 . S DIR(0)="SAO^E:Edit;C:Comments;W:Workload"
 . S DIR("A")="SELECT ('E' to Edit, 'C' for Comments, 'W' Workload): "
 D ^DIR
 I $D(DIRUT) S X="^" G V37
 S X=Y
 S:$E(X)="E" LREDIT=1,X=""
 I X="C" D COM G LOOP
 ;
 I $E(X)="W" D  G LOOP
 . I $P(LRPARAM,U,14),$P($G(^LRO(68,LRAA,0)),U,16) D STD^LRCAPV,EN^LRCAPV S LREND=0 Q
 . W !?10,"Workload is not activated. "
 ;
 S X=$S(X="@":"",X="":LRTEC,1:X),LRTEC=X
 S:'$D(^LRO(68,LRAA,1,LRAD,2)) ^(2)="" S ^(2)=X_U_$P(^(2),U,2,99)
 G EDIT:LREDIT
V37 Q  ;LEAVE LRVR4, BACK TO LRVR3
 ;
 ;
V25 ;
 I LRVF K LRSB(LRSB),LRM(LRSB) Q
 I '$D(LRSB(LRSB)) S LRSB(LRSB)=^LR(LRDFN,LRSS,LRIDT,LRSB) Q
 Q
 ;
 ;
V20 S LRNX=$O(LRORD(LRNX)) G V35:LRNX<1 D SUBS G V20:'LRTS
 I $D(^LR(LRDFN,LRSS,LRIDT,LRSB)),^(LRSB)'["pending" D V25 G:LRVF V20
 I "CH"'=LRSS G V20
 D V25^LRVR5
 W !,$P(^LAB(60,+LRTS,0),U)
 S X1=""
 I $D(^LR(LRDFN,LRSS,LRLDT,LRSB)) D
 . S X1=$P(^(LRSB),U),(LRDL,X)=X1
 . I $$GET1^DID(63.04,LRSB,"","TYPE","","LRERR")="SET" D
 . . S X=$$EXTERNAL^DILFD(63.04,LRSB,"",X1)
 . . I X="" S X=X1
 . W:X'="" ?30,@LRFP
 S X="",LRFLG=""
 I $D(LRSB(LRSB)),$P(LRSB(LRSB),U)'="" D
 . N LRX
 . K LRNOVER(LRSB)
 . S (LRDL,LRX,X)=$P(LRSB(LRSB),U)
 . I $$GET1^DID(63.04,LRSB,"","TYPE","","LRERR")="SET" D
 . . S X=$$EXTERNAL^DILFD(63.04,LRSB,"",LRX)
 . . I X="" S X=LRX
 . W ?44," ",@LRFP," "
 . S X=LRX,Y=0
 . K LRQ
 . I X="" Q
 . I (X="canc")!(X="comment")!(X="pending") D  Q
 . . W LRFLG,?56," ",$P(LRNG,U,7)
 . . S LREDIT=0
 . I LRDEL'="" S LRQ=1,LRVRM=11 X LRDEL S LRVRM=1 K LRQ
 . D RANGE
 . W LRFLG,?56," ",$P(LRNG,U,7) S:X'="" LREDIT=0
 I '$D(LRNUF) S LRLCT=LRLCT+1 S:$X>80 LRLCT=LRLCT+1 D:LRLCT>22 WT G:$G(Y)'="^" V20
 ;
V35 ;
 D LRCFL:LRCFL]""
 K LRNUF
 Q
 ;
 ;
LRCFL ;
 S LREXEC=LRCFL D ^LREXEC:LRCFL[""
 D:LRLCT>22 WT
 Q
 ;
 ;
EDIT ;
 S LROUT=1 D ^LRVR5
 S LRVRM=1,LREDIT=0
 G LRCFL:LROUT!$D(LRPER),LOOP
 ;
 ;
RANGE ;
 ; If results from another system, use flags returned with results
 ; and set LRNG,LRNGS with normals from message.
 ; Check for LRDUZ(2) set for performing lab or performing lab set (piece 9) in LRSB(LRSB) array.
 I $G(LRDUZ(2)),DUZ(2)'=LRDUZ(2) S Y=X D PLNR,CKPLNR,RQ Q
 I $P(LRSB(LRSB),"^",9),DUZ(2)'=$P(LRSB(LRSB),"^",9) S Y=X D PLNR,CKPLNR,RQ Q
 ;
 D RANGE^LRVER4,RQ
 Q
 ;
 ;
RQ S X=Y
NR I $D(LRSB(LRSB))#2 D
 . N I,LRX,LRY
 . I $P(X,U)="" S LRSB(LRSB)="" Q
 . S $P(LRSB(LRSB),U)=X
 . S $P(LRSB(LRSB),U,2)=LRFLG
 . S $P(LRSB(LRSB),U,4)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 . I $P(LRSB(LRSB),U,9)="" S $P(LRSB(LRSB),U,9)=$S($G(LRDUZ(2)):LRDUZ(2),$G(DUZ(2)):DUZ(2),1:"")
 . S LRX=$$TMPSB^LRVER1(LRSB),LRY=$P(LRSB(LRSB),U,3)
 . F I=1:1:$L(LRX,"!") I $P(LRY,"!",I)="" S $P(LRY,"!",I)=$P(LRX,"!",I)
 . S $P(LRSB(LRSB),U,3)=LRY
 . I $P($P(LRSB(LRSB),U,3),"!")="" D RONLT^LRVER3
 . S LRX=LRNGS,LRY=$P(LRSB(LRSB),U,5)
 . F I=1:1:$L(LRX,U) I $P(LRY,"!",I)="" S $P(LRY,"!",I)=$P(LRX,U,I)
 . S $P(LRSB(LRSB),U,5)=LRY
 Q
 ;
 ;
PLNR ; Performing lab normal ranges, use instead of current local ranges
 ; Retrieve from results when "NPC" node = 2 or greater
 ; and set LRNG and LRNGS with normals from HL7 message/interface.
 N I,LRY
 I +$G(^LR(LRDFN,LRSS,LRIDT,"NPC"))<2 Q
 S LRY=$P($G(LRSB(LRSB)),"^",5)
 S $P(LRNGS,"^")=$P(LRY,"!")
 F I=2:1:5,11,12 D
 . ; enclose in quotes if not numeric
 . I I<6,$P(LRY,"!",I)'?.N.1".".N S $P(LRY,"!",I)=$C(34)_$P(LRY,"!",I)_$C(34)
 . S $P(LRNGS,"^",I)=$P(LRY,"!",I),$P(LRNG,"^",I)=$P(LRY,"!",I),@("LRNG"_I)=$P(LRY,"!",I)
 S $P(LRNG,"^",7)=$P(LRY,"!",7),$P(LRNGS,"^",7)=$P(LRY,"!",7)
 Q
 ;
 ;
CKPLNR ; Check performing lab normal ranges and set abnormal flag
 ; based on HL7 messages/interface.
 S LRFLG=$P(LRSB(LRSB),"^",2)
 I '$D(LRQ),$E(LRFLG,2)="*" D DISPFLG^LRVER4
 Q
 ;
 ;
SUBS D SUBS^LRVER4
 Q
 ;
 ;
WT D WT^LRVER4
 Q
 ;
 ;
COM ;from LRVR5
 Q:$D(LRGVP)!('$D(LRLABKY))
 D DCOM^LRVERA
 K DR,DA,DIE
 S DIE="^LR("_LRDFN_",""CH"",",DA=LRIDT,DA(1)=LRDFN,DR=.99 D ^DIE
 Q
 ;
 ;
LRSBCOM ;Display/store comments from the instrument
 N LRSBCOM,LRI
 S LRI=0
 F  S LRI=$O(^LAH(LRLL,1,LRSQ,1,LRI)) Q:LRI=""  D
 . S LRSBCOM=^LAH(LRLL,1,LRSQ,1,LRI)
 . I $P(LRSBCOM,"^",2) Q  ; Already been processed
 . D LRSBCOM1
 . S $P(^LAH(LRLL,1,LRSQ,1,LRI),U,2)=1 ; Mark as processed
 I $G(LRQUIET) Q
 W !
 S LRLCT=$G(LRLCT)+1 D:LRLCT>22 WT
 Q
 ;
 ;
LRSBCOM1 ; Store instrument comments in file #63
 ; Check for duplicate comments in ^LAH and ^LR globals
 N LRDUP,LRERR,LRI,LRNOECHO,LRNOEXPD,LRX,LRY
 ;
 ; Don't echo comments/don't expand comment using lab description file.
 ; Used by LRNUM - called from input transform of #.01 field.
 S LRNOECHO=0,LRNOEXPD=1
 ;
 ; Check for duplicates - comment stripped if spaces, force to upper case unless
 ; flag set to store duplicates (Field #2.2 of PROFILE multiple in file #68.2)
 S LRDUP=0
 I '$P($G(^LRO(68.2,LRLL,10,+$G(LRPROF),0)),U,4) D
 . S LRI=0,LRY=$TR(LRSBCOM," ",""),LRY=$$UP^XLFSTR(LRY)
 . F  S LRI=$O(^LR(LRDFN,"CH",LRIDT,1,LRI)) Q:'LRI  D  Q:LRDUP
 . . S LRX=$P($G(^LR(LRDFN,"CH",LRIDT,1,LRI,0)),U)
 . . S LRX=$TR(LRX," ",""),LRX=$$UP^XLFSTR(LRX)
 . . I LRX=LRY S LRDUP=1
 I LRDUP=1 Q  ; Duplicate comment
 D FILECOM(LRDFN,LRIDT,LRSBCOM)
 I $G(LRQUIET) Q
 W !,"Inst Comments: "_LRSBCOM
 S LRLCT=$G(LRLCT)+1 D:LRLCT>10 WT
 Q
 ;
 ;
FILECOM(LRDFN,LRIDT,LRCMT) ; File comment in field #99
 ; Call with LRDFN = ien of patient in file #63
 ;           LRIDT = ien of specimen date/time
 ;           LRCMT = comment to store
 ;
 N LRFDA,LRERR
 S LRFDA(2,63.041,"+2,"_LRIDT_","_LRDFN_",",.01)=LRCMT
 D UPDATE^DIE("","LRFDA(2)","","LRERR(2)")
 Q
