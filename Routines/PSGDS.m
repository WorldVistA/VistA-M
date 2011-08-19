PSGDS ;BIR/CML3-DISCHARGE ORDERS ;21 JUL 94 / 3:12 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 N PSJNEW,PSGPTMP,PPAGE S PSJNEW=1
 ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 W ! S DIR(0)="Y",DIR("A")="Print BLANK Authorized Absence/Discharge Summary forms",DIR("B")="NO"
 S DIR("?",1)="Answer ""Yes"" if you want the report to print Authorized Absence/",DIR("?",2)="Discharge Summary forms for patients with no orders. Otherwise,",DIR("?")="enter ""No""."
 D ^DIR K DIR Q:Y["^"  S PSGBLANK=Y K ^TMP("PSGDS",$J)
 S (PSGP,PSGAPWD,PSGAPWG)=0,(PSGAPWDN,PSGAPWGN)="",PSGSSH="GENERIC" S PSGPTMP=0,PPAGE=1 D GWP^PSJPDIR Q:'$D(PSJSEL)  D @PSJSEL("SELECT"),EN^PSGDS0
 ;
DONE ;
 D ENKV^PSGSETU K CA,CML,CNTR,DIAG,ELIG,I1,I2,I3,PSGAP,PSGAPWD,PSGAPWDN,PSGAPWG,PSGAPWGN,PSGBLANK,PSGDICA,PSGPAT,PSJSEL,PSGSSH,T,N
 K LQ,ST,STT,STP,DF,DO,DRG,FD,NC,ND,ND2,NF,NP,PSJJORD,PSJOPC,PN,RB,RTE,SD,SI,SM,ST,STRT,VAEL,PSJACNWP,DDRG,^TMP("PSGDS",$J) Q
 ;
G ; get ward group
 S PSGAPWG=+PSJSEL("WG"),PSGAPWGN=$P(PSJSEL("WG"),"^",2) Q
 ;
W ; get ward
 S PSGAPWD=+PSJSEL("W"),PSGAPWDN=$P(PSJSEL("W"),"^",2) Q
 ;
P ; get patient
 N PAT S PAT="" F  S PAT=$O(PSJSEL("P",PAT)) Q:PAT=""  S PSGPAT(PAT)=$O(PSJSEL("P",PAT,PSGP))
 K PSGDICA Q
 ;
ENOR ;
 D ENCV^PSGSETU I '$D(XQUIT) S PSGPAT(PSGP)=+ORVP,PSJSEL("SELECT")="P",(PSGAPWD,PSGAPWDN,PSGAPWG,PSGAPWGN)="" D EN^PSGDS0
 G DONE
 ;
DTM ;
 S Y=%DT(0) D D^DIQ S T=$P(Y,"@",2),Y=$P(Y,",")
 W !!?2,"If a ",N," date is entered, a discharge summary will print for only those",!,"patients that have at least one active order with a ",$S(N["A":"STOP",1:"START")," DATE on or ",$S(N["A":"after",1:"before"),!,"the ",N," date entered."
 W !?2,"Entry is not required.  If neither date is entered, all patients with active",!,"orders will print (for the ward(s) chosen).  Enter an up-arrow (^) to exit."
 W !?2,"If you wish to enter a ",$S(N["A":"start",1:"stop")," date of ",Y,", you must enter a TIME of day",!,"of ",T," or greater.  Any date after ",Y," does not need time entered.",! S Y=-1 Q
