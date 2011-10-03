PRCPWPU1 ;WISC/RFJ-get number series for issue books                ;11 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
IBCNS(SERIES) ;  return next issue book common numbering series number
 ;  series=460-I4 where 460 is station number, 4 is fiscal year
 N %,DA,DATA,NEXT,X
 S DA=+$O(^PRC(442.6,"B",SERIES,0))
 I '$D(^PRC(442.6,DA,0)) K X S X(1)="Before performing this option you need to set up a common numbering series for "_SERIES_"." D DISPLAY^PRCPUX2(5,75,.X) Q ""
 ;
 L +^PRC(442.6,DA,0)
 S DATA=^PRC(442.6,DA,0),NEXT=$P(DATA,"^",4) I NEXT<1!(NEXT>9999) S NEXT=1
 ;
 ;  check lower and upper bounds
 I $P(DATA,"^",2)'=1 D  S $P(^PRC(442.6,DA,0),"^",2)=1
 .   S %=$S($P(DATA,"^",2)="":"<null>",1:$P(DATA,"^",2))
 .   K X S X(1)="PLEASE NOTE: The lower bound for the common numbering series "_SERIES_" should be set to 1 (not "_%_").  I will automatically make the change." D DISPLAY^PRCPUX2(5,75,.X)
 I $P(DATA,"^",3)'=9999 D  S $P(^PRC(442.6,DA,0),"^",3)=9999
 .   S %=$S($P(DATA,"^",3)="":"<null>",1:$P(DATA,"^",3))
 .   K X S X(1)="PLEASE NOTE: The upper bound for the common numbering series "_SERIES_" should be set to 9999 (not "_%_").  I will automatically make the change." D DISPLAY^PRCPUX2(5,75,.X)
 ;
 ;  check for duplicates
 I $D(^PRCP(445.2,"V",$P(SERIES,"-",2)_$E("0000",$L(NEXT)+1,4)_NEXT)) D  I 'NEXT L -^PRC(442.6,DA,0) Q ""
 .   K X S X(1)="PLEASE NOTE: The next number listed in the common numbering series "_SERIES_" is "_NEXT_" which has already been used ("_$P(SERIES,"-",2)_$E("0000",$L(NEXT)+1,4)_NEXT_")."
 .   S X(2)="Starting with "_NEXT_", I will search to 9999 and try to find a unique unused reference number.  If one cannot be found, I will start the search with number 1."
 .   D DISPLAY^PRCPUX2(5,75,.X)
 .   S NEXT=$$MISSING(NEXT)
 .   I 'NEXT S NEXT=$$MISSING(1)
 ;
 S $P(^PRC(442.6,DA,0),"^",4)=NEXT+1
 L -^PRC(442.6,DA,0)
 Q $P(SERIES,"-",2)_$E("0000",$L(NEXT)+1,4)_NEXT
 ;
 ;
MISSING(START) ;  search for missing numbers
 ;  return missing one or null if none found
 W !?5,"SEARCHING FOR A UNIQUE REFERENCE NUMBER..."
 F %=START:1:10000 Q:'$D(^PRCP(445.2,"V",$P(SERIES,"-",2)_$E("0000",$L(%)+1,4)_%))
 I %'=10000 W "  ",$P(SERIES,"-",2),$E("0000",$L(%)+1,4),%,"  IS UNIQUE" Q %
 K X S X(1)="WARNING: Unable to find an available unique reference number.  Either change the common numbering series or call your local OIFO." D DISPLAY^PRCPUX2(5,75,.X)
 Q ""
