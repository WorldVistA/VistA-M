PXRMREV ; SLC/PJH,PKR - Review Date routines. ;02/01/2010
 ;;2.0;CLINICAL REMINDERS;**4,16**;Feb 04, 2005;Build 119
 ;
 ;Select the review date
 ;----------------------
DATE() ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="DA^"_DT_"::EFTX"
 S DIR("A")="Enter Review Cutoff Date: "
 S DIR("B")=$$FMTE^XLFDT($$DT^XLFDT,"D")
 S DIR("?")="This must be today or a future date. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMREV(2)"
 W !
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q ""
 I $D(DTOUT)!($D(DUOUT)) Q ""
 Q Y
 ;
 ;Select file for review
 ;----------------------
FILE() N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO"_U_"C:Computed Finding;"
 S DIR(0)=DIR(0)_"D:Reminder Dialog;"
 S DIR(0)=DIR(0)_"L:Reminder Location List;"
 S DIR(0)=DIR(0)_"O:Reminder Orderable Item Groups;"
 S DIR(0)=DIR(0)_"R:Reminder Definition;"
 S DIR(0)=DIR(0)_"S:Reminder Sponsor;"
 S DIR(0)=DIR(0)_"T:Reminder Term;"
 S DIR(0)=DIR(0)_"X:Reminder Taxonomy;"
 S DIR("A")="Select File to Review"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMREV(1)"
 D ^DIR
 I $D(DIROUT)!$D(DIROUT) Q ""
 I $D(DTOUT)!$D(DUOUT) Q ""
 Q Y
 ;
 ;General help text routine
 ;-------------------------
HELP(CALL) ;
 N DIWF,DIWL,DIWR,HTEXT,IC
 S DIWF="C70",DIWL=0,DIWR=70
 I CALL=1 D
 .S HTEXT(1)="Select the file for which a Review Date report is required."
 .S HTEXT(2)=" "
 .S HTEXT(3)="The report lists in review date order all file entries which"
 .S HTEXT(4)="have a review date prior to the cuttoff date."
 I CALL=2 D
 .S HTEXT(1)="Enter a future date or today. All review dates in the file"
 .S HTEXT(2)="selected which are prior or equal to this date will be reported."
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 Q
 ;
 ;Print review date reports
 ;-------------------------
START N DATE,DIROUT,DONE,DTOUT,DUOUT,FTYPE
 S DONE=0
 F  Q:DONE  D
 . S FTYPE=$$FILE
 . I FTYPE="" S DONE=1 Q
 . S DATE=$$DATE
 . I DATE="" S DONE=1 Q
 .;
 . N BY,DHD,DIC,FLDS,FR,L,NOW,TO
 . S FR="01/01/2000"
 . S TO=DATE
 . S BY="REVIEW DATE"
 . S FLDS=".01,REVIEW DATE;C60"
 . S L=0
 .;
 . I FTYPE="C" S DIC="^PXRMD(811.4,",DHD="CF'S TO REVIEW"
 . I FTYPE="D" S DIC="^PXRMD(801.41,",DHD="DIALOGS TO REVIEW"
 . I FTYPE="L" S DIC="^PXRMD(810.9,",DHD="LOCATION LISTS TO REVIEW"
 . I FTYPE="R" S DIC="^PXD(811.9,",DHD="REMINDERS TO REVIEW"
 . I FTYPE="S" S DIC="^PXRMD(811.6,",DHD="SPONSORS TO REVIEW"
 . I FTYPE="X" S DIC="^PXD(811.2,",DHD="TAXONOMIES TO REVIEW"
 . I FTYPE="O" S DIC="^PXD(801,",DHD="ORDERABLE ITEM GROUPS TO REVIEW"
 . I FTYPE="T" S DIC="^PXRMD(811.5,",DHD="TERMS TO REVIEW"
 .;
 . S DHD=DHD_" (up to "_$$FMTE^XLFDT(DATE)_")"
 .;Print
 . D EN1^DIP
 Q
 ;
