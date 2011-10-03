RABTCH2 ;HISC/GJC-Batch Report Option, delete by date ;2/6/97  09:34
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
DELDT ; Delete a batch within a specified date range.
 ;***             Variable List               ***
 ; ^TMP($J,"RA BTCHDEL DT",ien)--> ien's of the records to be deleted
 ;
 N DIROUT,DIRUT,DTOUT,DUOUT,RA,RADUZ,RAUPRT,RAXIT,X,Y
 S RADUZ=+$G(DUZ)
 I '$D(^XUSEC("RA MGR",RADUZ)) D  Q
 . W !?5,"This option can only be used by those Radiology/Nuclear"
 . W " Medicine users that"
 . W !?5,"have access to the Radiology/Nuclear Medicine Manager's"
 . W " (RA MGR) key.",$C(7)
 . Q
 S (RA("%"),RA("DT"),RAUPRT)=0
 F  D  Q:RA("%")!(RAUPRT<0)
 . K ^TMP($J,"RA BTCHDEL DT"),RA("CNT") S RAXIT=0
 . K %DT S %DT="PEA",%DT(0)="-NOW"
 . S %DT("A")="Purge report batches printed before: "
 . S Y=$S('$D(DT):($$NOW^XLFDT()\1),1:DT) X ^DD("DD")
 . S %DT("B")=Y
 . W !!?5,"All batches up to the date you enter will be purged"
 . W !?5,"from the Report Batches file #74.2.",$C(7),!
 . D ^%DT K %DT
 . S:Y=-1 RA("%")=1,RA("DT")=Y
 . Q:RA("%")  S RA("DTI")=Y_".9999"
 . X ^DD("DD") S RA("DTX")=Y
 . W ! S RAUPRT=$$YN(RA("DTX")) Q:RAUPRT<0
 . D SETMP
 . I '+$G(RA("CNT")) D  Q
 .. W !!?5,"No "_$S(RAUPRT=1:"unprinted or ",1:"")_"printed batches exist before: ",RA("DTX"),"!"
 .. Q
 . D DISPLAY Q:RAXIT
 . W !!?5,"'",RA("DTX"),"', are you sure?",!
 . K DIR S DIR(0)="Y"
 . S DIR("?",1)="Enter 'Y' if this date is acceptable,"
 . S DIR("?")="or 'N' if you wish to select another date."
 . D ^DIR K DIR
 . S:$D(DIRUT) RA("DT")=-1
 . S:$D(DIRUT)!(+Y) RA("%")=1
 . Q
 I RA("DT")=-1!(RAUPRT<0) D KILL1 Q
 W !!?5,"There"_$S(+$G(RA("CNT"))>1:" are ",1:" is ")
 W +$G(RA("CNT"))," batch"
 W $S(+$G(RA("CNT"))>1:"es ",1:" ")
 W "selected to be deleted."
 W !?5,"Do you wish to task this job off to be completed"
 W !?5,"at a later time?",!
 K DIR S DIR(0)="Y"
 S DIR("?",1)="Enter 'Y' to task off the job and delete these batches at"
 S DIR("?")="a later date, or 'N' to delete these batches immediately."
 D ^DIR K DIR
 I $D(DIRUT) D KILL1 Q
 I +Y D
 . S ZTRTN="DEL^RABTCH2",ZTIO=""
 . S ZTDESC="Rad/Nuc Med Delete entries in the Report Batches (74.2) file up to "
 . S ZTDESC=ZTDESC_RA("DTX")
 . S ZTSAVE("^TMP($J,""RA BTCHDEL DT"",")=""
 . D ^%ZTLOAD
 . Q
 E  D
 . W !?5,$C(7),"Beginning the interactive deletion process.",!
 . D DEL
 . W !?5,"The deletion process has successfully completed!"
 . Q
KILL ; Kill and quit
 K ZTIO,ZTDESC,ZTRTN,ZTSAVE,ZTSK
KILL1 K ^TMP($J,"RA BTCHDEL DT")
 K DDH,I,POP
 Q
DEL ; $O through the ^TMP global to delete entries in 74.2!
 N DA,DIC,DIK S DIK="^RABTCH(74.2,",DA=0
 F  S DA=$O(^TMP($J,"RA BTCHDEL DT",DA)) Q:DA'>0  D ^DIK
 Q
DISPLAY ; Display selected Report Batches data
 N I,RA,RABTCH,RADTC,RADTP,RATXT,RAUSER S RA=0
 S RATXT="W !!?5,""The following Report Batches have been selected to be purged:"",!"
 W:$Y @IOF X RATXT
 F  S RA=$O(^TMP($J,"RA BTCHDEL DT",RA)) Q:RA'>0  D  Q:RAXIT
 . S RA(0)=$G(^RABTCH(74.2,RA,0)) Q:RA(0)']""
 . F I=1:1:4 S RA(I)=$P(RA(0),"^",I)
 . S RADTC=$$XTERNAL^RAUTL5(RA(2),$P($G(^DD(74.2,2,0)),"^",2))
 . S RAUSER=$$XTERNAL^RAUTL5(RA(3),$P($G(^DD(74.2,3,0)),"^",2))
 . S RADTP=$$XTERNAL^RAUTL5(RA(4),$P($G(^DD(74.2,4,0)),"^",2))
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF X RATXT
 . W !?3,"Batch: ",$P(RA(0),"^")
 . W ?39,"Date Created: ",$S(RADTC]"":RADTC,1:"Unknown")
 . W !?3,"User: ",$S(RAUSER]"":RAUSER,1:"Unknown")
 . W ?39,"Date Printed: ",$S(RADTP]"":RADTP,1:""),!
 . Q
 Q
SETMP ; Set ^TMP($J,"RA BTCHDEL DT").  If only printed batches are selected,
 ; (RAUPRT=0) then just hit the 'E' xref.  If both printed and unprinted
 ; batches are selected (RAUPRT=1) hit the Date/Time Batch Created 'F'
 ; xref.
 N RAXREF S RAXREF=$S(RAUPRT:"F",1:"E") S RA=0
 F  S RA=$O(^RABTCH(74.2,RAXREF,RA)) Q:RA'>0!(RA'<RA("DTI"))  D
 . S RA(1)=0
 . F  S RA(1)=$O(^RABTCH(74.2,RAXREF,RA,RA(1))) Q:RA(1)'>0  D
 .. S RA("CNT")=+$G(RA("CNT"))+1
 .. S ^TMP($J,"RA BTCHDEL DT",RA(1))=""
 .. Q
 . Q
 Q
YN(RADT) ; Yes/No prompt asking the user if unprinted batches are to be
 ; included as criteria for our batch deletion.
 ; Returns: 1 if yes, 0 if no, -1 if '^' or timeout
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y S DIR(0)="Y",DIR("B")="No"
 S DIR("A")="Want to include unprinted batches created before "_RADT
 S DIR("?",1)="Enter 'Yes' to delete printed and unprinted batches prior to "_RADT_"."
 S DIR("?")="Enter 'No' to delete only printed batches prior to "_RADT_"."
 D ^DIR S:$D(DIRUT) Y=-1
 Q Y
