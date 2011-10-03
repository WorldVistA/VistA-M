PXQMAIN4 ;ISL/JVS - USER FRIENDLY REPORT ;3/25/97  11:09
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**4,29**;Aug 12,1996
 ;
REPT ;--PCE VISIT TRAIL CUSTONIZED REPORT OPTION
 N DFN,IEN,VISIT,ANS,I,PXBCNT,PXBHIGH,PXQRECI
 S PXQRECI=0
 ;
 ;--SET UP OR RETRIEVE DEFAULTS
 I '$D(^DISV(DUZ,"PXQREP1")) S ^DISV(DUZ,"PXQREP1")="P"
 ;
ASK ;--ASK BY PATIENT OR BY IEN
 S DIR("A",1)="Enter '^' to exit"
 S DIR("A")="Select by (P)atient or (I)en"
 S DIR("B")=$G(^DISV(DUZ,"PXQREP1"))
 S DIR(0)="SOM^P:Patient List of Visits;I:Internal Entry Number of VISIT"
 D ^DIR K DIR
 I Y=""!(Y["^")!(Y<0) G EXIT
 I "IP"[Y S ^DISV(DUZ,"PXQREP1")=Y
 I Y="I" G IEN
 ;
PAT ;--ASK FOR PATIENT
 S DFN=$$ASKPAT^PXQUTL Q:DFN<0
 ;--ASK DATE RANGE
 D DATE^PXQUTL2
 I '$G(PXQSTART)!('$G(PXQEND)) G PAT
 ;--GET A LIST OF VISITS
 S (IEN,VISIT)=$$VISITLST^PXQGVST(DFN,PXQSTART,PXQEND,"","X") K PXQSTART,PXQEND G:IEN<0 ASK
 I $G(IEN)'<0 S ^DISV(DUZ,"PXQREP3")="`"_$G(IEN)
 G FORM
IEN ;--ASK FOR IEN OF VISIT
 N DFN,IEN,VISIT,ANS,I,BROKEN
 I $G(^DISV(DUZ,"PXQREP3"))]"" S DIR("B")=$G(^DISV(DUZ,"PXQREP3"))
 S (VISIT,IEN)=$$ASKNUM1^PXQUTL K DIR I IEN<0 D  G:IEN<0 ASK
 .I $G(IEN)]""&($G(IEN)'["^")&($G(IEN)'<0) S ^DISV(DUZ,"PXQREP3")=$G(IEN)
 ;.R !,"Look at a Possible BROKER POINTER to a visit? (Y/N): N// ",ANS:DTIME
 ;.I ANS["N"!(ANS="")!(ANS["^") Q
 ;.R !,"Enter Visit IEN: ",ANS:DTIME
 ;.I +ANS<1 G IEN
 ;.S (VISIT,IEN)=ANS
 ;.S ^DISV(DUZ,"PXQREP3")="`"_$G(IEN)
 ;.I '$D(^AUPNVSIT(ANS)) S BROKEN=1
 I $G(IEN)'<0 S ^DISV(DUZ,"PXQREP3")="`"_$G(IEN)
 ;
 ;
FORM ;--FORMAT FO THE RPORT
 S DIR("A",1)="~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
 S DIR("A",2)="To Customize your display use VA Fileman to add entries in file"
 S DIR("A",3)="PCE CUSTOMIZE REPORT, with your NAME, FILE/SUBFILE#s, and FIELD#s"
 S DIR("A",4)="that you want to have included in the report."
 S DIR("A",5)="~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
 S DIR("A",6)=" "
 S DIR("A",7)="Enter '^^' to exit option"
 S DIR("A")="Format of Print out"
 S DIR("B")=$G(^DISV(DUZ,"PXQREP2"))
 S DIR(0)="SOM^D:Default (first field of each file/subfile);A:All fields in a file/subfile (except 'NULL');C:Customized by User (Default plus added fields) "
 D ^DIR K DIR
 I Y=""!(Y="^") G ASK
 I Y="^^" G EXIT
 I "CDA^^"'[Y G FORM
 I "DAC"[Y S ^DISV(DUZ,"PXQREP2")=Y
 I Y="D" S PXQFORM=".01"_"^"_Y
 I Y="A" S PXQFORM="**"_"^"_Y
 I Y="C" S PXQFORM=".01"_"^"_Y
 ;
OPEN ;--OPEN DEVICE
 S OPTION=10
 D ZIS^PXQZIS G:POP EXIT
 ;
 ;--RESET $X,$Y TO ZERO
 N DX,DY S (DX,DY)=0 X ^%ZOSF("XY")
 ;
REPORT ;--DO REPORT
 K ^TMP("PXQDATA",$J)
 N VAR
 W $$RE^PXQUTL("***  R E C O R D    O F    R E L A T E D    E N T R I E S  ***")
 W $$RE^PXQUTL(" ")
 W $$RE^PXQUTL("         The Following is the VISIT file entry and")
 W $$RE^PXQUTL("          ALL records pointing back to this entry.")
 W $$RE^PXQUTL(" ")
 W $$RE^PXQUTL("               VISIT RECORD    --- #"_VISIT_"")
 W $$RE^PXQUTL(" ")
 I $D(^AUPNVSIT(VISIT)) D
 .N PXQSTUFF,PXQPAT,PXQDT,PXQCLN
 .D GETS^DIQ(9000010,VISIT_",",".01;.05;.22","EI","PXQSTUFF","PXQSTUFF")
 .D GETS^DIQ(9000010,VISIT_",","**","E","^TMP(""PXQDATA"",$J,")
 .S PXQDT=$G(PXQSTUFF(9000010,VISIT_",",.01,"E"))
 .S PXQPAT=$G(PXQSTUFF(9000010,VISIT_",",.05,"E"))
 .S PXQCLN=$G(PXQSTUFF(9000010,VISIT_",",.22,"E"))
 .S DFN=$G(PXQSTUFF(9000010,VISIT_",",.05,"I"))
 .W $$RE^PXQUTL("               DATE/TIME --- "_PXQDT_"")
 .W $$RE^PXQUTL("               PATIENT   --- "_PXQPAT_"")
 .W $$RE^PXQUTL("               LOCATION  --- "_PXQCLN_"")
 .W $$RE^PXQUTL(" ")
 .W $$RE^PXQUTL("______________________________________________________________")
 S VAR=$$DEC^PXQUTL1(VISIT,9000010,"",PXQFORM)
 I $D(PXQENC) D  K PXQENC
 .N PXQII
 .S PXQII=0 F  S PXQII=$O(PXQENC(PXQII)) Q:PXQII=""  D
 ..W $$RE^PXQUTL(" ")
 ..W $$RE^PXQUTL("       The Following is the OUTPATIENT ENCOUNTER entry and")
 ..W $$RE^PXQUTL("            most of the records pointing back to it.")
 ..W $$RE^PXQUTL(" ")
 ..W $$RE^PXQUTL("             OUTPATIENT ENCOUNTER --- #"_PXQII_"")
 ..W $$RE^PXQUTL(" ")
 ..W $$RE^PXQUTL("______________________________________________________________")
 ..S VAR=$$DEC^PXQUTL1(PXQII,409.68,"",PXQFORM)
 W $$RE^PXQUTL(" ")
 W $$RE^PXQUTL("       The Following is the SCHEDULING VISITS file.")
 W $$RE^PXQUTL("      This is where Scheduling stores the CPT codes.")
 W $$RE^PXQUTL(" ")
 D SDV^PXQUTL
 ;--READ TO DEVICE
 D READ^PXQUTL
 ;--CLOSE DEVICE
 D ^%ZISC
 I $D(ZTSK) G EXIT
 E  D FORM
 Q
 ;
 ;
EXIT ;--CLEAN UP AND QUIT
 K DIR,DIC,OPTION
 K ^TMP("PXQDATA",$J)
 Q
