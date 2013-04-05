PSXPOST ;BIR/BAB-Post Initialization Routine ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 S XQABT4=$H
 G:^XMB("NETNAME")?1"CMOP-".E HOST
 G:^XMB("NETNAME")'?1"CMOP-".E REMOTE
 Q
HOST F FILE=552,552.1,552.2,552.3,552.4,552.5,553,553.1,554,555 S ^DD(FILE,0,"VR")="2.0"
 ;Setup CMOP INTERFACE and CMOP OPERATIONS file entry
 S PSX=^XMB("NETNAME")
 S CMOP=$S($G(PSX)["-L":"LEAVENWORTH",$G(PSX)["-W":"WEST LA",$G(PSX)["-B":"BEDFORD",$G(PSX)["-D":"DALLAS",$G(PSX)["-M":"MURFREESBORO",$G(PSX)["-H":"HINES",1:"UNKNOWN")
 I $D(^PSX(553,1,0)) G OP
 S ^PSX(553,1,0)=CMOP_"^1^^9999^5^10^^10000^1^1000"
 S ^PSX(553,1,"F")="S"
 S ^PSX(553,1,"P")="S",^PSX(553,1,"S")="S"
 S ^PSX(553,1,"T")="6^3^30^60"
 S ^PSX(553,1,"X",0)="^553.01DA^^"
 S ^PSX(553,"B",CMOP,1)=""
OP ;
 I $D(^PSX(554,1,0)) G EXIT
 S ^PSX(554,0)="CMOP OPERATIONS^554^1^1",^PSX(554,1,0)=CMOP_"^1^1"
 S ^PSX(554,"B",CMOP,1)=""
 G EXIT
REMOTE F FILE=550,550.1,550.2 S ^DD(FILE,0,"VR")="2.0"
SYS ;Setup CMOP System entry for new sites
 G:$O(^PSX(550,0)) EXIT
 S DOM=0 S DOM=$O(^DIC(4.2,"B",^TMP("PSXCMOP",$J),DOM))
 S PSX1=^TMP("PSXCMOP",$J)
 I +$G(DOM)=0 D BMES^XPDUTL("Your Kernel Site Parameters File is missing the entry for the your CMOP mailman domain!  ")
 I +$G(DOM)=0 D BMES^XPDUTL("Please contact the Birmingham CIO Field Office!") S XPDABORT=2 Q
 S PSX=$S($G(PSX1)["-L":"LEAVENWORTH",$G(PSX1)["-B":"BEDFORD",$G(PSX1)["-W":"WEST LA",$G(PSX1)["-D":"DALLAS",$G(PSX1)["-M":"MURFREESBORO",$G(PSX1)["-H":"HINES",1:"UNKNOWN")
 I PSX["UNK" D BMES^XPDUTL("Unable to determine CMOP setup, contact the Birmingham ISC for assistance.") S XPDABORT=2 G EXIT
 S ^PSX(550,0)="CMOP SYSTEM^550I^1^1"
 S ^PSX(550,1,0)=PSX_"^I^H^"_+DOM
 S ^PSX(550,"B",PSX,1)=""
EXIT ;  Check resource device
 I '$O(^%ZISL(3.54,"B","PSX","")) D BMES^XPDUTL("You do not have the PSX Resource device set up.")
 I  D BMES^XPDUTL("Please read the CMOP Pre-Installation instructions for proper setup.")
 ;   Check Mail Group
MAIL I '$O(^XMB(3.8,"B","CMOP MANAGERS","")) D BMES^XPDUTL("The Mail Group CMOP MANAGERS must be set up and assigned at least one active user.")
 K CMOP,DA,DIK,DOM,FILE,X,PSX,PSX1,^TMP("PSXCMOP"),^TMP("PSXDIC"),^TMP("PSXDD"),^TMP("PSXPS"),ZX
 D BMES^XPDUTL("Initialization complete!!")
 K X
 Q
