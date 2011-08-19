ORCMEDT4 ;SLC/MKB-Prompt Editor ;6/19/01  15:05
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**8,46,95,245**;Dec 17, 1997;Build 2
EN ; -- Enter/edit prompts
 N PRMT F  S PRMT=+$$PROMPT Q:PRMT'>0  D  W !
 . I $P($G(^ORD(101.41,PRMT,0)),U,7)=$O(^DIC(9.4,"C","OR",0)) D  Q
 . . N DIC,DA S DIC="^ORD(101.41,",DA=PRMT D EN^DIQ
 . . W !,"This prompt is not editable!"
 . D EDIT(PRMT)
 Q
 ;
EDIT(DA) ; -- Edit prompt DA
 N DR,DIE,NAME,TEXT,TYPE,DOMAIN,OR0,OR1,ORP
 Q:'$G(DA)  S OR0=$G(^ORD(101.41,DA,0)),OR1=$G(^(1)),ORP=DA
 S NAME=$$NAME(DA) Q:(NAME="@")!(NAME="^")  ;deleted or quit
 S TEXT=$$DTEXT($P(OR0,U,2)) Q:TEXT="^"
 S TYPE=$$DATATYPE($P(OR1,U)) Q:TYPE="^"  S DOMAIN=$P(OR1,U,2)
 D @$S(TYPE="D"!(TYPE="R"):"DATE",TYPE="F":"TEXT",TYPE="N":"NMBR",TYPE="P":"PTR",TYPE="S":"SET",1:"OTHER") Q:DOMAIN="^"
 S $P(^ORD(101.41,DA,1),U,1,2)=TYPE_U_DOMAIN,DIE="^ORD(101.41,"
 S DR=$S(NAME'=$P(OR0,U):".01///^S X=NAME;",1:"")_$S(TEXT'=$P(OR0,U,2):"2///^S X=TEXT;",1:"")_"20"_";13" D ^DIE ;95
 Q
 ;
PROMPT() ; -- Find prompt in #101.41
 N X,Y,DIC,DLAYGO
 S DIC="^ORD(101.41,",DIC(0)="AEQLM",DLAYGO=101.41
 S DIC("A")="Select PROMPT: ",DIC("S")="I $P(^(0),U,4)=""P"""
 S DIC("DR")="4////P" D ^DIC
 Q Y
 ;
NAME(IFN) ; -- Edit .01 name of dialog IFN
 N X,Y,DIR,OLDNAME,ISPQO,NODELETE,DA,DIK,TYPE
 S DIR(0)="FAO^3:63",DIR("A")="NAME: "
 S OLDNAME=$P($G(^ORD(101.41,IFN,0)),U),ISPQO=0,NODELETE=1
 S TYPE=$P($G(^ORD(101.41,IFN,0)),U,4)
 I TYPE="Q",$E(OLDNAME,1,6)="ORWDQ " S ISPQO=1
 I ISPQO!(TYPE="P") S NODELETE=0 ; OK to delete personal quick orders and prompts
 S DIR("B")=OLDNAME
 S DIR("?")="Enter a unique name, up to 63 characters in length."
