MCARAM0 ;WASH ISC/JKL-MUSE AUTO INSTRUMENT REINITIALIZE ;2/24/95  10:01
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
START ;Driver for MCARECGINIT-ECG Corrupted Records Delete
 ;Deletes corrupted records and reinitializes error summary file
 N MCDT,MCIEN,MCCNT,MCCOR,MCNAME,MCSSN,MCERR,MCEXDT,MCEKG,MCPID,MCNDT
 S (MCDT,MCIEN,MCCNT,MCCOR)=0
 S (MCNAME,MCSSN)=""
 W !,"Warning: This process will delete all of the records listed in"
 W !,"the retransmittal report."
 W !!,"This process will also remove the release status of each"
 W !,"automated record that has a release status."
 W !!,"This process will also add a confirmation status to each"
 W !,"automated record that does not have a confirmation status."
 R !!,"Do you wish to continue ? N //",MCDEF:30 I '$T Q
 I $E(MCDEF)'="Y" Q
 W !!,"Each  "".""  represents 100 records.",!!,"Deleting---"
 ; checks for whole records
 F I=1:1 S MCIEN=$O(^MCAR(700.5,MCIEN)) Q:MCIEN=""!(MCIEN="B")  S MCROOT="^MCAR(700.5," D ERR I MCERR'="" D DEL S:MCERR="CORRUPTION" MCCOR=MCCOR+1 K MCNAME,MCSSN,MCERR,MCEXDT W:MCCNT#100=0 "."
 S (MCDT,MCIEN)=0,(MCNAME,MCSSN)=""
 F I=1:1 S MCIEN=$O(^MCAR(691.5,MCIEN)) Q:MCIEN=""!(MCIEN="B")  S MCROOT="^MCAR(691.5," D EKGCK I MCERR'="" D DEL,DELAC S:MCERR="CORRUPTION" MCCOR=MCCOR+1 K MCNAME,MCSSN,MCERR,MCEXDT W:MCCNT#100=0 "."
 D ^MCARAM0A
 D ^MCARAM0B
 D ^MCARAM0C
 D ^MCARAM0D
 D ^MCARAM0E
 D ^MCARAM0F
 D ^MCARAM0G
 W !!,MCCNT," records deleted."
 W !!,"Each  "".""  represents 100 records.",!!,"Removing release status and adding confirmation status---"
 D ^MCARAM0H
 W !!,"...done."
 Q
 ;
ERR ;
 S MCERR=""
 I $D(^MCAR(700.5,MCIEN,0)),$P(^MCAR(700.5,MCIEN,0),"^",2)="MHOLT" Q
 I '$D(^MCAR(700.5,MCIEN,0)) S MCDT="",MCNAME="",MCSSN="",MCERR="CORRUPTION"
 S MCDT=$P(^MCAR(700.5,MCIEN,0),"^"),MCSSN=$P(^MCAR(700.5,MCIEN,0),"^",3),MCNAME=$P(^MCAR(700.5,MCIEN,0),"^",4),MCERR=$P(^MCAR(700.5,MCIEN,0),"^",5)
 I MCDT="" S MCDT="NO DATE/TIME",MCERR="CORRUPTION"
 I MCSSN="" S MCSSN="NO SSN",MCERR="CORRUPTION"
 I MCNAME="" S MCNAME="NO PATIENT NAME ON FILE",MCERR="CORRUPTION"
 I '$D(^MCAR(700.5,"B",MCDT,MCIEN)) S MCERR="CORRUPTION"
 Q
 ;
EKGCK ;
 S MCERR=""
 I '$D(^MCAR(691.5,MCIEN,0)) S MCERR="CORRUPTION",MCPID="",MCDT=""
 I '$D(^MCAR(691.5,MCIEN,.1)) S MCSSN="",MCNAME="",MCERR="CORRUPTION" Q
 I $D(^MCAR(691.5,MCIEN,0)) S MCDT=$P(^MCAR(691.5,MCIEN,0),"^"),MCPID=$P(^MCAR(691.5,MCIEN,0),"^",2),MCSSN=^MCAR(691.5,MCIEN,.1)
 S X=MCSSN,DIC="^DPT(",DIC(0)="XZ",D="SSN" D IX^DIC
 I +Y>0 S MCNAME=$P(Y(0),"^")
 I +Y>0 S MCPIDT=$P(Y,"^")
 I +Y=-1 S MCPIDT="NOPID",MCNAME="NO PATIENT NAME ON FILE"
 I MCPID'=MCPIDT S MCERR="CORRUPTION",MCNDT=$E(MCDT,1,11) D MID
 K X,Y,D,MCPIDT,MCNDT
 I '$D(^MCAR(691.5,"B",MCDT,MCIEN)) S MCERR="CORRUPTION"
 I '$D(^MCAR(691.5,"C",MCPID,MCIEN)) S MCERR="CORRUPTION"
 Q
MID ;
 I '$D(^DPT(MCPID,0)) Q
 I $D(^MCAR(691.5,"B",MCNDT)) S MCNAME=$P(^DPT(MCPID,0),"^"),MCSSN=$P(^DPT(MCPID,0),"^",9) Q
 N MCSSN2,MCNAME2
 S MCSSN2=$P(^DPT(MCPID,0),"^",9) I MCSSN2'[MCPIDT S MCNAME2=$P(^DPT(MCPID,0),"^"),MCCOR=MCCOR+1,MCCNT=MCCNT+1
 K MCSSN2,MCNAME2 Q
DEL ;
 S DIK=MCROOT,DA=MCIEN D ^DIK
 S MCCNT=MCCNT+1 Q
 ;
DELAC ;
 I $D(MCDT),$D(MCPID),$D(^MCAR(690,"AC",MCPID,9999999.9999-MCDT,"MCAR(691.5",MCIEN)) K ^MCAR(690,"AC",MCPID,9999999.9999-MCDT,"MCAR(691.5",MCIEN)
 Q
