HDISDOL ;BPFO/DTG - LOOK UP SDO CODES FOR ORDERABLE ITEMS; Apr 07, 2018@12:42
 ;;1.0;HEALTH DATA & INFORMATICS;**22**;Feb 22, 2005;Build 26
 ;
 ; ICR's:
 ; 6895 - HDI READ ORDERABLE ITEMS File (#101.43)
 ; 6894 - HDI COLLECT SDOS
 ;
EN ; lookup orderable items for lab
 ; pick area
 N HDIAR,HDAR,PHM,LAB,DIR,RET,DA,DIE,MSG,I,Y,A,B,C,ERR,DIRUT,COUNT,HOK,HDICRT,HDIGO,HDITSK,HDITYPE,HTYP
 N HDIPART,HDISING,HDISP,OIENAM,AA,BB,CC,DD
 S RET="^TMP(""HDISDORET"",$J)",(HDIPART,HDISING,HDISP,OIENAM)="",$P(HDISP," ",75)=""
 D INFO
AREA ; only for Lab
    S HDIAR="L"
    S HDAR="LAB"
    ; set up allowable sets by area
 F I="LAB","CH","MI","EM","SP","CY","AU" S LAB(I)=1
ASK ; partial, all, or item
 S HTYP="" K DIR,Y,DIRUT
 S DIR("A")="Enter the Type of Search"
 S DIR(0)="SO^P:PARTIAL;S:SINGLE;A:ALL"
    S DIR("L",1)=" PARTIAL   (P)"
    S DIR("L",2)=" SINGLE    (S)"
    S DIR("L",3)=" ALL       (A)"
    S DIR("?")="Enter the Type of Search for the lookup. P for Partial, S Single, or A for All. Enter '^' to go back"
    D ^DIR
    I $D(DIRUT)!($E(Y)="^")!(Y="") W !,*7,"Type Not Selected." G QUIT
 I "PSA"'[$E($G(Y)) W !,*7,"Invalid Type Entered." G ASK
    S HTYP=$E($G(Y))
    I HTYP="A" G ALL
    I HTYP="P" G PART
    I HTYP="S" G SING
 W !,*7,"Type Not Selected. Quiting" G QUIT
    ;
ALL ;get all of the orderable items for an area
 K ERR,ZERR,ERRARY
 S ERR="",COUNT="" K @RET
 ;
 W !,*7," Collecting SDO's",!
 S ERR=$$EN^HDISDOC(HDIAR,"ALL","ALL",.RET,"ERRARY","COUNT")
 S OK="" I ERR D  I OK G ASK
 . D DISER F I=1:1 S A=$P(ERR,",",I) Q:A=""  I A<8!(A=12) S OK=1 Q
    D GOTO
    G AREA
    ;
SING ; single lookup select
 K DIR,DA,DIRUT
 S ERR="",COUNT="" K @RET,ERRARY
 S DIR(0)="PO^101.43:EMQZ"
 S DIR("A")="Enter the Orderable Item for SDO value"
 S DIR("S")="I $$CHKO^HDISDOL(+Y)"
 D ^DIR
 I $D(DIRUT)!($E(X)="^") G ASK
 I +Y'>0 W *7,!,"Invalid Item" G SING
 S OIEN=+Y
 S SINGM="",A=$P(Y,U,2) I A'=""&($E(A,1,$L(X))'=X) S SINGM="Y"
 ; check if proper group
 S HOK=$$CHKO(OIEN)
 I 'HOK W *7,!,"Orderable Item NOT Associated to Selected Area: LABORATORY" G SING
 S OIENAM=$$GETNAM(OIEN)
 S ERR=$$EN^HDISDOC(HDAR,"S",OIEN,.RET,"ERRARY","COUNT",SINGM)
 S OK="" I ERR D  I OK G SING
 . D DISER F I=1:1 S A=$P(ERR,",",I) Q:A=""  I A<8!(A=12) S OK=1 Q
 D GOTO
 G SING
 ;
PART ; enter partial name for lookup
 K DIR,DA,DIRUT
 S ERR="",COUNT="" K @RET,ERRARY
 S DIR("A")="Enter a Case Sensitive Partial Match for an Orderable Item Name"
 S DIR(0)="FO^1:40^"
    S DIR("?")="Enter a case sensitive Partial Match Orderable Item Name to lookup SDO Codes for. Enter '^' to go Back"
    D ^DIR
    I $D(DIRUT)!(Y="^") G ASK
    ; check if any names partial patch and are in the selected area
    S PART=Y
    D LIST^DIC(101.43,,";.01I","",,,PART,"B",,,"AA")
    K AB S A=0 F  S A=$O(AA("DILIST",2,A)) Q:'A  D  ;<
    . S D=$G(AA("DILIST",2,A)),E=$G(AA("DILIST",1,A)),F=$G(AA("DILIST","ID",A,.01))
    . I $E(E,1,$L(PART))=PART S AB(D)=""
    K AA
    S OK="",A=0,A=$O(AB(A)) I 'A G P2
    S A=0 F  S A=$O(AB(A)) Q:'A  S OK=$$CHKO(A) Q:OK=1  ;<
    K AB
    ;
