RMPR5HQ4 ;HCIOFO/ODJ - INVENTORY REPORT - PARAMETER DATA ENTRY ; 20 SEP 00
 ;;3.0;PROSTHETICS;**51,84,103,152**;Feb 09, 1996;Build 3
 ;
 ; AAC Patch 84, 02-25-04, additions, deletions and change descriptions for Groups and lines.
 ;
 ; Prompts for Station, Start date, End date, level of detail, 
 ; NPPD group, NPPD line, HCPC selections and Report Device
START N RMPRSDT,RMPREDT,RMPREXC,RMPRSEL,RMPRHTY,RMPRGLST,RMPRLINX
 N RMPRI,RMPRJ,RMPRLCN,RMPRHCN,RMPR,RMPRGRPA,RMPRVISN
 ; RMPR("STA")  Station Number (ien ^DIC(4)
 S RMPRSDT="" ; start date VM internal
 S RMPREDT=DT ; end date VM internal
 I '$D(RMPRDET) N RMPRDET S RMPRDET="" ; Level of detail
 S RMPRHTY="" ; type of HCPCS selection
 S RMPRLCN=1  ; Count for number of individual NPPD lines selected
 S RMPRHCN=1  ; Count for number of individual HCPCs selected
 K RMPREXC    ; Exit condition from prompts (^ defined as quit)
 K RMPRSEL    ; Array of parameter selections
 ;              If this array gets too big then need to save in ^TMP
 ;              in which case queuing option will have to be removed
 ;
 D GRPLST(.RMPRGLST) ;set list of NPPD group codes for DIR prompt
 D GRPARY(.RMPRGRPA)
 D SETLIN(.RMPRLINX) ;set an indexing array for NPPD line help
 S RMPREXC=$$STN(.RMPR,.RMPRVISN)
 I RMPREXC="^" G EDX
 S RMPREXC=$$STDT(.RMPRSDT) ;get Start Date (fileman format)
 I RMPREXC="^" G EDX
 S RMPREXC=$$ENDT(.RMPREDT,RMPRSDT) ;get End Date (fileman format)
 I RMPREXC="^" G EDX
 I RMPRDET="" S RMPREXC=$$LEV(.RMPRDET) ;get Level of Detail
 I RMPREXC="^" G EDX
 I RMPRDET="G" K RMPRSEL S RMPRSEL("*")="" G EDDEV ;NPPD group level of detail
 I RMPRDET="L" G EDLIN ;NPPD line level of detail
 I RMPRDET="H"!(RMPRDET="I") G EDHCPC ;HCPC or Item level of detail
 ;
 ; NPPD Group level of detail
EDGRP S RMPREXC=$$NPGRP(.RMPRSEL)
 I RMPREXC="^" G EDX
 G EDDEV
 ;
 ; NPPD Line level of detail
EDLIN S RMPREXC=$$NPLIN(.RMPRSEL)
 I RMPREXC="^" G EDX
EDLINX G EDDEV
 ;
 ; HCPC level of detail
EDHCPC S RMPREXC=$$HCPCTY(.RMPRHTY)
 I RMPREXC="^" G EDX
 I RMPRHTY="" G EDDEV
 I RMPRHTY="A" K RMPRSEL S RMPRSEL("*")="" G EDDEV
 I RMPRHTY="G" S RMPREXC=$$NPGRP(.RMPRSEL) G EDDEV
 I RMPRHTY="L" S RMPREXC=$$NPLIN(.RMPRSEL) G EDDEV
 S RMPREXC=$$HCPC(.RMPRSEL,.RMPRHCN)
 G EDDEV
 ;
 ; Get device and run report or queue it
EDDEV S RMPREXC=$$REPDEV("")
 I RMPREXC="^" G EDX
 I '$D(IO("Q")) D REPORT^RMPR5HQ5 G EDX
 K IO("Q")
 S ZTDESC="INVENTORY REPORT",ZTRTN="REPORT^RMPR5HQ5",ZTIO=ION
 S ZTSAVE("RMPRSDT")=""
 S ZTSAVE("RMPREDT")=""
 S ZTSAVE("RMPRDET")=""
 S ZTSAVE("RMPRSEL(")=""
 ;S ZTSAVE("IOM")=""
 S ZTSAVE("RMPR(""STA"")")=""
 D ^%ZTLOAD
 W:$D(ZTSK) !,"REQUEST QUEUED!" H 1
EDX Q
 ;
 ; Prompt for Site/Station
STN(RMPR,RMPRVISN) ;
 N X,Y,DIC,DA
 S RMPRVISN=""
 D DIV4^RMPRSIT ; call standard Prosthetic site look-up
 I $D(X) S X="^"
 E  S X="" S:RMPRSITE'="" RMPRVISN=$P($G(^RMPR(669.9,RMPRSITE,"INV")),"^",2)
 Q X
 ;
 ; Prompt for level of detail
EN1 N RMPRDET S RMPRDET="G" ;entry point NPPD Group level
 G START
EN2 N RMPRDET S RMPRDET="L" ;entry point NPPD Line level
 G START
EN3 N RMPRDET S RMPRDET="H" ;entry point HCPCS level
 G START
EN4 N RMPRDET S RMPRDET="I" ;entry point Item level
 G START
LEV(RMPRDET) ;
 N DIR,X,Y
 S RMPRDET=$G(RMPRDET)
 S DIR(0)="S^G:NPPD Group;L:NPPD Line;H:HCPCS Code;I:HCPCS Item"
 S DIR("A")="Select inventory report level of detail"
 D ^DIR
 I Y="",$D(DTOUT) S X="^" G LEVX
 I Y="^"!(Y="^^") S X="^" G LEVX
 S RMPRDET=Y
LEVX Q X
 ;
 ; Prompt for Start Date
STDT(RMPRSDT) ; RMPRSDT is start date in FM internal form
 N %DT,X,Y
 S %DT("A")="Beginning Date: "
 S %DT(0)=-DT
 S %DT="AEP"
 D ^%DT
 I Y<0 S X="^"
 S RMPRSDT=$P(Y,".",1)
 Q X
 ;
 ; Prompt for End Date
ENDT(RMPREDT,RMPRSDT) ; RMPREDT is end date in FM internal form
 N %DT,X,Y
ENDT1 S %DT("A")="Ending Date: "
 S %DT(0)=-DT
 S %DT="AEP"
 D ^%DT
 I Y<0 S X="^" G ENDT1X
 S RMPREDT=$P(Y,".",1)
 I RMPREDT<RMPRSDT W !,"Ending date should not precede start date",! G ENDT1
ENDT1X Q X
 ;
 ; Prompt for NPPD group
NPGRP(RMPRSEL) ;
 N DIR,DA,X,Y,RMPRCNT,RMPRI,RMPRJ,RMPRGRP
 W !
 F RMPRCNT=1:1:$L(RMPRGLST,";") D
 . W !,$J(RMPRCNT,2)_". "_$P($P(RMPRGLST,";",RMPRCNT),":",2)
 . Q
 S DIR(0)="L" S:$D(RMPRSEL) DIR(0)=DIR(0)_"O"
 S DIR("A")="Select NPPD Group "
 S $P(DIR(0),U,2)="1:"_RMPRCNT
 D ^DIR
 I Y="",$D(DTOUT) S X="^" G NPGRPX
 I Y="^"!(Y="^^") S X="^" G NPGRPX
 I Y="" S X="" G NPGRPX ; no selection so just exit
 ;
 ; add in the new selections
 S RMPRI=""
 F  S RMPRI=$O(Y(RMPRI)) Q:RMPRI=""  D  Q:RMPRI=""
 . I $L(Y(RMPRI),",")-1=RMPRCNT D  Q
 .. K RMPRSEL
 .. S RMPRSEL("*")="" ; all groups selected
 .. S RMPRI=""
 .. Q
 . F RMPRJ=1:1:$L(Y(RMPRI),",")-1 D
 .. S RMPRGRP=$P($P(RMPRGLST,";",$P(Y(RMPRI),",",RMPRJ)),":",1)
 .. K RMPRSEL(RMPRGRP)
 .. S RMPRSEL(RMPRGRP,"*")=""
 .. Q
 . Q
NPGRPX Q X
 ;
 ; Prompt for NPPD line
 ; User can select lines within a group
 ; If more than 1 group selected must use all lines within those groups
NPLIN(RMPRSEL) ;
 N DIR,DA,X,Y,RMPRHPG,RMPRGRP,RMPRLIN,RMPREXC,RMPRI,RMPRJ
 S DIR(0)="L" S:$D(RMPRSEL) DIR(0)=DIR(0)_"O"
NPLIN1C S RMPREXC=$$NPGRP(.RMPRSEL)
 I RMPREXC="^" S X="^" G NPLIN1X
 I $O(RMPRSEL(""))="*" S X="" G NPLIN1X
 S RMPRI=0,RMPRJ="" F  S RMPRJ=$O(RMPRSEL(RMPRJ)) Q:RMPRJ=""  S RMPRI=RMPRI+1 Q:RMPRI=2
 I RMPRI=2 S X="" G NPLIN1X
 S RMPRGRP=$O(RMPRSEL("")) K RMPRSEL
NPLIN1A D NPLINH(RMPRGRP,.RMPRHPG)
 S $P(DIR(0),U,2)="1:"_RMPRHPG
 S DIR("A")="Select NPPD line(s) within the above group"
 D ^DIR
 I Y="",$D(DTOUT) S X="^" G NPLIN1X
 I Y="^"!(Y="^^") S X="^" G NPLIN1X
 I Y="" S X="" G NPLIN1X
 S RMPRI=""
 F  S RMPRI=$O(Y(RMPRI)) Q:RMPRI=""  D  Q:RMPRI=""
 . I $L(Y(RMPRI),",")-1=RMPRHPG D  Q
 .. K RMPRSEL(RMPRGRP)
 .. S RMPRSEL(RMPRGRP,"*")="" ; all lines selected
 .. S RMPRI=""
 .. Q
 . F RMPRJ=1:1:$L(Y(RMPRI),",")-1 D
 .. D NPLINC(RMPRGRP,$P(Y(RMPRI),",",RMPRJ),.RMPRLIN)
 .. K RMPRSEL(RMPRGRP,RMPRLIN)
 .. S RMPRSEL(RMPRGRP,RMPRLIN,"*")=""
 .. Q
 . Q
 S X=""
NPLIN1X Q X
 ;
 ; Check entered NPPD line
 ; OFFS = line offset in RMPRN62 if valid NPPD line (else null)
 ;
NPLINC(RMPRGRP,INP,RMPRLIN) ;
 N S,OFFS
 S OFFS=RMPRLINX(RMPRGRP)+INP-1
 S S=$P($T(DES+OFFS^RMPRN62),";;",2)
 S RMPRLIN=$P(S,";",1)
 Q
 ;
 ; Display NPPD lines for a given group
NPLINH(RMPRGRP,TO) ;
 N FR,I,S,LINCD
 W !,"NPPD Lines for Group: ",RMPRGRP," - ",RMPRGRPA(RMPRGRP),!
 S FR=RMPRLINX(RMPRGRP)
 S TO=0
 F  S S=$P($T(DES+FR^RMPRN62),";;",2),LINCD=$P(S,";",1) Q:$P(LINCD," ",1)'=RMPRGRP  D
 . S TO=TO+1
 . W !,$J(TO,2),". ",$P(S,";",1)_" "_$P(S,";",2)
 . W:$D(RMPRSEL(RMPRGRP,LINCD)) ?65,"<< Selected"
 . S FR=FR+1
 . Q
 Q
 ;
 ; Select type of HCPCS selection
HCPCTY(RMPRHTY) ;
 N DIR,DA,X,Y
 S DIR("B")="A"
 S DIR(0)="S^A:ALL HCPCS;G:ALL HCPCS for NPPD group;L:ALL HCPCS for NPPD  line;S:Select individual HCPCS"
 S DIR("A")="Choose HCPCS selection option"
 D ^DIR
 I Y="",$D(DTOUT) S X="^" G HCPCTYX
 I Y="^"!(Y="^^") S X="^" G HCPCTYX
 I X="" S RMPRHTY="" G HCPCTYX
 S RMPRHTY=Y
HCPCTYX Q X
 ;
 ; Select HCPCS
HCPC(RMPRSEL,RMPRSCN) ;
 N DIC,X,Y,DA,RMPRLIN
 S DIC="^RMPR(661.1,",DIC(0)="AEQMZ"
HCPC1 S DIC("A")="Select HCPCS "_RMPRSCN_": "
 D ^DIC
 I $D(DTOUT) S X="^" G HCPCX
 I $D(DUOUT) S X="^" G HCPCX
 I X="" G HCPCX
 S RMPRLIN=$P(Y(0),U,7)
 S:RMPRLIN="" RMPRLIN="999 X"
 S RMPRSEL($P(RMPRLIN," ",1),RMPRLIN,$P(Y,U,1))=""
 S RMPRSCN=RMPRSCN+1
 G HCPC1
HCPCX Q X
 ;
 ; Select Report device
REPDEV(RMPRDEV) ;
 N X,POP,Y,%ZIS,IOP
REPDEV1 S X=""
 S %ZIS="MQ" K IOP D ^%ZIS I POP S X="^" G REPDEVX
 I IOM<132 W !,"You need at least 132 columns for this report.",!,"Please use a device capable of this requirement.",! G REPDEV1
REPDEVX Q X
 ;
 ; LINX is an array used in the help system within NPPD line selection
 ; Basically each page of help will show lines for a group.
 ; Each page has a start line corresponding to an offset in RMPRN62
SETLIN(LINX) ;
 N I,HLPPG,S,LINCD,LINCD0
 S HLPPG=0,LINCD0=""
 F I=1:1 S S=$T(DES+I^RMPRN62) D  Q:LINCD0=""
 . S LINCD=$P($P(S,";;",2),";",1)
 . S HLPPG=$P(LINCD," ",1)
 . I $E(HLPPG)'?1N S LINX(HLPPG)=I,LINCD0="" Q
 . I HLPPG'=LINCD0 D  Q
 .. S LINX(HLPPG)=I,LINCD0=HLPPG
 .. Q
 . Q
 Q
 ;
 ; Set NPPD (new) group codes and desc. for use in DIR
 ; set of codes prompt.
 ; Hard coded, but better if in Fileman file sometime
 ; Codes and desc. copied from RMPRN6UT
GRPLST(LIST) ;
 S LIST="100:WHEELCHAIRS AND ACCESSORIES"
 S $P(LIST,";",2)="200:ARTIFICIAL LEGS"
 S $P(LIST,";",3)="300:ARTIFICIAL ARMS AND TERMINAL DEVICES"
 S $P(LIST,";",4)="400:ORTHOSIS/ORTHOTICS"
 S $P(LIST,";",5)="500:SHOES/ORTHOTICS"
 S $P(LIST,";",6)="600:SENSORI-NEURO AIDS"
 S $P(LIST,";",7)="700:RESTORATIONS"
 S $P(LIST,";",8)="800:OXYGEN AND RESPIRATORY"
 S $P(LIST,";",9)="900:MEDICAL EQUIPMENT"
 S $P(LIST,";",10)="910:ALL OTHER SUPPLIES AND EQUIPMENT"
 S $P(LIST,";",11)="920:HOME DIALYSIS PROGRAM"
 S $P(LIST,";",12)="930:ADAPTIVE EQUIPMENT"
 S $P(LIST,";",13)="940:HISA"
 S $P(LIST,";",14)="960:SURGICAL IMPLANTS"
 S $P(LIST,";",15)="970:BIOLOGICAL IMPLANTS"
 S $P(LIST,";",16)="999:MISC"
 Q
 ;
 ; Same as above but set into array
GRPARY(ARRAY) ;
 N LIST,I
 K ARRAY
 D GRPLST(.LIST)
 F I=1:1:$L(LIST,";") S ARRAY($P($P(LIST,";",I),":",1))=$P($P(LIST,";",I),":",2)
 Q
