SROADX ;BIR/RJS - ASSOCIATED DIAGNOSIS FOR CODER AND VERIFY SCREENS ;11/22/05
 ;;3.0;Surgery;**119,150**;24 Jun 93
CASDX ;Associate/Delete "Primary" CPT to Diagnosis from the CPT Coding menu. 
 N SRDX0,SRDX1,SRDX2,SROANS,SRODIR,SRDIRX,OTHCNT,SRASSDS
 S S("OP")=^SRF(SRTN,"OP"),CPT=$P(S("OP"),U,2),SROPER=$P(S("OP"),U)
 Q:'CPT
 K DIR
 D HDR^SROVER2
 D CPTDISP^SROADX1,ASDX^SROADX1,ADXPRMT
 Q:($G(Y(0))="")!($G(Y(0))="QUIT")
 K DIR
 S Y=$P(SROLST,",",Y)
 S SROANS=Y
 S SRODIR("A",1)="   Select the number(s) of the Diagnosis Code appropriate for this procedure"
 S SRODIR("A")="     ("_SRTXT_")"
 S:$G(SROANS)="D" SRODIR("A",1)="   Select the number(s) of the Diagnosis Code(s) to delete from this procedure"
 D HDR^SROVER2
 D CPTDISP^SROADX1,ASDX^SROADX1
 S Y=SROANS
 I Y="D" D
 .W !,?8,SRDXCNT,". ALL"
 .S DIR(0)=SRDX1,DIR("A")=SRODIR("A"),DIR("A",1)="",DIR("A",2)=SRODIR("A",1)
 .F I=1:1 D ^DIR Q:$$VALASC()
 .Q:(Y["^")!(Y="")!($P(Y,",",1)=0)
 .I +Y(0)'=SRDXCNT D PDEL1^SROADX1
 .I +Y(0)=SRDXCNT D PDELALL^SROADX1
 I Y="A" D
 .K DIR
 .D SRODIR^SROADX1
 .W ! F I=1:1:80 W "-"
 .S DIR(0)=SRDX2
 .S SRASSDS=$$PASSDS^SROADX1
 .S DIR("B")=SRASSDS
 .F I=1:1 D ^DIR Q:(($$VALASC())&('$$DXDUP(Y)))
 .Q:(Y["^")!(Y="")!($P(Y,",",1)=0)
 .I SRDIRX(+Y(0))'="ALL" D PADD1^SROADX1 Q
 .I SRDIRX(+Y(0))="ALL" D PADDALL^SROADX1 Q
 Q:Y="Q"!(Y["")
 G CASDX
 Q
COTHADX D COTHBLD^SROADX1        ;Associate/Delete "Other" CPTs to Diagnosis from CPT/CODE menu.
 N SRDX0,SRDX1,SRDX2,SRDIR,OTHCNT,SRASSDS
 D HDR^SROVER2
 S OTHCNT=SRDA
 K DIR
 D OTHCPTD^SROADX1
 D OTHADX^SROADX1,ADXPRMT
 Q:($G(Y(0))="")!($G(Y(0))="QUIT")
 S SRODIR("A",1)="   Select the number(s) of the Diagnosis Code appropriate for this procedure"
 S SRODIR("A")="     ("_$G(SRSHT)_")"
 S:$G(Y(0))="DELETE" SRODIR("A",1)="   Select the number(s) of the Diagnosis Code(s) to delete from this procedure"
 K DIR
 S Y=$P(SROLST,",",Y)
 S SROANS=Y
 W @IOF
 D OTHCPTD^SROADX1
 D OTHADX^SROADX1
 S Y=SROANS
 I Y="D" D
 .W !,?8,SRDXCNT,". ALL"
 .S DIR(0)=SRDX1,DIR("A")=SRODIR("A"),DIR("A",1)="",DIR("A",2)=SRODIR("A",1)
 .F I=1:1 D ^DIR Q:$$VALASC()
 .Q:(Y["^")!(Y="")!($P(Y,",",1)=0)
 .I +Y(0)=SRDXCNT D
 ..W !,"ARE YOU SRE YOU WANT TO DELETE ALL ? (Y/N) "
 ..S %=2 D YN^DICN
 ..I %=1 Q:$E($G(IOST))'="C"!($G(DIK)'="")  D KOADX^SROADX2(SRTN,OTH)
 ..W @IOF
 ..S OTHCNT=SRDA
 .I +Y(0)'=SRDXCNT D
 ..S DIR(0)=SRDX1,DIR("A")=SRODIR("A"),DIR("A",1)="",DIR("A",2)=SRODIR("A",1)
 ..D ODEL1^SROADX1
 ..W @IOF
 .D OTHCPTD^SROADX1
 I Y="A" D  G COTHADX
 .K DIR
 .D SRODIR^SROADX1
 .W ! F I=1:1:80 W "-"
 .S DIR(0)=SRDX2
 .S SRASSDS=$$OASSDS^SROADX1
 .S DIR("B")=SRASSDS
 .F I=1:1 D ^DIR Q:(($$VALASC())&('$$DXDUP(Y)))
 .Q:(Y["^")!(Y="")!($P(Y,",",1)=0)
 .I SRDIRX(+Y(0))="ALL",SRDX0'="SO^1:ASSOCIATE;2:DELETE;3:QUIT" D  Q
 ..D OADDALL^SROADX1
 .I SRDIRX(+Y(0))="ALL",SRDX0="SO^1:ASSOCIATE;2:DELETE;3:QUIT" D  Q
 ..D OADD1^SROADX1
 .I SRDIRX(+Y(0))'="ALL" D
 ..D OADD1^SROADX1
 .W @IOF
 .D OTHCPTD^SROADX1
 .D OTHADX^SROADX1
 Q:Y="Q"!(Y["")
 G COTHADX
 Q
VASDX         ;Associate/Delete PRINCIPAL CPTs to Diagnosis from Physician's Verify menu.
 N SRDX0,SRDX1,SRDX2,SROANS,SRODIR,SRDIRX,SRASSDS
 K DIR
 W @IOF
 S DIR("?")="^D VHELP^SROADX"
 S DIR("??")="^D VHELP1^SROADX"
 D CPTDISP^SROADX1,ASDX^SROADX1,ADXPRMT
 Q:($G(Y(0))="")!($G(Y(0))="QUIT")
 S SRODIR("A",1)="   Select the number(s) of the Diagnosis Code appropriate for this procedure"
 S SRODIR("A")="     ("_SROCPT2_")"
 S:$G(Y(0))="DELETE" SRODIR("A",1)="   Select the number(s) of the Diagnosis Code(s) to delete from this procedure"
 K DIR
 S Y=$P(SROLST,",",Y)
 S SROANS=Y
 W @IOF
 D CPTDISP^SROADX1,ASDX^SROADX1
 S Y=SROANS
 I Y="D" D
 .W !,?8,SRDXCNT,". ALL"
 .S DIR(0)=SRDX1,DIR("A")=SRODIR("A"),DIR("A",1)="",DIR("A",2)=SRODIR("A",1)
 .S DIR("?")="^D DHELP^SROADX"
 .S DIR("??")="^D PHELP^SROADX"
 .F I=1:1 D ^DIR Q:$$VALASC()
 .Q:(Y["^")!(Y="")!($P(Y,",",1)=0)
 .I +Y(0)=SRDXCNT D PDELALL^SROADX1 Q
 .I +Y(0)'=SRDXCNT D PDEL1^SROADX1 Q
 I Y="A" D
 .K DIR
 .D SRODIR^SROADX1
 .W ! F I=1:1:80 W "-"
 .S DIR("?")="^D AHELP^SROADX"
 .S DIR("??")="^D PHELP^SROADX"
 .S SRASSDS=$$PASSDS^SROADX1
 .S DIR("B")=SRASSDS
 .S DIR(0)=SRDX2
 .F I=1:1 D ^DIR Q:(($$VALASC())&('$$DXDUP(Y)))
 .Q:(Y["^")!(Y="")!($P(Y,",",1)=0)
 .I SRDIRX(+Y(0))'="ALL" D PADD1^SROADX1 Q
 .I SRDIRX(+Y(0))="ALL" D PADDALL^SROADX1 Q
 G VASDX
 Q
NOTHADX S OTH=DA,OTHCNT=CNT
 S SRSEL(CNT)=OTH_U_$G(OTHER)_"^CPT Code: "_CPT_U_$G(CPT1)
VOTHADX N SRDX0,SRDX1,SRDX2,SRDIR,SRASSDS        ;Associate/Delete OTHER Diagnosis to CPTs from Physician's Verify menu.
 Q:'$D(^SRF(SRTN,13,OTH))
 W @IOF
 K DIR
 D OTHCPTD^SROADX1,OTHADX^SROADX1,ADXPRMT
 Q:($G(Y(0))="")!($G(Y(0))="QUIT")
 S SRODIR("A",1)="   Select the number(s) of the Diagnosis Code appropriate for this procedure"
 S SRODIR("A")="     ("_$G(SRSHT)_")"
 S:$G(Y(0))="DELETE" SRODIR("A",1)="   Select the number(s) of the Diagnosis Code(s) to delete from this procedure"
 K DIR
 S Y=$P(SROLST,",",Y)
 S SROANS=Y
 W @IOF
 D OTHCPTD^SROADX1
 D OTHADX^SROADX1
 S Y=SROANS
 I Y="D" D
 .W !,?8,SRDXCNT,". ALL"
 .S DIR("?")="^D DHELP^SROADX"
 .S DIR("??")="^D OHELP^SROADX"
 .S DIR(0)=SRDX1,DIR("A")=SRODIR("A"),DIR("A",1)="",DIR("A",2)=SRODIR("A",1)
 .F I=1:1 D ^DIR Q:$$VALASC()
 .Q:(Y["^")!(Y="")!($P(Y,",",1)=0)
 .I +Y(0)=SRDXCNT D
 ..W !,"ARE YOU SRE YOU WANT TO DELETE ALL ? (Y/N) "
 ..S %=2 D YN^DICN
 ..I %=1 Q:$E($G(IOST))'="C"!($G(DIK)'="")  D KOADX^SROADX2(SRTN,OTH)
 .I +Y(0)'=SRDXCNT D  Q
 ..S DIR(0)=SRDX1,DIR("A")=SRODIR("A"),DIR("A",1)=""
 ..W ! F I=1:1:80 W "-"
 ..S DIR("A",2)=SRODIR("A",1)
 ..D ODEL1^SROADX1
 .W @IOF
 .D OTHCPTD^SROADX1
 I Y="A" D
 .K DIR
 .D SRODIR^SROADX1
 .W ! F I=1:1:80 W "-"
 .S DIR("?")="^D AHELP^SROADX"
 .S DIR("??")="^D OHELP^SROADX"
 .S SRASSDS=$$OASSDS^SROADX1
 .S DIR("B")=SRASSDS
 .S DIR(0)=SRDX2
 .F I=1:1 D ^DIR Q:(($$VALASC())&('$$DXDUP(Y)))
 .Q:(Y["^")!(Y="")!($P(Y,",",1)=0)
 .I SRDIRX(+Y(0))="ALL" D OADDALL^SROADX1 Q
 .I SRDIRX(+Y(0))'="ALL" D OADD1^SROADX1 Q
 G VOTHADX
 Q
OHELP ;
 W !!,?5,"The Other Associated Diagnosis is used to associate a diagnosis"
 W !,?5,"or a group of diagnoses to the Other Procedures"
 Q
PHELP ;
 W !!,?5,"The Principal Associated Diagnosis is used to associate a diagnosis"
 W !,?5,"or a group of diagnoses to the Principal CPT Code"
 Q
DHELP ;
 W !!,?5,"Please enter a list or range, e.g.,2, or 2,3 or 1-3"
 W !,?5,"from the above list to be Deleted."
 Q
AHELP ;
 W !!,?5,"Please enter a list or range, e.g.,2, or 2,3 or 1-3"
 W !,?5,"from the above list to be Associated."
 Q
VHELP ;
 W !!,?5
 W:DIR("0")="SO^D:DELETE;Q:QUIT" "Select either D to Delete or Q to Quit"
 W:DIR("0")="SO^A:ASSOCIATE;D:DELETE;Q:QUIT" "Select A to Associate, D to Delete or Q to Quit"
 W:DIR("0")="SO^A:ASSOCIATE;Q:QUIT" "Select A to Associate or Q to Quit"
 Q
VHELP1 ;
 W !!,?5
 W:DIR("0")="SO^D:DELETE;Q:QUIT" "This will setup your choices for Deleting any Associated Diagnosis"
 W:DIR("0")="SO^A:ASSOCIATE;D:DELETE;Q:QUIT" "This will setup your choices for Associating or Deleting any Associated Diagnosis"
 W:DIR("0")="SO^A:ASSOCIATE;Q:QUIT" "This will setup your choices for Associating any Associated Diagnosis"
 Q
PINPUT ;
 Q:$D(EMILY)
 N SRC,SRDX
 S SRC(1)="The Associated Diagnosis can only be added via the",SRC(1,"F")="!!?5"
 S SRC(2)="Surgery Menu options.  Your entry has NOT been filed",SRC(2,"F")="!?5"
 D EN^DDIOL(.SRC),CONT^SROADX1
 K X
 Q
ADXPRMT ;
 I SRDX1'="LO^:0",SRDX2'="LO^:0" S SRDX0="SO^1:ASSOCIATE;2:DELETE;3:QUIT",SROLST="A,D,Q",DIR("L")="   1  ASSOCIATE      2  DELETE    3  QUIT"
 I SRDX1'="LO^:0",SRDX2="LO^:0" S SRDX0="SO^1:DELETE;2:QUIT",SROLST="D,Q",DIR("L")="         1  DELETE    2  QUIT"
 I SRDX1="LO^:1",SRDX2'="LO^:0" S SRDX0="SO^1:ASSOCIATE;2:QUIT",SROLST="A,Q",DIR("L")="          1  ASSOCIATE    2  QUIT"
 I SRDX1="LO^:0",SRDX2="LO^:0" S SRDX0="SO^1:QUIT",SROLST="A,Q",DIR("L")="          No Diagnosis to associate    1  QUIT"
 S DIR(0)=SRDX0,DIR("L",1)="     Select one of the following:",DIR("L",2)=""
 D ^DIR K DIR
 Q
DXDUP(SRDX) I (Y["^")!($G(DTOUT)) Q 0
 N SRAI,SRDXX,SRDUP,DIR S SRDUP=0
 I SRDX="" Q 0
 F SRAI=1:1:$L(SRDX,",") D
 .Q:$P(SRDX,",",SRAI)<1
 .I $D(SRDXX($P(SRDX,",",SRAI)))!((SRDIRX($P(SRDX,",",SRAI))="ALL")&($L(SRDX,",")>2)) S SRDUP=1,DIR(0)="FO^",DIR("A",1)="     **Duplicates entered",DIR("A")="     Press Return to continue" D ^DIR
 .S SRDXX($P(SRDX,",",SRAI))=""
 Q SRDUP
VALASC() I (Y["^")!('$G(Y(0)))!($G(DTOUT)) Q 1
 N VALA,DIR S VALA=1
 S:Y=""!(Y=U)!('+Y(0))!(Y[",0")!($P(Y,",",1)=0) VALA=0
 I 'VALA S DIR("A",1)="     **Invalid input",DIR(0)="FO^",DIR("A")="     Press Return to continue" D ^DIR
 Q VALA
