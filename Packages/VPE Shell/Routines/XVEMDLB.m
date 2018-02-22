XVEMDLB ;DJB/VEDD**Branch to Pointed-To File [11/07/94];2017-08-15  12:13 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
EN ;
 S U="^"
 S ^TMP("XVV",$J)=$$GETFILE() I ^TMP("XVV",$J)'>0 KILL ^($J) Q
 D ENDSCR^XVEMKT2
 D SYMTAB^XVEMKST("C","VEDDL",VEDDS) ;Clear symbol table
 S ZNUM=$P(^TMP("XVV",$J),U,1),ZNAM=$P(^($J),U,2),ZGL="^"_$P(^($J),U,3)
 S (FLAGE,FLAGQ,FLAGP)=0
 KILL ^TMP("XVV",$J)
 D EN^XVEMDL ;Recursive call
 D SYMTAB^XVEMKST("R","VEDDL",VEDDS) ;Restore symbol table
 Q
GETFILE() ;Return file number or zero
 NEW DATA,DD,FILE,FILENUM,FLD,GLB,I,REF,XVVX,XVVY
 S REF=$$GETREF^XVEMKTR("ID"_VEDDS) I REF="^" Q 0
 I REF="***" W $C(7) Q 0
 I '$D(^TMP("XVV","VEDD"_VEDDS,$J,REF)) Q 0
 S DATA=^(REF),FILE=$P(DATA,U,1),FLD=$P(DATA,U,2)
 I '$D(^DD(FILE,FLD,0)) Q 0
 S DD=^(0) I $P(DD,U,2)'["P",$P(DD,U,2)'["V" D MSG^XVEMDUM(1,1) Q 0
 S (XVVX,XVVY)=$P(DD,U,2) D @$S(XVVX["P":"POINTER",1:"VAR")
 I FILENUM'>0 Q 0
 I '$D(^DD(FILENUM)) D MSG^XVEMDUM(2,1) Q 0
 S GLB=$G(^DIC(FILENUM,0,"GL")) I GLB']"" D MSG^XVEMDUM(7,1) Q 0
 I $E(GLB)="^" S GLB=$E(GLB,2,999)
 Q FILENUM_"^"_$$GETNAME(FILENUM)_"^"_GLB
GETNAME(X) ;File file name
 I '$D(^DIC(X,0)) Q ""
 Q $P(^DIC(X,0),"^",1)
POINTER ;Get file number from piece 2 of data dictionary
 F I=1:1:$L(XVVX) Q:$E(XVVX,I)?1N!($E(XVVX,I)=".")  S XVVY=$E(XVVY,2,99)
 S FILENUM=+XVVY
 Q
VAR ;Variable Pointer
 NEW ANS,CHOICE,CNT,VAR,X,Y
 S FILENUM=0 I '$D(^DD(FILE,FLD,"V",0)) D MSG^XVEMDUM(3,1) Q
 D ENDSCR^XVEMKT2
 W !!?1,"VARIABLE POINTER:" S X=0,CNT=1
 F  S X=$O(^DD(FILE,FLD,"V",X)) Q:X'>0  S Y=^(X,0) D  ;
 . W !?3,CNT,". ",$P(Y,U,2)," (",$P(Y,U),")"
 . S VAR(CNT)=$P(Y,U),CNT=CNT+1
 W !
VAR1 W !?1,"Select NUMBER of your choice: "
 R ANS:XVV("TIME") S:'$T ANS="^" I "^"[ANS Q
 I '$D(VAR(ANS)) D  G VAR1
 . W !?1,"Enter number of your choice from left hand column"
 S FILENUM=VAR(ANS)
 Q
