PSODEARV ;WILM/BDB - EPCS Utilities and Reports; [5/7/02 5:53am] ;10/5/21  14:50
 ;;7.0;OUTPATIENT PHARMACY;**545**;DEC 1997;Build 270
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;
 Q
 ;
DL ;Delimited File message
 ;
 W !!,"You have selected the delimited file output." D YN Q:$G(PSOOUT)
 W @IOF
 W !,"The report output will be displayed on the screen in a delimited format, so"
 W !,"it can be captured and exported.  If you are using Reflections, you can turn"
 W !,"logging on by selecting 'Tools' on the top of the screen, then"
 W !,"select 'Logging' and capture to your desired location.  To avoid undesired"
 W !,"wrapping, you may need to set your terminal session display settings to"
 W !,"512 columns.  Please enter '0;512;9999' at the 'DEVICE:' prompt.  Lines"
 W !,"may need to be deleted at the top and bottom of the logged file before"
 W !,"importing."
 W !!,"The format of the output is as follows, using '|' as the delimiter:"
 W !,"Term Date|Name|DEA|DEA Exp Dt|Last Sign-on|Title|Service/Section|Remarks"
 D YN
 Q
 ;
YN ;yes or no prompt if no audited fields found for a file
 W ! K DIR,Y,PSOOUT S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 I $D(DTOUT)!($D(DUOUT))!('Y) S PSOOUT=1
 K DIRUT,DTOUT,DUOUT,DIR,X,Y
 Q
 ;
RUN(PSHEADER,PSCPRSSA,PSOEDS,PSOCPRSU)  ; Run Report
 N PSCOUNT2,PSOTD,PSONAME,POP,IOP,PSOION,PSOPROB
 S PSOPROB="",PSOION=ION,%ZIS="M" D ^%ZIS I POP S IOP=PSOION D ^%ZIS Q
 K ^TMP($J,"PSODEARP") ; Clear the temporary accumulator
 D COMPILE(PSCPRSSA,PSOEDS,PSOCPRSU,.PSOPROB)
 U IO
 W "Term Date","|","Name","|","DEA","|","DEA Exp Dt","|","Last Sign-on","|","Title","|","Service/Section","|","Remarks"
 W !,"DEA Expiration Date Report"_"       "
 W PSHEADER
 W "Run Date: ",$$FMTE^XLFDT(DT,"5DZ")
 I '$D(^TMP($J,"PSODEARP")) W !!,"There is no Data to Print"
 S PSOTD=0 F  S PSOTD=$O(^TMP($J,"PSODEARP",PSOTD)) Q:+PSOTD=0  D
 . S PSONAME="" F  S PSONAME=$O(^TMP($J,"PSODEARP",PSOTD,PSONAME)) Q:PSONAME=""  D
 .. S PSCOUNT2=0 F  S PSCOUNT2=$O(^TMP($J,"PSODEARP",PSOTD,PSONAME,PSCOUNT2)) Q:+PSCOUNT2=0  D
 ... W !,^TMP($J,"PSODEARP",PSOTD,PSONAME,PSCOUNT2,1),"|"
 I $G(PSOPROB) D
 . W !,"*PROBLEM* INDICATES BAD CROSS REFERENCE IN NEW PERSON FILE.",!,"CONTACT PRODUCT SUPPORT TO RESOLVE.",!
 D ^%ZISC
 K ^TMP($J,"PSODEARP") ; Clear the temporary accumulator
 W !!,"End of Report.  If 'Logging', please turn off 'Logging'.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
COMPILE(PSCPRSSA,PSOEDS,PSOCPRSU,PSOPROB)  ; -- Compile the report lines into the sort global
 N DEAIEN,DEATXT,PSCOUNT1,PSOLINE,PSOTD
 S PSCOUNT1=0
 S DEATXT="" F  S DEATXT=$O(^XTV(8991.9,"B",DEATXT)) Q:DEATXT=""  D
 . S DEAIEN=$O(^XTV(8991.9,"B",DEATXT,0)) Q:'DEAIEN
 . S NPIEN="" F  S NPIEN=$O(^VA(200,"PS4",DEATXT,NPIEN)) Q:'NPIEN  D
 . . K TMP,PSODNOBJ D GETS^DIQ(8991.9,DEAIEN_",","**","","TMP","MSG") M PSODNOBJ=TMP(8991.9,DEAIEN_",")
 . . K TMP,PSONPOBJ D GETS^DIQ(200,NPIEN_",","**","","TMP","MSG") M PSONPOBJ=TMP(200,NPIEN_",")
 . . S (PSOTD,PSONPOBJ(9.2))=$$GET1^DIQ(200,NPIEN_",",9.2,"I"),PSONPOBJ(9.2)=$$FMTE^XLFDT(PSONPOBJ(9.2),"5DZ")
 . . S PSONPOBJ(202)=$$GET1^DIQ(200,NPIEN_",",202,"I"),PSONPOBJ(202)=$$FMTE^XLFDT(PSONPOBJ(202),"5DZ")
 . . S PSODNOBJ(.04)=$$GET1^DIQ(8991.9,DEAIEN_",",.04,"I"),PSODNOBJ(.04)=$$FMTE^XLFDT(PSODNOBJ(.04),"5DZ")
 . . Q:'$$TEST(.PSODNOBJ,.PSONPOBJ,PSCPRSSA,PSOEDS,NPIEN,PSOCPRSU)
 . . N P200P5321 S P200P5321=$$FIND1^DIC(200.5321,","_NPIEN_",",,DEATXT)
 . . I '$G(P200P5321) S PSODNOBJ(.01)="*PROBLEM*",PSOPROB=$G(PSOPROB)+1
 . . S PSOLINE=""
 . . S PSOLINE=PSOLINE_PSONPOBJ(9.2)_"|"               ; TERMINATION DATE       #200,    #9.2
 . . S PSOLINE=PSOLINE_PSONPOBJ(.01)_"|"               ; NAME                   #200,    #.01
 . . S PSOLINE=PSOLINE_PSODNOBJ(.01)_"|"                ; DEA                    #8991.9, #.01
 . . S PSOLINE=PSOLINE_PSODNOBJ(.04)_"|"               ; DEA Expiration Date    #8991.9, #.04
 . . S PSOLINE=PSOLINE_PSONPOBJ(202)_"|"               ; LAST SIGN-ON           #200,    #202
 . . S PSOLINE=PSOLINE_PSONPOBJ(8)_"|"                 ; TITLE                  #200,    #8
 . . S PSOLINE=PSOLINE_PSONPOBJ(29)_"|"                ; SERVICE/SECTION        #200,    #29
 . . S PSCOUNT1=PSCOUNT1+1
 . . S PSOTD=$S(PSOTD:PSOTD,1:1)
 . . S ^TMP($J,"PSODEARP",PSOTD,PSODNOBJ(1.1),PSCOUNT1,1)=PSOLINE
 . . ;
 . . D:PSONPOBJ(53.9)'=""
 . . . S PSOLINE=PSOLINE_"REMARKS: "_PSONPOBJ(53.9)_"|"    ; REMARKS FIELD          #200,    #53.9
 . . . S ^TMP($J,"PSODEARP",PSOTD,PSODNOBJ(1.1),PSCOUNT1,1)=PSOLINE
 Q
 ;
TEST(PSODNOBJ,PSONPOBJ,PSCPRSSA,PSOEDS,NPIEN,PSOCPRSU)  ; -- Perform the requested test for screening critera
 N DEAEXPDT D DT^DILF("",PSODNOBJ(.04),.DEAEXPDT)
 N RESP,PSOACC S RESP=0
 N PSOTERM,PSOTODAY
 S PSOTERM=$$GET1^DIQ(200,NPIEN,9.2,"I")
 S PSOTODAY=$$DT^XLFDT
 S PSOACC=$$GET1^DIQ(200,NPIEN,2,"I")
 ;
 ; Provider Active and DEA is expired.
 I PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="E",$$ACTIVE^XUSER(NPIEN),PSODNOBJ(.04)'="",(DEAEXPDT<$$DT^XLFDT()) Q 1  ; Active CPRS Providers Only
 ; All (CPRS and Non-CPRS) Active Providers and DEA is expired
 I 'PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="E",PSONPOBJ(7)'="YES",('PSOTERM!(PSOTERM>PSOTODAY)),PSODNOBJ(.04)'="",(DEAEXPDT<$$DT^XLFDT()) Q 1     ; All Active Providers
 ;
 ; CPRS Provider Active and does not have a DEA expiration date.
 I PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="N",$$ACTIVE^XUSER(NPIEN),PSODNOBJ(.04)="" Q 1   ; Active CPRS Providers Only
 ; All (CPRS and Non-CPRS) Active Provider and does not have a DEA expiration date.
 I 'PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="N",PSONPOBJ(7)'="YES",('PSOTERM!(PSOTERM>PSOTODAY)),PSODNOBJ(.04)="" Q 1      ; All Active Providers
 ;
 ; CPRS Provider Active and DEA is expiring within next 30 days.
 I PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="3",$$ACTIVE^XUSER(NPIEN),PSODNOBJ(.04)'="",DEAEXPDT<$$FMADD^XLFDT(DT,30),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1   ; Active CPRS Providers Only
 ; All (CPRS and Non-CPRS) Active Provider and DEA is expiring within next 30 days.
 I 'PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="3",PSONPOBJ(7)'="YES",('PSOTERM!(PSOTERM>PSOTODAY)),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,30)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1      ; All Active Providers
 ;
 ; CPRS Provider Active and DEA expiring within the next 90 days.
 I PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="9",$$ACTIVE^XUSER(NPIEN),PSODNOBJ(.04)'="",DEAEXPDT<$$FMADD^XLFDT(DT,90),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1   ; Active CPRS Providers Only
 ; All (CPRS and Non-CPRS) Active DEA expiring within the next 90 days.
 I 'PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="9",PSONPOBJ(7)'="YES",('PSOTERM!(PSOTERM>PSOTODAY)),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,90)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1      ; All Active Providers
 ;
 ; CPRS Provider disusered and DEA is expired.
 I PSOCPRSU,$L(PSOACC),((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="E",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT<$$DT^XLFDT()) Q 1
 ; All (CPRS and Non-CPRS) disusered provider and DEA is expired.
 I 'PSOCPRSU,((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="E",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT<$$DT^XLFDT()) Q 1
 ;
 ; CPRS Provider disusered and does not have a DEA expiration date.
 I PSOCPRSU,$L(PSOACC),((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="N",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)="" Q 1
 ; All (CPRS and Non-CPRS) disusered provider and does not have a DEA expiration date.
 I 'PSOCPRSU,((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="N",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)="" Q 1
 ;
 ; CPRS Provider disusered and DEA is expiring within the next 30 days.
 I PSOCPRSU,$L(PSOACC),((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="3",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,30)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1
 ; All (CPRS and Non-CPRS) disusered Provider and DEA is expiring within the next 30 days.
 I 'PSOCPRSU,((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="3",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,30)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1
 ;
 ; CPRS Provider disusered and DEA is expiring within the next 90 days.
 I PSOCPRSU,$L(PSOACC),((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="9",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,90)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1
 ; All (CPRS and Non-CPRS) disusered and DEA is expiring within the next 90 days.
 I 'PSOCPRSU,((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="9",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,90)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1
 ;
 Q RESP
