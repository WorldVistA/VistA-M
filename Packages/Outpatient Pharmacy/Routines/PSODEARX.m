PSODEARX ;WILM/BDB - EPCS Utilities and Reports; [5/7/02 5:53am] ;3/3/22  14:50
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
 W !,"132 columns.  Please enter '0;132;9999' at the 'DEVICE:' prompt.  Lines"
 W !,"may need to be deleted at the top and bottom of the logged file before"
 W !,"importing."
 W !!,"The format of the output is as follows, using '|' as the delimiter:"
 W !,"Name|IEN|DEA(#200)|Error Text"
 D YN
 Q
 ;
YN ;yes or no prompt if no audited fields found for a file
 W ! K DIR,Y,PSOOUT S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 I $D(DTOUT)!($D(DUOUT))!('Y) S PSOOUT=1
 K DIRUT,DTOUT,DUOUT,DIR,X,Y
 Q
 ;
RUN(PSHEADER)  ; Run Report
 N PSCOUNT2,PSOTD,PSONAME,POP,IOP,PSOION
 S PSOION=ION,%ZIS="M" D ^%ZIS I POP S IOP=PSOION D ^%ZIS Q
 K ^TMP($J,"PSODEARW") ; Clear the temporary accumulator
 D COMPILE
 U IO
 W "Name","|","IEN","|","DEA","|","Error Text"
 W "     Run Date: ",$$FMTE^XLFDT(DT,"5DZ")
 I '$D(^TMP($J,"PSODEARW")) W "There is no Data to Print",!
 S PSCOUNT2=0 F  S PSCOUNT2=$O(^TMP($J,"PSODEARW",PSCOUNT2)) Q:+PSCOUNT2=0  Q:PSOQ  D
 . W !,^TMP($J,"PSODEARW",PSCOUNT2,1),"|"
 D ^%ZISC
 K ^TMP($J,"PSODEARW") ; Clear the temporary accumulator
 W !!,"End of Report.  If 'Logging', please turn off 'Logging'.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
COMPILE  ; -- Compile the report lines into the sort global
 N NAME,NPIEN,NPDEAIEN,ERROR,PRVNAME,NPDEA,DNDEA,PSOLINE,PSCOUNT1,NXNPIEN,NXDEAIEN
 N DNDETOX,NXDEA,DETOXCT,DNINPT,DNINPTCT,INDIV,DNDEAIEN,DNDEASX,DNDEATYP
 S ERROR(1)="MISSING DEA NUMBER IN (#8991.9)"
 S ERROR(2)="PROVIDER NAME MISMATCH (#200)(#8991.9)"
 S ERROR(3)="INSTITUTIONAL DEA MISSING SUFFIX"
 S ERROR(4)="DEA ASSIGNED TO PROVIDER:"
 S ERROR(5)="DUPLICATE DETOX NUMBER"
 S ERROR(6)="PROVIDER WITH MULTIPLE DETOX NUMBERS"
 S ERROR(7)="PROVIDER MISSING DEA INPATIENT FLAG"
 S PSCOUNT1=0
 S NAME="" F  S NAME=$O(^VA(200,"B",NAME)) Q:NAME=""  D
 . S NPIEN=0 F  S NPIEN=$O(^VA(200,"B",NAME,NPIEN)) Q:'NPIEN  D
 . . Q:'$D(^VA(200,NPIEN,"PS4"))
 . . I '$O(^VA(200,NPIEN,"PS4",0)) Q
 . . S PRVNAME=$$GET1^DIQ(200,NPIEN,.01,"E")
 . . ;CHECK FOR PROVIDER WITH MULTIPLE DETOX NUMBERS ERROR 6
 . . S DETOXCT=0,NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D  I DETOXCT>1 Q
 . . . S NPDEA=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.01,"E")
 . . . S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . . . S DNDETOX=$$GET1^DIQ(8991.9,DNDEAIEN,.03) I DNDETOX]"" S DETOXCT=DETOXCT+1
 . . . I DETOXCT>1 D
 . . . . S PSOLINE="",NPDEA=""
 . . . . S PSOLINE=PSOLINE_PRVNAME_"|"                     ; NAME            #200,    #.01
 . . . . S PSOLINE=PSOLINE_NPIEN_"|"                        ; IEN             #200
 . . . . S PSOLINE=PSOLINE_NPDEA_"|"                        ; NEW DEA NUMBER  #200,   
 . . . . S PSOLINE=PSOLINE_ERROR(6)   ; ERROR TEXT
 . . . . S PSCOUNT1=PSCOUNT1+1
 . . . . S ^TMP($J,"PSODEARW",PSCOUNT1,1)=PSOLINE
 . . ;CHECK FOR PROVIDER WITH ALL INDIVIDUAL DEA MISSING DEA INPATIENT FLAG ERROR 7
 . . S INDIV=0,DNINPTCT=0,NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D  I DNINPTCT>0 Q
 . . . S NPDEA=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.01,"E")
 . . . S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I") Q:DNDEAIEN=""
 . . . S DNDEATYP=$$GET1^DIQ(8991.9,DNDEAIEN,.07,"E") I DNDEATYP="INDIVIDUAL" S INDIV=1 D
 . . . . S DNINPT=$$GET1^DIQ(8991.9,DNDEAIEN,.06) I DNINPT="YES" S DNINPTCT=DNINPTCT+1
 . . I INDIV>0,DNINPTCT=0 D
 . . . S PSOLINE="",NPDEA=""
 . . . S PSOLINE=PSOLINE_PRVNAME_"|"                     ; NAME            #200,    #.01
 . . . S PSOLINE=PSOLINE_NPIEN_"|"                        ; IEN             #200
 . . . S PSOLINE=PSOLINE_NPDEA_"|"                        ; NEW DEA NUMBER  #200,   
 . . . S PSOLINE=PSOLINE_ERROR(7)   ; ERROR TEXT
 . . . S PSCOUNT1=PSCOUNT1+1
 . . . S ^TMP($J,"PSODEARW",PSCOUNT1,1)=PSOLINE
 . . ;CHECK EACH PROVIDER DEA
 . . S NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D  I DNDEA']"" Q
 . . . ; CHECK FOR MISSING DEA NUMBER (FILE: #8991.9) ERROR 1
 . . . S NPDEA=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.01,"E")
 . . . S DNDEA=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"E")
 . . . S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . . . I (DNDEA']"")!(NPDEA'=DNDEA) D
 . . . . S PSOLINE=""
 . . . . S PSOLINE=PSOLINE_PRVNAME_"|"                     ; NAME            #200,    #.01
 . . . . S PSOLINE=PSOLINE_NPIEN_"|"                        ; IEN             #200
 . . . . S PSOLINE=PSOLINE_NPDEA_"|"                        ; NEW DEA NUMBER  #200,
 . . . . S PSOLINE=PSOLINE_ERROR(1)                         ; ERROR TEXT
 . . . . S PSCOUNT1=PSCOUNT1+1
 . . . . S ^TMP($J,"PSODEARW",PSCOUNT1,1)=PSOLINE
 . . . ;CHECK FOR PROVIDER NAME MISMATCH (#200)(#8991.9) ERROR 2
 . . . I (DNDEA]"")&($P(PRVNAME,",",1)'=$P($$GET1^DIQ(8991.9,DNDEAIEN,1.1),",",1)) D
 . . . . S PSOLINE=""
 . . . . S PSOLINE=PSOLINE_PRVNAME_"|"                     ; NAME            #200,    #.01
 . . . . S PSOLINE=PSOLINE_NPIEN_"|"                        ; IEN             #200
 . . . . S PSOLINE=PSOLINE_NPDEA_"|"                        ; NEW DEA NUMBER  #200,   
 . . . . S PSOLINE=PSOLINE_ERROR(2)                         ; ERROR TEXT
 . . . . S PSCOUNT1=PSCOUNT1+1
 . . . . S ^TMP($J,"PSODEARW",PSCOUNT1,1)=PSOLINE
 . . . ;CHECK FOR INSTITUTIONAL DEA MISSING SUFFIX ERROR 3
 . . . S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . . . S DNDEATYP=$$GET1^DIQ(8991.9,DNDEAIEN,.07,"E")
 . . . S DNDEASX=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.02,"E")
 . . . I (DNDEATYP="INSTITUTIONAL")&(DNDEASX="") D  Q
 . . . . S PSOLINE=""
 . . . . S PSOLINE=PSOLINE_PRVNAME_"|"                     ; NAME            #200,    #.01
 . . . . S PSOLINE=PSOLINE_NPIEN_"|"                        ; IEN             #200
 . . . . S PSOLINE=PSOLINE_NPDEA_"|"                        ; NEW DEA NUMBER  #200,   
 . . . . S PSOLINE=PSOLINE_ERROR(3)                         ; ERROR TEXT
 . . . . S PSCOUNT1=PSCOUNT1+1
 . . . . S ^TMP($J,"PSODEARW",PSCOUNT1,1)=PSOLINE
 . . . ;CHECK FOR DEA ASSIGNED TO PROVIDER: ERROR 4
 . . . I DNDEATYP="INDIVIDUAL" S NXNPIEN="" F  S NXNPIEN=$O(^VA(200,"PS4",NPDEA,NXNPIEN)) Q:NXNPIEN=""  I NXNPIEN'=NPIEN D  Q
 . . . . S PSOLINE=""
 . . . . S PSOLINE=PSOLINE_PRVNAME_"|"                     ; NAME            #200,    #.01
 . . . . S PSOLINE=PSOLINE_NPIEN_"|"                        ; IEN             #200
 . . . . S PSOLINE=PSOLINE_NPDEA_"|"                        ; NEW DEA NUMBER  #200,   
 . . . . S PSOLINE=PSOLINE_ERROR(4)_"  "_$$GET1^DIQ(200,NXNPIEN_",",.01)   ; ERROR TEXT
 . . . . S PSCOUNT1=PSCOUNT1+1
 . . . . S ^TMP($J,"PSODEARW",PSCOUNT1,1)=PSOLINE
 . . . ;CHECK FOR DUPLICATE DETOX NUMBER
 . . . S DNDETOX=$$GET1^DIQ(8991.9,DNDEAIEN,.03)
 . . . I DNDETOX]"" S NXDEA="" F  S NXDEA=$O(^XTV(8991.9,"D",DNDETOX,NXDEA)) Q:NXDEA=""  I NXDEA'=NPDEA D  Q
 . . . . S NXDEAIEN=$O(^XTV(8991.9,"D",DNDETOX,NXDEA,""))
 . . . . S PSOLINE=""
 . . . . S PSOLINE=PSOLINE_PRVNAME_"|"                     ; NAME            #200,    #.01
 . . . . S PSOLINE=PSOLINE_NPIEN_"|"                        ; IEN             #200
 . . . . S PSOLINE=PSOLINE_NPDEA_"|"                        ; NEW DEA NUMBER  #200,   
 . . . . S PSOLINE=PSOLINE_ERROR(5)_"  DEA:"_$$GET1^DIQ(8991.9,NXDEAIEN_",",.01)   ; ERROR TEXT
 . . . . S PSCOUNT1=PSCOUNT1+1
 . . . . S ^TMP($J,"PSODEARW",PSCOUNT1,1)=PSOLINE
 Q
 ;
