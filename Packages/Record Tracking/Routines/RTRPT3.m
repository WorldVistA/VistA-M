RTRPT3 ;MJK/TROY ISC;Management Report Options; ; 5/18/87  8:58 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
6 ;Records Charged Out By Home Location
 D HOME G Q6:'$D(RTHOME) D SORT G Q6:RTSORT="^"
 S RTRD(1)="Yes^include all records",RTRD(2)="No^not include records currently checked into home location",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Include records currently checked into the home location? "
 D SET^RTRD G Q6:$E(X)="^",61:$E(X)="Y"
 S DIS(0)="I $D(^RT(D0,0)),$P(^(0),U,4)="_+RTAPL_$S($P(RTHOME,"^",3)="Y":"",1:",$D(^RT(D0,""CL"")),$P(^(""CL""),U,5)'=+RTHOME")
 S DHD="Charged Out Records  [Home Location: "_$P(RTHOME,"^",2)_"]   [Sorted by: "_$S(RTSORT="B":"BORROWER",RTSORT="T":"TERMINAL DIGITS",1:"NAME")_"]"
 S FR=","_+RTHOME,TO=","_+RTHOME_".999999",DIC="^RT(",L=0,FLDS="[RT HOME LOCATION]",BY="[RT CHARGED BY HOME BY "_$S(RTSORT="B":"BOR",RTSORT="T":"TD",1:"NAME")_"]" K DTOUT D EN1^DIP
Q6 K DIC,DIS,RTI,RTWND,RTMOVE,DHD,RTHOME,RTSORT,BY,FLDS,TO,FR
 K RTOP,RTRD,X,X1,Y,L Q
61 S DIS(0)="I $D(^RT(D0,0)),$P(^(0),U,4)="_+RTAPL,DHD="Home Location List  [Home Location: "_$P(RTHOME,"^",2)_"]   [Sorted by: "_$S(RTSORT="B":"BORROWER",RTSORT="T":"TERMINAL DIGITS",1:"NAME")_"]"
 S FR=+RTHOME,TO=+RTHOME_".999999",DIC="^RT(",L=0,FLDS="[RT HOME LOCATION]",BY="[RT HOME LIST BY "_$S(RTSORT="B":"BOR",RTSORT="T":"TD",1:"NAME")_"]" K DTOUT D EN1^DIP G Q6
 ;
3 ;;Overdue List
 K RTMOVE F RTI=0:0 S RTI=$O(^DIC(195.3,"C",+RTAPL,RTI)) Q:'RTI  I $D(^DIC(195.3,RTI,0)),$P(^(0),"^",4)="y" S RTMOVE(RTI)=""
 S DIS(0)="I $D(^RT(D0,0)),$D(^(""CL"")),$P(^(0),U,4)="_+RTAPL_",$P(^(0),U,6)'=$P(^(""CL""),U,5),$D(RTMOVE(+$P(^(""CL""),U,8))),$D(RTWND(+$P(^(0),U,3))),RTWND(+$P(^(0),U,3))>$P(^(""CL""),U,6)"
 S DIS(1)="I '$D(^DPT(+^RT(D0,0),.1))"
 S RTRD(1)="Institution^print overdue records by institution",RTRD(2)="Home^print overdue records by home location",RTRD("B")=1,RTRD(0)="S",RTRD("A")="Print Overdue List for a 'Institution' or 'Home Location'? " D SET^RTRD K RTRD
 G Q3:X="^" S RTOP=$E(X) D HOME:RTOP="H",DIV:$S('$D(RTOP):0,1:RTOP="I") G Q3:'$D(RTOP) D SORT G Q3:RTSORT="^"
 S DHD="Records Overdue ["_$S($D(RTHOME):"Home Location: "_$P(RTHOME,"^",2),1:"Institution: "_$P(RTDV,"^"))_"]   [Sorted by: "_$S(RTSORT="B":"BORROWER",RTSORT="T":"TERMINAL DIGITS",1:"NAME")_"]"
 D WINDOW^RTRPT S:$D(RTDV) X=$P(RTDV,",") S FR="2860101.0001,"_$S($D(RTHOME):+RTHOME,1:$P(X,",")),TO=RTWND_".9999"_","_$S($D(RTHOME):+RTHOME_".9999",1:$E(X,1,$L(X)-1)_$C($A($E(X,$L(X)))+1))
 S L=0,DIC="^RT(",FLDS="[RT HOME LOCATION]",BY="[RT OVER BY "_$S($D(RTHOME):"HOME",1:"DIV")_" BY "_$S(RTSORT="B":"BOR",RTSORT="T":"TD",1:"NAME")_"]" K DTOUT D OFF,EN1^DIP,ON
Q3 K RTI,DIS,DHD,RTOP,RTHOME,RTDV,RTSORT,RTWND,RTMOVE,FLDS,BY,FR,TO,DIC,X,X1 Q
 ;
HOME K RTOP,RTHOME W ! S DIC="^RTV(195.9,",DIC(0)="IAEMQ",DIC("S")="I $P(^(0),U,3)="_+RTAPL_",$P(^(0),U,13)=""F""",DIC("A")="Select HOME Location: " D ^DIC K DIC Q:Y<0
 S (RTOP,Y,RTHOME)=+Y D BOR^RTB S RTHOME=RTHOME_"^"_Y Q
 ;
DIV K RTOP,DIC,RTDV I $O(^DIC(195.1,+RTAPL,"INST",0)) S I=+$O(^(0)) I '$O(^(I)),$D(^DIC(4,I,0)) S (RTOP,RTDV)=$P(^(0),"^") Q
 S DIC(0)="AEMQI",DIC="^DIC(4,",DIC("A")="Select Institution: ",DIC("S")="I $D(^DIC(195.1,"_+RTAPL_",""INST"",Y,0))" S:$S('$D(DUZ(2)):0,$D(^DIC(4,+DUZ(2),0)):1,1:0) DIC("B")=$P(^(0),"^") D ^DIC K DIC
 I Y>0 S RTOP=+Y,RTDV=$P(Y,"^",2)
 Q
 ;
SORT S RTRD(1)="Borrower^sort by borrower",RTRD(2)="Name^sort by name",RTRD(3)="Terminal Digits^sort by terminal digits",RTRD(0)="S",RTRD("B")=1,RTRD("A")="How do you want the listing sorted? " D SET^RTRD K RTRD S RTSORT=$E(X) Q
 ;
ON I ^%ZOSF("OS")["M/11+" D ON^%XECOPT Q
 Q
OFF I ^%ZOSF("OS")["M/11+" D OFF^%XECOPT Q
 Q
