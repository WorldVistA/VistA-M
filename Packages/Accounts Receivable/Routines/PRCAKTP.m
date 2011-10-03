PRCAKTP ;WASH-ISC@ALTOONA,PA/CMS-AR PURGE TEMP ARCHIVE FILE ;6/4/93  11:05 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW STAT,%
 I $P($G(^PRCAK(430.8,0)),U,3)'>0 W !!,*7,"  The temporary storage file does not have data!",! G Q
 W !!,"This option will purge the data in the temporary storage file",!,"(AR Archive File 430.8).  Please coordinate the use of this option",!,"with IRM to make sure the PRCAK global is placed."
 S STAT=$O(^PRCA(430.3,"AC",114,0))
 I $O(^PRCA(430,"AC",STAT,0)) W !!,*7,"WARNING:  There are records remaining in the PENDING ARCHIVE status.",!,?10,"Remember to build this file again later."
 W !!,"Ready to purge 'NOW'" S %=2 D YN^DICN I %'=1 G Q
 D PUR
 W !!,?5,"Temporay Storage File is empty."
Q Q
PUR ;
 N TGLO
 L +^PRCAK("PRCAK"):1 I '$T D BUSY^PRCAKS("Kill Temporary Storage File") Q
 S TGLO=^PRCAK(430.8,0) K ^PRCAK(430.8) S ^PRCAK(430.8,0)=$P(TGLO,"^",1,2)_"^"
 L -^PRCAK("PRCAK")
 Q
