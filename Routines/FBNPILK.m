FBNPILK ;AISC/CLT, NPI lookup routine ;11 Apr 2006  3:02 PM
 ;;3.5;FEE BASIS;**98**;JAN 30, 1995;Build 54
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;This routine receives the IEN for the Fee Basis Vendor file (#161.2)
 ;and returns the NPI for that entry.
 ;
 ;This routine also performs a duplicate check to insure that only one vendor has
 ;a specific NPI in the FEE BASIS VENDOR file (#161.2)
 ;
EN(IEN) ;ENTRY POINT IF IEN IN FEE BASIS VENDOR FILE (#161.2) IS KNOWN
 ;The variable passed in is the IEN or DA or the entry in the FEE BASIS VENDOR
 ;file (#161.2).  Returned will be the variable FBNPI which is the NPI
 ;of the entry.  If the NPI is not entered the variable FBNPI will equal null
 ;and 10 spaces will be returned.
 ;
 N DIC,Y,FBNPI
 D:IEN=""
 .S DIC="^FBAAV(",DIC(0)="AEQM",DIC("A")="ENTER VENDOR NAME: " D ^DIC G:Y'>0 XIT
 .S IEN=+Y
 S FBNPI=$$GET1^DIQ(161.2,IEN,41.01)
 Q $S(FBNPI="":"          ",1:FBNPI)
 ;
DUP(FBNPI) ;LOOK FOR DUPLICATE ENTRIES
 ;This subroutine will review the FEE BASIS VENDOR file (#161.2) cross reference NPI to
 ;determine if the NPI entered is unique and not assigned to another entity.
 ;This subroutine takes the value of the variable X from the fileman entry into file 161.2,
 ;field 41.01 (NPI) through the input transform using the input variable of X, assigns it
 ;to the variable FBNPI and performs the lookup using the "NPIHISTORY" cross reference in the file
 ;#161.2.  If the NPI is not a duplicate entry a null value will be returned in FBRTN.  If
 ;the variable FBRTN is a number larger than zero it means the transform lookup has failed
 ;and the NPI entered is a duplicate entry.  This tag expects the variable DA to be the ien
 ;of the current entry in field name (#.01).
 ;The input transform is coded as follows: K:$L(X)>10!($L(X)<10)!('$$CHKDGT^XUSNPI(X))!($$DUP^FBNPILK(X)>0) X
 N FBLOOP,FBRTN S FBRTN=""
 S FBLOOP="" F  S FBLOOP=$O(^FBAAV("NPIHISTORY",FBNPI,FBLOOP)) Q:FBLOOP=""  S FBRTN=$G(FBLOOP) D:FBLOOP'=DA!('$D(^FBAAV("NPI",FBNPI,DA)))
 .W !,"The NPI of ",FBNPI," is now, or was in the past, assigned to: ",?47,$P(^FBAAV(FBLOOP,0),U,1)
 Q FBRTN
XIT ;EXIT AND CLEAN
 K DIC,X,Y
 Q "          "
