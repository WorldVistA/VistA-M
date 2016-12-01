PSJPDRUT ;BIR/MV-PADE REPORT UTILITIES ;18 JUN 96 / 2:58 PM
 ;;5.0;INPATIENT MEDICATIONS;**317**;16 DEC 97;Build 130
 ;
 ; Reference to ^%DT is supported by DBIA 10003.
 ; Reference to CLEAR^VALM1 is supported by DBIA 10116.
 ; Reference to ^XLFDT is supported by DBIA 10103.
 ; Reference to ^DPT supported by DBIA 10035
 ; Reference to ^PSDRUG supported by DBIA 2192
 Q
 ;
DATE(BEGEND,PSJSTOP,PSJINP) ; Prompt for Start Date
 N DIR,X,Y,DATE,PSJNOW,PSJDONE,TMPY,DUOUT,DTOUT
 S PSJNOW=$$NOW^XLFDT
 K %DT S %DT("A")="Enter"_$S($G(BEGEND)="B":" Start ",$G(BEGEND)="E":" End ",1:" ")_"Date: ",%DT="TAE"
 F  Q:$G(PSJSTOP)!$G(PSJDONE)  D
 .D ^%DT S TMPY=Y I ($D(DTOUT))!$G(DUOUT) S PSJSTOP=1 Q
 .I ($G(BEGEND)="E"),($G(X)="T") S TMPY=$P(TMPY,".")_".24"
 .I $G(TMPY)<1 D  Q
 ..I $E(X)="^" S PSJSTOP=1 Q
 ..W !,?3,$S(BEGEND="B":"Start ",1:"End ")_"Date is required"
 .I $G(BEGEND)="B" I TMPY>($$FMADD^XLFDT(PSJNOW)) D  Q
 ..W $C(7),!?3,"Start Date cannot be in the future. Re-enter Start Date."
 .I $G(BEGEND)="E",$G(PSJINP("PSJBDT")) I TMPY<PSJINP("PSJBDT") D  Q
 ..W $C(7),!?3,"End Date cannot be before Start Date. Re-enter End Date."
 .S PSJDONE=1
 S:$G(PSJSTOP) TMPY=""
 S DATE=TMPY
 I $G(BEGEND)="E",($P(DATE,".",2)="") S DATE=$$FMADD^XLFDT($P(DATE,"."),1)
 Q DATE
 ;
SELUSER(PSJINP,USER,SELUSER,USERX,PSJSTOP) ; Prompt for one user (or ALL)
 N DIR,X,Y,USRNAME,DUOUT,DTOUT,PSFOUND,PSALLPC
 N PSJPART,II,PSELMSG,PLSTMSG
 W ! D EN^DDIOL("  Enter '^ALL' to select all Users associated with selected PADE transactions.") W !
 S PLSTMSG(1)="Transactions matching the entered Date Range and Division "
 S PLSTMSG(2)="exist for the Users listed below."
 S DIR(0)="FAO^1:30",DIR("?")="^D LIST^PSJPDRTR(.USER,.PLSTMSG,15)"
 S DIR("A")="Select User: "_$S($D(SELUSER)>1:"",1:"^ALL//")
 D ^DIR I X="" S Y=$S($D(SELUSER)<10:"ALL",1:"")
 I $E(X)="^" S Y=$$XALL^PSJPDRIP(X)
 I $G(DUOUT)!$G(DTOUT) S PSJSTOP=1 Q
 I Y="ALL" M SELUSER=USER S SELUSER="ALL",PSJDONE=1 Q
 I Y="" D  Q
 .I $D(SELUSER)>1 S PSJDONE=1 Q
 .W !!?2,"Select a single User, several Items or enter ^ALL to select all Items."
 S PSJY=Y
 I $D(USER(PSJY)) D  Q
 .W "  ",USER(PSJY) S SELUSER(PSJY)=""
 I $D(USERX(PSJY)) D  Q
 .W "  ",USERX(PSJY) S SELUSER(USERX(PSJY))=""
 S PSELMSG="Select a User"
 S PSALLPC=1  ; return all data pieces from partial lookup
 D PARTIAL^PSJPADPT(PSJY,.USER,.SELUSER,1,PSELMSG,,.PSFOUND,,PSALLPC)
 Q:$G(PSFOUND)
 W "  ?? (No match found)"
 ;
 Q
 ;
