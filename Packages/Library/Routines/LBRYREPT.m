LBRYREPT ;SSI/ALA-LIBRARY PACKAGE STATUS REPORT ;[ 09/02/97  3:20 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
EN ;  Report on the status of the Library TaskMan options
 W !!,"LIBRARY TASKMAN OPTIONS STATUS REPORT",!
 F OPT="LBRY TRAN SEND","LBRY TRAN PROCESS","LBRY TRAN PURGE" D DS
 R !!,"Press Return to Continue: ",X:DTIME
 K OPT,DA,TSK,Y,LDT,FRQ
 Q
DS ;  Check and display options
 I $$FIND^XUTMOPT(OPT)=-1 D  Q
 . W !!!,OPT," is not set up in TaskMan.  Please call IRM."
 S DIC(0)="NZ",DIC="^DIC(19.2,",X=OPT D ^DIC
 S DA=+Y,TSK=Y(0),FRQ=$P(TSK,"^",6)
 S Y=$P(TSK,"^",2),LDT=$$FMTE^XLFDT(Y,1)
 W !,OPT,?20,"Frequency: ",FRQ,?40,"Run Time: ",LDT
 Q
