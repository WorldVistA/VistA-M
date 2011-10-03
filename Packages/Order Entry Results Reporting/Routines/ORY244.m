ORY244 ;SLC/JEH -- post-install for OR*3*244 ;12/14/2005
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**244**;Dec 17, 1997;Build 1
 ; Variables used: 
 ; DATE = the date 2nd part of the sub script of LRO(69,DATE
 ; LORSN = the multiple counter of 69 or 4th part  to get to each LAB ORDER
 ; LABDFN = DFN of LR file
 ; TSTCNT = the sub multiple / counter of the lab test or the 6th part of the 69 sub script   
 ; OERRDFN = DFN of OR(100 
 ; LRSUB = sub of LAB(60, the lab test in LR
 ; L60DFN = DFN of Lab test performed
 ; TSTCNT = 6th part of sub script of LOR(69, pts to LAB TEST( LAB(60, and corresponding OR DFN
 ; TSTTYP= CH MI AP, from the order file OR(100
 ; PANEL=1 Indicates from a panel test versies single test PANEL="" 
 ; CNT244 = Number of Abnormal results modified
 ;
 ;
POST ; -- Postinit corrects the abnormal flag and resuslts set in the OR(100, file
 N DATE,LOCATION,PTNAME,LABDFN,LORSN,LRSUB,TSTCNT,PANEL,TSTTYP,LRIVDAT,LSTEST,LABPNUM,TEST
 N L60DFN,RCNT,LRRESULT,LV60TST,OERRDFN,OR0,ORESULTS,CNT244,DAT60LV1,DAT60LV2,DAT69LV1,DAT69LV2
 S LOCATION="",PTNAME="",LABDFN="",PANEL="",CNT244=0,TEST=""
 K ^TMP("ORFIX",$J),^TMP("ORTXT",$J)
 S ^TMP("ORFIX",$J,0)=0
 ;
PTR69 ; -- Loop thru Lab order file 69 to find ptr to Order file (OR 100) and Lab Data file (LR
 N ORMSG,ZTSK
 S ORMSG(1)=""
 S ORMSG(2)="STARTING reinstatement of missing abnormal results in the ORDER file #100"
 S ORMSG(3)=""
 D MES^XPDUTL(.ORMSG)
 ;W !,"STARTING reinstatement of missing abnormal results in the ORDER file #100"
 S DATE=3050815 ; PROBLEM START WITH LR*5.2*340 given to test sites Aug 15
 F  S DATE=$O(^LRO(69,DATE)) Q:DATE'?7N!(DATE>3051231)  D  ;69 loop
 . ;
 . S LORSN=0
 . F  S LORSN=$O(^LRO(69,DATE,1,LORSN)) Q:LORSN'>0  D    ;loop within LR order to get multi test
 . . ;
 . . S DAT69LV1=$G(^LRO(69,DATE,1,LORSN,0)) Q:DAT69LV1=""
 . . S LABDFN=$P(^LRO(69,DATE,1,LORSN,0),"^",1)  ;get LR DFN
 . . I LABDFN="" Q   ;No LR not need to process v2
 . . ;
 . . S TSTCNT=0
 . . F  S TSTCNT=$O(^LRO(69,DATE,1,LORSN,2,TSTCNT)) Q:TSTCNT=""!(TSTCNT]"@")  D  ;loop thru test 
 . . . ;
 . . . W "."
 . . . S DAT69LV2=$G(^LRO(69,DATE,1,LORSN,2,TSTCNT,0)) Q:DAT69LV2=""
 . . . S OERRDFN=$P(^LRO(69,DATE,1,LORSN,2,TSTCNT,0),"^",7)  ;get DFN of OR(100
 . . . I OERRDFN="" Q   ;No OR(100 no need to process v2
 . . . S L60DFN=+$P(^LRO(69,DATE,1,LORSN,2,TSTCNT,0),"^",1)  ;get DFN of 60 lab test performed
 . . . I L60DFN="" Q   ;No lab test no need to process v2
 . . . ; If test is a Panel of test or a single test?
 . . . S DAT60LV1=$G(^LAB(60,L60DFN,0)) Q:DAT60LV1=""
 . . . S LSTEST=L60DFN
 . . . S PANEL=""
 . . . S PANEL=$G(^LAB(60,L60DFN,2,1,0)) ;if there, equal to 1st test in panel test.
 . . . I PANEL'="" S PANEL=L60DFN
 . . . ; OR100FU GET INFO FROM OR(100
 . . . I $G(^OR(100,OERRDFN,7))="" Q  ;No results no need to process
 . . . I $P(^OR(100,OERRDFN,7),"^",2)=1 Q  ;If abnomal results already, no need to process
 . . . ;
 . . . S LRIVDAT="",TSTTYP="",ORESULTS=""
 . . . I $G(^OR(100,OERRDFN,4))="" Q   ;If no date time of type quit v3
 . . . S LRIVDAT=$P(^OR(100,OERRDFN,4),";",5)
 . . . S TSTTYP=$P(^OR(100,OERRDFN,4),";",4)
 . . . ;If not one of the Lab test types processed by LR7OR1 then quit
 . . . I TSTTYP'="CH" Q
 . . . I LRIVDAT="" Q  ;No LR date no need to process v2
 . . . I PANEL="" D NONPAN
 . . . ;
 . . . I PANEL'="" D PAN60 ; PROCESS A PANEL OF TEST FOR THSI ORDER.
 ;
 D MAIL
 ;W !,"Up date of Order file is complete!"
 ;W !,"Please check your Mail for a list of modified ORDER files"
 N ORMSG,ZTSK
 S ORMSG(1)=""
 S ORMSG(2)="Up date of Order file is complete!"
 S ORMSG(3)="Please check your Mail for a list of modified ORDER files"
 S ORMSG(4)=""
 D MES^XPDUTL(.ORMSG)
 Q
 ;
NONPAN ;
 S DAT60LV2=$G(^LAB(60,L60DFN,.2)) Q:DAT60LV2=""
 S LRSUB=$P(^LAB(60,L60DFN,.2),"^",1)
 I LRSUB="" Q   ; if not test skip v2
 S LRRESULT=$G(^LR(LABDFN,TSTTYP,LRIVDAT,LRSUB)) Q:LRRESULT=""  ;If no results quit
 S TEST=$P(LRRESULT,"^",2)
 I (TEST["L")!(TEST["H") D  Q
 . I $G(^LAB(60,L60DFN,.1))="" Q  ;If no test name quit v3
 . S ORESULTS=$P(^LAB(60,L60DFN,.1),"^",1)_"="_$P(LRRESULT,"^",1)
 . D ORUPDAT ;set ABNORMAL results in Order file
 Q
 ;
PAN60 ;
 S ORESULTS=""   ;Clear for the next order file
 ; S DAT60LV1=$G(^LAB(60,LRSUB,0)) Q:DAT60LV1=""
 ;
 ; Lab(60 DFN in LOR(69 was a Panel of test.
 ; If an abnormal test in the panel test loop thru the panel test to pull each individual test 
 ; also loop Thru the LR from the start to pull the results to put with the test from LAB(60 
 S LRSUB=""
 ; Loop Thru LR file to pull individual test results when from a panel of test.
 S RCNT=0
 S LSTEST=""
 S LABPNUM=0
 F  S LABPNUM=$O(^LAB(60,PANEL,2,LABPNUM)) Q:LABPNUM=""!(LABPNUM]"@")  D
 . S LV60TST=$G(^LAB(60,PANEL,2,LABPNUM,0)) Q:LV60TST=""
 . S L60DFN=$P(LV60TST,"^",1)
 . I L60DFN="" Q  ;If not test skip v3
 . S LRSUB=$G(^LAB(60,L60DFN,.2))  ; If L60DFN not null but not valid quit v3
 . I LRSUB="" Q  ; v3
 . S LRSUB=$P(^LAB(60,L60DFN,.2),"^",1)
 . S LRRESULT=$G(^LR(LABDFN,TSTTYP,LRIVDAT,LRSUB)) Q:LRRESULT=""  ;If no test quit
 . S TEST=$P(LRRESULT,"^",2) Q:LRRESULT=""  ;If no results quit
 . I (TEST["L")!(TEST["H") D  Q
 . . S RCNT=RCNT+1
 . . S DAT60LV1=$G(^LAB(60,L60DFN,0)) Q:DAT60LV1=""
 . . S LSTEST=LRSUB
 . . I $G(^LAB(60,L60DFN,.1))="" Q  ;If no test name quit v3
 . . S $P(ORESULTS,",",RCNT)=$P(^LAB(60,L60DFN,.1),"^",1)_"="_$P(LRRESULT,"^",1)_" "
 . . ; S LRSUB=LRSUB+1  ;Bump to the next LR test results
 I ORESULTS'="" D ORUPDAT ;set ABNORMAL results in Order file
 Q
 ;
ORUPDAT ; Update the OR(100, file Abnormal results
 ;
 S CNT244=CNT244+1
 S ^TMP("ORFIX",$J,0)=CNT244
 S PTNAME=""
 S OR0=$G(^OR(100,OERRDFN,0))
 S PTNAME=$$PTNM($P(OR0,U,2))
 S ^TMP("ORFIX",$J,CNT244)="PATIENT NAME="_PTNAME
 S ^TMP("ORFIX",$J,CNT244,0)=" ORER FILE DFN="_OERRDFN
 S ^TMP("ORFIX",$J,CNT244,1)=" LAB DATA LRDFN="_LABDFN
 I PANEL="" S ^TMP("ORFIX",$J,CNT244,2)=" LABORATORY TEST IEN="_LSTEST
 I PANEL'="" S ^TMP("ORFIX",$J,CNT244,2)=" LABORATORY TEST(PANEL) IEN="_PANEL
 S ^TMP("ORFIX",$J,CNT244,3)=" ABNORMAL TEST RESULTS: "_ORESULTS
 S $P(^OR(100,OERRDFN,7),"^",2)=1
 S $P(^OR(100,OERRDFN,7),"^",3)=ORESULTS
 ;W !," ABNORMAL TEST RESULTS: ",ORESULTS
 ;
 ;S THISTEST=^OR(100,OERRDFN,7)
 ;W !,"Before update ^OR(100,"_OERRDFN_",7)=",THISTEST
 ;
 ;S THISTEST=^OR(100,OERRDFN,7)
 ;W !,"After update ^OR(100,"_OERRDFN_",7)=",THISTEST
 ;W !
 Q
 ;
 ;
 ;
MAIL ;Send results of cleanup in a mail message to initiator
 N I,XMSUB,XMTEXT,XMDUZ,XMY,DIFROM
 S XMSUB="Patch OR*3*244 Clean up completed"
 S XMDUZ="Patch OR*3*244 Clean up job"
 S XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S XMTEXT="^TMP(""ORTXT"",$J,"
 K ^TMP("ORTXT",$J)
 ; set up header and count
 S I=1
 S ^TMP("ORTXT",$J,I)="The reinstatement of Abnormal results has completed.",I=I+1
 S ^TMP("ORTXT",$J,I)="Below is a listing of Abnormal results taken from Lab test and added to the Order file.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S ^TMP("ORTXT",$J,I)=+$P($G(^TMP("ORFIX",$J,0)),U)_" orders had abnormal results added.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 I $G(^TMP("ORFIX",$J,0))=0 S ^TMP("ORTXT",$J,I)="No changes were made to your database.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 ; set up message text
 S CNT244=0 F  S CNT244=$O(^TMP("ORFIX",$J,CNT244)) Q:CNT244=""  D
 .S ^TMP("ORTXT",$J,I)=^TMP("ORFIX",$J,CNT244),I=I+1
 .S ^TMP("ORTXT",$J,I)=^TMP("ORFIX",$J,CNT244,0),I=I+1
 .S ^TMP("ORTXT",$J,I)=^TMP("ORFIX",$J,CNT244,1),I=I+1
 .S ^TMP("ORTXT",$J,I)=^TMP("ORFIX",$J,CNT244,2),I=I+1
 .S ^TMP("ORTXT",$J,I)=^TMP("ORFIX",$J,CNT244,3),I=I+1
 .S ^TMP("ORTXT",$J,I)="",I=I+1
 D ^XMD ;send results
 Q
 ;
PTNM(IEN) ;Return pt name or -1 if unable to determine
 N DFN,VADM
 I +IEN=0!(IEN'["DPT") Q -1
 S DFN=+IEN
 D ^VADPT
 I $G(VADM(1))="" Q -1
 Q $G(VADM(1))
 ;
