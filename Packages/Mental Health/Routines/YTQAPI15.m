YTQAPI15 ;ASF/ALB MHA XML ; 9/25/09 11:14am
 ;;5.01;MENTAL HEALTH;**85,97**;Dec 30, 1994;Build 42
 Q
MAIN ;
 N N,G,YSCN,ICN,Y,YSA,YSAD,YSB,YSC,YSCN,YSCODE,YSD,YSDFN,YSDG,YSE,YSEA,YSER,YSF,YSFIELD,YSFILE,YSIENS,YSJ,YSLOC,YSOD,YSQNUMB,YSQTEXT,YSR,DFN,DIRUT,L1,L2,CNT,IDX,LEN
 D SELAD
DEV S %ZIS="QM" D ^%ZIS Q:IO=""
 I '$D(IO("Q")) W !,"Please Queue this job",! G DEV
 D  D ^%ZTLOAD D HOME^%ZIS K IO("Q") Q  ;-->out
 .S ZTRTN="ENQ^YTQAPI15",ZTDESC="MHA3 XML Export",ZTSAVE("YS*")=""
 .S ZTIO=ION_";"_IOST
 .I $D(IO("DOC"))#2,IO("DOC")]"" S ZTIO=ZTIO_";"_IO("DOC") Q
 .I IOM S ZTIO=ZTIO_";"_IOM
 .I IOSL S ZTIO=ZTIO_";"_IOSL
 ;
ENQ ;taskman entry
 K ^TMP("YSXML",$J),^TMP("YSAD",$J)
 S N=0
 D SI:YSF="I",SP:YSF="P",SO:YSF="O",SL:YSF="L",SD:YSF="D"
 I '$D(^TMP("YSAD",$J)) S ^TMP("YSXML",$J,1)="[ERROR]^no data" Q  ;-->out
 S N=N+1,^TMP("YSXML",$J,N)="<?xml version='1.0' encoding='UTF-8'?>"
 S N=N+1,^TMP("YSXML",$J,N)="<Export>"
 D ADMIN
 S N=N+1,^TMP("YSXML",$J,N)="</Export>"
 U IO S N=0 F  S N=$O(^TMP("YSXML",$J,N)) Q:N'>0  W ^(N),!
 D ^%ZISC
 Q  ;-->out
SELAD ;administation filter
 W @IOF,!!,"MHA XML Export"
 K DIR S DIR(0)="S^D:Date Only;I:Instrument;L:Location;P:Patient;O:Ordered By"
 S DIR("A")="Filter By" D ^DIR
 Q:$D(DIRUT)
 S YSF=Y
 K DIR S DIR(0)="DA^2961001:NOW:TX",DIR("A")="Begin date/time: ",DIR("B")="T-1M" D ^DIR
 Q:$D(DIRUT)
 S YSB=Y
 K DIR S DIR(0)="DA^2961001:NOW:TX",DIR("A")="End date/time: ",DIR("B")="NOW" D ^DIR
 Q:$D(DIRUT)
 S YSE=Y
 K DIR S DIR(0)="Y",DIR("A")="Export Answers",DIR("B")="No" D ^DIR
 Q:$D(DIRUT)
 S YSEA=Y
 K DIR S DIR(0)="Y",DIR("A")="Export Results",DIR("B")="No" D ^DIR
 Q:$D(DIRUT)
 S YSER=Y
 K DIC
 I YSF="I" S DIC(0)="AEQ",DIC="^YTT(601.71," D ^DIC Q:Y'>0  S YSCODE=$P(Y,U,2)
 I YSF="P" D ^YSLRP Q:DFN'>0  ;-->out
 I YSF="O" S DIC("A")="Ordered By: ",DIC(0)="AEQ",DIC="^VA(200," D ^DIC Q:Y'>0  S YSOD=+Y
 I YSF="L" S DIC(0)="AEQ",DIC="^DIC(42," D ^DIC Q:Y'>0  S YSLOC=+Y
 Q
