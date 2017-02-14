PSBO ;BIRMINGHAM/EFC - BCMA OUTPUTS ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**13,32,2,25,28,51,50,42,58,68,70,83**;Mar 2004;Build 89
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^ORD(101.24/3429
 ; ^PSDRUG(/221
 ;
 ;*68-Add PSBSIFL as 19th parameter to RPC tag to control printing of
 ;       special instruction/other print info.
 ;*58 - Tag WRAP previously wrapped on a max text limit of 250 char.
 ;       Since the use of Enhanced Order Checks, that limit has to 
 ;       be removed and the length of the input string will be used.
 ;*70 - Add PSBCLINORD as 20th parameter to RPC tag to control the 
 ;       type of order to appear on reports that want to be able to
 ;       show Clinic Orders or IM orders.  Set C=CO I=IM
 ;       CCR #1459: Adding clinic to BL and BZ chui labels.
 ;*83 - Add call to cleanup all PSB* variables for all reports run.
 ;
RPC(RESULTS,PSBTYPE,PSBDFN,PSBSTRT,PSBSTOP,PSBINCL,PSBDEV,PSBSORT,PSBOI,PSBWLOC,PSBWSORT,PSBFUTR,PSBORDNM,PSBRCRI,PSBLIST,PSBPST,PSBTR,PSBDIV,PSBSIFL,PSBCLINORD,PSB21,PSB22,PSB23,PSB24,PSB25,PSBCLLST) ;
 ;
 ; RPC: PSB REPORT
 ;
 ; Description:
 ; Used by the client to create individual patient extracts of
 ; CHUI report options to display on the client.
 ;
 ;
 S RESULTS=$NAME(^TMP("PSBO",$J))
 N PSBIENS,PSBRPT,PSBFDA,DIC,PSBANS
 N PSBMODE                                                       ;*70
 K ^TMP("PSBO",$J) S ^TMP("PSBO",$J,1)="-1^"
 S DFN=PSBDFN
 D NEW^PSBO1(.PSBRPT,PSBTYPE)
 I PSBDFN'="",PSBTYPE="MH"!(PSBTYPE="WA")!(PSBTYPE="ML")!(PSBTYPE="MT") D PAINCMT^PSBCSUTL(PSBDFN) ;;Add Comment if Pain Score entered in BCMA was marked "Entered in Error" in Vitals.
 I +PSBRPT(0)<1 S ^TMP("PSBO",$J,1)="-1^Error: "_$P(PSBRPT(0),U,2) Q
 S PSBIENS=+PSBRPT(0)_","
 S PSBSTRT(0)=$E($P(PSBSTRT,".",2)_"0000",1,4),PSBSTRT=PSBSTRT\1
 S PSBSTOP(0)=$E($P(PSBSTOP,".",2)_"0000",1,4),PSBSTOP=PSBSTOP\1
 D:$G(PSBDEV)]""
 .D NOW^%DTC
 .I $P(PSBDEV,U,2)="" D VAL^DIE(53.69,PSBIENS,.06,"F",PSBDEV,"PSBRET","PSBFDA")
 .I $P(PSBDEV,U,2)'="" D VAL^DIE(53.69,PSBIENS,.06,"F","`"_$P(PSBDEV,U,2),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.07,"F",$S($P(PSBRCRI,U)="QD":$P(PSBRCRI,U,2),1:%),"PSBRET","PSBFDA")
 D:$G(PSBOI)]"" VAL^DIE(53.69,PSBIENS,.09,"F",PSBOI,"PSBRET","PSBFDA")
 S:($G(PSBSORT)']"")&(PSBTYPE'="XA") PSBSORT="P" D VAL^DIE(53.69,PSBIENS,.11,"F",PSBSORT,"PSBRET","PSBFDA")
 I "^SF"[("^"_PSBTYPE) D VAL^DIE(53.69,PSBIENS,.51,"F",PSBSORT,"PSBRET","PSBFDA")
 S PSBPST=$TR($G(PSBPST),"^",",")
 D VAL^DIE(53.69,PSBIENS,.52,"F",PSBPST,"PSBRET","PSBFDA")
 S PSBTR=$TR($G(PSBTR),"^",",")
 I $G(PSBDIV)]"" D VAL^DIE(53.69,PSBIENS,.04,"F",$G(PSBDIV),"PSBRET","PSBFDA")
 D VAL^DIE(53.69,PSBIENS,2,"F",PSBTR,"PSBRET","PSBFDA")
 D VAL^DIE(53.69,PSBIENS,.12,"F","`"_PSBDFN,"PSBRET","PSBFDA")
 I $G(PSBWLOC)]"" S PSBFDA(53.69,PSBIENS,.13)=PSBWLOC
 D:$G(PSBWSORT)]"" VAL^DIE(53.69,PSBIENS,.15,"F",PSBWSORT,"PSBRET","PSBFDA")
 D VAL^DIE(53.69,PSBIENS,.16,"F",PSBSTRT,"PSBRET","PSBFDA")
 D VAL^DIE(53.69,PSBIENS,.17,"F",PSBSTRT(0),"PSBRET","PSBFDA")
 D VAL^DIE(53.69,PSBIENS,.18,"F",PSBSTOP,"PSBRET","PSBFDA")
 D VAL^DIE(53.69,PSBIENS,.19,"F",PSBSTOP(0),"PSBRET","PSBFDA")
 D:$G(PSBINCL)]""
 .D VAL^DIE(53.69,PSBIENS,.21,"F",+$P(PSBINCL,"^",1),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.22,"F",+$P(PSBINCL,"^",2),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.23,"F",+$P(PSBINCL,"^",3),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.24,"F",+$P(PSBINCL,"^",4),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.28,"F",+$P(PSBINCL,"^",5),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.29,"F",+$P(PSBINCL,"^",6),"PSBRET","PSBFDA")
 D:$G(PSBFUTR)]""
 .D VAL^DIE(53.69,PSBIENS,.25,"F",+$P(PSBFUTR,"^",1),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.26,"F",+$P(PSBFUTR,"^",2),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.27,"F",+$P(PSBFUTR,"^",3),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.41,"F",+$P(PSBFUTR,"^",4),"PSBRET","PSBFDA")
 .D VAL^DIE(53.69,PSBIENS,.61,"F",$TR(PSBFUTR,"^ ","~"),"PSBRET","PSBFDA")
 ;*68 add SIOPI flag when present
 D:$D(PSBSIFL)
 .D VAL^DIE(53.69,PSBIENS,3,"F",PSBSIFL,"PSBRET","PSBFDA")
 ;*70 add PSBCLINORD indicator when present
 D:$D(PSBCLINORD)
 .D VAL^DIE(53.69,PSBIENS,4,"F",PSBCLINORD,"PSBRET","PSBFDA")
 D FILE^DIE("","PSBFDA")
 I "^SF"'[("^"_PSBTYPE) I $G(PSBLIST(0),"")]"" D LIST^PSBO1(.PSBLIST)
 I "^SF"'[("^"_PSBTYPE) I $G(PSBCLLST(0),"")]"" D LIST^PSBO1(.PSBCLLST)
 I $G(PSBDEV)]"" D PRINT^PSBO1 S RESULTS=$NAME(^TMP("PSBO",$J)) Q
 D HFSOPEN^PSBUTL("RPC") I POP S ^TMP("PSBO",$J,1)="ERROR: UNABLE TO ACCESS HFS DIRECTORY "_$$DEFDIR^%ZISH(),^TMP("PSBO",$J,2)="PLEASE CHECK DIRECTORY WRITE PRIVILEGES." Q
 U IO D DQ(+PSBIENS)
 D HFSCLOSE^PSBUTL("RPC")
 S RESULTS=$NAME(^TMP("PSBO",$J))
 D:$G(PSBDEV)]"" PRINT^PSBO1
 Q
 ;
