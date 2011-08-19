SCRPW22 ;RENO/KEITH - ACRP Ad Hoc Report (cont.) ; 03 Aug 98  9:36 PM
 ;;5.3;Scheduling;**144**;AUG 13, 1993
PLIST(C,SDLP,SDTEMP) ;Display parameter list
 ;Required input: C=column to format left margin
 ;Required input: SDLP=number of lines to print on a page
 ;Optional input: SDTEMP=array of template information to print
 N SDI,SDII,SDS1,SDS2,SDX,SDX1,SDX2,SDL S (SDOUT,SDL)=0
 D PHD(" R E P O R T   F O R M A T ") Q:SDOUT  D D1("F","") Q:SDOUT
 D PHD(" R E P O R T   P E R S P E C T I V E ") Q:SDOUT  D D2("Perspective","P",1) Q:SDOUT
 D PHD(" R E P O R T   L I M I T A T I O N S ") Q:SDOUT  D D1("L",2) Q:SDOUT
 S SDS1="L",SDS2=2 F  S SDS2=$O(SDPAR(SDS1,SDS2)) Q:'SDS2!SDOUT  D:SDL>SDLP WAIT Q:SDOUT  W ! S SDL=SDL+1 D D2("Addl. limitation",SDS1,SDS2)
 Q:SDOUT  D PHD(" R E P O R T   P R I N T   O R D E R ") Q:SDOUT  D D1("O","")
 I $D(SDPAR("PF")) D PHD(" A D D I T I O N A L   P R I N T   F I E L D S ") Q:SDOUT
 F SDS2=2,1 S SDS3=0 F  S SDS3=$O(SDPAR("PF",SDS2,SDS3)) Q:'SDS3  S SDX=SDPAR("PF",SDS2,SDS3) D:SDL>SDLP WAIT Q:SDOUT  W !?(C+36-$L($P(SDX,U,2))),$P(SDX,U,2),": ",$E($P(SDX,U,3),1,(42+C)) S SDL=SDL+1
 Q:SDOUT  D:SDL>SDLP WAIT Q:SDOUT  D:$D(SDTEMP)>1 PHD(" T E M P L A T E   I N F O R M A T I O N "),PTMP Q:SDOUT
 D:SDL>SDLP WAIT Q:SDOUT  W ! S SDL=SDL+1 D:SDL>SDLP WAIT Q:SDOUT  W ! S SDL=SDL+1 F SDI=1:1:IOM W "-"
 I $E(IOST)="C" D WAIT
 Q
 ;
PTMP N SDI S SDI=0 F  S SDI=$O(SDTEMP(SDI)) Q:'SDI!SDOUT  S SDX=$P(SDTEMP(SDI),U),SDX1=$P(SDTEMP(SDI),U,2) D D2P
 Q
 ;
D1(SDI,SDE) S SDII="" F  S SDII=$O(SDPAR(SDI,SDII)) Q:SDII=""!(SDE&(SDII>SDE))  S SDX=$P($T(@SDI+SDII),";;",2) D:SDL>SDLP WAIT Q:SDOUT  W !?(C+36-$L(SDX)),SDX,": ",$E($P(SDPAR(SDI,SDII),U,2),1,(42+C)) S SDL=SDL+1
 Q
 ;
