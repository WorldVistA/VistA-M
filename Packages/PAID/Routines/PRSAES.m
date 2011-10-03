PRSAES ; HISC/REL-Electronic Signature ;3/20/92  15:54
 ;;4.0;PAID;**100**;Sep 21, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S ES=$P($G(^VA(200,DUZ,20)),"^",4),ESNAM=$P($G(^(20)),"^",2),ESCNT=0
 I ES="" W !!,"No electronic signature on file!" G E2
 I ESNAM="" W !!,"No electronic signature block on file!" G E2
E1 W !!,"Enter Signature Code: " X ^%ZOSF("EOFF") R X:60 X ^%ZOSF("EON") S:'$T X="^" I X=""!(X="^") G E2
 I X="?"!(X="??") W !,"Enter your Electronic Signature code to verify this action." G E1
 S ESCNT=ESCNT+1 D HASH^XUSHSHP I ES'=X W "  ??",*7 S X="" G E1:ESCNT<3,E2
 W "  ... signed." S ESOK=1 K X,ES,ESCNT Q
E2 S ESOK=0 W *7,"  ... Not Signed." K X,ES,ESCNT Q