P2 I 'OK W *7,!!," None of The Partial Matches Are Associated to The Selected Area: LABORATORY" G PART
    ;
    W !,*7," Collecting SDO's",!
    S HDIPART=Y
    S ERR=$$EN^HDISDOC(HDAR,"P",Y,.RET,"ERRARY","COUNT")
    S OK="" I ERR D  I OK G PART
    . D DISER F I=1:1 S A=$P(ERR,",",I) Q:A=""  I A<8!(A=12) S OK=1 Q
    D GOTO
    G PART
    ;
INFO ; Display message, clear screen
 N MSG
 S MSG(1)="   This option allows the user to look up SDO codes for items in the ORDERABLE ITEMS File"
 S MSG(2)="   (#101.43). The lookup is limited to orderable items related to Laboratory"
 s MSG(4)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
 ;
INFOQS ; display quick stats for data return
 N MSG,A,B K MSG
 S A="Quick Stat for "_$S(HTYP="P":"Partial Match With",HTYP="A":"All",1:"Single")_" "_$S(HDIAR="L":"Laboratory",1:"Pharmacy")_" Orderable Item"_$S(HTYP="A":"s",HTYP="P":" Name:",1:" Name:")
 S B=$E(HDISP,1,(40-($L(A)\2)))_A
 S MSG(1)=B
 S A="" I HTYP="A" S A="ALL Laboratory Orderable Items"
 I HTYP="P" S A="Partial Name: "_$E(HDIPART,1,63)
 I HTYP="S" S A="IEN: "_OIEN_" Name: "_$E(OIENAM,1,63)
 S B=$E(HDISP,1,(40-($L(A)\2)))_A
 S MSG(2)=B
 G INFOL
 ;
INFOL ; Display Lab message, clear screen
 S MSG(3)="   Orderable Items File Count: "_$J($P(COUNT,U,2),6)
 S MSG(4)="   Number of Orderable Items File That Are Inactive: "_$J($P(COUNT,U,3),6)
 S MSG(5)="   Number of Orderable Items Partial Match to Mnemonic: "_$J($P(COUNT,U,4),6)
 S MSG(6)="   Number of Primary Lab Tests Count: "_$J($P(COUNT,U,5),6)
 S MSG(7)="   Number of Primary Tests that are Panels: "_$J($P(COUNT,U,6),6)
 S MSG(8)="   Number of Laboratory Tests: "_$J($P(COUNT,U,7),6)
 S MSG(9)="   Number of Unique Laboratory Tests: "_$J($P(COUNT,U,13),6)
 S MSG(10)="   Number of Inactive Laboratory Tests: "_$J($P(COUNT,U,8),6)
 S MSG(11)="   Number of Specimens: "_$J($P(COUNT,U,9),6)
 S MSG(12)="   Number of Inactive Specimens: "_$J($P(COUNT,U,10),6)
 S MSG(13)="   Number of Master Laboratory Tests: "_$J($P(COUNT,U,11),6)
 S MSG(14)="   Number of Unique Master Laboratory Tests: "_$J($P(COUNT,U,14),6)
 S MSG(15)="   Number of Inactive Master Laboratory Tests: "_$J($P(COUNT,U,12),6)
 S MSG(16)=""
 G INFOO
 ;
INFOO ; output quick stats
 D CLEAR^VALM1
 N A S A=0 F  S A=$O(MSG(A)) Q:'A  W !,MSG(A)
 N DIR,DIRUT,LREND,LRCNT,LRSUB,LRVAL,LRST,LRSTN,LRTXT,X,Y
 S DIR(0)="FO^0:3",DIR("A")="Press ENTER to Continue",DIR("B")=" "
 D ^DIR
 Q
 ;
QUIT ; exit here
 K @RET
 K HDIAR,HDAR,PHM,LAB,DIR,RET,DA,DIE,MSG,I,Y,A,B,C,ERR,DIRUT,COUNT
 K HOK,HDICRT,HDIGO,HDITSK,HDITYPE,HTYP
 K HDIPART,HDISING,HDISP,OIENAM
 Q
 ;
CHKO(HOI) ;check if order belongs to the correct area
 N A,B,AA,AR,E
 S OK="" K AA D LIST^DIC(101.439,","_HOI_",","@;.01I","",,,,,,,"AA")
 K AR M AR=AA("DILIST","ID") K AA
 S E="" F  S E=$O(AR(E)) Q:'E  S B=$G(AR(E,.01)) S:$G(@HDAR@(B))=1 OK=1 I (HDIAR="L"&((B="BB")!(B="HEMA")!(B="AP")!(B="VBC")!(B="VBEC")!(B="Hemo"))) S OK="" Q
 K AR,A,B,AA,E
 Q OK
 ;