LIST(LIST,MSG) ; Write list in LIST(ID1)=ID1
 N II,DRGNAME,NUMBER,TAB,NAME,ID1,ID2
 S $P(TAB," ",80)=""
 Q:$D(LIST)<10
 I $L($G(MSG)) W !,MSG,!
 I $D(MSG)>1 D  W !
 .S II=0 F  S II=$O(MSG(II)) Q:'II  W !,MSG(II)
 S ID1="" F  S ID1=$O(LIST(ID1)) Q:ID1=""  D
 .I LIST(ID1)="" W !,$E(TAB,1,10)_ID1 Q
 .W !,$E(TAB,1,14-$L(ID1))_ID1_"    "_$P(LIST(ID1),"^")_" "_$P(LIST(ID1),"^",2)
 Q
 ;
USERLIST(PSJINP,USER,USERX) ; Get list of selectable users in transactions matching date range, PADE device, and drug item criteria
 ;  INPUT: PSJINP("
 ; OUTPUT: USER
 ;
 N PSJDEV,PADEV,PSDRG,PSJBDT,PSJEDT,PSJTRDT,TRANS,PSJDONE,PSUNAME,PSJII,PSJHTM,PSJDOTS
 S PSJHTM=$P($H,",",2),PSJDOTS=""
 K USER S PSJII=1
 M PSJDEV=PSJINP("PADEV")
 M PSDRG=PSJINP("PSDRG")
 S PSJBDT=$G(PSJINP("PSJBDT"))
 S PSJEDT=$G(PSJINP("PSJEDT"))
 S USER="" F  S USER=$O(^PS(58.6,"USR",USER)) Q:USER=""  D
 .S PSJTRDT=$$FMADD^XLFDT(PSJEDT,,,,1),PSJDONE=0
 .D DISPDOTS^PSJPDRUT(.PSJHTM,.PSJDOTS,1)
 .F  S PSJTRDT=$O(^PS(58.6,"USR",USER,PSJTRDT),-1) Q:(PSJTRDT<PSJBDT)!$G(PSJDONE)!(PSJTRDT="")  D
 ..D DISPDOTS^PSJPDRUT(.PSJHTM,.PSJDOTS,1)
 ..S TRANS=0 F  S TRANS=$O(^PS(58.6,"USR",USER,PSJTRDT,TRANS)) Q:'TRANS!$G(PSJDONE)  D
 ...N CAB,SYS
 ...S CAB=$P($G(^PS(58.6,+TRANS,0)),"^",2) I CAB]"" Q:'$D(PSJINP("PADEV",CAB))
 ...S SYS=$P($G(^PS(58.6,+TRANS,1)),"^",3) I SYS]"" Q:SYS'=$G(PSJINP("PSJPSYSE"))
 ...S PSUNAME=$P($G(^PS(58.6,+TRANS,5)),"^",2)
 ...S:$TR(PSUNAME,",")="" PSUNAME="PADE,USER"
 ...S USER(USER)=PSUNAME,USERX(PSUNAME)=USER
 ...S PSJDONE=1,PSJII=PSJII+1
 Q
 ;
