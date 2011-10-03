GMRCSLM3 ;SLC/DCM - Extract medicine results for consult tracking ;7/16/98  02:01
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,15**;DEC 27, 1997
 ;
 ; This routine invokes IA #615,#3042
 ;
EN(GMRCSEL,GMRCSR,COUNT) ;;This entry point is used to collect consult data from the Medicine Package.
 ;GMRCSR="^MCAR(x," file IEN where result to associate is stored 
 ;in $P(^GMR(123,IEN,0),"^",15)
 ;                1=Called from RT^GMRCA1 or DT^GMRCSLM2 routine
 ;Consult/Request Tracking
 ;GMRCSEL: The IEN of the consult from file 123.
 ;COUNT:   The current position in ^TMP where data is to be placed.
 D ENDT,EXIT Q
 ;
ENDT Q:'$D(GMRCSEL)  Q:'$D(GMRCSEL)
 S ORIFN=$P(^GMR(123,GMRCSEL,0),"^",3),ORACTION=8
 S ^TMP("GMRCR",$J,"DT",COUNT,0)="",COUNT=COUNT+1
 S X="MCOR" X ^%ZOSF("TEST") I '$T S ^TMP("GMRCR",$J,"DT",COUNT,0)="Medicine package not installed.  Online results are not available.",COUNT=COUNT+1
 I 'GMRCSR S ^TMP("GMRCR",$J,"DT",COUNT,0)="No Medicine results are available for review",COUNT=COUNT+1 Q
 N SINGLE
 S SINGLE=$$SINGLE^MCAPI(GMRCSR)
 S GMRCRTIT=$P(SINGLE,U)_" SUMMARY REPORT "_$P(SINGLE,U,6)
 S GMRCH="",$P(GMRCH,"-",(77-$L(GMRCRTIT))\2)=""
 S ^TMP("GMRCR",$J,"DT",COUNT,0)=GMRCH_" "_GMRCRTIT_" "_GMRCH
 S COUNT=COUNT+1,^TMP("GMRCR",$J,"DT",COUNT,0)="",COUNT=COUNT+1
 D PRINT^MCOR I '$D(^TMP("MC",$J)) D
 . S ^TMP("GMRCR",$J,"DT",COUNT,0)="No results are available for review."
 . S COUNT=COUNT+1
 ;GMRCFT=Field Type of D (Diagnosis, I (Indications), S (Summary)
SET S GMRCFT="D" I $D(^TMP("MC",$J,"D")) D
 . S ^TMP("GMRCR",$J,"DT",COUNT,0)=$E(TAB,1,34)_"DIAGNOSIS"
 . S COUNT=COUNT+1
 . D SETFLD
 S GMRCFT="I" I $D(^TMP("MC",$J,"I")) D
 . S ^TMP("GMRCR",$J,"DT",COUNT,0)="",COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,"DT",COUNT,0)="INDICATIONS:",COUNT=COUNT+1
 . D SETFLD
 I $D(^TMP("MC",$J,"S")) D SUM
 Q
EXIT K GMRCH,GMRCX,GMRCFT,GMRCFLD,GMRCSUM,GMRCFLDN,GMRCSUMP,GMRCRTIT
 K GMRCPRNM,GMRCFLDP,MCC,MCK,MCMFLD,MCMUP
 K ^TMP("MC",$J)
 Q