NM I $L($P($G(^ORD(101.41,IFN,0)),U,3))>0 W !,!,"(This "_$$GETITM(IFN)_" has been disabled)"
 D ^DIR S:$D(DTOUT)!(X["^") Y="^"
 I X="@" D  G NM:X=""
 . I $D(^ORD(101.41,"AD",IFN)) W $C(7),!,"Cannot delete - currently in use!",! S X="" Q
 . I $$INUSE^ORCMEDT5(IFN) W $C(7),!,"Cannot delete - currently an Add Orders Menu!",! S X="" Q
 . I NODELETE D DISABLE(IFN) S X="" Q
 . I '$$SURE(IFN) S X="" Q  ;reask       
 . N IDX1,IDX2 S IDX1=0
 . F  S IDX1=$O(^ORD(101.44,"C",IFN,IDX1)) Q:'IDX1  D
 . . S IDX2=0
 . . F  S IDX2=$O(^ORD(101.44,"C",IFN,IDX1,IDX2)) Q:'IDX2  D
 . . . S DA=IDX2,DA(1)=IDX1,DIK="^ORD(101.44,"_IDX1_",10," D ^DIK
 . K DA S DA=IFN,DIK="^ORD(101.41," D ^DIK W "  ...deleted." S (X,Y)="@"
 I ISPQO,Y'="^",X'="@",Y'=OLDNAME D  G NM
 . W $C(7),!,"Cannot rename a personal quick order",!
 Q Y
 ;
GETITM(DLG) ;
 N ITM
 S ITM=$P($G(^ORD(101.41,DLG,0)),U,4)
 I ITM="Q",$E($P($G(^ORD(101.41,IFN,0)),U),1,6)="ORWDQ " Q "personal quick order"
 S ITM=$S(ITM="P":"prompt",ITM="D":"dialog",ITM="Q":"quick order",ITM="O":"order set",ITM="A":"action",ITM="M":"menu",1:"item")
 Q ITM
 ;
SURE(DLG) ; -- Are you sure?
 N X,Y,DIR,ITM,DA
 S ITM=$$GETITM(DLG)
 S DIR(0)="YA",DIR("A")="Are you sure you want to delete this "_ITM_"? "
 S DIR("?")="Enter YES if you want to delete this "_ITM_" from the file, or NO to quit."
 D ^DIR
 Q +Y
 ;
DISABLE(DLG) ; Disable item - return true if disabled
 N DIR,X,Y,ITM,DA,DR,DIE,DIDEL,DISABLED
 W $C(7),!,!,"Deletion not allowed outside of FileMan."
 S ITM=$$GETITM(DLG)
 S DISABLED=$L($P($G(^ORD(101.41,IFN,0)),U,3))>0
 S DIR(0)="YA"
 I DISABLED D  I 1
 . S DIR("A",1)="This "_ITM_" is already disabled."
 . S DIR("A")="Would you like to edit the disable message? "
 . S DIR("?")="Enter YES if you want to edit the disabled message, or NO to quit."
 . S DIR("B")="NO"
 E  D
 . S DIR("A")="Would you like to disable this "_ITM_"? "
 . S DIR("?")="Enter YES if you want to disable this "_ITM_", or NO to quit."
 . S DIR("B")="YES"
 D ^DIR
 I '+Y Q
 W !,"Enter disable message:"
 S DA=DLG,DR="3",DIE="^ORD(101.41,"
 D ^DIE
 Q
 ;
DTEXT(X) ; -- Enter/edit display text of prompt
 N Y,DIR
 S DIR(0)="FA^3:63",DIR("A")="TEXT OF PROMPT: " S:$L($G(X)) DIR("B")=X
 S DIR("?")="Enter the text of this prompt, including any punctuation and spaces"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
DATATYPE(X) ; -- Returns desired datatype for prompt
 N DIR,Y S DIR("A")="TYPE OF PROMPT: "
 S DIR(0)="SAM^D:date/time;R:relative date/time;F:free text;N:numeric;S:set of codes;P:pointer to a file;Y:yes/no;W:word processing;"
 S:$L($G(X)) DIR("B")=$P($P(DIR(0),X_":",2),";")
 S DIR("?")="Select the type of data to be entered at this prompt"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
DATE ; -- date parameters
 N X,Y,DIR,ORX,ORT,ORS,ORR
 S X=$P(DOMAIN,":",3),ORX=X["X",ORT=X["T",ORS=X["S",ORR=X["R",DIR(0)="YA"
 ; Still need to handle Earliest and Latest dates allowed
 S DIR("A")="CAN DATE BE IMPRECISE? ",DIR("B")=$S(ORX:"NO",1:"YES")
 D ^DIR S ORX='Y I $D(DUOUT)!($D(DTOUT)) S DOMAIN="^" Q
 S DIR("A")="CAN TIME OF DAY BE ENTERED? ",DIR("B")=$S(ORT:"YES",1:"NO")
 D ^DIR I $D(DUOUT)!($D(DTOUT)) S DOMAIN="^" Q
 S ORT=Y I 'Y S (ORS,ORR)=0 G DQ
 S DIR("A")="CAN SECONDS BE ENTERED? ",DIR("B")=$S(ORS:"YES",1:"NO")
 D ^DIR S ORS=Y I $D(DUOUT)!($D(DTOUT)) S DOMAIN="^" Q
 S DIR("A")="IS TIME REQUIRED? ",DIR("B")=$S(ORR:"YES",1:"NO")
 D ^DIR S ORR=Y I $D(DUOUT)!($D(DTOUT)) S DOMAIN="^" Q
DQ S DOMAIN="::E"_$S(ORX:"X",1:"")_$S(ORT:"T",1:"")_$S(ORS:"S",1:"")_$S(ORR:"R",1:"")
 Q
 ;
TEXT ; -- free text
 N X,Y,DIR
 S DIR(0)="NAO^1:245",DIR("A")="MINIMUM LENGTH: "
 S:+DOMAIN DIR("B")=+DOMAIN
 D ^DIR I $D(DTOUT)!($D(DUOUT)) S DOMAIN="^" Q
 S $P(DOMAIN,":")=Y,DIR("A")="MAXIMUM LENGTH: " K DIR("B")
 S:$P(DOMAIN,":",2) DIR("B")=$P(DOMAIN,":",2)
 D ^DIR I $D(DUOUT)!($D(DTOUT)) S DOMAIN="^" Q
 S $P(DOMAIN,":",2)=Y
 ; Opt pattern match ??
 Q
 ;
NMBR ; -- numeric
 N X,Y,DIR,STR
 S DIR(0)="NAO^::"_+$P(DOMAIN,":",3),DIR("A")="INCLUSIVE LOWER BOUND: ",DIR("B")=+DOMAIN ;95
 D ^DIR I $D(DTOUT)!($D(DUOUT)) S DOMAIN="^" Q
 S STR=Y,DIR(0)="NAO^"_Y_"::"_+$P(DOMAIN,":",3),DIR("A")="INCLUSIVE UPPER BOUND: ",DIR("B")=+$P(DOMAIN,":",2) ;95
 D ^DIR I $D(DTOUT)!($D(DUOUT)) S DOMAIN="^" Q
 S STR=STR_":"_Y,DIR(0)="NAO",DIR("A")="MAXIMUM NUMBER OF FRACTIONAL DIGITS: ",DIR("B")=+$P(DOMAIN,":",3) ;95
 D ^DIR I $D(DUOUT)!($D(DTOUT)) S DOMAIN="^" Q
 S DOMAIN=STR_":"_Y
 Q
 ;
PTR ; -- pointer
 I DUZ(0)="@"!($L(DOMAIN)&'DOMAIN) D ROOT Q  ; allow file root
 N X,Y,DIR,DIE,DR,FILE,STR,SCR
 S DIR(0)="PA^1:AEQM",DIR("A")="POINT TO WHICH FILE: "
 S:$L(DOMAIN) DIR("B")=$$FILENAME(+DOMAIN)
 D ^DIR I $D(DUOUT)!($D(DTOUT)) S DOMAIN="^" Q
 S FILE=+Y,STR=$P(DOMAIN,":",2) S:'$L(STR) STR="EQ"
 S DOMAIN=FILE_":"_STR
 Q
 ;
ROOT ; -- pointer via file root
 N X,Y,DIR,STR
 S DIR(0)="FA^1:100",DIR("A")="POINT TO WHICH FILE: "
 S DIR("?")="Enter the file or subfile by name, file number, or global root (without the leading '^')."
 S:$L(DOMAIN) DIR("B")=$S(+DOMAIN:$$FILENAME(+DOMAIN),1:$P(DOMAIN,":"))
RT1 D ^DIR I $D(DTOUT)!$D(DUOUT) S DOMAIN="^" Q
 I $L(DOMAIN),$L(X),X=$G(DIR("B")) S Y=$P(DOMAIN,":") G RTQ ; default
 I +Y=Y S X=$$FILENAME(+Y) I $L(X) W "   "_X G RTQ ; valid file number
 I $L(Y),+Y'=Y D  G:$D(Y) RTQ ; valid root or name
 . I "(,"[$E(Y,$L(Y)) Q:$D(@(U_Y_"0)"))  ; valid file root
 . S DIC=1,DIC(0)="EQ",X=Y D ^DIC S:Y>0 Y=+Y K:Y'>0 Y
 W $C(7),!,"Invalid file!" G RT1
RTQ S STR=$P(DOMAIN,":",2),DOMAIN=Y_":"_$S($L(STR):STR,1:"EQ")
 Q
 ;
SET ; -- set of codes
 N I,ORI,ORJ,ITEM,X,Y,ORQUIT,NEWLNG S ORJ=0
 F I=1:1:$L(DOMAIN,";") S:$P(DOMAIN,";",I)'="" ITEM(I)=$P(DOMAIN,";",I)
 S ORI=0 F  S ORI=$O(ITEM(ORI)) Q:ORI'>0  D SETEDIT Q:$G(ORQUIT)!(Y="")
 I $G(ORQUIT) S DOMAIN="^" Q
 S ORI=ORJ F  S ORI=ORI+1 D SETEDIT Q:$G(ORQUIT)!(Y="")  ; new codes
 I $G(ORQUIT) S DOMAIN="^" Q
 ; now done editing, rebuild DOMAIN
 S I=0,DOMAIN="" F  S I=$O(ITEM(I)) Q:I'>0  S NEWLNG=$L(DOMAIN)+$L(ITEM(I))+1 S:NEWLNG'>235 DOMAIN=DOMAIN_ITEM(I)_";" I NEWLNG>235 W $C(7),!,"Domain too long - unable to store all codes."  H 2 Q
 Q
SETEDIT ; -- edit each item in DOMAIN
 N DIR,TEXT,CODE S DIR(0)="FAO^1:5",DIR("A")="INTERNALLY-STORED CODE: "
 S CODE=$P($G(ITEM(ORI)),":"),TEXT=$P($G(ITEM(ORI)),":",2),ORJ=ORI
 S:$L(CODE) DIR("B")=CODE
 D ^DIR S:$D(DUOUT)!($D(DTOUT)) ORQUIT=1 Q:$G(ORQUIT)!(X="")
 I X="@" K ITEM(ORI) Q
 S CODE=X W "  WILL STAND FOR: " W:$L(TEXT) TEXT_"// "
SE1 R Y:DTIME I '$T!(Y["^") S ORQUIT=1 Q
 S:Y="" Y=TEXT I "@"[Y W $C(7),!,"  Required value!",!,"'"_CODE_"' WILL STAND FOR: " W:$L(TEXT) TEXT_"// " G SE1
 S TEXT=Y,ITEM(ORI)=CODE_":"_TEXT
 Q
 ;
OTHER ; -- no parameters needed
 S DOMAIN=""
 Q
 ;
FILENAME(FNUM) ; -- Returns name of file FNUM
 N ORY,Y D:$G(FNUM) FILE^DID(+FNUM,,"NAME","ORY")
 S Y=$G(ORY("NAME"))
 Q Y
