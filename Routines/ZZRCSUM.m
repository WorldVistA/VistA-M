ZZRCSUM	;EIE/HSED/mw - adhoc routine checksum comparison utility; 08/13/09
	;;1.5;EIE/HSED Research Utility; August 04, 2009
	;
	; menu...
	F  D  Q:$D(DIRUT)
	.W !!,"Routine Set Checksum Comparison Utility"
	.W !,"This configuration is: ",$P($ZU(86),"*",2)
	.W !,"This UCI is          : ",$ZU(5)
	.S DIR(0)="NAO^1:4"
	.S DIR("A")="Select OPTION NUMBER: "
	.S DIR("A",1)=" [1] Build Master Routine Set"
	.S DIR("A",2)=" [2] Build Comparison Routine Set"
	.S DIR("A",3)=" [3] Report Comparison Results"
	.S DIR("A",4)=" [4] Exit"
	.S DIR("A",5)=" "
	.S DIR("?")="^D HELP^ZZRCSUM"
	.W !
	.D ^DIR K DIR Q:$D(DIRUT)
	.I Y=4 S DIRUT=1 Q
	.S ZZOPT=Y
	.I ZZOPT=1 D GETBASE
	.I ZZOPT=2 D GETCOMP
	.I ZZOPT=3 D REPORT
	.K ZZOPT
	K DIRUT,DTOUT,X,Y,ZZOPT
	Q
	;
GETBASE	; collect master routine set...
	N DIRUT,DTOUT,X,Y
	I $D(^XTMP("HSED","MASTER_RSET")) D  I $D(DIRUT) Q
	.W !!,"CAUTION!"
	.W !,"The baseline routine set global appears to be already"
	.W !,"set in this UCI.  If you continue, I will delete the"
	.W !,"existing baseline routine set global."
	.S DIR(0)="YA"
	.S DIR("A")="Are you sure you wish to continue (Y/N)? "
	.W !
	.D ^DIR K DIR Q:$D(DIRUT)
	.I Y=0 D  Q
	..W !,"build of master routine set aborted"
	..S DIRUT=1
	; okay to continue...
	W !!,"Step 1: Initial routine selection"
	X ^%ZOSF("RSEL")
	I +$G(^UTILITY($J,0))=0 W !!,"No routines were found in this UCI!" Q
	;
	; move routine set to ^XTMP("HSED","MASTER_RSET",...), screening out Cache
	; routines beginning with "%SYS."...
	I $G(^XTMP("HSED",0))="" S ^XTMP("HSED",0)="3100101^3100101^HSED Research Utility"
	K ^XTMP("HSED","MASTER_RSET")
	; set initial routine count...
	S ^XTMP("HSED","MASTER_RSET",0)=+$G(^UTILITY($J,0))
	W !!,"Step 2: Create master routine set"
	W !,"Creating master routine set in ^XTMP(""HSED"",""MASTER_RSET"")."
	W !,"Note:  screening out %SYS.* routines, and verifying routines in the"
	W !,"       initial selection list actually exist in this UCI.  The routine"
	W !,"       count after this procedure may be different than reported above."
	S ROU="",RCT=+$G(^XTMP("HSED","MASTER_RSET",0))
	F  S ROU=$O(^UTILITY($J,ROU)) Q:ROU=""  D
	.I $E(ROU,1.5)="%SYS." S RCT=RCT-1 Q
	.S X=ROU
	.X ^%ZOSF("TEST")
	.I '$T S RCT=RCT-1 Q
	.S ^XTMP("HSED","MASTER_RSET",ROU)=""
	W !,"After screening and verifying, routine count = ",RCT
	S ^XTMP("HSED","MASTER_RSET",0)=RCT
	K RCT,ROU,^UTILITY($J)
	W !!,"Step 3: Compute checksums"
	W !,"Computing checksums for ",+$G(^XTMP("HSED","MASTER_RSET",0))," routines",!
	D CHKSUM("MASTER_RSET")
	W !,"All done."
	Q
	;
