PRCTTI ;WISC@ALTOONA/RGY-CALCULATE TIME ;01 Jun 90/3:26 PM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;PRCTMIN=# of min. to add or sub, PRCTSD=date to add or sub from in FM format -- Answer ret. in 'Y'
 S X2=PRCTMIN\1440,HOUR=(PRCTMIN-(1440*X2))\60,MIN=(PRCTMIN-(1440*X2)-(60*HOUR))#$S(PRCTMIN<0:-60,1:60),X1=PRCTSD\1,HR=$E(PRCTSD,9,10),MI=$E(PRCTSD,11,12)
 S:$L(HR)=1 HR=HR_0 S:$L(MI)=1 MI=MI_0 S MI=MI+MIN S:MI>59 MI=MI-60,HR=HR+1
 S:MI<0 MI=MI+60,HR=HR-1 S HR=HR+HOUR S:HR>23 HR=HR-24,X2=X2+1 S:HR<0 HR=HR+24,X2=X2-1 S:HR+MI=0 X2=X2-1,HR=24,MI=0 S:HR<10 HR=0_HR S:MI<10 MI=0_MI S X=X1 D:X2 C^%DTC S X=$P(X,".") S Y=+(X_"."_HR_MI)
 ; install with verson 17.3 of fm
 K HR,MI,X1,X2,HOUR,MIN,PRCTMIN,O Q
