DG53522P ;ALB/DW - DG*5.3*522 POST-INSTALL; 6/2/2003
 ;;5.3;Registration;**522**;Aug 13, 1993
ENV ;Environment check
 S XPDABORT=""
 D PRGCHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 Q
 ;
PRGCHK(XPDABORT) ;Checks programmer variables
 I '$G(DUZ)!($G(DUZ(0))'="@") D
 . W !,$C(7),"     To insure that data dictionary changes contained in this patch"
 . W !,"     are installed correctly, DUZ(0) must be equal the ""@"" symbol!",!
 . S XPDABORT=2
 Q