GETCOMP	; collect comparison routine set...
	N DIRUT,DTOUT,X,Y
	I $D(^XTMP("HSED","COMPARE_RSET")) D  I $D(DIRUT) Q
	.W !!,"CAUTION!"
	.W !,"The comparison routine set global appears to be already"
	.W !,"set in this UCI.  If you continue, I will delete the"
	.W !,"existing comparison routine set global."
	.S DIR(0)="YA"
	.S DIR("A")="Are you sure you wish to continue (Y/N)? "
	.W !
	.D ^DIR K DIR Q:$D(DIRUT)
	.I Y=0 D  Q
	..W !,"build of comparison routine set aborted"
	..S DIRUT=1
	; okay to continue...
	W !!,"Step 1: Initial routine selection"
	X ^%ZOSF("RSEL")
	I +$G(^UTILITY($J,0))=0 W !!,"No routines were found in this UCI!" Q
	;
	; move routine set to ^XTMP("HSED","COMPARE_RSET",...), screening out Cache
	; routines beginning with "%SYS."...
	I $G(^XTMP("HSED",0))="" S ^XTMP("HSED",0)="3100101^3100101^HSED Research Utility"
	K ^XTMP("HSED","COMPARE_RSET")
	; set initial routine count...
	S ^XTMP("HSED","COMPARE_RSET",0)=+$G(^UTILITY($J,0))
	W !!,"Step 2: Create comparison routine set"
	W !,"Creating comparison routine set in ^XTMP(""HSED"",""COMPARE_RSET"")."
	W !,"Note:  screening out %SYS.* routines, and verifying routines in the"
	W !,"       initial selection list actually exist in this UCI.  The routine"
	W !,"       count after this procedure may be different than reported above."
	S ROU="",RCT=+$G(^XTMP("HSED","COMPARE_RSET",0))
	F  S ROU=$O(^UTILITY($J,ROU)) Q:ROU=""  D
	.I $E(ROU,1.5)="%SYS." S RCT=RCT-1 Q
	.S X=ROU
	.X ^%ZOSF("TEST")
	.I '$T S RCT=RCT-1 Q
	.S ^XTMP("HSED","COMPARE_RSET",ROU)=""
	W !,"After screening and verifying, routine count = ",RCT
	S ^XTMP("HSED","COMPARE_RSET",0)=RCT
	K RCT,ROU,^UTILITY($J)
	W !!,"Step 3: Compute checksums"
	W !,"Computing checksums for ",+$G(^XTMP("HSED","COMPARE_RSET",0))," routines",!
	D CHKSUM("COMPARE_RSET")
	W !,"All done."
	Q
	;