D2(SDTX,SDS1,SDS2) Q:'$D(SDPAR(SDS1,SDS2))  S SDX=SDTX_" category",SDX1=$P(SDPAR(SDS1,SDS2),U,2) D D2P Q:SDOUT
 Q:'$D(SDPAR(SDS1,SDS2,1))  S SDX=SDTX_" sub-category",SDX1=$P(SDPAR(SDS1,SDS2,1),U,2) D D2P Q:SDOUT
 Q:'$D(SDPAR(SDS1,SDS2,2))  S SDX2=$P(SDPAR(SDS1,SDS2,2),U) D:SDL>SDLP WAIT Q:SDOUT  S SDX1=$O(SDPAR(SDS1,SDS2,4,"")) Q:SDX1=""
 S SDX=$S(SDS1="P":"Detail",$P(SDPAR(SDS1,SDS2,3),U)="I":"Include",1:"Exclude")_" "_$S("LN"[SDX2:"list",1:"range - from") D D2P Q:SDOUT
 I SDX2="R" S SDX="to",SDX1=$O(SDPAR(SDS1,SDS2,4,SDX1)) Q:SDX1=""  D D2P Q
 F  S SDX1=$O(SDPAR(SDS1,SDS2,4,SDX1)) Q:SDX1=""!SDOUT  D:SDL>SDLP WAIT Q:SDOUT  W !?(38+C),SDX1 S SDL=SDL+1
 Q
 ;
D2P D:SDL>SDLP WAIT Q:SDOUT  W !?(C+36-$L(SDX)),SDX,": ",$E(SDX1,1,(42+C)) S SDL=SDL+1 Q
 ;
F ;Format captions
 ;;Report output format
 ;;Compare data to previous year
 ;;Type of detail
 ;;List activity detail by
 ;;Limit Dx/Proc. list to most frequent
 ;;Produce output as
L ;Limitation captions
 ;;Starting date
 ;;Ending date
O ;Order caption
 ;;Output order
 ;;Report descriptive title
 ;
XY(X) ;Maintain $X, $Y
 ;Required input: X=screen handling variable to write
 S:'$D(SDXY) SDXY=^%ZOSF("XY") N DX,DY S DX=$X,DY=$Y W X X SDXY Q ""
 ;
PHD(SDH) ;Parameter header
 ;Required input: SDH=header value
 W ! S SDL=SDL+1 D:(SDL+1)>SDLP WAIT Q:SDOUT
 W ! S SDL=SDL+1
 F  W "-" Q:$X>(IOM-3-$L(SDH)\2)
 W " ",SDH," " F  W "-" Q:$X>(IOM-1)
 W ! S SDL=SDL+1 D:SDL>SDLP WAIT Q
 ;
WAIT I $E(IOST)="C" N DIR S DIR(0)="E" D ^DIR S:'Y SDOUT=1 W:'SDOUT $$XY(IOELALL),$$XY(IOCUU) S SDL=0 Q
 D HDR^SCRPW29("Report Parameters Selected") S SDL=0 Q
 ;
CAT(SDA) ;Enter edit perspective and limitation categories
 ;Required entry: SDA="A" for add or "E" for edit
 K SDPAR("X") M:SDA="E" SDPAR("X")=SDPAR(SDS1) I SDS1="L",SDA="E" S SDSEL=$P(SDPAR(SDS1,SDS2),U)_$P(SDPAR(SDS1,SDS2,1),U) G CAT1
 S (SDSEL,SDX)=$$DIR^SCRPW23(.DIR,1,"","","O") Q:SDOUT!SDNUL
 I SDA="E",SDX'=SDPAR(SDS1,SDS2) K SDPAR("X",SDS2)
 S SDPAR("X",SDS2)=SDX
 K SDEXE D PRMT("X",SDS2) S SDX=$$DIR^SCRPW23(.DIR,2,$G(SDEXE),$P(SDPAR("X",SDS2),U)) G:SDOUT!SDNUL CATQ
 I SDA="E",SDX'=$G(SDPAR("X",SDS2,1)) D
 .F SDI=1:1:6 K SDPAR("X",SDS2,SDI)
 .F SDI=4,5,6 K SDPAR(SDS1,SDS2,SDI)
 .Q
 S SDPAR("X",SDS2,1)=SDX,SDSEL=$P(SDSEL,U)_$P(SDX,U)
 I SDS1="P",$P(SDPAR("F",1),U)="S" M SDPAR(SDS1)=SDPAR("X") Q
CAT1 S SDACT=^TMP("SCRPW",$J,"ACT",SDSEL)
 I SDS1="P" S SDLR="L",SDX=$$RL() G:SDOUT CATQ S SDPAR("X",SDS2,2)=SDX D RL^SCRPW23 S (SDOUT,SDNUL)=0 M:$D(SDPAR("X",SDS2,4)) SDPAR(SDS1)=SDPAR("X") G:'$D(SDPAR("X",SDS2,4)) CATQ D CATD Q
 S SDLR=$P(SDACT,T,5),SDX=$$RL() G:SDOUT CATQ I SDA="E",SDX'=SDPAR("X",SDS2,2) F SDI=4,5 K SDPAR("X",SDS2,SDI)
 S SDPAR("X",SDS2,2)=SDX D RL^SCRPW23,CATD S (SDOUT,SDNUL)=0 G:'$D(SDPAR("X",SDS2,4)) CATQ
 K DIR D DIRB("X",SDS2,3) S DIR(0)="S^I:INCLUDE;E:EXCLUDE",DIR("A")="Include or exclude records in this category" D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G CATQ
 S SDPAR("X",SDS2,3)=Y_U_Y(0) M SDPAR(SDS1)=SDPAR("X") Q
 ;
CATD Q:'SDREV!($D(SDPAR(SDS1,SDS2,4)))!'$D(SDPAR(SDS1,SDS2))
 W !!,$C(7),"Required ",$S($P(SDPAR(SDS1,SDS2,2),U)="L":"list",1:"range")," data missing.",!,$P(SDPAR(SDS1,SDS2),U,2),": ",$P(SDPAR(SDS1,SDS2,1),U,2)," element deleted!" H 3
 K SDPAR(SDS1,SDS2) Q
 ;
CATQ W !!,"Required data missing!  "_$S(SDS1="P":"Perspective ",1:"Limitation item ")_$S(SDA="E":"changes ",1:"")_"not filed.",! H 2 S (SDOUT,SDNUL)=0 Q
 ;
RL() ;List or range?
 ;Output: selector type
 K DIR D DIRB("X",SDS2,2)
 S DIR("A")="Limit this factor by",DIR("?")="Specify if a list or a range of items should be used to limit this element.",DIR(0)="S^"_$S(SDLR["L":"L:LIST;",1:"")_$S(SDLR["R":"R:RANGE;",1:"")_"N:NULL (NO DATA VALUE)"
 Q $$DIR^SCRPW23(.DIR,0)
 ;
PRMT(SDS1,SDS2) ;Prompts for level DIR2
 ;Required input: SDS1,SDS2=subscript to find responses
 K DIR(0) D DIRB("X",SDS2,1) S DIR("A")="Select "_$P(SDPAR(SDS1,SDS2),U,2)_" category" Q
 ;
DIRB(SDS1,SDS2,SDS3) ;Get default value
 ;Required input: SDS1,SDS2,SDS3=subscript value
 S DIR("B")=$P($G(SDPAR(SDS1,SDS2,SDS3)),U,2) K:'$L(DIR("B")) DIR("B") Q
 ;
AED(SDS1) ;Add/edit/delete element categories
 ;Required input: SDS1=global subscript to work with
 N SDOUT S SDOUT=0 F  Q:SDOUT!SDNUL  D AED1
 Q
 ;
AED1 I '$O(SDPAR(SDS1,2)) D A Q
 W !!?28,$$XY(IORVON)," Limitation item action ",$$XY(IORVOFF) K DIR S DIR(0)="SO^A:ADD CATEGORY ITEMS;E:EDIT CATEGORY ITEMS;D:DELETE CATEGORY ITEMS",DIR("A")="Select edit action"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!($G(X)="") S SDOUT=1 Q
 D @Y Q
 ;
A ;Add items
 D L2A^SCRPW20 Q
 ;
E ;Edit items
 S SDX=$$ILIST("E") Q:'SDX!SDOUT  S SDS2=+SDX D CAT("E") Q
 ;
D ;Delete items
 S SDX=$$ILIST("D") Q:'SDX!SDOUT  D DEL1 Q
 ;
DEL1 N DIR S DIR(0)="Y",DIR("A")="Ok to delete "_$P(SDX,U,2)_" item",DIR("B")="YES" D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 Q:'Y  K SDPAR(SDS1,$P(SDX,U)) Q
 ;
ILIST(SDY) ;List/select items
 ;Required input: SDY="E" for edit, "D" for delete
 N SDI,SDX,SDOUT,SDS2 S (SDI,SDOUT)=0,SDS2=2,SDX=""
 W ! F  S SDS2=$O(SDPAR(SDS1,SDS2)) Q:'SDS2!SDOUT  S SDI=SDI+1 D ISET W !,SDI,". ",$P(SDI(SDI),U,2) D:'SDI#5 IL1
 D:'SDOUT&SDI#5 IL1 Q SDX
 ;
ISET S SDI(SDI)=SDS2_U_$P(SDPAR(SDS1,SDS2),U,2)_": "_$P(SDPAR(SDS1,SDS2,1),U,2)_" ("_$P(SDPAR(SDS1,SDS2,2),U,2)_")" Q
 ;
IL1 W ! N DIR S DIR(0)="NO^1:"_SDI_":0",DIR("A")="Select item to "_$S(SDY="E":"edit",1:"delete") D ^DIR W ! I $D(DTOUT)!$D(DUOUT)!$G(Y) S SDOUT=1
 S SDX=$G(SDI(+$G(Y))) Q
 ;
DESC ;Prompt for descriptive report title
 K DIR D DIRB1^SCRPW23("O",2)
 S DIR(0)="FO^1:80",DIR("A")="Report descriptive title (optional)",DIR("?")="Enter brief text describing the report (displayed at top of each page printed)."
 W ! S SDX=$$DIR^SCRPW23(.DIR,0) I SDX=""!(SDX=U) K SDPAR("O",2) Q
 S:$L(SDX) SDPAR("O",2)=SDX Q
 ;
REST() ;Select/restore template for editing
 ;Ouput: 1=template restored, 0=template not restored
 Q:'$O(^SDD(409.91,0)) 0
 W ! K DIR S DIR(0)="YO",DIR("A")="Would you like to use parameters from an existing template" D ^DIR I $D(DUOUT)!$D(DTOUT) S SDOUT=1 Q 0
 Q:'Y 0  W ! K SDPAR Q $$SELT^SCRPW21(.SDPAR)
