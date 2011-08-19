FBAACCB2 ;AISC/CMR-CLERK CLOSE BATCH ;JUN 21, 1994
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
PMNT ;displays check and cancellation information if any exist
 I $G(FBCK)]"" W !?4,">>>Check # ",FBCK I $G(FBCKDT) W "  Date Paid:  ",$$DATX^FBAAUTL(FBCKDT),$S(FBCKINT>0:"  Interest: "_$FN(FBCKINT,",",2),1:""),"<<<" D
 .I FBDIS-FBCKINT'=+A2 W !,*7,?4,">>>Amount paid altered to $ ",$FN((FBDIS-FBCKINT),",",2)," on the Fee Payment Voucher document.<<<"
 I $G(FBCANDT)>0 W !?4,">>>Check cancelled on: ",$$DATX^FBAAUTL(FBCANDT) I +FBCANR W "   Reason:  ",$P($G(^FB(162.95,+FBCANR,0)),"^"),"<<<" D
 .W !,?7,$S(FBCAN="R":"Check WILL be replaced.",FBCAN="C":"Check WILL be re-issued.",FBCAN="X":"Check WILL NOT be replaced.",1:"")
PMTCLN K FBCAN,FBCK,FBCKDT,FBCANDT,FBCANR,FBCKINT,FBDIS,FBCKIN
 Q
FBCKO(J,K,L,M) ;set outpatient check variables
 ;J,K,L,M must be defined to DA(3),DA(2),DA(1) and DA respectively
 I 'J!('K)!('L)!('M) S (FBCAN,FBCK,FBCANDT,FBCANR,FBDIS,FBCKINT,FBCKDT)="" Q
 S FBCKIN=$G(^FBAAC(J,1,K,1,L,1,M,2))
 S FBCAN=$P(FBCKIN,"^",6),FBCK=$P(FBCKIN,"^",3),FBCANDT=$P(FBCKIN,"^",4),FBCANR=$P(FBCKIN,"^",5),FBDIS=$P(FBCKIN,"^",8),FBCKINT=$P(FBCKIN,"^",9)
 S FBCKDT=$P($G(^FBAAC(J,1,K,1,L,1,M,0)),"^",14)
 K FBCKIN
 Q