REPORT	; report comparison results...
	W !!,"Routine Set Checksum Comparison -- Results"
	N CCT,MCT,NIMCT,RCT
	S CCT=+$G(^XTMP("HSED","COMPARE_RSET",0))
	S MCT=+$G(^XTMP("HSED","MASTER_RSET",0))
	W !!,"Routine count in MASTER  = ",$J(MCT,10)
	W !,"Routine count in COMPARE = ",$J(CCT,10)
	W !,"Difference               = ",$J($$DIFF(MCT,CCT),10)
	;
	; first pass -- use "MASTER_RSET" and check to see that all routines
	; in the master are present in the compare...
	W !!,"Verifying all MASTER SET routines are present in COMPARE SET."
	W !,"Routines listed below are in the MASTER SET, but NOT in the"
	W !,"COMPARE SET...",!
	S ROU=" ",RCT=0
	F  S ROU=$O(^XTMP("HSED","MASTER_RSET",ROU)) Q:ROU=""  D
	.I $D(^XTMP("HSED","COMPARE_RSET",ROU)) Q
	.W ROU,?$X+(10-$L(ROU))
	.I $X>70 W !
	.S RCT=RCT+1
	W !!,RCT," routine",$S(RCT=0:"s",RCT>1:"s",1:"")," in the MASTER SET were NOT found in the COMPARE SET."
	K RCT,ROU
	;
	W !!,"Comparing checksums:  COMPARE SET to MASTER SET..."
	S ROU=" ",(NIMCT,RCT)=0
	F  S ROU=$O(^XTMP("HSED","COMPARE_RSET",ROU)) Q:ROU=""  D
	.I '$D(^XTMP("HSED","MASTER_RSET",ROU)) D  Q
	..;W !,ROU,?12,"--",?24,"not in MASTER SET"
	..S NIMCT=NIMCT+1
	.S CVAL=^XTMP("HSED","COMPARE_RSET",ROU)
	.S MVAL=^XTMP("HSED","MASTER_RSET",ROU)
	.I CVAL=MVAL K CVAL,MVAL Q
	.W !!,"Routine",?12,"Master Set",?24,"Compare Set"
	.W !,ROU,?12,MVAL,?24,CVAL
	.W !,"First 2 lines of master routine:"
	.F I=1:1:2 W !,$G(^XTMP("HSED","MASTER_RSET",ROU,I))
	.W !,"First 2 lines of ompare routine:"
	.F I=1:1:2 W !,$G(^XTMP("HSED","COMPARE_RSET",ROU,I))
	.S RCT=RCT+1
	.K CVAL,MVAL
	K ROU
	W !!,"Summary"
	I RCT>0 W !!,RCT," routines with different checksums than the MASTER SET were found."
	I RCT=0 W !!,"No checksum differences were found."
	I NIMCT>0 W !,NIMCT," routines in this UCI were not found in the MASTER SET."
	I NIMCT=0 W !,"Both MASTER and COMPARE contain the same routines -- the sets are identical."
	W !!,"**END REPORT**",!!
	Q
	;
CHKSUM(RSET)	; compute checksums for routines in RSET...
	; RSET = either MASTER_RSET or COMPARE_RSET
	; returns nothing -- computes checksum using ^%ZOSF("RSUM") and stores
	; value at ^XTMP("HSED",<RSET>,<routine name>)=checksum value
	N I,ROU,X,XCNP,Y,ZZRL,ZZRLL
	S ZZRL="N %,%N S %N=0 X ""ZL @X F XCNP=XCNP+1:1:2 S %N=%N+1,%=$T(+%N) Q:$L(%)=0  S @(DIF_XCNP_"""",0)"""")=%"""
	S ROU=" "
	F  S ROU=$O(^XTMP("HSED",RSET,ROU)) Q:ROU=""  D
	.S X=ROU
	.X ^%ZOSF("RSUM")
	.S ^XTMP("HSED",RSET,ROU)=Y
	.; retrieve and store the first two lines of the routine...
	.K ZZRLL
	.S XCNP=0,DIF="ZZRLL("
	.X ZZRL
	.F I=1:1:2 S ^XTMP("HSED",RSET,ROU,I)=$G(ZZRLL(I,0))
	Q
	;
DIFF(V1,V2)	; compute difference between two values...
	; V1 and V2 are numeric values
	; returns difference (non-negative value) between V1 and V2
	I $G(V1)=""!($G(V2)="") Q 0
	I +V2>+V1 Q +V2-+V1
	Q +V1-+V2
	;
HELP	; help for menu option selection...
	W !!,"Master routine set is the set which will contain the routines"
	W !,"and checksum values that will be used to compare against a"
	W !,"routine set from another UCI.  This is the master routine set"
	W !,"and checksum values."
	W !!,"Comparison routine set is the set which contains the routines"
	W !,"in a UCI that will be compared against the master routine set."
	W !!,"The report option provides a list of routines in the current"
	W !,"UCI that either don't exist in the master, or have different"
	W !,"checksum values than the value computed for a given routine in"
	W !,"the master routine set."
	W !!,"Note:  ^%ZOSF(""RSUM"") is used to compute checksum values."
	Q
