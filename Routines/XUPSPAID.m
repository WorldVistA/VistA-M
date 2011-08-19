XUPSPAID ;CS/GRR/RAM/DW - New Person file Update & Report ; 1 Jan 2004
 ;;8.0;KERNEL;**309,343**; Jul 10, 1995;
 ;
 Q
 ;
EN ; - entry point
 ;
 N DIRUT,X,Y
 ;
 I $E(XUPSACT,1)="U" D
 . W !!,"  *********************************************"
 . W !,"  *This option will UPDATE eligible New Person*"
 . W !,"  *file (#200) entries with missing DOB or SEX*"
 . W !,"  *********************************************"
 ;
 W !!,"The reports will be sent to you via MailMan",!
 ;
 S DIR(0)="YA",DIR("B")="Yes",DIR("A")="Do you wish to continue? "
 S DIR("?")="Enter 'Yes' to continue or 'No' to quit"
 D ^DIR K DIR ;ask user if they want to continue with option
 Q:'Y!($D(DIRUT))  ;user responded No or with '^' to exit
 ;
 D QUE
 ;
 K XUPSACT
 Q
 ;
QUE ;Que the task
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZUSR,POP,X,ERR,IOP
 W !
 S ZTIO=""
 S ZTRTN="EN1^XUPSPAID"
 S ZTSAVE("XUPSACT")=""
 I $E(XUPSACT,1)="U" S ZTDESC="XUPS NPF UPDATE"
 I $E(XUPSACT,1)="P" S ZTDESC="XUPS NPF PREUPDATE REPORT"
 D ^%ZTLOAD
 D ^%ZISC,HOME^%ZIS
 W !,$S($D(ZTSK):"REQUEST QUEUED AS TASK#"_ZTSK,1:"REQUEST CANCELLED!")
 ;
 Q
 ;
EN1 ;
 N IEN,XUPSDIFF,XUPSUPD,XUT,XUNPFT,XUUPDT
 S (XUNPFT,XUUPDT)=0
 ;
 K ^TMP("XUPS PAID",$J)
 K ^TMP("XUPS DIFF",$J)
 K ^TMP("XUPS UPD",$J)
 ;
 S XUPSDIFF("SSN")=0
 S XUPSDIFF("NAME")=0
 S XUPSDIFF("SEX")=0
 S XUPSDIFF("DOB")=0
 ;
 S XUPSUPD("SEX")=0
 S XUPSUPD("DOB")=0
 ;
 S IEN=0
 F  S IEN=$O(^PRSPC(IEN)) Q:'IEN  D RECORD
 ;
 S XUT(1)=$G(XUNPFT)
 S XUT(2)=$G(XUUPDT)
 I $E(XUPSACT,1)="U" D NOTICE^XUPSPD1(.XUT)
 ;
 D REPORT
 ;
 Q
 ;
REPORT ;Pre-update reports
 ;
 N CNTG,DATA,DATA1,IEN,CNT,CNTU,CNTD
 S (CNTG,CNT,CNTU,CNTD)=0
 ;
 ;The difference report
 D HD("XUPS DIFF")
 S IEN=0
 F  S IEN=$O(^TMP("XUPS PAID",$J,"DIFF",IEN)) Q:'IEN  D
 .S DATA=^TMP("XUPS PAID",$J,"DIFF",IEN)
 .D FL("XUPS DIFF",DATA)
 .S CNTD=$G(CNTD)+1
 S CNT=$G(CNT)+1
 S ^TMP("XUPS DIFF",$J,CNT)=""
 S CNT=$G(CNT)+1
 S ^TMP("XUPS DIFF",$J,CNT)="                                 Totals"
 S CNT=$G(CNT)+1
 S ^TMP("XUPS DIFF",$J,CNT)="           Different LastName,FirstName: "_$G(XUPSDIFF("NAME"))
 S CNT=$G(CNT)+1
 S ^TMP("XUPS DIFF",$J,CNT)=" Same LastName,FirstName, different Sex: "_$G(XUPSDIFF("SEX"))
 S CNT=$G(CNT)+1
 S ^TMP("XUPS DIFF",$J,CNT)=" Same LastName,FirstName, different DOB: "_$G(XUPSDIFF("DOB"))
 S CNT=$G(CNT)+1
 S ^TMP("XUPS DIFF",$J,CNT)="                New Person file entries: "_$G(CNTD)
 ;
 ;The update report
 S CNT=0
 D HD1("XUPS UPD")
 S IEN=0
 F  S IEN=$O(^TMP("XUPS PAID",$J,"UPD",IEN)) Q:'IEN  D
 .S DATA=^TMP("XUPS PAID",$J,"UPD",IEN)
 .D FL1("XUPS UPD",DATA)
 .S CNTU=$G(CNTU)+1
 S CNT=$G(CNT)+1
 S ^TMP("XUPS UPD",$J,CNT)=""
 S CNT=$G(CNT)+1
 S ^TMP("XUPS UPD",$J,CNT)="             Totals"
 S CNT=$G(CNT)+1
 S ^TMP("XUPS UPD",$J,CNT)="         Sex fields: "_XUPSUPD("SEX")
 S CNT=$G(CNT)+1
 S ^TMP("XUPS UPD",$J,CNT)="         DOB fields: "_XUPSUPD("DOB")
 S CNT=$G(CNT)+1
 S ^TMP("XUPS UPD",$J,CNT)=" New Person entries: "_$G(CNTU)
 ;
 D XM("Update NPF with PAID data - Sex and DOB","XUPS UPD")
 D XM("Differences between NPF and PAID files","XUPS DIFF")
 ;
 K ^TMP("XUPS PAID",$J)
 K ^TMP("XUPS DIFF",$J)
 K ^TMP("XUPS UPD",$J)
 ;
 Q
 ;
