DGADDUTL ;ALB/PHH,EG,BAJ,ERC,CKN,TDM,LBD-PATIENT ADDRESS ; 8/19/13 11:13am
 ;;5.3;Registration;**658,695,730,688,808,851,872,915**;Aug 13, 1993;Build 6
 Q
ADDR ; validate/edit Patient address (entry for DG ADDRESS UPDATE option)
 N %,QUIT,DIC,Y,DFN,USERSEL
ADDRLOOP ;
 W !!
 K DIC,Y,DFN,USERSEL
 S DIC="^DPT(",DIC(0)="AEMZQ",DIC("A")="Veteran Name/SSN: " D ^DIC
 I $D(DTOUT)!($D(DUOUT)) Q
 Q:Y'>0
 ;
 S DFN=+Y,QUIT=0
 L +^DPT(DFN):3 E  W !!,"Patient is being edited. Try again later."  G ADDR
 F  D  Q:QUIT
 .W !!,"Do you want to update the (P)ermanent Address, (T)emporary Address, or (B)oth? "
 .R USERSEL:300
 .I '$T S USERSEL="^"
 .I USERSEL["^"!(USERSEL="") S QUIT=1 Q
 .S USERSEL=$TR(USERSEL,"ptb","PTB")
 .I USERSEL'="P",USERSEL'="T",USERSEL'="B" D  Q
 ..W !,"Invalid selection!"
 .I USERSEL="P"!(USERSEL="B") W ! D UPDATE(DFN,"PERM")
 .I USERSEL="T"!(USERSEL="B") D UPDATE(DFN,"TEMP")
 .S QUIT=1
 L -^DPT(DFN)
 G ADDRLOOP
ADD(DFN) ; validate/edit Patient address (entry point for routine DGREG)
 ;         Input  -- DFN
 ;
 N RETVAL,ADDYN
 ;Display the permanent address (DG*5.3*851)
 D DISPADD^DGADDUT2(DFN)
 S (RETVAL,ADDYN)=0
 F  D  Q:ADDYN
 .S ADDYN=$$ADDYN("Do you want to edit the Patient's Address")
 .S RETVAL=ADDYN
 .I ADDYN'=1,ADDYN'=2 S (ADDYN,RETVAL)=0
 .I 'ADDYN W !?5,"Enter 'YES' to edit Patient's Address or 'NO' to continue."
 I ADDYN=1,$G(DFN)'="",$D(^DPT(DFN,0)) D
 .D UPDATE(DFN,"PERM")
 .S RETVAL=1
 Q RETVAL
ADDYN(PROMPT) ; Yes/No Prompt to Edit/Validate Address
 ;         Input  -- None
 ;         Output --  1 = YES
 ;                    2 = NO
 ;                   -1 = Aborted
 ;
 N %
 W !,PROMPT
 D YN^DICN
 Q %
UPDATE(DFN,TYPE) ; Update the Address
 ;         Input  -- TYPE = "PERM" for Permanent Address
 ;                        = "TEMP" for Temporary Address
 ;         Output -- None
 ;         
 I TYPE'="PERM",TYPE'="TEMP" Q
 I TYPE="PERM" D
 .W !
 .N FLG S (FLG(1),FLG(2))=1
 .D ADDRED(DFN,.FLG)
 ;
 I TYPE="TEMP" D
 .D EDITTADR(DFN)
 Q
UPDDTTM(DFN,TYPE) ; Update the PATIENT file #2 with the current date and time
 ;
 D UPDDTTM^DGADDUT2(DFN,TYPE)
 Q
ADDRED(DFN,FLG) ; Address Edit (Code copied from DGREGAED and modified)
 ;Input:
 ;  DFN (required) - Internal Entry # of Patient File (#2)
 ;  FLG (optional) - Flags of 1 or 0; if null, 0 is assumed. Details:
 ;    FLG(1) - if 1, let user edit phone numbers (field #.131 and #.132)
 ;    FLG(2) - if 1, display before & after address for user confirmation
 N SRC,%,DGINPUT,I,X,Y
 S SRC="ADDUTL"
 D EN^DGREGAED(DFN,.FLG,SRC)
 ;
 ; Update the Date/Time Stamp
 ;The next line was disabled to fix problem of Date/Time stamp being
 ;updated even if no changes were made (DG*5.3*851).
 ;D UPDDTTM(DFN,TYPE)
 Q
GETPRIOR(DFN,DGPRIOR) ; Get prior address fields.
 N DGCURR,DGN,DGARRY,DGCIEN,DGST,DGCNTY
 D GETS^DIQ(2,DFN_",",".111;.112;.113;.114;.115;.117;.1112;.131;.132;.121;.118;.119;.12;.122;.1171:.1173","I","DGCURR")
 F DGN=.111,.112,.113,.114,.115,.117,.1112,.131,.132,.121,.118,.119,.12,.122,.1171,.1172,.1173 D
 . S DGARRY("OLD",DGN)=$G(DGCURR(2,DFN_",",DGN,"I"))
 M DGPRIOR=DGARRY("OLD")
 Q
GETUPDTS(DFN,DGINPUT) ; Get current address fields.
 N DGCURR,DGN,DGARRY
 D GETS^DIQ(2,DFN_",",".118;.119;.12;.122","I","DGCURR")
 F DGN=.118,.119,.12,.122 D
 . S DGARRY("NEW",DGN)=$G(DGCURR(2,DFN_",",DGN,"I"))
 M DGINPUT=DGARRY("NEW")
 Q
FILEYN(DGOLD,DGNEW) ; Determine whether or not to file to #301.7
 N RETVAL
 S RETVAL=0
 D
 .I DGOLD(.111)'=$G(DGNEW(.111)) S RETVAL=1 Q
 .I DGOLD(.112)'=$G(DGNEW(.112)) S RETVAL=1 Q
 .I DGOLD(.113)'=$G(DGNEW(.113)) S RETVAL=1 Q
 .I DGOLD(.114)'=$G(DGNEW(.114)) S RETVAL=1 Q
 .I DGOLD(.115)'=$P($G(DGNEW(.115)),"^",2) S RETVAL=1 Q
 .I DGOLD(.1112)'=$G(DGNEW(.1112)) S RETVAL=1 Q
 .I DGOLD(.117)'=$P($G(DGNEW(.117)),"^",2) S RETVAL=1 Q
 .I DGOLD(.131)'=$G(DGNEW(.131)) S RETVAL=1 Q
 .I DGOLD(.1171)'=$G(DGNEW(.1171)) S RETVAL=1 Q
 .I DGOLD(.1172)'=$G(DGNEW(.1172)) S RETVAL=1 Q
 .I DGOLD(.1173)'=$P($G(DGNEW(.1173)),"^",2) S RETVAL=1 Q
 .I DGOLD(.121)'=$G(DGNEW(.121)) S RETVAL=1 Q
 Q RETVAL
FOREIGN(DFN,CIEN,FILE,FIELD,COUNTRY) ;
 ; ** NOTE we have to default the value for "US" into the prompt if it is blank
 N FORGN,DA,DIR,DTOUT,DUOUT,DIROUT,DONE,INDX
 S:'$G(FILE) FILE=2  I '$G(FIELD) S FIELD=.1173
 S DIR(0)=FILE_","_FIELD,DONE=0 S:DFN DA=DFN
 S DIR("B")=$E($$CNTRYI^DGADDUTL(CIEN),1,19) I DIR("B")=-1 S DIR("B")="UNKNOWN COUNTRY"
 F  D  Q:DONE
 . D ^DIR
 . I $D(DTOUT) S DONE=1,FORGN=-1 Q
 . I $D(DUOUT)!$D(DIROUT) W !,"EXIT NOT ALLOWED" Q
 . I $D(DIRUT) W !,"This is a required response." Q
 . S COUNTRY=$P($G(Y),"^",2),FORGN=$$FORIEN($P($G(Y),"^")),DONE=1
 Q FORGN
UPDADDLG(DFN,DGPRIOR,DGINPUT) ; Update the IVM ADDRESS CHANGE LOG file #301.7
 ;
 D UPDADDLG^DGADDUT2(DFN,.DGPRIOR,.DGINPUT)
 Q
EDITTADR(DFN) ; Edit Temporary Address
 N DGPRIOR,DGCH,DGRPAN,DGDR,DGRPS
 I $G(DFN)="" Q
 ;I ($G(DFN)'?.N) Q
 ;
 ; Get the current Temporary Address and display it
 D GETTADR(DFN,.DGPRIOR)
 D DISPTADR(DFN,.DGPRIOR)
 W !!
 ;
 S DGCH=5,DGRPAN="1,2,3,4,5,",DGDR="",DGRPS=1
 D CHOICE^DGRPP
 D ^DGRPE
 ; Update the Date/Time Stamp
 D UPDDTTM(DFN,TYPE)
 Q
GETTADR(DFN,DGPRIOR) ; Get prior temporary address fields.
 N DGCURR,DGN,DGARRY,DGCIEN,DGST,DGCNTY
 D GETS^DIQ(2,DFN_",",".1211;.1212;.1213;.1214;.1215;.1216;.1217;.1218;.12105;.1219;.12111;.12112;.12113;.12114;.1221:.1223","I","DGCURR")
 F DGN=.1211,.1212,.1213,.1214,.1215,.1216,.1217,.1218,.12105,.1219,.12111,.12112,.12113,.12114,.1221,.1222,.1223 D
 .S DGARRY("OLD",DGN)=$G(DGCURR(2,DFN_",",DGN,"I"))
 M DGPRIOR=DGARRY("OLD")
 Q
DISPTADR(DFN,DGARRY) ; Display Temporary Address
 N DGADRACT,DGADR1,DGADR2,DGADR3,DGCITY,DGSTATE,DGZIP
 N DGCOUNTY,DGPHONE,DGFROMDT,DGTODT,DGPROV,DGPCODE,DGCNTRY,DGFORN
 ;
 S DGADRACT=$G(DGARRY(.12105))
 S DGADR1=$G(DGARRY(.1211))
 S DGADR2=$G(DGARRY(.1212))
 S DGADR3=$G(DGARRY(.1213))
 S DGCITY=$G(DGARRY(.1214))
 S DGSTATE=$G(DGARRY(.1215))
 S DGZIP=$G(DGARRY(.1216))
 S DGCOUNTY=$G(DGARRY(.12111))
 I DGCOUNTY'="",DGSTATE'="",$D(^DIC(5,DGSTATE,1,DGCOUNTY,0)) D
 .S DGCOUNTY=$P(^DIC(5,DGSTATE,1,DGCOUNTY,0),"^")_$S($P(^DIC(5,DGSTATE,1,DGCOUNTY,0),"^",4)'="":"("_$P(^DIC(5,DGSTATE,1,DGCOUNTY,0),"^",4)_")",1:"")
 ;changing to remove display of empty (), will only display if a code is in the 4th piece of the state file-Patch 872
 ;S DGCOUNTY=$P(^DIC(5,DGSTATE,1,DGCOUNTY,0),"^")_"( "_$P(^DIC(5,DGSTATE,1,DGCOUNTY,0),"^",4)
 I DGADRACT'="Y" S DGCOUNTY="NOT APPLICABLE"
 I DGSTATE'="",$D(^DIC(5,DGSTATE,0)) S DGSTATE=$P(^DIC(5,DGSTATE,0),"^",2)
 S DGPROV=$G(DGARRY(.1221))
 S DGPCODE=$G(DGARRY(.1222))
 S DGCNTRY=$G(DGARRY(.1223))
 S DGFORN=$$FORIEN(DGCNTRY)
 I DGCNTRY]"" S DGCNTRY=$$CNTRYI(DGCNTRY)
 S DGPHONE=$G(DGARRY(.1219))
 S DGFROMDT=$$FMTE^XLFDT($G(DGARRY(.1217)))
 S DGTODT=$$FMTE^XLFDT($G(DGARRY(.1218)))
 ;
 W !!,"Temporary Address: "
 I DGADRACT="Y" D
 .W:DGADR1'="" !?9,DGADR1
 .W:DGADR2'="" !?9,DGADR2
 .W:DGADR3'="" !?9,DGADR3
 .I DGFORN=0 D
 ..W !?9,$S(DGCITY'="":DGCITY,1:"")_$S(DGCITY'="":",",1:" ")_$S(DGSTATE'="":DGSTATE,1:"")_" "_$S(DGZIP'="":DGZIP,1:"")
 .I DGFORN W !?8,$S(DGPCODE'="":DGPCODE,1:"")_" "_$S(DGCITY'="":DGCITY,1:"")_$S(DGCITY'="":",",1:" ")_$S(DGPROV'="":DGPROV,1:"")
 ;commenting out, causes address to print 2x. Patch 872
 ;W !?9,$S(DGCITY'="":DGCITY,1:"")_","_$S(DGSTATE'="":DGSTATE,1:"")_" "_$S(DGZIP'="":DGZIP,1:"")
 ;Removing lines from dot structure Patch 872
 W !," County: "_DGCOUNTY
 W !,"  Phone: "_DGPHONE
 W !,"From/To: "_$P(DGFROMDT,",")_","_$P(DGFROMDT,", ",2)_"-"_$P(DGTODT,",")_","_$P(DGTODT,", ",2)
 ;
 I $G(DGARRY(.12105))="N" D
 .W:$G(DGARRY(.1211))="" !?9,"NO TEMPORARY ADDRESS"
 .W:$G(DGARRY(.1212))="" !?9,""
 .W !," County: NOT APPLICABLE"
 .W !,"  Phone: NOT APPLICABLE"
 .W !,"From/To: NOT APPLICABLE"
 Q
COUNTRY(DGC) ;
 ;where DGC is the external value of the country
 ;return value is in upper case display mode
 ;if DGC is invalid, return -1
 N DGCC,DGIEN
 ; if input is NULL change to US
 I $G(DGC)="" S DGC="USA"
 ; Get IEN from B index, error if not found
 S DGIEN=$O(^HL(779.004,"B",DGC,"")) Q:DGIEN']"" -1
 ; xlate IEN to POSTAL NAME
 S DGCC=$P(^HL(779.004,DGIEN,"SDS"),U,3)
 ; if POSTAL NAME = "<NULL>" return DESCRIPTION
 I DGCC="<NULL>" D
 . S DGCC=$$UPPER^DGUTL($P(^HL(779.004,DGIEN,0),U,2))
 Q DGCC
FOR(DGC) ;returns a 1 if address is foreign, a 0 if domestic, -1 if DGC is not valid
 ; DGC is the external value of the country (.01 field of file 779.004)
 N DGFOR
 S DGFOR=0
 I $G(DGC)="" Q DGFOR
 I '$D(^HL(779.004,"B",DGC)) Q -1
 I DGC'="USA" S DGFOR=1
 Q DGFOR
CNTRYI(DGIEN) ;where DGC is the internal value of the country
 ;return DGC as the display value for the country
 ;if the input value is not a valid IEN, return -1
 ;if the input value is null, return null
 N DGCC
 I $G(DGIEN)="" Q ""
 I '$D(^HL(779.004,DGIEN,0)) Q -1
 ; xlate IEN to POSTAL NAME
 S DGCC=$P(^HL(779.004,DGIEN,"SDS"),U,3)
 ; if POSTAL NAME = "<NULL>" return DESCRIPTION
 I DGCC="<NULL>" D
 . S DGCC=$$UPPER^DGUTL($P(^HL(779.004,DGIEN,0),U,2))
 Q DGCC
FORIEN(DGC) ;returns a 1 if address is foreign, a 0 if domestic, -1 if DGC is invalid
 ;DGC is the IEN of the country file (#779.004)
 N DGFOR
 S DGFOR=0
 I $G(DGC)="" Q DGFOR
 I DGC'?1.3N Q -1
 I '$D(^HL(779.004,DGC,0)) Q -1
 I DGC]"",(DGC'=$O(^HL(779.004,"B","USA",""))) S DGFOR=1
 Q DGFOR
