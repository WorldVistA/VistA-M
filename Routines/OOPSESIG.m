OOPSESIG ;HISC/REL-Electronic Signature ;3/30/98  16:11
 ;;2.0;ASISTS;;Jun 03, 2002
SIG(DUZ,IEN) ;
 N ES,ESOK,ESNAM,X,ESCNT
 N ESIG
 S ESIG="0^"
 S ES=$P($G(^VA(200,DUZ,20)),"^",4),ESNAM=$P($G(^(20)),"^",2),ESCNT=0
 I ES="" W !!,"No electronic signature on file!" G E2
 I ESNAM="" W !!,"No electronic signature block on file!" G E2
E1 W !!,"Enter Signature Code: " X ^%ZOSF("EOFF") R X:60 X ^%ZOSF("EON") S:'$T X="^" I X=""!(X="^") G E2
 I X["?" W !,"Enter your Electronic Signature code to verify this action." G E1
 S ESCNT=ESCNT+1 D HASH^XUSHSHP I ES'=X W "  ??",*7 S X="" G E1:ESCNT<3,E2
 W "  ... signed." S X=ESNAM,X1=DUZ,X2=IEN D EN^XUSHSHP S ESIG=DUZ_"^"_X
 D NOW^%DTC S ESIG=ESIG_"^"_% G EXIT
E2 S ESOK=0 W *7,"  ... Not Signed." G EXIT
EXIT K X,ES,ESCNT
 Q ESIG
