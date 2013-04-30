LRAPBK ;DALOI/STAFF - AP LOG BOOK ;08/29/11  13:58
 ;;5.2;LAB SERVICE;**51,72,201,274,350**;Sep 27, 1994;Build 230
 ;
 ; Reference to PXAPIOE supported by ICR #1541
 ;
 ; The code for functionality of LR*5.2*51 has changed with patch 72.
 ; The functionality that came with LR*5.2*51 remains the same.
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 N DIR,DIRUT,DTOUT,DUOUT,LRB
 D ^LRAP G:'$D(Y) END D XR^LRU
 W !!?20,LRO(68)," LOG BOOK"
 ;
 S DIR(0)="SO^0:No;1:Yes;2:Only Topography and Morphology Codes",DIR("A")="Print SNOMED codes",DIR("B")="No"
 D ^DIR
 I $D(DIRUT) D END Q
 S LRB=Y
 ;
 K DIR
 S DIR(0)="Y",DIR("A")="Print Single Accession",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q
 I Y=1 D ACC Q
 ;
 S LRH(2)=$E(DT,1,3),LRH(0)=$$FMTE^XLFDT(LRH(2)_"0000","D")
 ;
 K DIR
 S DIR(0)="DO^::AEP^",DIR("A")="Select Log Book Year",DIR("B")=LRH(0)
 F  D  Q:$D(DIRUT)!($G(LRH(0)))
 . D ^DIR
 . I $D(DIRUT) Q
 . S LRH(2)=$E(Y,1,3),LRH(0)=$$FMTE^XLFDT(LRH(2)_"0000","D")
 . I '$D(^LR(LRXREF,LRH(2),LRABV)) W $C(7),"   No entries for ",LRH(0) K LRH(0) Q
 I $D(DIRUT) D END Q
 ;
 ;
N1 R !,"Start with Acc #: ",X:DTIME G:X=""!(X[U) END I X'?1N.N W $C(7),!!,"NUMBERS ONLY !!" G N1
 S LRN(1)=X
 ;
 ;
N2 R !,"Go    to   Acc #: LAST // ",X:DTIME G:X='$T!(X[U) END S:X="" X=999999 I X'?1N.N W $C(7),!!,"NUMBERS ONLY !!",!! G N2
 ;
 S LRN(2)=X,ZTRTN="QUE^LRAPBK",ZTDESC="Anatomic Path Log Book",ZTSAVE("LR*")="" D BEG^LRUTL G:POP!($D(ZTSK)) END
 ;
 ;
QUE ; Print the log book
 N LRPSNM
 ; Flag to indicate which SNOMED system to print
 S LRPSNM=$$GET^XPAR("DIV^PKG","LR AP SNOMED SYSTEM PRINT",1,"Q")
 I LRPSNM<1 S LRPSNM=2
 ;
 U IO D L^LRU,S^LRU S P(9)="",LRW=LRH(2)_"0000" D H S LR("F")=1
 S LRAN=LRN(1)-1
 F  S LRAN=$O(^LR(LRXREF,LRH(2),LRABV,LRAN)) Q:'LRAN!(LRAN>LRN(2))!(LR("Q"))  D SH
 W:IOST'?1"C".E @IOF
 D END^LRUTL,END
 Q
 ;
 ;
ACC ; Print log book entry for a single accession
 ;  Called from above.
 N DFN,LR,LRAA,LRABV,LRACC,LRAD,LRAN,LRAX,LRBSAV,LRCAPA,LRDFN,LRDPAF,LRDPF,LREND,LRH,LRIDIV,LRIDT,LRO,LRSCR,LRSF,LRT,LRU,LRVBY,LRWHO,X,Y
 ;
 S LRSCR=LRSS,LRBSAV=LRB
 F  D  Q:LREND!LRSTOP
 . S LRACC="",(LREND,LRSTOP,LRVBY)=0,LRB=LRBSAV
 . D ENA^LRWU4(LRSCR)
 . I LRAN<1 S LREND=1 Q
 . I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W !,"Doesn't exist." Q
 . K LRDFN,LRDPF,LRIDT,LRSS
 . S LRSS=$P(^LRO(68,LRAA,0),"^",2),LRDFN=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),"^"),LRIDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5)
 . I LRSS=""!(LRIDT<1)!(LRDFN<1) W !,"Incomplete accession - unable to identify results." Q
 . I LRSS'?1(1"SP",1"CY",1"EM",1"AU") W !,"This option only supports SP, CY, EM and AU subscripted accessions." Q
 . D ACCB
 ;
 D END^LRUTL,END
 Q
 ;
 ;
