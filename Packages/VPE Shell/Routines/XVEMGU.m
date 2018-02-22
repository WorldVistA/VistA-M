XVEMGU ;DJB/VGL**Utility Routine - ZDELIM,Get File,Heading [07/29/94];2017-08-15  12:48 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
TRAN(X) ;Substitute ZDELIM with comma in subscript so I can check for $D.
 NEW ZDELIM,I,Y S ZDELIM=$C(127)_$C(124),Y=""
 F I=1:1:$L(X,ZDELIM) S Y=Y_$P(X,ZDELIM,I)_$S(I=$L(X,ZDELIM):"",1:",")
 Q Y
ZDELIM(SUB) ;Replace commas, spaces, and colons (if not between quotes) with variable ZDELIM, ZDELIM1, or ZDELIM2
 I $G(SUB)="" Q ""
 NEW CHK,NEWSUB,X,Y
 S (CHK,X)=0,NEWSUB=$P($E(SUB,1,$L(SUB)-1),"(",2,99)
 F  S X=X+1 Q:$E(NEWSUB,X)=""  S:$E(NEWSUB,X)="""" CHK=CHK=0 I 'CHK D
 . S Y=$E(NEWSUB,X)
 . S Y=$S(Y=",":ZDELIM,Y=" ":ZDELIM1,Y=":":ZDELIM2,1:"QUIT")
 . Q:Y="QUIT"  S NEWSUB=$E(NEWSUB,1,X-1)_Y_$E(NEWSUB,X+1,99),X=X+1
 . Q
 Q NEWSUB
GETFILE ;Select global by entering file name or number
 NEW DIC,GLOBAL,X,Y
 I '$D(^DIC)!('$D(^DD)) D  S ZGL="" D PAUSE^XVEMKC(2) Q
 . W $C(7),!!?1,"VA Filemanager is not in this UCI."
 I $G(FLAGPRM)="VGL" S DIC(0)="QEM",X=ZGL
 E  S DIC(0)="QEAM"
 S DIC="^DIC(" D ^DIC I Y<0 D  S ZGL="" Q
 . Q:$G(FLAGPRM)'="VGL"
 . W !!?1,"First parameter is not a valid file name/number."
 . D PAUSE^XVEMKC(2)
 S GLOBAL=$G(^DIC(+Y,0,"GL")) I GLOBAL="" D  S ZGL="" Q
 . W $C(7),!!?1,"^DIC(",+Y,",0,""GL"") is not defined."
 . D PAUSE^XVEMKC(2)
GETFILE1 W !?13,"Global ",GLOBAL,"//"
 R ZGL:XVV("TIME") S:'$T ZGL="^" S:ZGL="" ZGL=GLOBAL I ZGL="^" S ZGL=""
 I $E(ZGL)="?" D  G GETFILE1
 . W !?1,"Enter <RETURN> for default global, or a new global of your choice. Enter"
 . W !?1,"<SPACE> to select up to 10 entries from the default global, for viewing."
 I ZGL=" " NEW CNT S (DIC,ZGL)=GLOBAL,DIC(0)="QEAM" D  ;
 . F CNT=1:1:10 D ^DIC Q:Y<0  S ZGL=ZGL_$S(CNT=1:"",1:" ")_+Y
 Q
GLBLIST(GLB) ;List globals
 NEW CNT,DATA,DOTS,FLAG1ST,FLAGQ,SUB,X
 I $G(GLB)']""!($G(GLB)'?1.E1"*") Q ""
 S GLB=$TR(GLB,"*") S:$E(GLB)'="^" GLB="^"_GLB
 S:GLB["(" GLB=$P(GLB,"(",1)
 I GLB'?1"^".1"%"1A.AN W !!?1,"Global name invalid" Q ""
 S (FLAG1ST,FLAGQ,X)=0,CNT=1,$P(DOTS,".",20)="" KILL ^TMP("XVV",$J)
 F  S X=$O(@GLB@(X)) Q:X=""  D  Q:FLAGQ
 . S SUB=X I +SUB'=SUB S SUB=""""_SUB_"""" ;Alpha
 . S DATA=$S($D(@GLB@(X,0))#2:$P(^(0),"^",1),$D(@GLB@(X))#2:$E(^(X),1,49),1:"")
 . W:'FLAG1ST @XVV("IOF") S FLAG1ST=1
 . W !,$J(CNT,4)_". "_GLB_"("_SUB_" "_$E(DOTS,1,20-$L(SUB)-$L(GLB))_": "_DATA
 . S ^TMP("XVV",$J,CNT)=GLB_"("_SUB,CNT=CNT+1
 . I $Y>(XVV("IOSL")-5) D PAUSEQ^XVEMKC(2) W:'FLAGQ @XVV("IOF")
 I '$D(^TMP("XVV",$J)) W !!?1,"No data" Q ""
 W !
GLBLIST1 W !,"Enter NODE Number: " R CNT:XVV("TIME") S:'$T CNT="^"
 I "^"[CNT KILL ^TMP("XVV",$J) Q ""
 I '$D(^TMP("XVV",$J,CNT)) D  G GLBLIST1
 . W !,"Enter number of your choice from left hand column."
 S GLB=^TMP("XVV",$J,CNT) KILL ^TMP("XVV",$J)
 Q GLB
HD ;Heading
 I $G(FLAGVPE)["VEDD" Q  ;Global Lister called by VEDD
 I $G(FLAGVPE)["VRR" Q  ;Global Lister called by VRR
 I XVVT("STATUS")["HEADING" Q  ;Only do heading when starting over
 S $P(XVVT("STATUS"),"^",3)="HEADING"
 W !!?1,"VGL . . . Victory Global Lister . . . . . . . . . . . . . . . . David Bolduc"
 W !?1,"<SPACE>=File Name/Number   Global*=List   ?=Help"
 Q
