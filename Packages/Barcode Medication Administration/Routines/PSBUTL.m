PSBUTL ;BIRMINGHAM/EFC-BCMA UTILITIES ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**3,9,13,38,45,46,63,83,97,99,104**;Mar 2004;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference/IA
 ; $$PATCH & $$VERSION^XPDUTL/10141
 ; File 50/221
 ; File 200/10060
 ; EN^PSJBCMA1/2829
 ;
 ;*83 - Add tags called by DD trigger xrefs
 ;    - Add FIXADM to add to coversheet Results the G give action.
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
 N PSBCLNT,PSBSRVR,PSBDIFF,PSBMDNT
 S PSBMDNT=0
 I $P(X,"@",2)="0000" S $P(X,"@",2)="2400",PSBMDNT=1 ;Change Delphi time for midnight from 0000 to 2400 in PSB*3.0*63
 S %DT="RS" D ^%DT S PSBCLNT=Y
 D NOW^%DTC S PSBSRVR=%
 S:$G(PSBMDNT) PSBCLNT=$$FMADD^XLFDT(PSBCLNT,-1,0,0,0) ;Change Delphi date for midnight from day following midnight to day previous to midnight in PSB*3.0*63
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
 Q:'$O(^PSB(53.79,0))  ;Quit if there are no BCMA entries, PSB*3*99
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
 ;
VALGIV() ;Validate Give, variance time set during a Trigger call      *83
 Q:'$P($G(^PSB(53.79,DA,0)),U,6) 0
 Q ($P($G(^PSB(53.79,DA,.1)),U,2)="C"&($P($G(^(.1)),U,3)]"")&($G(PSBACTN)="G"))
 ;
VALREM() ;Validate Remove, variance time set during a Trigger call    *83
 Q:'$P($G(^PSB(53.79,DA,0)),U,6) 0
 Q ($P($G(^PSB(53.79,DA,.1)),U,2)="C"&($P($G(^(.1)),U,7)]"")&($G(PSBACTN)="RM"))
 ;
REMSTR(A,D,TY,SP,PRSP) ;build remove time string from admin time string via DOA value *83
 ;    A = admin time strg e.g. "0900-2100"
 ;    D = Duration of Admin (DOA)
 ;   TY = sched type
 ;   SP = order stop date
 ; PRSP = previous stop date
 ;
 N RMTM,RMSTR,Q
 S RMSTR="",TY=$G(TY),SP=$G(SP),PRSP=$G(PRSP)
 ;
 ;no admin time, return null RMSTR
 Q:(TY'="O")&('A) RMSTR
 ;
 ;sched typ is One Time, return Ord stop time as RMSTR
 I TY="O" D  Q RMSTR
 .S RMSTR=$S(PRSP:PRSP,1:SP),RMSTR=$E($P(RMSTR,".",2)_"0000",1,4)
 ;
 ;continuous schedules with valid admin times
 F Q=1:1:$L(A,"-") D
 .S RMTM=DT_"."_$P(A,"-",Q)
 .S RMTM=$$FMADD^XLFDT(RMTM,,,D)
 .S RMTM=$P(RMTM,".",2),RMTM=$E(RMTM_"0000",1,4)
 .S $P(RMSTR,"-",Q)=RMTM
 Q RMSTR
 ;
CNVRT4(STR,SEP) ;Converts a time string to 4 digit for consistency         *83
 ;  STR - string of times
 ;  SEP - separator character between times
 ;
 N QQ
 F QQ=1:1:$L(STR,SEP) S $P(STR,SEP,QQ)=$E($P(STR,SEP,QQ)_"0000",1,4)
 Q STR
 ;