RECORD ;Process the record
 ;
 N IEN200,DATA,DATA1
 N PAIDNM,PAIDOB,PAIDSSN,PAIDSEX
 N NPFNM,NPFSEX,NPFDOB,NPFSSN
 ;
 ; NPF IEN
 S IEN200=$P($G(^PRSPC(IEN,200)),"^",1)
 ;
 Q:'IEN200
 S XUNPFT=$G(XUNPFT)+1
 ;
 ; PAID file
 S DATA=$G(^PRSPC(IEN,0))
 S PAIDNM=$P(DATA,"^",1)
 S PAIDDOB=$P(DATA,"^",33)
 S PAIDSSN=$P(DATA,"^",9)
 S PAIDSEX=$P(DATA,"^",32)
 ; transform SEX code PAID to NPF
 S PAIDSEX=$S(PAIDSEX="":"",PAIDSEX=1:"M",PAIDSEX=2:"F",1:"")
 ;
 ; New Person File
 S DATA=$G(^VA(200,IEN200,1))
 S NPFNM=$P($G(^VA(200,IEN200,0)),U)
 S NPFSEX=$P(DATA,"^",2)
 S NPFDOB=$P(DATA,"^",3)
 S NPFSSN=$P(DATA,"^",9)
 ;
 Q:NPFSSN'=PAIDSSN
 ;
 S DATA=NPFNM_U_NPFSEX_U_NPFDOB_U_NPFSSN
 S DATA=DATA_U_PAIDNM_U_PAIDSEX_U_PAIDDOB_U_PAIDSSN_U_IEN200
 ;
 S DATA1=NPFSSN_U_NPFNM_U_U_U_IEN200
 ;
 I $$NAME(NPFNM)'=$$NAME(PAIDNM) D  Q
 .S XUPSDIFF("NAME")=XUPSDIFF("NAME")+1
 .S ^TMP("XUPS PAID",$J,"DIFF",IEN200)=DATA
 ;
 I PAIDSEX'="" D
 .I NPFSEX="" D  Q
 ..S $P(DATA1,U,3)=PAIDSEX
 ..S XUPSUPD("SEX")=XUPSUPD("SEX")+1
 ..S ^TMP("XUPS PAID",$J,"UPD",IEN200)=DATA1
 ..I $E(XUPSACT,1)="U" D
 ... D UPDSEX
 ... S XUUPDT=$G(XUUPDT)+1
 .I NPFSEX'=PAIDSEX D  Q
 ..S XUPSDIFF("SEX")=XUPSDIFF("SEX")+1
 ..S ^TMP("XUPS PAID",$J,"DIFF",IEN200)=DATA
 ;
 I PAIDDOB'="" D
 .I NPFDOB="" D  Q
 ..S $P(DATA1,U,4)=PAIDDOB
 ..S XUPSUPD("DOB")=XUPSUPD("DOB")+1
 ..S ^TMP("XUPS PAID",$J,"UPD",IEN200)=DATA1
 ..I $E(XUPSACT,1)="U" D
 ... D UPDDOB
 ... S XUUPDT=$G(XUUPDT)+1
 .I NPFDOB'=PAIDDOB D  Q
 ..S XUPSDIFF("DOB")=XUPSDIFF("DOB")+1
 ..S ^TMP("XUPS PAID",$J,"DIFF",IEN200)=DATA
 ;
 Q
 ;
