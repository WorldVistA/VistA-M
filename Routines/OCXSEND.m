OCXSEND ;SLC/RJS,CLA - BUILD RULE TRANSPORTER ROUTINES ;2/22/08  12:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,74,96,105,243**;Dec 17,1997;Build 242
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 N X,IOP,TOTL S TOTL=0
 N CVER,RCNT,RSIZE,LASTFILE,HEADER1,HEADER2,HEADER3,HEADER4,HEADER5
 N OCXASK,OCXID,OCXLIN2,OCXLIN3,OCXPATCH,OCXSCR,PARM,PARMV,DIE,DIERR,DIQ2,FCPARM,TEXT
 I '$D(IOM) S IOP=0 D ^%ZIS K IOP
 K ^TMP("OCXSEND",$J),^UTILITY($J),OCXPATH
 K ^UTILITY($J),OCXPATH
 S ^TMP("OCXSEND",$J)=($P($H,",",2)+($H*86400)+(4*60*60))_" <- ^TMP ENTRY EXPIRATION DATE FOR ^OCXOPURG"
 S OCXLIN2=$T(+2)
 S OCXLIN3=$T(+3)
 ;
 D ^OCXSEND1 ; Get List of Objects to Transport
 ;
 I '$O(^TMP("OCXSEND",$J,"LIST",0)) K ^TMP("OCXSEND",$J) Q  ; Nothing selected so Quit
 ;
 S OCXASK="" F  D  Q:$L(OCXASK)
 .W !
 .W !,"When the transport routine encounters locally"
 .W !,"altered rule data at a site, do you want to:"
 .;
 .S OCXASK=$$READ("S^O:Overwrite local data;D:Display locally altered data only;A:Ask the site what to do","(O)verwrite, (D)isplay, or (A)sk the site ? ","Ask")
 ;
 Q:(OCXASK[U)
 I (OCXASK="O") W !!,"Locally altered data will be overwritten without asking.",!!
 I (OCXASK="D") W !!,"Locally altered data will be displayed only.",!!
 I (OCXASK="A") W !!,"Sites will be asked before locally altered data is overwritten.",!!
 ;
 S OCXPATCH="" F  D  Q:$L(OCXPATCH)
 .W !!,"Enter Patch ID (ex. OR*3*96): " R OCXPATCH:DTIME E  S OCXPATCH="^" Q
 .Q:(OCXPATCH="^")
 .I '$L(OCXPATCH) S OCXPATCH="^^" Q
 .I $L(OCXPATCH),'(OCXPATCH?1"OR*"1N1"*"1.4N) D  S OCXPATCH="" Q
 ..W !!
 ..W:'(OCXPATCH["?") "Invalid"
 ..W " Format -> OR*v*ppp"
 ..W !,"   v = Package Version."
 ..W !," ppp = Patch Number."
 ..W !
 Q:(OCXPATCH="^")
 S:(OCXPATCH="^^") OCXPATCH=""
 I $P(OCXPATCH,"*",3) S $P(OCXLIN2,";",5)="**"_$P(OCXPATCH,"*",3)_"**"
 I $L(OCXPATCH) S OCXPATCH="(Delete after Install of "_OCXPATCH_")"
 ;
 Q:'$$RSDEL
 ;
 D ^OCXSEND2 ; Get File Data
 ;
 S TOTL=$$EN^OCXSEND3 ; File Routines
 ;
 S TOTL=TOTL+$$EN^OCXSENDA ; File Main Runtime Library Routine
 ;
 S TOTL=TOTL+$$EN^OCXSEND4 ; File Utility Runtime Library Routine 0
 ;
 S TOTL=TOTL+$$EN^OCXSEND5 ; File Utility Runtime Library Routine 1
 ;
 S TOTL=TOTL+$$EN^OCXSEND6 ; File Utility Runtime Library Routine 2
 ;
 S TOTL=TOTL+$$EN^OCXSEND7 ; File Utility Runtime Library Routine 3
 ;
 S TOTL=TOTL+$$EN^OCXSEND8 ; File Utility Runtime Library Routine 4
 ;
EXIT K ^TMP("OCXSEND",$J),^UTILITY($J)
 ;
 W !!,"Routines filed.",!!
 ;
 Q
 ;
READ(OCX0,OCXA,OCXB,OCXL) ;
 N X,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:'$L($G(OCX0)) U
 S DIR(0)=OCX0
 S:$L($G(OCXA)) DIR("A")=OCXA
 S:$L($G(OCXB)) DIR("B")=OCXB
 F X=1:1:($G(OCXL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
CUCI() Q:'$D(^%ZOSF("UCI")) "" N Y X ^%ZOSF("UCI") Q Y
 ;
NETNAME() ;
 N NETNAME
 S NETNAME=$P($$NETNAME^XMXUTIL(DUZ),"@",2)
 I $L(NETNAME) Q NETNAME
 ; Q:$L($G(^XMB("NETNAME"))) ^XMB("NETNAME")
 ; Q:$L($G(^XMB("NAME"))) ^XMB("NAME")
 Q $$CUCI
 ;
RSDEL() ;
 ;
 W !!,"Scanning for old rule transport routines..."
 N X,CNT,RCNT,RLIST,RNAME
 S RCNT=0
 ;
 ;  Scan for Routines To Delete
 ;
 ; Main Routine
 S RNAME=$$RNAME^OCXSEND3(0,0) I $$RFIND(RNAME,100) S RLIST(RNAME)=""
 ;
 ; Runtime Library routines
 F CNT=0:1:35 S RNAME=$$RNAME^OCXSEND3(CNT,1) I $$RFIND(RNAME,CNT) S RLIST(RNAME)=""
 ;
 ; Data Routines
 F CNT=0:1:46655 S RNAME=$$RNAME^OCXSEND3(CNT,2) I $$RFIND(RNAME,CNT) S RLIST(RNAME)=""
 ;
 I '$L($O(RLIST(""))) W !,"No old rule transport routines found..." H 2 Q 1
 ;
 W !!,"These routines will be deleted and overwritten."
 Q:'$$READ("Y"," Do you want to proceed?","NO") 0
 ;
 ;    Delete The routines
 ;
 I '$D(^%ZOSF("DEL")) W !!,"Old rule transport routines not deleted (^%ZOSF(""DEL"") undefined)" Q 0
 ;
 S RNAME="" F RCNT=1:1 S RNAME=$O(RLIST(RNAME)) Q:'$L(RNAME)  D
 .W !,RNAME
 .I $$RDEL(RNAME) W "   Deleted..." Q
 .W "   Not Deleted..."
 ;
 W !!,RCNT," routine",$S((RCNT=1):"",1:"s")," deleted."
 ;
 H 2 Q 1
 ;
RFIND(X,C) ;
 W:($X>70) ! W:'(C#100) "."
 Q:'$L(X) 0 X "S TEXT=$T(+1^"_X_")" Q:'$L(TEXT) 0
 W !,X Q 1
 Q
 ;
RDEL(X) ;
 ;
 Q:'$L(X) 0 X "S TEXT=$T(+1^"_X_")" Q:'$L(TEXT) 0
 X ^%ZOSF("DEL") Q 1
 ;