DRUGSEL(PSJINP,INDRUG,OUTDRUG,DRWPCK,PSJSTOP) ; Select drug(s) via screened ^PSDRUG lookup
 N COUNT,PSJCNT,DIR,X,Y,PSJDONE,DRGLIST,DRGNAME,PSJY,DRGN,PSJTMP,DUOUT,DTOUT
 K DRWPCK
 M DRGLIST=INDRUG
 S COUNT=0,PSJDONE=0
 D DRUGLIST^PSJPDRIN(.PSJINP,.DRGLIST)
 I $D(DRGLIST)<10 D  Q
 .S PSJSTOP=1
 .W !!,"Drug Item: "
 .W !," No Drug Items available for selection.."
 .S DIR(0)="E" D ^DIR
 W ! D EN^DDIOL("  Enter '^ALL' to select all available drug items ") W !
 F  Q:$G(DUOUT)!$G(DTOUT)!$G(PSJDONE)  D
 .N PSJPART,II
 .N DIC,X,Y,PSJX
 .S DIC="^PSDRUG(",DIC(0)="QEAZ",DIC("A")="Select Drug Item: "_$S($D(OUTDRUG)>1:"",1:"^ALL// ")
 .S DIC("S")="I $D(DRGLIST(""IEN"",+Y))"
 .D ^DIC S PSJX=X
 .I $E(PSJX)="^" S Y=$$XALL^PSJPDRIP(PSJX)
 .I $G(DUOUT)!$G(DTOUT) S PSJSTOP=1 Q
 .I Y=-1 S Y=$S($D(OUTDRUG)>1:"",1:"ALL")
 .I Y="" D  Q
 ..I $D(OUTDRUG)>1 S PSJDONE=1 Q
 ..W !!?2,"Select a single Item, several Items or enter ^ALL to select all Items."
 .S PSJY=Y
 .I PSJY,$D(DRGLIST("IEN",+PSJY)) D  Q
 ..W "  ",DRGLIST("IEN",+PSJY)
 ..S OUTDRUG(+PSJY)=$P($G(^PSDRUG(+PSJY,0)),"^")
 ..I $G(PSJINP("MANUNLOD")) D POCKET^PSJPDRIN(.PSJINP,+PSJY,.DRWPCK) S PSJDONE=1
 .I PSJX="",($D(OUTDRUG)<10) S Y="ALL"
 .I PSJX="",($D(OUTDRUG)>1) S PSJDONE=1
 .I PSJY="ALL" S OUTDRUG="ALL",PSJDONE=1 D  Q
 ..I $G(PSJINP("MANUNLOD")) S DRWPCK="ALL" Q
 ..N DRGIEN S DRGIEN=0 F  S DRGIEN=$O(INDRUG(DRGIEN)) Q:'DRGIEN  S OUTDRUG(DRGIEN)=$P($G(^PSDRUG(+DRGIEN,0)),"^")
 Q
 ;
PSYS(PSLAYGO) ; Get PADE Inventory System
 N PSYSIEN,PSYSCNT,PSYS,DIR,X,Y,PSYSLST,LISTDIR
 S PSYSIEN=0 F PSYSCNT=0:1 S PSYSIEN=$O(^PS(58.601,PSYSIEN)) Q:'PSYSIEN  D
 .S PSYS=PSYSIEN
 .S PSYSLST(PSYSIEN)=$$UPPER^HLFNC($P($G(^PS(58.601,PSYSIEN,0)),"^"))_"      "_$P($G(^PS(58.601,+PSYS,4)),"^")
 .S PSYSLSTX(PSYSCNT+1)=PSYSLST(PSYSIEN)_"^"_PSYSIEN
 .S LISTDIR=$G(LISTDIR)_$S($G(PSYSCNT):";",1:"")_(PSYSCNT+1)_":"_PSYSLST(PSYSIEN)
 I 'PSYSCNT D  Q ""
 .S PSJSTOP=-1
 .D EN^DDIOL("No PADE Inventory data on file")
 .N DIR S DIR(0)="EA",DIR("A")="Press Return to Continue... " D ^DIR
 I PSYSCNT=1 S DIR("B")=$P($G(^PS(58.601,+PSYS,0)),"^")
 S DIR(0)="SAO^"_LISTDIR
 S DIR("A")="Select PADE Inventory System: "
 D ^DIR
 S PSYS=$S(Y>0:+Y,1:"") S:PSYS="" PSJSTOP=-1
 I +$G(PSYS) S PSYS=$P(PSYSLSTX(PSYS),"^",2) S:PSYS="" PSJSTOP=-1
 Q PSYS
 ;
