XVEMDU ;DJB/VEDD**Groups,Required Fields [07/12/94];2017-08-15  12:23 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
GRP ;Groups
 NEW GRP,GRP1,GRP2,HD,X,Z,Z1,ZFLD,ZMULT
 S ZMULT="",HD="HD1" D GRPBLD G:FLAGG EX D INIT^XVEMDPR,HD1,GRPPRT
 G EX
GRPBLD ;
 S Z="",X=1
 F  S Z=$O(^TMP("XVV","VEDD",$J,"TMP",Z)) Q:Z=""  I $D(^DD(Z,"GR")) D
 . S GRP="" F  S GRP=$O(^DD(Z,"GR",GRP)) Q:GRP=""  S ZFLD="" F  S ZFLD=$O(^DD(Z,"GR",GRP,ZFLD)) Q:ZFLD=""  S ^TMP("XVV","VEDD",$J,"GRP",GRP,Z,ZFLD)=$P(^DD(Z,ZFLD,0),U),X=X+1 I X#9=0 W "."
 I '$D(^TMP("XVV","VEDD",$J,"GRP")) W ?30,"No Groups established." S FLAGG=1
 Q
GRPPRT ;
 S GRP="" F I=1:1 S GRP=$O(^TMP("XVV","VEDD",$J,"GRP",GRP)) Q:GRP=""!FLAGQ  W !,$J(I,3),". ",GRP D GRPPRT1
 Q
GRPPRT1 ;
 S GRP1=""
 F  S GRP1=$O(^TMP("XVV","VEDD",$J,"GRP",GRP,GRP1)) Q:GRP1=""!FLAGQ  S GRP2="" F  S GRP2=$O(^TMP("XVV","VEDD",$J,"GRP",GRP,GRP1,GRP2)) Q:GRP2=""  W ?18,$J(GRP1,6),?27,$J(GRP2,8),?39,^(GRP2),! I $Y>XVVSIZE D PAGE Q:FLAGQ
 Q
 ;====================================================================
REQ ;Required Fields
 NEW FILE,FLD,HD,LEV,PAGE,PIECE,ZDATA
 S HD="HD" D INIT^XVEMDPR,@HD,LOOP
 G EX
 ;
LOOP ;Start For Loop
 S (LEV,PAGE)=1,FILE(LEV)=ZNUM,FLD(LEV)=0 KILL ^TMP("XVV","VEDD",$J,"REQ")
 F  S FLD(LEV)=$O(^DD(FILE(LEV),FLD(LEV))) D  Q:'LEV!(FLAGQ)
 . I +FLD(LEV)=0 S LEV=LEV-1 Q
 . Q:'$D(^DD(FILE(LEV),FLD(LEV),0))  S ZDATA=^DD(FILE(LEV),FLD(LEV),0)
 . I $P($P(ZDATA,U,4),";",2)=0 S LEV=LEV+1,FILE(LEV)=+$P(ZDATA,U,2),FLD(LEV)=0 Q
 . Q:$P(ZDATA,U,2)'["R"
 . W !?1,$J(FLD(LEV),10),?14,$J(FILE(LEV),8),?25,$P(ZDATA,U)
 . I $Y>(XVVSIZE-1) D PAUSE Q:FLAGQ  W @XVV("IOF") W:$E(XVVIOST,1,2)="P-" !!! D @HD
 Q
PAUSE ;
 Q:$E(XVVIOST,1,2)="P-"  D PAUSEQE^XVEMKC(2)
 Q
PAUSE1 ;
 Q:$E(XVVIOST,1,2)="P-"  D PAUSE^XVEMKC(2)
 Q
 ;====================================================================
EX ;Exit
 KILL ^TMP("XVV","VEDD",$J,"GRP"),^TMP("XVV","VEDD",$J,"REQ")
 Q
HD ;Required Fields
 W !?1,"Required Fields..",!?2,"FLD NUM",?17,"DD",?48,"FIELD NAME"
 W !?1,"----------",?14,"--------",?25,"------------------------------------------------------"
 Q
HD1 ;Groups
 W !?5,"GROUP NAME",?20,"DD",?27,"FLD NUM",?48,"FIELD NAME",!?5,"-----------",?18,"------",?27,"--------",?39,"------------------------------",!
 Q
PAGE ;
 I FLAGP,$E(XVVIOST,1,2)="P-" W @XVV("IOF"),!!! D @HD Q
 D PAUSEQE^XVEMKC(2) Q:FLAGQ  W @XVV("IOF") D @HD
 Q