HD(NODE) ; -- Report header
 N C1,C2,C3,C4,C5
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=""
 ;
 I NODE="XUPS DIFF" D
 . S CNT=$G(CNT)+1
 . S ^TMP(NODE,$J,CNT)="The following New Person File entries have different LastName,FirstName,"
 . S CNT=$G(CNT)+1
 . S ^TMP(NODE,$J,CNT)="or same LastName,FirstName but different Sex or DOB with their linked PAID"
 . S CNT=$G(CNT)+1
 . S ^TMP(NODE,$J,CNT)="Employee entries."
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=""
 ;
 S C1=$$LJ^XLFSTR("NPF  - Name",30," ")
 S C2=$$CJ^XLFSTR("SEX",3," ")
 S C3=$$LJ^XLFSTR("DOB",11," ")
 S C4=$$LJ^XLFSTR("SSN",9," ")
 S C5=$$RJ^XLFSTR("IEN",14," ")
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=C1_C2_"  "_C3_"  "_C4_"  "_C5
 ;
 S C1=$$LJ^XLFSTR("PAID -",30," ")
 S C2=$$CJ^XLFSTR("",3," ")
 S C3=$$LJ^XLFSTR("",11," ")
 S C4=$$LJ^XLFSTR("",9," ")
 S C5=$$RJ^XLFSTR("",14," ")
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=C1_C2_"  "_C3_"  "_C4_"  "_C5
 ;
 S C1=$$LJ^XLFSTR("=================",30," ")
 S C2=$$CJ^XLFSTR("===",3," ")
 S C3=$$LJ^XLFSTR("==========",11," ")
 S C4=$$LJ^XLFSTR("=========",9," ")
 S C5=$$RJ^XLFSTR("===",14," ")
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=C1_C2_"  "_C3_"  "_C4_"  "_C5
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=""
 ;
 Q
 ;
FL(NODE,DATA) ; -- format line
 ;
 N NPFNM,NPFSEX,NPFDOB,NPFSSN,NPFIEN
 N PAIDNM,PAIDSEX,PAIDDOB,PAIDSSN
 ;
 S NPFNM=$P(DATA,U,1)
 S NPFSEX=$P(DATA,U,2)
 S NPFDOB=$P(DATA,U,3)
 S NPFSSN=$P(DATA,U,4)
 S NPFIEN=$P(DATA,U,9)
 S PAIDNM=$P(DATA,U,5)
 S PAIDSEX=$P(DATA,U,6)
 S PAIDDOB=$P(DATA,U,7)
 S PAIDSSN=$P(DATA,U,8)
 ;
 N C1,C2,C3,C4,C5
 ;
 ;NPF values
 S C1=$$LJ^XLFSTR(NPFNM,30," ")
 S C2=$$CJ^XLFSTR(NPFSEX,3," ")
 S C3=$$LJ^XLFSTR($$DOB(NPFDOB),11," ")
 S C4=$$LJ^XLFSTR(NPFSSN,9," ")
 S C5=$$RJ^XLFSTR(NPFIEN,14," ")
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=C1_C2_"  "_C3_"  "_C4_"  "_C5
 ;
 ;PAID values
 S C1=$$LJ^XLFSTR(PAIDNM,30," ")
 S C2=$$CJ^XLFSTR(PAIDSEX,3," ")
 S C3=$$LJ^XLFSTR($$DOB(PAIDDOB),11," ")
 S C4=$$LJ^XLFSTR(PAIDSSN,9," ")
 S C5=$$RJ^XLFSTR(" ",14," ")
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=C1_C2_"  "_C3_"  "_C4_"  "_C5
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=""
 ;
 Q
 ;
