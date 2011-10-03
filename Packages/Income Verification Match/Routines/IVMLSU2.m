IVMLSU2 ;ALB/MLI/KCL - IVM SSA/SSN UPLOAD OR PURGE ENTRIES ; 07-JAN-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine contains the code to execute the mneumonics on the
 ; list manager option.  The line tag equals the mneumonic (and is
 ; followed by a line mneumonic_Q which is the kill line for the
 ; tag).
 ;
 ;
PU ; - (Action) Purge entries from list if inappropriate for uploading
 ;
 ;  Input - ^TMP("IVMLST",$J,"IDX",#,#)=pt name_pt ssn_dfn_sp ien_date of death_da(1)_da
 ;          VALMY(n)=array of selections
 ;
 S IVMOUT=0,IVMWHERE="PU"
 ;
 ; - generic selector used within a list manager action call
 D EN^VALM2($G(XQORNOD(0)),"S")
 Q:'$D(VALMY)
 S IVMENT=0 F  S IVMENT=$O(VALMY(IVMENT)) Q:'IVMENT!IVMOUT  D
 .S IVMND=$G(^TMP("IVMLST",$J,"IDX",IVMENT,IVMENT)) I IVMND']"" Q
 .S IVMNM=$P(IVMND,"^",1),IVMSSN=$P(IVMND,"^",2)
 .S IVMI=$P(IVMND,"^",6),IVMJ=$P(IVMND,"^",7)
 .W !,"Purge for patient: ",IVMNM
 .;
 .; - alert user if date of death
 .I $P(IVMND,"^",5)]"" D DOD
 .;
 .D RUSURE^IVMLSU3 I 'IVMSURE Q
 .W !,"Update SSN's for ",IVMNM
 .D DELENT^IVMLSU3
 .W " ...deleted.",!
 .S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
PUQ D QUIT
 Q
 ;
 ;
UP ; - (Action) Upload data for patient
 ;
 ;  Input - ^TMP("IVMLST",$J,"IDX",#,#)=pt name_pt ssn_dfn_sp ien_date of death_da(1)_da
 ;          VALMY(n)=array of selections
 ;
 ;
 S IVMOUT=0,IVMWHERE="UP"
 ;
 ; - generic selector used within a list manager action call
 D EN^VALM2($G(XQORNOD(0)),"S")
 Q:'$D(VALMY)
 S IVMENT=0 F  S IVMENT=$O(VALMY(IVMENT)) Q:'IVMENT!IVMOUT  D
 .S IVMND=$G(^TMP("IVMLST",$J,"IDX",IVMENT,IVMENT)) I IVMND']"" Q
 .S IVMNM=$P(IVMND,"^",1),IVMSSN=$P(IVMND,"^",2)
 .S IVMI=$P(IVMND,"^",6),IVMJ=$P(IVMND,"^",7)
 .; - get data node
 .S IVMDND=^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI,IVMJ)
 .S DFN=$P(IVMDND,"^",1),IVMSIEN=$P(IVMDND,"^",2),IVMLINE=$P(IVMDND,"^",4,99)
 .S IVMVSSN=$P(IVMLINE,"^",3),IVMSSSN=$P(IVMLINE,"^",6)
 .S IVMUP=$S(IVMVSSN&IVMSSSN:"B",IVMVSSN:"V",1:"S")
 .W !,"Update for patient: ",IVMNM
 .;
 .; - alert user if date of death
 .I $P(IVMND,"^",5)]"" D DOD
 .;
 .I IVMUP="B" D BOTH I IVMOUT Q
 .;
 .D RUSURE^IVMLSU3 I IVMOUT!'IVMSURE Q
 .D SSNUP^IVMLSU3
UPQ D QUIT
 Q
 ;
 ;
QUIT ; - Kill variables used from all protocols
 ;
 ; - reset array for display
 D INIT^IVMLSU1
 ;
 S VALMBCK=$S(IVMOUT'=2:"R",1:"Q") ; redisplay or quit if timeout
 K DFN,IVMDND,IVMENT,IVMI,IVMJ,IVMLINE,IVMND,IVMNM,IVMOUT
 K IVMSSN,IVMSSSN,IVMSURE,IVMUP,IVMVSSN,IVMWHERE
 Q
 ;
 ;
BOTH ; - Upload both ssn's?
 ;
 ;  Input - None
 ; Output - IVMUP as V for vet, S for spouse, B for both
 ;          IVMOUT = 1 for '^', 2 for time-out, 0 otherwise
 ;
 N X,Y
 S DIR("A")="Update the SSN for the 'V'eteran, 'S'pouse, or 'B'oth?",DIR(0)="SB^V:VETERAN;S:SPOUSE;B:BOTH"
 S DIR("?",1)="Answer 'V' to upload veteran SSN only, 'S' to upload spouse SSN only",DIR("?")="or 'B' to upload the SSN for both the veteran and the spouse"
 S DIR("B")="BOTH" ; default both
 D ^DIR
 S IVMOUT=$S($D(DTOUT):2,$D(DUOUT):1,$D(DIROUT):1,1:0)
 S IVMUP=$G(Y) I IVMUP="B" S IVMUP="VS"
 K DIR,DIROUT,DTOUT,DUOUT
 Q
 ;
 ;
DOD ; - Alert user of date of death reported in DHCP or from IVM Center
 ;
 W !,*7,"'Date of Death' reported for this patient "
 W $S($E($P(IVMND,"^",5))="I":"by the IVM Center",$E($P(IVMND,"^",5))="D":"in DHCP")_" as "_$$DAT2^IVMUFNC4($E($P(IVMND,"^",5),2,99))_".",!
 Q