ENSYS() ; Get PADE Inventory System
 N PSYSIEN,PSYSCNT,PSYS,DIR,X,Y,PSYSLST,LISTDIR,PSYSNAM,PSYSALT
 K PSJSTOP
 F  Q:$G(PSYS)!$G(PSJSTOP)  D
 .D GETSYS(.PSYSLST,.PSYSLSTX,.PSYSNAM,.PSYSALT)
 .D SELSYS(.PSYSLST,.PSYSLSTX,.PSYSNAM,.PSYS)
 Q PSYS
 ;
PTIX(PS586IEN,PSJOMS)  ; Computed PATIENT to handle blank patients in "P" x-ref in Transaction file 586
 N PATIENT
 S PATIENT=$P($G(^PS(58.6,+$G(PS586IEN),0)),"^",15)
 I '$G(PATIENT) S PATIENT=$G(FDA(58.6,"+1,",14))
 I '$G(PATIENT) S PATIENT=$G(PSJOMS("DFN"))
 Q:$G(PATIENT) PATIENT
 Q "zz"
 ;
DRGIX(PS586IEN,PSJOMS)  ; Computed DRUG ID to handle unknown drugs in "P" x-ref in Transaction file 58.6
 I $P($G(^PS(58.6,+$G(PS586IEN),0)),"^",3) Q $P(^(0),"^",3)
 I $P($G(^PS(58.6,+$G(PS586IEN),1)),"^",6)]"" Q "zz~"_$P(^(0),"^",6)
 I $G(FDA(58.6,"+1,",2)) Q +$G(FDA(58.6,"+1,",2))
 I $G(PSJOMS("DRGTXT"))]"" Q "zz~"_$G(PSJOMS("DRGTXT"))
 Q "zz~UNKNOWN"
 ;
DISPDOTS(PSJHTM,PSJDOTS,SECONDS) ; Check to see if more than SECONDS seconds has elapsed in $H, since PSJHTM. 
 ; INPUT - PSJHTM = the 2nd comma piece of $H (seconds)
 ;         PSJDOTS = flag indicating whether initial message "Searching for matching transactions.." has (1) or has not 0 or "" already been displayed
 I '$G(PSJHTM) S PSJHTM=$P($H,",",2)
 I ($P($H,",",2)-PSJHTM)>1 D
 .I '$G(PSJDOTS) W !?2,"Searching for matching transactions.." S PSJDOTS=1,PSJHTM=$P($H,",",2)
 .W "." S PSJHTM=$P($H,",",2)
 Q
 ;
PADEUP(PADEV,PADEVUP)  ; Return PADEVUP array, containing subscripts converted to upper case from incoming PADEV array
 N PADE
 S PADE="" F  S PADE=$O(PADEV(PADE)) Q:PADE=""  S PADEVUP($$UPPER^HLFNC(PADE))=PADEV(PADE)
 Q
 ;
