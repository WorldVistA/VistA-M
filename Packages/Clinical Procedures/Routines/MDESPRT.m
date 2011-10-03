MDESPRT ;HOIFO/NCA - ELECTRONIC SIGNATURE PRINT ;12/21/04  09:24
 ;;1.0;CLINICAL PROCEDURES;**5**;Apr 01, 2004;Build 1
GETHDR(RESULTS,MDDP) ; Get Legal Header for Report Text
 K ^TMP("MDTMP",$J) N MDC,MDFCHK,MDFT,MDS5,MDS6,X3,Y S (MDFCHK,MDFT)=0
 N MCSTAT,TEMP,CODE,CREATION,FNAME,FT,FTYPE,NAME,NUM,TT,VERSION S MDC=7
 S ^TMP("MDTMP",$J,1)="****************************************************************"
 S ^TMP("MDTMP",$J,2)="This information was imported from the Medicine Package software"
 S ^TMP("MDTMP",$J,3)="and does not include an electronic signature; therefore, it is"
 S ^TMP("MDTMP",$J,4)="being administratively closed and should be used as information"
 S ^TMP("MDTMP",$J,5)="only."
 S ^TMP("MDTMP",$J,6)="****************************************************************"
 S ^TMP("MDTMP",$J,7)=""
 S MDS5=$P($P($G(MDDP),";",2),","),MDS5=+$P(MDS5,"(",2),MDS6=+MDDP
 I $P($G(^MCAR(MDS5,MDS6,"ES")),U,7)=""!($P($G(^MCAR(MDS5,MDS6,"ES")),U,7)="RNV") S ^TMP("MDTMP",$J,8)="                          CONVERTED ARCHIVED REPORT",MDC=MDC+1
 F X3=0:0 S X3=$O(@RESULTS@(X3)) Q:'X3  D  Q:+MDFCHK
 .I $P($G(^MCAR(MDS5,MDS6,"ES")),U,7)="RNV"&($G(@RESULTS@(X3))["R e l e a s e   S t a t u s") S MDFCHK=1 Q
 .S MDC=MDC+1,^TMP("MDTMP",$J,MDC)=$G(@RESULTS@(X3))
 S TEMP=$G(^MCAR(MDS5,MDS6,"ES"))
 I $P(TEMP,U,7)=""!($P(TEMP,U,7)="RNV") S MDFT=1
 I +MDFT<1 K ^TMP($J) M ^TMP($J)=^TMP("MDTMP",$J) K ^TMP("MDTMP",$J) Q
 I $P(TEMP,U,7)="RNV"&($G(^TMP("MDTMP",$J,MDC))[" - -") K ^TMP("MDTMP",$J,MDC) S MDC=MDC-1
 S $P(TEMP,U,15)=DT
 ; Retrieve RC/ES Field (NA = Dont need)
 S NAME="^^^^^^CODE^^^^^^^^CREATION",FTYPE="^^^^^^F^^^^^^^^D"
 F TT=7,15 D
 .S Y=$P(TEMP,U,TT),FT=$P(FTYPE,U,TT),FNAME=$P(NAME,U,TT)
 .I Y S:FT="D" @FNAME=+$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E((1700+$E(Y,1,3)),3,4) S:FT="F" @FNAME=Y
 S MCSTAT="CONVERTED ARCHIVED REPORT"
 S NUM=1
 S VERSION=NUM_" of "_NUM
 S $P(SS," -",40)="" S MDC=MDC+1,^TMP("MDTMP",$J,MDC)=""
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)=""
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)=""
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)=SS K SS
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)=$J(" ",18)_"R e p o r t   R e l e a s e   S t a t u s"
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)=""
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)="Current "
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)="Report  "_$J(" ",51)_"Date of    Report"
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)="Status  "_$J(" ",51)_" Entry     Version"
 S $P(SS,"=",80)="",MDC=MDC+1,^TMP("MDTMP",$J,MDC)=SS K SS
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)=MCSTAT
 S MDC=MDC+1,^TMP("MDTMP",$J,MDC)=$J(" ",59)_CREATION_"    "_VERSION
 K ^TMP($J) M ^TMP($J)=^TMP("MDTMP",$J) K ^TMP("MDTMP",$J)
 Q
