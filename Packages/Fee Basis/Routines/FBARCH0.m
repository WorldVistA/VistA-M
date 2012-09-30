FBARCH0 ; HINOIFO/RVD - ARCH IMPORT ELIGIBILITY AND UTILITY ; 01/08/11 12:30pm
 ;;3.5;FEE BASIS;**119,130,138**;JAN 30, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;Integration Agreements:
 ; ^DPT( - #2070, 10035
 ; ^DIE - #2053
 ; ^VASITE -#10112
 ; ^XUAF4 - #2171
 ; ^DIC(4 - #10090
 ; ^MPIF001 - #2701
 ; @XPDGREF - 2433
 ; DT^DILF - #2054
 Q
 ;
EN ; entry point
 ;
 N CNT,DFN,DIR,DTOUT,DUOUT,DIRUT,DIROUT,FBDATA,FBDATE,FBDIR,FBFILE,FBTOT,FBX,FBY,X,Y,Z
 K ^TMP("FBARCH",$J)
 S FBDIR=$$PWD^%ZISH
 ;
 S DIR("A")="Enter host file directory",DIR("B")=FBDIR
 S DIR("?",1)="Enter the full path specification where the host file may be found"
 S DIR("?")="or press return for the default directory "_FBDIR
 S DIR(0)="FO^3:60"
 D ^DIR K DIR
 S FBDIR=$S($D(DUOUT)!$D(DTOUT):-1,1:Y)
 I FBDIR=-1!(FBDIR="") G STARTX
 ;
 S DIR("A")="Enter host file name"
 S DIR("?")="Enter the name of the host file to upload"
 S DIR(0)="FO^3:60"
 D ^DIR K DIR
 S FBFILE=$S($D(DUOUT)!$D(DTOUT):-1,1:Y)
 I FBFILE=-1!(FBFILE="") G STARTX
 S FBX(FBFILE)="",Z=$$LIST^%ZISH(FBDIR,"FBX","FBY") K FBX,FBY
 I 'Z D  G STARTX
 .W !!,"File "_FBFILE_" not found in directory "_FBDIR
 .S DIR(0)="E" D ^DIR
 .Q
 ; load data into global ^TMP("FBARCH",$J,n)
 W !!,"Loading data into temporary global..."
 S Z=$$FTG^%ZISH(FBDIR,FBFILE,$NA(^TMP("FBARCH",$J,1)),3)
 I 'Z D  G STARTX
 .W !!,"Unable to load data from file "_FBDIR_FBFILE
 .S DIR(0)="E" D ^DIR
 .Q
 S FBTOT=$O(^TMP("FBARCH",$J,""),-1) ; total number of records in the file
 I 'FBTOT W "No records found." S DIR(0)="E" D ^DIR G STARTX
 W "Done."
 W !!,FBTOT," records found",!
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to continue uploading ARCH eligibility data from this file"
 D ^DIR K DIR
 I Y'>0 G STARTX
 ; process records
 W !!,"Processing records..."
 S CNT=0,Z="" F  S Z=$O(^TMP("FBARCH",$J,Z)) Q:'Z  D
 .S FBDATA=$G(^TMP("FBARCH",$J,Z))
 .; get and validate DFN
 .S DFN=+$$GETDFN^MPIF001($P(FBDATA,U)) I DFN'>0 Q
 .; get and validate date
 .D DT^DILF("E",$P(FBDATA,U,2),.FBDATE) I FBDATE'>0 Q
 .S CNT=CNT+1 I CNT#10=0 W "."
 .; process record
 .D SETREC(DFN,FBDATE)
 .Q
 W "Done"
 W !!,CNT," records processed."
 W !,"Upload complete",!
 S DIR(0)="E" D ^DIR
STARTX ;
 K ^TMP("FBARCH",$J)
 Q
 ;
SETREC(DFN,FBDATE) ; create/update entry in file 161
 ; DFN - ien in file 2/file 161
 ; FBDATE - ARCH eligibility date
 N DA,DIC,DINUM,DLAYGO,IEN,X,Y
 ; add this patient to file 161 if there's no existing entry
 S IEN=$O(^FBAAA("B",DFN,""))
 I 'IEN K DO S (X,DINUM,DA)=DFN,DIC="^FBAAA(",DIC(0)="LM",DLAYGO=161 D FILE^DICN S IEN=+Y K DINUM
 ; update ARCH eligibility
 I $O(^FBAAA("ARCH",FBDATE,DFN,""))>0 Q  ; ARCH eligibility record already exists
 K DA,DO
 S X=FBDATE,DA(1)=IEN,DLAYGO=161.011,DIC="^FBAAA("_IEN_",""ARCHFEE"",",DIC(0)="LM",DIC("DR")="2////1"
 D FILE^DICN
 Q
 ;
ELIG(DFN,FBBDT,FBEDT,FBDATA) ;this function returns if pt is ARCH eligible or NOT
 ; input: = DFN - patient IEN (pointer to file #161)
 ;          FBBDT - beginning dt
 ;          FBEDT - ending dt
 ; output: FBDATA = 1 if eligible and FBDATA()=DFN^0 or 1^date of eligibility
 ;          from most recent to the oldest
 ;  FBDATA = 0 if not eligible
 ;
 N FBI,FBDAT,FBEL,FBHDT,FBCNT,FBELDT,FBSAV1,FBSAV2,FBJ
 S (FBHDT,FBEL,FBELDT,FBCNT,FBDATA)=0
 S FBBDT=$S(FBBDT>0:FBBDT,1:0)
 S FBEDT=$S(FBEDT>0:FBEDT,1:9999999)
 Q:(FBEDT<FBBDT) FBDATA
 Q:'$D(^FBAAA(DFN,"ARCHFEE")) FBDATA
 S FBI=$O(^FBAAA(DFN,"ARCHFEE","B"," "),-1)
 S FBJ=$O(^FBAAA(DFN,"ARCHFEE","B",FBI," "),-1),FBDAT=$G(^FBAAA(DFN,"ARCHFEE",FBJ,0))
 I (FBEDT=FBI)!(FBEDT>FBI) D
 .S FBEL=$P(FBDAT,U,2)
 .S FBCNT=FBCNT+1 S FBDATA(FBCNT)=FBEL_U_FBI,FBDATA=FBEL
 F  S FBI=$O(^FBAAA(DFN,"ARCHFEE","B",FBI),-1) Q:FBI'>0  D
 .S FBJ=$O(^FBAAA(DFN,"ARCHFEE","B",FBI,0)),FBDAT=$G(^FBAAA(DFN,"ARCHFEE",FBJ,0))
 .Q:(FBEDT<FBI)
 .S FBEL=$P(FBDAT,U,2),FBCNT=FBCNT+1
 .S FBDATA(FBCNT)=FBEL_U_FBI
 ;
 S:$G(FBDATA(1)) FBDATA=$P(FBDATA(1),U)
 Q FBDATA
 ;
LIST(FBBDT,FBEDT) ;this function returns a list of ARCH patients w/in the date range.
 ; input: = FBBGT - beginning dt
 ;          FBEDT - ending dt
 ; output:= number of ARCH eligible pt and ^TMP($J,"ARCHFEE",#)=DFN^0 or 1^date of eligibility
 ;          from the OLDEST to the MOST RECENT
 ; FBJ - internal entry number of file #161 which is DINUM to Patient File (2)
 N FBCOUNT,FBI,FBJ,FBEDAT,FBHDAT,FBELDA,FBELDT,FBEL,FBHDT,FBH,FBDFI
 K ^TMP($J,"ARCHFEE") S (FBI,FBCOUNT,FBELDT)=0
 Q:'$D(^FBAAA("ARCH")) FBCOUNT
 S FBBDT=$S(FBBDT>0:FBBDT,1:0)
 S FBEDT=$S(FBEDT>0:FBEDT,1:9999999)
 Q:(FBEDT<FBBDT) FBCOUNT
 F  S FBI=$O(^FBAAA("ARCH",FBI)) Q:FBI=""  D
 .F FBJ=0:0 S FBJ=$O(^FBAAA("ARCH",FBI,FBJ)) Q:FBJ'>0  D
 ..S FBDFI=$O(^FBAAA("ARCH",FBI,FBJ,0))
 ..S FBEDAT=$G(^FBAAA(FBJ,"ARCHFEE",FBDFI,0)),FBELDT=$P(FBEDAT,U)
 ..Q:(FBEDT<FBELDT)
 ..S FBCOUNT=FBCOUNT+1
 ..S ^TMP($J,"ARCHFEE",FBCOUNT)=FBJ_U_$P(FBEDAT,U,2)_U_FBELDT
 Q FBCOUNT
 ;
PARSE(FB) ; parse - remove double quotes and trailing blanks if any
 N I,B
 Q:FB="" FB
 S:$E(FB,1)="""" FB=$E(FB,2,$L(FB))
 S:$E(FB,$L(FB))="""" FB=$E(FB,1,($L(FB)-1))
 Q:$E(FB,$L(FB))'=" " FB ; Last char is non-blank
 F I=$L(FB):-1:1 Q:$E(FB,I)'=" "  S B=$E(FB,1,I-1)
 S FB=B
 Q FB
 ;
GETDELAY() ; return the Project ARCH Reminder Delay - default is 1.
 N FBDELAY
 S FBDELAY=$P($G(^FBAA(161.4,1,"ARCH")),U)
 Q $S(FBDELAY]"":FBDELAY,1:1)
 ;
SETDELAY ; Edit the Fee Basis Site Parameters for the Project ARCH Reminder Delay
 N DIE,DIC,DA,DR,FBPOP
 D SITEP^FBAAUTL Q:FBPOP
 W !! S DIE="^FBAA(161.4,",DIC(0)="AELQ",DA=1,DR="38//1" D ^DIE
 Q
 ;
