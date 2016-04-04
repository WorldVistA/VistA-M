DDMPSM ;SFISC/DPC-IMPORT SCREENMAN CALLS ;9/20/96  10:07
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
FILESEL ;
 ; Called form Post-actin on change of Primary File prompt
 D PUT^DDSVALF("TMP_NM",1,1,"")
 I DDSOLD'="",$D(DDMPFDSL) S DDMPOLDF=DDSOLD,DDSBR="3^1^3"
 E  D
 . K DDMPCPNM,DDMPCPTH,DDMPFCAP,DDMPCF,DDMPFDNM
 . S DDMPF=X
 . S DDMPFLNM=DDSEXT
 . D UNED^DDSUTL("FLD_JUMP",1,1,$S(X:0,1:1))
 . D UNED^DDSUTL("TMP_NM",1,1,$S(X:0,1:1))
 . D REFRESH^DDSUTL
 Q
 ;
TMPLSCR(DDMPSELF,DDSEXT,DUZ) ;
 ;called from TMP_NM field.
 ;DDMPSELF = currently selected primary file.
 ;DDMPEXT  = External value of selected template.
 I $P(^(0),U,4)'=DDMPSELF Q 0
 I DUZ(0)["@" Q 1
 N DDMPRDAC,DDMPI,DDMPOK
 S DDMPRDAC=$P(^(0),U,3),DDMPOK=0
 F DDMPI=1:1:$L(DDMPRDAC) I DUZ(0)[$E(DDMPRDAC,DDMPI) S DDMPOK=1 Q
 Q DDMPOK
 ;
CHNGFILE ;
 ;Called for Post-action on pop-up file change verification page.
 I X D  ;code for changing selected file.
 . K DDMPFDSL,DDMPCPNM,DDMPCPTH,DDMPFCAP,DDMPCF,DDMPFDNM
 . S (DDMPOSET,DDMPFDCT)=0
 . S DDMPF=$$GET^DDSVALF("F_SEL",1,1)
 . S DDMPFLNM=$$GET^DDSVALF("F_SEL",1,1,"E")
 . I DDMPF="" D UNED^DDSUTL("FLD_JUMP",1,1,1),UNED^DDSUTL("TMP_NM",1,1,1)
 . S DDSBR="FLD_JUMP^1^1"
 . ;D REFRESH^DDSUTL
 E  D
 . D PUT^DDSVALF("F_SEL",1,1,DDMPOLDF,"I")
 . S DDSBR="F_SEL^1^1"
 Q
 ;
IXF ;
 ;Called from input transform of Field Selection field.
 N D0,DA,DIC,DP,Y S DIC="^DD("_DDMPCF_",",DIC(0)="ENZ" D ^DIC
 I Y'>0 K X
 E  S (X,DDMPX)=+$P(Y,"E"),DDMPFDNM=Y(0,0)
 Q
 ;
FDPROC ;
 ;Called from post-action on change of Field Selection prompt.
 N DDMP0P2
 S DDMP0P2=$P(^DD(DDMPCF,DDMPX,0),U,2)
 I +DDMP0P2 D
 . S DDSBR="FLD"
 . I 'DDMPFDCT D HLP^DDSUTL($C(7)_"You must select a field in the top level file before entering multiple.") Q
 . N DDMPI,DDMPOK
 . F DDMPI=1:1:DDMPFDCT I $P(DDMPFDSL(DDMPI),U,$L(DDMPFDSL(DDMPI),U))=DDMPCF S DDMPOK=1 Q
 . I '$G(DDMPOK) D HLP^DDSUTL($C(7)_"You must select a field in a subfile before entering one of its multiples.") Q
 . S DDMPFCAP=$$PATHNM(+DDMP0P2,DDMPFLNM)
 . S DDMPCPTH=$S($L($G(DDMPCPTH)):DDMPCPTH_":",1:"")_DDMPX_U_DDMPCF
 . S DDMPCF=+DDMP0P2
 . S DDMPCPNM=$S($L($G(DDMPCPNM)):DDMPCPNM_":",1:"")_DDMPFDNM
 E  D
 . S DDMPFDCT=DDMPFDCT+1
 . S DDMPFDSL(DDMPFDCT)=$S($L($G(DDMPCPTH)):DDMPCPTH_":",1:"")_DDMPX_U_DDMPCF
 . S DDMPFDSL("CAP",DDMPFDCT)=$S($L($G(DDMPCPNM)):DDMPCPNM_":",1:"")_DDMPFDNM
 . S DDMPOSET=$S(DDMPFDCT>9:DDMPFDCT-9,1:0)
 . S DDSBR=$S($G(DDMPSMFF("FIXED"))="YES":"LEN",1:"FLD")
 Q
 ;
PATHNM(DDMPSFNO,DDMPFLNM) ;
 N DDMPPATH S DDMPPATH=""
 I $D(^DD(DDMPSFNO,0,"UP")) F  D  Q:'$D(^DD(DDMPSFNO,0,"UP"))
 . S DDMPPATH=" : "_$P($P(^DD(DDMPSFNO,0),U),"SUB-FIELD")_"Subfile"_DDMPPATH
 . S DDMPSFNO=^DD(DDMPSFNO,0,"UP")
 Q $G(DDMPFLNM,$P(^DIC(DDMPSFNO,0),U))_DDMPPATH
 ;
UP1 ;
 ;Called from post-action on Field Selection prompt if null entered.
 S DDMPFCAP=$P($G(DDMPFCAP)," : ",1,$L($G(DDMPFCAP)," : ")-1)
 S DDMPCF=$P(DDMPCPTH,U,$L(DDMPCPTH,U))
 S DDMPCPTH=$P(DDMPCPTH,":",1,$L(DDMPCPTH,":")-1)
 S DDMPCPNM=$P(DDMPCPNM,":",1,$L(DDMPCPNM,":")-1)
 Q
 ;
DELFLD ;
 ;Called from post-action on change of the "Do you want to delete" prompt
 I DDMPFDCT=0 Q
 N DDMPL S DDMPL=$L($G(DDMPFDSL(DDMPFDCT-1)),":")
 I DDMPL=1 D
 . S DDMPCF=DDMPF
 . S DDMPFCAP=DDMPFLNM
 . S (DDMPCPNM,DDMPCPTH)=""
 E  D
 . S DDMPCF=$P(DDMPFDSL(DDMPFDCT-1),U,$L(DDMPFDSL(DDMPFDCT-1),U))
 . S DDMPFCAP=$$PATHNM(+DDMPCF,DDMPFLNM)
 . S DDMPCPTH=$P(DDMPFDSL(DDMPFDCT-1),":",1,DDMPL-1)
 . S DDMPCPNM=$P(DDMPFDSL("CAP",DDMPFDCT-1),":",1,DDMPL-1)
 K DDMPFDSL(DDMPFDCT),DDMPFDSL("CAP",DDMPFDCT),DDMPFDSL("LN",DDMPFDCT)
 S DDMPFDCT=DDMPFDCT-1
 I DDMPOSET S DDMPOSET=DDMPOSET-1
 Q
 ;
 ;
VAL ;
 ;Called from form level validation.
 N DDMPMSG
 ;1)Validate format of import.
 I (($G(DDMPSMFF("FIXED"))="YES")&($G(DDMPSMFF("FDELIM"))'=""))!(($G(DDMPSMFF("FIXED"))'="YES")&($G(DDMPSMFF("FDELIM"))="")) D  G VALERR
 . D BLD^DIALOG(1821)
 . S DDSERROR=2
 . S DDSBR="FOR_FMT^1^1"
 . D MSG^DIALOG("AE",.DDMPMSG)
 ;
 ;2) If file specified, move fields selected into DR().  Look for DIERRs created during move.
 I $G(DDMPF)]"" D
 . I $$GET^DDSVALF("TMP_NM",1,1)]"" D
 . . S DDMPFDSL=$$GET^DDSVALF("TMP_NM",1,1,"E")
 . . D TMPL2SQ^DDMP1(DDMPF,.DDMPFDSL)
 . I '$D(DDMPFDSL(1)) D  Q
 . . S DDSERROR=$G(DDSERROR)+1
 . . S DDMPMSG(DDSERROR)="You must specify some fields into which to import data."
 . . S DDSBR="FLD_JUMP^1^1"
 . K DDMPDR
 . S DDMPFDSL=1
 . N DDMPDIER S DDMPDIER=$G(DIERR)
 . D TODR^DDMP1(DDMPF,.DDMPFDSL,.DDMPDR)
 . I $G(DIERR)>DDMPDIER D
 . . S DDSERROR=$G(DDSERROR)+DIERR
 . . D MSG^DIALOG("AE",.DDMPMSG)
 . . S DDSBR="2.2^1^2"
 . . K DDMPDR
 ;
VALERR I $G(DDSERROR) D MSG^DDSUTL(.DDMPMSG) Q
 Q
 ;
FF ;
 ;Called from post-action on change of the Foreign Format field.
 N DDMPI
 I X'="" D
 . S DDMPSMFF=DDSEXT
 . S DDMPSMFF("IEN")=X
 . S DDMPSMFF("FDELIM")=$$GET1^DIQ(.44,X_",",1)
 . S DDMPSMFF("FIXED")=$$GET1^DIQ(.44,X_",",5)
 . S DDMPSMFF("QUOTED")=$$GET1^DIQ(.44,X_",",8)
 . F DDMPI="FIX","FLD_DLM","QUOTE" D
 . . D PUT^DDSVALF(DDMPI,1,1,"")
 . . D UNED^DDSUTL(DDMPI,1,1,1)
 E  D
 . K DDMPSMFF
 . F DDMPI="FIX","FLD_DLM","QUOTE" D UNED^DDSUTL(DDMPI,1,1,0)
 Q
