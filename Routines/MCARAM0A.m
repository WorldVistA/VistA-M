MCARAM0A ;WASH ISC/JKL-MUSE AUTO INSTRUMENT REINIT-EXT DATE ;2/24/95  10:39
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
 ;Called from ^MCARAM0
 ;Deletes corruption of records filed with external dates
 N MCLD,MCJ,MCNAM,MCDATE,MCIEN,MCPID,MCDT,DA,DIK
 S MCLD=9999999
 F I=1:1 S MCLD=$O(^MCAR(691.5,"B",MCLD)) Q:MCLD="ES"!(MCLD="")  S MCNAME="",MCSSN="",MCPID="",MCDT=MCLD,MCERR="",MCTR="" D CHECK
 ; deletes extraneous cross-reference on zero node
 I $D(^MCAR(691.5,0,"ES")) K ^MCAR(691.5,0,"ES")
 ; deletes extraneous cross-reference on "B" node
 I $D(^MCAR(691.5,"B","ES")) K ^MCAR(691.5,"B","ES")
 ; deletes extraneous cross-reference of EKG file
 ; checks for matching cross-references of record
 S (MCDATE,MCIEN)=0
 F  S MCDATE=$O(^MCAR(691.5,"B",MCDATE)) Q:MCDATE=""  S MCIEN=0 F  S MCIEN=$O(^MCAR(691.5,"B",MCDATE,MCIEN)) Q:MCIEN=""  I '$D(^MCAR(691.5,MCIEN)) K ^MCAR(691.5,"B",MCDATE,MCIEN)
 S (MCPID,MCIEN)=0
 F  S MCPID=$O(^MCAR(691.5,"C",MCPID)) Q:MCPID=""  S MCIEN=0 F  S MCIEN=$O(^MCAR(691.5,"C",MCPID,MCIEN)) Q:MCIEN=""  I '$D(^MCAR(691.5,MCIEN)) K ^MCAR(691.5,"C",MCPID,MCIEN)
 K MCLD,MCJ,MCNAM,MCDATE,MCIEN,MCPID,MCDT,DA,DIK
 Q
CHECK ;
 S %DT="T",X=MCLD D ^%DT S MCDT=Y
 S MCJ=0 F  S MCJ=$O(^MCAR(691.5,"B",MCDT,MCJ)) Q:MCJ=""  S MCIEN=MCJ,MCROOT="^MCAR(691.5," D DEL
 S MCJ=0 F  S MCJ=$O(^MCAR(700.5,"B",MCDT,MCJ)) Q:MCJ=""  S MCIEN=MCJ,MCROOT="^MCAR(700.5," D DEL
 Q
DEL ;
 S MCCNT=MCCNT+1
 S DIK=MCROOT,DA=MCIEN D ^DIK
 W:MCCNT#100=0 "."
 Q