DIV(PSJDIV,PSJSTOP)  ; Perform manual entry and validation of DIVISION (40.8)
 N PSJDONE,DIR,X,Y,DIVAR,DIVARX,PSJY,PSALLPC
 K PSJDIV
 D DIVLIST(.DIVAR,.DIVARX)
 S PSJDIV=""
 F  Q:$G(PSJSTOP)!$G(PSJDONE)  D
 .N PSJTMP
 .S DIR(0)="FAO^1:30",DIR("?")="^D DIVLKUP^PSJPDRUT(.DIVAR)"
 .S DIR("A")="Select Division: "_$S($D(PSJDIV)>1:"",1:" ^ALL// ")
 .D ^DIR I $E(X)="^" S Y=$$XALL^PSJPDRIP(X)
 .I X="",($D(PSJDIV)<10) S Y="ALL"
 .I Y="ALL" M PSJDIV=DIVAR S PSJDIV="ALL",PSJINP("PSJDIV")="ALL",PSJDONE=1 Q
 .I $G(DUOUT)!$G(DTOUT) S PSJSTOP=1 Q
 .I Y="" D  Q
 ..I $D(PSJDIV)>1 S PSJDONE=1 Q
 ..W !!?2,"Select a single Division, several Divisions or enter ^ALL to select all Divisions."
 .S PSJY=Y
 .I $D(DIVAR(PSJY)) D  Q
 ..N DIVIEN,PSALLPC
 ..S PSALLPC=1   ; return all data pieces from partial lookup
 ..S DIVIEN=$P(DIVAR(PSJY),"^",2)
 ..Q:'DIVIEN  S PSJDIV(DIVIEN)=DIVAR(PSJY)
 ..W "  ",PSJY,"  ",$P(DIVAR(PSJY),"^")
 .I $D(DIVARX(PSJY)) D  Q
 ..N DIVIEN S DIVIEN=$P(DIVAR(DIVARX(PSJY)),"^",2)
 ..Q:'DIVIEN  S PSJDIV(DIVIEN)=PSJY
 ..W "  ",PSJY,"  ",DIVAR(PSJY)
 .S PSELMSG="Select a Division"
 .S PSALLPC=1  ; Return all data pieces from partial lookup
 .D PARTIAL^PSJPADPT(PSJY,.DIVARX,.PSJTMP,,PSELMSG,.DIVAR,.PSFOUND,,PSALLPC)
 .I $G(PSFOUND) N PSDIV,DIVIEN S PSDIV=$O(PSJTMP("")) I PSDIV]"" S DIVIEN=$P($G(PSJTMP(PSDIV)),"^",2) I DIVIEN S PSJDIV(DIVIEN)=PSDIV_"^"_DIVIEN
 .Q:$G(PSFOUND)
 .W "  ?? (No match found)"
 Q
 ;
DIVLKUP(DIVAR)  ; Lookup Division
 D LIST^PSJPDRTR(.DIVAR,,15)
 Q
 ;
DIVLIST(DIVAR,DIVARX)  ; Get list of Divisions
 N DIVNAM,DIVIEN,DIVCNT
 S DIVNAM="" F DIVCNT=1:1 S DIVNAM=$O(^DG(40.8,"B",DIVNAM)) Q:DIVNAM=""  D
 .S DIVIEN=$O(^DG(40.8,"B",DIVNAM,0))
 .S DIVAR(DIVIEN)=DIVNAM_"^"_DIVIEN,DIVARX(DIVNAM)=DIVIEN
 Q
 ;
UPPER(PSTEXT)  ; Convert X to upper case
 N X,Y
 S PSTEXT=$$UPPER^HLFNC(PSTEXT)
 Q PSTEXT
 ;
GETSYS(PSYSLST,PSYSLSTX,PSYSNAM,PSYSALT)  ; Get list of PADE Inventory Systems from file 58.601
 ;
 N PSYSIEN,PSYSCNT
 K PSYSLST,PSYSLSTX,PSYSNAM,PSYSALT,PSUPPER
 S PSYSIEN=0 F PSYSCNT=0:1 S PSYSIEN=$O(^PS(58.601,PSYSIEN)) Q:'PSYSIEN  D
 .S PSYS=PSYSIEN
 .S PSYSLST("IEN",PSYSIEN)=$P($G(^PS(58.601,PSYSIEN,0)),"^")
 .S PSYSLST("NAME",PSYSLST("IEN",PSYSIEN))=PSYSIEN
 .S PSYSLSTX(PSYSCNT+1)=PSYSLST("IEN",PSYSIEN)_"    "_$P($G(^PS(58.601,+PSYSIEN,4)),"^")_"^"_PSYSIEN
 .S PSYSNAM(PSYSLST("IEN",PSYSIEN))=PSYSIEN
 .S PSYSALT=$P($G(^PS(58.601,+PSYSIEN,4)),"^") I PSYSALT]"" S PSYSNAM($$UPPER^PSJPDRUT(PSYSALT))=PSYSIEN
 Q
 ;
