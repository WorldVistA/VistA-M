PSBUTL ;BIRMINGHAM/EFC-BCMA UTILITIES ; 6/24/08 9:54am
 ;;3.0;BAR CODE MED ADMIN;**3,9,13,38,45,46**;Mar 2004;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference/IA
 ; $$PATCH & $$VERSION^XPDUTL/10141
 ; File 50/221
 ; File 200/10060
 ;
 ;
DIWP(X,Y,PSB,PSBARGN) ; 
 K ^UTILITY($J,"W")
 S DIWL=0,DIWR=Y,DIWF="C"_Y D ^DIWP
 F X=0:0 S X=$O(^UTILITY($J,"W",0,X)) Q:'X  D
 .S Y=$O(@PSB@(""),-1)+1
 .; Naked Ref ^UTILITY($J,"W",0,X)
 .S @PSB@(Y)=$J("",+$G(PSBARGN))_^(X,0)
 S @PSB@(0)=+$O(@PSB@(""),-1)
 K ^UTILITY($J,"W"),DIWL,DIWR,DIWF
 Q
 ;
SATURDAY(X,PSBDISP) ; 
 S X=X\1 D H^%DTC ; Convert to $H
 S %H=%H+(6-%Y) ;   Set it forward to Saturday
 D YMD^%DTC ;       Back to FM Format
 I $G(PSBDISP) S PSBDISP=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3)) D EN^DDIOL("Actual date is Saturday "_PSBDISP)
 Q X
 ;
SUNDAY(X,PSBDISP) ; 
 S X=X\1 D H^%DTC ; Convert to $H
 S %H=%H-%Y ;       Set it back to Sunday
 D YMD^%DTC ;       Back to FM Format
 I $G(PSBDISP) S PSBDISP=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3)) D EN^DDIOL("Actual date is Sunday "_PSBDISP)
 Q X
 ;
CLOCK(RESULTS,X) ; Verify Client/Server Date/Times are close enough
 ;
 ; RPC: PSB SERVER CLOCK VARIANCE
 ;
 ; Description:
 ; Returns variance from server to client in minutes
 ;
 N PSBCLNT,PSBSRVR,PSBDIFF
 S %DT="RS" D ^%DT S PSBCLNT=Y
 D NOW^%DTC S PSBSRVR=%
 S PSBDIFF=$$DIFF(PSBSRVR,PSBCLNT)
 S X=$$GET^XPAR("DIV","PSB SERVER CLOCK VARIANCE")
 I PSBDIFF>X!(PSBDIFF<(X*-1)) S RESULTS(0)="-1^"_PSBDIFF
 E  S RESULTS(0)="1^"_PSBDIFF
 Q
 ;
DIFF(X,X1) ; Difference in minutes between 2 FM dates
 ; Code copied from Fileman Function MINUTES
 S Y=$E(X1_"000",9,10)-$E(X_"000",9,10)*60+$E(X1_"00000",11,12)-$E(X_"00000",11,12),X2=X,X=$P(X,".",1)'=$P(X1,".",1) D ^%DTC:X S X=X*1440+Y
 Q X
 ;
DRUGINQ ; Drug File Inquiry
 N PSBRET,PSBIEN,DIC,DIR,IOINORM,IOINHI
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S DIC="^PSDRUG(",DIC(0)="AEQMVTN",DIC("T")="",D="B^C^VAPN^VAC^NDC^XATC",DIC("A")="Select DRUG: "
 ; Display active drugs and those for appl packages IV and Unit Dose
 S DIC("S")="I '$G(^PSDRUG(+Y,""I""))!($G(^(""I""))>DT),$P($G(^PSDRUG(+Y,2)),U,3)[""I""!($P($G(^PSDRUG(+Y,2)),U,3)[""U"")"
 F  W @IOF,!,"DRUG FILE INQUIRY",! D ^DIC  Q:+Y<1  D
 .K PSBRET
 .S PSBIEN=+Y_","
 .D GETS^DIQ(50,PSBIEN,".01;16;25;51;215;213;101;9*","","PSBRET")
 .W @IOF,!,"DRUG NAME: ",IOINHI,PSBRET(50,PSBIEN,.01)
 .W "  (IEN: ",+PSBIEN,")",IOINORM,!,$TR($J("",IOM)," ","-"),!
 .F X=16,25,51,215,213,101 D
 ..D FIELD^DID(50,X,"","LABEL","PSBRET")
 ..W !,PSBRET("LABEL"),":",?30,IOINHI
 ..D:$L(PSBRET(50,PSBIEN,X))>49
 ...F Y=1:1 Q:$L($P(PSBRET(50,PSBIEN,X)," ",1,Y))>49
 ...W $P(PSBRET(50,PSBIEN,X)," ",1,Y-1),!?30
 ...S PSBRET(50,PSBIEN,X)=$P(PSBRET(50,PSBIEN,X)," ",Y,250)
 ..W ?30,PSBRET(50,PSBIEN,X),IOINORM
 .W !!,"SYNONYMS:",IOINHI,!?15
 .S X="" F  S X=$O(PSBRET(50.1,X)) Q:X=""  W:$X>40 !?15 W:$X>15 ?40 W PSBRET(50.1,X,.01)
 .W IOINORM
 .F  Q:$Y>(IOSL-3)  W !
 .S DIR(0)="E" D ^DIR
 Q
 ;