FINDGIVE(IEN) ;Finds the last Give date/time in the Audit log for a RM sts *83
 ;   When a Remove action occurs and saved to 53.79, the Give Action
 ;   Status & Action Date/Time are overwritten. This Function will
 ;   retrieve that Give info.
 ;
 ; Function returns - string formatted as the MAH report uses:
 ;
 ; date/time^by initials^action code^IEN of #53.79^IEN of user #200
 ;
 Q:$P(^PSB(53.79,IEN,0),U,9)'="RM" ""
 N DA,DAT,GIVE,FOUND,STR,QQ,PRVDA,PRVDAT,SKIP
 S (FOUND,STR,GIVE)=""
 F DA=99999:0 S DA=$O(^PSB(53.79,IEN,.9,DA),-1) Q:'DA  D  Q:FOUND
 .S DAT=^PSB(53.79,IEN,.9,DA,0),SKIP=0
 .; check for previous audit to be an Undo RM, if so skip it
 .I DAT["ACTION STATUS Set to 'GIVEN'" D  Q
 ..S PRVDA=$O(^PSB(53.79,IEN,.9,DA),-1) ;previous audit DA
 ..D:PRVDA
 ...S PRVDAT=^PSB(53.79,IEN,.9,PRVDA,0)
 ...I PRVDAT["ACTION STATUS 'REMOVED'",PRVDAT["deleted" S SKIP=1
 ..Q:SKIP
 ..S $P(STR,U,1)=$P(DAT,U,1)            ;init date just in case
 ..S $P(STR,U,2)=$P(DAT,"'",4)          ;by initials
 ..S $P(STR,U,3)="G"                    ;action sts Give
 ..S $P(STR,U,4)=IEN                    ;ien of transaction
 ..S $P(STR,U,5)=$P(DAT,U,2)            ;ien of user file 200
 ..S GIVE=1
 .Q:SKIP
 .;
 .;preferred date of action is in external form, as manual med edits
 .;can be back dated and show up here vs audit date/time for the Give
 .D:GIVE
 ..Q:DAT'["DATE/TIME Set to"
 ..S:DAT?.E1"@".E $P(STR,U,1)=$$ETFM($P(^(0),"'",2))
 ..;found real date
 ..S FOUND=1
 Q STR
 ;
ETFM(EX) ;convert external to FM date format
 N M,MM,MTH,TM,DY,Y,Y1,Y2,YYY,YYYY,Q
 S MTH=$E(EX,1,3)
 S Q=0
 F M="JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC" S Q=Q+.01,MM(M)=Q
 S MM=$E($P(MM(MTH),".",2)_"0",1,2)
 ;
 S DY=$P(EX," ",2),DY=$TR(DY,",","")
 S Y=$P(EX," ",3),YYYY=$P(Y,"@"),Y1=$E(YYYY,1,2)-17,Y2=$E(YYYY,3,4),YYYY=Y1_Y2
 S TM=$P(Y,"@",2),TM=$TR(TM,":","")
 Q $E(YYYY_MM_DY_"."_TM,1,12)
 ;
MEDHIST(LIST,DFN,OI,MAX) ;Last nn admin actions per a patients Orderable Item
 ;
 ; Reference/IA
 ; #6271 for Inpatient Medications to call into BCMA   *83
 ;   ** NOTE **
 ;     THIS API IS DIRECTLY/INDIRECTLY DEPENDANT ON 3 OTHER INTERNAL
 ;     API's: LASTSITE^PSBINJEC, RPC^PSBVDLUD, & FINDGIVE^PSBUTL
 ;   
 ; Input:
 ;   DFN - Patient num
 ;   OI  - Inpatient Meds Orderable Item ien
 ;   MAX - Max days back to search
 ; Output:
 ;   LIST - Array of actions formatted as :
 ;     DATE^ACTION^ORDNO^LSTSITE^LOCATION^NURSINITL
 ;
 K LIST
 N DTE,CNT,IEN,ACTN,GIVE,DATE,LSITE,ACTBY,NURINI,ORDN,LOC
 ;
 S DTE=DT+1
 F  S DTE=$O(^PSB(53.79,"AOIP",DFN,OI,DTE),-1) Q:'DTE  D  Q:$$FMDIFF^XLFDT($$NOW^XLFDT,DTE,1)>MAX
 .S IEN=0
 .F  S IEN=$O(^PSB(53.79,"AOIP",DFN,OI,DTE,IEN)) Q:'IEN  D  Q:$$FMDIFF^XLFDT($$NOW^XLFDT,DTE,1)>MAX
 ..S ACTN=$$GET1^DIQ(53.79,IEN,.09)
 ..S ORDN=$$GET1^DIQ(53.79,IEN,.11)
 ..S LOC=$$GET1^DIQ(53.79,IEN,.02)
 ..S ACTBY=$$GET1^DIQ(53.79,IEN,.07,"I")
 ..S NURINI=$$GET1^DIQ(200,ACTBY,1)
 ..Q:ACTN="NOT GIVEN"
 ..Q:$$FMDIFF^XLFDT($$NOW^XLFDT,DTE,1)>MAX
 ..S LSITE=$$LASTSITE^PSBINJEC(DFN,OI)
 ..S LIST(DTE)=DTE_U_ACTN_U_ORDN_U_LSITE_U_LOC_U_NURINI
 ..I ACTN="REMOVED" D
 ...S GIVE=$$FINDGIVE(IEN)
 ...S DATE=$P(GIVE,U)
 ...S NURINI=$P(GIVE,U,2)
 ...Q:$$FMDIFF^XLFDT($$NOW^XLFDT,DATE,1)>MAX
 ...S LIST(DATE)=DATE_U_"GIVEN"_U_ORDN_U_LSITE_U_LOC_U_NURINI
 Q
 ;
FIXADM ;Update ORD seg with GIVE status based on ALL ADM Records         *83
 ;  If any ADM's contain G then remove required for this ORDER
 N QQ,MRR,ADSTS,ADIEN,OIEN,RMTM
 S MRR=0,ADSTS=""
 F QQ=1:1:+$G(^TMP("PSB",$J,"CVRSHT",0)) D
 .Q:$E(^TMP("PSB",$J,"CVRSHT",QQ),1,3)="END"
 .I $E(^TMP("PSB",$J,"CVRSHT",QQ),1,3)="ORD" S OIEN=QQ,MRR=0 Q
 .I $E(^TMP("PSB",$J,"CVRSHT",QQ),1,2)="DD" D
 ..S MRR=$P(^TMP("PSB",$J,"CVRSHT",QQ),U,8)
 .;only update sts in ORD.14 if G found for any med
 .I $E(^TMP("PSB",$J,"CVRSHT",QQ),1,3)="ADM" D  Q:ADSTS="G"
 ..S ADSTS=$P(^TMP("PSB",$J,"CVRSHT",QQ),U,5)
 ..S ADIEN=$P(^TMP("PSB",$J,"CVRSHT",QQ),U,4)
 ..S:ADIEN RMTM=$P(^PSB(53.79,ADIEN,.1),U,7)
 ..;if a Give & MRR med, then the Remove time needs to be retrieved
 ..;again from 53.79.  The last info found by PSBVDLUD may not be for
 ..;this medlog record.
 ..D:ADSTS="G"&MRR
 ...S $P(^TMP("PSB",$J,"CVRSHT",OIEN),U,14)=ADSTS
 ...S $P(^TMP("PSB",$J,"CVRSHT",OIEN),U,36)=RMTM
 Q
 ;
REMOVES(DFN,TYPE) ;Searches xrefs for MRR type meds needing removal and adds    *83
 ;
 ;Type = (P)atient, (W)ard, (C)linic
 ;
 N PSBGNODE,PSBIEN,PSBZON,PSBRMDT,PSBMRRFL,PSBONX,PSBOITX,PSBOSP,PSBOSTS
 ;
 ;Xref APATCH search (backwards compatible xref)
 S PSBGNODE="^PSB(53.79,"_"""APATCH"""_","_DFN_")"
 F  S PSBGNODE=$Q(@PSBGNODE) Q:PSBGNODE']""  Q:($QS(PSBGNODE,2)'="APATCH")!($QS(PSBGNODE,3)'=DFN)  D
 .S PSBIEN=$QS(PSBGNODE,5),PSBONX=$P(^PSB(53.79,PSBIEN,.1),U)
 .Q:'$D(^PSB(53.79,PSBIEN,.5,1))                        ;no disp drug
 .Q:$P(^PSB(53.79,PSBIEN,.5,1,0),U,4)'="PATCH"          ;not a Patch
 .Q:$P(^PSB(53.79,PSBIEN,0),U,9)'="G"                   ;not Given
 .S PSBRMDT=$P(^PSB(53.79,PSBIEN,.1),"^",7) Q:'PSBRMDT  ;Scheduled Removal Time
 .Q:(PSBRMDT<PSBSTART)!(PSBRMDT>PSBSTOP)
 .D PSJ1^PSBVT(DFN,PSBONX)
 .Q:(TYPE="C")&('PSBCLIEN)                              ;not a clinic order
 .D SETMRR
 ;
 ;Xref AMRR search   (new xref for transdermal meds)
 S PSBGNODE="^PSB(53.79,"_"""AMRR"""_","_DFN_")"
 F  S PSBGNODE=$Q(@PSBGNODE) Q:PSBGNODE']""  Q:($QS(PSBGNODE,2)'="AMRR")!($QS(PSBGNODE,3)'=DFN)  D
 .S PSBIEN=$QS(PSBGNODE,5),PSBONX=$P(^PSB(53.79,PSBIEN,.1),U)
 .Q:$P(^PSB(53.79,PSBIEN,.5,1,0),U,4)="PATCH"           ;Is patch already seen
 .Q:'$D(^PSB(53.79,PSBIEN,.5,1))                        ;no disp drug
 .Q:'$P(^PSB(53.79,PSBIEN,.5,1,0),U,6)                  ;no MRR flag
 .Q:$P(^PSB(53.79,PSBIEN,0),U,9)'="G"                   ;not Given
 .S PSBRMDT=$P(^PSB(53.79,PSBIEN,.1),"^",7) Q:'PSBRMDT  ;Scheduled Removal Time
 .Q:(PSBRMDT<PSBSTART)!(PSBRMDT>PSBSTOP)
 .D PSJ1^PSBVT(DFN,PSBONX)
 .Q:(TYPE="C")&('PSBCLIEN)                              ;not a clinic order
 .D SETMRR
 ;
 D CLEAN^PSBVT
 Q
 ;
SETMRR ;Get and set MRR info for printing Removals
 ; If clinic order mode, skip removes for locations not on clinic list
 ;   If No list then All clinics desired.
 N CLNAM S CLNAM=$P(^PSB(53.79,PSBIEN,0),U,2)
 I '$G(PSBIENS) N PSBIENS S PSBIENS=PSBRPT
 I PSBCLINORD,$D(^PSB(53.69,+PSBIENS,2,"B")),CLNAM]"",'$D(^PSB(53.69,+PSBIENS,2,"B",CLNAM)) Q   ;not on selection list when list is present
 S PSBZON=$P(^PSB(53.79,PSBIEN,.1),"^")
 K ^TMP("PSJ1",$J) D EN^PSJBCMA1(DFN,PSBZON,1)
 Q:$G(^TMP("PSJ1",$J,0))=-1
 S PSBONX=$P(^TMP("PSJ1",$J,0),U,3)     ; ord num w/  type "U" or "V"
 S PSBOSTS=$P(^TMP("PSJ1",$J,1),U,10)   ; ord status
 S PSBOITX=$P(^TMP("PSJ1",$J,2),U,2)    ; order item (expanded)
 S PSBOSP=$P(^TMP("PSJ1",$J,4),U,7)     ; stop date FM
 S ^TMP("PSB",$J,DFN,PSBRMDT,PSBOITX,PSBONX,"RM")=""
 S PSBS(DFN,PSBONX,$S(PSBOSTS="A":"Active",PSBOSTS="H":"On Hold",PSBOSTS="D":"DC'd",PSBOSTS="DE":"DC'd (Edit)",PSBOSTS="E":"Expired",PSBOSTS="O":"On Call",PSBOSTS="R":"Renewed",1:"*Unknown*"))="" ;PSB*3*76 adds Renewed as status
 S PSBSTXP(PSBONX,DFN,$$DTFMT^PSBOMM2(PSBOSP))=""
 Q