SELSYS(PSYSLST,PSYSLTX,PSYSNAM,PSYS)  ; Select dispensing system for editing
 ; Input:   PSYSLST   - list of dispensing systems, PSYSLST("IEN",IEN)=name, PSYSLST("NAME",name)=IEN
 ;          PSYSLSTX  - list of dispensing systems, PSYSLSTX(list#)=name
 ;          PSYSNAM   - list of dispensing systems, PSYSNAM(name)=list#
 ; Output:  PSYS  - IEN of dispensing system in file 58.601
 N PSJY,PSFOUND,PSALLPC
 K PSYS S PSYS=""
 S DIR(0)="FAO",DIR("?")="^D LIST^PSJPDRTR(.PSYSLSTX,,15)"
 S DIR("A")="Select PADE Inventory System: "
 D ^DIR
 ;
 I $G(DUOUT)!$G(DTOUT) S PSJSTOP=1 Q
 I Y=""!($TR(Y," ")="")!(Y["^") D  Q
 .W !!?2,"Select a PADE Dispensing Inventory system or '^' to exit."
 S PSJY=Y
 I $D(PSYSLSTX(+PSJY)) D  Q
 .W "  ",$P(PSYSLSTX(+PSJY),"^")
 .S PSYS=$P(PSYSLSTX(+PSJY),"^",2)
 I $D(PSYSNAM(PSJY)) D  Q
 .W "  ",PSYSNAM(PSJY)
 .S PSYS=PSYSNAM(PSJY)
 I $D(PSYSALT(PSJY)) D  Q
 .W "  ",PSYSLST(PSYSALT(PSJY))
 .S PSYS=PSYSALT(PSJY)
 S PSALLPC=1  ; return all data pieces from partial lookup
 D PARTIAL^PSJPADPT(.PSJY,.PSYSNAM,.PSJY,1,,.PSYSLSTX,.PSFOUND,,PSALLPC)
 I '$G(PSFOUND),($G(PSJY)]"") D  Q
 .N DIR,X,Y,FDA
 .S DIR("A")="  Are you adding '"_PSJY_"' as a new PADE INVENTORY SYSTEM? "
 .S DIR(0)="YAO",DIR("B")="N" D ^DIR Q:'Y
 .S FDA(58.601,"?+1,",.01)=PSJY
 .D UPDATE^DIE("E","FDA","PSYS","ERR")
 .S PSYS=$S($G(PSYS(1)):+$G(PSYS(1)),1:"")
 I $G(PSFOUND) S PSYS=$O(PSJY(0)),PSYS=+$G(PSYSNAM(PSYS)) I 'PSYS S PSYS=+$G(PSYSLST("NAME",PSYS))
 Q
 ;
PADEUSR(PSJPSYS,PSJPDUSR) ; Return Vista user ID for PADE user PSJPDUSER, if it exists
 N PSJSYSE,PSJVUSR,PSJVAL,PSJRSLT,PADUIEN
 Q:$G(PSJPSYS)="" ""
 Q:$G(PSJPDUSR)="" ""
 S PSJSYSE=$P($G(^PS(58.601,+PSJPSYS,0)),"^")
 Q:PSJSYSE="" ""
 S PSJVAL(1)=PSJSYSE
 S PSJVAL(2)=PSJPDUSR
 S PSJVUSR=$$FIND1^DIC(58.64,,"K",.PSJVAL)
 Q:'PSJVUSR ""
 S PADUIEN=+$G(PSJVUSR)
 D GETS^DIQ(58.64,+PSJVUSR,"2","IE","PSJRSLT")
 S PSJVUSR=+$G(PSJRSLT(58.64,PSJVUSR_",",2,"I"))_"^"_$G(PSJRSLT(58.64,PSJVUSR_",",2,"E"))_"^"_PADUIEN
 Q PSJVUSR
 ;
DEVSCRN(PSJINP,PSPDIEN)  ; Screen PADE cabinet PSPDIEN (file 58.63) 
 ; Compare PSJINP("PSJPSYS") to System Field (#1)(#58.63)
 ; and     PSJINP("PSJDIV") to Division Field (#2) (58.63)
 ; Manually coded version of screen S PSJSCR="I $D(PSJINP(""PSJDIV"",+$G(^(2))))&($P($G(^(0)),""^"",2)=PSJPSYS)&'$$EMPTY^PSJPADPT(+Y)"
 N PADEOK,DIVIEN,DIVNAME,SYSIEN,DIVTMP,DIVOK
 S PADEOK=1
 S DIVIEN=$P($G(^PS(58.63,+$G(PSPDIEN),2)),"^")
 S DIVNAME=$P($G(^DG(40.8,+DIVIEN,0)),"^")
 I DIVNAME="" Q 0  ; No division on file for cabinet, quit
 ; Division doesn't match any in PSJINP("PSJDIV"), quit
 S DIVOK=0 S DIVTMP="" F  S DIVTMP=$O(PSJINP("PSJDIV",DIVTMP)) Q:DIVTMP=""!$G(DIVOK)  I $P($G(PSJINP("PSJDIV",DIVTMP)),"^",2)=DIVIEN S DIVOK=1
 Q:'DIVOK 0
 ; System doesn't match PSJINP("PSJPSYS"), quit
 S SYSIEN=$P($G(^PS(58.63,+$G(PSPDIEN),0)),"^",2)
 I SYSIEN'=+$G(PSJINP("PSJPSYS")) Q 0
 ; Cabinet is empty, quit
 Q:$$EMPTY^PSJPADPT(+PSPDIEN) 0
 Q PADEOK
 ;
UNIQUE(PSJY,PADE)   ; Is PSJY unique subscript in PADE(), or are there other partial matches (PADE(PSJY), PADE(PSJYnn), PADE(PSJYxx), etc)?
 N NEXTSUB,PSJYLEN
 I $G(PSJY)="" Q 1
 I $D(PADE)<10 Q 1
 S NEXTSUB=$O(PADE(PSJY))
 S PSJYLEN=$L(PSJY)
 I $E(NEXTSUB,1,PSJYLEN)=PSJY Q 0
 Q 1
 ;
PSB(PSJOMS)  ; Get Patient Specific Bin info
 ;
 N PSPADFN,PSPADNM,PSPADPK
 I (PSJOMS("COMMENT")'["PATIENT SPECIFIC BIN") Q
 N PSSN S PSSN=$P(PSJOMS("COMMENT"),"-",2)
 I $G(PSSN) S PSPADFN=$$PATSSN(PSSN) I $G(PSPADFN) S PSJOMS("SSN")=PSSN,PSJOMS("DFN")=PSPADFN
 I $G(PSPADFN) S PSPADNM=$P($G(^DPT(+PSPADFN,0)),"^")
 I ($G(PSPADNM)'="") S (PSJOMS("DFN"),PSJOMS("PTID"))=PSPADFN D
 .S PSJOMS("PTNAMA")=$P(PSPADNM,",")
 .S PSJOMS("PTNAMB")=$P(PSPADNM,",",2)
 S PSPADPK=$G(PSJOMS("PKT"))
 S PSJOMS("PKT")=PSJOMS("PKT")_"PSB"
 Q
 ;
PATSSN(PSSN)  ; If valid PSSN patient SSN, return patient PDFN pointer to ^DPT
 N PSVAL,PSINDEX,PSJDFN
 S PSJDFN=""
 I $G(PSSN) S (X,PSVAL)=PSSN,PSINDEX="SSN" S PSJDFN=$$FIND1^DIC(2,,"X",PSVAL,PSINDEX,,"PSERR")
 I '$G(PSJDFN),$G(PSSN) S PSJDFN=$O(^DPT("SSN",PSSN,""))
 I '$G(PSJDFN),$G(PSSN) N TMPSSN S TMPSSN=$TR($J(+PSSN,9)," ",0) S PSJDFN=$O(^DPT("SSN",TMPSSN,""))
 I 'PSJDFN S PSJDFN=""
 I PSJDFN I '$D(^DPT(PSJDFN)) S PSJDFN=""
 Q PSJDFN
 ;
TTYPDIR(PSJPSYS,BDT,EDT)  ; build DIR(0) string of selectable transaction types
 N TTYPDIR,TTARRAY,TT,II
 Q:'$G(PSJPSYS) ""
 Q:'$D(^PS(58.601,+PSJPSYS,0)) ""
 D TTYPES(PSJPSYS,BDT,EDT,.TTARRAY)
 S TTYPDIR=""
 S TT="" F II=1:1 S TT=$O(TTARRAY(TT)) Q:TT=""  D
 .N TTYPNAM
 .S TTYPNAM=TT
 .I II=1 S TTYPDIR="1:"_TTYPNAM
 .I II>1 S TTYPDIR=TTYPDIR_";"_II_":"_TTYPNAM
 Q TTYPDIR
 ;
TTYPES(PSJPSYS,BDT,EDT,OUTTYP)  ; Get list of all transaction Types for system PSJPSYS between begin date BDT and end date EDT
 N TDT,SYSNAM,TDEV,TXIEN
 K OUTTYP
 S SYSNAM=$P($G(^PS(58.601,+$G(PSJPSYS),0)),"^")
 S TDT=$$FMADD^XLFDT(BDT,,,-.1)
 F  S TDT=$O(^PS(58.6,"B",TDT)) Q:(TDT="")!(TDT>EDT)  S TXIEN=0 F  S TXIEN=$O(^PS(58.6,"B",TDT,TXIEN)) Q:'TXIEN  D
 .N TT
 .Q:($P($G(^PS(58.6,TXIEN,1)),"^",3)'=SYSNAM)
 .S TT=$P($G(^PS(58.6,TXIEN,0)),"^",5) Q:TT=""
 .S TTYPNAM=$$TTEX(TT)
 .Q:$D(OUTTYP(TTYPNAM))
 .Q:'(",D,L,R,F,U,E,C,R,W,B,V,")[(","_TT_",")
 .S OUTTYP(TTYPNAM)=""
 Q
 ;
DEFTRAN(DEFTRAN)  ; Get default list of ALL transaction types if none were found in transaction file
 N II,TTYPNAM,TRANLIST,TTYPCOD
 S TRANLIST="V:Dispense,L:Load,U:Unload,F:Fill/Refill,B:Empty Bin,C:Count,R:Return,W:Waste,E:Expired,A:Discrepancy"
 N II F II=1:1:$L(TRANLIST,",") S II=$P(TRANLIST,",",II) Q:II=""  D
 .S TTYPCOD=$P(II,":"),TTYPNAM=$P(II,":",2)
 .S DEFTRAN(TTYPNAM)=TTYPCOD
 Q
 ;
TTEX(TTCODE)  ; Convert Transaction Type code to Type Name
 N TTNAME,TT
 S TT=$$UPPER^PSJPDRUT($G(TTCODE))
 S TTNAME=$S(TT="V":"Dispense",TT="L":"Load",TT="U":"Unload",TT="F":"Refill",TT="B":"Empty Bin",TT="C":"Count",TT="R":"Return",TT="W":"Waste",TT="E":"Expired",TT="D":"Destock",TT="A":"Discrepancy",TT="N":"Cancel",1:"Other")
 Q TTNAME
 ;
EXTT(TTNAME)  ; Convert Transaction Type Name to Type Code
 N TTCODE,TT
 S TT=$$UPPER^PSJPDRUT($G(TTNAME))
 S:TT="" TT="OTHER"
 S TTCODE=$P($T(@($E($P(TT," "),1,8)_"^PSJPDRUT")),";;",2)
 S:TTCODE="" TTCODE="O"
 Q TTCODE
 ;
DISPENSE ;;V
VEND ;;V
LOAD ;;L
UNLOAD ;;U
REFILL ;;F
EMPTY ;;B
COUNT ;;C
RETURN ;;R
WASTE ;;W
EXPIRED ;;E
DESTOCK ;;D
DISCREPA ;;A
CANCEL ;;N
UNKNOWN ;;O
OTHER ;;O
 Q