HD1(NODE) ; -- Report header
 ;
 N C1,C2,C3,C4,C5
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=""
 ;
 I NODE="XUPS UPD" D
 . S CNT=$G(CNT)+1
 . S ^TMP(NODE,$J,CNT)="The following New Person File entries will be updated."
 . S CNT=$G(CNT)+1
 . S ^TMP(NODE,$J,CNT)="The DOB or Sex fields to be updated are shown with the PAID values;"
 . S CNT=$G(CNT)+1
 . S ^TMP(NODE,$J,CNT)="The DOB or Sex fields not to be updated are shown with ""-""."
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=""
 ;
 S C1=$$LJ^XLFSTR("SSN",9," ")
 S C2=$$LJ^XLFSTR("NPF Name",30," ")
 S C3=$$LJ^XLFSTR("SEX",3," ")
 S C4=$$LJ^XLFSTR("DOB",11," ")
 S C5=$$RJ^XLFSTR("IEN",14," ")
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=C1_"  "_C2_"  "_C3_"  "_C4_"  "_C5
 ;
 S C1=$$LJ^XLFSTR("=========",9," ")
 S C2=$$LJ^XLFSTR("=================",30," ")
 S C3=$$CJ^XLFSTR("===",3," ")
 S C4=$$LJ^XLFSTR("==========",11," ")
 S C5=$$RJ^XLFSTR("===",14," ")
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=C1_"  "_C2_"  "_C3_"  "_C4_"  "_C5
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=""
 ;
 Q
 ;
FL1(NODE,DATA) ; -- format line
 ;
 N NPFSSN,NPFNM,NPFSEX,NPFDOB,NPFIEN
 ;
 S NPFSSN=$P(DATA,U,1)
 S NPFNM=$P(DATA,U,2)
 S NPFSEX=$P(DATA,U,3)
 I NPFSEX="" S NPFSEX="-"
 S NPFDOB=$P(DATA,U,4)
 S NPFIEN=$P(DATA,U,5)
 ;
 N C1,C2,C3,C4,C5
 ;
 ;NPF values
 S C1=$$LJ^XLFSTR(NPFSSN,9," ")
 S C2=$$LJ^XLFSTR(NPFNM,30," ")
 S C3=$$CJ^XLFSTR(NPFSEX,3," ")
 I NPFDOB="" S C4="---------- "
 I NPFDOB'="" S C4=$$LJ^XLFSTR($$DOB(NPFDOB),11," ")
 S C5=$$RJ^XLFSTR(NPFIEN,14," ")
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=C1_"  "_C2_"  "_C3_"  "_C4_"  "_C5
 ;
 S CNT=$G(CNT)+1
 S ^TMP(NODE,$J,CNT)=""
 ;
 Q
 ;
UPDSEX ;Update SEX if NPF SEX is null
 I $E(XUPSACT,1)'="U" Q
 ;
 N DIE,DA,DR
 S DIE=200,DA=IEN200
 I NPFSEX="" D
 . S DR="4///^S X=PAIDSEX"
 . D ^DIE
 Q
 ;
UPDDOB ;Update DOB if NPF DOB is null
 I $E(XUPSACT,1)'="U" Q
 ;
 N DIE,DA,DR
 S DIE=200,DA=IEN200
 I NPFDOB="" D
 . S DR="5///^S X=PAIDDOB"
 . D ^DIE
 Q
 ;
NAME(NAME) ; Return "LastName,FirstName".
 ;
 N RESULT,STDNM
 ;
 S RESULT=""
 ;
 ; CALL FORMAT^XLFNAME7
 S STDNM=$$FORMAT^XLFNAME7(.NAME,3,35)
 ;
 ; Return LastName,FirstName
 S RESULT=$P($G(STDNM)," ",1)
 ;
 Q RESULT
 ;
DOB(DOB) ; format DOB
 ;
 Q:DOB="" ""
 ;
 Q $E(DOB,4,5)_"/"_$E(DOB,6,7)_"/"_(1700+$E(DOB,1,3))
 ;
PSDT() ; format date
 ;
 N %
 ;
 D NOW^%DTC S Y=% D DD^%DT
 ;
 Q Y
 ;
XM(XMSUB,X) ;Email the report
 ;If called within a task, protect variables
 I $D(ZTQUEUED) N %,DIFROM
 ;
 N XMY,XMTEXT,XMDUZ
 S XMY(DUZ)="",XMDUZ=.5
 S XMTEXT="^TMP("""_X_""",$J,"
 D ^XMD
 ;
 Q
 ;