SETFLD S GMRCFLD=0,GMRCFLDP=""
 F  S GMRCFLD=$O(^TMP("MC",$J,GMRCFT,GMRCFLD)) Q:GMRCFLD=""  D
 . S GMRCFLD(0)=^TMP("MC",$J,GMRCFT,GMRCFLD) D
 .. S GMRCFLDN=$P(GMRCFLD(0),"^",2) Q:GMRCFLDN[";W"
 .. I GMRCFLDP=GMRCFLDN S COUNT=COUNT-1,^TMP("GMRCR",$J,"DT",COUNT,0)=^TMP("GMRCR",$J,"DT",COUNT,0)_", "
 .. E  S GMRCFLDP=GMRCFLDN,^TMP("GMRCR",$J,"DT",COUNT,0)=GMRCFLDP_":"_$E(TAB,1,18-$L(GMRCFLDP))
 .. I $L($P(GMRCFLD(0),"^",1))>45 D  Q
 ... S ^TMP("GMRCR",$J,"DT",COUNT,0)=^TMP("GMRCR",$J,"DT",COUNT,0)_$P(GMRCFLD(0),U)
 ... S COUNT=COUNT+1
 .. I $L($P(GMRCFLD(0),"^",1))'>77 S ^TMP("GMRCR",$J,"DT",COUNT,0)=^TMP("GMRCR",$J,"DT",COUNT,0)_$P(GMRCFLD(0),"^",1)
 .. S COUNT=COUNT+1 Q
 Q
SUM ;
 S GMRCSUM=$P(^TMP("MC",$J,"S"),"^",1)
 S GMRCSUMP=$P(^TMP("MC",$J,"S"),"^",2)
 I $L(GMRCSUM)!($L(GMRCSUMP)) S ^TMP("GMRCR",$J,"DT",COUNT,0)="SUMMARY:"
 I $L(GMRCSUM) S ^TMP("GMRCR",$J,"DT",COUNT,0)=^TMP("GMRCR",$J,"DT",COUNT,0)_$E(TAB,1,11)_GMRCSUM,COUNT=COUNT+1
 I $L(GMRCSUMP) S ^TMP("GMRCR",$J,"DT",COUNT,0)="SUMMARY PROCEDURE: "_GMRCSUMP,COUNT=COUNT+1
 Q
AREN(GMRCSEL,GMRCSR,GMRCPROC) ;Entry point for display of Medicine Results when associating a result with a consult - List Manager display set-up.
 ;GMRCSR=^MCAR(191, file IEN where result to associate is stored
 ;GMRCSEL=File ^GMR(123, IEN of consult to associate with medicine result
 ;GMRCPROC=pointer to GMRC PROCEDURE (#123.3) file
 S COUNT=1,TAB="",TAB=$P(TAB," ",30)
 S X="MCOR" X ^%ZOSF("TEST") I '$T S ^TMP("GMRCR",$J,"DT",COUNT,0)="Medicine Package is not installed. Online results are not available.",COUNT=COUNT+1 G END
 I 'GMRCSR S ^TMP("GMRCR",$J,"DT",COUNT,0)="No Medicine results are available for review.",COUNT=COUNT+1
 S ORIFN=$S($G(GMRCSEL):$P(^GMR(123,+GMRCSEL,0),"^",3),1:0),ORACTION=8
 S:+GMRCPROC GMRCPRNM=$$GET1^DIQ(697.2,$P(^GMR(123.3,+GMRCPROC,0),U,5),7)
 S GMRCPRNM=$S($L($G(GMRCPRNM)):GMRCPRNM,1:"ELECTROCARDIOGRAM")
 I +GMRCSR D PRINT^MCOR I $D(^TMP("MC",$J)) S ^TMP("GMRCR",$J,"DT",COUNT,0)=TAB_"MEDICINE RESULTS",COUNT=COUNT+1,^TMP("GMRCR",$J,"DT",COUNT,0)="",COUNT=COUNT+1 D SET
 S ^TMP("GMRCR",$J,"DT",COUNT,0)="",COUNT=COUNT+1
END S GMRCCT=COUNT-1
 K COUNT,GMRCH,GMRCFT,GMRCFLD,GMRCSUM,GMRCFLDN,GMRCSUMP,GMRCRTIT,GMRCPRNM,GMRCFLDP,MCC,MCK,MCMFLD,MCMUP
 K ^TMP("MC",$J)
 Q