GETNAM(A) ; get orderable item name if single order
 N C,DIQ,DIC,DR,DA,OB
 S DA=A
 S C="",DIQ="OB",DIQ(0)="IE",DIC=101.43,DR=".01" K ^UTILITY("DIQ1",$J) D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 Q $G(OB(101.43,DA,.01,"E"))
 ;
GOTO ;
 ; display quick summary
 D INFOQS
 G TYPE
 ; get type
TYPE ; determine output format
 K DIR,DA,DIRUT
 S DIR("A")="Enter the Output Format"
 S DIR(0)="SO^X:XML;E:EXPORT;R:REPORT"
    S DIR("L",1)=" XML       (X)"
    S DIR("L",2)=" EXPORT    (E)"
    S DIR("L",3)=" REPORT    (R)"
    S DIR("?")="Enter the Output Type for the Search Results. X for XML, E Export Tab Delimited, or R Report. Enter '^' to go back"
    D ^DIR
    I $D(DIRUT)!($E(Y)="^") W !,*7,"Output Type Not Selected" Q
    I ("XER"'[$E($G(Y))) W !,*7,"Valid Type Not Selected. Default to Report" S Y="R"
    S HDITYPE=$E(Y)
    ;
    S HDIGO="^HDISDOL"_HDIAR
    ; move REC to REC1 since most printing will go through taskman
    S A="",HDITSK="" F I=1:1:100 H 1 S A=$R(1000) I $G(^TMP("HDIOUT",A))'=DT S HDITSK=A Q
    S RET1="^TMP(""HDIOUT"",HDITSK)" K @RET1 M @RET1=@RET S @RET1=DT
    ;
    ;device
DEVICE S %ZIS="Q",%ZIS("A")="Output device: " D ^%ZIS
 I POP D HOME^ZIS W !,*7,"No Device Selected" Q
 S HDICRT=$S($E(IOST,1,2)="C-":1,1:0)
 I (HDICRT&(HTYP="A")&(HDITYPE'="R")) S OK="" D DASK I 'OK G DEVICE
 I $D(IO("Q")) N ZTDTH,ZTRTN,ZTIO,ZTDESC,ZTIO,ZTSAVE D  W:$D(ZTSK) !!,"Request queued",!! Q
 . S A=$P($H,",",2)+30,ZTDTH=$P($H,",",1)_","_A,ZTRTN="EN"_HDIGO
 . S ZTDESC="HDI SDO Items For "_HDAR_" Report"
 . K ZTIO
 . F I="HDICRT","HDITSK","HDITYPE","RET1","HDIAR","HDAR","HTYP","COUNT" S ZTSAVE(I)=""
 . D ^%ZTLOAD
 . D ^%ZISC
 I 'HDICRT W !,*7,"....Outputting...",!!
 D @HDIGO
 Q
 ;
DASK ; double dare for local device if type is ALL
 N DIR,DIRUT,A,B,Y,C
 K DIR,DIRUT
 S DIR(0)="Y",DIR("A")="Are you sure you want ALL of the collected items go to your screen?"
 S DIR("?")="If you enter yes, the ALL output will go to your screen. With XML and EXPORT there is no interupt logic."
 S DIR("B")="No"
 D ^DIR
 I $D(DIRUT) S OK="" Q
 I Y<1 S OK="" Q
 S OK=1
 Q
 ;
DISER ; display return error type
 I ERR=0 Q
 N MSG,A,I,B S MSG(1)="ERROR ITEMS FROM HDI SDO LOOKUP"
 F I=1:1 S A=$P(ERR,",",I) Q:A=""  S B(A)=""
 ; remove multi's of repeating error #'s
 S A=0 F I=1:1 S A=$O(B(A)) Q:'A  S MSG(I+1)=A_") "_$P($T(DISTXT+A),";",3)
 I $O(ERRARY(0))>0 D  ;<
 . S A=0 F  S A=$O(ERRARY(A)) Q:'A  S MSG(I+1)=ERRARY(A),I=I+1
 S MSG(I+1)=""
 K A,I
 G INFOO
 ;
DISTXT ; error text
 ;;Area Not Sent.
 ;;Lookup Value Not Sent.
 ;;Return Value Not Sent.
 ;;Improper Search Area
 ;;Single Item Not Found in ORDERABLE ITEMS File 101.43.
 ;;Single Item Not in Area.
 ;;Partial Lookup Error.
 ;;Orderable Items File Does Not Have Lab Pointer for Item.
 ;;Orderable Item Lab Pointer Not Found in Lab File.
 ;;
 ;;
 ;;Type of Lookup not Sent