ACCB ; Build variables for printing.
 ;
 N LREND,LRSINGLE,LRSTOP,LRX
 S LRX=^LRO(68,LRAA,0)
 S (LRO(68),LRAA(1))=$P(LRX,U),LRAA(2)=LRSS,LRABV=$P(LRX,U,11)
 S LRACC=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^")
 ;
 S X=^DIC(4,DUZ(2),0),LRAA(4)=$P(X,"^"),LRAA(5)=$E($P($G(^(1)),"^",3),1,30),X=+$P(X,"^",2),LRAA(6)=$P($G(^DIC(5,X,0)),"^",2)
 ;
 S LRH(2)=$E(LRAD,1,3),LRH(0)=LRH(2)+1700
 S (LRN(1),LRN(2))=LRAN
 D XR^LRU
 ;
 S (LREND,LRSTOP)=0,LRSINGLE=1
 S %ZIS="Q",ZTSAVE("DFN")="",ZTSAVE("LR*")="",ZTRTN="QUE^LRAPBK"
 D IO^LRWU
 Q
 ;
 ;
SH ;
 N LRX
 S P(13)="",LRDFN=$O(^LR(LRXREF,LRH(2),LRABV,LRAN,0)) Q:'LRDFN!(LR("Q"))  I "SPCYEM"[LRSS S LRI=$O(^(LRDFN,0)) Q:'LRI
 D:$Y>(IOSL-6) H Q:LR("Q")
 K LRDPF,LRLLOC
 D PT^LRX
 I $G(LREND) K LREND Q
 ;
 S LRP=PNM,P(0)=$S(LRDPF=2:"PATIENT",1:"OTHER")
 ;
 I "SPCYEM"[LRSS Q:'$D(^LR(LRDFN,LRSS,LRI,0))  D
 . S (LRX(0),X)=^LR(LRDFN,LRSS,LRI,0),LRX("ORU")=$G(^LR(LRDFN,LRSS,LRI,"ORU"))
 . S LRLLOC=$P(X,U,8),Y=$P(X,U,7) D S
 . S P(2)=Y,Y=$P(X,U,2) D S
 . S P(1)=$E(Y,1,12),Y=$P(X,U,13) D S
 . S P(13)=Y,LRSPDT=$$FMTE^XLFDT(($P(X,U,1)),"1M"),X=$P(X,U,10)
 ;
 I LRSS="AU" Q:'$D(^LR(LRDFN,"AU"))  D
 . S (LRX(0),X)=^LR(LRDFN,"AU"),LRX("ORU")=$G(^LR(LRDFN,"AU","ORU"))
 . S LRLLOC=$P(X,U,5),Y=$P(X,U,12) D S
 . S P(2)=Y,Y=$P(X,U,7) D S
 . S P(9)=$E(Y,1,15),Y=$P(X,U,2) D S
 . S LR("ASST")=Y,Y=$P(X,U,10) D S
 . S P(1)=$E(Y,1,12),X=+X
 ;
 S T=$$FMTE^XLFDT(X,"1P") S T=$P(T,",",1) S T=$TR(T," ","/")
 W !,$J(T,6),?7,$J(LRAN,5),?14 W:P(0)'="PATIENT" "#"
 W $E(LRP,1,18),?34,SSN(1),?40,$E(LRLLOC,1,8),?49,$E(P(2),1,16),?67,P(1),!?5,"Patient ID: ",SSN
 S LRLLOC("TY")=$P($G(^LRO(68,LRAA,1,LRH(2)_"0000",1,LRAN,0)),U,11)
 S LRLLOC("TY")=$S(LRLLOC("TY")="":"InPatient","WI"[LRLLOC("TY"):"InPatient",1:"OutPatient")
 W !?5,LRLLOC("TY")
 ;
 W ?29,"Accession [UID]: "_$P(LRX(0),"^",6)_" ["_$P(LRX("ORU"),"^")_"]"
 ;
 I $G(^LRO(68,LRAA,1,LRH(2)_"0000",1,LRAN,"PCE")) D
 . N IEN,LRENC,LRSTR,LRX,LRY,X,Y
 . S LRSTR=^LRO(68,LRAA,1,LRH(2)_"0000",1,LRAN,"PCE")
 . F IEN=1:1 S LRX=$P(LRSTR,";",IEN) Q:'LRX  D
 . . K LRY
 . . D GETCPT^PXAPIOE(LRX,"LRY","ERR")
 . . S LRY=0
 . . F  S LRY=$O(LRY(LRY)) Q:'LRY  S LRENC(LRX_"."_LRY)=LRY(LRY)
 . I '$O(LRENC(0)) Q
 . W !,"CPT Code: "
 . S IEN=0
 . F  S IEN=$O(LRENC(IEN)) Q:'IEN  W $P(LRENC(IEN),U)_"X"_$P(LRENC(IEN),U,16)_" " W:$X>70 !
 ;
 I "SPCYEM"[LRSS D
 . W !,"Date specimen taken: ",LRSPDT
 . S Y=$P($G(^LRO(68,LRAA,1,LRW,1,LRAN,0)),"^",10)
 . I Y,$D(^VA(200,Y,0)) W ?39," Entered by: ",$P(^(0),"^")
 ;
 I P(13)'="" W !?39,"Released by: ",P(13)
 S Y=+$G(^LRO(68,LRAA,1,LRH(2)_"0000",1,LRAN,.4)) I Y,Y'=DUZ(2) W !,$P($G(^DIC(4,Y,0)),U)
 ;
 I LRSS="AU" D
 . S DA=LRDFN D D^LRAUAW
 . S Y=LR(63,12) D D^LRU
 . W !?14,"Date died: ",Y,?49,"Path resident:",?64,P(9)
 . D AS
 ;
 ; Print specimens and any surgery case source references
 I LRSS?1(1"SP",1"CY",1"EM") D
 . N Z
 . S Z=0
 . F  S Z=$O(^LR(LRDFN,LRSS,LRI,.1,Z)) Q:'Z  D  Q:LR("Q")
 . . I $Y>(IOSL-6) D H1 Q:LR("Q")
 . . S Z(1)=$P(^LR(LRDFN,LRSS,LRI,.1,Z,0),"^")
 . . W !,?$S($L(Z(1))<61:14,1:2),Z(1)
 . I LR("Q") Q
 . D SRCASE
 ;
 Q:LR("Q")
 ;
 ; Print SNOMED codes
 I LRB,LRSS?1(1"SP",1"CY",1"EM"),$D(^LR(LRDFN,LRSS,LRI,2,0)) D  Q:LR("Q")
 . I $Y>(IOSL-6) D H1 Q:LR("Q")
 . W !?14,"SNOMED codes:"
 . D ^LRAPBK1
 ;
 I LRB,LRSS="AU",$O(^LR(LRDFN,"AY",0)) D  Q:LR("Q")
 . I $Y>(IOSL-6) D H1 Q:LR("Q")
 . W !?14,"SNOMED codes:"
 . D AU^LRAPBK1
 ;
 I LRSS'="AU" D D Q:LR("Q")
 ;
 Q:LR("Q")
 W !,LR("%")
 Q
 ;
 ;
D ;
 F Z(1)=99,97 Q:LR("Q")  D
 . S Z=0
 . F  S Z=$O(^LR(LRDFN,LRSS,LRI,Z(1),Z)) Q:'Z  D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?4,^LR(LRDFN,LRSS,LRI,Z(1),Z,0)
 Q
 ;
 ;
H ;
 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU
 I $G(LRSINGLE) W !,"LOG BOOK entry for accession ",LRACC,!
 E  W !,LRO(68)," (",LRABV,") LOG BOOK for ",LRH(0),!
 W "# =Demographic data in file other than PATIENT file"
 W !,"Date",?8,"Num",?14,"Patient",?35,"ID",?40,"LOC",?49,"PHYSICIAN",?67,"PATHOLOGIST",!,LR("%")
 Q
 ;
 ;
H1 ;
 D H Q:LR("Q")
 W !,$J(T,5),?7,$J(LRAN,5),?14
 W:P(0)'="PATIENT" "#"
 W $E(LRP,1,18),?34,SSN(1),?40,$E(LRLLOC,1,8),?49,$E(P(2),1,16),?67,P(1)
 Q
 ;
 ;
S ;
 S Y=$P($G(^VA(200,+Y,0)),U)
 Q
 ;
 ;
AS I $D(^LRO(68,LRAA,1,LRW,1,LRAN,0)) S Y=$P(^(0),"^",10) D S W ! W:Y]"" ?14,"Entered by: ",Y W:LR("ASST")]"" ?49,"Autopsy Asst: ",LR("ASST")
 Q
 ;
 ;
END ;
 K LRSPDT D V^LRU
 Q
 ;
 ;
SRCASE ; Print related surgery case info
 ;
 N LRDATA,LRFIELDNAME,LRFIELDNUM,LRIENS,LRJ,LRK,LRREF,LRSRTN,LRSUBFILE,LRTAB,LRX,LRY
 ;
 ;ZEXCEPT: IOM,IOSL,LRDFN,LRI,LRSS
 ;
 ; Print related surgical case #
 S LRIENS=LRDFN_","_LRSS_","_LRI_",0"
 I $D(^LR(LRDFN,"EPR","AD",LRIENS,1)) D
 . S LRJ=$O(^LR(LRDFN,"EPR","AD",LRIENS,1,0)),LRREF=LRJ_","_LRDFN_","
 . D GETDATA^LRUEPR(.LRDATA,LRREF)
 . S LRSRTN=LRDATA(63.00013,LRREF,1,"I")
 . I $P(LRSRTN,";",3)="" W !,"Related Surgery Case #"_$P(LRSRTN,";")
 . E  W !,$P(LRSRTN,";",3)
 ;
 ; Print soruce of surgical case info copied to Lab package.
 F LRJ=.2,.3,.4,.5 D  Q:LR("Q")
 . S LRIENS=LRDFN_","_LRSS_","_LRI_","_LRJ_",0"
 . I '$D(^LR(LRDFN,"EPR","AD",LRIENS,1)) Q
 . I $Y>(IOSL-6) D H1 Q:LR("Q")
 . S LRK=$O(^LR(LRDFN,"EPR","AD",LRIENS,1,0)),LRREF=LRK_","_LRDFN_","
 . K LRDATA
 . D GETDATA^LRUEPR(.LRDATA,LRREF)
 . S LRSUBFILE=$S(LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,1:"")
 . S LRFIELDNUM=((LRJ*10)+11)/1000
 . S LRFIELDNAME=$$GET1^DID(LRSUBFILE,LRFIELDNUM,"","LABEL")
 . S LRX=$P(LRDATA(63.00013,LRREF,1,"I"),";",3)
 . W !,LRFIELDNAME_": " S LRTAB=$X
 . I IOM'<($L(LRX)+LRTAB) W LRX Q
 . F LRK=1:1:$L(LRX," ") D
 . . S LRY=$P(LRX," ",LRK)
 . . I $X>LRTAB,($X+$L(LRY)+1)>IOM W !,?LRTAB,LRY Q
 . . W:$X>LRTAB " " W LRY
 ;
 Q