SI ;selct by instrument
 S YSCN=$O(^YTT(601.71,"B",YSCODE,-1))
 S YSD=YSB-.00001 F  S YSD=$O(^YTT(601.84,"AC",YSCN,YSD)) Q:(YSD'>0)!(YSD>YSE)  D
 . S YSAD=0 F  S YSAD=$O(^YTT(601.84,"AC",YSCN,YSD,YSAD)) Q:YSAD'>0  S ^TMP("YSAD",$J,YSAD)=""
 Q
SP ;select by patient
 S YSAD=0 F  S YSAD=$O(^YTT(601.84,"C",YSDFN,YSAD)) Q:YSAD'>0  D
 . S YSDG=$P(^YTT(601.84,YSAD,0),U,4)
 . S:(YSDG'<YSB)&(YSDG'>(YSE+.9)) ^TMP("YSAD",$J,YSAD)=""
 Q
SD ;select by Date Only
 S YSAD=0 F  S YSAD=$O(^YTT(601.84,"B",YSAD)) Q:YSAD'>0  D
 . S YSDG=$P(^YTT(601.84,YSAD,0),U,4)
 . S:(YSDG'<YSB)&(YSDG'>(YSE+.9)) ^TMP("YSAD",$J,YSAD)=""
 Q
SO ;select by Ordered by
 S YSAD=0 F  S YSAD=$O(^YTT(601.84,"AO",YSOD,YSAD)) Q:YSAD'>0  D
 . S YSDG=$P(^YTT(601.84,YSAD,0),U,4)
 . S:(YSDG'<YSB)&(YSDG'>(YSE+.9)) ^TMP("YSAD",$J,YSAD)=""
 Q
SL ;select by location
 S YSAD=0 F  S YSAD=$O(^YTT(601.84,"AL",YSLOC,YSAD)) Q:YSAD'>0  D
 . S YSDG=$P(^YTT(601.84,YSAD,0),U,4)
 . S:(YSDG'<YSB)&(YSDG'>(YSE+.9)) ^TMP("YSAD",$J,YSAD)=""
 Q
ADMIN ;extract the data into an XML global
 S YSAD=0 F  S YSAD=$O(^TMP("YSAD",$J,YSAD)) Q:YSAD'>0  D
 . S N=N+1,^TMP("YSXML",$J,N)="<Admin>"
 . S N=N+1,^TMP("YSXML",$J,N)="<Admin_ID>"_YSAD_"</Admin_ID>"
 . D FORM("Patient",601.84,YSAD,1)
 . S DFN=$P(^YTT(601.84,YSAD,0),U,2),ICN=$$GETICN^MPIF001(DFN),N=N+1,^TMP("YSXML",$J,N)="<ICN>"_ICN_"</ICN>"
 . D FORM("Instrument",601.84,YSAD,2)
 . D FORM("Given",601.84,YSAD,3)
 . D FORM("Saved",601.84,YSAD,4)
 . D FORM("Ordered",601.84,YSAD,5)
 . D FORM("Complete",601.84,YSAD,8)
 . D FORM("Location",601.84,YSAD,13)
 . D QUEST:YSEA
 . D RESULT:YSER
 . S N=N+1,^TMP("YSXML",$J,N)="</Admin>"
 Q
FORM(YSTAG,YSFILE,YSIENS,YSFIELD) ;xml entry
 N G,Y1,Y2
 S N=N+1
 S Y1=$$GET1^DIQ(YSFILE,YSIENS_",",YSFIELD)
 S Y2=$$CONVSTR(Y1)
 S G="<"_YSTAG_">"_Y2_"</"_YSTAG_">"
 S ^TMP("YSXML",$J,N)=G
 Q
QUEST ;answers out
 S YSA=0,YSJ=0  F  S YSA=$O(^YTT(601.85,"AD",YSAD,YSA)) Q:YSA'>0  D
 . S N=N+1,^TMP("YSXML",$J,N)="<Quest>"
 . S N=N+1,^TMP("YSXML",$J,N)="<Admin_ID>"_YSAD_"</Admin_ID>"
 . S YSQNUMB=$P(^YTT(601.85,YSA,0),U,3)
 . S N=N+1,^TMP("YSXML",$J,N)="<Qnumb>"_YSQNUMB_"</Qnumb>"
 . S YSQTEXT=$G(^YTT(601.72,YSQNUMB,1,1,0))
 . S N=N+1,^TMP("YSXML",$J,N)="<Qtext>"_YSQTEXT_"</Qtext>"
 . S N=N+1,YSJ=YSJ+1,^TMP("YSXML",$J,N)="<Seq>"_YSJ_"</Seq>"
 . D FORM("Choice",601.85,YSA,4)
 . S N=N+1
 . S YSC=$P(^YTT(601.85,YSA,0),U,4)
 . S YSCN=$S(YSC?1N.N:^YTT(601.75,YSC,1),1:"???")
 . S:$D(^YTT(601.85,YSA,1,1,0)) YSCN=^YTT(601.85,YSA,1,1,0)
 . S ^TMP("YSXML",$J,N)="<Ans>"_YSCN_"</Ans>"
 . S N=N+1,^TMP("YSXML",$J,N)="</Quest>"
 Q
RESULT ;results out
 S YSR=0
 F  S YSR=$O(^YTT(601.92,"AC",YSAD,YSR)) Q:YSR'>0  D
 . S N=N+1,^TMP("YSXML",$J,N)="<Score>"
 . S N=N+1,^TMP("YSXML",$J,N)="<Admin_ID>"_YSAD_"</Admin_ID>"
 . D FORM("Scale",601.92,YSR,2)
 . D FORM("Raw",601.92,YSR,3)
 . D FORM("Trans1",601.92,YSR,4)
 . S N=N+1,^TMP("YSXML",$J,N)="</Score>"
 Q
HEAD ;
 ;
CONVSTR(YSIN) ;convert string to valid xml
 S L1(1)="&",L2(1)="&amp;" ; Keep "&" first
 S L1(2)=">",L2(2)="&gt;"
 S L1(3)="<",L2(3)="&lt;"
 S L1(4)="'",L2(4)="&apos;"
 S L1(5)="""",L2(5)="&quot;"
 S YSOUT=YSIN
 F CNT=1:1:5 D
 .S LEN=$L(L1(CNT))+1
 .S IDX=0
 .F  S IDX=$F(YSOUT,L1(CNT),IDX) Q:IDX=0  D
 .. S YSOUT=$E(YSOUT,1,IDX-LEN)_L2(CNT)_$E(YSOUT,IDX,250)
 .. S IDX=IDX-(LEN-2)
 Q YSOUT
