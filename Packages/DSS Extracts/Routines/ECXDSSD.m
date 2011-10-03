ECXDSSD ;ALB/JAP - Derive DSS Department code ;July 16, 1998
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;
DERIVE(ECXSVC,ECXPUNIT,ECXDIV,ECXSUF) ;entry point for extrinsic function
 ; input
 ; ECXSVC = null or pointer to file #730; required
 ; ECXPUNIT = null or pointer to file #729; required
 ; ECXDIV = null or pointer to file #727.3; required
 ; ECXSUF = null or character string; optional
 ; output
 ; DSSDEPT = dss department code as ABBCxxx or null
 ;           A=DSS CODE from file (#730)
 ;          BB=DSS PRODUCTION UNIT CODE from file (#729)
 ;           C=DSS DIVISION IDENTIFIER from file (#727.3)
 ;         xxx=suffix of not more than three characters (optional)
 ;
 N DSSDEPT
 S DSSDEPT=""
 Q:'$D(ECXSVC) DSSDEPT Q:'$D(ECXPUNIT) DSSDEPT Q:'$D(ECXDIV) DSSDEPT
 D GETDIV(.ECXDIV)
 I ECXDIV="" Q DSSDEPT
 D GETSVC(.ECXSVC)
 I ECXSVC="" Q DSSDEPT
 D GETPUNIT(.ECXPUNIT)
 I ECXPUNIT="" Q DSSDEPT
 S DSSDEPT=ECXSVC_ECXPUNIT_ECXDIV
 ;if variable ecxsuf does not exist, then do nothing
 ;if variable ecxsuf is null, then assume user interaction for entry
 ;if variable suffix is a character string, then assume no user interaction; validate ecxsuf
 I $D(ECXSUF) D
 .D GETSUF(.ECXSUF)
 .S DSSDEPT=DSSDEPT_ECXSUF
 Q DSSDEPT
 ;
GETDIV(ECXDIV) ;get division portion of dss dept code
 ; input
 ; ECXDIV = pointer to file #40.8 or null; required; passed by reference
 ; output
 ; ECXDIV = dss division identifier or null
 N ECX,USER,DIC,DR,DIQ,DA,X,Y,DTOUT,DUOUT,JJ,SS
 S USER=0
 I ECXDIV="" D  Q:$D(DTOUT)!($D(DUOUT))!(+Y<1)
 .W !!
 .S USER=1
 .S DIC(0)="AEMQZ",DIC="^ECX(727.3," D ^DIC
 .S:+Y>0 ECXDIV=+Y Q
 S DIC="^ECX(727.3,",DR="1;",DIQ(0)="E",DIQ="ECX",DA=ECXDIV
 D EN^DIQ1
 S ECXDIV=$G(ECX(727.3,ECXDIV,1,"E"))
 I ECXDIV="",USER=1 D
 .W !!,"The selected division does not yet have a"
 .W !,"DSS Identifier code defined.",!
 .W !,"Use the Enter/Edit DSS Division Identifier option"
 .W !,"to associate a DSS identifier with this division.",!
 .I $E(IOST)="C" D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" W ! D ^DIR K DIR W !
 Q
 ;
GETSVC(ECXSVC) ;get service portion of dss dept code
 ; input
 ; ECXSVC = pointer to file #730 or null; required; passed by reference
 ; output
 ; ECXSVC = dss service code or null
 N ECX,USER,DIC,DR,DIQ,X,Y,JJ,SS,DA,DTOUT,DUOUT
 S USER=0
 I ECXSVC="" D  Q:$D(DTOUT)!($D(DUOUT))!(+Y<1)
 .W !!
 .S USER=1
 .S DIC(0)="AEMQZ",DIC="^ECC(730," D ^DIC
 .S:+Y>0 ECXSVC=+Y
 S DIC="^ECC(730,",DR="3;",DIQ(0)="E",DIQ="ECX",DA=ECXSVC
 D EN^DIQ1
 S ECXSVC=$G(ECX(730,ECXSVC,3,"E"))
 I ECXSVC="",USER=1 D
 .W !!,"The selected National Service does not have a"
 .W !,"DSS Clinical Service code defined.",!
 .W !,"It cannot be used in a DSS Department code.",!
 .I $E(IOST)="C" D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" W ! D ^DIR K DIR W !
 Q
 ;
GETPUNIT(ECXPUNIT) ;get production unit portion of dss dept code
 ; input
 ; ECXPUNIT = pointer to file #729 or null; required; passed by reference
 ; output
 ; ECXPUNIT = dss production unit code or null
 N ECX,DIC,DR,DIQ,X,Y,DTOUT,DUOUT,DA
 I ECXPUNIT="" D  Q:$D(DTOUT)!($D(DUOUT))!(+Y<1)
 .W !!
 .S DIC(0)="AEMQZ",DIC="^ECX(729," D ^DIC
 .S:+Y>0 ECXPUNIT=+Y
 S DIC="^ECX(729,",DR=".01;",DIQ(0)="E",DIQ="ECX",DA=ECXPUNIT
 D EN^DIQ1
 S ECXPUNIT=$G(ECX(729,ECXPUNIT,.01,"E"))
 Q
 ;
GETSUF(ECXSUF) ;get suffix portion of dss dept code
 ; input
 ; ECXSUF = character string or null; required; passed by reference
 ; output
 ; ECXSUF = character string or null;
 ;          input character string will be returned as null
 N USER,AGAIN,LEN,ZERO,OUT,DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;ask user for input only if ecxsuf="", otherwise assume no user interaction
 ;variable user acts as a flag --> if =1, then assume user interaction
 S USER=0 S:ECXSUF="" USER=1,AGAIN=0
 ;variable again acts as a flag --> if =1, don't ask user if he wants to enter suffix 
 D SUF2
 Q
SUF2 ;ask user for input if necessary, then validate variable ecxsuf
 I USER=1 D
 .I AGAIN=0 D  Q:$D(DIRUT)!(Y=0)
 ..W !!
 ..S DIR(0)="YA",DIR("A")="Do you want to enter a suffix? ",DIR("B")="NO" K X,Y
 ..D ^DIR K DIR
 .W !!
 .S AGAIN=0
 .S DIR(0)="FA^1:3",DIR("A")="Enter suffix: " K X,Y
 .D ^DIR K DIR
 .Q:$D(DIRUT)  Q:(X="^")&(Y="^")
 .S ECXSUF=Y,LEN=$L(ECXSUF)
 .I ECXSUF["-" D
 ..I $L(ECXSUF)=1 W !!,"Invalid ...try again." S ECXSUF="",AGAIN=1 Q
 ..I $E(ECXSUF,1)'="-" D  Q
 ...W !!,"The hyphen character < - > is only allowed as the"
 ...W !!,"1st character in the suffix.",!
 ...W !,"Try again...",!
 ...S ECXSUF="",AGAIN=1
 ..W !!,"The hyphen character < - > should not be used unless this"
 ..W !,"DSS Department code was previously established in DSS/Austin."
 ..W !
 ..S DIR(0)="YA",DIR("A")="Do you want to remove the hyphen? ",DIR("B")="YES" K X,Y
 ..D ^DIR K DIR
 ..S:($D(DIRUT))!(Y=1) ECXSUF="" S:(Y=1) AGAIN=1
 .Q:AGAIN=1
 .S ZERO=0
 .F I=1:1:LEN S X=$E(ECXSUF,I) D  Q:AGAIN=1
 ..Q:X="-"&(I=1)
 ..I X?1P D  Q:AGAIN=1
 ...W !!,"There is an invalid punctuation character < "_X_" > in the suffix.",!
 ...W !,"Try again...",!
 ...S ECXSUF="",AGAIN=1
 ..I X?1L D  Q:AGAIN=1
 ...W !!,"There is an invalid lowercase character < "_X_" > in the suffix.",!
 ...W !,"Try again...",!
 ...S ECXSUF="",AGAIN=1
 ..S:X="0" ZERO=ZERO+0 S:X'="0" ZERO=ZERO+1
 .Q:AGAIN=1
 .I ZERO=0 D
 ..W !!,"There are too many zeroes in the suffix.",!
 ..W !,"Try again...",!
 ..S ECXSUF="",AGAIN=1
 I USER=1,AGAIN=1 G SUF2
 ;no user interaction; validate ecxsuf
 I USER=0,ECXSUF]"" D
 .S (ZERO,OUT)=0
 .S LEN=$L(ECXSUF) I LEN>3 S ECXSUF="" Q
 .F I=1:1:LEN S X=$E(ECXSUF,I) D  Q:OUT=1
 ..I X="-",I'=1 S ECXSUF="",OUT=1
 ..I X?1P,X'="-" S ECXSUF="",OUT=1
 ..I X?1L S ECXSUF="",OUT=1
 ..S:X="0" ZERO=ZERO+0 S:X'="0" ZERO=ZERO+1
 .I ZERO=0 S ECXSUF=""
 Q
 ;
DECODE ;allow user to decode a dss department code
 N CODE,DESC,OUT,DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !!,"You may enter a DSS Department as 'ABBC' (no suffix)."
 W !,"The code will be 'translated' into a description and displayed.",!!
 S OUT=0
 F  D  Q:OUT=1  Q:$D(DIRUT)
 .S DIR(0)="FA^4:4",DIR("A")="Enter a DSS Department code: " K X,Y
 .D ^DIR K DIR
 .Q:$D(DIRUT)  Q:(X="^")&(Y="^")
 .S CODE=Y D REVERSE(CODE,.DESC)
 .W !
 .W !?5,"Service ",?20,"<"_$E(CODE,1)_">  = "_$P(DESC,U,1)
 .W !?5,"Prod. Unit ",?20,"<"_$E(CODE,2,3)_"> = "_$P(DESC,U,2)
 .W !?5,"Division ",?20,"<"_$E(CODE,4)_">  = "_$P(DESC,U,3)
 .W !
 .S DIR(0)="YA",DIR("A")="Another one? ",DIR("B")="YES" K X,Y
 .D ^DIR K DIR
 .I Y=0 S OUT=1
 Q
 ;
REVERSE(ECXDEPT,ECXDESC) ;get dss dept code description
 ; input
 ; ECXDEPT = dss dept code as ABBCxxx; required
 ; output
 ; ECXDESC = code description; passed by reference
 ;           service_name^prod_unit_long_desc^division_name/station number
 ;           note: if suffix (xxx) is present, it is ignored because free text
 N SVC,PUNIT,DIV
 Q:$L(ECXDEPT)<4
 S SVC=$E(ECXDEPT,1),PUNIT=$E(ECXDEPT,2,3),DIV=$E(ECXDEPT,4)
 K X,ECXERR S X=$$FIND1^DIC(730,,"X",SVC,"C",,"ECXERR")
 S SVC=$S(X>0:$P(^ECC(730,X,0),U,1),X=0:"Not found",X="":"Error",1:"")
 K X,ECXERR S X=$$FIND1^DIC(729,,"X",PUNIT,"B",,"ECXERR")
 S PUNIT=$S(X>0:$P(^ECX(729,X,0),U,3),X=0:"Not found",X="":"Error",1:"")
 K X,ECXERR S X=$$FIND1^DIC(727.3,,"X",DIV,"C",,"ECXERR")
 S DIV=$S(X>0:$P(^DG(40.8,X,0),U,1)_"/"_$P(^(0),U,2),X=0:"Not found",X="":"Error",1:"")
 S ECXDESC=SVC_U_PUNIT_U_DIV
 Q