XQ(PSBTYPE) ; Called via Kernel Menus
 N PSBANS,PSBANS1,PSBRPT,PSBSAVE,DA,DIK,DR,DDSFILE,PSBCNT
 D NEW^PSBO1(.PSBRPT,PSBTYPE)
 I +PSBRPT(0)<1 W !,"Error: ",$P(PSBRPT(0),U,2) S DIR(0)="E" D ^DIR Q
 S DA=+PSBRPT(0),DR="[PSBO "_PSBTYPE_"]",DDSFILE=53.69 D ^DDS
 W @IOF
 I 'PSBSAVE W !,"Cancelling Request..." S DIK="^PSB(53.69," D ^DIK W "Cancelled!"
 D:PSBSAVE
 .;Check Drug to Patient Relationship.
 .I (PSBTYPE="BL")!(PSBTYPE="BZ") S PSBANS="" D CHECK^PSBO1  I PSBANS=0!($D(DIRUT)) W !,"Cancelling Request..." S DIK="^PSB(53.69," D ^DIK W "Cancelled!" Q
 .;
 .;*70  (CCR #1459 begin)
 .I $O(PSBCL(""))]"" D
 ..N PSBI
 ..S PSBCL="" F PSBI=0:1 S PSBCL=$O(PSBCL(PSBCL)) Q:PSBCL=""
 ..I PSBI=1 D  Q
 ...S PSBCL=$O(PSBCL(PSBCL)),$P(^PSB(53.69,DA,4),U,3)=$O(^SC("B",PSBCL,""))
 ..;
 ..K DIR,Y
 ..;
 ..S PSBCL="" F PSBCNT=3:1 S PSBCL=$O(PSBCL(PSBCL)) Q:PSBCL=""  D
 ...S DIR("A",PSBCNT)=(PSBCNT-2)_". "_PSBCL,PSBCL(PSBCL)=(PSBCNT-2)
 ..;
 ..S DIR(0)="NAO^1:"_(PSBCNT-3)   ;,DIR("B")=(PSBCNT-3)
 ..S DIR("A",1)="Select the appropriate clinic:"
 ..S DIR("A",2)=""
 ..S DIR("A",(PSBCNT+1))=""
 ..S DIR("A")="Enter a number 1 thru "_(PSBCNT-3)_": "
 ..S DIR("?")="Select a number from 1 - "_(PSBCNT-3)_" or <Return> to exit"
 ..;
 ..D ^DIR
 ..I Y=""!(Y=-1)!(Y=U) S PSBANS=0 Q
 ..S PSBCL="" F  S PSBCL=$O(PSBCL(PSBCL)) Q:PSBCL=""  D
 ...I PSBCL[" (Ward)" Q
 ...I Y=PSBCL(PSBCL) S $P(^PSB(53.69,DA,4),U,3)=$O(^SC("B",PSBCL,""))
 .K PSBCL
 .I $G(PSBANS)=0 D  Q
 ..W !,"Cancelling Request..." S DIK="^PSB(53.69," D ^DIK W "Cancelled!"
 .;*70 (CCR #-1459 end)
 .;
 .;Allow "'BROWSER" Device
 .S IOP=$$GET1^DIQ(53.69,DA_",",.06,"I"),PSBSIO=0 I IOP]"" D
 ..S IOP="`"_IOP,%ZIS="N"
 ..D ^%ZIS
 ..I IO=IO(0) S PSBSIO=1
 ..D HOME^%ZIS K IOP
 .I $$GET1^DIQ(53.69,DA_",",.06)["BROWSER"!(PSBSIO=1) S IOP=$$GET1^DIQ(53.69,DA_",",.06)_";132" D ^%ZIS U IO D DQ(DA) D ^%ZISC K IOP Q
 .;
 .W @IOF,"Submitting Your Report Request to TaskMan..."
 .S ZTIO=$$GET1^DIQ(53.69,DA_",",.06)
 .S ZTDTH=$P(^PSB(53.69,DA,0),U,7)
 .S ZTDESC="BCMA - "_$$GET1^DIQ(53.69,DA_",",.05)
 .S ZTRTN="DQ^PSBO("_DA_")"
 .D ^%ZTLOAD
 .W "Submitted!",!,"Your Task Number Is: ",$G(ZTSK),!
 K ^TMP("PSBO",$J)
 Q
 ;
DQ(PSBRPT) ; Dequeue report from Taskman
 N PSBDFN
 Q:'$D(^PSB(53.69,PSBRPT,0))  ; No Such Report
 S $P(^PSB(53.69,PSBRPT,0),U,8)=$G(ZTSK,"RPC")
 D SETUP,@("EN^PSBO"_$P(PSBRPT(0),U,5))
 K ^TMP("PSBO",$J),PSBSIFLG
 S ZTREQ="@"
 D CLEAN^PSBVT  ;*83 cleanup all PSB* variables for all reports called
 Q
 ;
IOM() ; Returns good margin or not
 Q:IOM'<132 1
 W !,"**************************************************************"
 W !,"* SORRY, Your selected DEVICE does not print 132 columns.    *"
 W !,"**************************************************************"
 W !
 Q 0
 ;
VAL(PSBFLDS) ; Validate that fields in PSBFLDS are filled in
 N PSB,PSBFLD,PSBMSG,PSBSTOP,PSBST,PSBDAYS S PSBSTRT=""
 F PSB=1:1 Q:$P(PSBFLDS,";",PSB)=""  S PSBFLD=$P(PSBFLDS,";",PSB),PSBFLD(PSBFLD)=$$GET^DDSVAL(53.69,DA,PSBFLD)
 I $D(PSBFLD(.11)) K:$E(PSBFLD(.11))="P" PSBFLD(.13),PSBFLD(.15) K:$E(PSBFLD(.11))="W" PSBFLD(.12)
 S PSB=""  F  S PSB=$O(PSBFLD(PSB)) Q:PSB=""  D:PSBFLD(PSB)=""
 .I '$D(PSBMSG) S PSBMSG(0)="UNABLE TO FILE REQUEST",PSBMSG(1)=" ",PSBMSG(2)="ERROR: MISSING DATA - ALL FIELDS ARE REQUIRED",PSBMSG(3)=" "
 .D FIELD^DID(53.69,PSB,"","TITLE;LABEL","PSB")
 .S Z="  Missing Field: "_$S(PSB("TITLE")]"":PSB("TITLE"),1:PSB("LABEL"))
 .S PSBMSG($O(PSBMSG(""),-1)+1)=Z
 ; Check Times
 D:$G(PSBFLD(.16))
 .S PSBSTRT=PSBFLD(.16)+$G(PSBFLD(.17))
 .D:$P($$GET1^DIQ(53.69,DA_",",.01),U)["MH"
 ..S PSBDAYS=$$GET1^DIQ(101.24,$$FIND1^DIC(101.24,"","X","ORRP BCMA MAH","B")_",",.42)  ;check maxdays
 ..S:PSBDAYS="" PSBDAYS=7
 ..S X=PSBSTRT\1 D H^%DTC S PSBST=%H+PSBDAYS    ;Determine stop date
 .S PSBSTOP=$S($G(PSBFLD(.18)):PSBFLD(.18),1:PSBFLD(.16))+$G(PSBFLD(.19))
 .I PSBSTOP<PSBSTRT S Y=$O(PSBMSG(""),-1)+1,PSBMSG(Y)="  Date: Stop Date/Time is before Start Date/Time"
 .I $P($$GET1^DIQ(53.69,DA_",",.01),U)["MH" S X=PSBSTOP\1 D H^%DTC I %H>PSBST S Y=$O(PSBMSG(""),-1)+1,PSBMSG(Y)="  The date range cannot exceed "_PSBDAYS_" day(s) as defined in the CPRS 'MAXIMUM DAYS BACK' parameter"
 Q:'$D(PSBMSG)  ; All is well
 D MSG^DDSUTL(.PSBMSG)
 S DDSERROR=1
 Q
 ;
SETUP ; Setup parameters for the report in PSBRPT
 N PSBWRDL,PSBINDX,PSBWRDA,QQ,PSBSORT,RECS
 S RECS=0          ;init RECS found to 0       *70
 K ^TMP("PSBO",$J)
 F X=0,.1,.2,.3,.4,.5,1 S PSBRPT(X)=$G(^PSB(53.69,PSBRPT,X))
 I $D(^PSB(53.69,PSBRPT,2)) M PSBRPT(2)=^PSB(53.69,PSBRPT,2)
 I $D(^PSB(53.69,PSBRPT,3)) M PSBRPT(3)=^PSB(53.69,PSBRPT,3)
 I $D(^PSB(53.69,PSBRPT,4)) M PSBRPT(4)=^PSB(53.69,PSBRPT,4)      ;*68
 I $G(PSBRPT(4))="" S PSBRPT(4)="^I^"          ;if null def to I   *70
 S PSBRPT(.52)=$P($G(^PSB(53.69,PSBRPT,.5)),U,2)
 S PSBSIFLG=$P($G(PSBRPT(4)),U)                                   ;*68
 S PSBCLINORD=$S($P($G(PSBRPT(4)),U,2)="C":1,1:0)
 I $P(PSBRPT(0),"-")="ST",PSBRPT(3)]"" Q   ;Running a MSF report PSB*3*28
 I $P(PSBRPT(0),"-")="SF",PSBRPT(.52)]"" Q   ;Running a MSF report PSB*3*28
 ;
 S PSBSORT=$P(PSBRPT(.1),U,1)               ;init PSBSORT         ;*70
 ;
 ;* * Patient Mode * *
 I PSBSORT="P" D  I 'PSBDFN Q RECS
 .S PSBDFN=+$P(PSBRPT(.1),U,2) Q:'PSBDFN
 .N VA,VADM S DFN=PSBDFN D DEM^VADPT
 .Q:(VADM(1)="")!(VA("PID")="")
 .S ^TMP("PSBO",$J,PSBDFN,0)=VADM(1)_U_VA("PID"),^TMP("PSBO",$J,"B",VADM(1),PSBDFN)=""
 .S RECS=1
 ;
 ;* * WARDs per Nurse file group & All patient DFN's * *          ;*70
 I PSBSORT="W" D
 .S PSBWRD=$P(PSBRPT(.1),U,3) Q:'PSBWRD
 .D WARD^NURSUT5("L^"_PSBWRD,.PSBWRDA)
 .Q:$O(PSBWRDA(""))=""
 .S QQ="" F  S QQ=$O(PSBWRDA(PSBWRD,2,QQ)) Q:QQ=""  S PSBWRDL=$P(PSBWRDA(PSBWRD,2,QQ,.01),U,2) D
 ..F PSBDFN=0:0 S PSBDFN=$O(^DPT("CN",PSBWRDL,PSBDFN)) Q:'PSBDFN  D
 ...S DFN=PSBDFN D DEM^VADPT
 ...Q:(VADM(1)="")!(VA("PID")="")
 ...S ^TMP("PSBO",$J,PSBDFN,0)=VADM(1)_U_VA("PID")
 ...; Determine Sort or default to Pt Name...
 ...S:$P(PSBRPT(.1),U,5)="P" PSBINDX=VADM(1)
 ...I $P(PSBRPT(.1),U,5)="B" S PSBINDX=$P($G(^DPT(PSBDFN,.101)),U) S:PSBINDX="" PSBINDX="** NO ROOM BED **"
 ...S:$P(PSBRPT(.1),U,5)="" PSBINDX=VADM(1)
 ...S:$G(PSBINDX)="" PSBINDX=VADM(1)
 ...S ^TMP("PSBO",$J,"B",PSBINDX,PSBDFN)=""
 .S:$D(^TMP("PSBO",$J)) RECS=1
 ;
 ;* * Clinics selected & All patient DFN's * *                    ;*70
 I PSBSORT="C" D
 .Q:'$D(PSBRPT(2))                  ;no Clinics selected
 .D CLIN(.PSBRPT)
 .M ^TMP("PSBO",$J)=^TMP("PSJCL",$J) K ^TMP("PSJCL",$J)
 .S:$D(^TMP("PSBO",$J)) RECS=1
 ;
 Q
 ;Q RECS
 ;
WRAP(X,Y,Z) ; Quick text wrap
 ;
 ; Input Parameters Description:
 ;  X: Left Column of display [Optional]
 ;  Y: Cols to wrap in [Optional]
 ;  Z: Text to wrap [Optional]
 ;
 N PSB
 F  Q:'$L(Z)  D
 .W:$X>X !
 .W:$X<X ?X
 .I $L(Z)<Y W Z S Z="" Q
 .F PSB=Y:-1:0 Q:$E(Z,PSB)=" "
 .S:PSB<1 PSB=Y
 .W $E(Z,1,PSB)
 .S Z=$E(Z,PSB+1,$L(Z))
 Q ""
 ;
PRNEFF(PSBEIECMT,PSBIEN) ;Check for PRN Error comment
 N PSBCMTCH
 I $P($G(PSBRPT(.2)),U,8)=0 S PSBCMTCH=0 F  S PSBCMTCH=$O(^PSB(53.79,PSBIEN,.3,PSBCMTCH)) Q:PSBCMTCH=""  D
 .I $P($G(^PSB(53.79,PSBIEN,.3,PSBCMTCH,0)),U)["**Pain Score of" S PSBEIECMT=" **This Pain Score may have been Entered in Error. See Vitals Package.**"
 Q PSBEIECMT
 ;
FILTERCO ; rebuild TMP using needed recs and remove clinics not wanted
 N QQ,COCNT,CLNAM
 I '$G(PSBIENS) N PSBIENS S PSBIENS=PSBRPT
 S COCNT=0 K ^TMP("PSJTMP",$J)
 K ^TMP("PSJTMP",$J)
 F QQ=0:0 S QQ=$O(^TMP("PSJ",$J,QQ)) Q:'QQ  D
 . Q:$P($G(^TMP("PSJ",$J,QQ,0)),U,3)["P"
 . S CLNAM=$P($G(^TMP("PSJ",$J,QQ,0)),U,11) Q:CLNAM=""   ;Not a CO
 . ;ignore orders that are CO and for a Clinic not asked for
 . I CLNAM]"",'$D(^PSB(53.69,+PSBIENS,2,"B",CLNAM)) Q
 . S COCNT=COCNT+1
 . M ^TMP("PSJTMP",$J,COCNT)=^TMP("PSJ",$J,QQ)
 K ^TMP("PSJ",$J) M ^TMP("PSJ",$J)=^TMP("PSJTMP",$J)
 K ^TMP("PSJTMP",$J)
 S:'$D(^TMP("PSJ",$J)) ^TMP("PSJ",$J,1,0)=-1
 Q
 ;
CLIN(RPTARR,DFNLST) ;Build DFN list of patient orders per Clinics selected
 ; Input:  RPTARR - Report request array from file 53.69.  (required) 
 ;         DFNLST - pass by ref array name if array needed and not
 ;                  a tmp global pass a 1.  (optional)
 ;                                           default is TMP global
 ;         DFNLST - array of DFN's only   
 ;
 N DFNARR,GLB,ROOT,STARTDT
 K ^TMP("PSJCL",$J)
 S STARTDT=$P($G(RPTARR(.1)),U,6)
 S:STARTDT="" STARTDT=$P($$NOW^XLFDT,".")
 ; 
 ;Begin query read with Unit Dose xref and report start date range
 S GLB=$NA(^PS(55,"AUDC",STARTDT)),ROOT=$E(GLB,1,13)
 D QUERY(GLB,ROOT,9999999,.RPTARR,.DFNARR)
 ;
 ;Now do query read for IV xref and report start date range
 S GLB=$NA(^PS(55,"AIVC",STARTDT)),ROOT=$E(GLB,1,13)
 D QUERY(GLB,ROOT,9999999,.RPTARR,.DFNARR)
 ;
 I $G(DFNLST) M DFNLST=DFNARR Q  ;if DFNLST then return array and quit
 D BLDTMP(.DFNARR)
 Q
 ;
QUERY(GLB,ROOT,RPSTOPDT,RPTAR,DFNAR) ;Loops thru global xref via $Query
 ;                            for qualifying recs to find DFN's
 N CLN,CLNNAM,DFN,STPDT,NOD1,NOD2
 I GLB["UD" D
 .S NOD1=5,NOD2=8
 E  D
 .S NOD1="IV",NOD2="DSS"
 ;
 F  S GLB=$Q(@GLB) Q:$E(GLB,1,13)'=ROOT  D
 .S STPDT=$P($QS(GLB,3),"."),CLN=$QS(GLB,4),DFN=$QS(GLB,5),OR=$QS(GLB,6)
 .Q:$D(DFNAR(DFN))                      ;quit if DFN already on ARR
 .S CLNODE=$G(^PS(55,DFN,NOD1,OR,NOD2))
 .Q:'$$CLINIC(CLNODE)                   ;not active bcma clin order
 .S CLNNAM=$$GET1^DIQ(44,CLN,.01)       ;get clinic name
 .Q:STPDT>RPSTOPDT                      ;quit if rec beyond stop date
 .Q:'$D(RPTAR(2,"B",CLNNAM))            ;quit if Not on Cln sel list
 .;
 .S DFNAR(DFN)=""                       ;Keep - Set DFN in array
 Q
 ;
BLDTMP(ARR) ;Build Tmp global for DFN's to be included on the report
 N VA,VADM,PSJINDX
 F DFN=0:0 S DFN=$O(ARR(DFN)) Q:'DFN  D
 .K VA,VADM D DEM^VADPT
 .Q:(VADM(1)="")!(VA("PID")="")
 .S ^TMP("PSJCL",$J,DFN,0)=VADM(1)_U_VA("PID")
 .S PSJINDX=VADM(1)
 .S ^TMP("PSJCL",$J,"B",PSJINDX,DFN)=""
 .S RECS=1
 Q
 ;
CLINIC(CL) ;Is this a Clinic order that would show on the VDL in CO mode also?
 Q:'($P(CL,"^",2)?7N!($P(CL,"^",2)?7N1".".N)) 0  ;no appt date, IM ord
 Q:'$D(^PS(53.46,"B",+CL)) 0                     ;no PTR to 44, IM ord
 N A S A=$O(^PS(53.46,"B",+CL,"")) Q:'A 0        ;no 53.46 ien, IM ord
 Q $P(^PS(53.46,A,0),"^",4)                      ;Send to BCMA? flag
