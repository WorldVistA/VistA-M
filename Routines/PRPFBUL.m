PRPFBUL ;ALTOONA/CTB  GENERATE BULLETINS REQUIRED BY IG ;3/7/97  11:12 AM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
ADDRESS ;
 N N
 S XMY("G.PRPF BULLETINS")=""
 S N=0 F  S N=$O(^XUSEC("PRPF SUPERVISOR",N)) Q:'N  S XMY(N)=""
 QUIT
OVERDRAW(PATDA,TRANSID) ;BULLETIN FOR OVERDRAWAL
 NEW TEXT,XMSUB,XMDUZ,XMZ,OUT,XMY,XMTEXT
 S XMDUZ=DUZ,XMSUB="Patient Funds Bulletin"
 S XMTEXT="TEXT("
 S TEXT(1)="Patient Funds transaction "_TRANSID_" has caused the account of: "
 S TEXT(2)=$P(^DPT(PATDA,0),"^",1)_" - "_$P(^(0),"^",9)_" to be overdrawn."
 D ADDRESS
 D ^XMD
 K PRPFBUL("OVERDRAW")
 QUIT
RESTRICT(PATDA,TRANSID) ;BULLETIN FOR RESTRICTION
 NEW TEXT,XMSUB,XMDUZ,XMZ,OUT,XMY
 S XMDUZ=DUZ,XMSUB="Patient Funds Bulletin"
 S XMTEXT="TEXT("
 S TEXT(1)="Patient Funds transaction "_TRANSID_" has caused the account of: "
 S TEXT(2)=$P(^DPT(PATDA,0),"^",1)_" - "_$P(^(0),"^",9)_" to exceed a preset restriction."
 D ADDRESS
 D ^XMD
 K PRPFBUL("RESTRICTION")
 QUIT
DEFER(PATDA,TRANSID) ;BULLETIN FOR DEFERRAL
 NEW TEXT,XMSUB,XMDUZ,XMZ,OUT,XMY
 S XMDUZ=DUZ,XMSUB="Patient Funds Bulletin"
 S XMTEXT="TEXT("
 S TEXT(1)="Patient Funds transaction "_TRANSID_" has caused the account of: "
 S TEXT(2)=$P(^DPT(PATDA,0),"^",1)_" - "_$P(^(0),"^",9)_" has overridden a preset check deferral limit."
 D ADDRESS
 D ^XMD
 K PRPFBUL("DEFERRAL")
 QUIT
