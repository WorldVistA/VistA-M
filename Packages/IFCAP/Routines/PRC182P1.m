PRC182P1 ;FW/RB-PRE INSTALL PRC*182 TO FLAF FILE ^PRC(441.2) DELTED CODES WITH '*' ;4-26-94/3:45 PM
V ;;5.1;IFCAP;**182**;Oct 20, 2000;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
START ;PRC*5.1*182 Order through file 441.2 looking for DELETED
 ;            where piece 4 = 'D'.  For each deleted code
 ;            will kill the current code 'B" x-ref and add
 ;            new 'B' x-ref with '*' concatenated with code
 ;            to signify deleted code which can no longer be
 ;            pulled in search.  Also, did the same thing 
 ;            'D' x-ref for brief description to insure user
 ;            cannot pull old description during search.
 ;
 K ^XTMP("PRC182P1")
 D NOW^%DTC S PRCSTART=%
 S ^XTMP("PRC182P1","START DELETE FLAG")=PRCSTART
 S ^XTMP("PRC182P1","END DELETE FLAGP")="RUNNING"
 S ^XTMP("PRC182P1",0)=$$FMADD^XLFDT(PRCSTART,180)_"^"_PRCSTART
 S U="^",PRCT1=0,PRCIEN=0
1 F  S PRCIEN=$O(^PRC(441.2,PRCIEN)) Q:'PRCIEN  D
 . S PRCR0=^PRC(441.2,PRCIEN,0) Q:$P(PRCR0,U,4)'="D"
 . S PRCT1=PRCT1+1
 . K ^PRC(441.2,"B",$P(PRCR0,U),PRCIEN) S ^PRC(441.2,"B","*"_$P(PRCR0,U),PRCIEN)=""
 . S PRCBDCP=$E($P(PRCR0,U,2),1,30)
 . K ^PRC(441.2,"D",PRCBDCP,PRCIEN) S ^PRC(441.2,"D","*"_$E(PRCBDCP,1,29),PRCIEN)=""
 D NOW^%DTC S PRCEND=%
 S ^XTMP("PRC182P1","END DELETE FLAG")=PRCEND
 S ^XTMP("PRC182P1","TOTAL DELETE FLAGS")=PRCT1
 K %,PRCSTART,PRCEND,PRCT1,PRCIEN,PRCR0,PRCBDCP
 Q