DPTSET ; Set Logic for pt-merge x-ref on patient field in file 53.79
 ;
 ; Entered Date/Time
 I $P(^PSB(53.79,DA,0),U,4) S ^PSB(53.79,"AEDT",X,$P(^PSB(53.79,DA,0),U,4),DA)=""
 ;
 ; Administration Date/Time
 D:$P(^PSB(53.79,DA,0),U,6)
 .S ^PSB(53.79,"AADT",X,$P(^PSB(53.79,DA,0),U,6),DA)=""
 .;
 .; Orderable Item + Administration Date/Time
 .I $P(^PSB(53.79,DA,0),U,8) S ^PSB(53.79,"AOIP",X,$P(^PSB(53.79,DA,0),U,8),$P(^PSB(53.79,DA,0),U,6),DA)=""
 ;
 ; PRN's by entered date/time
 I $P($G(^PSB(53.79,DA,.1)),U,2)="P"&($P(^(0),U,4)) S ^PSB(53.79,"APRN",X,$P(^PSB(53.79,DA,0),U,4),DA)=""
 ;
 ; Order+Administration Date and Time
 I $P($G(^PSB(53.79,DA,.1)),U)]""&($P($G(^PSB(53.79,DA,.1)),U,3)) S ^PSB(53.79,"AORD",X,$P(^PSB(53.79,DA,.1),U),$P(^PSB(53.79,DA,.1),U,3),DA)=""
 Q
 ;
DPTKILL ; Kill Logic for pt-merge x-ref on patient field in file 53.79
 ;
 ; Entered Date/Time
 I $P(^PSB(53.79,DA,0),U,4) K ^PSB(53.79,"AEDT",X,$P(^PSB(53.79,DA,0),U,4),DA)
 ;
 ; Administration Date/Time
 D:$P(^PSB(53.79,DA,0),U,6)
 .K ^PSB(53.79,"AADT",X,$P(^PSB(53.79,DA,0),U,6),DA)
 .;
 .; Orderable Item + Administration Date/Time
 .I $P(^PSB(53.79,DA,0),U,8) K ^PSB(53.79,"AOIP",X,$P(^PSB(53.79,DA,0),U,8),$P(^PSB(53.79,DA,0),U,6),DA)
 ;
 ; PRN's by entered date/time
 I $P($G(^PSB(53.79,DA,.1)),U,2)="P"&($P(^(0),U,4)) K ^PSB(53.79,"APRN",X,$P(^PSB(53.79,DA,0),U,4),DA)
 ;
 ; Order+Administration Date and Time
 I $P($G(^PSB(53.79,DA,.1)),U)]""&($P($G(^PSB(53.79,DA,.1)),U,3)) K ^PSB(53.79,"AORD",X,$P(^PSB(53.79,DA,.1),U),$P(^PSB(53.79,DA,.1),U,3),DA)
 Q
 ;
TIMEIN ;
 X ^%ZOSF("UPPERCASE") S X=Y
 I X="NOON" S X=.12 Q
 I X="MID" S X=.24 Q
 I (X="NOW")!(X="N") D NOW^%DTC S X=$E($P(%,".",2)_"0000",1,4)
 S X="T@"_X,%DT="R" D ^%DT
 I Y<1 K X Q
 S X=Y-DT
 Q
 ;
TIMEOUT(X) ; 
 N HOUR,MIN,AMPM
 S X=$E($P(X,".",2)_"0000",1,4)
 I X="2400" Q "12:00m"
 I X="1200" Q "12:00n"
 S HOUR=+$E(X,1,2),MIN=$E(X,3,4)
 S AMPM="a"
 S AMPM=$S(HOUR<12:"a",HOUR>11:"p",1:"**")
 S:HOUR>12 HOUR=HOUR-12
 Q HOUR_":"_MIN_AMPM
 ;
