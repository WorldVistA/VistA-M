DDS02 ;SFISC/MKO-OVERFLOW FROM ^DDS01 ;1:50 PM  16 Jul 1999
 ;;22.0;VA FileMan;**8,11**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
UNED ;Change was made to uneditable field
 D MSG^DDSMSG("No editing allowed.",1)
 I $P($G(DDSO(0)),U,3)=2 N DDP S DDP=0
 S @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"D")=DDSOLD S:$D(DDSU("X"))#2 ^("X")=DDSU("X")
 Q
 ;
SV ;Save
 S DDACT="N"
 I $G(DDSDN)=1,DDO D ERR3^DDS3 Q
 I DDSSC'>1,'$G(DDSSEL),'$P(DDSSC(DDSSC),U,4) D S^DDS3 Q
 N DDSEM
 S DDSEM(1)="You cannot save changes at this level."
 S DDSEM(2)="To close the current page, press <PF1>C."
 D MSG^DDSMSG(.DDSEM,1)
 Q
 ;
EXT ;Process external form
 I '$P($G(DDSU("DD")),U,2),$P($G(DDSU("DD")),U,2)["P" D PT
 I $P($G(DDSO(0)),U,3)=2,$E($P($G(DDSO(20)),U))="P" D PTFO
 ;
 S:DDSOLD=Y DIR0N=1
 S DDSX=X,DDSY=Y
 I Y]"",$P($G(DDSU("DD")),U,2)["O",$G(^DD(DDP,DDSFLD,2))'?."^" K Y(0) X ^(2) S Y(0)=Y
 ;
 S DDSEXT=$G(Y(0,0),$G(Y(0),Y)),X=DDSY
 ;
 I $D(DDSO(14)) K DDSERROR X DDSO(14) I $D(DDSERROR)#2 D  Q
 . K DDSERROR,DDSY S DIR0("L")=DDSEXT,DDSCHKQ=1
 ;
 I DDSY="",DDSFLD'=.01 D  Q:'$D(DDSY)
 . N DDSREQ,DDSKEY
 . S DDSREQ=$P($G(DDSU("A")),U)
 . S:DDSREQ="" DDSREQ=$P($G(DDSO(4)),U)
 . S:DDSREQ="" DDSREQ=$P($G(DDSU("DD")),U,2)["R"
 . S DDSKEY=$D(^DD("KEY","F",DDP,DDSFLD))>0
 . I 'DDSREQ,'DDSKEY Q
 . K DDSY
 . S DDSCHKQ=1,DIR0("L")=DDSEXT
 . D MSG^DDSMSG("This is a required "_$S(DDSKEY:"key ",1:"")_"field.",1)
 ;
 S DY=$P(DIR0,U),DX=$P(DIR0,U,2)
 I DDSEXT'=DDSX D
 . X IOXY
 . S DDSX=$E(DDSEXT,1,$P(DIR0,U,3))
 . I '$P(DIR0,U,6) S DDSX=DDSX_$J("",$P(DIR0,U,3)-$L(DDSEXT))
 . E  S DDSX=$J("",$P(DIR0,U,3)-$L(DDSEXT))_DDSX
 . W $P(DDGLVID,DDGLDEL)_DDSX_$P(DDGLVID,DDGLDEL,10)
 ;
 I $G(DDSU("K")),DDSY]""!(DDSFLD'=.01) D  Q:'$D(DDSY)
 . N DDSFXR,DDSUI,DDSUNIQ,DDSVSV,DIIENS
 . D LOADXREF^DIKC1(DDP,"","",DDSU("K"),$NA(@DDSREFT@("F"))_"_","DDSFXR")
 . S:$D(@DDSREFT@("F"_DDP,DDSDA,DDSFLD,"D"))#2 DDSVSV=^("D") S ^("D")=DDSY
 . S DDSUNIQ=1,DDSUI=0
 . F  S DDSUI=$O(DDSFXR(DDP,DDSUI)) Q:'DDSUI  D  Q:'DDSUNIQ
 .. S DIIENS=DDSDA
 .. D SETXARR^DIKC(DDP,DDSUI,"DDSFXR","","D")
 .. S DDSUNIQ=$$UNIQUE^DIKK2(DDP,DDSUI,.X,.DA,"DDSFXR")
 . I 'DDSUNIQ D
 .. K DDSY
 .. S DDSCHKQ=1,DIR0("L")=DDSEXT
 .. D MSG^DDSMSG("Another entry already exists with this key value.",1)
 .. K @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"D") S:$D(DDSVSV)#2 ^("D")=DDSVSV
 ;
 D:$G(DDSDA)!'$D(DDSREP)
 . S:$D(Y(0)) @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"X")=DDSEXT
 . S @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"D")=DDSY I DDSY="",$D(DDSU("X")) S ^("X")=""
 K DDSY
 Q
 ;
PT ;Modify Y for pointer type fields
 I $P(Y,U,3)=1 D
 . S ^("ADD")=$G(@DDSREFT@("ADD"))+1,^("ADD",^("ADD"))=+Y_","_U_$P(DDSU("DD"),U,3)
 S Y=$P(Y,U)
 Q
 ;
PTFO ;Modify Y for pointer type form only fields
 I $P(Y,U,3)=1 D
 . N R,I S R=""
 . F I=1:1 Q:$D(DA(I))[0  S R=R_DA(I)_","
 . S ^("ADD")=$G(@DDSREFT@("ADD"))+1,@DDSREFT@("ADD",@DDSREFT@("ADD"))=+Y_","_R_$S($P(DDSO(20),U,3):^DIC(+$P(DDSO(20),U,3),0,"GL"),1:U_$P($P(DDSO(20),U,3),":"))
 S Y=$S(Y=-1:"",1:$P(Y,U))
 Q
