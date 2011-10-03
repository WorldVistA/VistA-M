YSCLSERV ;DALOI/RLM-Clozapine data server ;24 APR 1990
 ;;5.01;MENTAL HEALTH;**18,22,26,47,61,69,74,90,92**;Dec 30, 1994;Build 7
 ; Reference to ^%ZOSF supported by IA #10096
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^DD("DD" supported by IA #10017
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^PSDRUG supported by IA #25
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^VA(200 supported by IA #10060
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to $$FMTE^XLFDT() supported by IA #10103
 ; Reference to ^PSDRUG supported by IA #221
 ; Reference to ^XMD supported by IA #10070
START ;
 K ^TMP($J,"YSCLDATA")
 S YSDEBUG=$P(^YSCL(603.03,1,0),"^",3)
 S YSCLST=$P($$SITE^VASITE,"^",3)
 S YSCLSTN=$P($$SITE^VASITE,"^",2)
 ;Determine station number
 S X=XQSUB X ^%ZOSF("UPPERCASE") S YSCLSUB=Y
 S ^TMP($J,"YSCLDATA",1)=$S(YSDEBUG:"DEBUG ",1:"")_YSCLSUB_" triggered at "_YSCLST_" by "_XMFROM_" on "_XQDATE
 ;The first line of the message tells who requested the action and when
 D
  . S YSACTION=$S(YSCLSUB["REMOVE"!(YSCLSUB["DELETE"):"data deleted",YSCLSUB["REPORT":"report generated",YSCLSUB["REBUILD":"data verified",YSCLSUB["UPDATE":"data updated",YSCLSUB["DATESET":"date set",1:"CONT")
  . I YSACTION="CONT" S YSACTION=$S(YSCLSUB["DEMOG RESET":"Demographics Flag Reset",YSCLSUB["DEBUG":"Debug Mode set",YSCLSUB["AUTH":"Authorization",YSCLSUB["LOCK":"Lock",1:"Site Lock")
  . S ^TMP($J,"YSCLDATA",2)="No "_$S(YSDEBUG:"DEBUG ",1:"")_YSACTION_" at "_YSCLST
 ;The second line tells when the server is activated and no data can be
 ;gathered from the MailMan message.  This line gets replaced if the
 ;server finds something to do.
 S YSCLLNT=1 I YSCLSUB["REMOVE"!(YSCLSUB["DELETE") G DELETE
 ;If the subject contains the word REMOVE or DELETE delete those entries from the list.
 I YSCLSUB["REPORT" G REPORT
 ;If the subject contains "REPORT" send a report of the currently registered patients to the Clozapine group on Forum
 ;I YSCLSUB["REBUILD" G REBUILD
 I YSCLSUB["RESEND" G RESEND
 I YSCLSUB["UPDATE" G UPDATE
 ;I YSCLSUB["CHECKSUM" G CSUM^YSCLSRV1
 I YSCLSUB["DATESET" G DSET
 I YSCLSUB["DEBUG" G DEBUG
 I YSCLSUB["PATIENT" G ^YSCLSRV3
 I YSCLSUB["LOCKOUT" G LOCK^YSCLSRV3
 I YSCLSUB="DEMOG RESET" G DEMOG^YSCLSRV3
 I YSCLSUB["AUTHORIZE" G AUTH^YSCLSRV3
 I YSCLSUB="OVERRIDE" G OVRRID^YSCLSRV2
 I YSCLSUB="CLAPI" G CLAPI^YSCLSRV2
 I YSCLSUB="CL1API" G CL1API^YSCLSRV2
 I YSCLSUB["DISCON" G DCON^YSCLSRV2
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . ;Verify that + of site number matches local site number
  . I XMRG'?2U5N1","9N1","1U S YSCLER=" is in error and was not added at " D OUT Q
  . I $P(XMRG,",")'?2U5N S YSCLER=" is not a valid Clozapine number " D OUT Q
  . I $P(XMRG,",",2)'?9N S YSCLER=" An SSN must be 9 numbers " D OUT Q
  . I $P(XMRG,",",3)'="B",$P(XMRG,",",3)'="W",$P(XMRG,",",3)'="M" S YSCLER=" You must specify Weekly, Biweekly, or Monthly " D OUT Q
  . ;Validate the format of the data in the message and report the error.
  . S DIC="^DPT(",DIC(0)="X",D="SSN",X=$P(XMRG,",",2) I '$D(^DPT("SSN",X)) S YSCLER=" SSN does not exist at " D OUT Q
  . ;Do not add data for records where the SSN sent is not in the local database
  . I $D(^YSCL(603.01,"B",$P(XMRG,","))) S YSCLX=$O(^YSCL(603.01,"B",$P(XMRG,","),"")) S:YSCLX]"" YSCLX=$P(^YSCL(603.01,YSCLX,0),"^",2),YSCLER=" Clozapine # is in use by "_$P($G(^DPT(YSCLX,0)),"^")_" at " D OUT Q
  . D MIX^DIC1 S YSCLPT=+Y I Y=-1 S YSCLER=" could not be added at " D OUT Q
  . ;Add the data and report any errors to the Roll-Up group at Forum.
  . K DD S DIC="^YSCL(603.01,",X=$P(XMRG,","),DIC("DR")="1////"_YSCLPT_";2////"_$P(XMRG,",",3) K DO D FILE^DICN
  . S YSCLX=$O(^YSCL(603.01,"B",$P(XMRG,","),"")) S:YSCLX]"" YSCLX=$P(^YSCL(603.01,YSCLX,0),"^",2),YSCLER=" assigned to "_$P($G(^DPT(YSCLX,0)),"^")_" at " D OUT
EXIT ;If all went well, report that too.
 S YSDEBUG=$P(^YSCL(603.03,1,0),"^",3)
 S %H=$H D YMD^%DTC S XMDUN="NCCC LOGGER",XMDUZ=".5",XMSUB=$S(YSDEBUG:"DEBUG ",YSCLSUB["DEBUG":"DEBUG ",1:"")_YSCLST_" NCCC ENROLLER ("_X_%_")",XMTEXT="^TMP($J,""YSCLDATA"","
 K XMY S XMY("G.CLOZAPINE ROLL-UP@FORUM.VA.GOV")=""
 I YSDEBUG!(YSCLSUB["DEBUG") S XMY("G.CLOZAPINE DEBUG@FO-DALLAS.MED.VA.GOV")=""
 D ^XMD
 ;Mail the errors and successes back to the Roll-Up group at Forum.
 K ^TMP($J,"YSCLDATA")
 K %,%DT,%H,D,DA,DD,DIC,DIE,DIK,RET,X,XMDUN,XMDUZ,XMER,XMFROM
 K XMREC,XMRG,XMSUB,XMTEXT,XMY,XMZ,XQDATE,XQSUB,Y,YSA,YSACTION,YSCLTYPE
 K YSCL28,YSCLA,YSCLAA,YSCLB,YSCLC,YSCLDA,YSCLDA1,YSCLDATA,YSCLDEA1
 K YSCLDFN,YSCLDM,YSCLDOC,YSCLDOM,YSCLDR,YSCLDRA,YSCLDRB,YSCLDTA,YSCLERR
 K YSCLDUZ,YSCLED,YSCLER,YSCLFDA,YSCLFRQ,YSCLLNT,YSCLNM,YSCLOVR,YSCLSITE
 K YSCLPT,YSCLRPT,YSCLSD1,YSCLSDT,YSCLSSN,YSCLST,YSCLSTN,YSCLSUB,YSCLTC
 K YSCLRX,YSCLSAND,YSCLWB,YSCLX,YSCLYN,YSDEBUG,YSI,YSOFF,YSPR,ZTQUEUED,ZTSK
 Q
DELETE ;Allow the NCCC users to delete clozapine registration at the individual sites
 S YSCLLNT=1 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . I XMRG="**++**DELETEALL**++**" D DELALL Q
  . I '$D(^YSCL(603.01,"B",$P(XMRG,","))) S YSCLER=" "_$P(XMRG,",")_" is not registered at " D OUT Q
  . S YSCLDFN=$O(^DPT("SSN",$P(XMRG,",",2),"")) I YSCLDFN="" S YSCLER=" "_$P(XMRG,",")_" is not a valid SSN at " D OUT Q
  . I '$D(^YSCL(603.01,"C",YSCLDFN)) S YSCLER=" "_$P(XMRG,",",2)_" is not registered at " D OUT Q
  . S YSCLA=$O(^YSCL(603.01,"B",$P(XMRG,","),"")) I YSCLA="" S YSCLER=" "_$P(XMRG,",")_" is not a valid entry at " D OUT Q
  . K ^YSCL(603.01,YSCLA),^YSCL(603.01,"B",$P(XMRG,","),YSCLA),^YSCL(603.01,"C",YSCLDFN,YSCLA)
  . S YSCLER=" removed at " D OUT
  . ;I $D(^YSCL(603.01,"C",+Y)) K ^YSCL(603.01,YSCLA),^YSCL(603.01,"B",$P(XMRG,","),YSCLA),^YSCL(603.01,"C",YSCLDFN,YSCLA) S YSCLER=" removed at " D OUT Q  ;RLM 9-29-99 ADDED QUIT
 G EXIT
DELALL ;Delete all patients in file 603.01
 S YSCLA=0 F  S YSCLA=$O(^YSCL(603.01,YSCLA)) Q:YSCLA=""  D
  . I YSCLA S YSCLER=$P(^YSCL(603.01,YSCLA,0),"^",1)_", "_$P(^DPT($P(^YSCL(603.01,YSCLA,0),"^",2),0),"^",9)_", ("_$P(^YSCL(603.01,YSCLA,0),"^",3)_") gdeleted at " D OUT
  . K ^YSCL(603.01,YSCLA)
 Q
REPORT ;send report of current registrations to the Clozapine group on Forum
 D REPORT^YSCLSRV2 G EXIT
OUT S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)=XMRG_YSCLER_YSCLST Q
 ;Build the text for the return message here.
REBUILD ;
 D REBUILD^YSCLSRV2 G EXIT
UPDATE ;Update record with Monthly, Weekly or Bi-weekly status
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . I XMRG'?2U5N1","9N1","1U S YSCLER=" is in error and was not added at " D OUT Q
  . I $P(XMRG,",")'?2U5N S YSCLER=" is not a valid Clozapine number format " D OUT Q
  . I $P(XMRG,",",2)'?9N S YSCLER=" An SSN must be 9 numbers " D OUT Q
  . I $P(XMRG,",",3)'="B",$P(XMRG,",",3)'="W",$P(XMRG,",",3)'="M" S YSCLER=" You must specify Monthly, Weekly or Biweekly " D OUT Q  ;RLM 06/15/05
  . S YSCLNM=$P(XMRG,","),YSCLSSN=$P(XMRG,",",2),YSCLWB=$P(XMRG,",",3)
  . I '$D(^YSCL(603.01,"B",YSCLNM)) S YSCLER=" does not exist at " D OUT Q
  . S YSCLDA=$O(^DPT("SSN",YSCLSSN,0))
  . I YSCLDA="" S YSCLER=" SSN does not exist at " D OUT Q
  . I $O(^YSCL(603.01,"B",YSCLNM,0))="" S YSCLER=" SSN not in Clozapine file " D OUT Q
  . I $O(^DPT("SSN",YSCLSSN,YSCLDA)) S YSCLER=" SSN has more than one owner " D OUT Q
  . I $O(^YSCL(603.01,"B",YSCLNM,0))'=$O(^YSCL(603.01,"C",YSCLDA,0)) S YSCLER=" SSN ("_YSCLSSN_","_$P(^DPT(YSCLDA,0),"^")_") has multiple Clozapine Numbers at " D OUT
  . I $O(^YSCL(603.01,"B",YSCLNM,0))=$O(^YSCL(603.01,"C",YSCLDA,0)) D
  . . S YSCLDA1=$O(^YSCL(603.01,"B",YSCLNM,0)) S $P(^YSCL(603.01,YSCLDA1,0),"^",3)=YSCLWB
  . . S YSCLER=" "_YSCLNM_" ("_$P(^DPT(YSCLDA,0),"^")_") updated to "_$S(YSCLWB="M":"Monthly",YSCLWB="W":"Weekly",YSCLWB="B":"Bi-weekly",1:"Unknown")_" at " D OUT ;06/15/05
 G EXIT
RESEND ;Trigger retransmission of Clozapine data
 X XMREC
 K %DT S X=XMRG,%DT="P" D ^%DT I Y=-1 S YSCLER=" is an invalid date, RESEND not triggered at " D OUT G EXIT
 S YSCLED=Y,(YSCLSDT,X)=Y D H^%DTC I %H#7'=5 S YSCLER=" is not a Tuesday, RESEND not triggered at " D OUT G EXIT
 D SERV^YSCLTST2
 S Y=YSCLSDT X ^DD("DD") S YSCLER=" - Resend triggered (local task #"_$G(ZTSK)_") by "_XMFROM_" for "_Y_" at " D OUT
 G EXIT
DSET ;Set the day of the week for the roll-up to run.
 X XMREC Q:XMER<0  S X=$TR(XMRG,"- ","")
 S YSOFF=$S(X="SUNDAY":0,X="MONDAY":1,X="TUESDAY":2,X="WEDNESDAY":3,X="THURSDAY":4,X="FRIDAY":5,X="SATURDAY":6,1:7)
 I YSOFF>6 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)=X_" isn't a valid day of the week." G EXIT
 S $P(^YSCL(603.03,1,0),"^",2)=X
 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="Run day set to "_X
 G EXIT
 Q
DEBUG ;Turn debug mode on and off.
 I YSCLSUB["DEBUG ON" D
  . S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="Debug Mode is "_$S(YSDEBUG:"already",1:"now")_" ON at "_YSCLSTN
  . S $P(^YSCL(603.03,1,0),"^",3)=1
 I YSCLSUB["DEBUG OFF" D
  . S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="Debug Mode is "_$S('YSDEBUG:"already",1:"now")_" OFF at "_YSCLSTN
  . S $P(^YSCL(603.03,1,0),"^",3)=0
 G EXIT
ZEOR ;YSCLSERV