HFSOPEN(HANDLE) ; 
 N PSBDIR,PSBFILE
 S PSBDIR=$$DEFDIR^%ZISH()
 S PSBFILE="PSB"_DUZ_".DAT"
 D OPEN^%ZISH(HANDLE,PSBDIR,PSBFILE,"W") Q:POP
 S IOM=132,IOSL=99999,IOST="P-DUMMY",IOF=""""""
 Q
 ;
HFSCLOSE(HANDLE) ; 
 N PSBDIR,PSBFILE,PSBDEL
 D CLOSE^%ZISH(HANDLE)
 K ^TMP("PSBO",$J)
 S PSBDIR=$$DEFDIR^%ZISH()
 S PSBFILE="PSB"_DUZ_".DAT",PSBDEL(PSBFILE)=""
 S X=$$FTG^%ZISH(PSBDIR,PSBFILE,$NAME(^TMP("PSBO",$J,2)),3)
 S X=$$DEL^%ZISH(PSBDIR,$NA(PSBDEL))
 Q
 ;
AUDIT(PSBREC,PSBDD,PSBFLD,PSBDATA,PSBSK) ; Med Log Audit
 ; used by cross references to 53.79 to track changes to fields in Med Log file
 ; xref AU05, AU06, AU09, AU16, AU21, AU22 pass the value 53.79 as PSBDD
 ; xref AU303, AU304 pass the value 53.795 as PSBDD
 ; xref AU603, AU604 pass the value 53.796 as PSBDD
 ; xref AU703, AU704 pass the value 53.797 as PSBDD
 ;
 N PSBDT,PSBTMP
 I '$D(PSBOLSTS) S PSBOLSTS=$P(^PSB(53.79,PSBREC,0),U,9)
 I '$D(PSBOLDUZ) S PSBOLDUZ=$P(^PSB(53.79,PSBREC,0),U,5)
 Q:$G(PSBDATA)=""!('$G(PSBAUDIT))
 D NOW^%DTC S PSBDT=%
 S PSBDATA=$$EXTERNAL^DILFD(PSBDD,PSBFLD,"",PSBDATA)  ; PSBDD=53.79, 53.795, 53.796, or 53.797 see comment AUDIT
 D FIELD^DID(PSBDD,PSBFLD,"","LABEL","PSBTMP")  ; PSBDD=53.79, 53.795, 53.796, or 53.797 see comment AUDIT
 S:'$D(^PSB(53.79,PSBREC,.9,0)) ^(0)="^53.799^^"
 S Y=$O(^PSB(53.79,PSBREC,.9,""),-1)+1,X=""
 I PSBTMP("LABEL")["ACTION STATUS" D  Q
 .I PSBSK["K" S XY=Y F  S XY=$O(^PSB(53.79,PSBREC,.9,XY),-1) Q:($D(PSBGOON))!(+XY'>0)  D
 ..I ^PSB(53.79,PSBREC,.9,XY,0)["ACTION STATUS Set to '" D  Q
 ...S PSBGOON=1,PSBOLDUZ=$P(^PSB(53.79,PSBREC,.9,XY,0),U,2),X=$P(^PSB(53.79,PSBREC,.9,XY,0),"'",2)
 .S:$L(X)'>2 X=PSBOLSTS,X=$S(X="G":"GIVEN",X="H":"HELD",X="R":"REFUSED",X="I":"INFUSING",X="C":"COMPLETED",X="S":"STOPPED",X="N":"NOT GIVEN",X="RM":"REMOVED",X="M":"MISSING DOSE",X="":PSBOLSTS)
 .I PSBSK["K" S ^PSB(53.79,PSBREC,.9,Y,0)=PSBDT_U_DUZ_U_"Field: "_PSBTMP("LABEL")_" '"_PSBDATA_"' by '"_$$GET1^DIQ(200,PSBOLDUZ,"INITIAL")_"' deleted."
 .;PSB*3*45 Store Action status and last given fields.
 .E  S ^PSB(53.79,PSBREC,.9,Y,0)=PSBDT_U_DUZ_U_"Field: "_PSBTMP("LABEL")_" Set to '"_PSBDATA_"' by '"_$$GET1^DIQ(200,DUZ,"INITIAL")_"'."_U_PSBDATA_U_$P(^PSB(53.79,PSBREC,0),"^",7)
 I PSBSK["K" S ^PSB(53.79,PSBREC,.9,Y,0)=PSBDT_U_DUZ_U_"Field: "_PSBTMP("LABEL")_" '"_PSBDATA_"' deleted."
 E  S ^PSB(53.79,PSBREC,.9,Y,0)=PSBDT_U_DUZ_U_"Field: "_PSBTMP("LABEL")_$S(PSBTMP("LABEL")["DISPENSE DRUG":" Added '",1:" Set to '")_PSBDATA_"'."
 K XY,PSBGOON
 Q
 ;
CHECK(RESULTS,PSBWHAT,PSBDATA) ; Checks for KIDS Patch or Build
 ; Module added in Patch PSB*1.0*3 DP/TOPEKA 22-DEC-1999 11:51:22 
 ; PSBWHAT: B = Returns Build Version for packages by Namespace
 ;          P = Returns if Patch is installed
 ; PSBDATA: Build/Package namespace (i.e. PSB) or Patch Number
 ;         (i.e. PSB*1.0*1)
 ;
 S RESULTS(0)="-1^Unknown Parameter "_$G(PSBWHAT,"<PSBWHAT Undefined>")
 S PSBWHAT=$G(PSBWHAT),PSBDATA=$G(PSBDATA)
 D:PSBWHAT="B"
 .S X=$$VERSION^XPDUTL(PSBDATA)
 .S RESULTS(0)=$S(X="":"-1^Unknown Package/Build",1:"1^"_X)
 D:PSBWHAT="P"
 .S X=$$PATCH^XPDUTL(PSBDATA)
 .S RESULTS(0)=$S(X:"1^Patch Is Installed",1:"-1^Patch Is Not Installed")
 Q
 ;
VERSION() ; [Extrinsic] 
 ; Returns V#.# for display purposes
 Q "V"_$J(2,0,1)
 ;
RESETADM ;
 ;
 ;  This Subroutine will reset a medication order's resources
 ;  based on Med Log New Entry or Edit Med Log activity.
 ;
 ;  No input is necessary. Environment should be setup at call.
 ;
 I '$G(PSBMMEN) S X=$S($P(PSBIEN,",",2)]"":$P(PSBIEN,",",2),1:+PSBIEN) D CLEAN^PSBVT,PSJ1^PSBVT($P(^PSB(53.79,X,0),U),$P(^PSB(53.79,X,.1),U)) D:($$IVPTAB^PSBVDLU3(PSBOTYP,PSBIVT,PSBISYR,PSBCHEMT,+$G(PSBIVPSH)))  D CLEAN^PSBVT
 .S X=PSBIEN,X2=X_$S(X="+1":",",1:"") Q:'$D(PSBFDA(53.79,X2,.09))  I $F("HR",PSBFDA(53.79,X2,.09))>1 S PSBFDA(53.79,X2,.26)=""
 I $G(PSBMMEN),PSBIEN="+1",$G(PSBONX)["V" S PSBWSID=PSBFDA(53.79,"+1,",.26) K PSBFDA(53.79,"+1,",.26),PSBFDA(53.79,"+1,",.09)
 I $G(PSBMMEN) I ($D(PSBWSID))&($G(Y(0))="SAVE") D
 .S:(PSBREC(3)="G") PSBFDAX(53.79,X,.26)=PSBWSID
 .S:$F("HR",PSBREC(3))>1 PSBFDAX(53.79,X,.26)=""
 .S X=$P(PSBIEN,"+1,",2)
 .D UPDATE^DIE("","PSBFDAX","X","PSBMSG")
 Q
 ;
SCRNPTCH ;
 ;
 ; Maintain the "APATCH" index from SCREENMAN and Manual Med Entry.
 ;
 I Y(0)'="GIVEN" S PSBGPTCH=0 Q
 S PSBX=0 F  S PSBX=$O(^PSB(53.79,DA,.5,PSBX))  Q:+PSBX=0  Q:$P(^PSB(53.79,DA,.5,+PSBX,0),U,4)="PATCH"
 Q:+PSBX=0
 S PSBGPTCH=1
 Q
 ;
GIVEPTCH ;
 I $D(^PSB(53.79,"AORD",DFN,PSBONX)) N PSBX S PSBX="" F  S PSBX=$O(^PSB(53.79,"AORD",DFN,PSBONX,PSBX)) Q:+PSBX=0  D:$D(^PSB(53.79,"AORD",DFN,PSBONX,PSBX,DA))  Q:'$D(PSBX)
 .I $D(^PSB(53.79,"AORD",DFN,PSBONX,PSBX,DA)) D
 ..S PSBX=$P(^PSB(53.79,DA,0),U,6)
 ..I PSBGPTCH S ^PSB(53.79,"APATCH",DFN,PSBX,DA)="" K PSBX,PSBGPTCH Q
 ..I 'PSBGPTCH K ^PSB(53.79,"APATCH",DFN,PSBX,DA),PSBX,PSBGPTCH
 Q
